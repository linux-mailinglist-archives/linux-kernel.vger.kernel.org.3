Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 05391462E17
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 09:00:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239307AbhK3IDl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 03:03:41 -0500
Received: from mx1.didiglobal.com ([36.110.17.22]:8373 "HELO
        mailgate01.didichuxing.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with SMTP id S234489AbhK3IDk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 03:03:40 -0500
Received: from mail.didiglobal.com (unknown [172.20.36.31])
        by mailgate01.didichuxing.com (Maildata Gateway V2.8) with ESMTP id E37F2D81B920B;
        Tue, 30 Nov 2021 15:58:13 +0800 (CST)
Received: from BJSGEXMBX12.didichuxing.com (172.20.15.142) by
 BJSGEXMBX10.didichuxing.com (172.20.15.140) with Microsoft SMTP Server (TLS)
 id 15.0.1497.2; Tue, 30 Nov 2021 15:58:13 +0800
Received: from [172.24.140.44] (172.24.140.44) by BJSGEXMBX12.didichuxing.com
 (172.20.15.142) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Tue, 30 Nov
 2021 15:58:13 +0800
Message-ID: <bb88899e-3c54-4583-eef9-d30f01efe4bb@didichuxing.com>
Date:   Tue, 30 Nov 2021 15:58:04 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.3.2
Subject: Re: [PATCH] sched/fair: prevent cpu burst too many periods
Content-Language: en-US
To:     Benjamin Segall <bsegall@google.com>,
        Huaixin Chang <changhuaixin@linux.alibaba.com>
CC:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Mel Gorman <mgorman@suse.de>,
        "Daniel Bristot de Oliveira" <bristot@redhat.com>,
        <linux-kernel@vger.kernel.org>, <jameshongleiwang@126.com>
X-MD-Sfrom: wanghonglei@didiglobal.com
X-MD-SrcIP: 172.20.36.31
From:   Honglei Wang <wanghonglei@didichuxing.com>
In-Reply-To: <xm26mtlmpvox.fsf@google.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 7bit
X-Originating-IP: [172.24.140.44]
X-ClientProxiedBy: BJEXCAS35.didichuxing.com (172.20.36.196) To
 BJSGEXMBX12.didichuxing.com (172.20.15.142)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 2021/11/30 04:13, Benjamin Segall wrote:
> Honglei Wang <wanghonglei@didichuxing.com> writes:
> 
>> Tasks might get more cpu than quota in persistent periods due to the
>> cpu burst introduced by commit f4183717b370 ("sched/fair: Introduce the
>> burstable CFS controller"). For example, one task group whose quota is
>> 100ms per period and can get 100ms burst, and its avg utilization is
>> around 105ms per period. Once this group gets a free period which
>> leaves enough runtime, it has a chance to get computting power more
>> than its quota for 10 periods or more in common bandwidth configuration
>> (say, 100ms as period). It means tasks can 'steal' the bursted power to
>> do daily jobs because all tasks could be scheduled out or sleep to help
>> the group get free periods.
>>
>> I believe the purpose of cpu burst is to help handling bursty worklod.
>> But if one task group can get computting power more than its quota for
>> persistent periods even there is no bursty workload, it's kinda broke.
>>
>> This patch limits the burst to one period so that it won't break the
>> quota limit for long. With this, we can give task group more cpu burst
>> power to handle the real bursty workload and don't worry about the
>> 'stealing'.
> 
> CC ing the burst patch author.
> 
> Whether or not burst is useful only for burst, or also for a bit of
> long-term-only fairness is not entirely clear to me. Assuming we want it
> only for burst, cutting off this sharply has a bit of additional
> downside because it means that if a period refresh lands in the middle
> of a burst then you lose the burst runtime. Permitting only two periods
> in a row to make use of burst should be doable but it's yet another
> piece of state added to cfs_b for this, and given typical ~100ms periods
> that may be low enough odds that we don't care.
> 

Originally, I was thinking if we should permit 2 periods, but in another 
hand, I thought if we just permit 1, we can give more cpu.max.burst to 
help the workloads sharp enough and can use up the quota even when they 
start working in the middle of one period. In this way, they have chance 
to get job done in part period with quota+bursted cpu and probably one 
more period with only quota. It's kind of different views of the usage.

If you think it can't cover the burst work loads, we can permit more 
periods.

>>
>> Signed-off-by: Honglei Wang <wanghonglei@didichuxing.com>
>> ---
>>   kernel/sched/fair.c | 9 ++++++---
>>   1 file changed, 6 insertions(+), 3 deletions(-)
>>
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 6e476f6d9435..cc2c4567fc81 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -4640,14 +4640,17 @@ void __refill_cfs_bandwidth_runtime(struct cfs_bandwidth *cfs_b)
>>   	if (unlikely(cfs_b->quota == RUNTIME_INF))
>>   		return;
>>   
>> -	cfs_b->runtime += cfs_b->quota;
>> -	runtime = cfs_b->runtime_snap - cfs_b->runtime;
>> +	runtime = cfs_b->runtime_snap - cfs_b->quota - cfs_b->runtime;
>> +
>>   	if (runtime > 0) {
>>   		cfs_b->burst_time += runtime;
>>   		cfs_b->nr_burst++;
>> +		cfs_b->runtime = cfs_b->quota;
>> +	} else {
>> +		cfs_b->runtime += cfs_b->quota;
>> +		cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
>>   	}
>>   
>> -	cfs_b->runtime = min(cfs_b->runtime, cfs_b->quota + cfs_b->burst);
>>   	cfs_b->runtime_snap = cfs_b->runtime;
>>   }
> 
> If we do this, it should also be mentioned in
> Documentation/scheduler/sched-bwc.rst, since the straightforward
> description of burst as extra max runtime is no longer enough.
> 

Yep, I'll try to refine the description of the documentation next time 
if we decide to do this.

Thank,
Honglei
