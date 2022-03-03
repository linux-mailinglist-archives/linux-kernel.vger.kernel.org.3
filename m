Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 35E1F4CC862
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 22:49:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236696AbiCCVuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 16:50:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236670AbiCCVuK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 16:50:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3386A57179
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 13:49:23 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9FE3BB82552
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 21:49:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5AAC4C340FA;
        Thu,  3 Mar 2022 21:49:20 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nPtK3-00ESFo-A7;
        Thu, 03 Mar 2022 16:49:19 -0500
Message-ID: <20220303214919.152557962@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 16:48:36 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 4/4 v2] tracing: Add TRACE_CUSTOM_EVENT() macro
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

To make it really easy to add custom events from modules, add a
TRACE_CUSTOM_EVENT() macro that acts just like the TRACE_EVENT() macro,
but creates a custom event to an already existing tracepoint.

The trace_custom_sched.[ch] has been updated to use this new macro to show
how simple it is.

Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 include/linux/trace_events.h              |  24 +-
 samples/trace_events/Makefile             |   2 +-
 samples/trace_events/trace_custom_sched.c | 259 ++--------------------
 samples/trace_events/trace_custom_sched.h |  95 ++++++++
 4 files changed, 143 insertions(+), 237 deletions(-)
 create mode 100644 samples/trace_events/trace_custom_sched.h

diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index dcea51fb60e2..6c7ae3c2ba9b 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -315,6 +315,7 @@ enum {
 	TRACE_EVENT_FL_KPROBE_BIT,
 	TRACE_EVENT_FL_UPROBE_BIT,
 	TRACE_EVENT_FL_EPROBE_BIT,
+	TRACE_EVENT_FL_CUSTOM_BIT,
 };
 
 /*
@@ -328,6 +329,9 @@ enum {
  *  KPROBE        - Event is a kprobe
  *  UPROBE        - Event is a uprobe
  *  EPROBE        - Event is an event probe
+ *  CUSTOM        - Event is a custom event (to be attached to an exsiting tracepoint)
+ *                   This is set when the custom event has not been attached
+ *                   to a tracepoint yet, then it is cleared when it is.
  */
 enum {
 	TRACE_EVENT_FL_FILTERED		= (1 << TRACE_EVENT_FL_FILTERED_BIT),
@@ -339,6 +343,7 @@ enum {
 	TRACE_EVENT_FL_KPROBE		= (1 << TRACE_EVENT_FL_KPROBE_BIT),
 	TRACE_EVENT_FL_UPROBE		= (1 << TRACE_EVENT_FL_UPROBE_BIT),
 	TRACE_EVENT_FL_EPROBE		= (1 << TRACE_EVENT_FL_EPROBE_BIT),
+	TRACE_EVENT_FL_CUSTOM		= (1 << TRACE_EVENT_FL_CUSTOM_BIT),
 };
 
 #define TRACE_EVENT_FL_UKPROBE (TRACE_EVENT_FL_KPROBE | TRACE_EVENT_FL_UPROBE)
@@ -440,7 +445,9 @@ static inline bool bpf_prog_array_valid(struct trace_event_call *call)
 static inline const char *
 trace_event_name(struct trace_event_call *call)
 {
-	if (call->flags & TRACE_EVENT_FL_TRACEPOINT)
+	if (call->flags & TRACE_EVENT_FL_CUSTOM)
+		return call->name;
+	else if (call->flags & TRACE_EVENT_FL_TRACEPOINT)
 		return call->tp ? call->tp->name : NULL;
 	else
 		return call->name;
@@ -903,3 +910,18 @@ perf_trace_buf_submit(void *raw_data, int size, int rctx, u16 type,
 #endif
 
 #endif /* _LINUX_TRACE_EVENT_H */
+
+/*
+ * Note: we keep the TRACE_CUSTOM_EVENT outside the include file ifdef protection.
+ *  This is due to the way trace custom events work. If a file includes two
+ *  trace event headers under one "CREATE_CUSTOM_TRACE_EVENTS" the first include
+ *  will override the TRACE_CUSTOM_EVENT and break the second include.
+ */
+
+#ifndef TRACE_CUSTOM_EVENT
+
+#define DECLARE_CUSTOM_EVENT_CLASS(name, proto, args, tstruct, assign, print)
+#define DEFINE_CUSTOM_EVENT(template, name, proto, args)
+#define TRACE_CUSTOM_EVENT(name, proto, args, struct, assign, print)
+
+#endif /* ifdef TRACE_CUSTOM_EVENT (see note above) */
diff --git a/samples/trace_events/Makefile b/samples/trace_events/Makefile
index e98afc447fe1..b3808bb4cf8b 100644
--- a/samples/trace_events/Makefile
+++ b/samples/trace_events/Makefile
@@ -11,7 +11,7 @@
 # Here trace-events-sample.c does the CREATE_TRACE_POINTS.
 #
 CFLAGS_trace-events-sample.o := -I$(src)
+CFLAGS_trace_custom_sched.o := -I$(src)
 
 obj-$(CONFIG_SAMPLE_TRACE_EVENTS) += trace-events-sample.o
-
 obj-$(CONFIG_SAMPLE_TRACE_CUSTOM_EVENTS) += trace_custom_sched.o
diff --git a/samples/trace_events/trace_custom_sched.c b/samples/trace_events/trace_custom_sched.c
index 70a12c32ff99..b99d9ab7db85 100644
--- a/samples/trace_events/trace_custom_sched.c
+++ b/samples/trace_events/trace_custom_sched.c
@@ -11,256 +11,45 @@
 #include <linux/version.h>
 #include <linux/module.h>
 #include <linux/sched.h>
-#include <trace/events/sched.h>
-
-#define THIS_SYSTEM "custom_sched"
-
-#define SCHED_PRINT_FMT							\
-	C("prev_prio=%d next_pid=%d next_prio=%d", REC->prev_prio, REC->next_pid, \
-	  REC->next_prio)
-
-#define SCHED_WAKING_FMT				\
-	C("pid=%d prio=%d", REC->pid, REC->prio)
-
-#undef C
-#define C(a, b...) a, b
-
-static struct trace_event_fields sched_switch_fields[] = {
-	{
-		.type = "unsigned short",
-		.name = "prev_prio",
-		.size = sizeof(short),
-		.align = __alignof__(short),
-		.is_signed = 0,
-		.filter_type = FILTER_OTHER,
-	},
-	{
-		.type = "unsigned short",
-		.name = "next_prio",
-		.size = sizeof(short),
-		.align = __alignof__(short),
-		.is_signed = 0,
-		.filter_type = FILTER_OTHER,
-	},
-	{
-		.type = "unsigned int",
-		.name = "next_prio",
-		.size = sizeof(int),
-		.align = __alignof__(int),
-		.is_signed = 0,
-		.filter_type = FILTER_OTHER,
-	},
-	{}
-};
-
-struct sched_event {
-	struct trace_entry	ent;
-	unsigned short		prev_prio;
-	unsigned short		next_prio;
-	unsigned int		next_pid;
-};
-
-static struct trace_event_fields sched_waking_fields[] = {
-	{
-		.type = "unsigned int",
-		.name = "pid",
-		.size = sizeof(int),
-		.align = __alignof__(int),
-		.is_signed = 0,
-		.filter_type = FILTER_OTHER,
-	},
-	{
-		.type = "unsigned short",
-		.name = "prio",
-		.size = sizeof(short),
-		.align = __alignof__(short),
-		.is_signed = 0,
-		.filter_type = FILTER_OTHER,
-	},
-	{}
-};
-
-struct wake_event {
-	struct trace_entry	ent;
-	unsigned int		pid;
-	unsigned short		prio;
-};
-
-static void sched_switch_probe(void *data, bool preempt, struct task_struct *prev,
-			       struct task_struct *next)
-{
-	struct trace_event_file *trace_file = data;
-	struct trace_event_buffer fbuffer;
-	struct sched_event *entry;
-
-	if (trace_trigger_soft_disabled(trace_file))
-		return;
-
-	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
-					   sizeof(*entry));
-
-	if (!entry)
-		return;
-
-	entry->prev_prio = prev->prio;
-	entry->next_prio = next->prio;
-	entry->next_pid = next->pid;
-
-	trace_event_buffer_commit(&fbuffer);
-}
-
-static struct trace_event_class sched_switch_class = {
-	.system			= THIS_SYSTEM,
-	.reg			= trace_event_reg,
-	.fields_array		= sched_switch_fields,
-	.fields			= LIST_HEAD_INIT(sched_switch_class.fields),
-	.probe			= sched_switch_probe,
-};
-
-static void sched_waking_probe(void *data, struct task_struct *t)
-{
-	struct trace_event_file *trace_file = data;
-	struct trace_event_buffer fbuffer;
-	struct wake_event *entry;
-
-	if (trace_trigger_soft_disabled(trace_file))
-		return;
-
-	entry = trace_event_buffer_reserve(&fbuffer, trace_file,
-					   sizeof(*entry));
-
-	if (!entry)
-		return;
-
-	entry->prio = t->prio;
-	entry->pid = t->pid;
-
-	trace_event_buffer_commit(&fbuffer);
-}
-
-static struct trace_event_class sched_waking_class = {
-	.system			= THIS_SYSTEM,
-	.reg			= trace_event_reg,
-	.fields_array		= sched_waking_fields,
-	.fields			= LIST_HEAD_INIT(sched_waking_class.fields),
-	.probe			= sched_waking_probe,
-};
-
-static enum print_line_t sched_switch_output(struct trace_iterator *iter, int flags,
-					     struct trace_event *trace_event)
-{
-	struct trace_seq *s = &iter->seq;
-	struct sched_event *REC = (struct sched_event *)iter->ent;
-	int ret;
-
-	ret = trace_raw_output_prep(iter, trace_event);
-	if (ret != TRACE_TYPE_HANDLED)
-		return ret;
-
-	trace_seq_printf(s, SCHED_PRINT_FMT);
-	trace_seq_putc(s, '\n');
 
-	return trace_handle_return(s);
-}
-
-static struct trace_event_functions sched_switch_funcs = {
-	.trace			= sched_switch_output,
-};
-
-static enum print_line_t sched_waking_output(struct trace_iterator *iter, int flags,
-					     struct trace_event *trace_event)
-{
-	struct trace_seq *s = &iter->seq;
-	struct wake_event *REC = (struct wake_event *)iter->ent;
-	int ret;
-
-	ret = trace_raw_output_prep(iter, trace_event);
-	if (ret != TRACE_TYPE_HANDLED)
-		return ret;
-
-	trace_seq_printf(s, SCHED_WAKING_FMT);
-	trace_seq_putc(s, '\n');
-
-	return trace_handle_return(s);
-}
-
-static struct trace_event_functions sched_waking_funcs = {
-	.trace			= sched_waking_output,
-};
-
-#undef C
-#define C(a, b...) #a "," __stringify(b)
+/*
+ * Must include the event header that the custom event will attach to,
+ * from the C file, and not in the custom header file.
+ */
+#include <trace/events/sched.h>
 
-static struct trace_event_call sched_switch_call = {
-	.class			= &sched_switch_class,
-	.event			= {
-		.funcs			= &sched_switch_funcs,
-	},
-	.print_fmt		= SCHED_PRINT_FMT,
-	.module			= THIS_MODULE,
-	.flags			= TRACE_EVENT_FL_TRACEPOINT,
-};
+/* Declare CREATE_CUSTOM_TRACE_EVENTS before including custom header */
+#define CREATE_CUSTOM_TRACE_EVENTS
 
-static struct trace_event_call sched_waking_call = {
-	.class			= &sched_waking_class,
-	.event			= {
-		.funcs			= &sched_waking_funcs,
-	},
-	.print_fmt		= SCHED_WAKING_FMT,
-	.module			= THIS_MODULE,
-	.flags			= TRACE_EVENT_FL_TRACEPOINT,
-};
+#include "trace_custom_sched.h"
 
+/*
+ * As the trace events are not exported to modules, the use of
+ * for_each_kernel_tracepoint() is needed to find the trace event
+ * to attach to. The fct() function below, is a callback that
+ * will be called for every event.
+ *
+ * Helper functions are created by the TRACE_CUSTOM_EVENT() macro
+ * update the event. Those are of the form:
+ *
+ *    trace_custom_event_<event>_update()
+ *
+ * Where <event> is the event to attach.
+ */
 static void fct(struct tracepoint *tp, void *priv)
 {
-	if (tp->name && strcmp(tp->name, "sched_switch") == 0)
-		sched_switch_call.tp = tp;
-	else if (tp->name && strcmp(tp->name, "sched_waking") == 0)
-		sched_waking_call.tp = tp;
-}
-
-static int add_event(struct trace_event_call *call)
-{
-	int ret;
-
-	ret = register_trace_event(&call->event);
-	if (WARN_ON(!ret))
-		return -ENODEV;
-
-	ret = trace_add_event_call(call);
-	if (WARN_ON(ret))
-		unregister_trace_event(&call->event);
-
-	return ret;
+	trace_custom_event_sched_switch_update(tp);
+	trace_custom_event_sched_waking_update(tp);
 }
 
 static int __init trace_sched_init(void)
 {
-	int ret;
-
-	check_trace_callback_type_sched_switch(sched_switch_probe);
-	check_trace_callback_type_sched_waking(sched_waking_probe);
-
 	for_each_kernel_tracepoint(fct, NULL);
-
-	ret = add_event(&sched_switch_call);
-	if (ret)
-		return ret;
-
-	ret = add_event(&sched_waking_call);
-	if (ret)
-		trace_remove_event_call(&sched_switch_call);
-
-	return ret;
+	return 0;
 }
 
 static void __exit trace_sched_exit(void)
 {
-	trace_set_clr_event(THIS_SYSTEM, "sched_switch", 0);
-	trace_set_clr_event(THIS_SYSTEM, "sched_waking", 0);
-
-	trace_remove_event_call(&sched_switch_call);
-	trace_remove_event_call(&sched_waking_call);
 }
 
 module_init(trace_sched_init);
diff --git a/samples/trace_events/trace_custom_sched.h b/samples/trace_events/trace_custom_sched.h
new file mode 100644
index 000000000000..a3d14de6a2e5
--- /dev/null
+++ b/samples/trace_events/trace_custom_sched.h
@@ -0,0 +1,95 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+/*
+ * Like the headers that use TRACE_EVENT(), the TRACE_CUSTOM_EVENT()
+ * needs a header that allows for multiple inclusions.
+ *
+ * Test for a unique name (here we have _TRACE_CUSTOM_SCHED_H),
+ * also allowing to continue if TRACE_CUSTOM_MULTI_READ is defined.
+ */
+#if !defined(_TRACE_CUSTOM_SCHED_H) || defined(TRACE_CUSTOM_MULTI_READ)
+#define _TRACE_CUSTOM_SCHED_H
+
+/* Include linux/trace_events.h for initial defines of TRACE_CUSTOM_EVENT() */
+#include <linux/trace_events.h>
+
+/*
+ * TRACE_CUSTOM_EVENT() is just like TRACE_EVENT(). The first parameter
+ * is the event name of an existing event where the TRACE_EVENT has been included
+ * in the C file before including this file.
+ */
+TRACE_CUSTOM_EVENT(sched_switch,
+
+	/*
+	 * The TP_PROTO() and TP_ARGS must match the trace event
+	 * that the custom event is using.
+	 */
+	TP_PROTO(bool preempt,
+		 struct task_struct *prev,
+		 struct task_struct *next),
+
+	TP_ARGS(preempt, prev, next),
+
+	/*
+	 * The next fields are where the customization happens.
+	 * The TP_STRUCT__entry() defines what will be recorded
+	 * in the ring buffer when the custom event triggers.
+	 *
+	 * The rest is just like the TRACE_EVENT() macro except that
+	 * it uses the custom entry.
+	 */
+	TP_STRUCT__entry(
+		__field(	unsigned short,		prev_prio	)
+		__field(	unsigned short,		next_prio	)
+		__field(	pid_t,	next_pid			)
+	),
+
+	TP_fast_assign(
+		__entry->prev_prio	= prev->prio;
+		__entry->next_pid	= next->pid;
+		__entry->next_prio	= next->prio;
+	),
+
+	TP_printk("prev_prio=%d next_pid=%d next_prio=%d",
+		  __entry->prev_prio, __entry->next_pid, __entry->next_prio)
+)
+
+
+TRACE_CUSTOM_EVENT(sched_waking,
+
+	TP_PROTO(struct task_struct *p),
+
+	TP_ARGS(p),
+
+	TP_STRUCT__entry(
+		__field(	pid_t,			pid	)
+		__field(	unsigned short,		prio	)
+	),
+
+	TP_fast_assign(
+		__entry->pid	= p->pid;
+		__entry->prio	= p->prio;
+	),
+
+	TP_printk("pid=%d prio=%d", __entry->pid, __entry->prio)
+)
+#endif
+/*
+ * Just like the headers that create TRACE_EVENTs, the below must
+ * be outside the protection of the above #if block.
+ */
+
+/*
+ * It is required that the Makefile includes:
+ *    CFLAGS_<c_file>.o := -I$(src)
+ */
+#undef TRACE_INCLUDE_PATH
+#undef TRACE_INCLUDE_FILE
+#define TRACE_INCLUDE_PATH .
+
+/*
+ * It is requred that the TRACE_INCLUDE_FILE be the same
+ * as this file without the ".h".
+ */
+#define TRACE_INCLUDE_FILE trace_custom_sched
+#include <trace/define_custom_trace.h>
-- 
2.34.1
