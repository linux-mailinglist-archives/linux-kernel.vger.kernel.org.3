Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1B20D573418
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Jul 2022 12:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235171AbiGMK0I (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Jul 2022 06:26:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49836 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231962AbiGMK0G (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Jul 2022 06:26:06 -0400
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7EB95E6802
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:26:04 -0700 (PDT)
Received: by mail-pf1-x42e.google.com with SMTP id j3so9852616pfb.6
        for <linux-kernel@vger.kernel.org>; Wed, 13 Jul 2022 03:26:04 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=3qtR47dgTJBHv05pVKba0ayoiIbH0/O1fMnLEpybE7E=;
        b=nqpFohwrKAIVQA4J2YHRbK28h+zyQZSQzZIovSNg1VHgNPK6jZZZFsYNv541mjKgjQ
         u9oPc0c+3nG/RWw0KXrxxSOUDIT8VKyaAmDccmgrMhZ83ctU4QW3jmiv6h/ENBTsOstk
         yOG6nsSxUla2strLYtGRlOowOg0ozrY24Hzr98IKniOBQXaip6Y4AasHKQyaJp9weq1I
         pmnzq/0lR3MqVOY1n43M55PpgLMxC1TwRKAtl3/rYUOYI5dXjoYU9UdaZWsCwzG7Gqow
         LIhXQ2Zg7lco8WiLrIDM4pfIhLQLQ8xmMHu/ArT1xbdEDmQqoEYW5v62Dp9PwFidWqFn
         n0iw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=3qtR47dgTJBHv05pVKba0ayoiIbH0/O1fMnLEpybE7E=;
        b=rzWgoW1a6NBWJW4BJU1QsRrpI9lQ/e8V3pJRqx1W1F1k6ky+BKpdEjVA052YnyhLtT
         PHx4ALEqPswEG1HwDmBcTFu34Mq/4U8sJmduIdUdwYyKNazcWcXrgvyUuXlqG+H+MJGa
         w8MaYRZyhFqe5pjotxisJmYm8Y0PohUaUV0w7dgDMkH4E3eIdtDV+1Di/kEOGQIPWe14
         Ka0fquG4LaguVv+wLEAJ6paRZe/SZofbWaTVSEXpfLkG5AGMfwoDz1J5GHglI8E7P+43
         bERlD0nNcNcGRTMJAQXCY1F1Jnz02k+VxwODvFnLiTbtQUbpiliw7nLxgY+g7Av0bCe+
         52Aw==
X-Gm-Message-State: AJIora+vBIZAyhAg+QWG83fHMnkWTzWugNbQaTB8f3/SVqAeSkWRgqTs
        11QR9W5cc5lNPleTJ+u6FnVYdA==
X-Google-Smtp-Source: AGRyM1sV0g8tgg3pYtO9g0ykF02QJSMOpUR3ldOMJnNQik6SyLY4a8UXH607RwFYG2o7D5Wiww1jyA==
X-Received: by 2002:a63:4711:0:b0:415:d09b:1d33 with SMTP id u17-20020a634711000000b00415d09b1d33mr2301301pga.469.1657707964049;
        Wed, 13 Jul 2022 03:26:04 -0700 (PDT)
Received: from [10.4.113.6] ([139.177.225.234])
        by smtp.gmail.com with ESMTPSA id m7-20020a170902db0700b0016c4fe627eesm5310126plx.241.2022.07.13.03.26.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 13 Jul 2022 03:26:03 -0700 (PDT)
Message-ID: <90e76dec-aacf-5619-1116-b4c5640a65a4@bytedance.com>
Date:   Wed, 13 Jul 2022 18:25:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/7] sched/fair: skip busy cores in SIS search
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-7-wuyun.abel@bytedance.com>
 <20220621181442.GA37168@chenyu5-mobl1>
 <543d55e1-fad8-3df3-8bae-d79c0c8d8340@bytedance.com>
 <20220624033032.GA14945@chenyu5-mobl1>
 <3e4d2594-f678-b77a-4883-0b893daf19f6@bytedance.com>
 <2d18453d-9c9b-b57b-1616-d4a9229abd5a@bytedance.com>
 <20220630041645.GA9253@chenyu5-mobl1>
 <a72bf17e-f633-87e1-1166-6a4bff122500@bytedance.com>
 <20220709085519.GA13764@chenyu5-mobl1>
 <f3e2d5ad-52c7-e2c4-84c1-c26ee633bd6d@bytedance.com>
 <20220711120251.GA7733@chenyu5-mobl1>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220711120251.GA7733@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 7/11/22 8:02 PM, Chen Yu Wrote:
>>> ...
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index d3e2c5a7c1b7..452eb63ee6f6 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -5395,6 +5395,7 @@ void scheduler_tick(void)
>>>    		resched_latency = cpu_resched_latency(rq);
>>>    	calc_global_load_tick(rq);
>>>    	sched_core_tick(rq);
>>> +	update_overloaded_rq(rq);
>>
>> I didn't see this update in idle path. Is this on your intend?
>>
> It is intended to exclude the idle path. My thought was that, since
> the avg_util has contained the historic activity, checking the cpu
> status in each idle path seems to have no much difference...

I presume the avg_util is used to decide how many cpus to scan, while
the update determines which cpus to scan.

>>>    	rq_unlock(rq, &rf);
>>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>>> index f80ae86bb404..34b1650f85f6 100644
>>> --- a/kernel/sched/fair.c
>>> +++ b/kernel/sched/fair.c
>>> @@ -6323,6 +6323,50 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>>>    #endif /* CONFIG_SCHED_SMT */
>>> +/* derived from group_is_overloaded() */
>>> +static inline bool rq_overloaded(struct rq *rq, int cpu, unsigned int imbalance_pct)
>>> +{
>>> +	if (rq->nr_running - rq->cfs.idle_h_nr_running <= 1)
>>> +		return false;
>>> +
>>> +	if ((SCHED_CAPACITY_SCALE * 100) <
>>> +			(cpu_util_cfs(cpu) * imbalance_pct))
>>> +		return true;
>>> +
>>> +	if ((SCHED_CAPACITY_SCALE * imbalance_pct) <
>>> +			(cpu_runnable(rq) * 100))
>>> +		return true;
>>
>> So the filter contains cpus that over-utilized or overloaded now.
>> This steps further to make the filter reliable while at the cost
>> of sacrificing scan efficiency.
>>
> Right. Ideally if there is a 'realtime' idle cpumask for SIS, the
> scan would be quite accurate. The issue is how to maintain this
> cpumask in low cost.

Yes indeed.

>> The idea behind my recent patches is to keep the filter radical,
>> but use it conservatively.
>>
> Do you mean, update the per-core idle filter frequently, but only
> propogate the filter to LLC-cpumask when the system is overloaded?

Not exactly. I want to update the filter (BTW there is only the LLC
filter, no core filters :)) once core state changes, while apply it
in SIS domain scan only if the domain is busy enough.

>>> +
>>> +	return false;
>>> +}
>>> +
>>> +void update_overloaded_rq(struct rq *rq)
>>> +{
>>> +	struct sched_domain_shared *sds;
>>> +	struct sched_domain *sd;
>>> +	int cpu;
>>> +
>>> +	if (!sched_feat(SIS_FILTER))
>>> +		return;
>>> +
>>> +	cpu = cpu_of(rq);
>>> +	sd = rcu_dereference(per_cpu(sd_llc, cpu));
>>> +	if (unlikely(!sd))
>>> +		return;
>>> +
>>> +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>>> +	if (unlikely(!sds))
>>> +		return;
>>> +
>>> +	if (rq_overloaded(rq, cpu, sd->imbalance_pct)) {
>>
>> I'm not sure whether it is appropriate to use LLC imbalance pct here,
>> because we are comparing inside the LLC rather than between the LLCs.
>>
> Right, imbalance_pct could not be of LLC's, it could be of the core domain's
> imbalance_pct.
>>> +		/* avoid duplicated write, mitigate cache contention */
>>> +		if (!cpumask_test_cpu(cpu, sdo_mask(sds)))
>>> +			cpumask_set_cpu(cpu, sdo_mask(sds));
>>> +	} else {
>>> +		if (cpumask_test_cpu(cpu, sdo_mask(sds)))
>>> +			cpumask_clear_cpu(cpu, sdo_mask(sds));
>>> +	}
>>> +}
>>>    /*
>>>     * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>>>     * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>>> @@ -6383,6 +6427,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>    		}
>>>    	}
>>> +	if (sched_feat(SIS_FILTER) && !has_idle_core && sd->shared)
>>> +		cpumask_andnot(cpus, cpus, sdo_mask(sd->shared));
>>> +
>>>    	for_each_cpu_wrap(cpu, cpus, target + 1) {
>>>    		if (has_idle_core) {
>>>    			i = select_idle_core(p, cpu, cpus, &idle_cpu);
>>> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
>>> index ee7f23c76bd3..1bebdb87c2f4 100644
>>> --- a/kernel/sched/features.h
>>> +++ b/kernel/sched/features.h
>>> @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>>>     */
>>>    SCHED_FEAT(SIS_PROP, false)
>>>    SCHED_FEAT(SIS_UTIL, true)
>>> +SCHED_FEAT(SIS_FILTER, true)
>>
>> The filter should be enabled when there is a need. If the system
>> is idle enough, I don't think it's a good idea to clear out the
>> overloaded cpus from domain scan. Making the filter a sched-feat
>> won't help the problem.
>>
>> My latest patch will only apply the filter when nr is less than
>> the LLC size.
> Do you mean only update the filter(idle cpu mask), or only uses the
> filter in SIS when the system meets: nr_running < LLC size?
> 

In SIS domain search, apply the filter when nr < LLC_size. But I
haven't tested this with SIS_UTIL, and in the SIS_UTIL case this
condition seems always true.

Thanks,
Abel
