Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCE344CA989
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 16:49:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241758AbiCBPuA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 10:50:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54550 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241237AbiCBPtc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 10:49:32 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5391632066
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 07:48:44 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D575661737
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 15:48:43 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id E3E18C340F3;
        Wed,  2 Mar 2022 15:48:39 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1646236123;
        bh=xod/I3BbXievZhy1QOy5idiuGJKwjYH4mtt5MdZpSk0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=c9Scd/MlbKd46z/H7IO207pkRo+yhMBQ1VweBdz4Wgh4ITARmCvY3yT+Yp/L7ZBCX
         arES+bR8Eu6TVt608MpDTbjqcye2jkFu/Zsd21wwTE9rcGCOk4qyH3SNy4Lgt7ATOt
         10pa10czLT5dXB1YbSgyYhQJaatff0WY3xLqm+9nz5rjmhZky/wS+YfE9Nm4zT0qB1
         oSKFdFo2EiuQ+t+JcP6SwgN5WeHwHsiDrJNLwdxcr2fGNVBu9leu3FxnMCOlZTHYPf
         TzltlqNphHFSXemNd8vPfsu+E3FmcZjRdDoyNWpvO/11pPXfUrEoPRwNS5evKBY0Zw
         +YEGMkydghU7w==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     LKML <linux-kernel@vger.kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        "Paul E . McKenney" <paulmck@kernel.org>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 07/19] context_tracking: Take IRQ eqs entrypoints over RCU
Date:   Wed,  2 Mar 2022 16:47:58 +0100
Message-Id: <20220302154810.42308-8-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220302154810.42308-1-frederic@kernel.org>
References: <20220302154810.42308-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The RCU dynticks counter is going to be merged into the context tracking
subsystem. Prepare with moving the IRQ extended quiescent states
entrypoints to context tracking. For now those are dumb redirection to
existing RCU calls.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Paul E. McKenney <paulmck@kernel.org>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Thomas Gleixner <tglx@linutronix.de>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Nicolas Saenz Julienne <nsaenz@kernel.org>
Cc: Marcelo Tosatti <mtosatti@redhat.com>
Cc: Xiongfeng Wang <wangxiongfeng2@huawei.com>
Cc: Yu Liao<liaoyu15@huawei.com>
Cc: Phil Auld <pauld@redhat.com>
Cc: Paul Gortmaker<paul.gortmaker@windriver.com>
Cc: Alex Belits <abelits@marvell.com>
---
 .../RCU/Design/Requirements/Requirements.rst  | 10 ++++----
 Documentation/RCU/stallwarn.rst               |  4 ++--
 arch/Kconfig                                  |  2 +-
 arch/arm64/kernel/entry-common.c              |  6 ++---
 arch/x86/mm/fault.c                           |  2 +-
 drivers/cpuidle/cpuidle-psci.c                |  8 +++----
 include/linux/context_tracking_irq.h          | 17 +++++++++++++
 include/linux/context_tracking_state.h        |  1 +
 include/linux/entry-common.h                  | 10 ++++----
 include/linux/rcupdate.h                      |  5 ++--
 include/linux/tracepoint.h                    |  4 ++--
 kernel/context_tracking.c                     | 24 +++++++++++++++++--
 kernel/cpu_pm.c                               |  8 +++----
 kernel/entry/common.c                         | 12 +++++-----
 kernel/softirq.c                              |  4 ++--
 kernel/trace/trace.c                          |  6 ++---
 16 files changed, 81 insertions(+), 42 deletions(-)
 create mode 100644 include/linux/context_tracking_irq.h

diff --git a/Documentation/RCU/Design/Requirements/Requirements.rst b/Documentation/RCU/Design/Requirements/Requirements.rst
index ff2be1ac54c4..e3dd5d71c798 100644
--- a/Documentation/RCU/Design/Requirements/Requirements.rst
+++ b/Documentation/RCU/Design/Requirements/Requirements.rst
@@ -1844,10 +1844,10 @@ that meets this requirement.
 
 Furthermore, NMI handlers can be interrupted by what appear to RCU to be
 normal interrupts. One way that this can happen is for code that
-directly invokes rcu_irq_enter() and rcu_irq_exit() to be called
+directly invokes ct_irq_enter() and ct_irq_exit() to be called
 from an NMI handler. This astonishing fact of life prompted the current
-code structure, which has rcu_irq_enter() invoking
-rcu_nmi_enter() and rcu_irq_exit() invoking rcu_nmi_exit().
+code structure, which has ct_irq_enter() invoking
+rcu_nmi_enter() and ct_irq_exit() invoking rcu_nmi_exit().
 And yes, I also learned of this requirement the hard way.
 
 Loadable Modules
@@ -2195,7 +2195,7 @@ scheduling-clock interrupt be enabled when RCU needs it to be:
    sections, and RCU believes this CPU to be idle, no problem. This
    sort of thing is used by some architectures for light-weight
    exception handlers, which can then avoid the overhead of
-   rcu_irq_enter() and rcu_irq_exit() at exception entry and
+   ct_irq_enter() and ct_irq_exit() at exception entry and
    exit, respectively. Some go further and avoid the entireties of
    irq_enter() and irq_exit().
    Just make very sure you are running some of your tests with
@@ -2226,7 +2226,7 @@ scheduling-clock interrupt be enabled when RCU needs it to be:
 +-----------------------------------------------------------------------+
 | **Answer**:                                                           |
 +-----------------------------------------------------------------------+
-| One approach is to do ``rcu_irq_exit();rcu_irq_enter();`` every so    |
+| One approach is to do ``ct_irq_exit();ct_irq_enter();`` every so    |
 | often. But given that long-running interrupt handlers can cause other |
 | problems, not least for response time, shouldn't you work to keep     |
 | your interrupt handler's runtime within reasonable bounds?            |
diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index bdd52b40f307..7858c3afa1f4 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -98,11 +98,11 @@ warnings:
 
 -	A low-level kernel issue that either fails to invoke one of the
 	variants of rcu_user_enter(), rcu_user_exit(), ct_idle_enter(),
-	ct_idle_exit(), rcu_irq_enter(), or rcu_irq_exit() on the one
+	ct_idle_exit(), ct_irq_enter(), or ct_irq_exit() on the one
 	hand, or that invokes one of them too many times on the other.
 	Historically, the most frequent issue has been an omission
 	of either irq_enter() or irq_exit(), which in turn invoke
-	rcu_irq_enter() or rcu_irq_exit(), respectively.  Building your
+	ct_irq_enter() or ct_irq_exit(), respectively.  Building your
 	kernel with CONFIG_RCU_EQS_DEBUG=y can help track down these types
 	of issues, which sometimes arise in architecture-specific code.
 
diff --git a/arch/Kconfig b/arch/Kconfig
index 1a3b79cfc9e3..66b2b6d4717b 100644
--- a/arch/Kconfig
+++ b/arch/Kconfig
@@ -770,7 +770,7 @@ config HAVE_CONTEXT_TRACKING_USER
 	  Syscalls need to be wrapped inside user_exit()-user_enter(), either
 	  optimized behind static key or through the slow path using TIF_NOHZ
 	  flag. Exceptions handlers must be wrapped as well. Irqs are already
-	  protected inside rcu_irq_enter/rcu_irq_exit() but preemption or signal
+	  protected inside ct_irq_enter/ct_irq_exit() but preemption or signal
 	  handling on irq exit still need to be protected.
 
 config HAVE_CONTEXT_TRACKING_USER_OFFSTACK
diff --git a/arch/arm64/kernel/entry-common.c b/arch/arm64/kernel/entry-common.c
index ef7fcefb96bd..43ca8cf4e1dd 100644
--- a/arch/arm64/kernel/entry-common.c
+++ b/arch/arm64/kernel/entry-common.c
@@ -40,7 +40,7 @@ static __always_inline void __enter_from_kernel_mode(struct pt_regs *regs)
 
 	if (!IS_ENABLED(CONFIG_TINY_RCU) && is_idle_task(current)) {
 		lockdep_hardirqs_off(CALLER_ADDR0);
-		rcu_irq_enter();
+		ct_irq_enter();
 		trace_hardirqs_off_finish();
 
 		regs->exit_rcu = true;
@@ -74,7 +74,7 @@ static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs)
 		if (regs->exit_rcu) {
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
-			rcu_irq_exit();
+			ct_irq_exit();
 			lockdep_hardirqs_on(CALLER_ADDR0);
 			return;
 		}
@@ -82,7 +82,7 @@ static __always_inline void __exit_to_kernel_mode(struct pt_regs *regs)
 		trace_hardirqs_on();
 	} else {
 		if (regs->exit_rcu)
-			rcu_irq_exit();
+			ct_irq_exit();
 	}
 }
 
diff --git a/arch/x86/mm/fault.c b/arch/x86/mm/fault.c
index d0074c6ed31a..b781785b1ff3 100644
--- a/arch/x86/mm/fault.c
+++ b/arch/x86/mm/fault.c
@@ -1526,7 +1526,7 @@ DEFINE_IDTENTRY_RAW_ERRORCODE(exc_page_fault)
 
 	/*
 	 * Entry handling for valid #PF from kernel mode is slightly
-	 * different: RCU is already watching and rcu_irq_enter() must not
+	 * different: RCU is already watching and ct_irq_enter() must not
 	 * be invoked because a kernel fault on a user space address might
 	 * sleep.
 	 *
diff --git a/drivers/cpuidle/cpuidle-psci.c b/drivers/cpuidle/cpuidle-psci.c
index b51b5df08450..fe31b2d522b3 100644
--- a/drivers/cpuidle/cpuidle-psci.c
+++ b/drivers/cpuidle/cpuidle-psci.c
@@ -68,12 +68,12 @@ static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 		return -1;
 
 	/* Do runtime PM to manage a hierarchical CPU toplogy. */
-	rcu_irq_enter_irqson();
+	ct_irq_enter_irqson();
 	if (s2idle)
 		dev_pm_genpd_suspend(pd_dev);
 	else
 		pm_runtime_put_sync_suspend(pd_dev);
-	rcu_irq_exit_irqson();
+	ct_irq_exit_irqson();
 
 	state = psci_get_domain_state();
 	if (!state)
@@ -81,12 +81,12 @@ static int __psci_enter_domain_idle_state(struct cpuidle_device *dev,
 
 	ret = psci_cpu_suspend_enter(state) ? -1 : idx;
 
-	rcu_irq_enter_irqson();
+	ct_irq_enter_irqson();
 	if (s2idle)
 		dev_pm_genpd_resume(pd_dev);
 	else
 		pm_runtime_get_sync(pd_dev);
-	rcu_irq_exit_irqson();
+	ct_irq_exit_irqson();
 
 	cpu_pm_exit();
 
diff --git a/include/linux/context_tracking_irq.h b/include/linux/context_tracking_irq.h
new file mode 100644
index 000000000000..60e3ed15a04e
--- /dev/null
+++ b/include/linux/context_tracking_irq.h
@@ -0,0 +1,17 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+#ifndef _LINUX_CONTEXT_TRACKING_IRQ_H
+#define _LINUX_CONTEXT_TRACKING_IRQ_H
+
+#ifdef CONFIG_CONTEXT_TRACKING
+void ct_irq_enter(void);
+void ct_irq_exit(void);
+void ct_irq_enter_irqson(void);
+void ct_irq_exit_irqson(void);
+#else
+static inline void ct_irq_enter(void) { }
+static inline void ct_irq_exit(void) { }
+static inline void ct_irq_enter_irqson(void) { }
+static inline void ct_irq_exit_irqson(void) { }
+#endif
+
+#endif
diff --git a/include/linux/context_tracking_state.h b/include/linux/context_tracking_state.h
index 64dbbb880378..cdc692caa01d 100644
--- a/include/linux/context_tracking_state.h
+++ b/include/linux/context_tracking_state.h
@@ -4,6 +4,7 @@
 
 #include <linux/percpu.h>
 #include <linux/static_key.h>
+#include <linux/context_tracking_irq.h>
 
 struct context_tracking {
 	/*
diff --git a/include/linux/entry-common.h b/include/linux/entry-common.h
index 2e2b8d6140ed..7c6b1d864448 100644
--- a/include/linux/entry-common.h
+++ b/include/linux/entry-common.h
@@ -396,7 +396,7 @@ void irqentry_exit_to_user_mode(struct pt_regs *regs);
 /**
  * struct irqentry_state - Opaque object for exception state storage
  * @exit_rcu: Used exclusively in the irqentry_*() calls; signals whether the
- *            exit path has to invoke rcu_irq_exit().
+ *            exit path has to invoke ct_irq_exit().
  * @lockdep: Used exclusively in the irqentry_nmi_*() calls; ensures that
  *           lockdep state is restored correctly on exit from nmi.
  *
@@ -434,12 +434,12 @@ typedef struct irqentry_state {
  *
  * For kernel mode entries RCU handling is done conditional. If RCU is
  * watching then the only RCU requirement is to check whether the tick has
- * to be restarted. If RCU is not watching then rcu_irq_enter() has to be
- * invoked on entry and rcu_irq_exit() on exit.
+ * to be restarted. If RCU is not watching then ct_irq_enter() has to be
+ * invoked on entry and ct_irq_exit() on exit.
  *
- * Avoiding the rcu_irq_enter/exit() calls is an optimization but also
+ * Avoiding the ct_irq_enter/exit() calls is an optimization but also
  * solves the problem of kernel mode pagefaults which can schedule, which
- * is not possible after invoking rcu_irq_enter() without undoing it.
+ * is not possible after invoking ct_irq_enter() without undoing it.
  *
  * For user mode entries irqentry_enter_from_user_mode() is invoked to
  * establish the proper context for NOHZ_FULL. Otherwise scheduling on exit
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 38258542a6c3..5efba2bfa689 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -29,6 +29,7 @@
 #include <linux/lockdep.h>
 #include <asm/processor.h>
 #include <linux/cpumask.h>
+#include <linux/context_tracking_irq.h>
 
 #define ULONG_CMP_GE(a, b)	(ULONG_MAX / 2 >= (a) - (b))
 #define ULONG_CMP_LT(a, b)	(ULONG_MAX / 2 < (a) - (b))
@@ -143,9 +144,9 @@ static inline void rcu_nocb_flush_deferred_wakeup(void) { }
  */
 #define RCU_NONIDLE(a) \
 	do { \
-		rcu_irq_enter_irqson(); \
+		ct_irq_enter_irqson(); \
 		do { a; } while (0); \
-		rcu_irq_exit_irqson(); \
+		ct_irq_exit_irqson(); \
 	} while (0)
 
 /*
diff --git a/include/linux/tracepoint.h b/include/linux/tracepoint.h
index 28031b15f878..55717a2eda08 100644
--- a/include/linux/tracepoint.h
+++ b/include/linux/tracepoint.h
@@ -200,13 +200,13 @@ static inline struct tracepoint *tracepoint_ptr_deref(tracepoint_ptr_t *p)
 		 */							\
 		if (rcuidle) {						\
 			__idx = srcu_read_lock_notrace(&tracepoint_srcu);\
-			rcu_irq_enter_irqson();				\
+			ct_irq_enter_irqson();				\
 		}							\
 									\
 		__DO_TRACE_CALL(name, TP_ARGS(args));			\
 									\
 		if (rcuidle) {						\
-			rcu_irq_exit_irqson();				\
+			ct_irq_exit_irqson();				\
 			srcu_read_unlock_notrace(&tracepoint_srcu, __idx);\
 		}							\
 									\
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 3d479f363275..b63ff851472e 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -75,7 +75,7 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * At this stage, only low level arch entry code remains and
 			 * then we'll run in userspace. We can assume there won't be
 			 * any RCU read-side critical section until the next call to
-			 * user_exit() or rcu_irq_enter(). Let's remove RCU's dependency
+			 * user_exit() or ct_irq_enter(). Let's remove RCU's dependency
 			 * on the tick.
 			 */
 			if (state == CONTEXT_USER) {
@@ -112,7 +112,7 @@ void ct_user_enter(enum ctx_state state)
 	/*
 	 * Some contexts may involve an exception occuring in an irq,
 	 * leading to that nesting:
-	 * rcu_irq_enter() rcu_user_exit() rcu_user_exit() rcu_irq_exit()
+	 * ct_irq_enter() rcu_user_exit() rcu_user_exit() ct_irq_exit()
 	 * This would mess up the dyntick_nesting count though. And rcu_irq_*()
 	 * helpers are enough to protect RCU uses inside the exception. So
 	 * just return immediately if we detect we are in an IRQ.
@@ -247,3 +247,23 @@ void ct_idle_exit(void)
 	rcu_idle_exit();
 }
 EXPORT_SYMBOL_GPL(ct_idle_exit);
+
+noinstr void ct_irq_enter(void)
+{
+	rcu_irq_enter();
+}
+
+noinstr void ct_irq_exit(void)
+{
+	rcu_irq_exit();
+}
+
+void ct_irq_enter_irqson(void)
+{
+	rcu_irq_enter_irqson();
+}
+
+void ct_irq_exit_irqson(void)
+{
+	rcu_irq_exit_irqson();
+}
diff --git a/kernel/cpu_pm.c b/kernel/cpu_pm.c
index 246efc74e3f3..ba4ba71facf9 100644
--- a/kernel/cpu_pm.c
+++ b/kernel/cpu_pm.c
@@ -35,11 +35,11 @@ static int cpu_pm_notify(enum cpu_pm_event event)
 	 * disfunctional in cpu idle. Copy RCU_NONIDLE code to let RCU know
 	 * this.
 	 */
-	rcu_irq_enter_irqson();
+	ct_irq_enter_irqson();
 	rcu_read_lock();
 	ret = raw_notifier_call_chain(&cpu_pm_notifier.chain, event, NULL);
 	rcu_read_unlock();
-	rcu_irq_exit_irqson();
+	ct_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
 }
@@ -49,11 +49,11 @@ static int cpu_pm_notify_robust(enum cpu_pm_event event_up, enum cpu_pm_event ev
 	unsigned long flags;
 	int ret;
 
-	rcu_irq_enter_irqson();
+	ct_irq_enter_irqson();
 	raw_spin_lock_irqsave(&cpu_pm_notifier.lock, flags);
 	ret = raw_notifier_call_chain_robust(&cpu_pm_notifier.chain, event_up, event_down, NULL);
 	raw_spin_unlock_irqrestore(&cpu_pm_notifier.lock, flags);
-	rcu_irq_exit_irqson();
+	ct_irq_exit_irqson();
 
 	return notifier_to_errno(ret);
 }
diff --git a/kernel/entry/common.c b/kernel/entry/common.c
index bad713684c2e..cebc98b8adc6 100644
--- a/kernel/entry/common.c
+++ b/kernel/entry/common.c
@@ -327,7 +327,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	}
 
 	/*
-	 * If this entry hit the idle task invoke rcu_irq_enter() whether
+	 * If this entry hit the idle task invoke ct_irq_enter() whether
 	 * RCU is watching or not.
 	 *
 	 * Interrupts can nest when the first interrupt invokes softirq
@@ -338,12 +338,12 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 	 * not nested into another interrupt.
 	 *
 	 * Checking for rcu_is_watching() here would prevent the nesting
-	 * interrupt to invoke rcu_irq_enter(). If that nested interrupt is
+	 * interrupt to invoke ct_irq_enter(). If that nested interrupt is
 	 * the tick then rcu_flavor_sched_clock_irq() would wrongfully
 	 * assume that it is the first interrupt and eventually claim
 	 * quiescent state and end grace periods prematurely.
 	 *
-	 * Unconditionally invoke rcu_irq_enter() so RCU state stays
+	 * Unconditionally invoke ct_irq_enter() so RCU state stays
 	 * consistent.
 	 *
 	 * TINY_RCU does not support EQS, so let the compiler eliminate
@@ -356,7 +356,7 @@ noinstr irqentry_state_t irqentry_enter(struct pt_regs *regs)
 		 * as in irqentry_enter_from_user_mode().
 		 */
 		lockdep_hardirqs_off(CALLER_ADDR0);
-		rcu_irq_enter();
+		ct_irq_enter();
 		instrumentation_begin();
 		trace_hardirqs_off_finish();
 		instrumentation_end();
@@ -414,7 +414,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 			trace_hardirqs_on_prepare();
 			lockdep_hardirqs_on_prepare(CALLER_ADDR0);
 			instrumentation_end();
-			rcu_irq_exit();
+			ct_irq_exit();
 			lockdep_hardirqs_on(CALLER_ADDR0);
 			return;
 		}
@@ -436,7 +436,7 @@ noinstr void irqentry_exit(struct pt_regs *regs, irqentry_state_t state)
 		 * was not watching on entry.
 		 */
 		if (state.exit_rcu)
-			rcu_irq_exit();
+			ct_irq_exit();
 	}
 }
 
diff --git a/kernel/softirq.c b/kernel/softirq.c
index 41f470929e99..7b6761c1a0f3 100644
--- a/kernel/softirq.c
+++ b/kernel/softirq.c
@@ -607,7 +607,7 @@ void irq_enter_rcu(void)
  */
 void irq_enter(void)
 {
-	rcu_irq_enter();
+	ct_irq_enter();
 	irq_enter_rcu();
 }
 
@@ -659,7 +659,7 @@ void irq_exit_rcu(void)
 void irq_exit(void)
 {
 	__irq_exit_rcu();
-	rcu_irq_exit();
+	ct_irq_exit();
 	 /* must be last! */
 	lockdep_hardirq_exit();
 }
diff --git a/kernel/trace/trace.c b/kernel/trace/trace.c
index a569a0cb81ee..7c500c708180 100644
--- a/kernel/trace/trace.c
+++ b/kernel/trace/trace.c
@@ -3088,15 +3088,15 @@ void __trace_stack(struct trace_array *tr, unsigned int trace_ctx,
 	/*
 	 * When an NMI triggers, RCU is enabled via rcu_nmi_enter(),
 	 * but if the above rcu_is_watching() failed, then the NMI
-	 * triggered someplace critical, and rcu_irq_enter() should
+	 * triggered someplace critical, and ct_irq_enter() should
 	 * not be called from NMI.
 	 */
 	if (unlikely(in_nmi()))
 		return;
 
-	rcu_irq_enter_irqson();
+	ct_irq_enter_irqson();
 	__ftrace_trace_stack(buffer, trace_ctx, skip, NULL);
-	rcu_irq_exit_irqson();
+	ct_irq_exit_irqson();
 }
 
 /**
-- 
2.25.1

