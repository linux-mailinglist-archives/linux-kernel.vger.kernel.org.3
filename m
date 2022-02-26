Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8193B4C5684
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 15:50:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232069AbiBZOuq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 09:50:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41848 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiBZOuo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 09:50:44 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F0FAE18623B
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 06:50:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8BB3860500
        for <linux-kernel@vger.kernel.org>; Sat, 26 Feb 2022 14:50:07 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9B80CC340E8;
        Sat, 26 Feb 2022 14:50:05 +0000 (UTC)
Date:   Sat, 26 Feb 2022 09:50:04 -0500
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Linus Torvalds <torvalds@linux-foundation.org>,
        Al Viro <viro@ZenIV.linux.org.uk>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Arnaldo Carvalho de Melo <acme@kernel.org>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Daniel Bristot de Oliveira <bristot@kernel.org>,
        Nathan Chancellor <nathan@kernel.org>,
        Sven Schnelle <svens@linux.ibm.com>,
        Tom Zanussi <zanussi@kernel.org>
Subject: [GIT PULL] tracing: Updates for 5.17-rc
Message-ID: <20220226095004.298c6092@rorschach.local.home>
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

Tracing fixes for 5.17:

 - rtla (Real-Time Linux Analysis tool): fix typo in man page

 - rtla: Update API -e to -E before it is released

 - rlla: Error message fix and memory leak fix

 - Partially uninline trace event soft disable to shrink text

 - Fix function graph start up test

 - Have triggers affect the trace instance they are in and not top level

 - Have osnoise sleep in the units it says it uses

 - Remove unused ftrace stub function

 - Remove event probe redundant info from event in the buffer

 - Fix group ownership setting in tracefs

 - Ensure trace buffer is minimum size to prevent crashes


Please pull the latest trace-v5.17-rc4 tree, which can be found at:


  git://git.kernel.org/pub/scm/linux/kernel/git/rostedt/linux-trace.git
trace-v5.17-rc4

Tag SHA1: 4f1ef6a81c5f9a41c3793cda55669e7740b9cf02
Head SHA1: 90f59ee41abf587ad4675a70434136c8707fdf4b


Arnaldo Carvalho de Melo (1):
      rtla: Fix systme -> system typo on man page

Christophe Leroy (2):
      tracing: Uninline trace_trigger_soft_disabled() partly
      tracing: Fix selftest config check for function graph start up test

Daniel Bristot de Oliveira (5):
      tracing: Dump stacktrace trigger to the corresponding instance
      tracing/osnoise: Make osnoise_main to sleep for microseconds
      rtla/hist: Make -E the short version of --entries
      rtla/osnoise: Free params at the exit
      rtla/osnoise: Fix error message when failing to enable trace instance

Nathan Chancellor (1):
      ftrace: Remove unused ftrace_startup_enable() stub

Steven Rostedt (Google) (3):
      tracing: Have traceon and traceoff trigger honor the instance
      eprobes: Remove redundant event type information
      tracefs: Set the group ownership in apply_options() not parse_options()

Sven Schnelle (1):
      tracing: Ensure trace buffer is at least 4096 bytes large

----
 Documentation/tools/rtla/common_hist_options.rst   |  2 +-
 .../tools/rtla/common_osnoise_description.rst      |  2 +-
 Documentation/tools/rtla/rtla-osnoise-hist.rst     |  2 +-
 fs/tracefs/inode.c                                 |  5 +-
 include/linux/trace_events.h                       | 22 ++++---
 kernel/trace/ftrace.c                              |  1 -
 kernel/trace/trace.c                               | 10 +--
 kernel/trace/trace.h                               |  1 -
 kernel/trace/trace_eprobe.c                        | 16 +++--
 kernel/trace/trace_events_trigger.c                | 73 +++++++++++++++++++---
 kernel/trace/trace_osnoise.c                       | 53 +++++++++-------
 kernel/trace/trace_probe.c                         | 10 +--
 kernel/trace/trace_probe.h                         |  1 -
 kernel/trace/trace_selftest.c                      |  6 +-
 tools/tracing/rtla/src/osnoise.c                   |  2 +-
 tools/tracing/rtla/src/osnoise_hist.c              | 10 +--
 tools/tracing/rtla/src/osnoise_top.c               |  1 +
 tools/tracing/rtla/src/timerlat_hist.c             | 10 +--
 18 files changed, 148 insertions(+), 79 deletions(-)
---------------------------
diff --git a/Documentation/tools/rtla/common_hist_options.rst b/Documentation/tools/rtla/common_hist_options.rst
index 0266cd08a6c9..df53ff835bfb 100644
--- a/Documentation/tools/rtla/common_hist_options.rst
+++ b/Documentation/tools/rtla/common_hist_options.rst
@@ -2,7 +2,7 @@
 
         Set the histogram bucket size (default *1*).
 
-**-e**, **--entries** *N*
+**-E**, **--entries** *N*
 
         Set the number of entries of the histogram (default 256).
 
diff --git a/Documentation/tools/rtla/common_osnoise_description.rst b/Documentation/tools/rtla/common_osnoise_description.rst
index 8973c5df888f..d5d61615b967 100644
--- a/Documentation/tools/rtla/common_osnoise_description.rst
+++ b/Documentation/tools/rtla/common_osnoise_description.rst
@@ -1,7 +1,7 @@
 The **rtla osnoise** tool is an interface for the *osnoise* tracer. The
 *osnoise* tracer dispatches a kernel thread per-cpu. These threads read the
 time in a loop while with preemption, softirq and IRQs enabled, thus
-allowing all the sources of operating systme noise during its execution.
+allowing all the sources of operating system noise during its execution.
 The *osnoise*'s tracer threads take note of the delta between each time
 read, along with an interference counter of all sources of interference.
 At the end of each period, the *osnoise* tracer displays a summary of
diff --git a/Documentation/tools/rtla/rtla-osnoise-hist.rst b/Documentation/tools/rtla/rtla-osnoise-hist.rst
index 52298ddd8701..f2e79d22c4c4 100644
--- a/Documentation/tools/rtla/rtla-osnoise-hist.rst
+++ b/Documentation/tools/rtla/rtla-osnoise-hist.rst
@@ -36,7 +36,7 @@ default). The reason for reducing the runtime is to avoid starving the
 **rtla** tool. The tool is also set to run for *one minute*. The output
 histogram is set to group outputs in buckets of *10us* and *25* entries::
 
-  [root@f34 ~/]# rtla osnoise hist -P F:1 -c 0-11 -r 900000 -d 1M -b 10 -e 25
+  [root@f34 ~/]# rtla osnoise hist -P F:1 -c 0-11 -r 900000 -d 1M -b 10 -E 25
   # RTLA osnoise histogram
   # Time unit is microseconds (us)
   # Duration:   0 00:01:00
diff --git a/fs/tracefs/inode.c b/fs/tracefs/inode.c
index bafc02bf8220..de7252715b12 100644
--- a/fs/tracefs/inode.c
+++ b/fs/tracefs/inode.c
@@ -264,7 +264,6 @@ static int tracefs_parse_options(char *data, struct tracefs_mount_opts *opts)
 			if (!gid_valid(gid))
 				return -EINVAL;
 			opts->gid = gid;
-			set_gid(tracefs_mount->mnt_root, gid);
 			break;
 		case Opt_mode:
 			if (match_octal(&args[0], &option))
@@ -291,7 +290,9 @@ static int tracefs_apply_options(struct super_block *sb)
 	inode->i_mode |= opts->mode;
 
 	inode->i_uid = opts->uid;
-	inode->i_gid = opts->gid;
+
+	/* Set all the group ids to the mount option */
+	set_gid(sb->s_root, opts->gid);
 
 	return 0;
 }
diff --git a/include/linux/trace_events.h b/include/linux/trace_events.h
index 70c069aef02c..dcea51fb60e2 100644
--- a/include/linux/trace_events.h
+++ b/include/linux/trace_events.h
@@ -699,6 +699,8 @@ event_triggers_post_call(struct trace_event_file *file,
 
 bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
 
+bool __trace_trigger_soft_disabled(struct trace_event_file *file);
+
 /**
  * trace_trigger_soft_disabled - do triggers and test if soft disabled
  * @file: The file pointer of the event to test
@@ -708,20 +710,20 @@ bool trace_event_ignore_this_pid(struct trace_event_file *trace_file);
  * triggers that require testing the fields, it will return true,
  * otherwise false.
  */
-static inline bool
+static __always_inline bool
 trace_trigger_soft_disabled(struct trace_event_file *file)
 {
 	unsigned long eflags = file->flags;
 
-	if (!(eflags & EVENT_FILE_FL_TRIGGER_COND)) {
-		if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
-			event_triggers_call(file, NULL, NULL, NULL);
-		if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
-			return true;
-		if (eflags & EVENT_FILE_FL_PID_FILTER)
-			return trace_event_ignore_this_pid(file);
-	}
-	return false;
+	if (likely(!(eflags & (EVENT_FILE_FL_TRIGGER_MODE |
+			       EVENT_FILE_FL_SOFT_DISABLED |
+			       EVENT_FILE_FL_PID_FILTER))))
+		return false;
+
+	if (likely(eflags & EVENT_FILE_FL_TRIGGER_COND))
+		return false;
+
+	return __trace_trigger_soft_disabled(file);
 }
 
 #ifdef CONFIG_BPF_EVENTS
diff --git a/kernel/trace/ftrace.c b/kernel/trace/ftrace.c
index f9feb197b2da..a4b462b6f944 100644
--- a/kernel/trace/ftrace.c
+++ b/kernel/trace/ftrace.c
@@ -7191,7 +7191,6 @@ static int __init ftrace_nodyn_init(void)
 core_initcall(ftrace_nodyn_init);
 
 static inline int ftrace_init_dyn_tracefs(struct dentry *d_tracer) { return 0; }
-static inline void ftrace_startup_enable(int command) { }
 static inline void ftrace_startup_all(int command) { }
 
 # define ftrace_startup_sysctl()	do { } while (0)
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index 7c2578efde26..3050892d1812 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -1474,10 +1474,12 @@ static int __init set_buf_size(char *str)
 	if (!str)
 		return 0;
 	buf_size = memparse(str, &str);
-	/* nr_entries can not be zero */
-	if (buf_size == 0)
-		return 0;
-	trace_buf_size = buf_size;
+	/*
+	 * nr_entries can not be zero and the startup
+	 * tests require some buffer space. Therefore
+	 * ensure we have at least 4096 bytes of buffer.
+	 */
+	trace_buf_size = max(4096UL, buf_size);
 	return 1;
 }
 __setup("trace_buf_size=", set_buf_size);
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index d038ddbf1bea..c5b09c31e077 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -136,7 +136,6 @@ struct kprobe_trace_entry_head {
 
 struct eprobe_trace_entry_head {
 	struct trace_entry	ent;
-	unsigned int		type;
 };
 
 struct kretprobe_trace_entry_head {
diff --git a/kernel/trace/trace_eprobe.c b/kernel/trace/trace_eprobe.c
index 191db32dec46..541aa13581b9 100644
--- a/kernel/trace/trace_eprobe.c
+++ b/kernel/trace/trace_eprobe.c
@@ -242,7 +242,6 @@ static int trace_eprobe_tp_arg_update(struct trace_eprobe *ep, int i)
 
 static int eprobe_event_define_fields(struct trace_event_call *event_call)
 {
-	int ret;
 	struct eprobe_trace_entry_head field;
 	struct trace_probe *tp;
 
@@ -250,8 +249,6 @@ static int eprobe_event_define_fields(struct trace_event_call *event_call)
 	if (WARN_ON_ONCE(!tp))
 		return -ENOENT;
 
-	DEFINE_FIELD(unsigned int, type, FIELD_STRING_TYPE, 0);
-
 	return traceprobe_define_arg_fields(event_call, sizeof(field), tp);
 }
 
@@ -270,7 +267,9 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
 	struct trace_event_call *pevent;
 	struct trace_event *probed_event;
 	struct trace_seq *s = &iter->seq;
+	struct trace_eprobe *ep;
 	struct trace_probe *tp;
+	unsigned int type;
 
 	field = (struct eprobe_trace_entry_head *)iter->ent;
 	tp = trace_probe_primary_from_call(
@@ -278,15 +277,18 @@ print_eprobe_event(struct trace_iterator *iter, int flags,
 	if (WARN_ON_ONCE(!tp))
 		goto out;
 
+	ep = container_of(tp, struct trace_eprobe, tp);
+	type = ep->event->event.type;
+
 	trace_seq_printf(s, "%s: (", trace_probe_name(tp));
 
-	probed_event = ftrace_find_event(field->type);
+	probed_event = ftrace_find_event(type);
 	if (probed_event) {
 		pevent = container_of(probed_event, struct trace_event_call, event);
 		trace_seq_printf(s, "%s.%s", pevent->class->system,
 				 trace_event_name(pevent));
 	} else {
-		trace_seq_printf(s, "%u", field->type);
+		trace_seq_printf(s, "%u", type);
 	}
 
 	trace_seq_putc(s, ')');
@@ -498,10 +500,6 @@ __eprobe_trace_func(struct eprobe_data *edata, void *rec)
 		return;
 
 	entry = fbuffer.entry = ring_buffer_event_data(fbuffer.event);
-	if (edata->ep->event)
-		entry->type = edata->ep->event->event.type;
-	else
-		entry->type = 0;
 	store_trace_args(&entry[1], &edata->ep->tp, rec, sizeof(*entry), dsize);
 
 	trace_event_buffer_commit(&fbuffer);
diff --git a/kernel/trace/trace_events_trigger.c b/kernel/trace/trace_events_trigger.c
index d00fee705f9c..7eb9d04f1c2e 100644
--- a/kernel/trace/trace_events_trigger.c
+++ b/kernel/trace/trace_events_trigger.c
@@ -84,6 +84,20 @@ event_triggers_call(struct trace_event_file *file,
 }
 EXPORT_SYMBOL_GPL(event_triggers_call);
 
+bool __trace_trigger_soft_disabled(struct trace_event_file *file)
+{
+	unsigned long eflags = file->flags;
+
+	if (eflags & EVENT_FILE_FL_TRIGGER_MODE)
+		event_triggers_call(file, NULL, NULL, NULL);
+	if (eflags & EVENT_FILE_FL_SOFT_DISABLED)
+		return true;
+	if (eflags & EVENT_FILE_FL_PID_FILTER)
+		return trace_event_ignore_this_pid(file);
+	return false;
+}
+EXPORT_SYMBOL_GPL(__trace_trigger_soft_disabled);
+
 /**
  * event_triggers_post_call - Call 'post_triggers' for a trace event
  * @file: The trace_event_file associated with the event
@@ -1295,6 +1309,16 @@ traceon_trigger(struct event_trigger_data *data,
 		struct trace_buffer *buffer, void *rec,
 		struct ring_buffer_event *event)
 {
+	struct trace_event_file *file = data->private_data;
+
+	if (file) {
+		if (tracer_tracing_is_on(file->tr))
+			return;
+
+		tracer_tracing_on(file->tr);
+		return;
+	}
+
 	if (tracing_is_on())
 		return;
 
@@ -1306,8 +1330,15 @@ traceon_count_trigger(struct event_trigger_data *data,
 		      struct trace_buffer *buffer, void *rec,
 		      struct ring_buffer_event *event)
 {
-	if (tracing_is_on())
-		return;
+	struct trace_event_file *file = data->private_data;
+
+	if (file) {
+		if (tracer_tracing_is_on(file->tr))
+			return;
+	} else {
+		if (tracing_is_on())
+			return;
+	}
 
 	if (!data->count)
 		return;
@@ -1315,7 +1346,10 @@ traceon_count_trigger(struct event_trigger_data *data,
 	if (data->count != -1)
 		(data->count)--;
 
-	tracing_on();
+	if (file)
+		tracer_tracing_on(file->tr);
+	else
+		tracing_on();
 }
 
 static void
@@ -1323,6 +1357,16 @@ traceoff_trigger(struct event_trigger_data *data,
 		 struct trace_buffer *buffer, void *rec,
 		 struct ring_buffer_event *event)
 {
+	struct trace_event_file *file = data->private_data;
+
+	if (file) {
+		if (!tracer_tracing_is_on(file->tr))
+			return;
+
+		tracer_tracing_off(file->tr);
+		return;
+	}
+
 	if (!tracing_is_on())
 		return;
 
@@ -1334,8 +1378,15 @@ traceoff_count_trigger(struct event_trigger_data *data,
 		       struct trace_buffer *buffer, void *rec,
 		       struct ring_buffer_event *event)
 {
-	if (!tracing_is_on())
-		return;
+	struct trace_event_file *file = data->private_data;
+
+	if (file) {
+		if (!tracer_tracing_is_on(file->tr))
+			return;
+	} else {
+		if (!tracing_is_on())
+			return;
+	}
 
 	if (!data->count)
 		return;
@@ -1343,7 +1394,10 @@ traceoff_count_trigger(struct event_trigger_data *data,
 	if (data->count != -1)
 		(data->count)--;
 
-	tracing_off();
+	if (file)
+		tracer_tracing_off(file->tr);
+	else
+		tracing_off();
 }
 
 static int
@@ -1540,7 +1594,12 @@ stacktrace_trigger(struct event_trigger_data *data,
 		   struct trace_buffer *buffer,  void *rec,
 		   struct ring_buffer_event *event)
 {
-	trace_dump_stack(STACK_SKIP);
+	struct trace_event_file *file = data->private_data;
+
+	if (file)
+		__trace_stack(file->tr, tracing_gen_ctx(), STACK_SKIP);
+	else
+		trace_dump_stack(STACK_SKIP);
 }
 
 static void
diff --git a/kernel/trace/trace_osnoise.c b/kernel/trace/trace_osnoise.c
index 870a08da5b48..cfddb30e65ab 100644
--- a/kernel/trace/trace_osnoise.c
+++ b/kernel/trace/trace_osnoise.c
@@ -1436,6 +1436,37 @@ static int run_osnoise(void)
 static struct cpumask osnoise_cpumask;
 static struct cpumask save_cpumask;
 
+/*
+ * osnoise_sleep - sleep until the next period
+ */
+static void osnoise_sleep(void)
+{
+	u64 interval;
+	ktime_t wake_time;
+
+	mutex_lock(&interface_lock);
+	interval = osnoise_data.sample_period - osnoise_data.sample_runtime;
+	mutex_unlock(&interface_lock);
+
+	/*
+	 * differently from hwlat_detector, the osnoise tracer can run
+	 * without a pause because preemption is on.
+	 */
+	if (!interval) {
+		/* Let synchronize_rcu_tasks() make progress */
+		cond_resched_tasks_rcu_qs();
+		return;
+	}
+
+	wake_time = ktime_add_us(ktime_get(), interval);
+	__set_current_state(TASK_INTERRUPTIBLE);
+
+	while (schedule_hrtimeout_range(&wake_time, 0, HRTIMER_MODE_ABS)) {
+		if (kthread_should_stop())
+			break;
+	}
+}
+
 /*
  * osnoise_main - The osnoise detection kernel thread
  *
@@ -1444,30 +1475,10 @@ static struct cpumask save_cpumask;
  */
 static int osnoise_main(void *data)
 {
-	u64 interval;
 
 	while (!kthread_should_stop()) {
-
 		run_osnoise();
-
-		mutex_lock(&interface_lock);
-		interval = osnoise_data.sample_period - osnoise_data.sample_runtime;
-		mutex_unlock(&interface_lock);
-
-		do_div(interval, USEC_PER_MSEC);
-
-		/*
-		 * differently from hwlat_detector, the osnoise tracer can run
-		 * without a pause because preemption is on.
-		 */
-		if (interval < 1) {
-			/* Let synchronize_rcu_tasks() make progress */
-			cond_resched_tasks_rcu_qs();
-			continue;
-		}
-
-		if (msleep_interruptible(interval))
-			break;
+		osnoise_sleep();
 	}
 
 	return 0;
diff --git a/kernel/trace/trace_probe.c b/kernel/trace/trace_probe.c
index 73d90179b51b..80863c6508e5 100644
--- a/kernel/trace/trace_probe.c
+++ b/kernel/trace/trace_probe.c
@@ -871,15 +871,15 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 	switch (ptype) {
 	case PROBE_PRINT_NORMAL:
 		fmt = "(%lx)";
-		arg = "REC->" FIELD_STRING_IP;
+		arg = ", REC->" FIELD_STRING_IP;
 		break;
 	case PROBE_PRINT_RETURN:
 		fmt = "(%lx <- %lx)";
-		arg = "REC->" FIELD_STRING_FUNC ", REC->" FIELD_STRING_RETIP;
+		arg = ", REC->" FIELD_STRING_FUNC ", REC->" FIELD_STRING_RETIP;
 		break;
 	case PROBE_PRINT_EVENT:
-		fmt = "(%u)";
-		arg = "REC->" FIELD_STRING_TYPE;
+		fmt = "";
+		arg = "";
 		break;
 	default:
 		WARN_ON_ONCE(1);
@@ -903,7 +903,7 @@ static int __set_print_fmt(struct trace_probe *tp, char *buf, int len,
 					parg->type->fmt);
 	}
 
-	pos += snprintf(buf + pos, LEN_OR_ZERO, "\", %s", arg);
+	pos += snprintf(buf + pos, LEN_OR_ZERO, "\"%s", arg);
 
 	for (i = 0; i < tp->nr_args; i++) {
 		parg = tp->args + i;
diff --git a/kernel/trace/trace_probe.h b/kernel/trace/trace_probe.h
index 99e7a5df025e..92cc149af0fd 100644
--- a/kernel/trace/trace_probe.h
+++ b/kernel/trace/trace_probe.h
@@ -38,7 +38,6 @@
 #define FIELD_STRING_IP		"__probe_ip"
 #define FIELD_STRING_RETIP	"__probe_ret_ip"
 #define FIELD_STRING_FUNC	"__probe_func"
-#define FIELD_STRING_TYPE	"__probe_type"
 
 #undef DEFINE_FIELD
 #define DEFINE_FIELD(type, item, name, is_signed)			\
diff --git a/kernel/trace/trace_selftest.c b/kernel/trace/trace_selftest.c
index afd937a46496..abcadbe933bb 100644
--- a/kernel/trace/trace_selftest.c
+++ b/kernel/trace/trace_selftest.c
@@ -784,9 +784,7 @@ static struct fgraph_ops fgraph_ops __initdata  = {
 	.retfunc		= &trace_graph_return,
 };
 
-#if defined(CONFIG_DYNAMIC_FTRACE) && \
-    defined(CONFIG_HAVE_DYNAMIC_FTRACE_WITH_ARGS)
-#define TEST_DIRECT_TRAMP
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 noinline __noclone static void trace_direct_tramp(void) { }
 #endif
 
@@ -849,7 +847,7 @@ trace_selftest_startup_function_graph(struct tracer *trace,
 		goto out;
 	}
 
-#ifdef TEST_DIRECT_TRAMP
+#ifdef CONFIG_DYNAMIC_FTRACE_WITH_DIRECT_CALLS
 	tracing_reset_online_cpus(&tr->array_buffer);
 	set_graph_array(tr);
 
diff --git a/tools/tracing/rtla/src/osnoise.c b/tools/tracing/rtla/src/osnoise.c
index 5648f9252e58..e60f1862bad0 100644
--- a/tools/tracing/rtla/src/osnoise.c
+++ b/tools/tracing/rtla/src/osnoise.c
@@ -810,7 +810,7 @@ struct osnoise_tool *osnoise_init_trace_tool(char *tracer)
 
 	retval = enable_tracer_by_name(trace->trace.inst, tracer);
 	if (retval) {
-		err_msg("Could not enable osnoiser tracer for tracing\n");
+		err_msg("Could not enable %s tracer for tracing\n", tracer);
 		goto out_err;
 	}
 
diff --git a/tools/tracing/rtla/src/osnoise_hist.c b/tools/tracing/rtla/src/osnoise_hist.c
index 1f0b7fce55cf..52c053cc1789 100644
--- a/tools/tracing/rtla/src/osnoise_hist.c
+++ b/tools/tracing/rtla/src/osnoise_hist.c
@@ -426,7 +426,7 @@ static void osnoise_hist_usage(char *usage)
 	static const char * const msg[] = {
 		"",
 		"  usage: rtla osnoise hist [-h] [-D] [-d s] [-p us] [-r us] [-s us] [-S us] [-t[=file]] \\",
-		"	  [-c cpu-list] [-P priority] [-b N] [-e N] [--no-header] [--no-summary] \\",
+		"	  [-c cpu-list] [-P priority] [-b N] [-E N] [--no-header] [--no-summary] \\",
 		"	  [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
@@ -439,7 +439,7 @@ static void osnoise_hist_usage(char *usage)
 		"	  -D/--debug: print debug info",
 		"	  -t/--trace[=file]: save the stopped trace to [file|osnoise_trace.txt]",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
-		"	  -e/--entries N: set the number of entries of the histogram (default 256)",
+		"	  -E/--entries N: set the number of entries of the histogram (default 256)",
 		"	     --no-header: do not print header",
 		"	     --no-summary: do not print summary",
 		"	     --no-index: do not print index",
@@ -486,7 +486,7 @@ static struct osnoise_hist_params
 	while (1) {
 		static struct option long_options[] = {
 			{"bucket-size",		required_argument,	0, 'b'},
-			{"entries",		required_argument,	0, 'e'},
+			{"entries",		required_argument,	0, 'E'},
 			{"cpus",		required_argument,	0, 'c'},
 			{"debug",		no_argument,		0, 'D'},
 			{"duration",		required_argument,	0, 'd'},
@@ -507,7 +507,7 @@ static struct osnoise_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:b:d:e:Dhp:P:r:s:S:t::0123",
+		c = getopt_long(argc, argv, "c:b:d:E:Dhp:P:r:s:S:t::0123",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -534,7 +534,7 @@ static struct osnoise_hist_params
 			if (!params->duration)
 				osnoise_hist_usage("Invalid -D duration\n");
 			break;
-		case 'e':
+		case 'E':
 			params->entries = get_llong_from_str(optarg);
 			if ((params->entries < 10) || (params->entries > 9999999))
 				osnoise_hist_usage("Entries must be > 10 and < 9999999\n");
diff --git a/tools/tracing/rtla/src/osnoise_top.c b/tools/tracing/rtla/src/osnoise_top.c
index c67dc28ef716..7af769b9c0de 100644
--- a/tools/tracing/rtla/src/osnoise_top.c
+++ b/tools/tracing/rtla/src/osnoise_top.c
@@ -573,6 +573,7 @@ int osnoise_top_main(int argc, char **argv)
 	osnoise_free_top(tool->data);
 	osnoise_destroy_tool(record);
 	osnoise_destroy_tool(tool);
+	free(params);
 out_exit:
 	exit(return_value);
 }
diff --git a/tools/tracing/rtla/src/timerlat_hist.c b/tools/tracing/rtla/src/timerlat_hist.c
index 436a799f9adf..237e1735afa7 100644
--- a/tools/tracing/rtla/src/timerlat_hist.c
+++ b/tools/tracing/rtla/src/timerlat_hist.c
@@ -429,7 +429,7 @@ static void timerlat_hist_usage(char *usage)
 	char *msg[] = {
 		"",
 		"  usage: [rtla] timerlat hist [-h] [-q] [-d s] [-D] [-n] [-p us] [-i us] [-T us] [-s us] [-t[=file]] \\",
-		"         [-c cpu-list] [-P priority] [-e N] [-b N]  [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
+		"         [-c cpu-list] [-P priority] [-E N] [-b N]  [--no-irq] [--no-thread] [--no-header] [--no-summary] \\",
 		"         [--no-index] [--with-zeros]",
 		"",
 		"	  -h/--help: print this menu",
@@ -443,7 +443,7 @@ static void timerlat_hist_usage(char *usage)
 		"	  -T/--trace[=file]: save the stopped trace to [file|timerlat_trace.txt]",
 		"	  -n/--nano: display data in nanoseconds",
 		"	  -b/--bucket-size N: set the histogram bucket size (default 1)",
-		"	  -e/--entries N: set the number of entries of the histogram (default 256)",
+		"	  -E/--entries N: set the number of entries of the histogram (default 256)",
 		"	     --no-irq: ignore IRQ latencies",
 		"	     --no-thread: ignore thread latencies",
 		"	     --no-header: do not print header",
@@ -494,7 +494,7 @@ static struct timerlat_hist_params
 			{"cpus",		required_argument,	0, 'c'},
 			{"bucket-size",		required_argument,	0, 'b'},
 			{"debug",		no_argument,		0, 'D'},
-			{"entries",		required_argument,	0, 'e'},
+			{"entries",		required_argument,	0, 'E'},
 			{"duration",		required_argument,	0, 'd'},
 			{"help",		no_argument,		0, 'h'},
 			{"irq",			required_argument,	0, 'i'},
@@ -516,7 +516,7 @@ static struct timerlat_hist_params
 		/* getopt_long stores the option index here. */
 		int option_index = 0;
 
-		c = getopt_long(argc, argv, "c:b:d:e:Dhi:np:P:s:t::T:012345",
+		c = getopt_long(argc, argv, "c:b:d:E:Dhi:np:P:s:t::T:012345",
 				 long_options, &option_index);
 
 		/* detect the end of the options. */
@@ -543,7 +543,7 @@ static struct timerlat_hist_params
 			if (!params->duration)
 				timerlat_hist_usage("Invalid -D duration\n");
 			break;
-		case 'e':
+		case 'E':
 			params->entries = get_llong_from_str(optarg);
 			if ((params->entries < 10) || (params->entries > 9999999))
 					timerlat_hist_usage("Entries must be > 10 and < 9999999\n");
