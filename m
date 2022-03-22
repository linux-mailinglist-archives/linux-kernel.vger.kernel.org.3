Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0C95D4E42FA
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:29:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235780AbiCVPaZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:30:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36296 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235044AbiCVPaW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:30:22 -0400
Received: from mail-pl1-x62e.google.com (mail-pl1-x62e.google.com [IPv6:2607:f8b0:4864:20::62e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5EAD28BE05
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:28:55 -0700 (PDT)
Received: by mail-pl1-x62e.google.com with SMTP id w4so15726607ply.13
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:28:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language
         :from:to:cc:references:in-reply-to:content-transfer-encoding;
        bh=rNmQUGUX4iegT4ln3Ho9tZlmybJbnh/sFb9omQweIME=;
        b=QBfZ+OpF6JMIpQazvukmHUlkfuIkFH4DGleUiBUV9YWAkacSyVDvh0pOZ78yoTD8no
         GdWQ2Epf8/4SmiDbEgaMwjwrrUq6fXMxpy+ymUYV9N4L2SLnclk4LPW4VFf2js0ybxp1
         EtoeZlLqaLrYRXc5ZZSjE3EZusMHv8p5AA1TaI0c7brUD9Cc7tZ7eF3jppowcsB+HyMj
         nKZ9HhjfueLYa3egD+k6vOtrlpp/H8ggRthopnFz1H90Pd+khqutGvpfIiua5mBXqm7g
         Q83x6W81Wpmk4Sa7nzPPuk2aofyrD3rqaXO8vZRYxIbRmvCE4ii6/lhn/er/wljlxGgS
         n4fQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:from:to:cc:references:in-reply-to
         :content-transfer-encoding;
        bh=rNmQUGUX4iegT4ln3Ho9tZlmybJbnh/sFb9omQweIME=;
        b=Jxk0Vk00snM8G49RIdK47iZAJvvBwg553mnb6v2gpdq3EwDGABxhVTjUHgtKkd7GvG
         6T9jugwvGuSdKc9cCzsO8KPRQ9O9G5fa4Bz8nz5ZjI8p2x5fYlrtqYhIkjoYXQE8H2QB
         Y5BScEHM4k0U6bSIMLqnVPPSRLQFPwI6j0QpFgppXzwi+C+5+2R1ZA7cbQbu7HO18n4O
         nl+4QDvQ2NFUuRyQHLDKi0ceqmsaKHinwL4K5mOAnZih3slcmpLy0PfKMoC1wyJONE/k
         7S7XX5YUNXXTVxDFoHHQr7foWUpKyAxGDuFCFT38Skp89mKnJFdVdVrgYmQ6F0WxKnuI
         Vm4w==
X-Gm-Message-State: AOAM530ss8MEq/tYh+mPAFL0TaQXN7B7PVBQ7jrN69K03geP0SwEb//9
        NrIvsqRmw2UTRc7zSPpVrqv1ZBZlxdU56w==
X-Google-Smtp-Source: ABdhPJyJh6C78MwL4q2c9liWGTvFzMFdScUIAOg0OrH5sRT1BcKJFOL93R5xBUjWfTmKEXDaQtkv+w==
X-Received: by 2002:a17:902:f64e:b0:14d:20db:8478 with SMTP id m14-20020a170902f64e00b0014d20db8478mr19224608plg.158.1647962934906;
        Tue, 22 Mar 2022 08:28:54 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:a113:6fc:a7b4:4226? ([2409:8a28:e62:3990:a113:6fc:a7b4:4226])
        by smtp.gmail.com with ESMTPSA id om17-20020a17090b3a9100b001bf0fffee9bsm3230338pjb.52.2022.03.22.08.28.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 08:28:54 -0700 (PDT)
Message-ID: <1c9f2383-ec9f-f819-d7be-23aed2bf121a@bytedance.com>
Date:   Tue, 22 Mar 2022 23:28:41 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v2 1/6] perf/core: Fix incosistency between
 cgroup sched_out and sched_in
Content-Language: en-US
From:   Chengming Zhou <zhouchengming@bytedance.com>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, acme@kernel.org, mark.rutland@arm.com,
        alexander.shishkin@linux.intel.com, jolsa@kernel.org,
        namhyung@kernel.org, eranian@google.com,
        linux-perf-users@vger.kernel.org, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, songmuchun@bytedance.com
References: <20220322120834.98637-1-zhouchengming@bytedance.com>
 <20220322120834.98637-2-zhouchengming@bytedance.com>
 <YjnIKCIRV+ePJVCN@hirez.programming.kicks-ass.net>
 <b55676c3-07da-f4f1-e4c8-252cd9d4fac2@bytedance.com>
 <YjnjHPuNjo8YTwiQ@hirez.programming.kicks-ass.net>
 <cdfb252e-9bfc-bee3-7ebe-b8ef401c85dd@bytedance.com>
In-Reply-To: <cdfb252e-9bfc-bee3-7ebe-b8ef401c85dd@bytedance.com>
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

On 2022/3/22 11:16 下午, Chengming Zhou wrote:
> Hi peter,
> 
> On 2022/3/22 10:54 下午, Peter Zijlstra wrote:
>> On Tue, Mar 22, 2022 at 09:38:21PM +0800, Chengming Zhou wrote:
>>> On 2022/3/22 8:59 下午, Peter Zijlstra wrote:
>>>> On Tue, Mar 22, 2022 at 08:08:29PM +0800, Chengming Zhou wrote:
>>>>> There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
>>>>> in perf_cgroup_switch().
>>>>>
>>>>> CPU1					CPU2
>>>>> (in context_switch)			(attach running task)
>>>>> perf_cgroup_sched_out(prev, next)
>>>>> 	cgrp1 == cgrp2 is True
>>>>> 					next->cgroups = cgrp3
>>>>> 					perf_cgroup_attach()
>>>>> perf_cgroup_sched_in(prev, next)
>>>>> 	cgrp1 == cgrp3 is False

I see, you must have been misled by my wrong drawing above ;-)
I'm sorry, perf_cgroup_attach() on the right should be put at the bottom.

CPU1						CPU2
(in context_switch)				(attach running task)
perf_cgroup_sched_out(prev, next)
	cgrp1 == cgrp2 is True
						next->cgroups = cgrp3
perf_cgroup_sched_in(prev, next)
	cgrp1 == cgrp3 is False
						__perf_cgroup_move()

Thanks.

>>>>>
>>>>> The commit a8d757ef076f ("perf events: Fix slow and broken cgroup
>>>>> context switch code") would save cpuctx switch out/in when the
>>>>> perf_cgroup of "prev" and "next" are the same.
>>>>>
>>>>> But perf_cgroup of task can change in concurrent with context_switch.
>>>>
>>>> Can you clarify? IIRC then a task changes cgroup it goes throught the
>>>> whole ->attach() dance, and that serializes against the context switch
>>>> code.
>>>>
>>>
>>> task->cgroups changed before perf_cgroup_attach(), and is not serialized
>>> against the context switch, since task->cgroups can be changed without
>>> rq lock held. (cgroup v1 or cgroup v2 with PSI disabled)
>>>
>>> So perf_cgroup_sched_out() in perf_cgroup_switch() may see the old or
>>> new perf_cgroup when do context switch.
>>
>> __schedule()
>>   local_irq_disable();				<--- IRQ disable
>>   rq_lock();
>>
>>   ...
>>
>>   context_switch()
>>     prepare_task_switch()
>>       perf_event_task_sched_out()
>>         __perf_event_task_sched_out()
>> 	  perf_cgroup_sched_out();
> 
> here compare perf_cgroup_from_task(prev) and perf_cgroup_from_task(next)
> 
>>
>>   switch_to()
>>   finish_task_switch()
>>     perf_event_task_sched_in()
>>       __perf_event_task_sched_in()
>>         perf_cgroup_sched_in();
> 
> here compare perf_cgroup_from_task(prev) and perf_cgroup_from_task(next)
> 
>>     finish_lock_switch()
>>       raw_spin_irq_unlock_irq();		<--- IRQ enable
>>
>>
>> vs
>>
> 
> rcu_assign_pointer(p->cgroups, to)		<--- task perf_cgroup changed
> 
> task->cgroups has changed before sending IPI
> 
>> perf_event_cgrp_subsys.attach = perf_cgroup_attach()
>>   cgroup_taskset_for_each()
>>     task_function_call(task, __perf_cgroup_move) <--- sends IPI
>>
>>
>> Please explain how this can interleave.
> 
> __perf_cgroup_move in IPI is of course serialized against context switch,
> but the task->cgroups has changed before that, without rq lock held.
> So perf_cgroup_from_task() may see the old or new perf_cgroup.
> 
> Thanks.
> 
