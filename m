Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84C2A51C4B7
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:08:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381703AbiEEQLb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:11:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59294 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233049AbiEEQLZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:11:25 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B7C25C66F;
        Thu,  5 May 2022 09:07:40 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id EDBA4B82DF6;
        Thu,  5 May 2022 16:07:38 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id B513AC385B0;
        Thu,  5 May 2022 16:07:33 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651766857;
        bh=1PXzIuiYv7yvFib7IIqy0gOFIE0PIzPzi3cyr+sKVSs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=O1k7IFjZR5qVbYoHCopm30qo0HxtAjSrqkL8cagZZbVRNF3oYqqI4Efh3L6kT6Vd+
         lUtFiRU1NdmHWrQS0igL669CSLWUW+bYXPeChTwhFCEBBSO9P/X1Ym0P4TOBUB5QNY
         P5Q03RiBieL4CKOmob+y+pS9aKvZawK2YCWxzS98CNVwqnG1yQo111i/YqV+x9emxN
         DHElTBVm1NGlYXhBiB6Gp/WZI4cHntnojwKMTv/orsqMNpNIpfAdqUAt4TtfeZ1YK/
         5q64tl7sKDKcRphKMw0rev2PvNyFzUvl937j4gvCJckN/hj8P2RcmRvxYdWBhOFH0l
         mWIhHR9COCqyw==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>, linux-kernel@vger.kernel.org
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Ingo Molnar <mingo@redhat.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Will Deacon <will@kernel.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Marco Elver <elver@google.com>,
        Dmitry Vyukov <dvyukov@google.com>,
        "Paul E. McKenney" <paulmck@kernel.org>,
        Shuah Khan <skhan@linuxfoundation.org>,
        Gabriele Paoloni <gpaoloni@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Clark Williams <williams@redhat.com>,
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org
Subject: [RFC V3 04/20] rv/include: Add deterministic automata monitor definition via C macros
Date:   Thu,  5 May 2022 18:06:44 +0200
Message-Id: <64a6f7553fce998fafac1041c09665886f1bc954.1651766361.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1651766361.git.bristot@kernel.org>
References: <cover.1651766361.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In Linux terms, the runtime verification monitors are encapsulated
inside the "RV monitor" abstraction. The "RV monitor" includes a set
of instances of the monitor (per-cpu monitor, per-task monitor, and
so on), the helper functions that glue the monitor to the system
reference model, and the trace output as a reaction for event parsing
and exceptions, as depicted below:

Linux  +----- RV Monitor ----------------------------------+ Formal
 Realm |                                                   |  Realm
 +-------------------+     +----------------+     +-----------------+
 |   Linux kernel    |     |     Monitor    |     |     Reference   |
 |     Tracing       |  -> |   Instance(s)  | <-  |       Model     |
 | (instrumentation) |     | (verification) |     | (specification) |
 +-------------------+     +----------------+     +-----------------+
        |                          |                       |
        |                          V                       |
        |                     +----------+                 |
        |                     | Reaction |                 |
        |                     +--+--+--+-+                 |
        |                        |  |  |                   |
        |                        |  |  +-> trace output ?  |
        +------------------------|--|----------------------+
                                 |  +----> panic ?
                                 +-------> <user-specified>

The dot2c tool presented in this paper:

DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo
Silva. Efficient formal verification for the Linux kernel. In:
International Conference on Software Engineering and Formal Methods.
Springer, Cham, 2019. p. 315-332.

Translates a deterministic automaton in the DOT format into a C
source code representation that to be used for monitoring connecting
the Formal Reaml to Linux-like code.

This header file goes beyond, extending the code generation to the
verification stage, generating the code to the Monitor Instance(s)
level using C macros. The trace event code inspires this approach.

The benefits of the usage of macro for monitor synthesis is 3-fold:

	- Reduces the code duplication;
	- Facilitates the bug fix/improvement;
	(but mainly:)
	- Avoids the case of developers changing the core of the monitor
	  code to manipulate the model in a (let's say) non-standard
	  way.

This initial implementation presents three different types of monitor
instances:

	- #define DECLARE_DA_MON_GLOBAL(name, type)
	- #define DECLARE_DA_MON_PER_CPU(name, type)
	- #define DECLARE_DA_MON_PER_TASK(name, type)

The first declares the functions for a global deterministic automata
monitor, the second with per-cpu instances, and the third with
per-task instances.

In all cases, the name is a string that identifies the monitor,
and the type is the data type used by dot2c/k on the representation
of the model.

For example, the model "wip" below:

                     preempt_disable                       sched_waking
   +############+ >------------------> +################+ >------------+
 -># preemptive #                      # non-preemptive #              |
   +############+ <-----------------<  +################+ <------------+
                    preempt_enable

with two states and three events can be stored in a 'char' type.
Considering that the preemption control is a per-cpu behavior, the
monitor declaration will be:

  DECLARE_DA_MON_PER_CPU(wip, char);

The monitor is executed by sending events to be processed via the
functions presented below:

  da_handle_event_$(MONITOR_NAME)($(event from event enum));
  da_handle_init_event_$(MONITOR_NAME)($(event from event enum));

The function da_handle_event_$(MONITOR_NAME) is the regular case,
while the function da_handle_init_event_$(MONITOR_NAME)() is a
special case used to synchronize the system with the model.

When a monitor is enabled, it is placed in the initial state of the
automata. However, the monitor does not know if the system is in
the initial state. Hence, the monitor ignores events sent by
sent by da_handle_event_$(MONITOR_NAME) until the function
da_handle_init_event_$(MONITOR_NAME)() is called.

The function da_handle_init_event_$(MONITOR_NAME)() should be used for
the case in which the system generates the event is the one that returns
the automata to the initial state.

After receiving a da_handle_init_event_$(MONITOR_NAME)() event, the
monitor will know that it is in sync with the system and hence will
start processing the next events.

Using the wip model as example, the events "preempt_disable" and
"sched_waking" should be sent to monitor, respectively, via:
        da_handle_event_wip(preempt_disable);
        da_handle_event_wip(sched_waking);

While the event "preempt_enabled" will use:
        da_handle_init_event_wip(preempt_enable);

To notify the monitor that the system will be returning to the initial
state, so the system and the monitor should be in sync.

With the monitor synthesis in place, using these headers and dot2k,
the developer's work should be limited to the instrumentation of
the system, increasing the confidence in the overall approach.

Cc: Jonathan Corbet <corbet@lwn.net>
Cc: Steven Rostedt <rostedt@goodmis.org>
Cc: Ingo Molnar <mingo@redhat.com>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Will Deacon <will@kernel.org>
Cc: Catalin Marinas <catalin.marinas@arm.com>
Cc: Marco Elver <elver@google.com>
Cc: Dmitry Vyukov <dvyukov@google.com>
Cc: "Paul E. McKenney" <paulmck@kernel.org>
Cc: Shuah Khan <skhan@linuxfoundation.org>
Cc: Gabriele Paoloni <gpaoloni@redhat.com>
Cc: Juri Lelli <juri.lelli@redhat.com>
Cc: Clark Williams <williams@redhat.com>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/rv/da_monitor.h | 421 ++++++++++++++++++++++++++++++++++++++++
 include/rv/rv.h         |   9 +
 kernel/fork.c           |   2 +-
 3 files changed, 431 insertions(+), 1 deletion(-)
 create mode 100644 include/rv/da_monitor.h

diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
new file mode 100644
index 000000000000..6614cacfb3d2
--- /dev/null
+++ b/include/rv/da_monitor.h
@@ -0,0 +1,421 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Deterministic automata (DA) monitor functions, to be used togheter
+ * with automata models in C generated by the dot2k tool.
+ *
+ * The dot2k tool is available at tools/tracing/rv/
+ *
+ * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+
+#include <rv/automata.h>
+#include <linux/rv.h>
+
+/*
+ * Generic helpers for all types of deterministic automata monitors.
+ */
+#define DECLARE_DA_MON_GENERIC_HELPERS(name, type)				\
+static char REACT_MSG[1024];							\
+										\
+static inline char								\
+*format_react_msg(type curr_state, type event)					\
+{										\
+	snprintf(REACT_MSG, 1024,						\
+		 "rv: monitor %s does not allow event %s on state %s\n",	\
+		 MODULE_NAME,							\
+		 model_get_event_name_##name(event),				\
+		 model_get_state_name_##name(curr_state));			\
+	return REACT_MSG;							\
+}										\
+										\
+static void cond_react(char *msg)						\
+{										\
+	if (rv_##name.react)							\
+		rv_##name.react(msg);						\
+}										\
+										\
+static inline void da_monitor_reset_##name(struct da_monitor *da_mon)		\
+{										\
+	da_mon->monitoring = 0;							\
+	da_mon->curr_state = model_get_init_state_##name();			\
+}										\
+										\
+static inline type da_monitor_curr_state_##name(struct da_monitor *da_mon)	\
+{										\
+	return da_mon->curr_state;						\
+}										\
+										\
+static inline void								\
+da_monitor_set_state_##name(struct da_monitor *da_mon, enum states_##name state)\
+{										\
+	da_mon->curr_state = state;						\
+}										\
+static inline void da_monitor_start_##name(struct da_monitor *da_mon)		\
+{										\
+	da_mon->monitoring = 1;							\
+}										\
+										\
+static inline bool da_monitoring_##name(struct da_monitor *da_mon)		\
+{										\
+	return da_mon->monitoring;						\
+}
+
+
+/*
+ * Event handler for implict monitors. Implicity monitor is the one which the
+ * handler does not need to specify which da_monitor to manilupulate. Examples
+ * of implicit monitor are the per_cpu or the global ones.
+ */
+#define DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type)			\
+static inline void								\
+trace_event_##name(type state, type event, type next_state, bool safe);		\
+static inline void trace_error_##name(type state, type event);			\
+										\
+static inline bool								\
+da_event_##name(struct da_monitor *da_mon, enum events_##name event)		\
+{										\
+	type curr_state = da_monitor_curr_state_##name(da_mon);			\
+	type next_state = model_get_next_state_##name(curr_state, event);	\
+										\
+	if (next_state >= 0) {							\
+		da_monitor_set_state_##name(da_mon, next_state);		\
+										\
+		trace_event_##name(curr_state, event, next_state,		\
+				model_is_final_state_##name(next_state));	\
+										\
+		return true;							\
+	}									\
+										\
+	if (reacting_on)							\
+		cond_react(format_react_msg(curr_state, event));		\
+										\
+	trace_error_##name(curr_state, event);					\
+										\
+	return false;								\
+}										\
+
+/*
+ * Event handler for per_task monitors.
+ */
+#define DECLARE_DA_MON_MODEL_HANDLER_PER_TASK(name, type)			\
+										\
+static inline void								\
+trace_event_##name(pid_t pid, type state, type event,				\
+		   type next_state, bool safe);					\
+static inline void trace_error_##name(pid_t pid, type state, type event);	\
+										\
+static inline type								\
+da_event_##name(struct da_monitor *da_mon, struct task_struct *tsk,		\
+		enum events_##name event)					\
+{										\
+	type curr_state = da_monitor_curr_state_##name(da_mon);			\
+	type next_state = model_get_next_state_##name(curr_state, event);	\
+										\
+	if (next_state >= 0) {							\
+		da_monitor_set_state_##name(da_mon, next_state);		\
+										\
+		trace_event_##name(tsk->pid, curr_state, event, next_state,	\
+				   model_is_final_state_##name(next_state));	\
+										\
+		return true;							\
+	}									\
+										\
+	if (reacting_on)							\
+		cond_react(format_react_msg(curr_state, event));		\
+										\
+	trace_error_##name(tsk->pid, curr_state, event);			\
+										\
+	return false;								\
+}
+
+/*
+ * Functions to define, init and get a global monitor.
+ */
+#define DECLARE_DA_MON_INIT_GLOBAL(name, type)					\
+										\
+static struct da_monitor da_mon_##name;						\
+										\
+static struct da_monitor *da_get_monitor_##name(void)				\
+{										\
+	return &da_mon_##name;							\
+}										\
+										\
+static void da_monitor_reset_all_##name(void)					\
+{										\
+	da_monitor_reset_##name(da_mon_##name);					\
+}										\
+										\
+static inline int da_monitor_init_##name(void)					\
+{										\
+	struct da_monitor *da_mon = &da_mon_##name				\
+	da_mon->curr_state = model_get_init_state_##name();			\
+	da_mon->monitoring = 0;							\
+	return 0;								\
+}										\
+										\
+static inline void da_monitor_destroy_##name(void)				\
+{										\
+	return;									\
+}
+
+/*
+ * Functions to define, init and get a per-cpu monitor.
+ */
+#define DECLARE_DA_MON_INIT_PER_CPU(name, type)					\
+										\
+DEFINE_PER_CPU(struct da_monitor, da_mon_##name);				\
+										\
+static struct da_monitor *da_get_monitor_##name(void)				\
+{										\
+	return this_cpu_ptr(&da_mon_##name);					\
+}										\
+										\
+static void da_monitor_reset_all_##name(void)					\
+{										\
+	struct da_monitor *da_mon;						\
+	int cpu;								\
+	for_each_cpu(cpu, cpu_online_mask) {					\
+		da_mon = per_cpu_ptr(&da_mon_##name, cpu);			\
+		da_monitor_reset_##name(da_mon);				\
+	}									\
+}										\
+										\
+static inline int da_monitor_init_##name(void)					\
+{										\
+	struct da_monitor *da_mon;						\
+	int cpu;								\
+	for_each_cpu(cpu, cpu_online_mask) {					\
+		da_mon = per_cpu_ptr(&da_mon_##name, cpu);			\
+		da_mon->curr_state = model_get_init_state_##name();		\
+		da_mon->monitoring = 0;						\
+	}									\
+	return 0;								\
+}										\
+										\
+static inline void da_monitor_destroy_##name(void)				\
+{										\
+	return;									\
+}
+
+/*
+ * Functions to define, init and get a per-task monitor.
+ */
+#define DECLARE_DA_MON_INIT_PER_TASK(name, type)				\
+										\
+static int task_mon_slot_##name = RV_PER_TASK_MONITOR_INIT;			\
+										\
+static inline struct da_monitor *da_get_monitor_##name(struct task_struct *tsk)	\
+{										\
+	return &tsk->rv[task_mon_slot_##name].da_mon;				\
+}										\
+										\
+static void da_monitor_reset_all_##name(void)					\
+{										\
+	struct task_struct *g, *p;						\
+										\
+	read_lock(&tasklist_lock);						\
+	for_each_process_thread(g, p)						\
+		da_monitor_reset_##name(da_get_monitor_##name(p));		\
+	read_unlock(&tasklist_lock);						\
+}										\
+										\
+static int da_monitor_init_##name(void)						\
+{										\
+	struct da_monitor *da_mon;						\
+	struct task_struct *g, *p;						\
+	int retval;								\
+										\
+	retval = get_task_monitor_slot();					\
+	if (retval < 0)								\
+		return retval;							\
+										\
+	task_mon_slot_##name = retval;						\
+										\
+	read_lock(&tasklist_lock);						\
+	for_each_process_thread(g, p) {						\
+		da_mon = da_get_monitor_##name(p);				\
+		da_mon->curr_state = model_get_init_state_##name();		\
+		da_mon->monitoring = 0;						\
+	}									\
+	read_unlock(&tasklist_lock);						\
+										\
+	return 0;								\
+}										\
+										\
+static inline void da_monitor_destroy_##name(void)				\
+{										\
+	if (task_mon_slot_##name == RV_PER_TASK_MONITOR_INIT) {			\
+		WARN_ONCE(1, "Disabling a disabled monitor: " #name);		\
+		return;								\
+	}									\
+	put_task_monitor_slot(task_mon_slot_##name);				\
+	return;									\
+}
+
+/*
+ * Handle event for implicit monitor: da_get_monitor_##name() will figure out
+ * the monitor.
+ */
+#define DECLARE_DA_MON_MONITOR_HANDLER_IMPLICIT(name, type)			\
+										\
+static inline void __da_handle_event_##name(struct da_monitor *da_mon,		\
+				     enum events_##name event)			\
+{										\
+	int retval;								\
+										\
+	if (unlikely(!monitoring_on))						\
+		return;								\
+										\
+	if (unlikely(!rv_##name.enabled))					\
+		return;								\
+										\
+	if (unlikely(!da_monitoring_##name(da_mon)))				\
+		return;								\
+										\
+	retval = da_event_##name(da_mon, event);				\
+										\
+	if (!retval)								\
+		da_monitor_reset_##name(da_mon);				\
+}										\
+										\
+static inline void da_handle_event_##name(enum events_##name event)		\
+{										\
+	struct da_monitor *da_mon = da_get_monitor_##name();			\
+	__da_handle_event_##name(da_mon, event);				\
+}										\
+										\
+static inline bool da_handle_init_event_##name(enum events_##name event)	\
+{										\
+	struct da_monitor *da_mon;						\
+										\
+	if (unlikely(!rv_##name.enabled))					\
+		return false;							\
+										\
+	da_mon = da_get_monitor_##name();					\
+										\
+	if (unlikely(!da_monitoring_##name(da_mon))) {				\
+		da_monitor_start_##name(da_mon);				\
+		return false;							\
+	}									\
+										\
+	__da_handle_event_##name(da_mon, event);				\
+										\
+	return true;								\
+}										\
+										\
+static inline bool da_handle_init_run_event_##name(enum events_##name event)	\
+{										\
+	struct da_monitor *da_mon;						\
+										\
+	if (unlikely(!rv_##name.enabled))					\
+		return false;							\
+										\
+	da_mon = da_get_monitor_##name();					\
+										\
+	if (unlikely(!da_monitoring_##name(da_mon)))				\
+		da_monitor_start_##name(da_mon);				\
+										\
+	__da_handle_event_##name(da_mon, event);				\
+										\
+	return true;								\
+}
+
+/*
+ * Handle event for per task.
+ */
+#define DECLARE_DA_MON_MONITOR_HANDLER_PER_TASK(name, type)			\
+										\
+static inline void								\
+__da_handle_event_##name(struct da_monitor *da_mon, struct task_struct *tsk,	\
+			 enum events_##name event)				\
+{										\
+	int retval;								\
+										\
+	if (unlikely(!monitoring_on))						\
+		return;								\
+										\
+	if (unlikely(!rv_##name.enabled))					\
+		return;								\
+										\
+	if (unlikely(!da_monitoring_##name(da_mon)))				\
+		return;								\
+										\
+	retval = da_event_##name(da_mon, tsk, event);				\
+										\
+	if (!retval)								\
+		da_monitor_reset_##name(da_mon);				\
+}										\
+										\
+static inline void								\
+da_handle_event_##name(struct task_struct *tsk, enum events_##name event)	\
+{										\
+	struct da_monitor *da_mon = da_get_monitor_##name(tsk);			\
+	__da_handle_event_##name(da_mon, tsk, event);				\
+}										\
+										\
+static inline bool								\
+da_handle_init_event_##name(struct task_struct *tsk, enum events_##name event)	\
+{										\
+	struct da_monitor *da_mon;						\
+										\
+	if (unlikely(!rv_##name.enabled))					\
+		return false;							\
+										\
+	da_mon = da_get_monitor_##name(tsk);					\
+										\
+	if (unlikely(!da_monitoring_##name(da_mon))) {				\
+		da_monitor_start_##name(da_mon);				\
+		return false;							\
+	}									\
+										\
+	__da_handle_event_##name(da_mon, tsk, event);				\
+										\
+	return true;								\
+}
+
+/*
+ * Entry point for the global monitor.
+ */
+#define DECLARE_DA_MON_GLOBAL(name, type)					\
+										\
+DECLARE_AUTOMATA_HELPERS(name, type);						\
+										\
+DECLARE_DA_MON_GENERIC_HELPERS(name, type);					\
+										\
+DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type);				\
+										\
+DECLARE_DA_MON_INIT_PER_CPU(name, type);					\
+										\
+DECLARE_DA_MON_MONITOR_HANDLER_IMPLICIT(name, type);
+
+
+/*
+ * Entry point for the per-cpu monitor.
+ */
+#define DECLARE_DA_MON_PER_CPU(name, type)					\
+										\
+DECLARE_AUTOMATA_HELPERS(name, type);						\
+										\
+DECLARE_DA_MON_GENERIC_HELPERS(name, type);					\
+										\
+DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type);				\
+										\
+DECLARE_DA_MON_INIT_PER_CPU(name, type);					\
+										\
+DECLARE_DA_MON_MONITOR_HANDLER_IMPLICIT(name, type);
+
+
+/*
+ * Entry point for the per-task monitor.
+ */
+#define DECLARE_DA_MON_PER_TASK(name, type)					\
+										\
+DECLARE_AUTOMATA_HELPERS(name, type);						\
+										\
+DECLARE_DA_MON_GENERIC_HELPERS(name, type);					\
+										\
+DECLARE_DA_MON_MODEL_HANDLER_PER_TASK(name, type);				\
+										\
+DECLARE_DA_MON_INIT_PER_TASK(name, type);					\
+										\
+DECLARE_DA_MON_MONITOR_HANDLER_PER_TASK(name, type);
diff --git a/include/rv/rv.h b/include/rv/rv.h
index 27a108881d35..b0658cdc53d9 100644
--- a/include/rv/rv.h
+++ b/include/rv/rv.h
@@ -3,6 +3,14 @@
 #ifndef _RV_RV_H
 #define _RV_RV_H
 
+/*
+ * Deterministic automaton per-object variables.
+ */
+struct da_monitor {
+	bool	monitoring;
+	int	curr_state;
+};
+
 /*
  * Per-task RV monitors count. Nowadays fixed in RV_PER_TASK_MONITORS.
  * If we find justification for more monitors, we can think about
@@ -16,6 +24,7 @@
  * Futher monitor types are expected, so make this a union.
  */
 union rv_task_monitor {
+	struct da_monitor da_mon;
 };
 
 int get_task_monitor_slot(void);
diff --git a/kernel/fork.c b/kernel/fork.c
index 28334f6d2938..3f7703207a8c 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1967,7 +1967,7 @@ static void rv_task_fork(struct task_struct *p)
 	int i;
 
 	for (i = 0; i < RV_PER_TASK_MONITORS; i++)
-		;
+		p->rv[i].da_mon.monitoring = false;
 }
 #else
 #define rv_task_fork(p) do {} while (0)
-- 
2.35.1

