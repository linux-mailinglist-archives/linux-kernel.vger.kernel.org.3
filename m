Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0D2F44AD6F4
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:31:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357493AbiBHLar (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:30:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238928AbiBHKvV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 05:51:21 -0500
Received: from outbound-smtp25.blacknight.com (outbound-smtp25.blacknight.com [81.17.249.193])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D235AC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 02:51:19 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail02.blacknight.ie [81.17.254.11])
        by outbound-smtp25.blacknight.com (Postfix) with ESMTPS id 638ABCB22E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 10:51:18 +0000 (GMT)
Received: (qmail 12525 invoked from network); 8 Feb 2022 10:51:18 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 8 Feb 2022 10:51:18 -0000
Date:   Tue, 8 Feb 2022 10:51:16 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <20220208105116.GO3366@techsingularity.net>
References: <20220207155921.21321-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220207155921.21321-1-kprateek.nayak@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 07, 2022 at 09:29:21PM +0530, K Prateek Nayak wrote:
> Neither the sched/tip nor Mel's v5 patchset [1] provides an optimal
> new-task wakeup strategy when the tasks are affined to a subset of cpus
> which can result in piling of tasks on the same set of CPU in a NUMA
> group despite there being other cpus in a different NUMA group where the
> task could have run in. A good placement makes a difference especially
> in case of short lived task where the delay in load balancer kicking in
> can cause degradation in perfromance.
> 

Thanks.

V6 was posted based on previous feedback. While this patch is building
on top of it, please add Acked-by or Tested-by if the imbalance series
helps the general problem of handling imbalances when there are multiple
last level caches.

> <SNIP>
>
> Aggressive NUMA balancing is only done when needed. We select the
> minimum of number of allowed cpus in sched group and the calculated
> sd.imb_numa_nr as our imbalance threshold and the default behavior
> of mel-v5 is only modified when the former is smaller than
> the latter.
> 

In this context, it should be safe to reuse select_idle_mask like this
build tested patch

diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
index 538756bd8e7f..1e759c21371b 100644
--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9128,6 +9128,8 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 
 	case group_has_spare:
 		if (sd->flags & SD_NUMA) {
+			struct cpumask *cpus;
+			int imb;
 #ifdef CONFIG_NUMA_BALANCING
 			int idlest_cpu;
 			/*
@@ -9145,10 +9147,15 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
 			 * Otherwise, keep the task close to the wakeup source
 			 * and improve locality if the number of running tasks
 			 * would remain below threshold where an imbalance is
-			 * allowed. If there is a real need of migration,
-			 * periodic load balance will take care of it.
+			 * allowed while accounting for the possibility the
+			 * task is pinned to a subset of CPUs.  If there is a
+			 * real need of migration, periodic load balance will
+			 * take care of it.
 			 */
-			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
+			cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+			cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
+			imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
+			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
 				return NULL;
 		}
 
