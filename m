Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83DFD57B1C7
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:31:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231159AbiGTHbQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:31:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50824 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229984AbiGTHbM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:31:12 -0400
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00ED930F61
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:31:10 -0700 (PDT)
Received: by mail-lf1-x12e.google.com with SMTP id d12so28799213lfq.12
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:31:10 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qVD438c/qMHcP3YF4mUF+BEHLUy6O2VfnSTLupfA3+E=;
        b=pGKoI6tXDBkbLmwOLHwjv+gLgujzWTnrmOUSwtVzJbbx2M1chmhV8u9MQDFW3sPdRk
         Unu7+z50KTXfG11j0PG1eTCtlMmPRTjk8v+1lvr0u/m/S7U/Y8Qz/CwAsCciTY8HrL/Z
         6TVCFZ0E+05yyStITE/1r4DOYqN7FZa8wFUE4BRGr+Ih4yFDc6MSEXQLPIlaSYBKM0Y1
         lpePupv84Atn0yTFo9A8+WY5lAY7JtKFuzKpTH5COvewQXcNzcYTH+oC9yZuDOQq33rm
         JVCiXciEzVwZfGp5K4YZuoduA/6z3ZJ5G+FoIteEDM0EMdjFb3NVuRcZCW7NNTbNP/in
         6/oQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qVD438c/qMHcP3YF4mUF+BEHLUy6O2VfnSTLupfA3+E=;
        b=nIfe+FCBjH8hZ3vhTS4ZiCGyFbnRrEOkLDfBp73SUXlrrSpqW/BHCFymbWIcbwLa6M
         jef3OsaBE+kQT0AQ60t18DfSdSpQ4ZC+wP5q2bamSQWMI/Aqzxzavjre95QlI8QNlOeK
         wSzD4iWax69wJmhedfRenlgYGwkHStzuVdmBYcxEkyzSHvxrfd7swN1HsDeHDdd6IkYc
         3VUOFPtRODv2mlYOlMo3HXADRYp5UwtWVvlYa/Z2LE6rL/49w/n+B2rt18xLu8/3njUE
         7/uHEWaEKdjvIdYj+JFWUGGkV+GcYU/m9550KzAU4ztT7kSrUocAjZvtZ1dqDd6Rv13S
         GzrA==
X-Gm-Message-State: AJIora9Ord9GkenSD3iYqGzXS05Hczwmb2Pi7p5njCyOrkZYXtzGliHD
        v+5TuPBn2QERIs91TZw1TLsgGNmjWni+Yys5o4Y=
X-Google-Smtp-Source: AGRyM1utIKsIBlnakln99Sy6uVVmG9Nw4lb9JMhTKT2habayuzoTEwBZjeADArwlEGBqBlYfWZzF1niaQR1minCZoTU=
X-Received: by 2002:a05:6512:3c95:b0:48a:3d1:9df with SMTP id
 h21-20020a0565123c9500b0048a03d109dfmr20385097lfv.641.1658302269234; Wed, 20
 Jul 2022 00:31:09 -0700 (PDT)
MIME-Version: 1.0
References: <20220629194632.1117723-1-qais.yousef@arm.com> <20220629194632.1117723-4-qais.yousef@arm.com>
In-Reply-To: <20220629194632.1117723-4-qais.yousef@arm.com>
From:   Xuewen Yan <xuewen.yan94@gmail.com>
Date:   Wed, 20 Jul 2022 15:30:58 +0800
Message-ID: <CAB8ipk_mjv6RGAL+2ZY2AKoRrf6LR-d5yJ=4Fz-+DW=aHDOpYQ@mail.gmail.com>
Subject: Re: [PATCH 3/7] sched/uclamp: Fix fits_capacity() check in feec()
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Yun Hsiang <hsiang023167@gmail.com>
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

Hi Qais

On Thu, Jun 30, 2022 at 3:48 AM Qais Yousef <qais.yousef@arm.com> wrote:
>
> As reported by Yun Hsiang [1], if a task has its uclamp_min >= 0.8 * 1024,
> it'll always pick the previous CPU because fits_capacity() will always
> return false in this case.
>
> The new util_fits_cpu() logic should handle this correctly for us beside
> more corner cases where similar failures could occur, like when using
> UCLAMP_MAX.
>
> We open code uclamp_rq_util_with() except for the clamp() part,
> util_fits_cpu() needs the 'raw' values to be passed to it.
>
> Also introduce uclamp_rq_{set, get}() shorthand accessors to get uclamp
> value for the rq. Makes the code more readable and ensures the right
> rules (use READ_ONCE/WRITE_ONCE) are respected transparently.
>
> [1] https://lists.linaro.org/pipermail/eas-dev/2020-July/001488.html
>
> Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
> Reported-by: Yun Hsiang <hsiang023167@gmail.com>
> Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> ---
>  kernel/sched/core.c  | 10 +++++-----
>  kernel/sched/fair.c  | 26 ++++++++++++++++++++++++--
>  kernel/sched/sched.h | 40 ++++++++++++++++++++++++++++++++++++++--
>  3 files changed, 67 insertions(+), 9 deletions(-)
>
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d3e2c5a7c1b7..f5dac570d6c5 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -1404,7 +1404,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
>         if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
>                 return;
>
> -       WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
> +       uclamp_rq_set(rq, clamp_id, clamp_value);
>  }
>
>  static inline
> @@ -1555,8 +1555,8 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
>         if (bucket->tasks == 1 || uc_se->value > bucket->value)
>                 bucket->value = uc_se->value;
>
> -       if (uc_se->value > READ_ONCE(uc_rq->value))
> -               WRITE_ONCE(uc_rq->value, uc_se->value);
> +       if (uc_se->value > uclamp_rq_get(rq, clamp_id))
> +               uclamp_rq_set(rq, clamp_id, uc_se->value);
>  }
>
>  /*
> @@ -1622,7 +1622,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>         if (likely(bucket->tasks))
>                 return;
>
> -       rq_clamp = READ_ONCE(uc_rq->value);
> +       rq_clamp = uclamp_rq_get(rq, clamp_id);
>         /*
>          * Defensive programming: this should never happen. If it happens,
>          * e.g. due to future modification, warn and fixup the expected value.
> @@ -1630,7 +1630,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
>         SCHED_WARN_ON(bucket->value > rq_clamp);
>         if (bucket->value >= rq_clamp) {
>                 bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
> -               WRITE_ONCE(uc_rq->value, bkt_clamp);
> +               uclamp_rq_set(rq, clamp_id, bkt_clamp);
>         }
>  }
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 313437bea5a2..c80c676ab1bc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6878,6 +6878,8 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
>  static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>  {
>         unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
> +       unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
> +       unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
>         struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
>         int cpu, best_energy_cpu = prev_cpu, target = -1;
>         unsigned long cpu_cap, util, base_energy = 0;
> @@ -6907,6 +6909,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>
>         for (; pd; pd = pd->next) {
>                 unsigned long cur_delta, spare_cap, max_spare_cap = 0;
> +               unsigned long rq_util_min, rq_util_max;
> +               unsigned long util_min, util_max;
>                 bool compute_prev_delta = false;
>                 unsigned long base_energy_pd;
>                 int max_spare_cap_cpu = -1;
> @@ -6927,8 +6931,26 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
>                          * much capacity we can get out of the CPU; this is
>                          * aligned with sched_cpu_util().
>                          */
> -                       util = uclamp_rq_util_with(cpu_rq(cpu), util, p);
> -                       if (!fits_capacity(util, cpu_cap))
> +                       if (uclamp_is_used()) {
> +                               if (uclamp_rq_is_idle(cpu_rq(cpu))) {
> +                                       util_min = p_util_min;
> +                                       util_max = p_util_max;
> +                               } else {
> +                                       /*
> +                                        * Open code uclamp_rq_util_with() except for
> +                                        * the clamp() part. Ie: apply max aggregation
> +                                        * only. util_fits_cpu() logic requires to
> +                                        * operate on non clamped util but must use the
> +                                        * max-aggregated uclamp_{min, max}.
> +                                        */
> +                                       rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> +                                       rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> +
> +                                       util_min = max(rq_util_min, p_util_min);
> +                                       util_max = max(rq_util_max, p_util_max);
> +                               }
> +                       }
> +                       if (!util_fits_cpu(util, util_min, util_max, cpu))
>                                 continue;
>
>                         if (cpu == prev_cpu) {
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 9599d2eea3e7..69c4d35988b9 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2907,6 +2907,23 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
>  #ifdef CONFIG_UCLAMP_TASK
>  unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
>
> +static inline unsigned long uclamp_rq_get(struct rq *rq,
> +                                         enum uclamp_id clamp_id)
> +{
> +       return READ_ONCE(rq->uclamp[clamp_id].value);
> +}
> +
> +static inline void uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id,
> +                                unsigned int value)
> +{
> +       WRITE_ONCE(rq->uclamp[clamp_id].value, value);
> +}
> +
> +static inline bool uclamp_rq_is_idle(struct rq *rq)
> +{
> +       return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
> +}

Can you replace the idle judgment in the uclamp_rq_util_with()
function by the way?

> +
>  /**
>   * uclamp_rq_util_with - clamp @util with @rq and @p effective uclamp values.
>   * @rq:                The rq to clamp against. Must not be NULL.
> @@ -2946,8 +2963,8 @@ unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>                         goto out;
>         }
>
> -       min_util = max_t(unsigned long, min_util, READ_ONCE(rq->uclamp[UCLAMP_MIN].value));
> -       max_util = max_t(unsigned long, max_util, READ_ONCE(rq->uclamp[UCLAMP_MAX].value));
> +       min_util = max_t(unsigned long, min_util, uclamp_rq_get(rq, UCLAMP_MIN));
> +       max_util = max_t(unsigned long, max_util, uclamp_rq_get(rq, UCLAMP_MAX));
>  out:
>         /*
>          * Since CPU's {min,max}_util clamps are MAX aggregated considering
> @@ -3010,6 +3027,25 @@ static inline bool uclamp_is_used(void)
>  {
>         return false;
>  }
> +
> +static inline unsigned long uclamp_rq_get(struct rq *rq,
> +                                         enum uclamp_id clamp_id)
> +{
> +       if (clamp_id == UCLAMP_MIN)
> +               return 0;
> +
> +       return SCHED_CAPACITY_SCALE;
> +}
> +
> +static inline void uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id,
> +                                unsigned int value)
> +{
> +}
> +
> +static inline bool uclamp_rq_is_idle(struct rq *rq)
> +{
> +       return false;
> +}
>  #endif /* CONFIG_UCLAMP_TASK */
>
>  #ifdef CONFIG_HAVE_SCHED_AVG_IRQ
> --
> 2.25.1
>

Thanks!
BR
----
xuewen.yan
