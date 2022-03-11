Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C33D54D5F75
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 11:27:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347889AbiCKK1n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 05:27:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47688 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347865AbiCKK1k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 05:27:40 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C2167C792
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 02:26:37 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id F0A521F38D;
        Fri, 11 Mar 2022 10:26:35 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646994395; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=iDHlRfevwYuO53uWfkV+3+6vj5gqnO1eqvyOtlQyFUg=;
        b=IjA2cc+VwQHHyl5Izis9qUmfgpFP18q2zzaMlOqmSs4L8tvMLjUE7mf6BUNiMD1sPyL34L
        HTtI+XuU0sZu+GNEzo7ITyxbrC1zH4qRIxcR8sEjGMcaMnABHlwq3M568gsQsxjqlxIWQF
        UMMyIlO6Uo7kSzyo/Rp1SQQMmYatG1Y=
Received: from suse.cz (unknown [10.100.216.66])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id AE63BA3B88;
        Fri, 11 Mar 2022 10:26:35 +0000 (UTC)
Date:   Fri, 11 Mar 2022 11:26:32 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
Message-ID: <Yisj2PEtjZfHMe6N@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <YhYKP/UuSKENGwfj@alley>
 <87tuc7xma0.fsf@jogness.linutronix.de>
 <YioMcSe0P0Z7ksiW@alley>
 <87wnh14wp9.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87wnh14wp9.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-03-10 17:14:18, John Ogness wrote:
> On 2022-03-10, Petr Mladek <pmladek@suse.com> wrote:
> >    console_unlock()
> >    {
> > 	  [...]
> > 	  if (may_schedule)
> > 	      retry = console_trylock_sched();
> > 	  else
> > 	      retry = console_trylock();
> >    }
> 
> I believe the main confusion comes from the function name I chose and
> the poor function description. Using your above code idea and changing
> to a more fitting name, I would suggest:
> 
>     console_unlock()
>     {
>  	  [...]
>  	  if (may_schedule)
>  	      retry = console_lock_reacquire();
>  	  else
>  	      retry = console_trylock();
>     }
> 
> This console_lock_reacquire() acquires the console lock the same way
> that console_lock() does it. The only reason we don't just use
> console_lock() is because we want to perform a try on @console_sem. But
> if we are successful, in the end, we have re-taken the console lock
> exactly as console_lock() did before: @console_sem locked, kthreads
> blocked by mutex.
> 
> You say this creates deadlock potential, but I do not see how that could
> be. We are in the same context and locking the same way we did before.

Yeah, it looks safe when using to re-acquire the lock in console_unlock().

I thought about it as a generic API. If it exists, it might be used
anywhere. And it has pretty special behavior that one has to keep
in mind.


> But my primary concern is not the naming or workarounds or confusing
> APIs. So we should not let ourselves be diverted by that aspect.
> 
> My primary concern is the technical difference when a schedulable
> context reacquires via atomic counter (which fails if any kthread is
> active) vs. reacquiring via mutex (which never fails).
> 
> The reason for the reacquire is because (during direct printing) we see
> that a new record appeared and we need to make sure it gets printed
> (because other direct printers may have aborted, expecting us to print
> it).

I see. I missed this POV.


> This scenario is only interesting if kthread printers exist because
> otherwise @console_sem is enough to handle the direct printing.
> 
> So the questions are:
> 
> 1. Is it OK to assume the new record will be printed if any kthread is
> active? If yes, then it is enough to use the atomic counter.
> 
> 2. Or, since we are responsible for direct printing, do we want to be
> certain that the record is printed by printing it ourselves? If yes,
> then we must block all the kthreads and perform the printing directly to
> all the consoles. This requires the mutex approach.
>
> IMHO #1 will relies heavily on kthreads waking up and printing (even
> though the printk caller requested direct printing), whereas #2 will
> cause direct printers to more actively print (possibly printing more
> than was requested).

OK, it means that the main problem here _is not_ the scheduling context,
console_lock() vs. console_trylock(). The main problem _is_ the direct
printing vs. the offload to kthreads.

Of course, the context is important. It affects how we could re-take
the lock. But the main problem is the printing mode. We must make sure
that:

    1. someone is printing pending messages when the direct mode is needed

    2. kthreads are woken and can enter the printing mode when the direct
       mode is disabled.

Will console_trylock_sched()/console_trylock_reacquire() really
help here?

The API theoretically helps in direct mode when the lock was taken
via console_lock(). But it does not help when the lock was taken
via console_trylock() from printk(). It might mean that
the forward progress might not be guaranteed in the direct mode
(early boot, panic, ...).

Hmm, the forward progress seems to be guaranteed in the direct
mode most of the time. console_trylock() can take over
the atomic counter because console kthreads are not allowed
to enter the printing mode in this case.

I used "most of the time" because there might be races when
the mode is switched. "printk_direct" is an atomic variable.
CON_DIRECT is set under con->mutex but console_trylock()
does not take the mutex...

There are also races when the offload to consoles kthreads
is allowed. For example, console_trylock() might block
console_kthread_printing_tryenter().


Sigh, I am afraid that we have non-trivial problems
to guarantee that all messages will be printed:

     + races when switching between direct mode
       and offload to kthreads. It might cause
       stall in both modes.

     + console_trylock() races with
       console_kthread_printing_tryenter().
       It might put kthread into a sleep even when
       it is supposed to print the message.


IMHO, console_trylock_sched() does not help much here.
We need to solve console_trylock() path anyway.

I think that the solution might be:

   + make sure that the state of "printk_direct" atomic variable
     is enough to distinguish about the mode.

   + always wakeup() console kthreads after console_trylock()
     to handle the possible race with
     console_kthread_printing_tryenter()

I have to think more about it.

Does it make any sense, please?

Best Regards,
Petr
