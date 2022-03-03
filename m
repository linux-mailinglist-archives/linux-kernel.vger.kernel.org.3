Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DF1404CC861
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:49:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236685AbiCCVuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:50:21 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50698 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236666AbiCCVuJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:50:09 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B4324443F1
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:49:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3D392B826EE
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D1658C340F2;
        Thu,  3 Mar 2022 21:49:19 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nPtK2-00ESEi-UY;
        Thu, 03 Mar 2022 16:49:18 -0500
Message-ID: <20220303214918.785408734@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 16:48:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 2/4 v2] tracing: Add sample code for custom trace events
References: <20220303214832.031378059@goodmis.org>
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

Add sample code to show how to create custom trace events in the tracefs
directory that can be enabled and modified like any event in tracefs
(including triggers, histograms, synthetic events and event probes).

The example is creating a custom sched_switch and a sched_waking to limit
what is recorded:

If the custom sched switch only records the prev_prio, next_prio and
next_pid, it can bring the size from 64 bytes per event, down to just 16
bytes!

If sched_waking only records the prio and pid of the woken event, it will
bring the size down from 36 bytes to 12 bytes per event.

This will allow for a much smaller footprint into the ring buffer and keep
more events from dropping.

Suggested-by: Joel Fernandes <joel@joelfernandes.org>
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 arch/x86/kernel/kprobes/core.c            |   4 +-
 kernel/trace/ftrace.c                     |  33 ++-
 samples/Kconfig                           |   8 +-
 samples/Makefile                          |   1 +
 samples/trace_events/Makefile             |   2 +
 samples/trace_events/trace_custom_sched.c | 271 ++++++++++++++++++++++
 6 files changed, 314 insertions(+), 5 deletions(-)
 create mode 100644 samples/trace_events/trace_custom_sched.c

diff --git a/arch/x86/kernel/kprobes/core.c b/arch/x86/kernel/kprobes/core.c
index 6290712cb36d..2ea1ecd6f60b 100644
--- a/arch/x86/kernel/kprobes/core.c
+++ b/arch/x86/kernel/kprobes/core.c
@@ -202,8 +202,10 @@ __recover_probed_insn(kprobe_opcode_t *buf, unsigned long addr)
 	 * arch_check_ftrace_location(). Something went terribly wrong
 	 * if such an address is checked here.
 	 */
-	if (WARN_ON(faddr && faddr != addr))
+	if (WARN_ON(faddr && faddr != addr)) {
+		printk("faddr=%pS (%lx) addr=%pS (%lx)\n", (void*)faddr, faddr, (void*)addr, addr);
 		return 0UL;
+	}
 	/*
 	 * Use the current code if it is not modified by Kprobe
 	 * and it cannot be modified by ftrace.
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index a4b462b6f944..cb67527e1203 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -1578,7 +1578,24 @@ unsigned long ftrace_location_range(unsigned long start, unsigned long end)
  */
 unsigned long ftrace_location(unsigned long ip)
 {
-	return ftrace_location_range(ip, ip);
+	struct dyn_ftrace *rec;
+	unsigned long offset;
+	unsigned long size;
+
+	rec = lookup_rec(ip, ip);
+	if (!rec) {
+		if (!kallsyms_lookup_size_offset(ip, &size, &offset))
+			goto out;
+
+		if (!offset)
+			rec = lookup_rec(ip - offset, (ip - offset) + size - 1);
+	}
+
+	if (rec)
+		return rec->ip;
+
+out:
+	return 0;
 }
 
 /**
@@ -4962,7 +4979,8 @@ ftrace_match_addr(struct ftrace_hash *hash, unsigned long ip, int remove)
 {
 	struct ftrace_func_entry *entry;
 
-	if (!ftrace_location(ip))
+	ip = ftrace_location(ip);
+	if (!ip)
 		return -EINVAL;
 
 	if (remove) {
@@ -5110,11 +5128,16 @@ int register_ftrace_direct(unsigned long ip, unsigned long addr)
 	struct ftrace_func_entry *entry;
 	struct ftrace_hash *free_hash = NULL;
 	struct dyn_ftrace *rec;
-	int ret = -EBUSY;
+	int ret = -ENODEV;
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	/* See if there's a direct function at @ip already */
+	ret = -EBUSY;
 	if (ftrace_find_rec_direct(ip))
 		goto out_unlock;
 
@@ -5222,6 +5245,10 @@ int unregister_ftrace_direct(unsigned long ip, unsigned long addr)
 
 	mutex_lock(&direct_mutex);
 
+	ip = ftrace_location(ip);
+	if (!ip)
+		goto out_unlock;
+
 	entry = find_direct_entry(&ip, NULL);
 	if (!entry)
 		goto out_unlock;
diff --git a/samples/Kconfig b/samples/Kconfig
index 22cc921ae291..10e021c72282 100644
--- a/samples/Kconfig
+++ b/samples/Kconfig
@@ -14,7 +14,13 @@ config SAMPLE_TRACE_EVENTS
 	tristate "Build trace_events examples -- loadable modules only"
 	depends on EVENT_TRACING && m
 	help
-	  This build trace event example modules.
+	  This builds the trace event example module.
+
+config SAMPLE_TRACE_CUSTOM_EVENTS
+	tristate "Build custom trace event example -- loadable modules only"
+	depends on EVENT_TRACING && m
+	help
+	  This builds the custom trace event example module.
 
 config SAMPLE_TRACE_PRINTK
         tristate "Build trace_printk module - tests various trace_printk formats"
diff --git a/samples/Makefile b/samples/Makefile
index 1ae4de99c983..448343e8faeb 100644
--- a/samples/Makefile
+++ b/samples/Makefile
@@ -20,6 +20,7 @@ obj-$(CONFIG_SAMPLE_RPMSG_CLIENT)	+= rpmsg/
 subdir-$(CONFIG_SAMPLE_SECCOMP)		+= seccomp
 subdir-$(CONFIG_SAMPLE_TIMER)		+= timers
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS)	+= trace_events/
+obj-$(CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS) += trace_events/
 obj-$(CONFIG_SAMPLE_TRACE_PRINTK)	+= trace_printk/
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT)	+= ftrace/
 obj-$(CONFIG_SAMPLE_FTRACE_DIRECT_MULTI) += ftrace/
diff --git a/samples/trace_events/Makefile b/samples/trace_events/Makefile
index b78344e7bbed..e98afc447fe1 100644
--- a/samples/trace_events/Makefile
+++ b/samples/trace_events/Makefile
@@ -13,3 +13,5 @@
 CFLAGS_trace-events-sample.o := -I$(src)
 
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS) += trace-events-sample.o
+
+obj-$(CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS) += trace_custom_sched.o
diff --git a/samples/trace_events/trace_custom_sched.c b/samples/trace_events/trace_custom_sched.c
new file mode 100644
index 000000000000..70a12c32ff99
--- /dev/null
+++ b/samples/trace_events/trace_custom_sched.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * event tracer
+ *
+ * Copyright (C) 2022 Google Inc, Steven Rostedt <rostedt@goodmis.org>
+ */
+
+#define pr_fmt(fmt) fmt
+
+#include <linux/trace_events.h>
+#include <linux/version.h>
+#include <linux/module.h>
+#include <linux/sched.h>
+#include <trace/events/sched.h>
+
+#define THIS_SYSTEM "custom_sched"
+
+#define SCHED_PRINT_FMT							\
+	C("prev_prio=%d next_pid=%d next_prio=%d", REC->prev_prio, REC->next_pid, \
+	  REC->next_prio)
+
+#define SCHED_WAKING_FMT				\
+	C("pid=%d prio=%d", REC->pid, REC->prio)
+
+#undef C
+#define C(a, b...) a, b
+
+static struct trace_event_fields sched_switch_fields[] = {
+	{
+		.type = "unsigned short",
+		.name = "prev_prio",
+		.size = sizeof(short),
+		.align = __alignof__(short),
+		.is_signed = 0,
+		.filter_type = FILTER_OTHER,
+	},
+	{
+		.type = "unsigned short",
+		.name = "next_prio",
+		.size = sizeof(short),
+		.align = __alignof__(short),
+		.is_signed = 0,
+		.filter_type = FILTER_OTHER,
+	},
+	{
+		.type = "unsigned int",
+		.name = "next_prio",
+		.size = sizeof(int),
+		.align = __alignof__(int),
+		.is_signed = 0,
+		.filter_type = FILTER_OTHER,
+	},
+	{}
+};
+
+struct sched_event {
+	struct trace_entry	ent;
+	unsigned short		prev_prio;
+	unsigned short		next_prio;
+	unsigned int		next_pid;
+};
+
+static struct trace_event_fields sched_waking_fields[] = {
+	{
+		.type = "unsigned int",
+		.name = "pid",
+		.size = sizeof(int),
+		.align = __alignof__(int),
+		.is_signed = 0,
+		.filter_type = FILTER_OTHER,
+	},
+	{
+		.type = "unsigned short",
+		.name = "prio",
+		.size = sizeof(short),
+		.align = __alignof__(short),
+		.is_signed = 0,
+		.filter_type = FILTER_OTHER,
+	},
+	{}
+};
+
+struct wake_event {
+	struct trace_entry	ent;
+	unsigned int		pid;
+	unsigned short		prio;
+};
+
+static void sched_switch_probe(void *data, bool preempt, struct task_struct *prev,
+			       struct task_struct *next)
+{
+	struct trace_event_file *trace_file = data;
+	struct trace_event_buffer fbuffer;
+	struct sched_event *entry;
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry));
+
+	if (!entry)
+		return;
+
+	entry->prev_prio = prev->prio;
+	entry->next_prio = next->prio;
+	entry->next_pid = next->pid;
+
+	trace_event_buffer_commit(&fbuffer);
+}
+
+static struct trace_event_class sched_switch_class = {
+	.system			= THIS_SYSTEM,
+	.reg			= trace_event_reg,
+	.fields_array		= sched_switch_fields,
+	.fields			= LIST_HEAD_INIT(sched_switch_class.fields),
+	.probe			= sched_switch_probe,
+};
+
+static void sched_waking_probe(void *data, struct task_struct *t)
+{
+	struct trace_event_file *trace_file = data;
+	struct trace_event_buffer fbuffer;
+	struct wake_event *entry;
+
+	if (trace_trigger_soft_disabled(trace_file))
+		return;
+
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
+					   sizeof(*entry));
+
+	if (!entry)
+		return;
+
+	entry->prio = t->prio;
+	entry->pid = t->pid;
+
+	trace_event_buffer_commit(&fbuffer);
+}
+
+static struct trace_event_class sched_waking_class = {
+	.system			= THIS_SYSTEM,
+	.reg			= trace_event_reg,
+	.fields_array		= sched_waking_fields,
+	.fields			= LIST_HEAD_INIT(sched_waking_class.fields),
+	.probe			= sched_waking_probe,
+};
+
+static enum print_line_t sched_switch_output(struct trace_iterator *iter, int flags,
+					     struct trace_event *trace_event)
+{
+	struct trace_seq *s = &iter->seq;
+	struct sched_event *REC = (struct sched_event *)iter->ent;
+	int ret;
+
+	ret = trace_raw_output_prep(iter, trace_event);
+	if (ret != TRACE_TYPE_HANDLED)
+		return ret;
+
+	trace_seq_printf(s, SCHED_PRINT_FMT);
+	trace_seq_putc(s, '\n');
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions sched_switch_funcs = {
+	.trace			= sched_switch_output,
+};
+
+static enum print_line_t sched_waking_output(struct trace_iterator *iter, int flags,
+					     struct trace_event *trace_event)
+{
+	struct trace_seq *s = &iter->seq;
+	struct wake_event *REC = (struct wake_event *)iter->ent;
+	int ret;
+
+	ret = trace_raw_output_prep(iter, trace_event);
+	if (ret != TRACE_TYPE_HANDLED)
+		return ret;
+
+	trace_seq_printf(s, SCHED_WAKING_FMT);
+	trace_seq_putc(s, '\n');
+
+	return trace_handle_return(s);
+}
+
+static struct trace_event_functions sched_waking_funcs = {
+	.trace			= sched_waking_output,
+};
+
+#undef C
+#define C(a, b...) #a "," __stringify(b)
+
+static struct trace_event_call sched_switch_call = {
+	.class			= &sched_switch_class,
+	.event			= {
+		.funcs			= &sched_switch_funcs,
+	},
+	.print_fmt		= SCHED_PRINT_FMT,
+	.module			= THIS_MODULE,
+	.flags			= TRACE_EVENT_FL_TRACEPOINT,
+};
+
+static struct trace_event_call sched_waking_call = {
+	.class			= &sched_waking_class,
+	.event			= {
+		.funcs			= &sched_waking_funcs,
+	},
+	.print_fmt		= SCHED_WAKING_FMT,
+	.module			= THIS_MODULE,
+	.flags			= TRACE_EVENT_FL_TRACEPOINT,
+};
+
+static void fct(struct tracepoint *tp, void *priv)
+{
+	if (tp->name && strcmp(tp->name, "sched_switch") == 0)
+		sched_switch_call.tp = tp;
+	else if (tp->name && strcmp(tp->name, "sched_waking") == 0)
+		sched_waking_call.tp = tp;
+}
+
+static int add_event(struct trace_event_call *call)
+{
+	int ret;
+
+	ret = register_trace_event(&call->event);
+	if (WARN_ON(!ret))
+		return -ENODEV;
+
+	ret = trace_add_event_call(call);
+	if (WARN_ON(ret))
+		unregister_trace_event(&call->event);
+
+	return ret;
+}
+
+static int __init trace_sched_init(void)
+{
+	int ret;
+
+	check_trace_callback_type_sched_switch(sched_switch_probe);
+	check_trace_callback_type_sched_waking(sched_waking_probe);
+
+	for_each_kernel_tracepoint(fct, NULL);
+
+	ret = add_event(&sched_switch_call);
+	if (ret)
+		return ret;
+
+	ret = add_event(&sched_waking_call);
+	if (ret)
+		trace_remove_event_call(&sched_switch_call);
+
+	return ret;
+}
+
+static void __exit trace_sched_exit(void)
+{
+	trace_set_clr_event(THIS_SYSTEM, "sched_switch", 0);
+	trace_set_clr_event(THIS_SYSTEM, "sched_waking", 0);
+
+	trace_remove_event_call(&sched_switch_call);
+	trace_remove_event_call(&sched_waking_call);
+}
+
+module_init(trace_sched_init);
+module_exit(trace_sched_exit);
+
+MODULE_AUTHOR("Steven Rostedt");
+MODULE_DESCRIPTION("Custom scheduling events");
+MODULE_LICENSE("GPL");
-- 
2.34.1
