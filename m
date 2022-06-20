Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A981F55270D
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 00:45:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244798AbiFTWpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 18:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244259AbiFTWpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 18:45:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4DD661A05B;
        Mon, 20 Jun 2022 15:45:06 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D02E961019;
        Mon, 20 Jun 2022 22:45:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 3862CC341C4;
        Mon, 20 Jun 2022 22:45:05 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655765105;
        bh=PcdJtet5VwwATXE0ihwz9dBO3c9x1VGVtMFNGXXF/wI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=NptLNFLyJvcCYODs7JhifyUV6A4wMxNruwVmxsPwa1Khj8mcpKSVY9ADSE30KKhZi
         c7wUqpK3T93EmXq1HY8rhuXsuQ108Jhws6eWPYcVxJhkNBxXug47legO2Zz0cfAhLp
         37/RXTYOaF1dd2ZEZj0b6EukvH2TSKqdiNxZn//HMDq1ubFlnbboX3FiTu7vp0mtPR
         ZsTdm9BxBplPIAyJC/0BZKLZn1MAqn0dxKp0qND49AZzqQ778lvLZdceHyjrcJWm5t
         ryeeMq/DAtZO2X+i7kd8gNiGmQzKK5jXd3O3exMmYWDNHc5dkqnz1pDgjsmatzxzRo
         bDU9okORea1OA==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id E680D5C05B9; Mon, 20 Jun 2022 15:45:04 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>,
        Boqun Feng <boqun.feng@gmail.com>,
        Uladzislau Rezki <uladzislau.rezki@sony.com>,
        Joel Fernandes <joel@joelfernandes.org>,
        Zqiang <qiang1.zhang@intel.com>,
        "Paul E . McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 1/7] rcu/nocb: Add/del rdp to iterate from rcuog itself
Date:   Mon, 20 Jun 2022 15:44:57 -0700
Message-Id: <20220620224503.3841196-1-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
References: <20220620224455.GA3840881@paulmck-ThinkPad-P17-Gen-1>
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

NOCB rdp's are part of a group whose list is iterated by the
corresponding rdp leader.

This list is RCU traversed because an rdp can be either added or
deleted concurrently. Upon addition, a new iteration to the list after
a synchronization point (a pair of LOCK/UNLOCK ->nocb_gp_lock) is forced
to make sure:

1) we didn't miss a new element added in the middle of an iteration
2) we didn't ignore a whole subset of the list due to an element being
   quickly deleted and then re-added.
3) we prevent from probably other surprises...

Although this layout is expected to be safe, it doesn't help anybody
to sleep well.

Simplify instead the nocb state toggling with moving the list
modification from the nocb (de-)offloading workqueue to the rcuog
kthreads instead.

Whenever the rdp leader is expected to (re-)set the SEGCBLIST_KTHREAD_GP
flag of a target rdp, the latter is queued so that the leader handles
the flag flip along with adding or deleting the target rdp to the list
to iterate. This way the list modification and iteration happen from the
same kthread and those operations can't race altogether.

As a bonus, the flags for each rdp don't need to be checked locklessly
before each iteration, which is one less opportunity to produce
nightmares.

Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
Cc: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Cc: Boqun Feng <boqun.feng@gmail.com>
Cc: Uladzislau Rezki <uladzislau.rezki@sony.com>
Cc: Joel Fernandes <joel@joelfernandes.org>
Cc: Zqiang <qiang1.zhang@intel.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.h      |   1 +
 kernel/rcu/tree_nocb.h | 138 +++++++++++++++++++++--------------------
 2 files changed, 71 insertions(+), 68 deletions(-)

diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 2ccf5845957df..4f8532c33558f 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -235,6 +235,7 @@ struct rcu_data {
 					 * if rdp_gp.
 					 */
 	struct list_head nocb_entry_rdp; /* rcu_data node in wakeup chain. */
+	struct rcu_data *nocb_toggling_rdp; /* rdp queued for (de-)offloading */
 
 	/* The following fields are used by CB kthread, hence new cacheline. */
 	struct rcu_data *nocb_gp_rdp ____cacheline_internodealigned_in_smp;
diff --git a/kernel/rcu/tree_nocb.h b/kernel/rcu/tree_nocb.h
index 46694e13398a3..dac74952e1d1b 100644
--- a/kernel/rcu/tree_nocb.h
+++ b/kernel/rcu/tree_nocb.h
@@ -546,52 +546,43 @@ static void __call_rcu_nocb_wake(struct rcu_data *rdp, bool was_alldone,
 	}
 }
 
-/*
- * Check if we ignore this rdp.
- *
- * We check that without holding the nocb lock but
- * we make sure not to miss a freshly offloaded rdp
- * with the current ordering:
- *
- *  rdp_offload_toggle()        nocb_gp_enabled_cb()
- * -------------------------   ----------------------------
- *    WRITE flags                 LOCK nocb_gp_lock
- *    LOCK nocb_gp_lock           READ/WRITE nocb_gp_sleep
- *    READ/WRITE nocb_gp_sleep    UNLOCK nocb_gp_lock
- *    UNLOCK nocb_gp_lock         READ flags
- */
-static inline bool nocb_gp_enabled_cb(struct rcu_data *rdp)
-{
-	u8 flags = SEGCBLIST_OFFLOADED | SEGCBLIST_KTHREAD_GP;
-
-	return rcu_segcblist_test_flags(&rdp->cblist, flags);
-}
-
-static inline bool nocb_gp_update_state_deoffloading(struct rcu_data *rdp,
-						     bool *needwake_state)
+static int nocb_gp_toggle_rdp(struct rcu_data *rdp,
+			       bool *wake_state)
 {
 	struct rcu_segcblist *cblist = &rdp->cblist;
+	unsigned long flags;
+	int ret;
 
-	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED)) {
-		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP)) {
-			rcu_segcblist_set_flags(cblist, SEGCBLIST_KTHREAD_GP);
-			if (rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
-				*needwake_state = true;
-		}
-		return false;
+	rcu_nocb_lock_irqsave(rdp, flags);
+	if (rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED) &&
+	    !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP)) {
+		/*
+		 * Offloading. Set our flag and notify the offload worker.
+		 * We will handle this rdp until it ever gets de-offloaded.
+		 */
+		rcu_segcblist_set_flags(cblist, SEGCBLIST_KTHREAD_GP);
+		if (rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
+			*wake_state = true;
+		ret = 1;
+	} else if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_OFFLOADED) &&
+		   rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP)) {
+		/*
+		 * De-offloading. Clear our flag and notify the de-offload worker.
+		 * We will ignore this rdp until it ever gets re-offloaded.
+		 */
+		rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
+		if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
+			*wake_state = true;
+		ret = 0;
+	} else {
+		WARN_ON_ONCE(1);
+		ret = -1;
 	}
 
-	/*
-	 * De-offloading. Clear our flag and notify the de-offload worker.
-	 * We will ignore this rdp until it ever gets re-offloaded.
-	 */
-	WARN_ON_ONCE(!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_GP));
-	rcu_segcblist_clear_flags(cblist, SEGCBLIST_KTHREAD_GP);
-	if (!rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB))
-		*needwake_state = true;
-	return true;
-}
+	rcu_nocb_unlock_irqrestore(rdp, flags);
 
+	return ret;
+}
 
 /*
  * No-CBs GP kthreads come here to wait for additional callbacks to show up
@@ -609,7 +600,7 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	bool needwait_gp = false; // This prevents actual uninitialized use.
 	bool needwake;
 	bool needwake_gp;
-	struct rcu_data *rdp;
+	struct rcu_data *rdp, *rdp_toggling = NULL;
 	struct rcu_node *rnp;
 	unsigned long wait_gp_seq = 0; // Suppress "use uninitialized" warning.
 	bool wasempty = false;
@@ -634,19 +625,10 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 	 * is added to the list, so the skipped-over rcu_data structures
 	 * won't be ignored for long.
 	 */
-	list_for_each_entry_rcu(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp, 1) {
-		bool needwake_state = false;
-
-		if (!nocb_gp_enabled_cb(rdp))
-			continue;
+	list_for_each_entry(rdp, &my_rdp->nocb_head_rdp, nocb_entry_rdp) {
 		trace_rcu_nocb_wake(rcu_state.name, rdp->cpu, TPS("Check"));
 		rcu_nocb_lock_irqsave(rdp, flags);
-		if (nocb_gp_update_state_deoffloading(rdp, &needwake_state)) {
-			rcu_nocb_unlock_irqrestore(rdp, flags);
-			if (needwake_state)
-				swake_up_one(&rdp->nocb_state_wq);
-			continue;
-		}
+		lockdep_assert_held(&rdp->nocb_lock);
 		bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		if (bypass_ncbs &&
 		    (time_after(j, READ_ONCE(rdp->nocb_bypass_first) + 1) ||
@@ -656,8 +638,6 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			bypass_ncbs = rcu_cblist_n_cbs(&rdp->nocb_bypass);
 		} else if (!bypass_ncbs && rcu_segcblist_empty(&rdp->cblist)) {
 			rcu_nocb_unlock_irqrestore(rdp, flags);
-			if (needwake_state)
-				swake_up_one(&rdp->nocb_state_wq);
 			continue; /* No callbacks here, try next. */
 		}
 		if (bypass_ncbs) {
@@ -705,8 +685,6 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 		}
 		if (needwake_gp)
 			rcu_gp_kthread_wake();
-		if (needwake_state)
-			swake_up_one(&rdp->nocb_state_wq);
 	}
 
 	my_rdp->nocb_gp_bypass = bypass;
@@ -739,15 +717,49 @@ static void nocb_gp_wait(struct rcu_data *my_rdp)
 			!READ_ONCE(my_rdp->nocb_gp_sleep));
 		trace_rcu_this_gp(rnp, my_rdp, wait_gp_seq, TPS("EndWait"));
 	}
+
 	if (!rcu_nocb_poll) {
 		raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
+		// (De-)queue an rdp to/from the group if its nocb state is changing
+		rdp_toggling = my_rdp->nocb_toggling_rdp;
+		if (rdp_toggling)
+			my_rdp->nocb_toggling_rdp = NULL;
+
 		if (my_rdp->nocb_defer_wakeup > RCU_NOCB_WAKE_NOT) {
 			WRITE_ONCE(my_rdp->nocb_defer_wakeup, RCU_NOCB_WAKE_NOT);
 			del_timer(&my_rdp->nocb_timer);
 		}
 		WRITE_ONCE(my_rdp->nocb_gp_sleep, true);
 		raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
+	} else {
+		rdp_toggling = READ_ONCE(my_rdp->nocb_toggling_rdp);
+		if (rdp_toggling) {
+			/*
+			 * Paranoid locking to make sure nocb_toggling_rdp is well
+			 * reset *before* we (re)set SEGCBLIST_KTHREAD_GP or we could
+			 * race with another round of nocb toggling for this rdp.
+			 * Nocb locking should prevent from that already but we stick
+			 * to paranoia, especially in rare path.
+			 */
+			raw_spin_lock_irqsave(&my_rdp->nocb_gp_lock, flags);
+			my_rdp->nocb_toggling_rdp = NULL;
+			raw_spin_unlock_irqrestore(&my_rdp->nocb_gp_lock, flags);
+		}
+	}
+
+	if (rdp_toggling) {
+		bool wake_state = false;
+		int ret;
+
+		ret = nocb_gp_toggle_rdp(rdp_toggling, &wake_state);
+		if (ret == 1)
+			list_add_tail(&rdp_toggling->nocb_entry_rdp, &my_rdp->nocb_head_rdp);
+		else if (ret == 0)
+			list_del(&rdp_toggling->nocb_entry_rdp);
+		if (wake_state)
+			swake_up_one(&rdp_toggling->nocb_state_wq);
 	}
+
 	my_rdp->nocb_gp_seq = -1;
 	WARN_ON(signal_pending(current));
 }
@@ -966,6 +978,8 @@ static int rdp_offload_toggle(struct rcu_data *rdp,
 	swake_up_one(&rdp->nocb_cb_wq);
 
 	raw_spin_lock_irqsave(&rdp_gp->nocb_gp_lock, flags);
+	// Queue this rdp for add/del to/from the list to iterate on rcuog
+	WRITE_ONCE(rdp_gp->nocb_toggling_rdp, rdp);
 	if (rdp_gp->nocb_gp_sleep) {
 		rdp_gp->nocb_gp_sleep = false;
 		wake_gp = true;
@@ -1013,8 +1027,6 @@ static long rcu_nocb_rdp_deoffload(void *arg)
 	swait_event_exclusive(rdp->nocb_state_wq,
 			      !rcu_segcblist_test_flags(cblist, SEGCBLIST_KTHREAD_CB |
 							SEGCBLIST_KTHREAD_GP));
-	/* Stop nocb_gp_wait() from iterating over this structure. */
-	list_del_rcu(&rdp->nocb_entry_rdp);
 	/*
 	 * Lock one last time to acquire latest callback updates from kthreads
 	 * so we can later handle callbacks locally without locking.
@@ -1079,16 +1091,6 @@ static long rcu_nocb_rdp_offload(void *arg)
 
 	pr_info("Offloading %d\n", rdp->cpu);
 
-	/*
-	 * Cause future nocb_gp_wait() invocations to iterate over
-	 * structure, resetting ->nocb_gp_sleep and waking up the related
-	 * "rcuog".  Since nocb_gp_wait() in turn locks ->nocb_gp_lock
-	 * before setting ->nocb_gp_sleep again, we are guaranteed to
-	 * iterate this newly added structure before "rcuog" goes to
-	 * sleep again.
-	 */
-	list_add_tail_rcu(&rdp->nocb_entry_rdp, &rdp->nocb_gp_rdp->nocb_head_rdp);
-
 	/*
 	 * Can't use rcu_nocb_lock_irqsave() before SEGCBLIST_LOCKING
 	 * is set.
-- 
2.31.1.189.g2e36527f23

