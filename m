Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2E803589DFD
	for <lists+linux-kernel@lfdr.de>; Thu,  4 Aug 2022 16:59:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240080AbiHDO7Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 4 Aug 2022 10:59:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231396AbiHDO7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 4 Aug 2022 10:59:23 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 4A3811F637
        for <linux-kernel@vger.kernel.org>; Thu,  4 Aug 2022 07:59:22 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id AEA71113E;
        Thu,  4 Aug 2022 07:59:22 -0700 (PDT)
Received: from wubuntu (unknown [10.57.10.177])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 9BD6E3F73B;
        Thu,  4 Aug 2022 07:59:20 -0700 (PDT)
Date:   Thu, 4 Aug 2022 15:59:19 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 1/7] sched/uclamp: Fix relationship between uclamp and
 migration margin
Message-ID: <20220804145919.hspv7atwzy4zgifu@wubuntu>
References: <20220629194632.1117723-2-qais.yousef@arm.com>
 <CAKfTPtBAOLzYocTEg3KErACSyrAWDU94NdR7EAOnW0gti2GiDQ@mail.gmail.com>
 <20220712102334.6nwkbkilmmup4h4u@wubuntu>
 <CAKfTPtDweeQDRcZb+_ANO6rzZd11vbiatoVxDNwsWPtoCTG+AQ@mail.gmail.com>
 <20220712142013.j6fy77yejupvllah@wubuntu>
 <CAKfTPtB3pjoFWFP9E6RnH87nshEqJxPdFzX495R_Xju9rCPvEw@mail.gmail.com>
 <20220715103738.ufqv2nhkivlhzy7v@wubuntu>
 <CAKfTPtAXvP-v+A+PgzMAMqqaffxFp+sUuA4NnMDuF91XCSTrVQ@mail.gmail.com>
 <20220721140431.cl73bhn6ydzdhdkm@wubuntu>
 <20220722151300.GA30193@vingu-book>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220722151300.GA30193@vingu-book>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/22/22 17:13, Vincent Guittot wrote:

[...]

> Using capacity_orig_of(cpu) - thermal_load_avg(rq_of(cpu)) seems like
> a simple solution to cover thermal mitigation
> 
> Also I was looking more deeply at your condition and get hard time to
> understand why uclamp_max_fits needs to be false when both
> (capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE) ?
> 
> +       max_capacity = (capacity_orig == SCHED_CAPACITY_SCALE) &&
> (uclamp_max == SCHED_CAPACITY_SCALE);
> +       uclamp_max_fits = !max_capacity && (uclamp_max <= capacity_orig);
> +       fits = fits || uclamp_max_fits;
> 
> For task I would have done only :
> 
> +       capacity_orig = capacity_orig_of(cpu) - thermal_load_avg(rq_of(cpu));
> +       uclamp_max_fits = (uclamp_max <= capacity_orig);
>        fits = fits || uclamp_max_fits;

I just sent v2, and it's good to clarify what I have considered so far:

uclamp_max shouldn't care about thermal pressure except for capacity inversion
case. The goal of uclamp_max is to cap the task and the weak affinity part of
the hint is important to honour. So transient thermal pressure is not a problem
from fitness point of view. uclamp_max means it shouldn't exceed this perf
level, it's okay to be capped at a less value.

And ignoring the max_capacity check for tasks will actually create problems
because feec() will wrongly force fit tasks on the biggest cores only for
overutilized state to trigger later.

To preserve the current behavior, feec() should bailout and let the other logic
in select_task_rq_fair() fallback to the next best thing.

To do that, we need both call sites to behave the same.

> 
> and I would use a different one for cpu_overutlized in orde to discard the test
> with uclamp_max if uclamp_max one equals SCHED_CAPACITY_SCALE
> 
> +       uclamp_max_fits = (uclamp_max <= capacity_orig) && (uclamp_max != SCHED_CAPACITY_SCALE);

I opted to keep the logic encapsulated in util_fits_cpu(). I was wary that not
having coherent logic for all call sites will lead to random behavior changes.
Especially in the wake up path.

> and I don't think that we should compare uclamp_min <= capacity_orig for
> cpu_overutlized() but only for task to detect misfit one because uclamp_min is
> a performance hint not a bandwidth as you said previously.

I'd agree only for the corner case where capacity_orig == SCHED_CAPACITY_SCALE.

But for others it actually defeats the purpose of uclamp_min. If the user
dynamically controls uclamp_min (there are already users in android), then we
should detect if we need to migrate the task to a bigger CPU at the tick,
otherwise the new uclamp_min will only be honoured on the next wake up.

This doesn't contradict the performance hint nature of uclamp. If it requests
a uclamp_min = 1024 for example but it's already running on a little or medium
CPU, then by not triggering a misfit migration we prevent the task from
obtaining the performance level it asked for until the next wake up. Which
might end up being too late and impact the user experience already.


Thanks!

--
Qais Yousef
