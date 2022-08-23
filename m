Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D207E59EA9C
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 20:14:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231359AbiHWSNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 14:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231160AbiHWSNZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 14:13:25 -0400
Received: from mail-yw1-x1136.google.com (mail-yw1-x1136.google.com [IPv6:2607:f8b0:4864:20::1136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0AF16A0276
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:26:42 -0700 (PDT)
Received: by mail-yw1-x1136.google.com with SMTP id 00721157ae682-33365a01f29so393749627b3.2
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 09:26:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=C4UvO2wZkYFI1UTJOGZALmKlTacTBmVoJHWrt88EyS0=;
        b=PP5dUReG+7nTFYSZ1ga0l09a2/YXWDNi43PvsAsljJRdCkAjB6VOKhUYiipbfHN5Z8
         3czHMBXVF+Tcdo1mRw5FfIBXWTRNWr9PkiGkHhPSU07BvkA++GxtHiM0CtcJazzWn6Ys
         6TWaohyOB5udU1tOH1n44qV6JMZiyaTtVPVE46TmVbM6GXIjS/KV4U264HTN0hVEteYm
         p65g2/6IOae7pYJSZ+9UcISmfpbZTL7az7NYlA9yynIvzo2gfMzHNACauX4HJPxPfKKw
         LlgCFBcrQyrl7Y9vd7OrLi4Rr0MbXWsRAcTnXJJKo119SaqRTjXZqFKKK7b3OJDVRRoM
         B82w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=C4UvO2wZkYFI1UTJOGZALmKlTacTBmVoJHWrt88EyS0=;
        b=P3FnQp0PEc8l3xYTIoYa6Mglu7QSnE/aAqTMMrlEU6A4K0eSjDpiEmgG3ASlnu6lQw
         sIEW1QpwLwu8kY8W+oBgCj98SbmAXwJI/63xmyc+82X3G4vkK5Lbw4u8yq+3lLWcnCDr
         kwaWCZN6EStbv38GxyuzBb4QxXxFXaTsFyrnvlZYzek/+1IZKMEN6zcEH3CNCCgVhzNu
         ssycrKt1BTZc08AJtSOIBecUv38nSN9a72BMnk5sAtMw/JHj1eXDCAUc8HMISo+utdiI
         9VE72zEjj9p2t7WlYkQw/wNaTaR6Tn2qx2lzsuFuBIqWDu9/JqZWB10kx0K8oSvC6Rdc
         lNog==
X-Gm-Message-State: ACgBeo0oHl59Qmc2cafX3idpltesLq0G8UdW1K2Dbu6dkR9g5Ya4buph
        /giVFtqMZiyukSwh/nyvzBSGNVbTy3+xzv2Y/KUZJyuufGk=
X-Google-Smtp-Source: AA6agR5M6PynLP/CwASw9nWZUgsTAUOspeA3aXtYI1cJZ0bn5SinEngKwdlZKT4i2ZLhS1sh36QHrexeRbHdVLbNVLM=
X-Received: by 2002:a25:4ca:0:b0:695:feac:7322 with SMTP id
 193-20020a2504ca000000b00695feac7322mr2334545ybe.241.1661272001859; Tue, 23
 Aug 2022 09:26:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220819153320.291720-1-pierre.gondois@arm.com> <20220819153320.291720-3-pierre.gondois@arm.com>
In-Reply-To: <20220819153320.291720-3-pierre.gondois@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 23 Aug 2022 18:26:30 +0200
Message-ID: <CAKfTPtDjrxoH81-FKFo-PeKwEcu1K1HinDii90fGSjKTZGGGXw@mail.gmail.com>
Subject: Re: [PATCH 2/2] sched/fair: Use IRQ scaling for all sched classes
To:     Pierre Gondois <pierre.gondois@arm.com>
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
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

On Fri, 19 Aug 2022 at 17:33, Pierre Gondois <pierre.gondois@arm.com> wrote:
>
> The time spent executing IRQ handlers is not reflected in the
> utilization of CPU. IRQ scaling reduces rq CFS, RT and DL
> util by reflecting the CPU capacity reduction due to IRQs.
>
> commit 9033ea11889f ("cpufreq/schedutil: Take time spent in interrupts
> into account")
> introduced the notion of IRQ scaling for the now called
> effective_cpu_util() function with the following expression (for the
> CPU util):
>   IRQ util_avg + (max_cap - IRQ util_avg / max_cap ) * /Sum rq util_avg
>
> commit 523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")
> introduced IRQ scaling for scale_rt_capacity(), but without scaling
> RT and DL rq util.
>
> scale_rt_capacity() excludes RT and DL rq signals from IRQ scaling.
> Only the available capacity is scaled. However RT and DL rq util
> should also be scaled.

RT and DL are not excluded, they are removed before scaling the
available time. We compute the available cpu capacity in the clock
task domain before scaling it in the full clock domain

Let imagine that we have the following timeshare:

|       100%      |
|-IRQ-|-RT--|-----|
| 33% | 33% | 33% |
      |   100%    |
      | 50% | 50% |

irq uses a third of the time

RT uses a third of the time but 50% of the clock task as the time in
interrupt context is not accounted for. This means that the RT
utilization is 50%

In order to know what is available for others we do:

100% - 50% RT = 50% available in the clock task context

Then, we scale the 50% of available time to take the time stolen by IRQ

(100% - 33% IRQ) * 50% / 100% = 33%

So the available capacity for others is 33% of the original capacity
which is correct

What you're proposing:

free = (100% - 33% IRQ) * 100% / 100% = 67%

used = 50% RT + 33% IRQ == 83% whereas it should be 33% RT + 33% IRQ == 66%

Then free < used which means that there is no capacity available for
others which is not true

>
> Applying IRQ scaling allows to extract the IRQ util avg. So IRQ util
> avg should also be subtracted from the available capacity.
> Thermal pressure is not execution time but reduces the maximum
> possible capacity of a CPU. So IRQ scaling should not be applied.

thermal pressure uses clock_task so it has the same constraint as RT,
DL and CFS signal i.e. irq time is not accounted

>
> Thus, in this order:
>  - subtract thermal pressure
>  - apply IRQ scaling on the remaining capacity (RT + DL + CFS + free)
>  - subtract IRQ util
>
> Also, sort variables in reverse tree order.
>
> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
> ---
>  kernel/sched/fair.c | 19 ++++++++++++-------
>  1 file changed, 12 insertions(+), 7 deletions(-)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index bcae7bdd5582..546e490d6753 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8468,16 +8468,23 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>
>  static unsigned long scale_rt_capacity(int cpu)
>  {
> -       struct rq *rq = cpu_rq(cpu);
>         unsigned long max = arch_scale_cpu_capacity(cpu);
> +       struct rq *rq = cpu_rq(cpu);
> +       unsigned long irq, thermal;
>         unsigned long used, free;
> -       unsigned long irq;
>
>         irq = cpu_util_irq(rq);
>
>         if (unlikely(irq >= max))
>                 return 1;
>
> +       thermal = thermal_load_avg(rq);
> +       if (unlikely(thermal >= max))
> +               return 1;
> +
> +       free = max - thermal;
> +       free = scale_irq_capacity(free, irq, max);
> +
>         /*
>          * avg_rt.util_avg and avg_dl.util_avg track binary signals
>          * (running and not running) with weights 0 and 1024 respectively.
> @@ -8486,14 +8493,12 @@ static unsigned long scale_rt_capacity(int cpu)
>          */
>         used = READ_ONCE(rq->avg_rt.util_avg);
>         used += READ_ONCE(rq->avg_dl.util_avg);
> -       used += thermal_load_avg(rq);
> +       used += irq;

rq->avg_rt.util_avg and irq==cpu_util_irq(rq)) are not in the same
time scale so you can't add them


>
> -       if (unlikely(used >= max))
> +       if (unlikely(used >= free))
>                 return 1;
>
> -       free = max - used;
> -
> -       return scale_irq_capacity(free, irq, max);
> +       return free - used;
>  }
>
>  static void update_cpu_capacity(struct sched_domain *sd, int cpu)
> --
> 2.25.1
>
