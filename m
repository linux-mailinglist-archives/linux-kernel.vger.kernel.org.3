Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C3CD56A877
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Jul 2022 18:43:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236448AbiGGQnF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 7 Jul 2022 12:43:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236270AbiGGQnE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 7 Jul 2022 12:43:04 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D647D5A2C4
        for <linux-kernel@vger.kernel.org>; Thu,  7 Jul 2022 09:43:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C6A451063;
        Thu,  7 Jul 2022 09:43:01 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 98FE63F792;
        Thu,  7 Jul 2022 09:42:59 -0700 (PDT)
Message-ID: <88fab4b6-8e5c-3a4e-e32b-a0867d51398b@arm.com>
Date:   Thu, 7 Jul 2022 18:42:48 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] sched/fair: fix case with reduced capacity CPU
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        vschneid@redhat.com, linux-kernel@vger.kernel.org,
        david.chen@nutanix.com, zhangqiao22@huawei.com
References: <20220702045254.22922-1-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220702045254.22922-1-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 02/07/2022 06:52, Vincent Guittot wrote:
> The capacity of the CPU available for CFS tasks can be reduced because of
> other activities running on the latter. In such case, it's worth trying to
> move CFS tasks on a CPU with more available capacity.
> 
> The rework of the load balance has filterd the case when the CPU is
> classified to be fully busy but its capacity is reduced.
> 
> Check if CPU's capacity is reduced while gathering load balance statistics
> and classify it group_misfit_task instead of group_fully_busy so we can
> try to move the load on another CPU.
> 
> Reported-by: David Chen <david.chen@nutanix.com>
> Reported-by: Zhang Qiao <zhangqiao22@huawei.com>
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
> 
> David, Zhang,
> 
> I haven't put your tested-by because I have reworked and cleaned the patch to
> cover more cases.
> 
> Could you run some tests with this version ?
> 
> Thanks
> 
>  kernel/sched/fair.c | 50 ++++++++++++++++++++++++++++++++++++---------
>  1 file changed, 40 insertions(+), 10 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index a78d2e3b9d49..126b82ef4279 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -8798,6 +8798,19 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
>  	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>  }
>  
> +static inline bool
> +sched_reduced_capacity(struct rq *rq, struct sched_domain *sd)
> +{
> +	/*
> +	 * When there is more than 1 task, the group_overloaded case already
> +	 * takes care of cpu with reduced capacity
> +	 */
> +	if (rq->cfs.h_nr_running != 1)
> +		return false;
> +
> +	return check_cpu_capacity(rq, sd);
> +}
> +
>  /**
>   * update_sg_lb_stats - Update sched_group's statistics for load balancing.
>   * @env: The load balancing environment.
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
> +			   sched_reduced_capacity(rq, env->sd) &&
> +			   (sgs->group_misfit_task_load < load)) {
> +			/* Check for a task running on a CPU with reduced capacity */
> +			sgs->group_misfit_task_load = load;
>  		}
>  	}
>  
> @@ -8908,7 +8928,8 @@ static bool update_sd_pick_busiest(struct lb_env *env,
>  	 * CPUs in the group should either be possible to resolve
>  	 * internally or be covered by avg_load imbalance (eventually).
>  	 */
> -	if (sgs->group_type == group_misfit_task &&
> +	if ((env->sd->flags & SD_ASYM_CPUCAPACITY) &&
> +	    (sgs->group_type == group_misfit_task) &&
>  	    (!capacity_greater(capacity_of(env->dst_cpu), sg->sgc->max_capacity) ||
>  	     sds->local_stat.group_type != group_has_spare))
>  		return false;
> @@ -9517,9 +9538,18 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  	busiest = &sds->busiest_stat;
>  
>  	if (busiest->group_type == group_misfit_task) {
> -		/* Set imbalance to allow misfit tasks to be balanced. */
> -		env->migration_type = migrate_misfit;
> -		env->imbalance = 1;
> +		if (env->sd->flags & SD_ASYM_CPUCAPACITY) {
> +			/* Set imbalance to allow misfit tasks to be balanced. */
> +			env->migration_type = migrate_misfit;
> +			env->imbalance = 1;
> +		} else {
> +			/*
> +			 * Set load imbalance to allow moving task from cpu
> +			 * with reduced capacity
> +			 */
> +			env->migration_type = migrate_load;
> +			env->imbalance = busiest->group_misfit_task_load;

I'm wondering why you've chosen that hybrid approach `group_misfit_task
-> migrate_load` and not `group_misfit_task -> migrate_misfit`.

It looks like this `rq->cfs.h_nr_running = 1` case almost (since we
check `busiest->nr_running > 1`) always ends up in the load_balance()
`if (!ld_moved)` condition and need_active_balance() can return 1 in
case `if ((env->idle != CPU_NOT_IDLE) && ...` condition. This leads to
active load_balance and this

IMHO, the same you can achieve when you would stay with
`group_misfit_task -> migrate_misfit`.

I think cpu_load(rq) can be used instead of `rq->misfit_task_load` in
the migrate_misfit case of find_busiest_queue() too.

[...]
