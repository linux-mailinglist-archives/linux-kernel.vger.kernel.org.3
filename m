Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EECDE59FE2D
	for <lists+linux-kernel@lfdr.de>; Wed, 24 Aug 2022 17:23:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235726AbiHXPXI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 24 Aug 2022 11:23:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49472 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229640AbiHXPXC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 24 Aug 2022 11:23:02 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D55618E4C0
        for <linux-kernel@vger.kernel.org>; Wed, 24 Aug 2022 08:23:01 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8A87F106F;
        Wed, 24 Aug 2022 08:23:05 -0700 (PDT)
Received: from [10.57.46.156] (unknown [10.57.46.156])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id ADB8B3F67D;
        Wed, 24 Aug 2022 08:22:58 -0700 (PDT)
Message-ID: <bbe9b0c4-4540-b3f5-62f3-5d267690f9a2@arm.com>
Date:   Wed, 24 Aug 2022 17:22:57 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
From:   Pierre Gondois <pierre.gondois@arm.com>
Subject: Re: [PATCH 2/2] sched/fair: Use IRQ scaling for all sched classes
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     linux-kernel@vger.kernel.org, qperret@google.com,
        Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Valentin Schneider <vschneid@redhat.com>
References: <20220819153320.291720-1-pierre.gondois@arm.com>
 <20220819153320.291720-3-pierre.gondois@arm.com>
 <CAKfTPtDjrxoH81-FKFo-PeKwEcu1K1HinDii90fGSjKTZGGGXw@mail.gmail.com>
Content-Language: en-US
In-Reply-To: <CAKfTPtDjrxoH81-FKFo-PeKwEcu1K1HinDii90fGSjKTZGGGXw@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 8/23/22 18:26, Vincent Guittot wrote:
> On Fri, 19 Aug 2022 at 17:33, Pierre Gondois <pierre.gondois@arm.com> wrote:
>>
>> The time spent executing IRQ handlers is not reflected in the
>> utilization of CPU. IRQ scaling reduces rq CFS, RT and DL
>> util by reflecting the CPU capacity reduction due to IRQs.
>>
>> commit 9033ea11889f ("cpufreq/schedutil: Take time spent in interrupts
>> into account")
>> introduced the notion of IRQ scaling for the now called
>> effective_cpu_util() function with the following expression (for the
>> CPU util):
>>    IRQ util_avg + (max_cap - IRQ util_avg / max_cap ) * /Sum rq util_avg
>>
>> commit 523e979d3164 ("sched/core: Use PELT for scale_rt_capacity()")
>> introduced IRQ scaling for scale_rt_capacity(), but without scaling
>> RT and DL rq util.
>>
>> scale_rt_capacity() excludes RT and DL rq signals from IRQ scaling.
>> Only the available capacity is scaled. However RT and DL rq util
>> should also be scaled.
> 
> RT and DL are not excluded, they are removed before scaling the
> available time. We compute the available cpu capacity in the clock
> task domain before scaling it in the full clock domain
> 
> Let imagine that we have the following timeshare:
> 
> |       100%      |
> |-IRQ-|-RT--|-----|
> | 33% | 33% | 33% |
>        |   100%    |
>        | 50% | 50% |
> 
> irq uses a third of the time
> 
> RT uses a third of the time but 50% of the clock task as the time in
> interrupt context is not accounted for. This means that the RT
> utilization is 50%
> 
> In order to know what is available for others we do:
> 
> 100% - 50% RT = 50% available in the clock task context
> 
> Then, we scale the 50% of available time to take the time stolen by IRQ
> 
> (100% - 33% IRQ) * 50% / 100% = 33%
> 
> So the available capacity for others is 33% of the original capacity
> which is correct
> 
> What you're proposing:
> 
> free = (100% - 33% IRQ) * 100% / 100% = 67%
> 
> used = 50% RT + 33% IRQ == 83% whereas it should be 33% RT + 33% IRQ == 66%
> 
> Then free < used which means that there is no capacity available for
> others which is not true

Ok yes indeed, the scaling is correct as it is.

Thanks for the detailed explanation,
Pierre

> 
>>
>> Applying IRQ scaling allows to extract the IRQ util avg. So IRQ util
>> avg should also be subtracted from the available capacity.
>> Thermal pressure is not execution time but reduces the maximum
>> possible capacity of a CPU. So IRQ scaling should not be applied.
> 
> thermal pressure uses clock_task so it has the same constraint as RT,
> DL and CFS signal i.e. irq time is not accounted
> 
>>
>> Thus, in this order:
>>   - subtract thermal pressure
>>   - apply IRQ scaling on the remaining capacity (RT + DL + CFS + free)
>>   - subtract IRQ util
>>
>> Also, sort variables in reverse tree order.
>>
>> Signed-off-by: Pierre Gondois <pierre.gondois@arm.com>
>> ---
>>   kernel/sched/fair.c | 19 ++++++++++++-------
>>   1 file changed, 12 insertions(+), 7 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index bcae7bdd5582..546e490d6753 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -8468,16 +8468,23 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>>
>>   static unsigned long scale_rt_capacity(int cpu)
>>   {
>> -       struct rq *rq = cpu_rq(cpu);
>>          unsigned long max = arch_scale_cpu_capacity(cpu);
>> +       struct rq *rq = cpu_rq(cpu);
>> +       unsigned long irq, thermal;
>>          unsigned long used, free;
>> -       unsigned long irq;
>>
>>          irq = cpu_util_irq(rq);
>>
>>          if (unlikely(irq >= max))
>>                  return 1;
>>
>> +       thermal = thermal_load_avg(rq);
>> +       if (unlikely(thermal >= max))
>> +               return 1;
>> +
>> +       free = max - thermal;
>> +       free = scale_irq_capacity(free, irq, max);
>> +
>>          /*
>>           * avg_rt.util_avg and avg_dl.util_avg track binary signals
>>           * (running and not running) with weights 0 and 1024 respectively.
>> @@ -8486,14 +8493,12 @@ static unsigned long scale_rt_capacity(int cpu)
>>           */
>>          used = READ_ONCE(rq->avg_rt.util_avg);
>>          used += READ_ONCE(rq->avg_dl.util_avg);
>> -       used += thermal_load_avg(rq);
>> +       used += irq;
> 
> rq->avg_rt.util_avg and irq==cpu_util_irq(rq)) are not in the same
> time scale so you can't add them
> 
> 
>>
>> -       if (unlikely(used >= max))
>> +       if (unlikely(used >= free))
>>                  return 1;
>>
>> -       free = max - used;
>> -
>> -       return scale_irq_capacity(free, irq, max);
>> +       return free - used;
>>   }
>>
>>   static void update_cpu_capacity(struct sched_domain *sd, int cpu)
>> --
>> 2.25.1
>>
