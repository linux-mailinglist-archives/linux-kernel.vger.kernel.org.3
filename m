Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAFE857B1C5
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 09:29:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229863AbiGTH3i (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 03:29:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239946AbiGTH3Z (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 03:29:25 -0400
Received: from mail-yw1-x112d.google.com (mail-yw1-x112d.google.com [IPv6:2607:f8b0:4864:20::112d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4C2C668737
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:29:24 -0700 (PDT)
Received: by mail-yw1-x112d.google.com with SMTP id 00721157ae682-2ef5380669cso164505867b3.9
        for <linux-kernel@vger.kernel.org>; Wed, 20 Jul 2022 00:29:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=/Sy7JcJ1dmobVnb3fQg/V13Gnh8APPk7f+7TIQt7T80=;
        b=N3lCQPt05eW47IhJBlOTcVTBPiOcsMzmhd7AzrhGIpzdqzKrIUE/HseZH4RJiZcL82
         GxJOWXQPorx0i7n/7wcvS+gOOioZrJR2nfeAAfCjSf83Lk2R4PCx/lYMTSi1zeElhFPE
         8ITp4KbS13x5T2SNEkWZqcouztbA0LBtgI3AtT3B1Mh+hpikCe7K/8DpOqKdO1EoggkM
         WFMfa5xMTphUVTyAmrzQQNVtz6Xu15uod/4Jm2R9v7NjE/f9rikNczfBlRoIsDrjBnqD
         nTBR8kpeosAA01zIS0wac86lDN5aa3qk0a3I0nnWEMGc1MsNsHVKoQORamQ+qM2np+nz
         whww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=/Sy7JcJ1dmobVnb3fQg/V13Gnh8APPk7f+7TIQt7T80=;
        b=r3yg4dDZk7nwcd5IsUXjfdQVLl/7fYJq5LdW+15D7PSlVDCsxCDYoWAVr6Dm4AD9wA
         5sbJPBNC6OzKDOAAecwhGndRPHwYjDw4KmBVmmY1EIEqmZdtrjoaN9aULMQ0imp0RMAu
         2dAOb5DyphGEfcSIINGsUg4vRf9Vs1gXidxy3JrZoinyvJrLLtrlGu7bAFpapa6CLNES
         Pi2HIEf0JUnmjTWkq7mA2BbOz70a5t0GIlTjN3aYu9dJajoYFo++fCbgeR2/yaxtMjI0
         se3vHxFsirVl2rXJWXi5Gh25GbiWH4F/i9EV8qFixWmkO1WsMxQtgqv8JtYIoYDGFrMn
         xSyw==
X-Gm-Message-State: AJIora9gwuB2KMqAhlh+UGGVaLHnnERIAITAP0eg8qcUA+xoJ9hMgAz/
        LyrXvnjtL5UA2sikH0bO1kNzMJGALqvDSXWXWz/Bag==
X-Google-Smtp-Source: AGRyM1usZYv56m5DYBnRYBweO1cWhaqczqt5hdd1A0xfQSE/DSkRa3At5i7NNaLWOErdCdHzhEV6wwIR7B5+6fn1zzQ=
X-Received: by 2002:a81:ad0d:0:b0:31e:61a5:3b49 with SMTP id
 l13-20020a81ad0d000000b0031e61a53b49mr5845411ywh.67.1658302163481; Wed, 20
 Jul 2022 00:29:23 -0700 (PDT)
MIME-Version: 1.0
References: <20220629194632.1117723-1-qais.yousef@arm.com> <20220629194632.1117723-2-qais.yousef@arm.com>
 <CAKfTPtBAOLzYocTEg3KErACSyrAWDU94NdR7EAOnW0gti2GiDQ@mail.gmail.com>
 <20220712102334.6nwkbkilmmup4h4u@wubuntu> <CAKfTPtDweeQDRcZb+_ANO6rzZd11vbiatoVxDNwsWPtoCTG+AQ@mail.gmail.com>
 <20220712142013.j6fy77yejupvllah@wubuntu> <CAKfTPtB3pjoFWFP9E6RnH87nshEqJxPdFzX495R_Xju9rCPvEw@mail.gmail.com>
 <20220715103738.ufqv2nhkivlhzy7v@wubuntu>
In-Reply-To: <20220715103738.ufqv2nhkivlhzy7v@wubuntu>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 20 Jul 2022 09:29:12 +0200
Message-ID: <CAKfTPtAXvP-v+A+PgzMAMqqaffxFp+sUuA4NnMDuF91XCSTrVQ@mail.gmail.com>
Subject: Re: [PATCH 1/7] sched/uclamp: Fix relationship between uclamp and
 migration margin
To:     Qais Yousef <qais.yousef@arm.com>
Cc:     Ingo Molnar <mingo@kernel.org>,
        "Peter Zijlstra (Intel)" <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        linux-kernel@vger.kernel.org, Xuewen Yan <xuewen.yan94@gmail.com>,
        Wei Wang <wvw@google.com>,
        Jonathan JMChen <Jonathan.JMChen@mediatek.com>,
        Hank <han.lin@mediatek.com>, Lukasz Luba <lukasz.luba@arm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 15 Jul 2022 at 12:37, Qais Yousef <qais.yousef@arm.com> wrote:
>
> On 07/13/22 14:39, Vincent Guittot wrote:
>
> [...]
>
> > > > That's why I have mentioned that I have thermal pressure and irq in
> > > > mind. I'm speaking about performance level but not about bandwidth and
> > > > time sharing.
> > >
> > > irq pressure has no impact on the cpu's ability to get any OPP, no? It purely
> > > reduces the bandwidth availability for CFS tasks AFAIU. So the task's ability
> > > to achieve a performance level has no correlation with irq pressure IMO. Unless
> > > I missed something.
> >
> > The way irq is accounted in pelt might impact the result. TBH, i
> > haven't looked in details what would be the impact
>
> I can't see how irq can impact what performance level we can achieve on any
> CPU. It should just impact bandwidth?

It impacts the cpu and task utilization as your task utilization is
expressed in the range of the time not used by IRQ so could be lower
than what you think when you compare with uclamp and decide what to do

>
> [...]
>
> > > > more concerned by the thermal pressure as I mentioned previously. As
> > > > an example the thermal pressure reflects the impact on the performance
> > > > while task is running.
> > >
> > > Like we discussed on that RT email thread. If you have a 1024 task, tiny
> > > thermal pressure will make it look like it won't fit anywhere.
> >
> > maybe another big core without pressure. Otherwise if the task can
>
> Isn't thermal pressure per perf domain?

From a scheduler PoV, we don't have any rule on this

>
> > accept a lower compute capacity why not setting uclamp_min to a lower
> > value like 900
>
> Well if the system has lost its top 10% and you're still running as fast as
> the system can possibly do, what better can you do?
>
> I can't see how comparing uclamp with thermal pressure will help.
>
> In feec() we pick the highest spare capacity CPU. So if the bigs were split
> into 1 per perf domain and truly one of them can become severely throttled
> while the other isn't as you're trying to say, then this distribution will pick
> the highest spare capacity one.

The cpu with highest spare capacity might not be the one with highest
performance

>
> fits_capacity() just says this CPU is a candidate that we can consider.
>
> [...]
>
> > > > TaskA usually runs 4 ms every 8ms but wants to ensure a running time
> > > > around 5ms. Task A asks for a uclamp_min of 768.
> > > > medium cpu capacity_orig is 800 but runs at half its max freq because
> > > > of thermal mitigation then your task will runs more than 8ms
> > >
> > > If thermal pressure is 50%, then capacity_of() is 400. A 50% task will have
> > > util_avg of 512, which is much larger than 0.8 * 400. So this is dealt with
> > > already in this code, no?
> >
> > May be my example is not perfect but apply a mitigation of 20% and you
> > fall in the case
>
>         capacity_orig_of(medium) = 800
>         capacity_of(medium) = 800 * 0.8 - sum_of_(irq, rt) pressure :: <= 640
>
>         migration_margin * capacity_of(medium) = 0.8 * 640 = 512 === p->util_avg
>
> So this task will struggle still to run on the medium even under 20% pressure.

you are nitpicking. 19.75% should be ok

>
> I can see your point for sure that we could have scenarios where we should pick
> a bigger CPU. But my counter point is that if there's a meaningful thermal
> pressure we are screwed already and uclamp can't save the day.

uclamp can save it by triggering the search of another cpu with lower pressure

>
> I'll repeat my question, how would you encode the relationship?
>
> Consider these scenarios:
>
>
>         capaity_orig_of(little) = 400
>         capaity_orig_of(medium) = 800
>         capaity_orig_of(big) = 1024
>
>         p0->util_avg = 300
>         p0->uclamp_min = 800
>
>         p1->util_avg = 300
>         p1->uclamp_min = 1024
>
>
> When there's 10% thermal pressure on all CPUs.
>
> Does p1 fit on big still? Fit here means the  big is a viable candidate from
> uclamp point of view.

I agree that this one is tricky because if all cpus are throttled,
there is no cpu but it's worth looking for the big cpu with lowest
throttling otherwise

>
> How would you define the relationship so that p0 will not fit the medium, but
> p1 still fits the big.

I would compare uclamp_min with capacity_orig() - thermal pressure to
decide if we should look for another cpu

>
> What happens when thermal pressure is 1%? Should p0 still fit on the medium
> then? As Lukasz highlighted in other email threads, the decay of thermal
> pressure signal has a very long tail.
>
>
> Thanks!
>
> --
> Qais Yousef
