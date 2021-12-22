Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5ABE747CFEB
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Dec 2021 11:24:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240000AbhLVKYl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Dec 2021 05:24:41 -0500
Received: from mail-bn8nam11on2048.outbound.protection.outlook.com ([40.107.236.48]:20108
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232561AbhLVKYk (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Dec 2021 05:24:40 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=V98XKvh6kU5exjvW38FmAjedHemujAPbbbIEPFFjjf7VNCEBWQHNP2BgsWJ5Aty1dbCMgL+Lzh7O4QrhTc4qcQdoibWhmUk2wkDH4xP583pBMRKYxpG/Wv1O4iqag1ckykd/20A2rTz4LMtgEVR5RlPStS2ip+2vhFhxe97kjnH2+SH5jC6mmNkf8jE5lr6FGLD01fQyP0uKje1E/N58F2bmetoA8XM74asvjO4CK7QBtS8oDH8+xdaR4tYNtYJ3xm7ox0E01wmzWgoKOcyVnHMqsU4FrGcL1Yknx7khvnIMJEJbKGFGf2wbeuEvasTtEFR/yPp7wSZh7TrR6cnCWw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=MiK0k68zwh4vJOho59M9YIPCdWqxClHxeLfzzMlwP/Q=;
 b=GIfHXIGPnqD1CsKna0veTLKZXz5cWkORESFQRZhRP8uf7WuiGD5sRrYZNbrfna+CX34xnZIUeQkLJsL01BQfnd9SFUnPYQ7CoyUuTL3AXE6QVQG3jcEVXEXK4fdZnaU5UrXCHDHaMFpCnukezX8sOr0NX0ZlRRfCmPmovL6z1SM1jRCaivZhDv0VTuI8DcFdA65jpk2Im4bkOwEac/50HVH67HfAZ1l/ev7AhXRAYvz5BDlST/txskmCJCs179acWcrR7abzoXaDiZTVIo30Eafx1bWLWGhXmmulL60zYc2nymV2k0jNOE84mnuJIlJkb/rsjzLrwaSjl8l6LO2AxA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=amd.com; dmarc=pass action=none header.from=amd.com; dkim=pass
 header.d=amd.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=amd.com; s=selector1;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=MiK0k68zwh4vJOho59M9YIPCdWqxClHxeLfzzMlwP/Q=;
 b=T0kOy+LGQ6QnQ/XmWLpDnq3HQ0wagNQccX8Yh2WuTyWWCf7+Wg9RpK2K0xAf4C+xa917Wv4ufJKnwtUynCW3Qk2Aj90E0a7IhcGSCE3cLUyB1Id+agsAido1phaDnYVWKs8atsj9o7kzRbrDD6eWU/bH0vDOs5FZjCaiVxS4LY0=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=amd.com;
Received: from BYAPR12MB3286.namprd12.prod.outlook.com (2603:10b6:a03:139::15)
 by BYAPR12MB3191.namprd12.prod.outlook.com (2603:10b6:a03:133::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4801.17; Wed, 22 Dec
 2021 10:24:37 +0000
Received: from BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518]) by BYAPR12MB3286.namprd12.prod.outlook.com
 ([fe80::4899:90ea:bb12:518%7]) with mapi id 15.20.4801.020; Wed, 22 Dec 2021
 10:24:37 +0000
Date:   Wed, 22 Dec 2021 15:54:18 +0530
From:   "Gautham R. Shenoy" <gautham.shenoy@amd.com>
To:     Yicong Yang <yangyicong@hisilicon.com>
Cc:     peterz@infradead.org, mingo@redhat.com, juri.lelli@redhat.com,
        vincent.guittot@linaro.org, tim.c.chen@linux.intel.com,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        dietmar.eggemann@arm.com, rostedt@goodmis.org, bsegall@google.com,
        bristot@redhat.com, prime.zeng@huawei.com,
        jonathan.cameron@huawei.com, ego@linux.vnet.ibm.com,
        srikar@linux.vnet.ibm.com, linuxarm@huawei.com, 21cnbao@gmail.com,
        song.bao.hua@hisilicon.com, guodong.xu@linaro.org
Subject: Re: [PATCH 1/2] sched: Add per_cpu cluster domain info and
 cpus_share_cluster API
Message-ID: <YcL80lUZi4f9zqjB@BLR-5CG11610CF.amd.com>
References: <20211215041149.73171-1-yangyicong@hisilicon.com>
 <20211215041149.73171-2-yangyicong@hisilicon.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211215041149.73171-2-yangyicong@hisilicon.com>
X-ClientProxiedBy: BM1PR0101CA0016.INDPRD01.PROD.OUTLOOK.COM
 (2603:1096:b00:18::26) To BYAPR12MB3286.namprd12.prod.outlook.com
 (2603:10b6:a03:139::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2138fbe7-7439-44f9-d841-08d9c535411c
X-MS-TrafficTypeDiagnostic: BYAPR12MB3191:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB319193FB0D1526C0AB7AA462967D9@BYAPR12MB3191.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8273;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: t/IMRemK3UDIPvxXiUAFi1I6hQTVrfkxXWP/Qy34521HGeoMeS6iib8LBtfvvVVUfLWqtXqUKrH4YafUlX2unaR07Hhu4NGRul6ENdrPu9V9mHNWQLsriS1V2mWgsnrFWeThuJjI97ajoWETjhue29OGtMxXTjGIkXtydW4J6vOALR7gM76Jxe4j0dou1PdNAcgFLE+Hq8lMFvwbWa77kgw/9BjP2TbgsJuv/7T0TkFJM+jcTvTR97LSvgMUa45qmxakSLsxIVdhZ42LLk+4ufgDYk37aMG1OTlYF1KBgWQkVC/ajIXvMNkUy+THaOSwwNXOwrfseMSH8hFzsDeAoaBb0NYbiChr5VKqprz3BYs2IW+ESCkcTDNasa0rONhhz+mM2jUi+tHOwQQ2Gmoc6cGtyLnl0KHaHajlScL6RwO96RL/PJBvX//wWu0awyaTGwstJcwZhMiDkoMskIXYV+Q2tkM8mCruX61XVEkeOtaMGWpo6ZA/fE2VH3OLsx4uMs2Y30CPrcJw1rCsOi2lR4pZodvN9eUh+sghh0V6t/aLP/p7/bOym4N3M92M8nxbep10zHgSmJLIdfFvQP36EJJJr4EB9fiIemZg1PaWlOIZT/dwlq7CuRkEn5Rh+px0NiAyiMNjpiqAU+42kn4kCQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3286.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(5660300002)(8936002)(66946007)(6486002)(6916009)(508600001)(83380400001)(7416002)(66476007)(8676002)(6512007)(66556008)(2906002)(186003)(86362001)(6506007)(6666004)(26005)(38100700002)(4326008)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?sDzwKL/9BH16DRsaf2B8BLfiwU9GYh2lYwlH3Ri9AOzQqxPGIPkTNJk/rK8V?=
 =?us-ascii?Q?bp2o1EnpKmP+QJ28pi5vLJGUuJsb+TK4RiTEgQCQbzobbznHuEcgdGSROCvV?=
 =?us-ascii?Q?XBFOw8gtveVGyDdYhPacyFJkBuTgkqBde2EFrT0ysM40z3YPbzScQWN6C2rf?=
 =?us-ascii?Q?oCzhqkOV78GZD9fgXVecQojo8XqxVLwGDM+HUyYAM1V5vBh0Qo0FNprQwlRN?=
 =?us-ascii?Q?KPdhDAu6dajb/SSz9HkS+oV/HsHJvYdEGI/aefBKJAe6yau47gEF6XHaQtPP?=
 =?us-ascii?Q?0zeM4qe7JSZmdqr5ndaWTnzcg7ay525QNM5gezXuldlk175q/OLNfNUNIHAu?=
 =?us-ascii?Q?ap4uZ+r8N8Jb76Q+VcnS86EhIw9vdKbo8g6MyV/jGidZvKllRKI/W6wLuVJ3?=
 =?us-ascii?Q?6ijvpIOAyHOEblhyptXdq5LHQALBdCe/6XOLe5uYiPHee6HAMidjMjoV/D0k?=
 =?us-ascii?Q?JPLQbkFYuxSrb6TQ0q4xMItHLBPXm7ZuF1jgsw/OSUPB8kl1OwJCmcp1qwbq?=
 =?us-ascii?Q?AaRsRz+c9tbAxQBGb/YHmPHWuLANryiurOjBp6SYirL7E9BMWRnymg/513ko?=
 =?us-ascii?Q?GhqfXw5DJDwgxCXPzBzm4vCoYY4hbCWaSriamJYsx/5iMvuIBP8j2qCuShTJ?=
 =?us-ascii?Q?Mcmr2vf3qTbqP2lRHguts3ecQwyyTvZlpwBx8NpTpSBROKHZ0h/6MmywzKzD?=
 =?us-ascii?Q?iVdZl8VLvM1o3RRA2d+qNICvXZ75DgBuRrEudtWrvtMB1FMtJUXi2FSg+ZMk?=
 =?us-ascii?Q?z+24q2ZHsJe8Q7m2zdPed+PR8XbzsoROUxWirSVqSc2uL+81Wmjb3obsS3Wk?=
 =?us-ascii?Q?sICM8S3kWKhEV3a6QwvIg3wkmo05JVaArzsiiMLowuIawBxgSmgU8/HATkwo?=
 =?us-ascii?Q?c/eIWMbAY40APBeTkoT0ykuLXvCTJdSE7LdQTQwK5wHzn1ut+YknBNm3zXRh?=
 =?us-ascii?Q?esH3gkTkWIWfHZic2ZVhwd4mcykKRzCzQDJ61gMX/S5QZrpU+qscjRFafFxI?=
 =?us-ascii?Q?4qVCPik8bobgjibkd3gOcI7+ZKBQwx6uyj/KcFIy0fa6ej5cAhkfr73cLAFH?=
 =?us-ascii?Q?fXh9I5QGrZSKd/d1qhmRJ9smWQseZDyWA5stluRQjAF4n2W/7S3wK1hv96Th?=
 =?us-ascii?Q?YJ1UJ/Tw1vDN7fmVHUJsbdlcvQBdXQW9dTw9nfyHbYGVVP+WpdqhTMxLcJRr?=
 =?us-ascii?Q?St4A3IUBeqBYE1XeLZ7TTKZ10JbSw0Ubfl/diUesxAlzfDKUBiHkZwQddgwu?=
 =?us-ascii?Q?LoEVf8h1xfr/0jJI8wXOilH/kKWJAWXf2KGKn76yGp8oHl/LTAE8mN1x7Kwj?=
 =?us-ascii?Q?cBeFgQn18fuZyfoorla8v/ISjs0cWRjUhSk/lEfmk79XfOiPUzIwMUjQYabP?=
 =?us-ascii?Q?eGULqKP4YcfE/wndg3WmveYEDRMxyyEpKUK3hBcdXbylZgG5hk2mZvG+tip4?=
 =?us-ascii?Q?PZXAjdWbl/NKQ7rspw6VAjlzXoffP6DK9b5ul5S7m+ocQTpoacaGh1uCyGxS?=
 =?us-ascii?Q?z/CPv6QZj6tYdw3rBZ/6t0dRby+yAaW7OI5Bsz6cpQYEjUriryOhx0zpD0JO?=
 =?us-ascii?Q?qchhvRjWGcElZ49ki56rFNzrJfAo3NkimfAnQ5FySsQPEqDZZMvsRhR5LTdd?=
 =?us-ascii?Q?zqQJU/wBfTZM000j/XApdcE=3D?=
X-OriginatorOrg: amd.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2138fbe7-7439-44f9-d841-08d9c535411c
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3286.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Dec 2021 10:24:36.9577
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3dd8961f-e488-4e60-8e11-a82d994e183d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: y8L0/bl844tJ6vIBwqf/9ku73EJY8oehGMBNE8L+/FOVoj+gpsk1E8pSP1bRDGwSIdHY3TR3s7wvJLRijIfh2w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3191
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hello Yicong, Barry,


On Wed, Dec 15, 2021 at 12:11:48PM +0800, Yicong Yang wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> Add per-cpu cluster domain info and cpus_share_cluster() API.
> This is the preparation for the optimization of select_idle_cpu()
> on platforms with cluster scheduler level.
> 
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> ---
>  include/linux/sched/sd_flags.h |  5 +++++
>  include/linux/sched/topology.h |  8 +++++++-
>  kernel/sched/core.c            | 12 ++++++++++++
>  kernel/sched/sched.h           |  2 ++
>  kernel/sched/topology.c        |  9 +++++++++
>  5 files changed, 35 insertions(+), 1 deletion(-)
> 
> diff --git a/include/linux/sched/sd_flags.h b/include/linux/sched/sd_flags.h
> index 57bde66d95f7..0f732bcfbb2c 100644
> --- a/include/linux/sched/sd_flags.h
> +++ b/include/linux/sched/sd_flags.h
> @@ -109,6 +109,11 @@ SD_FLAG(SD_ASYM_CPUCAPACITY_FULL, SDF_SHARED_PARENT | SDF_NEEDS_GROUPS)
>   */
>  SD_FLAG(SD_SHARE_CPUCAPACITY, SDF_SHARED_CHILD | SDF_NEEDS_GROUPS)
>  
> +/*
> + * Set up for cluster domains sharing resources such as llc tags or l2
> + */
> +SD_FLAG(SD_CLUSTER, SDF_NEEDS_GROUPS)
> +
>  /*
>   * Domain members share CPU package resources (i.e. caches)
>   *
> diff --git a/include/linux/sched/topology.h b/include/linux/sched/topology.h
> index c07bfa2d80f2..78c3a94fae66 100644
> --- a/include/linux/sched/topology.h
> +++ b/include/linux/sched/topology.h
> @@ -45,7 +45,7 @@ static inline int cpu_smt_flags(void)
>  #ifdef CONFIG_SCHED_CLUSTER
>  static inline int cpu_cluster_flags(void)
>  {
> -	return SD_SHARE_PKG_RESOURCES;
> +	return SD_CLUSTER | SD_SHARE_PKG_RESOURCES;

On non-cluster systems, there would be only one group at the at the
CLS domain. Since SD_CLUSTER is also tagged with SDF_NEEDS_GROUP, it
would need the presence of two groups. Thus, on such non-cluster
systems, the CLS domain will continue to be degenerated in favour of
the SMT domain.

>  }
>  #endif
>  
> @@ -177,6 +177,7 @@ cpumask_var_t *alloc_sched_domains(unsigned int ndoms);
>  void free_sched_domains(cpumask_var_t doms[], unsigned int ndoms);
>  
>  bool cpus_share_cache(int this_cpu, int that_cpu);
> +bool cpus_share_cluster(int this_cpu, int that_cpu);
>  
>  typedef const struct cpumask *(*sched_domain_mask_f)(int cpu);
>  typedef int (*sched_domain_flags_f)(void);
> @@ -230,6 +231,11 @@ static inline bool cpus_share_cache(int this_cpu, int that_cpu)
>  	return true;
>  }
>  
> +static inline bool cpus_share_cluster(int this_cpu, int that_cpu)
> +{
> +	return true;
> +}
> +
>  #endif	/* !CONFIG_SMP */
>  
>  #if defined(CONFIG_ENERGY_MODEL) && defined(CONFIG_CPU_FREQ_GOV_SCHEDUTIL)
> diff --git a/kernel/sched/core.c b/kernel/sched/core.c
> index 3c9b0fda64ac..11f9b25c3068 100644
> --- a/kernel/sched/core.c
> +++ b/kernel/sched/core.c
> @@ -3732,6 +3732,18 @@ bool cpus_share_cache(int this_cpu, int that_cpu)
>  	return per_cpu(sd_llc_id, this_cpu) == per_cpu(sd_llc_id, that_cpu);
>  }
>  
> +/*
> + * On non-Cluster machine this function works same with cpus_share_cache()
> + * as sd_cluster_id equals to sd_llc_id.
> + */

Ok, so on a non-cluster machine, a cluster is trivially defined to be
a single core (this is reflected in what the cpu_cluster_mask() shows
up on such machines).

However, in cpus_share_cluster(), we are upgrading the definition of a
cluster to be group of CPUs that share the LLC. This is inconsistent
with the original definition. Is there a way to avoid this
inconsistency ?



> +bool cpus_share_cluster(int this_cpu, int that_cpu)
> +{
> +	if (this_cpu == that_cpu)
> +		return true;
> +
> +	return per_cpu(sd_cluster_id, this_cpu) == per_cpu(sd_cluster_id, that_cpu);
> +}
> +
>  static inline bool ttwu_queue_cond(int cpu, int wake_flags)
>  {
>  	/*
> diff --git a/kernel/sched/sched.h b/kernel/sched/sched.h
> index 0e66749486e7..ddd29879ad40 100644
> --- a/kernel/sched/sched.h
> +++ b/kernel/sched/sched.h
> @@ -1763,7 +1763,9 @@ static inline struct sched_domain *lowest_flag_domain(int cpu, int flag)
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DECLARE_PER_CPU(int, sd_llc_size);
>  DECLARE_PER_CPU(int, sd_llc_id);
> +DECLARE_PER_CPU(int, sd_cluster_id);
>  DECLARE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
> +DECLARE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
>  DECLARE_PER_CPU(struct sched_domain __rcu *, sd_asym_cpucapacity);
> diff --git a/kernel/sched/topology.c b/kernel/sched/topology.c
> index d201a7052a29..5642df384904 100644
> --- a/kernel/sched/topology.c
> +++ b/kernel/sched/topology.c
> @@ -644,6 +644,8 @@ static void destroy_sched_domains(struct sched_domain *sd)
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_llc);
>  DEFINE_PER_CPU(int, sd_llc_size);
>  DEFINE_PER_CPU(int, sd_llc_id);
> +DEFINE_PER_CPU(int, sd_cluster_id);
> +DEFINE_PER_CPU(struct sched_domain __rcu *, sd_cluster);
>  DEFINE_PER_CPU(struct sched_domain_shared __rcu *, sd_llc_shared);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_numa);
>  DEFINE_PER_CPU(struct sched_domain __rcu *, sd_asym_packing);
> @@ -669,6 +671,12 @@ static void update_top_cache_domain(int cpu)
>  	per_cpu(sd_llc_id, cpu) = id;
>  	rcu_assign_pointer(per_cpu(sd_llc_shared, cpu), sds);
>  
> +	sd = lowest_flag_domain(cpu, SD_CLUSTER);
> +	if (sd)
> +		id = cpumask_first(sched_domain_span(sd));
> +	rcu_assign_pointer(per_cpu(sd_cluster, cpu), sd);
> +	per_cpu(sd_cluster_id, cpu) = id;
> +
>  	sd = lowest_flag_domain(cpu, SD_NUMA);
>  	rcu_assign_pointer(per_cpu(sd_numa, cpu), sd);
>  
> @@ -1514,6 +1522,7 @@ static unsigned long __read_mostly *sched_numa_onlined_nodes;
>   */
>  #define TOPOLOGY_SD_FLAGS		\
>  	(SD_SHARE_CPUCAPACITY	|	\
> +	 SD_CLUSTER		|	\
>  	 SD_SHARE_PKG_RESOURCES |	\
>  	 SD_NUMA		|	\
>  	 SD_ASYM_PACKING)
> -- 
> 2.33.0
> 


--
Thanks and Regards
gautham.
