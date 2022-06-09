Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 83F2F544B12
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 13:55:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244644AbiFILy6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 07:54:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53534 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234050AbiFILyz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 07:54:55 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 57ACB17AA6
        for <linux-kernel@vger.kernel.org>; Thu,  9 Jun 2022 04:54:54 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=/NKx+ImT82FSftNEnF4Bfd5B5/3SIW+/c0RAA2AsNWM=; b=G49dlE689fJtPKxckEXf8MXcXr
        mEjxV8sCnj2DxkEkJViWG3dw3CN5HkCn5e24miIU1x7bcttb6EmgA/XPN/35HDosF0f9LS1hNI3Pa
        FbsISajuPCacIXZY7ffXxtof/k/pEwBLAAICKmHgaB3kscgRFDNplAWaQJ/jLZ+jP26R5ISeNLcNM
        MmFiYZW3Y4FQvmASm/lMNSDFqD1gCXEPYuCB4tQCyw3lkxIzMoIz02+jdD3K8RvEoBbHLdYUWgouZ
        YEFMt5zGBPrvAGIAOf9lSuy3kXsfAQVx8/26w7Flv6kKtR926rT6hGZdSAlYQ5U8i8rEPixbWLvDc
        8K7WMLzA==;
Received: from dhcp-077-249-017-003.chello.nl ([77.249.17.3] helo=worktop.programming.kicks-ass.net)
        by casper.infradead.org with esmtpsa (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nzGkC-00DWVl-Lx; Thu, 09 Jun 2022 11:54:33 +0000
Received: by worktop.programming.kicks-ass.net (Postfix, from userid 1000)
        id 86B609816EE; Thu,  9 Jun 2022 13:54:30 +0200 (CEST)
Date:   Thu, 9 Jun 2022 13:54:30 +0200
From:   Peter Zijlstra <peterz@infradead.org>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     aubrey.li@linux.intel.com, efault@gmx.de, gautham.shenoy@amd.com,
        linux-kernel@vger.kernel.org, mgorman@techsingularity.net,
        mingo@kernel.org, song.bao.hua@hisilicon.com,
        srikar@linux.vnet.ibm.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v7] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <YqHfdn9O81Ir1+bI@worktop.programming.kicks-ass.net>
References: <20220407111222.22649-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220407111222.22649-1-kprateek.nayak@amd.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 07, 2022 at 04:42:22PM +0530, K Prateek Nayak wrote:
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index d4bd299d67ab..520593bf0de6 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9215,6 +9215,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  
>  	case group_has_spare:
>  		if (sd->flags & SD_NUMA) {
> +			int imb;
>  #ifdef CONFIG_NUMA_BALANCING
>  			int idlest_cpu;
>  			/*
> @@ -9232,10 +9233,19 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
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
> +			imb = sd->imb_numa_nr;
> +			if (p->nr_cpus_allowed != num_online_cpus()) {
> +				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +
> +				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> +				imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
> +			}
> +			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
>  				return NULL;
>  		}

OK, so I've gone collecting patches, and this conflicts with the NUMA
patches from Mel.

Now, I can (and have) fixed up the conflict, but it did make me look at
this in a little more detail; and the thing I noticed is that your:

  'p->nr_cpus_allowed != num_online_cpus()'

test makes no sense. That's basically 'true'. The thing is,
nr_cpus_allowed is initialized to NR_CPUS, and unless someone somewhere
did set_cpus_allowed() on it, it'll still be NR_CPUS.

Also, CPU hotplug doesn't change nr_cpus_allowed, so num_online_cpus()
is just plain wrong.

Now, something that might work is:

  'p->nr_cpus_allowed < num_online_cpus()'

And even that is no guarantee. You can construct a situation where this
is still false even though you actually have a constrained set.
Consider a machine with 8 CPUs. Then set the mask to: 0x55, which has 4
CPUs set. Then offline the last 4 so that the online mask becomes 0x0f.

Then the effective mask is 0x05, and the number we're looking for above
is 2, but the suggested test would still be false, because
nr_cpus_allowed would be 4, as would num_online_cpus().

Find below what I've made of it (on top of Mel's patches), but I'm not
sure this is what we want.  For now I'll leave it commented out.

---
Subject: sched/fair: Consider CPU affinity when allowing NUMA imbalance in find_idlest_group()
From: K Prateek Nayak <kprateek.nayak@amd.com>
Date: Thu, 7 Apr 2022 16:42:22 +0530

From: K Prateek Nayak <kprateek.nayak@amd.com>

In the case of systems containing multiple LLCs per socket, like
AMD Zen systems, users want to spread bandwidth hungry applications
across multiple LLCs. Stream is one such representative workload where
the best performance is obtained by limiting one stream thread per LLC.
To ensure this, users are known to pin the tasks to a specify a subset
of the CPUs consisting of one CPU per LLC while running such bandwidth
hungry tasks.

Suppose we kickstart a multi-threaded task like stream with 8 threads
using taskset or numactl to run on a subset of CPUs on a 2 socket Zen3
server where each socket contains 128 CPUs
(0-63,128-191 in one socket, 64-127,192-255 in another socket)

Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8

Here each CPU in the list is from a different LLC and 4 of those LLCs
are on one socket, while the other 4 are on another socket.

Ideally we would prefer that each stream thread runs on a different
CPU from the allowed list of CPUs. However, the current heuristics in
find_idlest_group() do not allow this during the initial placement.

Suppose the first socket (0-63,128-191) is our local group from which
we are kickstarting the stream tasks. The first four stream threads
will be placed in this socket. When it comes to placing the 5th
thread, all the allowed CPUs are from the local group (0,16,32,48)
would have been taken.

However, the current scheduler code simply checks if the number of
tasks in the local group is fewer than the allowed numa-imbalance
threshold. This threshold was previously 25% of the NUMA domain span
(in this case threshold = 32) but after the v6 of Mel's patchset
"Adjust NUMA imbalance for multiple LLCs", got merged in sched-tip,
Commit: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance
when SD_NUMA spans multiple LLCs") it is now equal to number of LLCs
in the NUMA domain, for processors with multiple LLCs.
(in this case threshold = 8).

For this example, the number of tasks will always be within threshold
and thus all the 8 stream threads will be woken up on the first socket
thereby resulting in sub-optimal performance.

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks in the current tip/sched/core on the Zen3 machine:

stream-5313    [016] d..2.   627.005036: sched_wakeup_new: comm=stream pid=5315 prio=120 target_cpu=032
stream-5313    [016] d..2.   627.005086: sched_wakeup_new: comm=stream pid=5316 prio=120 target_cpu=048
stream-5313    [016] d..2.   627.005141: sched_wakeup_new: comm=stream pid=5317 prio=120 target_cpu=000
stream-5313    [016] d..2.   627.005183: sched_wakeup_new: comm=stream pid=5318 prio=120 target_cpu=016
stream-5313    [016] d..2.   627.005218: sched_wakeup_new: comm=stream pid=5319 prio=120 target_cpu=016
stream-5313    [016] d..2.   627.005256: sched_wakeup_new: comm=stream pid=5320 prio=120 target_cpu=016
stream-5313    [016] d..2.   627.005295: sched_wakeup_new: comm=stream pid=5321 prio=120 target_cpu=016

Once the first four threads are distributed among the allowed CPUs of
socket one, the rest of the treads start piling on these same CPUs
when clearly there are CPUs on the second socket that can be used.

Following the initial pile up on a small number of CPUs, though the
load-balancer eventually kicks in, it takes a while to get to {4}{4}
and even {4}{4} isn't stable as we observe a bunch of ping ponging
between {4}{4} to {5}{3} and back before a stable state is reached
much later (1 Stream thread per allowed CPU) and no more migration is
required.

We can detect this piling and avoid it by checking if the number of
allowed CPUs in the local group are fewer than the number of tasks
running in the local group and use this information to spread the
5th task out into the next socket (after all, the goal in this
slowpath is to find the idlest group and the idlest CPU during the
initial placement!).

The following sched_wakeup_new tracepoint output shows the initial
placement of tasks after adding this fix on the Zen3 machine:

stream-4485    [016] d..2.   230.784046: sched_wakeup_new: comm=stream pid=4487 prio=120 target_cpu=032
stream-4485    [016] d..2.   230.784123: sched_wakeup_new: comm=stream pid=4488 prio=120 target_cpu=048
stream-4485    [016] d..2.   230.784167: sched_wakeup_new: comm=stream pid=4489 prio=120 target_cpu=000
stream-4485    [016] d..2.   230.784222: sched_wakeup_new: comm=stream pid=4490 prio=120 target_cpu=112
stream-4485    [016] d..2.   230.784271: sched_wakeup_new: comm=stream pid=4491 prio=120 target_cpu=096
stream-4485    [016] d..2.   230.784322: sched_wakeup_new: comm=stream pid=4492 prio=120 target_cpu=080
stream-4485    [016] d..2.   230.784368: sched_wakeup_new: comm=stream pid=4493 prio=120 target_cpu=064

We see that threads are using all of the allowed CPUs and there is
no pileup.

No output is generated for tracepoint sched_migrate_task with this
patch due to a perfect initial placement which removes the need
for balancing later on - both across NUMA boundaries and within
NUMA boundaries for stream.

Following are the results from running 8 Stream threads with and
without pinning on a dual socket Zen3 Machine (2 x 64C/128T):

During the testing of this patch, the tip sched/core was at
commit: 089c02ae2771 "ftrace: Use preemption model accessors for trace
header printout"

Pinning is done using: numactl -C 0,16,32,48,64,80,96,112 ./stream8

	           5.18.0-rc1               5.18.0-rc1                5.18.0-rc1
               tip sched/core           tip sched/core            tip sched/core
                 (no pinning)                + pinning              + this-patch
								       + pinning

 Copy:   109364.74 (0.00 pct)     94220.50 (-13.84 pct)    158301.28 (44.74 pct)
Scale:   109670.26 (0.00 pct)     90210.59 (-17.74 pct)    149525.64 (36.34 pct)
  Add:   129029.01 (0.00 pct)    101906.00 (-21.02 pct)    186658.17 (44.66 pct)
Triad:   127260.05 (0.00 pct)    106051.36 (-16.66 pct)    184327.30 (44.84 pct)

Pinning currently hurts the performance compared to unbound case on
tip/sched/core. With the addition of this patch, we are able to
outperform tip/sched/core by a good margin with pinning.

Following are the results from running 16 Stream threads with and
without pinning on a dual socket IceLake Machine (2 x 32C/64T):

NUMA Topology of Intel Skylake machine:
Node 1: 0,2,4,6 ... 126 (Even numbers)
Node 2: 1,3,5,7 ... 127 (Odd numbers)

Pinning is done using: numactl -C 0-15 ./stream16

	           5.18.0-rc1               5.18.0-rc1                5.18.0-rc1
               tip sched/core           tip sched/core            tip sched/core
                 (no pinning)                 +pinning              + this-patch
								       + pinning

 Copy:    85815.31 (0.00 pct)     149819.21 (74.58 pct)    156807.48 (82.72 pct)
Scale:    64795.60 (0.00 pct)      97595.07 (50.61 pct)     99871.96 (54.13 pct)
  Add:    71340.68 (0.00 pct)     111549.10 (56.36 pct)    114598.33 (60.63 pct)
Triad:    68890.97 (0.00 pct)     111635.16 (62.04 pct)    114589.24 (66.33 pct)

In case of Icelake machine, with single LLC per socket, pinning across
the two sockets reduces cache contention, thus showing great
improvement in pinned case which is further benefited by this patch.

Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
Signed-off-by: Peter Zijlstra (Intel) <peterz@infradead.org>
Reviewed-by: Vincent Guittot <vincent.guittot@linaro.org>
Reviewed-by: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
Acked-by: Mel Gorman <mgorman@techsingularity.net>
Link: https://lkml.kernel.org/r/20220407111222.22649-1-kprateek.nayak@amd.com
---
 kernel/sched/fair.c |   16 +++++++++++++---
 1 file changed, 13 insertions(+), 3 deletions(-)

--- a/kernel/sched/fair.c
+++ b/kernel/sched/fair.c
@@ -9210,6 +9210,7 @@ find_idlest_group(struct sched_domain *s
 	case group_has_spare:
 #ifdef CONFIG_NUMA
 		if (sd->flags & SD_NUMA) {
+			int imb_numa_nr = sd->imb_numa_nr;
 #ifdef CONFIG_NUMA_BALANCING
 			int idlest_cpu;
 			/*
@@ -9227,13 +9228,22 @@ find_idlest_group(struct sched_domain *s
 			 * Otherwise, keep the task close to the wakeup source
 			 * and improve locality if the number of running tasks
 			 * would remain below threshold where an imbalance is
-			 * allowed. If there is a real need of migration,
-			 * periodic load balance will take care of it.
+			 * allowed while accounting for the possibility the
+			 * task is pinned to a subset of CPUs. If there is a
+			 * real need of migration, periodic load balance will
+			 * take care of it.
 			 */
+			if (p->nr_cpus_allowed < num_online_cpus()) {
+				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
+
+				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
+				imb_numa_nr = min(cpumask_weight(cpus), sd->imb_numa_nr);
+			}
+
 			imbalance = abs(local_sgs.idle_cpus - idlest_sgs.idle_cpus);
 			if (!adjust_numa_imbalance(imbalance,
 						   local_sgs.sum_nr_running + 1,
-						   sd->imb_numa_nr)) {
+						   imb_numa_nr)) {
 				return NULL;
 			}
 		}
