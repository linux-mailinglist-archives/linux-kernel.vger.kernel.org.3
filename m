Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 159044A95B3
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 10:04:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357292AbiBDJEQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 04:04:16 -0500
Received: from outbound-smtp48.blacknight.com ([46.22.136.219]:49981 "EHLO
        outbound-smtp48.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229705AbiBDJEO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 04:04:14 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp48.blacknight.com (Postfix) with ESMTPS id E2438FABEA
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 09:04:13 +0000 (GMT)
Received: (qmail 23272 invoked from network); 4 Feb 2022 09:04:13 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Feb 2022 09:04:13 -0000
Date:   Fri, 4 Feb 2022 09:04:11 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20220204090411.GM3366@techsingularity.net>
References: <20220203144652.12540-1-mgorman@techsingularity.net>
 <20220203144652.12540-3-mgorman@techsingularity.net>
 <20220204070654.GF618915@linux.vnet.ibm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220204070654.GF618915@linux.vnet.ibm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 12:36:54PM +0530, Srikar Dronamraju wrote:
> * Mel Gorman <mgorman@techsingularity.net> [2022-02-03 14:46:52]:
> 
> > diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> > index d201a7052a29..e6cd55951304 100644
> > --- a/kernel/sched/topology.c
> > +++ b/kernel/sched/topology.c
> > @@ -2242,6 +2242,59 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
> >  		}
> >  	}
> > 
> > +	/*
> > +	 * Calculate an allowed NUMA imbalance such that LLCs do not get
> > +	 * imbalanced.
> > +	 */
> 
> We seem to adding this hunk before the sched_domains may be degenerated.
> Wondering if we really want to do it before degeneration.
> 

There was no obvious advantage versus doing it at the same time
characteristics like groups were being determined.

> Let say we have 3 sched domains and we calculated the sd->imb_numa_nr for
> all the 3 domains, then lets say the middle sched_domain gets degenerated. 
> Would the sd->imb_numa_nr's still be relevant?
> 

It's expected that it is still relevant as the ratios with respect to
SD_SHARE_PKG_RESOURCES should still be consistent.

> 
> > +	for_each_cpu(i, cpu_map) {
> > +		unsigned int imb = 0;
> > +		unsigned int imb_span = 1;
> > +
> > +		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> > +			struct sched_domain *child = sd->child;
> > +
> > +			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> > +			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > +				struct sched_domain *top, *top_p;
> > +				unsigned int nr_llcs;
> > +
> > +				/*
> > +				 * For a single LLC per node, allow an
> > +				 * imbalance up to 25% of the node. This is an
> > +				 * arbitrary cutoff based on SMT-2 to balance
> > +				 * between memory bandwidth and avoiding
> > +				 * premature sharing of HT resources and SMT-4
> > +				 * or SMT-8 *may* benefit from a different
> > +				 * cutoff.
> > +				 *
> > +				 * For multiple LLCs, allow an imbalance
> > +				 * until multiple tasks would share an LLC
> > +				 * on one node while LLCs on another node
> > +				 * remain idle.
> > +				 */
> > +				nr_llcs = sd->span_weight / child->span_weight;
> > +				if (nr_llcs == 1)
> > +					imb = sd->span_weight >> 2;
> > +				else
> > +					imb = nr_llcs;
> > +				sd->imb_numa_nr = imb;
> > +
> > +				/* Set span based on the first NUMA domain. */
> > +				top = sd;
> > +				top_p = top->parent;
> > +				while (top_p && !(top_p->flags & SD_NUMA)) {
> > +					top = top->parent;
> > +					top_p = top->parent;
> > +				}
> > +				imb_span = top_p ? top_p->span_weight : sd->span_weight;
> 
> I am getting confused by imb_span.
> Let say we have a topology of SMT -> MC -> DIE -> NUMA -> NUMA, with SMT and
> MC domains having SD_SHARE_PKG_RESOURCES flag set.
> We come here only for DIE domain.
> 
> imb_span set here is being used for both the subsequent sched domains
> most likely they will be NUMA domains. Right?
> 

Right.

> > +			} else {
> > +				int factor = max(1U, (sd->span_weight / imb_span));
> > +
> > +				sd->imb_numa_nr = imb * factor;
> 
> For SMT, (or any sched domains below the llcs) factor would be
> sd->span_weight but imb_numa_nr and imb would be 0.

Yes.

> For NUMA (or any sched domain just above DIE), factor would be
> sd->imb_numa_nr would be nr_llcs.
> For subsequent sched_domains, the sd->imb_numa_nr would be some multiple of
> nr_llcs. Right?
> 

Right.

-- 
Mel Gorman
SUSE Labs
