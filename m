Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8C864AA436
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:20:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378046AbiBDXUr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:20:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41166 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378035AbiBDXUm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:20:42 -0500
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23EBEDFBC71C;
        Fri,  4 Feb 2022 15:20:41 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 73436CE24BE;
        Fri,  4 Feb 2022 23:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D4D7AC340F0;
        Fri,  4 Feb 2022 23:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016837;
        bh=KtTPpRsuWB62P+BYnS+xrXCcd8GYM6ix8SDQvoZz640=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=VS1S/6HzyQpxtWn0abQdsl2GixliTT4kOXAoFVkWrx8ZkOI05AePLNS+Ge5B98YHk
         m/1LMfZwtMqwecNDclVczB76g7HV1EQ6CdusLTi+6HWmXXVY2W7Im17Wc2N4vSoxMB
         Dnl00h2FU0bX6e1qJs4OnOhiL6IIpazzG3tOCb759njj62KOHxEs/0uR7K0ohM77Tk
         M9tBpijAUH7AFZgNuApZyntn0DPHL3zi1+KZMdWxTGhYxPkvGSjChOIhygHpcZfO6z
         GkHaFLH3269Okh/WCA/9Ru9wy1JzR391zB/vRtl8TTyc1pTHhlx+vR24RawdF54tv5
         UgQSqfN+mKOeg==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A5F825C08B7; Fri,  4 Feb 2022 15:20:37 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>
Subject: [PATCH rcu 3/5] rcu: Rework rcu_barrier() and callback-migration logic
Date:   Fri,  4 Feb 2022 15:20:34 -0800
Message-Id: <20220204232036.460-3-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204232027.GA4194214@paulmck-ThinkPad-P17-Gen-1>
References: <20220204232027.GA4194214@paulmck-ThinkPad-P17-Gen-1>
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

This commit reworks rcu_barrier() and callback-migration logic to
permit allowing rcu_barrier() to run concurrently with CPU-hotplug
operations.  The key trick is for callback migration to check to see if
an rcu_barrier() is in flight, and, if so, enqueue the ->barrier_head
callback on its behalf.

This commit adds synchronization with RCU's CPU-hotplug notifiers.  Taken
together, this will permit a later commit to remove the cpus_read_lock()
and cpus_read_unlock() calls from rcu_barrier().

[ paulmck: Updated per kbuild test robot feedback. ]
[ paulmck: Updated per reviews session with Neeraj, Frederic, Uladzislau, and Boqun. ]

Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 77 +++++++++++++++++++++++++++++++++++++----------
 kernel/rcu/tree.h |  2 ++
 2 files changed, 63 insertions(+), 16 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index 87ea516f87779..e80b4525469e1 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -3987,13 +3987,16 @@ static void rcu_barrier_callback(struct rcu_head *rhp)
 }
 
 /*
- * Called with preemption disabled, and from cross-cpu IRQ context.
+ * If needed, entrain an rcu_barrier() callback on rdp->cblist.
  */
-static void rcu_barrier_func(void *cpu_in)
+static void rcu_barrier_entrain(struct rcu_data *rdp)
 {
-	uintptr_t cpu = (uintptr_t)cpu_in;
-	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
+	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
 
+	lockdep_assert_held(&rdp->barrier_lock);
+	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
+		return;
 	rcu_barrier_trace(TPS("IRQ"), -1, rcu_state.barrier_sequence);
 	rdp->barrier_head.func = rcu_barrier_callback;
 	debug_rcu_head_queue(&rdp->barrier_head);
@@ -4003,10 +4006,26 @@ static void rcu_barrier_func(void *cpu_in)
 		atomic_inc(&rcu_state.barrier_cpu_count);
 	} else {
 		debug_rcu_head_unqueue(&rdp->barrier_head);
-		rcu_barrier_trace(TPS("IRQNQ"), -1,
-				  rcu_state.barrier_sequence);
+		rcu_barrier_trace(TPS("IRQNQ"), -1, rcu_state.barrier_sequence);
 	}
 	rcu_nocb_unlock(rdp);
+	smp_store_release(&rdp->barrier_seq_snap, gseq);
+}
+
+/*
+ * Called with preemption disabled, and from cross-cpu IRQ context.
+ */
+static void rcu_barrier_handler(void *cpu_in)
+{
+	uintptr_t cpu = (uintptr_t)cpu_in;
+	struct rcu_data *rdp = per_cpu_ptr(&rcu_data, cpu);
+
+	lockdep_assert_irqs_disabled();
+	WARN_ON_ONCE(cpu != rdp->cpu);
+	WARN_ON_ONCE(cpu != smp_processor_id());
+	raw_spin_lock(&rdp->barrier_lock);
+	rcu_barrier_entrain(rdp);
+	raw_spin_unlock(&rdp->barrier_lock);
 }
 
 /**
@@ -4020,6 +4039,8 @@ static void rcu_barrier_func(void *cpu_in)
 void rcu_barrier(void)
 {
 	uintptr_t cpu;
+	unsigned long flags;
+	unsigned long gseq;
 	struct rcu_data *rdp;
 	unsigned long s = rcu_seq_snap(&rcu_state.barrier_sequence);
 
@@ -4038,6 +4059,7 @@ void rcu_barrier(void)
 
 	/* Mark the start of the barrier operation. */
 	rcu_seq_start(&rcu_state.barrier_sequence);
+	gseq = rcu_state.barrier_sequence;
 	rcu_barrier_trace(TPS("Inc1"), -1, rcu_state.barrier_sequence);
 
 	/*
@@ -4058,19 +4080,30 @@ void rcu_barrier(void)
 	 */
 	for_each_possible_cpu(cpu) {
 		rdp = per_cpu_ptr(&rcu_data, cpu);
+retry:
+		if (smp_load_acquire(&rdp->barrier_seq_snap) == gseq)
+			continue;
+		raw_spin_lock_irqsave(&rdp->barrier_lock, flags);
 		if (!rcu_segcblist_n_cbs(&rdp->cblist)) {
+			WRITE_ONCE(rdp->barrier_seq_snap, gseq);
+			raw_spin_unlock_irqrestore(&rdp->barrier_lock, flags);
 			rcu_barrier_trace(TPS("NQ"), cpu, rcu_state.barrier_sequence);
 			continue;
 		}
-		if (cpu_online(cpu)) {
-			rcu_barrier_trace(TPS("OnlineQ"), cpu, rcu_state.barrier_sequence);
-			smp_call_function_single(cpu, rcu_barrier_func, (void *)cpu, 1);
-		} else {
+		if (!rcu_rdp_cpu_online(rdp)) {
+			rcu_barrier_entrain(rdp);
+			WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
+			raw_spin_unlock_irqrestore(&rdp->barrier_lock, flags);
 			rcu_barrier_trace(TPS("OfflineNoCBQ"), cpu, rcu_state.barrier_sequence);
-			local_irq_disable();
-			rcu_barrier_func((void *)cpu);
-			local_irq_enable();
+			continue;
 		}
+		raw_spin_unlock_irqrestore(&rdp->barrier_lock, flags);
+		if (smp_call_function_single(cpu, rcu_barrier_handler, (void *)cpu, 1)) {
+			schedule_timeout_uninterruptible(1);
+			goto retry;
+		}
+		WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
+		rcu_barrier_trace(TPS("OnlineQ"), cpu, rcu_state.barrier_sequence);
 	}
 	cpus_read_unlock();
 
@@ -4087,6 +4120,12 @@ void rcu_barrier(void)
 	/* Mark the end of the barrier operation. */
 	rcu_barrier_trace(TPS("Inc2"), -1, rcu_state.barrier_sequence);
 	rcu_seq_end(&rcu_state.barrier_sequence);
+	gseq = rcu_state.barrier_sequence;
+	for_each_possible_cpu(cpu) {
+		rdp = per_cpu_ptr(&rcu_data, cpu);
+
+		WRITE_ONCE(rdp->barrier_seq_snap, gseq);
+	}
 
 	/* Other rcu_barrier() invocations can now safely proceed. */
 	mutex_unlock(&rcu_state.barrier_mutex);
@@ -4134,6 +4173,8 @@ rcu_boot_init_percpu_data(int cpu)
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp)));
+	raw_spin_lock_init(&rdp->barrier_lock);
+	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_flags = RCU_GP_CLEANED;
 	rdp->rcu_onl_gp_seq = rcu_state.gp_seq;
@@ -4284,8 +4325,10 @@ void rcu_cpu_starting(unsigned int cpu)
 	local_irq_save(flags);
 	arch_spin_lock(&rcu_state.ofl_lock);
 	rcu_dynticks_eqs_online();
+	raw_spin_lock(&rdp->barrier_lock);
 	raw_spin_lock_rcu_node(rnp);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
+	raw_spin_unlock(&rdp->barrier_lock);
 	newcpu = !(rnp->expmaskinitnext & mask);
 	rnp->expmaskinitnext |= mask;
 	/* Allow lockless access for expedited grace periods. */
@@ -4372,7 +4415,9 @@ void rcutree_migrate_callbacks(int cpu)
 	    rcu_segcblist_empty(&rdp->cblist))
 		return;  /* No callbacks to migrate. */
 
-	local_irq_save(flags);
+	raw_spin_lock_irqsave(&rdp->barrier_lock, flags);
+	WARN_ON_ONCE(rcu_rdp_cpu_online(rdp));
+	rcu_barrier_entrain(rdp);
 	my_rdp = this_cpu_ptr(&rcu_data);
 	my_rnp = my_rdp->mynode;
 	rcu_nocb_lock(my_rdp); /* irqs already disabled. */
@@ -4382,10 +4427,10 @@ void rcutree_migrate_callbacks(int cpu)
 	needwake = rcu_advance_cbs(my_rnp, rdp) ||
 		   rcu_advance_cbs(my_rnp, my_rdp);
 	rcu_segcblist_merge(&my_rdp->cblist, &rdp->cblist);
+	raw_spin_unlock(&rdp->barrier_lock); /* irqs remain disabled. */
 	needwake = needwake || rcu_advance_cbs(my_rnp, my_rdp);
 	rcu_segcblist_disable(&rdp->cblist);
-	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) !=
-		     !rcu_segcblist_n_cbs(&my_rdp->cblist));
+	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) != !rcu_segcblist_n_cbs(&my_rdp->cblist));
 	if (rcu_rdp_is_offloaded(my_rdp)) {
 		raw_spin_unlock_rcu_node(my_rnp); /* irqs remain disabled. */
 		__call_rcu_nocb_wake(my_rdp, true, flags);
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 4b4bcef8a9743..84362951ed9e1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -188,6 +188,8 @@ struct rcu_data {
 	bool rcu_forced_tick_exp;	/*   ... provide QS to expedited GP. */
 
 	/* 4) rcu_barrier(), OOM callbacks, and expediting. */
+	raw_spinlock_t barrier_lock;	/* Protects ->barrier_seq_snap. */
+	unsigned long barrier_seq_snap;	/* Snap of rcu_state.barrier_sequence. */
 	struct rcu_head barrier_head;
 	int exp_dynticks_snap;		/* Double-check need for IPI. */
 
-- 
2.31.1.189.g2e36527f23

