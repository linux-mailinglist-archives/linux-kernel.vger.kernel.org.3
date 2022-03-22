Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1AEE74E429F
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 16:16:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238360AbiCVPSP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 22 Mar 2022 11:18:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238362AbiCVPSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 22 Mar 2022 11:18:10 -0400
Received: from mail-pj1-x1032.google.com (mail-pj1-x1032.google.com [IPv6:2607:f8b0:4864:20::1032])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F215D88783
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:16:41 -0700 (PDT)
Received: by mail-pj1-x1032.google.com with SMTP id bx24-20020a17090af49800b001c6872a9e4eso2420526pjb.5
        for <linux-kernel@vger.kernel.org>; Tue, 22 Mar 2022 08:16:41 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=6eZDvQ+GMABUTzr3i/57SRk9t3VJSQXjOSoM90PZFK0=;
        b=WIvCRqy2V1PZqmzsPyNm6PjBpYgMhpmXdba3x+jvifvOfrBLOLkbGRRStyuRhGPXri
         VI/G1FwyHAXPrQTFODvegxDlar810TOGe/NcB+OQQX3N/a7TGvBIXXxSZ+WOWD3oeNJK
         qUnFXT+E7aHTKOhwhRPVLSIbHyAKOZV7+6WDg0HPr5SNXVXp5AGVQQsap/bE+Vx0t/D8
         jW8C0qlLBLrLVUL9Gz7oZOe6dByXebJcDM4GgzYqP9hxc5B/XAAgB2XBtgDivcKv+MwZ
         C/mngmCLksmEMuW9/FZ2InAm2RsKuVeZn9vRYA95QxYrQjd32Q3p+CaY//w8wMGQaoB9
         E5UA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=6eZDvQ+GMABUTzr3i/57SRk9t3VJSQXjOSoM90PZFK0=;
        b=1xjOCaV9Iy/o0uwlQd75GROSuQf4Rgd2Ajh5uBUauoTTb3GmKvJ5c2mH9ycaEy0P4+
         EC7UGqb3X9A9nluKDHbtOln4An38WGFlnxYbclnFlytpx0PELarmopPabAZ0yjXPI7QO
         fPG0vgUGi1iuaibTorwmTP4ew0WjC4yf3FezHq1frdiG2Lv3HsI2q9FmfG/b6Pk9MpX9
         I1J6B+WF9Vt6opl9vdz14nWaWFfqtqVpFrU31jc32UiMdeBkVKJeMlWIcnprsbMH2bIw
         TDObFq4wKx4CHepHZ6pDZL6D2MsZ70Wr4zf0J8gGism55Ns70w5ZlGn7ILOECJ9fHSlu
         omBA==
X-Gm-Message-State: AOAM533/insYr0Ebsz374NdqkzhnjQgD3HMZo+oM8ZMj8GsKnCOxG6JC
        8yGjYHEzuCZm4aeay/rXuQMZtnmqyCLW/w==
X-Google-Smtp-Source: ABdhPJz8/N3pPBCVjW4KumM1dBjgxdurrXl9yWeUv3TORFiiatViYg8ST6pSyxyQUy4yP6/GLJTUpA==
X-Received: by 2002:a17:903:2343:b0:154:4a3e:6b24 with SMTP id c3-20020a170903234300b001544a3e6b24mr13341807plh.129.1647962201363;
        Tue, 22 Mar 2022 08:16:41 -0700 (PDT)
Received: from ?IPV6:2409:8a28:e62:3990:a113:6fc:a7b4:4226? ([2409:8a28:e62:3990:a113:6fc:a7b4:4226])
        by smtp.gmail.com with ESMTPSA id k6-20020a17090a7f0600b001c63352cadbsm3171449pjl.29.2022.03.22.08.16.35
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 22 Mar 2022 08:16:41 -0700 (PDT)
Message-ID: <cdfb252e-9bfc-bee3-7ebe-b8ef401c85dd@bytedance.com>
Date:   Tue, 22 Mar 2022 23:16:27 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.7.0
Subject: Re: [External] Re: [PATCH v2 1/6] perf/core: Fix incosistency between
 cgroup sched_out and sched_in
Content-Language: en-US
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
From:   Chengming Zhou <zhouchengming@bytedance.com>
In-Reply-To: <YjnjHPuNjo8YTwiQ@hirez.programming.kicks-ass.net>
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

Hi peter,

On 2022/3/22 10:54 下午, Peter Zijlstra wrote:
> On Tue, Mar 22, 2022 at 09:38:21PM +0800, Chengming Zhou wrote:
>> On 2022/3/22 8:59 下午, Peter Zijlstra wrote:
>>> On Tue, Mar 22, 2022 at 08:08:29PM +0800, Chengming Zhou wrote:
>>>> There is a race problem that can trigger WARN_ON_ONCE(cpuctx->cgrp)
>>>> in perf_cgroup_switch().
>>>>
>>>> CPU1					CPU2
>>>> (in context_switch)			(attach running task)
>>>> perf_cgroup_sched_out(prev, next)
>>>> 	cgrp1 == cgrp2 is True
>>>> 					next->cgroups = cgrp3
>>>> 					perf_cgroup_attach()
>>>> perf_cgroup_sched_in(prev, next)
>>>> 	cgrp1 == cgrp3 is False
>>>>
>>>> The commit a8d757ef076f ("perf events: Fix slow and broken cgroup
>>>> context switch code") would save cpuctx switch out/in when the
>>>> perf_cgroup of "prev" and "next" are the same.
>>>>
>>>> But perf_cgroup of task can change in concurrent with context_switch.
>>>
>>> Can you clarify? IIRC then a task changes cgroup it goes throught the
>>> whole ->attach() dance, and that serializes against the context switch
>>> code.
>>>
>>
>> task->cgroups changed before perf_cgroup_attach(), and is not serialized
>> against the context switch, since task->cgroups can be changed without
>> rq lock held. (cgroup v1 or cgroup v2 with PSI disabled)
>>
>> So perf_cgroup_sched_out() in perf_cgroup_switch() may see the old or
>> new perf_cgroup when do context switch.
> 
> __schedule()
>   local_irq_disable();				<--- IRQ disable
>   rq_lock();
> 
>   ...
> 
>   context_switch()
>     prepare_task_switch()
>       perf_event_task_sched_out()
>         __perf_event_task_sched_out()
> 	  perf_cgroup_sched_out();

here compare perf_cgroup_from_task(prev) and perf_cgroup_from_task(next)

> 
>   switch_to()
>   finish_task_switch()
>     perf_event_task_sched_in()
>       __perf_event_task_sched_in()
>         perf_cgroup_sched_in();

here compare perf_cgroup_from_task(prev) and perf_cgroup_from_task(next)

>     finish_lock_switch()
>       raw_spin_irq_unlock_irq();		<--- IRQ enable
> 
> 
> vs
> 

rcu_assign_pointer(p->cgroups, to)		<--- task perf_cgroup changed

task->cgroups has changed before sending IPI

> perf_event_cgrp_subsys.attach = perf_cgroup_attach()
>   cgroup_taskset_for_each()
>     task_function_call(task, __perf_cgroup_move) <--- sends IPI
> 
> 
> Please explain how this can interleave.

__perf_cgroup_move in IPI is of course serialized against context switch,
but the task->cgroups has changed before that, without rq lock held.
So perf_cgroup_from_task() may see the old or new perf_cgroup.

Thanks.

