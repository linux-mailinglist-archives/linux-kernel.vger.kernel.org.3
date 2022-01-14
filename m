Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1750B48EB4F
	for <lists+linux-kernel@lfdr.de>; Fri, 14 Jan 2022 15:10:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237452AbiANOKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 14 Jan 2022 09:10:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45492 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231331AbiANOKi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 14 Jan 2022 09:10:38 -0500
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BB14FC061574;
        Fri, 14 Jan 2022 06:10:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=00gnKZzNat2QdmQR8Oe1xgTfylUYzk2oj+Q2hjgiK+Y=; b=W/jjhKq3gAED8iYq2GUoPYlma5
        bD4Egg6Ado/KCN/dlsmOI2hKH0jz9losKIDaVgmzo4G/K/xnUNOGuqxnMROu/2Hd0Lq0qxtthR5Bn
        JZ02gHYtYaviEjAo7c2kS6vIJ9RQaKYGUqhVTHlgEfwpMDU7pvAGIybqBOEflOVmQyeptPP2n8pjb
        Nlo6L/G/jnaWW25g0JHYZ5dKBWydPn0O39BppGXKyPhqsvSwC1oLHYEImOJY0ynEWdQwShJiwbmcJ
        j4Mz5frMtfbA5NIkyH7OshdYKCDASvrmeY4Wi6wsDTKiT6SnZqjZzUEFVn1w4c2+WGiS6wYwNfr6o
        K64vkH4A==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n8NHC-0019ca-Lo; Fri, 14 Jan 2022 14:10:00 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id D982D3002C1;
        Fri, 14 Jan 2022 15:09:55 +0100 (CET)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 875452B323542; Fri, 14 Jan 2022 15:09:55 +0100 (CET)
Date:   Fri, 14 Jan 2022 15:09:55 +0100
From:   Peter Zijlstra <peterz@infradead.org>
To:     Peter Oskolkov <posk@posk.io>
Cc:     mingo@redhat.com, tglx@linutronix.de, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, linux-api@vger.kernel.org, x86@kernel.org,
        pjt@google.com, posk@google.com, avagin@google.com,
        jannh@google.com, tdelisle@uwaterloo.ca
Subject: Re: [RFC][PATCH 3/3] sched: User Mode Concurency Groups
Message-ID: <YeGEM7TP3tekBVEh@hirez.programming.kicks-ass.net>
References: <20211214204445.665580974@infradead.org>
 <20211214205358.701701555@infradead.org>
 <20211221171900.GA580323@dev-hv>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211221171900.GA580323@dev-hv>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


Hi!

I've seen you send a new version based on this, but I figured I ought to
reply to this first.

On Tue, Dec 21, 2021 at 05:19:00PM +0000, Peter Oskolkov wrote:

> > +/* pre-schedule() */
> > +void umcg_wq_worker_sleeping(struct task_struct *tsk)
> > +{
> > +	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
> > +
> > +	/* Must not fault, mmap_sem might be held. */
> > +	pagefault_disable();
> > +
> > +	if (WARN_ON_ONCE(!tsk->umcg_server))
> > +		UMCG_DIE_PF("no server");
> 
> We can get here if a running worker (no pinned pages) gets a pagefault
> in the userspace. Is umcg_sys_enter() called for pagefaults? If not,
> we should not kill the worker; also the userspace won't be able to
> detect this worker blocking on a pagefault...

Ufff.. good one. No #PF doesn't pass through sys_enter, I'll have to go
fix that.

> Why don't you like my approach of pinning pages on exit_to_userspace
> and unpinning on going to sleep? Yes, the pins will last longer,
> but only for scheduled on CPU tasks, so bounded both by time and number
> (of course, if umcg_sys_enter() is called on pagefaults/signals/other
> interrupts, pinning in umcg_sys_enter() is better).

Well, in general I would not call userspace bounded. There's plenty
userspace that doesn't do syscalls for indeterminate amounts of time.
Now, such userspace might not be the immediate target for UMCG, but we
also should not rule it out.

Having been an mm/ developer in a previous lifetime, I still think
page-pins should be as short as possible. They can get in the way of
other things, like CMA.

> On the other hand, doing nothing on pagefaults and similar, and having
> to only worry about blocking in syscalls, does make things much simpler
> (no unexpected concurrency and such). I think most of the things
> you found complicated in my patchset, other than the SMP remote-idle wakeup,
> were driven by making sure spurious pagefaults are properly handled.
> 
> I can't tell now whether keeping workers RUNNING during pagefaults
> vs waking their servers to run pending workers is a net gain or loss
> re: performance. I'll have to benchmark this when my large test is ready.

I'll go fix the non syscall things that can schedule.

> > +int umcg_wait(u64 timo)
> > +{
> > +	struct task_struct *tsk = current;
> > +	struct umcg_task __user *self = tsk->umcg_task;
> > +	struct page *page = NULL;
> > +	u32 state;
> > +	int ret;
> > +
> > +	for (;;) {
> > +		set_current_state(TASK_INTERRUPTIBLE);
> > +
> > +		ret = -EINTR;
> > +		if (signal_pending(current))
> > +			break;
> > +
> > +		/*
> > +		 * Faults can block and scribble our wait state.
> > +		 */
> > +		pagefault_disable();
> > +		if (get_user(state, &self->state)) {
> > +			pagefault_enable();
> > +
> > +			ret = -EFAULT;
> > +			if (page) {
> > +				unpin_user_page(page);
> > +				page = NULL;
> > +				break;
> > +			}
> > +
> > +			if (pin_user_pages_fast((unsigned long)self, 1, 0, &page) != 1) {
> 
> I believe that the task should not be TASK_INTERRUPTIBLE here,
> as pin_user_pages_fast may fault, and might_fault complains via __might_sleep.

Fair enough; can easily mark the task __set_current_state(TASK_RUNNING)
right near pagefault_enable() or something.

> > +				page = NULL;
> > +				break;
> > +			}
> > +
> > +			continue;
> > +		}

> > +void umcg_sys_exit(struct pt_regs *regs)
> > +{
> > +	struct task_struct *tsk = current;
> > +	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
> > +	long syscall = syscall_get_nr(tsk, regs);
> > +
> > +	if (syscall == __NR_umcg_wait)
> > +		return;
> > +
> > +	/*
> > +	 * sys_umcg_ctl() will get here without having called umcg_sys_enter()
> > +	 * as such it will look like a syscall that blocked.
> > +	 */
> > +
> > +	if (tsk->umcg_server) {
> > +		/*
> > +		 * Didn't block, we done.
> > +		 */
> > +		umcg_unpin_pages();
> > +		return;
> > +	}
> > +
> > +	/* avoid recursion vs schedule() */
> > +	current->flags &= ~PF_UMCG_WORKER;
> > +
> > +	if (umcg_pin_pages())
> > +		UMCG_DIE("pin");
> > +
> > +	if (umcg_update_state(tsk, self, UMCG_TASK_BLOCKED, UMCG_TASK_RUNNABLE))
> > +		UMCG_DIE_UNPIN("state");
> > +
> > +	if (umcg_enqueue_runnable(tsk))
> > +		UMCG_DIE_UNPIN("enqueue");
> > +
> > +	/* Server might not be RUNNABLE, means it's already running */
> > +	if (umcg_wake_server(tsk))
> > +		UMCG_DIE_UNPIN("wake-server");
> 
> So this here breaks the assumption that servers+workers never run
> on more CPUs than the number of servers, which I've gone through
> a lot of pain to ensure in my patchset.

Yes, but you also completely wrecked signals afaict. But yes, this
preemption thing also causes that, which is why I proposed that LAZY
crud earlier, but I never got that in a shape I was happy with -- it
quickly becomes a mess :/

> I think the assumption is based on the idea that a process
> using UMCG will get affined to N CPUs, will have N servers and
> a number of workers, and they will all happily cooperate and not
> get any extra threads running.
> 
> Of course the pretty picture was not completely true, as the unblocked
> tasks do consume extra threads in the kernel, though never in the
> userspace.

Right, there is some unmanaged time anyway.

> So this patch may result in all servers running due to wakeups
> in umcg_sys_exit(), with also their currently designated workers
> running as well, so the userspace may see N+N running threads.

I think this was already true, the servers could be running and all
workers could be woken from their in-kernel slumber, entering unmamanged
time, seeing N+M running tasks as worst possible case.

But yes, the 2N case is more common now.

> For now I think this may be OK, but as I mentioned above, I need to
> run a larger test with a real workload to see if anything is missing.
> 
> What does worry me is that in this wakeup the server calls sys_umcg_wait()
> with another worker in next_tid, so now the server will have two
> workers running: the current kernel API seems to allow this to happen.
> In my patchset the invariant that no more than one worker running
> per server was enforced by the kernel.

So one of the things I've started, but didn't finished, is to forward
port the Proxy-Execution patches to a current kernel and play with the
PE+UMCG interaction.

Thinking about that interaction I've ran into that exact problem.

The 'nice' solution is to actually block the worker, but that's also the
slow solution :/

The other solution seems to be to keep kernel state; track the current
worker associated with the server. I haven't (so far) done that due to
my futex trauma.

So yes, the current API can be used to do the wrong thing, but the
kernel doesn't care and you get to keep the pieces in userspace. And I
much prefer user pieces over kernel pieces.

> > +
> > +	umcg_unpin_pages();
> > +
> > +	switch (umcg_wait(0)) {
> > +	case -EFAULT:
> > +	case -EINVAL:
> > +	case -ETIMEDOUT: /* how!?! */
> > +	default:
> 
> This "default" coming before "case 0" below feels weird... can we do
> 
> 	switch (umcg_wait()) {
> 	case 0:
> 	case -EINTR:
> 		/* ... */
> 		break;
> 	default:
> 		UMCG_DIE("wait");
> 	}

Sure.

> > +		/*
> > +		 * XXX do we want a preemption consuming ::next_tid ?
> > +		 * I'm currently leaning towards no.
> 
> I don't think so: preemption is a sched-type event, so a server
> should handle it; next_tid has nothing to do with it.

We agree, I'll update the comment.

> > +SYSCALL_DEFINE2(umcg_wait, u32, flags, u64, timo)
> > +{
> > +	struct task_struct *tsk = current;
> > +	struct umcg_task __user *self = READ_ONCE(tsk->umcg_task);
> > +	bool worker = tsk->flags & PF_UMCG_WORKER;
> > +	int ret;
> > +
> > +	if (!self || flags)
> > +		return -EINVAL;
> > +
> > +	if (worker) {
> > +		tsk->flags &= ~PF_UMCG_WORKER;
> > +		if (timo)
> > +			return -ERANGE;
> 
> Worker sleeps timing out is a valid and a real use case. Similar
> to futex timeouts, mutex timeouts, condvar timeouts. I do not believe
> there is a fundamental problem here, so I'll add worker timeout
> handling in my larger test.

I don't understand worker timeout, also see:

  https://lkml.kernel.org/r/Ya34S2JCQg+81h4t@hirez.programming.kicks-ass.net

> In addition, shouldn't we NOT clear PF_UMCG_WORKER flag if we
> return an error?

Why? Userspace can do umcg_ctl() if they want, no?

> > +	}
> > +
> > +	/* see umcg_sys_{enter,exit}() syscall exceptions */
> > +	ret = umcg_pin_pages();
> 
> I do not think we need to pin pages for servers, only for workers. Yes,
> this makes things easier/simpler, so ok for now, but maybe later we will
> need to be a bit more fine-grained here.

Right.

> > +	if (ret)
> > +		goto unblock;
> > +
> > +	/*
> > +	 * Clear UMCG_TF_COND_WAIT *and* check state == RUNNABLE.
> > +	 */
> > +	ret = umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNABLE);
> > +	if (ret)
> > +		goto unpin;
> > +
> > +	if (worker) {
> > +		ret = umcg_enqueue_runnable(tsk);
> > +		if (ret)
> > +			goto unpin;
> > +	}
> > +
> > +	if (worker)
> 
> Should this "if" be merged with the one above?

Yes, I think I've done that at least once, but clearly it didn't stick.

Ah, here it is:

  https://lkml.kernel.org/r/Ybm+HJzkO%2F0BB4Va@hirez.programming.kicks-ass.net

but since that LAZY thing didn't live that cleanup seems to have gone
out the window too.

> > +		ret = umcg_wake(tsk);
> > +	else if (tsk->umcg_next)
> > +		ret = umcg_wake_next(tsk);
> > +
> > +	if (ret) {
> > +		/*
> > +		 * XXX already enqueued ourself on ::server_tid; failing now
> > +		 * leaves the lot in an inconsistent state since it'll also
> > +		 * unblock self in order to return the error. !?!?
> > +		 */
> 
> It looks like only EFAULT can be here. I'd ensure that, and then just DIE.

Can also be -EAGAIN if the target task isn't in an expected state.

I also wanted to avoid DIE from the syscalls(). DIE really isn't nice,
we shouldn't do it if it can be avoided.

> > +		goto unpin;
> > +	}
> > +
> > +	umcg_unpin_pages();
> > +
> > +	ret = umcg_wait(timo);
> > +	switch (ret) {
> > +	case 0:		/* all done */
> > +	case -EINTR:	/* umcg_notify_resume() will continue the wait */
> > +		ret = 0;
> > +		break;
> 
> Why not let workers have timeouts, and keep -ETIMEDOUT here? Just set
> UMCG_TF_PREEMPT, or another flag with similar behavior, and
> umcg_notify_resume will properly wake the server?

I really don't understand timeouts on workers, see above.

TF_PREEMPT must only be set on RUNNING, but if we're in wait, we're
RUNNABLE.

> > +
> > +	default:
> > +		goto unblock;
> > +	}
> > +out:
> > +	if (worker)
> > +		tsk->flags |= PF_UMCG_WORKER;
> > +	return ret;
> > +
> > +unpin:
> > +	umcg_unpin_pages();
> > +unblock:
> > +	/*
> > +	 * Workers will still block in umcg_notify_resume() before they can
> > +	 * consume their error, servers however need to get the error asap.
> > +	 *
> > +	 * Still, things might be unrecoverably screwy after this. Not our
> > +	 * problem.
> 
> I think we should explicitly document the unrecoverable screwiness
> of errors here, so that the userspace proactively kills itself
> to avoid badness. The only reason that returning an error here is
> mildly preferable to just killing the task (we already do that
> in other places) is to give the userspace an opportunity to
> log an error, with more state/info than we can do here.

Bah, I should've written a better comment, because I can't quite
remember the case I had in mind. Also, again from the LAZY patch, I
think we can actually do better in some of the cases here.

Specifically, currently we'll enqueue on ::runnable_workers_ptr and fail
waking ::next_tid and leave it at that. While I think waking
::server_tid in that case makes sense.

I'll go prod at this.

> > +	 */
> > +	if (!worker)
> > +		umcg_update_state(tsk, self, UMCG_TASK_RUNNABLE, UMCG_TASK_RUNNING);
> > +	goto out;
> > +}
> > +
> > +/**
> > + * sys_umcg_ctl: (un)register the current task as a UMCG task.
> > + * @flags:       ORed values from enum umcg_ctl_flag; see below;
> > + * @self:        a pointer to struct umcg_task that describes this
> > + *               task and governs the behavior of sys_umcg_wait if
> > + *               registering; must be NULL if unregistering.
> 
> @which_clock is not documented. Why do we need the option in the first
> place?

Well, you had CLOCK_REALTIME, which I think is quite daft, but Thomas
also wanted CLOCK_TAI, so here we are.

I'll add the comment.

> > +SYSCALL_DEFINE3(umcg_ctl, u32, flags, struct umcg_task __user *, self, clockid_t, which_clock)
> > +{
> > +	struct task_struct *server;
> > +	struct umcg_task ut;
> > +
> > +	if ((unsigned long)self % UMCG_TASK_ALIGN)
> > +		return -EINVAL;
> > +
> > +	if (flags & ~(UMCG_CTL_REGISTER |
> > +		      UMCG_CTL_UNREGISTER |
> > +		      UMCG_CTL_WORKER))
> > +		return -EINVAL;
> > +
> > +	if (flags == UMCG_CTL_UNREGISTER) {
> > +		if (self || !current->umcg_task)
> > +			return -EINVAL;
> > +
> > +		if (current->flags & PF_UMCG_WORKER)
> > +			umcg_worker_exit();
> 
> The server should be woken here. Imagine: one server, one worker.
> The server is sleeping, the worker is running. The worker unregisters,
> the server keeps sleeping forever?
> 
> I'm OK re: NOT waking the server if the worker thread exits without
> unregistering, as this is the userspace breaking the contract/protocol.
> But here we do need to notify the server. At the minimum so that the
> server can schedule a worker to run in its place.
> 
> (Why is this important? Worker count can fluctuate considerably:
> on load spikes many new workers may be created, and later in
> quiet times they exit to free resources.)

Fair enough. Will do.

> > +	if (flags == UMCG_CTL_WORKER) {
> > +		if ((ut.state & (UMCG_TASK_MASK | UMCG_TF_MASK)) != UMCG_TASK_BLOCKED)
> > +			return -EINVAL;
> > +
> > +		WRITE_ONCE(current->umcg_task, self);
> > +		current->flags |= PF_UMCG_WORKER;	/* hook schedule() */
> > +		set_syscall_work(SYSCALL_UMCG);		/* hook syscall */
> > +		set_thread_flag(TIF_UMCG);		/* hook return-to-user */
> 
> Too many flags, I'd say. Not a big deal, just a mild preference:
> I have only a single flag.

Yeah, you overloaded TIF_NOTIFY_RESUME, I prefer an explicit flag. And
the syscall things already have their own flag word, so that simply
needs another one.

> > +
> > +		/* umcg_sys_exit() will transition to RUNNABLE and wait */
> > +
> > +	} else {
> > +		if ((ut.state & (UMCG_TASK_MASK | UMCG_TF_MASK)) != UMCG_TASK_RUNNING)
> > +			return -EINVAL;
> > +
> > +		WRITE_ONCE(current->umcg_task, self);
> > +		set_thread_flag(TIF_UMCG);		/* hook return-to-user */
> 
> Why do we need to hook server's return to user? I did not need it in my
> version.

Signals; server could be blocked in sys_umcg_wait() and get a signal,
then we should resume waiting after the signal.

I hate signals as much as the next guy, but we gotta do something with
them.

Anyway, let me go poke at this code again..
