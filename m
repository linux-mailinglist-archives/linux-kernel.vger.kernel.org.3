Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 732EB4DB9DF
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 22:03:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355101AbiCPVFK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 17:05:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353443AbiCPVFH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 17:05:07 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 78B3D12AB3
        for <linux-kernel@vger.kernel.org>; Wed, 16 Mar 2022 14:03:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SuzzZw+cpd3GugZtgpP2SZIBUKR/Ka78UzH1KQJyyk0=; b=T8sgMhlSn1VorkI2uszJ6lB6Mp
        ZnC34XVAloLBzdfvFkJsJTCdeUFbr1VomS4ZyLYRDf0YdsEwMJIstXa7cgoEC8EpkBxStcVALKN9e
        VrpFiXMKtTKxf5QJLjVJuVElc4y2+voAex1V3HMbtdK/dpae5wryTMvn6IFH/pSYOxHAthGIG10o9
        cBoXRSJM98/ghM4QdAD+ErbD+/U0OQNXihn0P+tqITHoGaMYRP4VzbBSSGCK8yfQ65VVQ2f3ffbrL
        bUkPnWPkL+LzBado5SKUzEsfvwrX5FJ7AwAN/BQqCGnnjn7ixmpPT+DNwGngVDDFOVoE3rRnzbR9k
        FuUA1WeQ==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nUao3-001esg-1C; Wed, 16 Mar 2022 21:03:46 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 752229882AA; Wed, 16 Mar 2022 22:03:41 +0100 (CET)
Date:   Wed, 16 Mar 2022 22:03:41 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Steven Rostedt <rostedt@goodmis.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        joel@joelfernandes.org
Subject: Re: sched_core_balance() releasing interrupts with pi_lock held
Message-ID: <20220316210341.GD14330@worktop.programming.kicks-ass.net>
References: <20220308161455.036e9933@gandalf.local.home>
 <20220315174606.02959816@gandalf.local.home>
 <20220316202734.GJ8939@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220316202734.GJ8939@worktop.programming.kicks-ass.net>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 16, 2022 at 09:27:34PM +0100, Peter Zijlstra wrote:
> On Tue, Mar 15, 2022 at 05:46:06PM -0400, Steven Rostedt wrote:
> > On Tue, 8 Mar 2022 16:14:55 -0500
> > Steven Rostedt <rostedt@goodmis.org> wrote:
> > 
> > > Hi Peter,
> > 
> > Have you had time to look into this?
> 
> Not since I talk to you on IRC about it last week.
> 
> Like I wrote, the balance_callback should be ran under whichever
> rq->lock instance it gets queued under. As per:
> 
>   565790d28b1e ("sched: Fix balance_callback()")
> 
> Now, we only do queue_core_balance() from set_next_task_idle(), which
> *should* only happen from pick_next_task(), and as such the callback
> should only ever get called from finish_lock_switch() or the 'prev ==
> next' case in __schedule().
> 
> Neither of these two sites holds pi_lock.
> 
> 
> This is about as far as I got explaining things, and it being late, it's
> about as far as I got looking at things.
> 
> Now that also makes conceptual sense, we only want to pull a core-cookie
> task when we're scheduling an idle task.
> 
> Now, clearly this gets triggered from the PI path, but that's not making
> immediate sense to me, it would mean we're boosting the idle task, which
> is wrong too.
> 
> So it would be useful for someone that can reproduce this to provide a
> trace of where queue_core_balance() gets called, because that *should*
> only be in __schedule().

Does something like the below (untested in the extreme) help?

---
diff --git a/kernel/sched/core.c b/kernel/sched/core.c
index 83872f95a1ea..18163454bb47 100644
--- a/kernel/sched/core.c
+++ b/kernel/sched/core.c
@@ -5665,6 +5665,8 @@ static inline struct task_struct *pick_task(struct rq *rq)
 
 extern void task_vruntime_update(struct rq *rq, struct task_struct *p, bool in_fi);
 
+static void queue_core_balance(struct rq *rq);
+
 static struct task_struct *
 pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 {
@@ -5714,7 +5716,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 		}
 
 		rq->core_pick = NULL;
-		return next;
+		goto out;
 	}
 
 	put_prev_task_balance(rq, prev, rf);
@@ -5764,7 +5766,7 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
 			 */
 			WARN_ON_ONCE(fi_before);
 			task_vruntime_update(rq, next, false);
-			goto done;
+			goto out_set_next;
 		}
 	}
 
@@ -5884,8 +5886,12 @@ pick_next_task(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
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
 
@@ -5914,7 +5920,7 @@ static bool try_steal_cookie(int this, int that)
 		if (p == src->core_pick || p == src->curr)
 			goto next;
 
-		if (!cpumask_test_cpu(this, &p->cpus_mask))
+		if (!is_cpu_allowed(p, this))
 			goto next;
 
 		if (p->core_occupation > dst->idle->core_occupation)
@@ -5980,7 +5986,7 @@ static void sched_core_balance(struct rq *rq)
 
 static DEFINE_PER_CPU(struct callback_head, core_balance_head);
 
-void queue_core_balance(struct rq *rq)
+static void queue_core_balance(struct rq *rq)
 {
 	if (!sched_core_enabled(rq))
 		return;
diff --git a/kernel/sched/idle.c b/kernel/sched/idle.c
index d17b0a5ce6ac..314c36fc9c42 100644
--- a/kernel/sched/idle.c
+++ b/kernel/sched/idle.c
@@ -437,7 +437,6 @@ static void set_next_task_idle(struct rq *rq, struct task_struct *next, bool fir
 {
 	update_idle_core(rq);
 	schedstat_inc(rq->sched_goidle);
-	queue_core_balance(rq);
 }
 
 #ifdef CONFIG_SMP
diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
index de53be905739..b85c9344779a 100644
--- a/kernel/sched/sched.h
+++ b/kernel/sched/sched.h
@@ -1247,8 +1247,6 @@ static inline bool sched_group_cookie_match(struct rq *rq,
 	return false;
 }
 
-extern void queue_core_balance(struct rq *rq);
-
 static inline bool sched_core_enqueued(struct task_struct *p)
 {
 	return !RB_EMPTY_NODE(&p->core_node);
@@ -1282,10 +1280,6 @@ static inline raw_spinlock_t *__rq_lockp(struct rq *rq)
 	return &rq->__lock;
 }
 
-static inline void queue_core_balance(struct rq *rq)
-{
-}
-
 static inline bool sched_cpu_cookie_match(struct rq *rq, struct task_struct *p)
 {
 	return true;
