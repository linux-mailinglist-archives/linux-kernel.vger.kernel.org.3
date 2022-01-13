Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8522048DBE5
	for <lists+linux-kernel@lfdr.de>; Thu, 13 Jan 2022 17:35:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236785AbiAMQfl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 13 Jan 2022 11:35:41 -0500
Received: from foss.arm.com ([217.140.110.172]:48398 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S236772AbiAMQfk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 13 Jan 2022 11:35:40 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 641E36D;
        Thu, 13 Jan 2022 08:35:39 -0800 (PST)
Received: from FVFF7649Q05P (usa-sjc-imap-foss1.foss.arm.com [10.121.207.14])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 836CF3F774;
        Thu, 13 Jan 2022 08:35:37 -0800 (PST)
Date:   Thu, 13 Jan 2022 16:35:29 +0000
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Chitti Babu Theegala <quic_ctheegal@quicinc.com>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, joel@joelfernandes.org,
        linux-arm-msm@vger.kernel.org, quic_lingutla@quicinc.com,
        linux-kernel@vger.kernel.org, quic_rjendra@quicinc.com
Subject: Re: [PATCH] sched/fair: Prefer small idle cores for forkees
Message-ID: <YeBRD9zKSLPBFX+j@FVFF7649Q05P>
References: <20220112143902.13239-1-quic_ctheegal@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220112143902.13239-1-quic_ctheegal@quicinc.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 12, 2022 at 08:09:02PM +0530, Chitti Babu Theegala wrote:
> Newly forked threads don't have any useful utilization data yet and
> it's not possible to forecast their impact on energy consumption.
>update_pick_idlest These forkees (though very small, most times) end up waking big
> cores from deep sleep for that very small durations.
> 
> Bias all forkees to small cores to prevent waking big cores from deep
> sleep to save power.

This bias might be interesting for some workloads, but what about the
others? (see find_energy_efficient_cpu() comment, which discusses forkees).

> 
> Signed-off-by: Chitti Babu Theegala <quic_ctheegal@quicinc.com>
> ---
>  kernel/sched/fair.c | 16 +++++++++++-----
>  1 file changed, 11 insertions(+), 5 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 6e476f6..d407bbc 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -5976,7 +5976,7 @@ static int wake_affine(struct sched_domain *sd, struct task_struct *p,
>  }
>  
>  static struct sched_group *
> -find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu);
> +find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu, int sd_flag);
>  
>  /*
>   * find_idlest_group_cpu - find the idlest CPU among the CPUs in the group.
> @@ -6063,7 +6063,7 @@ static inline int find_idlest_cpu(struct sched_domain *sd, struct task_struct *p
>  			continue;
>  		}
>  
> -		group = find_idlest_group(sd, p, cpu);
> +		group = find_idlest_group(sd, p, cpu, sd_flag);
>  		if (!group) {
>  			sd = sd->child;
>  			continue;
> @@ -8997,7 +8997,8 @@ static inline void update_sg_wakeup_stats(struct sched_domain *sd,
>  static bool update_pick_idlest(struct sched_group *idlest,
>  			       struct sg_lb_stats *idlest_sgs,
>  			       struct sched_group *group,
> -			       struct sg_lb_stats *sgs)
> +			       struct sg_lb_stats *sgs,
> +			       int sd_flag)
>  {
>  	if (sgs->group_type < idlest_sgs->group_type)
>  		return true;
> @@ -9034,6 +9035,11 @@ static bool update_pick_idlest(struct sched_group *idlest,
>  		if (idlest_sgs->idle_cpus > sgs->idle_cpus)
>  			return false;
>  
> +		/* Select smaller cpu group for newly woken up forkees */
> +		if ((sd_flag & SD_BALANCE_FORK) && (idlest_sgs->idle_cpus &&
> +			!capacity_greater(idlest->sgc->max_capacity, group->sgc->max_capacity)))
> +			return false;
> +

Energy biased placement should probably be applied only when EAS is enabled.

It's especially true here, if all CPUs have the same capacity, capacity_greater
would be always false. So unless I missed something, we wouldn't let the group_util
evaluation happen, would we?

[...]
