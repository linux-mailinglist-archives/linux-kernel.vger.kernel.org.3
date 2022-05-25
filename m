Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11785533CF6
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 14:50:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243597AbiEYMtp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 08:49:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234909AbiEYMtk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 08:49:40 -0400
Received: from outbound-smtp12.blacknight.com (outbound-smtp12.blacknight.com [46.22.139.17])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB0E7B9FF
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 05:49:37 -0700 (PDT)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp12.blacknight.com (Postfix) with ESMTPS id B674F1C3865
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 13:49:35 +0100 (IST)
Received: (qmail 27432 invoked from network); 25 May 2022 12:49:35 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.198.246])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 25 May 2022 12:49:35 -0000
Date:   Wed, 25 May 2022 13:49:33 +0100
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
Message-ID: <20220525124933.GA3441@techsingularity.net>
References: <20220520103519.1863-1-mgorman@techsingularity.net>
 <CAKfTPtDERvGAsmasGK=xtGEawx1yK6Lf4mV7Cc7JcNFKrxUWKw@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtDERvGAsmasGK=xtGEawx1yK6Lf4mV7Cc7JcNFKrxUWKw@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 24, 2022 at 06:01:07PM +0200, Vincent Guittot wrote:
> > This is the min, max and range of run time for mg.D parallelised with ~25%
> > of the CPUs parallelised by MPICH running on a 2-socket machine (80 CPUs,
> > 16 active for mg.D due to limitations of mg.D).
> >
> > v5.3                                     Min  95.84 Max  96.55 Range   0.71 Mean  96.16
> > v5.7                                     Min  95.44 Max  96.51 Range   1.07 Mean  96.14
> > v5.8                                     Min  96.02 Max 197.08 Range 101.06 Mean 154.70
> > v5.12                                    Min 104.45 Max 111.03 Range   6.58 Mean 105.94
> > v5.13                                    Min 104.38 Max 170.37 Range  65.99 Mean 117.35
> > v5.13-revert-c6f886546cb8                Min 104.40 Max 110.70 Range   6.30 Mean 105.68
> > v5.18rc4-baseline                        Min 110.78 Max 169.84 Range  59.06 Mean 131.22
> > v5.18rc4-revert-c6f886546cb8             Min 113.98 Max 117.29 Range   3.31 Mean 114.71
> > v5.18rc4-this_series                     Min  95.56 Max 163.97 Range  68.41 Mean 105.39
> > v5.18rc4-this_series-revert-c6f886546cb8 Min  95.56 Max 104.86 Range   9.30 Mean  97.00
> 
> I'm interested to understand why such instability can be introduced by
> c6f886546cb8 as it aims to do the opposite by not waking up a random
> idle cpu but using the current cpu which is becoming idle, instead. I
> haven't been able to reproduce your problem with my current setup but
> I assume this is specific to some use cases so I will try to reproduce
> the mg.D test above. If you have more details on the setup to ease the
> reproduction of the problem I'm interested.
> 

Thanks Vincent,

The most straight-forward way to reproduce is via mmtests.

# git clone https://github.com/gormanm/mmtests/
# cd mmtests
# ./bin/generate-generic-configs
# ./run-mmtests.sh --run-monitor --config configs/config-hpc-nas-mpich-quarter-mgD-many test-mgD-many
# cd work/log
# ../../compare-kernels.sh

nas-mpich-mg NAS Time
                                 test
                             mgD-many
Min       mg.D       95.80 (   0.00%)
Amean     mg.D      110.77 (   0.00%)
Stddev    mg.D       21.55 (   0.00%)
CoeffVar  mg.D       19.46 (   0.00%)
Max       mg.D      155.35 (   0.00%)
BAmean-50 mg.D       96.05 (   0.00%)
BAmean-95 mg.D      107.83 (   0.00%)
BAmean-99 mg.D      109.23 (   0.00%)

Note the min of 95.80 seconds, max of 155.35 and high stddev indicating
the results are not stable.

The generated config is for openSUSE so it may not work for you. After
installing the mpich package, you'll need to adjust these lines

export NAS_MPICH_PATH=/usr/$MMTESTS_LIBDIR/mpi/gcc/$NAS_MPICH_VERSION/bin
export NAS_MPICH_LIBPATH=/usr/$MMTESTS_LIBDIR/mpi/gcc/$NAS_MPICH_VERSION/$MMTESTS_LIBDIR

NAS_MPICH_PATH and NAS_MPICH_LIBPATH need to point to the bin and lib
path for the mpich package your distribution ships.

-- 
Mel Gorman
SUSE Labs
