Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 001E7506C5F
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:25:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352279AbiDSM0q (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:26:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45028 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352324AbiDSM0f (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:26:35 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 743E436B6F
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 05:23:45 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 222CB1063;
        Tue, 19 Apr 2022 05:23:45 -0700 (PDT)
Received: from [10.0.0.18] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C9D1E3F766;
        Tue, 19 Apr 2022 05:23:43 -0700 (PDT)
Message-ID: <0d354ce1-9b43-feae-1065-5d8a78c56ccc@arm.com>
Date:   Tue, 19 Apr 2022 13:23:27 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v4 2/7] sched/fair: Decay task PELT values during wakeup
 migration
Content-Language: en-US
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
References: <20220412134220.1588482-1-vincent.donnefort@arm.com>
 <20220412134220.1588482-3-vincent.donnefort@arm.com>
 <CAKfTPtAZMwgKK8m5vdEjsXRJ73YWrZePoCtCu5KKBELtQMp3DA@mail.gmail.com>
From:   Vincent Donnefort <vincent.donnefort@arm.com>
In-Reply-To: <CAKfTPtAZMwgKK8m5vdEjsXRJ73YWrZePoCtCu5KKBELtQMp3DA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 19/04/2022 11:08, Vincent Guittot wrote:
> On Tue, 12 Apr 2022 at 15:42, Vincent Donnefort
> <vincent.donnefort@arm.com> wrote:
>>
>> Before being migrated to a new CPU, a task sees its PELT values
>> synchronized with rq last_update_time. Once done, that same task will also
>> have its sched_avg last_update_time reset. This means the time between
>> the migration and the last clock update (B) will not be accounted for in
>> util_avg and a discontinuity will appear. This issue is amplified by the
>> PELT clock scaling. If the clock hasn't been updated while the CPU is
>> idle, clock_pelt will not be aligned with clock_task and that time (A)
>> will be also lost.
>>
>>     ---------|----- A -----|-----------|------- B -----|>
>>          clock_pelt   clock_task     clock            now
>>
>> This is especially problematic for asymmetric CPU capacity systems which
>> need stable util_avg signals for task placement and energy estimation.
>>
>> Ideally, this problem would be solved by updating the runqueue clocks
>> before the migration. But that would require taking the runqueue lock
>> which is quite expensive [1]. Instead estimate the missing time and update
>> the task util_avg with that value:
>>
>>    A + B = clock_task - clock_pelt + sched_clock_cpu() - clock
>>
>> Neither clock_task, clock_pelt nor clock can be accessed without the
>> runqueue lock. The new cfs_rq last_update_lag is therefore created and
>> contains those three values when the last_update_time value for that very
>> same cfs_rq is updated.
>>
>>    last_update_lag = clock - clock_task + clock_pelt
>>
>> And we can then write the missing time as follow:
>>
>>    A + B = sched_clock_cpu() - last_update_lag
>>
>> The B. part of the missing time is however an estimation that doesn't take
>> into account IRQ and Paravirt time.
>>
>> Now we have an estimation for A + B, we can create an estimator for the
>> PELT value at the time of the migration. We need for this purpose to
>> inject last_update_time which is a combination of both clock_pelt and
>> lost_idle_time. The latter is a time value which is completely lost from a
>> PELT point of view and must be ignored. And finally, we can write:
>>
>>    now = last_update_time + A + B
>>        = last_update_time + sched_clock_cpu() - last_update_lag
>>
>> This estimation has a cost, mostly due to sched_clock_cpu(). Limit the
>> usage to the case where the source CPU is idle as we know this is when the
>> clock is having the biggest risk of being outdated.
>>
>> [1] https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/
>>
>> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 5dd38c9df0cc..e234d015657f 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -3694,6 +3694,57 @@ static inline void add_tg_cfs_propagate(struct cfs_rq *cfs_rq, long runnable_sum
>>
>>   #endif /* CONFIG_FAIR_GROUP_SCHED */
>>
>> +#ifdef CONFIG_NO_HZ_COMMON
>> +static inline void update_cfs_rq_lag(struct cfs_rq *cfs_rq)
>> +{
>> +       struct rq *rq = rq_of(cfs_rq);
>> +
>> +       u64_u32_store(cfs_rq->last_update_lag,
>> +#ifdef CONFIG_CFS_BANDWIDTH
>> +                     /* Timer stopped by throttling */
>> +                     unlikely(cfs_rq->throttle_count) ? U64_MAX :
>> +#endif
>> +                     rq->clock - rq->clock_task + rq->clock_pelt);
> 
> I'm worried that we will call this for each and every
> update_cfs_rq_load_avg() whereas the content will be used only when
> idle and not throttled. Can't we use these conditions to save values
> only when needed and limit the number of useless updates ?

I don't think we can use idle here as a condition, once it is idle, it 
is too late to get those clock values.
> 
> A quick test with hackbench on a 8 cpus system gives
> around 60k call for a duration 550 msec run a root level
> and 180k from a 3rd level cgroups

If you think this is too much to have this store on this path, we could 
though either:

a. restrict the feature to when we know it is the most important: EAS?

b. store the updated value only when "decayed" is non 0.

[...]
