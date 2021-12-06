Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41EC6469C45
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 16:18:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347859AbhLFPVa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 10:21:30 -0500
Received: from outbound-smtp29.blacknight.com ([81.17.249.32]:49965 "EHLO
        outbound-smtp29.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1356622AbhLFPPi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 10:15:38 -0500
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp29.blacknight.com (Postfix) with ESMTPS id 19E62BED5F
        for <linux-kernel@vger.kernel.org>; Mon,  6 Dec 2021 15:12:09 +0000 (GMT)
Received: (qmail 6806 invoked from network); 6 Dec 2021 15:12:08 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.29])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 6 Dec 2021 15:12:08 -0000
Date:   Mon, 6 Dec 2021 15:12:06 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Peter Zijlstra <peterz@infradead.org>
Cc:     Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20211206151206.GH3366@techsingularity.net>
References: <20211201151844.20488-1-mgorman@techsingularity.net>
 <20211201151844.20488-3-mgorman@techsingularity.net>
 <20211204104056.GR16608@worktop.programming.kicks-ass.net>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20211204104056.GR16608@worktop.programming.kicks-ass.net>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Dec 04, 2021 at 11:40:56AM +0100, Peter Zijlstra wrote:
> On Wed, Dec 01, 2021 at 03:18:44PM +0000, Mel Gorman wrote:
> > +	/* Calculate allowed NUMA imbalance */
> > +	for_each_cpu(i, cpu_map) {
> > +		int imb_numa_nr = 0;
> > +
> > +		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> > +			struct sched_domain *child = sd->child;
> > +
> > +			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> > +			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> > +				int nr_groups;
> > +
> > +				nr_groups = sd->span_weight / child->span_weight;
> > +				imb_numa_nr = max(1U, ((child->span_weight) >> 1) /
> > +						(nr_groups * num_online_nodes()));
> > +			}
> > +
> > +			sd->imb_numa_nr = imb_numa_nr;
> > +		}
> 
> OK, so let's see. All domains with SHARE_PKG_RESOURCES set will have
> imb_numa_nr = 0, all domains above it will have the same value
> calculated here.
> 
> So far so good I suppose :-)
> 

Good start :)

> Then nr_groups is what it says on the tin; we could've equally well
> iterated sd->groups and gotten the same number, but this is simpler.
> 

I also thought it would be clearer.

> Now, imb_numa_nr is where the magic happens, the way it's written
> doesn't help, but it's something like:
> 
> 	(child->span_weight / 2) / (nr_groups * num_online_nodes())
> 
> With a minimum value of 1. So the larger the system is, or the smaller
> the LLCs, the smaller this number gets, right?
> 

Correct.

> So my ivb-ep that has 20 cpus in a LLC and 2 nodes, will get: (20 / 2)
> / (1 * 2) = 10, while the ivb-ex will get: (20/2) / (1*4) = 5.
> 
> But a Zen box that has only like 4 CPUs per LLC will have 1, regardless
> of how many nodes it has.
> 

The minimum of one was to allow a pair of communicating tasks to remain
on one node even if it's imbalacnced.

> Now, I'm thinking this assumes (fairly reasonable) that the level above
> LLC is a node, but I don't think we need to assume this, while also not
> assuming the balance domain spans the whole machine (yay paritions!).
> 
> 	for (top = sd; top->parent; top = top->parent)
> 		;
> 
> 	nr_llcs = top->span_weight / child->span_weight;
> 	imb_numa_nr = max(1, child->span_weight / nr_llcs);
> 
> which for my ivb-ep gets me:  20 / (40 / 20) = 10
> and the Zen system will have:  4 / (huge number) = 1
> 
> Now, the exp: a / (b / a) is equivalent to a * (a / b) or a^2/b, so we
> can also write the above as:
> 
> 	(child->span_weight * child->span_weight) / top->span_weight;
> 

Gautham had similar reasoning to calculate the imbalance at each
higher-level domain instead of using a static value throughout and
it does make sense. For each level and splitting the imbalance between
two domains, this works out as


	/*
	 * Calculate an allowed NUMA imbalance such that LLCs do not get
	 * imbalanced.
	 */
	for_each_cpu(i, cpu_map) {
		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
			struct sched_domain *child = sd->child;

			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
				struct sched_domain *top = sd;
				unsigned int llc_sq;

				/*
				 * nr_llcs = (top->span_weight / llc_weight);
				 * imb = (child_weight / nr_llcs) >> 1
				 *
				 * is equivalent to
				 *
				 * imb = (llc_weight^2 / top->span_weight) >> 1
				 *
				 */
				llc_sq = child->span_weight * child->span_weight;
				while (top) {
					top->imb_numa_nr = max(1U,
						(llc_sq / top->span_weight) >> 1);
					top = top->parent;
				}

				break;
			}
		}
	}

I'll test this and should have results tomorrow.

-- 
Mel Gorman
SUSE Labs
