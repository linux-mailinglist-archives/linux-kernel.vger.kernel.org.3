Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2F68150607B
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 02:03:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236857AbiDSAGN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 20:06:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52728 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbiDSAGH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 20:06:07 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9A6F21816;
        Mon, 18 Apr 2022 17:03:25 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 3D4D0612C4;
        Tue, 19 Apr 2022 00:03:25 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 968BEC385A1;
        Tue, 19 Apr 2022 00:03:24 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1650326604;
        bh=/HCo85xQM6HRnnblLcN7u6Q2a90k5H0ufJjNTjySAKw=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=KIQ23jKW5KJdsUEkqSW23ZJq/oUnDzogK/vbHINtol3iMl6fdx/IU6+S0K3vZOxlx
         yF1fT4/7Mlx/KHXU9vQeqr/VANEiyQoXse7HyqghHVph/kwvJ1tPlGLU4IrBPVe5Qn
         qA8HLVCGyvOM9kDe+dOYGpkcJQUqPvw/LsHbx9rGXC++pkfyic4Yx51NLn0dhBJy7E
         cBIiqRPnPOAoQj+UAUpN6e5nC4bSXsp80LoarHQEzsLnZQrCm+N5dGRPpH/lH6wmbE
         8EZNwxeRhqO4P/z2TMfT92mMYnr6/cacS9UnOFHFjsPoU9DbSnIjibL97FlVrhsoDz
         fxmoIt3gh5+9A==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id 5415C5C0A0D; Mon, 18 Apr 2022 17:03:24 -0700 (PDT)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 04/21] srcu: Make Tree SRCU able to operate without snp_node array
Date:   Mon, 18 Apr 2022 17:03:05 -0700
Message-Id: <20220419000322.3948903-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
References: <20220419000315.GA3948789@paulmck-ThinkPad-P17-Gen-1>
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

This commit makes Tree SRCU able to operate without an snp_node
array, that is, when the srcu_data structures' ->mynode pointers
are NULL.  This can result in high contention on the srcu_struct
structure's ->lock, but only when there are lots of call_srcu(),
synchronize_srcu(), and synchronize_srcu_expedited() calls.

Note that when there is no snp_node array, all SRCU callbacks use
CPU 0's callback queue.  This is optimal in the common case of low
update-side load because it removes the need to search each CPU
for the single callback that made the grace period happen.

Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 include/linux/srcutree.h |  14 ++-
 kernel/rcu/srcutree.c    | 203 +++++++++++++++++++++------------------
 2 files changed, 124 insertions(+), 93 deletions(-)

diff --git a/include/linux/srcutree.h b/include/linux/srcutree.h
index 4025840ba9a3..8d1da136a93a 100644
--- a/include/linux/srcutree.h
+++ b/include/linux/srcutree.h
@@ -63,8 +63,9 @@ struct srcu_struct {
 	struct srcu_node node[NUM_RCU_NODES];	/* Combining tree. */
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
index 7d13e35e5d27..e23696edd43b 100644
--- a/kernel/rcu/srcutree.c
+++ b/kernel/rcu/srcutree.c
@@ -152,16 +152,17 @@ static void init_srcu_struct_nodes(struct srcu_struct *ssp)
 		sdp->ssp = ssp;
 		sdp->grpmask = 1 << (cpu - sdp->mynode->grplo);
 	}
+	smp_store_release(&ssp->srcu_size_state, SRCU_SIZE_WAIT_BARRIER);
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
+	ssp->srcu_size_state = SRCU_SIZE_SMALL;
 	mutex_init(&ssp->srcu_cb_mutex);
 	mutex_init(&ssp->srcu_gp_mutex);
 	ssp->srcu_idx = 0;
@@ -175,6 +176,7 @@ static int init_srcu_struct_fields(struct srcu_struct *ssp, bool is_static)
 	if (!ssp->sda)
 		return -ENOMEM;
 	init_srcu_struct_nodes(ssp);
+	ssp->srcu_size_state = SRCU_SIZE_BIG;
 	ssp->srcu_gp_seq_needed_exp = 0;
 	ssp->srcu_last_gp_end = ktime_get_mono_fast_ns();
 	smp_store_release(&ssp->srcu_gp_seq_needed, 0); /* Init done. */
@@ -391,6 +393,7 @@ void cleanup_srcu_struct(struct srcu_struct *ssp)
 	}
 	free_percpu(ssp->sda);
 	ssp->sda = NULL;
+	ssp->srcu_size_state = SRCU_SIZE_SMALL;
 }
 EXPORT_SYMBOL_GPL(cleanup_srcu_struct);
 
@@ -439,6 +442,10 @@ static void srcu_gp_start(struct srcu_struct *ssp)
 	struct srcu_data *sdp = this_cpu_ptr(ssp->sda);
 	int state;
 
+	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_BARRIER)
+		sdp = per_cpu_ptr(ssp->sda, 0);
+	else
+		sdp = this_cpu_ptr(ssp->sda);
 	lockdep_assert_held(&ACCESS_PRIVATE(ssp, lock));
 	WARN_ON_ONCE(ULONG_CMP_GE(ssp->srcu_gp_seq, ssp->srcu_gp_seq_needed));
 	spin_lock_rcu_node(sdp);  /* Interrupts already disabled. */
@@ -539,38 +546,40 @@ static void srcu_gp_end(struct srcu_struct *ssp)
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
 
@@ -599,18 +608,19 @@ static void srcu_funnel_exp_start(struct srcu_struct *ssp, struct srcu_node *snp
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
@@ -633,36 +643,37 @@ static void srcu_funnel_gp_start(struct srcu_struct *ssp, struct srcu_data *sdp,
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
@@ -820,7 +831,10 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 
 	check_init_srcu_struct(ssp);
 	idx = srcu_read_lock(ssp);
-	sdp = raw_cpu_ptr(ssp->sda);
+	if (smp_load_acquire(&ssp->srcu_size_state) < SRCU_SIZE_WAIT_CALL)
+		sdp = per_cpu_ptr(ssp->sda, 0);
+	else
+		sdp = raw_cpu_ptr(ssp->sda);
 	spin_lock_irqsave_rcu_node(sdp, flags);
 	if (rhp)
 		rcu_segcblist_enqueue(&sdp->srcu_cblist, rhp);
@@ -840,7 +854,7 @@ static unsigned long srcu_gp_start_if_needed(struct srcu_struct *ssp,
 	if (needgp)
 		srcu_funnel_gp_start(ssp, sdp, s, do_norm);
 	else if (needexp)
-		srcu_funnel_exp_start(ssp, sdp->mynode, s);
+		srcu_funnel_exp_start(ssp, smp_load_acquire(&sdp->mynode), s);
 	srcu_read_unlock(ssp, idx);
 	return s;
 }
@@ -1100,6 +1114,28 @@ static void srcu_barrier_cb(struct rcu_head *rhp)
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
@@ -1107,7 +1143,6 @@ static void srcu_barrier_cb(struct rcu_head *rhp)
 void srcu_barrier(struct srcu_struct *ssp)
 {
 	int cpu;
-	struct srcu_data *sdp;
 	unsigned long s = rcu_seq_snap(&ssp->srcu_barrier_seq);
 
 	check_init_srcu_struct(ssp);
@@ -1123,27 +1158,11 @@ void srcu_barrier(struct srcu_struct *ssp)
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

