Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18A484F91E9
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 11:19:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234191AbiDHJSB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 05:18:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233576AbiDHJMs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 05:12:48 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 58BC224E27C
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 02:09:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=VjUH0pYzMdFii4c6pMc1pUqcDA517z1/pp9WOhE6teA=; b=gkj2jFtNecjnBH2NZx8bYdxmwx
        EqvrA1LivuRsg2F16Kd3LpEzlc6tX52iGKdfJiNn4sAnMpa+iIfwPrtDFLJG27pFoB8MBtroRfEGQ
        1Zerb0TAa+eZEiJJoDJaRmF+vqTob8Yr6UIxcPRHQ5QuKwloXVWNNF0PL6a5gh8x5X2+gDGwIps8A
        O6geVUi14Kw83ubrwvRS28wDmnNggM+wleMorbunPFnGSCPdWnCXIMITXYPueU+DW6P3RX3Gu+7xW
        wWgQZqJNxZCjwHxH0G8z4WUsiGouWo7PTD7k/wajERrG/aL8dWyVhRCYJBP3J7Xfz+a6ohdkagbrG
        +nNwpOtw==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nckcA-002r42-BO; Fri, 08 Apr 2022 09:09:11 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 386729862CF; Fri,  8 Apr 2022 11:09:08 +0200 (CEST)
Date:   Fri, 8 Apr 2022 11:09:08 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     "Eric W. Biederman" <ebiederm@xmission.com>
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
Subject: Re: [PATCH v2] ptrace: fix ptrace vs tasklist_lock race on
 PREEMPT_RT.
Message-ID: <20220408090908.GO2731@worktop.programming.kicks-ass.net>
References: <Yh/b19JikC+Vnm8i@linutronix.de>
 <20220314185429.GA30364@redhat.com>
 <YjBO8yzxdmjTGNiy@linutronix.de>
 <20220315142944.GA22670@redhat.com>
 <YkW55u6u2fo5QmV7@linutronix.de>
 <20220405101026.GB34954@worktop.programming.kicks-ass.net>
 <20220405102849.GA2708@redhat.com>
 <Ykwn0MpcrZ/N+LOG@hirez.programming.kicks-ass.net>
 <20220407121340.GA2762@worktop.programming.kicks-ass.net>
 <87v8vk8q4g.fsf@email.froward.int.ebiederm.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8vk8q4g.fsf@email.froward.int.ebiederm.org>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 05:50:39PM -0500, Eric W. Biederman wrote:
> Peter Zijlstra <peterz@infradead.org> writes:
> 
> > On Tue, Apr 05, 2022 at 01:28:16PM +0200, Peter Zijlstra wrote:
> >> On Tue, Apr 05, 2022 at 12:29:03PM +0200, Oleg Nesterov wrote:
> >> > On 04/05, Peter Zijlstra wrote:
> >> > >
> >> > > As is, I think we can write task_is_stopped() like:
> >> > >
> >> > > #define task_is_stopped(task)	((task)->jobctl & JOBCTL_STOP_PENDING)
> >> > >
> >> > > Because jobctl is in fact the canonical state.
> >> > 
> >> > Not really. JOBCTL_STOP_PENDING means that the task should stop.
> >> > 
> >> > And this flag is cleared right before set_special_state(TASK_STOPPED)
> >> > in do_signal_stop(), see task_participate_group_stop().
> >> 
> >> Argh! More work then :-( Still, I really want to not have p->__state be
> >> actual unique state.
> >
> > How insane is this?
> >
> > In addition to solving the whole saved_state issue, it also allows my
> > freezer rewrite to reconstruct __state. If you don't find the below
> > fundamentally broken I can respin that freezer rewrite on top of it.
> 
> Let me see if I can describe what is going on.  Commit 5f220be21418
> ("sched/wakeup: Prepare for RT sleeping spin/rwlocks") is buggy because
> it fundamentally depends upon the assumption that only the current
> process will change task->state.  That assumption breaks ptrace_attach.

Right -- although I'll be arguing ptrace does some rather dodgy things
:-)

> Given that wake_up_state and wake_up_process fundamentally violate that
> assumption I am not at all certain it makes sense to try and fix the
> broken commit.  I think the assumption is that it is fine to ignore
> wake_up_state and wake_up_process and their wake_ups because the process
> will wake up eventually.
> 
> Is it possible to simply take pi_lock around what ptrace does and fix
> ptrace that way?

Sorta, see below, but there's an additional problem where I want to
rewrite the freezer to be a special task state. That is, replace:

	freezer_do_not_count();
	for (;;) {
		set_current_state(state);
		if (cond)
			break;
		schedule();
	}
	__set_current_state(RUNNING);
	freezer_count();

with:

	for (;;) {
		set_current_state(state|TASK_FREEZABLE);
		if (cond)
			break;
		schedule()
	}
	__set_current_state(RUNNING);

And have the freezer do (with pi_lock held):

+static int __set_task_frozen(struct task_struct *p, void *arg)
+{
+	unsigned int state = READ_ONCE(p->__state);
+
+	if (!(state & (TASK_FREEZABLE | __TASK_STOPPED | __TASK_TRACED)))
+		return 0;
+
+	/*
+	 * Only TASK_NORMAL can be augmented with TASK_FREEZABLE, since they
+	 * can suffer spurious wakeups.
+	 */
+	if (state & TASK_FREEZABLE)
+		WARN_ON_ONCE(!(state & TASK_NORMAL));
+
+#ifdef CONFIG_LOCKDEP
+	/*
+	 * It's dangerous to freeze with locks held; there be dragons there.
+	 */
+	if (!(state & __TASK_FREEZABLE_UNSAFE))
+		WARN_ON_ONCE(debug_locks && p->lockdep_depth);
+#endif
+
+	WRITE_ONCE(p->__state, TASK_FROZEN);
+	return TASK_FROZEN;
+}

That is, for anything FREEZABLE, STOPPED or TRACED set FROZEN.

The reason is that currently there's all sorts of races between the
whole freezer_do_not_count(); schedule(); freezer_count(); and thawing
which allows a task to thaw before it really is time.

By moving all that to a special block state, all that insanity goes
away.

*HOWEVER* per the above STOPPED,TRACED->FROZEN transition, that state is
lost. Thawing needs to somehow recover that state if needed. With the
proposed patch, I can write (this time with sighand *and* pi_lock held):

+/*
+ * The special task states (TASK_STOPPED, TASK_TRACED) keep their canonical
+ * state in p->jobctl. If either of them got a wakeup that was missed because
+ * TASK_FROZEN, then their canonical state reflects that and the below will
+ * refuse to restore the special state and instead issue the wakeup.
+ */
+static int __set_task_special(struct task_struct *p, void *arg)
+{
+	unsigned int state = 0;
+
+	if (p->jobctl & JOBCTL_TRACED) {
+		state = __TASK_TRACED;
+
+		if (!(p->jobctl & JOBCTL_TRACED_FROZEN)) {
+			state |= TASK_WAKEKILL;
+			if (__fatal_signal_pending(p))
+				state = 0;
+		}
+
+	} else if ((p->jobctl & JOBCTL_STOPPED) &&
+		   !__fatal_signal_pending(p)) {
+
+		state = TASK_STOPPED;
+	}
+
+	if (state)
+		WRITE_ONCE(p->__state, state);
+
+	return state;
+}

So recover the special states and not have them experience spurious
wakeups.

So the proposed change moves the state into jobctl, such that:

 - task_is_{stopped,traced}() can look at jobctl and not need to worry
   about ->__state / ->saved_state etc.

 - task->__state can be recovered, it no longer contains unique state.

> Hmmm.
> 
> Your ptrace_stop does:
> 
> > +	current->jobctl |= JOBCTL_TRACED;
> >  	set_special_state(TASK_TRACED);
> 
> Your ptrace_freeze_traced does:
> >  	    !__fatal_signal_pending(task)) {
> > +		task->jobctl |= JOBCTL_TRACED_FROZEN;
> >  		WRITE_ONCE(task->__state, __TASK_TRACED);
> >  		ret = true;
> 
> At which point I say bleep!
> 
> Unless I am misreading something if ptrace_freeze_traced happens
> during read_lock(&tasklist_lock) task->__state will be changed
> from TASK_RTLOCK_WAIT to __TASK_TRACED.   Then when
> read_lock(&tasklist_lock) is acquired task->__state will be changed
> from __TASK_TRACED to TASK_TRACED.  Making it possible to send
> SIGKILL to a process that is being ptraced.  Introducing all kinds
> of unexpected races.

Correct, I 'forgot' about that part but have the below patch on top to
cure that. Mind you, it's not something I'm proud of, but it should
work.

> Given that fundamentally TASK_WAKEKILL must be added in ptrace_stop and
> removed in ptrace_attach I don't see your proposed usage of jobctl helps
> anything fundamental.
> 
> I suspect somewhere there is a deep trade-off between complicating
> the scheduler to have a very special case for what is now
> TASK_RTLOCK_WAIT, and complicating the rest of the code with having
> TASK_RTLOCK_WAIT in __state and the values that should be in state
> stored somewhere else.

The thing is; ptrace is a special case. I feel very strongly we should
not complicate the scheduler/wakeup path for something that 'never'
happens.

> Perhaps we should just remove task->saved_state and start all over from a
> clean drawing sheet?

We've not managed to come up with an alternative scheme for allowing
sleeping spinlocks and not wrecking many other things.


Anyway, let me finish this freezer rewrite thing and write more coherent
Changelogs on that :-)

~ Peter

---

Subject: sched,ptrace: Fix PREEMPT_RT vs TASK_TRACED
From: Peter Zijlstra <peterz@infradead.org>
Date: Thu Apr 7 16:38:16 CEST 2022

ptrace_{,un}freeze_traced() attempts a compare-and-change pattern on
a remote task->__state. The correctness of this scheme relies on
__TASK_TRACED being a special state and those having stability
guarantees.

Except... PREEMPT_RT has task->saved_state which 'temporarily' holds
the real task->__state while a spinlock_rt does TASK_RTLOCK_WAIT.

This means the remote compare-and-change pattern is busted in the face
of PREEMPT_RT.

Rework it so it is atomic vs state changes and takes task->saved_state
into account.

Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
---
 kernel/ptrace.c |   37 ++++++++++++++++++++++++++++++++-----
 1 file changed, 32 insertions(+), 5 deletions(-)

--- a/kernel/ptrace.c
+++ b/kernel/ptrace.c
@@ -185,6 +185,29 @@ static bool looks_like_a_spurious_pid(st
 	return true;
 }
 
+static inline bool __set_if(unsigned int *state, unsigned int mask, unsigned int new)
+{
+	if (*state & mask) {
+		WRITE_ONCE(*state, new);
+		return 1;
+	}
+
+	return 0;
+}
+
+static int __set_if_traced(struct task_struct *task, void *arg)
+{
+	unsigned int *state = arg;
+
+	__set_if(&task->__state, __TASK_TRACED, *state)
+#ifdef CONFIG_PREEMPT_RT
+		|| __set_if(&task->saved_state, __TASK_TRACED, *state)
+#endif
+		;
+
+	return 0;
+}
+
 /*
  * Ensure that nothing can wake it up, even SIGKILL
  *
@@ -202,8 +225,10 @@ static bool ptrace_freeze_traced(struct
 	spin_lock_irq(&task->sighand->siglock);
 	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
 	    !__fatal_signal_pending(task)) {
+		unsigned int state = __TASK_TRACED;
+
 		task->jobctl |= JOBCTL_TRACED_FROZEN;
-		WRITE_ONCE(task->__state, __TASK_TRACED);
+		task_call_func(task, __set_if_traced, &state);
 		ret = true;
 	}
 	spin_unlock_irq(&task->sighand->siglock);
@@ -213,7 +238,7 @@ static bool ptrace_freeze_traced(struct
 
 static void ptrace_unfreeze_traced(struct task_struct *task)
 {
-	if (READ_ONCE(task->__state) != __TASK_TRACED)
+	if (!task_is_traced(task))
 		return;
 
 	WARN_ON(!task->ptrace || task->parent != current);
@@ -223,13 +248,15 @@ static void ptrace_unfreeze_traced(struc
 	 * Recheck state under the lock to close this race.
 	 */
 	spin_lock_irq(&task->sighand->siglock);
-	if (READ_ONCE(task->__state) == __TASK_TRACED) {
+	if (task->jobctl & JOBCTL_TRACED_FROZEN) {
 		task->jobctl &= ~JOBCTL_TRACED_FROZEN;
 		if (__fatal_signal_pending(task)) {
 			task->jobctl &= ~JOBCTL_TRACED;
 			wake_up_state(task, __TASK_TRACED);
-		} else
-			WRITE_ONCE(task->__state, TASK_TRACED);
+		} else {
+			unsigned int state = TASK_TRACED;
+			task_call_func(task, __set_if_traced, &state);
+		}
 	}
 	spin_unlock_irq(&task->sighand->siglock);
 }
