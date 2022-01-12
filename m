Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5756C48C72F
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 16:27:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354580AbiALP0d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 10:26:33 -0500
Received: from foss.arm.com ([217.140.110.172]:60654 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1354569AbiALP01 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 10:26:27 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 9CC04ED1;
        Wed, 12 Jan 2022 07:26:26 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B54133F774;
        Wed, 12 Jan 2022 07:26:24 -0800 (PST)
Subject: Re: [PATCH 3 1/4] sched/pelt: Relax the sync of util_sum with
 util_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org
References: <20220111134659.24961-1-vincent.guittot@linaro.org>
 <20220111134659.24961-2-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <1e64dac6-7724-f3f8-978e-fc70dbcc0ae3@arm.com>
Date:   Wed, 12 Jan 2022 16:26:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20220111134659.24961-2-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 11/01/2022 14:46, Vincent Guittot wrote:
> Rick reported performance regressions in bugzilla because of cpu frequency
> being lower than before:
>     https://bugzilla.kernel.org/show_bug.cgi?id=215045
> 
> He bisected the problem to:
> commit 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
> 
> This commit forces util_sum to be synced with the new util_avg after
> removing the contribution of a task and before the next periodic sync. By
> doing so util_sum is rounded to its lower bound and might lost up to
> LOAD_AVG_MAX-1 of accumulated contribution which has not yet been
> reflected in util_avg.
> 
> Instead of always setting util_sum to the low bound of util_avg, which can
> significantly lower the utilization of root cfs_rq after propagating the
> change down into the hierarchy, we revert the change of util_sum and
> propagate the difference.

IMHO, this paragraph does not match the changes in this patch.

> In addition, we also check that cfs's util_sum always stays above the
> lower bound for a given util_avg as it has been observed that
> sched_entity's util_sum is sometimes above cfs one.

And I guess this one also refers to the code change in 2/4, i.e. in
update_tg_cfs_util().
> Reported-by: Rick Yiu <rickyiu@google.com>
> Fixes: 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay consistent")
> Signed-off-by: Vincent Guittot <vincent.guittot@linaro.org>
> ---
>  kernel/sched/fair.c | 16 ++++++++++++++--
>  1 file changed, 14 insertions(+), 2 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 095b0aa378df..ed35255fdb85 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -3381,6 +3381,7 @@ void set_task_rq_fair(struct sched_entity *se,
>  	se->avg.last_update_time = n_last_update_time;
>  }
>  
> +#define MIN_DIVIDER (LOAD_AVG_MAX - 1024)
>  
>  /*
>   * When on migration a sched_entity joins/leaves the PELT hierarchy, we need to
> @@ -3449,7 +3450,6 @@ void set_task_rq_fair(struct sched_entity *se,
>   * XXX: only do this for the part of runnable > running ?
>   *
>   */
> -
>  static inline void
>  update_tg_cfs_util(struct cfs_rq *cfs_rq, struct sched_entity *se, struct cfs_rq *gcfs_rq)
>  {
> @@ -3681,7 +3681,19 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  
>  		r = removed_util;
>  		sub_positive(&sa->util_avg, r);
> -		sa->util_sum = sa->util_avg * divider;
> +		sub_positive(&sa->util_sum, r * divider);
> +		/*
> +		 * Because of rounding, se->util_sum might ends up being +1 more than

There are no se's involved in update_cfs_rq_load_avg(). Could be hard to
grasp for people only looking at this function.

> +		 * cfs->util_sum. Although this is not a problem by itself, detaching
> +		 * a lot of tasks with the rounding problem between 2 updates of
> +		 * util_avg (~1ms) can make cfs->util_sum becoming null whereas
> +		 * cfs_util_avg is not.
> +		 * Check that util_sum is still above its lower bound for the new
> +		 * util_avg. Given that period_contrib might have moved since the last
> +		 * sync, we are only sure that util_sum must be above or equal to
> +		 *    util_avg * minimum possible divider
                   ^^^
some superfluous whitepaces.

> +		 */
> +		sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
>  
>  		r = removed_runnable;
>  		sub_positive(&sa->runnable_avg, r);
> 

