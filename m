Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A1374B4E36
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351212AbiBNLX6 convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:23:58 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:52126 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350702AbiBNLXi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:23:38 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id C691E6AA5D
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:59:01 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-347-FZQAIk2MPauVFaiMtszyBg-1; Mon, 14 Feb 2022 05:48:16 -0500
X-MC-Unique: FZQAIk2MPauVFaiMtszyBg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id E997D801B0E;
        Mon, 14 Feb 2022 10:48:13 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id E30AA27BDC;
        Mon, 14 Feb 2022 10:48:01 +0000 (UTC)
From:   Daniel Bristot de Oliveira <bristot@kernel.org>
To:     Steven Rostedt <rostedt@goodmis.org>
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org,
        Wim Van Sebroeck <wim@linux-watchdog.org>,
        Guenter Roeck <linux@roeck-us.net>
Subject: [RFC V2 19/21] rv/monitor: Add safe watchdog nowayout monitor
Date:   Mon, 14 Feb 2022 11:45:10 +0100
Message-Id: <7a810f46b6136565a364001e7d1550fb9a4ccf62.1644830251.git.bristot@kernel.org>
In-Reply-To: <cover.1644830251.git.bristot@kernel.org>
References: <cover.1644830251.git.bristot@kernel.org>
MIME-Version: 1.0
X-Scanned-By: MIMEDefang 2.84 on 10.5.11.23
Authentication-Results: relay.mimecast.com;
        auth=pass smtp.auth=CUSA124A263 smtp.mailfrom=bristot@kernel.org
X-Mimecast-Spam-Score: 0
X-Mimecast-Originator: kernel.org
Content-Transfer-Encoding: 8BIT
Content-Type: text/plain; charset=WINDOWS-1252
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_SOFTFAIL,T_SCC_BODY_TEXT_LINE
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This is a simplification of the safe_wtd monitor, named safe_wtd_nwo.
The difference between these two monitors is that the latter enforces
the nowayout watchdog device option before opening the watchdog.

In this way, once the watchdog is starts, the watchdog hardware will
serve as an safety-monitor until the system shutdown.

For further information, please refer to:
        Documentation/trace/rv/watchdog-monitor.rst

The monitor specification was developed together with Gabriele Paoloni,
in the context of the Linux Foundation Elisa Project.

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
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 kernel/trace/rv/Kconfig                       |  10 +
 kernel/trace/rv/Makefile                      |   1 +
 kernel/trace/rv/monitor_safe_wtd_nwo/model.h  |  61 ++++
 .../rv/monitor_safe_wtd_nwo/safe_wtd_nwo.c    | 309 ++++++++++++++++++
 .../rv/monitor_safe_wtd_nwo/safe_wtd_nwo.h    |  64 ++++
 5 files changed, 445 insertions(+)
 create mode 100644 kernel/trace/rv/monitor_safe_wtd_nwo/model.h
 create mode 100644 kernel/trace/rv/monitor_safe_wtd_nwo/safe_wtd_nwo.c
 create mode 100644 kernel/trace/rv/monitor_safe_wtd_nwo/safe_wtd_nwo.h

diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 93b36f215b2b..7e797e132f60 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -39,6 +39,16 @@ config RV_MON_SAFE_WTD
 	  For futher information see:
 	    Documentation/trace/rv/safety-monitor.rst
 
+config RV_MON_SAFE_WTD_NWO
+	tristate "Safety watchdog nowayout"
+	help
+	  Enable safe_wtd_nwo, this monitor observes the interaction
+	  between a user-space safety monitor and a watchdog device. It
+	  enforces the usage of watchdog's nowayout config.
+
+	  For futher information see:
+	    Documentation/trace/rv/safety-monitor.rst
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y if RV
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 854d0f6e453b..44277103d178 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -4,6 +4,7 @@ obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_MON_WIP) += monitor_wip/wip.o
 obj-$(CONFIG_RV_MON_WWNR) += monitor_wwnr/wwnr.o
 obj-$(CONFIG_RV_MON_SAFE_WTD) += monitor_safe_wtd/safe_wtd.o
+obj-$(CONFIG_RV_MON_SAFE_WTD_NWO) += monitor_safe_wtd_nwo/safe_wtd_nwo.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_REACT_PRINTK) += reactor_printk.o
 obj-$(CONFIG_RV_REACT_PANIC) += reactor_panic.o
diff --git a/kernel/trace/rv/monitor_safe_wtd_nwo/model.h b/kernel/trace/rv/monitor_safe_wtd_nwo/model.h
new file mode 100644
index 000000000000..504a93e35b93
--- /dev/null
+++ b/kernel/trace/rv/monitor_safe_wtd_nwo/model.h
@@ -0,0 +1,61 @@
+enum states_safe_wtd_nwo {
+	init = 0,
+	closed_running,
+	nwo,
+	opened,
+	safe,
+	set,
+	started,
+	state_max
+};
+
+enum events_safe_wtd_nwo {
+	close = 0,
+	nowayout,
+	open,
+	other_threads,
+	ping,
+	set_safe_timeout,
+	start,
+	event_max
+};
+
+struct automaton_safe_wtd_nwo {
+	char *state_names[state_max];
+	char *event_names[event_max];
+	char function[state_max][event_max];
+	char initial_state;
+	char final_states[state_max];
+};
+
+struct automaton_safe_wtd_nwo automaton_safe_wtd_nwo = {
+	.state_names = {
+		"init",
+		"closed_running",
+		"nwo",
+		"opened",
+		"safe",
+		"set",
+		"started"
+	},
+	.event_names = {
+		"close",
+		"nowayout",
+		"open",
+		"other_threads",
+		"ping",
+		"set_safe_timeout",
+		"start"
+	},
+	.function = {
+		{             -1,            nwo,             -1,             -1,             -1,             -1,             -1 },
+		{             -1, closed_running,        started, closed_running,             -1,             -1,             -1 },
+		{             -1,            nwo,         opened,            nwo,             -1,             -1,             -1 },
+		{            nwo,             -1,             -1,             -1,             -1,             -1,        started },
+		{ closed_running,             -1,             -1,             -1,           safe,             -1,             -1 },
+		{             -1,             -1,             -1,             -1,           safe,             -1,             -1 },
+		{ closed_running,             -1,             -1,             -1,             -1,            set,             -1 },
+	},
+	.initial_state = init,
+	.final_states = { 1, 0, 0, 0, 0, 0, 0 },
+};
diff --git a/kernel/trace/rv/monitor_safe_wtd_nwo/safe_wtd_nwo.c b/kernel/trace/rv/monitor_safe_wtd_nwo/safe_wtd_nwo.c
new file mode 100644
index 000000000000..e19e10da0dc1
--- /dev/null
+++ b/kernel/trace/rv/monitor_safe_wtd_nwo/safe_wtd_nwo.c
@@ -0,0 +1,309 @@
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/da_monitor.h>
+
+#include <linux/watchdog.h>
+#include <linux/moduleparam.h>
+
+#define MODULE_NAME "safe_wtd_nwo"
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "model.h"
+
+/*
+ * Declare the deterministic automata monitor.
+ *
+ * The rv monitor reference is needed for the monitor declaration.
+ */
+struct rv_monitor rv_safe_wtd_nwo;
+DECLARE_DA_MON_GLOBAL(safe_wtd_nwo, char);
+
+#define CREATE_TRACE_POINTS
+#include "safe_wtd_nwo.h"
+
+/*
+ * custom: safe_timeout is the maximum value a watchdog monitor
+ * can set. This value is registered here to duplicate the information.
+ * In this way, a miss-behaving monitor can be detected.
+ */
+static int safe_timeout = ~0;
+module_param(safe_timeout, int, 0444);
+
+/*
+ * custom: if check_timeout is set, the monitor will check if the time left
+ * in the watchdog is less than or equals to the last safe timeout set by
+ * user-space. This check is done after each ping. In this way, if any
+ * code by-passed the watchdog dev interface setting a higher (so unsafe)
+ * timeout, this monitor will catch the side effect and react.
+ */
+static int last_timeout_set = 0;
+static int check_timeout = 0;
+module_param(check_timeout, int, 0444);
+
+/*
+ * custom: if dont_stop is set the monitor will react if stopped.
+ */
+static int dont_stop = 0;
+module_param(dont_stop, int, 0444);
+
+/*
+ * custom: there are some states that are kept after the watchdog is closed.
+ * For example, the nowayout state.
+ *
+ * Thus, the RV monitor needs to keep track of these states after a start/stop
+ * of the RV monitor itself, and should not reset after each restart - keeping the
+ * know state until the system shutdown.
+ *
+ * If for an unknown reason an RV monitor would like to reset the RV monitor at each
+ * RV monitor start, set it to one.
+ */
+static int reset_on_restart = 0;
+module_param(reset_on_restart, int, 0444);
+
+/*
+ * open_pid takes note of the first thread that opened the watchdog.
+ *
+ * Any other thread that generates an event will cause an "other_threads"
+ * event in the monitor.
+ */
+static int open_pid = 0;
+
+/*
+ * watchdog_id: the watchdog to monitor
+ */
+static int watchdog_id = 0;
+module_param(watchdog_id, int, 0444);
+
+static void handle_nowayout(void *data, struct watchdog_device *wdd)
+{
+	if (wdd->id != watchdog_id)
+		return;
+
+	da_handle_init_run_event_safe_wtd_nwo(nowayout);
+}
+
+static void handle_close(void *data, struct watchdog_device *wdd)
+{
+	if (wdd->id != watchdog_id)
+		return;
+
+	if (open_pid && current->pid != open_pid) {
+		da_handle_init_run_event_safe_wtd_nwo(other_threads);
+	} else {
+		da_handle_event_safe_wtd_nwo(close);
+		open_pid = 0;
+	}
+}
+
+static void handle_open(void *data, struct watchdog_device *wdd)
+{
+	if (wdd->id != watchdog_id)
+		return;
+
+	if (open_pid && current->pid != open_pid) {
+		da_handle_init_run_event_safe_wtd_nwo(other_threads);
+	} else {
+		da_handle_init_run_event_safe_wtd_nwo(open);
+		open_pid = current->pid;
+	}
+}
+
+static void blocked_events(void *data, struct watchdog_device *wdd)
+{
+	if (wdd->id != watchdog_id)
+		return;
+
+	if (open_pid && current->pid != open_pid) {
+		da_handle_init_run_event_safe_wtd_nwo(other_threads);
+		return;
+	}
+	da_handle_event_safe_wtd_nwo(other_threads);
+}
+
+static void handle_ping(void *data, struct watchdog_device *wdd)
+{
+	char msg[128];
+	unsigned int timeout;
+
+	if (wdd->id != watchdog_id)
+		return;
+
+	if (open_pid && current->pid != open_pid) {
+		da_handle_init_run_event_safe_wtd_nwo(other_threads);
+		return;
+	}
+
+	da_handle_event_safe_wtd_nwo(ping);
+
+	if (!check_timeout)
+		return;
+
+	if (wdd->ops->get_timeleft) {
+		timeout = wdd->ops->get_timeleft(wdd);
+		if (timeout > last_timeout_set) {
+			snprintf(msg, 128,
+				 "watchdog timout is %u > than previously set (%d)\n",
+				 timeout, last_timeout_set);
+			cond_react(msg);
+		}
+	} else {
+		snprintf(msg, 128, "error getting timeout: option not supported\n");
+		cond_react(msg);
+	}
+}
+
+static void handle_set_safe_timeout(void *data, struct watchdog_device *wdd, unsigned long timeout)
+{
+	char msg[128];
+
+	if (wdd->id != watchdog_id)
+		return;
+
+	if (open_pid && current->pid != open_pid) {
+		da_handle_init_run_event_safe_wtd_nwo(other_threads);
+		return;
+	}
+
+	da_handle_event_safe_wtd_nwo(set_safe_timeout);
+
+	if (timeout > safe_timeout) {
+		snprintf(msg, 128, "set safety timeout is too high: %d", (int) timeout);
+		cond_react(msg);
+	}
+
+	if (check_timeout)
+		last_timeout_set = timeout;
+}
+
+static void handle_start(void *data, struct watchdog_device *wdd)
+{
+	if (wdd->id != watchdog_id)
+		return;
+
+	if (open_pid && current->pid != open_pid) {
+		da_handle_init_run_event_safe_wtd_nwo(other_threads);
+		return;
+	}
+
+	da_handle_event_safe_wtd_nwo(start);
+}
+
+#define NR_TP	9
+static struct tracepoint_hook_helper tracepoints_to_hook[NR_TP] = {
+	{
+		.probe = handle_close,
+		.name = "watchdog_close",
+		.registered = 0
+	},
+	{
+		.probe = handle_nowayout,
+		.name = "watchdog_nowayout",
+		.registered = 0
+	},
+	{
+		.probe = handle_open,
+		.name = "watchdog_open",
+		.registered = 0
+	},
+	{
+		.probe = handle_ping,
+		.name = "watchdog_ping",
+		.registered = 0
+	},
+	{
+		.probe = handle_set_safe_timeout,
+		.name = "watchdog_set_timeout",
+		.registered = 0
+	},
+	{
+		.probe = handle_start,
+		.name = "watchdog_start",
+		.registered = 0
+	},
+	{
+		.probe = blocked_events,
+		.name = "watchdog_stop",
+		.registered = 0
+	},
+	{
+		.probe = blocked_events,
+		.name = "watchdog_set_keep_alive",
+		.registered = 0
+	},
+	{
+		.probe = blocked_events,
+		.name = "watchdog_keep_alive",
+		.registered = 0
+	},
+};
+
+static int mon_started = 0;
+
+static int start_safe_wtd_nwo(void)
+{
+	int retval;
+
+	if (!mon_started || reset_on_restart) {
+		da_monitor_init_safe_wtd_nwo();
+		mon_started = 1;
+	}
+
+	retval = thh_hook_probes(tracepoints_to_hook, NR_TP);
+	if (retval)
+		goto out_err;
+
+	return 0;
+
+out_err:
+	return -EINVAL;
+}
+
+static void stop_safe_wtd_nwo(void)
+{
+	if (dont_stop)
+		cond_react("dont_stop safe_wtd_nwo is set.");
+
+	rv_safe_wtd_nwo.enabled = 0;
+	thh_unhook_probes(tracepoints_to_hook, NR_TP);
+	return;
+}
+
+/*
+ * This is the monitor register section.
+ */
+struct rv_monitor rv_safe_wtd_nwo = {
+	.name = "safe_wtd_nwo",
+	.description = "A watchdog monitor guarding a safety monitor actions, nowayout required.",
+	.start = start_safe_wtd_nwo,
+	.stop = stop_safe_wtd_nwo,
+	.reset = da_monitor_reset_all_safe_wtd_nwo,
+	.enabled = 0,
+};
+
+int register_safe_wtd_nwo(void)
+{
+	rv_register_monitor(&rv_safe_wtd_nwo);
+	return 0;
+}
+
+void unregister_safe_wtd_nwo(void)
+{
+	if (rv_safe_wtd_nwo.enabled)
+		stop_safe_wtd_nwo();
+
+	rv_unregister_monitor(&rv_safe_wtd_nwo);
+}
+
+module_init(register_safe_wtd_nwo);
+module_exit(unregister_safe_wtd_nwo);
+
+MODULE_LICENSE("GPL v2");
+MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
+MODULE_DESCRIPTION("Safe watchdog RV monitor nowayout");
diff --git a/kernel/trace/rv/monitor_safe_wtd_nwo/safe_wtd_nwo.h b/kernel/trace/rv/monitor_safe_wtd_nwo/safe_wtd_nwo.h
new file mode 100644
index 000000000000..0d33800b0972
--- /dev/null
+++ b/kernel/trace/rv/monitor_safe_wtd_nwo/safe_wtd_nwo.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv
+
+#if !defined(_SAFETY_MONITOR_NWO_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _SAFETY_MONITOR_NWO_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(event_safe_wtd_nwo,
+
+	TP_PROTO(char state, char event, char next_state, bool safe),
+
+	TP_ARGS(state, event, next_state, safe),
+
+	TP_STRUCT__entry(
+		__field(	char,		state		)
+		__field(	char,		event		)
+		__field(	char,		next_state	)
+		__field(	bool,		safe		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->event = event;
+		__entry->next_state = next_state;
+		__entry->safe = safe;
+	),
+
+	TP_printk("%s x %s -> %s %s",
+		model_get_state_name_safe_wtd_nwo(__entry->state),
+		model_get_event_name_safe_wtd_nwo(__entry->event),
+		model_get_state_name_safe_wtd_nwo(__entry->next_state),
+		__entry->safe ? "(safe)" : "")
+);
+
+TRACE_EVENT(error_safe_wtd_nwo,
+
+	TP_PROTO(char state, char event),
+
+	TP_ARGS(state, event),
+
+	TP_STRUCT__entry(
+		__field(	char,		state		)
+		__field(	char,		event		)
+	),
+
+	TP_fast_assign(
+		__entry->state = state;
+		__entry->event = event;
+	),
+
+	TP_printk("event %s not expected in the state %s",
+		model_get_event_name_safe_wtd_nwo(__entry->event),
+		model_get_state_name_safe_wtd_nwo(__entry->state))
+);
+
+#endif /* _SAFETY_MONITOR_NWO_H */
+
+/* This part ust be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH ../kernel/trace/rv/monitor_safe_wtd_nwo/
+#define TRACE_INCLUDE_FILE safe_wtd_nwo
+#include <trace/define_trace.h>
-- 
2.33.1

