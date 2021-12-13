Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 219674722B0
	for <lists+linux-kernel@lfdr.de>; Mon, 13 Dec 2021 09:28:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231717AbhLMI2a (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Dec 2021 03:28:30 -0500
Received: from mail-dm6nam10on2052.outbound.protection.outlook.com ([40.107.93.52]:48237
        "EHLO NAM10-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S231901AbhLMI22 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Dec 2021 03:28:28 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Cxz4GJH+ai+/HuyEMDhaEkbFltZDUGy+KPft+KBeFymJ/QoZlydoiBld82eb0UBWmYvjo922T8vVGFFmN2r8EQ1rGDXQfA802z6NVOmnOVF5owQRjaOFE/Cq9pgkTuJ3r1tWh0nTDrqAjFXEU3Bn4tM/rqGHdee0i0aAgAEjTmnScCbPUTirKspPEif6tp0CMwYHYJUuPnMFa11PEC/o3pky88ayz3nq0gui6gwby+VvNqm2tEW6axMPDKKCwuhtOHi6ocJZsNFo+c5ajDYPl5BGbAwnHv2Ylj6zqBE9+L0Qz6DDLdtO9M+4b6FQuQ5znmreqtDkgn+P13LBWO853A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=zTcVdY6/pY8u7qy9zLmQULK6RQ9l+tRZ6MCQuVwZ8Fw=;
 b=IajxdCwWBT1pPxtJGVeah9JLZA2K4L2AzIwMfdhD/LGPkHKNd8XJfGZT2b2gK5ffj+iFE2fJPXoixoUoUsWvnnQhahPnlkswzzmJZz8EHOrxJl7vVsyUhLs/mwp+FrasDYVJmqWv4N+N/Cr2KDD5d5VLxIuawuUcylo5idji1IrnJlCAi022/oMeZMk/EEG30LhF/BEUyT45cORozV7fyduKA4P+NX+K1J3EKGRGUQ8nIii04Llop5xH/IemqzSEGqXS3rwYk5iTZ6WGL0C6cVts6Gc+lNiSkaSJWjwl3eNfEQ/hyUBPGdgQIokVgVGD3xdGqF8IunpiCITGtASzCw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=zTcVdY6/pY8u7qy9zLmQULK6RQ9l+tRZ6MCQuVwZ8Fw=;
 b=W97RE5lBdxgIn2WqRq90VHpTL5rO+DaBxT0FJo/dTK1xtoklnAsCO4JjfAH8nL2au9vX2fBRHq7c7Yhbl5EzGjDFS9KCQiS68d2cPdGBclSrD4f9aB/B06B33aV1Q14etg22sG+xtEQ3vMgf7zNWD+ixYU0UIHMGc4Sbb92k/8c=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BYAPR12MB2727.namprd12.prod.outlook.com (2603:10b6:a03:71::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.17; Mon, 13 Dec
 2021 08:28:22 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518%6]) with mapi id 15.20.4778.018; Mon, 13 Dec 2021
 08:28:22 +0000
Date:   Mon, 13 Dec 2021 13:58:03 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Mel Gorman <mgorman@techsingularity.net>
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
Message-ID: <YbcEE/mgIAhWuS+A@BLR-5CG11610CF.amd.com>
References: <20211210093307.31701-1-mgorman@techsingularity.net>
 <20211210093307.31701-3-mgorman@techsingularity.net>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210093307.31701-3-mgorman@techsingularity.net>
X-ClientProxiedBy: PN1PR0101CA0061.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:c00:d::23) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: eaec5553-9d92-4219-6987-08d9be1285ff
X-MS-TrafficTypeDiagnostic: BYAPR12MB2727:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB2727CB4B687B7B72E1DBAFD996749@BYAPR12MB2727.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: LtSLpmRks9Qod3MhQbPyG6Wg3hjduEdbA096uj8as3bYvw47WYbA3CS3DX6HLWvoFR1kBwNDJdpXiYuyFQ1MvKcm/w2cnwM0iivKdqaGZkXeTQ8fZHq0ecehQCglQkCO8HvjUuWoJGX2jtwqvN3Ok7voxpHnSpHcKp4EuBTwKyhSFVILA+rTyYbVIc1TbG7NZM65DReuQ4G4FRQptzajyZ+bomEJzCfl034Gx6+ltHr1CR5aF6gAltR8KTFvy3wCY3cfEwJ8JCSu3bZQB4MPmuxKdayPkrZqrIafZe20zOCyNCWJ3+mxlafY/Oh34mZeWRi+YMjy05Lf8/jOURQ7lID9Go7gGm0wbm8mPvLX7LNVwnD3ZE/bh03CWp4yJ80Xln30Idl9pgeRgLJrJjKMBQV7jVOlDBV9pvtceNkRqcwvgT6/i0k4Myh1Mm8jXyngztRAzGEqAdZ/qvNyV+dNHKusIgKielkOGs2NN3MZuGF5A6WEysokzIqkBpfo7bgGvsFVtzlZh+nn1CX1b4rs+aR/SfdB0YzlBAmBvSJmOrzrcIpbRi5fAaMmBm45lVpSqaUm+AyxWyiEWSwakpYuFFGGsnwqUrvBBdShmXSnIZGUwPQ1Ay292NbLQ4ZWZ/ks09U1cjucvUMj1zPNNuSkkw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(66556008)(6666004)(54906003)(7416002)(6506007)(66946007)(5660300002)(26005)(316002)(8936002)(4326008)(83380400001)(6916009)(66476007)(30864003)(186003)(8676002)(38100700002)(86362001)(2906002)(6486002)(6512007)(508600001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?VVS7F9L4v753/wtPCTtz4rEx5YRgtmWXYld7SCddg4uzW7m5DyPXwToO/kBH?=
 =?us-ascii?Q?Bim6RdwdQBXTkD7Xm3OIsK0d8sqHqHt39+CFkZIgKB14bInCdZFMF6fG6mn8?=
 =?us-ascii?Q?DY16C0XVHLVQaBeTugEE4d/X8U1w354zeVDIr7PnSf+7Qpsip0kF9+dt7P3U?=
 =?us-ascii?Q?z7UlRX00g8vuRTmLQMUQ9BoNjOrajQs2syBntgyr88QzqFsAa4vVp+wTdNTG?=
 =?us-ascii?Q?ZihxXEa4fi9TzkDCXk+QBbP14DarsBmGYkTg3QGnMUcQS7x20QmAtPm6JQhk?=
 =?us-ascii?Q?vlTtC60D1CvAE9rFTBhVk5IGfsunjNk12nhfdApi6ziu9x1QinR8zqcF8v2f?=
 =?us-ascii?Q?iSGwu0QHnKx2x7ogoBogANHuO5PPc6HN/hX4z+73ePBawO7dXtZ+0gcMMvcY?=
 =?us-ascii?Q?2sInBdQa1nWG9+B1A5uM9TK3axw4ITxzj65MltgHOunKBag9sXxwN7ReTcfr?=
 =?us-ascii?Q?yVRv/Dc5jIJr/DG2TtufMB28i6h+KT80LsoY0gtl0UMGCxY7UOhFO/HbOU1P?=
 =?us-ascii?Q?pOmoxgjcqRtCRkvKwbVOQ1iD+uxENJ9QGPm8/mYrQmSYXvjrzCcazmis/XhB?=
 =?us-ascii?Q?98RUmULBZN1vFzI0zcHWvQHXQWV8zk3JaNtTI7Va4DWmAjWF9UM87dXmSGLv?=
 =?us-ascii?Q?VWnAnoURoR9XBPJ8u4UhhTvm8d/T8y613Ha6g6E6w0cSMzeAZpumyTA0prxP?=
 =?us-ascii?Q?bDkdX9+iYH0kT2RuX+dedS+Ql7HEbW2B3nCHXq5ul7Um5copnpAEKF6WuvH3?=
 =?us-ascii?Q?nliPmGLlKGC39zjGu5IGvVDaGnixZxVl9LapZ8jaL2sYQ8W/zZYab7rqNeXE?=
 =?us-ascii?Q?74RejObcoPJx52Oo/AoRC/fVoq+fhZ383FgZkRdkcWSazy7k+5rnXGUkjYpc?=
 =?us-ascii?Q?u0Qv4sKHfGpr2T//4uBhT8WvvYkCGottuYoDg2bHVhN28YhZZzgeqQEfOzSi?=
 =?us-ascii?Q?cNjcVt/JdzTNLFH0XY0UxpHR2EDXvF1+9a/H2PeVZUzGUtdRam6BFLD6RcqQ?=
 =?us-ascii?Q?dKxDpoEPSWcqMKAkA1CnbuDHr4oVlUA/33o+EY/dms97hxIzV5//u1fs0oS/?=
 =?us-ascii?Q?1EXQKGokFLysVZsj0+6wuvMErL+KDD+jh8zHYeEz1y06l4F56ecnjvwJ/En5?=
 =?us-ascii?Q?cyL6sW3BLWJrYEog4IzYv9ZMt0VTnSpFURZ2HQnN4V4rysutCuYXz888uZla?=
 =?us-ascii?Q?qTmf3y9bWc8RZMJiCRSpT1t2bdTOhRt0qWgQMGmb/qngkXwd6D8EUNChZ3cs?=
 =?us-ascii?Q?aGtY2H3XGa3+PzadIrPHiN6sqDQyAovVZETkkW/NxMQZxq9T6+sjsoCgKyy4?=
 =?us-ascii?Q?xZguPjvq3aSn03DKxPPtG+t135K9kbkJmipYtzFOA4qRZrgatu4RNR7G/82a?=
 =?us-ascii?Q?Av+al/PcAUJAwZ2J9quYcZD4CNncMmhbDXvQkN0XACNMXhnsA0AMlcA2p78z?=
 =?us-ascii?Q?g8GrbG6BwVUJ4Qm/Weaf73krhG5hnbH5REaF1SGDL3fyPE1NVtaubEV9WXtx?=
 =?us-ascii?Q?kBUjPW8NXXP9fC2Yvjz7440Q9fZ0V/pBCbd1VgPPQ4kavdMZTKhE7plM2v6b?=
 =?us-ascii?Q?kQsz9kpZfT4zr6uLuI5hwcqsT8lA5ix52Xn62fjlgXObAgTEYizTNbyNQiTu?=
 =?us-ascii?Q?JOJV9Ev4mEecCoTM3k+lgxA=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: eaec5553-9d92-4219-6987-08d9be1285ff
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 13 Dec 2021 08:28:22.1901
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 9RLQkziElNYfKhnwORf3PyT1rLuKI58mGqltVa4oqyLrmUHVf9dmXqVzZD1KZtfk4PowDUyaHqXXcHlAFbqLmg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB2727
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Mel,

On Fri, Dec 10, 2021 at 09:33:07AM +0000, Mel Gorman wrote:
> Commit 7d2b5dd0bcc4 ("sched/numa: Allow a floating imbalance between NUMA
> nodes") allowed an imbalance between NUMA nodes such that communicating
> tasks would not be pulled apart by the load balancer. This works fine when
> there is a 1:1 relationship between LLC and node but can be suboptimal
> for multiple LLCs if independent tasks prematurely use CPUs sharing cache.
> 
> Zen* has multiple LLCs per node with local memory channels and due to
> the allowed imbalance, it's far harder to tune some workloads to run
> optimally than it is on hardware that has 1 LLC per node. This patch
> adjusts the imbalance on multi-LLC machines to allow an imbalance up to
> the point where LLCs should be balanced between nodes.
> 
> On a Zen3 machine running STREAM parallelised with OMP to have on instance
> per LLC the results and without binding, the results are
> 
>                             5.16.0-rc1             5.16.0-rc1
>                                vanilla       sched-numaimb-v4
> MB/sec copy-16    166712.18 (   0.00%)   651540.22 ( 290.82%)
> MB/sec scale-16   140109.66 (   0.00%)   382254.74 ( 172.83%)
> MB/sec add-16     160791.18 (   0.00%)   623073.98 ( 287.51%)
> MB/sec triad-16   160043.84 (   0.00%)   633964.52 ( 296.12%)


Could you please share the size of the stream array ? These numbers
are higher than what I am observing.

> 
> STREAM can use directives to force the spread if the OpenMP is new
> enough but that doesn't help if an application uses threads and
> it's not known in advance how many threads will be created.
> 
> Coremark is a CPU and cache intensive benchmark parallelised with
> threads. When running with 1 thread per instance, the vanilla kernel
> allows threads to contend on cache. With the patch;
> 
>                                5.16.0-rc1             5.16.0-rc1
>                                   vanilla    sched-numaimb-v4r24
> Min       Score-16   367816.09 (   0.00%)   384015.36 (   4.40%)
> Hmean     Score-16   389627.78 (   0.00%)   431907.14 *  10.85%*
> Max       Score-16   416178.96 (   0.00%)   480120.03 (  15.36%)
> Stddev    Score-16    17361.82 (   0.00%)    32505.34 ( -87.22%)
> CoeffVar  Score-16        4.45 (   0.00%)        7.49 ( -68.30%)
> 
> It can also make a big difference for semi-realistic workloads
> like specjbb which can execute arbitrary numbers of threads without
> advance knowledge of how they should be placed
> 
>                                5.16.0-rc1             5.16.0-rc1
>                                   vanilla       sched-numaimb-v4
> Hmean     tput-1      73743.05 (   0.00%)    70258.27 *  -4.73%*
> Hmean     tput-8     563036.51 (   0.00%)   591187.39 (   5.00%)
> Hmean     tput-16   1016590.61 (   0.00%)  1032311.78 (   1.55%)
> Hmean     tput-24   1418558.41 (   0.00%)  1424005.80 (   0.38%)
> Hmean     tput-32   1608794.22 (   0.00%)  1907855.80 *  18.59%*
> Hmean     tput-40   1761338.13 (   0.00%)  2108162.23 *  19.69%*
> Hmean     tput-48   2290646.54 (   0.00%)  2214383.47 (  -3.33%)
> Hmean     tput-56   2463345.12 (   0.00%)  2780216.58 *  12.86%*
> Hmean     tput-64   2650213.53 (   0.00%)  2598196.66 (  -1.96%)
> Hmean     tput-72   2497253.28 (   0.00%)  2998882.47 *  20.09%*
> Hmean     tput-80   2820786.72 (   0.00%)  2951655.27 (   4.64%)
> Hmean     tput-88   2813541.68 (   0.00%)  3045450.86 *   8.24%*
> Hmean     tput-96   2604158.67 (   0.00%)  3035311.91 *  16.56%*
> Hmean     tput-104  2713810.62 (   0.00%)  2984270.04 (   9.97%)
> Hmean     tput-112  2558425.37 (   0.00%)  2894737.46 *  13.15%*
> Hmean     tput-120  2611434.93 (   0.00%)  2781661.01 (   6.52%)
> Hmean     tput-128  2706103.22 (   0.00%)  2811447.85 (   3.89%)


> 
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
> ---
>  include/linux/sched/topology.h |  1 +
>  kernel/sched/fair.c            | 36 +++++++++++++++++----------------
>  kernel/sched/topology.c        | 37 ++++++++++++++++++++++++++++++++++
>  3 files changed, 57 insertions(+), 17 deletions(-)
> 
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index c07bfa2d80f2..54f5207154d3 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -93,6 +93,7 @@ struct sched_domain {
>  	unsigned int busy_factor;	/* less balancing by factor if busy */
>  	unsigned int imbalance_pct;	/* No balance until over watermark */
>  	unsigned int cache_nice_tries;	/* Leave cache hot tasks for # tries */
> +	unsigned int imb_numa_nr;	/* Nr imbalanced tasks allowed between nodes */
>  
>  	int nohz_idle;			/* NOHZ IDLE status */
>  	int flags;			/* See SD_* */
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 0a969affca76..972ba586b113 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -1489,6 +1489,7 @@ struct task_numa_env {
>  
>  	int src_cpu, src_nid;
>  	int dst_cpu, dst_nid;
> +	int imb_numa_nr;
>  
>  	struct numa_stats src_stats, dst_stats;
>  
> @@ -1504,7 +1505,8 @@ static unsigned long cpu_load(struct rq *rq);
>  static unsigned long cpu_runnable(struct rq *rq);
>  static unsigned long cpu_util(int cpu);
>  static inline long adjust_numa_imbalance(int imbalance,
> -					int dst_running, int dst_weight);
> +					int dst_running, int dst_weight,
> +					int imb_numa_nr);
>  
>  static inline enum
>  numa_type numa_classify(unsigned int imbalance_pct,
> @@ -1885,7 +1887,8 @@ static void task_numa_find_cpu(struct task_numa_env *env,
>  		dst_running = env->dst_stats.nr_running + 1;
>  		imbalance = max(0, dst_running - src_running);
>  		imbalance = adjust_numa_imbalance(imbalance, dst_running,
> -							env->dst_stats.weight);
> +						  env->dst_stats.weight,
> +						  env->imb_numa_nr);
>  
>  		/* Use idle CPU if there is no imbalance */
>  		if (!imbalance) {
> @@ -1950,8 +1953,10 @@ static int task_numa_migrate(struct task_struct *p)
>  	 */
>  	rcu_read_lock();
>  	sd = rcu_dereference(per_cpu(sd_numa, env.src_cpu));
> -	if (sd)
> +	if (sd) {
>  		env.imbalance_pct = 100 + (sd->imbalance_pct - 100) / 2;
> +		env.imb_numa_nr = sd->imb_numa_nr;
> +	}
>  	rcu_read_unlock();
>  
>  	/*
> @@ -9186,12 +9191,13 @@ find_idlest_group(struct sched_domain *sd, struct task_struct *p, int this_cpu)
>  				return idlest;
>  #endif
>  			/*
> -			 * Otherwise, keep the task on this node to stay close
> -			 * its wakeup source and improve locality. If there is
> -			 * a real need of migration, periodic load balance will
> -			 * take care of it.
> +			 * Otherwise, keep the task on this node to stay local
> +			 * to its wakeup source if the number of running tasks
> +			 * are below the allowed imbalance. If there is a real
> +			 * need of migration, periodic load balance will take
> +			 * care of it.
>  			 */
> -			if (allow_numa_imbalance(local_sgs.sum_nr_running, sd->span_weight))
> +			if (local_sgs.sum_nr_running <= sd->imb_numa_nr)
>  				return NULL;
>  		}
>  
> @@ -9280,19 +9286,14 @@ static inline void update_sd_lb_stats(struct lb_env *env, struct sd_lb_stats *sd
>  	}
>  }
>  
> -#define NUMA_IMBALANCE_MIN 2
> -
>  static inline long adjust_numa_imbalance(int imbalance,
> -				int dst_running, int dst_weight)
> +				int dst_running, int dst_weight,
> +				int imb_numa_nr)
>  {
>  	if (!allow_numa_imbalance(dst_running, dst_weight))
>  		return imbalance;
>

if (4 * dst_running >= dst_weight) we return imbalance here. The
dst_weight here corresponds to the span of the domain, while
dst_running is the nr_running in busiest.

On Zen3, at the top most NUMA domain, the dst_weight = 256 across in
all the configurations of Nodes Per Socket (NPS) = 1/2/4. There are
two groups, where each group is a socket. So, unless there are at
least 64 tasks running in one of the sockets, we would not return
imbalance here and go to the next step.


> -	/*
> -	 * Allow a small imbalance based on a simple pair of communicating
> -	 * tasks that remain local when the destination is lightly loaded.
> -	 */
> -	if (imbalance <= NUMA_IMBALANCE_MIN)
> +	if (imbalance <= imb_numa_nr)

imb_numa_nr in NPS=1 mode, imb_numa_nr would be 4. Since NUMA domains
don't have PREFER_SIBLING, we would be balancing the number of idle
CPUs. We will end up doing the imbalance, as long as the difference
between the idle CPUs is at least 8.

In NPS=2, imb_numa_nr = 8 for this topmost NUMA domain. So here, we
will not rebalance unless the difference between the idle CPUs is 16.

In NPS=4, imb_numa_nr = 16 for this topmost NUMA domain. So, the
threshold is now bumped up to 32.

>  		return 0;



>  
>  	return imbalance;
> @@ -9397,7 +9398,8 @@ static inline void calculate_imbalance(struct lb_env *env, struct sd_lb_stats *s
>  		/* Consider allowing a small imbalance between NUMA groups */
>  		if (env->sd->flags & SD_NUMA) {
>  			env->imbalance = adjust_numa_imbalance(env->imbalance,
> -				busiest->sum_nr_running, env->sd->span_weight);
> +				busiest->sum_nr_running, env->sd->span_weight,
> +				env->sd->imb_numa_nr);
>  		}
>  
>  		return;
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d201a7052a29..bacec575ade2 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -2242,6 +2242,43 @@ build_sched_domains(const struct cpumask *cpu_map, struct sched_domain_attr *att
>  		}
>  	}
>  
> +	/*
> +	 * Calculate an allowed NUMA imbalance such that LLCs do not get
> +	 * imbalanced.
> +	 */
> +	for_each_cpu(i, cpu_map) {
> +		unsigned int imb = 0;
> +		unsigned int imb_span = 1;
> +
> +		for (sd = *per_cpu_ptr(d.sd, i); sd; sd = sd->parent) {
> +			struct sched_domain *child = sd->child;
> +
> +			if (!(sd->flags & SD_SHARE_PKG_RESOURCES) && child &&
> +			    (child->flags & SD_SHARE_PKG_RESOURCES)) {
> +				struct sched_domain *top = sd;


We don't seem to be using top anywhere where sd may not be used since
we already have variables imb and imb_span to record the
top->imb_numa_nr and top->span_weight.


> +				unsigned int llc_sq;
> +
> +				/*
> +				 * nr_llcs = (top->span_weight / llc_weight);
> +				 * imb = (child_weight / nr_llcs) >> 2

child here is the llc. So can we use imb = (llc_weight / nr_llcs) >> 2.

> +				 *
> +				 * is equivalent to
> +				 *
> +				 * imb = (llc_weight^2 / top->span_weight) >> 2
> +				 *
> +				 */
> +				llc_sq = child->span_weight * child->span_weight;
> +
> +				imb = max(2U, ((llc_sq / top->span_weight) >> 2));
> +				imb_span = sd->span_weight;

On Zen3, child_weight (or llc_weight) = 16. llc_sq = 256.
   with NPS=1
      top = DIE.
      top->span_weight = 128. imb = max(2, (256/128) >> 2) = 2. imb_span = 128.

   with NPS=2
      top = NODE.
      top->span_weight = 64. imb = max(2, (256/64) >> 2) = 2. imb_span = 64.

   with NPS=4      
      top = NODE.
      top->span_weight = 32. imb = max(2, (256/32) >> 2) = 2. imb_span = 32.

On Zen2, child_weight (or llc_weight) = 8. llc_sq = 64.
   with NPS=1
      top = DIE.
      top->span_weight = 128. imb = max(2, (64/128) >> 2) = 2. imb_span = 128.

   with NPS=2
      top = NODE.
      top->span_weight = 64. imb = max(2, (64/64) >> 2) = 2. imb_span = 64.

   with NPS=4      
      top = NODE.
      top->span_weight = 32. imb = max(2, (64/32) >> 2) = 2. imb_span = 32.


> +
> +				sd->imb_numa_nr = imb;
> +			} else {
> +				sd->imb_numa_nr = imb * (sd->span_weight / imb_span);
> +			}

On Zen3,
   with NPS=1
        sd=NUMA, sd->span_weight = 256. sd->imb_numa_nr = 2 * (256/128) = 4.

   with NPS=2
        sd=NUMA, sd->span_weight = 128. sd->imb_numa_nr = 2 * (128/64) = 4
	sd=NUMA, sd->span_weight = 256. sd->imb_numa_nr = 2 * (256/64) = 8

   with NPS=4
        sd=NUMA, sd->span_weight = 128. sd->imb_numa_nr = 2 * (128/32) = 8
	sd=NUMA, sd->span_weight = 256. sd->imb_numa_nr = 2 * (256/32) = 16


For Zen2, since the imb_span and imb values are the same as the
corresponding NPS=x values on Zen3, the imb_numa_nr values are the
same as well since the corresponding sd->span_weight is the same.


If we look at the highest NUMA domain, there are two groups in all the
NPS configurations. There are the same number of LLCs in each of these
groups across the different NPS configurations (nr_llcs=8 on Zen3, 16
on Zen2) . However, the imb_numa_nr at this domain varies with the NPS
value, since we compute the imb_numa_nr value relative to the number
of "top" domains that can be fit within this NUMA domain. This is
because the size of the "top" domain varies with the NPS value. This
shows up in the benchmark results.



The numbers with stream, tbench and YCSB +
Mongodb are as follows:


~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Stream with 16 threads.
built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=10
Zen3, 64C128T per socket, 2 sockets,
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS=1
Test:     tip/sched/core                 mel-v3                    mel-v4
 Copy:    113716.62 (0.00 pct)     218961.59 (92.55 pct)     217130.07 (90.93 pct)
Scale:    110996.89 (0.00 pct)     216674.73 (95.20 pct)     220765.94 (98.89 pct)
  Add:    124504.19 (0.00 pct)     253461.32 (103.57 pct     260273.88 (109.04 pct)
Triad:    122890.43 (0.00 pct)     247552.00 (101.44 pct     252615.62 (105.56 pct)


NPS=2
Test:     tip/sched/core                 mel-v3                     mel-v4
 Copy:    58217.00 (0.00 pct)      204630.34 (251.49 pct)     191312.73 (228.62 pct)
Scale:    55004.76 (0.00 pct)      212142.88 (285.68 pct)     175499.15 (219.06 pct)
  Add:    63269.04 (0.00 pct)      254752.56 (302.64 pct)     203571.50 (221.75 pct)
Triad:    62178.25 (0.00 pct)      247290.80 (297.71 pct)     198988.70 (220.02 pct)

NPS=4
Test:     tip/sched/core                 mel-v3                     mel-v4
 Copy:    37986.66 (0.00 pct)      254183.87 (569.13 pct)     48748.87 (28.33 pct)
Scale:    35471.22 (0.00 pct)      237804.76 (570.41 pct)     48317.82 (36.21 pct)
  Add:    39303.25 (0.00 pct)      292285.20 (643.66 pct)     54259.59 (38.05 pct)
Triad:    39319.85 (0.00 pct)      285284.30 (625.54 pct)     54503.98 (38.61 pct)


We can see that with the v4 patch, for NPS=2 and NPS=4, the gains
start diminishing since the thresholds are higher than NPS=1.

~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
Stream with 16 threads.
built with -DSTREAM_ARRAY_SIZE=128000000, -DNTIMES=100
Zen3, 64C128T per socket, 2 sockets,
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS=1
Test:     tip/sched/core                 mel-v3                    mel-v4
 Copy:    137362.66 (0.00 pct)     236661.65 (72.28 pct)     241148.65 (75.55 pct)
Scale:    126742.24 (0.00 pct)     214568.17 (69.29 pct)     226416.41 (78.64 pct)
  Add:    148236.33 (0.00 pct)     257114.42 (73.44 pct)     272030.50 (83.51 pct)
Triad:    146913.25 (0.00 pct)     241880.88 (64.64 pct)     259873.61 (76.88 pct)

NPS=2
Test:     tip/sched/core                 mel-v3                    mel-v4
 Copy:    107143.94 (0.00 pct)     244922.66 (128.59 pct)    198299.91 (85.07 pct)
Scale:    102004.90 (0.00 pct)     218738.55 (114.43 pct)    177890.23 (74.39 pct)
  Add:    117760.23 (0.00 pct)     270516.24 (129.71 pct)    211458.30 (79.56 pct)
Triad:    115927.92 (0.00 pct)     255985.20 (120.81 pct)    197812.60 (70.63 pct)


NPS=4
Test:     tip/sched/core                 mel-v3                    mel-v4
 Copy:    111653.17 (0.00 pct)     253912.17 (127.41 pct)     48898.34 (-56.20 pct)
Scale:    105289.35 (0.00 pct)     223710.85 (112.47 pct)     48426.03 (-54.00 pct)
  Add:    120927.64 (0.00 pct)     277701.20 (129.64 pct)     54425.48 (-54.99 pct)
Triad:    117659.97 (0.00 pct)     259473.84 (120.52 pct)     54622.82 (-53.57 pct)

with -DNTIMES=100, each of the Copy,Scale,Add,Triad kernels runs for a
longer duration. So the test takes longer time (6-10 seconds) giving
the load-balancer sufficient time to place the tasks and balance
them. In this configuration we see that the v4 shows some degradation
on NPS=4. This is due to the imb_numa_nr being higher compared to v3.

While Stream benefits from spreading, it is fair to understand the
gains that we make with benchmarks that would prefer the tasks
co-located instead of spread out. Chose tbench and YCSB+Mongodb as
representatives of these. The numbers are as follows:


~~~~~~~~~~~~~~~~~~~~~~~~
tbench
Zen3, 64C128T per socket, 2 sockets,
~~~~~~~~~~~~~~~~~~~~~~~~

NPS=1
Clients:     tip/sched/core                 mel-v3                  mel-v4
    1        633.25 (0.00 pct)        619.18 (-2.22 pct)      632.96 (-0.04 pct)
    2        1152.54 (0.00 pct)       1189.91 (3.24 pct)      1184.84 (2.80 pct)
    4        1946.53 (0.00 pct)       2177.45 (11.86 pct)     1979.62 (1.69 pct)
    8        3554.65 (0.00 pct)       3565.16 (0.29 pct)      3678.13 (3.47 pct)
   16        6222.00 (0.00 pct)       6484.89 (4.22 pct)      6256.02 (0.54 pct)
   32        11707.57 (0.00 pct)      12185.93 (4.08 pct)     12006.63 (2.55 pct)
   64        18433.50 (0.00 pct)      19537.03 (5.98 pct)     19088.57 (3.55 pct)
  128        27400.07 (0.00 pct)      31771.53 (15.95 pct)    27265.00 (-0.49 pct)
  256        33195.27 (0.00 pct)      24478.67 (-26.25 pct)   34065.60 (2.62 pct)
  512        41633.10 (0.00 pct)      54833.20 (31.70 pct)    46724.00 (12.22 pct)
 1024        53877.23 (0.00 pct)      56363.37 (4.61 pct)     44813.10 (-16.82 pct)


NPS=2
Clients:     tip/sched/core                 mel-v3                  mel-v4
    1        629.76 (0.00 pct)        620.94 (-1.40 pct)      629.22 (-0.08 pct)
    2        1177.01 (0.00 pct)       1203.27 (2.23 pct)      1169.12 (-0.66 pct)
    4        1990.97 (0.00 pct)       2228.18 (11.91 pct)     1888.39 (-5.15 pct)
    8        3535.45 (0.00 pct)       3620.76 (2.41 pct)      3662.72 (3.59 pct)
   16        6309.02 (0.00 pct)       6548.66 (3.79 pct)      6508.67 (3.16 pct)
   32        12038.73 (0.00 pct)      12145.97 (0.89 pct)     11411.50 (-5.21 pct)
   64        18599.67 (0.00 pct)      19448.87 (4.56 pct)     17146.07 (-7.81 pct)
  128        27861.57 (0.00 pct)      30630.53 (9.93 pct)     28217.30 (1.27 pct)
  256        28215.80 (0.00 pct)      26864.67 (-4.78 pct)    29330.47 (3.95 pct)
  512        44239.67 (0.00 pct)      52822.47 (19.40 pct)    42652.63 (-3.58 pct)
 1024        54403.53 (0.00 pct)      53905.57 (-0.91 pct)    48490.30 (-10.86 pct)



NPS=4
Clients:     tip/sched/core                 mel-v3                  mel-v4
    1        622.68 (0.00 pct)        617.87 (-0.77 pct)      667.38 (7.17 pct)
    2        1160.74 (0.00 pct)       1182.40 (1.86 pct)      1294.12 (11.49 pct)
    4        1961.29 (0.00 pct)       2172.41 (10.76 pct)     2477.76 (26.33 pct)
    8        3664.25 (0.00 pct)       3450.80 (-5.82 pct)     4067.42 (11.00 pct)
   16        6495.53 (0.00 pct)       5873.41 (-9.57 pct)     6931.66 (6.71 pct)
   32        11833.27 (0.00 pct)      12010.43 (1.49 pct)     12710.60 (7.41 pct)
   64        17723.50 (0.00 pct)      18416.23 (3.90 pct)     18793.47 (6.03 pct)
  128        27724.83 (0.00 pct)      27894.50 (0.61 pct)     27948.60 (0.80 pct)
  256        31351.70 (0.00 pct)      23944.43 (-23.62 pct)   35430.17 (13.00 pct)
  512        43383.43 (0.00 pct)      49830.63 (14.86 pct)    43877.83 (1.13 pct)
 1024        46974.27 (0.00 pct)      53583.83 (14.07 pct)    50563.23 (7.64 pct)


With NPS=4, with v4, we see no regressions with tbench compared to
tip/sched/core and there is a considerable improvement in most
cases. So, the higher imb_numa_nr helps pack the tasks which
beneficial to tbench.



~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~
YCSB + Mongodb.

4 client instances, 256 threads per client instance.  These threads
have a very low utilization. The overall system utilization was in the
range of 16-20%.

YCSB workload type : A
~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~

NPS=1
               tip/sched/core   mel-v3        mel-v4
Throughput     351611.0        314981.33     329026.33
                               (-10.42 pct)  (-6.42 pct)



NPS=4
               tip/sched/core   mel-v3        mel-v4
Throughput     315808.0         316600.67     331093.67
                                (0.25 pct)    (4.84 pct)

Since at NPS=4, the imb_numa_nr=8 and 16 respectively at the lower and
higher NUMA domains, the task spreading happens more reluctantly
compared to v3 where the imb_numa_nr was 1 in both the domains.


--
Thanks and Regards
gautham.
