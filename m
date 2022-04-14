Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29EE3501E9B
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Apr 2022 00:46:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347267AbiDNWsd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 18:48:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347218AbiDNWsX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 18:48:23 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B26AC6EE2;
        Thu, 14 Apr 2022 15:45:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=1MUuoYIDAdHANZbhEijrvNi2xoswiut7YvJt8TOTV/8=; b=BVfLEJ8zOdydom3gzjyIsKnq1k
        rWfrZ7EF00oaafgUVs95D4g2JEpMyQ0vIgcyYqJglZaK7j9MytxJmL6opy9gPyJ3PCjsN/5tt7KbB
        Ffck/sX1fN9q4udGGEtenTV0l/NqrbnyxPHRFYxQU+HHo1jWnFqsTyPOGNJxZF/FQFmMMD7w7GInH
        B1FMromhLVUEzTZwWvIjWHS5Q6ae3Zp/oJAAkwVj4I3oarhuRnUyAa2FNoY/eKOR3nf8UWsD23K6z
        53uRrLm1SYdpOFjg8vsRUQRdhtfmMx1bORta19afl+ryZL3TFOMplF0EyqoynwsALwNJIDzAbQIQy
        23/oa0ew==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=noisy.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nf8DS-00FbUB-1Q; Thu, 14 Apr 2022 22:45:30 +0000
Received: from hirez.programming.kicks-ass.net (hirez.programming.kicks-ass.net [192.168.1.225])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        by noisy.programming.kicks-ass.net (Postfix) with ESMTPS id 451243002DE;
        Fri, 15 Apr 2022 00:45:27 +0200 (CEST)
Received: by hirez.programming.kicks-ass.net (Postfix, from userid 1000)
        id 01270322A9DDE; Fri, 15 Apr 2022 00:45:26 +0200 (CEST)
Date:   Fri, 15 Apr 2022 00:45:26 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Oleg Nesterov <oleg@redhat.com>
Cc:     rjw@rjwysocki.net, mingo@kernel.org, vincent.guittot@linaro.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, mgorman@suse.de,
        ebiederm@xmission.com, bigeasy@linutronix.de,
        Will Deacon <will@kernel.org>, linux-kernel@vger.kernel.org,
        tj@kernel.org, linux-pm@vger.kernel.org
Subject: Re: [PATCH 2/5] sched,ptrace: Fix ptrace_check_attach() vs PREEMPT_RT
Message-ID: <YlikBjA3kL3XEQP5@hirez.programming.kicks-ass.net>
References: <20220412114421.691372568@infradead.org>
 <20220412114853.842942162@infradead.org>
 <20220413132451.GA27281@redhat.com>
 <20220413185704.GA30360@redhat.com>
 <20220413185909.GB30360@redhat.com>
 <20220413192053.GY2731@worktop.programming.kicks-ass.net>
 <20220413195612.GC2762@worktop.programming.kicks-ass.net>
 <20220414115410.GA32752@redhat.com>
 <20220414183433.GC32752@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220414183433.GC32752@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 14, 2022 at 08:34:33PM +0200, Oleg Nesterov wrote:
> On 04/14, Oleg Nesterov wrote:
> >
> > OK, let me think about it. Thanks!
> 
> So. what do you think about the patch below?

Might just work, will have to look at it again though ;-) Comments
below.

> If it can work, then 1/5 needs some changes, I think. In particular,
> it should not introduce JOBCTL_TRACED_FROZEN until 5/5, and perhaps

That TRACED_FROZEN was to distinguish the TASK_TRACED and __TASK_TRACED
state, and isn't related to the freezer.

> we can avoid this flag altogether...
> 
> This is how ptrace_check_attach() looks with the patch applied:
> 
> 	static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
> 	{
> 		int traced;
> 		/*
> 		 * We take the read lock around doing both checks to close a
> 		 * possible race where someone else attaches or detaches our
> 		 * natural child.
> 		 */
> 		read_lock(&tasklist_lock);
> 		traced = child->ptrace && child->parent == current;
> 		read_unlock(&tasklist_lock);
> 
> 		if (!traced)
> 			return -ESRCH;

The thing being, that if it is our ptrace child, it won't be going away
since we're running this code and not ptrace_detach().  Right?

I failed to realize this earlier and I think that's part of why my
solution is somewhat over complicated.

> 		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
> 		if (ignore_state)
> 			return 0;
> 
> 		for (;;) {
> 			if (fatal_signal_pending(current))
> 				return -EINTR;

What if signal_wake_up(.resume=true) happens here? In that case we miss
the fatal pending, and task state isn't changed yet so we'll happily go
sleep.

> 			set_current_state(TASK_KILLABLE);
> 			if (!(READ_ONCE(child->jobctl) & JOBCTL_TRACED)) {

  TRACED_XXX ?

> 				__set_current_state(TASK_RUNNING);
> 				break;
> 			}
> 			schedule();
> 		}

That is, shouldn't we write this like:

		for (;;) {
			set_current_state(TASK_KILLABLE);
			if (fatal_signal_pending(current)) {
				ret = -EINTR;
				break;
			}
			if (!(READ_ONCE(current->jobctl) & JOBCTL_TRACED_XXX)) {
				ret = 0;
				break;
			}
			schedule();
		}
		__set_current_state(TASK_RUNNING);
		if (ret)
			return ret;

> 		if (!wait_task_inactive(child, TASK_TRACED) ||
> 		    !ptrace_freeze_traced(child))
> 			return -ESRCH;
> 
> 		return 0;
> 	}
> 
> Oleg.
> ---
> 
> diff --git a/include/linux/sched/jobctl.h b/include/linux/sched/jobctl.h
> index ec8b312f7506..1b5a57048e13 100644
> --- a/include/linux/sched/jobctl.h
> +++ b/include/linux/sched/jobctl.h
> @@ -22,7 +22,8 @@ struct task_struct;
>  
>  #define JOBCTL_STOPPED_BIT	24
>  #define JOBCTL_TRACED_BIT	25
> -#define JOBCTL_TRACED_FROZEN_BIT 26
> +#define JOBCTL_TRACED_XXX_BIT	25
> +#define JOBCTL_TRACED_FROZEN_BIT 27
>  
>  #define JOBCTL_STOP_DEQUEUED	(1UL << JOBCTL_STOP_DEQUEUED_BIT)
>  #define JOBCTL_STOP_PENDING	(1UL << JOBCTL_STOP_PENDING_BIT)
> @@ -35,6 +36,7 @@ struct task_struct;
>  
>  #define JOBCTL_STOPPED		(1UL << JOBCTL_STOPPED_BIT)
>  #define JOBCTL_TRACED		(1UL << JOBCTL_TRACED_BIT)
> +#define JOBCTL_TRACED_XXX	(1UL << JOBCTL_TRACED_XXX_BIT)
>  #define JOBCTL_TRACED_FROZEN	(1UL << JOBCTL_TRACED_FROZEN_BIT)
>  
>  #define JOBCTL_TRAP_MASK	(JOBCTL_TRAP_STOP | JOBCTL_TRAP_NOTIFY)
> diff --git a/kernel/ptrace.c b/kernel/ptrace.c
> index 626f96d275c7..5a03ae5cb0c0 100644
> --- a/kernel/ptrace.c
> +++ b/kernel/ptrace.c
> @@ -193,20 +193,22 @@ static bool looks_like_a_spurious_pid(struct task_struct *task)
>   */
>  static bool ptrace_freeze_traced(struct task_struct *task)
>  {
> +	unsigned long flags;
>  	bool ret = false;
>  
>  	/* Lockless, nobody but us can set this flag */
>  	if (task->jobctl & JOBCTL_LISTENING)
>  		return ret;
> +	if (!lock_task_sighand(task, &flags))
> +		return ret;
>  
> -	spin_lock_irq(&task->sighand->siglock);
>  	if (task_is_traced(task) && !looks_like_a_spurious_pid(task) &&
>  	    !__fatal_signal_pending(task)) {
>  		task->jobctl |= JOBCTL_TRACED_FROZEN;
>  		WRITE_ONCE(task->__state, __TASK_TRACED);
>  		ret = true;
>  	}

I would feel much better if this were still a task_func_call()
validating !->on_rq && !->on_cpu.

> -	spin_unlock_irq(&task->sighand->siglock);
> +	unlock_task_sighand(task, &flags);
>  
>  	return ret;
>  }
> @@ -253,40 +255,39 @@ static void ptrace_unfreeze_traced(struct task_struct *task)
>   */
>  static int ptrace_check_attach(struct task_struct *child, bool ignore_state)
>  {
> -	int ret = -ESRCH;
> -
> +	int traced;
>  	/*
>  	 * We take the read lock around doing both checks to close a
> -	 * possible race where someone else was tracing our child and
> -	 * detached between these two checks.  After this locked check,
> -	 * we are sure that this is our traced child and that can only
> -	 * be changed by us so it's not changing right after this.
> +	 * possible race where someone else attaches or detaches our
> +	 * natural child.
>  	 */
>  	read_lock(&tasklist_lock);
> -	if (child->ptrace && child->parent == current) {
> -		WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
> -		/*
> -		 * child->sighand can't be NULL, release_task()
> -		 * does ptrace_unlink() before __exit_signal().
> -		 */
> -		if (ignore_state || ptrace_freeze_traced(child))
> -			ret = 0;
> -	}
> +	traced = child->ptrace && child->parent == current;
>  	read_unlock(&tasklist_lock);
>  
> -	if (!ret && !ignore_state) {
> -		if (!wait_task_inactive(child, __TASK_TRACED)) {
> -			/*
> -			 * This can only happen if may_ptrace_stop() fails and
> -			 * ptrace_stop() changes ->state back to TASK_RUNNING,
> -			 * so we should not worry about leaking __TASK_TRACED.
> -			 */
> -			WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
> -			ret = -ESRCH;
> +	if (!traced)
> +		return -ESRCH;
> +
> +	WARN_ON(READ_ONCE(child->__state) == __TASK_TRACED);
> +	if (ignore_state)
> +		return 0;
> +
> +	for (;;) {
> +		if (fatal_signal_pending(current))
> +			return -EINTR;
> +		set_current_state(TASK_KILLABLE);
> +		if (!(READ_ONCE(child->jobctl) & JOBCTL_TRACED)) {
> +			__set_current_state(TASK_RUNNING);
> +			break;
>  		}
> +		schedule();
>  	}
>  
> -	return ret;
> +	if (!wait_task_inactive(child, TASK_TRACED) ||
> +	    !ptrace_freeze_traced(child))
> +		return -ESRCH;
> +
> +	return 0;
>  }
>  
>  static bool ptrace_has_cap(struct user_namespace *ns, unsigned int mode)
> diff --git a/kernel/signal.c b/kernel/signal.c
> index 0aea3f0a8002..684f0a0e9c71 100644
> --- a/kernel/signal.c
> +++ b/kernel/signal.c
> @@ -2182,6 +2182,14 @@ static void do_notify_parent_cldstop(struct task_struct *tsk,
>  	spin_unlock_irqrestore(&sighand->siglock, flags);
>  }
>  
> +static void clear_traced_xxx(void)
> +{
> +	spin_lock_irq(&current->sighand->siglock);
> +	current->jobctl &= ~JOBCTL_TRACED_XXX;
> +	spin_unlock_irq(&current->sighand->siglock);
> +	wake_up_state(current->parent, TASK_KILLABLE);
> +}
> +
>  /*
>   * This must be called with current->sighand->siglock held.
>   *
> @@ -2220,7 +2228,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>  	 * schedule() will not sleep if there is a pending signal that
>  	 * can awaken the task.
>  	 */
> -	current->jobctl |= JOBCTL_TRACED;
> +	current->jobctl |= JOBCTL_TRACED | JOBCTL_TRACED_XXX;
>  	set_special_state(TASK_TRACED);
>  
>  	/*
> @@ -2282,6 +2290,7 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>  		if (gstop_done && ptrace_reparented(current))
>  			do_notify_parent_cldstop(current, false, why);
>  
> +		clear_traced_xxx();
>  		/*
>  		 * Don't want to allow preemption here, because
>  		 * sys_ptrace() needs this task to be inactive.
> @@ -2296,9 +2305,6 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>  		cgroup_leave_frozen(true);
>  	} else {
>  		/*
> -		 * By the time we got the lock, our tracer went away.
> -		 * Don't drop the lock yet, another tracer may come.
> -		 *
>  		 * If @gstop_done, the ptracer went away between group stop
>  		 * completion and here.  During detach, it would have set
>  		 * JOBCTL_STOP_PENDING on us and we'll re-enter
> @@ -2307,13 +2313,14 @@ static int ptrace_stop(int exit_code, int why, int clear_code,
>  		 */
>  		if (gstop_done)
>  			do_notify_parent_cldstop(current, false, why);
> +		clear_traced_xxx();
> +		read_unlock(&tasklist_lock);
>  
> -		/* tasklist protects us from ptrace_freeze_traced() */
> +		/* JOBCTL_TRACED_XXX protects us from ptrace_freeze_traced() */

But... TRACED_XXX has just been cleared ?!

>  		__set_current_state(TASK_RUNNING);
>  		read_code = false;
>  		if (clear_code)
>  			exit_code = 0;
> -		read_unlock(&tasklist_lock);
>  	}
>  
>  	/*
> 
