Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2CB756CA71
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Jul 2022 17:56:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229560AbiGIP43 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Jul 2022 11:56:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41842 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229476AbiGIP41 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Jul 2022 11:56:27 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4E7510FF4
        for <linux-kernel@vger.kernel.org>; Sat,  9 Jul 2022 08:56:25 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id 73so1320346pgb.10
        for <linux-kernel@vger.kernel.org>; Sat, 09 Jul 2022 08:56:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=v75XOyTLSckyG3EUmtMq3p1CnPDISrMGaAQwNA83vOg=;
        b=l3jobFtSt6KSP2y878vHn7VX61rJUNftTWZ17ysl1oauidwHhFLE6OqcpECJhO6Scj
         l4eKQ3GWFOscNbfuRXTGBXYveF4GSLslptDbhwLac2GykaN9XvX2mKJPdhLbaTT8j2ep
         G+Q4A6K+dXR34QWRAp84Xe7M7trEiV/HM0U0xXXZji10MW7mcHzBeTIyEALm8CVQ1JL1
         jZbqUhrTCEr5ujBuy9AHOXp1fqW8vAptCP2I5zWgIqsMkT3yytsIS96Tz7vl17s7U2AF
         H0hCo3N9u0otqrX94rqqejY222lj/T6sRMefYexwKUa5Msl+GBY0srqP5/IEszF02BWy
         5lDQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=v75XOyTLSckyG3EUmtMq3p1CnPDISrMGaAQwNA83vOg=;
        b=lL0BtbXc7+qgbkQDGk6xGYoCKXkeHiYT/+wkJmyFEcXpEMzznVC83sOfCKXvqhtQw3
         nRV2NQlcSk9RSAXkbEpLdcxiNSh5J+u2ChQ9IQqCJU5fL1jgXN3/Q2YQwwLnVOxiTtNV
         wBvhPTZH+cil4PvOSY5gT/WCW/m2wZpzJ/58fM9YJoYWC1VhXfE32wnTcLNp6aGjrYS0
         P89Ok+hZms9I75Szje4S6Ct+rTq4gq3RgGwDovHHR3s3SY/SXHZKLlgqkLb3jOSlUMvr
         y7Dhb7JqYfi+9gDHIEWrKUBf05ZZZZp0Lxn0xOwmM5pY+Kls/v6Xci5fSfn/WBFDjGss
         9oZA==
X-Gm-Message-State: AJIora9jUzFzt4Q9oxY4Tmndq7TlL+sPiuUrqUfouoyFyuHhvzztwM90
        mTMDt7ipItBNFSioo5TRU+Q5/A==
X-Google-Smtp-Source: AGRyM1segbE6dr/Irmc/cSfGZpmi03T3hdviYQ+GHU28StcGfdMMbZt7twbRVC+2zi1KrGX7x/cDlw==
X-Received: by 2002:a63:5c5e:0:b0:412:a2f1:d0dd with SMTP id n30-20020a635c5e000000b00412a2f1d0ddmr8368396pgm.251.1657382185326;
        Sat, 09 Jul 2022 08:56:25 -0700 (PDT)
Received: from [10.4.101.155] ([139.177.225.237])
        by smtp.gmail.com with ESMTPSA id u13-20020a170903124d00b0016b82ff707asm1502693plh.79.2022.07.09.08.56.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 09 Jul 2022 08:56:24 -0700 (PDT)
Message-ID: <f3e2d5ad-52c7-e2c4-84c1-c26ee633bd6d@bytedance.com>
Date:   Sat, 9 Jul 2022 23:56:19 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.11.0
Subject: Re: [PATCH v4 6/7] sched/fair: skip busy cores in SIS search
Content-Language: en-US
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        "Gautham R . Shenoy" <gautham.shenoy@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-7-wuyun.abel@bytedance.com>
 <20220621181442.GA37168@chenyu5-mobl1>
 <543d55e1-fad8-3df3-8bae-d79c0c8d8340@bytedance.com>
 <20220624033032.GA14945@chenyu5-mobl1>
 <3e4d2594-f678-b77a-4883-0b893daf19f6@bytedance.com>
 <2d18453d-9c9b-b57b-1616-d4a9229abd5a@bytedance.com>
 <20220630041645.GA9253@chenyu5-mobl1>
 <a72bf17e-f633-87e1-1166-6a4bff122500@bytedance.com>
 <20220709085519.GA13764@chenyu5-mobl1>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220709085519.GA13764@chenyu5-mobl1>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 7/9/22 4:55 PM, Chen Yu Wrote:
> On Thu, Jun 30, 2022 at 06:46:08PM +0800, Abel Wu wrote:
>>
>> On 6/30/22 12:16 PM, Chen Yu Wrote:
>>> On Tue, Jun 28, 2022 at 03:58:55PM +0800, Abel Wu wrote:
>>>>
>>>> On 6/27/22 6:13 PM, Abel Wu Wrote:
>>>> There seems like not much difference except hackbench pipe test at
>>>> certain groups (30~110).
>>> OK, smaller LLC domain seems to not have much difference, which might
>>> suggest that by leveraging load balance code path, the read/write
>>> to LLC shared mask might not be the bottleneck. I have an vague
>>> impression that during Aubrey's cpumask searching for idle CPUs
>>> work[1], there is concern that updating the shared mask in large LLC
>>> has introduced cache contention and performance degrading. Maybe we
>>> can find that regressed test case to verify.
>>> [1] https://lore.kernel.org/all/1615872606-56087-1-git-send-email-aubrey.li@intel.com/
>>
>> I just went through Aubrey's v1-v11 patches and didn't find any
>> particular tests other than hackbench/tbench/uperf. Please let
>> me know if I missed something, thanks!
>>
> I haven't found any testcase that could trigger the cache contention
> issue. I thought we could stick with these testcases for now, especially
> for tbench, it has detected a cache issue described in
> https://lore.kernel.org/lkml/e000b124-afd4-28e1-fde2-393b0e38ce19@amd.com
> if I understand correctly.

I Agree.

>>>> I am intended to provide better scalability
>>>> by applying the filter which will be enabled when:
>>>>
>>>>     - The LLC is large enough that simply traversing becomes
>>>>       in-sufficient, and/or
>>>>
>>>>     - The LLC is loaded that unoccupied cpus are minority.
>>>>
>>>> But it would be very nice if a more fine grained pattern works well
>>>> so we can drop the above constrains.
>>>>
>>> We can first try to push a simple version, and later optimize it.
>>> One concern about v4 is that, we changed the logic in v3, which recorded
>>> the overloaded CPU, while v4 tracks unoccupied CPUs. An overloaded CPU is
>>> more "stable" because there are more than 1 running tasks on that runqueue.
>>> It is more likely to remain "occupied" for a while. That is to say,
>>> nr_task = 1, 2, 3... will all be regarded as occupied, while only nr_task = 0
>>> is unoccupied. The former would bring less false negative/positive.
>>
>> Yes, I like the 'overloaded mask' too, but the downside is extra
>> cpumask ops needed in the SIS path (the added cpumask_andnot).
>> Besides, in this patch, the 'overloaded mask' is also unstable due
>> to the state is maintained at core level rather than per-cpu, some
>> more thoughts are in cover letter.
>>
> I see.
>>>
>>> By far I have tested hackbench/schbench/netperf on top of Peter's sched/core branch,
>>> with SIS_UTIL enabled. Overall it looks good, and netperf has especially
>>> significant improvement when the load approaches overloaded(which is aligned
>>> with your comment above). I'll re-run the netperf for several cycles to check the
>>> standard deviation. And I'm also curious about v3's performance because it
>>> tracks overloaded CPUs, so I'll also test on v3 with small modifications.
>>
>> Thanks very much for your reviewing and testing.
>>
> I modified your v3 patch a little bit, and the test result shows good improvement
> on netperf and no significant regression on schbench/tbench/hackbench on this draft

I don't know why there is such a big improvement in netperf TCP_RR
168-threads while results under other configs are plain.

> patch. I would like to vote for your v3 version as it seems to be more straightforward,
> what do you think of the following change:
> 
>  From 277b60b7cd055d5be93188a552da50fdfe53214c Mon Sep 17 00:00:00 2001
> From: Abel Wu <wuyun.abel@bytedance.com>
> Date: Fri, 8 Jul 2022 02:16:47 +0800
> Subject: [PATCH] sched/fair: Introduce SIS_FILTER to skip overloaded CPUs
>   during SIS
> 
> Currently SIS_UTIL is used to limit the scan depth of idle CPUs in
> select_idle_cpu(). There could be another optimization to filter
> the overloaded CPUs so as to further speed up select_idle_cpu().
> Launch the CPU overload check in periodic tick, and take consideration
> of nr_running, avg_util and runnable_avg of that CPU. If the CPU is
> overloaded, add it into per LLC overload cpumask, so select_idle_cpu()
> could skip those overloaded CPUs. Although this detection is in periodic
> tick, checking the pelt signal of the CPU would make the 'overloaded' state
> more stable and reduce the frequency to update the LLC shared mask,
> so as to mitigate the cache contention in the LLC.
> 
> The following results are tested on top of latest sched/core tip.
> The baseline is with SIS_UTIL enabled, and compared it with both SIS_FILTER
> /SIS_UTIL enabled. Positive %compare stands for better performance.

Can you share the cpu topology please?

> 
> hackbench
> =========
> case            	load    	baseline(std%)	compare%( std%)
> process-pipe    	1 group 	 1.00 (  0.59)	 -1.35 (  0.88)
> process-pipe    	2 groups 	 1.00 (  0.38)	 -1.49 (  0.04)
> process-pipe    	4 groups 	 1.00 (  0.45)	 +0.10 (  0.91)
> process-pipe    	8 groups 	 1.00 (  0.11)	 +0.03 (  0.38)
> process-sockets 	1 group 	 1.00 (  3.48)	 +2.88 (  7.07)
> process-sockets 	2 groups 	 1.00 (  2.38)	 -3.78 (  2.81)
> process-sockets 	4 groups 	 1.00 (  0.26)	 -1.79 (  0.82)
> process-sockets 	8 groups 	 1.00 (  0.07)	 -0.35 (  0.07)
> threads-pipe    	1 group 	 1.00 (  0.87)	 -0.21 (  0.71)
> threads-pipe    	2 groups 	 1.00 (  0.63)	 +0.34 (  0.45)
> threads-pipe    	4 groups 	 1.00 (  0.18)	 -0.02 (  0.50)
> threads-pipe    	8 groups 	 1.00 (  0.08)	 +0.46 (  0.05)
> threads-sockets 	1 group 	 1.00 (  0.80)	 -0.08 (  1.06)
> threads-sockets 	2 groups 	 1.00 (  0.55)	 +0.06 (  0.85)
> threads-sockets 	4 groups 	 1.00 (  1.00)	 -2.13 (  0.18)
> threads-sockets 	8 groups 	 1.00 (  0.07)	 -0.41 (  0.08)
> 
> netperf
> =======
> case            	load    	baseline(std%)	compare%( std%)
> TCP_RR          	28 threads	 1.00 (  0.50)	 +0.19 (  0.53)
> TCP_RR          	56 threads	 1.00 (  0.33)	 +0.31 (  0.35)
> TCP_RR          	84 threads	 1.00 (  0.23)	 +0.15 (  0.28)
> TCP_RR          	112 threads	 1.00 (  0.20)	 +0.03 (  0.21)
> TCP_RR          	140 threads	 1.00 (  0.17)	 +0.20 (  0.18)
> TCP_RR          	168 threads	 1.00 (  0.17)	+112.84 ( 40.35)
> TCP_RR          	196 threads	 1.00 ( 16.66)	 +0.39 ( 15.72)
> TCP_RR          	224 threads	 1.00 ( 10.28)	 +0.05 (  9.97)
> UDP_RR          	28 threads	 1.00 ( 16.15)	 -0.13 (  0.93)
> UDP_RR          	56 threads	 1.00 (  7.76)	 +1.24 (  0.44)
> UDP_RR          	84 threads	 1.00 ( 11.68)	 -0.49 (  6.33)
> UDP_RR          	112 threads	 1.00 (  8.49)	 -0.21 (  7.77)
> UDP_RR          	140 threads	 1.00 (  8.49)	 +2.05 ( 19.88)
> UDP_RR          	168 threads	 1.00 (  8.91)	 +1.67 ( 11.74)
> UDP_RR          	196 threads	 1.00 ( 19.96)	 +4.35 ( 21.37)
> UDP_RR          	224 threads	 1.00 ( 19.44)	 +4.38 ( 16.61)
> 
> tbench
> ======
> case            	load    	baseline(std%)	compare%( std%)
> loopback        	28 threads	 1.00 (  0.12)	 +0.57 (  0.12)
> loopback        	56 threads	 1.00 (  0.11)	 +0.42 (  0.11)
> loopback        	84 threads	 1.00 (  0.09)	 +0.71 (  0.03)
> loopback        	112 threads	 1.00 (  0.03)	 -0.13 (  0.08)
> loopback        	140 threads	 1.00 (  0.29)	 +0.59 (  0.01)
> loopback        	168 threads	 1.00 (  0.01)	 +0.86 (  0.03)
> loopback        	196 threads	 1.00 (  0.02)	 +0.97 (  0.21)
> loopback        	224 threads	 1.00 (  0.04)	 +0.83 (  0.22)
> 
> schbench
> ========
> case            	load    	baseline(std%)	compare%( std%)
> normal          	1 mthread	 1.00 (  0.00)	 -8.82 (  0.00)
> normal          	2 mthreads	 1.00 (  0.00)	 +0.00 (  0.00)
> normal          	4 mthreads	 1.00 (  0.00)	+17.02 (  0.00)
> normal          	8 mthreads	 1.00 (  0.00)	 -4.84 (  0.00)
> 
> Signed-off-by: Abel Wu <wuyun.abel@bytedance.com>
> ---
>   include/linux/sched/topology.h |  6 +++++
>   kernel/sched/core.c            |  1 +
>   kernel/sched/fair.c            | 47 ++++++++++++++++++++++++++++++++++
>   kernel/sched/features.h        |  1 +
>   kernel/sched/sched.h           |  2 ++
>   kernel/sched/topology.c        |  3 ++-
>   6 files changed, 59 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index 816df6cc444e..c03076850a67 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -82,8 +82,14 @@ struct sched_domain_shared {
>   	atomic_t	nr_busy_cpus;
>   	int		has_idle_cores;
>   	int		nr_idle_scan;
> +	unsigned long	overloaded_cpus[];
>   };
>   
> +static inline struct cpumask *sdo_mask(struct sched_domain_shared *sds)
> +{
> +	return to_cpumask(sds->overloaded_cpus);
> +}
> +
>   struct sched_domain {
>   	/* These fields must be setup */
>   	struct sched_domain __rcu *parent;	/* top domain must be null terminated */
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index d3e2c5a7c1b7..452eb63ee6f6 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -5395,6 +5395,7 @@ void scheduler_tick(void)
>   		resched_latency = cpu_resched_latency(rq);
>   	calc_global_load_tick(rq);
>   	sched_core_tick(rq);
> +	update_overloaded_rq(rq);

I didn't see this update in idle path. Is this on your intend?

>   
>   	rq_unlock(rq, &rf);
>   
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index f80ae86bb404..34b1650f85f6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6323,6 +6323,50 @@ static inline int select_idle_smt(struct task_struct *p, struct sched_domain *sd
>   
>   #endif /* CONFIG_SCHED_SMT */
>   
> +/* derived from group_is_overloaded() */
> +static inline bool rq_overloaded(struct rq *rq, int cpu, unsigned int imbalance_pct)
> +{
> +	if (rq->nr_running - rq->cfs.idle_h_nr_running <= 1)
> +		return false;
> +
> +	if ((SCHED_CAPACITY_SCALE * 100) <
> +			(cpu_util_cfs(cpu) * imbalance_pct))
> +		return true;
> +
> +	if ((SCHED_CAPACITY_SCALE * imbalance_pct) <
> +			(cpu_runnable(rq) * 100))
> +		return true;

So the filter contains cpus that over-utilized or overloaded now.
This steps further to make the filter reliable while at the cost
of sacrificing scan efficiency.

The idea behind my recent patches is to keep the filter radical,
but use it conservatively.

> +
> +	return false;
> +}
> +
> +void update_overloaded_rq(struct rq *rq)
> +{
> +	struct sched_domain_shared *sds;
> +	struct sched_domain *sd;
> +	int cpu;
> +
> +	if (!sched_feat(SIS_FILTER))
> +		return;
> +
> +	cpu = cpu_of(rq);
> +	sd = rcu_dereference(per_cpu(sd_llc, cpu));
> +	if (unlikely(!sd))
> +		return;
> +
> +	sds = rcu_dereference(per_cpu(sd_llc_shared, cpu));
> +	if (unlikely(!sds))
> +		return;
> +
> +	if (rq_overloaded(rq, cpu, sd->imbalance_pct)) {

I'm not sure whether it is appropriate to use LLC imbalance pct here,
because we are comparing inside the LLC rather than between the LLCs.

> +		/* avoid duplicated write, mitigate cache contention */
> +		if (!cpumask_test_cpu(cpu, sdo_mask(sds)))
> +			cpumask_set_cpu(cpu, sdo_mask(sds));
> +	} else {
> +		if (cpumask_test_cpu(cpu, sdo_mask(sds)))
> +			cpumask_clear_cpu(cpu, sdo_mask(sds));
> +	}
> +}
>   /*
>    * Scan the LLC domain for idle CPUs; this is dynamically regulated by
>    * comparing the average scan cost (tracked in sd->avg_scan_cost) against the
> @@ -6383,6 +6427,9 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>   		}
>   	}
>   
> +	if (sched_feat(SIS_FILTER) && !has_idle_core && sd->shared)
> +		cpumask_andnot(cpus, cpus, sdo_mask(sd->shared));
> +
>   	for_each_cpu_wrap(cpu, cpus, target + 1) {
>   		if (has_idle_core) {
>   			i = select_idle_core(p, cpu, cpus, &idle_cpu);
> diff --git a/kernel/sched/features.h b/kernel/sched/features.h
> index ee7f23c76bd3..1bebdb87c2f4 100644
> --- a/kernel/sched/features.h
> +++ b/kernel/sched/features.h
> @@ -62,6 +62,7 @@ SCHED_FEAT(TTWU_QUEUE, true)
>    */
>   SCHED_FEAT(SIS_PROP, false)
>   SCHED_FEAT(SIS_UTIL, true)
> +SCHED_FEAT(SIS_FILTER, true)

The filter should be enabled when there is a need. If the system
is idle enough, I don't think it's a good idea to clear out the
overloaded cpus from domain scan. Making the filter a sched-feat
won't help the problem.

My latest patch will only apply the filter when nr is less than
the LLC size. It doesn't work perfectly yet, but really better
than doing nothing in my v4 patchset.


I will give this patch a test on my machine a few days later.

Thanks & BR,
Abel

>   
>   /*
>    * Issue a WARN when we do multiple update_rq_clock() calls
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 02c970501295..316127ab1ec7 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1812,6 +1812,8 @@ static inline struct cpumask *group_balance_mask(struct sched_group *sg)
>   
>   extern int group_balance_cpu(struct sched_group *sg);
>   
> +void update_overloaded_rq(struct rq *rq);
> +
>   #ifdef CONFIG_SCHED_DEBUG
>   void update_sched_domain_debugfs(void);
>   void dirty_sched_domain_sysctl(int cpu);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index 8739c2a5a54e..0d149e76a3b3 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -1641,6 +1641,7 @@ sd_init(struct sched_domain_topology_level *tl,
>   		sd->shared = *per_cpu_ptr(sdd->sds, sd_id);
>   		atomic_inc(&sd->shared->ref);
>   		atomic_set(&sd->shared->nr_busy_cpus, sd_weight);
> +		cpumask_clear(sdo_mask(sd->shared));
>   	}
>   
>   	sd->private = sdd;
> @@ -2106,7 +2107,7 @@ static int __sdt_alloc(const struct cpumask *cpu_map)
>   
>   			*per_cpu_ptr(sdd->sd, j) = sd;
>   
> -			sds = kzalloc_node(sizeof(struct sched_domain_shared),
> +			sds = kzalloc_node(sizeof(struct sched_domain_shared) + cpumask_size(),
>   					GFP_KERNEL, cpu_to_node(j));
>   			if (!sds)
>   				return -ENOMEM;
