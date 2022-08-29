Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 637C55A4F19
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 16:23:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230005AbiH2OXd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 10:23:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229559AbiH2OX1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 10:23:27 -0400
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CE7D996FC3
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:23:24 -0700 (PDT)
Received: by mail-ed1-x52d.google.com with SMTP id z41so2953213ede.0
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 07:23:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:from:to:cc;
        bh=VyqBHtmrcWJSxolXiqYrUzXAWMIlYBC+tn/MuMuveCg=;
        b=rO4Ai7CBRTJ2u4ysq85m9HHUSqmrg1XrD2zQfFbIS6emeBTnTSFfwNxby9FvAItugc
         DYroOo+OPv2LQvnz1RiBkHgwI1uKPtrV8f1RKXtFb8jAZAzY9EzutQt5FS9bjgtChWXw
         Yz/VrERWacyQvrObYwdLI5LA0+/D4HSbEHav7Q2j/uWHxTpycqn2lmdp8PLXsnxJHEkR
         HJbthgPVcv47ATKd2y4DWL2njWNFzVGnqHSBKgrQvy8WQExwp/M2sUBCesHUXF6g6TQI
         tvXO8bD6u4LqZgj5wBRCTcZM/OmEexVmK47aPhof+x1c0DOir3Rw68/G4EQ3J0mDqVCq
         B9/w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=in-reply-to:content-disposition:mime-version:references:message-id
         :subject:cc:to:from:date:x-gm-message-state:from:to:cc;
        bh=VyqBHtmrcWJSxolXiqYrUzXAWMIlYBC+tn/MuMuveCg=;
        b=C8zaf9wsGEuj0bQTlkv3wG2YjBB4iA/VQl8HkIX0eb//9vn1VbrJIXl/EO3Zs9fCps
         AeCSMRt4HrhpWsUMSbuuX8GtfhFJwOSBb5BRu8ITDB2VjNakfrR3qE8Zqa8IFDvL0KJq
         KmimNE4nAMcAb5Lrrkby4G/QBsl03Yd1jM4vUT0zM2h+wWmbiVQ3KJ71kRupQGZFQAG/
         PCi6vlx0ZFciPtWyY6pc48UaHLrEgyw7+pvu+YaBH0k7Aqmo7jmnPY9FGlChKX3ekkFO
         nqTd0dL+0oCpCYj21Pqal2q3GWBMf8bEQst4tomw1mtFHzbdym3XrSM1bvvgqwSGgVMR
         N/+A==
X-Gm-Message-State: ACgBeo0q2nuYiK+qZQhSCa0074VnpFbh827Q7GOoiP7ERSAeoe1fZAQm
        L8xT8SqBtGCzpdTCJjSEhTSDSw==
X-Google-Smtp-Source: AA6agR6+17js2D4DULv/JUrp7Ixl3ud3I3tEYVaIWV6kJIB1Gwydbqgv/FK9SYdhJIZEk+Cnac7x9w==
X-Received: by 2002:a05:6402:1848:b0:448:5f2e:e322 with SMTP id v8-20020a056402184800b004485f2ee322mr5354145edy.140.1661783002445;
        Mon, 29 Aug 2022 07:23:22 -0700 (PDT)
Received: from google.com (64.227.90.34.bc.googleusercontent.com. [34.90.227.64])
        by smtp.gmail.com with ESMTPSA id kx19-20020a170907775300b00734bfab4d59sm4582456ejc.170.2022.08.29.07.23.21
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 29 Aug 2022 07:23:21 -0700 (PDT)
Date:   Mon, 29 Aug 2022 14:23:17 +0000
From:   Quentin Perret <qperret@google.com>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Dietmar Eggemann <dietmar.eggemann@arm.com>,
        Ingo Molnar <mingo@kernel.org>,
        Morten Rasmussen <morten.rasmussen@arm.com>,
        Vincent Donnefort <vdonnefort@google.com>,
        Patrick Bellasi <patrick.bellasi@matbug.net>,
        Abhijeet Dharmapurikar <adharmap@quicinc.com>,
        Jian-Min <Jian-Min.Liu@mediatek.com>,
        Qais Yousef <qais.yousef@arm.com>, linux-kernel@vger.kernel.org
Subject: Re: [RFC PATCH 1/1] sched/pelt: Introduce PELT multiplier
Message-ID: <YwzL1eJUIReAEv0l@google.com>
References: <20220829055450.1703092-1-dietmar.eggemann@arm.com>
 <20220829055450.1703092-2-dietmar.eggemann@arm.com>
 <Ywxz7cuR+/+1CFMR@hirez.programming.kicks-ass.net>
 <YwyOzgbbUbB+JmSH@hirez.programming.kicks-ass.net>
 <CAKfTPtAnC4escfufhjJkqsYyhDPzpmQH4xYT4nj=EjCP7gzifg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAKfTPtAnC4escfufhjJkqsYyhDPzpmQH4xYT4nj=EjCP7gzifg@mail.gmail.com>
X-Spam-Status: No, score=-14.9 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,FSL_HELO_FAKE,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday 29 Aug 2022 at 12:13:26 (+0200), Vincent Guittot wrote:
> On Mon, 29 Aug 2022 at 12:03, Peter Zijlstra <peterz@infradead.org> wrote:
> >
> > On Mon, Aug 29, 2022 at 10:08:13AM +0200, Peter Zijlstra wrote:
> > > On Mon, Aug 29, 2022 at 07:54:50AM +0200, Dietmar Eggemann wrote:
> > > > From: Vincent Donnefort <vincent.donnefort@arm.com>
> > > >
> > > > The new sysctl sched_pelt_multiplier allows a user to set a clock
> > > > multiplier to x2 or x4 (x1 being the default). This clock multiplier
> > > > artificially speeds up PELT ramp up/down similarly to use a faster
> > > > half-life than the default 32ms.
> > > >
> > > >   - x1: 32ms half-life
> > > >   - x2: 16ms half-life
> > > >   - x4: 8ms  half-life
> > > >
> > > > Internally, a new clock is created: rq->clock_task_mult. It sits in the
> > > > clock hierarchy between rq->clock_task and rq->clock_pelt.
> > > >
> > > > Signed-off-by: Vincent Donnefort <vincent.donnefort@arm.com>
> > > > Signed-off-by: Dietmar Eggemann <dietmar.eggemann@arm.com>
> > >
> > > > +extern unsigned int sched_pelt_lshift;
> > > > +
> > > > +/*
> > > > + * absolute time   |1      |2      |3      |4      |5      |6      |
> > > > + * @ mult = 1      --------****************--------****************-
> > > > + * @ mult = 2      --------********----------------********---------
> > > > + * @ mult = 4      --------****--------------------****-------------
> > > > + * clock task mult
> > > > + * @ mult = 2      |   |   |2  |3  |   |   |   |   |5  |6  |   |   |
> > > > + * @ mult = 4      | | | | |2|3| | | | | | | | | | |5|6| | | | | | |
> > > > + *
> > > > + */
> > > > +static inline void update_rq_clock_task_mult(struct rq *rq, s64 delta)
> > > > +{
> > > > +   delta <<= READ_ONCE(sched_pelt_lshift);
> > > > +
> > > > +   rq->clock_task_mult += delta;
> > > > +
> > > > +   update_rq_clock_pelt(rq, delta);
> > > > +}
> > >
> > > Hurmph... I'd almost go write you something like
> > > static_call()/static_branch() but for immediates.
> > >
> > > That said; given there's only like 3 options, perhaps a few
> > > static_branch() instances work just fine ?
> >
> > Also, I'm not at all sure about exposing that as an official sysctl.
> 
> Me too, I would even make it a boot time parameter so we can remove
> the new clock_task_mult clock and left shift clock_taslk or the delta
> before passing it to clock_pelt

I'll let folks in CC comment about their use-case in more details, but
there's definitely been an interest in tuning this thing at run-time
FWIW. Typically a larger half-life will be fine with predictable
workloads with little inputs from users (e.g. fullscreen video playback)
while a lower one can be preferred in highly interactive cases (games,
...). The transient state is fun to reason about, but it really
shouldn't be too common AFAIK.

With that said I'd quite like to see numbers to back that claim.
Measuring power while running a video (for instance) with various HL
values should help. And similarly it shouldn't be too hard to get
performance numbers.
