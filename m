Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0BE6048C230
	for <lists+linux-kernel@lfdr.de>; Wed, 12 Jan 2022 11:24:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352491AbiALKYt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 12 Jan 2022 05:24:49 -0500
Received: from outbound-smtp23.blacknight.com ([81.17.249.191]:45485 "EHLO
        outbound-smtp23.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238224AbiALKYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 12 Jan 2022 05:24:47 -0500
Received: from mail.blacknight.com (pemlinmail04.blacknight.ie [81.17.254.17])
        by outbound-smtp23.blacknight.com (Postfix) with ESMTPS id 878D2BED54
        for <linux-kernel@vger.kernel.org>; Wed, 12 Jan 2022 10:24:45 +0000 (GMT)
Received: (qmail 12870 invoked from network); 12 Jan 2022 10:24:45 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 12 Jan 2022 10:24:45 -0000
Date:   Wed, 12 Jan 2022 10:24:43 +0000
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
Message-ID: <20220112102443.GZ3366@techsingularity.net>
References: <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
 <20211213130131.GQ3366@techsingularity.net>
 <YbddCcGJUpcPc8nS@BLR-5CG11610CF.amd.com>
 <YbnW/vLgE8MmQopN@BLR-5CG11610CF.amd.com>
 <20211215122550.GR3366@techsingularity.net>
 <YbuGYtxRSqVkOdbj@BLR-5CG11610CF.amd.com>
 <20211220111243.GS3366@techsingularity.net>
 <CAKfTPtARUODOnL9X-X+09cCu_BeMbZsW9U=kHX2vrXor7Du6qQ@mail.gmail.com>
 <20220105104207.GV3366@techsingularity.net>
 <CAKfTPtBCdgKb7gBDoFo3ictVYhgQGcneHViEtYj8o=WVH3kTaA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAKfTPtBCdgKb7gBDoFo3ictVYhgQGcneHViEtYj8o=WVH3kTaA@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jan 10, 2022 at 04:53:26PM +0100, Vincent Guittot wrote:
> On Wed, 5 Jan 2022 at 11:42, Mel Gorman <mgorman@techsingularity.net> wrote:
> >
> > On Tue, Dec 21, 2021 at 06:13:15PM +0100, Vincent Guittot wrote:
> > > > <SNIP>
> > > >
> > > > @@ -9050,9 +9054,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
> > > >   * This is an approximation as the number of running tasks may not be
> > > >   * related to the number of busy CPUs due to sched_setaffinity.
> > > >   */
> > > > -static inline bool allow_numa_imbalance(int dst_running, int dst_weight)
> > > > +static inline bool allow_numa_imbalance(int dst_running, int imb_numa_nr)
> > > >  {
> > > > -       return (dst_running < (dst_weight >> 2));
> > > > +       return dst_running < imb_numa_nr;
> > > >  }
> > > >
> > > >  /*
> > > >
> > > > <SNIP>
> > > >
> > > > @@ -9280,19 +9285,13 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
> > > >         }
> > > >  }
> > > >
> > > > -#define NUMA_IMBALANCE_MIN 2
> > > > -
> > > >  static inline long adjust_numa_imbalance(int imbalance,
> > > > -                               int dst_running, int dst_weight)
> > > > +                               int dst_running, int imb_numa_nr)
> > > >  {
> > > > -       if (!allow_numa_imbalance(dst_running, dst_weight))
> > > > +       if (!allow_numa_imbalance(dst_running, imb_numa_nr))
> > > >                 return imbalance;
> > > >
> > > > -       /*
> > > > -        * Allow a small imbalance based on a simple pair of communicating
> > > > -        * tasks that remain local when the destination is lightly loaded.
> > > > -        */
> > > > -       if (imbalance <= NUMA_IMBALANCE_MIN)
> > > > +       if (imbalance <= imb_numa_nr)
> > >
> > > Isn't this always true ?
> > >
> > > imbalance is "always" < dst_running as imbalance is usually the number
> > > of these tasks that we would like to migrate
> > >
> >
> > It's not necessarily true. allow_numa_imbalanced is checking if
> > dst_running < imb_numa_nr and adjust_numa_imbalance is checking the
> > imbalance.
> >
> > imb_numa_nr = 4
> > dst_running = 2
> > imbalance   = 1
> >
> > In that case, imbalance of 1 is ok, but 2 is not.
> 
> I don't catch your example. Why is imbalance = 2 not ok in your
> example above ? allow_numa_imbalance still returns true (dst-running <
> imb_numa_nr) and we still have imbalance <= imb_numa_nr
> 

At the time I wrote it, the comparison looked like < instead of <=.

> Also the name dst_running is quite confusing; In the case of
> calculate_imbalance, busiest->nr_running is passed as dst_running
> argument. But the busiest group is the src not the dst of the balance
> 
> Then,  imbalance < busiest->nr_running in load_balance because we try
> to even the number of task running in each groups without emptying it
> and allow_numa_imbalance checks that dst_running < imb_numa_nr. So we
> have imbalance < dst_running < imb_numa_nr
> 

But either way, you have a valid point. The patch as-is is too complex
and doing too much and is failing to make progress as a result. I'm going
to go back to the drawing board and come up with a simpler version that
adjusts the cut-off depending on topology but only allows an imbalance
of NUMA_IMBALANCE_MIN and tidy up the inconsistencies.

> > This?
> >
> >                                  * The 25% imbalance is an arbitrary cutoff
> >                                  * based on SMT-2 to balance between memory
> >                                  * bandwidth and avoiding premature sharing
> >                                  * of HT resources and SMT-4 or SMT-8 *may*
> >                                  * benefit from a different cutoff. nr_llcs
> >                                  * are accounted for to mitigate premature
> >                                  * cache eviction due to multiple tasks
> >                                  * using one cache while a sibling cache
> >                                  * remains relatively idle.
> >
> > > For example, why is it better than just 25% of the LLC weight ?
> >
> > Because lets say there are 2 LLCs then an imbalance based on just the LLC
> > weight might allow 2 tasks to share one cache while another is idle. This
> > is the original problem whereby the vanilla imbalance allowed multiple
> > LLCs on the same node to be overloaded which hurt workloads that prefer
> > to spread wide.
> 
> In this case, shouldn't it be (llc_weight >> 2) * nr_llcs to fill each
> llc up to 25%  ? instead of dividing by nr_llcs
> 
> As an example, you have
> 1 node with 1 LLC with 128 CPUs will get an imb_numa_nr = 32
> 1 node with 2 LLC with 64 CPUs each will get an imb_numa_nr = 8
> 1 node with 4 LLC with 32 CPUs each will get an imb_numa_nr = 2
> 
> sd->imb_numa_nr is used at NUMA level so the more LLC you have the
> lower imbalance is allowed
> 

The more LLCs, the lower the threshold where imbalances is allowed is
deliberate given that the motivating problem was that embarassingly
parallel problems on AMD suffer due to overloading some LLCs while
others remain idle.

-- 
Mel Gorman
SUSE Labs
