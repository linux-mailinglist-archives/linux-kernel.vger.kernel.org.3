Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 619A85707D9
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 18:03:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231203AbiGKQDN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 12:03:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229699AbiGKQDJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 12:03:09 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4C5C2422F1
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 09:03:08 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77D311596;
        Mon, 11 Jul 2022 09:03:08 -0700 (PDT)
Received: from wubuntu (unknown [10.57.86.231])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5BD6A3F792;
        Mon, 11 Jul 2022 09:03:06 -0700 (PDT)
Date:   Mon, 11 Jul 2022 17:03:04 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, bristot@redhat.com, vschneid@redhat.com,
        linux-kernel@vger.kernel.org, david.chen@nutanix.com,
        zhangqiao22@huawei.com
Subject: Re: [PATCH v2] sched/fair: fix case with reduced capacity CPU
Message-ID: <20220711160304.njkd3ml7nqpokiim@wubuntu>
References: <20220708154401.21411-1-vincent.guittot@linaro.org>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220708154401.21411-1-vincent.guittot@linaro.org>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Vincent

On 07/08/22 17:44, Vincent Guittot wrote:
> The capacity of the CPU available for CFS tasks can be reduced because of
> other activities running on the latter. In such case, it's worth trying to
> move CFS tasks on a CPU with more available capacity.
> 
> The rework of the load balance has filtered the case when the CPU is
> classified to be fully busy but its capacity is reduced.
> 
> Check if CPU's capacity is reduced while gathering load balance statistic
> and classify it group_misfit_task instead of group_fully_busy so we can
> try to move the load on another CPU.
> 
> Reported-by: David Chen <david.chen@nutanix.com>
> Reported-by: Zhang Qiao <zhangqiao22@huawei.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> Tested-by: David Chen <david.chen@nutanix.com>
> Tested-by: Zhang Qiao <zhangqiao22@huawei.com>
> ---

[...]

> @@ -8820,8 +8833,9 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  
>  	for_each_cpu_and(i, sched_group_span(group), env->cpus) {
>  		struct rq *rq = cpu_rq(i);
> +		unsigned long load = cpu_load(rq);
>  
> -		sgs->group_load += cpu_load(rq);
> +		sgs->group_load += load;
>  		sgs->group_util += cpu_util_cfs(i);
>  		sgs->group_runnable += cpu_runnable(rq);
>  		sgs->sum_h_nr_running += rq->cfs.h_nr_running;
> @@ -8851,11 +8865,17 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>  		if (local_group)
>  			continue;
>  
> -		/* Check for a misfit task on the cpu */
> -		if (env->sd->flags & SD_ASYM_CPUCAPACITY &&
> -		    sgs->group_misfit_task_load < rq->misfit_task_load) {
> -			sgs->group_misfit_task_load = rq->misfit_task_load;
> -			*sg_status |= SG_OVERLOAD;
> +		if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> +			/* Check for a misfit task on the cpu */
> +			if (sgs->group_misfit_task_load < rq->misfit_task_load) {
> +				sgs->group_misfit_task_load = rq->misfit_task_load;
> +				*sg_status |= SG_OVERLOAD;
> +			}
> +		} else if ((env->idle != CPU_NOT_IDLE) &&
> +			   sched_reduced_capacity(rq, env->sd)) {
> +			/* Check for a task running on a CPU with reduced capacity */
> +			if (sgs->group_misfit_task_load < load)
> +				sgs->group_misfit_task_load = load;
>  		}
>  	}

Small questions mostly for my education purposes.

The new condition only applies for SMP systems. The reason asym systems don't
care is because misfit check already considers capacity pressure when checking
that the task fits_capacity()?

It **seems** to me that the migration margin in fits_capacity() acts like the
sd->imbalance_pct when check_cpu_capacity() is called by
sched_reduced_capacity(), did I get it right?

If I got it right, if the migration margin ever tweaked, could we potentially
start seeing this kind of reported issue on asym systems then? I guess not. It
just seems to me for asym systems tweaking the migration margin is similar to
tweaking imbalance_pct for smp ones. But the subtlety is greater as
imbalance_pct is still used in asym systems.


Thanks

--
Qais Yousef
