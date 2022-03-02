Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 92FEB4CA880
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 15:49:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243233AbiCBOuK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 09:50:10 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42252 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234273AbiCBOuI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 09:50:08 -0500
Received: from galois.linutronix.de (Galois.linutronix.de [IPv6:2a0a:51c0:0:12e:550::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 29DA92B180
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 06:49:24 -0800 (PST)
From:   John Ogness <john.ogness@linutronix.de>
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020; t=1646232563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsfRjPGADDznTwP6UP8rO2/tn0zLOEDntHkPMrLfO3o=;
        b=PQI6UudmCrIGk9Y4uQdDksKVK6LvG6dl92N2Mvx4EmNEfYLMKjoHBg9snNfeBkTpZ4r4kO
        LIaewMgebD9I++aM6yMtQwZGmhIsqKcjCB1Ey26O6w0/yV7XbcTskVBoYQ7SqR+rncLUSX
        PVfpMV0setuD2ryMTi3OR5Tmz63ex975Z0jJ65tZzDKpW7R+SOXbtlZnIgDjPQ5ePI4O6m
        N+93hFSwXE66o80VQ6HGLFpB4ZD8J84T5EMrUZV1D5FgBPa1sJZNpwL4wUGr75WjGHt1qB
        OQDdaJeVAUBfD9Nk6GVfD8cd4j7WqVa7ode1d24qRyd7rh3cZkmXu98HE+jDcg==
DKIM-Signature: v=1; a=ed25519-sha256; c=relaxed/relaxed; d=linutronix.de;
        s=2020e; t=1646232563;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=OsfRjPGADDznTwP6UP8rO2/tn0zLOEDntHkPMrLfO3o=;
        b=gEbU27e2+ZIKq7GlcvsN82xEJPYX/NfomHyHT6KYdvp6RloQF2dbRV/sCha36zIJYT/ISb
        fUTiHzlbxee742DA==
To:     Petr Mladek <pmladek@suse.com>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: two locations: was: Re: [PATCH printk v1 03/13] printk: use
 percpu flag instead of cpu_online()
In-Reply-To: <Yg0C+UtoegnybA4q@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <Yg0C+UtoegnybA4q@alley>
Date:   Wed, 02 Mar 2022 15:55:23 +0106
Message-ID: <87v8wwh0jw.fsf@jogness.linutronix.de>
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

On 2022-02-16, Petr Mladek <pmladek@suse.com> wrote:
>> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
>> index d1b773823d63..b346e60e9e51 100644
>> --- a/kernel/printk/printk.c
>> +++ b/kernel/printk/printk.c
>> @@ -2577,11 +2577,11 @@ static int have_callable_console(void)
>>   *
>>   * Console drivers may assume that per-cpu resources have been allocated. So
>>   * unless they're explicitly marked as being able to cope (CON_ANYTIME) don't
>> - * call them until this CPU is officially up.
>> + * call them until per-cpu resources have been allocated.
>>   */
>>  static inline int can_use_console(void)
>>  {
>> -	return cpu_online(raw_smp_processor_id()) || have_callable_console();
>> +	return (printk_percpu_data_ready() || have_callable_console());
>>  }
>
> cpu_online(raw_smp_processor_id()) check is used also in
> call_console_drivers(). The same logic should be used in both
> locations.
>
> I found this when reviewing 6th patch that replaced both checks
> with a single one.
>
> Note that I am still not sure if this change is correct at all.
> It will allow to always call the console during CPU hotplug
> and I am not sure if it is safe. IMHO, it might cause problems when
> a console driver uses, for example, CPU-bound workqueues.

You are correct. We must take hotplug into account for !CON_ANYTIME
consoles. There may be some hotplug callbacks that make memory
unavailable for the console.

However, I will add the use of printk_percpu_data_ready() in the
check. !CON_ANYTIME consoles also should not be called until the per-cpu
areas are ready. For example, it would be bad if a console queued
irq_work before per-cpu areas are setup (cpu_online() is true during
this time).

One of my main concerns was that raw_smp_processor_id() was used for the
check. It is conceptually wrong to exclude certain consoles based on a
current CPU when migration is still enabled. I understand that the use
of can_use_console() is an optimization to avoid doing extra work where
there are no consoles available. But the task could be preemptible there
and _conceptually_, could get moved to another CPU before its write()
callback is called. The cpu_online() check belongs in code where
preemption is disabled.

If the context is preemptible, I do not think it will ever see
!cpu_online(). So I think if the cpu_online() check is limited to
unlocking when console_trylock() was used, it will be correct.

In the current implementation of printk(), it would be odd to do this
conditional check (perhaps by passing @do_cond_resched to
can_use_console()). But my series does significant refactoring and
actually does need to distinguish between console_lock() and
console_trylock() due to the kthreads and supporting the handover. So it
should work well that the cpu_online() check for !CON_ANYTIME is only
performed when !preemptible.

Regardless, my v2 will keep cpu_online() checks since they are necessary
for hotplug support.

John
