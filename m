Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 021B5467597
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 11:51:10 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352029AbhLCKyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 05:54:24 -0500
Received: from outbound-smtp47.blacknight.com ([46.22.136.64]:48061 "EHLO
        outbound-smtp47.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229750AbhLCKyW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 05:54:22 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp47.blacknight.com (Postfix) with ESMTPS id F08C9FB038
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 10:50:57 +0000 (GMT)
Received: (qmail 25378 invoked from network); 3 Dec 2021 10:50:57 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 3 Dec 2021 10:50:57 -0000
Date:   Fri, 3 Dec 2021 10:50:55 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Barry Song <21cnbao@gmail.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20211203105055.GB3366@techsingularity.net>
References: <20211201151844.20488-1-mgorman@techsingularity.net>
 <20211201151844.20488-3-mgorman@techsingularity.net>
 <CAGsJ_4xuYH8d18r9f5vUGYjNxtZ31FZrNZepEh8QCZbLW+3a6Q@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <CAGsJ_4xuYH8d18r9f5vUGYjNxtZ31FZrNZepEh8QCZbLW+3a6Q@mail.gmail.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 09:15:15PM +1300, Barry Song wrote:
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index d201a7052a29..fee2930745ab 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2242,6 +2242,26 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >                 }
> >         }
> >
> > +       /* Calculate allowed NUMA imbalance */
> > +       for_each_cpu(i, cpu_map) {
> > +               int imb_numa_nr = 0;
> > +
> > +               for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> > +                       struct sched_domain *child = sd->child;
> > +
> > +                       if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> > +                           (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > +                               int nr_groups;
> > +
> > +                               nr_groups = sd->span_weight / child->span_weight;
> > +                               imb_numa_nr = max(1U, ((child->span_weight) >> 1) /
> > +                                               (nr_groups * num_online_nodes()));
> 
> Hi Mel, you used to have 25% * numa_weight if node has only one LLC.
> for a system with 4 numa,  In case sd has 2 nodes, child is 1 numa node,
> then  nr_groups=2, num_online_nodes()=4,  imb_numa_nr will be
> child->span_weight/2/2/4?
> 
> Does this patch change the behaviour for machines whose numa equals LLC?
> 

Yes, it changes behaviour. Instead of a flat 25%, it takes into account
the number of LLCs per node and the number of nodes overall.

-- 
Mel Gorman
SUSE Labs
