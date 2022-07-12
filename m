Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7DB2E5729AC
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 01:09:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231354AbiGLXJy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 19:09:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229514AbiGLXJv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 19:09:51 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A58EB9B1A9
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 16:09:50 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4270C61740
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 23:09:50 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A38BEC3411E;
        Tue, 12 Jul 2022 23:09:48 +0000 (UTC)
Date:   Tue, 12 Jul 2022 19:09:47 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Douglas Anderson <dianders@chromium.org>,
        Li kunyu <kunyu@nfschina.com>,
        Tiezhu Yang <yangtiezhu@loongson.cn>,
        Zheng Yejian <zhengyejian1@huawei.com>,
        sunliming <sunliming@kylinos.cn>
Subject: [GIT PULL] tracing: Fixes and minor cleanups for 5.19
Message-ID: <20220712190947.055042b4@gandalf.local.home>
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


Linus,

Fixes and minor clean ups for tracing:

 - Fix memory leak by reverting what was thought to be a double free.
   A static tool had gave a false positive that a double free was
   possible in the error path, but it was actually a different location
   that confused the static analyzer (and those of us that reviewed it).

 - Move use of static buffers by ftrace_dump() to a location that can
   be used by kgdb's ftdump(), as it needs it for the same reasons.

 - Clarify in the Kconfig description that function tracing has negligible
   impact on x86, but may have a bit bigger impact on other architectures.

 - Remove unnecessary extra semicolon in trace event.

 - Make a local variable static that is used in the fprobes sample

 - Use KSYM_NAME_LEN for length of function in kprobe sample and get
   rid of unneeded macro for the same purpose.


Please pull the latest trace-v5.19-rc5 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.19-rc5

Tag SHA1: f64990a1b4d1e153bcb18e40634f008ce23cfbfd
Head SHA1: 1e1fb420fe68d9d938db360fec700dfd230cc22a


Douglas Anderson (1):
      tracing: Fix sleeping while atomic in kdb ftdump

Li kunyu (1):
      blk-iocost: tracing: atomic64_read(&ioc->vtime_rate) is assigned an extra semicolon

Steven Rostedt (Google) (1):
      ftrace: Be more specific about arch impact when function tracer is enabled

Tiezhu Yang (1):
      samples: Use KSYM_NAME_LEN for kprobes

Zheng Yejian (1):
      tracing/histograms: Fix memory leak problem

sunliming (1):
      fprobe/samples: Make sample_probe static

----
 include/trace/events/iocost.h       |  2 +-
 kernel/trace/Kconfig                |  3 ++-
 kernel/trace/trace.c                | 11 ++++++-----
 kernel/trace/trace_events_hist.c    |  2 ++
 samples/fprobe/fprobe_example.c     |  2 +-
 samples/kprobes/kprobe_example.c    |  5 ++---
 samples/kprobes/kretprobe_example.c |  5 ++---
 7 files changed, 16 insertions(+), 14 deletions(-)
---------------------------
diff --git a/include/trace/events/iocost.h b/include/trace/events/iocost.h
index e282ce02fa2d..6d1626e7a4ce 100644
--- a/include/trace/events/iocost.h
+++ b/include/trace/events/iocost.h
@@ -160,7 +160,7 @@ TRACE_EVENT(iocost_ioc_vrate_adj,
 
 	TP_fast_assign(
 		__assign_str(devname, ioc_name(ioc));
-		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);;
+		__entry->old_vrate = atomic64_read(&ioc->vtime_rate);
 		__entry->new_vrate = new_vrate;
 		__entry->busy_level = ioc->busy_level;
 		__entry->read_missed_ppm = missed_ppm[READ];
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index debbbb083286..ccd6a5ade3e9 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -194,7 +194,8 @@ config FUNCTION_TRACER
 	  sequence is then dynamically patched into a tracer call when
 	  tracing is enabled by the administrator. If it's runtime disabled
 	  (the bootup default), then the overhead of the instructions is very
-	  small and not measurable even in micro-benchmarks.
+	  small and not measurable even in micro-benchmarks (at least on
+	  x86, but may have impact on other architectures).
 
 config FUNCTION_GRAPH_TRACER
 	bool "Kernel Function Graph Tracer"
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a8cfac0611bc..b8dd54627075 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9864,6 +9864,12 @@ void trace_init_global_iter(struct trace_iterator *iter)
 	/* Output in nanoseconds only if we are using a clock in nanoseconds. */
 	if (trace_clocks[iter->tr->clock_id].in_ns)
 		iter->iter_flags |= TRACE_FILE_TIME_IN_NS;
+
+	/* Can not use kmalloc for iter.temp and iter.fmt */
+	iter->temp = static_temp_buf;
+	iter->temp_size = STATIC_TEMP_BUF_SIZE;
+	iter->fmt = static_fmt_buf;
+	iter->fmt_size = STATIC_FMT_BUF_SIZE;
 }
 
 void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
@@ -9896,11 +9902,6 @@ void ftrace_dump(enum ftrace_dump_mode oops_dump_mode)
 
 	/* Simulate the iterator */
 	trace_init_global_iter(&iter);
-	/* Can not use kmalloc for iter.temp and iter.fmt */
-	iter.temp = static_temp_buf;
-	iter.temp_size = STATIC_TEMP_BUF_SIZE;
-	iter.fmt = static_fmt_buf;
-	iter.fmt_size = STATIC_FMT_BUF_SIZE;
 
 	for_each_tracing_cpu(cpu) {
 		atomic_inc(&per_cpu_ptr(iter.array_buffer->data, cpu)->disabled);
diff --git a/kernel/trace/trace_events_hist.c b/kernel/trace/trace_events_hist.c
index 48e82e141d54..e87a46794079 100644
--- a/kernel/trace/trace_events_hist.c
+++ b/kernel/trace/trace_events_hist.c
@@ -4430,6 +4430,8 @@ static int parse_var_defs(struct hist_trigger_data *hist_data)
 
 			s = kstrdup(field_str, GFP_KERNEL);
 			if (!s) {
+				kfree(hist_data->attrs->var_defs.name[n_vars]);
+				hist_data->attrs->var_defs.name[n_vars] = NULL;
 				ret = -ENOMEM;
 				goto free;
 			}
diff --git a/samples/fprobe/fprobe_example.c b/samples/fprobe/fprobe_example.c
index 01ee6c8c8382..58f6e8358e97 100644
--- a/samples/fprobe/fprobe_example.c
+++ b/samples/fprobe/fprobe_example.c
@@ -20,7 +20,7 @@
 
 #define BACKTRACE_DEPTH 16
 #define MAX_SYMBOL_LEN 4096
-struct fprobe sample_probe;
+static struct fprobe sample_probe;
 static unsigned long nhit;
 
 static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
diff --git a/samples/kprobes/kprobe_example.c b/samples/kprobes/kprobe_example.c
index f991a66b5b02..fd346f58ddba 100644
--- a/samples/kprobes/kprobe_example.c
+++ b/samples/kprobes/kprobe_example.c
@@ -16,9 +16,8 @@
 #include <linux/module.h>
 #include <linux/kprobes.h>
 
-#define MAX_SYMBOL_LEN	64
-static char symbol[MAX_SYMBOL_LEN] = "kernel_clone";
-module_param_string(symbol, symbol, sizeof(symbol), 0644);
+static char symbol[KSYM_NAME_LEN] = "kernel_clone";
+module_param_string(symbol, symbol, KSYM_NAME_LEN, 0644);
 
 /* For each probe you need to allocate a kprobe structure */
 static struct kprobe kp = {
diff --git a/samples/kprobes/kretprobe_example.c b/samples/kprobes/kretprobe_example.c
index 228321ecb161..cbf16542d84e 100644
--- a/samples/kprobes/kretprobe_example.c
+++ b/samples/kprobes/kretprobe_example.c
@@ -23,11 +23,10 @@
 #include <linux/module.h>
 #include <linux/kprobes.h>
 #include <linux/ktime.h>
-#include <linux/limits.h>
 #include <linux/sched.h>
 
-static char func_name[NAME_MAX] = "kernel_clone";
-module_param_string(func, func_name, NAME_MAX, S_IRUGO);
+static char func_name[KSYM_NAME_LEN] = "kernel_clone";
+module_param_string(func, func_name, KSYM_NAME_LEN, 0644);
 MODULE_PARM_DESC(func, "Function to kretprobe; this module will report the"
 			" function's execution time");
 
