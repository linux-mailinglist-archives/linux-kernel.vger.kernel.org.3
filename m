Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3EBAB58054A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:14:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236792AbiGYUOP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:14:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46674 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237011AbiGYUNU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:13:20 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 54B882126E;
        Mon, 25 Jul 2022 13:12:58 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0C0C3B81100;
        Mon, 25 Jul 2022 20:12:57 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 36C65C36AE5;
        Mon, 25 Jul 2022 20:12:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658779975;
        bh=XgFnOX3T8eO26Fi31ftl6wH/3YfHPEwqxI2W3JB9lq8=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WhauyiTeBxFzbREy5FucjiE+THnhIPszlFYG6AXfvwoptygDA0z0I18Zs/+MeOkFM
         W/xjVmj3kZJko55DIAdoGkfhoXAEi6pFR/wdp7rPD9XZC0gM6C+l/+XcfbZC/IMpAN
         khsOmSH8jwAoxEyFyXdEmIcocnJ8pqT1199BCO5Rh0CGxy0AMDHglFC5eTM9RJg/ps
         MrGOv5uRQ1vFg7j/MCfL3InsAbQ0K9s6gVowxgrcBio+kLmt2K3CFdyuD94UF/9j7P
         rmf4BFjx72rRGkNniKbSQar6Ha1pE46vR/bZy9SDikwmD6fvwJ5GaSneGzt4/bODnH
         ii6FVnwyyLL5A==
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
Subject: [PATCH V7 13/16] rv/monitor: Add the wip monitor
Date:   Mon, 25 Jul 2022 22:11:25 +0200
Message-Id: <0a0527d70fb9e067b537bcd8075b0361a8159920.1658778484.git.bristot@kernel.org>
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

The wakeup in preemptive (wip) monitor verifies if the
wakeup events always take place with preemption disabled:

                     |
                     |
                     v
                   #==================#
                   H    preemptive    H <+
                   #==================#  |
                     |                   |
                     | preempt_disable   | preempt_enable
                     v                   |
    sched_waking   +------------------+  |
  +--------------- |                  |  |
  |                |  non_preemptive  |  |
  +--------------> |                  | -+
                   +------------------+

The wakeup event always takes place with preemption disabled because
of the scheduler synchronization. However, because the preempt_count
and its trace event are not atomic with regard to interrupts, some
inconsistencies might happen.

The documentation illustrates one of these cases.

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
 Documentation/trace/rv/index.rst       |  1 +
 Documentation/trace/rv/monitor_wip.rst | 55 ++++++++++++++++++++++++++
 include/trace/events/rv.h              | 10 +++++
 kernel/trace/rv/Kconfig                | 13 ++++++
 kernel/trace/rv/Makefile               |  1 +
 kernel/trace/rv/monitors/wip/wip.c     | 51 +++++++-----------------
 tools/verification/models/wip.dot      | 16 ++++++++
 7 files changed, 111 insertions(+), 36 deletions(-)
 create mode 100644 Documentation/trace/rv/monitor_wip.rst
 create mode 100644 tools/verification/models/wip.dot

diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index db2ae3f90b90..4cb71ed628b8 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -10,3 +10,4 @@ Runtime Verification
    deterministic_automata.rst
    da_monitor_synthesis.rst
    da_monitor_instrumentation.rst
+   monitor_wip.rst
diff --git a/Documentation/trace/rv/monitor_wip.rst b/Documentation/trace/rv/monitor_wip.rst
new file mode 100644
index 000000000000..a95763438c48
--- /dev/null
+++ b/Documentation/trace/rv/monitor_wip.rst
@@ -0,0 +1,55 @@
+Monitor wip
+===========
+
+- Name: wip - wakeup in preemptive
+- Type: per-cpu deterministic automaton
+- Author: Daniel Bristot de Oliveira <bristot@kernel.org>
+
+Description
+-----------
+
+The wakeup in preemptive (wip) monitor is a sample per-cpu monitor
+that verifies if the wakeup events always take place with
+preemption disabled::
+
+                     |
+                     |
+                     v
+                   #==================#
+                   H    preemptive    H <+
+                   #==================#  |
+                     |                   |
+                     | preempt_disable   | preempt_enable
+                     v                   |
+    sched_waking   +------------------+  |
+  +--------------- |                  |  |
+  |                |  non_preemptive  |  |
+  +--------------> |                  | -+
+                   +------------------+
+
+The wakeup event always takes place with preemption disabled because
+of the scheduler synchronization. However, because the preempt_count
+and its trace event are not atomic with regard to interrupts, some
+inconsistencies might happen. For example::
+
+  preempt_disable() {
+	__preempt_count_add(1)
+	------->	smp_apic_timer_interrupt() {
+				preempt_disable()
+					do not trace (preempt count >= 1)
+
+				wake up a thread
+
+				preempt_enable()
+					 do not trace (preempt count >= 1)
+			}
+	<------
+	trace_preempt_disable();
+  }
+
+This problem was reported and discussed here:
+  https://lore.kernel.org/r/cover.1559051152.git.bristot@redhat.com/
+
+Specification
+-------------
+Grapviz Dot file in tools/verification/models/wip.dot
diff --git a/include/trace/events/rv.h b/include/trace/events/rv.h
index 20a2e09c6416..e972f27d8df3 100644
--- a/include/trace/events/rv.h
+++ b/include/trace/events/rv.h
@@ -56,6 +56,16 @@ DECLARE_EVENT_CLASS(error_da_monitor,
 		__entry->event,
 		__entry->state)
 );
+
+#ifdef CONFIG_RV_MON_WIP
+DEFINE_EVENT(event_da_monitor, event_wip,
+	    TP_PROTO(char *state, char *event, char *next_state, bool final_state),
+	    TP_ARGS(state, event, next_state, final_state));
+
+DEFINE_EVENT(error_da_monitor, error_wip,
+	     TP_PROTO(char *state, char *event),
+	     TP_ARGS(state, event));
+#endif /* CONFIG_RV_MON_WIP */
 #endif /* CONFIG_DA_MON_EVENTS_IMPLICIT */
 
 #ifdef CONFIG_DA_MON_EVENTS_ID
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 0d9552b406c6..e50f3346164a 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -25,6 +25,19 @@ menuconfig RV
 	  For further information, see:
 	    Documentation/trace/rv/runtime-verification.rst
 
+config RV_MON_WIP
+	depends on RV
+	depends on PREEMPT_TRACER
+	select DA_MON_EVENTS_IMPLICIT
+	bool "wip monitor"
+	help
+	  Enable wip (wakeup in preemptive) sample monitor that illustrates
+	  the usage of per-cpu monitors, and one limitation of the
+	  preempt_disable/enable events.
+
+	  For further information, see:
+	    Documentation/trace/rv/monitor_wip.rst
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
index 8944274d9b41..b41109d2750a 100644
--- a/kernel/trace/rv/Makefile
+++ b/kernel/trace/rv/Makefile
@@ -2,3 +2,4 @@
 
 obj-$(CONFIG_RV) += rv.o
 obj-$(CONFIG_RV_REACTORS) += rv_reactors.o
+obj-$(CONFIG_RV_MON_WIP) += monitors/wip/wip.o
diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
index 79a054ca0cde..e31167ae02b5 100644
--- a/kernel/trace/rv/monitors/wip/wip.c
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -10,44 +10,26 @@
 
 #define MODULE_NAME "wip"
 
-/*
- * XXX: include required tracepoint headers, e.g.,
- * #include <linux/trace/events/sched.h>
- */
 #include <trace/events/rv.h>
+#include <trace/events/sched.h>
+#include <trace/events/preemptirq.h>
 
-/*
- * This is the self-generated part of the monitor. Generally, there is no need
- * to touch this section.
- */
 #include "wip.h"
 
-/*
- * Declare the deterministic automata monitor.
- *
- * The rv monitor reference is needed for the monitor declaration.
- */
 struct rv_monitor rv_wip;
 DECLARE_DA_MON_PER_CPU(wip, unsigned char);
 
-/*
- * This is the instrumentation part of the monitor.
- *
- * This is the section where manual work is required. Here the kernel events
- * are translated into model's event.
- *
- */
-static void handle_preempt_disable(void *data, /* XXX: fill header */)
+static void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
 {
-	da_handle_event_wip(preempt_disable_wip);
+	da_handle_start_event_wip(preempt_disable_wip);
 }
 
-static void handle_preempt_enable(void *data, /* XXX: fill header */)
+static void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
 {
 	da_handle_event_wip(preempt_enable_wip);
 }
 
-static void handle_sched_waking(void *data, /* XXX: fill header */)
+static void handle_sched_waking(void *data, struct task_struct *task)
 {
 	da_handle_event_wip(sched_waking_wip);
 }
@@ -60,9 +42,9 @@ static int enable_wip(void)
 	if (retval)
 		return retval;
 
-	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_disable);
-	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_enable);
-	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_sched_waking);
+	rv_attach_trace_probe("wip", preempt_enable, handle_preempt_enable);
+	rv_attach_trace_probe("wip", sched_waking, handle_sched_waking);
+	rv_attach_trace_probe("wip", preempt_disable, handle_preempt_disable);
 
 	return 0;
 }
@@ -71,19 +53,16 @@ static void disable_wip(void)
 {
 	rv_wip.enabled = 0;
 
-	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_disable);
-	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_enable);
-	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_sched_waking);
+	rv_detach_trace_probe("wip", preempt_disable, handle_preempt_disable);
+	rv_detach_trace_probe("wip", preempt_enable, handle_preempt_enable);
+	rv_detach_trace_probe("wip", sched_waking, handle_sched_waking);
 
 	da_monitor_destroy_wip();
 }
 
-/*
- * This is the monitor register section.
- */
 struct rv_monitor rv_wip = {
 	.name = "wip",
-	.description = "auto-generated wip",
+	.description = "wakeup in preemptive per-cpu testing monitor.",
 	.enable = enable_wip,
 	.disable = disable_wip,
 	.reset = da_monitor_reset_all_wip,
@@ -105,5 +84,5 @@ module_init(register_wip);
 module_exit(unregister_wip);
 
 MODULE_LICENSE("GPL");
-MODULE_AUTHOR("dot2k: auto-generated");
-MODULE_DESCRIPTION("wip");
+MODULE_AUTHOR("Daniel Bristot de Oliveira <bristot@kernel.org>");
+MODULE_DESCRIPTION("wip: wakeup in preemptive - per-cpu sample monitor.");
diff --git a/tools/verification/models/wip.dot b/tools/verification/models/wip.dot
new file mode 100644
index 000000000000..2a53a9700a89
--- /dev/null
+++ b/tools/verification/models/wip.dot
@@ -0,0 +1,16 @@
+digraph state_automaton {
+	{node [shape = circle] "non_preemptive"};
+	{node [shape = plaintext, style=invis, label=""] "__init_preemptive"};
+	{node [shape = doublecircle] "preemptive"};
+	{node [shape = circle] "preemptive"};
+	"__init_preemptive" -> "preemptive";
+	"non_preemptive" [label = "non_preemptive"];
+	"non_preemptive" -> "non_preemptive" [ label = "sched_waking" ];
+	"non_preemptive" -> "preemptive" [ label = "preempt_enable" ];
+	"preemptive" [label = "preemptive"];
+	"preemptive" -> "non_preemptive" [ label = "preempt_disable" ];
+	{ rank = min ;
+		"__init_preemptive";
+		"preemptive";
+	}
+}
-- 
2.35.1

