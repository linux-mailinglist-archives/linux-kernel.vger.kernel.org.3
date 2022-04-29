Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CCB1F514C2D
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 16:04:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376822AbiD2OHZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 10:07:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55606 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377056AbiD2OHP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 10:07:15 -0400
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (mail-mw2nam12on2062d.outbound.protection.outlook.com [IPv6:2a01:111:f400:fe5a::62d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 088D98BF29
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 06:56:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=KV+ecorlwLJy4G2+TzNz6v3/+zUGEIRvuRgMy1xOYN4hhfdIcrPtkZzZYxuXHMCVO0Ir3RjSs+yGn4AuzZMjLXjPF43dKYU6xjX8EqlrVMk8T3fpZdV6bVrz8P+vm6zUYZ8rb5h+EkV6MufiPZ8yObkJZTr6+xH5NCIuuiheTNITLkuAKJS00wgmlJ7q4N8dA5Ix4giNcxuu9JFHc4wRsn9vu8EajkYAeNcTdH02W94Wl25vrDJD9ZUFAN7aIgu1KroZ6cGcZj7UnhOliCiTwQTpWdBNsbQfjhlpKq9Ng9LXrWaS8QbUDsq3nde0JWgWq8p2V73aCT8662N+KSmf2Q==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DHzCgTlR7YemWBxndPnM0tFbTbgwoZsWw0DbrtnfLWw=;
 b=dcuGxUD80uBbx1IGfeAtp33/fAgK8eCcuHV3R+yurWqAupZ8Zpe5Jlr3Fi5qbx7FTcko3klWB2K/DkpPlg1dECuPkr9pbRUipDTdCAj5RpIjsEiBzkxlV8bgqBBkH+KOvfMEWhC1ur8QDy8AYJrTWlgdG07Q89fDQSg9b4cfd8L2tGDCmxH218VSJYpPsIUAWaOqquKsR6AKt1txDv6uNyCBsZMATFnvGxY4SKqYS7Q2FmXCG0tDBARMhZJSz1mS06Zw5ncsm9N3RJwCV+8hE4tbJ/u5IwvjAgBIiTAsbMSsKvKi7EwWrugj/FPo17ZA7zvjV/kRckaM3D8IBuRvhQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DHzCgTlR7YemWBxndPnM0tFbTbgwoZsWw0DbrtnfLWw=;
 b=ECI9unazwXTVjYwRbR/j+LACGd787V9IaDcdVM5PwB492jaOlQanIN8rZX++XaOGOVa6XJrrdW6WWKPJI4ze+zLPSjQuqLBBnqtSlc9TqIcU9L8VCe77VQwtj8YpStybBiaYmwaHTYafKd8FQck4iexQqxGmIjqU6dP99zHOi0TNEAU6v2IklxrE26oGemE+iDi3nzIwkjNba6CVcFbpZzqv7tQqrfaeE0643bNUXqgym3G869nWVx0JjW/9+tekyJqFZHhKaDn6GcpqAXUzSkch682+JJP0Cr/7fz7UEUI1P1KWrXGdoumyJQG3QfBuq2h2r+QrVOEkiPqVrm5/WQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB3823.namprd12.prod.outlook.com (2603:10b6:208:168::26)
 by BL1PR12MB5158.namprd12.prod.outlook.com (2603:10b6:208:31c::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5206.13; Fri, 29 Apr
 2022 13:55:02 +0000
Received: from MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10]) by MN2PR12MB3823.namprd12.prod.outlook.com
 ([fe80::920:970d:6f94:1f10%4]) with mapi id 15.20.5206.013; Fri, 29 Apr 2022
 13:55:02 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     linux-kernel@vger.kernel.org,
        virtualization@lists.linux-foundation.org,
        Vlastimil Babka <vbabka@suse.cz>,
        Mel Gorman <mgorman@techsingularity.net>,
        Eric Ren <renzhengeek@gmail.com>,
        Mike Rapoport <rppt@kernel.org>,
        Oscar Salvador <osalvador@suse.de>,
        Christophe Leroy <christophe.leroy@csgroup.eu>,
        Andrew Morton <akpm@linux-foundation.org>,
        kernel test robot <lkp@intel.com>,
        Qian Cai <quic_qiancai@quicinc.com>
Subject: Re: [PATCH v11 3/6] mm: make alloc_contig_range work at pageblock granularity
Date:   Fri, 29 Apr 2022 09:54:59 -0400
X-Mailer: MailMate (1.14r5870)
Message-ID: <23A7297E-6C84-4138-A9FE-3598234004E6@nvidia.com>
In-Reply-To: <20220425143118.2850746-4-zi.yan@sent.com>
References: <20220425143118.2850746-1-zi.yan@sent.com>
 <20220425143118.2850746-4-zi.yan@sent.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_957B407A-5B4E-44C9-8825-7EED92D36333_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: BL1PR13CA0260.namprd13.prod.outlook.com
 (2603:10b6:208:2ba::25) To MN2PR12MB3823.namprd12.prod.outlook.com
 (2603:10b6:208:168::26)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9ad9f89f-7435-4e0f-5996-08da29e7db0f
X-MS-TrafficTypeDiagnostic: BL1PR12MB5158:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5158351AEB22DFAF18F27B55C2FC9@BL1PR12MB5158.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Pl0dkgw39z89pLLbfFQRwK71P1MhsXCHKWLuOVA1FS7bqucvNqgkDEsZPAmNCvSBTjLjfkvg9T+RQdJ6sB0buawTN8ZwEybMuF1hZsj/5ObcpDlupqfWBUPurc762lYlV2cCwIqNGzKqmFEwI486yWDRJuJyZ6I9oTiNbMH8UBIDq/8AF83mDm/zy2E3OV6Gc9tKaElJPqaO/NhEImbKupW+Oa0kIwHBpERK9/BRVMvDIXtkIfGetXvlEAfKwDTPilR96AKjdMwgukbJK7mmNad+Sv/CSbhjCOQVedKObCSQM0C4knx17SwQv3/a4cwX7g++8EIzM6TP1lEpmxiO1/11GwPeRCONmYwoHlefoDdprQ+9/Yvt9Kyh71nW2ZG6LfM5R8vReMhrp89K/q4qc7hTtizcV+qiQIYC9A3lTP0wc1N2x8PEZlUXn+2IjII9FFGioDegPToNDBVwRgv3qK9eTvblJYy6b6O4sxUh0DJPEGif6uK1D3jt3c/4IhSY6x23Iyv83upI/dNy83LSNxx1C2lUAOHo0V1OpLMWbSMPU48mZOT8ctkX6GdvDa8WcWWnouA0BAbtij5Ju41yrRopCfQq7MD0OIoxjUaIvfxP3cHJysRTBnXhlIMVEUkjgwS3k/BHZz8O5g3kf5ZenkZFSwC9MOoYtxt0Du8c6FW587SL0eqW2nV5w4CKV3dTvlD/6LGvQMBIvQQu8nLeLTMidmCBkWN6qT42Zkj3Qz8Ua7xUXvVIFZ210lNvrHhfc79u8hxL/64fdE6NxJb2qUKQWIlq/oYyYqSWo3KV1HnL2L8MQ6yijp04rpPyX+df
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB3823.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(86362001)(966005)(6486002)(508600001)(2616005)(21480400003)(6506007)(6512007)(53546011)(26005)(38100700002)(6666004)(7416002)(2906002)(30864003)(66946007)(66556008)(33656002)(66476007)(316002)(186003)(36756003)(235185007)(5660300002)(8936002)(54906003)(83380400001)(4326008)(8676002)(45980500001)(72826004);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?t1fr15wDNrKpFKXYEDuxqaekFQ50739Eq9HQgxWYtE6f7XwQwPJdWs/zq9jU?=
 =?us-ascii?Q?ZZXcwgyx66TS3t+MYDOOYhwirtj+v1CCXFekQb4xt+KVXnBvpnS2hpVInZVs?=
 =?us-ascii?Q?ZswLv3wKPH8Gx0qjL0B5nK5yf6SQAO0aZ4JX/pY9ltbxcy9Q/6doc5dpLN92?=
 =?us-ascii?Q?OBiV9MR436cC3ugP9HQhJL2AgXOv4d2bfEMZ/N6rBO9X4iDGkESUdz2fPm3z?=
 =?us-ascii?Q?WDqajruNIgAbiEvwRZWLEVVX3cDDAVj81QjSbRSzq6T/YKS+uMr1LZNDHH5l?=
 =?us-ascii?Q?lL5cLJDIx6/Ff+7rwGO+prX9OF/XJh1IFn15fjHYTSuBEWqUBW5n3YUOfWq0?=
 =?us-ascii?Q?5Zw5ze7teLeAZne7N0U8M580AZTAbQyVKwQnSehjtacbOYUlZjzVWSEtlQAk?=
 =?us-ascii?Q?G6WCEV10fPcoJ6RfLDxNMsPTEOl6FpWrJ3rFxWdIj9oHfN2WQRyGW0SleDA1?=
 =?us-ascii?Q?A8fgoUIILJDENJoTJFe2N2bOcUkfUKGAG1zxSOzvETwoPMAC+PBOW5bDKp9z?=
 =?us-ascii?Q?KrDZAjq92qy/cxsQDqdzmbHUSqtg98b+qOZyr5hbgW3XmSHXawQnxOk4ePRT?=
 =?us-ascii?Q?hcZO88eylLhS+SOzj8gdOLDn0yriZnnPqczZVAW89gDUKxArPKjNiPoJPjqe?=
 =?us-ascii?Q?f4xlqy0kTLk1Z5zLlIK+zZ5b3IXXei2HEkKKgJ47uBNT2hdunqubdl7g6lmD?=
 =?us-ascii?Q?vGFCR2Wa0K75IZ4xGLks2vBK4LhQwYOK7z97fAvxRtYfqfuEhBXmMtKeb00j?=
 =?us-ascii?Q?jXBX4mYqcA4e8ISCbdosh49v/SIUFsl8wSlDTQZc40RQUFlH4JFKhcSuSGgV?=
 =?us-ascii?Q?z87weOGq6Bec9zFxq8/p23lAn9pOk+rP291Ym6IlZtFCjVIm+Pd8tJPBS65Q?=
 =?us-ascii?Q?Cpo+aGsgv3SEcSsALlTc5ndT59sKXFknzaXXrp3K79UFeI+BDTJJo+lnjZRZ?=
 =?us-ascii?Q?BqKQ9/KzyZtvFyVhirw/wmIqC5ozh2GRr+OQN/rRyDzhR6qJpYHCMNAYaVgI?=
 =?us-ascii?Q?oMRN9gyRw9bNwz6HzhUPUVV3HFunGGpCLGaXL9t/iXFAwXNXn5+B+k6IS2q0?=
 =?us-ascii?Q?oLt31LcTE6NatyfF84b6bmUGlprhAK84bxYdlIqlDZ/QHQKCwGFKb1ZthW2m?=
 =?us-ascii?Q?QkUZrVEla1zQXvTmuwpuERUjN9w+qHJgcGHI6+vMGlJSE6VCaaC12zcp+mK0?=
 =?us-ascii?Q?cMCGswRfpvDYZ6bWGYxeJDA51XRq7B/QKblUx1gPN8Z5a4mjzZJaGBgovOpb?=
 =?us-ascii?Q?NG9HnHsrdqZmwE1gIKzM/0tEFyvmtAwRROzFh8Gl65sMrpSLATg+OJ+xSzsS?=
 =?us-ascii?Q?jDrswl9G17SHE0d674o34w2jXDPbDOiBi8f36hLMJrBoLjbGsJHouhehmcF6?=
 =?us-ascii?Q?hIWaXsjdRCzqhGFCdv/oAQYTn9SgW1IVmTuKLeSHJal/bSlAllnpUs9ZQjId?=
 =?us-ascii?Q?lcGoUHg8oNlhONCYgCRmIaDyEtlAYK0u0ZGCksZqkMkCIupwu2cnrZnPvrt1?=
 =?us-ascii?Q?mpyWZurmwp/8Qk+Oku+mfihkyD+eRUusMJgZO12IrhAI/OSP90/5aEG/TUwY?=
 =?us-ascii?Q?xcrMN2xCcaVvilL7wa6gl+rU3VQmGOP3JRfI+/6V7iG9VZrCoa354li+vCbk?=
 =?us-ascii?Q?YokV48JOOtCMFItG4TLZGN5dYN0IN8elSklufqkTFEr1drzKiLQov1w8rKho?=
 =?us-ascii?Q?PMO6ORC5fvnraR5gnz1/XNS1ILlEtW7KudKI+77Vbp5ngrPKN3pr7S19awbR?=
 =?us-ascii?Q?VpsXQIZ1zQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9ad9f89f-7435-4e0f-5996-08da29e7db0f
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB3823.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 29 Apr 2022 13:55:01.9652
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: zfwb579yHJ52lfer6bXJtPqCYE/4JGMFW3k+45AT47rZh5jdmAaFqSWOCJqfUKz7
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5158
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        SPF_HELO_PASS,SPF_NONE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_957B407A-5B4E-44C9-8825-7EED92D36333_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 25 Apr 2022, at 10:31, Zi Yan wrote:

> From: Zi Yan <ziy@nvidia.com>
>
> alloc_contig_range() worked at MAX_ORDER_NR_PAGES granularity to avoid
> merging pageblocks with different migratetypes. It might unnecessarily
> convert extra pageblocks at the beginning and at the end of the range.
> Change alloc_contig_range() to work at pageblock granularity.
>
> Special handling is needed for free pages and in-use pages across the
> boundaries of the range specified by alloc_contig_range(). Because thes=
e
> partially isolated pages causes free page accounting issues. The free
> pages will be split and freed into separate migratetype lists; the
> in-use pages will be migrated then the freed pages will be handled in
> the aforementioned way.
>
> Reported-by: kernel test robot <lkp@intel.com>
> Signed-off-by: Zi Yan <ziy@nvidia.com>
> ---
>  include/linux/page-isolation.h |   4 +-
>  mm/internal.h                  |   6 ++
>  mm/memory_hotplug.c            |   3 +-
>  mm/page_alloc.c                |  54 ++++++++--
>  mm/page_isolation.c            | 184 ++++++++++++++++++++++++++++++++-=

>  5 files changed, 233 insertions(+), 18 deletions(-)
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
> index ce23ac8ad085..70ddd9a0bcf3 100644
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
> index c2f7a8bb634d..94b3467e5ba2 100644
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
> @@ -279,6 +279,157 @@ __first_valid_page(unsigned long pfn, unsigned lo=
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
> +		 * above do the rest. If migration is not enabled, just fail.
> +		 */
> +		if (PageHuge(page) || PageTransCompound(page)) {
> +#if defined CONFIG_COMPACTION || defined CONFIG_CMA
> +			unsigned long nr_pages =3D compound_nr(page);
> +			int order =3D compound_order(page);
> +			struct page *head =3D compound_head(page);
> +			unsigned long head_pfn =3D page_to_pfn(head);
> +			int ret;
> +			struct compact_control cc =3D {
> +				.nr_migratepages =3D 0,
> +				.order =3D -1,
> +				.zone =3D page_zone(pfn_to_page(head_pfn)),
> +				.mode =3D MIGRATE_SYNC,
> +				.ignore_skip_hint =3D true,
> +				.no_set_skip_hint =3D true,
> +				.gfp_mask =3D gfp_flags,
> +				.alloc_contig =3D true,
> +			};
> +			INIT_LIST_HEAD(&cc.migratepages);
> +
> +			if (head_pfn + nr_pages < boundary_pfn) {
> +				pfn +=3D nr_pages;
> +				continue;
> +			}
> +
> +			ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
> +						head_pfn + nr_pages);
> +
> +			if (ret)
> +				goto failed;
> +			/*
> +			 * reset pfn, let the free page handling code above
> +			 * split the free page to the right migratetype list.
> +			 *
> +			 * head_pfn is not used here as a hugetlb page order
> +			 * can be bigger than MAX_ORDER-1, but after it is
> +			 * freed, the free page order is not. Use pfn within
> +			 * the range to find the head of the free page and
> +			 * reset order to 0 if a hugetlb page with
> +			 * >MAX_ORDER-1 order is encountered.
> +			 */
> +			if (order > MAX_ORDER-1)
> +				order =3D 0;
> +			while (!PageBuddy(pfn_to_page(pfn))) {
> +				order++;
> +				pfn &=3D ~0UL << order;
> +			}
> +			continue;
> +#else
> +			goto failed;
> +#endif
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
> @@ -293,6 +444,8 @@ __first_valid_page(unsigned long pfn, unsigned long=
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
> @@ -301,6 +454,10 @@ __first_valid_page(unsigned long pfn, unsigned lon=
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
> @@ -321,21 +478,38 @@ __first_valid_page(unsigned long pfn, unsigned lo=
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
> @@ -346,7 +520,7 @@ int start_isolate_page_range(unsigned long start_pf=
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

Qian hit a bug caused by this series https://lore.kernel.org/linux-mm/202=
20426201855.GA1014@qian/
and the fix is:

diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index 75e454f5cf45..b3f074d1682e 100644
--- a/mm/page_isolation.c
+++ b/mm/page_isolation.c
@@ -367,58 +367,67 @@ static int isolate_single_pageblock(unsigned long b=
oundary_pfn, gfp_t gfp_flags,
 		}
 		/*
 		 * migrate compound pages then let the free page handling code
-		 * above do the rest. If migration is not enabled, just fail.
+		 * above do the rest. If migration is not possible, just fail.
 		 */
-		if (PageHuge(page) || PageTransCompound(page)) {
-#if defined CONFIG_COMPACTION || defined CONFIG_CMA
+		if (PageCompound(page)) {
 			unsigned long nr_pages =3D compound_nr(page);
-			int order =3D compound_order(page);
 			struct page *head =3D compound_head(page);
 			unsigned long head_pfn =3D page_to_pfn(head);
-			int ret;
-			struct compact_control cc =3D {
-				.nr_migratepages =3D 0,
-				.order =3D -1,
-				.zone =3D page_zone(pfn_to_page(head_pfn)),
-				.mode =3D MIGRATE_SYNC,
-				.ignore_skip_hint =3D true,
-				.no_set_skip_hint =3D true,
-				.gfp_mask =3D gfp_flags,
-				.alloc_contig =3D true,
-			};
-			INIT_LIST_HEAD(&cc.migratepages);

 			if (head_pfn + nr_pages < boundary_pfn) {
-				pfn +=3D nr_pages;
+				pfn =3D head_pfn + nr_pages;
 				continue;
 			}
-
-			ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
-						head_pfn + nr_pages);
-
-			if (ret)
-				goto failed;
+#if defined CONFIG_COMPACTION || defined CONFIG_CMA
 			/*
-			 * reset pfn, let the free page handling code above
-			 * split the free page to the right migratetype list.
-			 *
-			 * head_pfn is not used here as a hugetlb page order
-			 * can be bigger than MAX_ORDER-1, but after it is
-			 * freed, the free page order is not. Use pfn within
-			 * the range to find the head of the free page and
-			 * reset order to 0 if a hugetlb page with
-			 * >MAX_ORDER-1 order is encountered.
+			 * hugetlb, lru compound (THP), and movable compound pages
+			 * can be migrated. Otherwise, fail the isolation.
 			 */
-			if (order > MAX_ORDER-1)
+			if (PageHuge(page) || PageLRU(page) || __PageMovable(page)) {
+				int order;
+				unsigned long outer_pfn;
+				int ret;
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
+				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
+							head_pfn + nr_pages);
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
 				order =3D 0;
-			while (!PageBuddy(pfn_to_page(pfn))) {
-				order++;
-				pfn &=3D ~0UL << order;
-			}
-			continue;
-#else
-			goto failed;
+				outer_pfn =3D pfn;
+				while (!PageBuddy(pfn_to_page(outer_pfn))) {
+					if (++order >=3D MAX_ORDER) {
+						outer_pfn =3D pfn;
+						break;
+					}
+					outer_pfn &=3D ~0UL << order;
+				}
+				pfn =3D outer_pfn;
+				continue;
+			} else
 #endif
+				goto failed;
 		}

 		pfn++;
-- =

2.35.1




The fixed-up patch is below for easy review purpose:



=46rom fce466e89e50bcb0ebb56d7809db1b8bbea47628 Mon Sep 17 00:00:00 2001
From: Zi Yan <ziy@nvidia.com>
Date: Tue, 26 Apr 2022 23:00:33 -0400
Subject: [PATCH] mm: make alloc_contig_range work at pageblock granularit=
y

alloc_contig_range() worked at MAX_ORDER_NR_PAGES granularity to avoid
merging pageblocks with different migratetypes.  It might unnecessarily
convert extra pageblocks at the beginning and at the end of the range.
Change alloc_contig_range() to work at pageblock granularity.

Special handling is needed for free pages and in-use pages across the
boundaries of the range specified by alloc_contig_range().  Because these=

partially isolated pages causes free page accounting issues.  The free
pages will be split and freed into separate migratetype lists; the in-use=

pages will be migrated then the freed pages will be handled in the
aforementioned way.

Signed-off-by: Zi Yan <ziy@nvidia.com>
---
 include/linux/page-isolation.h |   4 +-
 mm/internal.h                  |   6 +
 mm/memory_hotplug.c            |   3 +-
 mm/page_alloc.c                |  54 +++++++--
 mm/page_isolation.c            | 193 ++++++++++++++++++++++++++++++++-
 5 files changed, 242 insertions(+), 18 deletions(-)

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
index 919fa07e1031..0667abd57634 100644
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
index 4c6065e5d274..9f8ae4cb77ee 100644
--- a/mm/memory_hotplug.c
+++ b/mm/memory_hotplug.c
@@ -1845,7 +1845,8 @@ int __ref offline_pages(unsigned long start_pfn, un=
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
index 93dbe05a6029..6a0d1746c095 100644
--- a/mm/page_alloc.c
+++ b/mm/page_alloc.c
@@ -1094,6 +1094,43 @@ static inline void __free_one_page(struct page *pa=
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
+	spin_lock_irqsave(&zone->lock, flags);
+	del_page_from_free_list(free_page, zone, order);
+	for (pfn =3D free_page_pfn;
+	     pfn < free_page_pfn + (1UL << order);) {
+		int mt =3D get_pfnblock_migratetype(pfn_to_page(pfn), pfn);
+
+		free_page_order =3D ffs(split_pfn_offset) - 1;
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
@@ -8919,7 +8956,7 @@ static inline void alloc_contig_dump_pages(struct l=
ist_head *page_list)
 #endif

 /* [start, end) must belong to a single zone. */
-static int __alloc_contig_migrate_range(struct compact_control *cc,
+int __alloc_contig_migrate_range(struct compact_control *cc,
 					unsigned long start, unsigned long end)
 {
 	/* This function is based on compact_zone() from compaction.c. */
@@ -9002,7 +9039,7 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 		       unsigned migratetype, gfp_t gfp_mask)
 {
 	unsigned long outer_start, outer_end;
-	unsigned int order;
+	int order;
 	int ret =3D 0;

 	struct compact_control cc =3D {
@@ -9021,14 +9058,11 @@ int alloc_contig_range(unsigned long start, unsig=
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
@@ -9042,9 +9076,9 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 	 */

 	ret =3D start_isolate_page_range(pfn_max_align_down(start),
-				       pfn_max_align_up(end), migratetype, 0);
+				pfn_max_align_up(end), migratetype, 0, gfp_mask);
 	if (ret)
-		return ret;
+		goto done;

 	drain_all_pages(cc.zone);

@@ -9064,7 +9098,7 @@ int alloc_contig_range(unsigned long start, unsigne=
d long end,
 	ret =3D 0;

 	/*
-	 * Pages from [start, end) are within a MAX_ORDER_NR_PAGES
+	 * Pages from [start, end) are within a pageblock_nr_pages
 	 * aligned blocks that are marked as MIGRATE_ISOLATE.  What's
 	 * more, all pages in [start, end) are free in page allocator.
 	 * What we are going to do is to allocate all pages from
diff --git a/mm/page_isolation.c b/mm/page_isolation.c
index c2f7a8bb634d..8a0f16d2e4c3 100644
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
@@ -279,6 +279,166 @@ __first_valid_page(unsigned long pfn, unsigned long=
 nr_pages)
 	return NULL;
 }

+/**
+ * isolate_single_pageblock() -- tries to isolate a pageblock that might=
 be
+ * within a free or in-use page.
+ * @boundary_pfn:		pageblock-aligned pfn that a page might cross
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
+static int isolate_single_pageblock(unsigned long boundary_pfn, gfp_t gf=
p_flags,
+			bool isolate_before)
+{
+	unsigned char saved_mt;
+	unsigned long start_pfn;
+	unsigned long isolate_pageblock;
+	unsigned long pfn;
+	struct zone *zone;
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

+	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), MIGRATE_ISOLA=
TE);
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
+			if (head_pfn + nr_pages < boundary_pfn) {
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
+				int ret;
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
+				ret =3D __alloc_contig_migrate_range(&cc, head_pfn,
+							head_pfn + nr_pages);
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
+					if (++order >=3D MAX_ORDER) {
+						outer_pfn =3D pfn;
+						break;
+					}
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
+	set_pageblock_migratetype(pfn_to_page(isolate_pageblock), saved_mt);
+	return -EBUSY;
+}
+
 /**
  * start_isolate_page_range() - make page-allocation-type of range of pa=
ges to
  * be MIGRATE_ISOLATE.
@@ -293,6 +453,8 @@ __first_valid_page(unsigned long pfn, unsigned long n=
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
@@ -301,6 +463,10 @@ __first_valid_page(unsigned long pfn, unsigned long =
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
@@ -321,21 +487,38 @@ __first_valid_page(unsigned long pfn, unsigned long=
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
+	ret =3D isolate_single_pageblock(start_pfn, gfp_flags, false);
+	if (ret)
+		return ret;
+
+	/* isolate [end_pfn - pageblock_nr_pages, end_pfn) pageblock */
+	ret =3D isolate_single_pageblock(end_pfn, gfp_flags, true);
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
@@ -346,7 +529,7 @@ int start_isolate_page_range(unsigned long start_pfn,=
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

--=_MailMate_957B407A-5B4E-44C9-8825-7EED92D36333_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename="signature.asc"
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEE6rR4j8RuQ2XmaZol4n+egRQHKFQFAmJr7jMPHHppeUBudmlk
aWEuY29tAAoJEOJ/noEUByhUTgwQAJoHG24lhvAJ0honia+hdaFA9OUUCnwasUUZ
p58uT+lg0a9TKKE35yic6MTk6sIV9DiCE/plpSivsk2YtdjXSRFEYS9XFF8R3q7D
dE78wyg+WfEtjgJDpl2+/oT2gKmwPAutepAmzqMchwm58s/lG4quz5imObSNset8
bEgx48/5ModdFSmmvChNnaAn8kEJsu2Sy2qMFoV+/cjObwuMACu32coAI4pyeWFu
UxO+RD2VhNC6w8g7jBu2y9mNaTqNQkc3Rt2wl6npKXxkrdh1WC1tYn4GL0WiwLho
quuZ+6Pfr2guxEvEhqKXvSD2kEvHz8i4E7FS0PcoNIIBjy6pcT/XZlu5DQPe/Z8d
1xDEeXzVuA+iPxP2fsRWFdagM9OhQClU44BO4TcMY88TuEv+pElzhODqXTF2CFzJ
s+7Rh/WfWYBhVjLJwomCcw1lW2tAOZ1aLSwgSs1cjkPehxo+CiGI8ymnGUuv4dV6
JqR6gbe/uHPWxIPSCu1H4iqQQML5QHa6q6G0xU6XBKxFdgaFSEZXGjPjLAcP5IQR
4BBtPqxEg03UJ2VpRpZ8h3nO9DT9LKWn7EE8ifsNBuUUuG5l9xlgQM3QGUfY7NvX
hXkchVEMc7j2ExNZngi0/N6SGBhWI2qvXPhi1Q5FcaqYlATrRYuPS4eOkvvfPbdZ
hRM7BMAy
=AMd0
-----END PGP SIGNATURE-----

--=_MailMate_957B407A-5B4E-44C9-8825-7EED92D36333_=--
