Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7143F571B0B
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Jul 2022 15:22:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232344AbiGLNWC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Jul 2022 09:22:02 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35832 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229760AbiGLNWA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Jul 2022 09:22:00 -0400
Received: from mail-yb1-xb30.google.com (mail-yb1-xb30.google.com [IPv6:2607:f8b0:4864:20::b30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E40343C8C3
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:21:58 -0700 (PDT)
Received: by mail-yb1-xb30.google.com with SMTP id i14so13902046yba.1
        for <linux-kernel@vger.kernel.org>; Tue, 12 Jul 2022 06:21:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=oVDWKHIq9JvQPJsWXktBxh6FdhYFEeIlPFL7iijeTqo=;
        b=gU9dYqJs78lQ7ErAckjyjNwsuZeWP/B8la6oKrDBPMTF/H4QbKckW7Y46Q2OZHvr3R
         WyHFVZoBzx7Ded1enZV4oziErOTLWBaWDFhrBUph3Z2BT1K/1ffZ8JM5COVdWnEnwzJr
         LHdbYGbR6kxeWIg+PlVNR+E6o+mKaX6rJvvw4ORY28gZKzTUEcy1pAKtAzE1uzyJ3P7U
         DUhXk1IgzSJbHlrAXKEFb8s23NQRbclfECOeLsvxY0Eg7HVIZo0eitLY0i/220ruf6Up
         rNTrSpa6aPLnyHZ8hKV5rUAivczerQOKSqprf9Np6ghALVTX1aNU9xFhCJZWmwJSBfDN
         7z0Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=oVDWKHIq9JvQPJsWXktBxh6FdhYFEeIlPFL7iijeTqo=;
        b=ZdNPd+Gzqx0r6490ouONFCfhmu5TtexkHYKlqAOWm4StuuRd2IIqQBdDY+byp+aphD
         ic+M+YYZfYsc/k8VMnlSfoIqEvp4GsOOhUlapzycALVrwnVT6OqlFGJXk6+T4iBYfv5u
         QLfBdNiFPufG/r8OQnPf3fZe1CmCTkRdtitxF8XTT1i7HcHWDo3vTcEZFl3FHwYAUVd2
         WUEipMeNUCtssD3xRhZOUYb527xPLPu9VlCE+99xPDryzy23uYB1TsGi4x0yo6X8YSZw
         Rcy6xAAWbmc8ESvkLbA1tSWQk9DH28QC2XtjJksfZQROjs+e10iEmIP/L5KaXagvpA1g
         B4fw==
X-Gm-Message-State: AJIora+46VfaBtcuSSVADDAT2a72CX1Bp01HWRmigDR2e5j2jpsBHOUE
        JAVi07nRPWrdhPBxnasM1Yk+oUPs3zUX+UU5WICd7g==
X-Google-Smtp-Source: AGRyM1uW2MavL0/2h+v/uea9oKVXYhkkJpX2J19OUrkHswTo2RjV5qBEwfGNERUXkykZeP2qZALmcdeY5vT/rxSsyfw=
X-Received: by 2002:a25:76cd:0:b0:66e:c634:1047 with SMTP id
 r196-20020a2576cd000000b0066ec6341047mr22914146ybc.241.1657632117890; Tue, 12
 Jul 2022 06:21:57 -0700 (PDT)
MIME-Version: 1.0
References: <20220629194632.1117723-1-qais.yousef@arm.com> <20220629194632.1117723-2-qais.yousef@arm.com>
 <CAKfTPtBAOLzYocTEg3KErACSyrAWDU94NdR7EAOnW0gti2GiDQ@mail.gmail.com> <20220712102334.6nwkbkilmmup4h4u@wubuntu>
In-Reply-To: <20220712102334.6nwkbkilmmup4h4u@wubuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 12 Jul 2022 15:21:46 +0200
Message-ID: <CAKfTPtDweeQDRcZb+_ANO6rzZd11vbiatoVxDNwsWPtoCTG+AQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] sched/uclamp: Fix relationship between uclamp and
 migration margin
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
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

On Tue, 12 Jul 2022 at 12:23, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 07/11/22 14:36, Vincent Guittot wrote:
> > On Wed, 29 Jun 2022 at 21:47, Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > fits_capacity() verifies that a util is within 20% margin of the
> > > capacity of a CPU, which is an attempt to speed up upmigration.
> > >
> > > But when uclamp is used, this 20% margin is problematic because for
> > > example if a task is boosted to 1024, then it will not fit on any CPU
> > > according to fits_capacity() logic.
> > >
> > > Or if a task is boosted to capacity_orig_of(medium_cpu). The task will
> > > end up on big instead on the desired medium CPU.
> > >
> > > Similar corner cases exist for uclamp and usage of capacity_of().
> > > Slightest irq pressure on biggest CPU for example will make a 1024
> > > boosted task look like it can't fit.
> > >
> > > What we really want is for uclamp comparisons to ignore the migration
> > > margin and capacity pressure, yet retain them for when checking the
> > > _actual_ util signal.
> >
> > I fully agree on the migration margin but I'm a bit more skeptical
> > about the capacity pressure. If uclam_min is set to ensure a minimum
> > compute capacity of X for a task but the CPU can't provide such
> > capacity because of some pressures (I have irq and thermal in mind),
> > then we should find a better cpu otherwise uclamp_min becomes
> > meaningless because it doesn't ensure a minimum compute capacity which
> > usually means a time to execute the work of the thread
>
> We need to be careful here about what uclamp_min means.
>
> uclamp is a performance hint, not a bandwidth hint. When a task p with:
>
>         p->util_avg = 300
>         p->uclamp_min = 1024
>
> what this means is that it needs to run at max performance point as it cares
> about how long it runs for. Its bandwidth which is defined but util_avg is 300
> which means there's plenty of idle time on the CPU. As you know better,
> util_avg of 300 could translate to different runtimes based on the performance
> point you're operating at.
>
> IOW, a uclamp_min of 1024 translates into task placement and frequency
> selection (biggest CPU and highest achievable OPP for 1024 case). Capacity
> pressure doesn't impact this selection. Only thermal pressure can actually
> impact our ability to achieve a performance level. I touched on this topic
> below.
>
> since p->util_avg reflect the true bandwidth of the task, 300 means there's
> plenty of idle time on that CPU and unless capacity pressure is higher than 724
> the task will always fit and be able to run at max perf point as uclamp_min
> hint indicated.
>
> Note that by design this means if there are 2 of these tasks whose util_avg is
> 300 and uclamp_min is 1024, then they both can be packed on the biggest CPU and
> run at the highest perf point with still plenty of idle time left on that CPU.
>
> The keyword here is that uclamp indicates performance level requirements, not
> bandwidth. We have cpushares, nice values, bandwidth controllers, etc for that.

That's why I have mentioned that I have thermal pressure and irq in
mind. I'm speaking about performance level but not about bandwidth and
time sharing.

If the thermal pressure makes the performance of the cpu half of the
capacity_orig, then you impact the performance  and you don't follow
the uclamp_min hint anymore.

>
> >
> > >
> > > For example, task p:
> > >
> > >         p->util_avg = 300
> > >         p->uclamp[UCLAMP_MIN] = 1024
> > >
> > > Will fit a big CPU. But
> > >
> > >         p->util_avg = 900
> > >         p->uclamp[UCLAMP_MIN] = 1024
> > >
> > > will not, this should trigger overutilized state because the big CPU is
> > > now *actually* being saturated.
> > >
> > > Similar reasoning applies to capping tasks with UCLAMP_MAX. For example:
> > >
> > >         p->util_avg = 1024
> > >         p->uclamp[UCLAMP_MAX] = capacity_orig_of(medium_cpu)
> > >
> > > Should fit the task on medium cpus without triggering overutilized
> > > state.
> > >
> > > Inlined comments expand more on desired behavior in more scenarios.
> > >
> > > Introduce new util_fits_cpu() function which encapsulates the new logic.
> > > The new function is not used anywhere yet, but will be used to update
> > > various users of fits_capacity() in later patches.
> > >
> > > Fixes: af24bde8df202 ("sched/uclamp: Add uclamp support to energy_compute()")
> > > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > > ---
> > >  kernel/sched/fair.c | 114 ++++++++++++++++++++++++++++++++++++++++++++
> > >  1 file changed, 114 insertions(+)
> > >
> > > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > > index f80ae86bb404..5eecae32a0f6 100644
> > > --- a/kernel/sched/fair.c
> > > +++ b/kernel/sched/fair.c
> > > @@ -4203,6 +4203,120 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
> > >         trace_sched_util_est_se_tp(&p->se);
> > >  }
> > >
> > > +static inline int util_fits_cpu(unsigned long util,
> > > +                               unsigned long uclamp_min,
> > > +                               unsigned long uclamp_max,
> > > +                               int cpu)
> > > +{
> > > +       unsigned long capacity = capacity_of(cpu);
> > > +       unsigned long capacity_orig;
> > > +       bool fits, max_capacity;
> > > +       bool uclamp_max_fits;
> > > +
> > > +       /*
> > > +        * Check if the real util fits without any uclamp boost/cap applied.
> > > +        */
> > > +       fits = fits_capacity(util, capacity);
> > > +
> > > +       if (!uclamp_is_used())
> > > +               return fits;
> > > +
> > > +       /*
> > > +        * We must use capacity_orig_of() for comparing against uclamp_min and
> > > +        * uclamp_max. We only care about capacity pressure (by using
> > > +        * capacity_of()) for comparing against the real util.
> >
> > I don't fully agree on this. see below
> >
> > > +        *
> > > +        * If a task is boosted to 1024 for example, we don't want a tiny
> > > +        * pressure to skew the check whether it fits a CPU or not.
> >
> > But should we look for a CPU with less pressure  ?
> >
> > Another example:
> > Task boosted to capacity_orig_of(medium_cpu) and there is pressure of
> > this medium CPU. Shouldn't we look for another CPU either a medium
> > without pressure or a big core if all mediums are under pressure ?
>
> Not if the *actual* utilization is small. As I tried to explain above uclamp
> hints indicates performance level requirements, which will be achieved
> regardless of the pressure. The only thing I'm worried about here is capacity

You seem to keep using the RT pressure in your example whereas I'm
more concerned by the thermal pressure as I mentioned previously. As
an example the thermal pressure reflects the impact on the performance
while task is running.

> inversion (like we saw for RT), but I think we need more infra structure to
> handle that case. And as I tried to explain on the RT thread, you can't just
> subtract thermal pressure because any tiny thermal pressure will mean 1024 hint
> will always be false. I think this area in general needs to be better defined
> and handled and I see it out of scope of these fixes.
>
> Generally EAS always looks for most energy efficient CPU with max spare
> capacity. So least busy medium will be picked. And if the mediums are pressued
> enough that adding this task will cause rq->util_avg to be high,
> util_fits_cpu() will see that and return false because actual utilization will
> be within the margin value and we should spell into the big cores then.
>
> If there's something simple to do now, I'll be happy to apply it. A simple
> subtraction of thermal pressure from capacity_orig_of won't cut it.
>
> > Otherwise, uclamp_min can become somewhat meaningless because you will
> > not have the requested min capacity when running. If you really want
>
> This can be only true if you interpret uclamp_min as bandwidth hint. Which as
> I explained above is not what uclamp_min means. Or maybe I misread your words
> :-)

TaskA usually runs 4 ms every 8ms but wants to ensure a running time
around 5ms. Task A asks for a uclamp_min of 768.
medium cpu capacity_orig is 800 but runs at half its max freq because
of thermal mitigation then your task will runs more than 8ms

>
> > your task to never go on big core, some cpu affinity would be a better
> > way to achieve this
>
> I hope I cleared this up with my answers above. The actual bandwidth used by
> the task and available by the CPU is not the same as the performance level.
>
> >
> >
> > > +        *
> > > +        * Similarly if a task is capped to capacity_orig_of(little_cpu), it
> > > +        * should fit a little cpu even if there's some pressure.
> > > +        *
> > > +        * Known limitation is when thermal pressure is severe to the point
> > > +        * where we have capacity inversion. We don't cater for that as the
> > > +        * system performance will already be impacted severely.
> > > +        */
> > > +       capacity_orig = capacity_orig_of(cpu);
> > > +
> > > +       /*
> > > +        * We want to force a task to fit a cpu as implied by uclamp_max.
> > > +        * But we do have some corner cases to cater for..
> > > +        *
> > > +        *
> > > +        *                                 C=z
> > > +        *   |                             ___
> > > +        *   |                  C=y       |   |
> > > +        *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _  uclamp_max
> > > +        *   |      C=x        |   |      |   |
> > > +        *   |      ___        |   |      |   |
> > > +        *   |     |   |       |   |      |   |    (util somewhere in this region)
> > > +        *   |     |   |       |   |      |   |
> > > +        *   |     |   |       |   |      |   |
> > > +        *   +----------------------------------------
> > > +        *         cpu0        cpu1       cpu2
> > > +        *
> > > +        *   In the above example if a task is capped to a specific performance
> > > +        *   point, y, then when:
> > > +        *
> > > +        *   * util = 80% of x then it does not fit on cpu0 and should migrate
> > > +        *     to cpu1
> > > +        *   * util = 80% of y then it is forced to fit on cpu1 to honour
> > > +        *     uclamp_max request.
> > > +        *
> > > +        *   which is what we're enforcing here. A task always fits if
> > > +        *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> > > +        *   the normal upmigration rules should withhold still.
> > > +        *
> > > +        *   Only exception is when we are on max capacity, then we need to be
> > > +        *   careful not to block overutilized state. This is so because:
> > > +        *
> > > +        *     1. There's no concept of capping at max_capacity! We can't go
> > > +        *        beyond this performance level anyway.
> > > +        *     2. The system is being saturated when we're operating near
> > > +        *        max_capacity, it doesn't make sense to block overutilized.
> > > +        */
> > > +       max_capacity = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> >
> > Is this intermediate variable max_capacity really needed ?
>
> I thought it helps with readability and breaks down an otherwise a very long
> line. Is it harmful?

uclamp_max_fits = (capacity_orig == SCHED_CAPACITY_SCALE) &&
(uclamp_max == SCHED_CAPACITY_SCALE);
uclamp_max_fits = !uclamp_max_fits && (uclamp_max <= capacity_orig);

Is the above less readable ?

Vincent
>
>
> Thanks!
>
> --
> Qais Yousef
>
> >
> > > +       uclamp_max_fits = !max_capacity && (uclamp_max <= capacity_orig);
> > > +       fits = fits || uclamp_max_fits;
> > > +
> > > +       /*
> > > +        *
> > > +        *                                 C=z
> > > +        *   |                             ___       (region a, capped, util >= uclamp_max)
> > > +        *   |                  C=y       |   |
> > > +        *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _ uclamp_max
> > > +        *   |      C=x        |   |      |   |
> > > +        *   |      ___        |   |      |   |      (region b, uclamp_min <= util <= uclamp_max)
> > > +        *   |_ _ _|_ _|_ _ _ _| _ | _ _ _| _ | _ _ _ _ _ uclamp_min
> > > +        *   |     |   |       |   |      |   |
> > > +        *   |     |   |       |   |      |   |      (region c, boosted, util < uclamp_min)
> > > +        *   +----------------------------------------
> > > +        *         cpu0        cpu1       cpu2
> > > +        *
> > > +        * a) If util > uclamp_max, then we're capped, we don't care about
> > > +        *    actual fitness value here. We only care if uclamp_max fits
> > > +        *    capacity without taking margin/pressure into account.
> > > +        *    See comment above.
> > > +        *
> > > +        * b) If uclamp_min <= util <= uclamp_max, then the normal
> > > +        *    fits_capacity() rules apply. Except we need to ensure that we
> > > +        *    enforce we remain within uclamp_max, see comment above.
> > > +        *
> > > +        * c) If util < uclamp_min, then we are boosted. Same as (b) but we
> > > +        *    need to take into account the boosted value fits the CPU without
> > > +        *    taking margin/pressure into account.
> > > +        *
> > > +        * Cases (a) and (b) are handled in the 'fits' variable already. We
> > > +        * just need to consider an extra check for case (c) after ensuring we
> > > +        * handle the case uclamp_min > uclamp_max.
> > > +        */
> > > +       uclamp_min = min(uclamp_min, uclamp_max);
> > > +       if (util < uclamp_min)
> > > +               fits = fits && (uclamp_min <= capacity_orig);
> > > +
> > > +       return fits;
> > > +}
> > > +
> > >  static inline int task_fits_capacity(struct task_struct *p,
> > >                                      unsigned long capacity)
> > >  {
> > > --
> > > 2.25.1
> > >
