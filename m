Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660FE52B43F
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 10:06:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232672AbiERIF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 04:05:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52420 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232631AbiERIFU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 04:05:20 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFC82DE7
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 01:05:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R921e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VDcGX1e_1652861115;
Received: from 30.47.240.162(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VDcGX1e_1652861115)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 18 May 2022 16:05:16 +0800
Message-ID: <1daee377-cdd5-40c9-866d-c0f626a4c465@linux.alibaba.com>
Date:   Wed, 18 May 2022 16:05:14 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [RFC PATCH] sched: Queue task on wakelist in the same llc if the
 wakee cpu is idle
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220513062427.2375743-1-dtcccc@linux.alibaba.com>
 <20220517135807.GS20579@suse.de>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <20220517135807.GS20579@suse.de>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.0 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/5/17 21:58, Mel Gorman wrote:
> On Fri, May 13, 2022 at 02:24:27PM +0800, Tianchen Ding wrote:
>> We notice the commit 518cd6234178 ("sched: Only queue remote wakeups
>> when crossing cache boundaries") disabled queuing tasks on wakelist when
>> the cpus share llc. This is because, at that time, the scheduler must
>> send IPIs to do ttwu_queue_wakelist. Nowadays, ttwu_queue_wakelist also
>> supports TIF_POLLING, so this is not a problem now when the wakee cpu is
>> in idle polling.
>>
>> Benefits:
>>    Queuing the task on idle cpu can help improving performance on waker cpu
>>    and utilization on wakee cpu, and further improve locality because
>>    the wakee cpu can handle its own rq. This patch helps improving rt on
>>    our real java workloads where wakeup happens frequently.
>>
>> Does this patch bring IPI flooding?
>>    For archs with TIF_POLLING_NRFLAG (e.g., x86), there will be no
>>    difference if the wakee cpu is idle polling. If the wakee cpu is idle
>>    but not polling, the later check_preempt_curr() will send IPI too.
>>
> 
> That's a big if. Polling does not last very long -- somewhere between 10
> and 62 microseconds for HZ=1000 or 250 microseconds for HZ=250. It may
> not bring IPI flooding depending on the workload but it will increase
> IPI counts.

This patch only takes effect when the wakee cpu is:
1) idle polling
2) idle not polling

For 1), there will be no IPI with or without this patch.

For 2), there will always be an IPI with or without this patch.
Without this patch: waker cpu will enqueue task and check preempt. Since 
"idle" will be sure to be preempted, waker cpu must send an resched IPI.
With this patch: waker cpu will put the task to the wakelist of wakee 
cpu, and send an IPI.

So there should be no difference about IPI counts.

> 
>>    For archs without TIF_POLLING_NRFLAG (e.g., arm64), the IPI is
>>    unavoidable, since the later check_preempt_curr() will send IPI when
>>    wakee cpu is idle.
>>
>> Benchmark:
>> running schbench -m 2 -t 8 on 8269CY:
>>
>> without patch:
>> Latency percentiles (usec)
>>          50.0000th: 10
>>          75.0000th: 14
>>          90.0000th: 16
>>          95.0000th: 16
>>          *99.0000th: 17
>>          99.5000th: 20
>>          99.9000th: 23
>>          min=0, max=28
>>
>> with patch:
>> Latency percentiles (usec)
>>          50.0000th: 6
>>          75.0000th: 8
>>          90.0000th: 9
>>          95.0000th: 9
>>          *99.0000th: 10
>>          99.5000th: 10
>>          99.9000th: 14
>>          min=0, max=16
>>
>> We've also tested unixbench and see about 10% improvement on Pipe-based
>> Context Switching, and no performance regression on other test cases.
> 
> It'll show a benefit for any heavily communicating tasks that rapidly
> enters/exits idle because the wakee CPU may be still polling due to the
> rapid enter/exit pattern.
> 
>> Signed-off-by: Tianchen Ding <dtcccc@linux.alibaba.com>
>> ---
>>   kernel/sched/core.c | 12 +++++++++---
>>   1 file changed, 9 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 51efaabac3e4..cae5011a8b1f 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -3820,6 +3820,9 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>>   	if (!cpu_active(cpu))
>>   		return false;
>>   
>> +	if (cpu == smp_processor_id())
>> +		return false;
>> +
>>   	/*
>>   	 * If the CPU does not share cache, then queue the task on the
>>   	 * remote rqs wakelist to avoid accessing remote data.
> 
> Is this suggesting that the running CPU should try sending an IPI to
> itself?
> 

No. When the running CPU is the same as wakee cpu, ttwu_queue_cond() 
will return false. So ttwu_queue_wakelist() will be skipped. This logic 
is not changed with or without this patch.

We move this if() forward to ttwu_queue_cond(), it is originally at 
ttwu_queue_wakelist().

The reason we need to check it is at b6e13e85829f0 ("sched/core: Fix 
ttwu() race").
The reason we move it forward is that, without this patch, 
!cpus_share_cache() can cover the condition. But with this patch, we 
need an explicit check.

>> @@ -3827,6 +3830,12 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>>   	if (!cpus_share_cache(smp_processor_id(), cpu))
>>   		return true;
>>   
>> +	/*
>> +	 * If the CPU is idle, let itself do activation to improve utilization.
>> +	 */
>> +	if (available_idle_cpu(cpu))
>> +		return true;
>> +
>>   	/*
>>   	 * If the task is descheduling and the only running task on the
>>   	 * CPU then use the wakelist to offload the task activation to
> 
> It is highly likely that the target CPU is idle given that we almost
> certainly called select_idle_sibling() before reaching here.
> 
> I suspect what you are trying to do is use the wakelist regardless of
> locality if the CPU is polling because polling means an IPI is avoided
> but it's not what the patch does.
> 

As I explained above, IPI is not my key point. In fact, without my 
patch, if the wakee cpu is polling, there will be no IPI, too. See 
resched_curr() -> trace_sched_wake_idle_without_ipi().

My point is to improve rt and idle cpu utilization.

Consider the normal condition (CPU0 and CPU1 share same llc) without 
this patch (origin path):

               CPU0                            CPU1

             select_task_rq()                 idle
             rq_lock(CPU1->rq)
             enqueue_task(CPU1->rq)
             notify CPU1 (by sending IPI or CPU1 polling)

                                              resched()

With this patch:

               CPU0                            CPU1

             select_task_rq()                 idle
             add to wakelist of CPU1
             notify CPU1 (by sending IPI or CPU1 polling)

                                              rq_lock(CPU1->rq)
                                              enqueue_task(CPU1->rq)
                                              resched()

We see CPU0 can finish its work earlier. It only needs to put task to 
wakelist and return.
While CPU1 is idle, so let itself handle its own runqueue data.

