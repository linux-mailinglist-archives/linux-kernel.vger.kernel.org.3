Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A9FC4D72D4
	for <lists+linux-kernel@lfdr.de>; Sun, 13 Mar 2022 06:43:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233612AbiCMFjR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 13 Mar 2022 00:39:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiCMFjP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 13 Mar 2022 00:39:15 -0500
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7C38139A
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:38:06 -0800 (PST)
Received: by mail-pj1-x1035.google.com with SMTP id bx5so11635817pjb.3
        for <linux-kernel@vger.kernel.org>; Sat, 12 Mar 2022 21:38:06 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:to:cc:references
         :from:in-reply-to:content-transfer-encoding;
        bh=7qpUz8ye2ArhpAi8guP0rB56tWXiT9C88VgIHLYyMps=;
        b=MuYZ9axCrl2zhwNAN6CDPMtSl0xFnKucgj5dvBDi/bI0rQS3G+ao0LfP7vxHV8DhnC
         aGpitno5ubZhut77wJe9s/kaJcg4AGRaAvQ85b3FqAmyLVAQ88c3+O+KZ5KiGzOQEHPk
         vJiQePWe9o373SHrCZtcgDpeBPAfzw8yON0B0AaMX2KscnycBjn9cg9j/HxsraXViBLm
         zRlzhlZcc0JbKhO4CXasDC0dZeLvQIoERmxCz2nf+lsPJVDPfp8Td9IlXOMK8IihWIpv
         R9TAfKbCD1VvaW532zMXF0dE/Aa7M2R+tqyZPyyOP2IbLE2qJCoa4/k9+stN+uMLp5NA
         wIVQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :to:cc:references:from:in-reply-to:content-transfer-encoding;
        bh=7qpUz8ye2ArhpAi8guP0rB56tWXiT9C88VgIHLYyMps=;
        b=54Y/gYsRyHfKMP7cMMvefVRIKw0EioWAuFRXV9w23yh36JgjZgJsP714x5cgylYWK5
         ISb+5UV6/6kBtXyGmWmhaUJMZRkPb1nVPMO9tG2Lnd+MUfn+xHzkV7Q22913jLEy7Ad7
         oGA4nWDbggUmX2EPVn9KgGoQVJMVYSPS0FOCXqmE+QPrNZ0Deqt+Z24Ua2M40XrCbQIv
         jngz/xxrk7XXl+gHeU8MBa46nKOGsVAMs2dV3Sx1bMIJm5MI5WPFkmYYoUk/l4OIiTnu
         lSAEWN/+CWjEPIf/hnkhtTZN31M9Vs1C00tOxQmbW8JbpaCzdvYZYXSP/1AAUVVD/iq5
         CudA==
X-Gm-Message-State: AOAM531r1vjC/qYD/aKqPL5yKZnnAEDiAaNAGwszcp/vpSCwxH0EsQa1
        xSHjS3uZjfvfsOAKYK0R7VOMmg==
X-Google-Smtp-Source: ABdhPJy3LoMdBQq7WLEd9ERuPFRcls1FcG1R2cPXgqho3KCk0KL8UUkRBQNB3LdzTzFJEb0Ld8i0+Q==
X-Received: by 2002:a17:902:ecd0:b0:151:dd64:c79b with SMTP id a16-20020a170902ecd000b00151dd64c79bmr18180355plh.79.1647149885978;
        Sat, 12 Mar 2022 21:38:05 -0800 (PST)
Received: from [10.4.241.58] ([139.177.225.239])
        by smtp.gmail.com with ESMTPSA id e13-20020a63370d000000b003810782e0cdsm6640955pga.56.2022.03.12.21.38.00
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 12 Mar 2022 21:38:05 -0800 (PST)
Message-ID: <a528d7bf-a634-00b6-42ab-dcb516567c34@bytedance.com>
Date:   Sun, 13 Mar 2022 13:37:37 +0800
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
From:   chenying <chenying.kernel@bytedance.com>
In-Reply-To: <20220312120309.GB6235@worktop.programming.kicks-ass.net>
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

在 2022/3/12 20:03, Peter Zijlstra 写道:
> On Fri, Mar 11, 2022 at 03:58:47PM +0800, chenying wrote:
>> We add a time offset to the se->vruntime when the idle sched_entity
>> is enqueued, so that the idle entity will always be on the right of
>> the non-idle in the runqueue. This can allow non-idle tasks to be
>> selected and run before the idle.
>>
>> A use-case is that sched_idle for background tasks and non-idle
>> for foreground. The foreground tasks are latency sensitive and do
>> not want to be disturbed by the background. It is well known that
>> the idle tasks can be preempted by the non-idle tasks when waking up,
>> but will not distinguish between idle and non-idle when pick the next
>> entity. This may cause background tasks to disturb the foreground.
>>
>> Test results as below:
>>
>> ~$ ./loop.sh &
>> [1] 764
>> ~$ chrt -i 0 ./loop.sh &
>> [2] 765
>> ~$ taskset -p 04 764
>> ~$ taskset -p 04 765
>>
>> ~$ top -p 764 -p 765
>> top - 13:10:01 up 1 min,  2 users,  load average: 1.30, 0.38, 0.13
>> Tasks:   2 total,   2 running,   0 sleeping,   0 stopped,   0 zombie
>> %Cpu(s): 12.5 us,  0.0 sy,  0.0 ni, 87.4 id,  0.0 wa,  0.0 hi, 0.0 si,  0.0
>> st
>> KiB Mem : 16393492 total, 16142256 free,   111028 used,   140208 buff/cache
>> KiB Swap:   385836 total,   385836 free,        0 used. 16037992 avail Mem
>>
>>    PID USER      PR  NI    VIRT    RES    SHR S  %CPU %MEM TIME+ COMMAND
>>    764 chenyin+  20   0   12888   1144   1004 R 100.0  0.0 1:05.12 loop.sh
>>    765 chenyin+  20   0   12888   1224   1080 R   0.0  0.0 0:16.21 loop.sh
>>
>> The non-idle process (764) can run at 100% and without being disturbed by
>> the idle process (765).
> 
> Did you just do a very complicated true idle time scheduler, with all
> the problems that brings?

When colocating CPU-intensive jobs with latency-sensitive services can 
improve CPU utilization but it is difficult to meet the stringent 
tail-latency requirements of latency-sensitive services. We use a true 
idle time scheduler for CPU-intensive jobs to minimize the impact on 
latency-sensitive services.
