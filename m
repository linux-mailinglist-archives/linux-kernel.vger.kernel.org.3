Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1052D485168
	for <lists+linux-kernel@lfdr.de>; Wed,  5 Jan 2022 11:49:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235406AbiAEKtY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 5 Jan 2022 05:49:24 -0500
Received: from outbound-smtp04.blacknight.com ([81.17.249.35]:34530 "EHLO
        outbound-smtp04.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235372AbiAEKtW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 5 Jan 2022 05:49:22 -0500
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp04.blacknight.com (Postfix) with ESMTPS id 5FEA7BEC2D
        for <linux-kernel@vger.kernel.org>; Wed,  5 Jan 2022 10:49:21 +0000 (GMT)
Received: (qmail 10575 invoked from network); 5 Jan 2022 10:49:21 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 5 Jan 2022 10:49:21 -0000
Date:   Wed, 5 Jan 2022 10:49:19 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Vincent Guittot <vincent.guittot@linaro.org>
Cc:     "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Valentin Schneider <Valentin.Schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20220105104918.GW3366@techsingularity.net>
References: <20211210093307.31701-3-mgorman@techsingularity.net>
 <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net>
 <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
 <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com>
 <20211215122550.GR3366@techsingularity.net>
 <YbuGYtxRSqVkOdbj@BLR-5CG11610CF.amd.com>
 <20211220111243.GS3366@techsingularity.net>
 <CAKfTPtARUODOnL9X-X+09cCu_BeMbZsW9U=kHX2vrXor7Du6qQ@mail.gmail.com>
 <20220105104207.GV3366@techsingularity.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220105104207.GV3366@techsingularity.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Jan 05, 2022 at 10:42:07AM +0000, Mel Gorman wrote:
> On Tue, Dec 21, 2021 at 06:13:15PM +0100, Vincent Guittot wrote:
> > > <SNIP>
> > >
> > > @@ -9050,9 +9054,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
> > >   * This is an approximation as the number of running tasks may not be
> > >   * related to the number of busy CPUs due to sched_setaffinity.
> > >   */
> > > -static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
> > > +static inline bool allow_numa_imbalance(int dst_running, int imb_numa_nr)
> > >  {
> > > -       return (dst_running < (dst_weight >> 2));
> > > +       return dst_running < imb_numa_nr;
> > >  }
> > >
> > >  /*
> > >
> > > <SNIP>
> > >
> > > @@ -9280,19 +9285,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> > >         }
> > >  }
> > >
> > > -#define NUMA_IMBALANCE_MIN 2
> > > -
> > >  static inline long adjust_numa_imbalance(int imbalance,
> > > -                               int dst_running, int dst_weight)
> > > +                               int dst_running, int imb_numa_nr)
> > >  {
> > > -       if (!allow_numa_imbalance(dst_running, dst_weight))
> > > +       if (!allow_numa_imbalance(dst_running, imb_numa_nr))
> > >                 return imbalance;
> > >
> > > -       /*
> > > -        * Allow a small imbalance based on a simple pair of communicating
> > > -        * tasks that remain local when the destination is lightly loaded.
> > > -        */
> > > -       if (imbalance <= NUMA_IMBALANCE_MIN)
> > > +       if (imbalance <= imb_numa_nr)
> > 
> > Isn't this always true ?
> > 
> > imbalance is "always" < dst_running as imbalance is usually the number
> > of these tasks that we would like to migrate
> > 
> 
> It's not necessarily true. allow_numa_imbalanced is checking if
> dst_running < imb_numa_nr and adjust_numa_imbalance is checking the
> imbalance.
> 
> imb_numa_nr = 4
> dst_running = 2
> imbalance   = 1
> 
> In that case, imbalance of 1 is ok, but 2 is not.
> 

My bad, this is based on v5 which I just queued for testing.

-- 
Mel Gorman
SUSE Labs
