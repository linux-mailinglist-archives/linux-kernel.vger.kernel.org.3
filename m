Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 90154573EB8
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 23:18:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237436AbiGMVS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 17:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38786 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237393AbiGMVSY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 17:18:24 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 103CE33E2B;
        Wed, 13 Jul 2022 14:18:14 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 55F7EB821EB;
        Wed, 13 Jul 2022 21:18:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 71203C341C0;
        Wed, 13 Jul 2022 21:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657747091;
        bh=EWK3htvZIp+bE3u7RqLvqLzwpZBzrTq588v0Yhq8EYI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YfFtDdNgUy7/YZ0AoelFk3k1x6b/3uvV+gY7QT3hl9AYQJWfFbRrE+hRsjtt6ryDk
         HHBihveXGHPf86qB0ff3hqZ75/yx/jG414ckux8JPv4vIf+IU27K+fOjmNHd4rEsFu
         ZMbRgJTFeu3SgUZt60yO9b9FcRLxaNS8pOnIRq63B6v27lercJPfhIxSv1cwu4zdV0
         fowjHss6jBLuIh8MPuvVOW5DxeJu/HGbFHinpgMi9NpgcZuyQzTU2MmRCJASeM7Yfg
         ioebhqtmMpRHsMiNTX2gZWu9+4cbEZ/n5rsgkFrnniQuROMczQjIsOQSxiod0B3ZLg
         Oswgt3rIEYHsg==
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     Daniel Bristot de Oliveira <bristot@kernel.org>,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>,
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
        Tao Zhou <tao.zhou@linux.dev>,
        Randy Dunlap <rdunlap@infradead.org>,
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V5 04/16] rv/include: Add deterministic automata monitor definition via C macros
Date:   Wed, 13 Jul 2022 23:17:20 +0200
Message-Id: <5e0447aa9d114c52fd2bc335de036c61d9625f1c.1657745645.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1657745645.git.bristot@kernel.org>
References: <cover.1657745645.git.bristot@kernel.org>
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

Add the rv/da_monitor.h, enabling automatic code generation for the
*Monitor Instance(s)* using C macros, and code to support it.

The benefits of the usage of macro for monitor synthesis are 3-fold as it:

- Reduces the code duplication;
- Facilitates the bug fix/improvement;
- Avoids the case of developers changing the core of the monitor code
  to manipulate the model in a (let's say) non-standard way.

This initial implementation presents three different types of monitor
instances:

- DECLARE_DA_MON_GLOBAL(name, type)
- DECLARE_DA_MON_PER_CPU(name, type)
- DECLARE_DA_MON_PER_TASK(name, type)

The first declares the functions for a global deterministic automata monitor,
the second for monitors with per-cpu instances, and the third with per-task
instances.

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
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
Cc: Tao Zhou <tao.zhou@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 include/linux/rv.h        |   2 +
 include/rv/da_monitor.h   | 521 ++++++++++++++++++++++++++++++++++++++
 include/rv/rv.h           |   9 +
 include/trace/events/rv.h | 120 +++++++++
 kernel/fork.c             |  14 +
 kernel/trace/rv/Kconfig   |  14 +
 kernel/trace/rv/rv.c      |   5 +
 7 files changed, 685 insertions(+)
 create mode 100644 include/rv/da_monitor.h
 create mode 100644 include/trace/events/rv.h

diff --git a/include/linux/rv.h b/include/linux/rv.h
index 88d28d207f3a..bdefdff12a1f 100644
--- a/include/linux/rv.h
+++ b/include/linux/rv.h
@@ -7,6 +7,8 @@
 #ifndef _LINUX_RV_H
 #define _LINUX_RV_H
 
+#define MAX_DA_NAME_LEN         24
+
 struct rv_reactor {
 	char			*name;
 	char			*description;
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
new file mode 100644
index 000000000000..d21045e6c5fc
--- /dev/null
+++ b/include/rv/da_monitor.h
@@ -0,0 +1,521 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+ *
+ * Deterministic automata (DA) monitor functions, to be used together
+ * with automata models in C generated by the dot2k tool.
+ *
+ * The dot2k tool is available at tools/verification/dot2k/
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
+static inline char *format_react_msg(type curr_state, type event)		\
+{										\
+	snprintf(REACT_MSG, 1024,						\
+		 "rv: monitor %s does not allow event %s on state %s\n",	\
+		 #name,								\
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
+/*										\
+ * da_monitor_reset_##name - reset a monitor and setting it to init state	\
+ */										\
+static inline void da_monitor_reset_##name(struct da_monitor *da_mon)		\
+{										\
+	da_mon->monitoring = 0;							\
+	da_mon->curr_state = model_get_init_state_##name();			\
+}										\
+										\
+/*										\
+ * da_monitor_curr_state_##name - return the current state			\
+ */										\
+static inline type da_monitor_curr_state_##name(struct da_monitor *da_mon)	\
+{										\
+	return da_mon->curr_state;						\
+}										\
+										\
+/*										\
+ * da_monitor_set_state_##name - set the new current state			\
+ */										\
+static inline void								\
+da_monitor_set_state_##name(struct da_monitor *da_mon, enum states_##name state)\
+{										\
+	da_mon->curr_state = state;						\
+}										\
+										\
+/*										\
+ * da_monitor_start_##name - start monitoring					\
+ *										\
+ * The monitor will ignore all events until monitoring is set to true. This	\
+ * function needs to be called to tell the monitor to start monitoring.		\
+ */										\
+static inline void da_monitor_start_##name(struct da_monitor *da_mon)		\
+{										\
+	da_mon->monitoring = 1;							\
+}										\
+										\
+/*										\
+ * da_monitoring_##name - returns true if the monitor is processing events	\
+ */										\
+static inline bool da_monitoring_##name(struct da_monitor *da_mon)		\
+{										\
+	return da_mon->monitoring;						\
+}
+
+
+/*
+ * Event handler for implicit monitors. Implicit monitor is the one which the
+ * handler does not need to specify which da_monitor to manipulate. Examples
+ * of implicit monitor are the per_cpu or the global ones.
+ */
+#define DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type)			\
+static inline bool								\
+da_event_##name(struct da_monitor *da_mon, enum events_##name event)		\
+{										\
+	type curr_state = da_monitor_curr_state_##name(da_mon);			\
+	type next_state = model_get_next_state_##name(curr_state, event);	\
+										\
+	if (next_state != INVALID_STATE) {					\
+		da_monitor_set_state_##name(da_mon, next_state);		\
+										\
+		trace_event_##name(model_get_state_name_##name(curr_state),	\
+				model_get_event_name_##name(event),		\
+				model_get_state_name_##name(next_state),	\
+				model_is_final_state_##name(next_state));	\
+										\
+		return true;							\
+	}									\
+										\
+	if (reacting_on)							\
+		cond_react(format_react_msg(curr_state, event));		\
+										\
+	trace_error_##name(model_get_state_name_##name(curr_state),		\
+			   model_get_event_name_##name(event));			\
+										\
+	return false;								\
+}										\
+
+/*
+ * Event handler for per_task monitors.
+ */
+#define DECLARE_DA_MON_MODEL_HANDLER_PER_TASK(name, type)			\
+static inline type								\
+da_event_##name(struct da_monitor *da_mon, struct task_struct *tsk,		\
+		enum events_##name event)					\
+{										\
+	type curr_state = da_monitor_curr_state_##name(da_mon);			\
+	type next_state = model_get_next_state_##name(curr_state, event);	\
+										\
+	if (next_state != INVALID_STATE) {					\
+		da_monitor_set_state_##name(da_mon, next_state);		\
+										\
+		trace_event_##name(tsk->pid,					\
+				   model_get_state_name_##name(curr_state),	\
+				   model_get_event_name_##name(event),		\
+				   model_get_state_name_##name(next_state),	\
+				   model_is_final_state_##name(next_state));	\
+										\
+		return true;							\
+	}									\
+										\
+	if (reacting_on)							\
+		cond_react(format_react_msg(curr_state, event));		\
+										\
+	trace_error_##name(tsk->pid,						\
+			   model_get_state_name_##name(curr_state),		\
+			   model_get_event_name_##name(event));			\
+										\
+	return false;								\
+}
+
+/*
+ * Functions to define, init and get a global monitor.
+ */
+#define DECLARE_DA_MON_INIT_GLOBAL(name, type)					\
+										\
+/*										\
+ * global monitor (a single variable)						\
+ */										\
+static struct da_monitor da_mon_##name;						\
+										\
+/*										\
+ * da_get_monitor_##name - return the global monitor address			\
+ */										\
+static struct da_monitor *da_get_monitor_##name(void)				\
+{										\
+	return &da_mon_##name;							\
+}										\
+										\
+/*										\
+ * da_monitor_reset_all_##name - reset the single monitor			\
+ */										\
+static void da_monitor_reset_all_##name(void)					\
+{										\
+	da_monitor_reset_##name(&da_mon_##name);				\
+}										\
+										\
+/*										\
+ * da_monitor_init_##name - initialize a monitor				\
+ */										\
+static inline int da_monitor_init_##name(void)					\
+{										\
+	struct da_monitor *da_mon = &da_mon_##name;				\
+	da_mon->curr_state = model_get_init_state_##name();			\
+	da_mon->monitoring = 0;							\
+	return 0;								\
+}										\
+										\
+/*										\
+ * da_monitor_destroy_##name - destroy the monitor				\
+ */										\
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
+/*										\
+ * per-cpu monitor variables							\
+ */										\
+DEFINE_PER_CPU(struct da_monitor, da_mon_##name);				\
+										\
+/*										\
+ * da_get_monitor_##name - return current CPU monitor address			\
+ */										\
+static struct da_monitor *da_get_monitor_##name(void)				\
+{										\
+	return this_cpu_ptr(&da_mon_##name);					\
+}										\
+										\
+/*										\
+ * da_monitor_reset_all_##name - reset all CPUs' monitor			\
+ */										\
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
+/*										\
+ * da_monitor_init_##name - initialize all CPUs' monitor			\
+ */										\
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
+/*										\
+ * da_monitor_destroy_##name - destroy the monitor				\
+ */										\
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
+/*										\
+ * The per-task monitor is stored a vector in the task struct. This variable	\
+ * stores the position on the vector reserved for this monitor.			\
+ */										\
+static int task_mon_slot_##name = RV_PER_TASK_MONITOR_INIT;			\
+										\
+/*										\
+ * da_get_monitor_##name - return the monitor in the allocated slot for tsk 	\
+ */										\
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
+/*										\
+ * da_monitor_init_##name - initialize the per-task monitor			\
+ *										\
+ * Try to allocate a slot in the task's vector of monitors. If there		\
+ * is an available slot, use it and reset all task's monitor.			\
+ */										\
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
+/*										\
+ * da_monitor_destroy_##name - return the allocated slot			\
+ */										\
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
+	/* global switch */							\
+	if (unlikely(!monitoring_on))						\
+		return;								\
+										\
+	/* monitor enabled */							\
+	if (unlikely(!rv_##name.enabled))					\
+		return;								\
+										\
+	/* monitor is actually monitoring */					\
+	if (unlikely(!da_monitoring_##name(da_mon)))				\
+		return;								\
+										\
+	retval = da_event_##name(da_mon, event);				\
+										\
+	if (!retval)								\
+		da_monitor_reset_##name(da_mon);				\
+}										\
+										\
+/*										\
+ * da_handle_event_##name - handle an event					\
+ */										\
+static inline void da_handle_event_##name(enum events_##name event)		\
+{										\
+	struct da_monitor *da_mon = da_get_monitor_##name();			\
+	__da_handle_event_##name(da_mon, event);				\
+}										\
+										\
+/*										\
+ * da_handle_init_event_##name - start monitoring or handle event		\
+ *										\
+ * This function is used notify the monitor that the system is returning	\
+ * to the initial state, so the monitor can start monitoring in the next event.	\
+ * Thus:									\
+ *										\
+ * If the monitor already started, handle the event.				\
+ * If the monitor did not start yet, start the monitor but skip the event.	\
+ */										\
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
+/*										\
+ * da_handle_init_run_event_##name - start monitoring and handle event		\
+ *										\
+ * This function is used notify the monitor that the system is in the		\
+ * initial state, so the monitor can start monitoring and handling event.	\
+ */										\
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
+	/* global switch */							\
+	if (unlikely(!monitoring_on))						\
+		return;								\
+										\
+	/* monitor enabled */							\
+	if (unlikely(!rv_##name.enabled))					\
+		return;								\
+										\
+	/* monitor is actually monitoring */					\
+	if (unlikely(!da_monitoring_##name(da_mon)))				\
+		return;								\
+										\
+	retval = da_event_##name(da_mon, tsk, event);				\
+										\
+	if (!retval)								\
+		da_monitor_reset_##name(da_mon);				\
+}										\
+										\
+/*										\
+ * da_handle_event_##name - handle an event					\
+ */										\
+static inline void								\
+da_handle_event_##name(struct task_struct *tsk, enum events_##name event)	\
+{										\
+	struct da_monitor *da_mon = da_get_monitor_##name(tsk);			\
+	__da_handle_event_##name(da_mon, tsk, event);				\
+}										\
+										\
+/*										\
+ * da_handle_init_event_##name - start monitoring or handle event		\
+ *										\
+ * This function is used notify the monitor that the system is returning	\
+ * to the initial state, so the monitor can start monitoring in the next event.	\
+ * Thus:									\
+ *										\
+ * If the monitor already started, handle the event.				\
+ * If the monitor did not start yet, start the monitor but skip the event.	\
+ */										\
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
+DECLARE_AUTOMATA_HELPERS(name, type)						\
+										\
+DECLARE_DA_MON_GENERIC_HELPERS(name, type)					\
+										\
+DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type)				\
+										\
+DECLARE_DA_MON_INIT_GLOBAL(name, type)						\
+										\
+DECLARE_DA_MON_MONITOR_HANDLER_IMPLICIT(name, type)
+
+
+/*
+ * Entry point for the per-cpu monitor.
+ */
+#define DECLARE_DA_MON_PER_CPU(name, type)					\
+										\
+DECLARE_AUTOMATA_HELPERS(name, type)						\
+										\
+DECLARE_DA_MON_GENERIC_HELPERS(name, type)					\
+										\
+DECLARE_DA_MON_MODEL_HANDLER_IMPLICIT(name, type)				\
+										\
+DECLARE_DA_MON_INIT_PER_CPU(name, type)					\
+										\
+DECLARE_DA_MON_MONITOR_HANDLER_IMPLICIT(name, type)
+
+
+/*
+ * Entry point for the per-task monitor.
+ */
+#define DECLARE_DA_MON_PER_TASK(name, type)					\
+										\
+DECLARE_AUTOMATA_HELPERS(name, type)						\
+										\
+DECLARE_DA_MON_GENERIC_HELPERS(name, type)					\
+										\
+DECLARE_DA_MON_MODEL_HANDLER_PER_TASK(name, type)				\
+										\
+DECLARE_DA_MON_INIT_PER_TASK(name, type)					\
+										\
+DECLARE_DA_MON_MONITOR_HANDLER_PER_TASK(name, type)
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
diff --git a/include/trace/events/rv.h b/include/trace/events/rv.h
new file mode 100644
index 000000000000..480aac18f403
--- /dev/null
+++ b/include/trace/events/rv.h
@@ -0,0 +1,120 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv
+
+#if !defined(_TRACE_RV_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _TRACE_RV_H
+
+#include <linux/rv.h>
+#include <linux/tracepoint.h>
+
+#ifdef CONFIG_DA_MON_EVENTS_IMPLICIT
+DECLARE_EVENT_CLASS(event_da_monitor,
+
+	TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+
+	TP_ARGS(state, event, next_state, final_state),
+
+	TP_STRUCT__entry(
+		__array(	char,	state,		MAX_DA_NAME_LEN	)
+		__array(	char,	event,		MAX_DA_NAME_LEN	)
+		__array(	char,	next_state,	MAX_DA_NAME_LEN	)
+		__field(	bool,	final_state				)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->state,		state,		MAX_DA_NAME_LEN);
+		memcpy(__entry->event,		event,		MAX_DA_NAME_LEN);
+		memcpy(__entry->next_state,	next_state,	MAX_DA_NAME_LEN);
+		__entry->final_state		= final_state;
+	),
+
+	TP_printk("%s x %s -> %s %s",
+		__entry->state,
+		__entry->event,
+		__entry->next_state,
+		__entry->final_state ? "(final)" : "")
+);
+
+DECLARE_EVENT_CLASS(error_da_monitor,
+
+	TP_PROTO(char *state, char *event),
+
+	TP_ARGS(state, event),
+
+	TP_STRUCT__entry(
+		__array(	char,	state,		MAX_DA_NAME_LEN	)
+		__array(	char,	event,		MAX_DA_NAME_LEN	)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->state,		state,		MAX_DA_NAME_LEN);
+		memcpy(__entry->event,		event,		MAX_DA_NAME_LEN);
+	),
+
+	TP_printk("event %s not expected in the state %s",
+		__entry->event,
+		__entry->state)
+);
+#endif /* CONFIG_DA_MON_EVENTS_IMPLICIT */
+
+#ifdef CONFIG_DA_MON_EVENTS_ID
+DECLARE_EVENT_CLASS(event_da_monitor_id,
+
+	TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+
+	TP_ARGS(id, state, event, next_state, final_state),
+
+	TP_STRUCT__entry(
+		__field(	int,	id				)
+		__array(	char,	state,		MAX_DA_NAME_LEN	)
+		__array(	char,	event,		MAX_DA_NAME_LEN	)
+		__array(	char,	next_state,	MAX_DA_NAME_LEN	)
+		__field(	bool,	final_state			)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->state,		state,		MAX_DA_NAME_LEN);
+		memcpy(__entry->event,		event,		MAX_DA_NAME_LEN);
+		memcpy(__entry->next_state,	next_state,	MAX_DA_NAME_LEN);
+		__entry->id			= id;
+		__entry->final_state		= final_state;
+	),
+
+	TP_printk("%d: %s x %s -> %s %s",
+		__entry->id,
+		__entry->state,
+		__entry->event,
+		__entry->next_state,
+		__entry->final_state ? "(final)" : "")
+);
+
+DECLARE_EVENT_CLASS(error_da_monitor_id,
+
+	TP_PROTO(int id, char *state, char *event),
+
+	TP_ARGS(id, state, event),
+
+	TP_STRUCT__entry(
+		__field(	int,	id				)
+		__array(	char,	state,		MAX_DA_NAME_LEN	)
+		__array(	char,	event,		MAX_DA_NAME_LEN	)
+	),
+
+	TP_fast_assign(
+		memcpy(__entry->state,		state,		MAX_DA_NAME_LEN);
+		memcpy(__entry->event,		event,		MAX_DA_NAME_LEN);
+		__entry->id			= id;
+	),
+
+	TP_printk("%d: event %s not expected in the state %s",
+		__entry->id,
+		__entry->event,
+		__entry->state)
+);
+#endif /* CONFIG_DA_MON_EVENTS_ID */
+#endif /* _TRACE_RV_H */
+
+/* This part ust be outside protection */
+#undef TRACE_INCLUDE_PATH
+#include <trace/define_trace.h>
diff --git a/kernel/fork.c b/kernel/fork.c
index 9d44f2d46c69..6f1f82ccd5f2 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1964,6 +1964,18 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
 	mutex_unlock(&oom_adj_mutex);
 }
 
+#ifdef CONFIG_RV
+static void rv_task_fork(struct task_struct *p)
+{
+	int i;
+
+	for (i = 0; i < RV_PER_TASK_MONITORS; i++)
+		p->rv[i].da_mon.monitoring = false;
+}
+#else
+#define rv_task_fork(p) do {} while (0)
+#endif
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2399,6 +2411,8 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	copy_seccomp(p);
 
+	rv_task_fork(p);
+
 	rseq_fork(p, clone_flags);
 
 	/* Don't start children in a dying pid namespace */
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 3eb5d48ab4f6..0123bdf7052a 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -1,5 +1,19 @@
 # SPDX-License-Identifier: GPL-2.0-only
 #
+config DA_MON_EVENTS
+	default n
+	bool
+
+config DA_MON_EVENTS_IMPLICIT
+	select DA_MON_EVENTS
+	default n
+	bool
+
+config DA_MON_EVENTS_ID
+	select DA_MON_EVENTS
+	default n
+	bool
+
 menuconfig RV
 	bool "Runtime Verification"
 	depends on TRACING
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index d988e2b1b9d2..00f1ffc49a7b 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -141,6 +141,11 @@
 #include <linux/slab.h>
 #include <rv/rv.h>
 
+#ifdef CONFIG_DA_MON_EVENTS
+#define CREATE_TRACE_POINTS
+#include <trace/events/rv.h>
+#endif
+
 #include "rv.h"
 
 DEFINE_MUTEX(rv_interface_lock);
-- 
2.35.1

