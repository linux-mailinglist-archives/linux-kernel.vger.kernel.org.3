Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C5F851E905
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 19:50:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244094AbiEGRyS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 13:54:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237053AbiEGRyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 13:54:14 -0400
Received: from mail-pj1-x102a.google.com (mail-pj1-x102a.google.com [IPv6:2607:f8b0:4864:20::102a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 11F3F11C13
        for <linux-kernel@vger.kernel.org>; Sat,  7 May 2022 10:50:26 -0700 (PDT)
Received: by mail-pj1-x102a.google.com with SMTP id j8-20020a17090a060800b001cd4fb60dccso9454818pjj.2
        for <linux-kernel@vger.kernel.org>; Sat, 07 May 2022 10:50:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7oVdKWHJGkGiPRnCMxDKVQRYzjMRKg8uhI00/+GApdQ=;
        b=lRLhk2h/w0yQGLjscSUwu2DRV+hEwqCzxI583MqdeACYYvOYIImJ65VymzFTRyg/+R
         XucuhSJOmY8NVzYjEj4WV854v2gpOxI2qVhG/0TC3eHmYPBlZ4r61mESI2rVQLpgWYuE
         w73fsdd8+X0nM9Ok9qlopurbBOxkeW3Vw6bkr6Rhut/eiWxaspGGtEYdTd5sNHz1GA8g
         RGT8S5nuxQi4N5/m2+tJ+QPA+/5hmW2ES0/GSXHkv3G0lsZkAhTsdc/7apAiL128iBrf
         gKALebJ2RMZ/pMXChqMh7fILZMjgxT6AjnRDYUJa5JXI+qQvC9FootUIzFjnnDKLnAMQ
         +Fyg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=7oVdKWHJGkGiPRnCMxDKVQRYzjMRKg8uhI00/+GApdQ=;
        b=DG72TyaYYx6Jumj0tyVrmxIAzoPuyR5SBhMxBQqcWLZVGffnsaAvKFpQbNFxmoOcq8
         HvWhBJkLC4pI634yYmtIwlUMOq00mkMczpecvfuOteaE0KZgf2FoAtwku7SMLkJCQdTL
         C4Ikxe+Cy3x7nqAN2BRJuge9uMGIqOPwwNap45DidB+wlAOqA+hejXambTzDPqmV4JAA
         0KbJmaJy15EdaqMwQUDLbN5Xf3jx1DXxdKEst98L4aD4/MIgzho4ko1k46BRXLnq3Rgx
         bS8YDG+DhwtgO86Yn5cSS1gq4AkNuwm47PbQ03dWELk5kDr2CMvDn0VOZtuJ60flJE7C
         Psog==
X-Gm-Message-State: AOAM530tn9zlQ2WbUDmuvldVTdqVRZo/CpVlv4tgXGVFwxXOhWtb4GbQ
        Bf04dcc0wGV8Zv1Inbtq93wPnA==
X-Google-Smtp-Source: ABdhPJwgoe0izh9OD401TP7thkhiLK+pDOWQm1O4AsCkiCMW8uZCL8ctb/933oUz0LtrErJU1bKphw==
X-Received: by 2002:a17:902:dac1:b0:15e:9faa:e926 with SMTP id q1-20020a170902dac100b0015e9faae926mr8957030plx.61.1651945825491;
        Sat, 07 May 2022 10:50:25 -0700 (PDT)
Received: from [10.254.89.20] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id l7-20020a654c47000000b003c2698d199bsm5488051pgr.25.2022.05.07.10.50.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 07 May 2022 10:50:25 -0700 (PDT)
Message-ID: <53fcde27-7dd2-5150-633b-4e2acc37bb6f@bytedance.com>
Date:   Sun, 8 May 2022 01:50:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.8.1
Subject: Re: [PATCH v3] sched/fair: filter out overloaded cpus in SIS
Content-Language: en-US
To:     Chen Yu <yu.chen.surf@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
References: <20220505122331.42696-1-wuyun.abel@bytedance.com>
 <CADjb_WTRYjSD8z0BCE=u322iJmQVuEq5cUMTZO6ij9V-=ViY-w@mail.gmail.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <CADjb_WTRYjSD8z0BCE=u322iJmQVuEq5cUMTZO6ij9V-=ViY-w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Chen,

On 5/8/22 12:09 AM, Chen Yu Wrote:
>   in
> Hi Abel,
> On Fri, May 6, 2022 at 1:21 AM Abel Wu <wuyun.abel@bytedance.com> wrote:
>>
>> Try to improve searching efficiency of SIS by filtering out the
>> overloaded cpus, and as a result the more overloaded the system
>> is, the less cpus will be searched.
>>
> My understanding is that, this patch aims to address the following issue:
> What kind of CPUs should the SIS  scan.
> And we also have another patch[1]  from another angle:
> How many CPUs should the SIS  scan.
> I assume the two direction could both help speed up the SIS process, so

Agreed.

> I'm curious what the result would be with both patch applied, and I planned
> to run your patch on my system too.
>> The overloaded cpus are tracked through LLC shared domain. To
>> regulate accesses to the shared data, the update happens mainly
>> at the tick. But in order to make it more accurate, we also take
>> the task migrations into consideration during load balancing which
>> can be quite frequent due to short running workload causing newly-
>> idle. Since an overloaded runqueue requires at least 2 non-idle
>> tasks runnable, we could have more faith on the "frequent newly-
>> idle" case.
>>
>> Benchmark
>> =========
>>
>> Tests are done in an Intel(R) Xeon(R) Platinum 8260 CPU@2.40GHz
>> machine with 2 NUMA nodes each of which has 24 cores with SMT2
>> enabled, so 96 CPUs in total.
>>
>> All of the benchmarks are done inside a normal cpu cgroup in a
> Do you have any script that I can leverage to launch the test?

I benchmarked the following configs in mmtests:
	config-scheduler-unbound
	config-scheduler-schbench
	config-network-netperf-stream-unbound
	config-network-tbench

more details: https://github.com/gormanm/mmtests

>> clean environment with cpu turbo disabled.
> I would recommend to apply the following patch(queued for 5.19) if
> the intel_pstate driver is loaded, because it seems that there is a
> utilization calculation
> issue when turbo is disabled:
> 
> diff --git a/drivers/cpufreq/intel_pstate.c b/drivers/cpufreq/intel_pstate.c
> index 846bb3a78788..2216b24b6f84 100644
> --- a/drivers/cpufreq/intel_pstate.c
> +++ b/drivers/cpufreq/intel_pstate.c
> @@ -1322,6 +1322,7 @@ static ssize_t store_no_turbo(struct kobject *a,
> struct kobj_attribute *b,
>    mutex_unlock(&intel_pstate_limits_lock);
> 
>    intel_pstate_update_policies();
> + arch_set_max_freq_ratio(global.no_turbo);
> 
>    mutex_unlock(&intel_pstate_driver_lock);
> 
> --
> 2.25.1
> [cut]

Thanks, I will apply it before next rounds of testing.

>>
>> v3:
>>    - removed sched-idle balance feature and focus on SIS
>>    - take non-CFS tasks into consideration
>>    - several fixes/improvement suggested by Josh Don
>>
>> v2:
>>    - several optimizations on sched-idle balancing
>>    - ignore asym topos in can_migrate_task
>>    - add more benchmarks including SIS efficiency
>>    - re-organize patch as suggested by Mel
>>
>> v1: https://lore.kernel.org/lkml/20220217154403.6497-5-wuyun.abel@bytedance.com/
>> v2: https://lore.kernel.org/lkml/20220409135104.3733193-1-wuyun.abel@bytedance.com/
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   include/linux/sched/topology.h | 12 ++++++++++
>>   kernel/sched/core.c            | 38 ++++++++++++++++++++++++++++++
>>   kernel/sched/fair.c            | 43 +++++++++++++++++++++++++++-------
>>   kernel/sched/idle.c            |  1 +
>>   kernel/sched/sched.h           |  4 ++++
>>   kernel/sched/topology.c        |  4 +++-
>>   6 files changed, 92 insertions(+), 10 deletions(-)
>>
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index 56cffe42abbc..95c7ad1e05b5 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -81,8 +81,20 @@ struct sched_domain_shared {
>>          atomic_t        ref;
>>          atomic_t        nr_busy_cpus;
>>          int             has_idle_cores;
>> +
>> +       /*
>> +        * Tracking of the overloaded cpus can be heavy, so start
>> +        * a new cacheline to avoid false sharing.
>> +        */
> Although we put the following items into different cache line compared to
> above ones, is it possible that there is still cache false sharing if
> CPU1 is reading nr_overloaded_cpus while
> CPU2 is updating overloaded_cpus?

I think it's not false sharing, it's just cache contention. But yes,
it is still possible if the two items mixed with others (by compiler)
in one cacheline, which seems out of our control..

>> +       atomic_t        nr_overloaded_cpus ____cacheline_aligned;
> ____cacheline_aligned seems to put nr_overloaded_cpus into data section, which
> seems to be unnecessary. Would ____cacheline_internodealigned_in_smp
> be more lightweight?

I didn't see the difference of the two macros, it would be appreciate
if you can shed some light.

>> +       unsigned long   overloaded_cpus[]; /* Must be last */
>>   };
>>
> [cut]
>>
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
> In [1] we used util_avg to check if the domain is overloaded and quit
> earlier, since util_avg would be
> more stable and contains historic data. But I think nr_running in your
> patch could be used as
> complementary metric and added to update_idle_cpu_scan() in [1] IMO.
>> +
>>          cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> +       if (nro > 1)
>> +               cpumask_andnot(cpus, cpus, sdo_mask(sds));
> If I understand correctly, this is the core of the optimization: SIS
> filters out the busy cores. I wonder if it
> is possible to save historic h_nr_running/idle_h_nr_running and use
> the average value? (like the calculation
> of avg_scan_cost).

Yes, I have been already working on that for several days, and
along with some improvement on load balance (group_has_spare).
Ideally we can finally get rid out of the cache issues.

> 
>>
>>          if (sched_feat(SIS_PROP) && !has_idle_core) {
>>                  u64 avg_cost, avg_idle, span_avg;
>> @@ -6354,7 +6372,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>                  avg_idle = this_rq->wake_avg_idle;
>>                  avg_cost = this_sd->avg_scan_cost + 1;
>>
>> -               span_avg = sd->span_weight * avg_idle;
>> +               span_avg = weight * avg_idle;
>>                  if (span_avg > 4*avg_cost)
>>                          nr = div_u64(span_avg, avg_cost);
>>                  else
> [cut]
> [1]  https://lore.kernel.org/lkml/20220428182442.659294-1-yu.c.chen@intel.com/
> 

I followed all 3 versions of your patch, and I think your work makes
sense. My only concern was that the depth is updated every llc_size
milliseconds which could be a long period in large machines and the
load can vary quickly enough to deviate from the historic value. But
it seems not a big deal as we discussed in your v1 patch.

Thanks & BR,
Abel
