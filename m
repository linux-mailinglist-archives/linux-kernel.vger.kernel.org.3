Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C6C9A492F93
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:43:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349294AbiARUnd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:43:33 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43808 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343795AbiARUnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:43:31 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 17B2F20B927A;
        Tue, 18 Jan 2022 12:43:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 17B2F20B927A
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642538611;
        bh=vu/vJHWme19QraNNv1lNg+FIaAp6zN63Emht5YXcox8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Uh/uP7s7OwpoZnpLPF9VPv1QvBVFJAiNtCjmudYZ3CmQQDiIfrwYygVWJ+GTXtvl0
         hVWyDHDv3Of9fJkZz37tW0IsDYDX2VbxohmJ8YRraxC1o35/h4Ny8QCfLyOXq+vFdl
         QYcSbkLodtNEwCQufZk7s5hjY9g3xf2EozGH4voI=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v10 02/12] user_events: Add print_fmt generation support for basic types
Date:   Tue, 18 Jan 2022 12:43:16 -0800
Message-Id: <20220118204326.2169-3-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118204326.2169-1-beaub@linux.microsoft.com>
References: <20220118204326.2169-1-beaub@linux.microsoft.com>
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
index 77105233115e..ddc5c3cf1bf8 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -359,6 +359,114 @@ static int user_event_parse_fields(struct user_event *user, char *args)
 
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
@@ -392,6 +500,7 @@ static int destroy_user_event(struct user_event *user)
 	clear_bit(user->index, page_bitmap);
 	hash_del(&user->node);
 
+	kfree(user->call.print_fmt);
 	kfree(EVENT_NAME(user));
 	kfree(user);
 
@@ -669,8 +778,10 @@ static int user_event_parse(char *name, char *args, char *flags,
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

