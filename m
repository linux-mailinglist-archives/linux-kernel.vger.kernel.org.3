Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B64DA53A482
	for <lists+linux-kernel@lfdr.de>; Wed,  1 Jun 2022 14:03:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349414AbiFAMC3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Jun 2022 08:02:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51108 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351742AbiFAMCV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Jun 2022 08:02:21 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 272BE4AE1A
        for <linux-kernel@vger.kernel.org>; Wed,  1 Jun 2022 05:02:18 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04395;MF=dtcccc@linux.alibaba.com;NM=1;PH=DS;RN=11;SR=0;TI=SMTPD_---0VF4pZzh_1654084934;
Received: from 30.236.24.63(mailfrom:dtcccc@linux.alibaba.com fp:SMTPD_---0VF4pZzh_1654084934)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 01 Jun 2022 20:02:15 +0800
Message-ID: <76b9b12d-b5a3-8990-f7ab-1a49f55aac19@linux.alibaba.com>
Date:   Wed, 1 Jun 2022 20:02:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.1
Subject: Re: [PATCH v2] sched: Queue task on wakelist in the same llc if the
 wakee cpu is idle
Content-Language: en-US
To:     Valentin Schneider <vschneid@redhat.com>
Cc:     Ingo Molnar <mingo@redhat.com>, Mel Gorman <mgorman@suse.de>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <20220527090544.527411-1-dtcccc@linux.alibaba.com>
 <xhsmhleuj7zve.mognet@vschneid.remote.csb>
 <1d0eb8f4-e474-86a9-751a-7c2e1788df85@linux.alibaba.com>
 <xhsmhilpl9azq.mognet@vschneid.remote.csb> <20220531135532.GA3332@suse.de>
 <xhsmhfskp8zlg.mognet@vschneid.remote.csb>
 <a5d04748-b34b-3b92-fb1d-bf85c2019cc3@linux.alibaba.com>
 <xhsmhczfs8xav.mognet@vschneid.remote.csb>
From:   Tianchen Ding <dtcccc@linux.alibaba.com>
In-Reply-To: <xhsmhczfs8xav.mognet@vschneid.remote.csb>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.2 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,HK_RANDOM_ENVFROM,HK_RANDOM_FROM,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/6/1 18:58, Valentin Schneider wrote:
> On 01/06/22 13:54, Tianchen Ding wrote:
>> On 2022/5/31 23:56, Valentin Schneider wrote:
>>
>>> Thanks!
>>>
>>> So I'm thinking we could first make that into
>>>
>>> 	if ((wake_flags & WF_ON_CPU) && !cpu_rq(cpu)->nr_running)
>>>
>>> Then building on this, we can generalize using the wakelist to any remote
>>> idle CPU (which on paper isn't as much as a clear win as just WF_ON_CPU,
>>> depending on how deeply idle the CPU is...)
>>>
>>> We need the cpu != this_cpu check, as that's currently served by the
>>> WF_ON_CPU check (AFAIU we can only observe p->on_cpu in there for remote
>>> tasks).
>>>
>>> ---
>>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>>> index 66c4e5922fe1..60038743f2f1 100644
>>> --- a/kernel/sched/core.c
>>> +++ b/kernel/sched/core.c
>>> @@ -3830,13 +3830,20 @@ static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>>>    	if (!cpus_share_cache(smp_processor_id(), cpu))
>>>    		return true;
>>>    
>>> +	if (cpu == smp_processor_id())
>>> +		return false;
>>> +
>>>    	/*
>>>    	 * If the task is descheduling and the only running task on the
>>>    	 * CPU then use the wakelist to offload the task activation to
>>>    	 * the soon-to-be-idle CPU as the current CPU is likely busy.
>>>    	 * nr_running is checked to avoid unnecessary task stacking.
>>> +	 *
>>> +	 * Note that we can only get here with (wakee) p->on_rq=0,
>>> +	 * p->on_cpu can be whatever, we've done the dequeue, so
>>> +	 * the wakee has been accounted out of ->nr_running
>>>    	 */
>>> -	if ((wake_flags & WF_ON_CPU) && cpu_rq(cpu)->nr_running <= 1)
>>> +	if (!cpu_rq(cpu)->nr_running)
>>>    		return true;
>>>    
>>>    	return false;
>>
>> Hi Valentin. I've done a simple unixbench test (Pipe-based Context
>> Switching) on my x86 machine with full threads (104).
>>
>>                old            patch1           patch1+patch2
>> score       7825.4     7500(more)-8000          9061.6
>>
>> patch1: use !cpu_rq(cpu)->nr_running instead of cpu_rq(cpu)->nr_running <= 1
>> patch2: ignore WF_ON_CPU check
>>
>> The score of patch1 is not stable. I've tested for many times and the
>> score is floating between about 7500-8000 (more at 7500).
>>
>> patch1 means more strict limit on using wakelist. But it may cause
>> performance regression.
>>
>> It seems that, using wakelist properly can help improve wakeup
>> performance, but using it too much may cause more IPIs. It's a trade-off
>> about how strict the ttwu_queue_cond() is.
>>
>> Anyhow, I think patch2 should be a pure improvement. What's your idea?
> 
> Thanks for separately testing these two.
> 
> I take it the results for patch1 are noticeably more swingy than the
> baseline? (FWIW boxplots are usually a nice way to summarize those sort of
> results).
> 

Hmm... I'm not familiar with this...
T want to say that I'm not sure about the performance impact about 
patch1. While from the view of logic, patch1 should be correct.

> WF_ON_CPU && nr_running == 1 means the wakee is scheduling out *and* there
> is another task queued, I'm guessing that's relatively common in your
> unixbench scenario...
> 
> Either way, I think we want to keep the two changes separate for the sake
> of testing and bisecting.

Yes. I'll split the patch to 2 parts. One for logic fix and another for 
performance improvement.

