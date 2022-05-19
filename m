Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0CC4F52D6A5
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 17:01:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240055AbiESPAX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 11:00:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42250 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240228AbiESO7Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 10:59:24 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7605EBA8A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 07:59:17 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5B14A61A0A
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 14:59:17 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6D64BC34115;
        Thu, 19 May 2022 14:59:13 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652972356;
        bh=yOuqYIThMF7mfOICV9Nuh6/kONoSGpy48kmNQb7W2IU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=vP9nqvGIAegLjnbjZpa0LEPFVWOns/ZTFe9zHSglz9MQuVjvYk/8p/M1v3nWhQiad
         FEV+sTyoWRuJhO9CIBSW2gQv1yBvcvdOew7/OaJPzEeDYrKB5/9yQscobR2K922VHt
         8bw2/96ewWG6NE71e4rCp2LbZ6P8cU9K2I4QD1gueCqJgaS6eY54zM5fKeTHgQrGei
         62AAXydnzjk7rn4b2eL9ASNJqL2RfU+D4VJurQWnLLlSh4NfKE9/kn17KZUR1V3G69
         tfRXTFCqdnyhhjjyz75WkIQQmncsk5ZDPFQtMR26m6bauFP7v+30bAi3CM9GC181rb
         T2S9wfcVYmbEQ==
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
        Joel Fernandes <joel@joelfernandes.org>,
        Mark Rutland <mark.rutland@arm.com>
Subject: [PATCH 12/21] rcu/context-tracking: Remove rcu_irq_enter/exit()
Date:   Thu, 19 May 2022 16:58:14 +0200
Message-Id: <20220519145823.618983-13-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220519145823.618983-1-frederic@kernel.org>
References: <20220519145823.618983-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now rcu_irq_enter/exit() is an unecessary middle call between
ct_irq_enter/exit() and nmi_irq_enter/exit(). Take this opportunity
to remove the former functions and move the comments above them to the
new entrypoints.

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
 include/linux/rcutiny.h   |  4 --
 include/linux/rcutree.h   |  4 --
 kernel/context_tracking.c | 75 ++++++++++++++++++++++++++++++++---
 kernel/rcu/tree.c         | 83 ---------------------------------------
 4 files changed, 69 insertions(+), 97 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index ab7e20dfb07b..5921d9ae7ab5 100644
--- a/include/linux/rcutiny.h
+++ b/include/linux/rcutiny.h
@@ -88,10 +88,6 @@ static inline void rcu_cpu_stall_reset(void) { }
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
index 20dbaa9a3882..cafe3fbf4272 100644
--- a/include/linux/rcutree.h
+++ b/include/linux/rcutree.h
@@ -49,10 +49,6 @@ void cond_synchronize_rcu(unsigned long oldstate);
 
 void rcu_idle_enter(void);
 void rcu_idle_exit(void);
-void rcu_irq_enter(void);
-void rcu_irq_exit(void);
-void rcu_irq_enter_irqson(void);
-void rcu_irq_exit_irqson(void);
 bool rcu_is_idle_cpu(int cpu);
 
 #ifdef CONFIG_PROVE_RCU
diff --git a/kernel/context_tracking.c b/kernel/context_tracking.c
index 120c2864dc95..9177bbfbdedf 100644
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
 
-void ct_irq_enter_irqson(void)
+/*
+ * Wrapper for ct_irq_enter() where interrupts are enabled.
+ *
+ * If you add or remove a call to ct_irq_enter_irqson(), be sure to test
+ * with CONFIG_RCU_EQS_DEBUG=y.
+ */
+void noinstr ct_irq_enter_irqson(void)
 {
-	rcu_irq_enter_irqson();
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	ct_irq_enter();
+	raw_local_irq_restore(flags);
 }
 
-void ct_irq_exit_irqson(void)
+/*
+ * Wrapper for ct_irq_exit() where interrupts are enabled.
+ *
+ * If you add or remove a call to ct_irq_exit_irqson(), be sure to test
+ * with CONFIG_RCU_EQS_DEBUG=y.
+ */
+void noinstr ct_irq_exit_irqson(void)
 {
-	rcu_irq_exit_irqson();
+	unsigned long flags;
+
+	raw_local_irq_save(flags);
+	ct_irq_exit();
+	raw_local_irq_restore(flags);
 }
 
 noinstr void ct_nmi_enter(void)
diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index c2792b200958..17503a6f7f60 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -793,31 +793,6 @@ noinstr void rcu_nmi_exit(void)
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
@@ -836,21 +811,6 @@ void rcu_irq_exit_check_preempt(void)
 }
 #endif /* #ifdef CONFIG_PROVE_RCU */
 
-/*
- * Wrapper for rcu_irq_exit() where interrupts are enabled.
- *
- * If you add or remove a call to rcu_irq_exit_irqson(), be sure to test
- * with CONFIG_RCU_EQS_DEBUG=y.
- */
-void noinstr rcu_irq_exit_irqson(void)
-{
-	unsigned long flags;
-
-	raw_local_irq_save(flags);
-	rcu_irq_exit();
-	raw_local_irq_restore(flags);
-}
-
 /*
  * Exit an RCU extended quiescent state, which can be either the
  * idle loop or adaptive-tickless usermode execution.
@@ -1045,49 +1005,6 @@ noinstr void rcu_nmi_enter(void)
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
-void noinstr rcu_irq_enter_irqson(void)
-{
-	unsigned long flags;
-
-	raw_local_irq_save(flags);
-	rcu_irq_enter();
-	raw_local_irq_restore(flags);
-}
-
 /*
  * Check to see if any future non-offloaded RCU-related work will need
  * to be done by the current CPU, even if none need be done immediately,
-- 
2.25.1

