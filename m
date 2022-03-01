Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF2734C8EF4
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 16:24:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235708AbiCAPZf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 10:25:35 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiCAPZ0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 10:25:26 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B09408A6FB;
        Tue,  1 Mar 2022 07:24:42 -0800 (PST)
Date:   Tue, 01 Mar 2022 15:24:40 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646148281;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoQkJlJvDfgiRoKCX0Fk6KgKKpnLQ12b+KEj3XNXjUc=;
        b=Yvd7PmngceusHBnARhBBjdvePjqqeNu+OeXLJWNO1qaW537xjmidXVTnW7psRqAXDeV7o5
        syD1LeIAWwAETHtH9DBq/J9UEcum9Bp97RX6H6hd93cpHI11IHIaEhLPg5tFmJz2J6UvYo
        L6M5ds6iXSAiqwn7YECtHhpnslvjYZOxpWBA3tewc4nE1lEErF0R+5GVXkPrcN+WRHjJ6i
        D+1R+MtRQ2Jr6pfW/3uC62z+E1rJdZi56Em4g9YH9wRCrgLR5p5a2XiVVLl7a9ciBu0HBI
        jKP33+jA/Wi6F8zrqceXHrecStocRT5CXm8dPlWfnPUGbvzfg+lU/gqjfcWdnw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646148281;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=FoQkJlJvDfgiRoKCX0Fk6KgKKpnLQ12b+KEj3XNXjUc=;
        b=3L9jjX32NYXbvxIWz6pYg+zdq/gSIpjQ7eicKLfHV5sxR52cCdErOhFW4XUM4dqyqAlN+a
        SUT8bkCbMu2E1UBQ==
From:   "tip-bot2 for Valentin Schneider" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/core] sched/rt: Plug rt_mutex_setprio() vs push_rt_task() race
Cc:     John Keeping <john@metanate.com>,
        Valentin Schneider <valentin.schneider@arm.com>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220127154059.974729-1-valentin.schneider@arm.com>
References: <20220127154059.974729-1-valentin.schneider@arm.com>
MIME-Version: 1.0
Message-ID: <164614828021.16921.6242853659792543118.tip-bot2@tip-bot2>
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

The following commit has been merged into the sched/core branch of tip:

Commit-ID:     49bef33e4b87b743495627a529029156c6e09530
Gitweb:        https://git.kernel.org/tip/49bef33e4b87b743495627a529029156c6e09530
Author:        Valentin Schneider <valentin.schneider@arm.com>
AuthorDate:    Thu, 27 Jan 2022 15:40:59 
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 01 Mar 2022 16:18:38 +01:00

sched/rt: Plug rt_mutex_setprio() vs push_rt_task() race

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
find_lowest_rq(rq->curr). Align the DL logic to also reschedule regardless
of next_task's migratability.

Fixes: a7c81556ec4d ("sched: Fix migrate_disable() vs rt/dl balancing")
Reported-by: John Keeping <john@metanate.com>
Signed-off-by: Valentin Schneider <valentin.schneider@arm.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
Tested-by: John Keeping <john@metanate.com>
Link: https://lore.kernel.org/r/20220127154059.974729-1-valentin.schneider@arm.com
---
 kernel/sched/deadline.c | 12 ++++++------
 kernel/sched/rt.c       | 32 ++++++++++++++++++++++----------
 2 files changed, 28 insertions(+), 16 deletions(-)

diff --git a/kernel/sched/deadline.c b/kernel/sched/deadline.c
index d2c072b..62f0cf8 100644
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2240,12 +2240,6 @@ static int push_dl_task(struct rq *rq)
 		return 0;
 
 retry:
-	if (is_migration_disabled(next_task))
-		return 0;
-
-	if (WARN_ON(next_task == rq->curr))
-		return 0;
-
 	/*
 	 * If next_task preempts rq->curr, and rq->curr
 	 * can move away, it makes sense to just reschedule
@@ -2258,6 +2252,12 @@ retry:
 		return 0;
 	}
 
+	if (is_migration_disabled(next_task))
+		return 0;
+
+	if (WARN_ON(next_task == rq->curr))
+		return 0;
+
 	/* We might release rq lock */
 	get_task_struct(next_task);
 
diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
index 7b4f4fb..14f273c 100644
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
@@ -2033,6 +2043,18 @@ retry:
 		if (!pull || rq->push_busy)
 			return 0;
 
+		/*
+		 * Invoking find_lowest_rq() on anything but an RT task doesn't
+		 * make sense. Per the above priority check, curr has to
+		 * be of higher priority than next_task, so no need to
+		 * reschedule when bailing out.
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
@@ -2057,16 +2079,6 @@ retry:
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
 
