Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id CDC0B48DBAB
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:25:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236635AbiAMQZV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:25:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236625AbiAMQZU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:25:20 -0500
Received: from mail-pg1-x532.google.com (mail-pg1-x532.google.com [IPv6:2607:f8b0:4864:20::532])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1A775C06161C
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:25:20 -0800 (PST)
Received: by mail-pg1-x532.google.com with SMTP id i30so304697pgl.0
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 08:25:20 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiPWEprVr2YAmhzLiGhZ4p+kH65VIfO/TgCAH3YeKa8=;
        b=YVi3rnQGmWRopKqROi35bl2XN+0uR5LFq/BPlbJMc5LxTmYq5C4Mx0kbxdeOeYZP1t
         +D2/Kk7qWFfGO4ocsoopIUPiQbfREzhg7eHVw85EAxLf0/uRM2ZJxuk+scMQidh2i0SH
         ME1oLlhuRveHyDREOJItfiVxw2SyCwBdhmoM3iNysohcM1LwU5ILqoJT/8Ii+vrapjpQ
         CDt9RRvCPvSVvTnciRxhPwMpiNWkx/P64xoSG2mEZKvMZmAfXmveLID7uKJ+Busnko0E
         tlzvpZ9GmTdGAs26+kMgPb25J8oAAVNVJr/KWKS2grlam7ScT3J987R+1iQh2Ko/PwFY
         ABLA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:mime-version
         :content-transfer-encoding;
        bh=eiPWEprVr2YAmhzLiGhZ4p+kH65VIfO/TgCAH3YeKa8=;
        b=aththPnG4qvjRUXOqYCEzZL5xGMt0AaVNGXRF1eL5t5Y1dAM/ec3xSIhIcwpwh3Ibi
         +xxd20Pl65j0Er/Khk83LkBquVanwmkqGTEWM5h4ozcBZdFsWgdiFgU5piqYzcReYb4W
         tNyDb1EEBESuYxI2Dr29v+0w6ZwKGo97GQBe/rOgTUhZRO4uWq62JobljVD8Ad7KE+2V
         RMywcT03BoWH3Xhw0x7+4sO6ZEAe6mG5/SdZbn6jeE0jaYBpEFz7GH4l4oh17blimXC+
         +jPRJJdUb8fdqwxi3u6MzlmUZlk2W9h2h0yVoPJGw3OYy+TNH6MJ7VE83CKr8ONix5Mb
         Yqfw==
X-Gm-Message-State: AOAM532FanhZ2BkAZnV7wjtSuEd+4Y2x8tQp2PEn5KEZ4vFrJa4lrqk8
        h1Qg4ycMZLtt8rpY0pVbiIk=
X-Google-Smtp-Source: ABdhPJyceF2SXN6Th+RLWWz9Q4vNAt9/0B/d6ZKKkdsVCGf1EyLlywoHG5ZJ7Jpvwz95EW5r8dRKgw==
X-Received: by 2002:a63:d312:: with SMTP id b18mr4569416pgg.198.1642091119617;
        Thu, 13 Jan 2022 08:25:19 -0800 (PST)
Received: from localhost.localdomain ([223.212.58.71])
        by smtp.gmail.com with ESMTPSA id j14sm3431291pfu.15.2022.01.13.08.25.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 08:25:19 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Cc:     linux-kernel@vger.kernel.org, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH] tracing: Use trace_create_file() to simplify creation of tracefs entry
Date:   Fri, 14 Jan 2022 00:25:13 +0800
Message-Id: <20220113162513.422350-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Creating tracefs entries with tracefs_create_file() followed by pr_warn()
is tedious and repetitive, we can use trace_create_file() to simplify
this process and make the code more readable.

Signed-off-by: Yuntao Wang <ytcoode@gmail.com>
---
 kernel/trace/ftrace.c                 | 17 +++++-------
 kernel/trace/trace.c                  | 16 ++++++------
 kernel/trace/trace_dynevent.c         |  8 ++----
 kernel/trace/trace_events.c           | 37 ++++++++++-----------------
 kernel/trace/trace_hwlat.c            |  2 +-
 kernel/trace/trace_kprobe.c           | 14 +++-------
 kernel/trace/trace_osnoise.c          |  2 +-
 kernel/trace/trace_printk.c           |  2 +-
 kernel/trace/trace_recursion_record.c |  7 ++---
 kernel/trace/trace_stack.c            |  4 +--
 kernel/trace/trace_uprobe.c           |  4 +--
 11 files changed, 44 insertions(+), 69 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 403e485bf091..3c5e3838772d 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -983,11 +983,9 @@ static __init void ftrace_profile_tracefs(struct dentry *d_tracer)
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
@@ -6366,11 +6364,10 @@ static __init int ftrace_init_dyn_tracefs(struct dentry *d_tracer)
 
 #ifdef CONFIG_FUNCTION_GRAPH_TRACER
 	trace_create_file("set_graph_function", TRACE_MODE_WRITE, d_tracer,
-				    NULL,
-				    &ftrace_graph_fops);
+			  NULL, &ftrace_graph_fops);
+
 	trace_create_file("set_graph_notrace", TRACE_MODE_WRITE, d_tracer,
-				    NULL,
-				    &ftrace_graph_notrace_fops);
+			  NULL, &ftrace_graph_notrace_fops);
 #endif /* CONFIG_FUNCTION_GRAPH_TRACER */
 
 	return 0;
@@ -7744,7 +7741,7 @@ static const struct file_operations ftrace_no_pid_fops = {
 void ftrace_init_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 {
 	trace_create_file("set_ftrace_pid", TRACE_MODE_WRITE, d_tracer,
-			    tr, &ftrace_pid_fops);
+			  tr, &ftrace_pid_fops);
 	trace_create_file("set_ftrace_notrace_pid", TRACE_MODE_WRITE,
 			  d_tracer, tr, &ftrace_no_pid_fops);
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a73d78dcda2c..5d66e79f43e7 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9422,10 +9422,10 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	int cpu;
 
 	trace_create_file("available_tracers", TRACE_MODE_READ, d_tracer,
-			tr, &show_traces_fops);
+			  tr, &show_traces_fops);
 
 	trace_create_file("current_tracer", TRACE_MODE_WRITE, d_tracer,
-			tr, &set_tracer_fops);
+			  tr, &set_tracer_fops);
 
 	trace_create_file("tracing_cpumask", TRACE_MODE_WRITE, d_tracer,
 			  tr, &tracing_cpumask_fops);
@@ -9472,7 +9472,7 @@ init_tracer_tracefs(struct trace_array *tr, struct dentry *d_tracer)
 	tr->buffer_percent = 50;
 
 	trace_create_file("buffer_percent", TRACE_MODE_READ, d_tracer,
-			tr, &buffer_percent_fops);
+			  tr, &buffer_percent_fops);
 
 	create_trace_options_dir(tr);
 
@@ -9680,19 +9680,19 @@ static __init int tracer_init_tracefs(void)
 	ftrace_init_tracefs_toplevel(&global_trace, NULL);
 
 	trace_create_file("tracing_thresh", TRACE_MODE_WRITE, NULL,
-			&global_trace, &tracing_thresh_fops);
+			  &global_trace, &tracing_thresh_fops);
 
 	trace_create_file("README", TRACE_MODE_READ, NULL,
-			NULL, &tracing_readme_fops);
+			  NULL, &tracing_readme_fops);
 
 	trace_create_file("saved_cmdlines", TRACE_MODE_READ, NULL,
-			NULL, &tracing_saved_cmdlines_fops);
+			  NULL, &tracing_saved_cmdlines_fops);
 
 	trace_create_file("saved_cmdlines_size", TRACE_MODE_WRITE, NULL,
 			  NULL, &tracing_saved_cmdlines_size_fops);
 
 	trace_create_file("saved_tgids", TRACE_MODE_READ, NULL,
-			NULL, &tracing_saved_tgids_fops);
+			  NULL, &tracing_saved_tgids_fops);
 
 	trace_eval_init();
 
@@ -9704,7 +9704,7 @@ static __init int tracer_init_tracefs(void)
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	trace_create_file("dyn_ftrace_total_info", TRACE_MODE_READ, NULL,
-			NULL, &tracing_dyn_info_fops);
+			  NULL, &tracing_dyn_info_fops);
 #endif
 
 	create_trace_instances(NULL);
diff --git a/kernel/trace/trace_dynevent.c b/kernel/trace/trace_dynevent.c
index e34e8182ee4b..6f6ee1d9e247 100644
--- a/kernel/trace/trace_dynevent.c
+++ b/kernel/trace/trace_dynevent.c
@@ -262,12 +262,8 @@ static __init int init_dynamic_event(void)
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
index 3147614c1812..408f8a8a7723 100644
--- a/kernel/trace/trace_events.c
+++ b/kernel/trace/trace_events.c
@@ -3446,12 +3446,10 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
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
@@ -3466,25 +3464,21 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
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
-				  ring_buffer_print_page_header,
-				  &ftrace_show_header_fops);
+			  ring_buffer_print_page_header,
+			  &ftrace_show_header_fops);
 
 	trace_create_file("header_event", TRACE_MODE_READ, d_events,
-				  ring_buffer_print_entry_header,
-				  &ftrace_show_header_fops);
+			  ring_buffer_print_entry_header,
+			  &ftrace_show_header_fops);
 
 	tr->event_dir = d_events;
 
@@ -3690,17 +3684,14 @@ static __init int event_trace_init_fields(void)
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
diff --git a/kernel/trace/trace_hwlat.c b/kernel/trace/trace_hwlat.c
index 56bb7b890578..7bab09a6bd0a 100644
--- a/kernel/trace/trace_hwlat.c
+++ b/kernel/trace/trace_hwlat.c
@@ -796,7 +796,7 @@ static int init_tracefs(void)
 	if (!hwlat_sample_width)
 		goto err;
 
-	hwlat_thread_mode = trace_create_file("mode", TRACE_MODE_WRITE,
+	hwlat_thread_mode = tracefs_create_file("mode", TRACE_MODE_WRITE,
 					      top_dir,
 					      NULL,
 					      &thread_mode_fops);
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3d85323278ed..d13826ea490b 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1912,19 +1912,13 @@ static __init int init_kprobe_trace(void)
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
 
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 36d9d5be08b4..d0aa23bcbf85 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -2075,7 +2075,7 @@ static int init_tracefs(void)
 	if (!tmp)
 		goto err;
 
-	tmp = trace_create_file("cpus", TRACE_MODE_WRITE, top_dir, NULL, &cpus_fops);
+	tmp = tracefs_create_file("cpus", TRACE_MODE_WRITE, top_dir, NULL, &cpus_fops);
 	if (!tmp)
 		goto err;
 
diff --git a/kernel/trace/trace_printk.c b/kernel/trace/trace_printk.c
index 29f6e95439b6..5422ac74537a 100644
--- a/kernel/trace/trace_printk.c
+++ b/kernel/trace/trace_printk.c
@@ -385,7 +385,7 @@ static __init int init_trace_printk_function_export(void)
 		return 0;
 
 	trace_create_file("printk_formats", TRACE_MODE_READ, NULL,
-				    NULL, &ftrace_formats_fops);
+			  NULL, &ftrace_formats_fops);
 
 	return 0;
 }
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
 
diff --git a/kernel/trace/trace_stack.c b/kernel/trace/trace_stack.c
index 5a48dba912ea..2337470e9ae0 100644
--- a/kernel/trace/trace_stack.c
+++ b/kernel/trace/trace_stack.c
@@ -560,10 +560,10 @@ static __init int stack_trace_init(void)
 		return 0;
 
 	trace_create_file("stack_max_size", TRACE_MODE_WRITE, NULL,
-			&stack_trace_max_size, &stack_max_size_fops);
+			  &stack_trace_max_size, &stack_max_size_fops);
 
 	trace_create_file("stack_trace", TRACE_MODE_READ, NULL,
-			NULL, &stack_trace_fops);
+			  NULL, &stack_trace_fops);
 
 #ifdef CONFIG_DYNAMIC_FTRACE
 	trace_create_file("stack_trace_filter", TRACE_MODE_WRITE, NULL,
diff --git a/kernel/trace/trace_uprobe.c b/kernel/trace/trace_uprobe.c
index 08b0e8417302..58feb4ab34d1 100644
--- a/kernel/trace/trace_uprobe.c
+++ b/kernel/trace/trace_uprobe.c
@@ -1652,10 +1652,10 @@ static __init int init_uprobe_trace(void)
 		return 0;
 
 	trace_create_file("uprobe_events", TRACE_MODE_WRITE, NULL,
-				    NULL, &uprobe_events_ops);
+			  NULL, &uprobe_events_ops);
 	/* Profile interface */
 	trace_create_file("uprobe_profile", TRACE_MODE_READ, NULL,
-				    NULL, &uprobe_profile_ops);
+			  NULL, &uprobe_profile_ops);
 	return 0;
 }
 
-- 
2.34.1

