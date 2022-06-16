Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0022B54DD53
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:48:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376277AbiFPIr0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:47:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36558 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376264AbiFPIqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:46:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2F9595DD39;
        Thu, 16 Jun 2022 01:46:31 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id ECA5461D74;
        Thu, 16 Jun 2022 08:46:30 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 24486C385A2;
        Thu, 16 Jun 2022 08:46:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369190;
        bh=r3LQRxsB4zvMJAbVYAKgMVYZMxuBkCguR2Xd1O6Gqto=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ZQpUvZVMbha3cDI+oZladehpZNwnxt/I10aiGs74dcvV7UO3yi9Uty8Oqa4mnGeNS
         52KIYOkQ8WjNXY3FwMYqU+RP0f1PzANjDe7pJTn/J/aqCEAcBUU7qBj+xUsA6Lc69J
         uJ5U8Eu38vYK6aR0X0cLFHl3noTa82euSfsWBofFWWAOW0t/pFfhIEzrlqnw3YIxVG
         MIZCzoKO+jJ9UGe4XjCnTy+si8pNFzZU91MuoBdUcksM4MWrCqum8mbghUCy7mpE/3
         YQxhti9YnXzZXWNBJUlCk8mO6GusqoQD8K87KNDJw3TnZU0lwrN2t6knndqsI9AksG
         dJT6YTpoOOyMw==
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
Subject: [PATCH V4 16/20] Documentation/rv: Add deterministic automata instrumentation documentation
Date:   Thu, 16 Jun 2022 10:44:58 +0200
Message-Id: <30171062e035a5cf0e64cfa9cbb8e56376ec5101.1655368610.git.bristot@kernel.org>
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

Add the da_monitor_instrumentation.rst. It describes the basics
of RV monitor instrumentation.

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
 .../trace/rv/da_monitor_instrumentation.rst   | 223 ++++++++++++++++++
 1 file changed, 223 insertions(+)
 create mode 100644 Documentation/trace/rv/da_monitor_instrumentation.rst

diff --git a/Documentation/trace/rv/da_monitor_instrumentation.rst b/Documentation/trace/rv/da_monitor_instrumentation.rst
new file mode 100644
index 000000000000..994110050d93
--- /dev/null
+++ b/Documentation/trace/rv/da_monitor_instrumentation.rst
@@ -0,0 +1,223 @@
+Deterministic Automata Instrumentation
+========================================
+
+This document introduces some concepts behind the **Deterministic Automata
+(DA)** monitor instrumentation.
+
+The synthesis of automata-based models into the Linux *RV monitor* abstraction
+is automated by a tool named dot2k, and the "rv/da_monitor.h" provided
+by the RV interface.
+
+For example, given a file "wip.dot", representing a per-cpu monitor, with
+this content::
+
+  digraph state_automaton {
+	center = true;
+	size = "7,11";
+	rankdir = LR;
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
+  }
+
+That is the "DOT" representation of this automata model::
+
+                       preempt_enable
+          +---------------------------------+
+          v                                 |
+        #============#  preempt_disable   +------------------+
+    --> H preemptive H -----------------> |  non_preemptive  |
+        #============#                    +------------------+
+                                            ^ sched_waking |
+                                            +--------------+
+
+
+Run the dot2k tool with the model, specifying that it is a "per-cpu"
+model::
+
+  $ dot2k -d ~/wip.dot -t per_cpu
+
+This will create a directory named "wip/" with the following files:
+
+- model.h: the wip in C
+- wip.h: tracepoints that report the execution of the events by the
+  monitor
+- wip.c: the RV monitor
+
+The monitor instrumentation should be done entirely in the RV monitor,
+in the example above, in the wip.c file.
+
+The RV monitor instrumentation section
+--------------------------------------
+
+The RV monitor file created by dot2k, with the name "$MODEL_NAME.c"
+will include a section dedicated to instrumentation.
+
+In the example of the wip.dot above, it will look like::
+
+  /*
+   * This is the instrumentation part of the monitor.
+   *
+   * This is the section where manual work is required. Here the kernel events
+   * are translated into model's event.
+   *
+   */
+  static void handle_preempt_disable(void *data, /* XXX: fill header */)
+  {
+	da_handle_event_wip(preempt_disable_wip);
+  }
+
+  static void handle_preempt_enable(void *data, /* XXX: fill header */)
+  {
+	da_handle_event_wip(preempt_enable_wip);
+  }
+
+  static void handle_sched_waking(void *data, /* XXX: fill header */)
+  {
+	da_handle_event_wip(sched_waking_wip);
+  }
+
+  static int start_wip(void)
+  {
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
+  }
+
+The comment at the top of the section explains the general idea: the
+instrumentation section translates *kernel events* into the *events
+accepted by the model*.
+
+Tracing callback functions
+-----------------------------
+
+The first three functions are skeletons for callback *handler functions* for
+each of the three events from the wip model. The developer does not
+necessarily need to use them: they are just starting points.
+
+Using the example of::
+
+ void handle_preempt_disable(void *data, /* XXX: fill header */)
+ {
+        da_handle_event_wip(preempt_disable_wip);
+ }
+
+The "preempt_disable" event from the model conects directly to the
+"preemptirq:preempt_disable". The "preemptirq:preempt_disable" event
+has the following signature, from "include/trace/events/preemptirq.h"::
+
+  TP_PROTO(unsigned long ip, unsigned long parent_ip)
+
+Hence, the "handle_preempt_disable()" function will look like::
+
+  void handle_preempt_disable(void *data, unsigned long ip, unsigned long parent_ip)
+
+In this case, the kernel even translates one to one with the automata event,
+and indeed, no other change is needed for this function.
+
+The next handler function, "handle_preempt_enable()" has the same argument
+list from the "handle_preempt_disable()". The difference is that the
+"preempt_enable" event will be used to synchronize the system to the model.
+
+Initially, the *model* is placed in the initial state. However, the *system*
+might, or might not be in the initial state. The monitor cannot start
+processing events until it knows that the system reached the initial state.
+Otherwise the monitor and the system could be out-of-sync.
+
+Looking at the automata definition, it is possible to see that the system
+and the model are expected to return to the initial state after the
+"preempt_enable" execution. Hence, it can be used to synchronize the
+system and the model at the initialization of the monitoring section.
+
+The initialization is informed via an special handle function, the
+"da_handle_init_event_$(MONITOR)(event)", in this case::
+
+  da_handle_event_wip(preempt_disable_wip);
+
+So, the callback function will look like::
+
+  void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
+  {
+        da_handle_init_event_wip(preempt_enable_wip);
+  }
+
+Finally, the "handle_sched_waking()" will look like::
+
+  void handle_sched_waking(void *data, struct task_struct *task)
+  {
+        da_handle_event_wip(sched_waking_wip);
+  }
+
+And the explanation is left for the reader as an exercise.
+
+Start and Stop functions
+------------------------
+
+dot2k automatically creates two special functions::
+
+  start_$MODELNAME()
+  stop_$MODELNAME()
+
+These functions are called when the monitor is enabled and disabled,
+respectivelly.
+
+They should be used to *attach* and *detach* the instrumentation to the running
+system. The developer must add to the relative function all that is needed to
+*attach* and *detach* its monitor to the system.
+
+For the wip case, these functions were named::
+
+ start_wip()
+ stop_wip()
+
+But no change was required because: by default, these functions *attach* and
+*detach* the tracepoints_to_attach, which was enough for this case.
+
+Instrumentation helpers
+--------------------------
+
+To complete the instrumentation, the *handler functions* need to be attached to a
+kernel event, at the monitoring start phase.
+
+The RV interface also facilitates this step. For example, the macro "rv_attach_trace_probe()"
+is used to connect the wip model events to the relative kernel event. dot2k automatically
+adds "rv_attach_trace_probe()" function call for each model event in the start phase, as
+a suggestion.
+
+For example, from the wip sample model::
+
+  static int start_wip(void)
+  {
+        int retval;
+
+        retval = da_monitor_init_wip();
+        if (retval)
+                return retval;
+
+        rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_disable);
+        rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_preempt_enable);
+        rv_attach_trace_probe("wip", /* XXX: tracepoint */, handle_sched_waking);
+
+        return 0;
+  }
+
+The probes then need to be detached at the stop phase.
-- 
2.35.1

