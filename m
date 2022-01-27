Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5854949E145
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 12:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240587AbiA0LiF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 06:38:05 -0500
Received: from smtp-out1.suse.de ([195.135.220.28]:42130 "EHLO
        smtp-out1.suse.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240577AbiA0LiD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 06:38:03 -0500
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out1.suse.de (Postfix) with ESMTP id A10AF218BB;
        Thu, 27 Jan 2022 11:38:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1643283482; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=AjNKKZf69TEijpgyWnhYdAsstA7e3sJmGRaS2vfo0Bs=;
        b=QtHxkuGDMMPqfVOn8ckDd61qxMZWQD+qJcWlqHMRr6jdDaWvd5Pc+pZp3MPAAw5wCBeQXP
        3jj/AzwtM23fMOUVdkM0+Mqsn59AgG9urVOVNDysFINEHA3Dk8qctkcTasfLNrO3PvAP4l
        VE8atQu6F4T8XlkxveLNt67stByXr6M=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 4A083A3B85;
        Thu, 27 Jan 2022 11:38:02 +0000 (UTC)
Date:   Thu, 27 Jan 2022 12:38:02 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     Sergey Senozhatsky <senozhatsky@chromium.org>
Cc:     Stephen Brennan <stephen.s.brennan@oracle.com>,
        John Ogness <john.ogness@linutronix.de>,
        Steven Rostedt <rostedt@goodmis.org>,
        Sergey Senozhatsky <sergey.senozhatsky@gmail.com>,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/4] printk: disable optimistic spin during panic
Message-ID: <YfKEGg0zQqXBVqGG@alley>
References: <20220121190222.572694-1-stephen.s.brennan@oracle.com>
 <20220121190222.572694-3-stephen.s.brennan@oracle.com>
 <YfER7tlXZZpX94c9@google.com>
 <87r18un83x.fsf@jogness.linutronix.de>
 <YfEdNKWI7GqKr9P/@google.com>
 <87tudqwegy.fsf@stepbren-lnx.us.oracle.com>
 <YfJFjHdg/khNXiRd@google.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfJFjHdg/khNXiRd@google.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu 2022-01-27 16:11:08, Sergey Senozhatsky wrote:
> On (22/01/26 10:15), Stephen Brennan wrote:
> [..]
> > > On (22/01/26 10:51), John Ogness wrote:
> > >> > Is there something that prevents panic CPU from NMI hlt CPU which is
> > >> > in console_trylock() under raw_spin_lock_irqsave()?
> > >> >
> > >> >  CPU0				CPU1
> > >> > 				console_trylock_spinnning()
> > >> > 				 console_trylock()
> > >> > 				  down_trylock()
> > >> > 				   raw_spin_lock_irqsave(&sem->lock)
> > >> >
> > >> >  panic()
> > >> >   crash_smp_send_stop()
> > >> >    NMI 			-> 		HALT
> > >> 
> > >> This is a good point. I wonder if console_flush_on_panic() should
> > >> perform a sema_init() before it does console_trylock().
> > >
> > > A long time ago there was zap_locks() function in printk, that used
> > > to re-init console semaphore and logbuf spin_lock, but _only_ in case
> > > of printk recursion (which was never reliable)
> > >
> > > https://git.kernel.org/pub/scm/linux/kernel/git/stable/linux.git/tree/kernel/printk/printk.c?h=v4.9.297#n1557
> > >
> > > This has been superseded by printk_safe per-CPU buffers so we removed
> > > that function.
> > >
> > > So it could be that may be we want to introduce something similar to
> > > zap_locks() again.
> > >
> > > All reasonable serial consoles drivers should take oops_in_progress into
> > > consideration in ->write(), so we probably don't care for console_drivers
> > > spinlocks, etc. but potentially can do a bit better on the printk side.
> > 
> > I see the concern here. If a CPU is halted while holding
> > console_sem.lock spinlock, then the very next printk would hang, since
> > each vprintk_emit() does a trylock.
> 
> Right. So I also thought about placing panic_in_progress() somewhere in
> console_trylock() and make it fail for anything that is not a panic CPU.
> 
> > Now in my thousands of iterations of tests, I haven't been lucky enough
> > to interrupt a CPU in the middle of this critical section. The critical
> > section itself is incredibly short and so it's hard to do it. Not
> > impossible, I'd imagine.
> 
> I can imagine that the race window is really small, and I'm not insisting
> on fixing it right now (or ever for that matter).
>
> Basically, we now have two different "something bad is in progress"
> that affect two different ends of the calls stack. bust_spinlocks()
> sets oops_in_progress and affects console drivers' spinlocks, but has
> no meaning to any other printk locks. And then we have panic_in_progress()
> which is meaningful to some printk locks, but not to all of them, and is
> meaningless to console drivers, because those look at oops_in_progress.

Good point! It looks a bit non-consistent and I am sure that we could
do better.

Well, my view is that there are contexts:

1. oops_in_progress is used when printing OOps report and panic().

   The important thing is that the system might continue working
   after OOps when "panic_on_oops" is not defined.

   Many console drivers allow to enter locked section even when the lock
   is already teaken. But they prevent double unlock.

   The aim is to show OOps messages on the console because they system
   might silently die otherwise.


2. The new panic_in_progress() context says that the system is really
   dying.

   The system should try hard to show the messages on console but
   still a safe way. It should not risk breaking other ways to store
   debugging information: kdump, kmsg_dump, and panic notifiers.

   I mention notifiers because some inform the hypervisor about the
   panic. The hypervisor could get some debugging information as well.


3. console_flush_on_panic() is the last attempt to show to messages
   on the console.

   It is done after kdump, kmsg_dump, and notifiers. consoles are
   the only concern here. So it could be more agressive and risk more.


Honestly, I never thought much about oops_in_panic context. All
the past discussion were focused on panic.

Also we focused on lowering the risk by introducing lockless algorithms
or fixing bugs. I can't remember moving some risky operation earlier.
Also we were reluctant to change the risk level (algorithm) when it
was not obvious or at least promising that it makes things better.


> If printk folks are fine with that then I'm also fine.
> 
> > We can't fix it in console_flush_on_panic(), because that is called much
> > later, after we've called the panic notifiers, which definitely
> > printk(). If we wanted to re-initialize the console_sem, we'd want it
> > done earlier in panic(), directly after the NMI was sent.

I am not sure if it is worth the risk. You want to reinitialize the
semaphore because a small race window in the internal spin lock.
But it will allow to enter a lot of code that is guarded by console_sem.

I mean that chance of dealock caused by the internal semaohore spin
lock is super small. In compare, a lot of tricky code is guarded
by console_sem. It looks like a big risk to ignore the semaphore
early in panic().

A better solution would be to use raw_spin_trylock_irqsave() in
down_trylock().

Best Regards,
Petr
