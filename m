Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC35B586090
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 21:05:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237951AbiGaTE6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 15:04:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237713AbiGaTEh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 15:04:37 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0EBFFF588;
        Sun, 31 Jul 2022 12:04:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3C59F61043;
        Sun, 31 Jul 2022 19:04:35 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 05267C43470;
        Sun, 31 Jul 2022 19:04:35 +0000 (UTC)
Received: from rostedt by gandalf.local.home with local (Exim 4.96)
        (envelope-from <rostedt@goodmis.org>)
        id 1oIEEs-007G8J-0Q;
        Sun, 31 Jul 2022 15:04:34 -0400
Message-ID: <20220731190433.970153510@goodmis.org>
User-Agent: quilt/0.66
Date:   Sun, 31 Jul 2022 15:03:41 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     linux-kernel@vger.kernel.org
Cc:     Ingo Molnar <mingo@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
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
        linux-doc@vger.kernel.org, linux-trace-devel@vger.kernel.org,
        Daniel Bristot de Oliveira <bristot@kernel.org>
Subject: [for-next][PATCH 12/21] Documentation/rv: Add deterministic automaton documentation
References: <20220731190329.641602282@goodmis.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Daniel Bristot de Oliveira <bristot@kernel.org>

Add documentation about deterministic automaton and its possible
representations (formal, graphic, .dot and C).

Link: https://lkml.kernel.org/r/387edaed87630bd5eb37c4275045dfd229700aa6.1659052063.git.bristot@kernel.org

Cc: Wim Van Sebroeck <wim@linux-watchdog.org>
Cc: Guenter Roeck <linux@roeck-us.net>
Cc: Jonathan Corbet <corbet@lwn.net>
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
Signed-off-by: Steven Rostedt (Google) <rostedt@goodmis.org>
---
 .../trace/rv/deterministic_automata.rst       | 184 ++++++++++++++++++
 Documentation/trace/rv/index.rst              |   1 +
 tools/verification/dot2/automata.py           |   3 +
 tools/verification/dot2/dot2c                 |   3 +
 tools/verification/dot2/dot2c.py              |   3 +
 5 files changed, 194 insertions(+)
 create mode 100644 Documentation/trace/rv/deterministic_automata.rst

diff --git a/Documentation/trace/rv/deterministic_automata.rst b/Documentation/trace/rv/deterministic_automata.rst
new file mode 100644
index 000000000000..d0638f95a455
--- /dev/null
+++ b/Documentation/trace/rv/deterministic_automata.rst
@@ -0,0 +1,184 @@
+Deterministic Automata
+======================
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
+- X\ :subscript:`m` (subset of *X*) is the set of marked (or final) states.
+- *f* : *X* x *E* -> *X* $ is the transition function. It defines the state
+  transition in the occurrence of an event from *E* in the state *X*. In the
+  special case of deterministic automata, the occurrence of the event in *E*
+  in a state in *X* has a deterministic next state from *X*.
+
+For example, a given automaton named 'wip' (wakeup in preemptive) can
+be defined as:
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
+One of the benefits of this formal definition is that it can be presented
+in multiple formats. For example, using a *graphical representation*, using
+vertices (nodes) and edges, which is very intuitive for *operating system*
+practitioners, without any loss.
+
+The previous 'wip' automaton can also be represented as::
+
+                       preempt_enable
+          +---------------------------------+
+          v                                 |
+        #============#  preempt_disable   +------------------+
+    --> H preemptive H -----------------> |  non_preemptive  |
+        #============#                    +------------------+
+                                            ^              |
+                                            | sched_waking |
+                                            +--------------+
+
+Deterministic Automaton in C
+----------------------------
+
+In the paper "Efficient formal verification for the Linux kernel",
+the authors present a simple way to represent an automaton in C that can
+be used as regular code in the Linux kernel.
+
+For example, the 'wip' automata can be presented as (augmented with comments)::
+
+  /* enum representation of X (set of states) to be used as index */
+  enum states {
+	preemptive = 0,
+	non_preemptive,
+	state_max
+  };
+
+  #define INVALID_STATE state_max
+
+  /* enum representation of E (set of events) to be used as index */
+  enum events {
+	preempt_disable = 0,
+	preempt_enable,
+	sched_waking,
+	event_max
+  };
+
+  struct automaton {
+	char *state_names[state_max];                   // X: the set of states
+	char *event_names[event_max];                   // E: the finite set of events
+	unsigned char function[state_max][event_max];   // f: transition function
+	unsigned char initial_state;                    // x_0: the initial state
+	bool final_states[state_max];                   // X_m: the set of marked states
+  };
+
+  struct automaton aut = {
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
+		{ non_preemptive,  INVALID_STATE,  INVALID_STATE },
+		{  INVALID_STATE,     preemptive, non_preemptive },
+	},
+	.initial_state = preemptive,
+	.final_states = { 1, 0 },
+  };
+
+The *transition function* is represented as a matrix of states (lines) and
+events (columns), and so the function *f* : *X* x *E* -> *X* can be solved
+in O(1). For example::
+
+  next_state = automaton_wip.function[curr_state][event];
+
+Graphviz .dot format
+--------------------
+
+The Graphviz open-source tool can produce the graphical representation
+of an automaton using the (textual) DOT language as the source code.
+The DOT format is widely used and can be converted to many other formats.
+
+For example, this is the 'wip' model in DOT::
+
+  digraph state_automaton {
+        {node [shape = circle] "non_preemptive"};
+        {node [shape = plaintext, style=invis, label=""] "__init_preemptive"};
+        {node [shape = doublecircle] "preemptive"};
+        {node [shape = circle] "preemptive"};
+        "__init_preemptive" -> "preemptive";
+        "non_preemptive" [label = "non_preemptive"];
+        "non_preemptive" -> "non_preemptive" [ label = "sched_waking" ];
+        "non_preemptive" -> "preemptive" [ label = "preempt_enable" ];
+        "preemptive" [label = "preemptive"];
+        "preemptive" -> "non_preemptive" [ label = "preempt_disable" ];
+        { rank = min ;
+                "__init_preemptive";
+                "preemptive";
+        }
+  }
+
+This DOT format can be transformed into a bitmap or vectorial image
+using the dot utility, or into an ASCII art using graph-easy. For
+instance::
+
+  $ dot -Tsvg -o wip.svg wip.dot
+  $ graph-easy wip.dot > wip.txt
+
+dot2c
+-----
+
+dot2c is a utility that can parse a .dot file containing an automaton as
+in the example above and automatically convert it to the C representation
+presented in [3].
+
+For example, having the previous 'wip' model into a file named 'wip.dot',
+the following command will transform the .dot file into the C
+representation (previously shown) in the 'wip.h' file::
+
+  $ dot2c wip.dot > wip.h
+
+The 'wip.h' content is the code sample in section 'Deterministic Automaton
+in C'.
+
+Remarks
+-------
+
+The automata formalism allows modeling discrete event systems (DES) in
+multiple formats, suitable for different applications/users.
+
+For example, the formal description using set theory is better suitable
+for automata operations, while the graphical format for human interpretation;
+and computer languages for machine execution.
+
+References
+----------
+
+Many textbooks cover automata formalism. For a brief introduction see::
+
+  O'Regan, Gerard. Concise guide to software engineering. Springer,
+  Cham, 2017.
+
+For a detailed description, including operations, and application on Discrete
+Event Systems (DES), see::
+
+  Cassandras, Christos G., and Stephane Lafortune, eds. Introduction to discrete
+  event systems. Boston, MA: Springer US, 2008.
+
+For the C representation in kernel, see::
+
+  De Oliveira, Daniel Bristot; Cucinotta, Tommaso; De Oliveira, Romulo
+  Silva. Efficient formal verification for the Linux kernel. In:
+  International Conference on Software Engineering and Formal Methods.
+  Springer, Cham, 2019. p. 315-332.
diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index b54e49b1d0de..013a41a410cf 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -7,3 +7,4 @@ Runtime Verification
    :glob:
 
    runtime-verification.rst
+   deterministic_automata.rst
diff --git a/tools/verification/dot2/automata.py b/tools/verification/dot2/automata.py
index f22e1dff19ce..baffeb960ff0 100644
--- a/tools/verification/dot2/automata.py
+++ b/tools/verification/dot2/automata.py
@@ -4,6 +4,9 @@
 # Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
 #
 # Automata object: parse an automata in dot file digraph format into a python object
+#
+# For further information, see:
+#   Documentation/trace/rv/deterministic_automata.rst
 
 import ntpath
 
diff --git a/tools/verification/dot2/dot2c b/tools/verification/dot2/dot2c
index 8a8cd84bdfcf..3fe89ab88b65 100644
--- a/tools/verification/dot2/dot2c
+++ b/tools/verification/dot2/dot2c
@@ -9,6 +9,9 @@
 #  de Oliveira, D. B. and Cucinotta, T. and de Oliveira, R. S.
 #  "Efficient Formal Verification for the Linux Kernel." International
 #  Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
+#
+# For further information, see:
+#   Documentation/trace/rv/deterministic_automata.rst
 
 if __name__ == '__main__':
     from dot2 import dot2c
diff --git a/tools/verification/dot2/dot2c.py b/tools/verification/dot2/dot2c.py
index bca902eec483..fa73353f7e56 100644
--- a/tools/verification/dot2/dot2c.py
+++ b/tools/verification/dot2/dot2c.py
@@ -9,6 +9,9 @@
 #  de Oliveira, D. B. and Cucinotta, T. and de Oliveira, R. S.
 #  "Efficient Formal Verification for the Linux Kernel." International
 #  Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
+#
+# For further information, see:
+#   Documentation/trace/rv/deterministic_automata.rst
 
 from dot2.automata import Automata
 
-- 
2.35.1
