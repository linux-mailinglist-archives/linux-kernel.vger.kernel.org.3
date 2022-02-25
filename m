Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 399F14C3FDC
	for <lists+linux-kernel@lfdr.de>; Fri, 25 Feb 2022 09:15:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238397AbiBYIPs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 25 Feb 2022 03:15:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233587AbiBYIPp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 25 Feb 2022 03:15:45 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 72D851D0D71
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:15:13 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id j10-20020a17090a94ca00b001bc2a9596f6so4158649pjw.5
        for <linux-kernel@vger.kernel.org>; Fri, 25 Feb 2022 00:15:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=8gK/68TTuhOiXg3xhW1tmjtT5/wBVuW4mc55U1QLxFg=;
        b=dkb9saRa31mERMTHDptVQEJ2yDYe43jmHvG0v8O9UYB6jIcABWN+nY8+b2YUu2/zQH
         aDJWpoqcccx5yXP/0mUCmCHHKnXod3dCpMCK7FCUXK/862Iy4EeFjkniWsGmrUuCom13
         60WwA4TBQoE6OBnUjbMh4aJ9jlGuURZYB590p9ielhLHc5KEfKaIXP8awaZqGmR72opw
         EWO+z0HG4X/exjPyTzGr1WHWhhYBOL83LA8wZzxoFmk6XEgWALuY8MpsgoHlHyumdr8V
         smpP8K6d9UMDsqT3QsLbqLcc2xlqt9d5MSedOrg+IfQ7C17jPkCaoZSFCbnPb/XulZwZ
         UMuA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=8gK/68TTuhOiXg3xhW1tmjtT5/wBVuW4mc55U1QLxFg=;
        b=l3Rt/XS3pstcybI4jp++csVRDBwNlP5KKhMnhrjpZ+v92qlrs4nGTeGe/5dWBpmNwM
         +iN5p00+7cNgayAEHaBtXcxiFRHY1BEJtYOWAsF7SlMasLRQolpqqHGNBYuOCn5+Mi31
         Pd5CGV4B+jJ56MedN9TmLHHq8dilT1mObb+lIsy276K2PyKBswthyfxz7g7k8oA3DAHI
         +j1dSt+0CV+2QyeKkuF9lIszDPiHG9v6ss+DDJAxUK3qX1B3cC+9esmjk29sjsgrKoyi
         y7eVYANMjgkS1ZSs+/DTmt+xUWOVcUQtMkrJXRtOQEqYdGXxbnvliEga1DUdx7PwiC2K
         e/7Q==
X-Gm-Message-State: AOAM530g3eqCxIF2aG6abTxKGioaMmgLD6dYK7rJrmyJbKprC5J8NUqw
        qAa4XaEnCGquEU3XhkmnA3m89A==
X-Google-Smtp-Source: ABdhPJxmTtUDJmBrrSRqJTstxtdRUEsPmfOcO6vuTT6BZvDDvicyK+UeNdEXIoqdkke0Zpq9DNabAw==
X-Received: by 2002:a17:902:e84e:b0:14d:8c9b:c6f6 with SMTP id t14-20020a170902e84e00b0014d8c9bc6f6mr6511258plg.96.1645776912853;
        Fri, 25 Feb 2022 00:15:12 -0800 (PST)
Received: from [10.94.58.189] ([139.177.225.254])
        by smtp.gmail.com with ESMTPSA id o185-20020a6341c2000000b0036fb987b25fsm1755475pga.38.2022.02.25.00.15.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 25 Feb 2022 00:15:12 -0800 (PST)
Message-ID: <99805673-50a1-78cd-b710-0f00ce7de809@bytedance.com>
Date:   Fri, 25 Feb 2022 16:15:06 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:91.0)
 Gecko/20100101 Thunderbird/91.6.1
Subject: Re: [RFC PATCH 0/5] introduce sched-idle balancing
Content-Language: en-US
To:     Mel Gorman <mgorman@suse.de>
Cc:     Ben Segall <bsegall@google.com>,
        Daniel Bristot de Oliveira <bristot@redhat.com>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@redhat.com>,
        Juri Lelli <juri.lelli@redhat.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Steven Rostedt <rostedt@goodmis.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        linux-kernel@vger.kernel.org, Abel Wu <wuyun.abel@bytedance.com>
References: <20220217154403.6497-1-wuyun.abel@bytedance.com>
 <20220224164711.GA4363@suse.de>
From:   Abel Wu <wuyun.abel@bytedance.com>
In-Reply-To: <20220224164711.GA4363@suse.de>
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

Hi Mel,

On 2/25/22 12:47 AM, Mel Gorman Wrote:
> On Thu, Feb 17, 2022 at 11:43:56PM +0800, Abel Wu wrote:
>> Current load balancing is mainly based on cpu capacity
>> and task util, which makes sense in the POV of overall
>> throughput. While there still might be some improvement
>> can be done by reducing number of overloaded cfs rqs if
>> sched-idle or idle rq exists.
>>
>> An CFS runqueue is considered overloaded when there are
>> more than one pullable non-idle tasks on it (since sched-
>> idle cpus are treated as idle cpus). And idle tasks are
>> counted towards rq->cfs.idle_h_nr_running, that is either
>> assigned SCHED_IDLE policy or placed under idle cgroups.
>>
> 
> It's not clear how your tests evaluated the balancing of SCHED_IDLE tasks
> versus the existing idle balancing and isolated that impact. I suspect
> the tests may primarily measured the effect of the SIS filter.

The sched-idle balancing doesn't really care about the idle tasks.
It tries to improve the non-idle tasks' performance by spreading
them out to make full use of cpu capacity.

I will do some individual tests to SIS and sched-idle balancer
each, and keep you informed.

> 
>> So in short, the goal of the sched-idle balancing is to
>> let the *non-idle tasks* make full use of cpu resources.
>> To achieve that, we mainly do two things:
>>
>>    - pull non-idle tasks for sched-idle or idle rqs
>>      from the overloaded ones, and
>>
>>    - prevent pulling the last non-idle task in an rq
>>
>> The mask of overloaded cpus is updated in periodic tick
>> and the idle path at the LLC domain basis. This cpumask
>> will also be used in SIS as a filter, improving idle cpu
>> searching.
>>
> 
> As the overloaded mask may be updated on each idle, it could be a
> significant source of cache misses between CPUs sharing the domain for
> workloads that rapidly idle so there should be data on whether cache misses
> are increased heavily. It also potentially delays the CPU reaching idle
> but it may not be by much.

Yes, that's why I cached overloaded status in rq->overloaded. So in
this case of short running tasks, when cpus rapidly/frequently go
idle, the cpumask/counter are not actually updated if the cached
status is already 0 (not overloaded).

> 
> The filter may be out of date. It takes up to one tick to detect
> overloaded and the filter to have a positive impact. As a CPU is not
> guaranteed to enter idle if there is at least one CPU-bound task, it may
> also be up to 1 tick before the mask is cleared. I'm not sure this is a
> serious problem though as SIS would not pick the CPU with the CPU-bound
> task anyway.

Yes, it can be out of date, but increasing the accuracy means more
frequent update which would introduce cache issues you mentioned
above. Rate limit the updating to tick at the LLC basis might be an
acceptable tradeoff I presume.

> 
> At minimum, the filter should be split out and considered first as it
> is the most likely reason why a performance difference was measured. It
> has some oddities like why nr_overloaded is really a boolean and as
> it's under rq lock, it's not clear why it's atomic. The changelog
> would ideally contain some comment on the impact to cache misses
> if any and some sort of proof that SIS search depth is reduced which
> https://lore.kernel.org/lkml/20210726102247.21437-2-mgorman@techsingularity.net/
> may be some help.
> 
> At that point, compare the idle task balancing on top to isolate how
> much it improves things if any and identify why existing balancing is
> insufficient. Split out the can_migrate_task change beforehand in case it
> is the main source of difference as opposed to the new balancing mechanism.
> 

The nr_overloaded sits in shared domain structure thus shared in
LLC domain and needs to be atomic_t, while rq->overloaded is a
boolean updated under rq lock. Maybe the naming can cause some
confusion, please lighten me up if you have better idea :)

And yes, I agree it would be nice if test result on SIS search
depth can be shown, and I actually did the test, but the result
didn't show a reduction in depth due to sched-idle balancing
will also consume sched-idle/idle cpus. I will apply your patch
and make some further tests on that, thanks.

Best Regards,
	Abel
