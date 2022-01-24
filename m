Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 420264983C6
	for <lists+linux-kernel@lfdr.de>; Mon, 24 Jan 2022 16:47:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234604AbiAXPrR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 24 Jan 2022 10:47:17 -0500
Received: from foss.arm.com ([217.140.110.172]:38338 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231434AbiAXPrP (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 24 Jan 2022 10:47:15 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 77AEA6D;
        Mon, 24 Jan 2022 07:47:15 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B88C03F766;
        Mon, 24 Jan 2022 07:47:13 -0800 (PST)
Subject: Re: [PATCH] sched/rt: Plug rt_mutex_setprio() vs push_rt_task() race
To:     Valentin Schneider <valentin.schneider@arm.com>,
        linux-kernel@vger.kernel.org
Cc:     John Keeping <john@metanate.com>, Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>
References: <20220120194037.650433-1-valentin.schneider@arm.com>
 <aa5bf2d0-bef7-485a-9a51-0da7df67d8c5@arm.com> <875yq945yi.mognet@arm.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <349ada44-69bd-8653-a9f8-4f3d0f303392@arm.com>
Date:   Mon, 24 Jan 2022 16:47:01 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <875yq945yi.mognet@arm.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 24/01/2022 14:29, Valentin Schneider wrote:
> On 24/01/22 10:37, Dietmar Eggemann wrote:
>> On 20/01/2022 20:40, Valentin Schneider wrote:
>>
>> [...]
>>
>>> diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
>>> index 7b4f4fbbb404..48fc8c04b038 100644
>>> --- a/kernel/sched/rt.c
>>> +++ b/kernel/sched/rt.c
>>> @@ -2026,6 +2026,16 @@ static int push_rt_task(struct rq *rq, bool pull)
>>>  		return 0;
>>>  
>>>  retry:
>>> +	/*
>>> +	 * It's possible that the next_task slipped in of
>>> +	 * higher priority than current. If that's the case
>>> +	 * just reschedule current.
>>> +	 */
>>> +	if (unlikely(next_task->prio < rq->curr->prio)) {
>>> +		resched_curr(rq);
>>> +		return 0;
>>> +	}
>>
>> If we do this before `is_migration_disabled(next_task), shouldn't then
>> the related condition in push_dl_task() also be moved up?
>>
>>   if (dl_task(rq->curr) &&
>>     dl_time_before(next_task->dl.deadline, rq->curr->dl.deadline) &&
>>     rq->curr->nr_cpus_allowed > 1)
>>
>> To enforce resched_curr(rq) in the `is_migration_disabled(next_task)`
>> case there as well?
>>
> 
> I'm not sure if we can hit the same issue with DL since DL doesn't have the
> push irqwork. If there are DL tasks on the rq when current gets demoted,
> switched_from_dl() won't queue pull_dl_task().

True. But with your RT change we reschedule current (CFS task or lower
rt task than next_task) now even in case next task is
migration-disabled. I.e. we prefer rescheduling over pushing current away.

But for DL we wouldn't reschedule current in such a case, we would just
return 0.

That said, the prio based check in RT includes other sched classes where
the DL check only compares DL tasks.

> That said, if say we have DL tasks on the rq and demote the current DL task
> to RT, do we currently have anything that will call resched_curr() (I'm
> looking at the rt_mutex path)?
> switched_to_fair() has a resched_curr() (which helps for the RT -> CFS
> case), I don't see anything that would give us that in switched_from_dl() /
> switched_to_rt(), or am I missing something?
> 
>>> +
>>>  	if (is_migration_disabled(next_task)) {
>>>  		struct task_struct *push_task = NULL;
>>>  		int cpu;
>>> @@ -2033,6 +2043,17 @@ static int push_rt_task(struct rq *rq, bool pull)
>>>  		if (!pull || rq->push_busy)
>>>  			return 0;
>>>  
>>> +		/*
>>> +		 * Per the above priority check, curr is at least RT. If it's
>>> +		 * of a higher class than RT, invoking find_lowest_rq() on it
>>> +		 * doesn't make sense.
>>> +		 *
>>> +		 * Note that the stoppers are masqueraded as SCHED_FIFO
>>> +		 * (cf. sched_set_stop_task()), so we can't rely on rt_task().
>>> +		 */
>>> +		if (rq->curr->sched_class != &rt_sched_class)
>>
>> s/ != / > / ... since the `unlikely(next_task->prio < rq->curr->prio)`
>> already filters tasks from lower sched classes (CFS)?
>>
> 
> != points out we won't invoke find_lowest_rq() on anything that isn't RT,
> which makes it a bit clearer IMO, and it's not like either of those
> comparisons is more expensive than the other :)

Also true, but it would be more aligned to the comment above '...  If it
(i.e. curr) 's of a higher class than ...'

[...]

