Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 402B1511646
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 13:34:08 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231703AbiD0LHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 07:07:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232218AbiD0LGp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 07:06:45 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0CDAE36CE0A
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 03:58:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id BB0E5ED1;
        Wed, 27 Apr 2022 03:58:47 -0700 (PDT)
Received: from wubuntu (unknown [10.57.77.199])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 208FF3F5A1;
        Wed, 27 Apr 2022 03:58:46 -0700 (PDT)
Date:   Wed, 27 Apr 2022 11:58:44 +0100
From:   Qais Yousef <qais.yousef@arm.com>
To:     Xuewen Yan <xuewen.yan94@gmail.com>
Cc:     Xuewen Yan <xuewen.yan@unisoc.com>, dietmar.eggemann@arm.com,
        lukasz.luba@arm.com, rafael@kernel.org, viresh.kumar@linaro.org,
        mingo@redhat.com, peterz@infradead.org, vincent.guittot@linaro.org,
        rostedt@goodmis.org, linux-kernel@vger.kernel.org,
        di.shen@unisoc.com
Subject: Re: [PATCH] sched: Take thermal pressure into account when determine
 rt fits capacity
Message-ID: <20220427105844.otru4yohja4s23ye@wubuntu>
References: <20220407051932.4071-1-xuewen.yan@unisoc.com>
 <20220420135127.o7ttm5tddwvwrp2a@airbuntu>
 <CAB8ipk-tWjkeAbV=BDhNy04Yq6rdLf80x_7twuLV=HqT4nc1+w@mail.gmail.com>
 <20220421161509.asz25zmh25eurgrk@airbuntu>
 <CAB8ipk_rZnwDrMaY-zJxR3pByYWD1XOP2waCgU9DZzQNpCN2zA@mail.gmail.com>
 <20220425161209.ydugtrs3b7gyy3kk@airbuntu>
 <CAB8ipk9hZXDcTV3hakRV+dE5dwKtg-Ka93WZ60ds0=4ErN1-0w@mail.gmail.com>
 <20220426092142.lppfj5eqgt3d24nb@airbuntu>
 <CAB8ipk_tM8WhZOLwURkqyi5XDSNJ=twOg1Zub=dsTB_b9N9BRg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAB8ipk_tM8WhZOLwURkqyi5XDSNJ=twOg1Zub=dsTB_b9N9BRg@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 04/27/22 09:38, Xuewen Yan wrote:
> > > > The best (simplest) way forward IMHO is to introduce a new function
> > > >
> > > >         bool cpu_in_capacity_inversion(int cpu);
> > > >
> > > > (feel free to pick another name) which will detect the scenario you're in. You
> > > > can use this function then in rt_task_fits_capacity()
> > > >
> > > >         diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > > >         index a32c46889af8..d48811a7e956 100644
> > > >         --- a/kernel/sched/rt.c
> > > >         +++ b/kernel/sched/rt.c
> > > >         @@ -462,6 +462,9 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> > > >                 if (!static_branch_unlikely(&sched_asym_cpucapacity))
> > > >                         return true;
> > > >
> > > >         +       if (cpu_in_capacity_inversion(cpu))
> > > >         +               return false;
> > > >         +
> > > >                 min_cap = uclamp_eff_value(p, UCLAMP_MIN);
> > > >                 max_cap = uclamp_eff_value(p, UCLAMP_MAX);
> > > >
> > > > You'll probably need to do something similar in dl_task_fits_capacity().
> > > >
> > > > This might be a bit aggressive though as we'll steer away all RT tasks from
> > > > this CPU (as long as there's another CPU that can fit it). I need to think more
> > > > about it. But we could do something like this too
> > > >
> > > >         diff --git a/kernel/sched/rt.c b/kernel/sched/rt.c
> > > >         index a32c46889af8..f2a34946a7ab 100644
> > > >         --- a/kernel/sched/rt.c
> > > >         +++ b/kernel/sched/rt.c
> > > >         @@ -462,11 +462,14 @@ static inline bool rt_task_fits_capacity(struct task_struct *p, int cpu)
> > > >                 if (!static_branch_unlikely(&sched_asym_cpucapacity))
> > > >                         return true;
> > > >
> > > >         +       cpu_cap = capacity_orig_of(cpu);
> > > >         +
> > > >         +       if (cpu_in_capacity_inversion(cpu))
> > >
> > > It's  a good idea, but as you said, in mainline, the
> > > sysctl_sched_uclamp_util_min_rt_default is always 1024,
> > > Maybe it's better to add it to the judgment?
> >
> > I don't think so. If we want to handle finding the next best thing, we need to
> > make the search more complex than that. This is no worse than having 2 RT tasks
> > waking up at the same time while there's only a single big CPU. One of them
> > will end up on a medium or a little and we don't provide better guarantees
> > here.
> 
> I may have misunderstood your patch before, do you mean this:
> 1. the cpu has to be inversion, if not, the cpu's capacity is still
> the biggest, although the sysctl_sched_uclamp_util_min_rt_default
> =1024, it still can put on the cpu.
> 2. If the cpu is inversion, the thermal pressure should be considered,
> at this time, if the sysctl_sched_uclamp_util_min_rt_default is not
> 1024, make the rt still have chance to select the cpu.
>     If the sysctl_sched_uclamp_util_min_rt_default is 1024, all of the
> cpu actually can not fit the rt, at this time, select cpu without
> considering the cap_orig_of(cpu). The worst thing may be that  rt
> would put on the small core.
> 
> I understand right? If so, Perhaps this approach has the least impact
> on the current code complexity.

I believe you understood correctly. Tasks that need to run at 1024 when the
biggest cpu is in capacity inversion will get screwed - the system can't
satisfy their requirements. If they're happy to run on a medium (the next best
thing), then their uclamp_min should change to reflect that. If they are not
happy to run at the medium, then I'm not sure if it'll make much of
a difference if they end up on little. Their deadline will be missed anyway..

Again this is no worse than having two RT tasks with uclamp_min = 1024 waking
up at the same time on a system with 1 big cpu. Only one of them will be able
to run there.

I think tasks wanting 1024 is rare and no one seemed to bother with doing
better here so far. But we can certainly do better if need to :-)


Thanks

--
Qais Yousef
