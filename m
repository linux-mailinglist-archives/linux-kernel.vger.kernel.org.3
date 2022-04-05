Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9D4C4F48E4
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 02:17:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388463AbiDEVya (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 17:54:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1457638AbiDEQX3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 12:23:29 -0400
Received: from mail-yb1-xb31.google.com (mail-yb1-xb31.google.com [IPv6:2607:f8b0:4864:20::b31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D61D81492
        for <linux-kernel@vger.kernel.org>; Tue,  5 Apr 2022 09:21:28 -0700 (PDT)
Received: by mail-yb1-xb31.google.com with SMTP id y38so24208084ybi.8
        for <linux-kernel@vger.kernel.org>; Tue, 05 Apr 2022 09:21:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=aurora.tech; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=E6JV8zFGCZHwuE5XQBxxuF6dginIdY0wojSrfDf5WPw=;
        b=Ii7ey2hT/J9PA4X9sGdgxr4Fh1UGPKsIxFbr40aeSR/KOogE4gz5jfWehcdoO63/T1
         t/AFdRe2rtBx22Xg79K2W/3rSgaiGYSC+5r+Ipm1d2Zjm94AblvikVCBGp1LfpAylLUV
         oRETyJ/x1Rdvk27tKjA9EAeHdIQJiZ39GqRcdtiZPdtwsFY4+WmP4GrUXF9WnlLK2Y5V
         24X44FjKFMXicoGpHuIo529x+H4xFvh3+WZuk/eQqO3ULjV5YBd7puFMtFjI23YLWClo
         41G/7e13tpuR3QQpWnTUNboTWdCP1F6ArdPiS7A4FyCNN4AqEZrLXWQ+PV106wfR8lw+
         OzTA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=E6JV8zFGCZHwuE5XQBxxuF6dginIdY0wojSrfDf5WPw=;
        b=P0lxep65WhNhtQ+1+RiPdxVdDAEp9BEf51LXju0GeKVj83AbLGmN5aJdJnDEMAWqBE
         h0EaShrgrQPWb7yt7V/2dNGyFXN+kucInK8DFZA/E+UrIedwslyiJlkcTJCsWDmH6sOY
         4YRDEPtvtlHs1eAXdJ0H0h98aHx4cX+y6pluK6uOyMQ5NJPK/X86vRFV2wrmMF+6UtCM
         pAFZadpze3nGpYPrgPAjMW24i7YFRgNg9l1k19OVA7NA6bZ5xOAvKkHk0Et4/jliJSLh
         LhCNQpUDp0XnqEndQ1zLGepFudhvARf/s+oLDdU0HtIwW/l/3NBuhkgU0kty5U9pI1j7
         fKYQ==
X-Gm-Message-State: AOAM533cht+dBag2l/zS9oFxRAo8Fma0KKGEBmnwQn+SXOmXiR6pwnGt
        sMsJmbPZL0n8zXDzQWOAggyDGeukRFVUt38olfUlSw==
X-Google-Smtp-Source: ABdhPJwDq+1cqs59XrwvRt34pPHyqt9RpZm1dlxLb7e/hOS6+ZW1ANCTKuHubxzgQIpPFOkaai1WDkvmin42mPbt6EQ=
X-Received: by 2002:a05:6902:1506:b0:638:44f6:673d with SMTP id
 q6-20020a056902150600b0063844f6673dmr3163404ybu.605.1649175687868; Tue, 05
 Apr 2022 09:21:27 -0700 (PDT)
MIME-Version: 1.0
References: <20220405010752.1347437-1-frederic@kernel.org> <20220405010752.1347437-2-frederic@kernel.org>
In-Reply-To: <20220405010752.1347437-2-frederic@kernel.org>
From:   Alison Chaiken <achaiken@aurora.tech>
Date:   Tue, 5 Apr 2022 09:21:16 -0700
Message-ID: <CAFzL-7s0oWtSS_oYTOJ1A-1Dbso6S+4qoR-n91joexgQYCaJEg@mail.gmail.com>
Subject: Re: [RT][PATCH 2/2] tick: Fix timer storm since introduction of timersd
To:     Frederic Weisbecker <frederic@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        linux-rt-users <linux-rt-users@vger.kernel.org>,
        Mel Gorman <mgorman@suse.de>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Thomas Gleixner <tglx@linutronix.de>,
        Glenn Elliott <glenn@aurora.tech>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 4, 2022 at 9:33 PM Frederic Weisbecker <frederic@kernel.org> wrote:
>
> If timers are pending while the tick is reprogrammed on nohz_mode, the
> next expiry is not armed to fire now, it is delayed one jiffy forward
> instead so as not to raise an inextinguishable timer storm with such
> scenario:
>
> 1) IRQ triggers and queue a timer
> 2) ksoftirqd() is woken up
> 3) IRQ tail: timer is reprogrammed to fire now
> 4) IRQ exit
> 5) TIMER interrupt
> 6) goto 3)
>
> ...all that until we finally reach ksoftirqd.
>
> Unfortunately we are checking the wrong softirq vector bitmask since
> timersd kthread has split from ksoftirqd. Timers now have their own
> vector state field that must be checked separately.

With kernel 5.15 and the timersd patch applied, we've observed that
x86_64 cores tend to enter deeper C-states even when there are pending
hrtimers.      Presumably failure to check the right   bits could also
explain that observation and, accordingly, the patch might fix it?

> As a result, the
> old timer storm is back. This shows up early on boot with extremely long
> initcalls:
>
>         [  333.004807] initcall dquot_init+0x0/0x111 returned 0 after 323822879 usecs
>
> and the cause is uncovered with the right trace events showing just
> 10 microseconds between ticks (~100 000 Hz):
>
>         swapper/-1         1dn.h111 60818582us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415486608
>         swapper/-1         1dn.h111 60818592us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415496082
>         swapper/-1         1dn.h111 60818601us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415505550
>         swapper/-1         1dn.h111 60818611us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415515013
>         swapper/-1         1dn.h111 60818620us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415524483
>         swapper/-1         1dn.h111 60818630us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415533949
>         swapper/-1         1dn.h111 60818639us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415543426
>         swapper/-1         1dn.h111 60818649us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415553061
>         swapper/-1         1dn.h111 60818658us : hrtimer_expire_entry: hrtimer=00000000e0ef0f6b function=tick_sched_timer now=60415562511
>
> Fix this with checking the right timer vector state from the nohz code.
>
> Signed-off-by: Frederic Weisbecker <frederic@kernel.org>
> Cc: Mel Gorman <mgorman@suse.de>
> Cc: Sebastian Andrzej Siewior <bigeasy@linutronix.de>
> Cc: Thomas Gleixner <tglx@linutronix.de>
> ---
>  include/linux/interrupt.h | 12 ++++++++++++
>  kernel/softirq.c          |  7 +------
>  kernel/time/tick-sched.c  |  2 +-
>  3 files changed, 14 insertions(+), 7 deletions(-)
>
> diff --git a/include/linux/interrupt.h b/include/linux/interrupt.h
> index e4b8a04e67ce..da248458f4d9 100644
> --- a/include/linux/interrupt.h
> +++ b/include/linux/interrupt.h
> @@ -607,9 +607,16 @@ extern void raise_softirq(unsigned int nr);
>
>  #ifdef CONFIG_PREEMPT_RT
>  DECLARE_PER_CPU(struct task_struct *, timersd);
> +DECLARE_PER_CPU(unsigned long, pending_timer_softirq);
> +
>  extern void raise_timer_softirq(void);
>  extern void raise_hrtimer_softirq(void);
>
> +static inline unsigned int local_pending_timers(void)
> +{
> +        return __this_cpu_read(pending_timer_softirq);
> +}
> +
>  #else
>  static inline void raise_timer_softirq(void)
>  {
> @@ -620,6 +627,11 @@ static inline void raise_hrtimer_softirq(void)
>  {
>         raise_softirq_irqoff(HRTIMER_SOFTIRQ);
>  }
> +
> +static inline unsigned int local_pending_timers(void)
> +{
> +        return local_softirq_pending();
> +}
>  #endif
>
>  DECLARE_PER_CPU(struct task_struct *, ksoftirqd);
> diff --git a/kernel/softirq.c b/kernel/softirq.c
> index 89eb45614af6..c0aef5f760e5 100644
> --- a/kernel/softirq.c
> +++ b/kernel/softirq.c
> @@ -625,12 +625,7 @@ static inline void tick_irq_exit(void)
>  }
>
>  DEFINE_PER_CPU(struct task_struct *, timersd);
> -static DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
> -
> -static unsigned int local_pending_timers(void)
> -{
> -        return __this_cpu_read(pending_timer_softirq);
> -}
> +DEFINE_PER_CPU(unsigned long, pending_timer_softirq);
>
>  static void wake_timersd(void)
>  {
> diff --git a/kernel/time/tick-sched.c b/kernel/time/tick-sched.c
> index 17a283ce2b20..7c359f029b97 100644
> --- a/kernel/time/tick-sched.c
> +++ b/kernel/time/tick-sched.c
> @@ -763,7 +763,7 @@ static void tick_nohz_restart(struct tick_sched *ts, ktime_t now)
>
>  static inline bool local_timer_softirq_pending(void)
>  {
> -       return local_softirq_pending() & BIT(TIMER_SOFTIRQ);
> +       return local_pending_timers() & BIT(TIMER_SOFTIRQ);
>  }
>
>  static ktime_t tick_nohz_next_event(struct tick_sched *ts, int cpu)
> --
> 2.25.1
>

Thanks,
Alison Chaiken
achaiken@aurora.tech
Aurora Innovation
