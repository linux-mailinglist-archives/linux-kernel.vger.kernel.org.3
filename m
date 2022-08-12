Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 039F3590E8B
	for <lists+linux-kernel@lfdr.de>; Fri, 12 Aug 2022 11:59:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbiHLJ6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 05:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237512AbiHLJ6D (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 05:58:03 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6AD59AA4DC;
        Fri, 12 Aug 2022 02:58:02 -0700 (PDT)
Date:   Fri, 12 Aug 2022 09:57:57 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1660298280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSd81+rtPYogV1+8k88xCNEVHesrtONo4ICUnlfWuug=;
        b=1qzwx5SVw2u234j5R5HhZDCsSxyGBGS68cHPkV32CLcl5HJ2nwX36ADIkKTokIceqFBknJ
        1VFbhk46GI3eCe3ST98gqC/63EPD+E6eO7gnJmiRoxXs9RsiBux2RV7QVqde3tyqka2MPi
        Vsv58G+PnFvBVXKpzlD2ir+k5pJOgyIJw9sy44S9aA6IaS8jRDashZQn1BKQetBImCdiXQ
        ziivkvRYrvdc5IznVFgzf7q5Kwq6uHhwBDKh2zcKp6YJXG/e4WeD9un8NfGMtzlju3DpSc
        6nqhZ8xKgwqKdhCIOc8EAG4mUPUtBbrCG/bb/bBKkq5sM4VTMb1CfqViwMhcaw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1660298280;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=oSd81+rtPYogV1+8k88xCNEVHesrtONo4ICUnlfWuug=;
        b=M/Yt0eFf8LnjUbR0U9PY2+fGQGTERYzsZbQupWn2I8/UDfI3WyH21iDOsfruhCvttApKwA
        PSpVGKR0XNtE5FAg==
From:   "tip-bot2 for Ingo Molnar" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/all: Change all BUG_ON() instances in the
 scheduler to WARN_ON_ONCE()
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Ingo Molnar <mingo@kernel.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <YvSsKcAXISmshtHo@gmail.com>
References: <YvSsKcAXISmshtHo@gmail.com>
MIME-Version: 1.0
Message-ID: <166029827708.401.15683126308560276708.tip-bot2@tip-bot2>
Robot-ID: <tip-bot2@linutronix.de>
Robot-Unsubscribe: Contact <mailto:tglx@linutronix.de> to get blacklisted from these emails
Content-Type: text/plain; charset="utf-8"
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The following commit has been merged into the sched/urgent branch of tip:

Commit-ID:     09348d75a6ce60eec85c86dd0ab7babc4db3caf6
Gitweb:        https://git.kernel.org/tip/09348d75a6ce60eec85c86dd0ab7babc4db3caf6
Author:        Ingo Molnar <mingo@kernel.org>
AuthorDate:    Thu, 11 Aug 2022 08:54:52 +02:00
Committer:     Ingo Molnar <mingo@kernel.org>
CommitterDate: Fri, 12 Aug 2022 11:25:10 +02:00

sched/all: Change all BUG_ON() instances in the scheduler to WARN_ON_ONCE()

There's no good reason to crash a user's system with a BUG_ON(),
chances are high that they'll never even see the crash message on
Xorg, and it won't make it into the syslog either.

By using a WARN_ON_ONCE() we at least give the user a chance to report
any bugs triggered here - instead of getting silent hangs.

None of these WARN_ON_ONCE()s are supposed to trigger, ever - so we ignore
cases where a NULL check is done via a BUG_ON() and we let a NULL
pointer through after a WARN_ON_ONCE().

There's one exception: WARN_ON_ONCE() arguments with side-effects,
such as locking - in this case we use the return value of the
WARN_ON_ONCE(), such as in:

 -       BUG_ON(!lock_task_sighand(p, &flags));
 +       if (WARN_ON_ONCE(!lock_task_sighand(p, &flags)))
 +               return;

Suggested-by: Linus Torvalds <torvalds@linux-foundation.org>
Signed-off-by: Ingo Molnar <mingo@kernel.org>
Link: https://lore.kernel.org/r/YvSsKcAXISmshtHo@gmail.com
---
 kernel/sched/autogroup.c |  3 ++-
 kernel/sched/core.c      |  2 +-
 kernel/sched/cpupri.c    |  2 +-
 kernel/sched/deadline.c  | 26 +++++++++++++-------------
 kernel/sched/fair.c      | 10 +++++-----
 kernel/sched/rt.c        |  2 +-
 kernel/sched/sched.h     |  6 +++---
 7 files changed, 26 insertions(+), 25 deletions(-)

diff --git a/kernel/sched/autogroup.c b/kernel/sched/autogroup.c
index 4ebaf97..991fc90 100644
--- a/kernel/sched/autogroup.c
+++ b/kernel/sched/autogroup.c
@@ -161,7 +161,8 @@ autogroup_move_group(struct task_struct *p, struct autogroup *ag)
 	struct task_struct *t;
 	unsigned long flags;
 
-	BUG_ON(!lock_task_sighand(p, &flags));
+	if (WARN_ON_ONCE(!lock_task_sighand(p, &flags)))
+		return;
 
 	prev = p->signal->autogroup;
 	if (prev == ag) {
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index ee28253..813687a 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2328,7 +2328,7 @@ static struct rq *move_queued_task(struct rq *rq, struct rq_flags *rf,
 	rq = cpu_rq(new_cpu);
 
 	rq_lock(rq, rf);
-	BUG_ON(task_cpu(p) != new_cpu);
+	WARN_ON_ONCE(task_cpu(p) != new_cpu);
 	activate_task(rq, p, 0);
 	check_preempt_curr(rq, p, 0);
 
diff --git a/kernel/sched/cpupri.c b/kernel/sched/cpupri.c
index fa9ce9d..a286e72 100644
--- a/kernel/sched/cpupri.c
+++ b/kernel/sched/cpupri.c
@@ -147,7 +147,7 @@ int cpupri_find_fitness(struct cpupri *cp, struct task_struct *p,
 	int task_pri = convert_prio(p->prio);
 	int idx, cpu;
 
-	BUG_ON(task_pri >= CPUPRI_NR_PRIORITIES);
+	WARN_ON_ONCE(task_pri >= CPUPRI_NR_PRIORITIES);
 
 	for (idx = 0; idx < task_pri; idx++) {
 
diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index 0ab79d8..962b169 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -310,7 +310,7 @@ static void dl_change_utilization(struct task_struct *p, u64 new_bw)
 {
 	struct rq *rq;
 
-	BUG_ON(p->dl.flags & SCHED_FLAG_SUGOV);
+	WARN_ON_ONCE(p->dl.flags & SCHED_FLAG_SUGOV);
 
 	if (task_on_rq_queued(p))
 		return;
@@ -607,7 +607,7 @@ static void enqueue_pushable_dl_task(struct rq *rq, struct task_struct *p)
 {
 	struct rb_node *leftmost;
 
-	BUG_ON(!RB_EMPTY_NODE(&p->pushable_dl_tasks));
+	WARN_ON_ONCE(!RB_EMPTY_NODE(&p->pushable_dl_tasks));
 
 	leftmost = rb_add_cached(&p->pushable_dl_tasks,
 				 &rq->dl.pushable_dl_tasks_root,
@@ -684,7 +684,7 @@ static struct rq *dl_task_offline_migration(struct rq *rq, struct task_struct *p
 			 * Failed to find any suitable CPU.
 			 * The task will never come back!
 			 */
-			BUG_ON(dl_bandwidth_enabled());
+			WARN_ON_ONCE(dl_bandwidth_enabled());
 
 			/*
 			 * If admission control is disabled we
@@ -830,7 +830,7 @@ static void replenish_dl_entity(struct sched_dl_entity *dl_se)
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 	struct rq *rq = rq_of_dl_rq(dl_rq);
 
-	BUG_ON(pi_of(dl_se)->dl_runtime <= 0);
+	WARN_ON_ONCE(pi_of(dl_se)->dl_runtime <= 0);
 
 	/*
 	 * This could be the case for a !-dl task that is boosted.
@@ -1616,7 +1616,7 @@ static void __enqueue_dl_entity(struct sched_dl_entity *dl_se)
 {
 	struct dl_rq *dl_rq = dl_rq_of_se(dl_se);
 
-	BUG_ON(!RB_EMPTY_NODE(&dl_se->rb_node));
+	WARN_ON_ONCE(!RB_EMPTY_NODE(&dl_se->rb_node));
 
 	rb_add_cached(&dl_se->rb_node, &dl_rq->root, __dl_less);
 
@@ -1640,7 +1640,7 @@ static void __dequeue_dl_entity(struct sched_dl_entity *dl_se)
 static void
 enqueue_dl_entity(struct sched_dl_entity *dl_se, int flags)
 {
-	BUG_ON(on_dl_rq(dl_se));
+	WARN_ON_ONCE(on_dl_rq(dl_se));
 
 	update_stats_enqueue_dl(dl_rq_of_se(dl_se), dl_se, flags);
 
@@ -2017,7 +2017,7 @@ static struct task_struct *pick_task_dl(struct rq *rq)
 		return NULL;
 
 	dl_se = pick_next_dl_entity(dl_rq);
-	BUG_ON(!dl_se);
+	WARN_ON_ONCE(!dl_se);
 	p = dl_task_of(dl_se);
 
 	return p;
@@ -2277,12 +2277,12 @@ static struct task_struct *pick_next_pushable_dl_task(struct rq *rq)
 
 	p = __node_2_pdl(rb_first_cached(&rq->dl.pushable_dl_tasks_root));
 
-	BUG_ON(rq->cpu != task_cpu(p));
-	BUG_ON(task_current(rq, p));
-	BUG_ON(p->nr_cpus_allowed <= 1);
+	WARN_ON_ONCE(rq->cpu != task_cpu(p));
+	WARN_ON_ONCE(task_current(rq, p));
+	WARN_ON_ONCE(p->nr_cpus_allowed <= 1);
 
-	BUG_ON(!task_on_rq_queued(p));
-	BUG_ON(!dl_task(p));
+	WARN_ON_ONCE(!task_on_rq_queued(p));
+	WARN_ON_ONCE(!dl_task(p));
 
 	return p;
 }
@@ -2492,7 +2492,7 @@ static void set_cpus_allowed_dl(struct task_struct *p,
 	struct root_domain *src_rd;
 	struct rq *rq;
 
-	BUG_ON(!dl_task(p));
+	WARN_ON_ONCE(!dl_task(p));
 
 	rq = task_rq(p);
 	src_rd = rq->rd;
diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 914096c..28f10dc 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -2600,7 +2600,7 @@ static void task_numa_group(struct task_struct *p, int cpupid, int flags,
 	if (!join)
 		return;
 
-	BUG_ON(irqs_disabled());
+	WARN_ON_ONCE(irqs_disabled());
 	double_lock_irq(&my_grp->lock, &grp->lock);
 
 	for (i = 0; i < NR_NUMA_HINT_FAULT_STATS * nr_node_ids; i++) {
@@ -7279,7 +7279,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
 		return;
 
 	find_matching_se(&se, &pse);
-	BUG_ON(!pse);
+	WARN_ON_ONCE(!pse);
 
 	cse_is_idle = se_is_idle(se);
 	pse_is_idle = se_is_idle(pse);
@@ -8159,7 +8159,7 @@ static void attach_task(struct rq *rq, struct task_struct *p)
 {
 	lockdep_assert_rq_held(rq);
 
-	BUG_ON(task_rq(p) != rq);
+	WARN_ON_ONCE(task_rq(p) != rq);
 	activate_task(rq, p, ENQUEUE_NOCLOCK);
 	check_preempt_curr(rq, p, 0);
 }
@@ -10134,7 +10134,7 @@ redo:
 		goto out_balanced;
 	}
 
-	BUG_ON(busiest == env.dst_rq);
+	WARN_ON_ONCE(busiest == env.dst_rq);
 
 	schedstat_add(sd->lb_imbalance[idle], env.imbalance);
 
@@ -10430,7 +10430,7 @@ static int active_load_balance_cpu_stop(void *data)
 	 * we need to fix it. Originally reported by
 	 * Bjorn Helgaas on a 128-CPU setup.
 	 */
-	BUG_ON(busiest_rq == target_rq);
+	WARN_ON_ONCE(busiest_rq == target_rq);
 
 	/* Search for an sd spanning us and the target CPU. */
 	rcu_read_lock();
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 55f39c8..2936fe5 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -843,7 +843,7 @@ static void __disable_runtime(struct rq *rq)
 		 * We cannot be left wanting - that would mean some runtime
 		 * leaked out of the system.
 		 */
-		BUG_ON(want);
+		WARN_ON_ONCE(want);
 balanced:
 		/*
 		 * Disable all the borrow logic by pretending we have inf
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index e26688d..7a44dce 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2709,8 +2709,8 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
 	__acquires(rq1->lock)
 	__acquires(rq2->lock)
 {
-	BUG_ON(!irqs_disabled());
-	BUG_ON(rq1 != rq2);
+	WARN_ON_ONCE(!irqs_disabled());
+	WARN_ON_ONCE(rq1 != rq2);
 	raw_spin_rq_lock(rq1);
 	__acquire(rq2->lock);	/* Fake it out ;) */
 	double_rq_clock_clear_update(rq1, rq2);
@@ -2726,7 +2726,7 @@ static inline void double_rq_unlock(struct rq *rq1, struct rq *rq2)
 	__releases(rq1->lock)
 	__releases(rq2->lock)
 {
-	BUG_ON(rq1 != rq2);
+	WARN_ON_ONCE(rq1 != rq2);
 	raw_spin_rq_unlock(rq1);
 	__release(rq2->lock);
 }
