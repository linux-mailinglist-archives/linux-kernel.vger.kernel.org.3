Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1604E4AA478
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:39:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378419AbiBDXjb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:39:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378246AbiBDXjG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:39:06 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F152E025B30;
        Fri,  4 Feb 2022 15:39:05 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D8FE761CA4;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 33D37C340F2;
        Fri,  4 Feb 2022 23:39:04 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644017944;
        bh=tOAzBg36M9bT8CIyEo/qjiTNeDJct5k9/98cm9hBKSY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=E9XgVwiAuZoCdSlN9nZ4ZT32iRUIIz0WYLRiBBSgSBJinWtgmEPcXkYqfUO6varJz
         sxpKOXo6jH0FlFESOelIe+Tqhu7F/75c8AmM98JmyWX8drWtDhim3RaTyxZu7zAeJo
         5UXQy1odzJpeRnxytZzDY38+kkgQVSAUJpwwYr5B8z0qS2h4kEV6MDISLignZLyZbJ
         eDMry1OGsv8oeiC/Z7lL3gDIm2fWVOCkgOK1tC+plFMwxiT82tLvr50Hm+/O+IImy5
         KtoXk5cxG9e3f9RJq+T0csjgQV8TRV4c4uslnoR4F1EYDqNNlod46pNotTUH0yRbvz
         Fr95mT1JeT6Og==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id EFA4B5C0992; Fri,  4 Feb 2022 15:39:03 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 05/19] srcu: Make Tree SRCU able to operate without snp_node array
Date:   Fri,  4 Feb 2022 15:38:48 -0800
Message-Id: <20220204233902.1902-5-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
References: <20220204233858.GA1469@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit makes Tree SRCU able to operate without an snp_node
array, that is, when the srcu_data structures' ->mynode pointers
are NULL.  This can result in high contention on the srcu_struct
structure's ->lock, but only when there are lots of call_srcu(),
synchronize_srcu(), and synchronize_srcu_expedited() calls.

Note that when there is no snp_node array, all SRCU callbacks use
CPU 0's callback queue.  This is optimal in the common case of low
update-side load because it removes the need to search each CPU
for the single callback that made the grace period happen.

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  14 ++-
 kernel/rcu/srcutree.c    | 202 +++++++++++++++++++++------------------
 2 files changed, 123 insertions(+), 93 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index f7190058fb8ab..8501b6b459411 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -63,8 +63,9 @@ struct srcu_struct {
 	struct srcu_node *node;			/* Combining tree. */
 	struct srcu_node *level[RCU_NUM_LVLS + 1];
 						/* First node at each level. */
+	int srcu_size_state;			/* Small-to-big transition state. */
 	struct mutex srcu_cb_mutex;		/* Serialize CB preparation. */
-	spinlock_t __private lock;		/* Protect counters */
+	spinlock_t __private lock;		/* Protect counters and size state. */
 	struct mutex srcu_gp_mutex;		/* Serialize GP work. */
 	unsigned int srcu_idx;			/* Current rdr array element. */
 	unsigned long srcu_gp_seq;		/* Grace-period seq #. */
@@ -83,6 +84,17 @@ struct srcu_struct {
 	struct lockdep_map dep_map;
 };
 
+/* Values for size state variable (->srcu_size_state). */
+#define SRCU_SIZE_SMALL		0
+#define SRCU_SIZE_ALLOC		1
+#define SRCU_SIZE_WAIT_BARRIER	2
+#define SRCU_SIZE_WAIT_CALL	3
+#define SRCU_SIZE_WAIT_CBS1	4
+#define SRCU_SIZE_WAIT_CBS2	5
+#define SRCU_SIZE_WAIT_CBS3	6
+#define SRCU_SIZE_WAIT_CBS4	7
+#define SRCU_SIZE_BIG		8
+
 /* Values for state variable (bottom bits of ->srcu_gp_seq). */
 #define SRCU_STATE_IDLE		0
 #define SRCU_STATE_SCAN1	1
diff --git a/kernel/rcu/srcutree.c b/kernel/rcu/srcutree.c
index eaf00c354a631..2bbe8a5d9ae86 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -177,14 +177,14 @@ static bool init_srcu_struct_nodes(struct srcu_struct *ssp)
 		}
 		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
 	}
+	smp_store_release(&ssp->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
 	return true;
 }
 
 /*
  * Initialize non-compile-time initialized fields, including the
- * associated srcu_node and srcu_data structures.  The is_static
- * parameter is passed through to init_srcu_struct_nodes(), and
- * also tells us that ->sda has already been wired up to srcu_data.
+ * associated srcu_node and srcu_data structures.  The is_static parameter
+ * tells us that ->sda has already been wired up to srcu_data.
  */
 static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 {
@@ -421,6 +421,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	ssp->sda = NULL;
 	kfree(ssp->node);
 	ssp->node = NULL;
+	ssp->srcu_size_state = SRCU_SIZE_SMALL;
 }
 EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
 
@@ -469,6 +470,10 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	struct srcu_data *sdp = this_cpu_ptr(ssp->sda);
 	int state;
 
+	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
+		sdp = per_cpu_ptr(ssp->sda, 0);
+	else
+		sdp = this_cpu_ptr(ssp->sda);
 	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
 	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
 	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
@@ -569,38 +574,40 @@ static void srcu_gp_end(struct srcu_struct *ssp)
 	/* A new grace period can start at this point.  But only one. */
 
 	/* Initiate callback invocation as needed. */
-	idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
-	srcu_for_each_node_breadth_first(ssp, snp) {
-		spin_lock_irq_rcu_node(snp);
-		cbs = false;
-		last_lvl = snp >= ssp->level[rcu_num_lvls - 1];
-		if (last_lvl)
-			cbs = snp->srcu_have_cbs[idx] == gpseq;
-		snp->srcu_have_cbs[idx] = gpseq;
-		rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
-		if (ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, gpseq))
-			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
-		mask = snp->srcu_data_have_cbs[idx];
-		snp->srcu_data_have_cbs[idx] = 0;
-		spin_unlock_irq_rcu_node(snp);
-		if (cbs)
-			srcu_schedule_cbs_snp(ssp, snp, mask, cbdelay);
-
-		/* Occasionally prevent srcu_data counter wrap. */
-		if (!(gpseq & counter_wrap_check) && last_lvl)
-			for (cpu = snp->grplo; cpu <= snp->grphi; cpu++) {
-				sdp = per_cpu_ptr(ssp->sda, cpu);
-				spin_lock_irqsave_rcu_node(sdp, flags);
-				if (ULONG_CMP_GE(gpseq,
-						 sdp->srcu_gp_seq_needed + 100))
-					sdp->srcu_gp_seq_needed = gpseq;
-				if (ULONG_CMP_GE(gpseq,
-						 sdp->srcu_gp_seq_needed_exp + 100))
-					sdp->srcu_gp_seq_needed_exp = gpseq;
-				spin_unlock_irqrestore_rcu_node(sdp, flags);
-			}
+	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER) {
+		srcu_schedule_cbs_sdp(per_cpu_ptr(ssp->sda, 0), cbdelay);
+	} else {
+		idx = rcu_seq_ctr(gpseq) % ARRAY_SIZE(snp->srcu_have_cbs);
+		srcu_for_each_node_breadth_first(ssp, snp) {
+			spin_lock_irq_rcu_node(snp);
+			cbs = false;
+			last_lvl = snp >= ssp->level[rcu_num_lvls - 1];
+			if (last_lvl)
+				cbs = snp->srcu_have_cbs[idx] == gpseq;
+			snp->srcu_have_cbs[idx] = gpseq;
+			rcu_seq_set_state(&snp->srcu_have_cbs[idx], 1);
+			if (ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, gpseq))
+				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, gpseq);
+			mask = snp->srcu_data_have_cbs[idx];
+			snp->srcu_data_have_cbs[idx] = 0;
+			spin_unlock_irq_rcu_node(snp);
+			if (cbs)
+				srcu_schedule_cbs_snp(ssp, snp, mask, cbdelay);
+		}
 	}
 
+	/* Occasionally prevent srcu_data counter wrap. */
+	if (!(gpseq & counter_wrap_check))
+		for_each_possible_cpu(cpu) {
+			sdp = per_cpu_ptr(ssp->sda, cpu);
+			spin_lock_irqsave_rcu_node(sdp, flags);
+			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed + 100))
+				sdp->srcu_gp_seq_needed = gpseq;
+			if (ULONG_CMP_GE(gpseq, sdp->srcu_gp_seq_needed_exp + 100))
+				sdp->srcu_gp_seq_needed_exp = gpseq;
+			spin_unlock_irqrestore_rcu_node(sdp, flags);
+		}
+
 	/* Callback initiation done, allow grace periods after next. */
 	mutex_unlock(&ssp->srcu_cb_mutex);
 
@@ -629,18 +636,19 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
 {
 	unsigned long flags;
 
-	for (; snp != NULL; snp = snp->srcu_parent) {
-		if (rcu_seq_done(&ssp->srcu_gp_seq, s) ||
-		    ULONG_CMP_GE(READ_ONCE(snp->srcu_gp_seq_needed_exp), s))
-			return;
-		spin_lock_irqsave_rcu_node(snp, flags);
-		if (ULONG_CMP_GE(snp->srcu_gp_seq_needed_exp, s)) {
+	if (snp)
+		for (; snp != NULL; snp = snp->srcu_parent) {
+			if (rcu_seq_done(&ssp->srcu_gp_seq, s) ||
+			    ULONG_CMP_GE(READ_ONCE(snp->srcu_gp_seq_needed_exp), s))
+				return;
+			spin_lock_irqsave_rcu_node(snp, flags);
+			if (ULONG_CMP_GE(snp->srcu_gp_seq_needed_exp, s)) {
+				spin_unlock_irqrestore_rcu_node(snp, flags);
+				return;
+			}
+			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
 			spin_unlock_irqrestore_rcu_node(snp, flags);
-			return;
 		}
-		WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
-		spin_unlock_irqrestore_rcu_node(snp, flags);
-	}
 	spin_lock_irqsave_rcu_node(ssp, flags);
 	if (ULONG_CMP_LT(ssp->srcu_gp_seq_needed_exp, s))
 		WRITE_ONCE(ssp->srcu_gp_seq_needed_exp, s);
@@ -663,36 +671,37 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
 	unsigned long flags;
 	int idx = rcu_seq_ctr(s) % ARRAY_SIZE(sdp->mynode->srcu_have_cbs);
 	struct srcu_node *snp;
-	struct srcu_node *snp_leaf = sdp->mynode;
+	struct srcu_node *snp_leaf = smp_load_acquire(&sdp->mynode);
 	unsigned long snp_seq;
 
-	/* Each pass through the loop does one level of the srcu_node tree. */
-	for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
-		if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != snp_leaf)
-			return; /* GP already done and CBs recorded. */
-		spin_lock_irqsave_rcu_node(snp, flags);
-		if (ULONG_CMP_GE(snp->srcu_have_cbs[idx], s)) {
-			snp_seq = snp->srcu_have_cbs[idx];
-			if (snp == snp_leaf && snp_seq == s)
-				snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
-			spin_unlock_irqrestore_rcu_node(snp, flags);
-			if (snp == snp_leaf && snp_seq != s) {
-				srcu_schedule_cbs_sdp(sdp, do_norm
-							   ? SRCU_INTERVAL
-							   : 0);
+	if (snp_leaf)
+		/* Each pass through the loop does one level of the srcu_node tree. */
+		for (snp = snp_leaf; snp != NULL; snp = snp->srcu_parent) {
+			if (rcu_seq_done(&ssp->srcu_gp_seq, s) && snp != snp_leaf)
+				return; /* GP already done and CBs recorded. */
+			spin_lock_irqsave_rcu_node(snp, flags);
+			if (ULONG_CMP_GE(snp->srcu_have_cbs[idx], s)) {
+				snp_seq = snp->srcu_have_cbs[idx];
+				if (snp == snp_leaf && snp_seq == s)
+					snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
+				spin_unlock_irqrestore_rcu_node(snp, flags);
+				if (snp == snp_leaf && snp_seq != s) {
+					srcu_schedule_cbs_sdp(sdp, do_norm
+								   ? SRCU_INTERVAL
+								   : 0);
+					return;
+				}
+				if (!do_norm)
+					srcu_funnel_exp_start(ssp, snp, s);
 				return;
 			}
-			if (!do_norm)
-				srcu_funnel_exp_start(ssp, snp, s);
-			return;
+			snp->srcu_have_cbs[idx] = s;
+			if (snp == snp_leaf)
+				snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
+			if (!do_norm && ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, s))
+				WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
+			spin_unlock_irqrestore_rcu_node(snp, flags);
 		}
-		snp->srcu_have_cbs[idx] = s;
-		if (snp == snp_leaf)
-			snp->srcu_data_have_cbs[idx] |= sdp->grpmask;
-		if (!do_norm && ULONG_CMP_LT(snp->srcu_gp_seq_needed_exp, s))
-			WRITE_ONCE(snp->srcu_gp_seq_needed_exp, s);
-		spin_unlock_irqrestore_rcu_node(snp, flags);
-	}
 
 	/* Top of tree, must ensure the grace period will be started. */
 	spin_lock_irqsave_rcu_node(ssp, flags);
@@ -850,7 +859,11 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 
 	check_init_srcu_struct(ssp);
 	idx = srcu_read_lock(ssp);
-	sdp = raw_cpu_ptr(ssp->sda);
+	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_CALL) {
+		sdp = per_cpu_ptr(ssp->sda, 0);
+	} else {
+		sdp = raw_cpu_ptr(ssp->sda);
+	}
 	spin_lock_irqsave_rcu_node(sdp, flags);
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
@@ -870,7 +883,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	if (needgp)
 		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
 	else if (needexp)
-		srcu_funnel_exp_start(ssp, sdp->mynode, s);
+		srcu_funnel_exp_start(ssp, smp_load_acquire(&sdp->mynode), s);
 	srcu_read_unlock(ssp, idx);
 	return s;
 }
@@ -1130,6 +1143,28 @@ static void srcu_barrier_cb(struct rcu_head *rhp)
 		complete(&ssp->srcu_barrier_completion);
 }
 
+/*
+ * Enqueue an srcu_barrier() callback on the specified srcu_data
+ * structure's ->cblist.  but only if that ->cblist already has at least one
+ * callback enqueued.  Note that if a CPU already has callbacks enqueue,
+ * it must have already registered the need for a future grace period,
+ * so all we need do is enqueue a callback that will use the same grace
+ * period as the last callback already in the queue.
+ */
+static void srcu_barrier_one_cpu(struct srcu_struct *ssp, struct srcu_data *sdp)
+{
+	spin_lock_irq_rcu_node(sdp);
+	atomic_inc(&ssp->srcu_barrier_cpu_cnt);
+	sdp->srcu_barrier_head.func = srcu_barrier_cb;
+	debug_rcu_head_queue(&sdp->srcu_barrier_head);
+	if (!rcu_segcblist_entrain(&sdp->srcu_cblist,
+				   &sdp->srcu_barrier_head)) {
+		debug_rcu_head_unqueue(&sdp->srcu_barrier_head);
+		atomic_dec(&ssp->srcu_barrier_cpu_cnt);
+	}
+	spin_unlock_irq_rcu_node(sdp);
+}
+
 /**
  * srcu_barrier - Wait until all in-flight call_srcu() callbacks complete.
  * @ssp: srcu_struct on which to wait for in-flight callbacks.
@@ -1137,7 +1172,6 @@ static void srcu_barrier_cb(struct rcu_head *rhp)
 void srcu_barrier(struct srcu_struct *ssp)
 {
 	int cpu;
-	struct srcu_data *sdp;
 	unsigned long s = rcu_seq_snap(&ssp->srcu_barrier_seq);
 
 	check_init_srcu_struct(ssp);
@@ -1153,27 +1187,11 @@ void srcu_barrier(struct srcu_struct *ssp)
 	/* Initial count prevents reaching zero until all CBs are posted. */
 	atomic_set(&ssp->srcu_barrier_cpu_cnt, 1);
 
-	/*
-	 * Each pass through this loop enqueues a callback, but only
-	 * on CPUs already having callbacks enqueued.  Note that if
-	 * a CPU already has callbacks enqueue, it must have already
-	 * registered the need for a future grace period, so all we
-	 * need do is enqueue a callback that will use the same
-	 * grace period as the last callback already in the queue.
-	 */
-	for_each_possible_cpu(cpu) {
-		sdp = per_cpu_ptr(ssp->sda, cpu);
-		spin_lock_irq_rcu_node(sdp);
-		atomic_inc(&ssp->srcu_barrier_cpu_cnt);
-		sdp->srcu_barrier_head.func = srcu_barrier_cb;
-		debug_rcu_head_queue(&sdp->srcu_barrier_head);
-		if (!rcu_segcblist_entrain(&sdp->srcu_cblist,
-					   &sdp->srcu_barrier_head)) {
-			debug_rcu_head_unqueue(&sdp->srcu_barrier_head);
-			atomic_dec(&ssp->srcu_barrier_cpu_cnt);
-		}
-		spin_unlock_irq_rcu_node(sdp);
-	}
+	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
+		srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, 0));
+	else
+		for_each_possible_cpu(cpu)
+			srcu_barrier_one_cpu(ssp, per_cpu_ptr(ssp->sda, cpu));
 
 	/* Remove the initial count, at which point reaching zero can happen. */
 	if (atomic_dec_and_test(&ssp->srcu_barrier_cpu_cnt))
-- 
2.31.1.189.g2e36527f23

