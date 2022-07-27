Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8251F582A3C
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 18:05:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234618AbiG0QFI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 12:05:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35374 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233421AbiG0QFG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 12:05:06 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 76B554AD78
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 09:05:04 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id CF9EF113E;
        Wed, 27 Jul 2022 09:05:04 -0700 (PDT)
Received: from wubuntu (unknown [10.57.12.122])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F376D3F73B;
        Wed, 27 Jul 2022 09:05:02 -0700 (PDT)
Date:   Wed, 27 Jul 2022 17:05:01 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>
Subject: Re: [PATCH 2/7] sched/uclamp: Make task_fits_capacity() use
 util_fits_cpu()
Message-ID: <20220727160501.m4omtncl5nvqoh3p@wubuntu>
References: <20220629194632.1117723-1-qais.yousef@arm.com>
 <20220629194632.1117723-3-qais.yousef@arm.com>
 <CAKfTPtAxK=NGbpQkiW8-tx3kEwp-M7LAr1Rq_kdWDdsSq7Hd9A@mail.gmail.com>
 <20220712104843.frbtkgkiftaovcon@wubuntu>
 <20220721142949.fqmabrjwylkuoltw@wubuntu>
 <20220722081913.GA6045@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220722081913.GA6045@vingu-book>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent

On 07/22/22 10:19, Vincent Guittot wrote:
> Le jeudi 21 juil. 2022 ï¿½ 15:29:49 (+0100), Qais Yousef a ï¿½crit :
> > On 07/12/22 11:48, Qais Yousef wrote:
> > > On 07/11/22 15:09, Vincent Guittot wrote:
> > > > On Wed, 29 Jun 2022 at 21:48, Qais Yousef <qais.yousef@arm.com> wrote:
> > > 
> 
> [...]
> 
> > > > > @@ -9108,7 +9125,7 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
> > > > >
> > > > >         /* Check if task fits in the group */
> > > > >         if (sd->flags & SD_ASYM_CPUCAPACITY &&
> > > > > -           !task_fits_capacity(p, group->sgc->max_capacity)) {
> > > > > +           !task_fits_cpu(p, group->sgc->max_capacity_cpu)) {
> > > > 
> > > > All the changes and added complexity above for this line. Can't you
> > > > find another way ?
> > > 
> > > You're right, I might have got carried away trying to keep the logic the same.
> > > 
> > > Can we use group->asym_prefer_cpu or pick a cpu from group->sgc->cpumask
> > > instead?
> > > 
> > > I'll dig more into it anyway and try to come up with simpler alternative.
> > 
> > Actually we can't.
> > 
> > I can keep the current {max,min}_capacity field and just add the new
> > {max,min}_capacity_cpu and use them where needed. Should address your concerns
> > this way? That was actually the first version of the code, but then it seemed
> > redundant to keep both {max,min}_capacity and {max,min}_capacity_cpu.
> > 
> > OR
> > 
> > I can add a new function to search for max spare capacity cpu in the group.
> > 
> > Preference?
> > 
> 
> Isn't the below enough and much simpler ?

Thanks for that!

> 
> [PATCH] sched/uclamp: Make task_fits_capacity() use util_fits_cpu()
> 
> So that the new uclamp rules in regard to migration margin and capacity
> pressure are taken into account correctly.
> ---
>  kernel/sched/fair.c  | 25 +++++++++++++++----------
>  kernel/sched/sched.h |  9 +++++++++
>  2 files changed, 24 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5eecae32a0f6..3e0c7cc490be 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -4317,10 +4317,12 @@ static inline int util_fits_cpu(unsigned long util,
>  	return fits;
>  }
> 
> -static inline int task_fits_capacity(struct task_struct *p,
> -				     unsigned long capacity)
> +static inline int task_fits_cpu(struct task_struct *p, int cpu)
>  {
> -	return fits_capacity(uclamp_task_util(p), capacity);
> +	unsigned long uclamp_min = uclamp_eff_value(p, UCLAMP_MIN);
> +	unsigned long uclamp_max = uclamp_eff_value(p, UCLAMP_MAX);
> +	unsigned long util = task_util_est(p);
> +	return util_fits_cpu(util, uclamp_min, uclamp_max, cpu);
>  }
> 
>  static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
> @@ -4333,7 +4335,7 @@ static inline void update_misfit_status(struct task_struct *p, struct rq *rq)
>  		return;
>  	}
> 
> -	if (task_fits_capacity(p, capacity_of(cpu_of(rq)))) {
> +	if (task_fits_cpu(p, cpu_of(rq))) {
>  		rq->misfit_task_load = 0;
>  		return;
>  	}
> @@ -8104,7 +8106,7 @@ static int detach_tasks(struct lb_env *env)
> 
>  		case migrate_misfit:
>  			/* This is not a misfit task */
> -			if (task_fits_capacity(p, capacity_of(env->src_cpu)))
> +			if (task_fits_cpu(p, env->src_cpu))
>  				goto next;
> 
>  			env->imbalance = 0;
> @@ -9085,6 +9087,10 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
> 
>  	memset(sgs, 0, sizeof(*sgs));
> 
> +	/* Assume that task can't fit any CPU of the group */
> +	if (sd->flags & SD_ASYM_CPUCAPACITY)
> +		sgs->group_misfit_task_load = 0;

Should this be

	sgs->group_misfit_task_load = 1

to indicate it doesn't fit?

> +
>  	for_each_cpu(i, sched_group_span(group)) {
>  		struct rq *rq = cpu_rq(i);
>  		unsigned int local;
> @@ -9104,12 +9110,11 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>  		if (!nr_running && idle_cpu_without(i, p))
>  			sgs->idle_cpus++;
> 
> -	}
> +		/* Check if task fits in the CPU */
> +		if (sd->flags & SD_ASYM_CPUCAPACITY &&
> +		    task_fits_cpu(p, i))
> +			sgs->group_misfit_task_load = 0;

So we clear the flag if there's any cpu that fits, I think that should work,
yes and much better too. I got tunneled visioned and didn't take a step back to
look at the big picture. Thanks for the suggestion :-)

I think we can make it more efficient by checking if
sgs->group_misfit_task_load is set

		/* Check if task fits in the CPU */
		if (sd->flags & SD_ASYM_CPUCAPACITY &&
		    sgs->group_misfit_task_load &&
		    task_fits_cpu(p, i))
			sgs->group_misfit_task_load = 0;

which will avoid calling task_fits_cpu() repeatedly if we got a hit already.


Thanks!

--
Qais Yousef

> 
> -	/* Check if task fits in the group */
> -	if (sd->flags & SD_ASYM_CPUCAPACITY &&
> -	    !task_fits_capacity(p, group->sgc->max_capacity)) {
> -		sgs->group_misfit_task_load = 1;
>  	}
> 
>  	sgs->group_capacity = group->sgc->capacity;
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 02c970501295..3292ad2db4ac 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2988,6 +2988,15 @@ static inline bool uclamp_is_used(void)
>  	return static_branch_likely(&sched_uclamp_used);
>  }
>  #else /* CONFIG_UCLAMP_TASK */
> +static inline unsigned long uclamp_eff_value(struct task_struct *p,
> +					     enum uclamp_id clamp_id)
> +{
> +	if (clamp_id == UCLAMP_MIN)
> +		return 0;
> +
> +	return SCHED_CAPACITY_SCALE;
> +}
> +
>  static inline
>  unsigned long uclamp_rq_util_with(struct rq *rq, unsigned long util,
>  				  struct task_struct *p)
> --
> 2.17.1
> 
> > 
> > Thanks!
> > 
> > --
> > Qais Yousef
