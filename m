Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E6994C2E86
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 15:37:41 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234909AbiBXOhX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 09:37:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53004 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229478AbiBXOhS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 09:37:18 -0500
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 41D2EDF2A
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:36:47 -0800 (PST)
Received: by mail-pl1-x62f.google.com with SMTP id e13so1877854plh.3
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 06:36:47 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=foEHGISvceeirQWRazzPV0pifLTSmT5usJfyGjpriGQ=;
        b=QDLPWLRRaeQ66cHFHYP5OutKf8qruLs+AQEhs0kJqQzFZ45o/ezLVu/xImsfciORmN
         BV39vBlp2a61IkHGQRZqsgaP9czf0YFNeXQidiUEuzz9oGeFJU3deW/WepUJPD9dqCvU
         IqO/D+5Isk/fBbRLJsxGlMpGz9c+Xtbzc6No6WDzrejH08ayN1PtpygUbRjqc6ygZX7w
         O30kxRs0q4wGkpro2fSJ7ik6/4rZ7XKsvqT3oRYP1H2YfICZqgFOnS7WBt9AzP/stQoX
         wfrtu+26zc82fHb+HsFn8ciEiPNvCcSoVhU8FcRRHPRU5zf0mz6ROoMw2/6UmX5p4LKN
         HxyQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=foEHGISvceeirQWRazzPV0pifLTSmT5usJfyGjpriGQ=;
        b=TCRL7xDKBXwK7kzO/WN86sUWDs8Q2F3bsg3PQaafVTWKfpNGDfL82lzGJz3bbvwaeL
         4embd5kiASXvxmteWiwoqEG8ybTrkQ6P6v7tUeJhU8fYzB0S/UjM5Me50DcFp+kV1jTa
         bMd8XYq8ICZVvLVPa0i5yHIsnmGqmjOcReFHDFgKS+moH2pwa7894EkC0qX4bHIqXgjf
         Yzz2JoiRhqdjKF+b7v1LsEVdCdYZPNFncLzbHpGT4kvoPWc00FlpB9+CJiTksgfaW/Lw
         dU3+VyTP0zjhJ3AGuT6VgjikVickvl9+FjpZNP50VKOZDlqQkFaN5aZ6PAHMSk4i9kqn
         sXRA==
X-Gm-Message-State: AOAM530zsCl/95GidbfS2ADNg/aZc96+11O2lrEJi1e6MDq3F9V0LlOq
        jymjsiCg0BOXzyo3gDicByy66w==
X-Google-Smtp-Source: ABdhPJx3jN+Kv16eWiht1uwBtXYpb4270WKN0dvIQ/Lbnbn7D0kINEWJxRSJrURzpfmuMpVva3SexA==
X-Received: by 2002:a17:902:bb89:b0:14d:85a7:6eea with SMTP id m9-20020a170902bb8900b0014d85a76eeamr3104772pls.158.1645713406690;
        Thu, 24 Feb 2022 06:36:46 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id n37sm3012154pgl.48.2022.02.24.06.36.41
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 24 Feb 2022 06:36:46 -0800 (PST)
Message-ID: <091879a2-c5a0-2512-ce43-ae2efa869f5b@bytedance.com>
Date:   Thu, 24 Feb 2022 22:36:39 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 1/5] sched/fair: record overloaded cpus
Content-Language: en-US
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Ingo Molnar <mingo@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        linux-kernel@vger.kernel.org, srikar@linux.vnet.ibm.com,
        aubrey.li@intel.com, Abel Wu <wuyun.abel@bytedance.com>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <20220217154403.6497-2-wuyun.abel@bytedance.com>
 <YhcvUV/jW7yr0Sn+@BLR-5CG11610CF.amd.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YhcvUV/jW7yr0Sn+@BLR-5CG11610CF.amd.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Gautham, thanks for your comment!

On 2/24/22 3:10 PM, Gautham R. Shenoy wrote:
> Hello Abel,
> 
> (+ Aubrey Li, Srikar)
> 
> On Thu, Feb 17, 2022 at 11:43:57PM +0800, Abel Wu wrote:
>> An CFS runqueue is considered overloaded when there are
>> more than one pullable non-idle tasks on it (since sched-
>> idle cpus are treated as idle cpus). And idle tasks are
>> counted towards rq->cfs.idle_h_nr_running, that is either
>> assigned SCHED_IDLE policy or placed under idle cgroups.
>>
>> The overloaded cfs rqs can cause performance issues to
>> both task types:
>>
>>    - for latency critical tasks like SCHED_NORMAL,
>>      time of waiting in the rq will increase and
>>      result in higher pct99 latency, and
>>
>>    - batch tasks may not be able to make full use
>>      of cpu capacity if sched-idle rq exists, thus
>>      presents poorer throughput.
>>
>> The mask of overloaded cpus is updated in periodic tick
>> and the idle path at the LLC domain basis. This cpumask
>> will also be used in SIS as a filter, improving idle cpu
>> searching.
> 
> This is an interesting approach to minimise the tail latencies by
> keeping track of the overloaded cpus in the LLC so that
> idle/sched-idle CPUs can pull from them. This approach contrasts with the
> following approaches that were previously tried :
> 
> 1. Maintain the idle cpumask at the LLC level by Aubrey Li
>     https://lore.kernel.org/all/1615872606-56087-1-git-send-email-aubrey.li@intel.com/

It's a similar approach from different sight in SIS. Both have pros and
cons, and I couldn't tell which one is more appropriate..
While since SIS can fail in finding one idle cpu due to scaling issues,
the sched-idle load balancing might be a valuable supplement to that to
consume the idle/sched-idle cpus.

>     
> 2. Maintain the identity of the idle core itself at the LLC level, by Srikar :
>     https://lore.kernel.org/lkml/20210513074027.543926-3-srikar@linux.vnet.ibm.com/

The efforts done by Srikar seems focused on idle core searching, which
has a different goal from my approach I think.
The case of short running tasks pointed out by Vincent should not be a
problem in updating the overloaded cpu mask/counter, since they are not
updated either when cpu becomes busy, or when cpu frequently goes idle
during a tick period.

> 
> There have been concerns in the past about having to update the shared
> mask/counter at regular intervals. Srikar, Aubrey any thoughts on this
> ?
> 

I'm afraid I didn't fully catch up with these loops, it is appreciated
if someone can shed some light, thanks!

> 
> 
>>
>> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
>> ---
>>   include/linux/sched/topology.h | 10 ++++++++++
>>   kernel/sched/core.c            |  1 +
>>   kernel/sched/fair.c            | 43 ++++++++++++++++++++++++++++++++++++++++++
>>   kernel/sched/sched.h           |  6 ++++++
>>   kernel/sched/topology.c        |  4 +++-
>>   5 files changed, 63 insertions(+), 1 deletion(-)
>>
>> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
>> index 56cffe42abbc..03c9c81dc886 100644
>> --- a/include/linux/sched/topology.h
>> +++ b/include/linux/sched/topology.h
>> @@ -81,6 +81,16 @@ struct sched_domain_shared {
>>   	atomic_t	ref;
>>   	atomic_t	nr_busy_cpus;
>>   	int		has_idle_cores;
>> +
>> +	/*
>> +	 * The above varibles are used in idle path and
>> +	 * select_task_rq, and the following two are
>> +	 * mainly updated in tick. They are all hot but
>> +	 * for different usage, so start a new cacheline
>> +	 * to avoid false sharing.
>> +	 */
>> +	atomic_t	nr_overloaded	____cacheline_aligned;
>> +	unsigned long	overloaded[];	/* Must be last */
>>   };
>>   
>>   struct sched_domain {
>> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
>> index 1d863d7f6ad7..a6da2998ec49 100644
>> --- a/kernel/sched/core.c
>> +++ b/kernel/sched/core.c
>> @@ -9423,6 +9423,7 @@ void __init sched_init(void)
>>   		rq->wake_stamp = jiffies;
>>   		rq->wake_avg_idle = rq->avg_idle;
>>   		rq->max_idle_balance_cost = sysctl_sched_migration_cost;
>> +		rq->overloaded = 0;
>>   
>>   		INIT_LIST_HEAD(&rq->cfs_tasks);
>>   
>> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
>> index 5c4bfffe8c2c..0a0438c3319b 100644
>> --- a/kernel/sched/fair.c
>> +++ b/kernel/sched/fair.c
>> @@ -6968,6 +6968,46 @@ balance_fair(struct rq *rq, struct task_struct *prev, struct rq_flags *rf)
>>   
>>   	return newidle_balance(rq, rf) != 0;
>>   }
>> +
>> +static inline int cfs_rq_overloaded(struct rq *rq)
>> +{
>> +	return rq->cfs.h_nr_running - rq->cfs.idle_h_nr_running > 1;
>> +}
>> +
>> +/* Must be called with rq locked */
>> +static void update_overload_status(struct rq *rq)
>> +{
>> +	struct sched_domain_shared *sds;
>> +	int overloaded = cfs_rq_overloaded(rq);
>> +	int cpu = cpu_of(rq);
>> +
>> +	lockdep_assert_rq_held(rq);
>> +
>> +	if (rq->overloaded == overloaded)
>> +		return;
>> +
>> +	rcu_read_lock();
>> +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
>> +	if (unlikely(!sds))
>> +		goto unlock;
>> +
>> +	if (overloaded) {
>> +		cpumask_set_cpu(cpu, sdo_mask(sds));
>> +		atomic_inc(&sds->nr_overloaded);
>> +	} else {
>> +		cpumask_clear_cpu(cpu, sdo_mask(sds));
>> +		atomic_dec(&sds->nr_overloaded);
>> +	}
>> +
>> +	rq->overloaded = overloaded;
>> +unlock:
>> +	rcu_read_unlock();
>> +}
>> +
>> +#else
>> +
>> +static inline void update_overload_status(struct rq *rq) { }
>> +
>>   #endif /* CONFIG_SMP */
>>   
>>   static unsigned long wakeup_gran(struct sched_entity *se)
>> @@ -7315,6 +7355,8 @@ done: __maybe_unused;
>>   	if (new_tasks > 0)
>>   		goto again;
>>   
>> +	update_overload_status(rq);
>> +
> 
> So here, we are calling update_overload_status() after
> newidle_balance(). If we had pulled a single task as a part of
> newidle_balance(), in your current code, we do not update the overload
> status. While this should get remedied in the next tick, should we
> move update_overload_status(rq) prior to the new_tasks > 0 check ?

A single task won't change the overloaded status :)
And I think it would be better not do an update even if pulled several
tasks because that would break the rate limit which is undesired.

Best Regards,
	Abel

> 
> 
> --
> Thanks and Regards
> gautham.
