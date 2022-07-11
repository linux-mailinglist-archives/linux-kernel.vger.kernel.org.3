Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC30C570282
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:38:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231849AbiGKMiR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:38:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231700AbiGKMh5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:37:57 -0400
Received: from mail-yb1-xb33.google.com (mail-yb1-xb33.google.com [IPv6:2607:f8b0:4864:20::b33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D8E8A61B2B
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:36:33 -0700 (PDT)
Received: by mail-yb1-xb33.google.com with SMTP id r3so8463697ybr.6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:36:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=wU3aWOEOlTUD1w2aJA6XSCUaFvlQa92cKstbtnwY51o=;
        b=gvBj2NzJECgUn9C2NTazdvyRZR6Ik93r/8eOr+sxN52mQF4XrJjxNF0CJk7gwhE+4H
         bSvBRrceCaoXhsgqRjbDVhR2sOq2oSIKyML51RdNpQBqGOVDyPA1L3AUc0vb9rKylk5t
         53VXQnAERK8zp9W7TYbSbxb1zBBoh2j8gEPe/HScEJQls8wxpwo/XVdrT+4vB4WjJyAQ
         8YS/u02zLZ0bXuISoIAbr306ysv3UJ/+72yof1hvqxKPSv1HwsIGQkjpGSyB1IVSEMvS
         N4Sl7UMuCQ7ordgRPXJemXDphQx1vvGET92V9PnSThQxZrabPW92z+3RDSTWEZ+yX/6W
         w2pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=wU3aWOEOlTUD1w2aJA6XSCUaFvlQa92cKstbtnwY51o=;
        b=rd2Bb+d19vWmazMJhnQsMNUnf/zR41vRQtiEjJypUBP36iO6jZ4ciwAPGDBFg3gSED
         7lkuoO4Y9R6nkA6yb6MBnDUq9QEU/ncSShrkpwuUM3KqeGsG8sUKCPAjIhGSFBWnVIKS
         B6zME5o1nyTJZTp9c5uw/6mZVUhsFqyphwszg7xiBrZ6Mz/DL9NcPd3+02RMqlaUyPUS
         c7sufUla8yysToZ+MwG95oNVBRd9TkKXI0QFaX73zaQDSi458crvL1qmkQv1dXVblBDI
         m0Dl7qyEiG+zO4X4WKBgl2lme4GWfnYEHTUjhxGNb4YtgL74imhBGKo5OnUj0idRzQ5Y
         tnkw==
X-Gm-Message-State: AJIora//WRm++kpIiuKoMY1mNiVhslgKzqGFbjqThIxoHzp+B4UOsDiW
        wtLAzqv5xie+/QHYyRqyHCVI0oeUGjoO/2EKjffF7br4Eec19A==
X-Google-Smtp-Source: AGRyM1tQUZXnnS2kxfSGaoWawbg8aAohdNumoic+qvDBX++tToZxexafAxFAcsAKBCc4II5jTvEje9rVrjAfFvFwzBE=
X-Received: by 2002:a25:bed0:0:b0:664:b4af:5bc9 with SMTP id
 k16-20020a25bed0000000b00664b4af5bc9mr16664622ybm.424.1657542985781; Mon, 11
 Jul 2022 05:36:25 -0700 (PDT)
MIME-Version: 1.0
References: <20220629194632.1117723-1-qais.yousef@arm.com> <20220629194632.1117723-2-qais.yousef@arm.com>
In-Reply-To: <20220629194632.1117723-2-qais.yousef@arm.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 11 Jul 2022 14:36:14 +0200
Message-ID: <CAKfTPtBAOLzYocTEg3KErACSyrAWDU94NdR7EAOnW0gti2GiDQ@mail.gmail.com>
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

On Wed, 29 Jun 2022 at 21:47, Qais Yousef <qais.yousef@arm.com> wrote:
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
>
> Similar corner cases exist for uclamp and usage of capacity_of().
> Slightest irq pressure on biggest CPU for example will make a 1024
> boosted task look like it can't fit.
>
> What we really want is for uclamp comparisons to ignore the migration
> margin and capacity pressure, yet retain them for when checking the
> _actual_ util signal.

I fully agree on the migration margin but I'm a bit more skeptical
about the capacity pressure. If uclam_min is set to ensure a minimum
compute capacity of X for a task but the CPU can't provide such
capacity because of some pressures (I have irq and thermal in mind),
then we should find a better cpu otherwise uclamp_min becomes
meaningless because it doesn't ensure a minimum compute capacity which
usually means a time to execute the work of the thread

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
>
> Similar reasoning applies to capping tasks with UCLAMP_MAX. For example:
>
>         p->util_avg = 1024
>         p->uclamp[UCLAMP_MAX] = capacity_orig_of(medium_cpu)
>
> Should fit the task on medium cpus without triggering overutilized
> state.
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

I don't fully agree on this. see below

> +        *
> +        * If a task is boosted to 1024 for example, we don't want a tiny
> +        * pressure to skew the check whether it fits a CPU or not.

But should we look for a CPU with less pressure  ?

Another example:
Task boosted to capacity_orig_of(medium_cpu) and there is pressure of
this medium CPU. Shouldn't we look for another CPU either a medium
without pressure or a big core if all mediums are under pressure ?
Otherwise, uclamp_min can become somewhat meaningless because you will
not have the requested min capacity when running. If you really want
your task to never go on big core, some cpu affinity would be a better
way to achieve this


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

Is this intermediate variable max_capacity really needed ?

> +       uclamp_max_fits = !max_capacity && (uclamp_max <= capacity_orig);
> +       fits = fits || uclamp_max_fits;
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
