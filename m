Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3D2284F95DB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 14:34:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235380AbiDHMgK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 08:36:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235782AbiDHMgI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 08:36:08 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [IPv6:2604:1380:40e1:4800::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EF2FF341EDB
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 05:34:02 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id 407EACE2ADA
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 12:34:01 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5E9AFC385A3;
        Fri,  8 Apr 2022 12:33:57 +0000 (UTC)
Date:   Fri, 8 Apr 2022 08:33:55 -0400
From:   Steven Rostedt <rostedt@goodmis.org>
To:     Thomas Gleixner <tglx@linutronix.de>
Cc:     LKML <linux-kernel@vger.kernel.org>, jstultz@google.com,
        Stephen Boyd <sboyd@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Marcel Holtmann <marcel@holtmann.org>,
        Johan Hedberg <johan.hedberg@gmail.com>,
        Luiz Augusto von Dentz <luiz.dentz@gmail.com>,
        Eric Dumazet <edumazet@google.com>,
        Guenter Roeck <linux@roeck-us.net>
Subject: Re: [RFC][PATCH] timers: Add del_time_free() to be called before
 freeing timers
Message-ID: <20220408083355.3aab1cad@rorschach.local.home>
In-Reply-To: <87pmlrkgi3.ffs@tglx>
References: <20220407161745.7d6754b3@gandalf.local.home>
        <87pmlrkgi3.ffs@tglx>
X-Mailer: Claws Mail 3.17.8 (GTK+ 2.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.7 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 08 Apr 2022 12:37:40 +0200
Thomas Gleixner <tglx@linutronix.de> wrote:

> On Thu, Apr 07 2022 at 16:17, Steven Rostedt wrote:
> > diff --git a/include/linux/timer.h b/include/linux/timer.h
> > index fda13c9d1256..cc76ab0659f3 100644
> > --- a/include/linux/timer.h
> > +++ b/include/linux/timer.h
> > @@ -67,11 +67,12 @@ struct timer_list {
> >  #define TIMER_DEFERRABLE	0x00080000
> >  #define TIMER_PINNED		0x00100000
> >  #define TIMER_IRQSAFE		0x00200000
> > +#define TIMER_FREED		0x00400000
> >  #define TIMER_INIT_FLAGS	(TIMER_DEFERRABLE | TIMER_PINNED | TIMER_IRQSAFE)
> > -#define TIMER_ARRAYSHIFT	22
> > -#define TIMER_ARRAYMASK		0xFFC00000
> > +#define TIMER_ARRAYSHIFT	23
> > +#define TIMER_ARRAYMASK		0xFF800000  
> 
> #define LVL_BITS	6
> #define LVL_SIZE	(1UL << LVL_BITS)
> 
> #if HZ > 100
> # define LVL_DEPTH	9
> # else
> # define LVL_DEPTH	8
> #endif
> 
> #define WHEEL_SIZE	(LVL_SIZE * LVL_DEPTH)
> 
> WHEEL_SIZE(HZ > 100) = (1 << 6) * 9 = 576
> max_index(HZ > 100) = 575 = 0x23f
> 
> 0x23f << ARRAY_SHIFT = 0x11f800000
> 
> Q: Does 0x11f800000 fit into 32bit?
> A: No, and we are not making flags 64bit just because.

And this is why it's a RFC patch. ;-)

I figured shrinking that mask was going to break something, but I
wanted to know if this approach was sound before digging further into
making it correct.

> 
> If you want a bit you have to steal it from the CPUMASK field, but you
> could simply set timer->function to NULL, so you can spare extra checks,
> no?


That could work. Thanks.

> 
> > @@ -966,6 +966,8 @@ __mod_timer(struct timer_list *timer, unsigned long expires, unsigned int option
> >  
> >  	BUG_ON(!timer->function);
> >  
> > +	WARN_ON(timer->flags & TIMER_FREED);  
> 
> So this would become:
> 
> -  	BUG_ON(!timer->function);
> +	if (WARN_ON(!timer->function))
> +		return -EBROKEN;
> 
> You really want to return here and not proceed.

I mention exactly this later in the thread with my discussions with
Guenter. But it was for the flag check, and not the NULL function.

> 
> That needs a corresponding change in add_timer_on() plus:
> 
> -		fn = timer->function;
> +		fn = READ_ONCE(timer->function);
> 
> in expire_timers().

OK.

> 
> > +int del_timer_free(struct timer_list *timer)
> > +{
> > +	struct timer_base *base;
> > +	unsigned long flags;
> > +	int ret;
> > +
> > +	debug_assert_init(timer);
> > +
> > +	for (;;) {
> > +		ret = -1;
> > +		base = lock_timer_base(timer, &flags);
> > +
> > +		if (base->running_timer != timer)
> > +			ret = detach_if_pending(timer, base, true);
> > +
> > +		if (ret >= 0) {
> > +			timer->flags |= TIMER_FREED;
> > +			raw_spin_unlock_irqrestore(&base->lock, flags);
> > +			break;
> > +		}
> > +
> > +		raw_spin_unlock_irqrestore(&base->lock, flags);
> > +
> > +		del_timer_wait_running(timer);
> > +		cpu_relax();
> > +	}
> > +
> > +	return ret;
> > +}  
> 
> So this reimplements del_timer_sync() just slightly different for no
> reason. Something like the uncompiled below.

Yeah, I was going to try a helper function for both, but wasn't sure I
would mess up something subtle, so for the RFC patch, I figured I just
implement it completely.

> 
> Thanks,
> 
>         tglx
> ---
> --- a/include/linux/timer.h
> +++ b/include/linux/timer.h

I'll take a look at the below later today.

Thanks for the review.

-- Steve

> @@ -183,12 +183,17 @@ extern int timer_reduce(struct timer_lis
>  extern void add_timer(struct timer_list *timer);
>  
>  extern int try_to_del_timer_sync(struct timer_list *timer);
> +extern int __del_timer_sync(struct timer_list *timer, bool free);
>  
> -#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
> -  extern int del_timer_sync(struct timer_list *timer);
> -#else
> -# define del_timer_sync(t)		del_timer(t)
> -#endif
> +static inline int del_timer_sync(struct timer_list *timer)
> +{
> +	return __del_timer_sync(timer, false);
> +}
> +
> +static inline int del_timer_sync_free(struct timer_list *timer)
> +{
> +	return __del_timer_sync(timer, true);
> +}
>  
>  #define del_singleshot_timer_sync(t) del_timer_sync(t)
>  
> --- a/kernel/time/timer.c
> +++ b/kernel/time/timer.c
> @@ -964,7 +964,8 @@ static inline int
>  	unsigned int idx = UINT_MAX;
>  	int ret = 0;
>  
> -	BUG_ON(!timer->function);
> +	if (WARN_ON(!timer->function))
> +		return -EINVAL;
>  
>  	/*
>  	 * This is a common optimization triggered by the networking code - if
> @@ -1140,7 +1141,8 @@ EXPORT_SYMBOL(timer_reduce);
>   */
>  void add_timer(struct timer_list *timer)
>  {
> -	BUG_ON(timer_pending(timer));
> +	if (WARN_ON(timer_pending(timer)))
> +		return;
>  	__mod_timer(timer, timer->expires, MOD_TIMER_NOTPENDING);
>  }
>  EXPORT_SYMBOL(add_timer);
> @@ -1157,7 +1159,8 @@ void add_timer_on(struct timer_list *tim
>  	struct timer_base *new_base, *base;
>  	unsigned long flags;
>  
> -	BUG_ON(timer_pending(timer) || !timer->function);
> +	if (WARN_ON(timer_pending(timer) || !timer->function))
> +		return;
>  
>  	new_base = get_timer_cpu_base(timer->flags, cpu);
>  
> @@ -1213,14 +1216,7 @@ int del_timer(struct timer_list *timer)
>  }
>  EXPORT_SYMBOL(del_timer);
>  
> -/**
> - * try_to_del_timer_sync - Try to deactivate a timer
> - * @timer: timer to delete
> - *
> - * This function tries to deactivate a timer. Upon successful (ret >= 0)
> - * exit the timer is not queued and the handler is not running on any CPU.
> - */
> -int try_to_del_timer_sync(struct timer_list *timer)
> +static int __try_to_del_timer_sync(struct timer_list *timer, boot free)
>  {
>  	struct timer_base *base;
>  	unsigned long flags;
> @@ -1232,11 +1228,25 @@ int try_to_del_timer_sync(struct timer_l
>  
>  	if (base->running_timer != timer)
>  		ret = detach_if_pending(timer, base, true);
> +	if (free)
> +		timer->function = NULL;
>  
>  	raw_spin_unlock_irqrestore(&base->lock, flags);
>  
>  	return ret;
>  }
> +
> +/**
> + * try_to_del_timer_sync - Try to deactivate a timer
> + * @timer: timer to delete
> + *
> + * This function tries to deactivate a timer. Upon successful (ret >= 0)
> + * exit the timer is not queued and the handler is not running on any CPU.
> + */
> +int try_to_del_timer_sync(struct timer_list *timer)
> +{
> +	return __try_to_del_timer_sync(timer, false);
> +}
>  EXPORT_SYMBOL(try_to_del_timer_sync);
>  
>  #ifdef CONFIG_PREEMPT_RT
> @@ -1312,7 +1322,6 @@ static inline void timer_sync_wait_runni
>  static inline void del_timer_wait_running(struct timer_list *timer) { }
>  #endif
>  
> -#if defined(CONFIG_SMP) || defined(CONFIG_PREEMPT_RT)
>  /**
>   * del_timer_sync - deactivate a timer and wait for the handler to finish.
>   * @timer: the timer to be deactivated
> @@ -1349,7 +1358,7 @@ static inline void del_timer_wait_runnin
>   *
>   * The function returns whether it has deactivated a pending timer or not.
>   */
> -int del_timer_sync(struct timer_list *timer)
> +int __del_timer_sync(struct timer_list *timer, bool free)
>  {
>  	int ret;
>  
> @@ -1379,7 +1388,7 @@ int del_timer_sync(struct timer_list *ti
>  		lockdep_assert_preemption_enabled();
>  
>  	do {
> -		ret = try_to_del_timer_sync(timer);
> +		ret = __try_to_del_timer_sync(timer, free);
>  
>  		if (unlikely(ret < 0)) {
>  			del_timer_wait_running(timer);
> @@ -1389,8 +1398,7 @@ int del_timer_sync(struct timer_list *ti
>  
>  	return ret;
>  }
> -EXPORT_SYMBOL(del_timer_sync);
> -#endif
> +EXPORT_SYMBOL(__del_timer_sync);
>  
>  static void call_timer_fn(struct timer_list *timer,
>  			  void (*fn)(struct timer_list *),

