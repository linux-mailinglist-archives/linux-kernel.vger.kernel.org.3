Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 89A625392F0
	for <lists+linux-kernel@lfdr.de>; Tue, 31 May 2022 16:10:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344864AbiEaOKJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 31 May 2022 10:10:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345144AbiEaOKE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 31 May 2022 10:10:04 -0400
Received: from outbound-smtp06.blacknight.com (outbound-smtp06.blacknight.com [81.17.249.39])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5DC56543C
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 07:09:59 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp06.blacknight.com (Postfix) with ESMTPS id A52BCE018
        for <linux-kernel@vger.kernel.org>; Tue, 31 May 2022 15:09:57 +0100 (IST)
Received: (qmail 19110 invoked from network); 31 May 2022 14:09:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 31 May 2022 14:09:57 -0000
Date:   Tue, 31 May 2022 15:09:24 +0100
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        K Prateek Nayak <kprateek.nayak@amd.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Ying Huang <ying.huang@intel.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 0/4] Mitigate inconsistent NUMA imbalance behaviour
Message-ID: <20220531140924.GA3401@techsingularity.net>
References: <20220520103519.1863-1-mgorman@techsingularity.net>
 <CAKfTPtDERvGAsmasGK=xtGEawx1yK6Lf4mV7Cc7JcNFKrxUWKw@mail.gmail.com>
 <20220525124933.GA3441@techsingularity.net>
 <CAKfTPtDnbnNLgE40Xk1r_Hv6J3=wUkLzV15cdmijoVuf9Cy2+A@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDnbnNLgE40Xk1r_Hv6J3=wUkLzV15cdmijoVuf9Cy2+A@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 31, 2022 at 12:26:51PM +0200, Vincent Guittot wrote:
> > # cd work/log
> > # ../../compare-kernels.sh
> >
> > nas-mpich-mg NAS Time
> >                                  test
> >                              mgD-many
> > Min       mg.D       95.80 (   0.00%)
> > Amean     mg.D      110.77 (   0.00%)
> > Stddev    mg.D       21.55 (   0.00%)
> > CoeffVar  mg.D       19.46 (   0.00%)
> > Max       mg.D      155.35 (   0.00%)
> > BAmean-50 mg.D       96.05 (   0.00%)
> > BAmean-95 mg.D      107.83 (   0.00%)
> > BAmean-99 mg.D      109.23 (   0.00%)
> >
> > Note the min of 95.80 seconds, max of 155.35 and high stddev indicating
> > the results are not stable.
> >
> > The generated config is for openSUSE so it may not work for you. After
> > installing the mpich package, you'll need to adjust these lines
> >
> > export NAS_MPICH_PATH=/usr/$MMTESTS_LIBDIR/mpi/gcc/$NAS_MPICH_VERSION/bin
> > export NAS_MPICH_LIBPATH=/usr/$MMTESTS_LIBDIR/mpi/gcc/$NAS_MPICH_VERSION/$MMTESTS_LIBDIR
> >
> > NAS_MPICH_PATH and NAS_MPICH_LIBPATH need to point to the bin and lib
> > path for the mpich package your distribution ships.
> 
> I have been able to run your tests on my setup: aarch64 2 nodes * 28
> cores * 4 threads. But I can't reproduce the problem, results stay
> stable before and after reverting c6f886546cb8.
> 

It's unfortunate but not surprising that it's not perfectly reproducible
given that I expect this to be a race of some description and not all
machines will observe the problem.

Thanks for trying.

-- 
Mel Gorman
SUSE Labs
