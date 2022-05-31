Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4370538EC9
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 12:27:20 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245678AbiEaK1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 06:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40148 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245671AbiEaK1F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 06:27:05 -0400
Received: from mail-yb1-xb2f.google.com (mail-yb1-xb2f.google.com [IPv6:2607:f8b0:4864:20::b2f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1CFB026F
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:27:03 -0700 (PDT)
Received: by mail-yb1-xb2f.google.com with SMTP id i11so23085564ybq.9
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 03:27:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Ag4xvrQYIa6XFpM1uC8ra5KlxcoQ7ACzSYyBP9Y3Jlo=;
        b=x4+i/52mGHO3BhUhOf69L16+Z/9d71jNlrJ33AhmYDwuA70nzXUAVkzXtYgEbDUnZJ
         Sh6bqSzSKF5jPYWiNNdBG6vFccj00+KNIiZVlN8PA0bAN0FcHTraXUoiKA2Hl9CRqwlH
         BAOD//9p2xGuSANARkl+jw7IJrxWGHAScTcKFMoeycEG1f3PFnMYheOqZgHfZcLFP74w
         HW8dx1I8wro1a13l0TI7yO65PEebq4UsNz6EUz8M6pKBrED9zpJ37vTzb5nSuFPBkgOf
         EDQLQ6la/pCPtLdTDq+l2OuJuypi63GUZZBHfkGS71S7yZ+r2qapMQM82od4xYlNHNsy
         4jLQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Ag4xvrQYIa6XFpM1uC8ra5KlxcoQ7ACzSYyBP9Y3Jlo=;
        b=4FA9NhY7C8D+dTK6iXZBz7UV/AkIsyMcxTMOmTVwK+iPZg8t4Qg/auCrfBQPTmOcci
         fM4Z/VUw1vDFXsC+3CuJ0CdzTA7WC0QlDI2apl0Mln3yalVlFX2XXoKfWD3eP/YN+LY4
         duP7TqpcLNUDDtbn0sr2nRd2D8Sp7WscDENnxqnlUSCiXl9CnUlTiwja52R45yJeBAE8
         k7C4hTsBWoUZJ7Mn29xuAUWv0WCjeBXT6w7SZtx/SLWYaB8BSei4ZW2vSk2/u5PLgI7X
         W/37AqAra8jCaCA7DJuTVeWLCKqVgWOYF3Y+28PamobrtFeds+dLnHuHv8MjRqChUb5H
         2EtQ==
X-Gm-Message-State: AOAM531vc91PQt1Yo9DamRhjnre/2Ma8aN6ZC2KL8om1gs3deyZUC/ZH
        Z40iusx6cx/7qzBXOTvdrOoSFNbKFI5uLbeKZX4irA==
X-Google-Smtp-Source: ABdhPJzh+wCHzAjh1onv9OmVebGxsxyki/rc6kwru3nHFpGdAZtXO72EStNjjeiKYKsH2NWCjEK+LYJaU6ES1F4Jfak=
X-Received: by 2002:a05:6902:1544:b0:64f:4b6c:b440 with SMTP id
 r4-20020a056902154400b0064f4b6cb440mr54502241ybu.424.1653992822304; Tue, 31
 May 2022 03:27:02 -0700 (PDT)
MIME-Version: 1.0
References: <20220520103519.1863-1-mgorman@techsingularity.net>
 <CAKfTPtDERvGAsmasGK=xtGEawx1yK6Lf4mV7Cc7JcNFKrxUWKw@mail.gmail.com> <20220525124933.GA3441@techsingularity.net>
In-Reply-To: <20220525124933.GA3441@techsingularity.net>
From:   Vincent Guittot <vincent.guittot@linaro.org>
Date:   Tue, 31 May 2022 12:26:51 +0200
Message-ID: <CAKfTPtDnbnNLgE40Xk1r_Hv6J3=wUkLzV15cdmijoVuf9Cy2+A@mail.gmail.com>
Subject: Re: [PATCH v2 0/4] Mitigate inconsistent NUMA imbalance behaviour
To:     Mel Gorman <mgorman@techsingularity.net>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Ying Huang <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 25 May 2022 at 14:49, Mel Gorman <mgorman@techsingularity.net> wrote:
>
> On Tue, May 24, 2022 at 06:01:07PM +0200, Vincent Guittot wrote:
> > > This is the min, max and range of run time for mg.D parallelised with ~25%
> > > of the CPUs parallelised by MPICH running on a 2-socket machine (80 CPUs,
> > > 16 active for mg.D due to limitations of mg.D).
> > >
> > > v5.3                                     Min  95.84 Max  96.55 Range   0.71 Mean  96.16
> > > v5.7                                     Min  95.44 Max  96.51 Range   1.07 Mean  96.14
> > > v5.8                                     Min  96.02 Max 197.08 Range 101.06 Mean 154.70
> > > v5.12                                    Min 104.45 Max 111.03 Range   6.58 Mean 105.94
> > > v5.13                                    Min 104.38 Max 170.37 Range  65.99 Mean 117.35
> > > v5.13-revert-c6f886546cb8                Min 104.40 Max 110.70 Range   6.30 Mean 105.68
> > > v5.18rc4-baseline                        Min 110.78 Max 169.84 Range  59.06 Mean 131.22
> > > v5.18rc4-revert-c6f886546cb8             Min 113.98 Max 117.29 Range   3.31 Mean 114.71
> > > v5.18rc4-this_series                     Min  95.56 Max 163.97 Range  68.41 Mean 105.39
> > > v5.18rc4-this_series-revert-c6f886546cb8 Min  95.56 Max 104.86 Range   9.30 Mean  97.00
> >
> > I'm interested to understand why such instability can be introduced by
> > c6f886546cb8 as it aims to do the opposite by not waking up a random
> > idle cpu but using the current cpu which is becoming idle, instead. I
> > haven't been able to reproduce your problem with my current setup but
> > I assume this is specific to some use cases so I will try to reproduce
> > the mg.D test above. If you have more details on the setup to ease the
> > reproduction of the problem I'm interested.
> >
>
> Thanks Vincent,
>
> The most straight-forward way to reproduce is via mmtests.
>
> # git clone https://github.com/gormanm/mmtests/
> # cd mmtests
> # ./bin/generate-generic-configs
> # ./run-mmtests.sh --run-monitor --config configs/config-hpc-nas-mpich-quarter-mgD-many test-mgD-many
> # cd work/log
> # ../../compare-kernels.sh
>
> nas-mpich-mg NAS Time
>                                  test
>                              mgD-many
> Min       mg.D       95.80 (   0.00%)
> Amean     mg.D      110.77 (   0.00%)
> Stddev    mg.D       21.55 (   0.00%)
> CoeffVar  mg.D       19.46 (   0.00%)
> Max       mg.D      155.35 (   0.00%)
> BAmean-50 mg.D       96.05 (   0.00%)
> BAmean-95 mg.D      107.83 (   0.00%)
> BAmean-99 mg.D      109.23 (   0.00%)
>
> Note the min of 95.80 seconds, max of 155.35 and high stddev indicating
> the results are not stable.
>
> The generated config is for openSUSE so it may not work for you. After
> installing the mpich package, you'll need to adjust these lines
>
> export NAS_MPICH_PATH=/usr/$MMTESTS_LIBDIR/mpi/gcc/$NAS_MPICH_VERSION/bin
> export NAS_MPICH_LIBPATH=/usr/$MMTESTS_LIBDIR/mpi/gcc/$NAS_MPICH_VERSION/$MMTESTS_LIBDIR
>
> NAS_MPICH_PATH and NAS_MPICH_LIBPATH need to point to the bin and lib
> path for the mpich package your distribution ships.

I have been able to run your tests on my setup: aarch64 2 nodes * 28
cores * 4 threads. But I can't reproduce the problem, results stay
stable before and after reverting c6f886546cb8.

I will continue to try to reproduce it

nas-mpich-mg NAS Time
                                 test                   test
                     mgD-many-v5.18-0 mgD-many-v5.18-revert-0
Min       mg.D       78.76 (   0.00%)       78.78 (  -0.03%)
Amean     mg.D       81.13 (   0.00%)       81.45 *  -0.40%*
Stddev    mg.D        0.96 (   0.00%)        1.12 ( -16.84%)
CoeffVar  mg.D        1.18 (   0.00%)        1.37 ( -16.38%)
Max       mg.D       82.71 (   0.00%)       82.91 (  -0.24%)
BAmean-50 mg.D       80.41 (   0.00%)       80.65 (  -0.30%)
BAmean-95 mg.D       81.02 (   0.00%)       81.34 (  -0.39%)
BAmean-99 mg.D       81.07 (   0.00%)       81.40 (  -0.40%)

>
> --
> Mel Gorman
> SUSE Labs
