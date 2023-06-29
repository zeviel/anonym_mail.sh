#!/bin/bash

api="https://anonymmail.net"
user_agent="Mozilla/5.0 (Windows NT 10.0; Win64; x64) AppleWebKit/537.36 (KHTML, like Gecko) Chrome/112.0.0.0 Safari/537.36"

function get_cookies() {
	response=$(curl --request GET \
		--url "$api/" \
		--user-agent "$user_agent" \
		-i -s)
	cookie=$(echo "$response" | grep -iE '^set-cookie:' | awk '{print $2}')
}

function create_email() {
	# 1 - email: (string): <email>
	curl --request POST \
		--url "$api/api/create" \
		--user-agent "$user_agent" \
		--header "cookie: $cookie" \
		--header "content-type: application/x-www-form-urlencoded" \
		--data "email=$1"
}

function get_email_inbox() {
	# 1 - email: (string): <email>
	curl --request POST \
		--url "$api/api/get" \
		--user-agent "$user_agent" \
		--header "cookie: $cookie" \
		--header "content-type: application/x-www-form-urlencoded" \
		--data "email=$1"
}
