Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D5D4B4E23
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:27:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350902AbiBNLXO convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Mon, 14 Feb 2022 06:23:14 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48980 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349793AbiBNLWg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:22:36 -0500
Received: from us-smtp-delivery-44.mimecast.com (us-smtp-delivery-44.mimecast.com [207.211.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 01D9A3A5C7
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 02:58:16 -0800 (PST)
Received: from mimecast-mx01.redhat.com (mimecast-mx01.redhat.com
 [209.132.183.4]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-258-5snPo-U7OPivrn84bzrALg-1; Mon, 14 Feb 2022 05:47:52 -0500
X-MC-Unique: 5snPo-U7OPivrn84bzrALg-1
Received: from smtp.corp.redhat.com (int-mx08.intmail.prod.int.phx2.redhat.com [10.5.11.23])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx01.redhat.com (Postfix) with ESMTPS id 00D5218B613A;
        Mon, 14 Feb 2022 10:47:51 +0000 (UTC)
Received: from x1.com (unknown [10.22.16.130])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 232DB27BD1;
        Mon, 14 Feb 2022 10:47:46 +0000 (UTC)
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
Subject: [RFC V2 16/21] Documentation/rv: Add deterministic automata instrumentation documentation
Date:   Mon, 14 Feb 2022 11:45:07 +0100
Message-Id: <8c305bb8ee48f5d144afe910514d01362180ef8b.1644830251.git.bristot@kernel.org>
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

Add the da_monitor_instrumentation.rst. It describes the basics
of RV monitor instrumentation.

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
 .../trace/rv/da_monitor_instrumentation.rst   | 230 ++++++++++++++++++
 1 file changed, 230 insertions(+)
 create mode 100644 Documentation/trace/rv/da_monitor_instrumentation.rst

diff --git a/Documentation/trace/rv/da_monitor_instrumentation.rst b/Documentation/trace/rv/da_monitor_instrumentation.rst
new file mode 100644
index 000000000000..6c5188f76cba
--- /dev/null
+++ b/Documentation/trace/rv/da_monitor_instrumentation.rst
@@ -0,0 +1,230 @@
+Deterministic Automata Instrumentation
+========================================
+
+This document introduces some concepts behind the **Deterministic Automata
+(DA)** monitor instrumentation.
+
+The synthesis of automata-based models into the Linux *RV monitor* abstraction
+is automatized by a tool named dot2k, and the "rv/da_monitor.h" provided
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
+ /*
+  * This is the instrumentation part of the monitor.
+  *
+  * This is the section where manual work is required. Here the kernel events
+  * are translated into model's event.
+  *
+  */
+
+ void handle_preempt_disable(void *data, /* XXX: fill header */)
+ {
+	da_handle_event_wip(preempt_disable);
+ }
+
+ void handle_preempt_enable(void *data, /* XXX: fill header */)
+ {
+	da_handle_event_wip(preempt_enable);
+ }
+
+ void handle_sched_waking(void *data, /* XXX: fill header */)
+ {
+	da_handle_event_wip(sched_waking);
+ }
+
+ #define NR_TP   3
+ struct tracepoint_hook_helper tracepoints_to_hook[NR_TP] = {
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
+ };
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
+        da_handle_event_wip(preempt_disable);
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
+processing events until it knows that the system reached the initial state. Otherwise the monitor and the system could be out-of-sync.
+
+Looking at the automata definition, it is possible to see that the system
+and the model are expected to return to the initial state after the
+"preempt_enable" execution. Hence, it can be used to synchronize the
+system and the model at the initialization of the monitoring section.
+
+The initialization is informed via an special handle function, the
+"da_handle_init_event_$(MONITOR)(event)", in this case::
+
+  da_handle_event_wip(preempt_disable);
+
+So, the callback function will look like::
+
+  void handle_preempt_enable(void *data, unsigned long ip, unsigned long parent_ip)
+  {
+        da_handle_init_event_wip(preempt_enable);
+  }
+
+Finally, the "handle_sched_waking()" will look like::
+
+  void handle_sched_waking(void *data, struct task_struct *task)
+  {
+        da_handle_event_wip(sched_waking);
+  }
+
+And the explanation is left for the reader as an exercise.
+
+Tracepoint hook helpers
+--------------------------
+
+Still in the previous example, the next code section is the
+"tracepoint_to_hook" definition, which is a structure that aims to help to
+connect a monitor *handler function* with a given "tracepoint". Note that
+this is just a suggestion. Indeed, the *handler functions* can hook to anything
+that is possible to hook in the kernel, not even limited to the
+tracing interface.
+
+For the specific case of wip, the "tracepoints_to_hook" structure was
+defined as::
+
+  #define NR_TP   3
+  struct tracepoint_hook_helper tracepoints_to_hook[NR_TP] = {
+        {
+                .probe = handle_preempt_disable,
+                .name = "preempt_disable",
+                .registered = 0
+        },
+        {
+                .probe = handle_preempt_enable,
+                .name = "preempt_enable",
+                .registered = 0
+        },
+        {
+                .probe = handle_sched_waking,
+                .name = "sched_wakeup",
+                .registered = 0
+        },
+  };
+
+And that is the instrumentation required for the wip sample model.
+
+Start and Stop functions
+------------------------
+
+Finally, dot2k automatically creates two special functions::
+
+  start_$MODELNAME()
+  stop_$MODELNAME()
+
+These functions are called when the monitor is enabled and disabled,
+respectivelly.
+They should be used to *hook* and *unhook* the instrumentation to the running
+system. The developer must add to the relative function all that is needed to
+*hook* and *unhook* its monitor to the system.
+
+For the wip case, these functions were named::
+
+ start_wip()
+ stop_wip()
+
+But no change was required because: by default, these functions *hook* and
+*unhook* the tracepoints_to_hook, which was enough for this case.
-- 
2.33.1

