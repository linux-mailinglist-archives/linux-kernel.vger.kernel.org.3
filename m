Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ADB9E54DD4D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 10:48:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376267AbiFPIrT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 04:47:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1359780AbiFPIqx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 04:46:53 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DB8EC5DD22;
        Thu, 16 Jun 2022 01:46:26 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3F2F061D7D;
        Thu, 16 Jun 2022 08:46:26 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 64FFDC341C6;
        Thu, 16 Jun 2022 08:46:21 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655369185;
        bh=RSXtvmUy632JYyL5m1ybJouoonN6y/iJYBvbYk3+LnM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=UEgxxw1azqcobv9yT9GCnL2tbEEwTQaKkbkQWrR/e1i8p07amaj1zwe55Qzp9zPD9
         32c9sexgZwRiXGjsc0vTAsT9eyS8+ctjyUoD71JKHCJbFl81D1Zkv6M4tqStkZJRcN
         eaqjfN3dH3MGL8PVHtMxn84t5qWPp3l6GAPrN4WhPIf2yxfIxepk2GmKM4WEm1av2/
         vAsL3TVitGYnbbzcILJSW9utXZ8ItmwNXsp7sjJxY91BoTMlY0wU+7gA2MI/ZYzTN5
         pTl5cZhnqXe7feMyxzrWV/nbwofAmU2tzFwdxpLDh9ZyMJ/OVQ0Vb0L4dvxuhefuRi
         TyyJPxZi0ThCQ==
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
Subject: [PATCH V4 15/20] Documentation/rv: Add deterministic automata monitor synthesis documentation
Date:   Thu, 16 Jun 2022 10:44:57 +0200
Message-Id: <65c0f41a30850002cac84f143616f932d147251d.1655368610.git.bristot@kernel.org>
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

Add the da_monitor_synthesis.rst introduces some concepts behind the
Deterministic Automata (DA) monitor synthesis and interface.

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
 .../trace/rv/da_monitor_synthesis.rst         | 284 ++++++++++++++++++
 1 file changed, 284 insertions(+)
 create mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst

diff --git a/Documentation/trace/rv/da_monitor_synthesis.rst b/Documentation/trace/rv/da_monitor_synthesis.rst
new file mode 100644
index 000000000000..1e1c857d7bbd
--- /dev/null
+++ b/Documentation/trace/rv/da_monitor_synthesis.rst
@@ -0,0 +1,284 @@
+Deterministic Automata Monitor Synthesis
+========================================
+
+The starting point for the application of runtime verification (RV) technics is
+the *specification* or *modeling* of the desired (or undesired) behavior of the
+system under scrutiny.
+
+The formal representation needs to be then *synthesized* into a *monitor* that
+can then be used in the analysis of the trace of the system. The *monitor*
+conects to the system via an *instrumentation* layer, that converts the events
+from the *system* to the events of the *specification*.
+
+This document introduces some concepts behind the **Deterministic Automata
+(DA)** monitor synthesis.
+
+DA monitor synthesis in a nutshell
+------------------------------------------------------
+
+The synthesis of automata-based models into the Linux *RV monitor* abstraction
+is automated by a tool named "dot2k", and the "rv/da_monitor.h" provided
+by the RV interface.
+
+Given a file "wip.dot", representing a per-cpu monitor, with this content::
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
+Run the dot2k tool with the model, specifying that it is a "per-cpu"
+model::
+
+  $ dot2k -d ~/wip.dot -t per_cpu
+
+This will create a directory named "wip/" with the following files:
+
+- wip.h: the wip in C
+- wip.c: the RV monitor
+
+The following line in the "wip.c" file is responsible for the monitor
+synthesis::
+
+  DECLARE_DA_MON_PER_CPU(wip, char);
+
+With that in place, the work left to be done is the *instrumentation* of
+the monitor, which is already initialized by dot2k.
+
+DA: Introduction and representation formats
+---------------------------------------------------------------
+
+Formally, a deterministic automaton, denoted by G, is defined as a quintuple:
+
+        *G* = { *X*, *E*, *f*, x\ :subscript:`0`, X\ :subscript:`m` }
+
+where:
+
+- *X* is the set of states;
+- *E* is the finite set of events;
+- x\ :subscript:`0` is the initial state;
+- X\ :subscript:`m` (subset of *X*) is the set of marked states.
+- *f* : *X* x *E* -> *X* $ is the transition function. It defines the state
+  transition in the occurrence of an event from *E* in the state *X*. In the
+  special case of deterministic automata, the occurrence of the event in *E*
+  in a state in *X* has a deterministic next state from *X*.
+
+One of the most evident benefits for the practical application of the automata
+formalism is its *graphic representation*, represented using vertices (nodes)
+and edges, which is very intuitive for *operating system* practitioners.
+
+For example, given an automata wip, with a regular representation of:
+
+- *X* = { ``preemptive``, ``non_preemptive``}
+- *E* = { ``preempt_enable``, ``preempt_disable``, ``sched_waking``}
+- x\ :subscript:`0` = ``preemptive``
+- X\ :subscript:`m` = {``preemptive``}
+- *f* =
+   - *f*\ (``preemptive``, ``preempt_disable``) = ``non_preemptive``
+   - *f*\ (``non_preemptive``, ``sched_waking``) = ``non_preemptive``
+   - *f*\ (``non_preemptive``, ``preempt_enable``) = ``preemptive``
+
+
+It can also be represented in a graphic format, without any loss, using this
+format::
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
+The Graphviz open-source tool can produce this graphic format using the
+(textual) DOT language as the source code. The DOT format is widely
+used and can be converted to many other formats, including the ASCII art above.
+
+The dot2c tool presented in:
+
+  DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo
+  Silva. Efficient formal verification for the Linux kernel. In:
+  International Conference on Software Engineering and Formal Methods.
+  Springer, Cham, 2019. p. 315-332.
+
+Translates a deterministic automaton in the DOT format into a C source
+code. For instance, using the wip model as input for dot2c results in
+the following C representation::
+
+  enum states_wip {
+	preemptive_wip = 0,
+	non_preemptive_wip,
+	state_max_wip
+  };
+
+  enum events_wip {
+	preempt_disable_wip = 0,
+	preempt_enable_wip,
+	sched_waking_wip,
+	event_max_wip
+  };
+
+  struct automaton_wip {
+	char *state_names[state_max_wip];
+	char *event_names[event_max_wip];
+	char function[state_max_wip][event_max_wip];
+	char initial_state;
+	char final_states[state_max_wip];
+  };
+
+  struct automaton_wip automaton_wip = {
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
+  };
+
+DA monitor synthesis for Linux
+------------------------------
+
+In Linux terms, the runtime verification monitors are encapsulated
+inside the "RV monitor" abstraction. The "RV monitor" includes a set
+of instances of the monitor (per-cpu monitor, per-task monitor, and
+so on), the helper functions that glue the monitor to the system
+reference model, and the trace output as a reaction for event parsing
+and exceptions, as depicted below::
+
+ Linux  +----- RV Monitor ----------------------------------+ Formal
+  Realm |                                                   |  Realm
+  +-------------------+     +----------------+     +-----------------+
+  |   Linux kernel    |     |     Monitor    |     |     Reference   |
+  |     Tracing       |  -> |   Instance(s)  | <-  |       Model     |
+  | (instrumentation) |     | (verification) |     | (specification) |
+  +-------------------+     +----------------+     +-----------------+
+         |                          |                       |
+         |                          V                       |
+         |                     +----------+                 |
+         |                     | Reaction |                 |
+         |                     +--+--+--+-+                 |
+         |                        |  |  |                   |
+         |                        |  |  +-> trace output ?  |
+         +------------------------|--|----------------------+
+                                  |  +----> panic ?
+                                  +-------> <user-specified>
+
+
+The dot2c tool works connecting the *Reference Model* to the *RV Monitor*
+abstraction by translating the *formal notation* into *code*.
+
+The "rv/da_monitor.h" header goes beyond dot2c, extending the code
+generation to the verification stage, generating the code to the *Monitor
+Instance(s)* level using C macros. The trace event code inspires this
+approach.
+
+The benefits of the usage of macro for monitor synthesis is 3-fold:
+
+- Reduces the code duplication;
+- Facilitates the bug fix/improvement;
+- Avoids the case of developers changing the core of the monitor code
+  to manipulate the model in a (let's say) non-standard way.
+
+This initial implementation presents two different types of monitor instances:
+
+- ``#define DECLARE_DA_MON_PER_CPU(name, type)``
+- ``#define DECLARE_DA_MON_PER_TASK(name, type)``
+
+The first declares the functions for deterministic automata monitor with
+per-cpu instances, and the second with per-task instances.
+
+In both cases, the name is a string that identifies the monitor, and the type
+is the data type used by dot2c/k on the representation of the model.
+
+For example, the "wip" model with two states and three events can be
+stored in a "char" type. Considering that the preemption control is a
+per-cpu behavior, the monitor declaration will be::
+
+  DECLARE_DA_MON_PER_CPU(wip, char);
+
+The monitor is executed by sending events to be processed via the functions
+presented below::
+
+  da_handle_event_$(MONITOR_NAME)($(event from event enum));
+  da_handle_init_event_$(MONITOR_NAME)($(event from event enum));
+
+The function ``da_handle_event_$(MONITOR_NAME)()`` is the regular case,
+while the function ``da_handle_init_event_$(MONITOR_NAME)()`` is a special
+case used to synchronize the system with the model.
+
+When a monitor is enabled, it is placed in the initial state of the automata.
+However, the monitor does not know if the system is in the *initial state*.
+Hence, the monitor ignores events sent by sent by
+``da_handle_event_$(MONITOR_NAME)()`` until the function
+``da_handle_init_event_$(MONITOR_NAME)()`` is called.
+
+The function ``da_handle_init_event_$(MONITOR_NAME)()`` should be used for
+the case in which the system generates the event is the one that returns
+the automata to the initial state.
+
+After receiving a ``da_handle_init_event_$(MONITOR_NAME)()`` event, the
+monitor will know that it is in sync with the system and hence will
+start processing the next events.
+
+Using the wip model as example, the events "preempt_disable" and
+"sched_waking" should be sent to monitor, respectively, via::
+
+  da_handle_event_wip(preempt_disable);
+  da_handle_event_wip(sched_waking);
+
+While the event "preempt_enabled" will use::
+
+  da_handle_init_event_wip(preempt_enable);
+
+To notify the monitor that the system will be returning to the initial state,
+so the system and the monitor should be in sync.
+
+rv/da_monitor.h
+-------------------------------------------
+
+The "rv/da_monitor.h" is, mostly, a set of C macros that create function
+definitions based on the paremeters passed via ``DECLARE_DA_MON_*``.
+
+In fewer words, the declaration of a monitor generates:
+
+- Helper functions for getting information from the automata model generated
+  by dot2k.
+- Helper functions for the analysis of a deterministic automata model
+- Functions for the initialization of the monitor instances
+- The definition of the structure to store the monitor instances' data
+
+One important aspect is that the monitor does not call external functions
+for the handling of the events sent by the instrumentation, except for
+generating *tracing events* or *reactions*.
+
+Final remarks
+-------------
+
+With the monitor synthesis in place using, the "rv/da_monitor.h" and
+dot2k, the developer's work should be limited to the instrumentation
+of the system, increasing the confidence in the overall approach.
-- 
2.35.1

