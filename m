Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AAFE7493B07
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 14:22:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354777AbiASNWu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 08:22:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57886 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354669AbiASNWn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 08:22:43 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ED1D6C06173F
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 05:22:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id x11so9371935lfa.2
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 05:22:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=K4NxkHaCPaZxAktRY7Z9j13Y+DVG/4Ag2JSyRXHqb24=;
        b=ti8Gh06talRe37sOC29PCTTLR6mADi2r7ZHqYaJ5sSLO1zKq5s6E6T3q//czKCW1gM
         JGha1wvCDGvl6QtuhvFxn3BdefYyH87USpFeB7wGsibh5eciB9mcxBO0wN5Dx4OY85/p
         Z7ikhOitXFCQNo7KkI/zK/WT+j5FGaMJb2DDzjQ7P79MtllzXplRscjBTYceV/xvTD+b
         j/aiMVtBriFmAN8WH0ijWgLN9t5EcbZsRLLEYOINaWTZfqFyWu3WjWnalXqtj2cumrrk
         1n8d1Hf79gSwW3QqQ7D1lRK2QodZ5O6X0gD/RUB36B8+UeVgxCUEfXRcLVg41kkbr5Lb
         A8Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=K4NxkHaCPaZxAktRY7Z9j13Y+DVG/4Ag2JSyRXHqb24=;
        b=qva6ySd+NXDxix8KoE87bRE9u0TOMLyc28hBqslSNemy/UHBf0Eury1CMJuAkSVkee
         QxXWwa9IBRegTXXvc2z8Zp1F0FKicB4dt3JjsYFBsMAymp2ji7nLYBVRC08OPyjDylzD
         ezmHoYhBA+52qWzyhxkTIPAhGkSMoJLc3sSJdXfcbkgOoZtubM+g+9XZtH+kidBkLDdQ
         YmK0JgfZth/8+BvSOvO8RSOXGQqA0EXP2umn8o+5qEteCsYXumzaugKEzrjxyZpmXbaw
         atOIM2h3L/x+unerjMgsWFYwqIOj0bdJdU6pHpv7X6LlHqJgU7hobM/FlSUauIW0VzFp
         Ku2Q==
X-Gm-Message-State: AOAM530v5bAsITrt2JsfNO9ezwqFnilagvXQQGRpRjtsWBw4Dz9TzjHD
        DwKKuQhI6bTNFWyFx2Ne5av6JRhAJDNOeqbeqLjlSA==
X-Google-Smtp-Source: ABdhPJx6GoAj8bSptRZ68c+ctdvk5tpIiiiFZFiN9pmrER+fTAfDbHQjRp8i5/be41dPbatXScHf/0ieDl9tc/5GPIs=
X-Received: by 2002:a05:6512:308d:: with SMTP id z13mr18136533lfd.523.1642598561229;
 Wed, 19 Jan 2022 05:22:41 -0800 (PST)
MIME-Version: 1.0
References: <20220112161230.836326-1-vincent.donnefort@arm.com>
 <20220112161230.836326-3-vincent.donnefort@arm.com> <CAKfTPtC2wCw4U9w=saW0dGYHfOKo42nBKU7oHcEM7KeDj7MzWA@mail.gmail.com>
 <Yeac5Y5Fzu/jaUf0@FVFF7649Q05P> <CAKfTPtAdTTP+qGruYy8gi6rfhS0W1gAdjgeLCtrLZHxyCEHo9g@mail.gmail.com>
 <Yef8kTnlP5h4I7/1@FVFF7649Q05P>
In-Reply-To: <Yef8kTnlP5h4I7/1@FVFF7649Q05P>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Wed, 19 Jan 2022 14:22:28 +0100
Message-ID: <CAKfTPtB=CJNFDrpXY9o8g5XfjBfnVTUgb2rWke1SyWMUxz0M+g@mail.gmail.com>
Subject: Re: [PATCH v2 2/7] sched/fair: Decay task PELT values during migration
To:     Vincent Donnefort <Vincent.Donnefort@arm.com>
Cc:     peterz@infradead.org, mingo@redhat.com,
        linux-kernel@vger.kernel.org, dietmar.eggemann@arm.com,
        Valentin.Schneider@arm.com, Morten.Rasmussen@arm.com,
        Chris.Redpath@arm.com, qperret@google.com, Lukasz.Luba@arm.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 19 Jan 2022 at 12:59, Vincent Donnefort
<vincent.donnefort@arm.com> wrote:
>
> [...]
>
> > > >
> > > > This has several shortfalls:
> > > > - have a look at cfs_rq_clock_pelt() and rq_clock_pelt(). What you
> > > > name clock_pelt in your commit message and is used to update PELT and
> > > > saved in se->avg.last_update_time is : rq->clock_pelt -
> > > > rq->lost_idle_time - cfs_rq->throttled_clock_task_time
> > >
> > > That's why, the PELT "lag" is added onto se->avg.last_update_time. (see the last
> > > paragraph of the commit message) The estimator is just a time delta, that is
> > > added on top of the entity's last_update_time. I don't see any problem with the
> > > lost_idle_time here.
> >
> > lost_idle_time is updated before entering idle and after your
> > clock_pelt_lag has been updated. This means that the delta that you
> > are computing can be wrong
> >
> > I haven't look in details but similar problem probably happens for
> > throttled_clock_task_time
> >
> > >
> > > > - you are doing this whatever the state of the cpu : idle or not. But
> > > > the clock cycles are not accounted for in the same way in both cases.
> > >
> > > If the CPU is idle and clock_pelt == clock_task, the component A of the
> > > estimator would be 0 and we only would account for how outdated is the rq's
> > > clock, i.e. component B.
> >
> > And if cpu is not idle, you can't apply the diff between clk_pelt and clock_task
> >
> > >
> > > > - (B) doesn't seem to be accurate as you skip irq and steal time
> > > > accounting and you don't apply any scale invariance if the cpu is not
> > > > idle
> > >
> > > The missing irq and paravirt time is the reason why it is called "estimator".
> > > But maybe there's a chance of improving this part with a lockless version of
> > > rq->prev_irq_time and rq->prev_steal_time_rq?
> > >
> > > > - IIUC your explanation in the commit message above, the (A) period
> > > > seems to be a problem only when idle but you apply it unconditionally.
> > >
> > > If the CPU is idle (and clock_pelt == clock_task), only the B part would be
> > > worth something:
> > >
> > >   A + B = [clock_task - clock_pelt] + [sched_clock_cpu() - clock]
> > >                       A                            B
> > >
> > > > If cpu is idle you can assume that clock_pelt should be equal to
> > > > clock_task but you can't if cpu is not idle otherwise your sync will
> > > > be inaccurate and defeat the primary goal of this patch. If your
> > > > problem with clock_pelt is that the pending idle time is not accounted
> > > > for when entering idle but only at the next update (update blocked
> > > > load or wakeup of a thread). This patch below should fix this and
> > > > remove your A.
> > >
> > > That would help slightly the current situation, but this part is already
> > > covered by the estimator.
> >
> > But the estimator, as you name it, is wrong beaus ethe A part can't be
> > applied unconditionally
>
> Hum, it is used only in the !active migration. So we know the task was sleeping
> before that migration. As a consequence, the time we need to account is "sleeping"
> time from the task point of view, which is clock_pelt == clock_task (for
> __update_load_avg_blocked_se()). Otherwise, we would only decay with the
> "wallclock" idle time instead of the "scaled" one wouldn't we?

clock_pelt == clock_task only when cpu is idle and after updating
lost_idle_time but you have no idea of the state of the cpu when
migrating the task

>
>
>      +-------------+--------------
>      |   Task A    |    Task B    .....
>               ^    ^             ^
>               |    |          migrate A
>               |    |             |
>               |    |             |
>               |    |             |
>               |    |<----------->|
>               |  Wallclock Task A idle time
>               |<---------------->|
>             "Scaled" Task A idle time
>
>
> [...]
