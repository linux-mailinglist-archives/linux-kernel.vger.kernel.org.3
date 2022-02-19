Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3C1E14BC466
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240908AbiBSA5s (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:57:48 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40012 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240769AbiBSAzk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:40 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D76E627AFE4
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:16 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 85EADB82765
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 54734C340FB;
        Sat, 19 Feb 2022 00:55:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1p-0051Zd-Ga;
        Fri, 18 Feb 2022 19:55:13 -0500
Message-ID: <20220219005513.341653321@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 06/16] user_events: Add print_fmt generation support for basic types
References: <20220219005430.848118506@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Beau Belgrave <beaub@linux.microsoft.com>

Addes print_fmt format generation for basic types that are supported for
user processes. Only supports sizes that are the same on 32 and 64 bit.

Link: https://lkml.kernel.org/r/20220118204326.2169-3-beaub@linux.microsoft.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
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
2.34.1
