Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E746B575B1E
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 07:58:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230017AbiGOF6G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 01:58:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45792 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230010AbiGOF6A (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 01:58:00 -0400
Received: from NAM11-BN8-obe.outbound.protection.outlook.com (mail-bn8nam11on2041.outbound.protection.outlook.com [40.107.236.41])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 83B0C4F668
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 22:57:56 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dFv38zOMvJikHng3ov8GBbxxNWgc1kDx6LxnUWfPt3nmjFKyc8bE8dbOAPU5eXXlDffgEit3YzKXY25pWfa6zph0q1X7345ifrrj43gvgjX8kuESy3hFLWm7Q2rFSio1mxe4f59zqq0d41vY0NP3Oo+GOSRfmD0BG8pxbAmQrH9Qvfz/hzu5seUD4JzkyfMKcjP7/kpttq4ghou8xGgZBV59toGOJeK/2+zVZvw++bIEALZQKiQRiADXiOqip3z9vaXSGS4UQo4lVeaviIMcS9KPhC+e6XSdHyLTz59j9T7q48EIBLdpr6jKXNPcxueoY3NSYonmZlDlOyABYCFcjA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=m64LaCtp+R9tZIO+HyI1U3c/O0DibHBHXCVhJbxqut0=;
 b=NHosP/mg+KWPSfXw25f0bVGSmOcc3On/KMd6BBWPGL7XnxAbNe5Lbjs84/ad7l4QlKX+T4IYhrpfTBpthk2tQuTXDKxGZ4t8U7Bu35snzw/ZI8gDjJowkHsKG/8+ZSoUDmLhro/1ssJwWbrJsxSp2wW/UV0ZyYTfN8i56lwt4/zfqjUlkwtdcF8yvygHtvr34cbIPrJmDeltKZ8HuexmXbjyBF/O/Y7P5EIF+az70MtrepbgB0maBz5Bh44DAVUYIjdPmqOgN+Kdo0S5/h+DB6OY7f42bFwiQDqFhGjughb0K3IBauEIeAOIk733eT449xkF6RwAvDQbYqw6dqryKA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=m64LaCtp+R9tZIO+HyI1U3c/O0DibHBHXCVhJbxqut0=;
 b=Re1drn3ert9H3keAXde1t71ISRHMemYllFDRPdEZX0r8MaLfucjAe4x+97TLovY0jfj2CFKhVwtlotwgHgFjEPy3i2vCM2knKxl5cb+oURzLsee/JWMwfZwYlKc/1tK7iJ872i6B0swuol+z/LMWG0Dj4nTbmFxBkJHzPaH0AQh2UpoT3tTKNQ2U7ZU+Bm0Lb/sNHKN0xcHsHhpHRDJUnEmrEwHRCh8/ne4Efu28x/E+Rh5s0Rk3hLNLpJFx5ADvl2lkhNrOucP8NsZQmDJeQdP/eZgLE8R3oKpkVhrIt9TQjfNbwZ8K60AH680vn5p9/m808R7xBcoFvvgsnXi/8Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BYAPR12MB3176.namprd12.prod.outlook.com (2603:10b6:a03:134::26)
 by DM4PR12MB5167.namprd12.prod.outlook.com (2603:10b6:5:396::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5438.13; Fri, 15 Jul
 2022 05:57:54 +0000
Received: from BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7]) by BYAPR12MB3176.namprd12.prod.outlook.com
 ([fe80::eca6:a4a7:e2b2:27e7%5]) with mapi id 15.20.5417.020; Fri, 15 Jul 2022
 05:57:54 +0000
References: <20220714045351.434957-1-aneesh.kumar@linux.ibm.com>
 <20220714045351.434957-6-aneesh.kumar@linux.ibm.com>
User-agent: mu4e 1.6.9; emacs 27.1
From:   Alistair Popple <apopple@nvidia.com>
To:     "Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com>
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org,
        Wei Xu <weixugc@google.com>, Huang Ying <ying.huang@intel.com>,
        Yang Shi <shy828301@gmail.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Tim C Chen <tim.c.chen@intel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Hesham Almatary <hesham.almatary@huawei.com>,
        Dave Hansen <dave.hansen@intel.com>,
        Jonathan Cameron <Jonathan.Cameron@huawei.com>,
        Dan Williams <dan.j.williams@intel.com>,
        Johannes Weiner <hannes@cmpxchg.org>, jvgediya.oss@gmail.com
Subject: Re: [PATCH v9 5/8] mm/demotion: Build demotion targets based on
 explicit memory tiers
Date:   Fri, 15 Jul 2022 14:47:31 +1000
In-reply-to: <20220714045351.434957-6-aneesh.kumar@linux.ibm.com>
Message-ID: <87cze6apeo.fsf@nvdebian.thelocal>
Content-Type: text/plain
X-ClientProxiedBy: BYAPR06CA0050.namprd06.prod.outlook.com
 (2603:10b6:a03:14b::27) To BYAPR12MB3176.namprd12.prod.outlook.com
 (2603:10b6:a03:134::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8efb0298-2e67-4a8e-83fc-08da6626f5a5
X-MS-TrafficTypeDiagnostic: DM4PR12MB5167:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pRjjOxk2HPsNmEh2TXla6WPg1/zqskMTP6+RaOvDSctw/9VZH2ANb3p/PS4EgEgb4qT2bJZmqre8bKFymYwl2qQiuwBkjUDWhdGmU5s/1rReuPMcyN794UnfHk+Yk6p3fw77PspN8bONsALQeo74A4v7Vhk9BobsiwRfvy2DK0uUzBeqYK/U8xUvXMjwve6OK1RKazQ9xZ57nyaFssqnSV9JfaYGjLa7nC6OegV0rVdVDiz/Po+czzh9jUqa2YWL3IynasYijWXskI0mPfbwe9ddfbvkzxjiooOfVxQ8tXtH88eXzKpuK0bsS6zMRW5/OBYnMMaF8b7G9VeKazme9UtHdkls21DDC6ltmLyUpihEmwUFh5ANwBoJlMRvVuFKDjXgcLuyRz5sIeB4N+d1aCyj1O9YZOBXGRN8joT+iG9laInEaztIRG8pRGxeo1i+PWp7YrdUPGnVmsWmOJDBIMurmCeaIb83l6F3B5+kSnRljbwp/lAqywnXOPJf6sUO1LMS9zx6GXFcFoBTnY6CRnnsE1LLXAFtrBt2ai/x/Q095KR6VQBjJPPwebhJ2sjSP3L24XvBOVJf71fS6rxrfB+XGygAEx/6qsmhLsFWRzWrYROs4ThqpHjGQqS/VN+q6ldLENt2Tq6iSn11Dpy6SYCawHSJWt7i0rV83cal+oRB/Fp0iU6Zy7+KCrMtzcGlp3lwfQhsTSUwH+Pln9yKgvX6JrmxvXmsTr68Et2tnNaXoszHcjL9q1uSvm3OY2Mbf0Dwt7wtH/4c6wWmgNhwnQ==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR12MB3176.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(346002)(366004)(376002)(396003)(66476007)(4326008)(6512007)(9686003)(6486002)(83380400001)(26005)(5660300002)(38100700002)(2906002)(186003)(86362001)(66946007)(8936002)(8676002)(66556008)(30864003)(41300700001)(6666004)(6506007)(478600001)(7416002)(54906003)(6916009)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?iGJGzDce2pEj747EnBXCNWmkeNZrP3+DaWNa8QPjiALfJ0/Cem/+DZ305Ykg?=
 =?us-ascii?Q?B5jnYCuTI/CZ1eMndCc23+7SIM3p23cVDyaGVFe9nxujCLEHYD46B6UryG+G?=
 =?us-ascii?Q?t2bQpYkPAjaxNyNdUsYO0Orw1hyWsIVL/VSWbXSJVLcAbXTw9H2IBoNOnCu7?=
 =?us-ascii?Q?w2gsvHEUSygsf2CBws9+hUY7TkWyrKlZwY75e07PWPUBf0oHfKZcoZDCtfMP?=
 =?us-ascii?Q?oL6ZkMKZDVLgCXIcbNw1WZ2cM3omKws54xGKkv9zlD4rxk3p+nnMefvCDFEz?=
 =?us-ascii?Q?DBKzs+xBRoTuO7aISluDCvrk+4mKlwNg0ztRF6LAGZeGiLVBYqDrhydla5Y4?=
 =?us-ascii?Q?vApO1awdBOPSs0KffLwc/Jubi8qTw9hTotPPoRMrA2O1PBBOWfMPJznuRmYX?=
 =?us-ascii?Q?mZxaK6kvmEqnSHrpEYRinlueMSsfarU1Ikp1dnedQdJxJahtHcgZEPV+E6aP?=
 =?us-ascii?Q?b9rcuEGJrtJEz66+fS29vhZnd761Snzx0vzxCQ6hgaSEX+3lamO8hH+ZKtwm?=
 =?us-ascii?Q?DSV0PzcRq/F+u3kInYtjhigjtXsDM9ocsTrrBiw68f8//wF1U24YN/WesuUU?=
 =?us-ascii?Q?ielmhc1KcrjoEkYXYZOhIrjs1SU5Ra+ubpcVR+2AEJzqTvsjQiDgCAPrYf83?=
 =?us-ascii?Q?DEklvY/so005+Q2VgsZp2wvZDYQLUPbNyF026vNZxHZO+TJFm4XHUWc0GUgZ?=
 =?us-ascii?Q?OU1EQ2fzCtpWwYkMRWhCGYUIGgBa9UwHvM2EBTQ+S2+IYk8lnEuw67SI0AnZ?=
 =?us-ascii?Q?R9C9aU0F2K081PuHWwYnZ8n59pTJtzS4VPB2nMuhQpG3WOwG1ZAHDAbBsZ/W?=
 =?us-ascii?Q?tCPyaUan6kl0yO/FdU6Fx6sDnUfpIYg0XzoX0DkRy0J1Tfv6Aaq5h007kahM?=
 =?us-ascii?Q?yRD39ScuHHBTe8YFeMITzR48jUuXY45tAzyq56HvbOOQsFE3mEzaHAkveILy?=
 =?us-ascii?Q?jrV5wiah1wxwFK4sH53Xgno/VchuYFssmXpwWAG63gNIvnoVSF+F+91Huzqg?=
 =?us-ascii?Q?ffDS6mVRmI/MxxjBkCsc5O7DMchi/bDubFnDMEB3rz/GE8mtBiCF29KDt9dv?=
 =?us-ascii?Q?Qs0TeFFyxGPz447pm43uEhUw2XAyYlptaJcMLuWKk5q58Lw6u77GtYUcl9HH?=
 =?us-ascii?Q?25sWa5RX1o8HhoxIjrRwXO4zsl6PZ1zjRlleZIIiYq8BoF2yQDG1FUyq0T/G?=
 =?us-ascii?Q?YdyAjKK3jg/174PCYI36LWfbd8pF2KnnsI7cwDoA7d5EsxlG7vSaLlg0pW9s?=
 =?us-ascii?Q?QJHlFNfCP1mp6tGbk04RXRR7x8YKrdNfDQXXdUOcZeSFZi3rsqx1zL0GTMXM?=
 =?us-ascii?Q?Xu4jmqTGlaO/RLBFbmZLDueNSgKRHt7XHhKAFcd/FGQChvGntSdOvz7JvXQ6?=
 =?us-ascii?Q?lAphq1fe+12wg3mD0l8LWnEJShlKRUH1VamN3gIslw5I7bWxlSkgVv905dfw?=
 =?us-ascii?Q?/cKUdxvKAnrkYw8uKyNQf/s1uGZSijjORFfVPZVoUXkw3i3Voxf8gB1TgT8S?=
 =?us-ascii?Q?KTOxFneMbw8Iz8E7IhfzxNXvzLu7QqIBQOVnlxu4FZNnz7mfSh8vl4xLBY6D?=
 =?us-ascii?Q?+d3IQNxZLAboAMXvfB3AY67VGy6CVPqr58qv5fIi?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8efb0298-2e67-4a8e-83fc-08da6626f5a5
X-MS-Exchange-CrossTenant-AuthSource: BYAPR12MB3176.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 15 Jul 2022 05:57:54.5370
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: YT8zpna+XZCdlwemr3ZAFyAER/n6b6ErawBnBZ5Reti/ZbA4uVLq8VJe/8Sv8ibyz9uXVkx+FwmoJwLabsER3Q==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR12MB5167
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


"Aneesh Kumar K.V" <aneesh.kumar@linux.ibm.com> writes:

> This patch switch the demotion target building logic to use memory tiers
> instead of NUMA distance. All N_MEMORY NUMA nodes will be placed in the
> default tier 200 and additional memory tiers will be added by drivers like
> dax kmem.
>
> This patch builds the demotion target for a NUMA node by looking at all
> memory tiers below the tier to which the NUMA node belongs. The closest node
> in the immediately following memory tier is used as a demotion target.
>
> Since we are now only building demotion target for N_MEMORY NUMA nodes
> the CPU hotplug calls are removed in this patch.
>
> A new memory tier can be inserted into the tier hierarchy for a new set
> of nodes without affecting the node assignment of any existing memtier,
> provided that there is enough gap in the tier ID values for the new memtier.
>
> The absolute value of tier ID of a memtier doesn't necessarily carry any meaning.
> Its value relative to other memtiers decides the level of this memtier in the tier
> hierarchy.
>
> For now, This patch supports hardcoded tier ID values which are 300, 200 and 100 for
> memory tiers.
>
> Suggested-by: Wei Xu <weixugc@google.com>
> Signed-off-by: Aneesh Kumar K.V <aneesh.kumar@linux.ibm.com>
> ---
>  include/linux/memory-tiers.h |  13 ++
>  include/linux/migrate.h      |  13 --
>  mm/memory-tiers.c            | 227 ++++++++++++++++++++
>  mm/migrate.c                 | 394 -----------------------------------
>  mm/vmstat.c                  |   4 -
>  5 files changed, 240 insertions(+), 411 deletions(-)
>
> diff --git a/include/linux/memory-tiers.h b/include/linux/memory-tiers.h
> index 9d36ff13c954..3234301c2537 100644
> --- a/include/linux/memory-tiers.h
> +++ b/include/linux/memory-tiers.h
> @@ -15,6 +15,14 @@
>
>  extern bool numa_demotion_enabled;
>  int node_create_and_set_memory_tier(int node, int tier);
> +#ifdef CONFIG_MIGRATION
> +int next_demotion_node(int node);
> +#else
> +static inline int next_demotion_node(int node)
> +{
> +	return NUMA_NO_NODE;
> +}
> +#endif
>
>  #else
>
> @@ -23,5 +31,10 @@ static inline int node_create_and_set_memory_tier(int node, int tier)
>  {
>  	return 0;
>  }
> +
> +static inline int next_demotion_node(int node)
> +{
> +	return NUMA_NO_NODE;
> +}
>  #endif	/* CONFIG_NUMA */
>  #endif  /* _LINUX_MEMORY_TIERS_H */
> diff --git a/include/linux/migrate.h b/include/linux/migrate.h
> index 43e737215f33..93fab62e6548 100644
> --- a/include/linux/migrate.h
> +++ b/include/linux/migrate.h
> @@ -75,19 +75,6 @@ static inline int migrate_huge_page_move_mapping(struct address_space *mapping,
>
>  #endif /* CONFIG_MIGRATION */
>
> -#if defined(CONFIG_MIGRATION) && defined(CONFIG_NUMA)
> -extern void set_migration_target_nodes(void);
> -extern void migrate_on_reclaim_init(void);
> -extern int next_demotion_node(int node);
> -#else
> -static inline void set_migration_target_nodes(void) {}
> -static inline void migrate_on_reclaim_init(void) {}
> -static inline int next_demotion_node(int node)
> -{
> -        return NUMA_NO_NODE;
> -}
> -#endif
> -
>  #ifdef CONFIG_COMPACTION
>  extern int PageMovable(struct page *page);
>  extern void __SetPageMovable(struct page *page, struct address_space *mapping);
> diff --git a/mm/memory-tiers.c b/mm/memory-tiers.c
> index 5706ad647136..e951f54ce56c 100644
> --- a/mm/memory-tiers.c
> +++ b/mm/memory-tiers.c
> @@ -6,16 +6,85 @@
>  #include <linux/lockdep.h>
>  #include <linux/moduleparam.h>
>  #include <linux/memory.h>
> +#include <linux/random.h>
>  #include <linux/memory-tiers.h>
>
> +#include "internal.h"
> +
>  struct memory_tier {
>  	struct list_head list;
>  	int id;
>  	nodemask_t nodelist;
>  };
>
> +struct demotion_nodes {
> +	nodemask_t preferred;
> +};
> +
> +static void establish_migration_targets(void);
>  static DEFINE_MUTEX(memory_tier_lock);
>  static LIST_HEAD(memory_tiers);
> +/*
> + * node_demotion[] examples:
> + *
> + * Example 1:
> + *
> + * Node 0 & 1 are CPU + DRAM nodes, node 2 & 3 are PMEM nodes.
> + *
> + * node distances:
> + * node   0    1    2    3
> + *    0  10   20   30   40
> + *    1  20   10   40   30
> + *    2  30   40   10   40
> + *    3  40   30   40   10
> + *
> + * memory_tiers[0] = <empty>
> + * memory_tiers[1] = 0-1
> + * memory_tiers[2] = 2-3
> + *
> + * node_demotion[0].preferred = 2
> + * node_demotion[1].preferred = 3
> + * node_demotion[2].preferred = <empty>
> + * node_demotion[3].preferred = <empty>
> + *
> + * Example 2:
> + *
> + * Node 0 & 1 are CPU + DRAM nodes, node 2 is memory-only DRAM node.
> + *
> + * node distances:
> + * node   0    1    2
> + *    0  10   20   30
> + *    1  20   10   30
> + *    2  30   30   10
> + *
> + * memory_tiers[0] = <empty>
> + * memory_tiers[1] = 0-2
> + * memory_tiers[2] = <empty>
> + *
> + * node_demotion[0].preferred = <empty>
> + * node_demotion[1].preferred = <empty>
> + * node_demotion[2].preferred = <empty>
> + *
> + * Example 3:
> + *
> + * Node 0 is CPU + DRAM nodes, Node 1 is HBM node, node 2 is PMEM node.
> + *
> + * node distances:
> + * node   0    1    2
> + *    0  10   20   30
> + *    1  20   10   40
> + *    2  30   40   10
> + *
> + * memory_tiers[0] = 1
> + * memory_tiers[1] = 0
> + * memory_tiers[2] = 2
> + *
> + * node_demotion[0].preferred = 2
> + * node_demotion[1].preferred = 0
> + * node_demotion[2].preferred = <empty>
> + *
> + */
> +static struct demotion_nodes *node_demotion __read_mostly;
>
>  static void insert_memory_tier(struct memory_tier *memtier)
>  {
> @@ -108,6 +177,7 @@ int node_create_and_set_memory_tier(int node, int tier)
>  	current_tier = __node_get_memory_tier(node);
>  	if (!current_tier) {
>  		ret = __node_create_and_set_memory_tier(node, tier);
> +		establish_migration_targets();
>  		goto out;
>  	}
>
> @@ -124,6 +194,8 @@ int node_create_and_set_memory_tier(int node, int tier)
>  	}
>  	if (nodes_empty(current_tier->nodelist))
>  		unregister_memory_tier(current_tier);
> +
> +	establish_migration_targets();
>  out:
>  	mutex_unlock(&memory_tier_lock);
>
> @@ -153,14 +225,152 @@ static int node_set_memory_tier(int node, int tier)
>
>  	mutex_lock(&memory_tier_lock);
>  	memtier = __node_get_memory_tier(node);
> +	/*
> +	 * if node is already part of the tier proceed with the
> +	 * current tier value, because we might want to establish
> +	 * new migration paths now. The node might be added to a tier
> +	 * before it was made part of N_MEMORY, hence estabilish_migration_targets
> +	 * will have skipped this node.
> +	 */
>  	if (!memtier)
>  		ret = __node_set_memory_tier(node, tier);
> +	establish_migration_targets();
>
>  	mutex_unlock(&memory_tier_lock);
>
>  	return ret;
>  }
>
> +#ifdef CONFIG_MIGRATION
> +/**
> + * next_demotion_node() - Get the next node in the demotion path
> + * @node: The starting node to lookup the next node
> + *
> + * Return: node id for next memory node in the demotion path hierarchy
> + * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
> + * @node online or guarantee that it *continues* to be the next demotion
> + * target.
> + */
> +int next_demotion_node(int node)
> +{
> +	struct demotion_nodes *nd;
> +	int target;
> +
> +	if (!node_demotion)
> +		return NUMA_NO_NODE;
> +
> +	nd = &node_demotion[node];
> +
> +	/*
> +	 * node_demotion[] is updated without excluding this
> +	 * function from running.
> +	 *
> +	 * Make sure to use RCU over entire code blocks if
> +	 * node_demotion[] reads need to be consistent.
> +	 */
> +	rcu_read_lock();
> +	/*
> +	 * If there are multiple target nodes, just select one
> +	 * target node randomly.
> +	 *
> +	 * In addition, we can also use round-robin to select
> +	 * target node, but we should introduce another variable
> +	 * for node_demotion[] to record last selected target node,
> +	 * that may cause cache ping-pong due to the changing of
> +	 * last target node. Or introducing per-cpu data to avoid
> +	 * caching issue, which seems more complicated. So selecting
> +	 * target node randomly seems better until now.
> +	 */
> +	target = node_random(&nd->preferred);
> +	rcu_read_unlock();
> +
> +	return target;
> +}
> +
> +/* Disable reclaim-based migration. */
> +static void __disable_all_migrate_targets(void)
> +{
> +	int node;
> +
> +	for_each_node_state(node, N_MEMORY)
> +		node_demotion[node].preferred = NODE_MASK_NONE;
> +}
> +
> +static void disable_all_migrate_targets(void)
> +{
> +	__disable_all_migrate_targets();
> +
> +	/*
> +	 * Ensure that the "disable" is visible across the system.
> +	 * Readers will see either a combination of before+disable
> +	 * state or disable+after.  They will never see before and
> +	 * after state together.
> +	 */
> +	synchronize_rcu();
> +}
> +#else
> +static void disable_all_migrate_targets(void) {}
> +#endif
> +
> +/*
> + * Find an automatic demotion target for all memory
> + * nodes. Failing here is OK.  It might just indicate
> + * being at the end of a chain.
> + */
> +static void establish_migration_targets(void)
> +{
> +	struct memory_tier *memtier;
> +	struct demotion_nodes *nd;
> +	int target = NUMA_NO_NODE, node;
> +	int distance, best_distance;
> +	nodemask_t used;
> +
> +	if (!node_demotion || !IS_ENABLED(CONFIG_MIGRATION))

Does it make sense to include the memory tiering/demotion code if
CONFIG_MIGRATION isn't enabled? From what I can tell none of the
information established here is used if CONFIG_MIGRATION isn't enabled,
so it would be better to remove the IS_ENABLED checks and not include
the code at all.

> +		return;
> +
> +	disable_all_migrate_targets();
> +
> +	for_each_node_state(node, N_MEMORY) {
> +		best_distance = -1;
> +		nd = &node_demotion[node];
> +
> +		memtier = __node_get_memory_tier(node);
> +		if (!memtier || list_is_last(&memtier->list, &memory_tiers))
> +			continue;
> +		/*
> +		 * Get the next memtier to find the  demotion node list.
> +		 */
> +		memtier = list_next_entry(memtier, list);
> +
> +		/*
> +		 * find_next_best_node, use 'used' nodemask as a skip list.
> +		 * Add all memory nodes except the selected memory tier
> +		 * nodelist to skip list so that we find the best node from the
> +		 * memtier nodelist.
> +		 */
> +		nodes_andnot(used, node_states[N_MEMORY], memtier->nodelist);
> +
> +		/*
> +		 * Find all the nodes in the memory tier node list of same best distance.
> +		 * add them to the preferred mask. We randomly select between nodes
> +		 * in the preferred mask when allocating pages during demotion.
> +		 */
> +		do {
> +			target = find_next_best_node(node, &used);
> +			if (target == NUMA_NO_NODE)
> +				break;
> +
> +			distance = node_distance(node, target);
> +			if (distance == best_distance || best_distance == -1) {
> +				best_distance = distance;
> +				node_set(target, nd->preferred);
> +			} else {
> +				break;
> +			}
> +		} while (1);
> +	}
> +}
> +
>  static unsigned int default_memtier = DEFAULT_MEMORY_TIER;
>  core_param(default_memory_tier, default_memtier, uint, 0644);
>  /*
> @@ -181,6 +391,17 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>  		return notifier_from_errno(0);
>
>  	switch (action) {
> +	case MEM_OFFLINE:
> +		/*
> +		 * In case we are moving out of N_MEMORY. Keep the node
> +		 * in the memory tier so that when we bring memory online,
> +		 * they appear in the right memory tier. We still need
> +		 * to rebuild the demotion order.
> +		 */
> +		mutex_lock(&memory_tier_lock);
> +		establish_migration_targets();
> +		mutex_unlock(&memory_tier_lock);
> +		break;
>  	case MEM_ONLINE:
>  		/*
>  		 * We ignore the error here, if the node already have the tier
> @@ -196,6 +417,12 @@ static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
>
>  static void __init migrate_on_reclaim_init(void)
>  {
> +
> +	if (IS_ENABLED(CONFIG_MIGRATION)) {
> +		node_demotion = kcalloc(MAX_NUMNODES, sizeof(struct demotion_nodes),
> +					GFP_KERNEL);
> +		WARN_ON(!node_demotion);
> +	}
>  	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
>  }
>
> diff --git a/mm/migrate.c b/mm/migrate.c
> index fce7d4a9e940..c758c9c21d7d 100644
> --- a/mm/migrate.c
> +++ b/mm/migrate.c
> @@ -2117,398 +2117,4 @@ int migrate_misplaced_page(struct page *page, struct vm_area_struct *vma,
>  	return 0;
>  }
>  #endif /* CONFIG_NUMA_BALANCING */
> -
> -/*
> - * node_demotion[] example:
> - *
> - * Consider a system with two sockets.  Each socket has
> - * three classes of memory attached: fast, medium and slow.
> - * Each memory class is placed in its own NUMA node.  The
> - * CPUs are placed in the node with the "fast" memory.  The
> - * 6 NUMA nodes (0-5) might be split among the sockets like
> - * this:
> - *
> - *	Socket A: 0, 1, 2
> - *	Socket B: 3, 4, 5
> - *
> - * When Node 0 fills up, its memory should be migrated to
> - * Node 1.  When Node 1 fills up, it should be migrated to
> - * Node 2.  The migration path start on the nodes with the
> - * processors (since allocations default to this node) and
> - * fast memory, progress through medium and end with the
> - * slow memory:
> - *
> - *	0 -> 1 -> 2 -> stop
> - *	3 -> 4 -> 5 -> stop
> - *
> - * This is represented in the node_demotion[] like this:
> - *
> - *	{  nr=1, nodes[0]=1 }, // Node 0 migrates to 1
> - *	{  nr=1, nodes[0]=2 }, // Node 1 migrates to 2
> - *	{  nr=0, nodes[0]=-1 }, // Node 2 does not migrate
> - *	{  nr=1, nodes[0]=4 }, // Node 3 migrates to 4
> - *	{  nr=1, nodes[0]=5 }, // Node 4 migrates to 5
> - *	{  nr=0, nodes[0]=-1 }, // Node 5 does not migrate
> - *
> - * Moreover some systems may have multiple slow memory nodes.
> - * Suppose a system has one socket with 3 memory nodes, node 0
> - * is fast memory type, and node 1/2 both are slow memory
> - * type, and the distance between fast memory node and slow
> - * memory node is same. So the migration path should be:
> - *
> - *	0 -> 1/2 -> stop
> - *
> - * This is represented in the node_demotion[] like this:
> - *	{ nr=2, {nodes[0]=1, nodes[1]=2} }, // Node 0 migrates to node 1 and node 2
> - *	{ nr=0, nodes[0]=-1, }, // Node 1 dose not migrate
> - *	{ nr=0, nodes[0]=-1, }, // Node 2 does not migrate
> - */
> -
> -/*
> - * Writes to this array occur without locking.  Cycles are
> - * not allowed: Node X demotes to Y which demotes to X...
> - *
> - * If multiple reads are performed, a single rcu_read_lock()
> - * must be held over all reads to ensure that no cycles are
> - * observed.
> - */
> -#define DEFAULT_DEMOTION_TARGET_NODES 15
> -
> -#if MAX_NUMNODES < DEFAULT_DEMOTION_TARGET_NODES
> -#define DEMOTION_TARGET_NODES	(MAX_NUMNODES - 1)
> -#else
> -#define DEMOTION_TARGET_NODES	DEFAULT_DEMOTION_TARGET_NODES
> -#endif
> -
> -struct demotion_nodes {
> -	unsigned short nr;
> -	short nodes[DEMOTION_TARGET_NODES];
> -};
> -
> -static struct demotion_nodes *node_demotion __read_mostly;
> -
> -/**
> - * next_demotion_node() - Get the next node in the demotion path
> - * @node: The starting node to lookup the next node
> - *
> - * Return: node id for next memory node in the demotion path hierarchy
> - * from @node; NUMA_NO_NODE if @node is terminal.  This does not keep
> - * @node online or guarantee that it *continues* to be the next demotion
> - * target.
> - */
> -int next_demotion_node(int node)
> -{
> -	struct demotion_nodes *nd;
> -	unsigned short target_nr, index;
> -	int target;
> -
> -	if (!node_demotion)
> -		return NUMA_NO_NODE;
> -
> -	nd = &node_demotion[node];
> -
> -	/*
> -	 * node_demotion[] is updated without excluding this
> -	 * function from running.  RCU doesn't provide any
> -	 * compiler barriers, so the READ_ONCE() is required
> -	 * to avoid compiler reordering or read merging.
> -	 *
> -	 * Make sure to use RCU over entire code blocks if
> -	 * node_demotion[] reads need to be consistent.
> -	 */
> -	rcu_read_lock();
> -	target_nr = READ_ONCE(nd->nr);
> -
> -	switch (target_nr) {
> -	case 0:
> -		target = NUMA_NO_NODE;
> -		goto out;
> -	case 1:
> -		index = 0;
> -		break;
> -	default:
> -		/*
> -		 * If there are multiple target nodes, just select one
> -		 * target node randomly.
> -		 *
> -		 * In addition, we can also use round-robin to select
> -		 * target node, but we should introduce another variable
> -		 * for node_demotion[] to record last selected target node,
> -		 * that may cause cache ping-pong due to the changing of
> -		 * last target node. Or introducing per-cpu data to avoid
> -		 * caching issue, which seems more complicated. So selecting
> -		 * target node randomly seems better until now.
> -		 */
> -		index = get_random_int() % target_nr;
> -		break;
> -	}
> -
> -	target = READ_ONCE(nd->nodes[index]);
> -
> -out:
> -	rcu_read_unlock();
> -	return target;
> -}
> -
> -/* Disable reclaim-based migration. */
> -static void __disable_all_migrate_targets(void)
> -{
> -	int node, i;
> -
> -	if (!node_demotion)
> -		return;
> -
> -	for_each_online_node(node) {
> -		node_demotion[node].nr = 0;
> -		for (i = 0; i < DEMOTION_TARGET_NODES; i++)
> -			node_demotion[node].nodes[i] = NUMA_NO_NODE;
> -	}
> -}
> -
> -static void disable_all_migrate_targets(void)
> -{
> -	__disable_all_migrate_targets();
> -
> -	/*
> -	 * Ensure that the "disable" is visible across the system.
> -	 * Readers will see either a combination of before+disable
> -	 * state or disable+after.  They will never see before and
> -	 * after state together.
> -	 *
> -	 * The before+after state together might have cycles and
> -	 * could cause readers to do things like loop until this
> -	 * function finishes.  This ensures they can only see a
> -	 * single "bad" read and would, for instance, only loop
> -	 * once.
> -	 */
> -	synchronize_rcu();
> -}
> -
> -/*
> - * Find an automatic demotion target for 'node'.
> - * Failing here is OK.  It might just indicate
> - * being at the end of a chain.
> - */
> -static int establish_migrate_target(int node, nodemask_t *used,
> -				    int best_distance)
> -{
> -	int migration_target, index, val;
> -	struct demotion_nodes *nd;
> -
> -	if (!node_demotion)
> -		return NUMA_NO_NODE;
> -
> -	nd = &node_demotion[node];
> -
> -	migration_target = find_next_best_node(node, used);
> -	if (migration_target == NUMA_NO_NODE)
> -		return NUMA_NO_NODE;
> -
> -	/*
> -	 * If the node has been set a migration target node before,
> -	 * which means it's the best distance between them. Still
> -	 * check if this node can be demoted to other target nodes
> -	 * if they have a same best distance.
> -	 */
> -	if (best_distance != -1) {
> -		val = node_distance(node, migration_target);
> -		if (val > best_distance)
> -			goto out_clear;
> -	}
> -
> -	index = nd->nr;
> -	if (WARN_ONCE(index >= DEMOTION_TARGET_NODES,
> -		      "Exceeds maximum demotion target nodes\n"))
> -		goto out_clear;
> -
> -	nd->nodes[index] = migration_target;
> -	nd->nr++;
> -
> -	return migration_target;
> -out_clear:
> -	node_clear(migration_target, *used);
> -	return NUMA_NO_NODE;
> -}
> -
> -/*
> - * When memory fills up on a node, memory contents can be
> - * automatically migrated to another node instead of
> - * discarded at reclaim.
> - *
> - * Establish a "migration path" which will start at nodes
> - * with CPUs and will follow the priorities used to build the
> - * page allocator zonelists.
> - *
> - * The difference here is that cycles must be avoided.  If
> - * node0 migrates to node1, then neither node1, nor anything
> - * node1 migrates to can migrate to node0. Also one node can
> - * be migrated to multiple nodes if the target nodes all have
> - * a same best-distance against the source node.
> - *
> - * This function can run simultaneously with readers of
> - * node_demotion[].  However, it can not run simultaneously
> - * with itself.  Exclusion is provided by memory hotplug events
> - * being single-threaded.
> - */
> -static void __set_migration_target_nodes(void)
> -{
> -	nodemask_t next_pass;
> -	nodemask_t this_pass;
> -	nodemask_t used_targets = NODE_MASK_NONE;
> -	int node, best_distance;
> -
> -	/*
> -	 * Avoid any oddities like cycles that could occur
> -	 * from changes in the topology.  This will leave
> -	 * a momentary gap when migration is disabled.
> -	 */
> -	disable_all_migrate_targets();
> -
> -	/*
> -	 * Allocations go close to CPUs, first.  Assume that
> -	 * the migration path starts at the nodes with CPUs.
> -	 */
> -	next_pass = node_states[N_CPU];
> -again:
> -	this_pass = next_pass;
> -	next_pass = NODE_MASK_NONE;
> -	/*
> -	 * To avoid cycles in the migration "graph", ensure
> -	 * that migration sources are not future targets by
> -	 * setting them in 'used_targets'.  Do this only
> -	 * once per pass so that multiple source nodes can
> -	 * share a target node.
> -	 *
> -	 * 'used_targets' will become unavailable in future
> -	 * passes.  This limits some opportunities for
> -	 * multiple source nodes to share a destination.
> -	 */
> -	nodes_or(used_targets, used_targets, this_pass);
> -
> -	for_each_node_mask(node, this_pass) {
> -		best_distance = -1;
> -
> -		/*
> -		 * Try to set up the migration path for the node, and the target
> -		 * migration nodes can be multiple, so doing a loop to find all
> -		 * the target nodes if they all have a best node distance.
> -		 */
> -		do {
> -			int target_node =
> -				establish_migrate_target(node, &used_targets,
> -							 best_distance);
> -
> -			if (target_node == NUMA_NO_NODE)
> -				break;
> -
> -			if (best_distance == -1)
> -				best_distance = node_distance(node, target_node);
> -
> -			/*
> -			 * Visit targets from this pass in the next pass.
> -			 * Eventually, every node will have been part of
> -			 * a pass, and will become set in 'used_targets'.
> -			 */
> -			node_set(target_node, next_pass);
> -		} while (1);
> -	}
> -	/*
> -	 * 'next_pass' contains nodes which became migration
> -	 * targets in this pass.  Make additional passes until
> -	 * no more migrations targets are available.
> -	 */
> -	if (!nodes_empty(next_pass))
> -		goto again;
> -}
> -
> -/*
> - * For callers that do not hold get_online_mems() already.
> - */
> -void set_migration_target_nodes(void)
> -{
> -	get_online_mems();
> -	__set_migration_target_nodes();
> -	put_online_mems();
> -}
> -
> -/*
> - * This leaves migrate-on-reclaim transiently disabled between
> - * the MEM_GOING_OFFLINE and MEM_OFFLINE events.  This runs
> - * whether reclaim-based migration is enabled or not, which
> - * ensures that the user can turn reclaim-based migration at
> - * any time without needing to recalculate migration targets.
> - *
> - * These callbacks already hold get_online_mems().  That is why
> - * __set_migration_target_nodes() can be used as opposed to
> - * set_migration_target_nodes().
> - */
> -#ifdef CONFIG_MEMORY_HOTPLUG
> -static int __meminit migrate_on_reclaim_callback(struct notifier_block *self,
> -						 unsigned long action, void *_arg)
> -{
> -	struct memory_notify *arg = _arg;
> -
> -	/*
> -	 * Only update the node migration order when a node is
> -	 * changing status, like online->offline.  This avoids
> -	 * the overhead of synchronize_rcu() in most cases.
> -	 */
> -	if (arg->status_change_nid < 0)
> -		return notifier_from_errno(0);
> -
> -	switch (action) {
> -	case MEM_GOING_OFFLINE:
> -		/*
> -		 * Make sure there are not transient states where
> -		 * an offline node is a migration target.  This
> -		 * will leave migration disabled until the offline
> -		 * completes and the MEM_OFFLINE case below runs.
> -		 */
> -		disable_all_migrate_targets();
> -		break;
> -	case MEM_OFFLINE:
> -	case MEM_ONLINE:
> -		/*
> -		 * Recalculate the target nodes once the node
> -		 * reaches its final state (online or offline).
> -		 */
> -		__set_migration_target_nodes();
> -		break;
> -	case MEM_CANCEL_OFFLINE:
> -		/*
> -		 * MEM_GOING_OFFLINE disabled all the migration
> -		 * targets.  Reenable them.
> -		 */
> -		__set_migration_target_nodes();
> -		break;
> -	case MEM_GOING_ONLINE:
> -	case MEM_CANCEL_ONLINE:
> -		break;
> -	}
> -
> -	return notifier_from_errno(0);
> -}
> -#endif
> -
> -void __init migrate_on_reclaim_init(void)
> -{
> -	node_demotion = kcalloc(nr_node_ids,
> -				sizeof(struct demotion_nodes),
> -				GFP_KERNEL);
> -	WARN_ON(!node_demotion);
> -#ifdef CONFIG_MEMORY_HOTPLUG
> -	hotplug_memory_notifier(migrate_on_reclaim_callback, 100);
> -#endif
> -	/*
> -	 * At this point, all numa nodes with memory/CPus have their state
> -	 * properly set, so we can build the demotion order now.
> -	 * Let us hold the cpu_hotplug lock just, as we could possibily have
> -	 * CPU hotplug events during boot.
> -	 */
> -	cpus_read_lock();
> -	set_migration_target_nodes();
> -	cpus_read_unlock();
> -}
>  #endif /* CONFIG_NUMA */
> -
> -
> diff --git a/mm/vmstat.c b/mm/vmstat.c
> index 373d2730fcf2..35c6ff97cf29 100644
> --- a/mm/vmstat.c
> +++ b/mm/vmstat.c
> @@ -28,7 +28,6 @@
>  #include <linux/mm_inline.h>
>  #include <linux/page_ext.h>
>  #include <linux/page_owner.h>
> -#include <linux/migrate.h>
>
>  #include "internal.h"
>
> @@ -2060,7 +2059,6 @@ static int vmstat_cpu_online(unsigned int cpu)
>
>  	if (!node_state(cpu_to_node(cpu), N_CPU)) {
>  		node_set_state(cpu_to_node(cpu), N_CPU);
> -		set_migration_target_nodes();
>  	}
>
>  	return 0;
> @@ -2085,7 +2083,6 @@ static int vmstat_cpu_dead(unsigned int cpu)
>  		return 0;
>
>  	node_clear_state(node, N_CPU);
> -	set_migration_target_nodes();
>
>  	return 0;
>  }
> @@ -2118,7 +2115,6 @@ void __init init_mm_internals(void)
>
>  	start_shepherd_timer();
>  #endif
> -	migrate_on_reclaim_init();
>  #ifdef CONFIG_PROC_FS
>  	proc_create_seq("buddyinfo", 0444, NULL, &fragmentation_op);
>  	proc_create_seq("pagetypeinfo", 0400, NULL, &pagetypeinfo_op);
