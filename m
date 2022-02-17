Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B2FF24B9CB2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 11:06:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238976AbiBQKFo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 05:05:44 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230434AbiBQKFl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 05:05:41 -0500
Received: from outbound-smtp21.blacknight.com (outbound-smtp21.blacknight.com [81.17.249.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2A8D21D685C
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 02:05:27 -0800 (PST)
Received: from mail.blacknight.com (pemlinmail03.blacknight.ie [81.17.254.16])
        by outbound-smtp21.blacknight.com (Postfix) with ESMTPS id B2186CCD29
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 10:05:25 +0000 (GMT)
Received: (qmail 29878 invoked from network); 17 Feb 2022 10:05:25 -0000
Received: from unknown (HELO techsingularity.net) (mgorman@techsingularity.net@[84.203.17.223])
  by 81.17.254.9 with ESMTPSA (AES256-SHA encrypted, authenticated); 17 Feb 2022 10:05:25 -0000
Date:   Thu, 17 Feb 2022 10:05:24 +0000
From:   Mel Gorman <mgorman@techsingularity.net>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v4] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <20220217100523.GV3366@techsingularity.net>
References: <20220217055408.28151-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-15
Content-Disposition: inline
In-Reply-To: <20220217055408.28151-1-kprateek.nayak@amd.com>
User-Agent: Mutt/1.10.1 (2018-07-13)
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Thanks Prateek,

On Thu, Feb 17, 2022 at 11:24:08AM +0530, K Prateek Nayak wrote:
> In AMD Zen like systems which contains multiple LLCs per socket,
> users want to spread bandwidth hungry applications across multiple
> LLCs. Stream is one such representative workload where the best
> performance is obtained by limiting one stream thread per LLC. To
> ensure this, users are known to pin the tasks to a specify a subset of
> the CPUs consisting of one CPU per LLC while running such bandwidth
> hungry tasks.
> 
> Suppose we kickstart a multi-threaded task like stream with 8 threads
> using taskset or numactl to run on a subset of CPUs on a 2 socket Zen3
> server where each socket contains 128 CPUs
> (0-63,128-191 in one socket, 64-127,192-255 in another socket)
> 
> Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8
> 

In this case the stream threads can use any CPU of the subset, presumably
this is parallelised with OpenMP without specifying spread or bind
directives.

> stream-5045    [032] d..2.   167.914699: sched_wakeup_new: comm=stream pid=5047 prio=120 target_cpu=048
> stream-5045    [032] d..2.   167.914746: sched_wakeup_new: comm=stream pid=5048 prio=120 target_cpu=000
> stream-5045    [032] d..2.   167.914846: sched_wakeup_new: comm=stream pid=5049 prio=120 target_cpu=016
> stream-5045    [032] d..2.   167.914891: sched_wakeup_new: comm=stream pid=5050 prio=120 target_cpu=032
> stream-5045    [032] d..2.   167.914928: sched_wakeup_new: comm=stream pid=5051 prio=120 target_cpu=032
> stream-5045    [032] d..2.   167.914976: sched_wakeup_new: comm=stream pid=5052 prio=120 target_cpu=032
> stream-5045    [032] d..2.   167.915011: sched_wakeup_new: comm=stream pid=5053 prio=120 target_cpu=032
> 

Resulting in some stacking with the baseline

> stream-4733    [032] d..2.   116.017980: sched_wakeup_new: comm=stream pid=4735 prio=120 target_cpu=048
> stream-4733    [032] d..2.   116.018032: sched_wakeup_new: comm=stream pid=4736 prio=120 target_cpu=000
> stream-4733    [032] d..2.   116.018127: sched_wakeup_new: comm=stream pid=4737 prio=120 target_cpu=064
> stream-4733    [032] d..2.   116.018185: sched_wakeup_new: comm=stream pid=4738 prio=120 target_cpu=112
> stream-4733    [032] d..2.   116.018235: sched_wakeup_new: comm=stream pid=4739 prio=120 target_cpu=096
> stream-4733    [032] d..2.   116.018289: sched_wakeup_new: comm=stream pid=4740 prio=120 target_cpu=016
> stream-4733    [032] d..2.   116.018334: sched_wakeup_new: comm=stream pid=4741 prio=120 target_cpu=080
> 

And no stacking with your patch. So far so good.

> <SNIP>
>
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 5c4bfffe8c2c..6e875f1f34e2 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9130,6 +9130,8 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  
>  	case group_has_spare:
>  		if (sd->flags & SD_NUMA) {
> +			struct cpumask *cpus;
> +			int imb;
>  #ifdef CONFIG_NUMA_BALANCING
>  			int idlest_cpu;
>  			/*
> @@ -9147,10 +9149,15 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  			 * Otherwise, keep the task close to the wakeup source
>  			 * and improve locality if the number of running tasks
>  			 * would remain below threshold where an imbalance is
> -			 * allowed. If there is a real need of migration,
> -			 * periodic load balance will take care of it.
> +			 * allowed while accounting for the possibility the
> +			 * task is pinned to a subset of CPUs. If there is a
> +			 * real need of migration, periodic load balance will
> +			 * take care of it.
>  			 */
> -			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, sd->imb_numa_nr))
> +			cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +			cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> +			imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
> +			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
>  				return NULL;

One concern I have is that we incur a cpumask setup and cpumask_weight
cost on every clone whether a restricted CPU mask is used or not.  Peter,
is it acceptable to avoid the cpumask check if there is no restrictions
on allowed cpus like this?

	imb = sd->imb_numa_nr;
	if (p->nr_cpus_allowed != num_online_cpus())
		struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);

		cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
		imb = min(cpumask_weight(cpus), imb);
	}

It's not perfect as a hotplug event could occur but that would be a fairly
harmless race with a limited impact (race with hotplug during clone may
stack for a short interval before LB intervenes).

-- 
Mel Gorman
SUSE Labs
