Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7465B538C95
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 10:16:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244754AbiEaIQf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 04:16:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37538 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242430AbiEaIQe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 04:16:34 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 33A8D8B0A4
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 01:16:33 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C540A23A;
        Tue, 31 May 2022 01:16:32 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E2C683F73D;
        Tue, 31 May 2022 01:16:30 -0700 (PDT)
Message-ID: <72bd6945-c167-65ba-6f81-fad2768972dc@arm.com>
Date:   Tue, 31 May 2022 10:16:05 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v9 2/7] sched/fair: Decay task PELT values during wakeup
 migration
Content-Language: en-US
To:     Vincent Donnefort <vdonnefort@google.com>, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, tao.zhou@linux.dev,
        kernel-team@android.com
References: <20220523155140.2878563-1-vdonnefort@google.com>
 <20220523155140.2878563-3-vdonnefort@google.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220523155140.2878563-3-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.7 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

- Vincent Donnefort <vincent.donnefort@arm.com>

On 23/05/2022 17:51, Vincent Donnefort wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>

[...]

> [1] https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/

minor:

I get `WARNING: Possible unwrapped commit description (prefer a maximum
75 chars per line)`. If you use

https://lkml.kernel.org/r/20190709115759.10451-1-chris.redpath@arm.com

this warning disappears.

[...]

> +static inline void migrate_se_pelt_lag(struct sched_entity *se)
> +{
> +	u64 throttled = 0, now, lut;
> +	struct cfs_rq *cfs_rq;
> +	struct rq *rq;
> +	bool is_idle;
> +
> +	if (load_avg_is_decayed(&se->avg))
> +		return;
> +
> +	cfs_rq = cfs_rq_of(se);
> +	rq = rq_of(cfs_rq);
> +
> +	rcu_read_lock();
> +	is_idle = is_idle_task(rcu_dereference(rq->curr));
> +	rcu_read_unlock();
> +
> +	/*
> +	 * The lag estimation comes with a cost we don't want to pay all the
> +	 * time. Hence, limiting to the case where the source CPU is idle and
> +	 * we know we are at the greatest risk to have an outdated clock.
> +	 */
> +	if (!is_idle)
> +		return;
> +
> +	/*
> +	 * Estimated "now" is: last_update_time + cfs_idle_lag + rq_idle_lag, where:
> +	 *
> +	 *   last_update_time (the cfs_rq's last_update_time)
> +	 *	= cfs_rq_clock_pelt()
> +	 *      = rq_clock_pelt() - cfs->throttled_clock_pelt_time

So this line is always:

		= rq_clock_pelt()@cfs_rq_idle -
		  cfs->throttled_clock_pelt_time@cfs_rq_idle

since we only execute this code when idle. Which then IMHO explains (1)
 better.

> +	 *
> +	 *   cfs_idle_lag (delta between cfs_rq's update and rq's update)
> +	 *      = rq_clock_pelt()@rq_idle - rq_clock_pelt()@cfs_rq_idle
> +	 *
> +	 *   rq_idle_lag (delta between rq's update and now)
> +	 *      = sched_clock_cpu() - rq_clock()@rq_idle
> +	 *
> +	 * The rq_clock_pelt() from last_update_time being the same as
> +	 * rq_clock_pelt()@cfs_rq_idle, we can write:

--> (1)    ^^^

> +	 *
> +	 *    now = rq_clock_pelt()@rq_idle - cfs->throttled_clock_pelt_time +
> +	 *          sched_clock_cpu() - rq_clock()@rq_idle
> +	 * Where:
> +	 *      rq_clock_pelt()@rq_idle        is rq->clock_pelt_idle
> +	 *      rq_clock()@rq_idle             is rq->enter_idle
> +	 *      cfs->throttled_clock_pelt_time is cfs_rq->throttled_pelt_idle

To understand this better:

		cfs->throttled_clock_pelt_time@cfs_rq_idle is
		cfs_rq->throttled_pelt_idle

[...]

> +	/*
> +	 * Paired with _update_idle_rq_clock_pelt. It ensures at the worst case

minor:

s/_update_idle_rq_clock_pelt/_update_idle_rq_clock_pelt()

> +	 * is observed the old clock_pelt_idle value and the new enter_idle,
> +	 * which lead to an understimation. The opposite would lead to an

s/understimation/underestimation

[...]

> @@ -8114,6 +8212,10 @@ static bool __update_blocked_fair(struct rq *rq, bool *done)
>  		if (update_cfs_rq_load_avg(cfs_rq_clock_pelt(cfs_rq), cfs_rq)) {
>  			update_tg_load_avg(cfs_rq);
>  
> +			/* sync clock_pelt_idle with last update */

update_idle_cfs_rq_clock_pelt() syncs cfs_rq->throttled_pelt_idle with
cfs_rq->throttled_clock_pelt_time. Not sure what `clock_pelt_idle` and
`last update` here mean?

[...]

> +/* The rq is idle, we can sync to clock_task */
> +static inline void _update_idle_rq_clock_pelt(struct rq *rq)
> +{
> +	rq->clock_pelt  = rq_clock_task(rq);
> +
> +	u64_u32_store(rq->enter_idle, rq_clock(rq));
> +	/* Paired with smp_rmb in migrate_se_pelt_lag */

minor:

s/migrate_se_pelt_lag/migrate_se_pelt_lag()

[...]

> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index bf4a0ec98678..97bc26e5c8af 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -648,6 +648,10 @@ struct cfs_rq {
>  	int			runtime_enabled;
>  	s64			runtime_remaining;
>  
> +	u64			throttled_pelt_idle;
> +#ifndef CONFIG_64BIT
> +	u64                     throttled_pelt_idle_copy;
> +#endif
>  	u64			throttled_clock;
>  	u64			throttled_clock_pelt;
>  	u64			throttled_clock_pelt_time;
> @@ -1020,6 +1024,12 @@ struct rq {
>  	u64			clock_task ____cacheline_aligned;
>  	u64			clock_pelt;
>  	unsigned long		lost_idle_time;
> +	u64			clock_pelt_idle;
> +	u64			enter_idle;
> +#ifndef CONFIG_64BIT
> +	u64			clock_pelt_idle_copy;
> +	u64			enter_idle_copy;
> +#endif
>  
>  	atomic_t		nr_iowait;

`throttled_pelt_idle`, `clock_pelt_idle` and `enter_idle` are clock
snapshots when cfs_rq resp. rq go idle. But the naming does not really
show this relation. And this makes reading those equations rather difficult.

What about something like `throttled_clock_pelt_time_enter_idle`,
`clock_pelt_enter_idle`, `clock_enter_idle`? Especially the first one is
too long but something which shows that those are clock snapshots when
enter idle would IMHO augment readability in migrate_se_pelt_lag().

Besides these small issues:

Reviewed-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
