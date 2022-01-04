Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 383FA484332
	for <lists+linux-kernel@lfdr.de>; Tue,  4 Jan 2022 15:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234077AbiADOSZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 4 Jan 2022 09:18:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51602 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234084AbiADOSR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 4 Jan 2022 09:18:17 -0500
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B0A33C061761
        for <linux-kernel@vger.kernel.org>; Tue,  4 Jan 2022 06:18:16 -0800 (PST)
Received: by mail-lf1-x132.google.com with SMTP id h7so37468033lfu.4
        for <linux-kernel@vger.kernel.org>; Tue, 04 Jan 2022 06:18:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8SIIJaimYqft0rZDsP8j1pneCQaQqI/SU2xXmyFOYmo=;
        b=o5FiSYJCsQeM/s+Rkynb9MpIIQd+UfhFyJf+1Y4DjFw1nD1yB03F1BTI/8PHkHMUTP
         ab2D6n91EJZ4j6JqLv2DaREujJn9geQPlGQMoCmnvlsu6GMrnUV3Nelnm9Ij+hmIi3mz
         MABy6rTXiJkKjFzj7NLWpfOAa0hYfVnk1xr5BWRvge75G9t0gmOC1xDwxESj/9l8p3jy
         QTyHXJqUoJUjDxm+Mkj2YHRbh2MGk2UVcRpYgQODKVAFT7xrSIyZP2wLM2fgRcXtqDGG
         ZgrB1Em98sY/ZyrXgYUP23SBc3r2PbgRvGAYTN+/O0nOGRGlcgn9rUPi7S8KJVwqL5LV
         fwGQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8SIIJaimYqft0rZDsP8j1pneCQaQqI/SU2xXmyFOYmo=;
        b=xF7ZjeE5ZCWrRna7HnS1vqypVWZ5e0Perl4uF5v3QoCveZr13+jQbsMwBSuoSUEVPO
         Um3YyxgkRDWAedGDFZqp/GLOTPe4qhf53oIH1oMdq5cqlgx3kpwjIE7biuvKKAqXcv7Q
         vffLC/wm1ZZifhR7rJrslX83HjMSGnZBpkeO6G0I3eEnM6lc+haHbvl/1nB1T5qoQVZ/
         fhtVEYneS/iMqWRVzTJvO2Ps2f5EoNYoGfsc2r+LuRBCAD/hXnUKWX+8C0VBF9Rj0WYK
         X6as0vcg8KMZhx6BYcNnayI/83foBwlo8Jvf8FX2jTD/3L8JEANaCewwvEmPdRc0PQPi
         ntGA==
X-Gm-Message-State: AOAM533eB4X1RrmijMgAD108IbSBnyQ6ZwjGkz72uu3FcsGdeo/BEjXw
        TWvWU5ylVQkJ7NHncDCAbzY1hGKTnXnK4xSNzyiNkw==
X-Google-Smtp-Source: ABdhPJw39GihROXV5NW2geRL5AeNfEv/tBa1rXZ+T0WzVKt49/+QiHAMG6+MydYolZJFwNAcFXj/30/kvjMEcBDWp5A=
X-Received: by 2002:a05:6512:4ca:: with SMTP id w10mr42999442lfq.32.1641305894833;
 Tue, 04 Jan 2022 06:18:14 -0800 (PST)
MIME-Version: 1.0
References: <20211211104324.95957-1-yangyicong@hisilicon.com>
 <CAKfTPtCaxGhpGk348Q8jGcEA13Xv4VHS+nX0aW4C+ba5df_4Lw@mail.gmail.com> <12315dc8-4b37-339d-3a41-f3a8b10344d7@huawei.com>
In-Reply-To: <12315dc8-4b37-339d-3a41-f3a8b10344d7@huawei.com>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 4 Jan 2022 15:18:03 +0100
Message-ID: <CAKfTPtCPRk+2L6wSHBpN-ewTX1Cj4U7a_m1itsSk9Yav-jE-9Q@mail.gmail.com>
Subject: Re: [PATCH] sched/fair: Track target domain's avg_scan_cost in select_idle_cpu
To:     Yicong Yang <yangyicong@huawei.com>
Cc:     Yicong Yang <yangyicong@hisilicon.com>, peterz@infradead.org,
        mingo@redhat.com, juri.lelli@redhat.com,
        mgorman@techsingularity.net, linux-kernel@vger.kernel.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com, linuxarm@huawei.com,
        21cnbao@gmail.com
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 23 Dec 2021 at 09:23, Yicong Yang <yangyicong@huawei.com> wrote:
>
> On 2021/12/22 18:47, Vincent Guittot wrote:
> > On Sat, 11 Dec 2021 at 11:43, Yicong Yang <yangyicong@hisilicon.com> wrote:
> >>
> >> We regulate the LLC domain scan in select_idle_cpu() by comparing
> >> the average scan cost of this_sd against the average idle time of
> >> this_rq. This is correct when the domain to scan is the LLC domain
> >> of this cpu. But when the domain to scan is different from this
> >> LLC domain, we'll have an inaccurate estimation of the scan cost
> >> on the target domain as this_sd->avg_scan_cost contains contributions
> >> of scanning other domains besides the target domain.
> >>
> >> Track the avg_scan_cost of the target domain to make the estimation
> >> more accurate.
> >>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> ---
> >>  kernel/sched/fair.c | 4 ++--
> >>  1 file changed, 2 insertions(+), 2 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 6e476f6d9435..6301740d98cb 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6267,7 +6267,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>                 }
> >>
> >>                 avg_idle = this_rq->wake_avg_idle;
> >> -               avg_cost = this_sd->avg_scan_cost + 1;
> >> +               avg_cost = sd->avg_scan_cost + 1;
> >>
> >>                 span_avg = sd->span_weight * avg_idle;
> >>                 if (span_avg > 4*avg_cost)
> >> @@ -6305,7 +6305,7 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>                  */
> >>                 this_rq->wake_avg_idle -= min(this_rq->wake_avg_idle, time);
> >>
> >> -               update_avg(&this_sd->avg_scan_cost, time);
> >> +               update_avg(&sd->avg_scan_cost, time);
> >
> > But then you can have several cpus updating the same value simultaneously
> >
>
> yes. sd->avg_scan_cost should includes the contributions of all the cpus scanned the sd.
>
> We regulated the scanning nr based on two things:
> - avg_idle: to indicate how much time we can have for this time scanning
> - avg_cost: to indicate how much time we'll spend for scanning the target domain based
>             on the history cost
>
> Previously sd->avg_scan_cost may not reflect the cost as it count the scanning cost
> on the domain of the scanner cpu, which may not be the domain the cpu scanned.
> For example, cpu 0 on llc A scanned llc B and llc C, we'll count the cost of scanning B
> and C on llc A's avg_scan_cost and we'll use this to estimate the cost for scanning
> llc A, which is not accurate.

I mean that you can now have several CPUs that will read, modify,
write sd->avg_scan_cost simultaneously without any protection

>
> >>         }
> >>
> >>         return idle_cpu;
> >> --
> >> 2.33.0
> >>
> > .
> >
