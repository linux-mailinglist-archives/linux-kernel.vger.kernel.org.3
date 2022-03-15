Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 39ED84D964D
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 09:33:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346064AbiCOIeK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 04:34:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346299AbiCOIdI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 04:33:08 -0400
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E2704C7AB
        for <linux-kernel@vger.kernel.org>; Tue, 15 Mar 2022 01:31:50 -0700 (PDT)
Date:   Tue, 15 Mar 2022 09:31:47 +0100
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647333109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8WxJ1iaVzDHKBMho9TQMsvxPMKiQqA5PZTrAtw2jnv8=;
        b=BPIpWH72QRrvfRzOcWqpwKwzfuY8FdeeIloC1VA+pej4kqcUfVhLqyCRSNzzjDNOCkUjgG
        iQjJ+SOhBxYHspU/HLwhFc/e+YG56+3Qb8L+EnD5KKyI0eOkJzXyIznJ0nToSBmlZ8Or8o
        soGsGNI0fNUEZEnaSpGg9wxBucUl3cfuLaTDuorRLR3aM+Q4RQiUhZMnSVYsKDwHdcOF5G
        aDyJIvNNp0PayhlDYxSXFkAo32orhsLDvQdktiQGpf9oxraRwx8ysww3fGEB/a2qjIMCjq
        yGVQLOHoOIQfFyOlmRCh6nfNiW7HvXoklarWh9ieHmnYWpuvQh0SSw2ldhBBPg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647333109;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8WxJ1iaVzDHKBMho9TQMsvxPMKiQqA5PZTrAtw2jnv8=;
        b=YoDL3b/dgZ9wa3peqZ2X4fJfO8va3wyTVUFp92D0ikwI3Drj1oO3f5mnnNbCFhebX4MuYk
        FdA+5pnXAo/Ni/Cg==
From:   Sebastian Andrzej Siewior <bigeasy@linutronix.de>
To:     Oleg Nesterov <oleg@redhat.com>
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
Subject: Re: [PATCH] ptrace: fix ptrace vs tasklist_lock race on PREEMPT_RT.
Message-ID: <YjBO8yzxdmjTGNiy@linutronix.de>
References: <Yh/b19JikC+Vnm8i@linutronix.de>
 <20220314185429.GA30364@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220314185429.GA30364@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-14 19:54:30 [+0100], Oleg Nesterov wrote:
> I never really understood ->saved_state logic. Will read this patch
> tomorrow, but at first glance this patch doesn't solve all problems.

Let me explain the ->saved_state logic:
On !RT, this

   set_current_state(TASK_UNINTERRUPTIBLE); 	// 1
   spin_lock(&lock);				// 2
   spin_unlock(&lock);				// 3
   schedule();					// 4

will assign ->state, spin on &lock and then invoke schedule() while
->state is still TASK_UNINTERRUPTIBLE.
On RT however, the spinlock_t becomes a sleeping lock and won't spin on
&lock but rather sleep want waiting for the lock. While at sleep waiting
for the lock, the ->state needs to be preserved or otherwise the ->state
gets lost on the wake-up with the lock acquired. 

That means RT that happens:
- 1 assigns ->state as with !RT
- 2 acquires &lock. If the is contained then
    with current->pi_lock acquired
    (current_save_and_set_rtlock_wait_state):
       ->saved_state = ->state (TASK_UNINTERRUPTIBLE)
       ->state = TASK_RTLOCK_WAIT
   and the task sleeps until &lock is available.
   Once the lock is acquired, the task will be woken up and its state is
   updated with ->pi_lock acquired (current_restore_rtlock_saved_state):
      ->state = ->saved_state (TASK_UNINTERRUPTIBLE)
      ->state = TASK_RUNNING

- 3 unlocks &lock, ->state still TASK_UNINTERRUPTIBLE
- 4 invokes schedule with TASK_UNINTERRUPTIBLE.

The sleeping locks on RT are spinlock_t and rwlock_t.

Side note: If !RT at step 2 spins on the lock then it may receive a wake
up at which point TASK_UNINTERRUPTIBLE becomes TASK_RUNNING and then it
would invoke schedule() with TASK_RUNNING (assuming the condition
becomes sooner available).
On RT, this also works and the task at step 2 may sleep or be in
transition to/ from sleep. Therefore the wake up (under ->pi_lock)
looks at ->state and if it is TASK_RTLOCK_WAIT then it updates
saved_state instead (ttwu_state_match()).

> On 03/02, Sebastian Andrzej Siewior wrote:
> >
> > +static inline bool __task_state_match_eq(struct task_struct *tsk, long state)
> > +{
> > +	bool match = false;
> > +
> > +	if (READ_ONCE(tsk->__state) == state)
> > +		match = true;
> > +	else if (tsk->saved_state == state)
> > +		match = true;
> > +	return match;
> > +}
> 
> ...
> 
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -3239,7 +3239,8 @@ unsigned long wait_task_inactive(struct task_struct *p, unsigned int match_state
> >  		 * is actually now running somewhere else!
> >  		 */
> >  		while (task_running(rq, p)) {
> > -			if (match_state && unlikely(READ_ONCE(p->__state) != match_state))
> > +			if (match_state &&
> > +			    unlikely(!task_state_match_eq(p, match_state)))
> >  				return 0;
> 
> So wait_task_inactive() can return 0 but the task can run after that, right?
> This is not what we want...

Without checking both states you may never observe the requested state
because it is set to TASK_RTLOCK_WAIT while waiting for a lock. Other
than that, it may run briefly because it tries to acquire a lock or just
acquired and this shouldn't be different from a task spinning on a lock.

> Oleg.

Sebastian
