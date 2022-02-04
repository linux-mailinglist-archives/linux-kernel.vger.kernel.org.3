Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33BF04A9D1C
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Feb 2022 17:46:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376630AbiBDQqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Feb 2022 11:46:00 -0500
Received: from outbound-smtp35.blacknight.com ([46.22.139.218]:43195 "EHLO
        outbound-smtp35.blacknight.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233928AbiBDQp7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Feb 2022 11:45:59 -0500
Received: from mail.blacknight.com (pemlinmail06.blacknight.ie [81.17.255.152])
        by outbound-smtp35.blacknight.com (Postfix) with ESMTPS id C9AD52036
        for <linux-kernel@vger.kernel.org>; Fri,  4 Feb 2022 16:45:58 +0000 (GMT)
Received: (qmail 20019 invoked from network); 4 Feb 2022 16:45:58 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 4 Feb 2022 16:45:58 -0000
Date:   Fri, 4 Feb 2022 16:45:57 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     "Nayak, KPrateek (K Prateek)" <kprateek.nayak@amd.com>
Cc:     Peter Zijlstra <peterz@infradead.org>,
        Ingo Molnar <mingo@kernel.org>,
        Vincent Guittot <vincent.guittot@linaro.org>,
        Valentin Schneider <valentin.schneider@arm.com>,
        Aubrey Li <aubrey.li@linux.intel.com>,
        Barry Song <song.bao.hua@hisilicon.com>,
        Mike Galbraith <efault@gmx.de>,
        Srikar Dronamraju <srikar@linux.vnet.ibm.com>,
        Gautham Shenoy <gautham.shenoy@amd.com>,
        LKML <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] sched/fair: Adjust the allowed NUMA imbalance when
 SD_NUMA spans multiple LLCs
Message-ID: <20220204164556.GN3366@techsingularity.net>
References: <20220203144652.12540-1-mgorman@techsingularity.net>
 <20220203144652.12540-3-mgorman@techsingularity.net>
 <9d7e8fe1-d9d7-90df-0f30-cf82b82e7f1f@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <9d7e8fe1-d9d7-90df-0f30-cf82b82e7f1f@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 04, 2022 at 08:37:53PM +0530, Nayak, KPrateek (K Prateek) wrote:
> On 2/3/2022 8:16 PM, Mel Gorman wrote:
> > @@ -9003,10 +9006,9 @@ static bool update_pick_idlest(struct sched_group *idlest,
> >   * This is an approximation as the number of running tasks may not be
> >   * related to the number of busy CPUs due to sched_setaffinity.
> >   */
> > -static inline bool
> > -allow_numa_imbalance(unsigned int running, unsigned int weight)
> > +static inline bool allow_numa_imbalance(int running, int imb_numa_nr)
> >  {
> > -	return (running < (weight >> 2));
> > +	return running < imb_numa_nr;
> >  }
> >  
> >  /*
> > @@ -9146,7 +9148,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> >  			 * allowed. If there is a real need of migration,
> >  			 * periodic load balance will take care of it.
> >  			 */
> > -			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, local_sgs.group_weight))
> > +			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
> 
> Could you please clarify why are we adding 1 to local_sgs.sum_nr_running while allowing imbalance?

To account for the new task similar to what task_numa_find_cpu before
calling adjust_numa_imbalance.

> allow_numa_imbalance allows the imbalance based on the following inequality:
> 
> 	running < imb_numa_nr
> 
> Consider on a Zen3 CPU with 8 LLCs in the sched group of the NUMA domain.
> Assume the group is running 7 task and we are finding the idlest group for the 8th task:
> 
>  	sd->imb_numa_nr = 8
> 	local_sgs.sum_nr_running = 7
> 
> In this case, local_sgs.sum_nr_running + 1 is equal to sd->imb_numa_nr and if we allow NUMA imbalance
> and place the task in the same group, each task can be given one LLC.
> However, allow_numa_imbalance returns 0 for the above case and can lead to task being placed on a different
> NUMA group.
> 
> In case of Gautham's suggested fix (https://lore.kernel.org/lkml/YcHs37STv71n4erJ@BLR-5CG11610CF.amd.com/),
> the v4 patch in question (https://lore.kernel.org/lkml/20211210093307.31701-3-mgorman@techsingularity.net/)
> used the inequality "<=" to allow NUMA imbalance where we needed to consider the additional load CPU had
> to bear. However that doesn't seem to be the case here.
> 

I failed to change < to <= in allow_numa_imbalance, I'll fix and retest.

-- 
Mel Gorman
SUSE Labs
