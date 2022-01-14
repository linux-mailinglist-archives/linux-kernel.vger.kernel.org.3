Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D595148E209
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 02:11:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235883AbiANBLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 20:11:41 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230237AbiANBLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 20:11:40 -0500
Received: from mail-pg1-x52a.google.com (mail-pg1-x52a.google.com [IPv6:2607:f8b0:4864:20::52a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 39062C061574
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 17:11:40 -0800 (PST)
Received: by mail-pg1-x52a.google.com with SMTP id f8so1430902pgf.8
        for <linux-kernel@vger.kernel.org>; Thu, 13 Jan 2022 17:11:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=Iax6Fync+gAPcYtUklGk2UcMbt5whDvR49NUg6FEsXA=;
        b=O2ZOAYXtBksrXbaN+QOmlMswIUs8NsG8jH3mU4UvfP+z4ZhPp/h90ztPs/vdgUhng/
         ClCk+teSJZrz6+NR80W+E8U48HKgCosDlucTim/csDUp7QfpxVf/lWbguLG6YjDtsjac
         ZdCvSIZljVzX77rQtBJExKhrW5RQvYoOOQT+5V70q6+zF7sOo/YmbL4LoMBuZlUgXlL5
         GfPijUhi7gRXnceFZNhjcUA/ewv1q7vupWy/Qb9u5PNsD3u9HMJQt6cgYqFHRT/jZMJK
         kaFk3kHX5eyxg8Vta+Ej4N4EfzOOMUtYuSmTJXnKjSW2lKYhFhWMSvhiJnxxZNvXeJuz
         5cSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=Iax6Fync+gAPcYtUklGk2UcMbt5whDvR49NUg6FEsXA=;
        b=Vo3960hQCzSTqjbICGEFNB92agsIpRqm4n8moGx2mPcgFWcBmhSbUTjsrxGbkT1vmT
         oftL9HcgKp+QJWcMImR75ZjnFXEhMot4109S4V2R3Peu/XU/V0PDk8GksZAyy0oXgFlI
         GxJluW5FRoD50FgKg8fllc3uLHF0dujfnYJzO5PX4oK+VzCJTTGQUzKZ4ljKvuK7N1Sn
         MRjdaT3KDz0ju52rHbNBb//pEEXBSjdaIgIHRfSKBQkhcUvlKrY8n3lqV/u3vxSLfiGG
         3YxYkO9Z6zqhfGUe1A8+oxxFgLvwdoQH4YfS/Ka24iBEjKrq1e74EAB273m78b4CzzSo
         U5Hg==
X-Gm-Message-State: AOAM532NIJISGF+GspN8BVz58A0lqVafqAagKpkCtx+kbze7m1doIiBS
        sHSdevQCeuHr2BsT9XrxBD8=
X-Google-Smtp-Source: ABdhPJx09qhEIk1XEiyb3MbTETC3qeOqRNZgtOhW50IlAAMXQuDhzMGs+PUIhzkaVcR1xqoRNj17Yg==
X-Received: by 2002:a63:6f8c:: with SMTP id k134mr6133546pgc.35.1642122699657;
        Thu, 13 Jan 2022 17:11:39 -0800 (PST)
Received: from vultr.guest ([141.164.42.249])
        by smtp.gmail.com with ESMTPSA id e7sm3732362pfc.106.2022.01.13.17.11.37
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 13 Jan 2022 17:11:39 -0800 (PST)
From:   Yuntao Wang <ytcoode@gmail.com>
To:     Steven Rostedt <rostedt@goodmis.org>,
        Ingo Molnar <mingo@redhat.com>
Cc:     linux-kernel@vger.kernel.org, Yuntao Wang <ytcoode@gmail.com>
Subject: [PATCH v2] tracing: Use trace_create_file() to simplify creation of tracefs entries
Date:   Fri, 14 Jan 2022 01:07:12 +0000
Message-Id: <20220114010712.1771145-1-ytcoode@gmail.com>
X-Mailer: git-send-email 2.25.1
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

 kernel/trace/ftrace.c                 |  8 +++-----
 kernel/trace/trace_dynevent.c         |  8 ++------
 kernel/trace/trace_events.c           | 29 +++++++++------------------
 kernel/trace/trace_kprobe.c           | 14 ++++---------
 kernel/trace/trace_recursion_record.c |  7 ++-----
 5 files changed, 21 insertions(+), 45 deletions(-)

diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 403e485bf091..83072cd9bdca 100644
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

