Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0BC8C50B7D9
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 15:04:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1447702AbiDVNGj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 09:06:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42024 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233857AbiDVNGh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 09:06:37 -0400
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7594F57B32
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 06:03:43 -0700 (PDT)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id 2FCA41F388;
        Fri, 22 Apr 2022 13:03:42 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1650632622; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JbXUkFhQVwKyques3iepFbIe7EDjr4sba6A0eegd0mE=;
        b=XCkUpTcOh7SvDykCOQcx2zbN3Xd6WaTsrTFHjiy5eKs2ZZXPi9JT2fQvxi6HQPjXeTt8pj
        Dwv4Dl2ADB99BvTGP5TeMDmI0Q6dqeausi5MgXElXkC/dkX1ShexyTMPREQXrZW4qyl8om
        XPbC/T8T+HQ/x6y+JFEzGLLCM3uJLM0=
Received: from suse.cz (unknown [10.163.26.26])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8974B2C14E;
        Fri, 22 Apr 2022 13:03:41 +0000 (UTC)
Date:   Fri, 22 Apr 2022 15:03:35 +0200
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v3 14/15] printk: extend console_lock for proper
 kthread support
Message-ID: <YmKnp3Ccu7laW3E4@alley>
References: <20220419234637.357112-1-john.ogness@linutronix.de>
 <20220419234637.357112-15-john.ogness@linutronix.de>
 <20220421124119.GB11747@pathway.suse.cz>
 <875yn2h5ku.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <875yn2h5ku.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-04-21 16:36:25, John Ogness wrote:
> On 2022-04-21, Petr Mladek <pmladek@suse.com> wrote:
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -2603,9 +2666,10 @@ static int console_cpu_notify(unsigned int cpu)
> >>  		/* If trylock fails, someone else is doing the printing */
> >>  		if (console_trylock())
> >>  			console_unlock();
> >> -
> >> -		/* Wake kthread printers. Some may have become usable. */
> >> -		wake_up_klogd();
> >> +		else {
> >> +			/* Some kthread printers may have become usable. */
> >> +			wake_up_klogd();
> >
> > Do you have any particular scenario in mind, please?
> > Could CPU hotplug put any printk kthread into a sleep?
> 
> I do not have a particular scenario. My reasoning was that a CPU coming
> online would affect the conditions of __console_is_usable() for consoles
> without CON_ANYTIME. Of course, it would mean that previously a kthread
> went to sleep because it was trying to print from a CPU that was
> offline. I am doubtful that such a scenario is possible. But you did
> uncover some bizarre code paths where task migration could fail during
> CPU offlining.
> 
> Anyway, you suggested to keep the CON_ANYTIME checks for kthreads in
> there. So it seems correct to wake threads anytime the
> printer_should_wake() conditions change.

Makes sense. Thanks for updating the comment in v4.


> >> @@ -2625,11 +2689,33 @@ void console_lock(void)
> >>  	down_console_sem();
> >>  	if (console_suspended)
> >>  		return;
> >> +	console_kthreads_block();
> >>  	console_locked = 1;
> >>  	console_may_schedule = 1;
> >>  }
> >>  EXPORT_SYMBOL(console_lock);
> >>  
> >> +/*
> >> + * Lock the console_lock, but rather than blocking all the kthread printers,
> >> + * lock a specified kthread printer and hold the lock. This is useful if
> >> + * console flags for a particular console need to be updated.
> >> + */
> >> +void console_lock_single_hold(struct console *con)
> >> +{
> >> +	might_sleep();
> >> +	down_console_sem();
> >> +	mutex_lock(&con->lock);
> >> +	console_locked = 1;
> >> +	console_may_schedule = 1;
> >
> > This looks wrong. It is a global flag that could be modified
> > only when all consoles are blocked.
> 
> You are correct. is_console_locked() needs to return false in this
> scenario. I will leave out the @console_lock setting and insert a
> comment to clarify why.
> 
> > This API blocks only the single console. The other consoles are still
> > allowed to print actively.
> 
> That is the point. VT does not care about the other printers. VT is
> using @console_locked to protect itself against itself.
> 
> > Another problem will appear with the 15th patch. It will remove
> > console_locked variable and is_console_locked() will not longer
> > be aware that this console is locked. We will not know that
> > it might cause deadlock in the VT code.
> 
> >From the perspective of VT code the console is _not_ locked. So
> is_console_locked() should return false. is_console_locked() is to make
> sure that the _VT code_ has called console_lock()/console_trylock(). So
> the 15th patch is still correct.

I see. I was not sure about the exact purpose in the VT code. Anyway,
it is clear that the locking is really complicated here.


> >> @@ -2728,17 +2834,18 @@ static void __console_unlock(void)
> >>   *
> >>   * @handover will be set to true if a printk waiter has taken over the
> >>   * console_lock, in which case the caller is no longer holding the
> >> - * console_lock. Otherwise it is set to false.
> >> + * console_lock. Otherwise it is set to false. A NULL pointer may be provided
> >> + * to disable allowing the console_lock to be taken over by a printk waiter.
> >>   *
> >>   * Returns false if the given console has no next record to print, otherwise
> >>   * true.
> >>   *
> >> - * Requires the console_lock.
> >> + * Requires the console_lock if @handover is non-NULL.
> >
> >     * Requires con->lock otherwise.
> 
> Right. I will update the comments.
> 
> >>   */
> >> -static bool console_emit_next_record(struct console *con, char *text, char *ext_text,
> >> -				     char *dropped_text, bool *handover)
> >> +static bool __console_emit_next_record(struct console *con, char *text, char *ext_text,
> >> +				       char *dropped_text, bool *handover)
> >>  {
> >> -	static int panic_console_dropped;
> >> +	static atomic_t panic_console_dropped = ATOMIC_INIT(0);
> >>  	struct printk_info info;
> >>  	struct printk_record r;
> >>  	unsigned long flags;
> >> @@ -3261,6 +3401,8 @@ void register_console(struct console *newcon)
> >>  
> >>  	newcon->dropped = 0;
> >>  	newcon->thread = NULL;
> >> +	newcon->flags |= CON_THD_BLOCKED;
> >
> > Just to show the complexity added by console_lock_single_hold():
> >
> > It took me some time to realize that it is correct. The flag
> > is needed because the console will be added under console_lock().
> > The flag would not be needed when it was added under
> > console_lock_single_hold().
> 
> ?? But it is not added under
> console_lock_single_hold(). console_lock_single_hold() is not a
> replacement for console_lock(). Their purpose is very
> different. console_lock_single_hold() is an internal function to provide
> synchronization for @flags and @thread updates of a single console.
>
> Maybe we are getting caught in my "bad naming" trap again. :-/

From my POV, the problem was that the real purpose was far from
clear and it was not mentioned anywhere. If it was mentioned
then it was too cryptic for me. The comments focused too
much on the possibility to do some changes without disturbing
other kthreads.

> We need a method to provide @flags synchronization between the kthreads
> and console_stop(). Keep in mind that console_lock() does *not* hold the
> mutexes. So a completed console_lock() call does *not* mean that the
> kthreads are sleeping. They could still lock their own mutex and keep
> going. It is not until the kthreads see that CON_THD_BLOCKED is set that
> they realize they are not supposed to be running and go to sleep.
> But console_stop() could be performing an update to @flags while that
> kthread is checking it. It is a data race in code that should be
> synchronized.

Nice derscription of the problem.


> I spent some time trying to find a good solution for this. Here are the
> ideas that I came up with:
> 
> 1. Use READ_ONCE(short)/WRITE_ONCE(short) because probably that is
>    enough to guarantee atomic writes/reads on all platforms.
> 
> 2. Make @flags atomic_t. This guarentees consistence but would require
>    changing how all consoles initialize that field.
> 
> 3. Create a separate @enabled boolean field in struct console so that
>    data races do not matter. This would also change how all consoles
>    initialize their struct.

> 4. Provide a new function that uses the mutex to synchronize, since the
>    kthread is already using the mutex.
> 
> I ended up choosing #4 because it had the added benefit of allowing
> console_start(), console_stop(), console_unregister() to avoid affecting
> the other kthreads.

IMHO, it is actually a generic problem of the complex locking scheme
when there are too many combinations of the protected data.
In the current state, the problem seems to be only with CON_ENABLED
flag but there might be other hidden races in the future.

IMHO, it would be much easier when there are the following rules:

   + console_lock() blocks taking con->lock
   + con->lock blocks taking console_lock()
   + Different con->lock might be taken in parallel

The result would be:

   + global variables need to be guarded by the big console_lock()
   + con->lock should be enough to guard per-console variables
   + the big console_lock() would serialize also access to
     per-console variables.

Of course, it is not that simple. I am not 100% that we could
even achieve this. Anyway, I think about the following
wrapper:

void single_console_lock(struct console *con)
{
	for (;;) {
		error = wait_event_interruptible(log_wait,
					con->flags & CON_THB_BLOCKED);

		if (error)
			continue;

		mutex_lock(&con->lock);

		if (!con->flags & CON_THB_BLOCKED)
			break;

		mutex_unlock(&con->lock);
	}
}

void single_console_unlock(struct console *con)
{
	mutex_unlock(&con->lock);
}

We should use it everywhere instead of the simple mutex_lock(con->lock)
and mutex_lock(con->lock). And we could remove mutex_lock()/unlock()
from code called under the big console_lock().

How does it sound, please?

Best Regards,
Petr
