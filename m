Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 819AA4876AE
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 12:43:57 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347193AbiAGLnz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 06:43:55 -0500
Received: from foss.arm.com ([217.140.110.172]:39888 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S237668AbiAGLny (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 06:43:54 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E4C2813D5;
        Fri,  7 Jan 2022 03:43:53 -0800 (PST)
Received: from [192.168.178.6] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F26263F66F;
        Fri,  7 Jan 2022 03:43:51 -0800 (PST)
Subject: Re: [PATCH v2 1/3] sched/pelt: Don't sync hardly util_sum with
 uti_avg
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        rostedt@goodmis.org, bsegall@google.com, mgorman@suse.de,
        bristot@redhat.com, linux-kernel@vger.kernel.org,
        rickyiu@google.com, odin@uged.al, sachinp@linux.vnet.ibm.com,
        naresh.kamboju@linaro.org
References: <20211222093802.22357-1-vincent.guittot@linaro.org>
 <20211222093802.22357-2-vincent.guittot@linaro.org>
 <9e526482-905c-e759-8aa6-1ff84bb5b2a3@arm.com>
 <CAKfTPtBR3BWCwEaJe0Cq6K5__zNxfU7FFo2f0bpOPkvzxKdiww@mail.gmail.com>
 <8f39d837-2589-4f7b-5232-1ed134fb1ad7@arm.com>
 <CAKfTPtCVD40GiDEG0pnU+k-nwMAh2PSu_OXq4w3k0A0zR4cLpw@mail.gmail.com>
From:   Dietmar Eggemann <dietmar.eggemann@arm.com>
Message-ID: <f1549032-50f6-e9fc-a7ae-24373352576b@arm.com>
Date:   Fri, 7 Jan 2022 12:43:50 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:78.0) Gecko/20100101
 Thunderbird/78.14.0
MIME-Version: 1.0
In-Reply-To: <CAKfTPtCVD40GiDEG0pnU+k-nwMAh2PSu_OXq4w3k0A0zR4cLpw@mail.gmail.com>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05/01/2022 14:57, Vincent Guittot wrote:
> On Wed, 5 Jan 2022 at 14:15, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>
>> On 04/01/2022 14:42, Vincent Guittot wrote:
>>> On Tue, 4 Jan 2022 at 12:47, Dietmar Eggemann <dietmar.eggemann@arm.com> wrote:
>>>>
>>>> On 22/12/2021 10:38, Vincent Guittot wrote:
>>
>> [...]
>>
>>>> I still wonder whether the regression only comes from the changes in
>>>> update_cfs_rq_load_avg(), introduced by 1c35b07e6d39.
>>>> And could be fixed only by this part of the patch-set (A):
>>>
>>> I have been able to trigger the warning even with (A) though It took
>>> much more time.
>>> And I have been able to catch wrong situations  (with additional
>>> traces) in the 3 places A, B and C
>>
>> OK. By wrong situation you mean '_sum < _avg * MIN_DIVIDER' ?
> 
> not only.
> also util_sum == 0 but util_avg !=0 in different places although these

Ah OK, I saw this one as part of '_sum < _avg * MIN_DIVIDER'.

> situation didn't trigger sched_warn because some other sync happened
> before the periodic call of __update_blocked_fair
> or if nr_running == 1 and  and task's util_avg/sum > cfs' util_avg/sum
> just before removing the task

I see.

>>>> @@ -3677,15 +3706,22 @@ update_cfs_rq_load_avg(u64 now, struct cfs_rq
>>>> *cfs_rq)
>>>>
>>>>     r = removed_load;
>>>>     sub_positive(&sa->load_avg, r);
>>>> -   sa->load_sum = sa->load_avg * divider;
>>>> +   sub_positive(&sa->load_sum, r * divider);
>>>> +   sa->load_sum = max_t(u32, sa->load_sum, sa->load_avg * MIN_DIVIDER);
>>>>
>>>>     r = removed_util;
>>>>     sub_positive(&sa->util_avg, r);
>>>> -   sa->util_sum = sa->util_avg * divider;
>>>> +   sub_positive(&sa->util_sum, r * divider);
>>>> +   sa->util_sum = max_t(u32, sa->util_sum, sa->util_avg * MIN_DIVIDER);
>>>>
>>>>     r = removed_runnable;
>>>>     sub_positive(&sa->runnable_avg, r);
>>>> -   sa->runnable_sum = sa->runnable_avg * divider;
>>>> +   sub_positive(&sa->runnable_sum, r * divider);
>>>> +   sa->runnable_sum = max_t(u32, sa->runnable_sum,
>>>> +                                 sa->runnable_avg * MIN_DIVIDER);
>>>>
>>>> i.e. w/o changing update_tg_cfs_X() (and
>>>> detach_entity_load_avg()/dequeue_load_avg()).
>>>>
>>>> update_load_avg()
>>>>   update_cfs_rq_load_avg()    <---
>>>>   propagate_entity_load_avg()
>>>>     update_tg_cfs_X()         <---
>>>>
>>>>
>>>> I didn't see the SCHED_WARN_ON() [cfs_rq_is_decayed()] when looping on
>>>> hackbench in several different sched group levels on
>>>> [Hikey620 (Arm64, 8 CPUs, SMP, 4 taskgroups: A/B C/D E/F G/H), >12h uptime].
>>>
>>> IIRC, it was with hikey960 with cgroup v1
>>> As a side note, I never trigger the problem with dragonboard845 and cgroup v2
>>
>> OK, just started a test on hikey960 cgroupv1. Let's see if I can catch it.

Still no sign of the issue (hikey960, cgroupv1,  4 taskgroups: A/B C/D
E/F G/H > 45h uptime

>>>>> @@ -3780,7 +3799,11 @@ static void detach_entity_load_avg(struct cfs_rq *cfs_rq, struct sched_entity *s
>>>>>
>>>>>       dequeue_load_avg(cfs_rq, se);
>>>>>       sub_positive(&cfs_rq->avg.util_avg, se->avg.util_avg);
>>>>> -     cfs_rq->avg.util_sum = cfs_rq->avg.util_avg * divider;
>>>>> +     sub_positive(&cfs_rq->avg.util_sum, se->avg.util_sum);
>>>>> +     /* See update_tg_cfs_util() */
>>>>> +     cfs_rq->avg.util_sum = max_t(u32, cfs_rq->avg.util_sum,
>>>>> +                                       cfs_rq->avg.util_avg * MIN_DIVIDER);
>>>>> +
>>>>
>>>> Maybe add a:
>>>>
>>>> Fixes: fcf6631f3736 ("sched/pelt: Ensure that *_sum is always synced
>>>> with *_avg")
>>>
>>> I spent time thinking about adding fixes tag. There is no crash/warn
>>> so far so should we propagate it back in LTS for better performance ?
>>
>> Not sure I understand. What do you mean by 'should we propagate it back
>> in LTS'?
> 
> Sorry I had any stables in mind and not only LTS.
> 
> Some of the changes done in PELT signal propagation that replace
> subtracting util_sum  by using util_avg * divider instead, are related
> to other problems with sched group hierarchy and
> throttling/unthrottling. I'm not 100% confident that using fixes tag
> to backport this on stables doesn't need to backport more patches on
> other areas in order to not resurrect old problems. So I wonder if
> it's worth  backporting this on stables

OK, I see. So only 1c35b07e6d39 (i.e. the util _sum/_avg change in
update_cfs_rq_load_avg() (1)) caused the CPU frequency regression. That
was the reason why I initially suggested to split the patch-set
differently. But you said that you saw the issue also when (1) is fixed.
