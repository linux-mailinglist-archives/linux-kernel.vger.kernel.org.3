Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5BC504D625E
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 14:28:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348852AbiCKN3t (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 08:29:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229620AbiCKN3s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 08:29:48 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [193.142.43.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B62D5C646
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 05:28:43 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647005321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8b3QE+2Y//YI4P+mljHaBD8D8T+OxSZZ+Uwuw/8XGvY=;
        b=AV2oT3KyFK+ccwT+qVs6o/cV3q8FZUL7xruM+BswA0iR4+Jm7Vqhd91b+G+ZDtsfaWo8HN
        a4huzFHL0ypPB9UHx3QMR4jXxQRMB6E/KxNAsTMvtgw+CDt15pUDEJ9ZGa1AsEo6TVGCRk
        LKjo7WdYJyFxRCb6UBfB7tIjvniSEKlpLfNUY+8YRukKqo9XnyLHtCBQJNpTmUbjeJHPLi
        Yela1DTuX9B/h0ZSy9AT41NxnqLwGhmjkN+yFUIos4eXQ2x1H+t/HyVacl2G4S4VRDztKF
        nZQABXfGhyp28RrZB6jKF0wqjU1SuZl5/PjYLL+GWtAnSrTx/iqjZFzVmK418w==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647005321;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=8b3QE+2Y//YI4P+mljHaBD8D8T+OxSZZ+Uwuw/8XGvY=;
        b=UNzhiAhvENYbRzJL8c6NiuJec65ZJb32An6tEXj2tofrpbwgngxPVkR3mJXG9wajA5f3AC
        8BFB9kLTyrLcuaCw==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
In-Reply-To: <Yisj2PEtjZfHMe6N@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <YhYKP/UuSKENGwfj@alley> <87tuc7xma0.fsf@jogness.linutronix.de>
 <YioMcSe0P0Z7ksiW@alley> <87wnh14wp9.fsf@jogness.linutronix.de>
 <Yisj2PEtjZfHMe6N@alley>
Date:   Fri, 11 Mar 2022 14:34:40 +0106
Message-ID: <87czisbotz.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain
X-Spam-Status: No, score=-3.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,INVALID_DATE_TZ_ABSURD,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-03-11, Petr Mladek <pmladek@suse.com> wrote:
>>     console_unlock()
>>     {
>>  	  [...]
>>  	  if (may_schedule)
>>  	      retry = console_lock_reacquire();
>>  	  else
>>  	      retry = console_trylock();
>>     }
>> 

[...]

> OK, it means that the main problem here _is not_ the scheduling context,
> console_lock() vs. console_trylock(). The main problem _is_ the direct
> printing vs. the offload to kthreads.
>
> Of course, the context is important. It affects how we could re-take
> the lock. But the main problem is the printing mode. We must make sure
> that:
>
>     1. someone is printing pending messages when the direct mode is needed

console_trylock() causes difficulties here because it will fail if any
kthread is active. It is an example of direct mode failure. But is that
really any different than current mainline console_trylock() failing
because a console_lock() context is active (and possibly not scheduled
on a CPU)?

>     2. kthreads are woken and can enter the printing mode when the direct
>        mode is disabled.

This happens at the end of vprintk_emit() and within __console_unlock(),
regardless if the printk() was running in direct mode or not.

> Will console_lock_reacquire() really help here?
>
> The API theoretically helps in direct mode when the lock was taken
> via console_lock().

console_lock_reacquire() only exists for the console_lock() case.

> But it does not help when the lock was taken
> via console_trylock() from printk(). It might mean that
> the forward progress might not be guaranteed in the direct mode
> (early boot, panic, ...).

How is the console_trylock() case different from current mainline now?
As I mentioned above, the kthreads can block console_trylock(), but so
can a console_lock() currently in mainline.

> Hmm, the forward progress seems to be guaranteed in the direct
> mode most of the time. console_trylock() can take over
> the atomic counter because console kthreads are not allowed
> to enter the printing mode in this case.
>
> I used "most of the time" because there might be races when
> the mode is switched. "printk_direct" is an atomic variable.
> CON_DIRECT is set under con->mutex but console_trylock()
> does not take the mutex...

You are mixing issues here. If CON_DIRECT is set, there is already a
console_lock() in progress, so console_trylock() fails on @console_sem.

> There are also races when the offload to consoles kthreads
> is allowed. For example, console_trylock() might block
> console_kthread_printing_tryenter().

I do not see how that is a problem. If any context has the console lock
(no matter how it got that lock) then the kthreads are blocked.

If direct printing is enabled (from @printk_direct or @oops_in_progress
or @system_state != SYSTEM_RUNNING), the task with the console lock will
print out *all* the remaining records.

If direct printing is not enabled, the kthreads are woken in
__console_unlock().

> Sigh, I am afraid that we have non-trivial problems
> to guarantee that all messages will be printed:
>
>      + races when switching between direct mode
>        and offload to kthreads. It might cause
>        stall in both modes.

Scheduable contexts holding locks can cause stalls. We have that same
problem with console_lock() in mainline now. The kernel provides
mechanisms to avoid such stalls (niceness, priorities, policies,
priority inheritance), but this is all problem-specific and must be
fine-tuned by the user if they are running workloads that are causing
problems. kthreads are not solving the reliability problem (and they
never will).

>      + console_trylock() races with
>        console_kthread_printing_tryenter().
>        It might put kthread into a sleep even when
>        it is supposed to print the message.

kthread is never _supposed_ to print a message. It is there to offload
direct printing. If console_trylock() (direct printing) wins, then that
is the context that does the printing.

> IMHO, console_lock_reacquire() does not help much here.
> We need to solve console_trylock() path anyway.

It preserves a consistent locking scenario for the console_lock()
path. That is all it is intended to do.

> I think that the solution might be:
>
>    + make sure that the state of "printk_direct" atomic variable
>      is enough to distinguish about the mode.

The printk subsystem does not have absolute control over which
task/context is doing the actual printing. Currently in mainline there
are printers that handoff to waiters and even some that do not print at
all because there is already waiters. Adding kthreads introduces a new
task that can print. But there still is no real control about who
prints. The important thing is that there is some context or runnable
task that is running the printing code (whether scheduled or not).

>    + always wakeup() console kthreads after console_trylock()
>      to handle the possible race with
>      console_kthread_printing_tryenter()

I do not understand. If console_trylock() wins, it already wakes the
kthreads on __console_unlock(). If console_trylock() loses, the kthreads
are already running.

John
