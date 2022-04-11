Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A6DFC4FB663
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 10:52:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245704AbiDKIyv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 04:54:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55378 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245330AbiDKIyo (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 04:54:44 -0400
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EEC0A3E0E6
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:52:30 -0700 (PDT)
Received: by mail-lj1-x236.google.com with SMTP id o16so13319426ljp.3
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 01:52:30 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Yzii+7wJJXx4rmsIH8JU7Rv/Nm45ck1GdD0lRQwc/lQ=;
        b=HBjZQ+PBltHHNWxxc7wfAK2FE/Amccg3t++/kOcvyn8EHl6mnBdPZMWsnFz/rf+8IP
         Uv2NAldicLGcBlujPpTW+J8/Dviqw/0W1OT5/vGFPkrYV7QRgxliHXxfqMrZGVlNgi1j
         /rYYRAuH9jXTKD7K752k4Zn8VV7FrJC04mTlXWlJGaMHeNlLM8l5TnVWQvkusxcV1Ite
         YcoUMr5fM2RiOTwRadkfGJGmsSxsTn2D8M779bY6STPeoTo8TOYfoQHax7u3WMO+fkWE
         ob4jDpy17GmrRxKsP4jJCwES40i5UFpFiungtSz1hbkrb0tSD/PmIu/RCeFBdOyTVC2A
         +3zw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Yzii+7wJJXx4rmsIH8JU7Rv/Nm45ck1GdD0lRQwc/lQ=;
        b=7+O7nTBcp1oMKoKYLKCIAHJz2jpD7BfirpeZgGIWS3W6QJvzFfPsq/epoYYz3lfDFY
         BiMJZlftbPh1pRqwEPY+aycdbMoj2C82+jU0DmR3id73P3Wx5iXG1yilmrn+bG+xdk5P
         ASq1yKsDhtU/AZLmRbEomiy3iFBt+DSnmABbDrpG085BEwBddoR50yspPjCOdkDY/Awj
         g0TVubxYXhuSPFak59Tgt4A4WFc7bmnmcRL7MYk2pdkSXDIK2OkZlt1zW5fkzR0bw5sB
         hHA473sK0aDffxPLIh9aB0S6QUdmGyU8NLSlAFTmvq+O7NMpx3MJXNkodbda34jWNZ3e
         0rww==
X-Gm-Message-State: AOAM530kWTuP031xqN5HiHv4cPIcRZPewqGiwpVTPRLjRh21gr4RqiDP
        mJ8hluKFQeJm8qopLZ9hyAljxXwwUGoSCIIXLTg=
X-Google-Smtp-Source: ABdhPJxLKQjus17Hj1nrsBvASrK2ug1hFYjicbeFVagryWfzBHqWdSMv68e+nZiDFZmE2gPN3VJyEjgGLYETab4gpPI=
X-Received: by 2002:a05:651c:230e:b0:24b:5d17:9829 with SMTP id
 bi14-20020a05651c230e00b0024b5d179829mr5186654ljb.377.1649667148991; Mon, 11
 Apr 2022 01:52:28 -0700 (PDT)
MIME-Version: 1.0
References: <20220407051932.4071-1-xuewen.yan@unisoc.com> <02350916-aa36-ea53-2c98-91b97f49d27e@arm.com>
In-Reply-To: <02350916-aa36-ea53-2c98-91b97f49d27e@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Mon, 11 Apr 2022 16:52:18 +0800
Message-ID: <CAB8ipk-KenZaVWQwWqVMksQXLP5r19BQ1OGAdmwHRbjwv3qFHg@mail.gmail.com>
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, Lukasz.Luba@arm.com,
        rafael@kernel.org, viresh.kumar@linaro.org, mingo@redhat.com,
        peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

HI Dietmar

On Mon, Apr 11, 2022 at 4:21 PM Dietmar Eggemann
<dietmar.eggemann@arm.com> wrote:
>
> On 07/04/2022 07:19, Xuewen Yan wrote:
> > There are cases when the cpu max capacity might be reduced due to thermal.
> > Take into the thermal pressure into account when judge whether the rt task
> > fits the cpu. And when schedutil govnor get cpu util, the thermal pressure
> > also should be considered.
> >
> > Signed-off-by: Xuewen Yan <xuewen.yan@unisoc.com>
> > ---
> >  kernel/sched/cpufreq_schedutil.c | 1 +
> >  kernel/sched/rt.c                | 1 +
> >  2 files changed, 2 insertions(+)
> >
> > diff --git a/kernel/sched/cpufreq_schedutil.c b/kernel/sched/cpufreq_schedutil.c
> > index 3dbf351d12d5..285ad51caf0f 100644
> > --- a/kernel/sched/cpufreq_schedutil.c
> > +++ b/kernel/sched/cpufreq_schedutil.c
> > @@ -159,6 +159,7 @@ static void sugov_get_util(struct sugov_cpu *sg_cpu)
> >       struct rq *rq = cpu_rq(sg_cpu->cpu);
> >       unsigned long max = arch_scale_cpu_capacity(sg_cpu->cpu);
> >
> > +     max -= arch_scale_thermal_pressure(sg_cpu->cpu);
>
> max' = arch_scale_cpu_capacity() - arch_scale_thermal_pressure()
>
> For the energy part (A) we use max' in compute_energy() to cap sum_util
> and max_util at max' and to call em_cpu_energy(..., max_util, sum_util,
> max'). This was done to match (B)'s `policy->max` capping.
>
> For the frequency part (B) we have freq_qos_update_request() in:
>
> power_actor_set_power()
>   ...
>   cdev->ops->set_cur_state()
>
>     cpufreq_set_cur_state()
>       freq_qos_update_request()      <-- !
>       arch_update_thermal_pressure()
>
> restricting `policy->max` which then clamps `target_freq` in:
>
>   cpufreq_update_util()
>     ...
>     get_next_freq()
>       cpufreq_driver_resolve_freq()
>         __resolve_freq()
>

Do you mean that the "max" here will not affect the frequency
conversion, so there is no need to change it?
But is it better to reflect the influence of thermal here?

> [...]
>
> > diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > index a32c46889af8..d9982ebd4821 100644
> > --- a/kernel/sched/rt.c
> > +++ b/kernel/sched/rt.c
> > @@ -466,6 +466,7 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> >       max_cap = uclamp_eff_value(p, UCLAMP_MAX);
> >
> >       cpu_cap = capacity_orig_of(cpu);
> > +     cpu_cap -= arch_scale_thermal_pressure(cpu);
> >
> >       return cpu_cap >= min(min_cap, max_cap);
> >  }
>
> IMHO, this should follow what we do with rq->cpu_capacity
> (capacity_of(), the remaining capacity for CFS). E.g. we use
> capacity_of() in find_energy_efficient_cpu() and select_idle_capacity()
> to compare capacities. So we would need a function like
> scale_rt_capacity() for RT (minus the rq->avg_rt.util_avg) but then also
> one for DL (minus rq->avg_dl.util_avg and rq->avg_rt.util_avg).

It's a really good idea. And do you already have the corresponding patch?
If there is, can you tell me the corresponding link?

Thanks a lot!

BR
xuewen
