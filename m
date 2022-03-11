Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A3C7C4D5840
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 03:41:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345689AbiCKCmm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 21:42:42 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242345AbiCKCml (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 21:42:41 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EDD52188A0D;
        Thu, 10 Mar 2022 18:41:38 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id AA710B829A0;
        Fri, 11 Mar 2022 02:41:37 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1108DC340EB;
        Fri, 11 Mar 2022 02:41:34 +0000 (UTC)
Date:   Thu, 10 Mar 2022 21:41:33 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Tom Zanussi <zanussi@kernel.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Borislav Petkov <bp@alien8.de>
Subject: [PATCH] tracing: Add snapshot at end of kernel boot up
Message-ID: <20220310214133.0e58e321@gandalf.local.home>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: "Steven Rostedt (Google)" <rostedt@goodmis.org>

Add ftrace_boot_snapshot kernel parameter that will take a snapshot at the
end of boot up just before switching over to user space (it happens during
the kernel freeing of init memory).

This is useful when there's interesting data that can be collected from
kernel start up, but gets overridden by user space start up code. With
this option, the ring buffer content from the boot up traces gets saved in
the snapshot at the end of boot up. This trace can be read from:

 /sys/kernel/tracing/snapshot

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../admin-guide/kernel-parameters.txt          |  8 ++++++++
 include/linux/ftrace.h                         | 11 ++++++++++-
 kernel/trace/ftrace.c                          |  2 ++
 kernel/trace/trace.c                           | 18 ++++++++++++++++++
 4 files changed, 38 insertions(+), 1 deletion(-)

diff --git a/Documentation/admin-guide/kernel-parameters.txt b/Documentation/admin-guide/kernel-parameters.txt
index f5a27f067db9..f6b7ee64ace8 100644
--- a/Documentation/admin-guide/kernel-parameters.txt
+++ b/Documentation/admin-guide/kernel-parameters.txt
@@ -1435,6 +1435,14 @@
 			as early as possible in order to facilitate early
 			boot debugging.
 
+	ftrace_boot_snapshot
+			[FTRACE] On boot up, a snapshot will be taken of the
+			ftrace ring buffer that can be read at:
+			/sys/kernel/tracing/snapshot.
+			This is useful if you need tracing information from kernel
+			boot up that is likely to be overridden by user space
+			start up functionality.
+
 	ftrace_dump_on_oops[=orig_cpu]
 			[FTRACE] will dump the trace buffers on oops.
 			If no parameter is passed, ftrace will dump
diff --git a/include/linux/ftrace.h b/include/linux/ftrace.h
index 9999e29187de..ee91400c1c97 100644
--- a/include/linux/ftrace.h
+++ b/include/linux/ftrace.h
@@ -30,6 +30,12 @@
 #define ARCH_SUPPORTS_FTRACE_OPS 0
 #endif
 
+#ifdef CONFIG_TRACING
+extern void ftrace_boot_snapshot(void);
+#else
+static inline void ftrace_boot_snapshot(void) { }
+#endif
+
 #ifdef CONFIG_FUNCTION_TRACER
 struct ftrace_ops;
 struct ftrace_regs;
@@ -216,7 +222,10 @@ void ftrace_free_init_mem(void);
 void ftrace_free_mem(struct module *mod, void *start, void *end);
 #else
 static inline void ftrace_free_init_mem(void) { }
-static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
+static inline void ftrace_free_mem(struct module *mod, void *start, void *end)
+{
+	ftrace_boot_snapshot();
+}
 #endif
 
 /*
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index 7f93577ee428..9774ea0ad878 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7123,6 +7123,8 @@ void __init ftrace_free_init_mem(void)
 	void *start = (void *)(&__init_begin);
 	void *end = (void *)(&__init_end);
 
+	ftrace_boot_snapshot();
+
 	ftrace_free_mem(NULL, start, end);
 }
 
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7c85ce9ffdc3..eaf7d30ca6f1 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -185,6 +185,7 @@ static char bootup_tracer_buf[MAX_TRACER_SIZE] __initdata;
 static char *default_bootup_tracer;
 
 static bool allocate_snapshot;
+static bool snapshot_at_boot;
 
 static int __init set_cmdline_ftrace(char *str)
 {
@@ -230,6 +231,15 @@ static int __init boot_alloc_snapshot(char *str)
 __setup("alloc_snapshot", boot_alloc_snapshot);
 
 
+static int __init boot_snapshot(char *str)
+{
+	snapshot_at_boot = true;
+	boot_alloc_snapshot(str);
+	return 1;
+}
+__setup("ftrace_boot_snapshot", boot_snapshot);
+
+
 static char trace_boot_options_buf[MAX_TRACER_SIZE] __initdata;
 
 static int __init set_trace_boot_options(char *str)
@@ -10149,6 +10159,14 @@ __init static int tracer_alloc_buffers(void)
 	return ret;
 }
 
+void __init ftrace_boot_snapshot(void)
+{
+	if (snapshot_at_boot) {
+		tracing_snapshot();
+		internal_trace_puts("** Boot snapshot taken **\n");
+	}
+}
+
 void __init early_trace_init(void)
 {
 	if (tracepoint_printk) {
-- 
2.34.1

