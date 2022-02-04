Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A58A74AA435
	for <lists+linux-kernel@lfdr.de>; Sat,  5 Feb 2022 00:20:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378050AbiBDXUp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 18:20:45 -0500
Received: from ams.source.kernel.org ([145.40.68.75]:59498 "EHLO
        ams.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233885AbiBDXUk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 18:20:40 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 2AEAAB83971;
        Fri,  4 Feb 2022 23:20:39 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D769BC340EF;
        Fri,  4 Feb 2022 23:20:37 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1644016837;
        bh=HqMzbM8Xz0R/enfePe3VHsak2rWiQyDYFJqCCFUfRFs=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=WwKJpQkdY2eE2s0M/K3VpD/uP+iB3oKx54Sk6cTPGms9zCn0mpipugDGGaSfNi0L+
         fXvtAYzdkJqs1qiTlDe7scEAzKSWRUaoCc/BBzQnv9sCIUN9meI4VRL8BY+KKtnt1H
         /sRg/Lt/rIk6FknJQx0h248SZV+wUZUOCXvP31WXQAuQ/hr4CUsVsbGoA3aD46Lu+2
         sk3W5RnybnZpxhtsIu5XC4R23pYOVGCFdC7MEtiSLfMV+FilNFzgO1ozu6T4+gRet9
         2+mXpVzWYd4Pnt4IIX+byWZk/x/gA4HoSlAq+DXp8kLpXg/4peb2I/j2foyJNI7XZA
         qncgzQs5QX1Fw==
Received: by paulmck-ThinkPad-P17-Gen-1.home (Postfix, from userid 1000)
        id A826A5C08DD; Fri,  4 Feb 2022 15:20:37 -0800 (PST)
From:   "Paul E. McKenney" <paulmck@kernel.org>
To:     rcu@vger.kernel.org
Cc:     linux-kernel@vger.kernel.org, kernel-team@fb.com,
        rostedt@goodmis.org, "Paul E. McKenney" <paulmck@kernel.org>,
        Frederic Weisbecker <frederic@kernel.org>,
        Neeraj Upadhyay <quic_neeraju@quicinc.com>
Subject: [PATCH rcu 4/5] rcu: Make rcu_barrier() no longer block CPU-hotplug operations
Date:   Fri,  4 Feb 2022 15:20:35 -0800
Message-Id: <20220204232036.460-4-paulmck@kernel.org>
X-Mailer: git-send-email 2.31.1.189.g2e36527f23
In-Reply-To: <20220204232027.GA4194214@paulmck-ThinkPad-P17-Gen-1>
References: <20220204232027.GA4194214@paulmck-ThinkPad-P17-Gen-1>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This commit removes the cpus_read_lock() and cpus_read_unlock() calls
from rcu_barrier(), thus allowing CPUs to come and go during the course
of rcu_barrier() execution.  Posting of the ->barrier_head callbacks does
synchronize with portions of RCU's CPU-hotplug notifiers, but these locks
are held for short time periods on both sides.  Thus, full CPU-hotplug
operations could both start and finish during the execution of a given
rcu_barrier() invocation.

Additional synchronization is provided by a global ->barrier_lock.
Since the ->barrier_lock is only used during rcu_barrier() execution and
during onlining/offlining a CPU, the contention for this lock should
be low.  It might be tempting to make use of a per-CPU lock just on
general principles, but straightforward attempts to do this have the
problems shown below.

Initial state: 3 CPUs present, CPU 0 and CPU1 do not have
any callback and CPU2 has callbacks.

1. CPU0 calls rcu_barrier().

2. CPU1 starts offlining for CPU2. CPU1 calls
   rcutree_migrate_callbacks(). rcu_barrier_entrain() is called
   from rcutree_migrate_callbacks(), with CPU2's rdp->barrier_lock.
   It does not entrain ->barrier_head for CPU2, as rcu_barrier()
   on CPU0 hasn't started the barrier sequence (by calling
   rcu_seq_start(&rcu_state.barrier_sequence)) yet.

3. CPU0 starts new barrier sequence. It iterates over
   CPU0 and CPU1, after acquiring their per-cpu ->barrier_lock
   and finds 0 segcblist length. It updates ->barrier_seq_snap
   for CPU0 and CPU1 and continues loop iteration to CPU2.

    for_each_possible_cpu(cpu) {
        raw_spin_lock_irqsave(&rdp->barrier_lock, flags);
        if (!rcu_segcblist_n_cbs(&rdp->cblist)) {
            WRITE_ONCE(rdp->barrier_seq_snap, gseq);
            raw_spin_unlock_irqrestore(&rdp->barrier_lock, flags);
            rcu_barrier_trace(TPS("NQ"), cpu, rcu_state.barrier_sequence);
            continue;
        }

4. rcutree_migrate_callbacks() completes execution on CPU1.
   Segcblist len for CPU2 becomes 0.

5. The loop iteration on CPU0, checks rcu_segcblist_n_cbs(&rdp->cblist)
   for CPU2 and completes the loop iteration after setting
   ->barrier_seq_snap.

6. As there isn't any ->barrier_head callback entrained; at
   this point, rcu_barrier() in CPU0 returns.

7. The callbacks, which migrated from CPU2 to CPU1, execute.

Straightforward per-CPU locking is also subject to the following race
condition noted by Boqun Feng:

1. CPU0 calls rcu_barrier(), starting a new barrier sequence by invoking
   rcu_seq_start() and init_completion(), but does not yet initialize
   rcu_state.barrier_cpu_count.

2. CPU1 starts offlining for CPU2, calling rcutree_migrate_callbacks(),
   which in turn calls rcu_barrier_entrain() holding CPU2's.
   rdp->barrier_lock.  It then entrains ->barrier_head for CPU2
   and atomically increments rcu_state.barrier_cpu_count, which is
   unfortunately not yet initialized to the value 2.

3. The just-entrained RCU callback is invoked.  It atomically
   decrements rcu_state.barrier_cpu_count and sees that it is
   now zero.  This callback therefore invokes complete().

4. CPU0 continues executing rcu_barrier(), but is not blocked
   by its call to wait_for_completion().  This results in rcu_barrier()
   returning before all pre-existing callbacks have been invoked,
   which is a bug.

Therefore, synchronization is provided by rcu_state.barrier_lock,
which is also held across the initialization sequence, especially the
rcu_seq_start() and the atomic_set() that sets rcu_state.barrier_cpu_count
to the value 2.  In addition, this lock is held when entraining the
rcu_barrier() callback, when deciding whether or not a CPU has callbacks
that rcu_barrier() must wait on, when setting the ->qsmaskinitnext for
incoming CPUs, and when migrating callbacks from a CPU that is going
offline.

Reviewed-by: Frederic Weisbecker <frederic@kernel.org>
Co-developed-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Neeraj Upadhyay <quic_neeraju@quicinc.com>
Signed-off-by: Paul E. McKenney <paulmck@kernel.org>
---
 kernel/rcu/tree.c | 28 ++++++++++++++--------------
 kernel/rcu/tree.h |  3 ++-
 2 files changed, 16 insertions(+), 15 deletions(-)

diff --git a/kernel/rcu/tree.c b/kernel/rcu/tree.c
index e80b4525469e1..1c30a01692076 100644
--- a/kernel/rcu/tree.c
+++ b/kernel/rcu/tree.c
@@ -87,6 +87,7 @@ static struct rcu_state rcu_state = {
 	.gp_state = RCU_GP_IDLE,
 	.gp_seq = (0UL - 300UL) << RCU_SEQ_CTR_SHIFT,
 	.barrier_mutex = __MUTEX_INITIALIZER(rcu_state.barrier_mutex),
+	.barrier_lock = __RAW_SPIN_LOCK_UNLOCKED(rcu_state.barrier_lock),
 	.name = RCU_NAME,
 	.abbr = RCU_ABBR,
 	.exp_mutex = __MUTEX_INITIALIZER(rcu_state.exp_mutex),
@@ -3994,7 +3995,7 @@ static void rcu_barrier_entrain(struct rcu_data *rdp)
 	unsigned long gseq = READ_ONCE(rcu_state.barrier_sequence);
 	unsigned long lseq = READ_ONCE(rdp->barrier_seq_snap);
 
-	lockdep_assert_held(&rdp->barrier_lock);
+	lockdep_assert_held(&rcu_state.barrier_lock);
 	if (rcu_seq_state(lseq) || !rcu_seq_state(gseq) || rcu_seq_ctr(lseq) != rcu_seq_ctr(gseq))
 		return;
 	rcu_barrier_trace(TPS("IRQ"), -1, rcu_state.barrier_sequence);
@@ -4023,9 +4024,9 @@ static void rcu_barrier_handler(void *cpu_in)
 	lockdep_assert_irqs_disabled();
 	WARN_ON_ONCE(cpu != rdp->cpu);
 	WARN_ON_ONCE(cpu != smp_processor_id());
-	raw_spin_lock(&rdp->barrier_lock);
+	raw_spin_lock(&rcu_state.barrier_lock);
 	rcu_barrier_entrain(rdp);
-	raw_spin_unlock(&rdp->barrier_lock);
+	raw_spin_unlock(&rcu_state.barrier_lock);
 }
 
 /**
@@ -4058,6 +4059,7 @@ void rcu_barrier(void)
 	}
 
 	/* Mark the start of the barrier operation. */
+	raw_spin_lock_irqsave(&rcu_state.barrier_lock, flags);
 	rcu_seq_start(&rcu_state.barrier_sequence);
 	gseq = rcu_state.barrier_sequence;
 	rcu_barrier_trace(TPS("Inc1"), -1, rcu_state.barrier_sequence);
@@ -4071,7 +4073,7 @@ void rcu_barrier(void)
 	 */
 	init_completion(&rcu_state.barrier_completion);
 	atomic_set(&rcu_state.barrier_cpu_count, 2);
-	cpus_read_lock();
+	raw_spin_unlock_irqrestore(&rcu_state.barrier_lock, flags);
 
 	/*
 	 * Force each CPU with callbacks to register a new callback.
@@ -4083,21 +4085,21 @@ void rcu_barrier(void)
 retry:
 		if (smp_load_acquire(&rdp->barrier_seq_snap) == gseq)
 			continue;
-		raw_spin_lock_irqsave(&rdp->barrier_lock, flags);
+		raw_spin_lock_irqsave(&rcu_state.barrier_lock, flags);
 		if (!rcu_segcblist_n_cbs(&rdp->cblist)) {
 			WRITE_ONCE(rdp->barrier_seq_snap, gseq);
-			raw_spin_unlock_irqrestore(&rdp->barrier_lock, flags);
+			raw_spin_unlock_irqrestore(&rcu_state.barrier_lock, flags);
 			rcu_barrier_trace(TPS("NQ"), cpu, rcu_state.barrier_sequence);
 			continue;
 		}
 		if (!rcu_rdp_cpu_online(rdp)) {
 			rcu_barrier_entrain(rdp);
 			WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
-			raw_spin_unlock_irqrestore(&rdp->barrier_lock, flags);
+			raw_spin_unlock_irqrestore(&rcu_state.barrier_lock, flags);
 			rcu_barrier_trace(TPS("OfflineNoCBQ"), cpu, rcu_state.barrier_sequence);
 			continue;
 		}
-		raw_spin_unlock_irqrestore(&rdp->barrier_lock, flags);
+		raw_spin_unlock_irqrestore(&rcu_state.barrier_lock, flags);
 		if (smp_call_function_single(cpu, rcu_barrier_handler, (void *)cpu, 1)) {
 			schedule_timeout_uninterruptible(1);
 			goto retry;
@@ -4105,7 +4107,6 @@ void rcu_barrier(void)
 		WARN_ON_ONCE(READ_ONCE(rdp->barrier_seq_snap) != gseq);
 		rcu_barrier_trace(TPS("OnlineQ"), cpu, rcu_state.barrier_sequence);
 	}
-	cpus_read_unlock();
 
 	/*
 	 * Now that we have an rcu_barrier_callback() callback on each
@@ -4173,7 +4174,6 @@ rcu_boot_init_percpu_data(int cpu)
 	INIT_WORK(&rdp->strict_work, strict_work_handler);
 	WARN_ON_ONCE(rdp->dynticks_nesting != 1);
 	WARN_ON_ONCE(rcu_dynticks_in_eqs(rcu_dynticks_snap(rdp)));
-	raw_spin_lock_init(&rdp->barrier_lock);
 	rdp->barrier_seq_snap = rcu_state.barrier_sequence;
 	rdp->rcu_ofl_gp_seq = rcu_state.gp_seq;
 	rdp->rcu_ofl_gp_flags = RCU_GP_CLEANED;
@@ -4325,10 +4325,10 @@ void rcu_cpu_starting(unsigned int cpu)
 	local_irq_save(flags);
 	arch_spin_lock(&rcu_state.ofl_lock);
 	rcu_dynticks_eqs_online();
-	raw_spin_lock(&rdp->barrier_lock);
+	raw_spin_lock(&rcu_state.barrier_lock);
 	raw_spin_lock_rcu_node(rnp);
 	WRITE_ONCE(rnp->qsmaskinitnext, rnp->qsmaskinitnext | mask);
-	raw_spin_unlock(&rdp->barrier_lock);
+	raw_spin_unlock(&rcu_state.barrier_lock);
 	newcpu = !(rnp->expmaskinitnext & mask);
 	rnp->expmaskinitnext |= mask;
 	/* Allow lockless access for expedited grace periods. */
@@ -4415,7 +4415,7 @@ void rcutree_migrate_callbacks(int cpu)
 	    rcu_segcblist_empty(&rdp->cblist))
 		return;  /* No callbacks to migrate. */
 
-	raw_spin_lock_irqsave(&rdp->barrier_lock, flags);
+	raw_spin_lock_irqsave(&rcu_state.barrier_lock, flags);
 	WARN_ON_ONCE(rcu_rdp_cpu_online(rdp));
 	rcu_barrier_entrain(rdp);
 	my_rdp = this_cpu_ptr(&rcu_data);
@@ -4427,7 +4427,7 @@ void rcutree_migrate_callbacks(int cpu)
 	needwake = rcu_advance_cbs(my_rnp, rdp) ||
 		   rcu_advance_cbs(my_rnp, my_rdp);
 	rcu_segcblist_merge(&my_rdp->cblist, &rdp->cblist);
-	raw_spin_unlock(&rdp->barrier_lock); /* irqs remain disabled. */
+	raw_spin_unlock(&rcu_state.barrier_lock); /* irqs remain disabled. */
 	needwake = needwake || rcu_advance_cbs(my_rnp, my_rdp);
 	rcu_segcblist_disable(&rdp->cblist);
 	WARN_ON_ONCE(rcu_segcblist_empty(&my_rdp->cblist) != !rcu_segcblist_n_cbs(&my_rdp->cblist));
diff --git a/kernel/rcu/tree.h b/kernel/rcu/tree.h
index 84362951ed9e1..a2d7ffd634cc1 100644
--- a/kernel/rcu/tree.h
+++ b/kernel/rcu/tree.h
@@ -188,7 +188,6 @@ struct rcu_data {
 	bool rcu_forced_tick_exp;	/*   ... provide QS to expedited GP. */
 
 	/* 4) rcu_barrier(), OOM callbacks, and expediting. */
-	raw_spinlock_t barrier_lock;	/* Protects ->barrier_seq_snap. */
 	unsigned long barrier_seq_snap;	/* Snap of rcu_state.barrier_sequence. */
 	struct rcu_head barrier_head;
 	int exp_dynticks_snap;		/* Double-check need for IPI. */
@@ -323,6 +322,8 @@ struct rcu_state {
 						/*  rcu_barrier(). */
 	/* End of fields guarded by barrier_mutex. */
 
+	raw_spinlock_t barrier_lock;		/* Protects ->barrier_seq_snap. */
+
 	struct mutex exp_mutex;			/* Serialize expedited GP. */
 	struct mutex exp_wake_mutex;		/* Serialize wakeup. */
 	unsigned long expedited_sequence;	/* Take a ticket. */
-- 
2.31.1.189.g2e36527f23

