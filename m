Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F44051C4B1
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 18:08:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381674AbiEEQLN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 12:11:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58944 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355134AbiEEQLH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 12:11:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00CAB5C369;
        Thu,  5 May 2022 09:07:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 8364261DCA;
        Thu,  5 May 2022 16:07:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DC5E9C385B2;
        Thu,  5 May 2022 16:07:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651766845;
        bh=LK+pl0hV5xL+NyGlyW1R8tulCCBxyHvocpv5nsijWAQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Z9Wb+E6Eb72AhF+3WOcY7qf9dzjr/Ck3g5Pe65SyzA3Gj+1DM/ObW/lghStSc2GZQ
         eDXAwVVFzASgj0taQrGvHK4uWUVnfaSpoCch5ZE7EfgS0eZR8C0jXQ5teaTHaS3+2o
         u7W+VWdOiL/KOUE1lAjvIVYcQpQiua6lvOtgdMylWHTQEJsGfZ5yi44pk7egebLzcd
         j1z2mm6XS4zuD3RII8RL2CWVl9hLu6UqKOu520kDGxTryUb3KvO/hMH2cEvgMdUicw
         r/7lxiXT+kKdPsOjOCl9SbhhTwuxPWpoU7m2q91hMk3XqGinNOuh+nCG/YQeuLh9W4
         noWzlcOPW+V3g==
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
Subject: [RFC V3 01/20] rv: Add Runtime Verification (RV) interface
Date:   Thu,  5 May 2022 18:06:41 +0200
Message-Id: <c6995b358b1d13be100b38ea81fa5abb207be4c4.1651766361.git.bristot@kernel.org>
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

RV is a lightweight (yet rigorous) method that complements classical
exhaustive verification techniques (such as model checking and
theorem proving) with a more practical approach to complex systems.

RV works by analyzing the trace of the system's actual execution,
comparing it against a formal specification of the system behavior.
RV can give precise information on the runtime behavior of the
monitored system while enabling the reaction for unexpected
events, avoiding, for example, the propagation of a failure on
safety-critical systems.

The development of this interface roots in the development of the
paper:

DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo
Silva. Efficient formal verification for the Linux kernel. In:
International Conference on Software Engineering and Formal Methods.
Springer, Cham, 2019. p. 315-332.

And:

DE OLIVEIRA, Daniel Bristot, et al. Automata-based formal analysis
and verification of the real-time Linux kernel. PhD Thesis, 2020.

The RV interface resembles the tracing/ interface on purpose. The current
path for the RV interface is /sys/kernel/tracing/rv/.

It presents these files:

 "available_monitors"
   - List the available monitors, one per line.

   For example:
   [root@f32 rv]# cat available_monitors
   wip
   wwnr

 "enabled_monitors"
   - Lists the enabled monitors, one per line;
   - Writing to it enables a given monitor;
   - Writing a monitor name with a '-' prefix disables it;
   - Truncating the file disables all enabled monitors.

   For example:
   [root@f32 rv]# cat enabled_monitors
   [root@f32 rv]# echo wip > enabled_monitors
   [root@f32 rv]# echo wwnr >> enabled_monitors
   [root@f32 rv]# cat enabled_monitors
   wip
   wwnr
   [root@f32 rv]# echo -wip >> enabled_monitors
   [root@f32 rv]# cat enabled_monitors
   wwnr
   [root@f32 rv]# echo > enabled_monitors
   [root@f32 rv]# cat enabled_monitors
   [root@f32 rv]#

   Note that more than one monitor can be enabled concurrently.

 "monitoring_on"
   - It is an on/off general switcher for monitoring. Note
   that it does not disable enabled monitors, but stop the per-entity
   monitors of monitoring the events received from the system.
   It resambles the "tracing_on" switcher.

 "monitors/"
   Each monitor will have its one directory inside "monitors/". There
   the monitor specific files will be presented.
   The "monitors/" directory resambles the "events" directory on
   tracefs.

   For example:
   [root@f32 rv]# cd monitors/wip/
   [root@f32 wip]# ls
   desc  enable
   [root@f32 wip]# cat desc
   auto-generated wakeup in preemptive monitor.
   [root@f32 wip]# cat enable
   0

For further information, see the comments in the header of
kernel/trace/rv/rv.c from this patch.

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
 include/linux/rv.h       |  23 ++
 include/linux/sched.h    |  11 +
 include/rv/rv.h          |  23 ++
 kernel/fork.c            |  14 +
 kernel/trace/Kconfig     |   2 +
 kernel/trace/Makefile    |   2 +
 kernel/trace/rv/Kconfig  |  12 +
 kernel/trace/rv/Makefile |   3 +
 kernel/trace/rv/rv.c     | 738 +++++++++++++++++++++++++++++++++++++++
 kernel/trace/rv/rv.h     |  34 ++
 kernel/trace/trace.c     |   4 +
 kernel/trace/trace.h     |   2 +
 12 files changed, 868 insertions(+)
 create mode 100644 include/linux/rv.h
 create mode 100644 include/rv/rv.h
 create mode 100644 kernel/trace/rv/Kconfig
 create mode 100644 kernel/trace/rv/Makefile
 create mode 100644 kernel/trace/rv/rv.c
 create mode 100644 kernel/trace/rv/rv.h

diff --git a/include/linux/rv.h b/include/linux/rv.h
new file mode 100644
index 000000000000..205e65f57637
--- /dev/null
+++ b/include/linux/rv.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Runtime Verification.
+ *
+ * For futher information, see: kernel/trace/rv/rv.c.
+ *
+ * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+#ifndef _LINUX_RV_H
+#define _LINUX_RV_H
+struct rv_monitor {
+	const char		*name;
+	const char		*description;
+	bool			enabled;
+	int			(*start)(void);
+	void			(*stop)(void);
+	void			(*reset)(void);
+};
+
+extern bool monitoring_on;
+int rv_unregister_monitor(struct rv_monitor *monitor);
+int rv_register_monitor(struct rv_monitor *monitor);
+#endif /* _LINUX_RV_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index a8911b1f35aa..30affc6573c2 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -35,6 +35,7 @@
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
 #include <asm/kmap_size.h>
+#include <rv/rv.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -1499,6 +1500,16 @@ struct task_struct {
 	struct callback_head		l1d_flush_kill;
 #endif
 
+#ifdef CONFIG_RV
+	/*
+	 * Per-task RV monitor. Nowadays fixed in RV_PER_TASK_MONITORS.
+	 * If we find justification for more monitors, we can think
+	 * about adding more or developing a dynamic method. So far,
+	 * none of these are justified.
+	 */
+	union rv_task_monitor		rv[RV_PER_TASK_MONITORS];
+#endif
+
 	/*
 	 * New fields for task_struct should be added above here, so that
 	 * they are included in the randomized portion of task_struct.
diff --git a/include/rv/rv.h b/include/rv/rv.h
new file mode 100644
index 000000000000..27a108881d35
--- /dev/null
+++ b/include/rv/rv.h
@@ -0,0 +1,23 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+
+#ifndef _RV_RV_H
+#define _RV_RV_H
+
+/*
+ * Per-task RV monitors count. Nowadays fixed in RV_PER_TASK_MONITORS.
+ * If we find justification for more monitors, we can think about
+ * adding more or developing a dynamic method. So far, none of
+ * these are justified.
+ */
+#define RV_PER_TASK_MONITORS		1
+#define RV_PER_TASK_MONITOR_INIT	(RV_PER_TASK_MONITORS)
+
+/*
+ * Futher monitor types are expected, so make this a union.
+ */
+union rv_task_monitor {
+};
+
+int get_task_monitor_slot(void);
+void put_task_monitor_slot(int slot);
+#endif /* _RV_RV_H */
diff --git a/kernel/fork.c b/kernel/fork.c
index 9796897560ab..28334f6d2938 100644
--- a/kernel/fork.c
+++ b/kernel/fork.c
@@ -1961,6 +1961,18 @@ static void copy_oom_score_adj(u64 clone_flags, struct task_struct *tsk)
 	mutex_unlock(&oom_adj_mutex);
 }
 
+#ifdef CONFIG_RV
+static void rv_task_fork(struct task_struct *p)
+{
+	int i;
+
+	for (i = 0; i < RV_PER_TASK_MONITORS; i++)
+		;
+}
+#else
+#define rv_task_fork(p) do {} while (0)
+#endif
+
 /*
  * This creates a new process as a copy of the old one,
  * but does not actually start it yet.
@@ -2393,6 +2405,8 @@ static __latent_entropy struct task_struct *copy_process(
 	 */
 	copy_seccomp(p);
 
+	rv_task_fork(p);
+
 	rseq_fork(p, clone_flags);
 
 	/* Don't start children in a dying pid namespace */
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index 2c43e327a619..200fd17e184c 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1103,4 +1103,6 @@ config HIST_TRIGGERS_DEBUG
 
           If unsure, say N.
 
+source "kernel/trace/rv/Kconfig"
+
 endif # FTRACE
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index d77cd8032213..5b09458aafdb 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -104,3 +104,5 @@ obj-$(CONFIG_RETHOOK) += rethook.o
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
 
 libftrace-y := ftrace.o
+
+obj-$(CONFIG_RV) += rv/
diff --git a/kernel/trace/rv/Kconfig b/kernel/trace/rv/Kconfig
new file mode 100644
index 000000000000..6d127cdb00dd
--- /dev/null
+++ b/kernel/trace/rv/Kconfig
@@ -0,0 +1,12 @@
+# SPDX-License-Identifier: GPL-2.0-only
+#
+menuconfig RV
+	bool "Runtime Verification"
+	depends on TRACING
+	help
+	  Enable the kernel runtime verification infrastructure. RV is a
+	  lightweight (yet rigorous) method that complements classical
+	  exhaustive verification techniques (such as model checking and
+	  theorem proving). RV works by analyzing the trace of the system's
+	  actual execution, comparing it against a formal specification of
+	  the system behavior.
diff --git a/kernel/trace/rv/Makefile b/kernel/trace/rv/Makefile
new file mode 100644
index 000000000000..fd995379df67
--- /dev/null
+++ b/kernel/trace/rv/Makefile
@@ -0,0 +1,3 @@
+# SPDX-License-Identifier: GPL-2.0
+
+obj-$(CONFIG_RV) += rv.o
diff --git a/kernel/trace/rv/rv.c b/kernel/trace/rv/rv.c
new file mode 100644
index 000000000000..11735e431a09
--- /dev/null
+++ b/kernel/trace/rv/rv.c
@@ -0,0 +1,738 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * This is the online Runtime Verification (RV) interface.
+ *
+ * RV is a lightweight (yet rigorous) method that complements classical
+ * exhaustive verification techniques (such as model checking and
+ * theorem proving) with a more practical approach to complex systems.
+ *
+ * RV works by analyzing the trace of the system's actual execution,
+ * comparing it against a formal specification of the system behavior.
+ * RV can give precise information on the runtime behavior of the
+ * monitored system while enabling the reaction for unexpected
+ * events, avoiding, for example, the propagation of a failure on
+ * safety-critical systems.
+ *
+ * The development of this interface roots in the development of the
+ * paper:
+ *
+ * DE OLIVEIRA, Daniel Bristot; CUCINOTTA, Tommaso; DE OLIVEIRA, Romulo
+ * Silva. Efficient formal verification for the Linux kernel. In:
+ * International Conference on Software Engineering and Formal Methods.
+ * Springer, Cham, 2019. p. 315-332.
+ *
+ * And:
+ *
+ * DE OLIVEIRA, Daniel Bristot, et al. Automata-based formal analysis
+ * and verification of the real-time Linux kernel. PhD Thesis, 2020.
+ *
+ * == Runtime monitor interface ==
+ *
+ * A monitor is the central part of the runtime verification of a system.
+ *
+ * The monitor stands in between the formal specification of the desired
+ * (or undesired) behavior, and the trace of the actual system.
+ *
+ * In Linux terms, the runtime verification monitors are encapsulated
+ * inside the "RV monitor" abstraction. A RV monitor includes a reference
+ * model of the system, a set of instances of the monitor (per-cpu monitor,
+ * per-task monitor, and so on), and the helper functions that glue the
+ * monitor to the system via trace. Generally, a monitor includes some form
+ * of trace output as a reaction for event parsing and exceptions,
+ * as depicted bellow:
+ *
+ * Linux  +----- RV Monitor ----------------------------------+ Formal
+ *  Realm |                                                   |  Realm
+ *  +-------------------+     +----------------+     +-----------------+
+ *  |   Linux kernel    |     |     Monitor    |     |     Reference   |
+ *  |     Tracing       |  -> |   Instance(s)  | <-  |       Model     |
+ *  | (instrumentation) |     | (verification) |     | (specification) |
+ *  +-------------------+     +----------------+     +-----------------+
+ *         |                          |                       |
+ *         |                          V                       |
+ *         |                     +----------+                 |
+ *         |                     | Reaction |                 |
+ *         |                     +--+--+--+-+                 |
+ *         |                        |  |  |                   |
+ *         |                        |  |  +-> trace output ?  |
+ *         +------------------------|--|----------------------+
+ *                                  |  +----> panic ?
+ *                                  +-------> <user-specified>
+ *
+ * This file implements the interface for loading RV monitors, and
+ * to control the verification session.
+ *
+ * == Registering monitors ==
+ *
+ * The struct rv_monitor defines a set of callback functions to control
+ * a verification session. For instance, when a given monitor is enabled,
+ * the "start" callback function is called to hook the instrumentation
+ * functions to the kernel trace events. The "stop" function is called
+ * when disabling the verification session.
+ *
+ * A RV monitor is registered via:
+ *   int rv_register_monitor(struct rv_monitor *monitor);
+ * And unregistered via:
+ *   int rv_unregister_monitor(struct rv_monitor *monitor);
+ *
+ * These functions are exported to modules, enabling verification monitors
+ * to be dynamically loaded.
+ *
+ * == User interface ==
+ *
+ * The user interface resembles kernel tracing interface. It presents
+ * these files:
+ *
+ *  "available_monitors"
+ *    - List the available monitors, one per line.
+ *
+ *    For example:
+ *    [root@f32 rv]# cat available_monitors
+ *    wip
+ *    wwnr
+ *
+ *  "enabled_monitors"
+ *    - Lists the enabled monitors, one per line;
+ *    - Writing to it enables a given monitor;
+ *    - Writing a monitor name with a '-' prefix disables it;
+ *    - Truncating the file disables all enabled monitors.
+ *
+ *    For example:
+ *    [root@f32 rv]# cat enabled_monitors
+ *    [root@f32 rv]# echo wip > enabled_monitors
+ *    [root@f32 rv]# echo wwnr >> enabled_monitors
+ *    [root@f32 rv]# cat enabled_monitors
+ *    wip
+ *    wwnr
+ *    [root@f32 rv]# echo -wip >> enabled_monitors
+ *    [root@f32 rv]# cat enabled_monitors
+ *    wwnr
+ *    [root@f32 rv]# echo > enabled_monitors
+ *    [root@f32 rv]# cat enabled_monitors
+ *    [root@f32 rv]#
+ *
+ *    Note that more than one monitor can be enabled concurrently.
+ *
+ *  "monitoring_on"
+ *    - It is an on/off general switcher for monitoring. Note
+ *    that it does not disable enabled monitors, but stop the per-entity
+ *    monitors of monitoring the events received from the system.
+ *    It resambles the "tracing_on" switcher.
+ *
+ *  "monitors/"
+ *    Each monitor will have its one directory inside "monitors/". There
+ *    the monitor specific files will be presented.
+ *    The "monitors/" directory resambles the "events" directory on
+ *    tracefs.
+ *
+ *    For example:
+ *    [root@f32 rv]# cd monitors/wip/
+ *    [root@f32 wip]# ls
+ *    desc  enable
+ *    [root@f32 wip]# cat desc
+ *    auto-generated wakeup in preemptive monitor.
+ *    [root@f32 wip]# cat enable
+ *    0
+ *
+ * Copyright (C) 2019-2022 Daniel Bristot de Oliveira <bristot@kernel.org>
+ */
+
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/init.h>
+#include <linux/slab.h>
+#include <rv/rv.h>
+
+#include "rv.h"
+
+DEFINE_MUTEX(rv_interface_lock);
+struct rv_interface rv_root;
+
+struct dentry *get_monitors_root(void)
+{
+	return rv_root.monitors_dir;
+}
+
+/*
+ * Monitoring on global switcher!
+ */
+bool __read_mostly monitoring_on;
+
+/*
+ * Interface for the monitor register.
+ */
+LIST_HEAD(rv_monitors_list);
+
+static int task_monitor_count;
+static bool task_monitor_slots[RV_PER_TASK_MONITORS];
+
+int get_task_monitor_slot(void)
+{
+	int i;
+
+	lockdep_assert_held(&rv_interface_lock);
+
+	if (task_monitor_count == RV_PER_TASK_MONITORS)
+		return -EBUSY;
+
+	task_monitor_count++;
+
+	for (i = 0; i < RV_PER_TASK_MONITORS; i++) {
+		if (task_monitor_slots[i] == false) {
+			task_monitor_slots[i] = true;
+			return i;
+		}
+	}
+
+	WARN_ONCE(1, "RV task_monitor_cout and slots are out of sync\n");
+
+	return -EINVAL;
+}
+
+void put_task_monitor_slot(int slot)
+{
+	lockdep_assert_held(&rv_interface_lock);
+
+	if (slot < 0 || slot > RV_PER_TASK_MONITORS) {
+		WARN_ONCE(1, "RV releasing an invlid slot!: %d\n", slot);
+		return;
+	}
+
+	WARN_ONCE(!task_monitor_slots[slot], "RV releasing unsused task_monitor_slots: %d\n",
+		  slot);
+
+	task_monitor_count--;
+	task_monitor_slots[slot] = false;
+}
+
+/*
+ * This section collects the monitor/ files and folders.
+ */
+static ssize_t monitor_enable_read_data(struct file *filp,
+					char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	struct rv_monitor_def *mdef = filp->private_data;
+	char buff[4];
+
+	memset(buff, 0, sizeof(buff));
+
+	mutex_lock(&rv_interface_lock);
+	sprintf(buff, "%x\n", mdef->monitor->enabled);
+	mutex_unlock(&rv_interface_lock);
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       buff, strlen(buff)+1);
+}
+
+/*
+ * Disable a given runtime monitor.
+ */
+static int disable_monitor(struct rv_monitor_def *mdef)
+{
+	if (mdef->monitor->enabled) {
+		mdef->monitor->enabled = 0;
+		mdef->monitor->stop();
+	}
+
+	mdef->enabled = 0;
+	return 0;
+}
+
+/*
+ * Enable a given monitor.
+ */
+static int enable_monitor(struct rv_monitor_def *mdef)
+{
+	int retval;
+
+	/*
+	 * Reset all internal monitors before starting.
+	 */
+	mdef->monitor->reset();
+	if (!mdef->monitor->enabled) {
+		retval = mdef->monitor->start();
+		if (retval)
+			return retval;
+	}
+
+	mdef->monitor->enabled = 1;
+	mdef->enabled = 1;
+
+	return 0;
+}
+
+/*
+ * interface for enabling/disabling a monitor.
+ */
+static ssize_t monitor_enable_write_data(struct file *filp,
+					 const char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct rv_monitor_def *mdef = filp->private_data;
+	int retval;
+	u64 val;
+
+	retval = kstrtoull_from_user(user_buf, count, 10, &val);
+	if (retval)
+		return retval;
+
+	retval = count;
+
+	mutex_lock(&rv_interface_lock);
+
+	switch (val) {
+	case 0:
+		retval = disable_monitor(mdef);
+		break;
+	case 1:
+		retval = enable_monitor(mdef);
+		break;
+	default:
+		retval = -EINVAL;
+	}
+
+	mutex_unlock(&rv_interface_lock);
+
+	return retval;
+}
+
+static const struct file_operations interface_enable_fops = {
+	.open   = simple_open,
+	.llseek = no_llseek,
+	.write  = monitor_enable_write_data,
+	.read   = monitor_enable_read_data,
+};
+
+/*
+ * Interface to read the enable/disable status of a monitor.
+ */
+static ssize_t
+monitor_desc_read_data(struct file *filp, char __user *user_buf,
+		       size_t count, loff_t *ppos)
+{
+	struct rv_monitor_def *mdef = filp->private_data;
+	char buf[MAX_RV_MONITOR_NAME_SIZE];
+
+	memset(buf, 0, sizeof(buf));
+
+	mutex_lock(&rv_interface_lock);
+	sprintf(buf, "%s\n", mdef->monitor->description);
+	mutex_unlock(&rv_interface_lock);
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+					buf, strlen(buf)+1);
+}
+
+static const struct file_operations interface_desc_fops = {
+	.open   = simple_open,
+	.llseek	= no_llseek,
+	.read	= monitor_desc_read_data,
+};
+
+/*
+ * During the registration of a monitor, this function creates
+ * the monitor dir, where the specific options of the monitor
+ * is exposed.
+ */
+static int create_monitor_dir(struct rv_monitor_def *mdef)
+{
+	struct dentry *root = get_monitors_root();
+	struct dentry *tmp;
+	const char *name = mdef->monitor->name;
+	int retval = 0;
+
+	mdef->root_d = rv_create_dir(name, root);
+
+	if (!mdef->root_d)
+		return -ENOMEM;
+
+	tmp = rv_create_file("enable", 0600,
+			     mdef->root_d, mdef,
+			     &interface_enable_fops);
+	if (!tmp) {
+		retval = -ENOMEM;
+		goto out_remove_root;
+	}
+
+	tmp = rv_create_file("desc", 0400,
+			      mdef->root_d, mdef,
+			      &interface_desc_fops);
+	if (!tmp) {
+		retval = -ENOMEM;
+		goto out_remove_root;
+	}
+
+	return retval;
+
+out_remove_root:
+	rv_remove(mdef->root_d);
+	return retval;
+}
+
+/*
+ * Available/Enable monitor shared seq functions.
+ */
+static int monitors_show(struct seq_file *m, void *p)
+{
+	struct rv_monitor_def *mon_def = p;
+
+	seq_printf(m, "%s\n", mon_def->monitor->name);
+	return 0;
+}
+
+/*
+ * Used by the seq file operations at the end of a read
+ * operation.
+ */
+static void monitors_stop(struct seq_file *m, void *p)
+{
+	mutex_unlock(&rv_interface_lock);
+}
+
+/*
+ * Available monitor seq functions:
+ */
+static void *available_monitors_start(struct seq_file *m, loff_t *pos)
+{
+	mutex_lock(&rv_interface_lock);
+	return seq_list_start(&rv_monitors_list, *pos);
+}
+
+static void *available_monitors_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	return seq_list_next(p, &rv_monitors_list, pos);
+}
+
+/*
+ * Enable monitor seq functions:
+ */
+
+static void *enabled_monitors_next(struct seq_file *m, void *p, loff_t *pos)
+{
+	struct rv_monitor_def *m_def = p;
+
+	(*pos)++;
+
+	list_for_each_entry_continue(m_def, &rv_monitors_list, list) {
+		if (m_def->monitor->enabled)
+			return m_def;
+	}
+
+	return NULL;
+}
+
+static void *enabled_monitors_start(struct seq_file *m, loff_t *pos)
+{
+	struct rv_monitor_def *m_def;
+	loff_t l;
+
+	mutex_lock(&rv_interface_lock);
+	m_def = list_entry(&rv_monitors_list, struct rv_monitor_def, list);
+
+	for (l = 0; l <= *pos; ) {
+		m_def = enabled_monitors_next(m, m_def, &l);
+		if (!m_def)
+			break;
+	}
+
+	return m_def;
+}
+
+/*
+ * available/enabled monitors seq definition.
+ */
+static const struct seq_operations available_monitors_seq_ops = {
+	.start	= available_monitors_start,
+	.next	= available_monitors_next,
+	.stop	= monitors_stop,
+	.show	= monitors_show
+};
+
+static const struct seq_operations enabled_monitors_seq_ops = {
+	.start  = enabled_monitors_start,
+	.next   = enabled_monitors_next,
+	.stop   = monitors_stop,
+	.show   = monitors_show
+};
+
+/*
+ * available_monitors interface.
+ */
+static int available_monitors_open(struct inode *inode, struct file *file)
+{
+	return seq_open(file, &available_monitors_seq_ops);
+};
+
+static const struct file_operations available_monitors_ops = {
+	.open    = available_monitors_open,
+	.read    = seq_read,
+	.llseek  = seq_lseek,
+	.release = seq_release
+};
+
+/*
+ * enabled_monitors interface
+ */
+static void disable_all_monitors(void)
+{
+	struct rv_monitor_def *mdef;
+
+	list_for_each_entry(mdef, &rv_monitors_list, list)
+		disable_monitor(mdef);
+}
+
+static int enabled_monitors_open(struct inode *inode, struct file *file)
+{
+	if ((file->f_mode & FMODE_WRITE) && (file->f_flags & O_TRUNC))
+		disable_all_monitors();
+
+	return seq_open(file, &enabled_monitors_seq_ops);
+};
+
+static ssize_t
+enabled_monitors_write(struct file *filp, const char __user *user_buf,
+		      size_t count, loff_t *ppos)
+{
+	char buff[MAX_RV_MONITOR_NAME_SIZE+1];
+	struct rv_monitor_def *mdef;
+	int retval = -EINVAL;
+	bool enable = true;
+	char *ptr = buff;
+	int len;
+
+	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE+1)
+		return -EINVAL;
+
+	memset(buff, 0, sizeof(buff));
+
+	retval = simple_write_to_buffer(buff, sizeof(buff)-1, ppos, user_buf,
+					count);
+	if (!retval)
+		return -EFAULT;
+
+	if (buff[0] == '-') {
+		enable = false;
+		ptr++;
+	}
+
+	len = strlen(ptr);
+	if (!len)
+		return count;
+	/*
+	 * remove \n
+	 */
+	ptr[len-1] = '\0';
+
+	mutex_lock(&rv_interface_lock);
+
+	retval = -EINVAL;
+
+	list_for_each_entry(mdef, &rv_monitors_list, list) {
+		if (strcmp(ptr, mdef->monitor->name) == 0) {
+			/*
+			 * Monitor found!
+			 */
+			if (enable)
+				retval = enable_monitor(mdef);
+			else
+				retval = disable_monitor(mdef);
+
+			if (retval)
+				goto out;
+
+			/*
+			 * Success!
+			 */
+			retval = count;
+			break;
+		}
+	}
+
+out:
+	mutex_unlock(&rv_interface_lock);
+	return retval;
+}
+
+static const struct file_operations enabled_monitors_ops = {
+	.open		= enabled_monitors_open,
+	.read		= seq_read,
+	.write		= enabled_monitors_write,
+	.llseek		= seq_lseek,
+	.release	= seq_release,
+};
+
+/*
+ * monitoring_on general switcher
+ */
+static ssize_t monitoring_on_read_data(struct file *filp,
+					char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	char buff[4];
+
+	memset(buff, 0, sizeof(buff));
+
+	mutex_lock(&rv_interface_lock);
+	sprintf(buff, "%d\n", monitoring_on);
+	mutex_unlock(&rv_interface_lock);
+
+	return simple_read_from_buffer(user_buf, count, ppos,
+				       buff, strlen(buff)+1);
+}
+
+static void turn_monitoring_off(void)
+{
+	monitoring_on = false;
+}
+
+static void turn_monitoring_on(void)
+{
+	reset_all_monitors();
+	monitoring_on = true;
+}
+
+static ssize_t monitoring_on_write_data(struct file *filp,
+					 const char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	int retval;
+	u64 val;
+
+	retval = kstrtoull_from_user(user_buf, count, 10, &val);
+	if (retval)
+		return retval;
+
+	retval = count;
+
+	mutex_lock(&rv_interface_lock);
+
+	switch (val) {
+	case 0:
+		turn_monitoring_off();
+		break;
+	case 1:
+		turn_monitoring_on();
+		break;
+	default:
+		retval = -EINVAL;
+	}
+
+	mutex_unlock(&rv_interface_lock);
+
+	return retval;
+}
+
+static const struct file_operations monitoring_on_fops = {
+	.open   = simple_open,
+	.llseek = no_llseek,
+	.write  = monitoring_on_write_data,
+	.read   = monitoring_on_read_data,
+};
+
+/*
+ * Monitor API.
+ */
+static void destroy_monitor_dir(struct rv_monitor_def *mdef)
+{
+	rv_remove(mdef->root_d);
+}
+
+/**
+ * rv_register_monitor - register a rv monitor.
+ * @monitor:    The rv_monitor to be registered.
+ *
+ * Returns 0 if successful, error otherwise.
+ */
+int rv_register_monitor(struct rv_monitor *monitor)
+{
+	struct rv_monitor_def *r;
+	int retval = 0;
+
+	if (strlen(monitor->name) >= MAX_RV_MONITOR_NAME_SIZE) {
+		pr_info("Monitor %s has a name longer than %d\n",
+			monitor->name, MAX_RV_MONITOR_NAME_SIZE);
+		return -1;
+	}
+
+	mutex_lock(&rv_interface_lock);
+
+	list_for_each_entry(r, &rv_monitors_list, list) {
+		if (strcmp(monitor->name, r->monitor->name) == 0) {
+			pr_info("Monitor %s is already registered\n",
+				monitor->name);
+			retval = -1;
+			goto out_unlock;
+		}
+	}
+
+	r = kzalloc(sizeof(struct rv_monitor_def), GFP_KERNEL);
+	if (!r) {
+		retval = -ENOMEM;
+		goto out_unlock;
+	}
+
+	r->monitor = monitor;
+
+	create_monitor_dir(r);
+
+	list_add_tail(&r->list, &rv_monitors_list);
+
+out_unlock:
+	mutex_unlock(&rv_interface_lock);
+	return retval;
+}
+
+/**
+ * rv_unregister_monitor - unregister a rv monitor.
+ * @monitor:    The rv_monitor to be unregistered.
+ *
+ * Returns 0 if successful, error otherwise.
+ */
+int rv_unregister_monitor(struct rv_monitor *monitor)
+{
+	struct rv_monitor_def *ptr, *next;
+
+	mutex_lock(&rv_interface_lock);
+
+	list_for_each_entry_safe(ptr, next, &rv_monitors_list, list) {
+		if (strcmp(monitor->name, ptr->monitor->name) == 0) {
+			list_del(&ptr->list);
+			destroy_monitor_dir(ptr);
+		}
+	}
+
+	mutex_unlock(&rv_interface_lock);
+	return 0;
+}
+
+void reset_all_monitors(void)
+{
+	struct rv_monitor_def *mdef;
+
+	/*
+	 * Reset all monitors before re-enabling monitoring.
+	 */
+	list_for_each_entry(mdef, &rv_monitors_list, list) {
+		if (mdef->monitor->enabled)
+			mdef->monitor->reset();
+	}
+
+}
+
+int __init rv_init_interface(void)
+{
+	rv_root.root_dir = rv_create_dir("rv", NULL);
+	rv_root.monitors_dir = rv_create_dir("monitors", rv_root.root_dir);
+
+	rv_create_file("available_monitors", 0400, rv_root.root_dir, NULL,
+		       &available_monitors_ops);
+	rv_create_file("enabled_monitors", 0600, rv_root.root_dir, NULL,
+		       &enabled_monitors_ops);
+	rv_create_file("monitoring_on", 0600, rv_root.root_dir, NULL,
+		       &monitoring_on_fops);
+
+	monitoring_on = true;
+
+	return 0;
+}
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
new file mode 100644
index 000000000000..0796867a7b1e
--- /dev/null
+++ b/kernel/trace/rv/rv.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/mutex.h>
+
+struct rv_interface {
+	struct dentry *root_dir;
+	struct dentry *monitors_dir;
+};
+
+#include "../trace.h"
+#include <linux/tracefs.h>
+#include <linux/rv.h>
+
+#define rv_create_dir			tracefs_create_dir
+#define rv_create_file			tracefs_create_file
+#define rv_remove			tracefs_remove
+
+#define MAX_RV_MONITOR_NAME_SIZE	32
+
+extern struct mutex rv_interface_lock;
+
+struct rv_monitor_def {
+	struct list_head list;
+	struct rv_monitor *monitor;
+	struct dentry *root_d;
+	bool enabled;
+	bool task_monitor;
+};
+
+extern bool monitoring_on;
+struct dentry *get_monitors_root(void);
+void reset_all_monitors(void);
+int init_rv_monitors(struct dentry *root_dir);
+int get_task_monitor_slot(void);
+void put_task_monitor_slot(int slot);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index f4de111fa18f..789104b8a0cc 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9762,6 +9762,10 @@ static __init int tracer_init_tracefs(void)
 
 	update_tracer_options(&global_trace);
 
+#ifdef CONFIG_RV
+	rv_init_interface();
+#endif
+
 	return 0;
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index 07d990270e2a..a366e21cea1a 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2009,4 +2009,6 @@ struct trace_min_max_param {
 
 extern const struct file_operations trace_min_max_fops;
 
+extern int rv_init_interface(void);
+
 #endif /* _LINUX_KERNEL_TRACE_H */
-- 
2.35.1

