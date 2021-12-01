Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1026A46555A
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Dec 2021 19:25:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230456AbhLAS3F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 13:29:05 -0500
Received: from linux.microsoft.com ([13.77.154.182]:48014 "EHLO
        linux.microsoft.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352367AbhLAS2l (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 13:28:41 -0500
Received: from localhost.localdomain (c-73-140-2-214.hsd1.wa.comcast.net [73.140.2.214])
        by linux.microsoft.com (Postfix) with ESMTPSA id 0AD6220E5812;
        Wed,  1 Dec 2021 10:25:20 -0800 (PST)
DKIM-Filter: OpenDKIM Filter v2.11.0 linux.microsoft.com 0AD6220E5812
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linux.microsoft.com;
        s=default; t=1638383120;
        bh=RYOYMTO4Ww6v4fWKXDe/z5dtqxpFG4IHJPHCCwLyzPI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iQbmOkxf+yTitrxd0wsufHhgTL5vV+oO1RCFNA/KcI5EkXyCpM9WWiLivpbkTjKPW
         FF21KVa7OzFmPHkoWJLJMvKi3lVBEQ54f5ROn9xHYs9U2bNiglyQnYEdD7VVM5kvNG
         pO0mI6zbt8Iw4USAEoOsEkPCckryGvmXw0A3qjeU=
From:   Beau Belgrave <beaub@linux.microsoft.com>
To:     rostedt@goodmis.org, mhiramat@kernel.org
Cc:     linux-trace-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        beaub@linux.microsoft.com
Subject: [PATCH v6 04/13] user_events: Handle matching arguments from dyn_events
Date:   Wed,  1 Dec 2021 10:25:06 -0800
Message-Id: <20211201182515.2446-5-beaub@linux.microsoft.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20211201182515.2446-1-beaub@linux.microsoft.com>
References: <20211201182515.2446-1-beaub@linux.microsoft.com>
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
index ad8e0e359eab..04d72e491d02 100644
--- a/kernel/trace/trace_events_user.c
+++ b/kernel/trace/trace_events_user.c
@@ -39,6 +39,7 @@
 #define MAX_EVENT_DESC 512
 #define EVENT_NAME(user_event) ((user_event)->tracepoint.name)
 #define MAX_FIELD_ARRAY_SIZE (2 * PAGE_SIZE)
+#define MAX_FIELD_ARG_NAME 256
 
 static char *register_page_data;
 
@@ -692,13 +693,87 @@ static int user_event_free(struct dyn_event *ev)
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

