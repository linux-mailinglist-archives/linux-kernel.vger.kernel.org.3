Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4B6FF520F5C
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:04:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237725AbiEJIIH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:08:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56712 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230484AbiEJIH7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:07:59 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F63C51E52
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:04:02 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id m12so2332416plb.4
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 01:04:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=FhWfsRbZ98Akrf0aSLVkGfN8ZyYE5vG2KIhUV1/GMow=;
        b=LPxkR4M8ti1ISXPW/OtVTag/V3pT3pW5EjmEDcrAD7mUxvUu4DrQCUUVjSTbA983Vf
         ORsCjPmpyTSaxRqBU3uLLaSehTeTuy36SFHoK3sQhd9B0WOXKGyYanyAf/ls0VNZMWqJ
         TjhIffrZtG7POepa6wM+mCTV/rE0h4nvTaSobNNNZ3TKBUbdroxwPDhNF0NL/LHpBS6F
         3WtGXdbKYQLPpvC/etMn7PiaecPqTA42+MJhbQiOH78OLE3SsXGBE5MUQDjJCuzqESB9
         MBi3VCRCSSHrzFN8M6ChuHb0Fxo+bRiZdLcQJx2A/LRJfKGZ06gfqCdOLg6Usv2xzZeb
         7Bdg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=FhWfsRbZ98Akrf0aSLVkGfN8ZyYE5vG2KIhUV1/GMow=;
        b=wzV/W5SNSkeNkolPBeUrNFQr12zX4kHLtGwP8pO0NoB5iyZ5CeFrQptHvWubC9fAUA
         TqCJWP7JlPouhClPXZttJppWRrQGaVSrGnLnRhTPdkcpaprV7d7HBxp+qc/SAWWlM7QC
         DoijYwd9ird9Z3mTFBmSMf+e4ufGkflXXJ4kPs3KMg31eyWoURnPZvBwOH3K4N/ARPo8
         DsbID+zg468svYtVfS21JDy3wd1MS7VssdK88eAvyaXiHXYuJy1SqXMWVwk4dCgARgd3
         Xlwv/cAJIa+GJaRwnLGGUCK/UFWTc8TEP1VJW89gX48Q7tbK5347ugAbx0SJotZEwto8
         3kjQ==
X-Gm-Message-State: AOAM530zfWFSeKjn66Dx5rMts0QDcmzpHb/oFzfmFlusg5wV1KttV3Ez
        Qgy+KeoyZuPvKIX2eWDT58s44Q==
X-Google-Smtp-Source: ABdhPJw+MDRFI9Jwkuu3Bm3ZmJ34tYF0D8qZDpcogyNCuNu3qJW1m8ZRepUBkTX137Z1tJ6eQBqI1A==
X-Received: by 2002:a17:90b:70a:b0:1d8:5662:6de0 with SMTP id s10-20020a17090b070a00b001d856626de0mr21702431pjz.212.1652169841372;
        Tue, 10 May 2022 01:04:01 -0700 (PDT)
Received: from [10.254.93.206] ([139.177.225.236])
        by smtp.gmail.com with ESMTPSA id m2-20020a170902db0200b0015e8d4eb1d0sm1371765plx.26.2022.05.10.01.03.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 10 May 2022 01:04:01 -0700 (PDT)
Message-ID: <2db9ab21-e1ce-694a-f509-5600f1190d75@bytedance.com>
Date:   Tue, 10 May 2022 16:03:56 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.9.0
Subject: Re: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
Content-Language: en-US
To:     Josh Don <joshdon@google.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Abel Wu <wuyun.abel@bytedance.com>,
        Chen Yu <yu.c.chen@intel.com>
References: <20220505122331.42696-1-wuyun.abel@bytedance.com>
 <CABk29Ns3KBwLXBSwiSe7Pv2YE9iMg+A1kPpPESWG=KNJu9dz0w@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CABk29Ns3KBwLXBSwiSe7Pv2YE9iMg+A1kPpPESWG=KNJu9dz0w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Josh,

On 5/10/22 9:14 AM, Josh Don Wrote:
> Hi Abel,
> 
> Overall this looks good, just a couple of comments.
> 
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index d4bd299d67ab..79b4ff24faee 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6323,7 +6323,9 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>>   static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool has_idle_core, int target)
>>   {
>>          struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
>> -       int i, cpu, idle_cpu = -1, nr = INT_MAX;
>> +       struct sched_domain_shared *sds = sd->shared;
>> +       int nr, nro, weight = sd->span_weight;
>> +       int i, cpu, idle_cpu = -1;
>>          struct rq *this_rq = this_rq();
>>          int this = smp_processor_id();
>>          struct sched_domain *this_sd;
>> @@ -6333,7 +6335,23 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>          if (!this_sd)
>>                  return -1;
>>
>> +       nro = atomic_read(&sds->nr_overloaded_cpus);
>> +       if (nro == weight)
>> +               goto out;
> 
> This assumes that the sd we're operating on here is the LLC domain
> (true for current use). Perhaps to catch future bugs from changing
> this assumption, we could WARN_ON_ONCE(nro > weight).

The @sds comes from sd->shared, so I don't think the condition will
break once we operate at other level domains. But a quick check on
sds != NULL may be needed then since domains can have no sds attached.

> 
>> +
>> +       nr = min_t(int, weight, p->nr_cpus_allowed);
>> +
>> +       /*
>> +        * It's unlikely to find an idle cpu if the system is under
>> +        * heavy pressure, so skip searching to save a few cycles
>> +        * and relieve cache traffic.
>> +        */
>> +       if (weight - nro < (nr >> 4) && !has_idle_core)
>> +               return -1;
> 
> nit: nr / 16 is easier to read and the compiler will do the shifting for you.

Agreed.

> 
> Was < intentional vs <= ? With <= you'll be able to skip the search in
> the case where both sides evaluate to 0 (can happen frequently if we
> have no idle cpus, and a task with a small affinity mask).

It's intentional, the idea is to unconditionally pass when there are
less than 16 cpus to search which seems scalability is not an issue.
But I made a mistake that (weight - nro) couldn't be 0 here, so it's
not appropriate to use "<".

BTW, I think Chen Yu's proposal[1] on search depth limitation is a
better idea and more reasonable. And he is doing some benchmark on
the mixture of our work.

[1] 
https://lore.kernel.org/lkml/20220428182442.659294-1-yu.c.chen@intel.com/

> 
> This will also get a bit confused in the case where the task has many
> cpus allowed, but almost all of them on a different LLC than the one
> we're considering here. Apart from caching the per-LLC
> nr_cpus_allowed, we could instead use cpumask_weight(cpus) below (and
> only do this in the !has_idle_core case to reduce calls to
> cpumask_weight()).

Yes the task might have many cpus allowed on another LLC, the idea is
to use @nr as a worst case boundary. And with Chen's work, I think we
can get rid of nr_cpus_allowed.

> 
>> +
>>          cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> +       if (nro > 1)
>> +               cpumask_andnot(cpus, cpus, sdo_mask(sds));
> 
> Just
> if (nro)
> ?

I think it's just not worthy to touch sdo_mask(sds) which causes heavy
cache traffic, if it only contains one cpu.

> 
>> @@ -6392,6 +6407,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>
>>                  update_avg(&this_sd->avg_scan_cost, time);
>>          }
>> +out:
>> +       if (has_idle_core)
>> +               WRITE_ONCE(sds->has_idle_cores, 0);
> 
> nit: use set_idle_cores() instead (or, if you really want to avoid the
> extra sds dereference, add a __set_idle_cores(sds, val) helper you can
> call directly.

OK, will do.

> 
>> @@ -7904,6 +7922,7 @@ static struct task_struct *detach_one_task(struct lb_env *env)
>>                          continue;
>>
>>                  detach_task(p, env);
>> +               update_overloaded_rq(env->src_rq);
>>
>>                  /*
>>                   * Right now, this is only the second place where
>> @@ -8047,6 +8066,9 @@ static int detach_tasks(struct lb_env *env)
>>                  list_move(&p->se.group_node, tasks);
>>          }
>>
>> +       if (detached)
>> +               update_overloaded_rq(env->src_rq);
>> +
> 
> Thinking about this more, I don't see an issue with moving the
> update_overloaded_rq() calls to enqueue/dequeue_task, rather than here
> in the attach/detach_task paths. Overloaded state only changes when we
> pass the boundary of 2 runnable non-idle tasks, so thashing of the
> overloaded mask is a lot less worrisome than if it were updated on the
> boundary of 1 runnable task. The attach/detach_task paths run as part
> of load balancing, which can be on a millisecond time scale.

It's really hard to say which one is better, and I think it's more like
workload-specific. It's common in our cloud servers that a long running
workload co-exists with a short running workload which could flip the
status frequently.

Thanks & BR,
Abel
