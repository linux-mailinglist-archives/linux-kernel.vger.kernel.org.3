Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB13B536A50
	for <lists+linux-kernel@lfdr.de>; Sat, 28 May 2022 04:53:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355607AbiE1Cw5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 27 May 2022 22:52:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351288AbiE1Cww (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 27 May 2022 22:52:52 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58F041271A9
        for <linux-kernel@vger.kernel.org>; Fri, 27 May 2022 19:52:51 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id E858461D2A
        for <linux-kernel@vger.kernel.org>; Sat, 28 May 2022 02:52:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 57132C3411C;
        Sat, 28 May 2022 02:52:50 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1numZN-000LLX-CL;
        Fri, 27 May 2022 22:52:49 -0400
Message-ID: <20220528025249.223467825@goodmis.org>
User-Agent: quilt/0.66
Date:   Fri, 27 May 2022 22:50:31 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Masami Hiramatsu (Google)" <mhiramat@kernel.org>,
        Yuntao Wang <ytcoode@gmail.com>
Subject: [for-next][PATCH 03/23] tracing: Use trace_create_file() to simplify creation of tracefs
 entries
References: <20220528025028.850906216@goodmis.org>
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

From: Yuntao Wang <ytcoode@gmail.com>

Creating tracefs entries with tracefs_create_file() followed by pr_warn()
is tedious and repetitive, we can use trace_create_file() to simplify
this process and make the code more readable.

Link: https://lkml.kernel.org/r/20220114131052.534382-1-ytcoode@gmail.com

Acked-by: Masami Hiramatsu (Google) <mhiramat@kernel.org>
Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 kernel/trace/ftrace.c                 |  9 +++------
 kernel/trace/trace_dynevent.c         |  9 ++-------
 kernel/trace/trace_events.c           | 29 +++++++++------------------
 kernel/trace/trace_kprobe.c           | 15 ++++----------
 kernel/trace/trace_recursion_record.c |  7 ++-----
 5 files changed, 21 insertions(+), 48 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 5c465e70d146..6c5b12669e06 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -952,7 +952,6 @@ static struct tracer_stat function_stats __initdata = {
 static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
 {
 	struct ftrace_profile_stat *stat;
-	struct dentry *entry;
 	char *name;
 	int ret;
 	int cpu;
@@ -983,11 +982,9 @@ static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
 		}
 	}
 
-	entry = tracefs_create_file("function_profile_enabled",
-				    TRACE_MODE_WRITE, d_tracer, NULL,
-				    &ftrace_profile_fops);
-	if (!entry)
-		pr_warn("Could not create tracefs 'function_profile_enabled' entry\n");
+	trace_create_file("function_profile_enabled",
+			  TRACE_MODE_WRITE, d_tracer, NULL,
+			  &ftrace_profile_fops);
 }
 
 #else /* CONFIG_FUNCTION_PROFILER */
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index e34e8182ee4b..076b447a1b88 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -255,19 +255,14 @@ static const struct file_operations dynamic_events_ops = {
 /* Make a tracefs interface for controlling dynamic events */
 static __init int init_dynamic_event(void)
 {
-	struct dentry *entry;
 	int ret;
 
 	ret = tracing_init_dentry();
 	if (ret)
 		return 0;
 
-	entry = tracefs_create_file("dynamic_events", TRACE_MODE_WRITE, NULL,
-				    NULL, &dynamic_events_ops);
-
-	/* Event list interface */
-	if (!entry)
-		pr_warn("Could not create tracefs 'dynamic_events' entry\n");
+	trace_create_file("dynamic_events", TRACE_MODE_WRITE, NULL,
+			  NULL, &dynamic_events_ops);
 
 	return 0;
 }
diff --git a/kernel/trace/trace_events.c b/kernel/trace/trace_events.c
index d5913487821a..9a88de9d7815 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3546,12 +3546,10 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 	struct dentry *d_events;
 	struct dentry *entry;
 
-	entry = tracefs_create_file("set_event", TRACE_MODE_WRITE, parent,
-				    tr, &ftrace_set_event_fops);
-	if (!entry) {
-		pr_warn("Could not create tracefs 'set_event' entry\n");
+	entry = trace_create_file("set_event", TRACE_MODE_WRITE, parent,
+				  tr, &ftrace_set_event_fops);
+	if (!entry)
 		return -ENOMEM;
-	}
 
 	d_events = tracefs_create_dir("events", parent);
 	if (!d_events) {
@@ -3566,16 +3564,12 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
 	/* There are not as crucial, just warn if they are not created */
 
-	entry = tracefs_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
-				    tr, &ftrace_set_event_pid_fops);
-	if (!entry)
-		pr_warn("Could not create tracefs 'set_event_pid' entry\n");
+	trace_create_file("set_event_pid", TRACE_MODE_WRITE, parent,
+			  tr, &ftrace_set_event_pid_fops);
 
-	entry = tracefs_create_file("set_event_notrace_pid",
-				    TRACE_MODE_WRITE, parent, tr,
-				    &ftrace_set_event_notrace_pid_fops);
-	if (!entry)
-		pr_warn("Could not create tracefs 'set_event_notrace_pid' entry\n");
+	trace_create_file("set_event_notrace_pid",
+			  TRACE_MODE_WRITE, parent, tr,
+			  &ftrace_set_event_notrace_pid_fops);
 
 	/* ring buffer internal formats */
 	trace_create_file("header_page", TRACE_MODE_READ, d_events,
@@ -3790,17 +3784,14 @@ static __init int event_trace_init_fields(void)
 __init int event_trace_init(void)
 {
 	struct trace_array *tr;
-	struct dentry *entry;
 	int ret;
 
 	tr = top_trace_array();
 	if (!tr)
 		return -ENODEV;
 
-	entry = tracefs_create_file("available_events", TRACE_MODE_READ,
-				    NULL, tr, &ftrace_avail_fops);
-	if (!entry)
-		pr_warn("Could not create tracefs 'available_events' entry\n");
+	trace_create_file("available_events", TRACE_MODE_READ,
+			  NULL, tr, &ftrace_avail_fops);
 
 	ret = early_event_add_tracer(NULL, tr);
 	if (ret)
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 47cebef78532..93507330462c 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1907,25 +1907,18 @@ core_initcall(init_kprobe_trace_early);
 static __init int init_kprobe_trace(void)
 {
 	int ret;
-	struct dentry *entry;
 
 	ret = tracing_init_dentry();
 	if (ret)
 		return 0;
 
-	entry = tracefs_create_file("kprobe_events", TRACE_MODE_WRITE,
-				    NULL, NULL, &kprobe_events_ops);
-
 	/* Event list interface */
-	if (!entry)
-		pr_warn("Could not create tracefs 'kprobe_events' entry\n");
+	trace_create_file("kprobe_events", TRACE_MODE_WRITE,
+			  NULL, NULL, &kprobe_events_ops);
 
 	/* Profile interface */
-	entry = tracefs_create_file("kprobe_profile", TRACE_MODE_READ,
-				    NULL, NULL, &kprobe_profile_ops);
-
-	if (!entry)
-		pr_warn("Could not create tracefs 'kprobe_profile' entry\n");
+	trace_create_file("kprobe_profile", TRACE_MODE_READ,
+			  NULL, NULL, &kprobe_profile_ops);
 
 	setup_boot_kprobe_events();
 
diff --git a/kernel/trace/trace_recursion_record.c b/kernel/trace/trace_recursion_record.c
index 4d4b78c8ca25..a520b11afb0d 100644
--- a/kernel/trace/trace_recursion_record.c
+++ b/kernel/trace/trace_recursion_record.c
@@ -224,12 +224,9 @@ static const struct file_operations recursed_functions_fops = {
 
 __init static int create_recursed_functions(void)
 {
-	struct dentry *dentry;
 
-	dentry = trace_create_file("recursed_functions", TRACE_MODE_WRITE,
-				   NULL, NULL, &recursed_functions_fops);
-	if (!dentry)
-		pr_warn("WARNING: Failed to create recursed_functions\n");
+	trace_create_file("recursed_functions", TRACE_MODE_WRITE,
+			  NULL, NULL, &recursed_functions_fops);
 	return 0;
 }
 
-- 
2.35.1
