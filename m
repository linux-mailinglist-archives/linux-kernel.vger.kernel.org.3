Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 19B0550A5AA
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 18:34:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229832AbiDUQcI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 12:32:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39354 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231397AbiDUQbc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 12:31:32 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B210349F1B
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:26:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650558361;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=YzLMHYGlgJV6x+Dcp/1+CizAxcwBiXBL5GAr+2klJbY=;
        b=hHLqFigHP37DE4+KbAcI9vDLLIKHZEhm/H6m0HdSYjzI+S+Rn3uYk7JOqyf9vxV5MXroKX
        Om2Ui2aUYNueXDJIJy8FcUbHGMEMY11Im49DZbn6jPX3elNICA+3PuVFQF4R2NneL74ZDd
        eg7uqKKcBY+VVCh4ilqOZfhavAAs1kA=
Received: from mail-ua1-f71.google.com (mail-ua1-f71.google.com
 [209.85.222.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-148-u5VA4BtTNaCYnUQrLP6ZGA-1; Thu, 21 Apr 2022 12:26:00 -0400
X-MC-Unique: u5VA4BtTNaCYnUQrLP6ZGA-1
Received: by mail-ua1-f71.google.com with SMTP id w16-20020ab067d0000000b0035ceb645456so2078239uar.10
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 09:26:00 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=YzLMHYGlgJV6x+Dcp/1+CizAxcwBiXBL5GAr+2klJbY=;
        b=SrxH3HJJsq60jxqLAYvM34R5kPnpzYdFV0XgMt4f5WreiH3OyFF2e0gSoOP8zRIN6r
         6Qj03QU+eLXqXst7S0XaLR3H2NLvpvgAYcAsGfqzCuOdCGjGfy2IggOtvUJ53uTOAdnh
         xF6LTz2uQTo253gAoe3NONEEgJDugBoQvqeRpM00zVoRPmQYrkHZIX0vC/kV/dQIb/rO
         UhzVqNSVdyssJ6NunBsZKTdDIsXZ4Fw0Rl5jShnvNHtuowc0JlruP1jbO3MT52OvwV8w
         ouOvLmuH1s2r2EOxwiip70Q+ApkP6jhdbjicanC/t4iYNkLyByOGy5kO4RxrmsJBF1/t
         idTA==
X-Gm-Message-State: AOAM53000MTUxlkX6n40Ccb8BdsjGtlRL0mG1MN2j7D721YrLKabeuYc
        eoXbDxbPQ4c+oupKJC9i4AfGPn/XTDEMspp/7eUsFsd82v5dKHPUADTmB+UBcoUI+q0QSDvSzSo
        YC5BZVD/5DOLzzkdyOxhxY189
X-Received: by 2002:a05:6102:a8e:b0:325:aa27:35a7 with SMTP id n14-20020a0561020a8e00b00325aa2735a7mr162598vsg.50.1650558359895;
        Thu, 21 Apr 2022 09:25:59 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJx7HGoMlorFMIObliYFXOddYMZmP70gzc5sATCpn4GK7fzm1tWeggKSpCdKocttoO72C1q7wQ==
X-Received: by 2002:a05:6102:a8e:b0:325:aa27:35a7 with SMTP id n14-20020a0561020a8e00b00325aa2735a7mr162579vsg.50.1650558359671;
        Thu, 21 Apr 2022 09:25:59 -0700 (PDT)
Received: from [192.168.169.241] ([216.239.164.83])
        by smtp.gmail.com with ESMTPSA id m6-20020a0561023e8600b0031bb1803345sm757470vsv.6.2022.04.21.09.25.58
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 21 Apr 2022 09:25:59 -0700 (PDT)
Message-ID: <5653e751-f81d-f64e-b4b5-b251949d13d9@redhat.com>
Date:   Thu, 21 Apr 2022 12:25:58 -0400
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v9] oom_kill.c: futex: Delay the OOM reaper to allow time
 for proper futex cleanup
Content-Language: en-US
To:     Thomas Gleixner <tglx@linutronix.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Rafael Aquini <aquini@redhat.com>,
        Waiman Long <longman@redhat.com>,
        "Herton R . Krzesinski" <herton@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Steven Rostedt <rostedt@goodmis.org>,
        Ben Segall <bsegall@google.com>, Mel Gorman <mgorman@suse.de>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Michal Hocko <mhocko@suse.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@redhat.com>,
        Joel Savitz <jsavitz@redhat.com>,
        Darren Hart <dvhart@infradead.org>, stable@kernel.org
References: <20220414144042.677008-1-npache@redhat.com> <874k2mts8p.ffs@tglx>
From:   Nico Pache <npache@redhat.com>
In-Reply-To: <874k2mts8p.ffs@tglx>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/21/22 10:40, Thomas Gleixner wrote:
> On Thu, Apr 14 2022 at 10:40, Nico Pache wrote:
>> The pthread struct is allocated on PRIVATE|ANONYMOUS memory [1] which can
>> be targeted by the oom reaper. This mapping is used to store the futex
>> robust list head; the kernel does not keep a copy of the robust list and
>> instead references a userspace address to maintain the robustness during
>> a process death. A race can occur between exit_mm and the oom reaper that
>> allows the oom reaper to free the memory of the futex robust list before
>> the exit path has handled the futex death:
>>
>>     CPU1                               CPU2
>> ------------------------------------------------------------------------
>>     page_fault
>>     do_exit "signal"
>>     wake_oom_reaper
>>                                         oom_reaper
>>                                         oom_reap_task_mm (invalidates mm)
>>     exit_mm
>>     exit_mm_release
>>     futex_exit_release
>>     futex_cleanup
>>     exit_robust_list
>>     get_user (EFAULT- can't access memory)
>>
>> If the get_user EFAULT's, the kernel will be unable to recover the
>> waiters on the robust_list, leaving userspace mutexes hung indefinitely.
>>
>> Delay the OOM reaper, allowing more time for the exit path to perform
>> the futex cleanup.
>>
>> Reproducer: https://gitlab.com/jsavitz/oom_futex_reproducer
>>
>> [1] https://elixir.bootlin.com/glibc/latest/source/nptl/allocatestack.c#L370
> 
> A link to the original discussion about this would be more useful than a
> code reference which is stale tomorrow. The above explanation is good
> enough to describe the problem.

Hi Andrew,

can you please update the link when you add the ACKs.

Here is a more stable link:
[1] https://elixir.bootlin.com/glibc/glibc-2.35/source/nptl/allocatestack.c#L370

> 
>>  
>> +/*
>> + * Give the OOM victim time to exit naturally before invoking the oom_reaping.
>> + * The timers timeout is arbitrary... the longer it is, the longer the worst
>> + * case scenario for the OOM can take. If it is too small, the oom_reaper can
>> + * get in the way and release resources needed by the process exit path.
>> + * e.g. The futex robust list can sit in Anon|Private memory that gets reaped
>> + * before the exit path is able to wake the futex waiters.
>> + */
>> +#define OOM_REAPER_DELAY (2*HZ)
>> +static void queue_oom_reaper(struct task_struct *tsk)
> 
> Bah. Did you run out of newlines? Glueing that define between the
> comment and the function is unreadable.

My Enter key hit its cgroup limit for newlines.

Andrew, would it be possible to also add a new line when you make the other
changes. Sorry about that.

> 
> Other than that.
> 
> Acked-by: Thomas Gleixner <tglx@linutronix.de>

Thanks!

