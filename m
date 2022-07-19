Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9C07357A534
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Jul 2022 19:27:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239222AbiGSR1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Jul 2022 13:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239168AbiGSR1p (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Jul 2022 13:27:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EC174E626;
        Tue, 19 Jul 2022 10:27:43 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 08CB5B81C87;
        Tue, 19 Jul 2022 17:27:42 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 1C21FC341CE;
        Tue, 19 Jul 2022 17:27:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1658251660;
        bh=KTM2U/uwu4041U36WYibtBzbJsulAQlescO/HzFfFtM=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=TwIEuSjdBe/Bpx4HjIZU9GCWYW54FDG+fh9yFMLrtKDrwP8u/YDMf5ruMPzm+dxna
         qHTaobflC3n2GZ9N/yu5DGfmCjV7anmSRrdNU85CkgjlPGqDYVGMGq2JxENStaMA3P
         DORIX9GWE5EwN3yHXNNLRZPvRHTEC8jxccXA6v5G5mHMGfZ8kLpQzT+1+HDqSmf205
         T6ZctXKauO7wcpdsBB3WNS3fHo7nOEkalaaCVTyOnqfQw1Dravh8jhTZ2r4lPo1uy7
         1w10HSi4f8IMMBRTvdwB5dqp5zYOn1fv6vFWU/5cdE8zi53M5sf3ASRVoQaM4Z2u+c
         m9Zt2rM5ZWiBw==
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
Subject: [PATCH V6 01/16] rv: Add Runtime Verification (RV) interface
Date:   Tue, 19 Jul 2022 19:27:06 +0200
Message-Id: <69bb4c369b4f6f12014eb9ca3c28b74e4378c007.1658244826.git.bristot@kernel.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <cover.1658244826.git.bristot@kernel.org>
References: <cover.1658244826.git.bristot@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
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

De Oliveira, Daniel Bristot; Cucinotta, Tommaso; De Oliveira, Romulo
Silva. Efficient formal verification for the Linux kernel. In:
International Conference on Software Engineering and Formal Methods.
Springer, Cham, 2019. p. 315-332.

And:

De Oliveira, Daniel Bristot. Automata-based formal analysis
and verification of the real-time Linux kernel. PhD Thesis, 2020.

The RV interface resembles the tracing/ interface on purpose. The current
path for the RV interface is /sys/kernel/tracing/rv/.

It presents these files:

 "available_monitors"
   - List the available monitors, one per line.

   For example:
     # cat available_monitors
     wip
     wwnr

 "enabled_monitors"
   - Lists the enabled monitors, one per line;
   - Writing to it enables a given monitor;
   - Writing a monitor name with a '!' prefix disables it;
   - Truncating the file disables all enabled monitors.

   For example:
     # cat enabled_monitors
     # echo wip > enabled_monitors
     # echo wwnr >> enabled_monitors
     # cat enabled_monitors
     wip
     wwnr
     # echo '!wip' >> enabled_monitors
     # cat enabled_monitors
     wwnr
     # echo > enabled_monitors
     # cat enabled_monitors
     #

   Note that more than one monitor can be enabled concurrently.

 "monitoring_on"
   - It is an on/off general switcher for monitoring. Note
   that it does not disable enabled monitors or detach events,
   but stop the per-entity monitors of monitoring the events
   received from the system. It resembles the "tracing_on" switcher.

 "monitors/"
   Each monitor will have its one directory inside "monitors/". There
   the monitor specific files will be presented.
   The "monitors/" directory resembles the "events" directory on
   tracefs.

   For example:
     # cd monitors/wip/
     # ls
     desc  enable
     # cat desc
     wakeup in preemptive per-cpu testing monitor.
     # cat enable
     0

For further information, see the comments in the header of
kernel/trace/rv/rv.c from this patch.

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
 include/linux/rv.h       |  22 ++
 include/linux/sched.h    |  11 +
 include/rv/rv.h          |  23 ++
 kernel/trace/Kconfig     |   2 +
 kernel/trace/Makefile    |   1 +
 kernel/trace/rv/Kconfig  |  12 +
 kernel/trace/rv/Makefile |   3 +
 kernel/trace/rv/rv.c     | 722 +++++++++++++++++++++++++++++++++++++++
 kernel/trace/rv/rv.h     |  34 ++
 kernel/trace/trace.c     |   2 +
 kernel/trace/trace.h     |   9 +
 11 files changed, 841 insertions(+)
 create mode 100644 include/linux/rv.h
 create mode 100644 include/rv/rv.h
 create mode 100644 kernel/trace/rv/Kconfig
 create mode 100644 kernel/trace/rv/Makefile
 create mode 100644 kernel/trace/rv/rv.c
 create mode 100644 kernel/trace/rv/rv.h

diff --git a/include/linux/rv.h b/include/linux/rv.h
new file mode 100644
index 000000000000..b6bcdb4888e6
--- /dev/null
+++ b/include/linux/rv.h
@@ -0,0 +1,22 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Runtime Verification.
+ *
+ * For futher information, see: kernel/trace/rv/rv.c.
+ */
+#ifndef _LINUX_RV_H
+#define _LINUX_RV_H
+
+struct rv_monitor {
+	const char		*name;
+	const char		*description;
+	bool			enabled;
+	int			(*enable)(void);
+	void			(*disable)(void);
+	void			(*reset)(void);
+};
+
+bool rv_monitoring_on(void);
+int rv_unregister_monitor(struct rv_monitor *monitor);
+int rv_register_monitor(struct rv_monitor *monitor);
+#endif /* _LINUX_RV_H */
diff --git a/include/linux/sched.h b/include/linux/sched.h
index c46f3a63b758..b037f364efdc 100644
--- a/include/linux/sched.h
+++ b/include/linux/sched.h
@@ -35,6 +35,7 @@
 #include <linux/seqlock.h>
 #include <linux/kcsan.h>
 #include <asm/kmap_size.h>
+#include <rv/rv.h>
 
 /* task_struct member predeclarations (sorted alphabetically): */
 struct audit_context;
@@ -1500,6 +1501,16 @@ struct task_struct {
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
diff --git a/kernel/trace/Kconfig b/kernel/trace/Kconfig
index ccd6a5ade3e9..1052126bdca2 100644
--- a/kernel/trace/Kconfig
+++ b/kernel/trace/Kconfig
@@ -1106,4 +1106,6 @@ config HIST_TRIGGERS_DEBUG
 
           If unsure, say N.
 
+source "kernel/trace/rv/Kconfig"
+
 endif # FTRACE
diff --git a/kernel/trace/Makefile b/kernel/trace/Makefile
index 0d261774d6f3..c6651e16b557 100644
--- a/kernel/trace/Makefile
+++ b/kernel/trace/Makefile
@@ -106,5 +106,6 @@ obj-$(CONFIG_FPROBE) += fprobe.o
 obj-$(CONFIG_RETHOOK) += rethook.o
 
 obj-$(CONFIG_TRACEPOINT_BENCHMARK) += trace_benchmark.o
+obj-$(CONFIG_RV) += rv/
 
 libftrace-y := ftrace.o
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
index 000000000000..89cd766cfacd
--- /dev/null
+++ b/kernel/trace/rv/rv.c
@@ -0,0 +1,722 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2019-2022 Red Hat, Inc. Daniel Bristot de Oliveira <bristot@kernel.org>
+ *
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
+ * De Oliveira, Daniel Bristot; Cucinotta, Tommaso; De Oliveira, Romulo
+ * Silva. Efficient formal verification for the Linux kernel. In:
+ * International Conference on Software Engineering and Formal Methods.
+ * Springer, Cham, 2019. p. 315-332.
+ *
+ * And:
+ *
+ * De Oliveira, Daniel Bristot, et al. Automata-based formal analysis
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
+ * the "enable" callback function is called to hook the instrumentation
+ * functions to the kernel trace events. The "disable" function is called
+ * when disabling the verification session.
+ *
+ * A RV monitor is registered via:
+ *   int rv_register_monitor(struct rv_monitor *monitor);
+ * And unregistered via:
+ *   int rv_unregister_monitor(struct rv_monitor *monitor);
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
+ *      # cat available_monitors
+ *      wip
+ *      wwnr
+ *
+ *  "enabled_monitors"
+ *    - Lists the enabled monitors, one per line;
+ *    - Writing to it enables a given monitor;
+ *    - Writing a monitor name with a '!' prefix disables it;
+ *    - Truncating the file disables all enabled monitors.
+ *
+ *    For example:
+ *      # cat enabled_monitors
+ *      # echo wip > enabled_monitors
+ *      # echo wwnr >> enabled_monitors
+ *      # cat enabled_monitors
+ *      wip
+ *      wwnr
+ *      # echo '!wip' >> enabled_monitors
+ *      # cat enabled_monitors
+ *      wwnr
+ *      # echo > enabled_monitors
+ *      # cat enabled_monitors
+ *      #
+ *
+ *    Note that more than one monitor can be enabled concurrently.
+ *
+ *  "monitoring_on"
+ *    - It is an on/off general switcher for monitoring. Note
+ *    that it does not disable enabled monitors or detach events,
+ *    but stops the per-entity monitors from monitoring the events
+ *    received from the instrumentation. It resembles the "tracing_on"
+ *    switcher.
+ *
+ *  "monitors/"
+ *    Each monitor will have its own directory inside "monitors/". There
+ *    the monitor specific files will be presented.
+ *    The "monitors/" directory resembles the "events" directory on
+ *    tracefs.
+ *
+ *    For example:
+ *      # cd monitors/wip/
+ *      # ls
+ *      desc  enable
+ *      # cat desc
+ *      auto-generated wakeup in preemptive monitor.
+ *      # cat enable
+ *      0
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
+
+static struct rv_interface rv_root;
+
+struct dentry *get_monitors_root(void)
+{
+	return rv_root.monitors_dir;
+}
+
+/*
+ * Monitoring on global switcher!
+ */
+static bool __read_mostly monitoring_on;
+
+/**
+ * rv_monitoring_on - checks if monitoring is on
+ *
+ * Returns 1 if on, 0 otherwise.
+ */
+bool rv_monitoring_on(void)
+{
+	return monitoring_on;
+}
+
+/*
+ * Interface for the monitor register.
+ */
+static LIST_HEAD(rv_monitors_list);
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
+	WARN_ONCE(1, "RV task_monitor_count and slots are out of sync\n");
+
+	return -EINVAL;
+}
+
+void put_task_monitor_slot(int slot)
+{
+	lockdep_assert_held(&rv_interface_lock);
+
+	if (slot < 0 || slot >= RV_PER_TASK_MONITORS) {
+		WARN_ONCE(1, "RV releasing an invalid slot!: %d\n", slot);
+		return;
+	}
+
+	WARN_ONCE(!task_monitor_slots[slot], "RV releasing unused task_monitor_slots: %d\n",
+		  slot);
+
+	task_monitor_count--;
+	task_monitor_slots[slot] = false;
+}
+
+/*
+ * This section collects the monitor/ files and folders.
+ */
+static ssize_t monitor_enable_read_data(struct file *filp, char __user *user_buf, size_t count,
+					loff_t *ppos)
+{
+	struct rv_monitor_def *mdef = filp->private_data;
+	const char *buff;
+
+	mutex_lock(&rv_interface_lock);
+	buff = mdef->monitor->enabled ? "1\n" : "0\n";
+	mutex_unlock(&rv_interface_lock);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff)+1);
+}
+
+/*
+ * Disable a given runtime monitor.
+ */
+static int disable_monitor(struct rv_monitor_def *mdef)
+{
+	if (mdef->monitor->enabled) {
+		mdef->monitor->enabled = 0;
+		mdef->monitor->disable();
+	}
+
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
+	if (!mdef->monitor->enabled) {
+		retval = mdef->monitor->enable();
+		if (retval)
+			return retval;
+	}
+
+	mdef->monitor->enabled = 1;
+
+	return 0;
+}
+
+/*
+ * interface for enabling/disabling a monitor.
+ */
+static ssize_t monitor_enable_write_data(struct file *filp, const char __user *user_buf,
+					 size_t count, loff_t *ppos)
+{
+	struct rv_monitor_def *mdef = filp->private_data;
+	int retval;
+	bool val;
+
+	retval = kstrtobool_from_user(user_buf, count, &val);
+	if (retval)
+		return retval;
+
+	retval = count;
+
+	mutex_lock(&rv_interface_lock);
+
+	if (val)
+		retval = enable_monitor(mdef);
+	else
+		retval = disable_monitor(mdef);
+
+	mutex_unlock(&rv_interface_lock);
+
+	return retval ? : count;
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
+static ssize_t monitor_desc_read_data(struct file *filp, char __user *user_buf, size_t count,
+				      loff_t *ppos)
+{
+	struct rv_monitor_def *mdef = filp->private_data;
+	char buff[256];
+
+	memset(buff, 0, sizeof(buff));
+
+	mutex_lock(&rv_interface_lock);
+	snprintf(buff, sizeof(buff), "%s\n", mdef->monitor->description);
+	mutex_unlock(&rv_interface_lock);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
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
+ * are exposed.
+ */
+static int create_monitor_dir(struct rv_monitor_def *mdef)
+{
+	struct dentry *root = get_monitors_root();
+	const char *name = mdef->monitor->name;
+	struct dentry *tmp;
+	int retval;
+
+	mdef->root_d = rv_create_dir(name, root);
+	if (!mdef->root_d)
+		return -ENOMEM;
+
+	tmp = rv_create_file("enable", RV_MODE_WRITE, mdef->root_d, mdef, &interface_enable_fops);
+	if (!tmp) {
+		retval = -ENOMEM;
+		goto out_remove_root;
+	}
+
+	tmp = rv_create_file("desc", RV_MODE_READ, mdef->root_d, mdef, &interface_desc_fops);
+	if (!tmp) {
+		retval = -ENOMEM;
+		goto out_remove_root;
+	}
+
+	return 0;
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
+ * Available monitor seq functions.
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
+ * Enable monitor seq functions.
+ */
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
+
+	if (list_empty(&rv_monitors_list))
+		return NULL;
+
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
+ * enabled_monitors interface.
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
+static ssize_t enabled_monitors_write(struct file *filp, const char __user *user_buf,
+				      size_t count, loff_t *ppos)
+{
+	char buff[MAX_RV_MONITOR_NAME_SIZE + 2];
+	struct rv_monitor_def *mdef;
+	int retval = -EINVAL;
+	bool enable = true;
+	char *ptr = buff;
+	int len;
+
+	if (count < 1 || count > MAX_RV_MONITOR_NAME_SIZE + 1)
+		return -EINVAL;
+
+	memset(buff, 0, sizeof(buff));
+
+	retval = simple_write_to_buffer(buff, sizeof(buff) - 1, ppos, user_buf, count);
+	if (retval < 0)
+		return -EFAULT;
+
+	ptr = strim(buff);
+
+	if (ptr[0] == '!') {
+		enable = false;
+		ptr++;
+	}
+
+	len = strlen(ptr);
+	if (!len)
+		return count;
+
+	mutex_lock(&rv_interface_lock);
+
+	retval = -EINVAL;
+
+	list_for_each_entry(mdef, &rv_monitors_list, list) {
+		if (strcmp(ptr, mdef->monitor->name) != 0)
+			continue;
+
+		/*
+		 * Monitor found!
+		 */
+		if (enable)
+			retval = enable_monitor(mdef);
+		else
+			retval = disable_monitor(mdef);
+
+		if (!retval)
+			retval = count;
+
+		break;
+	}
+
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
+ * monitoring_on general switcher.
+ */
+static ssize_t monitoring_on_read_data(struct file *filp, char __user *user_buf,
+				       size_t count, loff_t *ppos)
+{
+	const char *buff;
+
+	mutex_lock(&rv_interface_lock);
+	buff = monitoring_on ? "1\n" : "0\n";
+	mutex_unlock(&rv_interface_lock);
+
+	return simple_read_from_buffer(user_buf, count, ppos, buff, strlen(buff) + 1);
+}
+
+static void turn_monitoring_off(void)
+{
+	monitoring_on = false;
+}
+
+static void reset_all_monitors(void)
+{
+	struct rv_monitor_def *mdef;
+
+	list_for_each_entry(mdef, &rv_monitors_list, list) {
+		if (mdef->monitor->enabled)
+			mdef->monitor->reset();
+	}
+}
+
+
+static void turn_monitoring_on(void)
+{
+	reset_all_monitors();
+	monitoring_on = true;
+}
+
+static ssize_t monitoring_on_write_data(struct file *filp, const char __user *user_buf,
+					size_t count, loff_t *ppos)
+{
+	int retval;
+	bool val;
+
+	retval = kstrtobool_from_user(user_buf, count, &val);
+	if (retval)
+		return retval;
+
+	mutex_lock(&rv_interface_lock);
+
+	if (val)
+		turn_monitoring_on();
+	else
+		turn_monitoring_off();
+
+	mutex_unlock(&rv_interface_lock);
+
+	return count;
+}
+
+static const struct file_operations monitoring_on_fops = {
+	.open   = simple_open,
+	.llseek = no_llseek,
+	.write  = monitoring_on_write_data,
+	.read   = monitoring_on_read_data,
+};
+
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
+		pr_info("Monitor %s has a name longer than %d\n", monitor->name,
+			MAX_RV_MONITOR_NAME_SIZE);
+		return -1;
+	}
+
+	mutex_lock(&rv_interface_lock);
+
+	list_for_each_entry(r, &rv_monitors_list, list) {
+		if (strcmp(monitor->name, r->monitor->name) == 0) {
+			pr_info("Monitor %s is already registered\n", monitor->name);
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
+	retval = create_monitor_dir(r);
+	if (retval) {
+		kfree(r);
+		goto out_unlock;
+	}
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
+int __init rv_init_interface(void)
+{
+	struct dentry *tmp;
+
+	rv_root.root_dir = rv_create_dir("rv", NULL);
+	if (!rv_root.root_dir)
+		goto out_err;
+
+	rv_root.monitors_dir = rv_create_dir("monitors", rv_root.root_dir);
+	if (!rv_root.monitors_dir)
+		goto out_err;
+
+	tmp = rv_create_file("available_monitors", RV_MODE_READ, rv_root.root_dir, NULL,
+			     &available_monitors_ops);
+	if (!tmp)
+		goto out_err;
+
+	tmp = rv_create_file("enabled_monitors", RV_MODE_WRITE, rv_root.root_dir, NULL,
+			     &enabled_monitors_ops);
+	if (!tmp)
+		goto out_err;
+
+	tmp = rv_create_file("monitoring_on", RV_MODE_WRITE, rv_root.root_dir, NULL,
+			     &monitoring_on_fops);
+	if (!tmp)
+		goto out_err;
+
+	monitoring_on = true;
+
+	return 0;
+
+out_err:
+	rv_remove(rv_root.root_dir);
+	printk(KERN_ERR "RV: Error while creating the RV interface\n");
+	return 1;
+}
diff --git a/kernel/trace/rv/rv.h b/kernel/trace/rv/rv.h
new file mode 100644
index 000000000000..2631ada61ebc
--- /dev/null
+++ b/kernel/trace/rv/rv.h
@@ -0,0 +1,34 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#include <linux/mutex.h>
+
+struct rv_interface {
+	struct dentry		*root_dir;
+	struct dentry		*monitors_dir;
+};
+
+#include "../trace.h"
+#include <linux/tracefs.h>
+#include <linux/rv.h>
+
+#define RV_MODE_WRITE			TRACE_MODE_WRITE
+#define RV_MODE_READ			TRACE_MODE_READ
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
+	struct list_head	list;
+	struct rv_monitor	*monitor;
+	struct dentry		*root_d;
+	bool			task_monitor;
+};
+
+struct dentry *get_monitors_root(void);
+int init_rv_monitors(struct dentry *root_dir);
+int get_task_monitor_slot(void);
+void put_task_monitor_slot(int slot);
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index b8dd54627075..062423371741 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -9772,6 +9772,8 @@ static __init int tracer_init_tracefs(void)
 		tracer_init_tracefs_work_func(NULL);
 	}
 
+	rv_init_interface();
+
 	return 0;
 }
 
diff --git a/kernel/trace/trace.h b/kernel/trace/trace.h
index ff816fb41e48..900e75d96c84 100644
--- a/kernel/trace/trace.h
+++ b/kernel/trace/trace.h
@@ -2005,4 +2005,13 @@ struct trace_min_max_param {
 
 extern const struct file_operations trace_min_max_fops;
 
+#ifdef CONFIG_RV
+extern int rv_init_interface(void);
+#else
+static inline int rv_init_interface(void)
+{
+	return 0;
+}
+#endif
+
 #endif /* _LINUX_KERNEL_TRACE_H */
-- 
2.35.1

