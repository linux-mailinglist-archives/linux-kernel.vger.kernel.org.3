Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 069515085DF
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 12:27:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347786AbiDTKae (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 06:30:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352222AbiDTK2m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 06:28:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id A50373D1EF
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 03:25:55 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 6C2E723A;
        Wed, 20 Apr 2022 03:25:55 -0700 (PDT)
Received: from [10.57.41.90] (unknown [10.57.41.90])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 163E83F766;
        Wed, 20 Apr 2022 03:25:53 -0700 (PDT)
Message-ID: <1939e95d-81ea-45d9-b410-8290a100e7c8@arm.com>
Date:   Wed, 20 Apr 2022 11:25:52 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [PATCH v4 2/7] sched/fair: Decay task PELT values during wakeup
 migration
Content-Language: en-US
From:   Vincent Donnefort <vincent.donnefort@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        morten.rasmussen@arm.com, chris.redpath@arm.com, qperret@google.com
References: <20220412134220.1588482-1-vincent.donnefort@arm.com>
 <20220412134220.1588482-3-vincent.donnefort@arm.com>
 <CAKfTPtAZMwgKK8m5vdEjsXRJ73YWrZePoCtCu5KKBELtQMp3DA@mail.gmail.com>
 <0d354ce1-9b43-feae-1065-5d8a78c56ccc@arm.com>
 <20220419162758.GA26133@vingu-book>
 <87fdf203-2a61-4234-4310-88ff67aab531@arm.com>
In-Reply-To: <87fdf203-2a61-4234-4310-88ff67aab531@arm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 20/04/2022 10:34, Vincent Donnefort wrote:
> On 19/04/2022 17:27, Vincent Guittot wrote:
>> Le mardi 19 avril 2022 ï¿½ 13:23:27 (+0100), Vincent Donnefort a 
>> ï¿½crit :
>>>
>>>
>>> On 19/04/2022 11:08, Vincent Guittot wrote:
>>>> On Tue, 12 Apr 2022 at 15:42, Vincent Donnefort
>>>> <vincent.donnefort@arm.com> wrote:
>>>>>
>>>>> Before being migrated to a new CPU, a task sees its PELT values
>>>>> synchronized with rq last_update_time. Once done, that same task 
>>>>> will also
>>>>> have its sched_avg last_update_time reset. This means the time between
>>>>> the migration and the last clock update (B) will not be accounted 
>>>>> for in
>>>>> util_avg and a discontinuity will appear. This issue is amplified 
>>>>> by the
>>>>> PELT clock scaling. If the clock hasn't been updated while the CPU is
>>>>> idle, clock_pelt will not be aligned with clock_task and that time (A)
>>>>> will be also lost.
>>>>>
>>>>>      ---------|----- A -----|-----------|------- B -----|>
>>>>>           clock_pelt   clock_task     clock            now
>>>>>
>>>>> This is especially problematic for asymmetric CPU capacity systems 
>>>>> which
>>>>> need stable util_avg signals for task placement and energy estimation.
>>>>>
>>>>> Ideally, this problem would be solved by updating the runqueue clocks
>>>>> before the migration. But that would require taking the runqueue lock
>>>>> which is quite expensive [1]. Instead estimate the missing time and 
>>>>> update
>>>>> the task util_avg with that value:
>>>>>
>>>>>     A + B = clock_task - clock_pelt + sched_clock_cpu() - clock
>>>>>
>>>>> Neither clock_task, clock_pelt nor clock can be accessed without the
>>>>> runqueue lock. The new cfs_rq last_update_lag is therefore created and
>>>>> contains those three values when the last_update_time value for 
>>>>> that very
>>>>> same cfs_rq is updated.
>>>>>
>>>>>     last_update_lag = clock - clock_task + clock_pelt
>>>>>
>>>>> And we can then write the missing time as follow:
>>>>>
>>>>>     A + B = sched_clock_cpu() - last_update_lag
>>>>>
>>>>> The B. part of the missing time is however an estimation that 
>>>>> doesn't take
>>>>> into account IRQ and Paravirt time.
>>>>>
>>>>> Now we have an estimation for A + B, we can create an estimator for 
>>>>> the
>>>>> PELT value at the time of the migration. We need for this purpose to
>>>>> inject last_update_time which is a combination of both clock_pelt and
>>>>> lost_idle_time. The latter is a time value which is completely lost 
>>>>> from a
>>>>> PELT point of view and must be ignored. And finally, we can write:
>>>>>
>>>>>     now = last_update_time + A + B
>>>>>         = last_update_time + sched_clock_cpu() - last_update_lag
>>>>>
>>>>> This estimation has a cost, mostly due to sched_clock_cpu(). Limit the
>>>>> usage to the case where the source CPU is idle as we know this is 
>>>>> when the
>>>>> clock is having the biggest risk of being outdated.
>>>>>
>>>>> [1] 
>>>>> https://lore.kernel.org/all/20190709115759.10451-1-chris.redpath@arm.com/ 
>>>>>
>>>>>
>>>>> Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
>>
>> [...]
>>
>>>>
>>>> I'm worried that we will call this for each and every
>>>> update_cfs_rq_load_avg() whereas the content will be used only when
>>>> idle and not throttled. Can't we use these conditions to save values
>>>> only when needed and limit the number of useless updates ?
>>>
>>> I don't think we can use idle here as a condition, once it is idle, 
>>> it is
>>> too late to get those clock values.
>>
>> As an example, the patch below should work. It doesn't handle the 
>> throttled case yet and still has to
>> make sure that rq->enter_idle and rq->clock_pelt_idle are coherent in 
>> regards to ILB that
>> update blocked load.
> 
> 
> I had to abandon the per-rq approach from v1 to v2. This is because of 
> the following example:
> 
> 1. task A sleep
> 2. rq's clock updated (e.g another task runs)
> 3. task A migrated
> 
> With a per-rq lag, we would miss the time delta between 1 and 2. We know 
> how old is the last clock update. But what we actually want is how old 
> is the task's last_update_time.


However, to go back to your idea of only updating when going idle: we 
could only do the update when the task is dequeued. We know that only 
after that dequeue we could have a wake-up migration.

Something like:

   static void
   dequeue_entity(struct cfs_rq *cfs_rq, struct sched_entity *se, int 
flags)

...

           update_load_avg(cfs_rq, se, UPDATE_TG);
+         if (entity_is_task(se))
+                  update_cfs_rq_lag(cfs_rq);
           se_update_runnable(se);


That would drastically reduce the number of time update_cfs_rq_lag() 
would be called, skipping the update during enqueue and tick.

Additionally, we could also check for nr_running in cfs_rq, to only 
update when cfs_rq is 'idle'?


Thoughts?


> 
>>
>> ---
>>   kernel/sched/fair.c  | 30 ++++++++++++++++++++++++++++++
>>   kernel/sched/pelt.h  | 21 ++++++++++++++-------
>>   kernel/sched/sched.h |  3 ++-
>>   3 files changed, 46 insertions(+), 8 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index e6ecf530f19f..f00843f9dd01 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -7005,6 +7005,35 @@ select_task_rq_fair(struct task_struct *p, int 
>> prev_cpu, int wake_flags)
>>   static void detach_entity_cfs_rq(struct sched_entity *se);
>> +#ifdef CONFIG_NO_HZ_COMMON
>> +static inline void migrate_se_pelt_lag(struct sched_entity *se)
>> +{
>> +       u64 now;
>> +       struct cfs_rq *cfs_rq;
>> +       struct rq *rq;
>> +       bool is_idle;
>> +
>> +       cfs_rq = cfs_rq_of(se);
>> +       rq = rq_of(cfs_rq);
>> +
>> +       rcu_read_lock();
>> +       is_idle = is_idle_task(rcu_dereference(rq->curr));
>> +       rcu_read_unlock();
>> +
>> +       if (!is_idle)
>> +               return;
>> +
>> +    /* TODO handle throttled cfs */
>> +    /* TODO handle update ilb blocked load update */
>> +    now = READ_ONCE(rq->clock_pelt_idle);
>> +    now += sched_clock_cpu(cpu_of(rq)) - READ_ONCE(rq->enter_idle);
>> +
>> +       __update_load_avg_blocked_se(now, se);
>> +}
>> +#else
>> +static void migrate_se_pelt_lag(struct sched_entity *se) {}
>> +#endif
>> +
>>   /*
>>    * Called immediately before a task is migrated to a new CPU; 
>> task_cpu(p) and
>>    * cfs_rq_of(p) references at time of call are still valid and 
>> identify the
>> @@ -7056,6 +7085,7 @@ static void migrate_task_rq_fair(struct 
>> task_struct *p, int new_cpu)
>>            * sounds not bad.
>>            */
>>           remove_entity_load_avg(&p->se);
>> +        migrate_se_pelt_lag(&p->se);
>>       }
>>       /* Tell new CPU we are migrated */
>> diff --git a/kernel/sched/pelt.h b/kernel/sched/pelt.h
>> index c336f5f481bc..ece4423026e5 100644
>> --- a/kernel/sched/pelt.h
>> +++ b/kernel/sched/pelt.h
>> @@ -61,6 +61,14 @@ static inline void cfs_se_util_change(struct 
>> sched_avg *avg)
>>       WRITE_ONCE(avg->util_est.enqueued, enqueued);
>>   }
>> +static inline u64 rq_clock_pelt(struct rq *rq)
>> +{
>> +    lockdep_assert_rq_held(rq);
>> +    assert_clock_updated(rq);
>> +
>> +    return rq->clock_pelt - rq->lost_idle_time;
>> +}
>> +
>>   /*
>>    * The clock_pelt scales the time to reflect the effective amount of
>>    * computation done during the running delta time but then sync back to
>> @@ -78,6 +86,8 @@ static inline void update_rq_clock_pelt(struct rq 
>> *rq, s64 delta)
>>       if (unlikely(is_idle_task(rq->curr))) {
>>           /* The rq is idle, we can sync to clock_task */
>>           rq->clock_pelt  = rq_clock_task(rq);
>> +        WRITE_ONCE(rq->enter_idle, rq_clock(rq)); /* this could be 
>> factorized with idle_stamp */
>> +        WRITE_ONCE(rq->clock_pelt_idle, rq_clock_pelt(rq)); /* last 
>> pelt clock update when idle */
>>           return;
>>       }
>> @@ -130,14 +140,11 @@ static inline void 
>> update_idle_rq_clock_pelt(struct rq *rq)
>>        */
>>       if (util_sum >= divider)
>>           rq->lost_idle_time += rq_clock_task(rq) - rq->clock_pelt;
>> -}
>> -static inline u64 rq_clock_pelt(struct rq *rq)
>> -{
>> -    lockdep_assert_rq_held(rq);
>> -    assert_clock_updated(rq);
>> -
>> -    return rq->clock_pelt - rq->lost_idle_time;
>> +    /* The rq is idle, we can sync with clock_task */
>> +    rq->clock_pelt  = rq_clock_task(rq);
>> +    WRITE_ONCE(rq->enter_idle, rq_clock(rq)); /* this could be 
>> factorized with idle_stamp */
>> +    WRITE_ONCE(rq->clock_pelt_idle, rq_clock_pelt(rq)); /* last pelt 
>> clock update when idle */
>>   }
>>   #ifdef CONFIG_CFS_BANDWIDTH
>> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
>> index 6ab77b171656..108698446762 100644
>> --- a/kernel/sched/sched.h
>> +++ b/kernel/sched/sched.h
>> @@ -1007,7 +1007,8 @@ struct rq {
>>       u64            clock_task ____cacheline_aligned;
>>       u64            clock_pelt;
>>       unsigned long        lost_idle_time;
>> -
>> +    u64            clock_pelt_idle;
>> +    u64            enter_idle;
>>       atomic_t        nr_iowait;
>>   #ifdef CONFIG_SCHED_DEBUG
