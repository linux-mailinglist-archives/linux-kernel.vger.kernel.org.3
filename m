Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B58CF4FFA7A
	for <lists+linux-kernel@lfdr.de>; Wed, 13 Apr 2022 17:39:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236637AbiDMPmL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 13 Apr 2022 11:42:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49422 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229732AbiDMPmK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 13 Apr 2022 11:42:10 -0400
Received: from mail-yb1-f169.google.com (mail-yb1-f169.google.com [209.85.219.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 826AF3E0DD;
        Wed, 13 Apr 2022 08:39:48 -0700 (PDT)
Received: by mail-yb1-f169.google.com with SMTP id p65so4432834ybp.9;
        Wed, 13 Apr 2022 08:39:48 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ilj9o7n3l/1aK2gZGkvAu8R7H4z8gknEBb05cWzjfsQ=;
        b=AnmvA+SZjt3/kCY+oKn6By7ac9WAlu7rTX+EmOPyqewm0yZNb5gu6/cE11lS44egtJ
         XgMjAh9V8szWszCrQY0w2lxYvCsbX1/VzdYITZ9+Foo/Xbtx2EbyDw35KqsTzZTQMtYb
         ZvBHA3Uu+VRK5LLtn6VWrQbksTRrFtX5e+1jRxNucKGqe9nLx5Sk3whN+bTQ4tu5jaeQ
         XnLSOmeelxtPiIjMTENqGzcB0qcJGOnhrGsKzA2hozggGlgt/Z2t1nRTbayXJ+s5MDz5
         f3jPm/rcaShJhuDLP6Jnl3LSDYPkrobeqSKS4+tzu/6VaL7DhGi6jLMU6mySSM0fP43z
         EByw==
X-Gm-Message-State: AOAM532n/NCMbVCo+ctMQZn+AD1r7t2t85GDj40X+IzCyCW5wXOFzyoc
        td+UY9mdvonCP8PjKgZtxi7G7ZKcE1pSqJ/d5e8=
X-Google-Smtp-Source: ABdhPJy3rSywWLlrRlA3i0ucuEuO0ZcncIrCyV73ZSRe9Ts/0QwHSnh1HJvj1FuMIrBCY+Rt6g7eu8+0KxXy+qOP0cw=
X-Received: by 2002:a25:e082:0:b0:641:cf5:b91f with SMTP id
 x124-20020a25e082000000b006410cf5b91fmr18196837ybg.482.1649864387664; Wed, 13
 Apr 2022 08:39:47 -0700 (PDT)
MIME-Version: 1.0
References: <20220407234258.569681-1-yu.c.chen@intel.com> <36982e082159a77154cfc8a78039e4ce9e3b4770.camel@suse.cz>
In-Reply-To: <36982e082159a77154cfc8a78039e4ce9e3b4770.camel@suse.cz>
From:   "Rafael J. Wysocki" <rafael@kernel.org>
Date:   Wed, 13 Apr 2022 17:39:36 +0200
Message-ID: <CAJZ5v0jNGYP8zT6_96J6+bxx1p-ngf56GdvXMmscyUCNMMQeSg@mail.gmail.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Handle no_turbo in frequency invariance
To:     Giovanni Gherdovich <ggherdovich@suse.cz>,
        Chen Yu <yu.c.chen@intel.com>
Cc:     Linux PM <linux-pm@vger.kernel.org>,
        "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Len Brown <len.brown@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Chen Yu <yu.chen.surf@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Zhang Rui <rui.zhang@intel.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 8, 2022 at 4:22 PM Giovanni Gherdovich <ggherdovich@suse.cz> wrote:
>
> On Fri, 2022-04-08 at 07:42 +0800, Chen Yu wrote:
> > Problem statement:
> > Once the user has disabled turbo frequency by
> > echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo,
> > the cfs_rq's util_avg becomes quite small when compared with
> > CPU capacity.
> >
> > Step to reproduce:
> >
> > echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
> >
> > ./x86_cpuload --count 1 --start 3 --timeout 100 --busy 99
> > would launch 1 thread and bind it to CPU3, lasting for 100 seconds,
> > with a CPU utilization of 99%. [1]
> >
> > top result:
> > %Cpu3  : 98.4 us,  0.0 sy,  0.0 ni,  1.6 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> >
> > check util_avg:
> > cat /sys/kernel/debug/sched/debug | grep "cfs_rq\[3\]" -A 20 | grep util_avg
> >   .util_avg                      : 611
> >
> > So the util_avg/cpu capacity is 611/1024, which is much smaller than
> > 98.4% shown in the top result.
> >
> > This might impact some logic in the scheduler. For example, group_is_overloaded()
> > would compare the group_capacity and group_util in the sched group, to
> > check if this sched group is overloaded or not. With this gap, even
> > when there is a nearly 100% workload, the sched group will not be regarded
> > as overloaded. Besides group_is_overloaded(), there are also other victims.
> > There is a ongoing work that aims to optimize the task wakeup in a LLC domain.
> > The main idea is to stop searching idle CPUs if the sched domain is overloaded[2].
> > This proposal also relies on the util_avg/CPU capacity to decide whether the LLC
> > domain is overloaded.
> >
> > Analysis:
> > CPU frequency invariance has caused this difference. In summary,
> > the util_sum of cfs rq would decay quite fast when the CPU is in
> > idle, when the CPU frequency invariance is enabled.
> >
> > The detail is as followed:
> >
> > As depicted in update_rq_clock_pelt(), when the frequency invariance
> > is enabled, there would be two clock variables on each rq, clock_task
> > and clock_pelt:
> >
> >    The clock_pelt scales the time to reflect the effective amount of
> >    computation done during the running delta time but then syncs back to
> >    clock_task when rq is idle.
> >
> >    absolute time    | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16
> >    @ max frequency  ------******---------------******---------------
> >    @ half frequency ------************---------************---------
> >    clock pelt       | 1| 2|    3|    4| 7| 8| 9|   10|   11|14|15|16
> >
> > The fast decay of util_sum during idle is due to:
> > 1. rq->clock_pelt is always behind rq->clock_task
> > 2. rq->last_update is updated to rq->clock_pelt' after invoking ___update_load_sum()
> > 3. Then the CPU becomes idle, the rq->clock_pelt' would be suddenly increased
> >    a lot to rq->clock_task
> > 4. Enters ___update_load_sum() again, the idle period is calculated by
> >    rq->clock_task - rq->last_update, AKA, rq->clock_task - rq->clock_pelt'.
> >    The lower the CPU frequency is, the larger the delta =
> >    rq->clock_task - rq->clock_pelt' will be. Since the idle period will be
> >    used to decay the util_sum only, the util_sum drops significantly during
> >    idle period.
> >
> > Proposal:
> > This symptom is not only caused by disabling turbo frequency, but it
> > would also appear if the user limits the max frequency at runtime. Because
> > if the frequency is always lower than the max frequency,
> > CPU frequency invariance would decay the util_sum quite fast during idle.
> >
> > As some end users would disable turbo after boot up, this patch aims to
> > present this symptom and deals with turbo scenarios for now. It might
> > be ideal if CPU frequency invariance is aware of the max CPU frequency
> > (user specified) at runtime in the future.
> >
> > [Previous patch seems to be lost on LKML, this is a resend, sorry for any
> > inconvenience]
> >
> > Link: https://github.com/yu-chen-surf/x86_cpuload.git #1
> > Link: https://lore.kernel.org/lkml/20220310005228.11737-1-yu.c.chen@intel.com/ #2
> > Signed-off-by: Chen Yu <yu.c.chen@intel.com>
>
> Reviewed-by: Giovanni Gherdovich <ggherdovich@suse.cz>
>
> You're right, when turbo is disabled, the frequency invariance code needs to
> know about it; it calculates freq_curr/freq_max and thinks that freq_max is
> some turbo level. For example commit 918229cdd5ab ("x86/intel_pstate: Handle
> runtime turbo disablement/enablement in frequency invariance") takes care of
> this when global.turbo_disabled changes, but before your patch nothing checks
> if the user disabled turbo from sysfs. Thanks for the fix!
>
> Giovanni

Applied as 5.19 material, thanks!
