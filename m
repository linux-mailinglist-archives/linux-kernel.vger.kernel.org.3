Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8656B50280F
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 12:17:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352168AbiDOKTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Apr 2022 06:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352163AbiDOKTa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Apr 2022 06:19:30 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 922EDBA330
        for <linux-kernel@vger.kernel.org>; Fri, 15 Apr 2022 03:17:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650017821;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=SW3+pTZzJmwPiUjPG7sYRQA2iIBjDVKXN/85OokF02U=;
        b=XMQCg1QT7kiZn+PEkVIx7Wyx8aBZvGDGeHU7kcWTBv58pydgsk1nrpU+NvOavHBHwJzhVO
        YPz02fiVDTRSBluQNx0oYkK0uqtV5aCHe2+/eBuJFWmsYH5eqV6WKIni8CAIHgJxuMVzq/
        jm26KapYfkWbLT/PCdEMvJFubAIk8Ck=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-577-XejZnFfoOW2rBE4VXbgNAQ-1; Fri, 15 Apr 2022 06:16:50 -0400
X-MC-Unique: XejZnFfoOW2rBE4VXbgNAQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id A94D11014A6F;
        Fri, 15 Apr 2022 10:16:49 +0000 (UTC)
Received: from dhcp-27-174.brq.redhat.com (unknown [10.40.192.163])
        by smtp.corp.redhat.com (Postfix) with SMTP id 7AAC6145B97B;
        Fri, 15 Apr 2022 10:16:46 +0000 (UTC)
Received: by dhcp-27-174.brq.redhat.com (nbSMTP-1.00) for uid 1000
        oleg@redhat.com; Fri, 15 Apr 2022 12:16:48 +0200 (CEST)
Date:   Fri, 15 Apr 2022 12:16:44 +0200
From:   Oleg Nesterov <oleg@redhat.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <20220415101644.GA10421@redhat.com>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
 <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
User-Agent: Mutt/1.5.24 (2015-08-30)
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/15, Peter Zijlstra wrote:
>
> On Thu, Apr 14, 2022 at 08:34:33PM +0200, Oleg Nesterov wrote:
>
> > If it can work, then 1/5 needs some changes, I think. In particular,
> > it should not introduce JOBCTL_TRACED_FROZEN until 5/5, and perhaps
>
> That TRACED_FROZEN was to distinguish the TASK_TRACED and __TASK_TRACED
> state, and isn't related to the freezer.

Lets forget about 3-5 which I didn't read carefully yet. So why do we
need TRACED_FROZEN?

From 1/5:

	 static inline void signal_wake_up(struct task_struct *t, bool resume)
	 {
	+	lockdep_assert_held(&t->sighand->siglock);
	+
	+	if (resume && !(t->jobctl & JOBCTL_TRACED_FROZEN))
	+		t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
	+
		signal_wake_up_state(t, resume ? TASK_WAKEKILL : 0);
	 }
	+
	 static inline void ptrace_signal_wake_up(struct task_struct *t, bool resume)
	 {
	+	lockdep_assert_held(&t->sighand->siglock);
	+
	+	if (resume)
	+		t->jobctl &= ~JOBCTL_TRACED;
	+
		signal_wake_up_state(t, resume ? __TASK_TRACED : 0);
	 }

Can't we simply change signal_wake_up_state(),

	void signal_wake_up_state(struct task_struct *t, unsigned int state)
	{
		set_tsk_thread_flag(t, TIF_SIGPENDING);
		/*
		 * TASK_WAKEKILL also means wake it up in the stopped/traced/killable
		 * case. We don't check t->state here because there is a race with it
		 * executing another processor and just now entering stopped state.
		 * By using wake_up_state, we ensure the process will wake up and
		 * handle its death signal.
		 */
		if (wake_up_state(t, state | TASK_INTERRUPTIBLE))
			t->jobctl &= ~(JOBCTL_STOPPED | JOBCTL_TRACED);
		else
			kick_process(t);
	}

?

> > 		/*
> > 		 * We take the read lock around doing both checks to close a
> > 		 * possible race where someone else attaches or detaches our
> > 		 * natural child.
> > 		 */
> > 		read_lock(&tasklist_lock);
> > 		traced = child->ptrace && child->parent == current;
> > 		read_unlock(&tasklist_lock);
> >
> > 		if (!traced)
> > 			return -ESRCH;
>
> The thing being, that if it is our ptrace child, it won't be going away
> since we're running this code and not ptrace_detach().  Right?

Yes. and nobody else can detach it.

Another tracer can't attach until child->ptrace is cleared, but this can
only happen if a) this child is killed and b) another thread does wait()
and reaps it; but after that attach() is obviously impossible.

But since this child can go away, the patch changes ptrace_freeze_traced()
to use lock_task_sighand().

> > 		for (;;) {
> > 			if (fatal_signal_pending(current))
> > 				return -EINTR;
>
> What if signal_wake_up(.resume=true) happens here? In that case we miss
> the fatal pending, and task state isn't changed yet so we'll happily go
> sleep.

No, it won't sleep, see the signal_pending_state() check in schedule().

> > 			set_current_state(TASK_KILLABLE);

And let me explain TASK_KILLABLE just in case... We could just use
TASK_UNINTERRUPTIBLE and avoid the signal_pending() check, but KILLABLE
looks "safer" to me. If the tracer hangs because of some bug, at least
it can be killed from userspace.


> > 			if (!(READ_ONCE(child->jobctl) & JOBCTL_TRACED)) {
>
>   TRACED_XXX ?

oops ;)

> > -	spin_lock_irq(&task->sighand->siglock);
> >  	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
> >  	    !__fatal_signal_pending(task)) {
> >  		task->jobctl |= JOBCTL_TRACED_FROZEN;
> >  		WRITE_ONCE(task->__state, __TASK_TRACED);
> >  		ret = true;
> >  	}
>
> I would feel much better if this were still a task_func_call()
> validating !->on_rq && !->on_cpu.

Well, but "on_rq || on_cpu" would mean that wait_task_inactive() is buggy ?

But! I forgot to make anothet change in this code. I do not think it should
rely on task_is_traced(). We are going to abuse task->__state, so I think
it should check task->__state == TASK_TRACED directly. Say,

	if (READ_ONCE(task->__state) == TASK_TRACED && ...) {
		WRITE_ONCE(task->__state, __TASK_TRACED);
		WARN_ON_ONCE(!task_is_traced(task));
		ret = true;
	}

looks more clean to me. What do you think?

> > @@ -2307,13 +2313,14 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
> >  		 */
> >  		if (gstop_done)
> >  			do_notify_parent_cldstop(current, false, why);
> > +		clear_traced_xxx();
> > +		read_unlock(&tasklist_lock);
> >
> > -		/* tasklist protects us from ptrace_freeze_traced() */
> > +		/* JOBCTL_TRACED_XXX protects us from ptrace_freeze_traced() */
>
> But... TRACED_XXX has just been cleared ?!

Cough ;) OK, I'll move __set_current_state() back under tasklist.

And in this case we do not need wake_up(parent), so we can shift it from
clear_traced_xxx() into another branch.

OK, so far it seems that this patch needs a couple of simple fixes you
pointed out, but before I send V2:

	- do you agree we can avoid JOBCTL_TRACED_FROZEN in 1-2 ?

	- will you agree if I change ptrace_freeze_traced() to rely
	  on __state == TASK_TRACED rather than task_is_traced() ?

Thanks,

Oleg.

