Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 00892492F97
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 21:43:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349431AbiARUnr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 15:43:47 -0500
Received: from linux.microsoft.com ([13.77.154.182]:43816 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345684AbiARUnb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 15:43:31 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 4872D20B927B;
        Tue, 18 Jan 2022 12:43:31 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 4872D20B927B
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1642538611;
        bh=q5KI/D692VhGMWb6PRmt3MwCIwpIi9OrMF74O2H645c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=IRykAIFChjWuDMceRtxtiQ+gK8qcuDShetO4Ungy/DxtCIR8KaSr/9GIfARjnFjPq
         RWKqLu8ugu7WFofsxlkkpqrgtS7QCBWK+2rgdKSmc4SkXAQKps8UInOobkmPzIjG6t
         HkaMo7H011aEoBGkMI9UtSiqxnwPk4LvfdzI9Xpo=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v10 03/12] user_events: Handle matching arguments from dyn_events
Date:   Tue, 18 Jan 2022 12:43:17 -0800
Message-Id: <20220118204326.2169-4-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220118204326.2169-1-beaub@linux.microsoft.com>
References: <20220118204326.2169-1-beaub@linux.microsoft.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Ensures that when dynamic events requests a match with arguments that
they match what is in the user_event.

Signed-off-by: Beau Belgrave <beaub@linux.microsoft.com>
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
2.17.1

