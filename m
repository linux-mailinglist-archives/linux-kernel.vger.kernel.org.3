Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CBCC502951
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 14:01:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352906AbiDOMDb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 08:03:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34388 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353096AbiDOMDP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 08:03:15 -0400
Received: from desiato.infradead.org (desiato.infradead.org [IPv6:2001:8b0:10b:1:d65d:64ff:fe57:4e05])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A296619B;
        Fri, 15 Apr 2022 05:00:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=desiato.20200630; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SG977EC0hrWla+V9GLRCJtr95Qc5uycAYkjvc3GtVYs=; b=gW/LXUM8Ny1EC6oNtDEzBmL55S
        gGHe0yVse6JJ59P9/H7xY8pEAxWN68bpbu0aVMvxc7CjhyCG8HCSZFh1NV7dpKPVrScW0Hc9qKeA8
        kJUAL3c/0A5RFb9KFednTzji0K+zyDDcno546KlaD8kTA0+W1bTCf5ZnOIjNJ6lu9BmgtXBFEKllr
        vlrhKIV5Y8cM4YqPzAKMtrZI/7/6HDYpbmhVcTSmd2cuH68N3BGLpiHErEh4tg3xLpqYQu9pXa47l
        k1Ec7teTLrRnC42t27Nzj3nYLGA2SFipB5oAX0ZeSY5eFk5l3MT5XtXPLlMDJ0Mn0c7XoSt26bIWI
        +HhGxnzg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by desiato.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nfKcb-005NB7-Ae; Fri, 15 Apr 2022 12:00:17 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits))
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 3EA5E3001AD;
        Fri, 15 Apr 2022 14:00:15 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 2185A30A47DFC; Fri, 15 Apr 2022 14:00:15 +0200 (CEST)
Date:   Fri, 15 Apr 2022 14:00:15 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <YlleTwxqx4keRYd4@hirez.programming.kicks-ass.net>
References: <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
 <20220415101644.GA10421@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220415101644.GA10421@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 15, 2022 at 12:16:44PM +0200, Oleg Nesterov wrote:
> On 04/15, Peter Zijlstra wrote:
> >
> > On Thu, Apr 14, 2022 at 08:34:33PM +0200, Oleg Nesterov wrote:
> >
> > > If it can work, then 1/5 needs some changes, I think. In particular,
> > > it should not introduce JOBCTL_TRACED_FROZEN until 5/5, and perhaps
> >
> > That TRACED_FROZEN was to distinguish the TASK_TRACED and __TASK_TRACED
> > state, and isn't related to the freezer.
> 
> Lets forget about 3-5 which I didn't read carefully yet. So why do we
> need TRACED_FROZEN?

The purpose of 1/5 was to not have any unique state in __state. To at
all times be able to reconstruct __state from outside information (where
needed).

Agreed that this particular piece of state isn't needed until 5/5, but
the concept is independent (also 5/5 is insanely large already).

> From 1/5:
> 
> 	 static inline void signal_wake_up(struct task_struct *t, bool resume)
> 	 {
> 	+	lockdep_assert_held(&t->sighand->siglock);
> 	+
> 	+	if (resume && !(t->jobctl & JOBCTL_TRACED_FROZEN))
> 	+		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
> 	+
> 		signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
> 	 }
> 	+
> 	 static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
> 	 {
> 	+	lockdep_assert_held(&t->sighand->siglock);
> 	+
> 	+	if (resume)
> 	+		t->jobctl &= ~JOBCTL_TRACED;
> 	+
> 		signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
> 	 }
> 
> Can't we simply change signal_wake_up_state(),
> 
> 	void signal_wake_up_state(struct task_struct *t, unsigned int state)
> 	{
> 		set_tsk_thread_flag(t, TIF_SIGPENDING);
> 		/*
> 		 * TASK_WAKEKILL also means wake it up in the stopped/traced/killable
> 		 * case. We don't check t->state here because there is a race with it
> 		 * executing another processor and just now entering stopped state.
> 		 * By using wake_up_state, we ensure the process will wake up and
> 		 * handle its death signal.
> 		 */
> 		if (wake_up_state(t, state | TASK_INTERRUPTIBLE))
> 			t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
> 		else
> 			kick_process(t);
> 	}
> 
> ?

This would be broken when we so signal_wake_up_state() when state
doesn't match. Does that happen? I'm thikning siglock protects us from
the most obvious races, but still.

If not broken, then it needs at least a comment explaining why not etc..
I'm sure to not remember many of these details.

Also, signal_wake_up_state() really can do with that
lockdep_assert_held() as well ;-)

> > > 		/*
> > > 		 * We take the read lock around doing both checks to close a
> > > 		 * possible race where someone else attaches or detaches our
> > > 		 * natural child.
> > > 		 */
> > > 		read_lock(&tasklist_lock);
> > > 		traced = child->ptrace && child->parent == current;
> > > 		read_unlock(&tasklist_lock);
> > >
> > > 		if (!traced)
> > > 			return -ESRCH;
> >
> > The thing being, that if it is our ptrace child, it won't be going away
> > since we're running this code and not ptrace_detach().  Right?
> 
> Yes. and nobody else can detach it.
> 
> Another tracer can't attach until child->ptrace is cleared, but this can
> only happen if a) this child is killed and b) another thread does wait()
> and reaps it; but after that attach() is obviously impossible.
> 
> But since this child can go away, the patch changes ptrace_freeze_traced()
> to use lock_task_sighand().

Right.

> > > 		for (;;) {
> > > 			if (fatal_signal_pending(current))
> > > 				return -EINTR;
> >
> > What if signal_wake_up(.resume=true) happens here? In that case we miss
> > the fatal pending, and task state isn't changed yet so we'll happily go
> > sleep.
> 
> No, it won't sleep, see the signal_pending_state() check in schedule().

Urgh, forgot about that one ;-)

> > > 			set_current_state(TASK_KILLABLE);
> 
> And let me explain TASK_KILLABLE just in case... We could just use
> TASK_UNINTERRUPTIBLE and avoid the signal_pending() check, but KILLABLE
> looks "safer" to me. If the tracer hangs because of some bug, at least
> it can be killed from userspace.

Agreed.

> 
> > > 			if (!(READ_ONCE(child->jobctl) & JOBCTL_TRACED)) {
> >
> >   TRACED_XXX ?
> 
> oops ;)
> 
> > > -	spin_lock_irq(&task->sighand->siglock);
> > >  	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
> > >  	    !__fatal_signal_pending(task)) {
> > >  		task->jobctl |= JOBCTL_TRACED_FROZEN;
> > >  		WRITE_ONCE(task->__state, __TASK_TRACED);
> > >  		ret = true;
> > >  	}
> >
> > I would feel much better if this were still a task_func_call()
> > validating !->on_rq && !->on_cpu.
> 
> Well, but "on_rq || on_cpu" would mean that wait_task_inactive() is buggy ?

Yes, but I'm starting to feel a little paranoid here. Better safe than
sorry etc..

> But! I forgot to make anothet change in this code. I do not think it should
> rely on task_is_traced(). We are going to abuse task->__state, so I think
> it should check task->__state == TASK_TRACED directly. Say,
> 
> 	if (READ_ONCE(task->__state) == TASK_TRACED && ...) {
> 		WRITE_ONCE(task->__state, __TASK_TRACED);
> 		WARN_ON_ONCE(!task_is_traced(task));
> 		ret = true;
> 	}
> 
> looks more clean to me. What do you think?

Agreed on this.

> > > @@ -2307,13 +2313,14 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
> > >  		 */
> > >  		if (gstop_done)
> > >  			do_notify_parent_cldstop(current, false, why);
> > > +		clear_traced_xxx();
> > > +		read_unlock(&tasklist_lock);
> > >
> > > -		/* tasklist protects us from ptrace_freeze_traced() */
> > > +		/* JOBCTL_TRACED_XXX protects us from ptrace_freeze_traced() */
> >
> > But... TRACED_XXX has just been cleared ?!
> 
> Cough ;) OK, I'll move __set_current_state() back under tasklist.
> 
> And in this case we do not need wake_up(parent), so we can shift it from
> clear_traced_xxx() into another branch.
> 
> OK, so far it seems that this patch needs a couple of simple fixes you
> pointed out, but before I send V2:
> 
> 	- do you agree we can avoid JOBCTL_TRACED_FROZEN in 1-2 ?

We can for the sake of 2 avoid TRACED_FROZEN, but as explained at the
start, the point of 1 was to ensure there is no unique state in __state,
and I think in that respect we can keep it, hmm?

> 	- will you agree if I change ptrace_freeze_traced() to rely
> 	  on __state == TASK_TRACED rather than task_is_traced() ?

Yes.
