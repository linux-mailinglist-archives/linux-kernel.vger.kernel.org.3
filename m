Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86E124B4E28
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350739AbiBNLWp convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:22:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50198 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351045AbiBNLVt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:21:49 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 993A728E03
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:58:02 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-510-uMtCYzVQMwmav8KewIsXpQ-1; Mon, 14 Feb 2022 05:46:51 -0500
X-MC-Unique: uMtCYzVQMwmav8KewIsXpQ-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id C527A1091DA1;
        Mon, 14 Feb 2022 10:46:49 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 3039A26E74;
        Mon, 14 Feb 2022 10:46:43 +0000 (UTC)
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
        linux-trace-devel@vger.kernel.org
Subject: [RFC V2 08/21] rv/monitor: Add the wip monitor skeleton created by dot2k
Date:   Mon, 14 Feb 2022 11:44:59 +0100
Message-Id: <a0c00c72bdb6fc183a67df3c8d913f990e2b522b.1644830251.git.bristot@kernel.org>
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
 kernel/trace/rv/monitor_wip/wip.c   | 124 ++++++++++++++++++++++++++++
 kernel/trace/rv/monitor_wip/wip.h   |  64 ++++++++++++++
 3 files changed, 226 insertions(+)
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
index 000000000000..1aec75e683d2
--- /dev/null
+++ b/kernel/trace/rv/monitor_wip/wip.c
@@ -0,0 +1,124 @@
+#include <linux/ftrace.h>
+#include <linux/tracepoint.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/rv.h>
+#include <rv/da_monitor.h>
+
+#define MODULE_NAME "wip"
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
+
+void handle_preempt_disable(void *data, /* XXX: fill header */)
+{
+	da_handle_event_wip(preempt_disable);
+}
+
+void handle_preempt_enable(void *data, /* XXX: fill header */)
+{
+	da_handle_event_wip(preempt_enable);
+}
+
+void handle_sched_waking(void *data, /* XXX: fill header */)
+{
+	da_handle_event_wip(sched_waking);
+}
+
+#define NR_TP   3
+static struct tracepoint_hook_helper tracepoints_to_hook[NR_TP] = {
+	{
+		.probe = handle_preempt_disable,
+		.name = /* XXX: tracepoint name here */,
+		.registered = 0
+	},
+	{
+		.probe = handle_preempt_enable,
+		.name = /* XXX: tracepoint name here */,
+		.registered = 0
+	},
+	{
+		.probe = handle_sched_waking,
+		.name = /* XXX: tracepoint name here */,
+		.registered = 0
+	},
+};
+
+static int start_wip(void)
+{
+	int retval;
+
+	da_monitor_init_wip();
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
+static void stop_wip(void)
+{
+	rv_wip.enabled = 0;
+	thh_unhook_probes(tracepoints_to_hook, NR_TP);
+	return;
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
+MODULE_LICENSE("GPL v2");
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
2.33.1

