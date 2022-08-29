Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 38D925A46E6
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 12:13:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229599AbiH2KNt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 06:13:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40334 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229675AbiH2KNl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 06:13:41 -0400
Received: from mail-lf1-x130.google.com (mail-lf1-x130.google.com [IPv6:2a00:1450:4864:20::130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41494E47
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:13:40 -0700 (PDT)
Received: by mail-lf1-x130.google.com with SMTP id z25so10465845lfr.2
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 03:13:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=1/ET8JN98Ye+2oSbnSBckiDuz3aa/P73E4RHpohVUXc=;
        b=O3+Bm2FqeC36Q2AA8jc5nm+UKm3ZbQWSsP7vTzBYfP4b1Uiy56ZBUeIRsFx8zl7YpZ
         tQSpQcFt30vndgceV5CzgRgOGgZnZF8ecbb79SXmu9hJwdiJIgBpntu7ZbIR3pd4szl2
         N7mpH8tNlWtyJ8NjxzqJfczvIELP7Z9qTCAZg3arV2EFgMPYzoN7vgRYLz1UQsG6ykYc
         a/iEXaTt3mp2JmVOIfQ22De9JcjNSecNqRL0WeDTMN9I0+G4mSFNHIajxs/KhiabDsDT
         4f3cqLM7VfJCPh76l0VivjGgRFylGZGM1qWZ8y86e8i+ZH1fK8pr2BZHfNghg/+rNiV1
         zgAA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=1/ET8JN98Ye+2oSbnSBckiDuz3aa/P73E4RHpohVUXc=;
        b=IElCy31wT3ssXz24MfU2e2ScvxJC9xm89EdvtnCQ5GX0/aRRZNhT4ZAYXKGIbnhXfc
         iOqNDrVjg0vcwrs1VEoof0IsI3y2kLuxH/5RGezyHEngYO4obJl1xHt0dzIgNTS8DWJI
         oElcql60ZlGNVWJEklsTXWb2IYl4rkBegFG3vWEA2qz0LgL8Ja4zADedI9i7DhcS7lBh
         jU+0T2KxD85Gv4uf0TMAQvxr2JBKeMRARG3ESDnl58a2BX6zmZ+zQXPU3nLx7MZy4ZTO
         7mCs58Nb1xFuSDQNChMbmAOHJQecDQQ8JUMfNht/zf19uhzWFQyzk5wK2qN+c2TtrTC/
         M53Q==
X-Gm-Message-State: ACgBeo10yNKlTwaAcUBFfJoulXx6M6I6Kar7MVIIG7jOGjT1dmuZaLKQ
        WyrkuQbRnY/Mh6kldqrLSIRmgeNDpPHFJCjKnr+QwYFt42HLvnOE
X-Google-Smtp-Source: AA6agR4k0mPFoXTIHXgeTGQ7Ddw+kTJas6rx3CatpHDBznt62jZH2/1rDKJNIx885Gj8RA/6uXvP/DfHdaz9VKEVpdI=
X-Received: by 2002:a05:6512:159b:b0:492:c1c0:5aab with SMTP id
 bp27-20020a056512159b00b00492c1c05aabmr5966752lfb.523.1661768018550; Mon, 29
 Aug 2022 03:13:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <20220829055450.1703092-2-dietmar.eggemann@arm.com> <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
 <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net>
In-Reply-To: <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 29 Aug 2022 12:13:26 +0200
Message-ID: <CAKfTPtAnC4escfufhjJkqsYyhDPzpmQH4xYT4nj=EjCP7gzifg@mail.gmail.com>
Subject: Re: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Quentin Perret <qperret@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
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

On Mon, 29 Aug 2022 at 12:03, Peter Zijlstra <peterz@infradead.org> wrote:
>
> On Mon, Aug 29, 2022 at 10:08:13AM +0200, Peter Zijlstra wrote:
> > On Mon, Aug 29, 2022 at 07:54:50AM +0200, Dietmar Eggemann wrote:
> > > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > >
> > > The new sysctl sched_pelt_multiplier allows a user to set a clock
> > > multiplier to x2 or x4 (x1 being the default). This clock multiplier
> > > artificially speeds up PELT ramp up/down similarly to use a faster
> > > half-life than the default 32ms.
> > >
> > >   - x1: 32ms half-life
> > >   - x2: 16ms half-life
> > >   - x4: 8ms  half-life
> > >
> > > Internally, a new clock is created: rq->clock_task_mult. It sits in the
> > > clock hierarchy between rq->clock_task and rq->clock_pelt.
> > >
> > > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> >
> > > +extern unsigned int sched_pelt_lshift;
> > > +
> > > +/*
> > > + * absolute time   |1      |2      |3      |4      |5      |6      |
> > > + * @ mult = 1      --------****************--------****************-
> > > + * @ mult = 2      --------********----------------********---------
> > > + * @ mult = 4      --------****--------------------****-------------
> > > + * clock task mult
> > > + * @ mult = 2      |   |   |2  |3  |   |   |   |   |5  |6  |   |   |
> > > + * @ mult = 4      | | | | |2|3| | | | | | | | | | |5|6| | | | | | |
> > > + *
> > > + */
> > > +static inline void update_rq_clock_task_mult(struct rq *rq, s64 delta)
> > > +{
> > > +   delta <<= READ_ONCE(sched_pelt_lshift);
> > > +
> > > +   rq->clock_task_mult += delta;
> > > +
> > > +   update_rq_clock_pelt(rq, delta);
> > > +}
> >
> > Hurmph... I'd almost go write you something like
> > static_call()/static_branch() but for immediates.
> >
> > That said; given there's only like 3 options, perhaps a few
> > static_branch() instances work just fine ?
>
> Also, I'm not at all sure about exposing that as an official sysctl.

Me too, I would even make it a boot time parameter so we can remove
the new clock_task_mult clock and left shift clock_taslk or the delta
before passing it to clock_pelt

>
> How about something like so?
>
> ---
> Subject: sched/pelt: Introduce PELT multiplier
> From: Vincent Donnefort <vincent.donnefort@arm.com>
> Date: Mon, 29 Aug 2022 07:54:50 +0200
>
> From: Vincent Donnefort <vincent.donnefort@arm.com>
>
> The new sysctl sched_pelt_multiplier allows a user to set a clock
> multiplier to x2 or x4 (x1 being the default). This clock multiplier
> artificially speeds up PELT ramp up/down similarly to use a faster
> half-life than the default 32ms.
>
>   - x1: 32ms half-life
>   - x2: 16ms half-life
>   - x4: 8ms  half-life
>
> Internally, a new clock is created: rq->clock_task_mult. It sits in the
> clock hierarchy between rq->clock_task and rq->clock_pelt.
>
> [peterz: Use sched_feat()]
> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
> ---
>  kernel/sched/core.c     |    2 +-
>  kernel/sched/features.h |    3 +++
>  kernel/sched/pelt.h     |   45 +++++++++++++++++++++++++++++++++++++++++----
>  kernel/sched/sched.h    |    1 +
>  4 files changed, 46 insertions(+), 5 deletions(-)
>
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -727,7 +727,7 @@ static void update_rq_clock_task(struct
>         if ((irq_delta + steal) && sched_feat(NONTASK_CAPACITY))
>                 update_irq_load_avg(rq, irq_delta + steal);
>  #endif
> -       update_rq_clock_pelt(rq, delta);
> +       update_rq_clock_task_mult(rq, delta);
>  }
>
>  void update_rq_clock(struct rq *rq)
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -101,3 +101,6 @@ SCHED_FEAT(LATENCY_WARN, false)
>
>  SCHED_FEAT(ALT_PERIOD, true)
>  SCHED_FEAT(BASE_SLICE, true)
> +
> +SCHED_FEAT(PELT_M2, false)
> +SCHED_FEAT(PELT_M4, false)
> --- a/kernel/sched/pelt.h
> +++ b/kernel/sched/pelt.h
> @@ -61,6 +61,14 @@ static inline void cfs_se_util_change(st
>         WRITE_ONCE(avg->util_est.enqueued, enqueued);
>  }
>
> +static inline u64 rq_clock_task_mult(struct rq *rq)
> +{
> +       lockdep_assert_rq_held(rq);
> +       assert_clock_updated(rq);
> +
> +       return rq->clock_task_mult;
> +}
> +
>  static inline u64 rq_clock_pelt(struct rq *rq)
>  {
>         lockdep_assert_rq_held(rq);
> @@ -72,7 +80,7 @@ static inline u64 rq_clock_pelt(struct r
>  /* The rq is idle, we can sync to clock_task */
>  static inline void _update_idle_rq_clock_pelt(struct rq *rq)
>  {
> -       rq->clock_pelt  = rq_clock_task(rq);
> +       rq->clock_pelt = rq_clock_task_mult(rq);
>
>         u64_u32_store(rq->clock_idle, rq_clock(rq));
>         /* Paired with smp_rmb in migrate_se_pelt_lag() */
> @@ -121,6 +129,30 @@ static inline void update_rq_clock_pelt(
>         rq->clock_pelt += delta;
>  }
>
> +extern unsigned int sched_pelt_lshift;
> +
> +/*
> + * absolute time   |1      |2      |3      |4      |5      |6      |
> + * @ mult = 1      --------****************--------****************-
> + * @ mult = 2      --------********----------------********---------
> + * @ mult = 4      --------****--------------------****-------------
> + * clock task mult
> + * @ mult = 2      |   |   |2  |3  |   |   |   |   |5  |6  |   |   |
> + * @ mult = 4      | | | | |2|3| | | | | | | | | | |5|6| | | | | | |
> + *
> + */
> +static inline void update_rq_clock_task_mult(struct rq *rq, s64 delta)
> +{
> +       if (sched_feat(PELT_M2))
> +               delta *= 2;
> +       if (sched_feat(PELT_M4))
> +               delta *= 4;
> +
> +       rq->clock_task_mult += delta;
> +
> +       update_rq_clock_pelt(rq, delta);
> +}
> +
>  /*
>   * When rq becomes idle, we have to check if it has lost idle time
>   * because it was fully busy. A rq is fully used when the /Sum util_sum
> @@ -147,7 +179,7 @@ static inline void update_idle_rq_clock_
>          * rq's clock_task.
>          */
>         if (util_sum >= divider)
> -               rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
> +               rq->lost_idle_time += rq_clock_task_mult(rq) - rq->clock_pelt;
>
>         _update_idle_rq_clock_pelt(rq);
>  }
> @@ -218,13 +250,18 @@ update_irq_load_avg(struct rq *rq, u64 r
>         return 0;
>  }
>
> -static inline u64 rq_clock_pelt(struct rq *rq)
> +static inline u64 rq_clock_task_mult(struct rq *rq)
>  {
>         return rq_clock_task(rq);
>  }
>
> +static inline u64 rq_clock_pelt(struct rq *rq)
> +{
> +       return rq_clock_task_mult(rq);
> +}
> +
>  static inline void
> -update_rq_clock_pelt(struct rq *rq, s64 delta) { }
> +update_rq_clock_task_mult(struct rq *rq, s64 delta) { }
>
>  static inline void
>  update_idle_rq_clock_pelt(struct rq *rq) { }
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1009,6 +1009,7 @@ struct rq {
>         u64                     clock;
>         /* Ensure that all clocks are in the same cache line */
>         u64                     clock_task ____cacheline_aligned;
> +       u64                     clock_task_mult;
>         u64                     clock_pelt;
>         unsigned long           lost_idle_time;
>         u64                     clock_pelt_idle;
