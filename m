Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B925C54DD3B
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:46:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359843AbiFPIqi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:46:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34610 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359805AbiFPIqA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:46:00 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E3315DBCD;
        Thu, 16 Jun 2022 01:45:55 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D67F2B81E20;
        Thu, 16 Jun 2022 08:45:53 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3F995C3411F;
        Thu, 16 Jun 2022 08:45:48 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369152;
        bh=ZJ0brquACtNcXCIAgCRgNB+aJ/fU2CSwf1pEP1xdS3c=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rmpY9+pOtMmQn4Yy+VrFIeWB31DRRL5kf9pHv2pn3dg9ADHcEztUGaTGnuSDtJ6FK
         OmGgKEoJYtkHsedir14+rjJXSGEE4KnNz8BPq7sSioUaiR2y8rcdK4v5sJxdtFle0e
         jQ+8CBDW5LNum7z8NWYzn7INcYejQJGJC8Y7CqVWINIQye2LQf6qlf/1CSMbaY7oDi
         /BNuZp2SAHQALxiY3qpXxM0+RcrsqEKps5uDPQgcPREYnMNYZS3p8QJnprDlfTA8jw
         4MOnuKBznzsFdKwX3X8Xe0suHsarKBdbUNesxloU8EcJex0Dmkgfqk6FfjjXYEVRGg
         iYEtuB5wBfVAQ==
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
        linux-doc@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-trace-devel@vger.kernel.org
Subject: [PATCH V4 08/20] rv/monitor: Add the wip monitor skeleton created by dot2k
Date:   Thu, 16 Jun 2022 10:44:50 +0200
Message-Id: <6559fb9064f683fda469849549c72607c0f2ae5b.1655368610.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1655368610.git.bristot@kernel.org>
References: <cover.1655368610.git.bristot@kernel.org>
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
 kernel/trace/rv/monitors/wip/wip.c | 112 +++++++++++++++++++++++++++++
 kernel/trace/rv/monitors/wip/wip.h |  38 ++++++++++
 2 files changed, 150 insertions(+)
 create mode 100644 kernel/trace/rv/monitors/wip/wip.c
 create mode 100644 kernel/trace/rv/monitors/wip/wip.h

diff --git a/kernel/trace/rv/monitors/wip/wip.c b/kernel/trace/rv/monitors/wip/wip.c
new file mode 100644
index 000000000000..08950e09b823
--- /dev/null
+++ b/kernel/trace/rv/monitors/wip/wip.c
@@ -0,0 +1,112 @@
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
+#include <trace/events/rv.h>
+
+/*
+ * This is the self-generated part of the monitor. Generally, there is no need
+ * to touch this section.
+ */
+#include "wip.h"
+
+/*
+ * Declare the deterministic automata monitor.
+ *
+ * The rv monitor reference is needed for the monitor declaration.
+ */
+struct rv_monitor rv_wip;
+DECLARE_DA_MON_PER_CPU(wip, char);
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
+	da_handle_event_wip(preempt_disable_wip);
+}
+
+static void handle_preempt_enable(void *data, /* XXX: fill header */)
+{
+	da_handle_event_wip(preempt_enable_wip);
+}
+
+static void handle_sched_waking(void *data, /* XXX: fill header */)
+{
+	da_handle_event_wip(sched_waking_wip);
+}
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
diff --git a/kernel/trace/rv/monitors/wip/wip.h b/kernel/trace/rv/monitors/wip/wip.h
new file mode 100644
index 000000000000..3055ea331706
--- /dev/null
+++ b/kernel/trace/rv/monitors/wip/wip.h
@@ -0,0 +1,38 @@
+enum states_wip {
+	preemptive_wip = 0,
+	non_preemptive_wip,
+	state_max_wip
+};
+
+enum events_wip {
+	preempt_disable_wip = 0,
+	preempt_enable_wip,
+	sched_waking_wip,
+	event_max_wip
+};
+
+struct automaton_wip {
+	char *state_names[state_max_wip];
+	char *event_names[event_max_wip];
+	char function[state_max_wip][event_max_wip];
+	char initial_state;
+	char final_states[state_max_wip];
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
+		{ non_preemptive_wip,                 -1,                 -1 },
+		{                 -1,     preemptive_wip, non_preemptive_wip },
+	},
+	.initial_state = preemptive_wip,
+	.final_states = { 1, 0 },
+};
-- 
2.35.1

