Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 738CB51C84C
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 20:45:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384804AbiEEStB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 14:49:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384751AbiEESsZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 14:48:25 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3BD361619
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 11:41:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id A48D91042;
        Thu,  5 May 2022 11:41:17 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 177C73FA31;
        Thu,  5 May 2022 11:41:15 -0700 (PDT)
Message-ID: <3899a404-8016-0f4f-58b8-9353d08db4c9@arm.com>
Date:   Thu, 5 May 2022 20:41:08 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v8 2/7] sched/fair: Decay task PELT values during wakeup
 migration
Content-Language: en-US
To:     peterz@infradead.org, mingo@redhat.com, vincent.guittot@linaro.org,
        vdonnefort@gmail.com
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, tao.zhou@linux.dev
References: <20220429141148.181816-1-vincent.donnefort@arm.com>
 <20220429141148.181816-3-vincent.donnefort@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
In-Reply-To: <20220429141148.181816-3-vincent.donnefort@arm.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ vdonnefort@gmail.com
- vincent.donnefort@arm.com

On 29/04/2022 16:11, Vincent Donnefort wrote:

[...]

> To that end, we need sched_clock_cpu() but it is a costly function. Limit
> the usage to the case where the source CPU is idle as we know this is when
> the clock is having the biggest risk of being outdated. In this such case,
> let's call it cfs_idle_lag the delta time between the rq_clock_pelt value
> at rq idle and cfs_rq idle. And rq_idle_lag the delta between "now" and
> the rq_clock_pelt at rq idle.
> 
> The estimated PELT clock is then:

Where is this nice diagram (timeline) from v7 ?

[...]

> +	/*
> +	 * estimated "now" is:
> +	 *   last_update_time + (the cfs_rq's last_update_time)
> +	 *   cfs_idle_lag + (delta between cfs_rq's update and rq's update)
> +	 *   rq_idle_lag (delta between rq's update and now)

The parentheses here make this hard to get. Same text as in the patch
header. What would have speed up me understanding this would have been
this line:

         now = last_update_time + cfs_idle_lag + rq_idle_lag

> +	 *
> +	 *   last_update_time = cfs_rq_clock_pelt()
> +	 *                    = rq_clock_pelt() - cfs->throttled_clock_pelt_time
> +	 *
> +	 *   cfs_idle_lag = rq_clock_pelt()@rq_idle -
> +	 *                  rq_clock_pelt()@cfs_rq_idle
> +	 *
> +	 *   rq_idle_lag = sched_clock_cpu() - rq_clock()@rq_idle
> +	 *
> +	 *   The rq_clock_pelt() from last_update_time being the same as
> +	 *   rq_clock_pelt()@cfs_rq_idle, we can write:
> +	 *
> +	 *     now = rq_clock_pelt()@rq_idle - cfs->throttled_clock_pelt_time +
> +	 *           sched_clock_cpu() - rq_clock()@rq_idle
> +	 *
> +	 *   Where:
> +	 *      rq_clock_pelt()@rq_idle        is rq->clock_pelt_idle
> +	 *      rq_clock()@rq_idle             is rq->enter_idle
> +	 *      cfs->throttled_clock_pelt_time is cfs_rq->throttled_pelt_idle
> +	 */

[...]

> +#ifdef CONFIG_CFS_BANDWIDTH
> +static inline void update_idle_cfs_rq_clock_pelt(struct cfs_rq *cfs_rq)
>  {
> -	lockdep_assert_rq_held(rq);
> -	assert_clock_updated(rq);
> -
> -	return rq->clock_pelt - rq->lost_idle_time;
> +	/*
> +	 * Make sure that pending update of rq->clock_pelt_idle and
> +	 * rq->enter_idle are visible during update_blocked_average() before

s/update_blocked_average()/update_blocked_averages()

> +	 * updating cfs_rq->throttled_pelt_idle.
> +	 */
> +	smp_wmb();

I don't understand this one. Where is the counterpart barrier?

> +	if (unlikely(cfs_rq->throttle_count))
> +		u64_u32_store(cfs_rq->throttled_pelt_idle, U64_MAX);
> +	else
> +		u64_u32_store(cfs_rq->throttled_pelt_idle,
> +			      cfs_rq->throttled_clock_pelt_time);

Nit-pick:

Using a local u64 throttled might be easier on the eye:

        if (unlikely(cfs_rq->throttle_count))
-               u64_u32_store(cfs_rq->throttled_pelt_idle, U64_MAX);
+               throttled = U64_MAX;
        else
-               u64_u32_store(cfs_rq->throttled_pelt_idle,
-                             cfs_rq->throttled_clock_pelt_time);
+               throttled = cfs_rq->throttled_clock_pelt_time;
+
+       u64_u32_store(cfs_rq->throttled_pelt_idle, throttled);

[...]
