Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A98A54F86A2
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 19:52:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346630AbiDGRyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Apr 2022 13:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36868 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240462AbiDGRyg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Apr 2022 13:54:36 -0400
Received: from out01.mta.xmission.com (out01.mta.xmission.com [166.70.13.231])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C9BE822EBC4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Apr 2022 10:52:25 -0700 (PDT)
Received: from in02.mta.xmission.com ([166.70.13.52]:47330)
        by out01.mta.xmission.com with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ncWIq-008R6S-Nc; Thu, 07 Apr 2022 11:52:16 -0600
Received: from ip68-227-174-4.om.om.cox.net ([68.227.174.4]:42782 helo=email.froward.int.ebiederm.org.xmission.com)
        by in02.mta.xmission.com with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <ebiederm@xmission.com>)
        id 1ncWIp-006Mg4-9F; Thu, 07 Apr 2022 11:52:16 -0600
From:   "Eric W. Biederman" <ebiederm@xmission.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Oleg Nesterov <oleg@redhat.com>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        linux-kernel@vger.kernel.org, Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Mel Gorman <mgorman@suse.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Vincent Guittot <vincent.guittot@linaro.org>
References: <Yh/b19JikC+Vnm8i@linutronix.de>
        <20220314185429.GA30364@redhat.com> <YjBO8yzxdmjTGNiy@linutronix.de>
        <20220315142944.GA22670@redhat.com> <YkW55u6u2fo5QmV7@linutronix.de>
        <20220405101026.GB34954@worktop.programming.kicks-ass.net>
        <20220405102849.GA2708@redhat.com>
        <Ykwn0MpcrZ/N+LOG@hirez.programming.kicks-ass.net>
        <20220407121340.GA2762@worktop.programming.kicks-ass.net>
Date:   Thu, 07 Apr 2022 12:51:43 -0500
In-Reply-To: <20220407121340.GA2762@worktop.programming.kicks-ass.net> (Peter
        Zijlstra's message of "Thu, 7 Apr 2022 14:13:40 +0200")
Message-ID: <871qy8eq8g.fsf@email.froward.int.ebiederm.org>
User-Agent: Gnus/5.13 (Gnus v5.13) Emacs/27.1 (gnu/linux)
MIME-Version: 1.0
Content-Type: text/plain
X-XM-SPF: eid=1ncWIp-006Mg4-9F;;;mid=<871qy8eq8g.fsf@email.froward.int.ebiederm.org>;;;hst=in02.mta.xmission.com;;;ip=68.227.174.4;;;frm=ebiederm@xmission.com;;;spf=neutral
X-XM-AID: U2FsdGVkX19OhTdzVxynesIxNteftIA9ltu6HIy+ils=
X-SA-Exim-Connect-IP: 68.227.174.4
X-SA-Exim-Mail-From: ebiederm@xmission.com
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-DCC: XMission; sa05 1397; Body=1 Fuz1=1 Fuz2=1 
X-Spam-Combo: *;Peter Zijlstra <peterz@infradead.org>
X-Spam-Relay-Country: 
X-Spam-Timing: total 823 ms - load_scoreonly_sql: 0.06 (0.0%),
        signal_user_changed: 13 (1.6%), b_tie_ro: 12 (1.4%), parse: 1.95
        (0.2%), extract_message_metadata: 22 (2.7%), get_uri_detail_list: 7
        (0.8%), tests_pri_-1000: 17 (2.0%), tests_pri_-950: 1.58 (0.2%),
        tests_pri_-900: 1.29 (0.2%), tests_pri_-90: 158 (19.3%), check_bayes:
        151 (18.3%), b_tokenize: 21 (2.5%), b_tok_get_all: 13 (1.6%),
        b_comp_prob: 3.9 (0.5%), b_tok_touch_all: 109 (13.2%), b_finish: 1.17
        (0.1%), tests_pri_0: 589 (71.6%), check_dkim_signature: 0.86 (0.1%),
        check_dkim_adsp: 4.6 (0.6%), poll_dns_idle: 0.04 (0.0%), tests_pri_10:
        3.2 (0.4%), tests_pri_500: 9 (1.2%), rewrite_mail: 0.00 (0.0%)
Subject: Re: [PATCH v2] ptrace: fix ptrace vs tasklist_lock race on PREEMPT_RT.
X-SA-Exim-Version: 4.2.1 (built Sat, 08 Feb 2020 21:53:50 +0000)
X-SA-Exim-Scanned: Yes (on in02.mta.xmission.com)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Peter Zijlstra <peterz@infradead.org> writes:

> On Tue, Apr 05, 2022 at 01:28:16PM +0200, Peter Zijlstra wrote:
>> On Tue, Apr 05, 2022 at 12:29:03PM +0200, Oleg Nesterov wrote:
>> > On 04/05, Peter Zijlstra wrote:
>> > >
>> > > As is, I think we can write task_is_stopped() like:
>> > >
>> > > #define task_is_stopped(task)	((task)->jobctl & JOBCTL_STOP_PENDING)
>> > >
>> > > Because jobctl is in fact the canonical state.
>> > 
>> > Not really. JOBCTL_STOP_PENDING means that the task should stop.
>> > 
>> > And this flag is cleared right before set_special_state(TASK_STOPPED)
>> > in do_signal_stop(), see task_participate_group_stop().
>> 
>> Argh! More work then :-( Still, I really want to not have p->__state be
>> actual unique state.
>
> How insane is this?
>
> In addition to solving the whole saved_state issue, it also allows my
> freezer rewrite to reconstruct __state. If you don't find the below
> fundamentally broken I can respin that freezer rewrite on top of it.

I am confused about what everyone is trying to fix here.
So I can't comment right on the fundamentals except to see
it looks like more code and more complexity which could be a problem.

If this actually solves the fundamental issue we need to coordinate
because I am just about to allocate jobctl bit 31 for JOBCTL_WILL_EXIT
to implement fatal_signal_pending.  Among other things that allows
to not have two meanings for SIGKILL in task->pending.

There are also some interesting interactions between some of these
states and processes that have fatal_signal_pending that I should
look at as well.

I can say that I recently looked and signal_wake_up_state is
consistently called with siglock held.

Eric


>
> ---
>  include/linux/sched.h        |  8 +++-----
>  include/linux/sched/jobctl.h |  8 ++++++++
>  include/linux/sched/signal.h | 15 ++++++++++++++-
>  kernel/ptrace.c              | 18 ++++++++++++++----
>  kernel/signal.c              |  9 ++++++---
>  5 files changed, 45 insertions(+), 13 deletions(-)
>
> diff --git a/include/linux/sched.h b/include/linux/sched.h
> index 67f06f72c50e..6698b97b8e3b 100644
> --- a/include/linux/sched.h
> +++ b/include/linux/sched.h
> @@ -118,11 +118,9 @@ struct task_group;
>  
>  #define task_is_running(task)		(READ_ONCE((task)->__state) == TASK_RUNNING)
>  
> -#define task_is_traced(task)		((READ_ONCE(task->__state) & __TASK_TRACED) != 0)
> -
> -#define task_is_stopped(task)		((READ_ONCE(task->__state) & __TASK_STOPPED) != 0)
> -
> -#define task_is_stopped_or_traced(task)	((READ_ONCE(task->__state) & (__TASK_STOPPED | __TASK_TRACED)) != 0)
> +#define task_is_traced(task)		((READ_ONCE(task->jobctl) & JOBCTL_TRACED) != 0)
> +#define task_is_stopped(task)		((READ_ONCE(task->jobctl) & JOBCTL_STOPPED) != 0)
> +#define task_is_stopped_or_traced(task)	((READ_ONCE(task->jobctl) & (JOBCTL_STOPPED | JOBCTL_TRACED)) != 0)
>  
>  /*
>   * Special states are those that do not use the normal wait-loop pattern. See
> diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
> index fa067de9f1a9..ec8b312f7506 100644
> --- a/include/linux/sched/jobctl.h
> +++ b/include/linux/sched/jobctl.h
> @@ -20,6 +20,10 @@ struct task_struct;
>  #define JOBCTL_LISTENING_BIT	22	/* ptracer is listening for events */
>  #define JOBCTL_TRAP_FREEZE_BIT	23	/* trap for cgroup freezer */
>  
> +#define JOBCTL_STOPPED_BIT	24
> +#define JOBCTL_TRACED_BIT	25
> +#define JOBCTL_TRACED_FROZEN_BIT 26
> +
>  #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
>  #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
>  #define JOBCTL_STOP_CONSUME	(1UL << JOBCTL_STOP_CONSUME_BIT)
> @@ -29,6 +33,10 @@ struct task_struct;
>  #define JOBCTL_LISTENING	(1UL << JOBCTL_LISTENING_BIT)
>  #define JOBCTL_TRAP_FREEZE	(1UL << JOBCTL_TRAP_FREEZE_BIT)
>  
> +#define JOBCTL_STOPPED		(1UL << JOBCTL_STOPPED_BIT)
> +#define JOBCTL_TRACED		(1UL << JOBCTL_TRACED_BIT)
> +#define JOBCTL_TRACED_FROZEN	(1UL << JOBCTL_TRACED_FROZEN_BIT)
> +
>  #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
>  #define JOBCTL_PENDING_MASK	(JOBCTL_STOP_PENDING | JOBCTL_TRAP_MASK)
>  
> diff --git a/include/linux/sched/signal.h b/include/linux/sched/signal.h
> index 3c8b34876744..3e4a14ed402e 100644
> --- a/include/linux/sched/signal.h
> +++ b/include/linux/sched/signal.h
> @@ -294,8 +294,10 @@ static inline int kernel_dequeue_signal(void)
>  static inline void kernel_signal_stop(void)
>  {
>  	spin_lock_irq(&current->sighand->siglock);
> -	if (current->jobctl & JOBCTL_STOP_DEQUEUED)
> +	if (current->jobctl & JOBCTL_STOP_DEQUEUED) {
> +		current->jobctl |= JOBCTL_STOPPED;
>  		set_special_state(TASK_STOPPED);
> +	}
>  	spin_unlock_irq(&current->sighand->siglock);
>  
>  	schedule();
> @@ -437,10 +439,21 @@ extern void signal_wake_up_state(struct task_struct *t, unsigned int state);
>  
>  static inline void signal_wake_up(struct task_struct *t, bool resume)
>  {
> +	lockdep_assert_held(t->sighand->siglock);
> +
> +	if (resume && !(t->jobctl & JOBCTL_TRACED_FROZEN))
> +		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
> +
>  	signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
>  }
> +
>  static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
>  {
> +	lockdep_assert_held(t->sighand->siglock);
> +
> +	if (resume)
> +		t->jobctl &= ~JOBCTL_TRACED;
> +
>  	signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
>  }
>  
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index ccc4b465775b..626f96d275c7 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -185,7 +185,12 @@ static bool looks_like_a_spurious_pid(struct task_struct *task)
>  	return true;
>  }
>  
> -/* Ensure that nothing can wake it up, even SIGKILL */
> +/*
> + * Ensure that nothing can wake it up, even SIGKILL
> + *
> + * A task is switched to this state while a ptrace operation is in progress;
> + * such that the ptrace operation is uninterruptible.
> + */
>  static bool ptrace_freeze_traced(struct task_struct *task)
>  {
>  	bool ret = false;
> @@ -197,6 +202,7 @@ static bool ptrace_freeze_traced(struct task_struct *task)
>  	spin_lock_irq(&task->sighand->siglock);
>  	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
>  	    !__fatal_signal_pending(task)) {
> +		task->jobctl |= JOBCTL_TRACED_FROZEN;
>  		WRITE_ONCE(task->__state, __TASK_TRACED);
>  		ret = true;
>  	}
> @@ -218,9 +224,11 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>  	 */
>  	spin_lock_irq(&task->sighand->siglock);
>  	if (READ_ONCE(task->__state) == __TASK_TRACED) {
> -		if (__fatal_signal_pending(task))
> +		task->jobctl &= ~JOBCTL_TRACED_FROZEN;
> +		if (__fatal_signal_pending(task)) {
> +			task->jobctl &= ~JOBCTL_TRACED;
>  			wake_up_state(task, __TASK_TRACED);
> -		else
> +		} else
>  			WRITE_ONCE(task->__state, TASK_TRACED);
>  	}
>  	spin_unlock_irq(&task->sighand->siglock);
> @@ -475,8 +483,10 @@ static int ptrace_attach(struct task_struct *task, long request,
>  	 * in and out of STOPPED are protected by siglock.
>  	 */
>  	if (task_is_stopped(task) &&
> -	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING))
> +	    task_set_jobctl_pending(task, JOBCTL_TRAP_STOP | JOBCTL_TRAPPING)) {
> +		task->jobctl &= ~JOBCTL_STOPPED;
>  		signal_wake_up_state(task, __TASK_STOPPED);
> +	}
>  
>  	spin_unlock(&task->sighand->siglock);
>  
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 30cd1ca43bcd..0aea3f0a8002 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -884,7 +884,7 @@ static int check_kill_permission(int sig, struct kernel_siginfo *info,
>  static void ptrace_trap_notify(struct task_struct *t)
>  {
>  	WARN_ON_ONCE(!(t->ptrace & PT_SEIZED));
> -	assert_spin_locked(&t->sighand->siglock);
> +	lockdep_assert_held(&t->sighand->siglock);
>  
>  	task_set_jobctl_pending(t, JOBCTL_TRAP_NOTIFY);
>  	ptrace_signal_wake_up(t, t->jobctl & JOBCTL_LISTENING);
> @@ -930,9 +930,10 @@ static bool prepare_signal(int sig, struct task_struct *p, bool force)
>  		for_each_thread(p, t) {
>  			flush_sigqueue_mask(&flush, &t->pending);
>  			task_clear_jobctl_pending(t, JOBCTL_STOP_PENDING);
> -			if (likely(!(t->ptrace & PT_SEIZED)))
> +			if (likely(!(t->ptrace & PT_SEIZED))) {
> +				t->jobctl &= ~JOBCTL_STOPPED;
>  				wake_up_state(t, __TASK_STOPPED);
> -			else
> +			} else
>  				ptrace_trap_notify(t);
>  		}
>  
> @@ -2219,6 +2220,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>  	 * schedule() will not sleep if there is a pending signal that
>  	 * can awaken the task.
>  	 */
> +	current->jobctl |= JOBCTL_TRACED;
>  	set_special_state(TASK_TRACED);
>  
>  	/*
> @@ -2460,6 +2462,7 @@ static bool do_signal_stop(int signr)
>  		if (task_participate_group_stop(current))
>  			notify = CLD_STOPPED;
>  
> +		current->jobctl |= JOBCTL_STOPPED;
>  		set_special_state(TASK_STOPPED);
>  		spin_unlock_irq(&current->sighand->siglock);
>  
