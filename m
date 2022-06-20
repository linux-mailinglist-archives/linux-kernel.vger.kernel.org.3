Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A80455527E1
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 01:13:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345347AbiFTXNG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 19:13:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347046AbiFTXME (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 19:12:04 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23FFE1ADA2;
        Mon, 20 Jun 2022 16:10:44 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id F2DF761503;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 155FFC36AEA;
        Mon, 20 Jun 2022 23:10:32 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655766632;
        bh=xsKKjIRCTs+MYTIZQulQGrFw/Klyh+WfPxCeTxp4NpA=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=OCEWw2VQTwNZzAlOV5mtXQ9uJL086ovj3jehUe8+Y/yVJ+bGcnjBpCSl7mNY0SYe/
         BwL2PO01qHOxJwvoYwFMdETev9aXAOO+T/ypDUWiYc/ysvgF/VmiHgbxw7fzF7JA41
         H8jtZOZcwSTTaZUwQ9LJbgT8t3+b8SLAithhwWLlx/NQPXqrGJmFUd9fwKjsNBEPEA
         ZWbYEAi2gBX0loyUqMv5hdIrAXzc51fshU6LzdeNB2GgNHn/SSaPuN3N1wWOLEGuv8
         P4toCMvx0GEb47ynw6IJhH49Flb8pnA1dDeeV51jYGYhQYmIXlDlNYOLNvp6DUFcUN
         KYHJk+HPS6sLA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 650A15C0E42; Mon, 20 Jun 2022 16:10:31 -0700 (PDT)
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
Subject: [PATCH rcu 13/23] rcu/context-tracking: Remove rcu_irq_enter/exit()
Date:   Mon, 20 Jun 2022 16:10:19 -0700
Message-Id: <20220620231029.3844583-13-paulmck@kernel.org>
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

Now rcu_irq_enter/exit() is an unecessary middle call between
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
---
 include/linux/rcutiny.h   |  4 --
 include/linux/rcutree.h   |  4 --
 kernel/context_tracking.c | 71 +++++++++++++++++++++++++++++++--
 kernel/rcu/tree.c         | 83 ---------------------------------------
 4 files changed, 67 insertions(+), 95 deletions(-)

diff --git a/include/linux/rcutiny.h b/include/linux/rcutiny.h
index 5fed476f977f6..591119413cf1d 100644
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
index 9c6cfb742504f..4522b6a7cc42f 100644
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
index afb4451c26a25..96406daf5f54b 100644
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
index 051fed0844b67..75b433dba4276 100644
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
2.31.1.189.g2e36527f23

