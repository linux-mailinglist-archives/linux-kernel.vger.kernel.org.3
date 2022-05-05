Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 377E351C4D2
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:11:51 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381777AbiEEQMF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:12:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1381746AbiEEQLw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:11:52 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5CCE5C667;
        Thu,  5 May 2022 09:07:56 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 7D99AB82DF4;
        Thu,  5 May 2022 16:07:55 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 84F62C385B3;
        Thu,  5 May 2022 16:07:50 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651766874;
        bh=klaEUR0NZ1KM/QJT1bStAAWRqh9uRYsY58s/dwSZMfg=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=m0KIj1qpqqA9D9cNK1d5/9BWpHfYY6Vx6B8Ttjsxw2E95PT/k0onE8nUAhSg2TQj6
         gPiJXGTDBwmQ4xLDIvZnQ7oCg8vn57OJamCZbem13CpgjIWgsF4+JU9+74wY7xE2Tq
         8RvU+h49biMErKYfiLn+d19GkUwruDEuHgHlbr/S0uJqsiV1RnuYHmYMfaD6mmyrNC
         5LrnQLUjo6ryVVEHW3InpKWHdy/2v/oFyd0b072BCUM8eETZeDiYqNJmwEEbF2LmqC
         TfwpgDtSM0v8jfqj3Sr52bj+PjgVZ4TQanBiBNQfqMO6Sng97W4ac3oCo10+w5hklx
         uD4drrTjIgAWA==
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
Subject: [RFC V3 08/20] rv/monitor: Add the wip monitor skeleton created by dot2k
Date:   Thu,  5 May 2022 18:06:48 +0200
Message-Id: <2e2bd513d229ad96fbb014a75cc628e83f5f3b03.1651766361.git.bristot@kernel.org>
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

This is the direct output this command line:
  $ dot2k -d ~/wip.dot -t per_cpu

with wip.dot as:
 ----- %< -----
digraph state_automaton {
	center = true;
	size = "7,11";
	rankdir = LR;
	{node [shape = circle] "non_preemptive"};
	{node [shape = plaintext, style=invis, label=""] "__init_preemptive"};
	{node [shape = doublecircle] "preemptive"};
	{node [shape = circle] "preemptive"};
	"__init_preemptive" -> "preemptive";
	"non_preemptive" [label = "non_preemptive"];
	"non_preemptive" -> "non_preemptive" [ label = "sched_waking" ];
	"non_preemptive" -> "preemptive" [ label = "preempt_enable" ];
	"preemptive" [label = "preemptive"];
	"preemptive" -> "non_preemptive" [ label = "preempt_disable" ];
	{ rank = min ;
		"__init_preemptive";
		"preemptive";
	}
}
 ----- >% -----

This model is broken because preempt_disable_notrace(). It is broken on
purpose to test the reactors.

It does not compile because it lacks the instrumentation, which will be
add next.

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
 kernel/trace/rv/monitor_wip/model.h |  38 +++++++++
 kernel/trace/rv/monitor_wip/wip.c   | 115 ++++++++++++++++++++++++++++
 kernel/trace/rv/monitor_wip/wip.h   |  64 ++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 kernel/trace/rv/monitor_wip/model.h
 create mode 100644 kernel/trace/rv/monitor_wip/wip.c
 create mode 100644 kernel/trace/rv/monitor_wip/wip.h

diff --git a/kernel/trace/rv/monitor_wip/model.h b/kernel/trace/rv/monitor_wip/model.h
new file mode 100644
index 000000000000..5212ba5b1dfb
--- /dev/null
+++ b/kernel/trace/rv/monitor_wip/model.h
@@ -0,0 +1,38 @@
+enum states_wip {
+	preemptive = 0,
+	non_preemptive,
+	state_max
+};
+
+enum events_wip {
+	preempt_disable = 0,
+	preempt_enable,
+	sched_waking,
+	event_max
+};
+
+struct automaton_wip {
+	char *state_names[state_max];
+	char *event_names[event_max];
+	char function[state_max][event_max];
+	char initial_state;
+	char final_states[state_max];
+};
+
+struct automaton_wip automaton_wip = {
+	.state_names = {
+		"preemptive",
+		"non_preemptive"
+	},
+	.event_names = {
+		"preempt_disable",
+		"preempt_enable",
+		"sched_waking"
+	},
+	.function = {
+		{ non_preemptive,             -1,             -1 },
+		{             -1,     preemptive, non_preemptive },
+	},
+	.initial_state = preemptive,
+	.final_states = { 1, 0 },
+};
\ No newline at end of file
diff --git a/kernel/trace/rv/monitor_wip/wip.c b/kernel/trace/rv/monitor_wip/wip.c
new file mode 100644
index 000000000000..cd7795b282d6
--- /dev/null
+++ b/kernel/trace/rv/monitor_wip/wip.c
@@ -0,0 +1,115 @@
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
+#define MODULE_NAME "wip"
+
+/*
+ * XXX: include required tracepoint headers, e.g.,
+ * #include <linux/trace/events/sched.h>
+ */
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
+struct rv_monitor rv_wip;
+DECLARE_DA_MON_PER_CPU(wip, char);
+
+#define CREATE_TRACE_POINTS
+#include "wip.h"
+
+/*
+ * This is the instrumentation part of the monitor.
+ *
+ * This is the section where manual work is required. Here the kernel events
+ * are translated into model's event.
+ *
+ */
+static void handle_preempt_disable(void *data, /* XXX: fill header */)
+{
+	da_handle_event_wip(preempt_disable);
+}
+
+static void handle_preempt_enable(void *data, /* XXX: fill header */)
+{
+	da_handle_event_wip(preempt_enable);
+}
+
+static void handle_sched_waking(void *data, /* XXX: fill header */)
+{
+	da_handle_event_wip(sched_waking);
+}
+
+
+static int start_wip(void)
+{
+	int retval;
+
+	retval = da_monitor_init_wip();
+	if (retval)
+		return retval;
+
+	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_disable);
+	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_enable);
+	rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_sched_waking);
+
+	return 0;
+}
+
+static void stop_wip(void)
+{
+	rv_wip.enabled = 0;
+
+	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_disable);
+	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_enable);
+	rv_detach_trace_probe("wip", /* XXX: tracepoint */, handle_sched_waking);
+
+	da_monitor_destroy_wip();
+}
+
+/*
+ * This is the monitor register section.
+ */
+struct rv_monitor rv_wip = {
+	.name = "wip",
+	.description = "auto-generated wip",
+	.start = start_wip,
+	.stop = stop_wip,
+	.reset = da_monitor_reset_all_wip,
+	.enabled = 0,
+};
+
+int register_wip(void)
+{
+	rv_register_monitor(&rv_wip);
+	return 0;
+}
+
+void unregister_wip(void)
+{
+	if (rv_wip.enabled)
+		stop_wip();
+
+	rv_unregister_monitor(&rv_wip);
+}
+
+module_init(register_wip);
+module_exit(unregister_wip);
+
+MODULE_LICENSE("GPL");
+MODULE_AUTHOR("dot2k: auto-generated");
+MODULE_DESCRIPTION("wip");
diff --git a/kernel/trace/rv/monitor_wip/wip.h b/kernel/trace/rv/monitor_wip/wip.h
new file mode 100644
index 000000000000..7a751a8896e9
--- /dev/null
+++ b/kernel/trace/rv/monitor_wip/wip.h
@@ -0,0 +1,64 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#undef TRACE_SYSTEM
+#define TRACE_SYSTEM rv
+
+#if !defined(_WIP_TRACE_H) || defined(TRACE_HEADER_MULTI_READ)
+#define _WIP_TRACE_H
+
+#include <linux/tracepoint.h>
+
+TRACE_EVENT(event_wip,
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
+		model_get_state_name_wip(__entry->state),
+		model_get_event_name_wip(__entry->event),
+		model_get_state_name_wip(__entry->next_state),
+		__entry->safe ? "(safe)" : "")
+);
+
+TRACE_EVENT(error_wip,
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
+		model_get_event_name_wip(__entry->event),
+		model_get_state_name_wip(__entry->state))
+);
+
+#endif /* _WIP_H */
+
+/* This part ust be outside protection */
+#undef TRACE_INCLUDE_PATH
+#define TRACE_INCLUDE_PATH .
+#define TRACE_INCLUDE_FILE wip
+#include <trace/define_trace.h>
-- 
2.35.1

