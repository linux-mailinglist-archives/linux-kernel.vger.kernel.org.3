Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B90944F90AB
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 10:22:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231658AbiDHIYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 04:24:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231613AbiDHIYj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 04:24:39 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43BA713987B;
        Fri,  8 Apr 2022 01:22:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=p4al6XE4mZf5FhF4BRGqvM8RxBNfhw6xzIpON9k8hEs=; b=BtTKjOwVnmC70zpA2wmxiLVUrY
        2GqbJP2uJ5AnaVEFYp32h6BnHTvF/k8v3TC654jmKq6R0KCIgW3APXRpPoSrDLQfSRrhzEQzKZ2SH
        1q602T47W5Xf4Yhjzu8b6CrL/q2WbF+9y9B7jrRJTnsselr3QZVjQoQIyrc5fnX3tBVIvWZs8K6KD
        zS7H38MJcIMF5d8P/BPtybsrmyWM2qxsld4E+gf+x6qmX/7XlmOh8ugR1lbXcf2X40QbiS+owubQX
        i9qiOqF6ZpEKadSVPXr4fZIs3HEjd+sVbq00oXGnZtsls0xus6l2jCMBQCYOMgywq8RPqAwY1N7Zu
        5lF00ONg==;
Received: from j217100.upc-j.chello.nl ([24.132.217.100] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1ncjsw-009deL-Dk; Fri, 08 Apr 2022 08:22:26 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id BFB149862CF; Fri,  8 Apr 2022 10:22:25 +0200 (CEST)
Date:   Fri, 8 Apr 2022 10:22:25 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     Chen Yu <yu.c.chen@intel.com>
Cc:     linux-pm@vger.kernel.org, "Rafael J. Wysocki" <rafael@kernel.org>,
        Srinivas Pandruvada <srinivas.pandruvada@linux.intel.com>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Len Brown <len.brown@intel.com>,
        Tim Chen <tim.c.chen@intel.com>,
        Giovanni Gherdovich <ggherdovich@suse.cz>,
        Chen Yu <yu.chen.surf@gmail.com>, linux-kernel@vger.kernel.org,
        Zhang Rui <rui.zhang@intel.com>
Subject: Re: [PATCH] cpufreq: intel_pstate: Handle no_turbo in frequency
 invariance
Message-ID: <20220408082225.GN2731@worktop.programming.kicks-ass.net>
References: <20220407234258.569681-1-yu.c.chen@intel.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407234258.569681-1-yu.c.chen@intel.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Apr 08, 2022 at 07:42:58AM +0800, Chen Yu wrote:
> Problem statement:
> Once the user has disabled turbo frequency by
> echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo,
> the cfs_rq's util_avg becomes quite small when compared with
> CPU capacity.
> 
> Step to reproduce:
> 
> echo 1 > /sys/devices/system/cpu/intel_pstate/no_turbo
> 
> ./x86_cpuload --count 1 --start 3 --timeout 100 --busy 99
> would launch 1 thread and bind it to CPU3, lasting for 100 seconds,
> with a CPU utilization of 99%. [1]
> 
> top result:
> %Cpu3  : 98.4 us,  0.0 sy,  0.0 ni,  1.6 id,  0.0 wa,  0.0 hi,  0.0 si,  0.0 st
> 
> check util_avg:
> cat /sys/kernel/debug/sched/debug | grep "cfs_rq\[3\]" -A 20 | grep util_avg
>   .util_avg                      : 611
> 
> So the util_avg/cpu capacity is 611/1024, which is much smaller than
> 98.4% shown in the top result.
> 
> This might impact some logic in the scheduler. For example, group_is_overloaded()
> would compare the group_capacity and group_util in the sched group, to
> check if this sched group is overloaded or not. With this gap, even
> when there is a nearly 100% workload, the sched group will not be regarded
> as overloaded. Besides group_is_overloaded(), there are also other victims.
> There is a ongoing work that aims to optimize the task wakeup in a LLC domain.
> The main idea is to stop searching idle CPUs if the sched domain is overloaded[2].
> This proposal also relies on the util_avg/CPU capacity to decide whether the LLC
> domain is overloaded.
> 
> Analysis:
> CPU frequency invariance has caused this difference. In summary,
> the util_sum of cfs rq would decay quite fast when the CPU is in
> idle, when the CPU frequency invariance is enabled.
> 
> The detail is as followed:
> 
> As depicted in update_rq_clock_pelt(), when the frequency invariance
> is enabled, there would be two clock variables on each rq, clock_task
> and clock_pelt:
> 
>    The clock_pelt scales the time to reflect the effective amount of
>    computation done during the running delta time but then syncs back to
>    clock_task when rq is idle.
> 
>    absolute time    | 1| 2| 3| 4| 5| 6| 7| 8| 9|10|11|12|13|14|15|16
>    @ max frequency  ------******---------------******---------------
>    @ half frequency ------************---------************---------
>    clock pelt       | 1| 2|    3|    4| 7| 8| 9|   10|   11|14|15|16
> 
> The fast decay of util_sum during idle is due to:
> 1. rq->clock_pelt is always behind rq->clock_task
> 2. rq->last_update is updated to rq->clock_pelt' after invoking ___update_load_sum()
> 3. Then the CPU becomes idle, the rq->clock_pelt' would be suddenly increased
>    a lot to rq->clock_task
> 4. Enters ___update_load_sum() again, the idle period is calculated by
>    rq->clock_task - rq->last_update, AKA, rq->clock_task - rq->clock_pelt'.
>    The lower the CPU frequency is, the larger the delta =
>    rq->clock_task - rq->clock_pelt' will be. Since the idle period will be
>    used to decay the util_sum only, the util_sum drops significantly during
>    idle period.
> 
> Proposal:
> This symptom is not only caused by disabling turbo frequency, but it
> would also appear if the user limits the max frequency at runtime. Because
> if the frequency is always lower than the max frequency,
> CPU frequency invariance would decay the util_sum quite fast during idle.
> 
> As some end users would disable turbo after boot up, this patch aims to
> present this symptom and deals with turbo scenarios for now. It might
> be ideal if CPU frequency invariance is aware of the max CPU frequency
> (user specified) at runtime in the future.
> 
> [Previous patch seems to be lost on LKML, this is a resend, sorry for any
> inconvenience]
> 
> Link: https://github.com/yu-chen-surf/x86_cpuload.git #1
> Link: https://lore.kernel.org/lkml/20220310005228.11737-1-yu.c.chen@intel.com/ #2
> Signed-off-by: Chen Yu <yu.c.chen@intel.com>

Acked-by: Peter Zijlstra (Intel) <peterz@infradead.org>
