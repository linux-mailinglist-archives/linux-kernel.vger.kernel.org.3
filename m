Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E4C29484129
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 12:47:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232604AbiADLrU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 06:47:20 -0500
Received: from foss.arm.com ([217.140.110.172]:58612 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232602AbiADLrS (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 06:47:18 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E831A13A1;
        Tue,  4 Jan 2022 03:47:17 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 0C0863F774;
        Tue,  4 Jan 2022 03:47:15 -0800 (PST)
Subject: Re: [PATCH v2 2/3] sched/pelt: Don't sync hardly runnable_sum with
 runnable_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>, mingo@redhat.com,
        peterz@infradead.org, juri.lelli@redhat.com, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org, rickyiu@google.com, odin@uged.al
Cc:     sachinp@linux.vnet.ibm.com, naresh.kamboju@linaro.org
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
 <20211222093802.22357-3-vincent.guittot@linaro.org>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <32e4f1d7-26b1-802a-665f-f89de61db669@arm.com>
Date:   Tue, 4 Jan 2022 12:47:14 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <20211222093802.22357-3-vincent.guittot@linaro.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 22/12/2021 10:38, Vincent Guittot wrote:

[...]

> @@ -3704,7 +3709,10 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq *cfs_rq)
>  
>  		r = removed_runnable;
>  		sub_positive(&sa->runnable_avg, r);
> -		sa->runnable_sum = sa->runnable_avg * divider;
> +		sub_positive(&sa->runnable_sum, r * divider);
> +		/* See update_tg_cfs_util() */
> +		sa->runnable_sum = max_t(u32, sa->runnable_sum,
> +					      sa->runnable_avg * MIN_DIVIDER);

Maybe add a:

Fixes: 1c35b07e6d39 ("sched/fair: Ensure _sum and _avg values stay
consistent")

[...]

> @@ -3805,7 +3807,10 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>  					  cfs_rq->avg.util_avg * MIN_DIVIDER);
>  
>  	sub_positive(&cfs_rq->avg.runnable_avg, se->avg.runnable_avg);
> -	cfs_rq->avg.runnable_sum = cfs_rq->avg.runnable_avg * divider;
> +	sub_positive(&cfs_rq->avg.runnable_sum, se->avg.runnable_sum);
> +	/* See update_tg_cfs_util() */
> +	cfs_rq->avg.runnable_sum = max_t(u32, cfs_rq->avg.runnable_sum,
> +					      cfs_rq->avg.runnable_avg * MIN_DIVIDER);

Maybe add a:

Fixes: fcf6631f3736 ("sched/pelt: Ensure that *_sum is always synced
with *_avg")

[...]
