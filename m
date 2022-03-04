Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 559084CD8D0
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 17:14:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240702AbiCDQPZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 11:15:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240703AbiCDQPQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 11:15:16 -0500
Received: from smtp-out2.suse.de (smtp-out2.suse.de [195.135.220.29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 173F71598FC
        for <linux-kernel@vger.kernel.org>; Fri,  4 Mar 2022 08:14:19 -0800 (PST)
Received: from relay2.suse.de (relay2.suse.de [149.44.160.134])
        by smtp-out2.suse.de (Postfix) with ESMTP id A61231F386;
        Fri,  4 Mar 2022 16:14:17 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=suse.com; s=susede1;
        t=1646410457; h=from:from:reply-to:date:date:message-id:message-id:to:to:cc:cc:
         mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D6tMkw9qlM5UYaKemwdZ5cjjRWO9/r0Z1+FOXCrzn3o=;
        b=EUxzWi3PMQBW0303yGQhoiej9gRMkAwhmAofPOnfT9450HtKx0EY2zWHmd+FRaSY1aYVmS
        ZNi8An8P112TTSuS7tnOeUhV3ihkyd+cKiXbgYpTm+2n+yr/Rv3gIH5hDhVeyRvCXcitKu
        5yITB+gndn9MChP7x/G4hppEdJBW49w=
Received: from suse.cz (unknown [10.100.224.162])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by relay2.suse.de (Postfix) with ESMTPS id 8CB94A3B95;
        Fri,  4 Mar 2022 16:14:17 +0000 (UTC)
Date:   Fri, 4 Mar 2022 17:14:14 +0100
From:   Petr Mladek <pmladek@suse.com>
To:     John Ogness <john.ogness@linutronix.de>
Cc:     Sergey Senozhatsky <senozhatsky@chromium.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Subject: Re: two locations: was: Re: [PATCH printk v1 03/13] printk: use
 percpu flag instead of cpu_online()
Message-ID: <YiI61ppIW+FsrzPu@alley>
References: <20220207194323.273637-1-john.ogness@linutronix.de>
 <20220207194323.273637-4-john.ogness@linutronix.de>
 <Yg0C+UtoegnybA4q@alley>
 <87v8wwh0jw.fsf@jogness.linutronix.de>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <87v8wwh0jw.fsf@jogness.linutronix.de>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed 2022-03-02 15:55:23, John Ogness wrote:
> On 2022-02-16, Petr Mladek <pmladek@suse.com> wrote:
> >> diff --git a/kernel/printk/printk.c b/kernel/printk/printk.c
> >> index d1b773823d63..b346e60e9e51 100644
> >> --- a/kernel/printk/printk.c
> >> +++ b/kernel/printk/printk.c
> >> @@ -2577,11 +2577,11 @@ static int have_callable_console(void)
> >>   *
> >>   * Console drivers may assume that per-cpu resources have been allocated. So
> >>   * unless they're explicitly marked as being able to cope (CON_ANYTIME) don't
> >> - * call them until this CPU is officially up.
> >> + * call them until per-cpu resources have been allocated.
> >>   */
> >>  static inline int can_use_console(void)
> >>  {
> >> -	return cpu_online(raw_smp_processor_id()) || have_callable_console();
> >> +	return (printk_percpu_data_ready() || have_callable_console());
> >>  }
> >
> > cpu_online(raw_smp_processor_id()) check is used also in
> > call_console_drivers(). The same logic should be used in both
> > locations.
> >
> > I found this when reviewing 6th patch that replaced both checks
> > with a single one.
> >
> > Note that I am still not sure if this change is correct at all.
> > It will allow to always call the console during CPU hotplug
> > and I am not sure if it is safe. IMHO, it might cause problems when
> > a console driver uses, for example, CPU-bound workqueues.
> 
> You are correct. We must take hotplug into account for !CON_ANYTIME
> consoles. There may be some hotplug callbacks that make memory
> unavailable for the console.
> 
> However, I will add the use of printk_percpu_data_ready() in the
> check. !CON_ANYTIME consoles also should not be called until the per-cpu
> areas are ready. For example, it would be bad if a console queued
> irq_work before per-cpu areas are setup (cpu_online() is true during
> this time).
> 
> One of my main concerns was that raw_smp_processor_id() was used for the
> check. It is conceptually wrong to exclude certain consoles based on a
> current CPU when migration is still enabled. I understand that the use
> of can_use_console() is an optimization to avoid doing extra work where
> there are no consoles available. But the task could be preemptible there
> and _conceptually_, could get moved to another CPU before its write()
> callback is called. The cpu_online() check belongs in code where
> preemption is disabled.
> 
> If the context is preemptible, I do not think it will ever see
> !cpu_online(). So I think if the cpu_online() check is limited to
> unlocking when console_trylock() was used, it will be correct.

This would require calling console_lock()/console_unlock()
in a hotplug code when cpu_online() already returns false.
Do I get it correctly?

I agree that it should not happen. console_lock() must be called in
a preemptible context. And CPU should not be in a pre-emptible
context when cpu_online() returns false. To be honest, I did
not check the code. It just does not make much sense.

> In the current implementation of printk(), it would be odd to do this
> conditional check (perhaps by passing @do_cond_resched to
> can_use_console()). But my series does significant refactoring and
> actually does need to distinguish between console_lock() and
> console_trylock() due to the kthreads and supporting the handover. So it
> should work well that the cpu_online() check for !CON_ANYTIME is only
> performed when !preemptible.
> 
> Regardless, my v2 will keep cpu_online() checks since they are necessary
> for hotplug support.

Yes, I would do it to stay on the safe side.

Best Regards,
Petr
