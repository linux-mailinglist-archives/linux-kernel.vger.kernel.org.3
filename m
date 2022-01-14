Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 133C248EBF8
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242001AbiANOrO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:47:14 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40226 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238709AbiANOrM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:47:12 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D3D84B825EC
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 14:47:10 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 66AA7C36AEA;
        Fri, 14 Jan 2022 14:47:08 +0000 (UTC)
Date:   Fri, 14 Jan 2022 09:47:06 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Pingfan Liu <kernelfans@gmail.com>,
        David Laight <David.Laight@ACULAB.COM>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>
Subject: [for-next][PATCH] tracing: Add ustring operation to filtering
 string pointers
Message-ID: <20220114094706.31d7a2ef@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
for-next

Head SHA1: f37c3bbc635994eda203a6da4ba0f9d05165a8d6


Steven Rostedt (1):
      tracing: Add ustring operation to filtering string pointers

----
 Documentation/trace/events.rst     |  9 +++++
 kernel/trace/trace_events_filter.c | 81 +++++++++++++++++++++++++++-----------
 2 files changed, 66 insertions(+), 24 deletions(-)
---------------------------
commit f37c3bbc635994eda203a6da4ba0f9d05165a8d6
Author: Steven Rostedt <rostedt@goodmis.org>
Date:   Thu Jan 13 20:08:40 2022 -0500

    tracing: Add ustring operation to filtering string pointers
    
    Since referencing user space pointers is special, if the user wants to
    filter on a field that is a pointer to user space, then they need to
    specify it.
    
    Add a ".ustring" attribute to the field name for filters to state that the
    field is pointing to user space such that the kernel can take the
    appropriate action to read that pointer.
    
    Link: https://lore.kernel.org/all/yt9d8rvmt2jq.fsf@linux.ibm.com/
    
    Fixes: 77360f9bbc7e ("tracing: Add test for user space strings when filtering on string pointers")
    Tested-by: Sven Schnelle <svens@linux.ibm.com>
    Signed-off-by: Steven Rostedt <rostedt@goodmis.org>

diff --git a/Documentation/trace/events.rst b/Documentation/trace/events.rst
index 45e66a60a816..c47f381d0c00 100644
--- a/Documentation/trace/events.rst
+++ b/Documentation/trace/events.rst
@@ -198,6 +198,15 @@ The glob (~) accepts a wild card character (\*,?) and character classes
   prev_comm ~ "*sh*"
   prev_comm ~ "ba*sh"
 
+If the field is a pointer that points into user space (for example
+"filename" from sys_enter_openat), then you have to append ".ustring" to the
+field name::
+
+  filename.ustring ~ "password"
+
+As the kernel will have to know how to retrieve the memory that the pointer
+is at from user space.
+
 5.2 Setting filters
 -------------------
 
diff --git a/kernel/trace/trace_events_filter.c b/kernel/trace/trace_events_filter.c
index 2e9ef64e9ee9..b458a9afa2c0 100644
--- a/kernel/trace/trace_events_filter.c
+++ b/kernel/trace/trace_events_filter.c
@@ -665,6 +665,23 @@ struct ustring_buffer {
 static __percpu struct ustring_buffer *ustring_per_cpu;
 
 static __always_inline char *test_string(char *str)
+{
+	struct ustring_buffer *ubuf;
+	char *kstr;
+
+	if (!ustring_per_cpu)
+		return NULL;
+
+	ubuf = this_cpu_ptr(ustring_per_cpu);
+	kstr = ubuf->buffer;
+
+	/* For safety, do not trust the string pointer */
+	if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
+		return NULL;
+	return kstr;
+}
+
+static __always_inline char *test_ustring(char *str)
 {
 	struct ustring_buffer *ubuf;
 	char __user *ustr;
@@ -676,23 +693,11 @@ static __always_inline char *test_string(char *str)
 	ubuf = this_cpu_ptr(ustring_per_cpu);
 	kstr = ubuf->buffer;
 
-	/*
-	 * We use TASK_SIZE to denote user or kernel space, but this will
-	 * not work for all architectures. If it picks the wrong one, it may
-	 * just fail the filter (but will not bug).
-	 *
-	 * TODO: Have a way to properly denote which one this is for.
-	 */
-	if (likely((unsigned long)str >= TASK_SIZE)) {
-		/* For safety, do not trust the string pointer */
-		if (!strncpy_from_kernel_nofault(kstr, str, USTRING_BUF_SIZE))
-			return NULL;
-	} else {
-		/* user space address? */
-		ustr = (char __user *)str;
-		if (!strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE))
-			return NULL;
-	}
+	/* user space address? */
+	ustr = (char __user *)str;
+	if (!strncpy_from_user_nofault(kstr, ustr, USTRING_BUF_SIZE))
+		return NULL;
+
 	return kstr;
 }
 
@@ -709,24 +714,42 @@ static int filter_pred_string(struct filter_pred *pred, void *event)
 	return match;
 }
 
+static __always_inline int filter_pchar(struct filter_pred *pred, char *str)
+{
+	int cmp, match;
+	int len;
+
+	len = strlen(str) + 1;	/* including tailing '\0' */
+	cmp = pred->regex.match(str, &pred->regex, len);
+
+	match = cmp ^ pred->not;
+
+	return match;
+}
 /* Filter predicate for char * pointers */
 static int filter_pred_pchar(struct filter_pred *pred, void *event)
 {
 	char **addr = (char **)(event + pred->offset);
 	char *str;
-	int cmp, match;
-	int len;
 
 	str = test_string(*addr);
 	if (!str)
 		return 0;
 
-	len = strlen(str) + 1;	/* including tailing '\0' */
-	cmp = pred->regex.match(str, &pred->regex, len);
+	return filter_pchar(pred, str);
+}
 
-	match = cmp ^ pred->not;
+/* Filter predicate for char * pointers in user space*/
+static int filter_pred_pchar_user(struct filter_pred *pred, void *event)
+{
+	char **addr = (char **)(event + pred->offset);
+	char *str;
 
-	return match;
+	str = test_ustring(*addr);
+	if (!str)
+		return 0;
+
+	return filter_pchar(pred, str);
 }
 
 /*
@@ -1232,6 +1255,7 @@ static int parse_pred(const char *str, void *data,
 	struct filter_pred *pred = NULL;
 	char num_buf[24];	/* Big enough to hold an address */
 	char *field_name;
+	bool ustring = false;
 	char q;
 	u64 val;
 	int len;
@@ -1266,6 +1290,12 @@ static int parse_pred(const char *str, void *data,
 		return -EINVAL;
 	}
 
+	/* See if the field is a user space string */
+	if ((len = str_has_prefix(str + i, ".ustring"))) {
+		ustring = true;
+		i += len;
+	}
+
 	while (isspace(str[i]))
 		i++;
 
@@ -1405,7 +1435,10 @@ static int parse_pred(const char *str, void *data,
 					goto err_mem;
 			}
 
-			pred->fn = filter_pred_pchar;
+			if (ustring)
+				pred->fn = filter_pred_pchar_user;
+			else
+				pred->fn = filter_pred_pchar;
 		}
 		/* go past the last quote */
 		i++;
