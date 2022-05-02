Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0596516DC6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 11:57:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384784AbiEBKAj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 06:00:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1384863AbiEBKA3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 06:00:29 -0400
Received: from mail-yw1-x112c.google.com (mail-yw1-x112c.google.com [IPv6:2607:f8b0:4864:20::112c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E62C4ECF9
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 02:54:43 -0700 (PDT)
Received: by mail-yw1-x112c.google.com with SMTP id 00721157ae682-2f7c424c66cso142443637b3.1
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 02:54:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Q6hMio14MlaNNi+L2d6tcY8rx2TTh2sPffP2H8lOP7Y=;
        b=AZAq5b1oiZUvxLAknaOz6gTl+Ns1b6Qh1xTwYxDqM+G2XD4Etie5JkxhlEMOKjW8gS
         Alw38i+1owoIcRiKDklCBe6vnJhK1NoBuCoulddEa+RJ1vA5mP4+gwxv3zBuNFF4NXqo
         SYyPqwJPJAFoHfzjmFmhFbDhfiqi5kpTgL1/OVMmgwzxV2gfvXjm6Qc/LjoabMi67bE+
         mfNizP8737bp9mQ+wbE8VTYX93r05Uyj0XQQkg9112eHL+s9bXRv+YtxasRglVd4VUIL
         kgrH5SfCv17LO99abk3WZd/rb95bXlsxsFob3zI2DA7mwJkkUS5okY0sZ6Bao/qSoqYV
         h1VQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Q6hMio14MlaNNi+L2d6tcY8rx2TTh2sPffP2H8lOP7Y=;
        b=u/gamINIqhJL6A7TqgwfgRJKlj109DGl/vinL7TxyXhnWcHatVHhCyhTMxsjfZjDyH
         ygOlBaloRJ7h0o9l1+ljiswc5655AyfABAKHu7mcOOnTReq+Sf8N+0eC+ZO0epRUUO1g
         ahUR7HxSOFUsLVbvG/hANujLaZrG/sP1YM5AOF2lasJF/dbDofBqwE7ZI4L+rlZDyMQL
         TIzC3DBumQaopJKKatAi5hHLhElBWvRgnidaPR1ns+co5D2X+bh2OFO84HwWAOD6ck8b
         nUtzvrdNsuN5KrLN63tRPWdzJd2wFQSL1U04bMWEtOgfsTdsEcFgC9lx0td8H9qH96A9
         u7og==
X-Gm-Message-State: AOAM5307CGiQHIKIDifJ8m2OdLVF/pBKneXdY8b5wmlLjJ2tX9+w49tk
        iWpiAOAtJYHzYrHUQfJ0fSYJXZpnMr3xEJ1lwPQRVQ==
X-Google-Smtp-Source: ABdhPJzLprqZuiv9RtaIaM+KOaLyf9cuRZsNYfhwftzJ+DplCidBH6+N3VHG78KI7lFeDQthgxkUeRytjhfCZ1XiHJE=
X-Received: by 2002:a0d:fa01:0:b0:2d6:595d:81d4 with SMTP id
 k1-20020a0dfa01000000b002d6595d81d4mr10726816ywf.86.1651485282574; Mon, 02
 May 2022 02:54:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-6-vincent.guittot@linaro.org> <Ym6uMoHVkqr9zOpj@geo.homenetwork>
In-Reply-To: <Ym6uMoHVkqr9zOpj@geo.homenetwork>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Mon, 2 May 2022 11:54:31 +0200
Message-ID: <CAKfTPtD2Hb_ZU8x1J9B6he7fYNvw2AyUBOKdfRk6zcSvJEvYTg@mail.gmail.com>
Subject: Re: [RFC 5/6] sched/fair: Take into account latency nice at wakeup
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com,
        pkondeti@codeaurora.org, vschneid@redhat.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Tao,

On Sun, 1 May 2022 at 17:58, Tao Zhou <tao.zhou@linux.dev> wrote:
>
> Hi Vincent,
>
> Change to Valentin Schneider's now using mail address.

Thanks

>
> On Fri, Mar 11, 2022 at 05:14:05PM +0100, Vincent Guittot wrote:
>
> > Take into account the nice latency priority of a thread when deciding to
> > preempt the current running thread. We don't want to provide more CPU
> > bandwidth to a thread but reorder the scheduling to run latency sensitive
> > task first whenever possible.
> >
> > As long as a thread didn't use its bandwidth, it will be able to preempt
> > the current thread.
> >
> > At the opposite, a thread with a low latency priority will preempt current
> > thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
> > wait for the tick to get its sched slice.
> >
> >                                    curr vruntime
> >                                        |
> >                       sysctl_sched_wakeup_granularity
> >                                    <-->
> > ----------------------------------|----|-----------------------|---------------
> >                                   |    |<--------------------->
> >                                   |    .  sysctl_sched_latency
> >                                   |    .
> > default/current latency entity    |    .
> >                                   |    .
> > 1111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-
> > se preempts curr at wakeup ------>|<- se doesn't preempt curr -----------------
> >                                   |    .
> >                                   |    .
> >                                   |    .
> > low latency entity                |    .
> >                                    ---------------------->|
> >                                % of sysctl_sched_latency  |
> > 1111111111111111111111111111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-
> > preempt ------------------------------------------------->|<- do not preempt --
> >                                   |    .
> >                                   |    .
> >                                   |    .
> > high latency entity               |    .
> >          |<-----------------------|    .
> >          | % of sysctl_sched_latency   .
> > 111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1
> > preempt->|<- se doesn't preempt curr ------------------------------------------
> >
> > Tests results of nice latency impact on heavy load like hackbench:
> >
> > hackbench -l (2560 / group) -g group
> > group        latency 0             latency 19
> > 1            1.450(+/- 0.60%)      1.376(+/- 0.54%) + 5%
> > 4            1.537(+/- 1.75%)      1.335(+/- 1.81%) +13%
> > 8            1.414(+/- 1.91%)      1.348(+/- 1.88%) + 5%
> > 16           1.423(+/- 1.65%)      1.374(+/- 0.58%) + 3%
> >
> > hackbench -p -l (2560 / group) -g group
> > group
> > 1            1.416(+/- 3.45%)      0.886(+/- 0.54%) +37%
> > 4            1.634(+/- 7.14%)      0.888(+/- 5.40%) +45%
> > 8            1.449(+/- 2.14%)      0.804(+/- 4.55%) +44%
> > 16           0.917(+/- 4.12%)      0.777(+/- 1.41%) +15%
> >
> > By deacreasing the latency prio, we reduce the number of preemption at
>
> s/deacreasing/decreasing/

yes

> s/reduce/increase/

not in the case of hackbench tests above. By decreasing the latency
prio of all hackbench threads, we make sure that they will not preempt
the current thread and let it move forward so we reduce the number of
preemption.

>
> > wakeup and help hackbench making progress.
> >
> > Test results of nice latency impact on short live load like cyclictest
> > while competing with heavy load like hackbench:
> >
> > hackbench -l 10000 -g group &
> > cyclictest --policy other -D 5 -q -n
> >         latency 0           latency -20
> > group   min  avg    max     min  avg    max
> > 0       16    17     28      15   17     27
> > 1       61   382  10603      63   89   4628
> > 4       52   437  15455      54   98  16238
> > 8       56   728  38499      61  125  28983
> > 16      53  1215  52207      61  183  80751
> >
> > group = 0 means that hackbench is not running.
> >
> > The avg is significantly improved with nice latency -20 especially with
> > large number of groups but min and max remain quite similar. If we add the
> > histogram parameters to get details of latency, we have :
> >
> > hackbench -l 10000 -g 16 &
> > cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
> >               latency 0    latency -20
> > Min Latencies:    63           62
> > Avg Latencies:  1397          218
> > Max Latencies: 44926        42291
> > 50% latencies:   100           98
> > 75% latencies:   762          116
> > 85% latencies:  1118          126
> > 90% latencies:  1540          130
> > 95% latencies:  5610          138
> > 99% latencies: 13738          266
> >
> > With percentile details, we see the benefit of nice latency -20 as
> > 1% of the latencies stays above 266us whereas the default latency has
> > got 25% are above 762us and 10% over the 1ms.
> >

[..]

> > +static long wakeup_latency_gran(int latency_weight)
> > +{
> > +     long thresh = sysctl_sched_latency;
> > +
> > +     if (!latency_weight)
> > +             return 0;
> > +
> > +     if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > +             thresh >>= 1;
> > +
> > +     /*
> > +      * Clamp the delta to stay in the scheduler period range
> > +      * [-sysctl_sched_latency:sysctl_sched_latency]
> > +      */
> > +     latency_weight = clamp_t(long, latency_weight,
> > +                             -1 * NICE_LATENCY_WEIGHT_MAX,
> > +                             NICE_LATENCY_WEIGHT_MAX);
> > +
> > +     return (thresh * latency_weight) >> NICE_LATENCY_SHIFT;
> > +}
> > +
> >  static unsigned long wakeup_gran(struct sched_entity *se)
> >  {
> >       unsigned long gran = sysctl_sched_wakeup_granularity;
> > @@ -7008,6 +7059,10 @@ static int
> >  wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
> >  {
> >       s64 gran, vdiff = curr->vruntime - se->vruntime;
> > +     int latency_weight = se->latency_weight - curr->latency_weight;
> > +
> > +     latency_weight = min(latency_weight, se->latency_weight);
>
> Let lable A=se->latency_weight, B=curr->latency_weight, C=A-B.
>
> 1 A>0 B>0
>     ::C=A-B<0, min(C,A)=C, latency decrease, C is the real diff value no matter
>       what A is. That means it can be very 'long'(-sched_latency) and vdiff is
>       more possible to be in <= 0 case and return -1.
>     ::C=A-B>0, min(C,A)=A, latency increase, but it is conservative. Limit to

A>0 and B>0  then min(C=A-B, A) = C

>       A/1024*sched_latency.
>     When latecy is decreased, the negtive value added to vdiff is larger than the
>     positive value added to vdiff when latency is increased.

When the weight > 0, the tasks have some latency requirements so we
use their relative priority to decide if we can preempt current which
also has some latency requirement

>
> 2 A>0 B<0
>     ::C=A-B>0 and C>A, min(C,A)=A, latency increase and it is conservative.
>
> 3 A<0 B<0
>     ::C=A-B>0, min(C,A)=A, latency increase but min(C,A)<0, I think if latency
>     increase means the value added to vdiff will be a positive value to increase
>     the chance to return 1. I would say it is max(C,A)=C
>     ::C=A-B<0, min(C,A)=A, latency decrease and the real negtive value.

When the weight < 0, the tasks haven't latency requirement and even
don't care of being scheduled "quickly". In this case, we don't care
about the relative priority but we want to minimize the preemption of
current so we use the weight

>
> 4 A<0,B>0
>     ::C=A-B<0, min(C,A)=C, latency decrease and the real negtive value.
>
> Is there a reason that the value when latency increase and latency decrease
> be treated differently. Latency increase value is limited to se's latency_weight

I have tried to explain why I treat differently if weight is > 0 or < 0.

> but latency decrease value can extend to -sched_latency or treat them the same.
> Penalty latency decrease and conserve latency increase.
>
>
> There is any value that this latency_weight can be considered to be a average.
>
> The delta value choose is ~%5 to 1024. %5*sched_latency=0.05*6ms=0.3ms.(no scale)
> I do not think over that vdiff equation  and others though.
>
> Thanks,
> Tao
> > +     vdiff += wakeup_latency_gran(latency_weight);
> >
> >       if (vdiff <= 0)
> >               return -1;
> > @@ -7117,6 +7172,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> >               return;
> >
> >       update_curr(cfs_rq_of(se));
> > +
> >       if (wakeup_preempt_entity(se, pse) == 1) {
> >               /*
> >                * Bias pick_next to pick the sched entity that is
> > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > index 456ad2159eb1..dd92aa9c36f9 100644
> > --- a/kernel/sched/sched.h
> > +++ b/kernel/sched/sched.h
> > @@ -122,6 +122,17 @@ extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
> >   * Default tasks should be treated as a task with latency_nice = 0.
> >   */
> >  #define DEFAULT_LATENCY_NICE 0
> > +#define DEFAULT_LATENCY_PRIO (DEFAULT_LATENCY_NICE + LATENCY_NICE_WIDTH/2)
> > +
> > +/*
> > + * Convert user-nice values [ -20 ... 0 ... 19 ]
> > + * to static latency [ 0..39 ],
> > + * and back.
> > + */
> > +#define NICE_TO_LATENCY(nice)        ((nice) + DEFAULT_LATENCY_PRIO)
> > +#define LATENCY_TO_NICE(prio)        ((prio) - DEFAULT_LATENCY_PRIO)
> > +#define NICE_LATENCY_SHIFT   (SCHED_FIXEDPOINT_SHIFT)
> > +#define NICE_LATENCY_WEIGHT_MAX      (1L << NICE_LATENCY_SHIFT)
> >
> >  /*
> >   * Increase resolution of nice-level calculations for 64-bit architectures.
> > @@ -2098,6 +2109,7 @@ static_assert(WF_TTWU == SD_BALANCE_WAKE);
> >
> >  extern const int             sched_prio_to_weight[40];
> >  extern const u32             sched_prio_to_wmult[40];
> > +extern const int             sched_latency_to_weight[40];
> >
> >  /*
> >   * {de,en}queue flags:
> > --
> > 2.17.1
> >
