Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F029B53312E
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 21:02:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240899AbiEXTCv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 15:02:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55494 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240906AbiEXTCM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 15:02:12 -0400
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (mail-bn7nam10on2073.outbound.protection.outlook.com [40.107.92.73])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A57689CF5C
        for <linux-kernel@vger.kernel.org>; Tue, 24 May 2022 12:00:57 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=BebQLFHxUj8Z0HOfXe4EpD3laieQ5rjozcnE2DxyfMcBL8GF8b9BhA+86ngAXyNtd9DJSUQbbrTwht3gz6W6B2FZnKGhIlF4uswCH7PeG6wGWc9OapoUs4itXt0844Nr0JzJOi54jA5odoFQQw6ZGPpQLrgd7l+YDHEwHlTVrSAcQcbw9balV1OjcEJXgHeDBRg7c7FcvUFS6HYW+hUFJv1B6X/GCisN2T+z/60z4lCUtUlySfPMG8RM0f5g6PEJMYwv8pbI3McFwnu3sBPlyvEaYK1dtvRyvaUtrC/5ABvEAhETxqEGEWWC6xVhyM3W/9kHpUqExqL8ZK6uGPDxhg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=6eEueAzsgMlcR3ELGlZBVgioRqcu1E6bs70pGeD5QDk=;
 b=NvqTYokWmBCltr96YQSImwljhkUrmFjhY6FHSUgeHo8M+zMtEPUEz3NEVeZlNqAhiTLf4MmB2jWuG4GqA6XLA5tmgKrTsHPkicVpn/j1MyzUp1D/nQ7MRaRvEkorfYtvFmVDTLZc/zQ47bTLaWeVGgG+yB+AqPDRBZ451hh8TvYY+LbmRSr6WxDgtl8ZVEk5oea2n3LI+aGmOnvY5WOYhwqrFpTrkUENbQAkWyhjgqLk1PrKy+k1CrXdWs8zQ+/MjlstzcrJjhvD/Z7OSbNwgyU6Wdl/SOhSl1Ns/zqzsas+qU6hISohCFGKhnfKzuLrdXCNbRIITxQsnzeWQ+zBnw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=6eEueAzsgMlcR3ELGlZBVgioRqcu1E6bs70pGeD5QDk=;
 b=fMFSsYB3SNPPQoQDHH4QkDG6T9S5LE0VdFgjdUf2HzJvQT7OR8svDye4mhFDuV6p8+ejatJXplLyLDQ9WrRiNxwvkdVWM6b+IvD76QZJq1H/qYJIJpsDAOSFZv2Mpbis2Tr1uicy8e+cxDCep9UM8/sbj0/0VorsoaW6CFZeGgkVj2huFG7C3AwYvuzkFm7eEj3xV2OqLOaWKg2KG0omleKMAZHarDpshNDuTMmDudZwecZzeeyMmntfe8LIdW8FS5Db7rnWkISO0wjDUHtCStuuIK+S7dDlbcmqhX/7aVzE+xH9e59PSodMxyhdzMEPlm0W8xIvoxe4OrYJVrZx2Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 BY5PR12MB3652.namprd12.prod.outlook.com (2603:10b6:a03:1a7::28) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5273.19; Tue, 24 May
 2022 19:00:32 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::f993:a9a1:3730:a7a5%5]) with mapi id 15.20.5293.013; Tue, 24 May 2022
 19:00:32 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>, linux-mm@kvack.org,
        Qian Cai <quic_qiancai@quicinc.com>
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH v11 3/6] mm: make alloc_contig_range work at pageblock granularity
Date:   Tue, 24 May 2022 15:00:30 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <57952356-1590-4CE0-9DAE-ADF741D7F696@nvidia.com>
In-Reply-To: <23A7297E-6C84-4138-A9FE-3598234004E6@nvidia.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220425143118.2850746-4-zi.yan@sent.com>
 <23A7297E-6C84-4138-A9FE-3598234004E6@nvidia.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_93F4047A-7B49-43F9-AB3E-C6FD8D7D814E_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BLAPR03CA0053.namprd03.prod.outlook.com
 (2603:10b6:208:32d::28) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd7460fd-bad0-4b02-b16c-08da3db7ad82
X-MS-TrafficTypeDiagnostic: BY5PR12MB3652:EE_
X-Microsoft-Antispam-PRVS: <BY5PR12MB3652603952E1FD31089B24ACC2D79@BY5PR12MB3652.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 3mJUvm3Oi/oUv6REZwRYfCOUgSDYDRotFq1/Vp+6c/RJeRtrW2XWaxJwXJZNEKQ8lD3JXCyA6MKUYMaa4FdtKyXMuMqIoZz79glRLryyqZ50sa1HpZm1OBd25kNYtr0KCv8mRk9dwKnv/ztoQi5oE9+PQBQCwdM5gjx9FRw+6DtczJh2Y/e1NIZlOZm78kzoHEE+UcWytutAwQRiSzkd/mTyCcQlA0BP/aEEy2gRMk74Ln4L0cXpCCTNz0NzEew37/6e7SK3amUY9kz+Rm3tv3arQuQ//pnhjgkt/hSMDXxX0JoVB8UwTLWit1K0bUGfPbjn+s6b8MEKj6OHdOZzm5OyZ8a7yhSunairJkFCPT2LYsXABbitF9581y7Cq9XuSR4cNypJRRQU+z9L3RO1MZjxmUDdj85JBh4NbeNDB6T4cnxT8dy8bP96UBkGIHRsunB+aVFi1Qtc8p3bRf4bBqbmAOzmPdF4giobigJRdRL5k5aS6Qdo5i5TSOQjEhnIJiaP6gP9EPY7NXnl4mZdvwMP72X6twQfb5Mp7ff/ufAW/HaFK+FInFhpiFMUjIX4v+EW6GRyzTicLMJHXxcF/16BRl9SoH0Ex6faQG2TJThQSrjnUIy5DrDfbLJuk0JYFSkRh8G41DwUog8hfX6qzgMTQm53z9Yq4E19AiOZGxL+XeRQU5oKYTYMvqZXUijT+y9BUHmSTqK1e0/Q/dKSOndTvpB2bSHWxOocTbjZhX1WlJfKlXW9+7x7sY608Zl10yVEhZDG1BCNPko4fXryYQ6+rBt4GuyqSetJlQpVtEmawMxTyKRRgFMiIXhFUFdIMMISZCS8HlO+rfL0qYYYF0vGj659BaFm04YXD4VyuUOYI7mZ3K+rhPYk/8kHv5mN
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(2616005)(186003)(966005)(83380400001)(6486002)(508600001)(33656002)(6512007)(38100700002)(26005)(86362001)(8676002)(6506007)(53546011)(4326008)(66946007)(36756003)(66476007)(66556008)(2906002)(5660300002)(7416002)(54906003)(8936002)(235185007)(30864003)(316002)(110136005)(21480400003)(21314003)(72826004)(45980500001)(579004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?b/AqxjalV0Fp5OAa+6RvYxb7HJzUfyiGPTndOQnA2vgaDMqcHZwGJW96iBEr?=
 =?us-ascii?Q?tEhM6RFl+Jd3G3zaUqkBcpYEpgjtrcLWPGTQaBupQolCrw4GZRClHye/8jW5?=
 =?us-ascii?Q?iXu1RrZUaEoS2w2wOgMWQlSF5am/z4P2l/bVm7I6/jjpgd/YoshFaa+BRfHc?=
 =?us-ascii?Q?A1H6mpdP5AkzGJYvTh2zBI3IqtcHON4f8zqpgF1Ebuf9Uf27MRwSHJrqFMOI?=
 =?us-ascii?Q?tTzc4INMtUYHhcfhkcZBUg0QYUG6+VBMw9Rac+9jnmFGe7c3JABwoQ96XEjM?=
 =?us-ascii?Q?ZjE41QR3+jK9eBhA7ki1ZvrSCm/ZS52VKpMs/VSNQzFe3IqxW1KrWNZf0Wr/?=
 =?us-ascii?Q?S27B8nU4IYRK/YnetqC5NMGKkDFwv1dAHOmzftbbCb52AdOiBgfN4VbHN6MZ?=
 =?us-ascii?Q?YiX4TqZmh6M8moWE+HBIyxvpwqCJ+GhVp+VVvXi+ikpRapTpXf0ECjbtDWCn?=
 =?us-ascii?Q?4J52AT3ae7wmvk+XohKbXNEpJJxBP233k3Av9vwfd0BLfN6bfvDWcGzsWa/1?=
 =?us-ascii?Q?AtzJybud+3Cr1v3Xrh7KshHLENEdxIGe/FuoKU3ubvS5XcC29wKLHN4m/js3?=
 =?us-ascii?Q?U7YdtWzdUxq/I9Ia9+iK7VWsc+76ctoxyR5XKG/3jV70+Hub7itpbYbLs7M/?=
 =?us-ascii?Q?XOuVbBFzl8YV50I7jEnggcnJ1TpfBNDbYEx5nJtN4BJOslYJVJZfle49bbup?=
 =?us-ascii?Q?x7aO+T3KgVw6JAyXgTslZSX/u7Ic3j8V7OH2vqO4UXaxFSCkYwVerF/JDZ39?=
 =?us-ascii?Q?BFW4c6QJ06COptMKuJpeAI1USGyKsl6SOX+uzIDXgaoAr/pdsZfcSvuicspJ?=
 =?us-ascii?Q?/lArAcOGjOJ4IbXgUFTFNyJ1552QDUFAbgw+LRBt7aJtcAaqk7ckzEGr0KWg?=
 =?us-ascii?Q?OnjxiUX+ZG2eYJmyzv8dF1xbgtkNKGQwKs1ga+CVAl1VE06Fp2hpeZ8khF21?=
 =?us-ascii?Q?YLgADOn7Pm2kv6UbAJPnobfsoK7q4TfMqsqb58WVcZzYr50ZkAMApdjwcAXM?=
 =?us-ascii?Q?6bnAe2saKCRBi5Cc76/nNkKoPe/ghM7XhpFV9t+u/YtiPuch5V7ao/IXm0jL?=
 =?us-ascii?Q?VuZrCjX99Crpp1auATcyFtLtQ+rO4dKHz7UWjeQHb7/r3PaNAqAl71GJX/ze?=
 =?us-ascii?Q?wMEhNGDMrNsc4Najbgh6UH0cCeZr2XGf+TELmwIKiYKwHToekUCg4Fi86kDY?=
 =?us-ascii?Q?O0eNyiwZdIDlEn8AfO7CrTOhr+tjA7bDwV745DAGh0Q6trKKmZOzNP4Zj7lA?=
 =?us-ascii?Q?81z8AAd/BuDA3gG+rPlPDfOkrk/5nwsjlLMUa5CsCEHK2BT8v0RvNriDy+z1?=
 =?us-ascii?Q?EvbRb2xjsovrb15bftkQPls9caVmpE6ZqZ/VV29WP0353H8j9btMUriZkRJQ?=
 =?us-ascii?Q?nHwVdpz39Ie8o0RCz/iITVCjbLhV+8pCH3DBgOdqyh6l0csa2bwEuAfwYxEn?=
 =?us-ascii?Q?l35Xisu6XyXGQK81pUj9NsiWFxIuoIIqn82QNXDUi2kPc0GhglkzywtvoN7q?=
 =?us-ascii?Q?rsqVYDF7SLLX6QGHEhppXouBSg4x6Qtg6QMZXl+9IQR58j1x4YebTCwITyBo?=
 =?us-ascii?Q?axMs81eQrNtN+0wcog5GNSZOE0zUfcb8O55WU7tgmz1QiIe+oXzpXwrB4CXl?=
 =?us-ascii?Q?X9jvXK7pGmmgGXly3lPhsIdnWBfqwoIyb6CxJXWddZqVa6aP7/D8x8Pf1yBL?=
 =?us-ascii?Q?p4sbUaFmQksSS4tUb3MXLvnr3j7cplf7MJFFz8Ob8uT1Jh3Ytq0g5VqagTYZ?=
 =?us-ascii?Q?pBSCifuKkg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: dd7460fd-bad0-4b02-b16c-08da3db7ad82
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 24 May 2022 19:00:32.7554
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: AvxRuSinkdQ4F5xrYSGqWwthdhxJaPCdSatf66Ta80v9BFH8GyvNe1IG/+n7k8/m
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BY5PR12MB3652
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_93F4047A-7B49-43F9-AB3E-C6FD8D7D814E_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

>
> From fce466e89e50bcb0ebb56d7809db1b8bbea47628 Mon Sep 17 00:00:00 2001
> From: Zi Yan <ziy@nvidia.com>
> Date: Tue, 26 Apr 2022 23:00:33 -0400
> Subject: [PATCH] mm: make alloc_contig_range work at pageblock granular=
ity
>
> alloc_contig_range() worked at MAX_ORDER_NR_PAGES granularity to avoid
> merging pageblocks with different migratetypes.  It might unnecessarily=

> convert extra pageblocks at the beginning and at the end of the range.
> Change alloc_contig_range() to work at pageblock granularity.
>
> Special handling is needed for free pages and in-use pages across the
> boundaries of the range specified by alloc_contig_range().  Because the=
se
> partially isolated pages causes free page accounting issues.  The free
> pages will be split and freed into separate migratetype lists; the in-u=
se
> pages will be migrated then the freed pages will be handled in the
> aforementioned way.
>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/page-isolation.h |   4 +-
>  mm/internal.h                  |   6 +
>  mm/memory_hotplug.c            |   3 +-
>  mm/page_alloc.c                |  54 +++++++--
>  mm/page_isolation.c            | 193 ++++++++++++++++++++++++++++++++-=

>  5 files changed, 242 insertions(+), 18 deletions(-)
>
> diff --git a/include/linux/page-isolation.h b/include/linux/page-isolat=
ion.h
> index e14eddf6741a..5456b7be38ae 100644
> --- a/include/linux/page-isolation.h
> +++ b/include/linux/page-isolation.h
> @@ -42,7 +42,7 @@ int move_freepages_block(struct zone *zone, struct pa=
ge *page,
>   */
>  int
>  start_isolate_page_range(unsigned long start_pfn, unsigned long end_pf=
n,
> -			 unsigned migratetype, int flags);
> +			 int migratetype, int flags, gfp_t gfp_flags);
>
>  /*
>   * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
> @@ -50,7 +50,7 @@ start_isolate_page_range(unsigned long start_pfn, uns=
igned long end_pfn,
>   */
>  void
>  undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn=
,
> -			unsigned migratetype);
> +			int migratetype);
>
>  /*
>   * Test all pages in [start_pfn, end_pfn) are isolated or not.
> diff --git a/mm/internal.h b/mm/internal.h
> index 919fa07e1031..0667abd57634 100644
> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -359,6 +359,9 @@ extern void *memmap_alloc(phys_addr_t size, phys_ad=
dr_t align,
>  			  phys_addr_t min_addr,
>  			  int nid, bool exact_nid);
>
> +void split_free_page(struct page *free_page,
> +				int order, unsigned long split_pfn_offset);
> +
>  #if defined CONFIG_COMPACTION || defined CONFIG_CMA
>
>  /*
> @@ -422,6 +425,9 @@ isolate_freepages_range(struct compact_control *cc,=

>  int
>  isolate_migratepages_range(struct compact_control *cc,
>  			   unsigned long low_pfn, unsigned long end_pfn);
> +
> +int __alloc_contig_migrate_range(struct compact_control *cc,
> +					unsigned long start, unsigned long end);
>  #endif
>  int find_suitable_fallback(struct free_area *area, unsigned int order,=

>  			int migratetype, bool only_stealable, bool *can_steal);
> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
> index 4c6065e5d274..9f8ae4cb77ee 100644
> --- a/mm/memory_hotplug.c
> +++ b/mm/memory_hotplug.c
> @@ -1845,7 +1845,8 @@ int __ref offline_pages(unsigned long start_pfn, =
unsigned long nr_pages,
>  	/* set above range as isolated */
>  	ret =3D start_isolate_page_range(start_pfn, end_pfn,
>  				       MIGRATE_MOVABLE,
> -				       MEMORY_OFFLINE | REPORT_FAILURE);
> +				       MEMORY_OFFLINE | REPORT_FAILURE,
> +				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
>  	if (ret) {
>  		reason =3D "failure to isolate range";
>  		goto failed_removal_pcplists_disabled;
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 93dbe05a6029..6a0d1746c095 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1094,6 +1094,43 @@ static inline void __free_one_page(struct page *=
page,
>  		page_reporting_notify_free(order);
>  }
>
> +/**
> + * split_free_page() -- split a free page at split_pfn_offset
> + * @free_page:		the original free page
> + * @order:		the order of the page
> + * @split_pfn_offset:	split offset within the page
> + *
> + * It is used when the free page crosses two pageblocks with different=
 migratetypes
> + * at split_pfn_offset within the page. The split free page will be pu=
t into
> + * separate migratetype lists afterwards. Otherwise, the function achi=
eves
> + * nothing.
> + */
> +void split_free_page(struct page *free_page,
> +				int order, unsigned long split_pfn_offset)
> +{
> +	struct zone *zone =3D page_zone(free_page);
> +	unsigned long free_page_pfn =3D page_to_pfn(free_page);
> +	unsigned long pfn;
> +	unsigned long flags;
> +	int free_page_order;
> +
> +	spin_lock_irqsave(&zone->lock, flags);
> +	del_page_from_free_list(free_page, zone, order);
> +	for (pfn =3D free_page_pfn;
> +	     pfn < free_page_pfn + (1UL << order);) {
> +		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
> +
> +		free_page_order =3D ffs(split_pfn_offset) - 1;
> +		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
> +				mt, FPI_NONE);
> +		pfn +=3D 1UL << free_page_order;
> +		split_pfn_offset -=3D (1UL << free_page_order);
> +		/* we have done the first part, now switch to second part */
> +		if (split_pfn_offset =3D=3D 0)
> +			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
> +	}
> +	spin_unlock_irqrestore(&zone->lock, flags);
> +}
>  /*
>   * A bad page could be due to a number of fields. Instead of multiple =
branches,
>   * try and check multiple fields with one check. The caller must do a =
detailed
> @@ -8919,7 +8956,7 @@ static inline void alloc_contig_dump_pages(struct=
 list_head *page_list)
>  #endif
>
>  /* [start, end) must belong to a single zone. */
> -static int __alloc_contig_migrate_range(struct compact_control *cc,
> +int __alloc_contig_migrate_range(struct compact_control *cc,
>  					unsigned long start, unsigned long end)
>  {
>  	/* This function is based on compact_zone() from compaction.c. */
> @@ -9002,7 +9039,7 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
>  		       unsigned migratetype, gfp_t gfp_mask)
>  {
>  	unsigned long outer_start, outer_end;
> -	unsigned int order;
> +	int order;
>  	int ret =3D 0;
>
>  	struct compact_control cc =3D {
> @@ -9021,14 +9058,11 @@ int alloc_contig_range(unsigned long start, uns=
igned long end,
>  	 * What we do here is we mark all pageblocks in range as
>  	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
>  	 * have different sizes, and due to the way page allocator
> -	 * work, we align the range to biggest of the two pages so
> -	 * that page allocator won't try to merge buddies from
> -	 * different pageblocks and change MIGRATE_ISOLATE to some
> -	 * other migration type.
> +	 * work, start_isolate_page_range() has special handlings for this.
>  	 *
>  	 * Once the pageblocks are marked as MIGRATE_ISOLATE, we
>  	 * migrate the pages from an unaligned range (ie. pages that
> -	 * we are interested in).  This will put all the pages in
> +	 * we are interested in). This will put all the pages in
>  	 * range back to page allocator as MIGRATE_ISOLATE.
>  	 *
>  	 * When this is done, we take the pages in range from page
> @@ -9042,9 +9076,9 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
>  	 */
>
>  	ret =3D start_isolate_page_range(pfn_max_align_down(start),
> -				       pfn_max_align_up(end), migratetype, 0);
> +				pfn_max_align_up(end), migratetype, 0, gfp_mask);
>  	if (ret)
> -		return ret;
> +		goto done;
>
>  	drain_all_pages(cc.zone);
>
> @@ -9064,7 +9098,7 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
>  	ret =3D 0;
>
>  	/*
> -	 * Pages from [start, end) are within a MAX_ORDER_NR_PAGES
> +	 * Pages from [start, end) are within a pageblock_nr_pages
>  	 * aligned blocks that are marked as MIGRATE_ISOLATE.  What's
>  	 * more, all pages in [start, end) are free in page allocator.
>  	 * What we are going to do is to allocate all pages from
> diff --git a/mm/page_isolation.c b/mm/page_isolation.c
> index c2f7a8bb634d..8a0f16d2e4c3 100644
> --- a/mm/page_isolation.c
> +++ b/mm/page_isolation.c
> @@ -203,7 +203,7 @@ static int set_migratetype_isolate(struct page *pag=
e, int migratetype, int isol_
>  	return -EBUSY;
>  }
>
> -static void unset_migratetype_isolate(struct page *page, unsigned migr=
atetype)
> +static void unset_migratetype_isolate(struct page *page, int migratety=
pe)
>  {
>  	struct zone *zone;
>  	unsigned long flags, nr_pages;
> @@ -279,6 +279,166 @@ __first_valid_page(unsigned long pfn, unsigned lo=
ng nr_pages)
>  	return NULL;
>  }
>
> +/**
> + * isolate_single_pageblock() -- tries to isolate a pageblock that mig=
ht be
> + * within a free or in-use page.
> + * @boundary_pfn:		pageblock-aligned pfn that a page might cross
> + * @gfp_flags:			GFP flags used for migrating pages
> + * @isolate_before:	isolate the pageblock before the boundary_pfn
> + *
> + * Free and in-use pages can be as big as MAX_ORDER-1 and contain more=
 than one
> + * pageblock. When not all pageblocks within a page are isolated at th=
e same
> + * time, free page accounting can go wrong. For example, in the case o=
f
> + * MAX_ORDER-1 =3D pageblock_order + 1, a MAX_ORDER-1 page has two pag=
elbocks.
> + * [         MAX_ORDER-1         ]
> + * [  pageblock0  |  pageblock1  ]
> + * When either pageblock is isolated, if it is a free page, the page i=
s not
> + * split into separate migratetype lists, which is supposed to; if it =
is an
> + * in-use page and freed later, __free_one_page() does not split the f=
ree page
> + * either. The function handles this by splitting the free page or mig=
rating
> + * the in-use page then splitting the free page.
> + */
> +static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t =
gfp_flags,
> +			bool isolate_before)
> +{
> +	unsigned char saved_mt;
> +	unsigned long start_pfn;
> +	unsigned long isolate_pageblock;
> +	unsigned long pfn;
> +	struct zone *zone;
> +
> +	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));
> +
> +	if (isolate_before)
> +		isolate_pageblock =3D boundary_pfn - pageblock_nr_pages;
> +	else
> +		isolate_pageblock =3D boundary_pfn;
> +
> +	/*
> +	 * scan at the beginning of MAX_ORDER_NR_PAGES aligned range to avoid=

> +	 * only isolating a subset of pageblocks from a bigger than pageblock=

> +	 * free or in-use page. Also make sure all to-be-isolated pageblocks
> +	 * are within the same zone.
> +	 */
> +	zone  =3D page_zone(pfn_to_page(isolate_pageblock));
> +	start_pfn  =3D max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),=

> +				      zone->zone_start_pfn);
> +
> +	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pageblock)=
);
> +	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), MIGRATE_ISO=
LATE);
> +
> +	/*
> +	 * Bail out early when the to-be-isolated pageblock does not form
> +	 * a free or in-use page across boundary_pfn:
> +	 *
> +	 * 1. isolate before boundary_pfn: the page after is not online
> +	 * 2. isolate after boundary_pfn: the page before is not online
> +	 *
> +	 * This also ensures correctness. Without it, when isolate after
> +	 * boundary_pfn and [start_pfn, boundary_pfn) are not online,
> +	 * __first_valid_page() will return unexpected NULL in the for loop
> +	 * below.
> +	 */
> +	if (isolate_before) {
> +		if (!pfn_to_online_page(boundary_pfn))
> +			return 0;
> +	} else {
> +		if (!pfn_to_online_page(boundary_pfn - 1))
> +			return 0;
> +	}
> +
> +	for (pfn =3D start_pfn; pfn < boundary_pfn;) {
> +		struct page *page =3D __first_valid_page(pfn, boundary_pfn - pfn);
> +
> +		VM_BUG_ON(!page);
> +		pfn =3D page_to_pfn(page);
> +		/*
> +		 * start_pfn is MAX_ORDER_NR_PAGES aligned, if there is any
> +		 * free pages in [start_pfn, boundary_pfn), its head page will
> +		 * always be in the range.
> +		 */
> +		if (PageBuddy(page)) {
> +			int order =3D buddy_order(page);
> +
> +			if (pfn + (1UL << order) > boundary_pfn)
> +				split_free_page(page, order, boundary_pfn - pfn);
> +			pfn +=3D (1UL << order);
> +			continue;
> +		}
> +		/*
> +		 * migrate compound pages then let the free page handling code
> +		 * above do the rest. If migration is not possible, just fail.
> +		 */
> +		if (PageCompound(page)) {
> +			unsigned long nr_pages =3D compound_nr(page);
> +			struct page *head =3D compound_head(page);
> +			unsigned long head_pfn =3D page_to_pfn(head);
> +
> +			if (head_pfn + nr_pages < boundary_pfn) {
> +				pfn =3D head_pfn + nr_pages;
> +				continue;
> +			}
> +#if defined CONFIG_COMPACTION || defined CONFIG_CMA
> +			/*
> +			 * hugetlb, lru compound (THP), and movable compound pages
> +			 * can be migrated. Otherwise, fail the isolation.
> +			 */
> +			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
> +				int order;
> +				unsigned long outer_pfn;
> +				int ret;
> +				struct compact_control cc =3D {
> +					.nr_migratepages =3D 0,
> +					.order =3D -1,
> +					.zone =3D page_zone(pfn_to_page(head_pfn)),
> +					.mode =3D MIGRATE_SYNC,
> +					.ignore_skip_hint =3D true,
> +					.no_set_skip_hint =3D true,
> +					.gfp_mask =3D gfp_flags,
> +					.alloc_contig =3D true,
> +				};
> +				INIT_LIST_HEAD(&cc.migratepages);
> +
> +				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
> +							head_pfn + nr_pages);
> +
> +				if (ret)
> +					goto failed;
> +				/*
> +				 * reset pfn to the head of the free page, so
> +				 * that the free page handling code above can split
> +				 * the free page to the right migratetype list.
> +				 *
> +				 * head_pfn is not used here as a hugetlb page order
> +				 * can be bigger than MAX_ORDER-1, but after it is
> +				 * freed, the free page order is not. Use pfn within
> +				 * the range to find the head of the free page.
> +				 */
> +				order =3D 0;
> +				outer_pfn =3D pfn;
> +				while (!PageBuddy(pfn_to_page(outer_pfn))) {
> +					if (++order >=3D MAX_ORDER) {
> +						outer_pfn =3D pfn;
> +						break;
> +					}
> +					outer_pfn &=3D ~0UL << order;
> +				}
> +				pfn =3D outer_pfn;
> +				continue;
> +			} else
> +#endif
> +				goto failed;
> +		}
> +
> +		pfn++;
> +	}
> +	return 0;
> +failed:
> +	/* restore the original migratetype */
> +	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), saved_mt);
> +	return -EBUSY;
> +}
> +
>  /**
>   * start_isolate_page_range() - make page-allocation-type of range of =
pages to
>   * be MIGRATE_ISOLATE.
> @@ -293,6 +453,8 @@ __first_valid_page(unsigned long pfn, unsigned long=
 nr_pages)
>   *					 and PageOffline() pages.
>   *			REPORT_FAILURE - report details about the failure to
>   *			isolate the range
> + * @gfp_flags:		GFP flags used for migrating pages that sit across the=

> + *			range boundaries.
>   *
>   * Making page-allocation-type to be MIGRATE_ISOLATE means free pages =
in
>   * the range will never be allocated. Any free pages and pages freed i=
n the
> @@ -301,6 +463,10 @@ __first_valid_page(unsigned long pfn, unsigned lon=
g nr_pages)
>   * pages in the range finally, the caller have to free all pages in th=
e range.
>   * test_page_isolated() can be used for test it.
>   *
> + * The function first tries to isolate the pageblocks at the beginning=
 and end
> + * of the range, since there might be pages across the range boundarie=
s.
> + * Afterwards, it isolates the rest of the range.
> + *
>   * There is no high level synchronization mechanism that prevents two =
threads
>   * from trying to isolate overlapping ranges. If this happens, one thr=
ead
>   * will notice pageblocks in the overlapping range already set to isol=
ate.
> @@ -321,21 +487,38 @@ __first_valid_page(unsigned long pfn, unsigned lo=
ng nr_pages)
>   * Return: 0 on success and -EBUSY if any part of range cannot be isol=
ated.
>   */
>  int start_isolate_page_range(unsigned long start_pfn, unsigned long en=
d_pfn,
> -			     unsigned migratetype, int flags)
> +			     int migratetype, int flags, gfp_t gfp_flags)
>  {
>  	unsigned long pfn;
>  	struct page *page;
> +	int ret;
>
>  	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
>  	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));
>
> -	for (pfn =3D start_pfn;
> -	     pfn < end_pfn;
> +	/* isolate [start_pfn, start_pfn + pageblock_nr_pages) pageblock */
> +	ret =3D isolate_single_pageblock(start_pfn, gfp_flags, false);
> +	if (ret)
> +		return ret;
> +
> +	/* isolate [end_pfn - pageblock_nr_pages, end_pfn) pageblock */
> +	ret =3D isolate_single_pageblock(end_pfn, gfp_flags, true);
> +	if (ret) {
> +		unset_migratetype_isolate(pfn_to_page(start_pfn), migratetype);
> +		return ret;
> +	}
> +
> +	/* skip isolated pageblocks at the beginning and end */
> +	for (pfn =3D start_pfn + pageblock_nr_pages;
> +	     pfn < end_pfn - pageblock_nr_pages;
>  	     pfn +=3D pageblock_nr_pages) {
>  		page =3D __first_valid_page(pfn, pageblock_nr_pages);
>  		if (page && set_migratetype_isolate(page, migratetype, flags,
>  					start_pfn, end_pfn)) {
>  			undo_isolate_page_range(start_pfn, pfn, migratetype);
> +			unset_migratetype_isolate(
> +				pfn_to_page(end_pfn - pageblock_nr_pages),
> +				migratetype);
>  			return -EBUSY;
>  		}
>  	}
> @@ -346,7 +529,7 @@ int start_isolate_page_range(unsigned long start_pf=
n, unsigned long end_pfn,
>   * Make isolated pages available again.
>   */
>  void undo_isolate_page_range(unsigned long start_pfn, unsigned long en=
d_pfn,
> -			    unsigned migratetype)
> +			    int migratetype)
>  {
>  	unsigned long pfn;
>  	struct page *page;
> -- =

> 2.35.1
>
> --
> Best Regards,
> Yan, Zi

To address the infinite loop issue reported by Qian Cai, the follow fixup=
 should be applied to the commit above, another fixup patch should be app=
lied to Patch 4 in this series (I will reply to Patch 4 email) :


diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0c7252ed14a0..76551933bb1d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1114,13 +1114,16 @@ void split_free_page(struct page *free_page,
 	unsigned long flags;
 	int free_page_order;

+	if (split_pfn_offset =3D=3D 0)
+		return;
+
 	spin_lock_irqsave(&zone->lock, flags);
 	del_page_from_free_list(free_page, zone, order);
 	for (pfn =3D free_page_pfn;
 	     pfn < free_page_pfn + (1UL << order);) {
 		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);

-		free_page_order =3D ffs(split_pfn_offset) - 1;
+		free_page_order =3D min(pfn ? __ffs(pfn) : order, __fls(split_pfn_offs=
et));
 		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
 				mt, FPI_NONE);
 		pfn +=3D 1UL << free_page_order;
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 8a0f16d2e4c3..7e45736d6451 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -283,6 +283,7 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
  * isolate_single_pageblock() -- tries to isolate a pageblock that might=
 be
  * within a free or in-use page.
  * @boundary_pfn:		pageblock-aligned pfn that a page might cross
+ * @flags:			isolation flags
  * @gfp_flags:			GFP flags used for migrating pages
  * @isolate_before:	isolate the pageblock before the boundary_pfn
  *
@@ -298,14 +299,15 @@ __first_valid_page(unsigned long pfn, unsigned long=
 nr_pages)
  * either. The function handles this by splitting the free page or migra=
ting
  * the in-use page then splitting the free page.
  */
-static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gf=
p_flags,
-			bool isolate_before)
+static int isolate_single_pageblock(unsigned long boundary_pfn, int flag=
s,
+			gfp_t gfp_flags, bool isolate_before)
 {
 	unsigned char saved_mt;
 	unsigned long start_pfn;
 	unsigned long isolate_pageblock;
 	unsigned long pfn;
 	struct zone *zone;
+	int ret;

 	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));

@@ -325,7 +327,11 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, gfp_t gfp_flags,
 				      zone->zone_start_pfn);

 	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pageblock));=

-	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), MIGRATE_ISOLA=
TE);
+	ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_m=
t, flags,
+			isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
+
+	if (ret)
+		return ret;

 	/*
 	 * Bail out early when the to-be-isolated pageblock does not form
@@ -374,7 +380,7 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, gfp_t gfp_flags,
 			struct page *head =3D compound_head(page);
 			unsigned long head_pfn =3D page_to_pfn(head);

-			if (head_pfn + nr_pages < boundary_pfn) {
+			if (head_pfn + nr_pages <=3D boundary_pfn) {
 				pfn =3D head_pfn + nr_pages;
 				continue;
 			}
@@ -386,7 +392,8 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, gfp_t gfp_flags,
 			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
 				int order;
 				unsigned long outer_pfn;
-				int ret;
+				int page_mt =3D get_pageblock_migratetype(page);
+				bool isolate_page =3D !is_migrate_isolate_page(page);
 				struct compact_control cc =3D {
 					.nr_migratepages =3D 0,
 					.order =3D -1,
@@ -399,9 +406,31 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, gfp_t gfp_flags,
 				};
 				INIT_LIST_HEAD(&cc.migratepages);

+				/*
+				 * XXX: mark the page as MIGRATE_ISOLATE so that
+				 * no one else can grab the freed page after migration.
+				 * Ideally, the page should be freed as two separate
+				 * pages to be added into separate migratetype free
+				 * lists.
+				 */
+				if (isolate_page) {
+					ret =3D set_migratetype_isolate(page, page_mt,
+						flags, head_pfn, head_pfn + nr_pages);
+					if (ret)
+						goto failed;
+				}
+
 				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
 							head_pfn + nr_pages);

+				/*
+				 * restore the page's migratetype so that it can
+				 * be split into separate migratetype free lists
+				 * later.
+				 */
+				if (isolate_page)
+					unset_migratetype_isolate(page, page_mt);
+
 				if (ret)
 					goto failed;
 				/*
@@ -417,10 +446,9 @@ static int isolate_single_pageblock(unsigned long bo=
undary_pfn, gfp_t gfp_flags,
 				order =3D 0;
 				outer_pfn =3D pfn;
 				while (!PageBuddy(pfn_to_page(outer_pfn))) {
-					if (++order >=3D MAX_ORDER) {
-						outer_pfn =3D pfn;
-						break;
-					}
+					/* stop if we cannot find the free page */
+					if (++order >=3D MAX_ORDER)
+						goto failed;
 					outer_pfn &=3D ~0UL << order;
 				}
 				pfn =3D outer_pfn;
@@ -435,7 +463,7 @@ static int isolate_single_pageblock(unsigned long bou=
ndary_pfn, gfp_t gfp_flags,
 	return 0;
 failed:
 	/* restore the original migratetype */
-	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), saved_mt);
+	unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
 	return -EBUSY;
 }

@@ -497,12 +525,12 @@ int start_isolate_page_range(unsigned long start_pf=
n, unsigned long end_pfn,
 	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));

 	/* isolate [start_pfn, start_pfn + pageblock_nr_pages) pageblock */
-	ret =3D isolate_single_pageblock(start_pfn, gfp_flags, false);
+	ret =3D isolate_single_pageblock(start_pfn, flags, gfp_flags, false);
 	if (ret)
 		return ret;

 	/* isolate [end_pfn - pageblock_nr_pages, end_pfn) pageblock */
-	ret =3D isolate_single_pageblock(end_pfn, gfp_flags, true);
+	ret =3D isolate_single_pageblock(end_pfn, flags, gfp_flags, true);
 	if (ret) {
 		unset_migratetype_isolate(pfn_to_page(start_pfn), migratetype);
 		return ret;



The complete commit with the fixup patch applied is:

=46rom 71a4c830ce96d23aacb11ec715cc27d482acdd93 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Thu, 12 May 2022 20:22:58 -0700
Subject: [PATCH] mm: make alloc_contig_range work at pageblock granularit=
y

alloc_contig_range() worked at MAX_ORDER_NR_PAGES granularity to avoid
merging pageblocks with different migratetypes.  It might unnecessarily
convert extra pageblocks at the beginning and at the end of the range.
Change alloc_contig_range() to work at pageblock granularity.

Special handling is needed for free pages and in-use pages across the
boundaries of the range specified by alloc_contig_range().  Because these=
=3D

Partially isolated pages causes free page accounting issues.  The free
pages will be split and freed into separate migratetype lists; the in-use=
=3D

Pages will be migrated then the freed pages will be handled in the
aforementioned way.

[ziy@nvidia.com: fix deadlock/crash]
  Link: https://lkml.kernel.org/r/23A7297E-6C84-4138-A9FE-3598234004E6@nv=
idia.com
Link: https://lkml.kernel.org/r/20220425143118.2850746-4-zi.yan@sent.com
Signed-off-by: Zi Yan <ziy@nvidia.com>
Reported-by: kernel test robot <lkp@intel.com>
Cc: Christophe Leroy <christophe.leroy@csgroup.eu>
Cc: David Hildenbrand <david@redhat.com>
Cc: Eric Ren <renzhengeek@gmail.com>
Cc: Mel Gorman <mgorman@techsingularity.net>
Cc: Mike Rapoport <rppt@linux.ibm.com>
Cc: Minchan Kim <minchan@kernel.org>
Cc: Oscar Salvador <osalvador@suse.de>
Cc: Vlastimil Babka <vbabka@suse.cz>
Signed-off-by: Andrew Morton <akpm@linux-foundation.org>
---
 include/linux/page-isolation.h |   4 +-
 mm/internal.h                  |   6 +
 mm/memory_hotplug.c            |   3 +-
 mm/page_alloc.c                |  57 +++++++--
 mm/page_isolation.c            | 221 ++++++++++++++++++++++++++++++++-
 5 files changed, 273 insertions(+), 18 deletions(-)

diff --git a/include/linux/page-isolation.h b/include/linux/page-isolatio=
n.h
index e14eddf6741a..5456b7be38ae 100644
--- a/include/linux/page-isolation.h
+++ b/include/linux/page-isolation.h
@@ -42,7 +42,7 @@ int move_freepages_block(struct zone *zone, struct page=
 *page,
  */
 int
 start_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,=

-			 unsigned migratetype, int flags);
+			 int migratetype, int flags, gfp_t gfp_flags);

 /*
  * Changes MIGRATE_ISOLATE to MIGRATE_MOVABLE.
@@ -50,7 +50,7 @@ start_isolate_page_range(unsigned long start_pfn, unsig=
ned long end_pfn,
  */
 void
 undo_isolate_page_range(unsigned long start_pfn, unsigned long end_pfn,
-			unsigned migratetype);
+			int migratetype);

 /*
  * Test all pages in [start_pfn, end_pfn) are isolated or not.
diff --git a/mm/internal.h b/mm/internal.h
index ddd09245a6db..a770029beb08 100644
--- a/mm/internal.h
+++ b/mm/internal.h
@@ -359,6 +359,9 @@ extern void *memmap_alloc(phys_addr_t size, phys_addr=
_t align,
 			  phys_addr_t min_addr,
 			  int nid, bool exact_nid);

+void split_free_page(struct page *free_page,
+				int order, unsigned long split_pfn_offset);
+
 #if defined CONFIG_COMPACTION || defined CONFIG_CMA

 /*
@@ -422,6 +425,9 @@ isolate_freepages_range(struct compact_control *cc,
 int
 isolate_migratepages_range(struct compact_control *cc,
 			   unsigned long low_pfn, unsigned long end_pfn);
+
+int __alloc_contig_migrate_range(struct compact_control *cc,
+					unsigned long start, unsigned long end);
 #endif
 int find_suitable_fallback(struct free_area *area, unsigned int order,
 			int migratetype, bool only_stealable, bool *can_steal);
diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
index e99fd60548f5..945191708ef6 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1837,7 +1837,8 @@ int __ref offline_pages(unsigned long start_pfn, un=
signed long nr_pages,
 	/* set above range as isolated */
 	ret =3D start_isolate_page_range(start_pfn, end_pfn,
 				       MIGRATE_MOVABLE,
-				       MEMORY_OFFLINE | REPORT_FAILURE);
+				       MEMORY_OFFLINE | REPORT_FAILURE,
+				       GFP_USER | __GFP_MOVABLE | __GFP_RETRY_MAYFAIL);
 	if (ret) {
 		reason =3D "failure to isolate range";
 		goto failed_removal_pcplists_disabled;
diff --git a/mm/page_alloc.c b/mm/page_alloc.c
index 0756f046b644..76551933bb1d 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1094,6 +1094,46 @@ static inline void __free_one_page(struct page *pa=
ge,
 		page_reporting_notify_free(order);
 }

+/**
+ * split_free_page() -- split a free page at split_pfn_offset
+ * @free_page:		the original free page
+ * @order:		the order of the page
+ * @split_pfn_offset:	split offset within the page
+ *
+ * It is used when the free page crosses two pageblocks with different m=
igratetypes
+ * at split_pfn_offset within the page. The split free page will be put =
into
+ * separate migratetype lists afterwards. Otherwise, the function achiev=
es
+ * nothing.
+ */
+void split_free_page(struct page *free_page,
+				int order, unsigned long split_pfn_offset)
+{
+	struct zone *zone =3D page_zone(free_page);
+	unsigned long free_page_pfn =3D page_to_pfn(free_page);
+	unsigned long pfn;
+	unsigned long flags;
+	int free_page_order;
+
+	if (split_pfn_offset =3D=3D 0)
+		return;
+
+	spin_lock_irqsave(&zone->lock, flags);
+	del_page_from_free_list(free_page, zone, order);
+	for (pfn =3D free_page_pfn;
+	     pfn < free_page_pfn + (1UL << order);) {
+		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
+
+		free_page_order =3D min(pfn ? __ffs(pfn) : order, __fls(split_pfn_offs=
et));
+		__free_one_page(pfn_to_page(pfn), pfn, zone, free_page_order,
+				mt, FPI_NONE);
+		pfn +=3D 1UL << free_page_order;
+		split_pfn_offset -=3D (1UL << free_page_order);
+		/* we have done the first part, now switch to second part */
+		if (split_pfn_offset =3D=3D 0)
+			split_pfn_offset =3D (1UL << order) - (pfn - free_page_pfn);
+	}
+	spin_unlock_irqrestore(&zone->lock, flags);
+}
 /*
  * A bad page could be due to a number of fields. Instead of multiple br=
anches,
  * try and check multiple fields with one check. The caller must do a de=
tailed
@@ -8951,7 +8991,7 @@ static inline void alloc_contig_dump_pages(struct l=
ist_head *page_list)
 #endif

 /* [start, end) must belong to a single zone. */
-static int __alloc_contig_migrate_range(struct compact_control *cc,
+int __alloc_contig_migrate_range(struct compact_control *cc,
 					unsigned long start, unsigned long end)
 {
 	/* This function is based on compact_zone() from compaction.c. */
@@ -9034,7 +9074,7 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
-	unsigned int order;
+	int order;
 	int ret =3D 0;

 	struct compact_control cc =3D {
@@ -9053,14 +9093,11 @@ int alloc_contig_range(unsigned long start, unsig=
ned long end,
 	 * What we do here is we mark all pageblocks in range as
 	 * MIGRATE_ISOLATE.  Because pageblock and max order pages may
 	 * have different sizes, and due to the way page allocator
-	 * work, we align the range to biggest of the two pages so
-	 * that page allocator won't try to merge buddies from
-	 * different pageblocks and change MIGRATE_ISOLATE to some
-	 * other migration type.
+	 * work, start_isolate_page_range() has special handlings for this.
 	 *
 	 * Once the pageblocks are marked as MIGRATE_ISOLATE, we
 	 * migrate the pages from an unaligned range (ie. pages that
-	 * we are interested in).  This will put all the pages in
+	 * we are interested in). This will put all the pages in
 	 * range back to page allocator as MIGRATE_ISOLATE.
 	 *
 	 * When this is done, we take the pages in range from page
@@ -9074,9 +9111,9 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 	 */

 	ret =3D start_isolate_page_range(pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype, 0);
+				pfn_max_align_up(end), migratetype, 0, gfp_mask);
 	if (ret)
-		return ret;
+		goto done;

 	drain_all_pages(cc.zone);

@@ -9096,7 +9133,7 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 	ret =3D 0;

 	/*
-	 * Pages from [start, end) are within a MAX_ORDER_NR_PAGES
+	 * Pages from [start, end) are within a pageblock_nr_pages
 	 * aligned blocks that are marked as MIGRATE_ISOLATE.  What's
 	 * more, all pages in [start, end) are free in page allocator.
 	 * What we are going to do is to allocate all pages from
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c2f7a8bb634d..6b47acaf51f3 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -203,7 +203,7 @@ static int set_migratetype_isolate(struct page *page,=
 int migratetype, int isol_
 	return -EBUSY;
 }

-static void unset_migratetype_isolate(struct page *page, unsigned migrat=
etype)
+static void unset_migratetype_isolate(struct page *page, int migratetype=
)
 {
 	struct zone *zone;
 	unsigned long flags, nr_pages;
@@ -279,6 +279,194 @@ __first_valid_page(unsigned long pfn, unsigned long=
 nr_pages)
 	return NULL;
 }

+/**
+ * isolate_single_pageblock() -- tries to isolate a pageblock that might=
 be
+ * within a free or in-use page.
+ * @boundary_pfn:		pageblock-aligned pfn that a page might cross
+ * @flags:			isolation flags
+ * @gfp_flags:			GFP flags used for migrating pages
+ * @isolate_before:	isolate the pageblock before the boundary_pfn
+ *
+ * Free and in-use pages can be as big as MAX_ORDER-1 and contain more t=
han one
+ * pageblock. When not all pageblocks within a page are isolated at the =
same
+ * time, free page accounting can go wrong. For example, in the case of
+ * MAX_ORDER-1 =3D pageblock_order + 1, a MAX_ORDER-1 page has two pagel=
bocks.
+ * [         MAX_ORDER-1         ]
+ * [  pageblock0  |  pageblock1  ]
+ * When either pageblock is isolated, if it is a free page, the page is =
not
+ * split into separate migratetype lists, which is supposed to; if it is=
 an
+ * in-use page and freed later, __free_one_page() does not split the fre=
e page
+ * either. The function handles this by splitting the free page or migra=
ting
+ * the in-use page then splitting the free page.
+ */
+static int isolate_single_pageblock(unsigned long boundary_pfn, int flag=
s,
+			gfp_t gfp_flags, bool isolate_before)
+{
+	unsigned char saved_mt;
+	unsigned long start_pfn;
+	unsigned long isolate_pageblock;
+	unsigned long pfn;
+	struct zone *zone;
+	int ret;
+
+	VM_BUG_ON(!IS_ALIGNED(boundary_pfn, pageblock_nr_pages));
+
+	if (isolate_before)
+		isolate_pageblock =3D boundary_pfn - pageblock_nr_pages;
+	else
+		isolate_pageblock =3D boundary_pfn;
+
+	/*
+	 * scan at the beginning of MAX_ORDER_NR_PAGES aligned range to avoid
+	 * only isolating a subset of pageblocks from a bigger than pageblock
+	 * free or in-use page. Also make sure all to-be-isolated pageblocks
+	 * are within the same zone.
+	 */
+	zone  =3D page_zone(pfn_to_page(isolate_pageblock));
+	start_pfn  =3D max(ALIGN_DOWN(isolate_pageblock, MAX_ORDER_NR_PAGES),
+				      zone->zone_start_pfn);
+
+	saved_mt =3D get_pageblock_migratetype(pfn_to_page(isolate_pageblock));=

+	ret =3D set_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_m=
t, flags,
+			isolate_pageblock, isolate_pageblock + pageblock_nr_pages);
+
+	if (ret)
+		return ret;
+
+	/*
+	 * Bail out early when the to-be-isolated pageblock does not form
+	 * a free or in-use page across boundary_pfn:
+	 *
+	 * 1. isolate before boundary_pfn: the page after is not online
+	 * 2. isolate after boundary_pfn: the page before is not online
+	 *
+	 * This also ensures correctness. Without it, when isolate after
+	 * boundary_pfn and [start_pfn, boundary_pfn) are not online,
+	 * __first_valid_page() will return unexpected NULL in the for loop
+	 * below.
+	 */
+	if (isolate_before) {
+		if (!pfn_to_online_page(boundary_pfn))
+			return 0;
+	} else {
+		if (!pfn_to_online_page(boundary_pfn - 1))
+			return 0;
+	}
+
+	for (pfn =3D start_pfn; pfn < boundary_pfn;) {
+		struct page *page =3D __first_valid_page(pfn, boundary_pfn - pfn);
+
+		VM_BUG_ON(!page);
+		pfn =3D page_to_pfn(page);
+		/*
+		 * start_pfn is MAX_ORDER_NR_PAGES aligned, if there is any
+		 * free pages in [start_pfn, boundary_pfn), its head page will
+		 * always be in the range.
+		 */
+		if (PageBuddy(page)) {
+			int order =3D buddy_order(page);
+
+			if (pfn + (1UL << order) > boundary_pfn)
+				split_free_page(page, order, boundary_pfn - pfn);
+			pfn +=3D (1UL << order);
+			continue;
+		}
+		/*
+		 * migrate compound pages then let the free page handling code
+		 * above do the rest. If migration is not possible, just fail.
+		 */
+		if (PageCompound(page)) {
+			unsigned long nr_pages =3D compound_nr(page);
+			struct page *head =3D compound_head(page);
+			unsigned long head_pfn =3D page_to_pfn(head);
+
+			if (head_pfn + nr_pages <=3D boundary_pfn) {
+				pfn =3D head_pfn + nr_pages;
+				continue;
+			}
+#if defined CONFIG_COMPACTION || defined CONFIG_CMA
+			/*
+			 * hugetlb, lru compound (THP), and movable compound pages
+			 * can be migrated. Otherwise, fail the isolation.
+			 */
+			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
+				int order;
+				unsigned long outer_pfn;
+				int page_mt =3D get_pageblock_migratetype(page);
+				bool isolate_page =3D !is_migrate_isolate_page(page);
+				struct compact_control cc =3D {
+					.nr_migratepages =3D 0,
+					.order =3D -1,
+					.zone =3D page_zone(pfn_to_page(head_pfn)),
+					.mode =3D MIGRATE_SYNC,
+					.ignore_skip_hint =3D true,
+					.no_set_skip_hint =3D true,
+					.gfp_mask =3D gfp_flags,
+					.alloc_contig =3D true,
+				};
+				INIT_LIST_HEAD(&cc.migratepages);
+
+				/*
+				 * XXX: mark the page as MIGRATE_ISOLATE so that
+				 * no one else can grab the freed page after migration.
+				 * Ideally, the page should be freed as two separate
+				 * pages to be added into separate migratetype free
+				 * lists.
+				 */
+				if (isolate_page) {
+					ret =3D set_migratetype_isolate(page, page_mt,
+						flags, head_pfn, boundary_pfn - 1);
+					if (ret)
+						goto failed;
+				}
+
+				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
+							head_pfn + nr_pages);
+
+				/*
+				 * restore the page's migratetype so that it can
+				 * be split into separate migratetype free lists
+				 * later.
+				 */
+				if (isolate_page)
+					unset_migratetype_isolate(page, page_mt);
+
+				if (ret)
+					goto failed;
+				/*
+				 * reset pfn to the head of the free page, so
+				 * that the free page handling code above can split
+				 * the free page to the right migratetype list.
+				 *
+				 * head_pfn is not used here as a hugetlb page order
+				 * can be bigger than MAX_ORDER-1, but after it is
+				 * freed, the free page order is not. Use pfn within
+				 * the range to find the head of the free page.
+				 */
+				order =3D 0;
+				outer_pfn =3D pfn;
+				while (!PageBuddy(pfn_to_page(outer_pfn))) {
+					/* stop if we cannot find the free page */
+					if (++order >=3D MAX_ORDER)
+						goto failed;
+					outer_pfn &=3D ~0UL << order;
+				}
+				pfn =3D outer_pfn;
+				continue;
+			} else
+#endif
+				goto failed;
+		}
+
+		pfn++;
+	}
+	return 0;
+failed:
+	/* restore the original migratetype */
+	unset_migratetype_isolate(pfn_to_page(isolate_pageblock), saved_mt);
+	return -EBUSY;
+}
+
 /**
  * start_isolate_page_range() - make page-allocation-type of range of pa=
ges to
  * be MIGRATE_ISOLATE.
@@ -293,6 +481,8 @@ __first_valid_page(unsigned long pfn, unsigned long n=
r_pages)
  *					 and PageOffline() pages.
  *			REPORT_FAILURE - report details about the failure to
  *			isolate the range
+ * @gfp_flags:		GFP flags used for migrating pages that sit across the
+ *			range boundaries.
  *
  * Making page-allocation-type to be MIGRATE_ISOLATE means free pages in=

  * the range will never be allocated. Any free pages and pages freed in =
the
@@ -301,6 +491,10 @@ __first_valid_page(unsigned long pfn, unsigned long =
nr_pages)
  * pages in the range finally, the caller have to free all pages in the =
range.
  * test_page_isolated() can be used for test it.
  *
+ * The function first tries to isolate the pageblocks at the beginning a=
nd end
+ * of the range, since there might be pages across the range boundaries.=

+ * Afterwards, it isolates the rest of the range.
+ *
  * There is no high level synchronization mechanism that prevents two th=
reads
  * from trying to isolate overlapping ranges. If this happens, one threa=
d
  * will notice pageblocks in the overlapping range already set to isolat=
e.
@@ -321,21 +515,38 @@ __first_valid_page(unsigned long pfn, unsigned long=
 nr_pages)
  * Return: 0 on success and -EBUSY if any part of range cannot be isolat=
ed.
  */
 int start_isolate_page_range(unsigned long start_pfn, unsigned long end_=
pfn,
-			     unsigned migratetype, int flags)
+			     int migratetype, int flags, gfp_t gfp_flags)
 {
 	unsigned long pfn;
 	struct page *page;
+	int ret;

 	BUG_ON(!IS_ALIGNED(start_pfn, pageblock_nr_pages));
 	BUG_ON(!IS_ALIGNED(end_pfn, pageblock_nr_pages));

-	for (pfn =3D start_pfn;
-	     pfn < end_pfn;
+	/* isolate [start_pfn, start_pfn + pageblock_nr_pages) pageblock */
+	ret =3D isolate_single_pageblock(start_pfn, flags, gfp_flags, false);
+	if (ret)
+		return ret;
+
+	/* isolate [end_pfn - pageblock_nr_pages, end_pfn) pageblock */
+	ret =3D isolate_single_pageblock(end_pfn, flags, gfp_flags, true);
+	if (ret) {
+		unset_migratetype_isolate(pfn_to_page(start_pfn), migratetype);
+		return ret;
+	}
+
+	/* skip isolated pageblocks at the beginning and end */
+	for (pfn =3D start_pfn + pageblock_nr_pages;
+	     pfn < end_pfn - pageblock_nr_pages;
 	     pfn +=3D pageblock_nr_pages) {
 		page =3D __first_valid_page(pfn, pageblock_nr_pages);
 		if (page && set_migratetype_isolate(page, migratetype, flags,
 					start_pfn, end_pfn)) {
 			undo_isolate_page_range(start_pfn, pfn, migratetype);
+			unset_migratetype_isolate(
+				pfn_to_page(end_pfn - pageblock_nr_pages),
+				migratetype);
 			return -EBUSY;
 		}
 	}
@@ -346,7 +557,7 @@ int start_isolate_page_range(unsigned long start_pfn,=
 unsigned long end_pfn,
  * Make isolated pages available again.
  */
 void undo_isolate_page_range(unsigned long start_pfn, unsigned long end_=
pfn,
-			    unsigned migratetype)
+			    int migratetype)
 {
 	unsigned long pfn;
 	struct page *page;
-- =

2.35.1



--
Best Regards,
Yan, Zi

--=_MailMate_93F4047A-7B49-43F9-AB3E-C6FD8D7D814E_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmKNK04PHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUTFsP/2BjGlot7ndjysD9j/mv3lR1H3/3ZMCHH6kV
sn0Fd/dQgLYWNXE5VEJRTEACfgHh+tnOZ25LP96Cxx8/h7H8oIFDucayM8oBBn7c
dPbyfp96rZmLPALr2Byu/HGFhXb4Sdru/+EeCgKsGlWgikA+leyXDmIXF003G2yA
4JCv+V7+REXoG52H7nPebxdnjLb2dQg7h8LqBnaZMFcBCrI+rz+YwPprMFNvbSdu
2niS0gpVUXDxoL2jCHPP+NM7MOO7jSnLVdGCQdnyB/0WCyfU6lRoEyqVtxonpSZB
YzfxwHtaMIupPafBx0aeEA6zd6hqt7s3z9QkDfDt05ypkekay9iyDejv02PkyXjn
tTjw/uTb948JDLQ3JpJr+WvzV9QEJBsU7vSdmpZ0El62oBO2owpHLhs8T7q0f/6s
nM7lukpQ+jA+XuFc9dFX1UKxTU3UOvZEIOTnmwnqLYuQcRpicfG3ZtUC7ASSXSRw
jUyeA7NjEFQlymZkaTYlE53BxaOS9cTrDL7chn5c2faKSNWJIiEE62OyADwZojZR
bJQhR3nA5p2U3DHnWlxTjd16I0gJnwPNRrY5UmjUCX7tA24bJY2zgdABr0GqBdCU
Nj09xUoNCrG/Dr/S5+7H1RvWMLXIJrrB4Zm+0Am+0LzrHA0xnmX/Y9/5rTjQ+liN
PYP8Cho7
=mV9D
-----END PGP SIGNATURE-----

--=_MailMate_93F4047A-7B49-43F9-AB3E-C6FD8D7D814E_=--
