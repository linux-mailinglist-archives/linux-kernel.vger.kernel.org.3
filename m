Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 06C1948EA65
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 14:11:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241149AbiANNLm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 08:11:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231283AbiANNLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 08:11:40 -0500
Received: from mail-pj1-x1029.google.com (mail-pj1-x1029.google.com [IPv6:2607:f8b0:4864:20::1029])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D0ACC061574
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:11:39 -0800 (PST)
Received: by mail-pj1-x1029.google.com with SMTP id l10-20020a17090a384a00b001b22190e075so21892140pjf.3
        for <linux-kernel@vger.kernel.org>; Fri, 14 Jan 2022 05:11:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nFISphGpFiTR+JHBIVREZhNZNOc/s2LDaWzcBR1vLSQ=;
        b=ZXuQYcl7r5FGVjXDYbe4HvM7DgdGBoinxWnvrzB5XvrWesi1L8tkGhCfuK6BqVPb6G
         IqkGXzf3caCL+Omncc+JIn+pd0gngwyMyZysAhswU/aarjY0xdPi7sffDyXQzCqqX2rK
         J2mRnWUb4JTc8gB7lVvVFL4BOs6TVvBtDGmCszCEpO+WwuFHEqS0RZI06i5yoqZhiZ3r
         P/kOzzcpth0+fLF2Mm7fvcjCf4fDgtRFEkDOfD/g1XTHUAwEHJY2RwB25jIYPMPmx8IL
         0mb5IEw5hpByJDGIuw2jiWzQf6y8M25gGQuZ3x+Wj2FVicz7zRjH5tdaVVSR4E//NkW5
         V99w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nFISphGpFiTR+JHBIVREZhNZNOc/s2LDaWzcBR1vLSQ=;
        b=0xNQzrZER7kKVJLZkWUK1Z9jS14TDt2QAHeMrLWl4jMbmsYLZ/f3U1z8OidhVckDaw
         J1BF0a/BhTUj772nmpSQ5xi7xqxKvUvea3hi28HLwxwNQwF7zZ/GYh+8KrNHKB1RDiAS
         RVhSIOEfKbwS5OVS48foCZ848sTAvWmtRyHurdJpOBBdSwFYC0o3Ubi+2z/+2+2HJSdn
         mMShy/kZacR007RmMLwWLqLERW9bNoVjA29KpEEAWkOuqu/VPY5oCnzRgq38iiq9Yzv5
         9fRNgZTb01z00Z2D5xg/rQbXxhLlZHChgI+s+vKO/JAXirNYQ/f22sjqTqkYzymrhRmc
         vUpQ==
X-Gm-Message-State: AOAM532RJRIR5sVsDEa11d1p0vr+cRCXV+92HzY46oblOwzXW0TPEbah
        6yg4RsuUtjAiDDOm+/Qjm9UGe5g3AcaNlCD11zU=
X-Google-Smtp-Source: ABdhPJxYtCj+RlgiF39jUOy3IR+ua8uS+T+3kBBvzfnvTRzIviKAMIgghQ+PD56kwFH2JOWg17L3sA==
X-Received: by 2002:a17:902:aa46:b0:149:6c44:ffae with SMTP id c6-20020a170902aa4600b001496c44ffaemr9119083plr.163.1642165898935;
        Fri, 14 Jan 2022 05:11:38 -0800 (PST)
Received: from localhost.localdomain ([223.212.58.71])
        by smtp.gmail.com with ESMTPSA id n22sm2072286pfu.160.2022.01.14.05.11.36
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 14 Jan 2022 05:11:38 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v3] tracing: Use trace_create_file() to simplify creation of tracefs entries
Date:   Fri, 14 Jan 2022 21:10:52 +0800
Message-Id: <20220114131052.534382-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220113142314.2bd7eebe@gandalf.local.home>
References: <20220113142314.2bd7eebe@gandalf.local.home>
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
Changes since v1:
- Remove format change updates

Changes since v2:
- Remove unused variables

 kernel/trace/ftrace.c                 |  9 +++------
 kernel/trace/trace_dynevent.c         |  9 ++-------
 kernel/trace/trace_events.c           | 29 +++++++++------------------
 kernel/trace/trace_kprobe.c           | 15 ++++----------
 kernel/trace/trace_recursion_record.c |  7 ++-----
 5 files changed, 21 insertions(+), 48 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 403e485bf091..6d9bb73d19d3 100644
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
index 3147614c1812..718518b3c491 100644
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
@@ -3466,16 +3464,12 @@ create_event_toplevel_files(struct dentry *parent, struct trace_array *tr)
 
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
diff --git a/kernel/trace/trace_kprobe.c b/kernel/trace/trace_kprobe.c
index 3d85323278ed..5c35c2311690 100644
--- a/kernel/trace/trace_kprobe.c
+++ b/kernel/trace/trace_kprobe.c
@@ -1906,25 +1906,18 @@ core_initcall(init_kprobe_trace_early);
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
2.34.1

