Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B8CD04BC243
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 22:42:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239845AbiBRVmY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 16:42:24 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:35150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235827AbiBRVmV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 16:42:21 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 503F632075
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 13:42:01 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1645220518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z2l+VAxQDDx0OeC/30i+N6nTLlw9tzVQSZFkmj5mJEI=;
        b=AW1Q53bTOoUds/cBBbJwTVorSd7ruQTq3kYySocEUrj0ITuHiOsXcBoYyWfy8/PlASIzGD
        CY8giMnNnFQxJwpjqylZRJt2w+58BTC8j6OlWc9Xb8mnQTBo37sf1zzc8ovo1om3di7/Ri
        wOHLnYHzoIibXcU00FPQflL6vcCxLL4OidTtmK+5YA8MciTlYwxJfogEG5+4DfFvGgQRWO
        Kw04zKfNgTXk37VpBUUk0JdAdc05MMqT3xb2cWZBFYnAPososkVvJFNXTSO9urygNhnJC2
        DNSgM8etoZhXd6WUQ63xtjb7xgAzEQtUv32wg6nrHQ15NtHn1eoNhMmSzt6QAg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1645220518;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=z2l+VAxQDDx0OeC/30i+N6nTLlw9tzVQSZFkmj5mJEI=;
        b=90WzBgevenrLcolcfeOW85Ts5j5qTA3HrVaKX1ZEp4qwnPqGX0UjPnxBKb6trMo4eIYSPn
        618KNeObv6zRB1CQ==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: [PATCH printk v1 11/13] printk: reimplement console_lock for
 proper kthread support
In-Reply-To: <Yg/HWcifuqLsS6cv@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-12-john.ogness@linutronix.de>
 <Yg/HWcifuqLsS6cv@alley>
Date:   Fri, 18 Feb 2022 22:47:56 +0106
Message-ID: <87o8333l97.fsf@jogness.linutronix.de>
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

On 2022-02-18, Petr Mladek <pmladek@suse.com> wrote:
> the solution is very interesting and I am sure that it has many
> advantages. But it is also quite complex. I want to be sure
> about the motivations before I start discussing details.

I am jumping ahead to this email so that we can start discussing
details. This patch is really the key to make the whole series work
correctly.

> On Mon 2022-02-07 20:49:21, John Ogness wrote:
>> With non-threaded console printers preemption is disabled while
>> holding the console lock in order to avoid the situation where the
>> console printer is scheduled away and no other task can lock the
>> console (for printing or otherwise).
>
> I guess that you are talking about that vprintk_emit() disables
> the preemtion. console_lock() does not disable preemption.

Yes. I did not mean to imply that console_lock() is disabling
preemption. But preemption is disabled at some point _within_ the
console_lock()/console_unlock() window. I consider
console_lock()/console_unlock() to be the main API functions for direct
printing and I wanted to point out that calling that pair will cause
preemption disabling.

>> Disabling preemption is necessary because the console lock is
>> implemented purely as a semaphore, which has no owner.
>
> I do not understand this explanation.
>
> The preemtion was added into vprintk_emit() by the commit
> fd5f7cde1b85d4c8e09c ("printk: Never set console_may_schedule
> in console_trylock()").
>
> It is not really necessary. It actually increases the risk of softlockups.
> The motivation was to increase the chance that messages will get
> printed. Nobody prints the messages when the owner is sleeping.
> We hoped that the console owner steeling will be efficient enough
> to prevent the softlockups.

Yes, I am referring to this case where the context taking the semaphore
goes to sleep. If another context tries to take the semaphore, the
scheduler does not know which task it can schedule to resolve the
situation because there is no true lock contention.

With a mutex there is an owner. When another task tries to lock a mutex,
the scheduler knows which task must be scheduled to resolve this true
lock contention. (There are also other benefits relating to priority
inheritance, but I chose not to mention this.)

>> Like non-threaded console printers, kthread printers use the
>> console lock to synchronize during printing. However, since they
>> use console_lock() instead of a best-effort console_trylock(), it
>> is not possible to disable preemption upon locking.
>   ^^^^^^^^^^^^^^^
>
> IMHO, it is possible to disable preemtion. But we propably do
> not want to do it, especially on RT.

As stated in the commit message of fd5f7cde1b85 ("printk: Never set
console_may_schedule in console_trylock()"), enabling preemption is "a
mistake". That is why I said "not possible". Perhaps I should say "bad
idea".

>> Therefore an alternative for synchronizing and avoiding
>> the above mentioned situation is needed.
>
> I do not think that preemtion is the reason for an alternative
> soluiton.

Well, if enabling preemption is "a mistake" then we _need_ an
alternative.

> IMHO, the reason is to handle different consoles independently.
> It will allow to handle more consoles in parallel. And more
> importantly they will not block each other.

This is an additional benefit, but it was not my primary motivation when
designing the alternative. Honestly, I do not care how we phrase the
motivation and benefits. I only wanted to make it clear that disabling
preemption is not an acceptable option.

>> The kthread printers do not need to synchronize against each other,
>
> yes
>
>> but they do need to synchronize against console_lock() callers.
>
> We should make it more clear why. I see the following reasons:
>
>    + it is needed for switching between direct printing and
>      offload to kthreads.
>
>    + another operations on all consoles, e.g. suspend, updating
>      list of registered consoles
>
>    + console_lock() has several other external users and their
>      dependencies are complicated.

OK. Those are also the reasons I see.

>> To provide this synchronization, introduce a per-console mutex. The
>> mutex is taken by the kthread printer during printing and is also
>> taken by console_lock() callers.
>
> ok
>
>> Since mutexes have owners, when calling console_lock(), the
>> scheduler is able to schedule any kthread printers that may have
>> been preempted while printing.
>
> I do not userstand the relation between mutex owners and scheduling
> kthreads. The mutex can be taken by any process.

As mentioned above, it is about creating true lock contention between
the kthreads and the console_lock() callers.

>> Rather than console_lock() callers holding the per-console mutex
>> for the duration of the console lock, the per-console mutex is only
>> taken in order to set a new CON_PAUSED flag, which is checked by
>> the kthread printers. This avoids any issues due to nested locking
>> between the various per-console mutexes.
>
> The flag adds some complexity. The logic will use two locks + one flag
> instead of just two locks. IMHO, it deserves a more clear explanation
> why it is needed. When can nested locking happen? Will it make the
> nested locking safe?
>
> The obvious ordering is to always take con->mutex under console_sem.
>
> Are you afraid that some console driver might need to take console_sem
> from con->write() callback?

No. By nested locking I mean:

    for_each_console(c)
        mutex_lock(&c->lock);

    /* .... do something .... */

    for_each_console_reversed(c)
        mutex_unlock(&c->lock);

Aside from this looking ugly and being a potential lockdep problem if
the console ordering were to change, it would also mean that all the
console mutexes are locked while suspended. That is not necessarily an
issue, but I just did not like the idea of holding so many locks while
suspended. And I still do not feel so comfortable about the somewhat
arbitrary ordering of console locking.

If you think the above construct is good, then we do not need the flag
approach.

>> The kthread printers must also synchronize against console_trylock()
>> callers. Since console_trylock() is non-blocking, a global atomic
>> counter will be used to identify if any kthread printers are active.
>> The kthread printers will also check the atomic counter to identify
>> if the console has been locked by another task via
>> console_trylock().
>
> This is another complexity. An easier solution would be to do:
>
> console_trylock()
> {
> 	if (down_trylock(&console_sem))
> 		return failed;
>
> 	for_each_console(con) {
> 		if (mutext_trylock(&con->lock))
> 			goto fail;
> 	}
>
> 	// sucess
>
> fail:
> 	for_each_console(con_fail) {
> 		if (con_fail == con)
> 			break;
> 		mutex_unlock(&con->lock);
> }

No, this cannot work. Semaphores are the _only_ synchonization object in
the kernel that is allowed to perform a trylock from any context
(because they don't have owners).

> Of course, the atomic counter is interesting. But it is
> also another extra complexity. Is it worth it?

I could find no alternative. But I am open for ideas if anyone thinks it
can be done with less complexity.

John
