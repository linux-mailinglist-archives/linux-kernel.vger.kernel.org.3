Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87F4B58054E
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:14:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237032AbiGYUOc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:14:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236412AbiGYUNb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:13:31 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3838622503;
        Mon, 25 Jul 2022 13:13:04 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 6F76BCE13D1;
        Mon, 25 Jul 2022 20:13:02 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 415C6C341CE;
        Mon, 25 Jul 2022 20:12:56 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658779980;
        bh=7ki6Q2Ml1rGm+VkjegkEdRM3Ii0a4PDuPinI0FDioOc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=mJu5QdhXBjgs70sMPr81swOBbZuoeXwGfrh/pzYu0Ikqk/sgWzxEGlcFrbPK6DeEK
         AUvTztqX9WkHUrfVqpcqMj3TH5rcOqzuTZuVeBhUIRoHE4djiys5348cNfY1hBgpHV
         jMwAdhaGFL/mg5EPikiaSIUPlkBbjKdggNW2ll07FuXlF+mIMI1wZM577KSZXGypuy
         wPRW+Y1WM/a7gRO5OqhEPnu/cJhEvN/vqN68clEN6oYbGE6GFeWCy/tG5neO/mkLCl
         JbnXRHDj7F7mTOIiGKWuEKWj9wAUOTmiOtHqzq07wTK/yDUitO8fo4xqxiJX25lCOA
         gJaIoXveYXhZw==
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
Subject: [PATCH V7 14/16] rv/monitor: Add the wwnr monitor
Date:   Mon, 25 Jul 2022 22:11:26 +0200
Message-Id: <5ff152e9b419a721fd2cf62df8d76aaa85d53869.1658778484.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1658778484.git.bristot@kernel.org>
References: <cover.1658778484.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Per task wakeup while not running (wwnr) monitor.

This model is broken, the reason is that a task can be running in the
processor without being set as RUNNABLE. Think about a task about to
sleep:

1:      set_current_state(TASK_UNINTERRUPTIBLE);
2:      schedule();

And then imagine an IRQ happening in between the lines one and two,
waking the task up. BOOM, the wakeup will happen while the task is
running.

Q: Why do we need this model, so?
A: To test the reactors.

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
 Documentation/trace/rv/index.rst        |  1 +
 Documentation/trace/rv/monitor_wwnr.rst | 45 +++++++++++++
 include/trace/events/rv.h               | 12 ++++
 kernel/trace/rv/Kconfig                 | 12 ++++
 kernel/trace/rv/Makefile                |  1 +
 kernel/trace/rv/monitors/wwnr/wwnr.c    | 87 +++++++++++++++++++++++++
 kernel/trace/rv/monitors/wwnr/wwnr.h    | 46 +++++++++++++
 tools/verification/models/wwnr.dot      | 16 +++++
 8 files changed, 220 insertions(+)
 create mode 100644 Documentation/trace/rv/monitor_wwnr.rst
 create mode 100644 kernel/trace/rv/monitors/wwnr/wwnr.c
 create mode 100644 kernel/trace/rv/monitors/wwnr/wwnr.h
 create mode 100644 tools/verification/models/wwnr.dot

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index 4cb71ed628b8..15fa966102c0 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -11,3 +11,4 @@ Runtime Verification
    da_monitor_synthesis.rst
    da_monitor_instrumentation.rst
    monitor_wip.rst
+   monitor_wwnr.rst
diff --git a/Documentation/trace/rv/monitor_wwnr.rst b/Documentation/trace/rv/monitor_wwnr.rst
new file mode 100644
index 000000000000..80f1777b85aa
--- /dev/null
+++ b/Documentation/trace/rv/monitor_wwnr.rst
@@ -0,0 +1,45 @@
+Monitor wwnr
+============
+
+- Name: wwrn - wakeup while not running
+- Type: per-task deterministic automaton
+- Author: Daniel Bristot de Oliveira <bristot@kernel.org>
+
+Description
+-----------
+
+This is a per-task sample monitor, with the following
+definition::
+
+               |
+               |
+               v
+    wakeup   +-------------+
+  +--------- |             |
+  |          | not_running |
+  +--------> |             | <+
+             +-------------+  |
+               |              |
+               | switch_in    | switch_out
+               v              |
+             +-------------+  |
+             |   running   | -+
+             +-------------+
+
+This model is borken, the reason is that a task can be running
+in the processor without being set as RUNNABLE. Think about a
+task about to sleep::
+
+  1:      set_current_state(TASK_UNINTERRUPTIBLE);
+  2:      schedule();
+
+And then imagine an IRQ happening in between the lines one and two,
+waking the task up. BOOM, the wakeup will happen while the task is
+running.
+
+- Why do we need this model, so?
+- To test the reactors.
+
+Specification
+-------------
+Grapviz Dot file in tools/verification/models/wwnr.dot
diff --git a/include/trace/events/rv.h b/include/trace/events/rv.h
index e972f27d8df3..56592da9301c 100644
--- a/include/trace/events/rv.h
+++ b/include/trace/events/rv.h
@@ -122,6 +122,18 @@ DECLARE_EVENT_CLASS(error_da_monitor_id,
 		__entry->event,
 		__entry->state)
 );
+
+#ifdef CONFIG_RV_MON_WWNR
+/* id is the pid of the task */
+DEFINE_EVENT(event_da_monitor_id, event_wwnr,
+	     TP_PROTO(int id, char *state, char *event, char *next_state, bool final_state),
+	     TP_ARGS(id, state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor_id, error_wwnr,
+	     TP_PROTO(int id, char *state, char *event),
+	     TP_ARGS(id, state, event));
+#endif /* CONFIG_RV_MON_WWNR */
+
 #endif /* CONFIG_DA_MON_EVENTS_ID */
 #endif /* _TRACE_RV_H */
 
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index e50f3346164a..b259d6e8dc7c 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -38,6 +38,18 @@ config RV_MON_WIP
 	  For further information, see:
 	    Documentation/trace/rv/monitor_wip.rst
 
+config RV_MON_WWNR
+	depends on RV
+	select DA_MON_EVENTS_ID
+	bool "wwnr monitor"
+	help
+	  Enable wwnr (wakeup while not running) sample monitor, this is a
+	  sample monitor that illustrates the usage of per-task monitor.
+	  The model is borken on purpose: it serves to test reactors.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_wwnr.rst
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index b41109d2750a..af0ff9a46418 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -3,3 +3,4 @@
 obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
 obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
+obj-$(CONFIG_RV_MON_WWNR) += monitors/wwnr/wwnr.o
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.c b/kernel/trace/rv/monitors/wwnr/wwnr.c
new file mode 100644
index 000000000000..599225d9cf38
--- /dev/null
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.c
@@ -0,0 +1,87 @@
+// SPDX-License-Identifier: GPL-2.0
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/instrumentation.h>
+#include <rv/da_monitor.h>
+
+#define MODULE_NAME "wwnr"
+
+#include <trace/events/rv.h>
+#include <trace/events/sched.h>
+
+#include "wwnr.h"
+
+struct rv_monitor rv_wwnr;
+DECLARE_DA_MON_PER_TASK(wwnr, unsigned char);
+
+static void handle_switch(void *data, bool preempt, struct task_struct *p,
+			  struct task_struct *n, unsigned int prev_state)
+{
+	/* start monitoring only after the first suspension */
+	if (prev_state == TASK_INTERRUPTIBLE)
+		da_handle_start_event_wwnr(p, switch_out_wwnr);
+	else
+		da_handle_event_wwnr(p, switch_out_wwnr);
+
+	da_handle_event_wwnr(n, switch_in_wwnr);
+}
+
+static void handle_wakeup(void *data, struct task_struct *p)
+{
+	da_handle_event_wwnr(p, wakeup_wwnr);
+}
+
+static int enable_wwnr(void)
+{
+	int retval;
+
+	retval = da_monitor_init_wwnr();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("wwnr", sched_switch, handle_switch);
+	rv_attach_trace_probe("wwnr", sched_wakeup, handle_wakeup);
+
+	return 0;
+}
+
+static void disable_wwnr(void)
+{
+	rv_wwnr.enabled = 0;
+
+	rv_detach_trace_probe("wwnr", sched_switch, handle_switch);
+	rv_detach_trace_probe("wwnr", sched_wakeup, handle_wakeup);
+
+	da_monitor_destroy_wwnr();
+}
+
+struct rv_monitor rv_wwnr = {
+	.name = "wwnr",
+	.description = "wakeup while not running per-task testing model.",
+	.enable = enable_wwnr,
+	.disable = disable_wwnr,
+	.reset = da_monitor_reset_all_wwnr,
+	.enabled = 0,
+};
+
+static int register_wwnr(void)
+{
+	rv_register_monitor(&rv_wwnr);
+	return 0;
+}
+
+static void unregister_wwnr(void)
+{
+	rv_unregister_monitor(&rv_wwnr);
+}
+
+module_init(register_wwnr);
+module_exit(unregister_wwnr);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
+MODULE_DESCRIPTION("wwnr: wakeup while not running monitor");
diff --git a/kernel/trace/rv/monitors/wwnr/wwnr.h b/kernel/trace/rv/monitors/wwnr/wwnr.h
new file mode 100644
index 000000000000..d1afe55cdd4c
--- /dev/null
+++ b/kernel/trace/rv/monitors/wwnr/wwnr.h
@@ -0,0 +1,46 @@
+/*
+ * Automatically generated C representation of wwnr automaton
+ * For further information about this format, see kernel documentation:
+ *   Documentation/trace/rv/deterministic_automata.rst
+ */
+
+enum states_wwnr {
+	not_running_wwnr = 0,
+	running_wwnr,
+	state_max_wwnr
+};
+
+#define INVALID_STATE state_max_wwnr
+
+enum events_wwnr {
+	switch_in_wwnr = 0,
+	switch_out_wwnr,
+	wakeup_wwnr,
+	event_max_wwnr
+};
+
+struct automaton_wwnr {
+	char *state_names[state_max_wwnr];
+	char *event_names[event_max_wwnr];
+	unsigned char function[state_max_wwnr][event_max_wwnr];
+	unsigned char initial_state;
+	bool final_states[state_max_wwnr];
+};
+
+struct automaton_wwnr automaton_wwnr = {
+	.state_names = {
+		"not_running",
+		"running"
+	},
+	.event_names = {
+		"switch_in",
+		"switch_out",
+		"wakeup"
+	},
+	.function = {
+		{       running_wwnr,      INVALID_STATE,   not_running_wwnr },
+		{      INVALID_STATE,   not_running_wwnr,      INVALID_STATE },
+	},
+	.initial_state = not_running_wwnr,
+	.final_states = { 1, 0 },
+};
diff --git a/tools/verification/models/wwnr.dot b/tools/verification/models/wwnr.dot
new file mode 100644
index 000000000000..1b206e83129c
--- /dev/null
+++ b/tools/verification/models/wwnr.dot
@@ -0,0 +1,16 @@
+digraph state_automaton {
+	{node [shape = plaintext, style=invis, label=""] "__init_not_running"};
+	{node [shape = ellipse] "not_running"};
+	{node [shape = plaintext] "not_running"};
+	{node [shape = plaintext] "running"};
+	"__init_not_running" -> "not_running";
+	"not_running" [label = "not_running", color = green3];
+	"not_running" -> "not_running" [ label = "wakeup" ];
+	"not_running" -> "running" [ label = "switch_in" ];
+	"running" [label = "running"];
+	"running" -> "not_running" [ label = "switch_out" ];
+	{ rank = min ;
+		"__init_not_running";
+		"not_running";
+	}
+}
-- 
2.35.1

