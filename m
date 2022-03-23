Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 42D974E5342
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 14:37:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244359AbiCWNjD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 09:39:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42448 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241030AbiCWNi4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 09:38:56 -0400
Received: from mail-pl1-x62c.google.com (mail-pl1-x62c.google.com [IPv6:2607:f8b0:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A4CF7D020
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:37:26 -0700 (PDT)
Received: by mail-pl1-x62c.google.com with SMTP id w8so1543868pll.10
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 06:37:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=VfajTc7fN5/QBah8uryBe2x7PpPvgTkjk9FpVMqI2Is=;
        b=X6L7caAs4D6yd3LFy3C0MVgkxhB2lTj6oP3oqntMlIMTMfzQatfRHNg76dn9Zhywgr
         lTN3bw+JS0CpnCaFHZ9ncnFvuiYOjOyk/unztfnWeRNAKPvhKuxfwVdDMhKY0kGG7SQw
         SiDpW9zIrRafwSn2ls4u8/ShuxVUMzjj5bTYrgF36nbsk6fR8TlwlyyquXi7t8C87uUd
         SOgUWHmvpwTSlbh7XXsz/xFB5pvamxbGmVGei2A86copTP2wMAR/llzVqe1v82CsghAN
         HXlpfN4dAQ6Pxmjei6ey8mseQgQbWTSmIwRQH+KgPH0Ur6zj79DenZ8n7mBCpnZJjPVB
         I3TQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=VfajTc7fN5/QBah8uryBe2x7PpPvgTkjk9FpVMqI2Is=;
        b=ZoFsbrNROEDLeSnDSJMtiFtQeLblgMmHMtCO5Y3ocM/56Wu3kYdVIsREVIwwFAU7LM
         GhvxOIf4/BICsddNfGemGO9Mq/XhUwer9OoG3wF8hOkNTHgPRIZGMOo1qjjonUkJwlmF
         rPJoh9oJyVr6qJe29UYIgueD09KWg21rltjOlqw2wELxfa/sTs0jwGQvIywIWGq26W7/
         ssOwOUIx9L/uIUEN1noCl/2EbNUA4Q7+irSb9imAAY1itRSI4E8ofMKlBGhQJAJ0pUkd
         w0LyQzlyQK/YDEoZjOrdz9vCfv2o726bZYIRUg3zk6SCxH3ha4zuxoYIVtIrTaT3Vo/a
         AdDw==
X-Gm-Message-State: AOAM532KduOnRirTLsTbiOJYCgKSE8Ix9mnKVep1rXi74wi3rEm+aT8J
        LsWEowqqdMBMx4HZ6vAjlrxolQ==
X-Google-Smtp-Source: ABdhPJx8aAdnXi3BFxQKrylXbbKyjkCLwLwRVVaqgAGr0C6HjAU/0fl68wSxOvKNF9RIEiMbH/ufuA==
X-Received: by 2002:a17:90b:1d0e:b0:1bf:2a24:2716 with SMTP id on14-20020a17090b1d0e00b001bf2a242716mr11581372pjb.60.1648042645866;
        Wed, 23 Mar 2022 06:37:25 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:1de6:b89c:5d2d:b2d6? ([2409:8a28:e62:3990:1de6:b89c:5d2d:b2d6])
        by smtp.gmail.com with ESMTPSA id o7-20020aa79787000000b004f8e44a02e2sm24747pfp.45.2022.03.23.06.37.22
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 23 Mar 2022 06:37:25 -0700 (PDT)
Message-ID: <c4fea458-b0e1-9842-91ea-5a1c6f7e8387@bytedance.com>
Date:   Wed, 23 Mar 2022 21:37:16 +0800
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
 <f6a46509-a373-5c7a-8694-8eaf0ebc69ab@bytedance.com>
 <20220323131744.GY8939@worktop.programming.kicks-ass.net>
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <20220323131744.GY8939@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022/3/23 9:17 下午, Peter Zijlstra wrote:
> On Wed, Mar 23, 2022 at 09:07:01PM +0800, Chengming Zhou wrote:
>> On 2022/3/23 8:51 下午, Peter Zijlstra wrote:
>>> On Tue, Mar 22, 2022 at 08:08:30PM +0800, Chengming Zhou wrote:
>>>
>>>> diff --git a/kernel/events/core.c b/kernel/events/core.c
>>>> index 8b5cf2aedfe6..848a3bfa9513 100644
>>>> --- a/kernel/events/core.c
>>>> +++ b/kernel/events/core.c
>>>
>>>> @@ -843,11 +845,21 @@ static void perf_cgroup_switch(struct task_struct *task)
>>>>  	 */
>>>>  	local_irq_save(flags);
>>>>  
>>>> +	cgrp = perf_cgroup_from_task(task, NULL);
>>>> +	if (cgrp == __this_cpu_read(cpu_perf_cgroup))
>>>> +		goto out;
> 
> So this compares the cpu thing against the task thing, if matching, we
> bail.
> 
>>>> +
>>>> +	__this_cpu_write(cpu_perf_cgroup, cgrp);
> 
> Then we set cpu thing.
> 
>>>> +
>>>>  	list = this_cpu_ptr(&cgrp_cpuctx_list);
>>>>  	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
>>>>  		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
>>>>  
>>>>  		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>>>> +
>>>> +		if (cpuctx->cgrp == cgrp)
>>>> +			continue;
>>>> +
>>>>  		perf_pmu_disable(cpuctx->ctx.pmu);
>>>>  
>>>>  		cpu_ctx_sched_out(cpuctx, EVENT_ALL);
> 
>>>> +		cpuctx->cgrp = cgrp
> 
> But here we already have exactly the same pattern, we match cpuctx thing
> against task thing and skip/set etc.

Yes, cpu_perf_cgroup is just "cache" which cgrp assigned to cpuctx->cgrp.

> 
>>> Also, I really don't see the point of cpu_perf_cgroup, cpuctx->cgrp
>>> should be able to do this.
>>
>> But the problem is that we have two cpuctx on the percpu list, do you
>> mean we should use perf_cgroup of the first cpuctx to compare with
>> the next task's perf_cgroup ?
>>
>> Or we should delete the cgrp in cpuctx, and use this new percpu cpu_perf_cgroup?
> 
> I'm a bit confused, per the above, you already do exactly what the new
> cpu_perf_cgroup does on the cpuctx->cgrp variable. AFAICT the only think
> the new per-cpu variable does is avoid a lock, howveer:

we have cgrp in cpuctx make me confused at first too.

perf_cgroup_event_enable()
	if (ctx->is_active && !cpuctx->cgrp)
		if ...
			cpuctx->cgrp = cgrp;   -->  set cpuctx->cgrp when enable event

	list_add(&cpuctx->cgrp_cpuctx_entry,
			per_cpu_ptr(&cgrp_cpuctx_list, event->cpu))  --> add cpuctx on percpu list

But we have two (hw and sw) cpuctx, so these two cpuctx->cgrp maybe different...

This is the reason why I want to create a percpu cpu_perf_cgroup,
just "cache" cgrp last scheduled, to compare with next task to decide
whether perf_cgroup_switch() can be skipped.

But you are right, having cpuctx->cgrp and cpu_perf_cgroup make things confused..
maybe we can delete cpuctx->cgrp, change to use percpu cpu_perf_cgroup?

> 
> 
>>> --- a/kernel/events/core.c
>>> +++ b/kernel/events/core.c
>>> @@ -833,6 +833,7 @@ static DEFINE_PER_CPU(struct list_head,
>>>   */
>>>  static void perf_cgroup_switch(struct task_struct *task)
>>>  {
>>> +	struct perf_cgroup *cgrp;
>>>  	struct perf_cpu_context *cpuctx, *tmp;
>>>  	struct list_head *list;
>>>  	unsigned long flags;
>>> @@ -843,11 +844,20 @@ static void perf_cgroup_switch(struct ta
>>>  	 */
>>>  	local_irq_save(flags);
>>>  
>>> +	cgrp = perf_cgroup_from_task(task, NULL);
>>> +
>>>  	list = this_cpu_ptr(&cgrp_cpuctx_list);
>>>  	list_for_each_entry_safe(cpuctx, tmp, list, cgrp_cpuctx_entry) {
>>>  		WARN_ON_ONCE(cpuctx->ctx.nr_cgroups == 0);
>>>  
>>> +		if (READ_ONCE(cpuctx->cgrp == cgrp))
>>> +			continue
> 
> I think we can avoid that by doing an early check, hmm?

perf_cgroup_switch() can be called from context_switch(), or __perf_cgroup_move() from IPI.
Say if in context_switch() already set cpuctx->cgrp to the new task->cgroups, then context_switch()
finish, handle IPI in __perf_cgroup_move(), we don't need to do sched_out/in again.

Thanks.

> 
>>> +
>>>  		perf_ctx_lock(cpuctx, cpuctx->task_ctx);
>>> +
>>> +		if (cpuctx->cgrp == cgrp)
>>> +			goto next;
>>> +
>>>  		perf_pmu_disable(cpuctx->ctx.pmu);
>>>  
>>>  		cpu_ctx_sched_out(cpuctx, EVENT_ALL);
>>> @@ -855,50 +865,22 @@ static void perf_cgroup_switch(struct ta
>>>  		 * must not be done before ctxswout due
>>>  		 * to event_filter_match() in event_sched_out()
>>>  		 */
>>> -		cpuctx->cgrp = perf_cgroup_from_task(task,
>>> -						     &cpuctx->ctx);
>>> +		WRITE_ONCE(cpuctx->cgrp, cgrp);
