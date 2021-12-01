Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C8CB4465559
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:25:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352461AbhLAS3A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:29:00 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48004 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352021AbhLAS2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:28:41 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id CE01D20E5809;
        Wed,  1 Dec 2021 10:25:19 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com CE01D20E5809
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638383119;
        bh=AyqSW6ZwP/qF0pxijh9KTwh8+3MhxSXdGP03LIXvGvQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IaWn1WY0UaZiol57uQ0YV66douJPmHLmDiM3Oj1WrIDkRW3yXkS1RM5uwIGqqlkNs
         4JqXQVRfQGENqqEKiW+bmf2e0ytbn4uEI+nGR96+BvetAxMgkF4u+Aau0VJDBr6c03
         +7tGKwY2uqvu9JtYfkPBpXEQbHwxs+e5yBX2OSFI=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v6 03/13] user_events: Add print_fmt generation support for basic types
Date:   Wed,  1 Dec 2021 10:25:05 -0800
Message-Id: <20211201182515.2446-4-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201182515.2446-1-beaub@linux.microsoft.com>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addes print_fmt format generation for basic types that are supported for
user processes. Only supports sizes that are the same on 32 and 64 bit.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 107 ++++++++++++++++++++++++++++++-
 1 file changed, 105 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index afcf224b941d..ad8e0e359eab 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -357,6 +357,106 @@ static int user_event_parse_fields(struct user_event *user, char *args)
 
 static struct trace_event_fields user_event_fields_array[1];
 
+static const char *user_field_format(const char *type)
+{
+	if (strcmp(type, "s64") == 0)
+		return "%lld";
+	if (strcmp(type, "u64") == 0)
+		return "%llu";
+	if (strcmp(type, "s32") == 0)
+		return "%d";
+	if (strcmp(type, "u32") == 0)
+		return "%u";
+	if (strcmp(type, "int") == 0)
+		return "%d";
+	if (strcmp(type, "unsigned int") == 0)
+		return "%u";
+	if (strcmp(type, "s16") == 0)
+		return "%d";
+	if (strcmp(type, "u16") == 0)
+		return "%u";
+	if (strcmp(type, "short") == 0)
+		return "%d";
+	if (strcmp(type, "unsigned short") == 0)
+		return "%u";
+	if (strcmp(type, "s8") == 0)
+		return "%d";
+	if (strcmp(type, "u8") == 0)
+		return "%u";
+	if (strcmp(type, "char") == 0)
+		return "%d";
+	if (strcmp(type, "unsigned char") == 0)
+		return "%u";
+	if (strstr(type, "char[") != 0)
+		return "%s";
+
+	/* Unknown, likely struct, allowed treat as 64-bit */
+	return "%llu";
+}
+
+static bool user_field_is_dyn_string(const char *type)
+{
+	if (str_has_prefix(type, "__data_loc ") ||
+	    str_has_prefix(type, "__rel_loc "))
+		if (strstr(type, "char[") != 0)
+			return true;
+
+	return false;
+}
+
+#define LEN_OR_ZERO (len ? len - pos : 0)
+static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
+{
+	struct ftrace_event_field *field, *next;
+	struct list_head *head = &user->fields;
+	int pos = 0, depth = 0;
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
+
+	list_for_each_entry_safe_reverse(field, next, head, link) {
+		if (depth != 0)
+			pos += snprintf(buf + pos, LEN_OR_ZERO, " ");
+
+		pos += snprintf(buf + pos, LEN_OR_ZERO, "%s=%s",
+				field->name, user_field_format(field->type));
+
+		depth++;
+	}
+
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"");
+
+	list_for_each_entry_safe_reverse(field, next, head, link) {
+		if (user_field_is_dyn_string(field->type))
+			pos += snprintf(buf + pos, LEN_OR_ZERO,
+					", __get_str(%s)", field->name);
+		else
+			pos += snprintf(buf + pos, LEN_OR_ZERO,
+					", REC->%s", field->name);
+	}
+
+	return pos + 1;
+}
+#undef LEN_OR_ZERO
+
+static int user_event_create_print_fmt(struct user_event *user)
+{
+	char *print_fmt;
+	int len;
+
+	len = user_event_set_print_fmt(user, NULL, 0);
+
+	print_fmt = kmalloc(len, GFP_KERNEL);
+
+	if (!print_fmt)
+		return -ENOMEM;
+
+	user_event_set_print_fmt(user, print_fmt, len);
+
+	user->call.print_fmt = print_fmt;
+
+	return 0;
+}
+
 static enum print_line_t user_event_print_trace(struct trace_iterator *iter,
 						int flags,
 						struct trace_event *event)
@@ -390,6 +490,7 @@ static int destroy_user_event(struct user_event *user)
 	clear_bit(user->index, page_bitmap);
 	hash_del(&user->node);
 
+	kfree(user->call.print_fmt);
 	kfree(EVENT_NAME(user));
 	kfree(user);
 
@@ -669,8 +770,10 @@ static int user_event_parse(char *name, char *args, char *flags,
 	if (ret)
 		goto put_user;
 
-	/* Minimal print format */
-	user->call.print_fmt = "\"\"";
+	ret = user_event_create_print_fmt(user);
+
+	if (ret)
+		goto put_user;
 
 	user->call.data = user;
 	user->call.class = &user->class;
-- 
2.17.1

