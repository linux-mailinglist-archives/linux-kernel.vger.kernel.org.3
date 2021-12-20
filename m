Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1D69A47A895
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 12:26:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231779AbhLTL0g (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 06:26:36 -0500
Received: from foss.arm.com ([217.140.110.172]:52676 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231774AbhLTL0f (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 06:26:35 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6CCDB1042;
        Mon, 20 Dec 2021 03:26:34 -0800 (PST)
Received: from [192.168.178.2] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E91CA3F718;
        Mon, 20 Dec 2021 03:26:32 -0800 (PST)
Subject: Re: [PATCH 2/4] sched/fair: Decay task PELT values during migration
To:     Vincent Donnefort <vincent.donnefort@arm.com>,
        peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, valentin.schneider@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com,
        qperret@google.com, lukasz.luba@arm.com
References: <20211209161159.1596018-1-vincent.donnefort@arm.com>
 <20211209161159.1596018-3-vincent.donnefort@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <daa01574-5d7b-c125-48a9-d1ec7bd1fb64@arm.com>
Date:   Mon, 20 Dec 2021 12:26:23 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211209161159.1596018-3-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 09.12.21 17:11, Vincent Donnefort wrote:

[...]

> @@ -6899,6 +6899,14 @@ select_task_rq_fair(struct task_struct *p, int prev_cpu, int wake_flags)
>  
>  static void detach_entity_cfs_rq(struct sched_entity *se);
>  
> +static u64 rq_clock_pelt_estimator(struct rq *rq)
> +{
> +	u64 pelt_lag = sched_clock_cpu(cpu_of(rq)) -
> +		       u64_u32_load(rq->clock_pelt_lag);
> +
> +	return cfs_rq_last_update_time(&rq->cfs) + pelt_lag;

Why do you use `avg.last_update_time` (lut) of the root cfs_rq here?

p's lut was just synced to cfs_rq_of(se)'s lut in

migrate_task_rq_fair() (1) -> remove_entity_load_avg() ->
sync_entity_load_avg(se) (2)

[...]

> @@ -6924,26 +6934,29 @@ static void migrate_task_rq_fair(struct task_struct *p, int new_cpu)
>  		 * In case of TASK_ON_RQ_MIGRATING we in fact hold the 'old'
>  		 * rq->lock and can modify state directly.
>  		 */
> -		lockdep_assert_rq_held(task_rq(p));
> -		detach_entity_cfs_rq(&p->se);
> +		lockdep_assert_rq_held(rq);
> +		detach_entity_cfs_rq(se);
>  
>  	} else {
> +		remove_entity_load_avg(se);
> +
>  		/*
> -		 * We are supposed to update the task to "current" time, then
> -		 * its up to date and ready to go to new CPU/cfs_rq. But we
> -		 * have difficulty in getting what current time is, so simply
> -		 * throw away the out-of-date time. This will result in the
> -		 * wakee task is less decayed, but giving the wakee more load
> -		 * sounds not bad.
> +		 * Here, the task's PELT values have been updated according to
> +		 * the current rq's clock. But if that clock hasn't been
> +		 * updated in a while, a substantial idle time will be missed,
> +		 * leading to an inflation after wake-up on the new rq.
> +		 *
> +		 * Estimate the PELT clock lag, and update sched_avg to ensure
> +		 * PELT continuity after migration.
>  		 */
> -		remove_entity_load_avg(&p->se);
> +		__update_load_avg_blocked_se(rq_clock_pelt_estimator(rq), se);

We do __update_load_avg_blocked_se() now twice for p, 1. in (2) and then
in (1) again.

[...]

