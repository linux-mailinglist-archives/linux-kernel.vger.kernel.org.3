Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7E0D24E52C2
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:07:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244117AbiCWNIp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:08:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51662 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243493AbiCWNIn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:08:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CB6B7A986
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:07:14 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso1721133pjb.5
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:07:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=ZxdFE04CTgkizBkYzCS4GbYVPagKn+7CUxhEqDV8SKc=;
        b=iG+TwB9aEVfEu/ws/wkSBpzFYxAgzAQhtf/EwAdOGeEuUSw0uybKzsA+54AyNd/SkD
         47WWxTi2eMDY5tJw3j9lsA1IJSPETf6CgCtPhm7FamWTfGc4lYleLpOoa5Zx8eRAeR+o
         URguTFXCdgZQ/JUq4HDDGv0iSTfDrpoWbZxtMLEkFt52IQSYAGUsHcMR0c/UhC9BgBqJ
         Um+aMS5GDH7SOROC3RT7jqP5a2FzgKZIwjwavJuAxxpjNwUU+veXjztA8lLZBt6/N/+Z
         7taplPIAlKFy+D+QIzNfVD/Br7ajffq454mdDu3l+S5xBauOatXjh4HjBwoULZzVAeP/
         bJqQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=ZxdFE04CTgkizBkYzCS4GbYVPagKn+7CUxhEqDV8SKc=;
        b=aSBKWz1M5VXcQHtf5Io/g4MzwBSr4IOXLPLaTX/hxYnXmGcd+E9krsXnpoHWJyQF4P
         TnH/e/uupzvTBuuKOIpW7N4rZdvv1an/WXbXmq74W+2YmRa8yleh6TYQhYhl70V2ZO2f
         N1hwGQ1qEkgkstxKVG6Z9g12YbLcb0/ktNv7kN8cXyZtJ1do5/SAdX+qne/FI9IP3CEM
         6cxuc2Ys3NLrzoZTuI/RvHsLCCsXy4dwEaEjIM+dRpzj9V9fxcN6fo0wTojGq8HoNWVU
         ofR7FPXwg38qMzyyqM8//DeNw8Evk3FaV3FUk0K7q2n/8m9VBS8w7x7UnkGiw4oARqKy
         YzBQ==
X-Gm-Message-State: AOAM532XOikM/xEApweU5JJpyvnTTDqsWHhlSe6pPs7pHx35ilVk+mft
        TB8jduhb2mzW+Z5lNooB/tMiAw==
X-Google-Smtp-Source: ABdhPJzr+vPKF/Xud3CsLzZb9/OKzypa6peSNxe6Jd7Hs+yFnQYrokAGJe5/DpQ7OJJ83RtHDPFGxg==
X-Received: by 2002:a17:90b:3b8c:b0:1c6:ed78:67e2 with SMTP id pc12-20020a17090b3b8c00b001c6ed7867e2mr11530730pjb.163.1648040833488;
        Wed, 23 Mar 2022 06:07:13 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:1de6:b89c:5d2d:b2d6? ([2409:8a28:e62:3990:1de6:b89c:5d2d:b2d6])
        by smtp.gmail.com with ESMTPSA id x23-20020a63fe57000000b0036490068f12sm19376483pgj.90.2022.03.23.06.07.07
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 06:07:13 -0700 (PDT)
Message-ID: <f6a46509-a373-5c7a-8694-8eaf0ebc69ab@bytedance.com>
Date:   Wed, 23 Mar 2022 21:07:01 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v2 2/6] perf/core: Introduce percpu
 perf_cgroup
Content-Language: en-US
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-3-zhouchengming@bytedance.com>
 <20220323125116.GX8939@worktop.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220323125116.GX8939@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/23 8:51 下午, Peter Zijlstra wrote:
> On Tue, Mar 22, 2022 at 08:08:30PM +0800, Chengming Zhou wrote:
> 
>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>> index 8b5cf2aedfe6..848a3bfa9513 100644
>> --- a/kernel/events/core.c
>> +++ b/kernel/events/core.c
> 
>> @@ -843,11 +845,21 @@ static void perf_cgroup_switch(struct task_struct *task)
>>  	 */
>>  	local_irq_save(flags);
>>  
>> +	cgrp = perf_cgroup_from_task(task, NULL);
>> +	if (cgrp == __this_cpu_read(cpu_perf_cgroup))
>> +		goto out;
>> +
>> +	__this_cpu_write(cpu_perf_cgroup, cgrp);
>> +
>>  	list = this_cpu_ptr(&cgrp_cpuctx_list);
>>  	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
>>  		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
>>  
>>  		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>> +
>> +		if (cpuctx->cgrp == cgrp)
>> +			continue;
>> +
>>  		perf_pmu_disable(cpuctx->ctx.pmu);
>>  
>>  		cpu_ctx_sched_out(cpuctx, EVENT_ALL);
> 
> This is just straight up broken.. you can't continue after taking a
> lock, that'll miss unlock.

Yes, Namhyung has pointed it out, I will fix it next version.

> 
> Also, I really don't see the point of cpu_perf_cgroup, cpuctx->cgrp
> should be able to do this.

But the problem is that we have two cpuctx on the percpu list, do you
mean we should use perf_cgroup of the first cpuctx to compare with
the next task's perf_cgroup ?

Or we should delete the cgrp in cpuctx, and use this new percpu cpu_perf_cgroup?

> 
> Also, perhaps merge this in the previous patch, I'm not sure it makes
> sense to split this.

Ok, will do. I put it in one patch in v1 RFC, then split it for easier review.
I will put it together in the next version.

Thanks.

> 
> --- a/kernel/events/core.c
> +++ b/kernel/events/core.c
> @@ -833,6 +833,7 @@ static DEFINE_PER_CPU(struct list_head,
>   */
>  static void perf_cgroup_switch(struct task_struct *task)
>  {
> +	struct perf_cgroup *cgrp;
>  	struct perf_cpu_context *cpuctx, *tmp;
>  	struct list_head *list;
>  	unsigned long flags;
> @@ -843,11 +844,20 @@ static void perf_cgroup_switch(struct ta
>  	 */
>  	local_irq_save(flags);
>  
> +	cgrp = perf_cgroup_from_task(task, NULL);
> +
>  	list = this_cpu_ptr(&cgrp_cpuctx_list);
>  	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
>  		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
>  
> +		if (READ_ONCE(cpuctx->cgrp == cgrp))
> +			continue
> +
>  		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
> +
> +		if (cpuctx->cgrp == cgrp)
> +			goto next;
> +
>  		perf_pmu_disable(cpuctx->ctx.pmu);
>  
>  		cpu_ctx_sched_out(cpuctx, EVENT_ALL);
> @@ -855,50 +865,22 @@ static void perf_cgroup_switch(struct ta
>  		 * must not be done before ctxswout due
>  		 * to event_filter_match() in event_sched_out()
>  		 */
> -		cpuctx->cgrp = perf_cgroup_from_task(task,
> -						     &cpuctx->ctx);
> +		WRITE_ONCE(cpuctx->cgrp, cgrp);
>  		/*
>  		 * set cgrp before ctxsw in to allow
>  		 * event_filter_match() to not have to pass
>  		 * task around
> -		 * we pass the cpuctx->ctx to perf_cgroup_from_task()
> -		 * because cgroup events are only per-cpu
>  		 */
>  		cpu_ctx_sched_in(cpuctx, EVENT_ALL, task);
>  
>  		perf_pmu_enable(cpuctx->ctx.pmu);
> +next:
>  		perf_ctx_unlock(cpuctx, cpuctx->task_ctx);
>  	}
>  
>  	local_irq_restore(flags);
>  }
>  
> -static inline void perf_cgroup_sched_switch(struct task_struct *task,
> -					    struct task_struct *next)
> -{
> -	struct perf_cgroup *cgrp1;
> -	struct perf_cgroup *cgrp2 = NULL;
> -
> -	rcu_read_lock();
> -	/*
> -	 * we come here when we know perf_cgroup_events > 0
> -	 * we do not need to pass the ctx here because we know
> -	 * we are holding the rcu lock
> -	 */
> -	cgrp1 = perf_cgroup_from_task(task, NULL);
> -	cgrp2 = perf_cgroup_from_task(next, NULL);
> -
> -	/*
> -	 * only schedule out current cgroup events if we know
> -	 * that we are switching to a different cgroup. Otherwise,
> -	 * do no touch the cgroup events.
> -	 */
> -	if (cgrp1 != cgrp2)
> -		perf_cgroup_switch(task);
> -
> -	rcu_read_unlock();
> -}
> -
>  static int perf_cgroup_ensure_storage(struct perf_event *event,
>  				struct cgroup_subsys_state *css)
>  {
> @@ -1062,11 +1044,6 @@ static inline void update_cgrp_time_from
>  {
>  }
>  
> -static inline void perf_cgroup_sched_switch(struct task_struct *task,
> -					    struct task_struct *next)
> -{
> -}
> -
>  static inline int perf_cgroup_connect(pid_t pid, struct perf_event *event,
>  				      struct perf_event_attr *attr,
>  				      struct perf_event *group_leader)
> @@ -1080,11 +1057,6 @@ perf_cgroup_set_timestamp(struct task_st
>  {
>  }
>  
> -static inline void
> -perf_cgroup_sched_switch(struct task_struct *task, struct task_struct *next)
> -{
> -}
> -
>  static inline u64 perf_cgroup_event_time(struct perf_event *event)
>  {
>  	return 0;
> @@ -1104,6 +1076,10 @@ static inline void
>  perf_cgroup_event_disable(struct perf_event *event, struct perf_event_context *ctx)
>  {
>  }
> +
> +static void perf_cgroup_switch(struct task_struct *task)
> +{
> +}
>  #endif
>  
>  /*
> @@ -3625,7 +3601,7 @@ void __perf_event_task_sched_out(struct
>  	 * cgroup event are system-wide mode only
>  	 */
>  	if (atomic_read(this_cpu_ptr(&perf_cgroup_events)))
> -		perf_cgroup_sched_switch(task, next);
> +		perf_cgroup_switch(next);
>  }
>  
>  /*
