Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 733CF4FE782
	for <lists+linux-kernel@lfdr.de>; Tue, 12 Apr 2022 19:55:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358565AbiDLR6L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 12 Apr 2022 13:58:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230389AbiDLR6I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 12 Apr 2022 13:58:08 -0400
Received: from mail-pj1-x1031.google.com (mail-pj1-x1031.google.com [IPv6:2607:f8b0:4864:20::1031])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1DE6954693
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:55:50 -0700 (PDT)
Received: by mail-pj1-x1031.google.com with SMTP id c12-20020a17090a020c00b001cba1ebb20cso2608173pjc.0
        for <linux-kernel@vger.kernel.org>; Tue, 12 Apr 2022 10:55:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=kozdvatZLTmDkXnmiW8bALff1eOcRGxn1gxosrc9704=;
        b=IHZMd4MD9Rg98YDSoYfqnIsRGYqbCbsGIJ6qcTf8GsV74kYgQ7wnHe5s7c5TO67Xhk
         NUevKLw8Y8eYcvMnXk+6LiF7Xz+L9s3sv2moh8wFs1saUIDENTBxBADAK0DU+dFUuM0H
         3xHnIq4q9NFl+Hm7n+S+i7kB5jgOqKb/MZKSlsbKK78gBZlEZydlu5o6nGadsEPoJLZu
         sEeJtJrhLuxtkyPfFda0aYPwHccBEjmWDwDV+vNpRtfjP/pkUJiGXN/xZQMt7CkEcJkQ
         K0p+Lp9DTpsHdloi86nGc0kLl9EyjfuvpVYn66LpRu9rUbwoAlyutn7FeBxIGLQyCfhs
         d1zg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=kozdvatZLTmDkXnmiW8bALff1eOcRGxn1gxosrc9704=;
        b=LjokDjrCyV07OYHZzTzCAFIKRriHYaTNXM3k5RCHZ+SxoQU1vJi3jMPeavwBXhbFJZ
         8T2JlQqUZb7388tbnKlGCjOfpc5x3qBIyPynpZHgvj3kKXPsv9fgqeju05fpYkgKMGNG
         oaPo9IMqiX5FmzS0rWAt8fMRJw/YUYpw2R4lHhARxvjYh+PJWEf+P9acWl7Q3Ori1uix
         8EfhG6q7riK08mOGj7Cf0EXjWdaigr92ETRjKzNipyOfUGXXHVL0TyOaQasEic9jAv4h
         vMX+X3iDOnpNhmYmEU1c5bE2RcYAub2QmUWCoKO7So3Dtojvj0QV8A+D3iSytohCXavm
         IQNw==
X-Gm-Message-State: AOAM531pN0IgGwsrOYkGvopjtO1iJonsTS8aBhkwMTub8q+hPM7unehT
        /P/YKr7uAWWPI25zQFl70aYIBQ==
X-Google-Smtp-Source: ABdhPJzngRxSqx/MusdTXjhnwzmNP59GzqkkI9+YAjXPLNKl4wzmFIyb73y7gg4rritgkWAEwIHABg==
X-Received: by 2002:a17:90b:3144:b0:1cb:6343:cd54 with SMTP id ip4-20020a17090b314400b001cb6343cd54mr6287762pjb.52.1649786149564;
        Tue, 12 Apr 2022 10:55:49 -0700 (PDT)
Received: from [10.254.90.123] ([139.177.225.252])
        by smtp.gmail.com with ESMTPSA id n3-20020a62e503000000b005060c0b379esm470756pff.200.2022.04.12.10.55.46
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 12 Apr 2022 10:55:49 -0700 (PDT)
Message-ID: <56ded56d-f7ad-a49f-c19c-8aa40fb33a29@bytedance.com>
Date:   Wed, 13 Apr 2022 01:55:44 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.0
Subject: Re: [RFC v2 1/2] sched/fair: filter out overloaded cpus in SIS
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>
References: <20220409135104.3733193-1-wuyun.abel@bytedance.com>
 <20220409135104.3733193-2-wuyun.abel@bytedance.com>
 <CABk29NtBL2WovUVcxXW8cF7Nk+UM_AeEJaX_JbQ4Wue-qMvz_w@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29NtBL2WovUVcxXW8cF7Nk+UM_AeEJaX_JbQ4Wue-qMvz_w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh, thanks very much for your reviewing.

On 4/12/22 9:23 AM, Josh Don Wrote:
> Hi Abel,
> 
> Thanks for the patch, a few comments:
> 
>>   /*
>> + * It would be very unlikely to find an unoccupied cpu when system is heavily
>> + * overloaded. Even if we could, the cost might bury the benefit.
>> + */
>> +static inline bool sched_domain_overloaded(struct sched_domain *sd, int nr_overloaded)
>> +{
>> +       return nr_overloaded > sd->span_weight - (sd->span_weight >> 4);
>> +}
>> +
>> +/*
>>    * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>>    * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
>>    * average idle time for this rq (as found in rq->avg_idle).
>> @@ -6291,7 +6300,7 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>>   static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
>>   {
>>          struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>> -       int i, cpu, idle_cpu = -1, nr = INT_MAX;
>> +       int i, cpu, idle_cpu = -1, nr = INT_MAX, nro;
>>          struct rq *this_rq = this_rq();
>>          int this = smp_processor_id();
>>          struct sched_domain *this_sd;
>> @@ -6301,7 +6310,13 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>          if (!this_sd)
>>                  return -1;
>>
>> +       nro = atomic_read(&sd->shared->nr_overloaded);
>> +       if (sched_domain_overloaded(sd, nro))
>> +               return -1;
> 
> This early bail out doesn't seem to be related to the main idea of
> your patch. Apart from deciding the exact heuristic value for what is

I agree that this early check doesn't seem to have a strong bound with
the idea "filter out the overloaded cpus", but this check is aligned
with the goal of "search less when becoming more overloaded".

As to the heuristic value, which is about 95%, I think it would be nice
if I can show more test results? I also have tested sd->imbalance_pct
and 100% (nro == sd->span_weight), seems like 95% is a better choice.

> considered too unlikely to find an idle cpu, this doesn't work well
> with tasks constrained by affinity; a task may have a small affinity
> mask containing idle cpus it may wake onto, even if most of the node
> is overloaded.

Yes, indeed. And I haven't come to a solution except that remove this
check entirely. Ideas?

> 
>>          cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> +       if (nro)
>> +               cpumask_andnot(cpus, cpus, sdo_mask(sd->shared));
> 
> To prevent us from exhausting our search attempts too quickly, this
> only needs to go under the sched_feat(SIS_PROP) && !has_idle_core case
> below. But by doing this unconditionally here, I guess your secondary
> goal is to reduce total search cost in both cases. Just wondering, did

Yes, it's unnecessary to try the overloaded cpus. But this makes sense
only if the overloaded cpumask is relatively accurate as you pointed
out below.

> you observe significant time spent here that you are trying to
> optimize? By reducing our search space by the overload mask, it is
> important that the mask is relatively up to date, or else we could
> miss an opportunity to find an idle cpu.

I think that's why Mel asked for the SIS statistics. The result in the
cover letter shows improvement on the search efficiency, and that is
what the overhead of the cpumask calculation trade for. Would it be
better if skip the update when nro is small?

> 
>>          if (sched_feat(SIS_PROP) && !has_idle_core) {
>>                  u64 avg_cost, avg_idle, span_avg;
>> @@ -7018,6 +7033,51 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>
>>          return newidle_balance(rq, rf) != 0;
>>   }
>> +
>> +static inline bool cfs_rq_overloaded(struct rq *rq)
>> +{
>> +       return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running > 1;
>> +}
> 
> Why > 1 instead of > 0? If a cpu is running 1 non-idle task and any
> number of idle tasks, I'd think it is still "occupied" in the way
> you've defined. We'd want to steer wakeups to cpus running 0 non-idle
> tasks.

The idea behind "> 1" is telling the unoccupied cpus to pull non-idle
tasks from it (in the next patch). Although "> 0" is more efficient in
wakeup, it blinds us when pulling tasks.

> 
>> +static void update_overload_status(struct rq *rq)
>> +{
>> +       struct sched_domain_shared *sds;
>> +       bool overloaded = cfs_rq_overloaded(rq);
>> +       int cpu = cpu_of(rq);
>> +
>> +       lockdep_assert_rq_held(rq);
>> +
>> +       if (rq->overloaded == overloaded)
>> +               return;
>> +
>> +       rcu_read_lock();
>> +       sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>> +       if (unlikely(!sds))
>> +               goto unlock;
>> +
>> +       if (overloaded) {
>> +               cpumask_set_cpu(cpu, sdo_mask(sds));
>> +               atomic_inc(&sds->nr_overloaded);
>> +       } else {
>> +               cpumask_clear_cpu(cpu, sdo_mask(sds));
>> +               atomic_dec(&sds->nr_overloaded);
>> +       }
> 
> Why are these cpu mask writes not atomic?

They are atomic. The non-atomic version is __cpumask_{set,clear}_cpu.
Did I miss something?

> 
>> +
>> +       rq->overloaded = overloaded;
>> +unlock:
>> +       rcu_read_unlock();
>> +}
>> +
>> +#else
>> +
>> +static inline void update_overload_status(struct rq *rq) { }
>> +
>>   #endif /* CONFIG_SMP */
>>
>>   static unsigned long wakeup_gran(struct sched_entity *se)
>> @@ -7365,6 +7425,8 @@ done: __maybe_unused;
>>          if (new_tasks > 0)
>>                  goto again;
>>
>> +       update_overload_status(rq);
>> +
>>          /*
>>           * rq is about to be idle, check if we need to update the
>>           * lost_idle_time of clock_pelt
>> @@ -11183,6 +11245,7 @@ static void task_tick_fair(struct rq *rq, struct task_struct *curr, int queued)
>>          if (static_branch_unlikely(&sched_numa_balancing))
>>                  task_tick_numa(rq, curr);
>>
>> +       update_overload_status(rq);
>>          update_misfit_status(curr, rq);
>>          update_overutilized_status(task_rq(curr));
> 
> I'd caution about using task_tick and pick_next_task_fair as the
> places we set and clear overload.
> 
> Some issues with task_tick:
> - ticks may be disabled in NO_HZ_FULL (an issue if we define overload
> as > 0 non-idle tasks)
> - most ticks will have the same state, so somewhat redundant checking.
> Could use an edge based trigger instead, such as enqueue/dequeue
> (somewhat similar to rq->rd->overload).

1. In NO_HZ_FULL, given rq is overloaded, say have non-idle task A and
    B enqueued, if A is dequeued before next tick then tick will be off
    and the rq will keep "overloaded" while it's actually not. But this
    doesn't necessarily be a bad thing because this cpu will be skipped
    in wakeup path which helps in improving searching efficiency.

2. Yes, that's why I use rq->overloaded to save the last update state.
    So when the overloaded state doesn't change, what we all do is a
    simple check on a local variable.
    The enqueue/dequeue path is not well bounded, and it could be very
    frequent on short running workloads, which would introduce great
    overhead to update the LLC shared atomic/cpumask.

> 
> With pick_next_task_fair():
> - there's a window between a thread dequeuing, and then scheduler
> running through to the end of pick_next_task_fair(), during which we
> falsely observe the cpu as overloaded
> - this breaks with core scheduling, since we may use pick_task_fair
> rather than pick_next_task_fair

1. I'm afraid I don't understand what the problem is, can you explain
    more on this? Thanks.

2. Nice catch, I will fix it in next update. (Maybe by updating the
    overloaded status in do_idle()?)

Thanks & BR,
Abel
