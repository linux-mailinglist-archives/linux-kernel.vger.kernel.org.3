Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 41A7B5B0080
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:30:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230097AbiIGJaL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:30:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229706AbiIGJaI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:30:08 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4FAFD13DEB;
        Wed,  7 Sep 2022 02:30:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VNVnlIPa3SxL4obnH4n5uEuVjotIlVSNZU2MPTJ/x38=; b=epekmRTaV+hHUQaXQA1UrD8uuJ
        iet3qpxPd2VD0Y5u+zWho9yval+4fWxckDNUqULFZtktkQheI0vQKxPJk2HEth1GilXrlOjGkXzE1
        bbdZ5iKve/fKRQ1V6m6vHIRZXSQD9riLVUfTw+4cszICthp73IrP/ecJeEZrTX9lSy3settUjVwTo
        Oe6O56ii9XoBwreJ8vFyomQp8lrgeNngAeQopqzcgYm0eKc+wXislmV4U+v9Jovc4T9Dgc3/gCQ1M
        OCI2744gfirjICQCrjySpD/se6IEtrXiCLgS0KEdmxRdGvyb0yFoaQDyz4SU721IT8Th9t38Eroth
        1mr6qDkQ==;
Received: from j130084.upc-j.chello.nl ([24.132.130.84] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1oVrNP-00APWO-26; Wed, 07 Sep 2022 09:29:43 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id A442B30013F;
        Wed,  7 Sep 2022 11:29:42 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 861F82B99BB12; Wed,  7 Sep 2022 11:29:42 +0200 (CEST)
Date:   Wed, 7 Sep 2022 11:29:42 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Ingo Molnar <mingo@kernel.org>
Cc:     rjw@rjwysocki.net, oleg@redhat.com, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH v3 3/6] sched: Change wait_task_inactive()s match_state
Message-ID: <Yxhkhn55uHZx+NGl@hirez.programming.kicks-ass.net>
References: <20220822111816.760285417@infradead.org>
 <20220822114648.856734578@infradead.org>
 <YxSBlPb/oZ6x0jfw@gmail.com>
 <Yxcm6oOTbmCbsHvj@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <Yxcm6oOTbmCbsHvj@hirez.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Sep 06, 2022 at 12:54:34PM +0200, Peter Zijlstra wrote:

> > Suggestion #1:
> > 
> > - Shouldn't we rename task_running() to something like task_on_cpu()? The 
> >   task_running() primitive is similar to TASK_RUNNING but is not based off 
> >   any TASK_FLAGS.
> 
> That looks like a simple enough patch, lemme go do that.

---
Subject: sched: Rename task_running() to task_on_cpu()
From: Peter Zijlstra <peterz@infradead.org>
Date: Tue Sep 6 12:33:04 CEST 2022

There is some ambiguity about task_running() in that it is unrelated
to TASK_RUNNING but instead tests ->on_cpu. As such, rename the thing
task_on_cpu().

Suggested-by: Ingo Molnar <mingo@kernel.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/sched/core.c       |   10 +++++-----
 kernel/sched/core_sched.c |    2 +-
 kernel/sched/deadline.c   |    6 +++---
 kernel/sched/fair.c       |    2 +-
 kernel/sched/rt.c         |    6 +++---
 kernel/sched/sched.h      |    2 +-
 6 files changed, 14 insertions(+), 14 deletions(-)

--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -2778,7 +2778,7 @@ static int affine_move_task(struct rq *r
 		return -EINVAL;
 	}
 
-	if (task_running(rq, p) || READ_ONCE(p->__state) == TASK_WAKING) {
+	if (task_on_cpu(rq, p) || READ_ONCE(p->__state) == TASK_WAKING) {
 		/*
 		 * MIGRATE_ENABLE gets here because 'p == current', but for
 		 * anything else we cannot do is_migration_disabled(), punt
@@ -3290,11 +3290,11 @@ unsigned long wait_task_inactive(struct
 		 *
 		 * NOTE! Since we don't hold any locks, it's not
 		 * even sure that "rq" stays as the right runqueue!
-		 * But we don't care, since "task_running()" will
+		 * But we don't care, since "task_on_cpu()" will
 		 * return false if the runqueue has changed and p
 		 * is actually now running somewhere else!
 		 */
-		while (task_running(rq, p)) {
+		while (task_on_cpu(rq, p)) {
 			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
 				return 0;
 			cpu_relax();
@@ -3307,7 +3307,7 @@ unsigned long wait_task_inactive(struct
 		 */
 		rq = task_rq_lock(p, &rf);
 		trace_sched_wait_task(p);
-		running = task_running(rq, p);
+		running = task_on_cpu(rq, p);
 		queued = task_on_rq_queued(p);
 		ncsw = 0;
 		if (!match_state || READ_ONCE(p->__state) == match_state)
@@ -8649,7 +8649,7 @@ int __sched yield_to(struct task_struct
 	if (curr->sched_class != p->sched_class)
 		goto out_unlock;
 
-	if (task_running(p_rq, p) || !task_is_running(p))
+	if (task_on_cpu(p_rq, p) || !task_is_running(p))
 		goto out_unlock;
 
 	yielded = curr->sched_class->yield_to_task(rq, p);
--- a/kernel/sched/core_sched.c
+++ b/kernel/sched/core_sched.c
@@ -88,7 +88,7 @@ static unsigned long sched_core_update_c
 	 * core has now entered/left forced idle state. Defer accounting to the
 	 * next scheduling edge, rather than always forcing a reschedule here.
 	 */
-	if (task_running(rq, p))
+	if (task_on_cpu(rq, p))
 		resched_curr(rq);
 
 	task_rq_unlock(rq, p, &rf);
--- a/kernel/sched/deadline.c
+++ b/kernel/sched/deadline.c
@@ -2087,7 +2087,7 @@ static void task_fork_dl(struct task_str
 
 static int pick_dl_task(struct rq *rq, struct task_struct *p, int cpu)
 {
-	if (!task_running(rq, p) &&
+	if (!task_on_cpu(rq, p) &&
 	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 	return 0;
@@ -2241,7 +2241,7 @@ static struct rq *find_lock_later_rq(str
 		if (double_lock_balance(rq, later_rq)) {
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(later_rq->cpu, &task->cpus_mask) ||
-				     task_running(rq, task) ||
+				     task_on_cpu(rq, task) ||
 				     !dl_task(task) ||
 				     !task_on_rq_queued(task))) {
 				double_unlock_balance(rq, later_rq);
@@ -2475,7 +2475,7 @@ static void pull_dl_task(struct rq *this
  */
 static void task_woken_dl(struct rq *rq, struct task_struct *p)
 {
-	if (!task_running(rq, p) &&
+	if (!task_on_cpu(rq, p) &&
 	    !test_tsk_need_resched(rq->curr) &&
 	    p->nr_cpus_allowed > 1 &&
 	    dl_task(rq->curr) &&
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -7938,7 +7938,7 @@ int can_migrate_task(struct task_struct
 	/* Record that we found at least one task that could run on dst_cpu */
 	env->flags &= ~LBF_ALL_PINNED;
 
-	if (task_running(env->src_rq, p)) {
+	if (task_on_cpu(env->src_rq, p)) {
 		schedstat_inc(p->stats.nr_failed_migrations_running);
 		return 0;
 	}
--- a/kernel/sched/rt.c
+++ b/kernel/sched/rt.c
@@ -1849,7 +1849,7 @@ static void put_prev_task_rt(struct rq *
 
 static int pick_rt_task(struct rq *rq, struct task_struct *p, int cpu)
 {
-	if (!task_running(rq, p) &&
+	if (!task_on_cpu(rq, p) &&
 	    cpumask_test_cpu(cpu, &p->cpus_mask))
 		return 1;
 
@@ -2004,7 +2004,7 @@ static struct rq *find_lock_lowest_rq(st
 			 */
 			if (unlikely(task_rq(task) != rq ||
 				     !cpumask_test_cpu(lowest_rq->cpu, &task->cpus_mask) ||
-				     task_running(rq, task) ||
+				     task_on_cpu(rq, task) ||
 				     !rt_task(task) ||
 				     !task_on_rq_queued(task))) {
 
@@ -2462,7 +2462,7 @@ static void pull_rt_task(struct rq *this
  */
 static void task_woken_rt(struct rq *rq, struct task_struct *p)
 {
-	bool need_to_push = !task_running(rq, p) &&
+	bool need_to_push = !task_on_cpu(rq, p) &&
 			    !test_tsk_need_resched(rq->curr) &&
 			    p->nr_cpus_allowed > 1 &&
 			    (dl_task(rq->curr) || rt_task(rq->curr)) &&
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -2060,7 +2060,7 @@ static inline int task_current(struct rq
 	return rq->curr == p;
 }
 
-static inline int task_running(struct rq *rq, struct task_struct *p)
+static inline int task_on_cpu(struct rq *rq, struct task_struct *p)
 {
 #ifdef CONFIG_SMP
 	return p->on_cpu;
