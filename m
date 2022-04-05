Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7A7094F3771
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 16:20:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352953AbiDELNT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 07:13:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52922 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238307AbiDEIa2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 04:30:28 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09361252A9;
        Tue,  5 Apr 2022 01:22:04 -0700 (PDT)
Date:   Tue, 05 Apr 2022 08:22:02 -0000
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1649146923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0WLv/34aXALGGonMvU1AeA6IQSlt0LPxAfGmIW2LNc=;
        b=knZHXtLTIGsxCTakTRhkyTxFw+LtP0RiCYgQjAYL3T2ZI8ziZ1AtlVD7FgN39Lke4pnfVD
        hKl/tvIrpGHYQKv7r40SY8XOoYyPvjgr/cGP6ud3Tv9yCucnp90jXQgSvuxNb6heqdO03x
        lV4frW9HHvrbnit3zkq1sFESGQxhscoFt27iHR8kJf2wWcl+ZV5aPN6HVbcJyPp3jJDduf
        kcxj4oTdXNuLtN863y0u9NNfALJ+5ZmE5rEyM/tUUgknLEUybfmvK07zA1eKDdawOCRs0B
        sFjsGFZFQrWyVxDkdJMsK9ybSa7NONzoVgj0s3s/Flfz2ND9vAm9rYy7DWXHkQ==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1649146923;
        h=from:from:sender:sender:reply-to:reply-to:subject:subject:date:date:
         message-id:message-id:to:to:cc:cc:mime-version:mime-version:
         content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=S0WLv/34aXALGGonMvU1AeA6IQSlt0LPxAfGmIW2LNc=;
        b=4mixiYV/04rhwvRcL04MdY25FBmdAS0dI0W6k4KZWGpAkLR7BDrnN1atchxyMGTcJXbbRs
        NFRtZmPzJcJRbCDA==
From:   "tip-bot2 for Peter Zijlstra" <tip-bot2@linutronix.de>
Sender: tip-bot2@linutronix.de
Reply-to: linux-kernel@vger.kernel.org
To:     linux-tip-commits@vger.kernel.org
Subject: [tip: sched/urgent] sched/core: Fix forceidle balancing
Cc:     Steven Rostedt <rostedt@goodmis.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        "T.J. Alumbaugh" <talumbau@chromium.org>, x86@kernel.org,
        linux-kernel@vger.kernel.org
In-Reply-To: <20220330160535.GN8939@worktop.programming.kicks-ass.net>
References: <20220330160535.GN8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Message-ID: <164914692201.389.73475831202436743.tip-bot2@tip-bot2>
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

Commit-ID:     5b6547ed97f4f5dfc23f8e3970af6d11d7b7ed7e
Gitweb:        https://git.kernel.org/tip/5b6547ed97f4f5dfc23f8e3970af6d11d7b7ed7e
Author:        Peter Zijlstra <peterz@infradead.org>
AuthorDate:    Wed, 16 Mar 2022 22:03:41 +01:00
Committer:     Peter Zijlstra <peterz@infradead.org>
CommitterDate: Tue, 05 Apr 2022 09:59:36 +02:00

sched/core: Fix forceidle balancing

Steve reported that ChromeOS encounters the forceidle balancer being
ran from rt_mutex_setprio()'s balance_callback() invocation and
explodes.

Now, the forceidle balancer gets queued every time the idle task gets
selected, set_next_task(), which is strictly too often.
rt_mutex_setprio() also uses set_next_task() in the 'change' pattern:

	queued = task_on_rq_queued(p); /* p->on_rq == TASK_ON_RQ_QUEUED */
	running = task_current(rq, p); /* rq->curr == p */

	if (queued)
		dequeue_task(...);
	if (running)
		put_prev_task(...);

	/* change task properties */

	if (queued)
		enqueue_task(...);
	if (running)
		set_next_task(...);

However, rt_mutex_setprio() will explicitly not run this pattern on
the idle task (since priority boosting the idle task is quite insane).
Most other 'change' pattern users are pidhash based and would also not
apply to idle.

Also, the change pattern doesn't contain a __balance_callback()
invocation and hence we could have an out-of-band balance-callback,
which *should* trigger the WARN in rq_pin_lock() (which guards against
this exact anti-pattern).

So while none of that explains how this happens, it does indicate that
having it in set_next_task() might not be the most robust option.

Instead, explicitly queue the forceidle balancer from pick_next_task()
when it does indeed result in forceidle selection. Having it here,
ensures it can only be triggered under the __schedule() rq->lock
instance, and hence must be ran from that context.

This also happens to clean up the code a little, so win-win.

Fixes: d2dfa17bc7de ("sched: Trivial forced-newidle balancer")
Reported-by: Steven Rostedt <rostedt@goodmis.org>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Tested-by: T.J. Alumbaugh <talumbau@chromium.org>
Link: https://lkml.kernel.org/r/20220330160535.GN8939@worktop.programming.kicks-ass.net
---
 kernel/sched/core.c  | 14 ++++++++++----
 kernel/sched/idle.c  |  1 -
 kernel/sched/sched.h |  6 ------
 3 files changed, 10 insertions(+), 11 deletions(-)

diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index d575b49..017ee78 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5752,6 +5752,8 @@ static inline struct task_struct *pick_task(struct rq *rq)
 
 extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
 
+static void queue_core_balance(struct rq *rq);
+
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -5801,7 +5803,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 
 		rq->core_pick = NULL;
-		return next;
+		goto out;
 	}
 
 	put_prev_task_balance(rq, prev, rf);
@@ -5851,7 +5853,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 */
 			WARN_ON_ONCE(fi_before);
 			task_vruntime_update(rq, next, false);
-			goto done;
+			goto out_set_next;
 		}
 	}
 
@@ -5970,8 +5972,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		resched_curr(rq_i);
 	}
 
-done:
+out_set_next:
 	set_next_task(rq, next);
+out:
+	if (rq->core->core_forceidle_count && next == rq->idle)
+		queue_core_balance(rq);
+
 	return next;
 }
 
@@ -6066,7 +6072,7 @@ static void sched_core_balance(struct rq *rq)
 
 static DEFINE_PER_CPU(struct callback_head, core_balance_head);
 
-void queue_core_balance(struct rq *rq)
+static void queue_core_balance(struct rq *rq)
 {
 	if (!sched_core_enabled(rq))
 		return;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index 8f8b502..ecb0d70 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -434,7 +434,6 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
-	queue_core_balance(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index 58263f9..8dccb34 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1232,8 +1232,6 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 	return false;
 }
 
-extern void queue_core_balance(struct rq *rq);
-
 static inline bool sched_core_enqueued(struct task_struct *p)
 {
 	return !RB_EMPTY_NODE(&p->core_node);
@@ -1267,10 +1265,6 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
-static inline void queue_core_balance(struct rq *rq)
-{
-}
-
 static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
 {
 	return true;
