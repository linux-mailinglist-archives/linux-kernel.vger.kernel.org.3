Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 184C35181EB
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 12:03:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234036AbiECKGe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 06:06:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234214AbiECKGP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 06:06:15 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A1ECD3983C
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 03:02:13 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 411D1B81C96
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 10:02:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EAD87C385BB;
        Tue,  3 May 2022 10:02:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651572131;
        bh=twsdKeg1BiJ0kaSJbwYhbKiCBWwghWtn3Tq0Oq38oPw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=hC8zC0ILZ0FEDCkkbrFrR4anpLA3qA3tLP1ED7SIUiy87VCfUb7LdRneQbdXT2P0w
         j7KfvIHkSI0X/IyutcTqZ6x9sonaXvkxBroSkioXQnKG+3GjzuKjPGaiOShAWOePay
         QOUXanU/+8wAUS3u/6w+54a5DUrjmbkSdjAh/e0Tf8fqt0Qh9LNP+3WdB6b4AAzW83
         Wc8d4QIEQtAonR+3OBQTiMck4oMUGaeroD5XtXSEjFqKIldJ888J7KUMiCUFYnEbjk
         KIGAgFw2Y7vTJ9R9WSXDtfcgf5Jj8mK6VWIXFrcd9uKIiO6Yz/a3phHCpPHk7hdwC3
         LrkWLwQi/tMXw==
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
Subject: [PATCH 19/21] rcu/context-tracking: Remove unused and/or unecessary middle functions
Date:   Tue,  3 May 2022 12:00:49 +0200
Message-Id: <20220503100051.2799723-20-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220503100051.2799723-1-frederic@kernel.org>
References: <20220503100051.2799723-1-frederic@kernel.org>
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

Some eqs functions are now only used internally by context tracking, so
their public declarations can be removed.

Also middle functions such as rcu_user_*() and rcu_idle_*()
which now directly call to rcu_eqs_enter() and rcu_eqs_exit() can be
wiped out as well.

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
 Documentation/RCU/stallwarn.rst |   2 +-
 include/linux/hardirq.h         |   8 --
 include/linux/rcupdate.h        |   8 --
 include/linux/rcutiny.h         |   2 -
 include/linux/rcutree.h         |   2 -
 kernel/context_tracking.c       | 147 +++++++++++---------------------
 6 files changed, 50 insertions(+), 119 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index 7858c3afa1f4..bebcaef475a6 100644
--- a/Documentation/RCU/stallwarn.rst
+++ b/Documentation/RCU/stallwarn.rst
@@ -97,7 +97,7 @@ warnings:
 	which will include additional debugging information.
 
 -	A low-level kernel issue that either fails to invoke one of the
-	variants of rcu_user_enter(), rcu_user_exit(), ct_idle_enter(),
+	variants of rcu_eqs_enter(true), rcu_eqs_exit(true), ct_idle_enter(),
 	ct_idle_exit(), ct_irq_enter(), or ct_irq_exit() on the one
 	hand, or that invokes one of them too many times on the other.
 	Historically, the most frequent issue has been an omission
diff --git a/include/linux/hardirq.h b/include/linux/hardirq.h
index 345cdbe9c1b7..d57cab4d4c06 100644
--- a/include/linux/hardirq.h
+++ b/include/linux/hardirq.h
@@ -92,14 +92,6 @@ void irq_exit_rcu(void);
 #define arch_nmi_exit()		do { } while (0)
 #endif
 
-#ifdef CONFIG_TINY_RCU
-static inline void rcu_nmi_enter(void) { }
-static inline void rcu_nmi_exit(void) { }
-#else
-extern void rcu_nmi_enter(void);
-extern void rcu_nmi_exit(void);
-#endif
-
 /*
  * NMI vs Tracing
  * --------------
diff --git a/include/linux/rcupdate.h b/include/linux/rcupdate.h
index 923e4fa04338..79ea1a45adf0 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -105,14 +105,6 @@ static inline void rcu_sysrq_start(void) { }
 static inline void rcu_sysrq_end(void) { }
 #endif /* #else #ifdef CONFIG_RCU_STALL_COMMON */
 
-#ifdef CONFIG_NO_HZ_FULL
-void rcu_user_enter(void);
-void rcu_user_exit(void);
-#else
-static inline void rcu_user_enter(void) { }
-static inline void rcu_user_exit(void) { }
-#endif /* CONFIG_NO_HZ_FULL */
-
 #ifdef CONFIG_RCU_NOCB_CPU
 void rcu_init_nohz(void);
 int rcu_nocb_cpu_offload(int cpu);
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 5921d9ae7ab5..430aac8a7344 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -86,8 +86,6 @@ static inline int rcu_needs_cpu(void)
 static inline void rcu_virt_note_context_switch(int cpu) { }
 static inline void rcu_cpu_stall_reset(void) { }
 static inline int rcu_jiffies_till_stall_check(void) { return 21 * HZ; }
-static inline void rcu_idle_enter(void) { }
-static inline void rcu_idle_exit(void) { }
 static inline void rcu_irq_exit_check_preempt(void) { }
 #define rcu_is_idle_cpu(cpu) \
 	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index d9e8e6233c47..72131447762e 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -47,8 +47,6 @@ unsigned long start_poll_synchronize_rcu(void);
 bool poll_state_synchronize_rcu(unsigned long oldstate);
 void cond_synchronize_rcu(unsigned long oldstate);
 
-void rcu_idle_enter(void);
-void rcu_idle_exit(void);
 bool rcu_is_idle_cpu(int cpu);
 
 #ifdef CONFIG_PROVE_RCU
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 279fb5875dd8..b906fb55903b 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -140,52 +140,17 @@ static noinstr void rcu_eqs_enter(bool user)
 }
 
 /**
- * rcu_idle_enter - inform RCU that current CPU is entering idle
- *
- * Enter idle mode, in other words, -leave- the mode in which RCU
- * read-side critical sections can occur.  (Though RCU read-side
- * critical sections can occur in irq handlers in idle, a possibility
- * handled by irq_enter() and irq_exit().)
- *
- * If you add or remove a call to rcu_idle_enter(), be sure to test with
- * CONFIG_RCU_EQS_DEBUG=y.
- */
-noinstr void rcu_idle_enter(void)
-{
-	lockdep_assert_irqs_disabled();
-	rcu_eqs_enter(false);
-}
-
-#ifdef CONFIG_NO_HZ_FULL
-/**
- * rcu_user_enter - inform RCU that we are resuming userspace.
- *
- * Enter RCU idle mode right before resuming userspace.  No use of RCU
- * is permitted between this call and rcu_user_exit(). This way the
- * CPU doesn't need to maintain the tick for RCU maintenance purposes
- * when the CPU runs in userspace.
- *
- * If you add or remove a call to rcu_user_enter(), be sure to test with
- * CONFIG_RCU_EQS_DEBUG=y.
- */
-noinstr void rcu_user_enter(void)
-{
-	rcu_eqs_enter(true);
-}
-#endif /* CONFIG_NO_HZ_FULL */
-
-/**
- * rcu_nmi_exit - inform RCU of exit from NMI context
+ * ct_nmi_exit - inform RCU of exit from NMI context
  *
  * If we are returning from the outermost NMI handler that interrupted an
  * RCU-idle period, update ct->dynticks and ct->dynticks_nmi_nesting
  * to let the RCU grace-period handling know that the CPU is back to
  * being RCU-idle.
  *
- * If you add or remove a call to rcu_nmi_exit(), be sure to test
+ * If you add or remove a call to ct_nmi_exit(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-noinstr void rcu_nmi_exit(void)
+noinstr void ct_nmi_exit(void)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
@@ -266,46 +231,7 @@ static void noinstr rcu_eqs_exit(bool user)
 }
 
 /**
- * rcu_idle_exit - inform RCU that current CPU is leaving idle
- *
- * Exit idle mode, in other words, -enter- the mode in which RCU
- * read-side critical sections can occur.
- *
- * If you add or remove a call to rcu_idle_exit(), be sure to test with
- * CONFIG_RCU_EQS_DEBUG=y.
- *
- * FIXME: This function should be noinstr but the below local_irq_save() is
- * unsafe because it involves illegal RCU uses through tracing and lockdep.
- * This must be fixed first.
- */
-void rcu_idle_exit(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	rcu_eqs_exit(false);
-	local_irq_restore(flags);
-}
-EXPORT_SYMBOL_GPL(rcu_idle_exit);
-
-#ifdef CONFIG_NO_HZ_FULL
-/**
- * rcu_user_exit - inform RCU that we are exiting userspace.
- *
- * Exit RCU idle mode while entering the kernel because it can
- * run a RCU read side critical section anytime.
- *
- * If you add or remove a call to rcu_user_exit(), be sure to test with
- * CONFIG_RCU_EQS_DEBUG=y.
- */
-void noinstr rcu_user_exit(void)
-{
-	rcu_eqs_exit(true);
-}
-#endif /* ifdef CONFIG_NO_HZ_FULL */
-
-/**
- * rcu_nmi_enter - inform RCU of entry to NMI context
+ * ct_nmi_enter - inform RCU of entry to NMI context
  *
  * If the CPU was idle from RCU's viewpoint, update ct->dynticks and
  * ct->dynticks_nmi_nesting to let the RCU grace-period handling know
@@ -313,10 +239,10 @@ void noinstr rcu_user_exit(void)
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
  *
- * If you add or remove a call to rcu_nmi_enter(), be sure to test
+ * If you add or remove a call to ct_nmi_enter(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-noinstr void rcu_nmi_enter(void)
+noinstr void ct_nmi_enter(void)
 {
 	long incby = 2;
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
@@ -431,7 +357,13 @@ void noinstr __ct_user_enter(enum ctx_state state)
 			 * that will fire and reschedule once we resume in user/guest mode.
 			 */
 			rcu_irq_work_resched();
-			rcu_user_enter();
+			/*
+			 * Enter RCU idle mode right before resuming userspace.  No use of RCU
+			 * is permitted between this call and rcu_eqs_exit(). This way the
+			 * CPU doesn't need to maintain the tick for RCU maintenance purposes
+			 * when the CPU runs in userspace.
+			 */
+			rcu_eqs_enter(true);
 		}
 		/*
 		 * Even if context tracking is disabled on this CPU, because it's outside
@@ -464,7 +396,7 @@ void ct_user_enter(enum ctx_state state)
 	/*
 	 * Some contexts may involve an exception occuring in an irq,
 	 * leading to that nesting:
-	 * ct_irq_enter() rcu_user_exit() rcu_user_exit() ct_irq_exit()
+	 * ct_irq_enter() rcu_eqs_exit(true) rcu_eqs_enter(true) ct_irq_exit()
 	 * This would mess up the dyntick_nesting count though. And rcu_irq_*()
 	 * helpers are enough to protect RCU uses inside the exception. So
 	 * just return immediately if we detect we are in an IRQ.
@@ -513,10 +445,10 @@ void noinstr __ct_user_exit(enum ctx_state state)
 	if (__this_cpu_read(context_tracking.state) == state) {
 		if (__this_cpu_read(context_tracking.active)) {
 			/*
-			 * We are going to run code that may use RCU. Inform
-			 * RCU core about that (ie: we may need the tick again).
+			 * Exit RCU idle mode while entering the kernel because it can
+			 * run a RCU read side critical section anytime.
 			 */
-			rcu_user_exit();
+			rcu_eqs_exit(true);
 			if (state == CONTEXT_USER) {
 				instrumentation_begin();
 				vtime_user_exit(current);
@@ -606,16 +538,45 @@ DEFINE_PER_CPU(struct context_tracking, context_tracking) = {
 };
 EXPORT_SYMBOL_GPL(context_tracking);
 
-
+/**
+ * ct_idle_enter - inform RCU that current CPU is entering idle
+ *
+ * Enter idle mode, in other words, -leave- the mode in which RCU
+ * read-side critical sections can occur.  (Though RCU read-side
+ * critical sections can occur in irq handlers in idle, a possibility
+ * handled by irq_enter() and irq_exit().)
+ *
+ * If you add or remove a call to ct_idle_enter(), be sure to test with
+ * CONFIG_RCU_EQS_DEBUG=y.
+ */
 noinstr void ct_idle_enter(void)
 {
-	rcu_idle_enter();
+	lockdep_assert_irqs_disabled();
+	rcu_eqs_enter(false);
 }
 EXPORT_SYMBOL_GPL(ct_idle_enter);
 
+/**
+ * ct_idle_exit - inform RCU that current CPU is leaving idle
+ *
+ * Exit idle mode, in other words, -enter- the mode in which RCU
+ * read-side critical sections can occur.
+ *
+ * If you add or remove a call to ct_idle_exit(), be sure to test with
+ * CONFIG_RCU_EQS_DEBUG=y.
+ *
+ * FIXME: This function should be noinstr but the below local_irq_save() is
+ * unsafe because it involves illegal RCU uses through tracing and lockdep.
+ * This must be fixed first.
+ */
 void ct_idle_exit(void)
 {
-	rcu_idle_exit();
+	unsigned long flags;
+
+	local_irq_save(flags);
+	rcu_eqs_exit(false);
+	local_irq_restore(flags);
+
 }
 EXPORT_SYMBOL_GPL(ct_idle_exit);
 
@@ -709,13 +670,3 @@ void ct_irq_exit_irqson(void)
 	ct_irq_exit();
 	local_irq_restore(flags);
 }
-
-noinstr void ct_nmi_enter(void)
-{
-	rcu_nmi_enter();
-}
-
-noinstr void ct_nmi_exit(void)
-{
-	rcu_nmi_exit();
-}
-- 
2.25.1

