Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DC5CB57CD8B
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 16:25:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232123AbiGUOZ0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 10:25:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232106AbiGUOY6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 10:24:58 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8710882FB4
        for <linux-kernel@vger.kernel.org>; Thu, 21 Jul 2022 07:24:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C9C671042;
        Thu, 21 Jul 2022 07:24:50 -0700 (PDT)
Received: from wubuntu (unknown [10.57.86.173])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0CFFF3F73D;
        Thu, 21 Jul 2022 07:24:48 -0700 (PDT)
Date:   Thu, 21 Jul 2022 15:24:47 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH 7/7] sched/uclamp: Cater for uclamp in
 find_energy_efficient_cpu()'s early exit condition
Message-ID: <20220721142447.emsv6q3y4ch3bphi@wubuntu>
References: <20220629194632.1117723-1-qais.yousef@arm.com>
 <20220629194632.1117723-8-qais.yousef@arm.com>
 <CAB8ipk9=EEfArTTQ_w10+Df0WqMinFvjbmfFEBLg1zUYcHkOPw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk9=EEfArTTQ_w10+Df0WqMinFvjbmfFEBLg1zUYcHkOPw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/20/22 15:39, Xuewen Yan wrote:
> Hi Qais
> 
> On Thu, Jun 30, 2022 at 3:48 AM Qais Yousef <qais.yousef@arm.com> wrote:
> >
> > If the utilization of the woken up task is 0, we skip the energy
> > calculation because it has no impact.
> >
> > But if the task is boosted (uclamp_min != 0) will have an impact on task
> > placement and frequency selection. Only skip if the util is truly
> > 0 after applying uclamp values.
> >
> > Change uclamp_task_cpu() signature to avoid unnecessary additional calls
> > to uclamp_eff_get(). feec() is the only user now.
> >
> > Fixes: 732cd75b8c920 ("sched/fair: Select an energy-efficient CPU on task wake-up")
> > Signed-off-by: Qais Yousef <qais.yousef@arm.com>
> > ---
> >  kernel/sched/fair.c | 14 ++++++++------
> >  1 file changed, 8 insertions(+), 6 deletions(-)
> >
> > diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> > index 499ef7a7288c..a112ca45864c 100644
> > --- a/kernel/sched/fair.c
> > +++ b/kernel/sched/fair.c
> > @@ -4057,14 +4057,16 @@ static inline unsigned long task_util_est(struct task_struct *p)
> >  }
> >
> >  #ifdef CONFIG_UCLAMP_TASK
> > -static inline unsigned long uclamp_task_util(struct task_struct *p)
> > +static inline unsigned long uclamp_task_util(struct task_struct *p,
> > +                                            unsigned long uclamp_min,
> > +                                            unsigned long uclamp_max)
> >  {
> > -       return clamp(task_util_est(p),
> > -                    uclamp_eff_value(p, UCLAMP_MIN),
> > -                    uclamp_eff_value(p, UCLAMP_MAX));
> > +       return clamp(task_util_est(p), uclamp_min, uclamp_max);
> >  }
> >  #else
> > -static inline unsigned long uclamp_task_util(struct task_struct *p)
> > +static inline unsigned long uclamp_task_util(struct task_struct *p,
> > +                                            unsigned long uclamp_min,
> > +                                            unsigned long uclamp_max)
> >  {
> >         return task_util_est(p);
> >  }
> > @@ -6913,7 +6915,7 @@ static int find_energy_efficient_cpu(struct task_struct *p, int prev_cpu)
> >         target = prev_cpu;
> >
> >         sync_entity_load_avg(&p->se);
> > -       if (!task_util_est(p))
> > +       if (!uclamp_task_util(p, p_util_min, p_util_max))
> 
> Is it not enough to just replace the task_util_est with the
> uclamp_task_util? If change the definition of uclamp_task_util,
> that means it have to get task's uclamp first if user want to call the
> function, may increase the code complex farther more?

Calling uclamp_eff_value() all the time is not cheap actually.

We can easily add two versions when we need to:

	__uclamp_task_util(p, uclamp_min, uclamp_max);

	uclamp_task_util(p) {
		uclamp_min = uclamp_eff_value();
		uclamp_max = uclamp_eff_value();
		return __uclamp_eff_value(p, uclamp_min, uclamp_max);
	}

When we need to. Since we have a single user now, there's no need to do this
now and if we ever get more users it'd be easy to refactor then?


Thanks!

--
Qais Yousef

> 
> >                 goto unlock;
> >
> >         for (; pd; pd = pd->next) {
> > --
> > 2.25.1
> >
> 
> BR
> ---
> xuewen.yan
