Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A044757E38F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 17:13:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229936AbiGVPNQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 11:13:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235700AbiGVPNG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 11:13:06 -0400
Received: from mail-wr1-x433.google.com (mail-wr1-x433.google.com [IPv6:2a00:1450:4864:20::433])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 606D29B56E
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:13:05 -0700 (PDT)
Received: by mail-wr1-x433.google.com with SMTP id m17so6634035wrw.7
        for <linux-kernel@vger.kernel.org>; Fri, 22 Jul 2022 08:13:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=V5JHeSKVBjjp6WOmXqzUHLj9Pb9TjTX95+Bmy8kYM6w=;
        b=e16jDxFMSvfWxbIFlns8FxhQKaR1pEnqAan5o3rV82OxMmjjcD28zbfJWH1Ins3dep
         TsuNrj+UbJda6fTtijo8lgPD0Zqfjld5ZgdCJbOvu99CrPgywQgZ8FfXJprTnwo0yJtG
         pQP7B57CKvK0QBqLfK7z7Pvb7Sp/+L0S7XU8Ay0hn9gURjitBii2mWQrATylS78oGwif
         y/CG+FcwGfft1c7mDwo02AgXfVYH8EgAWzWdM3DHw7bb+H9l2W/oJNj2yRW/xgsq1y+A
         Ff0hfA6kawmTzn9WZLMTsNZEEORg2oi6KCdNboCCstFNlZehxLpBbAe0SmJeQtxDPkfn
         Swlw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=V5JHeSKVBjjp6WOmXqzUHLj9Pb9TjTX95+Bmy8kYM6w=;
        b=g65/MdsN+WG0Cc0dn9+BzeuSdY9tdpdGPPxAzlyHQk5ptcmcUBDXgYaXtQDwS5J/H4
         IbaeO1lHSBLqb0XNCB3I7yqfabh3clU8G3IJdYYleKSccLVfQAj32jiK+16bJipQpxF8
         lngDXFFx1Q8uxJf7sealXKyU4MvKv7YCdsNPT1xW5MD0b48uhDUg6CsOQZ3n9qZ0IO3C
         d7ZHFgyzcEbpXtFGi7Dq/Z8yWF/m9tbkpBJSWmAhnbsWzkTxINixvo/7R97Qp1f6aoBK
         pS8+GY9L/Cm0IBH44k4w62WviRXs5DHfhVVKUqT1N0mq1mamWV9LGmkowUSzIRvkndkP
         6IWg==
X-Gm-Message-State: AJIora/qzFi3sg7TY6w/7N9+UUMSwcXbHfSDDA+BQFwHLKMwqFNHrHLX
        PIVgQp/yh8lbBoVveTafJ4OBAQ==
X-Google-Smtp-Source: AGRyM1szclXbr2E4W1j6uyAiPnJOgY515fqRphFvS7VMt9KQRtQiBj9CfnedvOJBIfEaPPOfEU9F8g==
X-Received: by 2002:adf:fb12:0:b0:20c:79b2:a200 with SMTP id c18-20020adffb12000000b0020c79b2a200mr257178wrr.617.1658502783593;
        Fri, 22 Jul 2022 08:13:03 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:a949:104c:3ba5:5555])
        by smtp.gmail.com with ESMTPSA id a8-20020adfe5c8000000b0021e5d77a489sm2733354wrn.31.2022.07.22.08.13.02
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Fri, 22 Jul 2022 08:13:02 -0700 (PDT)
Date:   Fri, 22 Jul 2022 17:13:00 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Lukasz Luba <lukasz.luba@arm.com>
Subject: Re: [PATCH 1/7] sched/uclamp: Fix relationship between uclamp and
 migration margin
Message-ID: <20220722151300.GA30193@vingu-book>
References: <20220629194632.1117723-1-qais.yousef@arm.com>
 <20220629194632.1117723-2-qais.yousef@arm.com>
 <CAKfTPtBAOLzYocTEg3KErACSyrAWDU94NdR7EAOnW0gti2GiDQ@mail.gmail.com>
 <20220712102334.6nwkbkilmmup4h4u@wubuntu>
 <CAKfTPtDweeQDRcZb+_ANO6rzZd11vbiatoVxDNwsWPtoCTG+AQ@mail.gmail.com>
 <20220712142013.j6fy77yejupvllah@wubuntu>
 <CAKfTPtB3pjoFWFP9E6RnH87nshEqJxPdFzX495R_Xju9rCPvEw@mail.gmail.com>
 <20220715103738.ufqv2nhkivlhzy7v@wubuntu>
 <CAKfTPtAXvP-v+A+PgzMAMqqaffxFp+sUuA4NnMDuF91XCSTrVQ@mail.gmail.com>
 <20220721140431.cl73bhn6ydzdhdkm@wubuntu>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220721140431.cl73bhn6ydzdhdkm@wubuntu>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le jeudi 21 juil. 2022 à 15:04:31 (+0100), Qais Yousef a écrit :
> On 07/20/22 09:29, Vincent Guittot wrote:
> > On Fri, 15 Jul 2022 at 12:37, Qais Yousef <qais.yousef@arm.com> wrote:
> > >
> > > On 07/13/22 14:39, Vincent Guittot wrote:
> > >
> > > [...]
> > >
> > > > > > That's why I have mentioned that I have thermal pressure and irq in
> > > > > > mind. I'm speaking about performance level but not about bandwidth and
> > > > > > time sharing.
> > > > >
> > > > > irq pressure has no impact on the cpu's ability to get any OPP, no? It purely
> > > > > reduces the bandwidth availability for CFS tasks AFAIU. So the task's ability
> > > > > to achieve a performance level has no correlation with irq pressure IMO. Unless
> > > > > I missed something.
> > > >
> > > > The way irq is accounted in pelt might impact the result. TBH, i
> > > > haven't looked in details what would be the impact
> > >
> > > I can't see how irq can impact what performance level we can achieve on any
> > > CPU. It should just impact bandwidth?
> > 
> > It impacts the cpu and task utilization as your task utilization is
> > expressed in the range of the time not used by IRQ so could be lower
> > than what you think when you compare with uclamp and decide what to do
> 
> I need more helping hand to understand please.
> 
> So for the case of uclamp_min = 1024, this request means:
> 
> 	When I run, I want to run at max performance point of the system.
> 
> Which translates into running at highest frequency on SMP, and highest
> frequency + biggest CPU on HMP.
> 
> If a CPU has irq pressure, how this will prevent the task from running at
> highest frequency? What am I missing?

I was thinking of the case of uclamp_min not being 1024. But the real
task util_avg (ie including the impact of irq pressure) will be always
lower than the task clock version so the comparison with uclamp_min will
always be satisfied.

> 
> I am assuming that the task is actually small so it will never be able to run
> at max frequency without this hint, ie: util_avg = 300.
> 
> Keep in mind that util_fits_cpu() still verifies that util_avg is within the
> 80% range of capacity_of() which takes into account all types of pressures.
> 
> > 
> > >
> > > [...]
> > >
> > > > > > more concerned by the thermal pressure as I mentioned previously. As
> > > > > > an example the thermal pressure reflects the impact on the performance
> > > > > > while task is running.
> > > > >
> > > > > Like we discussed on that RT email thread. If you have a 1024 task, tiny
> > > > > thermal pressure will make it look like it won't fit anywhere.
> > > >
> > > > maybe another big core without pressure. Otherwise if the task can
> > >
> > > Isn't thermal pressure per perf domain?
> > 
> > From a scheduler PoV, we don't have any rule on this
> > 
> > >
> > > > accept a lower compute capacity why not setting uclamp_min to a lower
> > > > value like 900
> > >
> > > Well if the system has lost its top 10% and you're still running as fast as
> > > the system can possibly do, what better can you do?
> > >
> > > I can't see how comparing uclamp with thermal pressure will help.
> > >
> > > In feec() we pick the highest spare capacity CPU. So if the bigs were split
> > > into 1 per perf domain and truly one of them can become severely throttled
> > > while the other isn't as you're trying to say, then this distribution will pick
> > > the highest spare capacity one.
> > 
> > The cpu with highest spare capacity might not be the one with highest
> > performance
> 
> True. But all of this is best effort. And I think this is good enough for the
> common case. I don't mind addressing the thermal problem, but it's not a simple
> one. And there's a complexity cost that is AFAICS is high.
> 

Using capacity_orig_of(cpu) - thermal_load_avg(rq_of(cpu)) seems like
a simple solution to cover thermal mitigation

Also I was looking more deeply at your condition and get hard time to
understand why uclamp_max_fits needs to be false when both
(capacity_orig == SCHED_CAPACITY_SCALE) && (uclamp_max == SCHED_CAPACITY_SCALE) ?

+       max_capacity = (capacity_orig == SCHED_CAPACITY_SCALE) &&
(uclamp_max == SCHED_CAPACITY_SCALE);
+       uclamp_max_fits = !max_capacity && (uclamp_max <= capacity_orig);
+       fits = fits || uclamp_max_fits;

For task I would have done only :

+       capacity_orig = capacity_orig_of(cpu) - thermal_load_avg(rq_of(cpu));
+       uclamp_max_fits = (uclamp_max <= capacity_orig);
       fits = fits || uclamp_max_fits;

and I would use a different one for cpu_overutlized in orde to discard the test
with uclamp_max if uclamp_max one equals SCHED_CAPACITY_SCALE

+       uclamp_max_fits = (uclamp_max <= capacity_orig) && (uclamp_max != SCHED_CAPACITY_SCALE);

and I don't think that we should compare uclamp_min <= capacity_orig for
cpu_overutlized() but only for task to detect misfit one because uclamp_min is
a performance hint not a bandwidth as you said previously.

> > 
> > >
> > > fits_capacity() just says this CPU is a candidate that we can consider.
> > >
> > > [...]
> > >
> > > > > > TaskA usually runs 4 ms every 8ms but wants to ensure a running time
> > > > > > around 5ms. Task A asks for a uclamp_min of 768.
> > > > > > medium cpu capacity_orig is 800 but runs at half its max freq because
> > > > > > of thermal mitigation then your task will runs more than 8ms
> > > > >
> > > > > If thermal pressure is 50%, then capacity_of() is 400. A 50% task will have
> > > > > util_avg of 512, which is much larger than 0.8 * 400. So this is dealt with
> > > > > already in this code, no?
> > > >
> > > > May be my example is not perfect but apply a mitigation of 20% and you
> > > > fall in the case
> > >
> > >         capacity_orig_of(medium) = 800
> > >         capacity_of(medium) = 800 * 0.8 - sum_of_(irq, rt) pressure :: <= 640
> > >
> > >         migration_margin * capacity_of(medium) = 0.8 * 640 = 512 === p->util_avg
> > >
> > > So this task will struggle still to run on the medium even under 20% pressure.
> > 
> > you are nitpicking. 19.75% should be ok
> 
> I was just trying to highlight it took a bit of effort to reach to the corner
> case. Which indicates the corner case is specific.

hmmm 19%.75% is not a corner case, i was just lazy to compute the exact number

> 
> > 
> > >
> > > I can see your point for sure that we could have scenarios where we should pick
> > > a bigger CPU. But my counter point is that if there's a meaningful thermal
> > > pressure we are screwed already and uclamp can't save the day.
> > 
> > uclamp can save it by triggering the search of another cpu with lower pressure
> 
> How would you do that?
> 
> If a task hints towards uclamp_min = 1024. If there's 1% pressure on all cpus,
> is triggering overutilized right? What's tripping me off is how would you do
> that fallback gracefully?
> 

As proposed above, you should use different rules for cpu_overutilized
and task fits cpus to make a difference beteen overutlized cpu and misfit task

> > 
> > >
> > > I'll repeat my question, how would you encode the relationship?
> > >
> > > Consider these scenarios:
> > >
> > >
> > >         capaity_orig_of(little) = 400
> > >         capaity_orig_of(medium) = 800
> > >         capaity_orig_of(big) = 1024
> > >
> > >         p0->util_avg = 300
> > >         p0->uclamp_min = 800
> > >
> > >         p1->util_avg = 300
> > >         p1->uclamp_min = 1024
> > >
> > >
> > > When there's 10% thermal pressure on all CPUs.
> > >
> > > Does p1 fit on big still? Fit here means the  big is a viable candidate from
> > > uclamp point of view.
> > 
> > I agree that this one is tricky because if all cpus are throttled,
> > there is no cpu but it's worth looking for the big cpu with lowest
> > throttling otherwise
> 
> If there's an easy path to achieving this, I'm happy to try it.
> 
> > 
> > >
> > > How would you define the relationship so that p0 will not fit the medium, but
> > > p1 still fits the big.
> > 
> > I would compare uclamp_min with capacity_orig() - thermal pressure to
> > decide if we should look for another cpu
> 
> Are you referring to instantaneous pressure here? Because with the average
> signal we would take a long time to decay, and lose a lot of opportunities to
> do better. And this is really the crust of the problem.
> 
> My understanding has been is that this signal can easily be non-zero. But maybe
> I need to re-evaluate that if you don't see this as a problem.
> 
> Maybe with Lukasz patch to speed up the decaying we can do better?
> 
> 	https://lore.kernel.org/lkml/20220429091245.12423-1-lukasz.luba@arm.com/
> 
> 
> But even then, the case of
> 
> 	capaity_orig_of(little) = 400
> 	capaity_orig_of(medium) = 800
> 	capaity_orig_of(big) = 1024
> 
> 	p0->util_avg = 300
> 	p0->uclamp_min = 1024
> 
> would unnecessarily trigger overutilized for all values of thermal pressure up
> to ~20% on the big cores. Which I see is wrong.
> 
> IMO better here means keeping the task on the big core is this honours the best
> available performance hint. Only exception is if we go into capacity inversion,
> which I think we can handle.
> 
> 
> Thanks
> 
> --
> Qais Yousef
> 
> > 
> > >
> > > What happens when thermal pressure is 1%? Should p0 still fit on the medium
> > > then? As Lukasz highlighted in other email threads, the decay of thermal
> > > pressure signal has a very long tail.
> > >
> > >
> > > Thanks!
> > >
> > > --
> > > Qais Yousef
