Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EA8E94878E9
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 15:25:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239195AbiAGOZb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 09:25:31 -0500
Received: from foss.arm.com ([217.140.110.172]:41090 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238858AbiAGOZY (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 09:25:24 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 0174613A1;
        Fri,  7 Jan 2022 06:25:24 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 38D8F3F774;
        Fri,  7 Jan 2022 06:25:22 -0800 (PST)
Subject: Re: [RT] BUG in sched/cpupri.c
To:     John Keeping <john@metanate.com>
Cc:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-rt-users@vger.kernel.org, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org
References: <Yb3vXx3DcqVOi+EA@donbot>
 <71ddbe51-2b7f-2b13-5f22-9013506471dc@arm.com> <87zgou6iq1.mognet@arm.com>
 <20211221164528.3c84543f.john@metanate.com>
 <31a47e99-6de3-76ec-62ad-9c98d092ead5@arm.com> <87r1a4775a.mognet@arm.com>
 <f2d50e78-dc7b-6851-f12e-d702fbfea826@arm.com> <Ydgo2lENzywieaZL@donbot>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <88826618-5ce8-dd1f-c9db-ec273fede3ce@arm.com>
Date:   Fri, 7 Jan 2022 15:25:21 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <Ydgo2lENzywieaZL@donbot>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/01/2022 12:49, John Keeping wrote:
> On Fri, Jan 07, 2022 at 11:46:45AM +0100, Dietmar Eggemann wrote:
>> On 22/12/2021 20:48, Valentin Schneider wrote:
>>>  /*
>>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>>> index ef8228d19382..8f3e3a1367b6 100644
>>> --- a/kernel/sched/rt.c
>>> +++ b/kernel/sched/rt.c
>>> @@ -1890,6 +1890,16 @@ static int push_rt_task(struct rq *rq, bool pull)
>>>  	if (!next_task)
>>>  		return 0;
>>>  
>>> +	/*
>>> +	 * It's possible that the next_task slipped in of higher priority than
>>> +	 * current, or current has *just* changed priority.  If that's the case
>>> +	 * just reschedule current.
>>> +	 */
>>> +	if (unlikely(next_task->prio < rq->curr->prio)) {
>>> +		resched_curr(rq);
>>> +		return 0;
>>> +	}
>>
>> IMHO, that's the bit which prevents the BUG.
>>
>> But this would also prevent the case in which rq->curr is an RT task
>> with lower prio than next_task.
>>
>> Also `rq->curr = migration/X` goes still though which is somehow fine
>> since find_lowest_rq() bails out for if (task->nr_cpus_allowed == 1).
>>
>> And DL tasks (like sugov:X go through and they can have
>> task->nr_cpus_allowed > 1 (arm64 slow-switching boards with shared
>> freuency domains with schedutil). cpupri_find_fitness()->convert_prio()
>> can handle  task_pri, p->prio = -1 (CPUPRI_INVALID) although its somehow
>> by coincidence.
>>
>> So maybe something like this:
> 
> Do you mean to replace just the one hunk from Valentin's patch with the
> change below (keeping the rest), or are you saying that only the change
> below is needed?

The latter.

I think Valentin wanted to see if something like this can also occur via
sched_setscheduler() and maybe for this changes in switched_from_[rt/dl]
will be necessary.

>> @ -1898,6 +1898,11 @@ static int push_rt_task(struct rq *rq, bool pull)
>>                 if (!pull || rq->push_busy)
>>                         return 0;
>>
>> +               if (rq->curr->sched_class != &rt_sched_class) {
>> +                       resched_curr(rq);
>> +                       return 0;
>> +               }
>> +
>>                 cpu = find_lowest_rq(rq->curr);
>>
>> [...
