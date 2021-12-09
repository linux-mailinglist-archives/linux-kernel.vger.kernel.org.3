Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9181446EC04
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Dec 2021 16:43:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240091AbhLIPqm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Dec 2021 10:46:42 -0500
Received: from outbound-smtp40.blacknight.com ([46.22.139.223]:33473 "EHLO
        outbound-smtp40.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S236792AbhLIPql (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Dec 2021 10:46:41 -0500
Received: from mail.blacknight.com (pemlinmail05.blacknight.ie [81.17.254.26])
        by outbound-smtp40.blacknight.com (Postfix) with ESMTPS id B4CB81C3C35
        for <linux-kernel@vger.kernel.org>; Thu,  9 Dec 2021 15:43:06 +0000 (GMT)
Received: (qmail 32476 invoked from network); 9 Dec 2021 15:43:06 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.197.169])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 9 Dec 2021 15:43:06 -0000
Date:   Thu, 9 Dec 2021 15:43:04 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     Valentin Schneider <valentin.schneider@arm.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        "Gautham R. Shenoy" <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20211209154304.GN3366@techsingularity.net>
References: <20211201151844.20488-1-mgorman@techsingularity.net>
 <20211201151844.20488-3-mgorman@techsingularity.net>
 <20211204104056.GR16608@worktop.programming.kicks-ass.net>
 <20211206151206.GH3366@techsingularity.net>
 <87y24t97rn.mognet@arm.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <87y24t97rn.mognet@arm.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 09, 2021 at 02:23:40PM +0000, Valentin Schneider wrote:
> On 06/12/21 15:12, Mel Gorman wrote:
> > Gautham had similar reasoning to calculate the imbalance at each
> > higher-level domain instead of using a static value throughout and
> > it does make sense. For each level and splitting the imbalance between
> > two domains, this works out as
> >
> >
> >       /*
> >        * Calculate an allowed NUMA imbalance such that LLCs do not get
> >        * imbalanced.
> >        */
> >       for_each_cpu(i, cpu_map) {
> >               for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> >                       struct sched_domain *child = sd->child;
> >
> >                       if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> >                           (child->flags & SD_SHARE_PKG_RESOURCES)) {
> >                               struct sched_domain *top = sd;
> >                               unsigned int llc_sq;
> >
> >                               /*
> >                                * nr_llcs = (top->span_weight / llc_weight);
> >                                * imb = (child_weight / nr_llcs) >> 1
> >                                *
> >                                * is equivalent to
> >                                *
> >                                * imb = (llc_weight^2 / top->span_weight) >> 1
> >                                *
> >                                */
> >                               llc_sq = child->span_weight * child->span_weight;
> >                               while (top) {
> >                                       top->imb_numa_nr = max(1U,
> >                                               (llc_sq / top->span_weight) >> 1);
> >                                       top = top->parent;
> >                               }
> >
> >                               break;
> >                       }
> >               }
> >       }
> >
> 
> IIRC Peter suggested punting that logic to before domains get degenerated,
> but I don't see how that helps here. If you just want to grab the LLC
> domain (aka highest_flag_domain(cpu, SD_SHARE_PKG_RESOURCES)) and compare
> its span with that of its parents, that can happen after the degeneration,
> no?
> 

I guess we could but I don't see any specific advantage to doing that.

> > I'll test this and should have results tomorrow.
> >

The test results indicated that there was still a problem with
communicating tasks being pulled apart so am testing a new version.

-- 
Mel Gorman
SUSE Labs
