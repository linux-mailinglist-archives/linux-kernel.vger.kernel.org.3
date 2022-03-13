Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6F8F54D7429
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 11:07:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234216AbiCMKIk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 06:08:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57846 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229475AbiCMKIi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 06:08:38 -0400
Received: from mail-pg1-x52b.google.com (mail-pg1-x52b.google.com [IPv6:2607:f8b0:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C14C9AE6B
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 03:07:28 -0700 (PDT)
Received: by mail-pg1-x52b.google.com with SMTP id z4so11265054pgh.12
        for <linux-kernel@vger.kernel.org>; Sun, 13 Mar 2022 03:07:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=Pap/dho2OEbby8v417yTC/mpsfUxrNptqjeGXyamOJU=;
        b=GrKm1S/LLhTundh5WJB/LDXVYVFtkpqKOgkw+cUN4AUI4464cu+XB9LU0wZTG6vXL0
         sexH5IVGK47qde1O43jF+zXwUJFQWu9F5V0foJlWYEf3JKihyrxrMvtzGs/zp2C26j0s
         3NfXC0bAGtlqI6Uwf+hmJutWAHu4VE4/HCdd497OS/fj9/iX0JLOKcdQpfW4KiFRBQSE
         QeCkv8caNM4dshJgPNkqhtqmW7H02QR2HrFo0lB1Ar91VHTwvHQMx/4JXr5c3V21p08i
         LEKkrTzNCX9ls9ntAChrUclJM9kdqwuTu5E+4BNVUulP3zjTPucOUT+4twOV6kHfZ1KZ
         aq9A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Pap/dho2OEbby8v417yTC/mpsfUxrNptqjeGXyamOJU=;
        b=vnsXgP1DdjcK15ct0+wR8GpBMc+Zc1T6OaK81Wa71NyhTtS5UAUa+ZVj3XKlQZHKqJ
         GOQ28E3sfTHHMR4XIjQm5xwVCKUWoMVAmBznLWpWvMJdjTedgpzPVn5Qq/A6w6gSjbJ4
         ljR6DE5qVsDGe/0FYk44jvINXcmdbcL/rttPECjGFCAKGPDhLPP5yDx79fCnC4DL9XhD
         YZYigOEG8027A1+RLBCfO2nBECKlgCSjJI4Cw3cyLBRzYEFb8zzUdhjLbgHysFq4seL7
         DaO4o6dzpzQ0IcQ7YBvmSJ1bu0nQxbbQ1u/kgfvGSFp4wHyTQdq/TrUfAOQh5ELKKVat
         Fb9Q==
X-Gm-Message-State: AOAM530863KIwU4TWGHAe7uy9LAKmBVJNq2CU3/lOwKYn03LPEJkFhQ8
        ZQZIFYc7hKZ+3NwAU41ZFnu2Pw==
X-Google-Smtp-Source: ABdhPJyQKKZZl8/eRuaja7cGplxqGUyDPcBRX5Sh7pcpsGTTS9jKcjvRvlogI9s66f/xuxDF9/Yzhg==
X-Received: by 2002:a63:c61:0:b0:370:592b:3ad1 with SMTP id 33-20020a630c61000000b00370592b3ad1mr15715055pgm.240.1647166047426;
        Sun, 13 Mar 2022 03:07:27 -0700 (PDT)
Received: from [10.4.241.58] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id me8-20020a17090b17c800b001bf9907c41bsm17976462pjb.12.2022.03.13.03.07.21
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 13 Mar 2022 03:07:26 -0700 (PDT)
Message-ID: <e57c7166-b484-0d32-e4e8-5a47ef0bb53c@bytedance.com>
Date:   Sun, 13 Mar 2022 18:06:58 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [External] Re: Subject: [PATCH] sched/fair: prioritize normal
 task over sched_idle task with vruntime offset
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, dietmar.eggemann@arm.com,
        rostedt@goodmis.org, mgorman@suse.de, bristot@redhat.com,
        bsegall@google.com, linux-kernel@vger.kernel.org,
        duanxiongchun@bytedance.com, zhouchengming@bytedance.com,
        songmuchun@bytedance.com, zhengqi.arch@bytedance.com,
        zhoufeng.zf@bytedance.com, ligang.bdlg@bytedance.com
References: <f87a8c0d-527d-a9bc-9653-ff955e0e95b4@bytedance.com>
 <20220312120309.GB6235@worktop.programming.kicks-ass.net>
 <a528d7bf-a634-00b6-42ab-dcb516567c34@bytedance.com>
 <20220313090222.GL28057@worktop.programming.kicks-ass.net>
From:   chenying <chenying.kernel@bytedance.com>
In-Reply-To: <20220313090222.GL28057@worktop.programming.kicks-ass.net>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

在 2022/3/13 17:02, Peter Zijlstra 写道:
> On Sun, Mar 13, 2022 at 01:37:37PM +0800, chenying wrote:
>> 在 2022/3/12 20:03, Peter Zijlstra 写道:
>>> On Fri, Mar 11, 2022 at 03:58:47PM +0800, chenying wrote:
>>>> We add a time offset to the se->vruntime when the idle sched_entity
>>>> is enqueued, so that the idle entity will always be on the right of
>>>> the non-idle in the runqueue. This can allow non-idle tasks to be
>>>> selected and run before the idle.
>>>>
>>>> A use-case is that sched_idle for background tasks and non-idle
>>>> for foreground. The foreground tasks are latency sensitive and do
>>>> not want to be disturbed by the background. It is well known that
>>>> the idle tasks can be preempted by the non-idle tasks when waking up,
>>>> but will not distinguish between idle and non-idle when pick the next
>>>> entity. This may cause background tasks to disturb the foreground.
>>>>
>>>> Test results as below:
>>>>
>>>> ~$ ./loop.sh &
>>>> [1] 764
>>>> ~$ chrt -i 0 ./loop.sh &
>>>> [2] 765
>>>> ~$ taskset -p 04 764
>>>> ~$ taskset -p 04 765
>>>>
>>>> ~$ top -p 764 -p 765
>>>> top - 13:10:01 up 1 min,  2 users,  load average: 1.30, 0.38, 0.13
>>>> Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
>>>> %Cpu(s): 12.5 us,  0.0 sy,  0.0 ni, 87.4 id,  0.0 wa,  0.0 hi, 0.0 si,  0.0
>>>> st
>>>> KiB Mem : 16393492 total, 16142256 free,   111028 used,   140208 buff/cache
>>>> KiB Swap:   385836 total,   385836 free,        0 used. 16037992 avail Mem
>>>>
>>>>     PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM TIME+ COMMAND
>>>>     764 chenyin+  20   0   12888   1144   1004 R 100.0  0.0 1:05.12 loop.sh
>>>>     765 chenyin+  20   0   12888   1224   1080 R   0.0  0.0 0:16.21 loop.sh
>>>>
>>>> The non-idle process (764) can run at 100% and without being disturbed by
>>>> the idle process (765).
>>>
>>> Did you just do a very complicated true idle time scheduler, with all
>>> the problems that brings?
>>
>> When colocating CPU-intensive jobs with latency-sensitive services can
>> improve CPU utilization but it is difficult to meet the stringent
>> tail-latency requirements of latency-sensitive services. We use a true idle
>> time scheduler for CPU-intensive jobs to minimize the impact on
>> latency-sensitive services.
> 
> Hard NAK on any true idle-time scheduler until you make the whole kernel
> immune to lock holder starvation issues.

If I set the sched_idle_vruntime_offset to a relatively small value 
(e.g. 10 minutes), can this issues be avoided?

