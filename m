Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C538848E273
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 03:15:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238810AbiANCPH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 21:15:07 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:40630 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236061AbiANCPG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 21:15:06 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4B2BCB823E9
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 02:15:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DB2A3C36AEA;
        Fri, 14 Jan 2022 02:15:02 +0000 (UTC)
Date:   Thu, 13 Jan 2022 21:15:01 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Sven Schnelle <svens@linux.ibm.com>
Cc:     David Laight <David.Laight@ACULAB.COM>,
        LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Pingfan Liu <kernelfans@gmail.com>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>, hca@linux.ibm.com,
        deller@gmx.de
Subject: Re: [PATCH v2] tracing: Add test for user space strings when
 filtering on  string pointers
Message-ID: <20220113211501.473ab5ca@gandalf.local.home>
In-Reply-To: <20220113165115.0c844df9@gandalf.local.home>
References: <20220110115532.536088fd@gandalf.local.home>
        <31c11a47a8bc4e34a1a64d54a54bb944@AcuMS.aculab.com>
        <20220110122436.5302128f@gandalf.local.home>
        <7a0fefb7ed3542b4a49dee1e78b1668b@AcuMS.aculab.com>
        <yt9d8rvmt2jq.fsf@linux.ibm.com>
        <20220113125754.0cb5273f@gandalf.local.home>
        <yt9dwnj3wcke.fsf@linux.ibm.com>
        <20220113165115.0c844df9@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 13 Jan 2022 16:51:15 -0500
Steven Rostedt <rostedt@goodmis.org> wrote:

> We could add something later. As it is currently the merge window, and this
> is a real bug, I'm going to just leave it as is, and we can work to fix the
> other archs later. I need to get a pull request ready by tomorrow.

Actually I got this working, and looks like a reasonable answer to the
problem. It basically requires that the user specify that the pointer
points into user space for the kernel to read it.

Thus instead of:

  echo 'filename ~ "trace"' > events/syscalls/sys_enter_openat/filter

They must now do:

  echo 'filename.ustring ~ "trace"' > events/syscalls/sys_enter_openat/filter

I updated the documentation to reflect this.

-- Steve

From: Steven Rostedt <rostedt@goodmis.org>
Subject: [PATCH] tracing: Add ustring operation to filtering string pointers

Since referencing user space pointers is special, if the user wants to
filter on a field that is a pointer to user space, then they need to
specify it.

Add a ".ustring" attribute to the field name for filters to state that the
field is pointing to user space such that the kernel can take the
appropriate action to read that pointer.

Signed-off-by: Steven Rostedt <rostedt@goodmis.org>
---
 Documentation/trace/events.rst     |  9 ++++
 kernel/trace/trace_events_filter.c | 81 +++++++++++++++++++++---------
 2 files changed, 66 insertions(+), 24 deletions(-)

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
-- 
2.33.0

