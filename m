Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDB3B4F1C10
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Apr 2022 23:26:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381287AbiDDVWt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 4 Apr 2022 17:22:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59400 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378987AbiDDQQA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 4 Apr 2022 12:16:00 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3BE6A2FE78
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 09:14:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1649088842;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5/6Wt9IkvR9/PHXPvpCHIlNMFPvsjemyujOZqaEvdsQ=;
        b=MHqT5SdGEjuqVDoeLjRkIZzQGIG71LZe1nFQlwoZPdvO2ZS/JoP7kI9fK+kOMRXQfQD2F5
        Ujo0VrgsC9MdQ8U9JLDgrlHqmGPiWLI45Nz4cvnM6vOinkUD7bq6Mas9WgkmiidBOpztPK
        eZfu7DMuLqIF2Hz5tAWBmfRDJkP3Pqg=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590-t8WHI3nGMxKBida6nbGqUw-1; Mon, 04 Apr 2022 12:13:57 -0400
X-MC-Unique: t8WHI3nGMxKBida6nbGqUw-1
Received: from smtp.corp.redhat.com (int-mx10.intmail.prod.int.rdu2.redhat.com [10.11.54.10])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id E8DF13C11A18;
        Mon,  4 Apr 2022 16:13:54 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.110])
        by smtp.corp.redhat.com (Postfix) with SMTP id 5FB97536B9A;
        Mon,  4 Apr 2022 16:13:42 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Mon,  4 Apr 2022 18:13:45 +0200 (CEST)
Date:   Mon, 4 Apr 2022 18:13:39 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Sebastian Andrzej Siewior <bigeasy@linutronix.de>
Cc:     linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
Subject: Re: [PATCH v2] ptrace: fix ptrace vs tasklist_lock race on
 PREEMPT_RT.
Message-ID: <20220404161339.GA21531@redhat.com>
References: <Yh/b19JikC+Vnm8i@linutronix.de>
 <20220314185429.GA30364@redhat.com>
 <YjBO8yzxdmjTGNiy@linutronix.de>
 <20220315142944.GA22670@redhat.com>
 <YkW55u6u2fo5QmV7@linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <YkW55u6u2fo5QmV7@linutronix.de>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.10
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Cough. Somehow I can hardly understand v2. For example, if we fix
wait_task_inactive() correctly, then why ptrace_freeze_traced()
should take saved_state into account? And how can unfreeze_traced
hit saved_state == __TASK_TRACED ?

I will read this patch tommorrow again, I have a fever today, quite
possibly I missed something...

But in any case, I think you need to update the changelog. Yes sure,
ptrace/wait_task_inactive doesn't play well if CONFIG_PREEMPT_RT,
but which exactly problem this patch tries to solve? and how?

And btw... What does the "Fix for ptrace_unfreeze_traced() by Oleg
Nesterov" below mean? This all looks as if there is something else
I am not aware of.

On 03/31, Sebastian Andrzej Siewior wrote:
>
> As explained by Alexander Fyodorov <halcy@yandex.ru>:
>
> |read_lock(&tasklist_lock) in ptrace_stop() is converted to sleeping
> |lock on a PREEMPT_RT kernel, and it can remove __TASK_TRACED from
> |task->__state (by moving  it to task->saved_state). If parent does
> |wait() on child followed by a sys_ptrace call, the following race can
> |happen:
> |
> |- child sets __TASK_TRACED in ptrace_stop()
> |- parent does wait() which eventually calls wait_task_stopped() and returns
> |  child's pid
> |- child blocks on read_lock(&tasklist_lock) in ptrace_stop() and moves
> |  __TASK_TRACED flag to saved_state
> |- parent calls sys_ptrace, which calls ptrace_check_attach() and
> |  wait_task_inactive()
>
> The patch is based on his initial patch where an additional check is
> added in case the __TASK_TRACED moved to ->saved_state. The pi_lock is
> acquired to have stable view on ->__state and ->saved_state.
>
> wait_task_inactive() needs to check both task states while waiting for the
> expected task state. Should the expected task state be in ->saved_state then
> the task is blocked on a sleeping lock. In this case wait_task_inactive() needs
> to wait until the lock situtation has been resolved (the expected state is in
> ->__state). This ensures that the task is idle and does not wakeup as part of
> lock resolving and races for instance with __switch_to_xtra() while the
> debugger clears TIF_BLOCKSTEP() (noted by Oleg Nesterov).
>
> [ Fix for ptrace_unfreeze_traced() by Oleg Nesterov ]
>
> Signed-off-by: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> ---
> v1…v2:
>   - Use also ->saved_state in task_state_match_and_set().
>   - Wait in wait_task_inactive() until the desired task state is in
>     ->__state so that the task won't wake up a as part of lock
>     resolving. Pointed out by Oleg Nesterov.
>
>  include/linux/sched.h |  128 ++++++++++++++++++++++++++++++++++++++++++++++++--
>  kernel/ptrace.c       |   25 +++++----
>  kernel/sched/core.c   |   11 +++-
>  3 files changed, 146 insertions(+), 18 deletions(-)
>
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -118,12 +118,8 @@ struct task_group;
>
>  #define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
>
> -#define task_is_traced(task)		((READ_ONCE(task->__state) & __TASK_TRACED) != 0)
> -
>  #define task_is_stopped(task)		((READ_ONCE(task->__state) & __TASK_STOPPED) != 0)
>
> -#define task_is_stopped_or_traced(task)	((READ_ONCE(task->__state) & (__TASK_STOPPED | __TASK_TRACED)) != 0)
> -
>  /*
>   * Special states are those that do not use the normal wait-loop pattern. See
>   * the comment with set_special_state().
> @@ -2009,6 +2005,130 @@ static inline int test_tsk_need_resched(
>  	return unlikely(test_tsk_thread_flag(tsk,TIF_NEED_RESCHED));
>  }
>
> +#ifdef CONFIG_PREEMPT_RT
> +
> +static inline bool task_state_match_and(struct task_struct *tsk, long state)
> +{
> +	unsigned long flags;
> +	bool match = false;
> +
> +	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
> +	if (READ_ONCE(tsk->__state) & state)
> +		match = true;
> +	else if (tsk->saved_state & state)
> +		match = true;
> +	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
> +	return match;
> +}
> +
> +static inline int __task_state_match_eq(struct task_struct *tsk, long state)
> +{
> +	int match = 0;
> +
> +	if (READ_ONCE(tsk->__state) == state)
> +		match = 1;
> +	else if (tsk->saved_state == state)
> +		match = -1;
> +
> +	return match;
> +}
> +
> +static inline int task_state_match_eq(struct task_struct *tsk, long state)
> +{
> +	unsigned long flags;
> +	int match;
> +
> +	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
> +	match = __task_state_match_eq(tsk, state);
> +	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
> +	return match;
> +}
> +
> +static inline bool task_state_match_and_set(struct task_struct *tsk, long state,
> +					    long new_state)
> +{
> +	unsigned long flags;
> +	bool match = false;
> +
> +	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
> +	if (READ_ONCE(tsk->__state) & state) {
> +		WRITE_ONCE(tsk->__state, new_state);
> +		match = true;
> +	} else if (tsk->saved_state & state) {
> +		tsk->saved_state = new_state;
> +		match = true;
> +	}
> +	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
> +	return match;
> +}
> +
> +static inline bool task_state_match_eq_set(struct task_struct *tsk, long state,
> +					   long new_state)
> +{
> +	unsigned long flags;
> +	bool match = false;
> +
> +	raw_spin_lock_irqsave(&tsk->pi_lock, flags);
> +	if (READ_ONCE(tsk->__state) == state) {
> +		WRITE_ONCE(tsk->__state, new_state);
> +		match = true;
> +	} else if (tsk->saved_state == state) {
> +		tsk->saved_state = new_state;
> +		match = true;
> +	}
> +	raw_spin_unlock_irqrestore(&tsk->pi_lock, flags);
> +	return match;
> +}
> +
> +#else
> +
> +static inline bool task_state_match_and(struct task_struct *tsk, long state)
> +{
> +	return READ_ONCE(tsk->__state) & state;
> +}
> +
> +static inline int __task_state_match_eq(struct task_struct *tsk, long state)
> +{
> +	return READ_ONCE(tsk->__state) == state;
> +}
> +
> +static inline int task_state_match_eq(struct task_struct *tsk, long state)
> +{
> +	return __task_state_match_eq(tsk, state);
> +}
> +
> +static inline bool task_state_match_and_set(struct task_struct *tsk, long state,
> +					    long new_state)
> +{
> +	if (READ_ONCE(tsk->__state) & state) {
> +		WRITE_ONCE(tsk->__state, new_state);
> +		return true;
> +	}
> +	return false;
> +}
> +
> +static inline bool task_state_match_eq_set(struct task_struct *tsk, long state,
> +					   long new_state)
> +{
> +	if (READ_ONCE(tsk->__state) == state) {
> +		WRITE_ONCE(tsk->__state, new_state);
> +		return true;
> +	}
> +	return false;
> +}
> +
> +#endif
> +
> +static inline bool task_is_traced(struct task_struct *tsk)
> +{
> +	return task_state_match_and(tsk, __TASK_TRACED);
> +}
> +
> +static inline bool task_is_stopped_or_traced(struct task_struct *tsk)
> +{
> +	return task_state_match_and(tsk, __TASK_STOPPED | __TASK_TRACED);
> +}
> +
>  /*
>   * cond_resched() and cond_resched_lock(): latency reduction via
>   * explicit rescheduling in places that are safe. The return
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -195,10 +195,10 @@ static bool ptrace_freeze_traced(struct
>  		return ret;
>
>  	spin_lock_irq(&task->sighand->siglock);
> -	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
> -	    !__fatal_signal_pending(task)) {
> -		WRITE_ONCE(task->__state, __TASK_TRACED);
> -		ret = true;
> +	if (!looks_like_a_spurious_pid(task) && !__fatal_signal_pending(task)) {
> +
> +		ret = task_state_match_and_set(task, __TASK_TRACED,
> +					       __TASK_TRACED);
>  	}
>  	spin_unlock_irq(&task->sighand->siglock);
>
> @@ -207,7 +207,10 @@ static bool ptrace_freeze_traced(struct
>
>  static void ptrace_unfreeze_traced(struct task_struct *task)
>  {
> -	if (READ_ONCE(task->__state) != __TASK_TRACED)
> +	bool frozen;
> +
> +	if (!IS_ENABLED(CONFIG_PREEMPT_RT) &&
> +	    READ_ONCE(task->__state) != __TASK_TRACED)
>  		return;
>
>  	WARN_ON(!task->ptrace || task->parent != current);
> @@ -217,12 +220,12 @@ static void ptrace_unfreeze_traced(struc
>  	 * Recheck state under the lock to close this race.
>  	 */
>  	spin_lock_irq(&task->sighand->siglock);
> -	if (READ_ONCE(task->__state) == __TASK_TRACED) {
> -		if (__fatal_signal_pending(task))
> -			wake_up_state(task, __TASK_TRACED);
> -		else
> -			WRITE_ONCE(task->__state, TASK_TRACED);
> -	}
> +
> +	frozen = task_state_match_eq_set(task, __TASK_TRACED, TASK_TRACED);
> +
> +	if (frozen && __fatal_signal_pending(task))
> +		wake_up_state(task, __TASK_TRACED);
> +
>  	spin_unlock_irq(&task->sighand->siglock);
>  }
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3219,6 +3219,8 @@ unsigned long wait_task_inactive(struct
>  	struct rq *rq;
>
>  	for (;;) {
> +		int match_type = 0;
> +
>  		/*
>  		 * We do the initial early heuristics without holding
>  		 * any task-queue locks at all. We'll only try to get
> @@ -3239,7 +3241,8 @@ unsigned long wait_task_inactive(struct
>  		 * is actually now running somewhere else!
>  		 */
>  		while (task_running(rq, p)) {
> -			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> +			if (match_state &&
> +			    unlikely(!task_state_match_eq(p, match_state)))
>  				return 0;
>  			cpu_relax();
>  		}
> @@ -3254,7 +3257,9 @@ unsigned long wait_task_inactive(struct
>  		running = task_running(rq, p);
>  		queued = task_on_rq_queued(p);
>  		ncsw = 0;
> -		if (!match_state || READ_ONCE(p->__state) == match_state)
> +		if (match_state)
> +			match_type = __task_state_match_eq(p, match_state);
> +		if (!match_state || match_type)
>  			ncsw = p->nvcsw | LONG_MIN; /* sets MSB */
>  		task_rq_unlock(rq, p, &rf);
>
> @@ -3284,7 +3289,7 @@ unsigned long wait_task_inactive(struct
>  		 * running right now), it's preempted, and we should
>  		 * yield - it could be a while.
>  		 */
> -		if (unlikely(queued)) {
> +		if (unlikely(queued || match_type < 0)) {
>  			ktime_t to = NSEC_PER_SEC / HZ;
>
>  			set_current_state(TASK_UNINTERRUPTIBLE);

