Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4C8F1580526
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Jul 2022 22:12:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236929AbiGYUMq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Jul 2022 16:12:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45594 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236800AbiGYUM3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Jul 2022 16:12:29 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8748321E1B;
        Mon, 25 Jul 2022 13:12:21 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 11F3861151;
        Mon, 25 Jul 2022 20:12:21 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DFF09C341D4;
        Mon, 25 Jul 2022 20:12:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658779940;
        bh=IZAqMGMmcacy3iz8BdNpmN6JqSf9a1r0ONB2OVFcRAI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=iSrXzF+vaJCzrYJcu7TQaG6y5wJFKo0QwxDDn4+cQHs6LqkGa1NxAhN+1+yCrGneV
         /NrkRSIynCHdcdHM90R2NjKR0CpjsbZtLjPw7AUog4iy4yF1IqA/30aAUvMVdK9EKu
         NlOlAc8ADUG2PdQgu5oBUT+odsXV42P+KH6DRdG4ANn+kv9la6v5FIeCAwLs28P8Tc
         ht2zTyYa9mjIwazYSJ3tpvVV1+eNLARCeN9LlOvm/uxRW2hnfk4TQW1dsKfbPPtn0Y
         BXFar2dIA/5UBGlf799luOpw9VIiJW9v52V/WtJPWJTujHg/TVR4Fgdg1pXnzZ25D7
         4GpufDgy39M1g==
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
Subject: [PATCH V7 06/16] Documentation/rv: Add a basic documentation
Date:   Mon, 25 Jul 2022 22:11:18 +0200
Message-Id: <46c77b04593a0e69fb641817db185efe969a0e66.1658778484.git.bristot@kernel.org>
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

Add the runtime-verification.rst document, explaining the basics of RV
and how to use the interface.

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
 Documentation/trace/index.rst                 |   1 +
 Documentation/trace/rv/index.rst              |   9 +
 .../trace/rv/runtime-verification.rst         | 231 ++++++++++++++++++
 kernel/trace/rv/Kconfig                       |   3 +
 kernel/trace/rv/rv.c                          |   3 +
 5 files changed, 247 insertions(+)
 create mode 100644 Documentation/trace/rv/index.rst
 create mode 100644 Documentation/trace/rv/runtime-verification.rst

diff --git a/Documentation/trace/index.rst b/Documentation/trace/index.rst
index f9b7bcb5a630..2d73e8697523 100644
--- a/Documentation/trace/index.rst
+++ b/Documentation/trace/index.rst
@@ -32,3 +32,4 @@ Linux Tracing Technologies
    sys-t
    coresight/index
    user_events
+   rv/index
diff --git a/Documentation/trace/rv/index.rst b/Documentation/trace/rv/index.rst
new file mode 100644
index 000000000000..b54e49b1d0de
--- /dev/null
+++ b/Documentation/trace/rv/index.rst
@@ -0,0 +1,9 @@
+====================
+Runtime Verification
+====================
+
+.. toctree::
+   :maxdepth: 2
+   :glob:
+
+   runtime-verification.rst
diff --git a/Documentation/trace/rv/runtime-verification.rst b/Documentation/trace/rv/runtime-verification.rst
new file mode 100644
index 000000000000..c46b6149470e
--- /dev/null
+++ b/Documentation/trace/rv/runtime-verification.rst
@@ -0,0 +1,231 @@
+====================
+Runtime Verification
+====================
+
+Runtime Verification (RV) is a lightweight (yet rigorous) method that
+complements classical exhaustive verification techniques (such as *model
+checking* and *theorem proving*) with a more practical approach for complex
+systems.
+
+Instead of relying on a fine-grained model of a system (e.g., a
+re-implementation a instruction level), RV works by analyzing the trace of the
+system's actual execution, comparing it against a formal specification of
+the system behavior.
+
+The main advantage is that RV can give precise information on the runtime
+behavior of the monitored system, without the pitfalls of developing models
+that require a re-implementation of the entire system in a modeling language.
+Moreover, given an efficient monitoring method, it is possible execute an
+*online* verification of a system, enabling the *reaction* for unexpected
+events, avoiding, for example, the propagation of a failure on safety-critical
+systems.
+
+Runtime Monitors and Reactors
+=============================
+
+A monitor is the central part of the runtime verification of a system. The
+monitor stands in between the formal specification of the desired (or
+undesired) behavior, and the trace of the actual system.
+
+In Linux terms, the runtime verification monitors are encapsulated inside the
+*RV monitor* abstraction. A *RV monitor* includes a reference model of the
+system, a set of instances of the monitor (per-cpu monitor, per-task monitor,
+and so on), and the helper functions that glue the monitor to the system via
+trace, as depicted bellow::
+
+ Linux   +---- RV Monitor ----------------------------------+ Formal
+  Realm  |                                                  |  Realm
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
+In addition to the verification and monitoring of the system, a monitor can
+react to an unexpected event. The forms of reaction can vary from logging the
+event occurrence to the enforcement of the correct behavior to the extreme
+action of taking a system down to avoid the propagation of a failure.
+
+In Linux terms, a *reactor* is an reaction method available for *RV monitors*.
+By default, all monitors should provide a trace output of their actions,
+which is already a reaction. In addition, other reactions will be available
+so the user can enable them as needed.
+
+For further information about the principles of runtime verification and
+RV applied to Linux:
+
+  Bartocci, Ezio, et al. *Introduction to runtime verification.* In: Lectures on
+  Runtime Verification. Springer, Cham, 2018. p. 1-33.
+
+  Falcone, Ylies, et al. *A taxonomy for classifying runtime verification tools.*
+  In: International Conference on Runtime Verification. Springer, Cham, 2018. p.
+  241-262.
+
+  De Oliveira, Daniel Bristot. *Automata-based formal analysis and
+  verification of the real-time Linux kernel.* Ph.D. Thesis, 2020.
+
+Online RV monitors
+==================
+
+Monitors can be classified as *offline* and *online* monitors. *Offline*
+monitor process the traces generated by a system after the events, generally by
+reading the trace execution from a permanent storage system. *Online* monitors
+process the trace during the execution of the system. Online monitors are said
+to be *synchronous* if the processing of an event is attached to the system
+execution, blocking the system during the event monitoring. On the other hand,
+an *asynchronous* monitor has its execution detached from the system. Each type
+of monitor has a set of advantages. For example, *offline* monitors can be
+executed on different machines but require operations to save the log to a
+file. In contrast, *synchronous online* method can react at the exact moment
+a violation occurs.
+
+Another important aspect regarding monitors is the overhead associated with the
+event analysis. If the system generates events at a frequency higher than the
+monitor's ability to process them in the same system, only the *offline*
+methods are viable. On the other hand, if the tracing of the events incurs
+on higher overhead than the simple handling of an event by a monitor, then a
+*synchronous online* monitors will incur on lower overhead.
+
+Indeed, the research presented in:
+
+  De Oliveira, Daniel Bristot; Cucinotta, Tommaso; De Oliveira, Romulo Silva.
+  *Efficient formal verification for the Linux kernel.* In: International
+  Conference on Software Engineering and Formal Methods. Springer, Cham, 2019.
+  p. 315-332.
+
+Shows that for Deterministic Automata models, the synchronous processing of
+events in-kernel causes lower overhead than saving the same events to the trace
+buffer, not even considering collecting the trace for user-space analysis.
+This motivated the development of an in-kernel interface for online monitors.
+
+For further information about modeling of Linux kernel behavior using automata,
+see:
+
+  De Oliveira, Daniel B.; De Oliveira, Romulo S.; Cucinotta, Tommaso. *A thread
+  synchronization model for the PREEMPT_RT Linux kernel.* Journal of Systems
+  Architecture, 2020, 107: 101729.
+
+The user interface
+==================
+
+The user interface resembles the tracing interface (on purpose). It is
+currently at "/sys/kernel/tracing/rv/".
+
+The following files/folders are currently available:
+
+**available_monitors**
+
+- Reading list the available monitors, one per line
+
+For example::
+
+   # cat available_monitors
+   wip
+   wwnr
+
+**available_reactors**
+
+- Reading shows the available reactors, one per line.
+
+For example::
+
+   # cat available_reactors
+   nop
+   panic
+   printk
+
+**enabled_monitors**:
+
+- Reading lists the enabled monitors, one per line
+- Writing to it enables a given monitor
+- Writing a monitor name with a '!' prefix disables it
+- Truncating the file disables all enabled monitors
+
+For example::
+
+   # cat enabled_monitors
+   # echo wip > enabled_monitors
+   # echo wwnr >> enabled_monitors
+   # cat enabled_monitors
+   wip
+   wwnr
+   # echo '!wip' >> enabled_monitors
+   # cat enabled_monitors
+   wwnr
+   # echo > enabled_monitors
+   # cat enabled_monitors
+   #
+
+Note that it is possible to enable more than one monitor concurrently.
+
+**monitoring_on**
+
+This is an on/off general switcher for monitoring. It resembles the
+"tracing_on" switcher in the trace interface.
+
+- Writing "0" stops the monitoring
+- Writing "1" continues the monitoring
+- Reading returns the current status of the monitoring
+
+Note that it does not disable enabled monitors but stop the per-entity
+monitors monitoring the events received from the system.
+
+**reacting_on**
+
+- Writing "0" prevents reactions for happening
+- Writing "1" enable reactions
+- Reading returns the current status of the reaction
+
+**monitors/**
+
+Each monitor will have its own directory inside "monitors/". There the
+monitor-specific files will be presented. The "monitors/" directory resembles
+the "events" directory on tracefs.
+
+For example::
+
+   # cd monitors/wip/
+   # ls
+   desc  enable
+   # cat desc
+   wakeup in preemptive per-cpu testing monitor.
+   # cat enable
+   0
+
+**monitors/MONITOR/desc**
+
+- Reading shows a description of the monitor *MONITOR*
+
+**monitors/MONITOR/enable**
+
+- Writing "0" disables the *MONITOR*
+- Writing "1" enables the *MONITOR*
+- Reading return the current status of the *MONITOR*
+
+**monitors/MONITOR/reactors**
+
+- List available reactors, with the select reaction for the given *MONITOR*
+  inside "[]". The default one is the nop (no operation) reactor.
+- Writing the name of a reactor enables it to the given MONITOR.
+
+For example::
+
+   # cat monitors/wip/reactors
+   [nop]
+   panic
+   printk
+   # echo panic > monitors/wip/reactors
+   # cat monitors/wip/reactors
+   nop
+   [panic]
+   printk
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
index 8714800e22ad..0d9552b406c6 100644
--- a/kernel/trace/rv/Kconfig
+++ b/kernel/trace/rv/Kconfig
@@ -22,6 +22,9 @@ menuconfig RV
 	  actual execution, comparing it against a formal specification of
 	  the system behavior.
 
+	  For further information, see:
+	    Documentation/trace/rv/runtime-verification.rst
+
 config RV_REACTORS
 	bool "Runtime verification reactors"
 	default y
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
index 70259589f52d..15bd404c076f 100644
--- a/kernel/trace/rv/rv.c
+++ b/kernel/trace/rv/rv.c
@@ -133,6 +133,9 @@
  *      auto-generated wakeup in preemptive monitor.
  *      # cat enable
  *      0
+ *
+ *  For further information, see:
+ *   Documentation/trace/rv/runtime-verification.rst
  */
 
 #include <linux/kernel.h>
-- 
2.35.1

