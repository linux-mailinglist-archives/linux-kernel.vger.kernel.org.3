Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A8B75592C87
	for <lists+linux-kernel@lfdr.de>; Mon, 15 Aug 2022 12:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232299AbiHOJt0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 15 Aug 2022 05:49:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40776 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232224AbiHOJtX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 15 Aug 2022 05:49:23 -0400
Received: from mail-pl1-x633.google.com (mail-pl1-x633.google.com [IPv6:2607:f8b0:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A8F201EC73
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:49:22 -0700 (PDT)
Received: by mail-pl1-x633.google.com with SMTP id m2so5946120pls.4
        for <linux-kernel@vger.kernel.org>; Mon, 15 Aug 2022 02:49:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :from:to:cc;
        bh=wLoV40q45cqrk1vO6MI/1VSDZblkbuETl72Uww+Qfq8=;
        b=4+RlZbqCBb7mNSHcZTGRG/chCLCiZeqsc+RJyXfZlLjxY0BZNEKYxpU5fF3J/s/Jr0
         jHbLEIC5pFMnoHmnEKGY7dKnGrrkFdBoMfZQudQqd0s+KJhVktZqvH8rXyu5I6GEEMwT
         Q8oQ6ju9MHUJ4neBYv/dJRzFEotDkMEYXGFVvhZCPnLhxLvmbB20yz6q0kJkoiImBjoM
         8GP+ecooLPM5Ban91CDGRHjaiwlRffrJNs76x7JMWTY2CHvWwTqhg9VfWJ8eRd1CosH9
         Hdsjh1ng2m/UrgLUS5LyMeiYYlgMb0wsSFBA1BGJK6w6HUa6Xu5VaAz3xk1gsyiaOtbf
         6ZvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:from:references:cc:to
         :content-language:subject:user-agent:mime-version:date:message-id
         :x-gm-message-state:from:to:cc;
        bh=wLoV40q45cqrk1vO6MI/1VSDZblkbuETl72Uww+Qfq8=;
        b=rlPB/gjNXG7hMBY9kvesnBvDuAXb9o3pDBsvY2575x1c6sllhhOy3Of2c0jfKN6wpb
         RcQar7FWRzxjzLGE7Br0CwkADQ5ER4/VdM1GOOnGiVf3CUc6kRV6gW+tUu5w47jEAxxH
         z7m6OC8mwRdHWiKB9slEw/nBsxXw0Mvt+YNzdF/OwE/W5ivlaK0ELd4riT3/cZisQpsv
         W9XX3gq1hGUcRKmj0043W1fhFXzsBtc12Q+xA2X3sp4Gf2vrSRlNpUfKhJYKbsTwiyDW
         TbpI3iwkmQeW39URn9AL7QYeFCLGcmEj+i7W301tA9VsXtYJNUN4EsGXZ4+bVmrtuDtA
         kbIA==
X-Gm-Message-State: ACgBeo1sT8sZw0zi7Rba8KRFImPhZRu36PbJBZtZQ5DXpxOrbwZMKzaL
        KKvDQnx+8iG3YXta3V7B5dKI/L60cem+a+aY
X-Google-Smtp-Source: AA6agR73lXxjazQyJT8K/DQ6pLIrixcAgVmiexg31bkUCNiC8cjduGjmcwmcROSV97q5jAjVhPLSiA==
X-Received: by 2002:a17:903:2cb:b0:171:4f0d:beb6 with SMTP id s11-20020a17090302cb00b001714f0dbeb6mr16131835plk.53.1660556962163;
        Mon, 15 Aug 2022 02:49:22 -0700 (PDT)
Received: from [10.94.58.189] ([139.177.225.238])
        by smtp.gmail.com with ESMTPSA id e5-20020a170902ed8500b0016dc6279ab8sm6644421plj.159.2022.08.15.02.49.18
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 15 Aug 2022 02:49:21 -0700 (PDT)
Message-ID: <d3c8d1eb-bed3-a5f7-4ff1-a43399c59d8c@bytedance.com>
Date:   Mon, 15 Aug 2022 17:49:17 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.12.0
Subject: Re: [PATCH v4 6/7] sched/fair: skip busy cores in SIS search
Content-Language: en-US
To:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Josh Don <joshdon@google.com>, Chen Yu <yu.c.chen@intel.com>,
        Tim Chen <tim.c.chen@linux.intel.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        linux-kernel@vger.kernel.org
References: <20220619120451.95251-1-wuyun.abel@bytedance.com>
 <20220619120451.95251-7-wuyun.abel@bytedance.com>
 <YtgqRVDIGqCNJAZ6@BLR-5CG11610CF.amd.com>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <YtgqRVDIGqCNJAZ6@BLR-5CG11610CF.amd.com>
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

On 7/21/22 12:16 AM, Gautham R. Shenoy Wrote:
> On Sun, Jun 19, 2022 at 08:04:50PM +0800, Abel Wu wrote:
> 
> [..snip..]
> 
>>   
>> +static void sd_update_icpus(int core, int icpu)
> 
> How about update_llc_icpus() ?

LGTM, will rename.

> 
>> +{
>> +	struct sched_domain_shared *sds;
>> +	struct cpumask *icpus;
>> +
>> +	sds = rcu_dereference(per_cpu(sd_llc_shared, core));
>> +	if (!sds)
>> +		return;
>> +
>> +	icpus = sched_domain_icpus(sds);
>> +
>> +	/*
>> +	 * XXX: The update is racy between different cores.
>> +	 * The non-atomic ops here is a tradeoff of accuracy
>> +	 * for easing the cache traffic.
>> +	 */
>> +	if (icpu == -1)
>> +		cpumask_andnot(icpus, icpus, cpu_smt_mask(core));
>> +	else if (!cpumask_test_cpu(icpu, icpus))
>> +		__cpumask_set_cpu(icpu, icpus);
>> +}
>> +
>>   /*
>>    * Scans the local SMT mask to see if the entire core is idle, and records this
>>    * information in sd_llc_shared->has_idle_cores.
>> @@ -6340,6 +6362,10 @@ static inline bool test_idle_cpus(int cpu)
>>   	return true;
>>   }
>>   
>> +static inline void sd_update_icpus(int core, int icpu)
>> +{
>> +}
>> +
>>   static inline int select_idle_core(struct task_struct *p, int core, struct cpumask *cpus, int *idle_cpu)
>>   {
>>   	return __select_idle_cpu(core, p);
>> @@ -6370,7 +6396,8 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>>   	if (!this_sd)
>>   		return -1;
>>   
>> -	cpumask_and(cpus, sched_domain_span(sd), p->cpus_ptr);
>> +	cpumask_and(cpus, has_idle_core ? sched_domain_span(sd) :
>> +		    sched_domain_icpus(sd->shared), p->cpus_ptr);
> 
> With this we get an idea of the likely idle CPUs. However, we may
> still want SIS_UTIL on top of this as it determines the number of idle
> CPUs to scan based on the utilization average that will iron out any
> transient idle CPUs which may feature in
> sched_domain_icpus(sd->shared) but are not likely to remain idle. Is
> this understanding correct ?
> 

Yes, the sd->shared is not real-time updated so it could contain
false positives. The SIS_UTIL limits the efforts we should pay for
and SIS filter tries to make the efforts more efficient by ironing
out the unlikely idle cpus.

> 
>>   
>>   	if (sched_feat(SIS_PROP) && !has_idle_core) {
>>   		u64 avg_cost, avg_idle, span_avg;
>> @@ -8342,6 +8369,7 @@ struct sd_lb_stats {
>>   	unsigned int prefer_sibling; /* tasks should go to sibling first */
>>   
>>   	int sd_state;
>> +	int idle_cpu;
>>   
>>   	struct sg_lb_stats busiest_stat;/* Statistics of the busiest group */
>>   	struct sg_lb_stats local_stat;	/* Statistics of the local group */
>> @@ -8362,6 +8390,7 @@ static inline void init_sd_lb_stats(struct sd_lb_stats *sds)
>>   		.total_load = 0UL,
>>   		.total_capacity = 0UL,
>>   		.sd_state = sd_is_busy,
>> +		.idle_cpu = -1,
>>   		.busiest_stat = {
>>   			.idle_cpus = UINT_MAX,
>>   			.group_type = group_has_spare,
>> @@ -8702,10 +8731,18 @@ sched_asym(struct lb_env *env, struct sd_lb_stats *sds,  struct sg_lb_stats *sgs
>>   	return sched_asym_prefer(env->dst_cpu, group->asym_prefer_cpu);
>>   }
>>   
>> -static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq)
>> +static inline void sd_classify(struct sd_lb_stats *sds, struct rq *rq, int cpu)
>>   {
>> -	if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq))
>> +	if (sds->sd_state != sd_has_icpus && unoccupied_rq(rq)) {
>> +		/*
>> +		 * Prefer idle cpus than unoccupied ones. This
>> +		 * is achieved by only allowing the idle ones
>> +		 * unconditionally overwrite the preious record
>                                                   ^^^^^^^^
> Nit:						 previous
> 

Will fix.

> 
>> +		 * while the occupied ones can't.
>> +		 */
> 
> This if condition is only executed when we encounter the very first
> unoccupied cpu in the SMT domain. So why do we need this comment here
> about preferring idle cpus over unoccupied ones ?
> 

Agreed, this comment should be removed.

> 
>> +		sds->idle_cpu = cpu;
>>   		sds->sd_state = sd_has_icpus;
>> +	}
>>   }
>>   
>>   /**
>> @@ -8741,7 +8778,7 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>   		sgs->sum_nr_running += nr_running;
>>   
>>   		if (update_core)
>> -			sd_classify(sds, rq);
>> +			sd_classify(sds, rq, i);
>>   
>>   		if (nr_running > 1)
>>   			*sg_status |= SG_OVERLOAD;
>> @@ -8757,7 +8794,16 @@ static inline void update_sg_lb_stats(struct lb_env *env,
>>   		 * No need to call idle_cpu() if nr_running is not 0
>>   		 */
>>   		if (!nr_running && idle_cpu(i)) {
>> +			/*
>> +			 * Prefer the last idle cpu by overwriting
>> +			 * preious one. The first idle cpu in this
>                             ^^^^^^^
> Nit:			   previous

Will fix.

> 
>> +			 * domain (if any) can trigger balancing
>> +			 * and fed with tasks, so we'd better choose
>> +			 * a candidate in an opposite way.
>> +			 */
> 
> This is a better place to call out the fact that an idle cpu is
> preferrable to an unoccupied cpu.
> 
>> +			sds->idle_cpu = i;
>>   			sgs->idle_cpus++;
>> +
>>   			/* Idle cpu can't have misfit task */
>>   			continue;
>>   		}
>> @@ -9273,8 +9319,40 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>>   
>>   static void sd_update_state(struct lb_env *env, struct sd_lb_stats *sds)
>>   {
>> -	if (sds->sd_state == sd_has_icpus && !test_idle_cpus(env->dst_cpu))
>> -		set_idle_cpus(env->dst_cpu, true);
>> +	struct sched_domain_shared *sd_smt_shared = env->sd->shared;
>> +	enum sd_state new = sds->sd_state;
>> +	int this = env->dst_cpu;
>> +
>> +	/*
>> +	 * Parallel updating can hardly contribute accuracy to
>> +	 * the filter, besides it can be one of the burdens on
>> +	 * cache traffic.
>> +	 */
>> +	if (cmpxchg(&sd_smt_shared->updating, 0, 1))
>> +		return;
>> +
>> +	/*
>> +	 * There is at least one unoccupied cpu available, so
>> +	 * propagate it to the filter to avoid false negative
>> +	 * issue which could result in lost tracking of some
>> +	 * idle cpus thus throughupt downgraded.
>> +	 */
>> +	if (new != sd_is_busy) {
>> +		if (!test_idle_cpus(this))
>> +			set_idle_cpus(this, true);
>> +	} else {
>> +		/*
>> +		 * Nothing changes so nothing to update or
>> +		 * propagate.
>> +		 */
>> +		if (sd_smt_shared->state == sd_is_busy)
>> +			goto out;
> 
> 
> The main use of sd_smt_shared->state is to detect the transition
> between sd_has_icpu --> sd_is_busy during which sds->idle_cpu == -1
> which will ensure that sd_update_icpus() below clears this core's CPUs
> from the LLC's icpus mask. Calling this out may be a more useful
> comment instead of the comment above.
> 

The sd_has_icpu --> sd_is_busy transition is just one of them, the
full decision matrix is:

	old		new		decision
	*		has_icpu	update(icpu)
	has_icpu	is_busy		update(-1)
	is_busy		is_busy		-

The comment here corresponds to the hyphen above. Please let me know
if I understood you incorrectly.

Best Regards,
Abel

>   
>> +	}
>> +
>> +	sd_update_icpus(this, sds->idle_cpu);
>> +	sd_smt_shared->state = new;
>> +out:
>> +	xchg(&sd_smt_shared->updating, 0);
>>   }
> 
> 
> --
> Thanks and Regards
> gautham.
