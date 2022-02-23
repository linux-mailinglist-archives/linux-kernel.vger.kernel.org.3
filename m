Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC4674C19CF
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 18:21:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243343AbiBWRV1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 12:21:27 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiBWRVZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 12:21:25 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B51813CE9
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 09:20:57 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645636855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j17tbBJubcNQf160iUR2CRDjglhcykXbhnTHJ3K9114=;
        b=g7mBCujZDCqKobSfTp5tfE1vzr7psYa5o+fDGBAbaX7eqVHy3YD8bBtiwvNLld38Xoi3VS
        dJISn3f/aQSgwT2+10fH7HPz6Krm7WQD9fbg6yOLPJ3OW6GK61Amw0IiRq/Hb0PDn8Kbpi
        H0jIPaeXbGef+rjV784CFdPJx9LepClYn5oST7YzzfSci2Xw9TKrRfpm4lesRFvHnY4+M6
        /mAIT7fL/HPRCoJyedvt9tgfdUoXo5aHhWFOcYdUYgfPC1mXAy4PQiSAMWAZkZ2uND1S12
        1yq+NKHig/je1xlsCY5jaced4PxR6DRO0QYCDvUjxOcMGn/j3vKWTQCIRAuCSw==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645636855;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=j17tbBJubcNQf160iUR2CRDjglhcykXbhnTHJ3K9114=;
        b=u6jIKNpT6W0jQGTPx0oy4r1obXUvYnqMgfDh6jOhazSUDERTMAAmP5jRUJkgPJj5nZjnzG
        +wXrD6K0C6UBjmDQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
In-Reply-To: <YhTMDOHyXADh665V@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <Yg/HWcifuqLsS6cv@alley> <87o8333l97.fsf@jogness.linutronix.de>
 <YhTMDOHyXADh665V@alley>
Date:   Wed, 23 Feb 2022 18:26:54 +0106
Message-ID: <87h78pqz2h.fsf@jogness.linutronix.de>
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

On 2022-02-22, Petr Mladek <pmladek@suse.com> wrote:
>> >> With non-threaded console printers preemption is disabled while
>> >> holding the console lock in order to avoid the situation where the
>> >> console printer is scheduled away and no other task can lock the
>> >> console (for printing or otherwise).
>> >
>> > I guess that you are talking about that vprintk_emit() disables
>> > the preemtion. console_lock() does not disable preemption.
>> 
>> Yes. I did not mean to imply that console_lock() is disabling
>> preemption. But preemption is disabled at some point _within_ the
>> console_lock()/console_unlock() window. I consider
>> console_lock()/console_unlock() to be the main API functions for direct
>> printing and I wanted to point out that calling that pair will cause
>> preemption disabling.
>
> But console_unlock() should not call consoles when kthreads are
> usable. It should just wake up them. The kthreads might still
> use console_lock() and __console_unlock().

I am only talking about when direct printing should be performed. Direct
printing depends on more than just the kthreads. See
allow_direct_printing().

> I do not understand why this should be a reason to introduce
> per-console locks.

I see your point and you are correct. The reason for per-console locks
is purely to allow the console printers to run in parallel.

>> >> Disabling preemption is necessary because the console lock is
>> >> implemented purely as a semaphore, which has no owner.
>> >
>> > I do not understand this explanation.
>> >
>> > The preemtion was added into vprintk_emit() by the commit
>> > fd5f7cde1b85d4c8e09c ("printk: Never set console_may_schedule
>> > in console_trylock()").
>> >
>> > It is not really necessary. It actually increases the risk of
>> > softlockups.  The motivation was to increase the chance that
>> > messages will get printed. Nobody prints the messages when the
>> > owner is sleeping.  We hoped that the console owner steeling will
>> > be efficient enough to prevent the softlockups.
>> 
>> Yes, I am referring to this case where the context taking the
>> semaphore goes to sleep. If another context tries to take the
>> semaphore, the scheduler does not know which task it can schedule to
>> resolve the situation because there is no true lock contention.
>> 
>> With a mutex there is an owner. When another task tries to lock a
>> mutex, the scheduler knows which task must be scheduled to resolve
>> this true lock contention. (There are also other benefits relating to
>> priority inheritance, but I chose not to mention this.)
>
> This sounds interesting. Does scheduler wake up or prioritize
> mutex owners?

Sorry, the only example of this is priority inheritance. But for
non-PREEMPT_RT there is no priority inheritance. The lock would need to
be an rtmutex for this ability, which probably doesn't make sense for
printk.

And besides, the priority inheritance only works in 1 direction. With
the use of the flags approach, there is no way for printing kthreads to
boost console_lock owners. So even mentioning priority inheritance is
misleading.

> I do not see this in the code. There is the optimistic spin but
> it is used only when the current owner is just running on another CPU.
>
> Again, I do not see how this could be a motivation to introduce
> per-console mutexes.

You are correct.

>> >> Like non-threaded console printers, kthread printers use the
>> >> console lock to synchronize during printing. However, since they
>> >> use console_lock() instead of a best-effort console_trylock(), it
>> >> is not possible to disable preemption upon locking.
>> >   ^^^^^^^^^^^^^^^
>> >
>> > IMHO, it is possible to disable preemtion. But we propably do
>> > not want to do it, especially on RT.
>> 
>> As stated in the commit message of fd5f7cde1b85 ("printk: Never set
>> console_may_schedule in console_trylock()"), enabling preemption is
>> "a mistake". That is why I said "not possible". Perhaps I should say
>> "bad idea".
>
> "bad idea" is better. I am sorry that I am too picky. But the disabled
> preemption was a big mystery when I started working on printk code
> ages ago. And it was hard to find any explanation if it was required
> or just nice to have. Clear commit message or comment would have
> helped a lot.

AFAICT the issue only applies to the printk() call chain, because the
caller may be holding other locks that are critical to the system. (In
Tetsuo's case [0], it was @oom_lock.)

[0] https://lore.kernel.org/linux-mm/201603022101.CAH73907.OVOOMFHFFtQJSL@I-love.SAKURA.ne.jp/

That means the reasoning in my commit message about kthreaded printing
and disabling preemption is moot. I will clean that up. Thanks for
pointing out my handwaving.

> I do not see how the per-console mutexes help with preemtion:
>
>    + console_lock()/console_unlock() is fast when kthreads are usable
>
>    + console_lock()/console_unlock() behaves the same as before
>      when kthreads are not usable, for example, during early boot,
>      or panic.
>
> BTW: The possibility to process printk kthreads in parallel is
>      a good enough reason from my POV. But I would still like
>      to understand your primary motivation. There must be some
>      important aspect that I do not understand. And it would be
>      great to document it.

You are right. The v2 commit message will focus on:

- the motivation for per-console locks is parallel printing

- explain about how disabling preemption is only necessary for direct
  printing via printk() because the caller may be holding
  system-critical and/or timing-sensitive locks (and also to allow the
  console owner/waiter logic to work correctly)

- correctly clarifying why the various types
  (semaphore/mutex/flag/atomic) were chosen to implement the printing
  sychronization between atomic-direct, non-atomic-direct, and kthreads
  (and I will explicitly remind the audience that mutex_trylock() cannot
  be used in atomic context)

Thanks, Petr!

John
