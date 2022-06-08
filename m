Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 64C23542CA8
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:10:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236207AbiFHKKB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:10:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35874 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236993AbiFHKJ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:09:29 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 56D48131F38
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:54:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4A12D1424;
        Wed,  8 Jun 2022 02:54:01 -0700 (PDT)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id BA25A3F73B;
        Wed,  8 Jun 2022 02:53:59 -0700 (PDT)
Message-ID: <2860f381-24e8-2950-388a-b984c4eb51f2@arm.com>
Date:   Wed, 8 Jun 2022 11:53:42 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Subject: Re: [PATCH v10 2/7] sched/fair: Decay task PELT values during wakeup
 migration
To:     Vincent Donnefort <vdonnefort@google.com>, peterz@infradead.org,
        mingo@redhat.com, vincent.guittot@linaro.org
Cc:     linux-kernel@vger.kernel.org, morten.rasmussen@arm.com,
        chris.redpath@arm.com, qperret@google.com, tao.zhou@linux.dev,
        kernel-team@android.com
References: <20220607123254.565579-1-vdonnefort@google.com>
 <20220607123254.565579-3-vdonnefort@google.com>
Content-Language: en-US
In-Reply-To: <20220607123254.565579-3-vdonnefort@google.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/06/2022 14:32, Vincent Donnefort wrote:
> From: Vincent Donnefort <vincent.donnefort@arm.com>

[...]

> To that end, we need sched_clock_cpu() but it is a costly function. Limit
> the usage to the case where the source CPU is idle as we know this is when
> the clock is having the biggest risk of being outdated. In this such case,

s/In this such case/in such a case

> let's call it cfs_idle_lag the delta time between the rq_clock_pelt value
> at rq idle and cfs_rq idle.

s/it cfs_idle_lag the delta time between the rq_clock_pelt value at rq
idle and cfs_rq idle./the delta time between the rq_clock_pelt value
> at rq idle and cfs_rq idle cfs_idle_lag?

 And rq_idle_lag the delta between "now" and
> the rq_clock_pelt at rq idle.
> 

--->

> The estimated PELT clock is then:
> 
>    last_update_time (the cfs_rq's last_update_time)
>    + cfs_idle_lag (delta between cfs_rq's update and rq's update>    + rq_idle_lag (delta between rq's update and now)
> 
>   last_update_time = cfs_rq_clock_pelt()
>                    = rq_clock_pelt() - cfs->throttled_clock_pelt_time
> 
>   cfs_idle_lag = rq_clock_pelt()@rq_idle -
>                  rq_clock_pelt()@cfs_rq_idle
> 
>   rq_idle_lag = sched_clock_cpu() - rq_clock()@rq_idle
> 
> The rq_clock_pelt() from last_update_time being the same as
> rq_clock_pelt()@cfs_rq_idle, we can write:
> 
>   estimation = rq_clock_pelt()@rq_idle - cfs->throttled_clock_pelt_time +
>                sched_clock_cpu() - rq_clock()@rq_idle
> 
> The clocks being not accessible without the rq lock taken, some timestamps
> are created:
> 
>       rq_clock_pelt()@rq_idle        is rq->clock_pelt_idle
>       rq_clock()@rq_idle             is rq->enter_idle
>       cfs->throttled_clock_pelt_time is cfs_rq->throttled_pelt_idle
> 

<--- ^^^

This whole block seems to be the same information as the comment block
in migrate_se_pelt_lag(). But you haven't updated it in v10. Maybe you
can get rid of this here and point to the comment block in
migrate_se_pelt_lag() from here instead to guarantee consistency?
Otherwise they should be in sync.

[...]

> +	/*
> +	 * Estimated "now" is: last_update_time + cfs_idle_lag + rq_idle_lag, where:
> +	 *
> +	 *   last_update_time (the cfs_rq's last_update_time)
> +	 *	= cfs_rq_clock_pelt()@cfs_rq_idle
> +	 *      = rq_clock_pelt()@cfs_rq_idle
> +	 *        - cfs->throttled_clock_pelt_time@cfs_rq_idle
> +	 *
> +	 *   cfs_idle_lag (delta between cfs_rq's update and rq's update)

Isn't this:            (delta between rq's update and cfs_rq's update) ?

> +	 *      = rq_clock_pelt()@rq_idle - rq_clock_pelt()@cfs_rq_idle
> +	 *
> +	 *   rq_idle_lag (delta between rq's update and now)

Isn't this:              (delta between now and rq's update) ?

> +	 *      = sched_clock_cpu() - rq_clock()@rq_idle
> +	 *
> +	 * We can then write:
> +	 *
> +	 *    now = rq_clock_pelt()@rq_idle - cfs->throttled_clock_pelt_time +
> +	 *          sched_clock_cpu() - rq_clock()@rq_idle
> +	 * Where:
> +	 *      rq_clock_pelt()@rq_idle        is rq->clock_pelt_idle
> +	 *      rq_clock()@rq_idle             is rq->clock_idle
                                         is rq->clock_pelt_idle
                                         is rq->clock_idle

> +	 *      cfs->throttled_clock_pelt_time@cfs_rq_idle is
> +	 *      cfs_rq->throttled_pelt_idle
                                          is cfs_rq->throttled_pelt_idle

Maybe align the `is foo` for readability?

[...]
