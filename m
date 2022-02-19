Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 716404BC438
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 02:10:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240948AbiBSA5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 19:57:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:39836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240778AbiBSAzl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 19:55:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7CD0E27B489
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 16:55:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id C0DCDB82764
        for <linux-kernel@vger.kernel.org>; Sat, 19 Feb 2022 00:55:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 7F551C340F4;
        Sat, 19 Feb 2022 00:55:14 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nLE1p-0051aC-Ma;
        Fri, 18 Feb 2022 19:55:13 -0500
Message-ID: <20220219005513.531685906@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 18 Feb 2022 19:54:37 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Beau Belgrave <beaub@linux.microsoft.com>
Subject: [for-next][PATCH 07/16] user_events: Handle matching arguments from dyn_events
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

Ensures that when dynamic events requests a match with arguments that
they match what is in the user_event.

Link: https://lkml.kernel.org/r/20220118204326.2169-4-beaub@linux.microsoft.com

Acked-by: Masami Hiramatsu <mhiramat@kernel.org>
Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/trace_events_user.c | 77 +++++++++++++++++++++++++++++++-
 1 file changed, 76 insertions(+), 1 deletion(-)

diff --git a/kernel/trace/trace_events_user.c b/kernel/trace/trace_events_user.c
index ddc5c3cf1bf8..a6794cb1f586 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -39,6 +39,7 @@
 #define MAX_EVENT_DESC 512
 #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
 #define MAX_FIELD_ARRAY_SIZE 1024
+#define MAX_FIELD_ARG_NAME 256
 
 static char *register_page_data;
 
@@ -700,13 +701,87 @@ static int user_event_free(struct dyn_event *ev)
 	return destroy_user_event(user);
 }
 
+static bool user_field_match(struct ftrace_event_field *field, int argc,
+			     const char **argv, int *iout)
+{
+	char *field_name, *arg_name;
+	int len, pos, i = *iout;
+	bool colon = false, match = false;
+
+	if (i >= argc)
+		return false;
+
+	len = MAX_FIELD_ARG_NAME;
+	field_name = kmalloc(len, GFP_KERNEL);
+	arg_name = kmalloc(len, GFP_KERNEL);
+
+	if (!arg_name || !field_name)
+		goto out;
+
+	pos = 0;
+
+	for (; i < argc; ++i) {
+		if (i != *iout)
+			pos += snprintf(arg_name + pos, len - pos, " ");
+
+		pos += snprintf(arg_name + pos, len - pos, argv[i]);
+
+		if (strchr(argv[i], ';')) {
+			++i;
+			colon = true;
+			break;
+		}
+	}
+
+	pos = 0;
+
+	pos += snprintf(field_name + pos, len - pos, field->type);
+	pos += snprintf(field_name + pos, len - pos, " ");
+	pos += snprintf(field_name + pos, len - pos, field->name);
+
+	if (colon)
+		pos += snprintf(field_name + pos, len - pos, ";");
+
+	*iout = i;
+
+	match = strcmp(arg_name, field_name) == 0;
+out:
+	kfree(arg_name);
+	kfree(field_name);
+
+	return match;
+}
+
+static bool user_fields_match(struct user_event *user, int argc,
+			      const char **argv)
+{
+	struct ftrace_event_field *field, *next;
+	struct list_head *head = &user->fields;
+	int i = 0;
+
+	list_for_each_entry_safe_reverse(field, next, head, link)
+		if (!user_field_match(field, argc, argv, &i))
+			return false;
+
+	if (i != argc)
+		return false;
+
+	return true;
+}
+
 static bool user_event_match(const char *system, const char *event,
 			     int argc, const char **argv, struct dyn_event *ev)
 {
 	struct user_event *user = container_of(ev, struct user_event, devent);
+	bool match;
 
-	return strcmp(EVENT_NAME(user), event) == 0 &&
+	match = strcmp(EVENT_NAME(user), event) == 0 &&
 		(!system || strcmp(system, USER_EVENTS_SYSTEM) == 0);
+
+	if (match && argc > 0)
+		match = user_fields_match(user, argc, argv);
+
+	return match;
 }
 
 static struct dyn_event_operations user_event_dops = {
-- 
2.34.1
