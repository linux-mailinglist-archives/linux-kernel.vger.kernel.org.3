Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11D4B4BA0CE
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 14:15:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237065AbiBQNPd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 08:15:33 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:59936 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231520AbiBQNPb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 08:15:31 -0500
Received: from outbound-smtp60.blacknight.com (outbound-smtp60.blacknight.com [46.22.136.244])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 82AEF2AB52F
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 05:15:16 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail01.blacknight.ie [81.17.254.10])
        by outbound-smtp60.blacknight.com (Postfix) with ESMTPS id D58EFFAF4D
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 13:15:14 +0000 (GMT)
Received: (qmail 28296 invoked from network); 17 Feb 2022 13:15:14 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Feb 2022 13:15:14 -0000
Date:   Thu, 17 Feb 2022 13:15:12 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v4] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <20220217131512.GW3366@techsingularity.net>
References: <20220217055408.28151-1-kprateek.nayak@amd.com>
 <20220217100523.GV3366@techsingularity.net>
 <a57dbac2-1b8e-ea5c-8b6c-3a97ac186ad9@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <a57dbac2-1b8e-ea5c-8b6c-3a97ac186ad9@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_MSPIKE_H2,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 04:53:51PM +0530, K Prateek Nayak wrote:
> Hello Mel,
> 
> 
> Thank you for looking into the patch.
> 
> On 2/17/2022 3:35 PM, Mel Gorman wrote:
> > Thanks Prateek,
> >
> > On Thu, Feb 17, 2022 at 11:24:08AM +0530, K Prateek Nayak wrote:
> >> [..snip..]
> >>
> >> Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8
> >>
> > In this case the stream threads can use any CPU of the subset, presumably
> > this is parallelised with OpenMP without specifying spread or bind
> > directives.
> Yes it is parallelized using OpenMP without specifying any directive.
> > [..snip..]
> > One concern I have is that we incur a cpumask setup and cpumask_weight
> > cost on every clone whether a restricted CPU mask is used or not.  Peter,
> > is it acceptable to avoid the cpumask check if there is no restrictions
> > on allowed cpus like this?
> >
> > 	imb = sd->imb_numa_nr;
> > 	if (p->nr_cpus_allowed != num_online_cpus())
> > 		struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> >
> > 		cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> > 		imb = min(cpumask_weight(cpus), imb);
> > 	}
> Can we optimize this further as:
> 
> 	imb = sd->imb_numa_nr;
> 	if (unlikely(p->nr_cpus_allowed != num_online_cpus()))
> 		struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> 
> 		cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> 		imb = min(cpumask_weight(cpus), imb);
> 	}
> 
> As for most part, p->nr_cpus_allowed will be equal to num_online_cpus()
> unless user has specifically pinned the task.
> 

I'm a little wary due to https://lwn.net/Articles/420019/ raising concerns
from people that feel more strongly about likely/unlikely use. Whether that
branch is likely true or not is specific to the deployment. On my desktop
and most tests I run, the branch is very unlikely because most workloads
I run are usually not CPU-constrained and not fork-intensive. Even those
that are CPU contrained are generally not fork intensive. For a setup with
lots of containers, virtual machines, locality-aware applications etc,
the path is potentially very likely and harder to detect in the future.

I don't object to the change but I would wonder if it's measurable for
anything other than a fork-intensive microbenchmark given it's one branch
in a relatively heavy operation.

I think a relatively harmless micro-optimisation would be

-		imb = min(cpumask_weight(cpus), imb);
+		imb = cpumask_weight(cpus);

It assumes that the constrained cpus_allowed would have a lower imb
than one calculated based on all cpus allowed which sounds like a safe
assumption other than racing with hot-onlining a bunch of CPUs.

I think both micro-optimisations are negligible in comparison to avoiding
an unecessary cpumask_and cpumask_weight call. FWIW, I looked at my own
use of likely/unlikely recently and it's

c49c2c47dab6b8d45022b3fabf0642a0e62e3109 unlikely that memory hotplug operation is in progress
3b12e7e97938424de2bb1b95ba0bd6a49bad39f9 hotplug active or machine booting
df1acc856923c0a65c28b588585449106c316b71 memory isolated for hotplug or CMA attempt in progress
56f0e661ea8c0178e80048df7166653a51ef2c3d memory isolated for hotplug or CMA attempt in progress
b3b64ebd38225d8032b5db42938d969b602040c2 bulk allocation request with an array that already has pages

Of those, the last one is the most marginal because it really depends
on whether network core or NFS is the heavy user of the interface and
I made a guess that high-speed networks are more common critical paths
than NFS servers.

-- 
Mel Gorman
SUSE Labs
