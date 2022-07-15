Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 62834575F76
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 12:37:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231244AbiGOKho (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 06:37:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40080 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229436AbiGOKhm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 06:37:42 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 5CE91753BB
        for <linux-kernel@vger.kernel.org>; Fri, 15 Jul 2022 03:37:41 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 8AC9B1474;
        Fri, 15 Jul 2022 03:37:41 -0700 (PDT)
Received: from wubuntu (unknown [10.57.87.59])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B8BA73F792;
        Fri, 15 Jul 2022 03:37:39 -0700 (PDT)
Date:   Fri, 15 Jul 2022 11:37:38 +0100
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
Message-ID: <20220715103738.ufqv2nhkivlhzy7v@wubuntu>
References: <20220629194632.1117723-1-qais.yousef@arm.com>
 <20220629194632.1117723-2-qais.yousef@arm.com>
 <CAKfTPtBAOLzYocTEg3KErACSyrAWDU94NdR7EAOnW0gti2GiDQ@mail.gmail.com>
 <20220712102334.6nwkbkilmmup4h4u@wubuntu>
 <CAKfTPtDweeQDRcZb+_ANO6rzZd11vbiatoVxDNwsWPtoCTG+AQ@mail.gmail.com>
 <20220712142013.j6fy77yejupvllah@wubuntu>
 <CAKfTPtB3pjoFWFP9E6RnH87nshEqJxPdFzX495R_Xju9rCPvEw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <CAKfTPtB3pjoFWFP9E6RnH87nshEqJxPdFzX495R_Xju9rCPvEw@mail.gmail.com>
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 07/13/22 14:39, Vincent Guittot wrote:

[...]

> > > That's why I have mentioned that I have thermal pressure and irq in
> > > mind. I'm speaking about performance level but not about bandwidth and
> > > time sharing.
> >
> > irq pressure has no impact on the cpu's ability to get any OPP, no? It purely
> > reduces the bandwidth availability for CFS tasks AFAIU. So the task's ability
> > to achieve a performance level has no correlation with irq pressure IMO. Unless
> > I missed something.
> 
> The way irq is accounted in pelt might impact the result. TBH, i
> haven't looked in details what would be the impact

I can't see how irq can impact what performance level we can achieve on any
CPU. It should just impact bandwidth?

[...]

> > > more concerned by the thermal pressure as I mentioned previously. As
> > > an example the thermal pressure reflects the impact on the performance
> > > while task is running.
> >
> > Like we discussed on that RT email thread. If you have a 1024 task, tiny
> > thermal pressure will make it look like it won't fit anywhere.
> 
> maybe another big core without pressure. Otherwise if the task can

Isn't thermal pressure per perf domain?

> accept a lower compute capacity why not setting uclamp_min to a lower
> value like 900

Well if the system has lost its top 10% and you're still running as fast as
the system can possibly do, what better can you do?

I can't see how comparing uclamp with thermal pressure will help.

In feec() we pick the highest spare capacity CPU. So if the bigs were split
into 1 per perf domain and truly one of them can become severely throttled
while the other isn't as you're trying to say, then this distribution will pick
the highest spare capacity one.

fits_capacity() just says this CPU is a candidate that we can consider.

[...]

> > > TaskA usually runs 4 ms every 8ms but wants to ensure a running time
> > > around 5ms. Task A asks for a uclamp_min of 768.
> > > medium cpu capacity_orig is 800 but runs at half its max freq because
> > > of thermal mitigation then your task will runs more than 8ms
> >
> > If thermal pressure is 50%, then capacity_of() is 400. A 50% task will have
> > util_avg of 512, which is much larger than 0.8 * 400. So this is dealt with
> > already in this code, no?
> 
> May be my example is not perfect but apply a mitigation of 20% and you
> fall in the case

	capacity_orig_of(medium) = 800
	capacity_of(medium) = 800 * 0.8 - sum_of_(irq, rt) pressure :: <= 640

	migration_margin * capacity_of(medium) = 0.8 * 640 = 512 === p->util_avg

So this task will struggle still to run on the medium even under 20% pressure.

I can see your point for sure that we could have scenarios where we should pick
a bigger CPU. But my counter point is that if there's a meaningful thermal
pressure we are screwed already and uclamp can't save the day.

I'll repeat my question, how would you encode the relationship?

Consider these scenarios:


	capaity_orig_of(little) = 400
	capaity_orig_of(medium) = 800
	capaity_orig_of(big) = 1024

	p0->util_avg = 300
	p0->uclamp_min = 800

	p1->util_avg = 300
	p1->uclamp_min = 1024


When there's 10% thermal pressure on all CPUs.

Does p1 fit on big still? Fit here means the  big is a viable candidate from
uclamp point of view.

How would you define the relationship so that p0 will not fit the medium, but
p1 still fits the big.

What happens when thermal pressure is 1%? Should p0 still fit on the medium
then? As Lukasz highlighted in other email threads, the decay of thermal
pressure signal has a very long tail.


Thanks!

--
Qais Yousef
