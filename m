Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7724495503
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 20:40:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243879AbiATTku (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 14:40:50 -0500
Received: from foss.arm.com ([217.140.110.172]:51182 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234821AbiATTks (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 14:40:48 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B5CB86D;
        Thu, 20 Jan 2022 11:40:47 -0800 (PST)
Received: from e113632-lin.cambridge.arm.com (e113632-lin.cambridge.arm.com [10.1.196.57])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPA id 2EDB13F774;
        Thu, 20 Jan 2022 11:40:46 -0800 (PST)
From:   Valentin Schneider <valentin.schneider@arm.com>
To:     linux-kernel@vger.kernel.org
Cc:     John Keeping <john@metanate.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
Subject: [PATCH] sched/rt: Plug rt_mutex_setprio() vs push_rt_task() race
Date:   Thu, 20 Jan 2022 19:40:37 +0000
Message-Id: <20220120194037.650433-1-valentin.schneider@arm.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

John reported that push_rt_task() can end up invoking
find_lowest_rq(rq->curr) when curr is not an RT task (in this case a CFS
one), which causes mayhem down convert_prio().

This can happen when current gets demoted to e.g. CFS when releasing an
rt_mutex, and the local CPU gets hit with an rto_push_work irqwork before
getting the chance to reschedule. Exactly who triggers this work isn't
entirely clear to me - switched_from_rt() only invokes rt_queue_pull_task()
if there are no RT tasks on the local RQ, which means the local CPU can't
be in the rto_mask.

My current suspected sequence is something along the lines of the below,
with the demoted task being current.

  mark_wakeup_next_waiter()
    rt_mutex_adjust_prio()
      rt_mutex_setprio() // deboost originally-CFS task
	check_class_changed()
	  switched_from_rt() // Only rt_queue_pull_task() if !rq->rt.rt_nr_running
	  switched_to_fair() // Sets need_resched
      __balance_callbacks() // if pull_rt_task(), tell_cpu_to_push() can't select local CPU per the above
      raw_spin_rq_unlock(rq)

       // need_resched is set, so task_woken_rt() can't
       // invoke push_rt_tasks(). Best I can come up with is
       // local CPU has rt_nr_migratory >= 2 after the demotion, so stays
       // in the rto_mask, and then:

       <some other CPU running rto_push_irq_work_func() queues rto_push_work on this CPU>
	 push_rt_task()
	   // breakage follows here as rq->curr is CFS

Move an existing check to check rq->curr vs the next pushable task's
priority before getting anywhere near find_lowest_rq(). While at it, add an
explicit sched_class of rq->curr check prior to invoking
find_lowest_rq(rq->curr).

Link: http://lore.kernel.org/r/Yb3vXx3DcqVOi+EA@donbot
Fixes: a7c81556ec4d ("sched: Fix migrate_disable() vs rt/dl balancing")
Reported-by: John Keeping <john@metanate.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
---
 kernel/sched/rt.c | 31 +++++++++++++++++++++----------
 1 file changed, 21 insertions(+), 10 deletions(-)

diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7b4f4fbbb404..48fc8c04b038 100644
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -2026,6 +2026,16 @@ static int push_rt_task(struct rq *rq, bool pull)
 		return 0;
 
 retry:
+	/*
+	 * It's possible that the next_task slipped in of
+	 * higher priority than current. If that's the case
+	 * just reschedule current.
+	 */
+	if (unlikely(next_task->prio < rq->curr->prio)) {
+		resched_curr(rq);
+		return 0;
+	}
+
 	if (is_migration_disabled(next_task)) {
 		struct task_struct *push_task = NULL;
 		int cpu;
@@ -2033,6 +2043,17 @@ static int push_rt_task(struct rq *rq, bool pull)
 		if (!pull || rq->push_busy)
 			return 0;
 
+		/*
+		 * Per the above priority check, curr is at least RT. If it's
+		 * of a higher class than RT, invoking find_lowest_rq() on it
+		 * doesn't make sense.
+		 *
+		 * Note that the stoppers are masqueraded as SCHED_FIFO
+		 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
+		 */
+		if (rq->curr->sched_class != &rt_sched_class)
+			return 0;
+
 		cpu = find_lowest_rq(rq->curr);
 		if (cpu == -1 || cpu == rq->cpu)
 			return 0;
@@ -2057,16 +2078,6 @@ static int push_rt_task(struct rq *rq, bool pull)
 	if (WARN_ON(next_task == rq->curr))
 		return 0;
 
-	/*
-	 * It's possible that the next_task slipped in of
-	 * higher priority than current. If that's the case
-	 * just reschedule current.
-	 */
-	if (unlikely(next_task->prio < rq->curr->prio)) {
-		resched_curr(rq);
-		return 0;
-	}
-
 	/* We might release rq lock */
 	get_task_struct(next_task);
 
-- 
2.25.1

