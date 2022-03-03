Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6671D4CC890
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Mar 2022 23:06:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236761AbiCCWH3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Mar 2022 17:07:29 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51722 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236755AbiCCWHR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Mar 2022 17:07:17 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BBA0F16F95E
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 14:06:29 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 4AF03B826FB
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:06:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CDCCFC34101;
        Thu,  3 Mar 2022 22:06:26 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.95)
        (envelope-from <rostedt@goodmis.org>)
        id 1nPtab-00ESY0-T3;
        Thu, 03 Mar 2022 17:06:25 -0500
Message-ID: <20220303220625.738622494@goodmis.org>
User-Agent: quilt/0.66
Date:   Thu, 03 Mar 2022 17:05:34 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Joel Fernandes <joel@joelfernandes.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Masami Hiramatsu <mhiramat@kernel.org>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [PATCH 4/4 v3] tracing: Add TRACE_CUSTOM_EVENT() macro
References: <20220303220530.058538533@goodmis.org>
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
 include/trace/define_custom_trace.h       |  77 +++++++
 include/trace/trace_custom_events.h       | 221 ++++++++++++++++++
 samples/trace_events/Makefile             |   2 +-
 samples/trace_events/trace_custom_sched.c | 259 ++--------------------
 samples/trace_events/trace_custom_sched.h |  95 ++++++++
 6 files changed, 441 insertions(+), 237 deletions(-)
 create mode 100644 include/trace/define_custom_trace.h
 create mode 100644 include/trace/trace_custom_events.h
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
diff --git a/include/trace/define_custom_trace.h b/include/trace/define_custom_trace.h
new file mode 100644
index 000000000000..5827a4c92c74
--- /dev/null
+++ b/include/trace/define_custom_trace.h
@@ -0,0 +1,77 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Trace files that want to automate creation of all tracepoints defined
+ * in their file should include this file. The following are macros that the
+ * trace file may define:
+ *
+ * TRACE_SYSTEM defines the system the tracepoint is for
+ *
+ * TRACE_INCLUDE_FILE if the file name is something other than TRACE_SYSTEM.h
+ *     This macro may be defined to tell define_trace.h what file to include.
+ *     Note, leave off the ".h".
+ *
+ * TRACE_INCLUDE_PATH if the path is something other than core kernel include/trace
+ *     then this macro can define the path to use. Note, the path is relative to
+ *     define_trace.h, not the file including it. Full path names for out of tree
+ *     modules must be used.
+ */
+
+#ifdef CREATE_CUSTOM_TRACE_EVENTS
+
+/* Prevent recursion */
+#undef CREATE_CUSTOM_TRACE_EVENTS
+
+#include <linux/stringify.h>
+
+#undef TRACE_CUSTOM_EVENT
+#define TRACE_CUSTOM_EVENT(name, proto, args, tstruct, assign, print)
+
+#undef DEFINE_CUSTOM_EVENT
+#define DEFINE_CUSTOM_EVENT(template, name, proto, args)
+
+#undef TRACE_INCLUDE
+#undef __TRACE_INCLUDE
+
+#ifndef TRACE_INCLUDE_FILE
+# define TRACE_INCLUDE_FILE TRACE_SYSTEM
+# define UNDEF_TRACE_INCLUDE_FILE
+#endif
+
+#ifndef TRACE_INCLUDE_PATH
+# define __TRACE_INCLUDE(system) <trace/events/system.h>
+# define UNDEF_TRACE_INCLUDE_PATH
+#else
+# define __TRACE_INCLUDE(system) __stringify(TRACE_INCLUDE_PATH/system.h)
+#endif
+
+# define TRACE_INCLUDE(system) __TRACE_INCLUDE(system)
+
+/* Let the trace headers be reread */
+#define TRACE_CUSTOM_MULTI_READ
+
+#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
+
+#ifdef TRACEPOINTS_ENABLED
+#include <trace/trace_custom_events.h>
+#endif
+
+#undef TRACE_CUSTOM_EVENT
+#undef DECLARE_CUSTOM_EVENT_CLASS
+#undef DEFINE_CUSTOM_EVENT
+#undef TRACE_CUSTOM_MULTI_READ
+
+/* Only undef what we defined in this file */
+#ifdef UNDEF_TRACE_INCLUDE_FILE
+# undef TRACE_INCLUDE_FILE
+# undef UNDEF_TRACE_INCLUDE_FILE
+#endif
+
+#ifdef UNDEF_TRACE_INCLUDE_PATH
+# undef TRACE_INCLUDE_PATH
+# undef UNDEF_TRACE_INCLUDE_PATH
+#endif
+
+/* We may be processing more files */
+#define CREATE_CUSTOM_TRACE_POINTS
+
+#endif /* CREATE_CUSTOM_TRACE_POINTS */
diff --git a/include/trace/trace_custom_events.h b/include/trace/trace_custom_events.h
new file mode 100644
index 000000000000..b567c7202339
--- /dev/null
+++ b/include/trace/trace_custom_events.h
@@ -0,0 +1,221 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * This is similar to the trace_events.h file, but is to only
+ * create custom trace events to be attached to existing tracepoints.
+ * Where as the TRACE_EVENT() macro (from trace_events.h) will create
+ * both the trace event and the tracepoint it will attach the event to,
+ * TRACE_CUSTOM_EVENT() is to create only a custom version of an existing
+ * trace event (created by TRACE_EVENT() or DEFINE_EVENT()), and will
+ * be placed in the "custom" system.
+ */
+
+#include <linux/trace_events.h>
+
+/* All custom events are placed in the custom group */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM custom
+
+#ifndef TRACE_SYSTEM_VAR
+#define TRACE_SYSTEM_VAR TRACE_SYSTEM
+#endif
+
+/* The init stage creates the system string and enum mappings */
+
+#include "stages/init.h"
+
+#undef TRACE_CUSTOM_EVENT
+#define TRACE_CUSTOM_EVENT(name, proto, args, tstruct, assign, print) \
+	DECLARE_CUSTOM_EVENT_CLASS(name,			      \
+			     PARAMS(proto),		       \
+			     PARAMS(args),		       \
+			     PARAMS(tstruct),		       \
+			     PARAMS(assign),		       \
+			     PARAMS(print));		       \
+	DEFINE_CUSTOM_EVENT(name, name, PARAMS(proto), PARAMS(args));
+
+/* Stage 1 creates the structure of the recorded event layout */
+
+#include "stages/stage1_defines.h"
+
+#undef DECLARE_CUSTOM_EVENT_CLASS
+#define DECLARE_CUSTOM_EVENT_CLASS(name, proto, args, tstruct, assign, print) \
+	struct trace_custom_event_raw_##name {				\
+		struct trace_entry	ent;				\
+		tstruct							\
+		char			__data[];			\
+	};								\
+									\
+	static struct trace_event_class custom_event_class_##name;
+
+#undef DEFINE_CUSTOM_EVENT
+#define DEFINE_CUSTOM_EVENT(template, name, proto, args)	\
+	static struct trace_event_call	__used			\
+	__attribute__((__aligned__(4))) custom_event_##name
+
+#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
+
+/* Stage 2 creates the custom class */
+
+#include "stages/stage2_defines.h"
+
+#undef DECLARE_CUSTOM_EVENT_CLASS
+#define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print)	\
+	struct trace_custom_event_data_offsets_##call {			\
+		tstruct;						\
+	};
+
+#undef DEFINE_CUSTOM_EVENT
+#define DEFINE_CUSTOM_EVENT(template, name, proto, args)
+
+#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
+
+/* Stage 3 create the way to print the custom event */
+
+#include "stages/stage3_defines.h"
+
+#undef DECLARE_CUSTOM_EVENT_CLASS
+#define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
+static notrace enum print_line_t					\
+trace_custom_raw_output_##call(struct trace_iterator *iter, int flags,	\
+			struct trace_event *trace_event)		\
+{									\
+	struct trace_seq *s = &iter->seq;				\
+	struct trace_seq __maybe_unused *p = &iter->tmp_seq;		\
+	struct trace_custom_event_raw_##call *field;			\
+	int ret;							\
+									\
+	field = (typeof(field))iter->ent;				\
+									\
+	ret = trace_raw_output_prep(iter, trace_event);			\
+	if (ret != TRACE_TYPE_HANDLED)					\
+		return ret;						\
+									\
+	trace_event_printf(iter, print);				\
+									\
+	return trace_handle_return(s);					\
+}									\
+static struct trace_event_functions trace_custom_event_type_funcs_##call = { \
+	.trace			= trace_custom_raw_output_##call,	\
+};
+
+#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
+
+/* Stage 4 creates the offset layout for the fields */
+
+#include "stages/stage4_defines.h"
+
+#undef DECLARE_CUSTOM_EVENT_CLASS
+#define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, func, print)	\
+static struct trace_event_fields trace_custom_event_fields_##call[] = {	\
+	tstruct								\
+	{} };
+
+#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
+
+/* Stage 5 creates the helper function for dynamic fields */
+
+#include "stages/stage5_defines.h"
+
+#undef DECLARE_CUSTOM_EVENT_CLASS
+#define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
+static inline notrace int trace_custom_event_get_offsets_##call(	\
+	struct trace_custom_event_data_offsets_##call *__data_offsets, proto) \
+{									\
+	int __data_size = 0;						\
+	int __maybe_unused __item_length;				\
+	struct trace_custom_event_raw_##call __maybe_unused *entry;	\
+									\
+	tstruct;							\
+									\
+	return __data_size;						\
+}
+
+#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
+
+/* Stage 6 creates the probe function that records the event */
+
+#include "stages/stage6_defines.h"
+
+#undef DECLARE_CUSTOM_EVENT_CLASS
+#define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
+									\
+static notrace void							\
+trace_custom_event_raw_event_##call(void *__data, proto)		\
+{									\
+	struct trace_event_file *trace_file = __data;			\
+	struct trace_custom_event_data_offsets_##call __maybe_unused __data_offsets; \
+	struct trace_event_buffer fbuffer;				\
+	struct trace_custom_event_raw_##call *entry;			\
+	int __data_size;						\
+									\
+	if (trace_trigger_soft_disabled(trace_file))			\
+		return;							\
+									\
+	__data_size = trace_custom_event_get_offsets_##call(&__data_offsets, args); \
+									\
+	entry = trace_event_buffer_reserve(&fbuffer, trace_file,	\
+				 sizeof(*entry) + __data_size);		\
+									\
+	if (!entry)							\
+		return;							\
+									\
+	tstruct								\
+									\
+	{ assign; }							\
+									\
+	trace_event_buffer_commit(&fbuffer);				\
+}
+/*
+ * The ftrace_test_custom_probe is compiled out, it is only here as a build time check
+ * to make sure that if the tracepoint handling changes, the ftrace probe will
+ * fail to compile unless it too is updated.
+ */
+
+#undef DEFINE_CUSTOM_EVENT
+#define DEFINE_CUSTOM_EVENT(template, call, proto, args)		\
+static inline void ftrace_test_custom_probe_##call(void)		\
+{									\
+	check_trace_callback_type_##call(trace_custom_event_raw_event_##template); \
+}
+
+#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
+
+/* Stage 7 creates the actual class and event structure for the custom event */
+
+#include "stages/stage7_defines.h"
+
+#undef DECLARE_CUSTOM_EVENT_CLASS
+#define DECLARE_CUSTOM_EVENT_CLASS(call, proto, args, tstruct, assign, print) \
+static char custom_print_fmt_##call[] = print;					\
+static struct trace_event_class __used __refdata custom_event_class_##call = { \
+	.system			= TRACE_SYSTEM_STRING,			\
+	.fields_array		= trace_custom_event_fields_##call,		\
+	.fields			= LIST_HEAD_INIT(custom_event_class_##call.fields),\
+	.raw_init		= trace_event_raw_init,			\
+	.probe			= trace_custom_event_raw_event_##call,	\
+	.reg			= trace_event_reg,			\
+};
+
+#undef DEFINE_CUSTOM_EVENT
+#define DEFINE_CUSTOM_EVENT(template, call, proto, args)		\
+									\
+static struct trace_event_call __used custom_event_##call = {		\
+	.name			= #call,				\
+	.class			= &custom_event_class_##template,	\
+	.event.funcs		= &trace_custom_event_type_funcs_##template, \
+	.print_fmt		= custom_print_fmt_##template,		\
+	.flags			= TRACE_EVENT_FL_CUSTOM,		\
+};									\
+static inline int trace_custom_event_##call##_update(struct tracepoint *tp) \
+{									\
+	if (tp->name && strcmp(tp->name, #call) == 0) {			\
+		custom_event_##call.tp = tp;				\
+		custom_event_##call.flags = TRACE_EVENT_FL_TRACEPOINT;	\
+		return 1;						\
+	}								\
+	return 0;							\
+}									\
+static struct trace_event_call __used					\
+__section("_ftrace_events") *__custom_event_##call = &custom_event_##call
+
+#include TRACE_INCLUDE(TRACE_INCLUDE_FILE)
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
