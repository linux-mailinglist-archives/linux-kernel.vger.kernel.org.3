Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9671158053A
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:13:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236937AbiGYUN0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:13:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236845AbiGYUMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:12:48 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 959E2220D5;
        Mon, 25 Jul 2022 13:12:41 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 327546114C;
        Mon, 25 Jul 2022 20:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0FE46C385A2;
        Mon, 25 Jul 2022 20:12:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658779960;
        bh=SiKAfcK1PLJNKE6AM2WSYxQBh8UVxnM60QtN2Z1WFCo=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YVSNiUG8K+p5Uh0oCEJv8lT0dhZZEle8YhOFfxa2UjfTwAVSbzhZAzdHBDA4nRk2z
         0FI5mfquDbeH4jWBtSFejTII14WphZMVH/lII67AMl9NDRjK/A8iwmLyy7z6tmaNiR
         xxXvv/MNVZz+4GATIKa7I+ziAlJDunDnvjleU9WSADHW2LKhuKYbEr0lteDiDgL1jg
         22o0w86G5fMeL3rHNKXvQjDYgAGaEZ0RoP1q/40Ssk6lfA7CAYxMnIAqQbMJXi4YB8
         xmUF+UPMda+DHFAjtC2hE5WCFQKFzfiYFdhPdEMFlQEW5XMTX6hlLJLdeUbDKZvyCt
         4FlsbcPGGjtpw==
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
Subject: [PATCH V7 10/16] Documentation/rv: Add deterministic automata monitor synthesis documentation
Date:   Mon, 25 Jul 2022 22:11:22 +0200
Message-Id: <a55ace40a8d44ab2376a5d2b3c804fbc059de0d3.1658778484.git.bristot@kernel.org>
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
Cc: Tao Zhou <tao.zhou@linux.dev>
Cc: Randy Dunlap <rdunlap@infradead.org>
Cc: linux-doc@vger.kernel.org
Cc: linux-kernel@vger.kernel.org
Cc: linux-trace-devel@vger.kernel.org
Signed-off-by: Daniel Bristot de Oliveira <bristot@kernel.org>
---
 .../trace/rv/da_monitor_synthesis.rst         | 147 ++++++++++++++++++
 Documentation/trace/rv/index.rst              |   1 +
 include/rv/da_monitor.h                       |   3 +
 tools/verification/dot2/dot2k                 |   3 +
 tools/verification/dot2/dot2k.py              |   3 +
 5 files changed, 157 insertions(+)
 create mode 100644 Documentation/trace/rv/da_monitor_synthesis.rst

diff --git a/Documentation/trace/rv/da_monitor_synthesis.rst b/Documentation/trace/rv/da_monitor_synthesis.rst
new file mode 100644
index 000000000000..0dbdcd1e62b9
--- /dev/null
+++ b/Documentation/trace/rv/da_monitor_synthesis.rst
@@ -0,0 +1,147 @@
+Deterministic Automata Monitor Synthesis
+========================================
+
+The starting point for the application of runtime verification (RV) technics
+is the *specification* or *modeling* of the desired (or undesired) behavior
+of the system under scrutiny.
+
+The formal representation needs to be then *synthesized* into a *monitor*
+that can then be used in the analysis of the trace of the system. The
+*monitor* connects to the system via an *instrumentation* that converts
+the events from the *system* to the events of the *specification*.
+
+
+In Linux terms, the runtime verification monitors are encapsulated inside
+the *RV monitor* abstraction. The RV monitor includes a set of instances
+of the monitor (per-cpu monitor, per-task monitor, and so on), the helper
+functions that glue the monitor to the system reference model, and the
+trace output as a reaction to event parsing and exceptions, as depicted
+below::
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
+DA monitor synthesis
+--------------------
+
+The synthesis of automata-based models into the Linux *RV monitor* abstraction
+is automated by the dot2k tool and the rv/da_monitor.h header file that
+contains a set of macros that automatically generate the monitor's code.
+
+dot2k
+-----
+
+The dot2k utility leverages dot2c by converting an automaton model in
+the DOT format into the C representation [1] and creating the skeleton of
+a kernel monitor in C.
+
+For example, it is possible to transform the wip.dot model present in
+[1] into a per-cpu monitor with the following command::
+
+  $ dot2k -d wip.dot -t per_cpu
+
+This will create a directory named wip/ with the following files:
+
+- wip.h: the wip model in C
+- wip.c: the RV monitor
+
+The wip.c file contains the monitor declaration and the starting point for
+the system instrumentation.
+
+Monitor macros
+--------------
+
+The rv/da_monitor.h enables automatic code generation for the *Monitor
+Instance(s)* using C macros.
+
+The benefits of the usage of macro for monitor synthesis are 3-fold as it:
+
+- Reduces the code duplication;
+- Facilitates the bug fix/improvement;
+- Avoids the case of developers changing the core of the monitor code
+  to manipulate the model in a (let's say) non-standard way.
+
+This initial implementation presents three different types of monitor instances:
+
+- ``#define DECLARE_DA_MON_GLOBAL(name, type)``
+- ``#define DECLARE_DA_MON_PER_CPU(name, type)``
+- ``#define DECLARE_DA_MON_PER_TASK(name, type)``
+
+The first declares the functions for a global deterministic automata monitor,
+the second for monitors with per-cpu instances, and the third with per-task
+instances.
+
+In all cases, the 'name' argument is a string that identifies the monitor, and
+the 'type' argument is the data type used by dot2k on the representation of
+the model in C.
+
+For example, the wip model with two states and three events can be
+stored in an 'unsigned char' type. Considering that the preemption control
+is a per-cpu behavior, the monitor declaration in the 'wip.c' file is::
+
+  DECLARE_DA_MON_PER_CPU(wip, unsigned char);
+
+The monitor is executed by sending events to be processed via the functions
+presented below::
+
+  da_handle_event_$(MONITOR_NAME)($(event from event enum));
+  da_handle_start_event_$(MONITOR_NAME)($(event from event enum));
+  da_handle_start_run_event_$(MONITOR_NAME)($(event from event enum));
+
+The function ``da_handle_event_$(MONITOR_NAME)()`` is the regular case where
+the event will be processed if the monitor is processing events.
+
+When a monitor is enabled, it is placed in the initial state of the automata.
+However, the monitor does not know if the system is in the *initial state*.
+
+The ``da_handle_start_event_$(MONITOR_NAME)()`` function is used to notify the
+monitor that the system is returning to the initial state, so the monitor can
+start monitoring the next event.
+
+The ``da_handle_start_run_event_$(MONITOR_NAME)()`` function is used to notify
+the monitor that the system is known to be in the initial state, so the
+monitor can start monitoring and monitor the current event.
+
+Using the wip model as example, the events "preempt_disable" and
+"sched_waking" should be sent to monitor, respectively, via [2]::
+
+  da_handle_event_wip(preempt_disable_wip);
+  da_handle_event_wip(sched_waking_wip);
+
+While the event "preempt_enabled" will use::
+
+  da_handle_start_event_wip(preempt_enable_wip);
+
+To notify the monitor that the system will be returning to the initial state,
+so the system and the monitor should be in sync.
+
+Final remarks
+-------------
+
+With the monitor synthesis in place using the rv/da_monitor.h and
+dot2k, the developer's work should be limited to the instrumentation
+of the system, increasing the confidence in the overall approach.
+
+[1] For details about deterministic automata format and the translation
+from one representation to another, see::
+
+  Documentation/trace/rv/deterministic_automata.rst
+
+[2] dot2k appends the monitor's name suffix to the events enums to
+avoid conflicting variables when exporting the global vmlinux.h
+use by BPF programs.
diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
index 013a41a410cf..46d47f33052c 100644
--- a/Documentation/trace/rv/index.rst
+++ b/Documentation/trace/rv/index.rst
@@ -8,3 +8,4 @@ Runtime Verification
 
    runtime-verification.rst
    deterministic_automata.rst
+   da_monitor_synthesis.rst
diff --git a/include/rv/da_monitor.h b/include/rv/da_monitor.h
index e14dad3ec4a8..f543efa0ed75 100644
--- a/include/rv/da_monitor.h
+++ b/include/rv/da_monitor.h
@@ -6,6 +6,9 @@
  * with automata models in C generated by the dot2k tool.
  *
  * The dot2k tool is available at tools/verification/dot2k/
+ *
+ * For further information, see:
+ *   Documentation/trace/rv/da_monitor_synthesis.rst
  */
 
 #include <rv/automata.h>
diff --git a/tools/verification/dot2/dot2k b/tools/verification/dot2/dot2k
index 69106f4b7682..9dcd38abe20a 100644
--- a/tools/verification/dot2/dot2k
+++ b/tools/verification/dot2/dot2k
@@ -4,6 +4,9 @@
 # Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
 #
 # dot2k: transform dot files into a monitor for the Linux kernel.
+#
+# For further information, see:
+#   Documentation/trace/rv/da_monitor_synthesis.rst
 
 if __name__ == '__main__':
     from dot2.dot2k import dot2k
diff --git a/tools/verification/dot2/dot2k.py b/tools/verification/dot2/dot2k.py
index 4eecd69c2568..2856e1ce1259 100644
--- a/tools/verification/dot2/dot2k.py
+++ b/tools/verification/dot2/dot2k.py
@@ -4,6 +4,9 @@
 # Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
 #
 # dot2k: transform dot files into a monitor for the Linux kernel.
+#
+# For further information, see:
+#   Documentation/trace/rv/da_monitor_synthesis.rst
 
 from dot2.dot2c import Dot2c
 import platform
-- 
2.35.1

