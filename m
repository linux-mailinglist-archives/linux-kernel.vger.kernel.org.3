Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B05F8517429
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 18:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242067AbiEBQZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 12:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241466AbiEBQZI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 12:25:08 -0400
Received: from mail-wm1-x329.google.com (mail-wm1-x329.google.com [IPv6:2a00:1450:4864:20::329])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6B2E7614A
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 09:21:38 -0700 (PDT)
Received: by mail-wm1-x329.google.com with SMTP id p7-20020a05600c358700b00393e80c59daso223737wmq.0
        for <linux-kernel@vger.kernel.org>; Mon, 02 May 2022 09:21:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to
         :user-agent;
        bh=FyBG6aJCLlMDne+rJMumWyUoSL8Sjd0fPcd17Ay1opA=;
        b=Dlz6RdYOZBaB91QCTcLyyW5oOOMPjCT/xOeiLYVD5m0a84hBmwa85VhlgETYI2unan
         pBM86aUY0/xkHhy2Lzz1y9qJjMURtXBxFNLvskXLNjrzxPiAN1MR0F/jgHjYQ08kKl4v
         29rGHaYmAJ6HCyGLrhZ6EUVygWq/JLFS/0keu3CIuHD+QZX8v7scRA/jQA+Y9PM8CybV
         IfA/40QI1jSVaNd0hwB6HvCsj1X9dB0CCCoPjAFSSuIZ1l2GtIR6RUIaK21JwDDZnSHc
         tbBiP7H6WibRym7R8iCKixpMjtsw7pTegs1xyk6h42yqa3qVsXrGjWKl9MjX2VMaE5vW
         EpUg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to:user-agent;
        bh=FyBG6aJCLlMDne+rJMumWyUoSL8Sjd0fPcd17Ay1opA=;
        b=o8zHzS6K14gbBpFIgOTHPXbDVXPAzgKOucK8z96aqx0gVzNP4hMrnIuU/0kktLjfrj
         olRXcMINBFw8JoXqPe3tYrkx23m2uyBctZTlQYXbh5k7KIc+GxgW19+IVwZfOfk+g2v1
         AUO2dPXWHGNNxUBoB6FAFR1xBOgwCySMzsbszOelk7JMTaB+UPAvCHsRWhv2pwy46+XO
         4Ff9+O/rbT3tFIfcSmK3VuICRaoXRGJZe9dgNnxSWsQc17x4+KUSyf2SbhEQf/5bb4qY
         JJBEQl9B6CA9zZZE2xkQbNVZr3wSgA5pQYN3PfkBs7Wa3hkqOxiwxk0MRSw+nWqskGTv
         udtg==
X-Gm-Message-State: AOAM530o/cpJuH/83kE+Kgo6Waa+u0tBq8eH1+JRBzSxgtw92vpaHrh5
        /xgjcoNQ2tchUKBY927W1110Ug==
X-Google-Smtp-Source: ABdhPJwrpjqT9Du2EIEL8oq9sISFgwJIYJLmSYYlnF6TzCEYPX4o5c0iYZ0uf4Y8AML6oEJ2nUbRvw==
X-Received: by 2002:a05:600c:2112:b0:393:ff25:fb92 with SMTP id u18-20020a05600c211200b00393ff25fb92mr11306875wml.194.1651508496847;
        Mon, 02 May 2022 09:21:36 -0700 (PDT)
Received: from vingu-book ([2a01:e0a:f:6020:54c4:a93:ef1f:226c])
        by smtp.gmail.com with ESMTPSA id n14-20020adfc60e000000b0020c6a524fd5sm2225625wrg.99.2022.05.02.09.21.35
        (version=TLS1_2 cipher=ECDHE-ECDSA-CHACHA20-POLY1305 bits=256/256);
        Mon, 02 May 2022 09:21:36 -0700 (PDT)
Date:   Mon, 2 May 2022 18:21:34 +0200
From:   Vincent Guittot <vincent.guittot@linaro.org>
To:     Tao Zhou <tao.zhou@linux.dev>
Cc:     mingo@redhat.com, peterz@infradead.org, juri.lelli@redhat.com,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        mgorman@suse.de, linux-kernel@vger.kernel.org, parth@linux.ibm.com,
        qais.yousef@arm.com, chris.hyser@oracle.com, vschneid@redhat.com,
        patrick.bellasi@matbug.net, David.Laight@aculab.com,
        pjt@google.com, pavel@ucw.cz, tj@kernel.org, qperret@google.com,
        tim.c.chen@linux.intel.com
Subject: Re: [RFC 5/6] sched/fair: Take into account latency nice at wakeup
Message-ID: <20220502162134.GA26973@vingu-book>
References: <20220311161406.23497-1-vincent.guittot@linaro.org>
 <20220311161406.23497-6-vincent.guittot@linaro.org>
 <Ym6uMoHVkqr9zOpj@geo.homenetwork>
 <CAKfTPtD2Hb_ZU8x1J9B6he7fYNvw2AyUBOKdfRk6zcSvJEvYTg@mail.gmail.com>
 <CAKfTPtCkMGnATuBZObRTabn0-OTUbB6j8f_Sg57HCg4cgQ96rQ@mail.gmail.com>
 <Ym/z39Qk/QDJckKE@geo.homenetwork>
 <Ym/4Fs9GEctSNFM3@geo.homenetwork>
 <Ym/9FL5RAYwbDjES@geo.homenetwork>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Ym/9FL5RAYwbDjES@geo.homenetwork>
User-Agent: Mutt/1.9.4 (2018-02-28)
X-Spam-Status: No, score=-1.6 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,PDS_BTC_ID,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Le lundi 02 mai 2022 à 23:47:32 (+0800), Tao Zhou a écrit :
> On Mon, May 02, 2022 at 11:26:14PM +0800, Tao Zhou wrote:
> > On Mon, May 02, 2022 at 11:08:15PM +0800, Tao Zhou wrote:
> > > On Mon, May 02, 2022 at 02:30:55PM +0200, Vincent Guittot wrote:
> > > 
> > > > On Mon, 2 May 2022 at 11:54, Vincent Guittot <vincent.guittot@linaro.org> wrote:
> > > > >
> > > > > Hi Tao,
> > > > >
> > > > > On Sun, 1 May 2022 at 17:58, Tao Zhou <tao.zhou@linux.dev> wrote:
> > > > > >
> > > > > > Hi Vincent,
> > > > > >
> > > > > > Change to Valentin Schneider's now using mail address.
> > > > >
> > > > > Thanks
> > > > >
> > > > > >
> > > > > > On Fri, Mar 11, 2022 at 05:14:05PM +0100, Vincent Guittot wrote:
> > > > > >
> > > > > > > Take into account the nice latency priority of a thread when deciding to
> > > > > > > preempt the current running thread. We don't want to provide more CPU
> > > > > > > bandwidth to a thread but reorder the scheduling to run latency sensitive
> > > > > > > task first whenever possible.
> > > > > > >
> > > > > > > As long as a thread didn't use its bandwidth, it will be able to preempt
> > > > > > > the current thread.
> > > > > > >
> > > > > > > At the opposite, a thread with a low latency priority will preempt current
> > > > > > > thread at wakeup only to keep fair CPU bandwidth sharing. Otherwise it will
> > > > > > > wait for the tick to get its sched slice.
> > > > > > >
> > > > > > >                                    curr vruntime
> > > > > > >                                        |
> > > > > > >                       sysctl_sched_wakeup_granularity
> > > > > > >                                    <-->
> > > > > > > ----------------------------------|----|-----------------------|---------------
> > > > > > >                                   |    |<--------------------->
> > > > > > >                                   |    .  sysctl_sched_latency
> > > > > > >                                   |    .
> > > > > > > default/current latency entity    |    .
> > > > > > >                                   |    .
> > > > > > > 1111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-
> > > > > > > se preempts curr at wakeup ------>|<- se doesn't preempt curr -----------------
> > > > > > >                                   |    .
> > > > > > >                                   |    .
> > > > > > >                                   |    .
> > > > > > > low latency entity                |    .
> > > > > > >                                    ---------------------->|
> > > > > > >                                % of sysctl_sched_latency  |
> > > > > > > 1111111111111111111111111111111111111111111111111111111111|0000|-1-1-1-1-1-1-1-
> > > > > > > preempt ------------------------------------------------->|<- do not preempt --
> > > > > > >                                   |    .
> > > > > > >                                   |    .
> > > > > > >                                   |    .
> > > > > > > high latency entity               |    .
> > > > > > >          |<-----------------------|    .
> > > > > > >          | % of sysctl_sched_latency   .
> > > > > > > 111111111|0000|-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1-1
> > > > > > > preempt->|<- se doesn't preempt curr ------------------------------------------
> > > > > > >
> > > > > > > Tests results of nice latency impact on heavy load like hackbench:
> > > > > > >
> > > > > > > hackbench -l (2560 / group) -g group
> > > > > > > group        latency 0             latency 19
> > > > > > > 1            1.450(+/- 0.60%)      1.376(+/- 0.54%) + 5%
> > > > > > > 4            1.537(+/- 1.75%)      1.335(+/- 1.81%) +13%
> > > > > > > 8            1.414(+/- 1.91%)      1.348(+/- 1.88%) + 5%
> > > > > > > 16           1.423(+/- 1.65%)      1.374(+/- 0.58%) + 3%
> > > > > > >
> > > > > > > hackbench -p -l (2560 / group) -g group
> > > > > > > group
> > > > > > > 1            1.416(+/- 3.45%)      0.886(+/- 0.54%) +37%
> > > > > > > 4            1.634(+/- 7.14%)      0.888(+/- 5.40%) +45%
> > > > > > > 8            1.449(+/- 2.14%)      0.804(+/- 4.55%) +44%
> > > > > > > 16           0.917(+/- 4.12%)      0.777(+/- 1.41%) +15%
> > > > > > >
> > > > > > > By deacreasing the latency prio, we reduce the number of preemption at
> > > > > >
> > > > > > s/deacreasing/decreasing/
> > > > >
> > > > > yes
> > > > >
> > > > > > s/reduce/increase/
> > > > >
> > > > > not in the case of hackbench tests above. By decreasing the latency
> > > > > prio of all hackbench threads, we make sure that they will not preempt
> > > > > the current thread and let it move forward so we reduce the number of
> > > > > preemption.
> > > > >
> > > > > >
> > > > > > > wakeup and help hackbench making progress.
> > > > > > >
> > > > > > > Test results of nice latency impact on short live load like cyclictest
> > > > > > > while competing with heavy load like hackbench:
> > > > > > >
> > > > > > > hackbench -l 10000 -g group &
> > > > > > > cyclictest --policy other -D 5 -q -n
> > > > > > >         latency 0           latency -20
> > > > > > > group   min  avg    max     min  avg    max
> > > > > > > 0       16    17     28      15   17     27
> > > > > > > 1       61   382  10603      63   89   4628
> > > > > > > 4       52   437  15455      54   98  16238
> > > > > > > 8       56   728  38499      61  125  28983
> > > > > > > 16      53  1215  52207      61  183  80751
> > > > > > >
> > > > > > > group = 0 means that hackbench is not running.
> > > > > > >
> > > > > > > The avg is significantly improved with nice latency -20 especially with
> > > > > > > large number of groups but min and max remain quite similar. If we add the
> > > > > > > histogram parameters to get details of latency, we have :
> > > > > > >
> > > > > > > hackbench -l 10000 -g 16 &
> > > > > > > cyclictest --policy other -D 5 -q -n  -H 20000 --histfile data.txt
> > > > > > >               latency 0    latency -20
> > > > > > > Min Latencies:    63           62
> > > > > > > Avg Latencies:  1397          218
> > > > > > > Max Latencies: 44926        42291
> > > > > > > 50% latencies:   100           98
> > > > > > > 75% latencies:   762          116
> > > > > > > 85% latencies:  1118          126
> > > > > > > 90% latencies:  1540          130
> > > > > > > 95% latencies:  5610          138
> > > > > > > 99% latencies: 13738          266
> > > > > > >
> > > > > > > With percentile details, we see the benefit of nice latency -20 as
> > > > > > > 1% of the latencies stays above 266us whereas the default latency has
> > > > > > > got 25% are above 762us and 10% over the 1ms.
> > > > > > >
> > > > >
> > > > > [..]
> > > > >
> > > > > > > +static long wakeup_latency_gran(int latency_weight)
> > > > > > > +{
> > > > > > > +     long thresh = sysctl_sched_latency;
> > > > > > > +
> > > > > > > +     if (!latency_weight)
> > > > > > > +             return 0;
> > > > > > > +
> > > > > > > +     if (sched_feat(GENTLE_FAIR_SLEEPERS))
> > > > > > > +             thresh >>= 1;
> > > > > > > +
> > > > > > > +     /*
> > > > > > > +      * Clamp the delta to stay in the scheduler period range
> > > > > > > +      * [-sysctl_sched_latency:sysctl_sched_latency]
> > > > > > > +      */
> > > > > > > +     latency_weight = clamp_t(long, latency_weight,
> > > > > > > +                             -1 * NICE_LATENCY_WEIGHT_MAX,
> > > > > > > +                             NICE_LATENCY_WEIGHT_MAX);
> > > > > > > +
> > > > > > > +     return (thresh * latency_weight) >> NICE_LATENCY_SHIFT;
> > > > > > > +}
> > > > > > > +
> > > > > > >  static unsigned long wakeup_gran(struct sched_entity *se)
> > > > > > >  {
> > > > > > >       unsigned long gran = sysctl_sched_wakeup_granularity;
> > > > > > > @@ -7008,6 +7059,10 @@ static int
> > > > > > >  wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
> > > > > > >  {
> > > > > > >       s64 gran, vdiff = curr->vruntime - se->vruntime;
> > > > > > > +     int latency_weight = se->latency_weight - curr->latency_weight;
> > > > > > > +
> > > > > > > +     latency_weight = min(latency_weight, se->latency_weight);
> > > > > >
> > > > > > Let lable A=se->latency_weight, B=curr->latency_weight, C=A-B.
> > > > > >
> > > > > > 1 A>0 B>0
> > > > > >     ::C=A-B<0, min(C,A)=C, latency decrease, C is the real diff value no matter
> > > > > >       what A is. That means it can be very 'long'(-sched_latency) and vdiff is
> > > > > >       more possible to be in <= 0 case and return -1.
> > > > > >     ::C=A-B>0, min(C,A)=A, latency increase, but it is conservative. Limit to
> > > > >
> > > > > A>0 and B>0  then min(C=A-B, A) = C
> > > 
> > > It's my mistake. And in this case the calculating of value added to vdiff
> > > for latency increase and deleted to vdiff for latency decrease is the same.
> > > 
> > > > >
> > > > > >       A/1024*sched_latency.
> > > > > >     When latecy is decreased, the negtive value added to vdiff is larger than the
> > > > > >     positive value added to vdiff when latency is increased.
> > > > >
> > > > > When the weight > 0, the tasks have some latency requirements so we
> > > > > use their relative priority to decide if we can preempt current which
> > > > > also has some latency requirement
> > > > >
> > > > > >
> > > > > > 2 A>0 B<0
> > > > > >     ::C=A-B>0 and C>A, min(C,A)=A, latency increase and it is conservative.
> > > > 
> > > > For this one we want to use delta like for UC 1 above
> > > > 
> > > > > >
> > > > > > 3 A<0 B<0
> > > > > >     ::C=A-B>0, min(C,A)=A, latency increase but min(C,A)<0, I think if latency
> > > > > >     increase means the value added to vdiff will be a positive value to increase
> > > > > >     the chance to return 1. I would say it is max(C,A)=C
> > > > > >     ::C=A-B<0, min(C,A)=A, latency decrease and the real negtive value.
> > > > >
> > > > > When the weight < 0, the tasks haven't latency requirement and even
> > > > > don't care of being scheduled "quickly". In this case, we don't care
> > > > > about the relative priority but we want to minimize the preemption of
> > > > > current so we use the weight
> > > > >
> > > > > >
> > > > > > 4 A<0,B>0
> > > > > >     ::C=A-B<0, min(C,A)=C, latency decrease and the real negtive value.
> > > > 
> > > > And for this one we probably want to use A like for other UC with A < 0
> > > > 
> > > > I'm going to update the way the weight is computed to match this
> > > 
> > > According to your explanations, the min(C,A) is used for A and B both in
> > > the negtive region or in the postive region, the max(C,A) is use for A and
> > > B both not in the same region.
> > > 
> > > if ((A>>31)^(B>>31))
> > >   max(C,A)
> > > else
> > >   min(C,A)
> > 
> > Not right. 
> > 
> >   if ((A&(1<<31))^(B(1<<31)))
> >       max(C,A)
> >   else
> >       min(C,A)
> > 
> > > 
> > > wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
> > > {
> > >     s64 gran, vdiff = curr->vruntime - se->vruntime;
> > >     int latency_weight = se->latency_weight - curr->latency_weight;
> > > 
> > >     if ((se->latency_weight>>(WMULT_SHIFT-1)) ^
> > >          curr->latency_weight>>(WMULT_SHIFT-1))
> > >         latency_weight = max(latency_weight, se->latency_weight);
> > >     else
> > >         latency_weight = min(latency_weight, se->latency_weight);
> > > 
> > >     vdiff += wakeup_latency_gran(latency_weight);
> > >     ...
> > > }
> > 
> > Not right.
> > 
> > wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
> > {
> >     s64 gran, vdiff = curr->vruntime - se->vruntime;
> >     int latency_weight = se->latency_weight - curr->latency_weight;
> > 
> >     if ((se->latency_weight & (1 << WMULT_SHIFT-1)) ^
> >          curr->latency_weight & (1 << WMULT_SHIFT-1))
> >         latency_weight = max(latency_weight, se->latency_weight);
> >     else
> >         latency_weight = min(latency_weight, se->latency_weight);
> > 
> >     vdiff += wakeup_latency_gran(latency_weight);
> >     ...
> > }
> 
> I already on bed, but I think they are the same.. heh

case 1 & 2 use delta and have A > 0

case 3 & 4 use A and have A < 0

so I plan to use :

 wakeup_preempt_entity(struct sched_entity *curr, struct sched_entity *se)
 {
 	s64 gran, vdiff = curr->vruntime - se->vruntime;
+	int latency_weight = se->latency_weight;
+
+	/*
+	 * A positive latency weight means that se has some latency requirements that
+	 * needs to be evaluate versus the current thread.
+	 * Otherwise, use the latency weight to evaluate how much scheduling
+	 * delay is acceptable by se.
+	 */
+	if (latency_weight > 0)
+		latency_weight -= curr->latency_weight;
+
+	vdiff += wakeup_latency_gran(latency_weight);

 	if (vdiff <= 0)
 		return -1;

> 
> > > > > >
> > > > > > Is there a reason that the value when latency increase and latency decrease
> > > > > > be treated differently. Latency increase value is limited to se's latency_weight
> > > > >
> > > > > I have tried to explain why I treat differently if weight is > 0 or < 0.
> > > > >
> > > > > > but latency decrease value can extend to -sched_latency or treat them the same.
> > > > > > Penalty latency decrease and conserve latency increase.
> > > > > >
> > > > > >
> > > > > > There is any value that this latency_weight can be considered to be a average.
> > > > > >
> > > > > > The delta value choose is ~%5 to 1024. %5*sched_latency=0.05*6ms=0.3ms.(no scale)
> > > > > > I do not think over that vdiff equation  and others though.
> > > > > >
> > > > > > Thanks,
> > > > > > Tao
> > > > > > > +     vdiff += wakeup_latency_gran(latency_weight);
> > > > > > >
> > > > > > >       if (vdiff <= 0)
> > > > > > >               return -1;
> > > > > > > @@ -7117,6 +7172,7 @@ static void check_preempt_wakeup(struct rq *rq, struct task_struct *p, int wake_
> > > > > > >               return;
> > > > > > >
> > > > > > >       update_curr(cfs_rq_of(se));
> > > > > > > +
> > > > > > >       if (wakeup_preempt_entity(se, pse) == 1) {
> > > > > > >               /*
> > > > > > >                * Bias pick_next to pick the sched entity that is
> > > > > > > diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> > > > > > > index 456ad2159eb1..dd92aa9c36f9 100644
> > > > > > > --- a/kernel/sched/sched.h
> > > > > > > +++ b/kernel/sched/sched.h
> > > > > > > @@ -122,6 +122,17 @@ extern void call_trace_sched_update_nr_running(struct rq *rq, int count);
> > > > > > >   * Default tasks should be treated as a task with latency_nice = 0.
> > > > > > >   */
> > > > > > >  #define DEFAULT_LATENCY_NICE 0
> > > > > > > +#define DEFAULT_LATENCY_PRIO (DEFAULT_LATENCY_NICE + LATENCY_NICE_WIDTH/2)
> > > > > > > +
> > > > > > > +/*
> > > > > > > + * Convert user-nice values [ -20 ... 0 ... 19 ]
> > > > > > > + * to static latency [ 0..39 ],
> > > > > > > + * and back.
> > > > > > > + */
> > > > > > > +#define NICE_TO_LATENCY(nice)        ((nice) + DEFAULT_LATENCY_PRIO)
> > > > > > > +#define LATENCY_TO_NICE(prio)        ((prio) - DEFAULT_LATENCY_PRIO)
> > > > > > > +#define NICE_LATENCY_SHIFT   (SCHED_FIXEDPOINT_SHIFT)
> > > > > > > +#define NICE_LATENCY_WEIGHT_MAX      (1L << NICE_LATENCY_SHIFT)
> > > > > > >
> > > > > > >  /*
> > > > > > >   * Increase resolution of nice-level calculations for 64-bit architectures.
> > > > > > > @@ -2098,6 +2109,7 @@ static_assert(WF_TTWU == SD_BALANCE_WAKE);
> > > > > > >
> > > > > > >  extern const int             sched_prio_to_weight[40];
> > > > > > >  extern const u32             sched_prio_to_wmult[40];
> > > > > > > +extern const int             sched_latency_to_weight[40];
> > > > > > >
> > > > > > >  /*
> > > > > > >   * {de,en}queue flags:
> > > > > > > --
> > > > > > > 2.17.1
> > > > > > >
