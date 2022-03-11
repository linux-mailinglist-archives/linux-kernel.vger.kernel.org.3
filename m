Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8983F4D6AA4
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:27:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229555AbiCKWq4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:46:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229490AbiCKWqj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:46:39 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5363F187B82
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:21:54 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1647037312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GUT/XyD1JmdUBh6NMIEZcouy3zdM2rhgSG8nRivlBD4=;
        b=nJOnpcpBPWfS58FCKN34a+fkJWfXBpXHZ41n0ZpHMtFnx7awS25HQM/+sGx70DpJxBz4Vp
        18EF1A1IJfUCHEDZdVH19DkTg3y1P5JVoJrhuyQmu63BqAarIUy8oe1S2Dbk5NO1mbnVdB
        bfQiuumu4eJygp3dKY3C+eTwY+QSxlyelnF52qWJNF4YRCNmJXALDhH67LNBebcicpvWxO
        c6zNWVqp+6VU389hqdyGar0WsNnF9lTs39k47Ltr9VPXrA+qhcbZcMKN/WBHFHsB3PRqcC
        DVp400en0JJBuuDGI+5vC4t2Gl//EDy/8edvvzDQBnna24ieFaaFFihWbTDDAA==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1647037312;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=GUT/XyD1JmdUBh6NMIEZcouy3zdM2rhgSG8nRivlBD4=;
        b=E0GPIWBfLQAFFedY+cXguy4HoKZBdGIOyjCZI5Ppe3ZWNuDA3V8lwvfeMuYxXiB3LxpRfP
        Bh0XxJlKwgvcUPCg==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
In-Reply-To: <Yit2LN1nCaiUo5y4@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <YhYKP/UuSKENGwfj@alley> <87tuc7xma0.fsf@jogness.linutronix.de>
 <YioMcSe0P0Z7ksiW@alley> <87wnh14wp9.fsf@jogness.linutronix.de>
 <Yisj2PEtjZfHMe6N@alley> <87czisbotz.fsf@jogness.linutronix.de>
 <Yit2LN1nCaiUo5y4@alley>
Date:   Fri, 11 Mar 2022 23:27:51 +0106
Message-ID: <87tuc4yvsw.fsf@jogness.linutronix.de>
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

Hi Petr,

I do not think the example below is showing what you think it does, but
it does shed light on an important point.

On 2022-03-11, Petr Mladek <pmladek@suse.com> wrote:
> CPU0			CPU1			CPU2
>
> printk()
>   // direct mode allowed

OK, so @printk_direct is >= 1.

>   console_trylock()
>   console_unlock()
>     console_flush_all()
>
> 			printk_direct_enter()

@printk_direct is now >= 2.

>
>       allows_direct_printing() -> false;

I do not understand why you say it returns false. @printk_direct is not
zero. This returns _true_ and will print all records currently in the
ringbuffer.

>       break;
>
>       __console_unlock()
>         wakeup_klogd()

Note that all kthreads wake here. To keep it simple, let us assume there
is only 1.

> 						// woken printk_khread

The kthread will only go into its printing loop if new records have
appeared after the above __console_unlock(). If any did appear, _that_
printk() will attempt to print them because direct printing is
active. But let us assume that the kthread on CPU2 woke up before the
new printk() context could attempt a console_lock() or
console_trylock().

> 						console_thread_printing_enter()

@console_lock_count is now 1. Now console_lock() and console_trylock()
will block or fail, respectively.

> 			printk_direct_exit()

@printk_direct is now >= 1.

>       console_trylock()
>         atomic_tryblock()
> 	  //fails because thread active

Correct. (Note that if CPU0 had been in a console_lock() context, it
would _not_ fail because console_lock_reacquire() would wait for the
active kthreads to finish their current record.)

>    return;
>
> 			printk_direct_enter()

@printk_direct is now >= 2.

> 						console_thread_printing_exit()

Note that CPU2 would have printed a single record.

> 						// sleep because
> 						atomic_read(&printk_direct) is not
> 						zero

No, the kthread does not sleep. It will continue printing until it is
blocked via console_lock()/console_trylock() or until all the records
are printed.

> Result: nobody prints

Sorry, but I have no idea how you came to that conclusion.

> Note: The thread will actually not sleep because printk_should_wake()
>       does not check atomic_read(&printk_direct).

Exactly.

>       But it is a bug. Active thread should check it and allow
>       entering direct mode.

We are in direct mode this entire example. I do not understand what you
mean by "allow entering direct mode". Perhaps you mean "allow
console_trylock() to succeed".

If that is what you mean, then you are suggesting that the
console_trylock() spins until all the kthreads have finished their
current record. This could be a new variant of console_trylock().

And then rather than continuing their printing loop, the kthreads all
stay asleep as long as @printk_direct is non-zero (in addition to the
existing sleep conditions).

This could work if the kthreads disable preemption for the
console_thread_printing_enter()/_exit() window.

Although it should be noted that this still will not help if a
console_lock() context is scheduled out.

> Note2: Even when one printk thread flushes the messages. There might
>        be other thread that will never get scheduled a nobody would
>        printk the messages on the related console.

That is what atomic consoles are for. Until atomic consoles are
available, that situation is covered by @oops_in_progress and
console_flush_on_panic().

> This is the race that I see with console_trylock(). IMHO, if we solve
> this race then we do not need console_lock_reacquire().

I do not understand why you continue to mix console_trylock() and
console_lock_reacquire(). console_lock_reacquire() is only for the
console_lock() context.

> Well, I might be wrong. It is Friday evening. I still do not have
> the entire picture. I probably should have waited for Monday.

I believe that you sense a danger with direct printing and
console_trylock(). It allows for scenarios like your example that end up
relying on kthreads to finish the printing (if there is no
panic). Mainline already has this issue because console_lock() can also
be scheduled away and console_trylock() has no chance to print. This
really is the same issue and ultimately relies on @oops_in_progress and
console_flush_on_panic() to get the messages out.

I believe you are hinting at the worst-case scenario: a kthread getting
scheduled out while printing and never seeing a CPU again because the
system is so busy. Assuming the system does not panic, no printing would
be seen on that console anymore, even if direct printing is enabled.

The only solution I see (aside from atomic consoles) is to disable
preemption during printing. Perhaps for non-atomic consoles, this is
what we need to do. That, together with a new console_trylock() variant,
should avoid this concern. Do you agree? Do we want to go that route?

Disabling preemption would be a problem moving forward for the fbcon
because, for the future, I really would like fbcon to live in a
sleepable context. I already have some new ideas about this. But that is
not a topic for this series.

John

P.S. By "new console_trylock() variant" I mean something for the
console_trylock() context like:

1. grab @console_sem with down_trylock_console_sem()

2. spin on atomic_tryblock()

If console_thread_printing_enter() disables preemption, this should work
about as well as the current owner/waiter logic for @console_sem. I can
do some prototype testing to see if there is some detail I am missing.

John
