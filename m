Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E71C552809
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:17:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347229AbiFTXQE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:16:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347120AbiFTXMG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:12:06 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A9638222A5;
        Mon, 20 Jun 2022 16:10:45 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 90C7561515;
        Mon, 20 Jun 2022 23:10:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 55D7AC341EF;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=xl4Qv/D8eO08gmDd70pGOWhnlkzRN6HwvsTr8ErlRVs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PeJnwQLjb2yr4ZKchVmSDjcE/5bVBREF2ju+diiQNUrbqfyWJJYCOScGoWeCatTlA
         +p50b69yLyT9aVH0DCMwVi4A00NrVzILftBP23XTuRorgdNKQLMDyMWOUvjwLyE9uW
         cG6nuvxpSYN0FdUsvkXBAB1xqzp7Ppy4jFO7IOL7hDD/5clVvVfEnt3YLjjmULdLIG
         yNTQIcStxJspHy9+66VYx3rAkLvhlKAcA6WFg3MtuJ2qbw8bRA5ZPlwYsqcu0VEXLa
         qtVKzOE5U1/FuitQavSKjnlIJ6Zh0tQc2CZXpOAqDgr6qHZHVrlkYo3akrVS+2JBgB
         g/hhMMvXl1YnQ==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 71F0A5C11DB; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
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
Subject: [PATCH rcu 19/23] rcu/context-tracking: Remove unused and/or unecessary middle functions
Date:   Mon, 20 Jun 2022 16:10:25 -0700
Message-Id: <20220620231029.3844583-19-paulmck@kernel.org>
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

Some eqs functions are now only used internally by context tracking, so
their public declarations can be removed.

Also middle functions such as rcu_user_*() and rcu_idle_*()
which now directly call to rcu_eqs_enter() and rcu_eqs_exit() can be
wiped out as well.

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
 Documentation/RCU/stallwarn.rst |  2 +-
 include/linux/hardirq.h         |  8 ---
 include/linux/rcupdate.h        |  8 ---
 include/linux/rcutiny.h         |  2 -
 include/linux/rcutree.h         |  2 -
 kernel/context_tracking.c       | 98 +++++++++------------------------
 6 files changed, 28 insertions(+), 92 deletions(-)

diff --git a/Documentation/RCU/stallwarn.rst b/Documentation/RCU/stallwarn.rst
index ce1f58a9d954b..e38c587067fc8 100644
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
index 345cdbe9c1b70..d57cab4d4c06f 100644
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
index 3717cad983a67..434da1eb88cd9 100644
--- a/include/linux/rcupdate.h
+++ b/include/linux/rcupdate.h
@@ -104,14 +104,6 @@ static inline void rcu_sysrq_start(void) { }
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
 #if defined(CONFIG_NO_HZ_FULL) && (!defined(CONFIG_GENERIC_ENTRY) || !defined(CONFIG_KVM_XFER_TO_GUEST_WORK))
 void rcu_irq_work_resched(void);
 #else
diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 591119413cf1d..900ba35c3582d 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -76,8 +76,6 @@ static inline int rcu_needs_cpu(void)
 static inline void rcu_virt_note_context_switch(int cpu) { }
 static inline void rcu_cpu_stall_reset(void) { }
 static inline int rcu_jiffies_till_stall_check(void) { return 21 * HZ; }
-static inline void rcu_idle_enter(void) { }
-static inline void rcu_idle_exit(void) { }
 static inline void rcu_irq_exit_check_preempt(void) { }
 #define rcu_is_idle_cpu(cpu) \
 	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 24db1e41695c8..9cca00ed9bc9f 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -45,8 +45,6 @@ unsigned long start_poll_synchronize_rcu(void);
 bool poll_state_synchronize_rcu(unsigned long oldstate);
 void cond_synchronize_rcu(unsigned long oldstate);
 
-void rcu_idle_enter(void);
-void rcu_idle_exit(void);
 bool rcu_is_idle_cpu(int cpu);
 
 #ifdef CONFIG_PROVE_RCU
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index f3e92705e0a89..8b0979412f755 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -189,17 +189,17 @@ static void noinstr rcu_eqs_exit(bool user)
 }
 
 /**
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
-void noinstr rcu_nmi_exit(void)
+void noinstr ct_nmi_exit(void)
 {
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
 
@@ -242,7 +242,7 @@ void noinstr rcu_nmi_exit(void)
 }
 
 /**
- * rcu_nmi_enter - inform RCU of entry to NMI context
+ * ct_nmi_enter - inform RCU of entry to NMI context
  *
  * If the CPU was idle from RCU's viewpoint, update ct->dynticks and
  * ct->dynticks_nmi_nesting to let the RCU grace-period handling know
@@ -250,10 +250,10 @@ void noinstr rcu_nmi_exit(void)
  * long as the nesting level does not overflow an int.  (You will probably
  * run out of stack space first.)
  *
- * If you add or remove a call to rcu_nmi_enter(), be sure to test
+ * If you add or remove a call to ct_nmi_enter(), be sure to test
  * with CONFIG_RCU_EQS_DEBUG=y.
  */
-void noinstr rcu_nmi_enter(void)
+void noinstr ct_nmi_enter(void)
 {
 	long incby = 2;
 	struct context_tracking *ct = this_cpu_ptr(&context_tracking);
@@ -302,32 +302,33 @@ void noinstr rcu_nmi_enter(void)
 }
 
 /**
- * rcu_idle_enter - inform RCU that current CPU is entering idle
+ * ct_idle_enter - inform RCU that current CPU is entering idle
  *
  * Enter idle mode, in other words, -leave- the mode in which RCU
  * read-side critical sections can occur.  (Though RCU read-side
  * critical sections can occur in irq handlers in idle, a possibility
  * handled by irq_enter() and irq_exit().)
  *
- * If you add or remove a call to rcu_idle_enter(), be sure to test with
+ * If you add or remove a call to ct_idle_enter(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void noinstr rcu_idle_enter(void)
+void noinstr ct_idle_enter(void)
 {
 	WARN_ON_ONCE(IS_ENABLED(CONFIG_RCU_EQS_DEBUG) && !raw_irqs_disabled());
 	rcu_eqs_enter(false);
 }
+EXPORT_SYMBOL_GPL(ct_idle_enter);
 
 /**
- * rcu_idle_exit - inform RCU that current CPU is leaving idle
+ * ct_idle_exit - inform RCU that current CPU is leaving idle
  *
  * Exit idle mode, in other words, -enter- the mode in which RCU
  * read-side critical sections can occur.
  *
- * If you add or remove a call to rcu_idle_exit(), be sure to test with
+ * If you add or remove a call to ct_idle_exit(), be sure to test with
  * CONFIG_RCU_EQS_DEBUG=y.
  */
-void noinstr rcu_idle_exit(void)
+void noinstr ct_idle_exit(void)
 {
 	unsigned long flags;
 
@@ -335,18 +336,6 @@ void noinstr rcu_idle_exit(void)
 	rcu_eqs_exit(false);
 	raw_local_irq_restore(flags);
 }
-EXPORT_SYMBOL_GPL(rcu_idle_exit);
-
-noinstr void ct_idle_enter(void)
-{
-	rcu_idle_enter();
-}
-EXPORT_SYMBOL_GPL(ct_idle_enter);
-
-void ct_idle_exit(void)
-{
-	rcu_idle_exit();
-}
 EXPORT_SYMBOL_GPL(ct_idle_exit);
 
 /**
@@ -431,50 +420,11 @@ void ct_irq_exit_irqson(void)
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
+#else
+static __always_inline void rcu_eqs_enter(bool user) { }
+static __always_inline void rcu_eqs_exit(bool user) { }
 #endif /* #ifdef CONFIG_CONTEXT_TRACKING_IDLE */
 
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
-
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
-#endif /* #ifdef CONFIG_NO_HZ_FULL */
-
 #ifdef CONFIG_CONTEXT_TRACKING_USER
 
 #define CREATE_TRACE_POINTS
@@ -542,7 +492,13 @@ void noinstr __ct_user_enter(enum ctx_state state)
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
@@ -579,7 +535,7 @@ void ct_user_enter(enum ctx_state state)
 	/*
 	 * Some contexts may involve an exception occuring in an irq,
 	 * leading to that nesting:
-	 * ct_irq_enter() rcu_user_exit() rcu_user_exit() ct_irq_exit()
+	 * ct_irq_enter() rcu_eqs_exit(true) rcu_eqs_enter(true) ct_irq_exit()
 	 * This would mess up the dyntick_nesting count though. And rcu_irq_*()
 	 * helpers are enough to protect RCU uses inside the exception. So
 	 * just return immediately if we detect we are in an IRQ.
@@ -631,10 +587,10 @@ void noinstr __ct_user_exit(enum ctx_state state)
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
-- 
2.31.1.189.g2e36527f23

