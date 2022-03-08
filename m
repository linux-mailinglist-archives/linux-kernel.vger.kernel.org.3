Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 795A44D1354
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Mar 2022 10:30:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242700AbiCHJbS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Mar 2022 04:31:18 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234089AbiCHJbQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Mar 2022 04:31:16 -0500
Received: from mx0a-001b2d01.pphosted.com (mx0a-001b2d01.pphosted.com [148.163.156.1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1FCD73151E
        for <linux-kernel@vger.kernel.org>; Tue,  8 Mar 2022 01:30:20 -0800 (PST)
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.1.2/8.16.1.2) with SMTP id 22896LAp027825;
        Tue, 8 Mar 2022 09:29:54 GMT
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ibm.com; h=date : from : to : cc :
 subject : message-id : reply-to : references : mime-version : content-type
 : in-reply-to; s=pp1; bh=cr7SLjArKIH61O2KOL8N0koB1YZGNpxsLLkcrPgNhZQ=;
 b=EaEckaMupnAP+F2V1x9Mb7gAcIcBlRc/+atBbX0OOF7ntLs9zEceZLt07MQhn9h+11HM
 fDHElp7WL3z+hnwJ+N7mNvbk+eWphkAIN3q56Ga8CkVFHZxoSIf0VVWxScSIvhc3kqiR
 PEX03RdeVGkFE6VQjpMDUzhlI0Jge9YKbF7EQHqH20NMFg2JQyrRXjfdDLqJVsD+8XG3
 T9ZT4sk8K42VgaP098qKuFfkyOqErcJHl8+lVrJiS+n2DTSgPsOHGZNKWaiPPv3hDKDk
 B3/4NSTA5A49+ezao6VAXwgULKpJ1VqYWC8cH/RQG90FviPxYrB9re3WU9D28jbzHdJJ IQ== 
Received: from pps.reinject (localhost [127.0.0.1])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3entt82pky-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 09:29:53 +0000
Received: from m0098410.ppops.net (m0098410.ppops.net [127.0.0.1])
        by pps.reinject (8.16.0.43/8.16.0.43) with SMTP id 2288rMwi023402;
        Tue, 8 Mar 2022 09:29:53 GMT
Received: from ppma03fra.de.ibm.com (6b.4a.5195.ip4.static.sl-reverse.com [149.81.74.107])
        by mx0a-001b2d01.pphosted.com with ESMTP id 3entt82pkd-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 09:29:53 +0000
Received: from pps.filterd (ppma03fra.de.ibm.com [127.0.0.1])
        by ppma03fra.de.ibm.com (8.16.1.2/8.16.1.2) with SMTP id 2289E1HL023473;
        Tue, 8 Mar 2022 09:29:50 GMT
Received: from b06cxnps3075.portsmouth.uk.ibm.com (d06relay10.portsmouth.uk.ibm.com [9.149.109.195])
        by ppma03fra.de.ibm.com with ESMTP id 3enpk2seb0-1
        (version=TLSv1.2 cipher=ECDHE-RSA-AES256-GCM-SHA384 bits=256 verify=NOT);
        Tue, 08 Mar 2022 09:29:50 +0000
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (b06wcsmtp001.portsmouth.uk.ibm.com [9.149.105.160])
        by b06cxnps3075.portsmouth.uk.ibm.com (8.14.9/8.14.9/NCO v10.0) with ESMTP id 2289TmTj48628086
        (version=TLSv1/SSLv3 cipher=DHE-RSA-AES256-GCM-SHA384 bits=256 verify=OK);
        Tue, 8 Mar 2022 09:29:48 GMT
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 26269A4060;
        Tue,  8 Mar 2022 09:29:48 +0000 (GMT)
Received: from b06wcsmtp001.portsmouth.uk.ibm.com (unknown [127.0.0.1])
        by IMSVA (Postfix) with ESMTP id 54D4BA405F;
        Tue,  8 Mar 2022 09:29:45 +0000 (GMT)
Received: from linux.vnet.ibm.com (unknown [9.126.150.29])
        by b06wcsmtp001.portsmouth.uk.ibm.com (Postfix) with SMTP;
        Tue,  8 Mar 2022 09:29:45 +0000 (GMT)
Date:   Tue, 8 Mar 2022 14:59:44 +0530
From:   Srikar Dronamraju <srikar@linux.vnet.ibm.com>
To:     K Prateek Nayak <kprateek.nayak@amd.com>
Cc:     peterz@infradead.org, aubrey.li@linux.intel.com, efault@gmx.de,
        gautham.shenoy@amd.com, linux-kernel@vger.kernel.org,
        mgorman@techsingularity.net, mingo@kernel.org,
        song.bao.hua@hisilicon.com, valentin.schneider@arm.com,
        vincent.guittot@linaro.org
Subject: Re: [PATCH v6] sched/fair: Consider cpu affinity when allowing NUMA
 imbalance in find_idlest_group
Message-ID: <20220308092944.GJ618915@linux.vnet.ibm.com>
Reply-To: Srikar Dronamraju <srikar@linux.vnet.ibm.com>
References: <20220308063749.6929-1-kprateek.nayak@amd.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
In-Reply-To: <20220308063749.6929-1-kprateek.nayak@amd.com>
X-TM-AS-GCONF: 00
X-Proofpoint-GUID: zBPGgwZl31IXd0dRX7quoAm6SclaCQGR
X-Proofpoint-ORIG-GUID: faGpZjXel5ouT1mY53tEJFae9FfH7kq1
X-Proofpoint-Virus-Version: vendor=baseguard
 engine=ICAP:2.0.205,Aquarius:18.0.816,Hydra:6.0.425,FMLib:17.11.64.514
 definitions=2022-03-08_03,2022-03-04_01,2022-02-23_01
X-Proofpoint-Spam-Details: rule=outbound_notspam policy=outbound score=0 phishscore=0 spamscore=0
 clxscore=1011 lowpriorityscore=0 suspectscore=0 priorityscore=1501
 mlxlogscore=999 bulkscore=0 adultscore=0 impostorscore=0 malwarescore=0
 mlxscore=0 classifier=spam adjust=0 reason=mlx scancount=1
 engine=8.12.0-2202240000 definitions=main-2203080047
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_EF,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

* K Prateek Nayak <kprateek.nayak@amd.com> [2022-03-08 12:07:49]:

Hi Prateek, 

> In the case of systems containing multiple LLCs per socket, like
> AMD Zen systems, users want to spread bandwidth hungry applications
> across multiple LLCs. Stream is one such representative workload where
> the best performance is obtained by limiting one stream thread per LLC.
> To ensure this, users are known to pin the tasks to a specify a subset
> of the CPUs consisting of one CPU per LLC while running such bandwidth
> hungry tasks.
> 
> Suppose we kickstart a multi-threaded task like stream with 8 threads
> using taskset or numactl to run on a subset of CPUs on a 2 socket Zen3
> server where each socket contains 128 CPUs
> (0-63,128-191 in one socket, 64-127,192-255 in another socket)
> 
> Eg: numactl -C 0,16,32,48,64,80,96,112 ./stream8
> 
> Here each CPU in the list is from a different LLC and 4 of those LLCs
> are on one socket, while the other 4 are on another socket.
> 
> Ideally we would prefer that each stream thread runs on a different
> CPU from the allowed list of CPUs. However, the current heuristics in
> find_idlest_group() do not allow this during the initial placement.
> 
> Suppose the first socket (0-63,128-191) is our local group from which
> we are kickstarting the stream tasks. The first four stream threads
> will be placed in this socket. When it comes to placing the 5th
> thread, all the allowed CPUs are from the local group (0,16,32,48)
> would have been taken.
> 
> However, the current scheduler code simply checks if the number of
> tasks in the local group is fewer than the allowed numa-imbalance
> threshold. This threshold was previously 25% of the NUMA domain span
> (in this case threshold = 32) but after the v6 of Mel's patchset
> "Adjust NUMA imbalance for multiple LLCs", got merged in sched-tip,
> Commit: e496132ebedd ("sched/fair: Adjust the allowed NUMA imbalance
> when SD_NUMA spans multiple LLCs") it is now equal to number of LLCs
> in the NUMA domain, for processors with multiple LLCs.
> (in this case threshold = 8).
> 
> For this example, the number of tasks will always be within threshold
> and thus all the 8 stream threads will be woken up on the first socket
> thereby resulting in sub-optimal performance.
> 
> The following sched_wakeup_new tracepoint output shows the initial
> placement of tasks in the current tip/sched/core on the Zen3 machine:
> 
> stream-5045    [032] d..2.   167.914699: sched_wakeup_new: comm=stream pid=5047 prio=120 target_cpu=048
> stream-5045    [032] d..2.   167.914746: sched_wakeup_new: comm=stream pid=5048 prio=120 target_cpu=000
> stream-5045    [032] d..2.   167.914846: sched_wakeup_new: comm=stream pid=5049 prio=120 target_cpu=016
> stream-5045    [032] d..2.   167.914891: sched_wakeup_new: comm=stream pid=5050 prio=120 target_cpu=032
> stream-5045    [032] d..2.   167.914928: sched_wakeup_new: comm=stream pid=5051 prio=120 target_cpu=032
> stream-5045    [032] d..2.   167.914976: sched_wakeup_new: comm=stream pid=5052 prio=120 target_cpu=032
> stream-5045    [032] d..2.   167.915011: sched_wakeup_new: comm=stream pid=5053 prio=120 target_cpu=032
> 
> Once the first four threads are distributed among the allowed CPUs of
> socket one, the rest of the treads start piling on these same CPUs
> when clearly there are CPUs on the second socket that can be used.
> 
> Following the initial pile up on a small number of CPUs, though the
> load-balancer eventually kicks in, it takes a while to get to {4}{4}
> and even {4}{4} isn't stable as we observe a bunch of ping ponging
> between {4}{4} to {5}{3} and back before a stable state is reached
> much later (1 Stream thread per allowed CPU) and no more migration is
> required.
> 
> We can detect this piling and avoid it by checking if the number of
> allowed CPUs in the local group are fewer than the number of tasks
> running in the local group and use this information to spread the
> 5th task out into the next socket (after all, the goal in this
> slowpath is to find the idlest group and the idlest CPU during the
> initial placement!).
> 

If I recollect correctly, each stream thread, has its independent data set.
However if the threads were all to contend for the same resource (memory) or
a waker/wakee relationships, would we not end up spreading the waker/wakee
apart?


> The following sched_wakeup_new tracepoint output shows the initial
> placement of tasks after adding this fix on the Zen3 machine:
> 
> stream-4733    [032] d..2.   116.017980: sched_wakeup_new: comm=stream pid=4735 prio=120 target_cpu=048
> stream-4733    [032] d..2.   116.018032: sched_wakeup_new: comm=stream pid=4736 prio=120 target_cpu=000
> stream-4733    [032] d..2.   116.018127: sched_wakeup_new: comm=stream pid=4737 prio=120 target_cpu=064
> stream-4733    [032] d..2.   116.018185: sched_wakeup_new: comm=stream pid=4738 prio=120 target_cpu=112
> stream-4733    [032] d..2.   116.018235: sched_wakeup_new: comm=stream pid=4739 prio=120 target_cpu=096
> stream-4733    [032] d..2.   116.018289: sched_wakeup_new: comm=stream pid=4740 prio=120 target_cpu=016
> stream-4733    [032] d..2.   116.018334: sched_wakeup_new: comm=stream pid=4741 prio=120 target_cpu=080
> 
> We see that threads are using all of the allowed CPUs and there is
> no pileup.
> 
> No output is generated for tracepoint sched_migrate_task with this
> patch due to a perfect initial placement which removes the need
> for balancing later on - both across NUMA boundaries and within
> NUMA boundaries for stream.
> 
> Following are the results from running 8 Stream threads with and
> without pinning on a dual socket Zen3 Machine (2 x 64C/128T):
> 
> Pinning is done using: numactl -C 0,16,32,48,64,80,96,112 ./stream8
> 
> 	           5.17.0-rc1               5.17.0-rc1                5.17.0-rc1
>                tip sched/core           tip sched/core            tip sched/core
>                  (no pinning)                 +pinning              + this-patch
> 								       + pinning
> 
>  Copy:    97699.28 (0.00 pct)     95933.60  (-1.80 pct)    156578.91 (60.26 pct)
> Scale:   107754.15 (0.00 pct)     91869.88 (-14.74 pct)    149783.25 (39.00 pct)
>   Add:   126383.29 (0.00 pct)    105730.86 (-16.34 pct)    186493.09 (47.56 pct)
> Triad:   124896.78 (0.00 pct)    106394.38 (-14.81 pct)    184733.48 (47.90 pct)
> 

Do we have numbers for the with-your patch - non-pinned case?
I would assume they would be the same as 1st column since your change
affects only pinned case. But I am wondering if this problem happens in the
unpinned case or not?

Also Stream on powerpc seems to have some variation in results, did we take
a mean of runs, or is it just results of just one run?

> Pinning currently hurts the performance compared to unbound case on
> tip/sched/core. With the addition of this patch, we are able to
> outperform tip/sched/core by a good margin with pinning.
> 
> Following are the results from running 16 Stream threads with and
> without pinning on a dual socket Skylake Machine (2 x 24C/48T):
> 
> Pinning is done using: numactl -C 0,1,2,3,4,5,6,7,8,9,10,11,12,13,14,15 ./stream16
> 
> 	           5.17.0-rc1               5.17.0-rc1                5.17.0-rc1
>                tip sched/core           tip sched/core            tip sched/core
>                  (no pinning)                 +pinning              + this-patch
> 								       + pinning
> 
>  Copy:   126620.67 (0.00 pct)     141062.10 (11.40 pct)    147615.44 (16.58 pct)
> Scale:   91313.51 (0.00 pct)      112879.61 (23.61 pct)    122591.28 (34.25 pct)
>   Add:   102035.43 (0.00 pct)     125889.98 (23.37 pct)    138179.01 (35.42 pct)
> Triad:   102281.91 (0.00 pct)     123743.48 (20.98 pct)    138940.41 (35.84 pct)
> 
> In case of Skylake machine, with single LLC per socket, we see good
> improvement brought about by pinning which is further benefited by
> this patch.
> 
> Signed-off-by: K Prateek Nayak <kprateek.nayak@amd.com>
> Acked-by: Mel Gorman <mgorman@techsingularity.net>
> ---
> Changelog v5-->v6:
>  -  Move the cpumask variable declaration to the block it is
>     used in.
>  -  Collect tags from v5.
> Changelog v4-->v5:
>  -  Only perform cpumask operations if nr_cpus_allowed is not
>     equal to num_online_cpus based on Mel's suggestion.
> ---
>  kernel/sched/fair.c | 16 +++++++++++++---
>  1 file changed, 13 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 16874e112fe6..6cc90d76250f 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -9183,6 +9183,7 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
> 
>  	case group_has_spare:
>  		if (sd->flags & SD_NUMA) {
> +			int imb;
>  #ifdef CONFIG_NUMA_BALANCING
>  			int idlest_cpu;
>  			/*
> @@ -9200,10 +9201,19 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
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

Again, repeating, is the problem only happening in the pinned case?

> +				struct cpumask *cpus = this_cpu_cpumask_var_ptr(select_idle_mask);
> +
> +				cpumask_and(cpus, sched_group_span(local), p->cpus_ptr);
> +				imb = min(cpumask_weight(cpus), sd->imb_numa_nr);
> +			}
> +			if (allow_numa_imbalance(local_sgs.sum_nr_running + 1, imb))
>  				return NULL;
>  		}
> 
> -- 
> 2.25.1
> 

-- 
Thanks and Regards
Srikar Dronamraju
