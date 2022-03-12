Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 490FD4D7181
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 00:27:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233144AbiCLX1q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 12 Mar 2022 18:27:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232995AbiCLX1E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 12 Mar 2022 18:27:04 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3526492D0F
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 15:25:56 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2B6ABB80B37
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 23:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id F403AC340FC;
        Sat, 12 Mar 2022 23:25:52 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nTB7Q-000WiZ-3P;
        Sat, 12 Mar 2022 18:25:52 -0500
Message-ID: <20220312232551.934410678@goodmis.org>
User-Agent: quilt/0.66
Date:   Sat, 12 Mar 2022 18:25:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>
Subject: [for-next][PATCH 11/12] tracing: Add snapshot at end of kernel boot up
References: <20220312232525.234705244@goodmis.org>
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
index 9999e29187de..37b619185ec9 100644
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
@@ -215,7 +221,10 @@ struct ftrace_ops_hash {
 void ftrace_free_init_mem(void);
 void ftrace_free_mem(struct module *mod, void *start, void *end);
 #else
-static inline void ftrace_free_init_mem(void) { }
+static inline void ftrace_free_init_mem(void)
+{
+	ftrace_boot_snapshot();
+}
 static inline void ftrace_free_mem(struct module *mod, void *start, void *end) { }
 #endif
 
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9feb197b2da..4e29bd1cf151 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7096,6 +7096,8 @@ void __init ftrace_free_init_mem(void)
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
2.35.1
