Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 178864BF766
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Feb 2022 12:42:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231723AbiBVLmh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Feb 2022 06:42:37 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34030 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231722AbiBVLme (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Feb 2022 06:42:34 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6E3D1375AB
        for <linux-kernel@vger.kernel.org>; Tue, 22 Feb 2022 03:42:08 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id 3E2B321116;
        Tue, 22 Feb 2022 11:42:07 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1645530127; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=hxQNYAUPJD4VLOpKLCveYaNb99s6UWx770ZenEMiWe4=;
        b=nB2wJpGD7YOQDV+ZLdLTtaI2sY7QInkb1PDXV4TWCs6TNBF7knhJgubWTjSlRKM3LVY2W4
        /D3nvwiJmJz68VIOxktSrKJUWBAjrYwavbwWIxvaUy3DLRNucYjygiHDnSNeDAS7BXCG3z
        uvXNYuNiPY60ypQrcfT0fGYgwJRmhJA=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id E5B82A3B83;
        Tue, 22 Feb 2022 11:42:06 +0000 (UTC)
Date:   Tue, 22 Feb 2022 12:42:04 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
Message-ID: <YhTMDOHyXADh665V@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <Yg/HWcifuqLsS6cv@alley>
 <87o8333l97.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87o8333l97.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi,

first, to make it clear. The changes make sense and I am going to
review the code. But I would still like to clarify the commit message.
I do not understand it myself. Future generations should know
why we did this ;-)

On Fri 2022-02-18 22:47:56, John Ogness wrote:
> On 2022-02-18, Petr Mladek <pmladek@suse.com> wrote:
> > the solution is very interesting and I am sure that it has many
> > advantages. But it is also quite complex. I want to be sure
> > about the motivations before I start discussing details.
> 
> I am jumping ahead to this email so that we can start discussing
> details. This patch is really the key to make the whole series work
> correctly.
> 
> > On Mon 2022-02-07 20:49:21, John Ogness wrote:
> >> With non-threaded console printers preemption is disabled while
> >> holding the console lock in order to avoid the situation where the
> >> console printer is scheduled away and no other task can lock the
> >> console (for printing or otherwise).
> >
> > I guess that you are talking about that vprintk_emit() disables
> > the preemtion. console_lock() does not disable preemption.
> 
> Yes. I did not mean to imply that console_lock() is disabling
> preemption. But preemption is disabled at some point _within_ the
> console_lock()/console_unlock() window. I consider
> console_lock()/console_unlock() to be the main API functions for direct
> printing and I wanted to point out that calling that pair will cause
> preemption disabling.

But console_unlock() should not call consoles when kthreads are
usable. It should just wake up them. The kthreads might still
use console_lock() and __console_unlock().

I do not understand why this should be a reason to introduce
per-console locks.


> >> Disabling preemption is necessary because the console lock is
> >> implemented purely as a semaphore, which has no owner.
> >
> > I do not understand this explanation.
> >
> > The preemtion was added into vprintk_emit() by the commit
> > fd5f7cde1b85d4c8e09c ("printk: Never set console_may_schedule
> > in console_trylock()").
> >
> > It is not really necessary. It actually increases the risk of softlockups.
> > The motivation was to increase the chance that messages will get
> > printed. Nobody prints the messages when the owner is sleeping.
> > We hoped that the console owner steeling will be efficient enough
> > to prevent the softlockups.
> 
> Yes, I am referring to this case where the context taking the semaphore
> goes to sleep. If another context tries to take the semaphore, the
> scheduler does not know which task it can schedule to resolve the
> situation because there is no true lock contention.
> 
> With a mutex there is an owner. When another task tries to lock a mutex,
> the scheduler knows which task must be scheduled to resolve this true
> lock contention. (There are also other benefits relating to priority
> inheritance, but I chose not to mention this.)

This sounds interesting. Does scheduler wake up or prioritize
mutex owners?

I do not see this in the code. There is the optimistic spin but
it is used only when the current owner is just running on another CPU.

Again, I do not see how this could be a motivation to introduce
per-console mutexes.


> >> Like non-threaded console printers, kthread printers use the
> >> console lock to synchronize during printing. However, since they
> >> use console_lock() instead of a best-effort console_trylock(), it
> >> is not possible to disable preemption upon locking.
> >   ^^^^^^^^^^^^^^^
> >
> > IMHO, it is possible to disable preemtion. But we propably do
> > not want to do it, especially on RT.
> 
> As stated in the commit message of fd5f7cde1b85 ("printk: Never set
> console_may_schedule in console_trylock()"), enabling preemption is "a
> mistake". That is why I said "not possible". Perhaps I should say "bad
> idea".

"bad idea" is better. I am sorry that I am too picky. But the disabled
preemption was a big mystery when I started working on printk code
ages ago. And it was hard to find any explanation if it was required
or just nice to have. Clear commit message or comment would have
helped a lot.


> >> Therefore an alternative for synchronizing and avoiding
> >> the above mentioned situation is needed.
> >
> > I do not think that preemtion is the reason for an alternative
> > soluiton.
> 
> Well, if enabling preemption is "a mistake" then we _need_ an
> alternative.

The alternative is the offload to kthreads that were introduced
in another patch. This patch introduces per-console locks and
the kthreads are usable even without them.

This is why I am confused by this commit messages.


> > IMHO, the reason is to handle different consoles independently.
> > It will allow to handle more consoles in parallel. And more
> > importantly they will not block each other.
> 
> This is an additional benefit, but it was not my primary motivation when
> designing the alternative. Honestly, I do not care how we phrase the
> motivation and benefits. I only wanted to make it clear that disabling
> preemption is not an acceptable option.

I am sorry but I still do not understand the primary motivation.
I do not see how the per-console mutexes help with preemtion:

   + console_lock()/console_unlock() is fast when kthreads are usable

   + console_lock()/console_unlock() behaves the same as before
     when kthreads are not usable, for example, during early boot,
     or panic.


Idea: Did you want to prevent situation when the console_lock()
      is blocked because any printk kthread is sleeping with the lock?

      But it is still the case. console_lock() must still take
      each per-console mutex and can be blocked by any sleeping
      printk kthread.


BTW: The possibility to process printk kthreads in parallel is
     a good enough reason from my POV. But I would still like
     to understand your primary motivation. There must be some
     important aspect that I do not understand. And it would be
     great to document it.

> >> To provide this synchronization, introduce a per-console mutex. The
> >> mutex is taken by the kthread printer during printing and is also
> >> taken by console_lock() callers.
> >
> > ok
> >
> >> Since mutexes have owners, when calling console_lock(), the
> >> scheduler is able to schedule any kthread printers that may have
> >> been preempted while printing.
> >
> > I do not userstand the relation between mutex owners and scheduling
> > kthreads. The mutex can be taken by any process.
> 
> As mentioned above, it is about creating true lock contention between
> the kthreads and the console_lock() callers.

I understand that it solves synchronization between the global
console_lock() and per-console mutexes.

But I still do not understand the effect of mutex owners and that
scheduler might wake them. I do not see any code for this.
Will this behavior be added by some followup patchset?


> >> Rather than console_lock() callers holding the per-console mutex
> >> for the duration of the console lock, the per-console mutex is only
> >> taken in order to set a new CON_PAUSED flag, which is checked by
> >> the kthread printers. This avoids any issues due to nested locking
> >> between the various per-console mutexes.
> >
> > The flag adds some complexity. The logic will use two locks + one flag
> > instead of just two locks. IMHO, it deserves a more clear explanation
> > why it is needed. When can nested locking happen? Will it make the
> > nested locking safe?
> >
> > The obvious ordering is to always take con->mutex under console_sem.
> >
> > Are you afraid that some console driver might need to take console_sem
> > from con->write() callback?
> 
> No. By nested locking I mean:
> 
>     for_each_console(c)
>         mutex_lock(&c->lock);
> 
>     /* .... do something .... */
> 
>     for_each_console_reversed(c)
>         mutex_unlock(&c->lock);
> 
> Aside from this looking ugly and being a potential lockdep problem if
> the console ordering were to change, it would also mean that all the
> console mutexes are locked while suspended. That is not necessarily an
> issue, but I just did not like the idea of holding so many locks while
> suspended. And I still do not feel so comfortable about the somewhat
> arbitrary ordering of console locking.

It makes perfect sense. I see why we need the flags now.

> If you think the above construct is good, then we do not need the flag
> approach.
> 
> >> The kthread printers must also synchronize against console_trylock()
> >> callers. Since console_trylock() is non-blocking, a global atomic
> >> counter will be used to identify if any kthread printers are active.
> >> The kthread printers will also check the atomic counter to identify
> >> if the console has been locked by another task via
> >> console_trylock().
> >
> > This is another complexity. An easier solution would be to do:
> >
> > console_trylock()
> > {
> > 	if (down_trylock(&console_sem))
> > 		return failed;
> >
> > 	for_each_console(con) {
> > 		if (mutext_trylock(&con->lock))
> > 			goto fail;
> > 	}
> >
> > 	// sucess
> >
> > fail:
> > 	for_each_console(con_fail) {
> > 		if (con_fail == con)
> > 			break;
> > 		mutex_unlock(&con->lock);
> > }

> No, this cannot work. Semaphores are the _only_ synchonization object in
> the kernel that is allowed to perform a trylock from any context
> (because they don't have owners).

Ah, mutex_trylock() can't be used in atomic context. I was not aware
of this.

It means that also the atomic counter makes perfect sense. And it is
very nice trick.

Best Regards,
Petr

PS: I am going to review the code.
