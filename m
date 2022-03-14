Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E53784D8612
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Mar 2022 14:38:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241859AbiCNNjL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Mar 2022 09:39:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33130 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241536AbiCNNjH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Mar 2022 09:39:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 111B6BC9A
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 06:37:57 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 4CEA161185
        for <linux-kernel@vger.kernel.org>; Mon, 14 Mar 2022 13:37:56 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AB0E7C340F6;
        Mon, 14 Mar 2022 13:37:53 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647265075;
        bh=rr6lMXcZFN4o3VbDgDdxjHH2wTI1ygkpoMFDut5z9oY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=X3bh7TI4xgrruUgSrEmv/4AuzHcpyQSpJIa0FuZaWaMv4mcshalAfoD36sdz+ns5s
         X3BaROjRbrIlIPwohmsov8p8LfOeXy12c3KnYFe4+8MHwo6XlEY35FttA0T0gi2zRh
         OIDWSmaSnyPEPsecwG/BgcvriCgoHZdQFHKu+EKI0GGrDLgtLYNvZDwvFi0hQmvhbY
         lLtL6tKBTTdgNkbBUx1zqRidLlNJLjGzR9+NAoqlCmsd4JBHxrKpxYhCrLRFGixUNp
         FtMThnu4v3lF1tbd08zq7JvgzlD+8Z5AMpcg+d3t08o8sG+14JeKNm5Zcupk3jatEH
         3DynZcEX2q6bw==
From:   Frederic Weisbecker <frederic@kernel.org>
To:     "Paul E . McKenney" <paulmck@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marco Elver <elver@google.com>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>
Subject: [PATCH 1/3] rcu: Fix expedited GP polling against UP/no-preempt environment
Date:   Mon, 14 Mar 2022 14:37:36 +0100
Message-Id: <20220314133738.269522-2-frederic@kernel.org>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220314133738.269522-1-frederic@kernel.org>
References: <20220314133738.269522-1-frederic@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

synchronize_rcu_expedited() has an early return condition: if the
current CPU is the only one online and the kernel doesn't run in
preemption mode, the current assumed quiescent state is worth a grace
period.

However the expedited grace period polling caller of
synchronize_rcu_expedited() takes a GP sequence snapshot and expects it
to complete by the end of the synchronize_rcu_expedited() call. Yet if
synchronize_rcu_expedited() relies on the above described UP/no-preempt
early return, the grace period sequence won't move and may cause
an expedited grace period polling stall.

Fix this with treating polling differently while calling
synchronize_rcu_expedited() and ignore the UP-no-preempt optimization
in this case.

Reported-by: Paul E. McKenney <paulmck@kernel.org>
Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Peter Zijlstra <peterz@infradead.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/rcu/tree_exp.h | 57 ++++++++++++++++++++++++++-----------------
 1 file changed, 35 insertions(+), 22 deletions(-)

diff --git a/kernel/rcu/tree_exp.h b/kernel/rcu/tree_exp.h
index d5f30085b0cf..3d8216ced93e 100644
--- a/kernel/rcu/tree_exp.h
+++ b/kernel/rcu/tree_exp.h
@@ -794,27 +794,14 @@ static int rcu_print_task_exp_stall(struct rcu_node *rnp)
 
 #endif /* #else #ifdef CONFIG_PREEMPT_RCU */
 
-/**
- * synchronize_rcu_expedited - Brute-force RCU grace period
- *
- * Wait for an RCU grace period, but expedite it.  The basic idea is to
- * IPI all non-idle non-nohz online CPUs.  The IPI handler checks whether
- * the CPU is in an RCU critical section, and if so, it sets a flag that
- * causes the outermost rcu_read_unlock() to report the quiescent state
- * for RCU-preempt or asks the scheduler for help for RCU-sched.  On the
- * other hand, if the CPU is not in an RCU read-side critical section,
- * the IPI handler reports the quiescent state immediately.
- *
- * Although this is a great improvement over previous expedited
- * implementations, it is still unfriendly to real-time workloads, so is
- * thus not recommended for any sort of common-case code.  In fact, if
- * you are using synchronize_rcu_expedited() in a loop, please restructure
- * your code to batch your updates, and then use a single synchronize_rcu()
- * instead.
- *
- * This has the same semantics as (but is more brutal than) synchronize_rcu().
+/*
+ * Start and wait for an expedited grace period completion.
+ * If it happens to be called by polling functions (@polling = true),
+ * there is no possible early return in UP no-preempt mode because
+ * the callers are waiting for an actual given sequence snapshot to start
+ * and end.
  */
-void synchronize_rcu_expedited(void)
+static void __synchronize_rcu_expedited(bool polling)
 {
 	bool boottime = (rcu_scheduler_active == RCU_SCHEDULER_INIT);
 	struct rcu_exp_work rew;
@@ -827,7 +814,7 @@ void synchronize_rcu_expedited(void)
 			 "Illegal synchronize_rcu_expedited() in RCU read-side critical section");
 
 	/* Is the state is such that the call is a grace period? */
-	if (rcu_blocking_is_gp())
+	if (rcu_blocking_is_gp() && !polling)
 		return;
 
 	/* If expedited grace periods are prohibited, fall back to normal. */
@@ -863,6 +850,32 @@ void synchronize_rcu_expedited(void)
 
 	if (likely(!boottime))
 		destroy_work_on_stack(&rew.rew_work);
+
+}
+
+/**
+ * synchronize_rcu_expedited - Brute-force RCU grace period
+ *
+ * Wait for an RCU grace period, but expedite it.  The basic idea is to
+ * IPI all non-idle non-nohz online CPUs.  The IPI handler checks whether
+ * the CPU is in an RCU critical section, and if so, it sets a flag that
+ * causes the outermost rcu_read_unlock() to report the quiescent state
+ * for RCU-preempt or asks the scheduler for help for RCU-sched.  On the
+ * other hand, if the CPU is not in an RCU read-side critical section,
+ * the IPI handler reports the quiescent state immediately.
+ *
+ * Although this is a great improvement over previous expedited
+ * implementations, it is still unfriendly to real-time workloads, so is
+ * thus not recommended for any sort of common-case code.  In fact, if
+ * you are using synchronize_rcu_expedited() in a loop, please restructure
+ * your code to batch your updates, and then use a single synchronize_rcu()
+ * instead.
+ *
+ * This has the same semantics as (but is more brutal than) synchronize_rcu().
+ */
+void synchronize_rcu_expedited(void)
+{
+	__synchronize_rcu_expedited(false);
 }
 EXPORT_SYMBOL_GPL(synchronize_rcu_expedited);
 
@@ -903,7 +916,7 @@ static void sync_rcu_do_polled_gp(struct work_struct *wp)
 	if (s & 0x1)
 		return;
 	while (!sync_exp_work_done(s))
-		synchronize_rcu_expedited();
+		__synchronize_rcu_expedited(true);
 	raw_spin_lock_irqsave(&rnp->exp_poll_lock, flags);
 	s = rnp->exp_seq_poll_rq;
 	if (!(s & 0x1) && !sync_exp_work_done(s))
-- 
2.25.1

