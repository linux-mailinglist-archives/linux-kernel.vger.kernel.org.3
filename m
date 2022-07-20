Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 29D4157B18A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:17:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230039AbiGTHR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230416AbiGTHRY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:17:24 -0400
Received: from mail-lj1-x22a.google.com (mail-lj1-x22a.google.com [IPv6:2a00:1450:4864:20::22a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DF3E466B9F
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:17:22 -0700 (PDT)
Received: by mail-lj1-x22a.google.com with SMTP id q7so20058255lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:17:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZC7HVTEFve+LCLxIOK2U5RabWbYkthZn0umMUnZX5R0=;
        b=laqv3WkA2qPgEivcprYXB8QWi8aqZXRolsibQJlkYm4h8JoD4rLhLwg1zWEHIvdIYH
         DgupVuC6jousYZGAkSkBMoBH+Oc9I4Z9j/ScCEVSZjJG1IdIqe/Wj4rZN29W5v1ImwHd
         jIcz08qpbmfq05SY+OjsQj98BwOTQJwam7CCYyY61uQ6pVa/bL29gUm11npVWAlsLxC1
         EoH26elpEpqGMwWtpOnljgd5C8tCFRuomLZw9Pn/5KvBc4uWtphZIKkNORnfqhafU6WO
         ZOaPp/durcYAiQAdgvigqmq6a0rovo8NPf9LtrkCN2GpHjQCx+b7B1PKuwDpGGlzJ8Ct
         Lp2Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZC7HVTEFve+LCLxIOK2U5RabWbYkthZn0umMUnZX5R0=;
        b=hgbt7jPaofQvILTVB7DXlVhr4kzbmaM+X2BshwKJnMKYZPxqTrHI7PQyK6rqjavvcp
         xwDlYZwzPJFSeH3bVxgNE0LPZwRfkz7sdL2Wx65Bj7I17eMhI4fc5n/OT4ZEFe9lY2QZ
         PIzaY3q46yNdx5wrrBiXvtaJlZ2q4epmlXo9VyGrH2PvYcnwpO6fOXr0gFCOB/7/X9xT
         rKIEcpJtemZvbbC69gvsJbP03JLvn2IaguPZNKTY8dibcjzoRPGBh6BjzsOFzUl8kQsb
         8dwMVa1xKqniEskeNxCJBe8jooY02Jm8IzDIqdPysXPdl3tPWVPneHX5XwCVrQHWfaO7
         ZYWg==
X-Gm-Message-State: AJIora/UsAi1v5vXdt0gRW75bXkCLR/onyxNAeWbdvKGm8enF9zxI/CQ
        Tu/xCis8v6PxOnFCwwkUuwQJq7ttrFQDRGFRjIY=
X-Google-Smtp-Source: AGRyM1uIiO68OHznp3qmcGXtNBZMd6FWhwDFmjGcPbfiMyurTGXucT4iEdS8tqm8ROlr1FJF/ktGYGFwe5NYx3+jY6A=
X-Received: by 2002:a2e:bc1c:0:b0:25d:a703:266e with SMTP id
 b28-20020a2ebc1c000000b0025da703266emr10920696ljf.356.1658301441083; Wed, 20
 Jul 2022 00:17:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220629194632.1117723-1-qais.yousef@arm.com> <20220629194632.1117723-2-qais.yousef@arm.com>
In-Reply-To: <20220629194632.1117723-2-qais.yousef@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 20 Jul 2022 15:17:10 +0800
Message-ID: <CAB8ipk-PzwsfTzJtfrq6vJJdDNHsnGKrHjFR+527SoxBNQy0YA@mail.gmail.com>
Subject: Re: [PATCH 1/7] sched/uclamp: Fix relationship between uclamp and
 migration margin
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Qais,

On Thu, Jun 30, 2022 at 3:47 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> fits_capacity() verifies that a util is within 20% margin of the
> capacity of a CPU, which is an attempt to speed up upmigration.
>
> But when uclamp is used, this 20% margin is problematic because for
> example if a task is boosted to 1024, then it will not fit on any CPU
> according to fits_capacity() logic.
>
> Or if a task is boosted to capacity_orig_of(medium_cpu). The task will
> end up on big instead on the desired medium CPU.

I think it is reasonable. Since the user sets uclamp_min to be greater
than 0, the user prefers that the process has better performance cpu.
If ignore the margin here, the uclamp_min is meaningless.

>
> Similar corner cases exist for uclamp and usage of capacity_of().
> Slightest irq pressure on biggest CPU for example will make a 1024
> boosted task look like it can't fit.

I think it can't fit is reasonable. The uclamp_min is limit the
util_avg, if the task can fit the cpu with capacity is 1024, which
uclamp_min is 1024, How to deal with the task which util is 1024?
Maybe your idea is that the biggest cpu can fit any task even if it's
util is 1024?

>
> What we really want is for uclamp comparisons to ignore the migration
> margin and capacity pressure, yet retain them for when checking the
> _actual_ util signal.
>
> For example, task p:
>
>         p->util_avg = 300
>         p->uclamp[UCLAMP_MIN] = 1024
>
> Will fit a big CPU. But
>
>         p->util_avg = 900
>         p->uclamp[UCLAMP_MIN] = 1024
>
> will not, this should trigger overutilized state because the big CPU is
> now *actually* being saturated.

Now the code would catch the uclamp before judging the fits_capacity.
The two task both can not fit the cpu, why the task(300) can fit the
cpu?

>
> Similar reasoning applies to capping tasks with UCLAMP_MAX. For example:
>
>         p->util_avg = 1024
>         p->uclamp[UCLAMP_MAX] = capacity_orig_of(medium_cpu)
>
> Should fit the task on medium cpus without triggering overutilized
> state.

I fully agree with this! But there is a problem, How to do when there
is RT pressure or irq pressure?
Maybe it is better to compare the uclamp_max with the capacity_of(cpu)
instead of the capacity_origin?

>
> Inlined comments expand more on desired behavior in more scenarios.
>
> Introduce new util_fits_cpu() function which encapsulates the new logic.
> The new function is not used anywhere yet, but will be used to update
> various users of fits_capacity() in later patches.
>
> Fixes: af24bde8df202 ("sched/uclamp: Add uclamp support to energy_compute()")
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/fair.c | 114 ++++++++++++++++++++++++++++++++++++++++++++
>  1 file changed, 114 insertions(+)
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f80ae86bb404..5eecae32a0f6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4203,6 +4203,120 @@ static inline void util_est_update(struct cfs_rq *cfs_rq,
>         trace_sched_util_est_se_tp(&p->se);
>  }
>
> +static inline int util_fits_cpu(unsigned long util,
> +                               unsigned long uclamp_min,
> +                               unsigned long uclamp_max,
> +                               int cpu)
> +{

May the function name is not proper when the uclamp is unused.

> +       unsigned long capacity = capacity_of(cpu);
> +       unsigned long capacity_orig;
> +       bool fits, max_capacity;
> +       bool uclamp_max_fits;
> +
> +       /*
> +        * Check if the real util fits without any uclamp boost/cap applied.
> +        */
> +       fits = fits_capacity(util, capacity);
> +
> +       if (!uclamp_is_used())
> +               return fits;
> +
> +       /*
> +        * We must use capacity_orig_of() for comparing against uclamp_min and
> +        * uclamp_max. We only care about capacity pressure (by using
> +        * capacity_of()) for comparing against the real util.
> +        *
> +        * If a task is boosted to 1024 for example, we don't want a tiny
> +        * pressure to skew the check whether it fits a CPU or not.
> +        *
> +        * Similarly if a task is capped to capacity_orig_of(little_cpu), it
> +        * should fit a little cpu even if there's some pressure.
> +        *
> +        * Known limitation is when thermal pressure is severe to the point
> +        * where we have capacity inversion. We don't cater for that as the
> +        * system performance will already be impacted severely.
> +        */
> +       capacity_orig = capacity_orig_of(cpu);
> +
> +       /*
> +        * We want to force a task to fit a cpu as implied by uclamp_max.
> +        * But we do have some corner cases to cater for..
> +        *
> +        *
> +        *                                 C=z
> +        *   |                             ___
> +        *   |                  C=y       |   |
> +        *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _  uclamp_max
> +        *   |      C=x        |   |      |   |
> +        *   |      ___        |   |      |   |
> +        *   |     |   |       |   |      |   |    (util somewhere in this region)
> +        *   |     |   |       |   |      |   |
> +        *   |     |   |       |   |      |   |
> +        *   +----------------------------------------
> +        *         cpu0        cpu1       cpu2
> +        *
> +        *   In the above example if a task is capped to a specific performance
> +        *   point, y, then when:
> +        *
> +        *   * util = 80% of x then it does not fit on cpu0 and should migrate
> +        *     to cpu1
> +        *   * util = 80% of y then it is forced to fit on cpu1 to honour
> +        *     uclamp_max request.
> +        *
> +        *   which is what we're enforcing here. A task always fits if
> +        *   uclamp_max <= capacity_orig. But when uclamp_max > capacity_orig,
> +        *   the normal upmigration rules should withhold still.
> +        *
> +        *   Only exception is when we are on max capacity, then we need to be
> +        *   careful not to block overutilized state. This is so because:
> +        *
> +        *     1. There's no concept of capping at max_capacity! We can't go
> +        *        beyond this performance level anyway.
> +        *     2. The system is being saturated when we're operating near
> +        *        max_capacity, it doesn't make sense to block overutilized.
> +        */
> +       max_capacity = (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE);
> +       uclamp_max_fits = !max_capacity && (uclamp_max <= capacity_orig);
> +       fits = fits || uclamp_max_fits;

As I said above, Using the capacity_orig may ignore the rt/irq pressure.
If we have two or more middle cpus, we can select the cpu whose rt/irq
pressure is smaller.
If using the capacity_orig, the first MID cpu is always the candidate.

> +
> +       /*
> +        *
> +        *                                 C=z
> +        *   |                             ___       (region a, capped, util >= uclamp_max)
> +        *   |                  C=y       |   |
> +        *   |_ _ _ _ _ _ _ _ _ ___ _ _ _ | _ | _ _ _ _ _ uclamp_max
> +        *   |      C=x        |   |      |   |
> +        *   |      ___        |   |      |   |      (region b, uclamp_min <= util <= uclamp_max)
> +        *   |_ _ _|_ _|_ _ _ _| _ | _ _ _| _ | _ _ _ _ _ uclamp_min
> +        *   |     |   |       |   |      |   |
> +        *   |     |   |       |   |      |   |      (region c, boosted, util < uclamp_min)
> +        *   +----------------------------------------
> +        *         cpu0        cpu1       cpu2
> +        *
> +        * a) If util > uclamp_max, then we're capped, we don't care about
> +        *    actual fitness value here. We only care if uclamp_max fits
> +        *    capacity without taking margin/pressure into account.
> +        *    See comment above.
> +        *
> +        * b) If uclamp_min <= util <= uclamp_max, then the normal
> +        *    fits_capacity() rules apply. Except we need to ensure that we
> +        *    enforce we remain within uclamp_max, see comment above.
> +        *
> +        * c) If util < uclamp_min, then we are boosted. Same as (b) but we
> +        *    need to take into account the boosted value fits the CPU without
> +        *    taking margin/pressure into account.
> +        *
> +        * Cases (a) and (b) are handled in the 'fits' variable already. We
> +        * just need to consider an extra check for case (c) after ensuring we
> +        * handle the case uclamp_min > uclamp_max.
> +        */
> +       uclamp_min = min(uclamp_min, uclamp_max);
> +       if (util < uclamp_min)
> +               fits = fits && (uclamp_min <= capacity_orig);

As said above, I think the uclamp_min should consider the margin.

> +
> +       return fits;
> +}
> +
>  static inline int task_fits_capacity(struct task_struct *p,
>                                      unsigned long capacity)
>  {
> --
> 2.25.1
>

Thanks!
BR
---
xuewen.yan
