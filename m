Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6970155E44C
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346292AbiF1NSE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:18:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346340AbiF1NRb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:17:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C645338A1
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:17:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9E3BC61773
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 13:17:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 385E3C341CB;
        Tue, 28 Jun 2022 13:17:11 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656422235;
        bh=CKvspgON2AAXab9DYh3WkZ2WHnHNk6fD1Cej9nblgDk=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=Dv+GQAWUfmiQCq6jpfAtu6heowy/SyKMNxCDgJccE+ip97sxWskEa/6Sy68bU9G9N
         15uZFsq66WRP4aK1q5wx9KDnQbijaSJUuNM7A0LirLfwWwvY4iuEeME9yHz7MSyuIF
         ipFIsPrBqshXkXvwZ+OGxfOGuMEUZR59hKAwsVOeY6pjbZco5VTytnnqmIAqQujDJY
         WgRXhbIk5r739xmPpqbglMHExO0umMZYDxrCEnLKH8dEhsePqMST5n3paHrjCmAp2I
         /kLYQN63k8h7BKk5KGSWMoH5h2eYj9H1yW7iVDkIUjbfU2ZoC8yiDDMFluJu7oQBnu
         i7BBuORGGfitg==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Phil Auld <pauld@redhat.com>,
        Alex Belits <abelits@marvell.com>,
        Nicolas Saenz Julienne <nsaenz@kernel.org>,
        Marco Elver <elver@google.com>,
        Xiongfeng Wang <wangxiongfeng2@huawei.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Nicolas Saenz Julienne <nsaenzju@redhat.com>,
        Max Filippov <jcmvbkbc@gmail.com>,
        Yu Liao <liaoyu15@huawei.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Marcelo Tosatti <mtosatti@redhat.com>,
        kernel test robot <lkp@intel.com>,
        Paul Gortmaker <paul.gortmaker@windriver.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 11/20] rcu/context-tracking: Remove rcu_irq_enter/exit()
Date:   Tue, 28 Jun 2022 15:16:10 +0200
Message-Id: <20220628131619.2109651-12-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220628131619.2109651-1-frederic@kernel.org>
References: <20220628131619.2109651-1-frederic@kernel.org>
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

Now rcu_irq_enter/exit() is an unnecessary middle call between
ct_irq_enter/exit() and nmi_irq_enter/exit(). Take this opportunity
to remove the former functions and move the comments above them to the
new entrypoints.

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
Reviewed-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
Tested-by: Nicolas Saenz Julienne <nsaenzju@redhat.com>
---
 include/linux/rcutiny.h   |  4 --
 include/linux/rcutree.h   |  4 --
 kernel/context_tracking.c | 71 +++++++++++++++++++++++++++++++--
 kernel/rcu/tree.c         | 83 ---------------------------------------
 4 files changed, 67 insertions(+), 95 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 5fed476f977f..591119413cf1 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -78,10 +78,6 @@ static inline void rcu_cpu_stall_reset(void) { }
 static inline int rcu_jiffies_till_stall_check(void) { return 21 * HZ; }
 static inline void rcu_idle_enter(void) { }
 static inline void rcu_idle_exit(void) { }
-static inline void rcu_irq_enter(void) { }
-static inline void rcu_irq_exit_irqson(void) { }
-static inline void rcu_irq_enter_irqson(void) { }
-static inline void rcu_irq_exit(void) { }
 static inline void rcu_irq_exit_check_preempt(void) { }
 #define rcu_is_idle_cpu(cpu) \
 	(is_idle_task(current) && !in_nmi() && !in_hardirq() && !in_serving_softirq())
diff --git a/include/linux/rcutree.h b/include/linux/rcutree.h
index 9c6cfb742504..4522b6a7cc42 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -47,10 +47,6 @@ void cond_synchronize_rcu(unsigned long oldstate);
 
 void rcu_idle_enter(void);
 void rcu_idle_exit(void);
-void rcu_irq_enter(void);
-void rcu_irq_exit(void);
-void rcu_irq_enter_irqson(void);
-void rcu_irq_exit_irqson(void);
 bool rcu_is_idle_cpu(int cpu);
 
 #ifdef CONFIG_PROVE_RCU
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index b8a731f20778..c0d86dac98f1 100644
--- a/kernel/context_tracking.c
+++ b/kernel/context_tracking.c
@@ -36,24 +36,87 @@ void ct_idle_exit(void)
 }
 EXPORT_SYMBOL_GPL(ct_idle_exit);
 
+/**
+ * ct_irq_enter - inform RCU that current CPU is entering irq away from idle
+ *
+ * Enter an interrupt handler, which might possibly result in exiting
+ * idle mode, in other words, entering the mode in which read-side critical
+ * sections can occur.  The caller must have disabled interrupts.
+ *
+ * Note that the Linux kernel is fully capable of entering an interrupt
+ * handler that it never exits, for example when doing upcalls to user mode!
+ * This code assumes that the idle loop never does upcalls to user mode.
+ * If your architecture's idle loop does do upcalls to user mode (or does
+ * anything else that results in unbalanced calls to the irq_enter() and
+ * irq_exit() functions), RCU will give you what you deserve, good and hard.
+ * But very infrequently and irreproducibly.
+ *
+ * Use things like work queues to work around this limitation.
+ *
+ * You have been warned.
+ *
+ * If you add or remove a call to ct_irq_enter(), be sure to test with
+ * CONFIG_RCU_EQS_DEBUG=y.
+ */
 noinstr void ct_irq_enter(void)
 {
-	rcu_irq_enter();
+	lockdep_assert_irqs_disabled();
+	ct_nmi_enter();
 }
 
+/**
+ * ct_irq_exit - inform RCU that current CPU is exiting irq towards idle
+ *
+ * Exit from an interrupt handler, which might possibly result in entering
+ * idle mode, in other words, leaving the mode in which read-side critical
+ * sections can occur.  The caller must have disabled interrupts.
+ *
+ * This code assumes that the idle loop never does anything that might
+ * result in unbalanced calls to irq_enter() and irq_exit().  If your
+ * architecture's idle loop violates this assumption, RCU will give you what
+ * you deserve, good and hard.  But very infrequently and irreproducibly.
+ *
+ * Use things like work queues to work around this limitation.
+ *
+ * You have been warned.
+ *
+ * If you add or remove a call to ct_irq_exit(), be sure to test with
+ * CONFIG_RCU_EQS_DEBUG=y.
+ */
 noinstr void ct_irq_exit(void)
 {
-	rcu_irq_exit();
+	lockdep_assert_irqs_disabled();
+	ct_nmi_exit();
 }
 
+/*
+ * Wrapper for ct_irq_enter() where interrupts are enabled.
+ *
+ * If you add or remove a call to ct_irq_enter_irqson(), be sure to test
+ * with CONFIG_RCU_EQS_DEBUG=y.
+ */
 void ct_irq_enter_irqson(void)
 {
-	rcu_irq_enter_irqson();
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ct_irq_enter();
+	local_irq_restore(flags);
 }
 
+/*
+ * Wrapper for ct_irq_exit() where interrupts are enabled.
+ *
+ * If you add or remove a call to ct_irq_exit_irqson(), be sure to test
+ * with CONFIG_RCU_EQS_DEBUG=y.
+ */
 void ct_irq_exit_irqson(void)
 {
-	rcu_irq_exit_irqson();
+	unsigned long flags;
+
+	local_irq_save(flags);
+	ct_irq_exit();
+	local_irq_restore(flags);
 }
 
 noinstr void ct_nmi_enter(void)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 051fed0844b6..75b433dba427 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -789,31 +789,6 @@ noinstr void rcu_nmi_exit(void)
 		rcu_dynticks_task_enter();
 }
 
-/**
- * rcu_irq_exit - inform RCU that current CPU is exiting irq towards idle
- *
- * Exit from an interrupt handler, which might possibly result in entering
- * idle mode, in other words, leaving the mode in which read-side critical
- * sections can occur.  The caller must have disabled interrupts.
- *
- * This code assumes that the idle loop never does anything that might
- * result in unbalanced calls to irq_enter() and irq_exit().  If your
- * architecture's idle loop violates this assumption, RCU will give you what
- * you deserve, good and hard.  But very infrequently and irreproducibly.
- *
- * Use things like work queues to work around this limitation.
- *
- * You have been warned.
- *
- * If you add or remove a call to rcu_irq_exit(), be sure to test with
- * CONFIG_RCU_EQS_DEBUG=y.
- */
-void noinstr rcu_irq_exit(void)
-{
-	lockdep_assert_irqs_disabled();
-	rcu_nmi_exit();
-}
-
 #ifdef CONFIG_PROVE_RCU
 /**
  * rcu_irq_exit_check_preempt - Validate that scheduling is possible
@@ -832,21 +807,6 @@ void rcu_irq_exit_check_preempt(void)
 }
 #endif /* #ifdef CONFIG_PROVE_RCU */
 
-/*
- * Wrapper for rcu_irq_exit() where interrupts are enabled.
- *
- * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
- */
-void rcu_irq_exit_irqson(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	rcu_irq_exit();
-	local_irq_restore(flags);
-}
-
 /*
  * Exit an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
@@ -1041,49 +1001,6 @@ noinstr void rcu_nmi_enter(void)
 	barrier();
 }
 
-/**
- * rcu_irq_enter - inform RCU that current CPU is entering irq away from idle
- *
- * Enter an interrupt handler, which might possibly result in exiting
- * idle mode, in other words, entering the mode in which read-side critical
- * sections can occur.  The caller must have disabled interrupts.
- *
- * Note that the Linux kernel is fully capable of entering an interrupt
- * handler that it never exits, for example when doing upcalls to user mode!
- * This code assumes that the idle loop never does upcalls to user mode.
- * If your architecture's idle loop does do upcalls to user mode (or does
- * anything else that results in unbalanced calls to the irq_enter() and
- * irq_exit() functions), RCU will give you what you deserve, good and hard.
- * But very infrequently and irreproducibly.
- *
- * Use things like work queues to work around this limitation.
- *
- * You have been warned.
- *
- * If you add or remove a call to rcu_irq_enter(), be sure to test with
- * CONFIG_RCU_EQS_DEBUG=y.
- */
-noinstr void rcu_irq_enter(void)
-{
-	lockdep_assert_irqs_disabled();
-	rcu_nmi_enter();
-}
-
-/*
- * Wrapper for rcu_irq_enter() where interrupts are enabled.
- *
- * If you add or remove a call to rcu_irq_enter_irqson(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
- */
-void rcu_irq_enter_irqson(void)
-{
-	unsigned long flags;
-
-	local_irq_save(flags);
-	rcu_irq_enter();
-	local_irq_restore(flags);
-}
-
 /*
  * Check to see if any future non-offloaded RCU-related work will need
  * to be done by the current CPU, even if none need be done immediately,
-- 
2.25.1

