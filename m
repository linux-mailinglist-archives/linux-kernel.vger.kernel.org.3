Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 53FE35098F3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 09:27:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1385746AbiDUH1c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 03:27:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47326 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385733AbiDUH13 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 03:27:29 -0400
Received: from mail-pg1-x52c.google.com (mail-pg1-x52c.google.com [IPv6:2607:f8b0:4864:20::52c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 98E93183B5
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:24:40 -0700 (PDT)
Received: by mail-pg1-x52c.google.com with SMTP id r83so3951838pgr.2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 00:24:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=kSUnnvJTV6dNmB2mN9DrMiibs+rULUql9Nla3IWhGM4=;
        b=dVwZGpiMDl7qOHSARU9WfPhrvfWXoS7J2FfOViqrrazKPqnHRMXgKYQFrMB3txh+Im
         lj9fbnCn/VIEQvPMmWWQFPxBdhJLdLUUFvt78s+5RMjQDeVS/cVFNexaWtPrPOEiO3ZZ
         ouRZrVdr2/pzmQfbQpsxrOmCI5MmRlCGRoiOawHXDgt23MqMg6qSKjjDilR5EGEkvSow
         F/oBkodTJiTNwwBuB+ZAKjmJfASQ3GnaIdubUk9N6OQ5t9QZEirAwVGlTMNtTF64xmGe
         EXVWmGF32fA0m7HmTVPcQM+4YBApsaLh2QrnCTap8DdkNB6Vwr5GFkc/3yEvnp9kUD+q
         y7uA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kSUnnvJTV6dNmB2mN9DrMiibs+rULUql9Nla3IWhGM4=;
        b=1ETnSMe3WMhEdjylCRAEKGJdmf5p66NymUkQdhFu/ZADF6ZovSHWNHMecbbZX01IeJ
         VPhkvE6YVt0/+QhNOmp2Fi75HAienBQTcSKHKXKjL41GsLmHnRgzLfw2Pbgd8M4fVYHg
         qY3XOM14aSJYsKZbiesOnZGx1RSLzUO/5t7xgVsaW556bpgXGRRLiWLQ/xWCcWvCqDZY
         ROhMWCZZr64s8yidCPzXWcsF/LtoeFHshSSKBrIDzL+YVYzSNmccVd03yzW4qx/JJUsS
         5mGRfoayGVC1EQsaUg6P2HCXVmFmLvvvn20krzakILdT8898BPBfqpXdznUmaZsXBIta
         y9Sw==
X-Gm-Message-State: AOAM533qOakTdCHAPPKW4EU5J1iPZudWHbmp1LHAilpMHVYgcTOwFTuL
        EprRvb6vbK4oqtAuHfctXuvHRQ==
X-Google-Smtp-Source: ABdhPJzPm2MwQXX0FyCGQAAvhJC7iG9geQ4YDFYVQXgl6L14srgxw6b0TNMg4tjfsPfmcyOMRlxN7A==
X-Received: by 2002:a65:6e0e:0:b0:399:26d7:a224 with SMTP id bd14-20020a656e0e000000b0039926d7a224mr22734041pgb.437.1650525880180;
        Thu, 21 Apr 2022 00:24:40 -0700 (PDT)
Received: from [10.85.115.102] ([139.177.225.244])
        by smtp.gmail.com with ESMTPSA id m13-20020a17090b068d00b001cd4989fee0sm1461880pjz.44.2022.04.21.00.24.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 00:24:39 -0700 (PDT)
Message-ID: <84f61791-8cf2-b955-5d71-1cab15129ab2@bytedance.com>
Date:   Thu, 21 Apr 2022 15:24:33 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [External] Re: [PATCH] sched/core: Avoid obvious double
 update_rq_clock warning
To:     Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, rostedt@goodmis.org,
        bsegall@google.com, mgorman@suse.de, bristot@redhat.com,
        linux-kernel@vger.kernel.org
References: <20220418090929.54005-1-jiahao.os@bytedance.com>
 <20220419104828.GQ2731@worktop.programming.kicks-ass.net>
 <c1e7fc17-b091-1da1-7fa8-0490cc7f7e4b@bytedance.com>
 <df0c4d87-68be-7aef-597f-043b3c7fea59@arm.com>
From:   Hao Jia <jiahao.os@bytedance.com>
In-Reply-To: <df0c4d87-68be-7aef-597f-043b3c7fea59@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2022/4/21 Dietmar Eggemann wrote:
> On 20/04/2022 10:29, Hao Jia wrote:
>> On 4/19/22 6:48 PM, Peter Zijlstra wrote:
>>> On Mon, Apr 18, 2022 at 05:09:29PM +0800, Hao Jia wrote:
> 
> [...]
> 
>>> I'm really not sure about this part though. This is a bit of a mess. The
>>> balancer doesn't really need the pinning stuff. I realize you did that
>>> because we got the clock annotation mixed up with that, but urgh.
>>>
>>> Basically we want double_rq_lock() / double_lock_balance() to clear
>>> RQCF_UPDATED, right? Perhaps do that directly?
>>>
>>> (maybe with an inline helper and a wee comment?)
>>>
>>> The only immediate problem with this would appear to be that
>>> _double_rq_lock() behaves differently when it returns 0. Not sure that
>>> matters.
>>>
>>> Hmm?
>>
>> Thanks for your review comments.
>> As you have prompted, the WARN_DOUBLE_CLOCK warning is still triggered
>> when _double_rq_lock() returns 0.
>> Please review the solution below, and based on your review, I will
>> submit the v2 patch as soon as possible.
>> Thanks.
> 
> 
> [...]
> 
> Maybe something like this:
> 
> -->8--
> 
> From: Dietmar Eggemann <dietmar.eggemann@arm.com>
> Date: Wed, 20 Apr 2022 11:12:10 +0200
> Subject: [PATCH] sched/core: Clear RQCF_UPDATED in _double_lock_balance() &
>   double_rq_lock()
> 
> Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> ---
>   kernel/sched/core.c  |  6 +++---
>   kernel/sched/sched.h | 20 ++++++++++++++++----
>   2 files changed, 19 insertions(+), 7 deletions(-)
> 
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 068c088e9584..f4cfe7eea861 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -610,10 +610,10 @@ void double_rq_lock(struct rq *rq1, struct rq *rq2)
>   		swap(rq1, rq2);
>   
>   	raw_spin_rq_lock(rq1);
> -	if (__rq_lockp(rq1) == __rq_lockp(rq2))
> -		return;
> +	if (__rq_lockp(rq1) != __rq_lockp(rq2))
> +		raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
>   
> -	raw_spin_rq_lock_nested(rq2, SINGLE_DEPTH_NESTING);
> +	rq_clock_clear_update(rq1, rq2);
>   }
>   #endif
>   
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 58263f90c559..3a77b10d7cc4 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -2515,6 +2515,16 @@ static inline bool rq_order_less(struct rq *rq1, struct rq *rq2)
>   
>   extern void double_rq_lock(struct rq *rq1, struct rq *rq2);
>   
> +#ifdef CONFIG_SCHED_DEBUG
> +static inline void rq_clock_clear_update(struct rq *rq1, struct rq *rq2)
> +{
> +	rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +	rq2->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);
> +}
> +#else
> +static inline void rq_clock_clear_update(struct rq *rq1, struct rq *rq2) {}
> +#endif
> +
>   #ifdef CONFIG_PREEMPTION
>   
>   /*
> @@ -2549,14 +2559,15 @@ static inline int _double_lock_balance(struct rq *this_rq, struct rq *busiest)
>   	__acquires(busiest->lock)
>   	__acquires(this_rq->lock)
>   {
> -	if (__rq_lockp(this_rq) == __rq_lockp(busiest))
> -		return 0;
> -
> -	if (likely(raw_spin_rq_trylock(busiest)))
> +	if (__rq_lockp(this_rq) == __rq_lockp(busiest) ||
> +	    likely(raw_spin_rq_trylock(busiest))) {
> +		rq_clock_clear_update(this_rq, busiest);
>   		return 0;
> +	}
>   
>   	if (rq_order_less(this_rq, busiest)) {
>   		raw_spin_rq_lock_nested(busiest, SINGLE_DEPTH_NESTING);
> +		rq_clock_clear_update(this_rq, busiest);
>   		return 0;
>   	}
>   
> @@ -2650,6 +2661,7 @@ static inline void double_rq_lock(struct rq *rq1, struct rq *rq2)
>   	BUG_ON(rq1 != rq2);
>   	raw_spin_rq_lock(rq1);
>   	__acquire(rq2->lock);	/* Fake it out ;) */
> +	rq_clock_clear_update(rq1, rq2);

Thanks for your review.
This is very helpful to me.
If CONFIG_SMP is not enabled, should we just clear the RQCF_UPDATED of 
one of rq1 and q2?

like this:
rq1->clock_update_flags &= (RQCF_REQ_SKIP|RQCF_ACT_SKIP);

Thanks.

>   }
>   
>   /*
