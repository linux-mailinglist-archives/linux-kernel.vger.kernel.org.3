Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC83477AB3
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 18:35:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240359AbhLPRfY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 12:35:24 -0500
Received: from linux.microsoft.com ([13.77.154.182]:54466 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239849AbhLPRfP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 12:35:15 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 42E8E20B717B;
        Thu, 16 Dec 2021 09:35:15 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 42E8E20B717B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1639676115;
        bh=0fNqPKZevVA3k1Ku6Zsv80sfa7jMxr32HDbgB2fDQpU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NxKZV6bCatmcca1LXFrcOwcO1Q/5Mnktv3F7SVkTEmfz58QjreNgVnKsozaSjkoi0
         8gMi3Qvc/U1j/U9CsmuoOEo17q5hM8qTXtOvJKUAaUelivIzEfN4zNhpTTbw8odWfq
         mYh0lfVnQB5Dwabw29Zawog0oIFFeCTPM2hDYRy0=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v8 02/12] user_events: Add print_fmt generation support for basic types
Date:   Thu, 16 Dec 2021 09:35:01 -0800
Message-Id: <20211216173511.10390-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211216173511.10390-1-beaub@linux.microsoft.com>
References: <20211216173511.10390-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Addes print_fmt format generation for basic types that are supported for
user processes. Only supports sizes that are the same on 32 and 64 bit.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
---
 kernel/trace/trace_events_user.c | 115 ++++++++++++++++++++++++++++++-
 1 file changed, 113 insertions(+), 2 deletions(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index 0a1b6496b9c3..67a92fe04ee4 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -358,6 +358,114 @@ static int user_event_parse_fields(struct user_event *user, char *args)
 
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
+static bool user_field_is_dyn_string(const char *type, const char **str_func)
+{
+	if (str_has_prefix(type, "__data_loc ")) {
+		*str_func = "__get_str";
+		goto check;
+	}
+
+	if (str_has_prefix(type, "__rel_loc ")) {
+		*str_func = "__get_rel_str";
+		goto check;
+	}
+
+	return false;
+check:
+	return strstr(type, "char") != 0;
+}
+
+#define LEN_OR_ZERO (len ? len - pos : 0)
+static int user_event_set_print_fmt(struct user_event *user, char *buf, int len)
+{
+	struct ftrace_event_field *field, *next;
+	struct list_head *head = &user->fields;
+	int pos = 0, depth = 0;
+	const char *str_func;
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
+		if (user_field_is_dyn_string(field->type, &str_func))
+			pos += snprintf(buf + pos, LEN_OR_ZERO,
+					", %s(%s)", str_func, field->name);
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
@@ -391,6 +499,7 @@ static int destroy_user_event(struct user_event *user)
 	clear_bit(user->index, page_bitmap);
 	hash_del(&user->node);
 
+	kfree(user->call.print_fmt);
 	kfree(EVENT_NAME(user));
 	kfree(user);
 
@@ -663,8 +772,10 @@ static int user_event_parse(char *name, char *args, char *flags,
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

