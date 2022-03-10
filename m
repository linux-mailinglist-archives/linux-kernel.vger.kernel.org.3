Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E708C4D4C3C
	for <lists+linux-kernel@lfdr.de>; Thu, 10 Mar 2022 16:02:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344784AbiCJOxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 10 Mar 2022 09:53:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344255AbiCJOkg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 10 Mar 2022 09:40:36 -0500
Received: from smtp-out1.suse.de (smtp-out1.suse.de [195.135.220.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C0668180211
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 06:34:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A38B321A41;
        Thu, 10 Mar 2022 14:34:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646922868; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=9RouxQD9+gCSJlO6hdmA/8bp89OhhegxAXxjgYOLaZE=;
        b=n2K4oY3y+KFwk9XZgNQhaAZwkt1LV/+z0gdG17f6RDQOuZtqGBi+yvVCgAy2Bbq1G8oBw+
        9a3iGLRZ0ZuPCE4rcGhiee1N55Ul7DHy0q6mrQuQ2LdeYDso5FLPw3XMwJP9VADzrNAqs1
        gdbers2jjnWZRwP7JIMdZfkNNejQHiU=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 857FAA3BAC;
        Thu, 10 Mar 2022 14:34:28 +0000 (UTC)
Date:   Thu, 10 Mar 2022 15:34:25 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
Message-ID: <YioMcSe0P0Z7ksiW@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <YhYKP/UuSKENGwfj@alley>
 <87tuc7xma0.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87tuc7xma0.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-09 15:02:07, John Ogness wrote:
> On 2022-02-23, Petr Mladek <pmladek@suse.com> wrote:
> >> +/*
> >> + * A variant of console_trylock() that allows specifying if the context may
> >> + * sleep. If yes, a trylock on @console_sem is attempted and if successful,
> >> + * the threaded printers are paused. This is important to ensure that
> >> + * sleepable contexts do not become involved in console_lock handovers and
> >> + * will call cond_resched() during the printing loop.
> >> + */
> >> +static int console_trylock_sched(bool may_schedule)
> >> +{
> >> +	if (!may_schedule)
> >> +		return console_trylock();
> >> +
> >> +	might_sleep();
> >> +
> >> +	if (down_trylock_console_sem())
> >> +		return 0;
> >> +	if (console_suspended) {
> >> +		up_console_sem();
> >> +		return 0;
> >> +	}
> >> +	pause_all_consoles();
> >
> > This is weird. Any trylock function should be fast and non-blocking.
> > But pause_all_consoles() uses mutex_lock().
> >
> > My expectation would be that console_trylock_sched() behaves
> > excatly the same as console_trylock() except that it will
> > set console_may_schedule by the given parameter.
> >
> > I would do it the other way. Rename console_trylock() and
> > implement:
> >
> > int console_trylock(void)
> > {
> > 	return console_trylock_sched(false);
> > }
> >
> > LATER: I got it. It is used by console_trylock_sched() called
> >        in console_unlock() when "do_cond_resched == true". In this
> >        case, the trylock might wait for the mutexes. It will prevent
> >        transfering console_lock from schedulable to atomic context
> >        by the check in console_emit_next_record().
> 
> Yes!
> 
> >        Hmm, I would still prefer to keep console_trylock_sched()
> >        behavior sane: non-blocking in all situations. It means
> >        that we actually do not need it and console_trylock()
> >        is enough.
> >
> >        It will allow to steal console_lock() from schedulable
> >        context. But it is not a regression. And it is only
> >        a corner case when console_unlock() re-takes the semaphore
> >        after releasing it.
> 
> A console waiter must not wait on a schedulable context. The console
> waiter is burning the CPU waiting for a transfer. If the console owner
> gets scheduled away while still holding the console lock, that is bad.

There must be a confusion. Of course, preemption must be disabled
when the current console_lock() owner allows to take over the lock.
It is currently achieved by disabling interrupts:

	printk_safe_enter_irqsave(flags);
	console_lock_spinning_enable();

	call_console_driver(con, write_text, len, dropped_text);

	*handover = console_lock_spinning_disable_and_check();
	printk_safe_exit_irqrestore(flags);


I wanted to say that it is safe even when the preemption is otherwise
enabled around this code.

Also I wanted to say that it is not ideal when the current owner
is called with preemption enabled and the new owner will continue
handling consoles with preemption disabled. But the original code
worked this way.

It would be nice to avoid moving the lock from a preemptive context
to non-preemptive one. But I would prefer to do it separately
because the proposed console_trylock_sched() is really controversial.
IMHO, it is not worth delaying this patchset because of this.


> >        We could do the same optimization in console_unlock() by
> >        calling console_emit_next_record() with NULL handover pointer
> >        when do_cond_resched == true. But we should do it
> >        as a separate patch later.
> 
> It is not an optimization, it is needed. Passing a NULL handover pointer
> when do_cond_resched == true would handle it correctly, but this feels
> like a workaround to me.
>
> The reason for adding console_trylock_sched() is because a context that
> previously acquired the console lock via console_lock() wants to try to
> reacquire it. If it reacquires the console lock using the kthread
> mutexes, the locking scenario returns to the same as it was
> before... all kthreads are blocked via their mutex.
> 
> You are suggesting that a console_lock() context later tries to
> reacquire the console lock, but using the console_trylock() method
> (atomic counter) and keeping console_may_schedule=1.
> 
> IMHO, _this_ is a weird variant that requires passing in a NULL handover
> pointer as a workaround. It introduces a third locking scenario where a
> schedulable context is using functions created for atomic use.
>
> Also, as I mentioned in the percpu thread [0], I think we need to avoid
> console_trylock() usage in schedulable contexts. Functions need to be
> aware in what contexts they are running and call the appropriate
> functions for it.

Let's put the NULL parameter aside. It is an implementation detail.
It can be handled by another parameter or so.

IMHO, the main disagreement is:

   + I do not like the proposed console_trylock_sched() API because
     it uses mutex_lock().

     From my POV, it can obviously cause deadlock. It is something
     that nobody would expect from any *_trylock() API. IMHO,
     it is a ticking bomb.


   + You do not like that console_lock()/console_unlock() might
     re-take the lock using another approach (atomic counter
     vs. con->flags.

     From your POV, using non-blocking console_trylock() in
     console_unlock() would be 3rd locking scheme. Also you say that
     that the caller should know the context and use the appropriate
     function.


Let me try to persuade you ;-)

1. Regarding the 3rd locking scheme:

   It is exactly the opposite from my POV. console_trylock_sched()
   looks like a 3rd locking variant to me. We would have blocking
   console_lock(), non-blocking console_trylock(), and semi-blocking
   console_trylock_sched().

   And it is even worse. console_trylock_sched() behaves differently
   according to the parameter. It makes is even more hard to
   understand the behavior.


2. Regarding using appropriate function:

   Let's see how it looks in the code:

       printk()
           preempt_disable()

           console_trylock()
           console_unlock()
               // printing
               up_console_sem()
               retry = console_trylock_sched();

   It feels like using sleeping lock in a non-preemptive context.
   OK, we could make it more obvious:

   console_unlock()
   {
	  [...]
	  if (may_schedule)
	      retry = console_trylock_sched();
	  else
	      retry = console_trylock();
   }

   But it is yet another complexity in console_unlock().
   Is it really necessary?


3. Implementation detail:

  From my POV, the way how console_lock()/console_trylock() takes
  the lock is an implementation detail.

  console_lock() uses con->flags because it can and actually must
  wait/sleep. console_trylock() uses the atomic counter because
  it must not block.

  We hide this implementation detail in __console_unlock(). It
  releases the lock the same way as it was taken.


4. may_schedule vs. handover

  The information whether console_unlock() may schedule is stored in
  @console_may_schedule variable. console_lock() allows scheduling
  and console_trylock() disables scheduling.

  console_emit_next_record() allows handover according to
  the atomic counter. It is set by the way how console_lock
  was taken. console_lock() disables handover. console_trylock()
  enables handover.

  Now, console_trylock_sched() is needed to re-take the lock
  the same way as it was taken originally. Otherwise,
  the atomic counter will be used even when scheduling was enabled.
  As a result, console_emit_next_record() would work differently.

  By other word, console_trylock_sched() is used to encode
  @console_may_schedule into @console_lock_count.

  It looks like a hack similar to passing NULL *handover. But from my POV,
  it is much worse. The price is console_trylock_sched() API with
  very strange behavior. It is super tricky. It took me hours to
  understand the motivation and behavior.

  From, my POV, the most clear solution is to pass "may_schedule"
  parameter to console_emit_next_record().


Does it make sense, please?
Do I miss anything, please?

Best Regards,
Petr
