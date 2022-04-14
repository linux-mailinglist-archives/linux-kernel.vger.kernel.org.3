Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F4BF501847
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 18:08:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241590AbiDNQHf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 12:07:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349642AbiDNP45 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 11:56:57 -0400
Received: from mail-pf1-x42a.google.com (mail-pf1-x42a.google.com [IPv6:2607:f8b0:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F2854252
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:36:56 -0700 (PDT)
Received: by mail-pf1-x42a.google.com with SMTP id l127so3464085pfl.6
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 08:36:56 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Del0YeHO+pZXfLnVE/laCfH96hEXfZHDYIwspmKAr7M=;
        b=Aax9vCA4u7kYD8oGQ0mF6NL7+vmSLsmnPZL2t95Ni1I7TL+2JLty3Pm21wy6aVHI06
         lJ449OM/kxmkiUsic8Q9gskFiw1AQoX83JoxjoHYhlMi+78fnpbv1DwlmJbXxnYf5Iyc
         Nm+3WChWErIuaUoHlGQlzSm1dcpPmnSvy/iexX1XHw7U14GuBUMZqYuYWxknDD+Trclc
         koywgW5ltTJqkm7BGdUPKimvyQzyjfMk4YcJpfPj05P30Vb9pJVvtl2VqlZAvLqQmp0T
         ozA1OmLtjKuBN1iVs+4LuXjosPe4o5QpVe6IxtIi9X5cEp5FNKKlEZg6+L1O4YuXmFPH
         ECNA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Del0YeHO+pZXfLnVE/laCfH96hEXfZHDYIwspmKAr7M=;
        b=TWEAxMo7ewYLTNd5KrHdCOrVCxKpbp5lR46tJlkStVVy2K3batEPtfrXcVGiJJOzFd
         RYNssj4aPwA9do2cC42mqe+61qd9/cZLKiYDY4qa57ViIlDbyHscIF54zMFGi8muVhFi
         m8fZbkHZzg7IlDzvsmEF2RiOelQWDY2NtHYfPbONwfmVi/qnHpdywDqbF8tJAqvMAIbS
         6XQy3hbRcmTfEfzMhyHAFsmCDhqoqqH6tq79e/cyb4zV1w4LB+hIUDBRWJ5gNlThxE3z
         sIzDHBm0dz6BVeHLywEfp8wrjyr6Wk7VDOdJYVwXhJu5gUBh+w2AGJ7AaL2UyjrgmLLN
         GnoA==
X-Gm-Message-State: AOAM531BIZxf1QSWv0gbuWW0X2WT4I7n2Gb6/eVGBSJXeJnRYrv+WWpG
        CvwGbqXAEoDqHBP41P4jWKLEZQ==
X-Google-Smtp-Source: ABdhPJxKvquxJErlZVBO9DK1VGSk3A1KF1JoaxV9ifrXGsI1WtkdoA1SpMs6sj75xgKorDtMX/1K4w==
X-Received: by 2002:a63:4147:0:b0:382:9ac9:b12b with SMTP id o68-20020a634147000000b003829ac9b12bmr2786112pga.277.1649950616379;
        Thu, 14 Apr 2022 08:36:56 -0700 (PDT)
Received: from [10.255.214.21] ([139.177.225.227])
        by smtp.gmail.com with ESMTPSA id z7-20020a056a00240700b004e1cde37bc1sm300941pfh.84.2022.04.14.08.36.53
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 14 Apr 2022 08:36:55 -0700 (PDT)
Message-ID: <45fdb9f1-ac3e-2b92-9bd9-0f5e5886e2c9@bytedance.com>
Date:   Thu, 14 Apr 2022 23:36:51 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RFC v2 1/2] sched/fair: filter out overloaded cpus in SIS
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abel Wu <wuyun.abel@bytedance.com>
References: <20220409135104.3733193-1-wuyun.abel@bytedance.com>
 <20220409135104.3733193-2-wuyun.abel@bytedance.com>
 <CABk29NtBL2WovUVcxXW8cF7Nk+UM_AeEJaX_JbQ4Wue-qMvz_w@mail.gmail.com>
 <56ded56d-f7ad-a49f-c19c-8aa40fb33a29@bytedance.com>
 <CABk29Nu+6vh825SqyNmSJoWBQmEBgCsk6mcEtWLmXCq_T0xUjg@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29Nu+6vh825SqyNmSJoWBQmEBgCsk6mcEtWLmXCq_T0xUjg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/14/22 7:49 AM, Josh Don Wrote:
> On Tue, Apr 12, 2022 at 10:55 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> On 4/12/22 9:23 AM, Josh Don Wrote:
> 
>>>>    static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
>>>>    {
>>>>           struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>>>> -       int i, cpu, idle_cpu = -1, nr = INT_MAX;
>>>> +       int i, cpu, idle_cpu = -1, nr = INT_MAX, nro;
>>>>           struct rq *this_rq = this_rq();
>>>>           int this = smp_processor_id();
>>>>           struct sched_domain *this_sd;
>>>> @@ -6301,7 +6310,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>>>           if (!this_sd)
>>>>                   return -1;
>>>>
>>>> +       nro = atomic_read(&sd->shared->nr_overloaded);
>>>> +       if (sched_domain_overloaded(sd, nro))
>>>> +               return -1;
>>>
>>> This early bail out doesn't seem to be related to the main idea of
>>> your patch. Apart from deciding the exact heuristic value for what is
>>
>> I agree that this early check doesn't seem to have a strong bound with
>> the idea "filter out the overloaded cpus", but this check is aligned
>> with the goal of "search less when becoming more overloaded".
>>
>> As to the heuristic value, which is about 95%, I think it would be nice
>> if I can show more test results? I also have tested sd->imbalance_pct
>> and 100% (nro == sd->span_weight), seems like 95% is a better choice.
>>
>>> considered too unlikely to find an idle cpu, this doesn't work well
>>> with tasks constrained by affinity; a task may have a small affinity
>>> mask containing idle cpus it may wake onto, even if most of the node
>>> is overloaded.
>>
>> Yes, indeed. And I haven't come to a solution except that remove this
>> check entirely. Ideas?
> 
> Does this check help that much? Given that you added the filter below
> to cut out searching overloaded cpus, I would think that the below is
> sufficient.

I see a ~10% performance drop in the higher load part of the hackbench
and tbench without this check, in which cases system is quite overloaded
and idle cpus can hardly exist.

> 
> Another use case that would break with the above:
> 
> A few cpus are reserved for a job, so that it always has a couple cpus
> dedicated to it. It can run across the entire machine though (no
> affinity restriction). If the rest of the machine is very busy, we'd
> still want to be able to search for and find the idle reserved cpus
> for the job.

Yes, this could be true if very few cpus are reserved for the job. Along
with the previous affinity case, I think the following might help both:

static inline bool
sched_domain_overloaded(struct sched_domain *sd, int nr_overloaded)
{
	return nr_overloaded == sd->span_weight;
}

Besides, I think sched_idle_balance() will work well on this case.

> 
>>>>           cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>>>> +       if (nro)
>>>> +               cpumask_andnot(cpus, cpus, sdo_mask(sd->shared));
>>>
>>> To prevent us from exhausting our search attempts too quickly, this
>>> only needs to go under the sched_feat(SIS_PROP) && !has_idle_core case
>>> below. But by doing this unconditionally here, I guess your secondary
>>> goal is to reduce total search cost in both cases. Just wondering, did
>>
>> Yes, it's unnecessary to try the overloaded cpus. But this makes sense
>> only if the overloaded cpumask is relatively accurate as you pointed
>> out below.
>>
>>> you observe significant time spent here that you are trying to
>>> optimize? By reducing our search space by the overload mask, it is
>>> important that the mask is relatively up to date, or else we could
>>> miss an opportunity to find an idle cpu.
>>
>> I think that's why Mel asked for the SIS statistics. The result in the
>> cover letter shows improvement on the search efficiency, and that is
>> what the overhead of the cpumask calculation trade for. Would it be
>> better if skip the update when nro is small?
> 
> Just pointing out that with a very fast wake/sleep rate, you could hit
> cases where you potentially fail to consider waking onto a cpu that is
> actually idle. But I think this concern is addressed below.
> 
>>>
>>>>           if (sched_feat(SIS_PROP) && !has_idle_core) {
>>>>                   u64 avg_cost, avg_idle, span_avg;
>>>> @@ -7018,6 +7033,51 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>>>
>>>>           return newidle_balance(rq, rf) != 0;
>>>>    }
>>>> +
>>>> +static inline bool cfs_rq_overloaded(struct rq *rq)
>>>> +{
>>>> +       return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running > 1;
>>>> +}
>>>
>>> Why > 1 instead of > 0? If a cpu is running 1 non-idle task and any
>>> number of idle tasks, I'd think it is still "occupied" in the way
>>> you've defined. We'd want to steer wakeups to cpus running 0 non-idle
>>> tasks.
>>
>> The idea behind "> 1" is telling the unoccupied cpus to pull non-idle
>> tasks from it (in the next patch). Although "> 0" is more efficient in
>> wakeup, it blinds us when pulling tasks.
> 
> Ok, I was a bit confused because there are different considerations
> for >=1 and >=2 non-idle tasks.
> 
> So you consider >= 2 non-idle tasks to be "overloaded". TBH I do
> prefer this than ">=1" for the wakeup filtering anyway, because if
> there are at least two tasks, that makes it less likely for us to race
> with seeing a spurious wakeup/sleep causing a cpu to be fully
> idle/non-idle (ie. we have more confidence that we can safely filter
> out the overload mask).

Agreed.

> 
>>> Why are these cpu mask writes not atomic?
>>
>> They are atomic. The non-atomic version is __cpumask_{set,clear}_cpu.
>> Did I miss something?
> 
> Ah, I confused these, my bad.
> 
>>> I'd caution about using task_tick and pick_next_task_fair as the
>>> places we set and clear overload.
>>>
>>> Some issues with task_tick:
>>> - ticks may be disabled in NO_HZ_FULL (an issue if we define overload
>>> as > 0 non-idle tasks)
>>> - most ticks will have the same state, so somewhat redundant checking.
>>> Could use an edge based trigger instead, such as enqueue/dequeue
>>> (somewhat similar to rq->rd->overload).
>>
>> 1. In NO_HZ_FULL, given rq is overloaded, say have non-idle task A and
>>      B enqueued, if A is dequeued before next tick then tick will be off
>>      and the rq will keep "overloaded" while it's actually not. But this
>>      doesn't necessarily be a bad thing because this cpu will be skipped
>>      in wakeup path which helps in improving searching efficiency.
> 
> Yea this concern is alleviated because overload is actually >=2 tasks
> (I had been incorrectly assuming you wanted to mark overload for >=1
> non-idle task.
> 
>> 2. Yes, that's why I use rq->overloaded to save the last update state.
>>      So when the overloaded state doesn't change, what we all do is a
>>      simple check on a local variable.
>>      The enqueue/dequeue path is not well bounded, and it could be very
>>      frequent on short running workloads, which would introduce great
>>      overhead to update the LLC shared atomic/cpumask.
> 
> Yea, the frequent update would be an issue. I now see the check on the
> cpu-local variable.
> 
> So the rate limit on updates comes from the fact that
> !overloaded->overloaded requires a tick. We can quickly go from
> overloaded->!overloaded, but will take another tick until we can go
> back to overloaded.

 From the SIS's point of view, yes. But sched_idle_balance() will help
in overloaded->!overloaded transition, since an update will be issued
on the overloaded cpu after pulling. This tendency towards !overload
makes overload bits more reliable than the !overload bits in cpumask,
and when comes to the worst case, that is all bits are !overload, it
just fallback to the original SIS code.

> 
>>> With pick_next_task_fair():
>>> - there's a window between a thread dequeuing, and then scheduler
>>> running through to the end of pick_next_task_fair(), during which we
>>> falsely observe the cpu as overloaded
>>> - this breaks with core scheduling, since we may use pick_task_fair
>>> rather than pick_next_task_fair
>>
>> 1. I'm afraid I don't understand what the problem is, can you explain
>>      more on this? Thanks.
> 
> Can ignore this comment, I don't think it is relevant given that this
> isn't really a regression vs. the latency between the last thread
> dequeuing and available_idle_cpu() returning true.
> 
>> 2. Nice catch, I will fix it in next update. (Maybe by updating the
>>      overloaded status in do_idle()?)
> 
> Ideally can catch it before we actually switch to rq->idle (just
> trying to minimize latency to mark as !overloaded).

Makes sense.

Thanks & BR,
Abel

