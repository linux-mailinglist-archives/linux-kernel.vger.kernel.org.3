Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 124A25527DF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343721AbiFTXM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346829AbiFTXLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:11:50 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5FA0D26544;
        Mon, 20 Jun 2022 16:10:36 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 9A693B8164D;
        Mon, 20 Jun 2022 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ECB79C36AE7;
        Mon, 20 Jun 2022 23:10:31 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=7Os/de3av0FDcoi4MWN14jETAiFGF7qvFPt5+ViREeE=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=sRwCov+YCQ5eWkPcV5pqEqjDGRdPIZYJC96fQGVsQV3HWrWD1SAO1N0L4Sz8JmOq9
         qo6D56y6m4T7r+tbUo0zNRvkWmHNYHGSW1/y7ro9VCRzO1OxqT2iJ8e98+G3Q3fDsm
         OxTMtxY4XBnAjl02CfYNkfmx3cDF1Gambq4V82NiGSTeqi7d0BktOnqiszKKoOWwTr
         /bwTI9I8e8AAWMu000VeuqYv3XXS+l9J4/UZMBLVQcfK3mMzVfYNQ4IYVeimeIFNtm
         dtP45MZfUH6Ch2pv+60gziWo6Pr+nbGAbQEHvWL6wYrzftCW0qQw3nTXbkk4uJwuNn
         T/oxauglr4leQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5EEFA5C0DAC; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Boqun Feng <boqun.feng@gmail.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Yu Liao <liaoyu15@huawei.com>, Phil Auld <pauld@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Alex Belits <abelits@marvell.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 10/23] context_tracking: Take idle eqs entrypoints over RCU
Date:   Mon, 20 Jun 2022 16:10:16 -0700
Message-Id: <20220620231029.3844583-10-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
References: <20220620231027.GA3844372@paulmck-ThinkPad-P17-Gen-1>
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

From: Frederic Weisbecker <frederic@kernel.org>

The RCU dynticks counter is going to be merged into the context tracking
subsystem. Start with moving the idle extended quiescent states
entrypoints to context tracking. For now those are dumb redirections to
existing RCU calls.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao <liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 Documentation/RCU/stallwarn.rst   |  4 ++--
 arch/arm/mach-imx/cpuidle-imx6q.c |  5 +++--
 drivers/acpi/processor_idle.c     |  5 +++--
 drivers/cpuidle/cpuidle.c         |  9 +++++----
 include/linux/context_tracking.h  |  8 ++++++++
 include/linux/rcupdate.h          |  2 +-
 kernel/context_tracking.c         | 15 +++++++++++++++
 kernel/locking/lockdep.c          |  2 +-
 kernel/rcu/Kconfig                |  2 ++
 kernel/rcu/tree.c                 |  2 --
 kernel/rcu/update.c               |  2 +-
 kernel/sched/idle.c               | 10 +++++-----
 kernel/sched/sched.h              |  1 +
 kernel/time/Kconfig               |  6 ++++++
 14 files changed, 53 insertions(+), 20 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 794837eb519b9..b95bda7755fa9 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -97,8 +97,8 @@ warnings:
 	which will include additional debugging information.
 
 -	A low-level kernel issue that either fails to invoke one of the
-	variants of rcu_user_enter(), rcu_user_exit(), rcu_idle_enter(),
-	rcu_idle_exit(), rcu_irq_enter(), or rcu_irq_exit() on the one
+	variants of rcu_user_enter(), rcu_user_exit(), ct_idle_enter(),
+	ct_idle_exit(), rcu_irq_enter(), or rcu_irq_exit() on the one
 	hand, or that invokes one of them too many times on the other.
 	Historically, the most frequent issue has been an omission
 	of either irq_enter() or irq_exit(), which in turn invoke
diff --git a/arch/arm/mach-imx/cpuidle-imx6q.c b/arch/arm/mach-imx/cpuidle-imx6q.c
index 094337dc1bc7e..d086cbae09c37 100644
--- a/arch/arm/mach-imx/cpuidle-imx6q.c
+++ b/arch/arm/mach-imx/cpuidle-imx6q.c
@@ -3,6 +3,7 @@
  * Copyright (C) 2012 Freescale Semiconductor, Inc.
  */
 
+#include <linux/context_tracking.h>
 #include <linux/cpuidle.h>
 #include <linux/module.h>
 #include <asm/cpuidle.h>
@@ -24,9 +25,9 @@ static int imx6q_enter_wait(struct cpuidle_device *dev,
 		imx6_set_lpm(WAIT_UNCLOCKED);
 	raw_spin_unlock(&cpuidle_lock);
 
-	rcu_idle_enter();
+	ct_idle_enter();
 	cpu_do_idle();
-	rcu_idle_exit();
+	ct_idle_exit();
 
 	raw_spin_lock(&cpuidle_lock);
 	if (num_idle_cpus-- == num_online_cpus())
diff --git a/drivers/acpi/processor_idle.c b/drivers/acpi/processor_idle.c
index 6a5572a1a80cc..1401d193a2dfc 100644
--- a/drivers/acpi/processor_idle.c
+++ b/drivers/acpi/processor_idle.c
@@ -23,6 +23,7 @@
 #include <linux/minmax.h>
 #include <linux/perf_event.h>
 #include <acpi/processor.h>
+#include <linux/context_tracking.h>
 
 /*
  * Include the apic definitions for x86 to have the APIC timer related defines
@@ -647,11 +648,11 @@ static int acpi_idle_enter_bm(struct cpuidle_driver *drv,
 		raw_spin_unlock(&c3_lock);
 	}
 
-	rcu_idle_enter();
+	ct_idle_enter();
 
 	acpi_idle_do_entry(cx);
 
-	rcu_idle_exit();
+	ct_idle_exit();
 
 	/* Re-enable bus master arbitration */
 	if (dis_bm) {
diff --git a/drivers/cpuidle/cpuidle.c b/drivers/cpuidle/cpuidle.c
index ef2ea1b12cd84..62dd956025f33 100644
--- a/drivers/cpuidle/cpuidle.c
+++ b/drivers/cpuidle/cpuidle.c
@@ -23,6 +23,7 @@
 #include <linux/suspend.h>
 #include <linux/tick.h>
 #include <linux/mmu_context.h>
+#include <linux/context_tracking.h>
 #include <trace/events/power.h>
 
 #include "cpuidle.h"
@@ -150,12 +151,12 @@ static void enter_s2idle_proper(struct cpuidle_driver *drv,
 	 */
 	stop_critical_timings();
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
-		rcu_idle_enter();
+		ct_idle_enter();
 	target_state->enter_s2idle(dev, drv, index);
 	if (WARN_ON_ONCE(!irqs_disabled()))
 		local_irq_disable();
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
-		rcu_idle_exit();
+		ct_idle_exit();
 	tick_unfreeze();
 	start_critical_timings();
 
@@ -233,10 +234,10 @@ int cpuidle_enter_state(struct cpuidle_device *dev, struct cpuidle_driver *drv,
 
 	stop_critical_timings();
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
-		rcu_idle_enter();
+		ct_idle_enter();
 	entered_state = target_state->enter(dev, drv, index);
 	if (!(target_state->flags & CPUIDLE_FLAG_RCU_IDLE))
-		rcu_idle_exit();
+		ct_idle_exit();
 	start_critical_timings();
 
 	sched_clock_idle_wakeup_event();
diff --git a/include/linux/context_tracking.h b/include/linux/context_tracking.h
index e35ae66b4794e..01abadb2f9930 100644
--- a/include/linux/context_tracking.h
+++ b/include/linux/context_tracking.h
@@ -119,4 +119,12 @@ extern void context_tracking_init(void);
 static inline void context_tracking_init(void) { }
 #endif /* CONFIG_CONTEXT_TRACKING_USER_FORCE */
 
+#ifdef CONFIG_CONTEXT_TRACKING_IDLE
+extern void ct_idle_enter(void);
+extern void ct_idle_exit(void);
+#else
+static inline void ct_idle_enter(void) { }
+static inline void ct_idle_exit(void) { }
+#endif /* !CONFIG_CONTEXT_TRACKING_IDLE */
+
 #endif
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 1a32036c918cd..6ebe754501c38 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -128,7 +128,7 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
  * @a: Code that RCU needs to pay attention to.
  *
  * RCU read-side critical sections are forbidden in the inner idle loop,
- * that is, between the rcu_idle_enter() and the rcu_idle_exit() -- RCU
+ * that is, between the ct_idle_enter() and the ct_idle_exit() -- RCU
  * will happily ignore any such read-side critical sections.  However,
  * things like powertop need tracepoints in the inner idle loop.
  *
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index a6997daf27d10..e9904f935f7f4 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -22,6 +22,21 @@
 #include <linux/export.h>
 #include <linux/kprobes.h>
 
+
+#ifdef CONFIG_CONTEXT_TRACKING_IDLE
+noinstr void ct_idle_enter(void)
+{
+	rcu_idle_enter();
+}
+EXPORT_SYMBOL_GPL(ct_idle_enter);
+
+void ct_idle_exit(void)
+{
+	rcu_idle_exit();
+}
+EXPORT_SYMBOL_GPL(ct_idle_exit);
+#endif /* #ifdef CONFIG_CONTEXT_TRACKING_IDLE */
+
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 
 #define CREATE_TRACE_POINTS
diff --git a/kernel/locking/lockdep.c b/kernel/locking/lockdep.c
index f06b91ca6482d..5ea690cb4f7af 100644
--- a/kernel/locking/lockdep.c
+++ b/kernel/locking/lockdep.c
@@ -6570,7 +6570,7 @@ void lockdep_rcu_suspicious(const char *file, const int line, const char *s)
 
 	/*
 	 * If a CPU is in the RCU-free window in idle (ie: in the section
-	 * between rcu_idle_enter() and rcu_idle_exit(), then RCU
+	 * between ct_idle_enter() and ct_idle_exit(), then RCU
 	 * considers that CPU to be in an "extended quiescent state",
 	 * which means that RCU will be completely ignoring that CPU.
 	 * Therefore, rcu_read_lock() and friends have absolutely no
diff --git a/kernel/rcu/Kconfig b/kernel/rcu/Kconfig
index 1c630e573548d..3fa24e63d6f9b 100644
--- a/kernel/rcu/Kconfig
+++ b/kernel/rcu/Kconfig
@@ -8,6 +8,8 @@ menu "RCU Subsystem"
 config TREE_RCU
 	bool
 	default y if SMP
+	# Dynticks-idle tracking
+	select CONTEXT_TRACKING_IDLE
 	help
 	  This option selects the RCU implementation that is
 	  designed for very large SMP system with hundreds or
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 9a5edab5558c9..051fed0844b67 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -664,7 +664,6 @@ void noinstr rcu_idle_enter(void)
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
 	rcu_eqs_enter(false);
 }
-EXPORT_SYMBOL_GPL(rcu_idle_enter);
 
 #ifdef CONFIG_NO_HZ_FULL
 
@@ -904,7 +903,6 @@ void noinstr rcu_idle_exit(void)
 	rcu_eqs_exit(false);
 	raw_local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(rcu_idle_exit);
 
 #ifdef CONFIG_NO_HZ_FULL
 /**
diff --git a/kernel/rcu/update.c b/kernel/rcu/update.c
index fc7fef5756064..147214b2cd68e 100644
--- a/kernel/rcu/update.c
+++ b/kernel/rcu/update.c
@@ -85,7 +85,7 @@ module_param(rcu_normal_after_boot, int, 0444);
  * and while lockdep is disabled.
  *
  * Note that if the CPU is in the idle loop from an RCU point of view (ie:
- * that we are in the section between rcu_idle_enter() and rcu_idle_exit())
+ * that we are in the section between ct_idle_enter() and ct_idle_exit())
  * then rcu_read_lock_held() sets ``*ret`` to false even if the CPU did an
  * rcu_read_lock().  The reason for this is that RCU ignores CPUs that are
  * in such a section, considering these as in extended quiescent state,
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 328cccbee4441..f26ab2675f7d7 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -53,14 +53,14 @@ static noinline int __cpuidle cpu_idle_poll(void)
 {
 	trace_cpu_idle(0, smp_processor_id());
 	stop_critical_timings();
-	rcu_idle_enter();
+	ct_idle_enter();
 	local_irq_enable();
 
 	while (!tif_need_resched() &&
 	       (cpu_idle_force_poll || tick_check_broadcast_expired()))
 		cpu_relax();
 
-	rcu_idle_exit();
+	ct_idle_exit();
 	start_critical_timings();
 	trace_cpu_idle(PWR_EVENT_EXIT, smp_processor_id());
 
@@ -98,12 +98,12 @@ void __cpuidle default_idle_call(void)
 		 *
 		 * Trace IRQs enable here, then switch off RCU, and have
 		 * arch_cpu_idle() use raw_local_irq_enable(). Note that
-		 * rcu_idle_enter() relies on lockdep IRQ state, so switch that
+		 * ct_idle_enter() relies on lockdep IRQ state, so switch that
 		 * last -- this is very similar to the entry code.
 		 */
 		trace_hardirqs_on_prepare();
 		lockdep_hardirqs_on_prepare();
-		rcu_idle_enter();
+		ct_idle_enter();
 		lockdep_hardirqs_on(_THIS_IP_);
 
 		arch_cpu_idle();
@@ -116,7 +116,7 @@ void __cpuidle default_idle_call(void)
 		 */
 		raw_local_irq_disable();
 		lockdep_hardirqs_off(_THIS_IP_);
-		rcu_idle_exit();
+		ct_idle_exit();
 		lockdep_hardirqs_on(_THIS_IP_);
 		raw_local_irq_enable();
 
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 47b89a0fc6e55..0cfe2d0af2947 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -27,6 +27,7 @@
 #include <linux/capability.h>
 #include <linux/cgroup_api.h>
 #include <linux/cgroup.h>
+#include <linux/context_tracking.h>
 #include <linux/cpufreq.h>
 #include <linux/cpumask_api.h>
 #include <linux/ctype.h>
diff --git a/kernel/time/Kconfig b/kernel/time/Kconfig
index 41f99bcfe9e66..a41753be1a2bf 100644
--- a/kernel/time/Kconfig
+++ b/kernel/time/Kconfig
@@ -76,6 +76,12 @@ config TIME_KUNIT_TEST
 config CONTEXT_TRACKING
 	bool
 
+config CONTEXT_TRACKING_IDLE
+	bool
+	select CONTEXT_TRACKING
+	help
+	  Tracks idle state on behalf of RCU.
+
 if GENERIC_CLOCKEVENTS
 menu "Timers subsystem"
 
-- 
2.31.1.189.g2e36527f23

