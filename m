Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD6657CD2E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:19:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229506AbiGUOT0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:19:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58742 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiGUOTY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:19:24 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7718D8048A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:19:23 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BF2A71042;
        Thu, 21 Jul 2022 07:19:23 -0700 (PDT)
Received: from wubuntu (unknown [10.57.86.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9AEA73F73D;
        Thu, 21 Jul 2022 07:19:20 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:19:18 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Yun Hsiang <hsiang023167@gmail.com>
Subject: Re: [PATCH 3/7] sched/uclamp: Fix fits_capacity() check in feec()
Message-ID: <20220721141918.s2xlvrwqvulp6lyb@wubuntu>
References: <20220629194632.1117723-1-qais.yousef@arm.com>
 <20220629194632.1117723-4-qais.yousef@arm.com>
 <CAB8ipk_mjv6RGAL+2ZY2AKoRrf6LR-d5yJ=4Fz-+DW=aHDOpYQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk_mjv6RGAL+2ZY2AKoRrf6LR-d5yJ=4Fz-+DW=aHDOpYQ@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/22 15:30, Xuewen Yan wrote:
> Hi Qais
> 
> On Thu, Jun 30, 2022 at 3:48 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > As reported by Yun Hsiang [1], if a task has its uclamp_min >= 0.8 * 1024,
> > it'll always pick the previous CPU because fits_capacity() will always
> > return false in this case.
> >
> > The new util_fits_cpu() logic should handle this correctly for us beside
> > more corner cases where similar failures could occur, like when using
> > UCLAMP_MAX.
> >
> > We open code uclamp_rq_util_with() except for the clamp() part,
> > util_fits_cpu() needs the 'raw' values to be passed to it.
> >
> > Also introduce uclamp_rq_{set, get}() shorthand accessors to get uclamp
> > value for the rq. Makes the code more readable and ensures the right
> > rules (use READ_ONCE/WRITE_ONCE) are respected transparently.
> >
> > [1] https://lists.linaro.org/pipermail/eas-dev/2020-July/001488.html
> >
> > Fixes: 1d42509e475c ("sched/fair: Make EAS wakeup placement consider uclamp restrictions")
> > Reported-by: Yun Hsiang <hsiang023167@gmail.com>
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >  kernel/sched/core.c  | 10 +++++-----
> >  kernel/sched/fair.c  | 26 ++++++++++++++++++++++++--
> >  kernel/sched/sched.h | 40 ++++++++++++++++++++++++++++++++++++++--
> >  3 files changed, 67 insertions(+), 9 deletions(-)
> >
> > diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> > index d3e2c5a7c1b7..f5dac570d6c5 100644
> > --- a/kernel/sched/core.c
> > +++ b/kernel/sched/core.c
> > @@ -1404,7 +1404,7 @@ static inline void uclamp_idle_reset(struct rq *rq, enum uclamp_id clamp_id,
> >         if (!(rq->uclamp_flags & UCLAMP_FLAG_IDLE))
> >                 return;
> >
> > -       WRITE_ONCE(rq->uclamp[clamp_id].value, clamp_value);
> > +       uclamp_rq_set(rq, clamp_id, clamp_value);
> >  }
> >
> >  static inline
> > @@ -1555,8 +1555,8 @@ static inline void uclamp_rq_inc_id(struct rq *rq, struct task_struct *p,
> >         if (bucket->tasks == 1 || uc_se->value > bucket->value)
> >                 bucket->value = uc_se->value;
> >
> > -       if (uc_se->value > READ_ONCE(uc_rq->value))
> > -               WRITE_ONCE(uc_rq->value, uc_se->value);
> > +       if (uc_se->value > uclamp_rq_get(rq, clamp_id))
> > +               uclamp_rq_set(rq, clamp_id, uc_se->value);
> >  }
> >
> >  /*
> > @@ -1622,7 +1622,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
> >         if (likely(bucket->tasks))
> >                 return;
> >
> > -       rq_clamp = READ_ONCE(uc_rq->value);
> > +       rq_clamp = uclamp_rq_get(rq, clamp_id);
> >         /*
> >          * Defensive programming: this should never happen. If it happens,
> >          * e.g. due to future modification, warn and fixup the expected value.
> > @@ -1630,7 +1630,7 @@ static inline void uclamp_rq_dec_id(struct rq *rq, struct task_struct *p,
> >         SCHED_WARN_ON(bucket->value > rq_clamp);
> >         if (bucket->value >= rq_clamp) {
> >                 bkt_clamp = uclamp_rq_max_value(rq, clamp_id, uc_se->value);
> > -               WRITE_ONCE(uc_rq->value, bkt_clamp);
> > +               uclamp_rq_set(rq, clamp_id, bkt_clamp);
> >         }
> >  }
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 313437bea5a2..c80c676ab1bc 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -6878,6 +6878,8 @@ compute_energy(struct task_struct *p, int dst_cpu, struct perf_domain *pd)
> >  static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >  {
> >         unsigned long prev_delta = ULONG_MAX, best_delta = ULONG_MAX;
> > +       unsigned long p_util_min = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MIN) : 0;
> > +       unsigned long p_util_max = uclamp_is_used() ? uclamp_eff_value(p, UCLAMP_MAX) : 1024;
> >         struct root_domain *rd = cpu_rq(smp_processor_id())->rd;
> >         int cpu, best_energy_cpu = prev_cpu, target = -1;
> >         unsigned long cpu_cap, util, base_energy = 0;
> > @@ -6907,6 +6909,8 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >
> >         for (; pd; pd = pd->next) {
> >                 unsigned long cur_delta, spare_cap, max_spare_cap = 0;
> > +               unsigned long rq_util_min, rq_util_max;
> > +               unsigned long util_min, util_max;
> >                 bool compute_prev_delta = false;
> >                 unsigned long base_energy_pd;
> >                 int max_spare_cap_cpu = -1;
> > @@ -6927,8 +6931,26 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >                          * much capacity we can get out of the CPU; this is
> >                          * aligned with sched_cpu_util().
> >                          */
> > -                       util = uclamp_rq_util_with(cpu_rq(cpu), util, p);
> > -                       if (!fits_capacity(util, cpu_cap))
> > +                       if (uclamp_is_used()) {
> > +                               if (uclamp_rq_is_idle(cpu_rq(cpu))) {
> > +                                       util_min = p_util_min;
> > +                                       util_max = p_util_max;
> > +                               } else {
> > +                                       /*
> > +                                        * Open code uclamp_rq_util_with() except for
> > +                                        * the clamp() part. Ie: apply max aggregation
> > +                                        * only. util_fits_cpu() logic requires to
> > +                                        * operate on non clamped util but must use the
> > +                                        * max-aggregated uclamp_{min, max}.
> > +                                        */
> > +                                       rq_util_min = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MIN);
> > +                                       rq_util_max = uclamp_rq_get(cpu_rq(cpu), UCLAMP_MAX);
> > +
> > +                                       util_min = max(rq_util_min, p_util_min);
> > +                                       util_max = max(rq_util_max, p_util_max);
> > +                               }
> > +                       }
> > +                       if (!util_fits_cpu(util, util_min, util_max, cpu))
> >                                 continue;
> >
> >                         if (cpu == prev_cpu) {
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 9599d2eea3e7..69c4d35988b9 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -2907,6 +2907,23 @@ static inline unsigned long cpu_util_rt(struct rq *rq)
> >  #ifdef CONFIG_UCLAMP_TASK
> >  unsigned long uclamp_eff_value(struct task_struct *p, enum uclamp_id clamp_id);
> >
> > +static inline unsigned long uclamp_rq_get(struct rq *rq,
> > +                                         enum uclamp_id clamp_id)
> > +{
> > +       return READ_ONCE(rq->uclamp[clamp_id].value);
> > +}
> > +
> > +static inline void uclamp_rq_set(struct rq *rq, enum uclamp_id clamp_id,
> > +                                unsigned int value)
> > +{
> > +       WRITE_ONCE(rq->uclamp[clamp_id].value, value);
> > +}
> > +
> > +static inline bool uclamp_rq_is_idle(struct rq *rq)
> > +{
> > +       return rq->uclamp_flags & UCLAMP_FLAG_IDLE;
> > +}
> 
> Can you replace the idle judgment in the uclamp_rq_util_with()
> function by the way?

Yep I missed it. Fixed.


Thanks!

--
Qais Yousef
