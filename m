Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EA615A330F
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 02:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239871AbiH0A0H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 26 Aug 2022 20:26:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231216AbiH0A0E (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 26 Aug 2022 20:26:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2077.outbound.protection.outlook.com [40.107.220.77])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9AA52DEB7E
        for <linux-kernel@vger.kernel.org>; Fri, 26 Aug 2022 17:26:02 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=R1Dy+Xg/lfWcy3uhvEoWoe68d3qkVn6x4/Wbgj4qv3R7YObhA9yAxcC7AmDnwSsivw80jLOok+jC0pzDZVSNhmC9BKHnig40bGyxYRXnSEIWIhUXOVv8DBDKaqWb7TFoszAaOboQWmgy4vbtRDQ24/ztaUnfsk8nmPRa+0+e/Rv5rhpke5iIvUytGIZ9VOpBR84LO7WkjnxSghju3fJoi9bDjEcU7S4WcOIYKCraEGhbMhJU1hMN/icHmD4UKSksfw70X2frwKeqjZXmy+CNrvUC8pL6+Sg8xPFYmEpiLGl3Ds2d3U4VQP8dGP0AllPDUg7qo5aLmIoHdMML5rYRKw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rNOkAFoOSgfFy1eg8T9XvbLsOyI9hmxBkRwYtu70fRk=;
 b=XtMPNznUIZTKNQAh3DK57EGGL0oBuod5cawjO2N5cGBSVvbiDnQqefSmiIU+BTXWuJs5vGxqhycdX+bucSSYKJQ0bEdDg1MVXAhtdCqHmnFURG7fb6OOqpMWV4jmejDAYYw+Lw75edLvyl6KWj6/wCsfgiI2gTnpY4gu9lYiWCNiO/7k0Ik5PxcvsjKV+wEEgHAeBalQlJGAurbi5rKhQ5y4zfOUW/okA9uiq4mJ3aDZIfLCZUJHMTpnt+ApUbqjfPhojLlgnB/MIhKOSjAgTlP2RsCqjqashzvSDp9Arcwmld4swD424WMl7/78b7zDrcttaYO5zi7gyUyDa/KNyA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rNOkAFoOSgfFy1eg8T9XvbLsOyI9hmxBkRwYtu70fRk=;
 b=Srh2PllnAlT79UmaSLwFfXWJGWfJG5w5PjCVEsrzx9lLER9BVsc8W+pyw0pRB7HimeatX8ZcwFzQz4ZFBSyI7DFqMavOScF5OvwswyCYjBjVVswDVIJRWp2QMoNJBVJ+eZKl2hCTwLKiX0MsUZevGQWD60AM6viQF+H0Eon2avmiRjpwpEDHeRAy7LGn0e1FPjty4X+fI+Rv4AyajpG4ryQh+pCvj1bOkARGDGWpP2kAREkiig+EbmF3aYSAx6N6O8DQcx7zHT1PXV04lUAbNBDvuGA7uSTIZ/p6sKZaqDEGNJ8XJ0xS93V7slwu/n2zhK8lio9N4FqeMay4j/WXGw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from DS7PR12MB5744.namprd12.prod.outlook.com (2603:10b6:8:73::18) by
 PH8PR12MB7160.namprd12.prod.outlook.com (2603:10b6:510:228::6) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5566.16; Sat, 27 Aug 2022 00:26:00 +0000
Received: from DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7415:f39a:d46e:1594]) by DS7PR12MB5744.namprd12.prod.outlook.com
 ([fe80::7415:f39a:d46e:1594%3]) with mapi id 15.20.5566.015; Sat, 27 Aug 2022
 00:26:00 +0000
From:   Zi Yan <ziy@nvidia.com>
To:     alexlzhu@fb.com
Cc:     linux-mm@kvack.org, willy@infradead.org, hannes@cmpxchg.org,
        akpm@linux-foundation.org, riel@surriel.com, kernel-team@fb.com,
        linux-kernel@vger.kernel.org
Subject: Re: [RFC 3/3] mm: THP low utilization shrinker
Date:   Fri, 26 Aug 2022 20:25:56 -0400
X-Mailer: MailMate (1.14r5907)
Message-ID: <4BA28B97-9E5C-4CF5-B6E1-A6AD27A1B6AC@nvidia.com>
In-Reply-To: <ba2dfb44f4d4ec099dec0ca83790f4fb9ee02e72.1661461643.git.alexlzhu@fb.com>
References: <cover.1661461643.git.alexlzhu@fb.com>
 <ba2dfb44f4d4ec099dec0ca83790f4fb9ee02e72.1661461643.git.alexlzhu@fb.com>
Content-Type: multipart/signed;
 boundary="=_MailMate_2CB5A647-8E00-4DAB-BB7B-7F058B445749_=";
 micalg=pgp-sha512; protocol="application/pgp-signature"
X-ClientProxiedBy: MN2PR13CA0015.namprd13.prod.outlook.com
 (2603:10b6:208:160::28) To DS7PR12MB5744.namprd12.prod.outlook.com
 (2603:10b6:8:73::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 516facb7-4a9e-4a70-a801-08da87c2b73b
X-MS-TrafficTypeDiagnostic: PH8PR12MB7160:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8nKpp5PhUvjM5C9qIA2a1EcZ5rjpQN8U+QH7mp9YLjYN94KkouUhOEgyTLAaFCQhdpaoCgdVWZuh3TdgexNmVXwPvo+yqFUM/2uiyhX0NqcISj+3jdQ/hiK+vwX/yGcOrVF5jZzR1kXnBPxTvrlrQKfv/bG8WvaHxKyVE5/6dXtx1SD4KrfLWa6OEQD5MVjpyTEwE8ICmeKSwJqlQUhGOKSy7voHMFlM3DgEgpLDU62z5OFARpKKO3pfX+2iWrzkn+HXHHl+PvRQn8HapJBtocm/5shxF6WiUPx9T6T0sKN6c62i/DLhXtYXCUpWyeXjcQBLrvcDuJsXwseEHL/5x+z6LMQ9IVMdoOelrRJ83b7uCVMov0XOWDVlsYbehxwfQjLMF+UGIy98K1aDSJNYW8NS/vk2Ha9PXntuF/E7SjuBt2RqDv56+STwjso9cQBY5VS1jw5OhYSt0jzwc9kTvpy/6V9u9WovqJxBcpjMjEf7fUDMaDh4tiuOibrM45SFNdPAJDkKlYsZd1Ds0RV8m0irS+A94LKX2ZDxOnwy0626R9ETcQgNO9VAxem7u4D/tCnFEvjGIg6m7sZZI76oqLmCAXr7OiAHMnBjM7qEK33It4jW2Hdah3kyn5BDso9GXrns1RqwyK29LsZ8v41zvRQx8aDfIAwuQlw8QAwLoEjAM3lPDH7/wcm0cnZTJxHcNE5d2PopF9QCSdEGhHBJbbqyCxL5NsV1TJpyRMEk/C4KWc4GHH38yugrfI9My5cF1KL9bUlcbeQqOhI2mXiUf4YSykgTk+Cp4qZ+qoq1tak=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DS7PR12MB5744.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(346002)(376002)(396003)(39860400002)(136003)(2906002)(6486002)(30864003)(316002)(6916009)(478600001)(41300700001)(36756003)(6512007)(26005)(6666004)(186003)(53546011)(235185007)(2616005)(6506007)(8936002)(33656002)(86362001)(83380400001)(66476007)(8676002)(4326008)(66556008)(5660300002)(66946007)(38100700002)(72826004)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?ZxjSJKm1hcWAFE/xtSL17S+Uc/EEImICkQlSiQK4mjgVsVgeK5eWZYlN7Lk4?=
 =?us-ascii?Q?km6ZvrX9NiLFAS96yshzM33ZM3plReec/0RVauPdQRYcwVx+qlBInY1HTC0z?=
 =?us-ascii?Q?jNvMw3FXBJ1NlxYZzRqXGXDyK9lEWmZrE+VpNc+1omcpiogLH18IJxYq9CJW?=
 =?us-ascii?Q?vi/2CgOqihIVYQ6GiJ6UXQBkfKTIF8PNGtjo7Uob5IUlQFM7lC5IiBEvalFj?=
 =?us-ascii?Q?Ui+oPNdp2irb2tfYAV+9iL6wcitYHA462I2E9wWKUk/IJNy6DR1TlJq8/E4Z?=
 =?us-ascii?Q?9SAoT4iNM+NJjWAvNHZVEUqkDYsOhlGPBOm6QxXUuQB1YA5ePKYSqkHL4gFq?=
 =?us-ascii?Q?DAMJ87T9U2fwasC53z64pz6ZEjNKa4LMug9meBk3LjaTwU/EoaHhp0dST3Mb?=
 =?us-ascii?Q?KRSzxPwy0WB8Sg1EdGKcTB9fyP+ehFHdOnKo8tNn21JU8+DtsO8JFN2vKiq5?=
 =?us-ascii?Q?XVAQIgjS419yMxXoBktKHpQ/+ZWrbtQ5n59AEg1z8x3hdknQJROqzqVZQdgQ?=
 =?us-ascii?Q?UHC+Im+/VCNU9/eUiDKFlxOjrahMnbTFIXldo74EnS9hrmS+N9E8yYCUts8y?=
 =?us-ascii?Q?La9dWNWNT7rLOVrRS4wF7rT24k/Um/SbNphLWI15I86SDsGlaaoTAw/cYpeM?=
 =?us-ascii?Q?h6+lE7b9RlvhsvrXJ7hPVQkeNfnrHIyXvd3EtRBPsXfXoAHD42E5bxe9hc37?=
 =?us-ascii?Q?pnVgPCEZS6GKLScbaPVB1gRV6aUOHdkiu3tDeEd9bZ1fb8ukarPymWEKFGGU?=
 =?us-ascii?Q?SNShPy14TZrm8l0e1SZtnYn102IfNa6feHmcLK68xmotzY9A8hWcfygM1jkH?=
 =?us-ascii?Q?onmPbCPEmcJUVtxdHCsm3vlPJctTRwWq9QWFjlEFx/YaGcirUcFlkzKfYB3q?=
 =?us-ascii?Q?mOYbCWRm1vHbapip0NijJNRNM6ijh+oF+iH/vx+DP/vuV1PyqAKHCw9wkTeI?=
 =?us-ascii?Q?HfFmDlL2yagOyW/xif5z1ryAz4agcubcWxuYOSCTAExpjRev+ng9rC5wfnFp?=
 =?us-ascii?Q?ZoxlGxqiHPqrCQWzMfgGHxIOC/EnzHauryJ2ZSb9lyyZuJDL0jH+KOyYXEiO?=
 =?us-ascii?Q?WX7Cxlz99yDAqjOv0FDihN0EKcwDeoCdweVqXYRnElDSGyAffYPF2j4A6VT+?=
 =?us-ascii?Q?91RzvAKgNAS3v3O1DqDRLRhBl8CwQuZDHrLL7LeeHDVcMY+s5yvgcllyM/Kp?=
 =?us-ascii?Q?9sxRzdwQc8VQ0QJS/R8UUW1KPxThHgsY/IQQxuxHEXC37B09wjehSExh3yaz?=
 =?us-ascii?Q?tZ/9OYOqiu5MEoX9LqlGI61jcUikroA+NON0cTIEvGj4Wmqdu4a9P6/q+Z7i?=
 =?us-ascii?Q?h6ohZvyOCH33EyFM9UHslkH7r1fg5NhOqgskIANsfP5QoRAQkXKSmzAIUQf0?=
 =?us-ascii?Q?Pj5Kx0LlGfh34QphGAcksPnEsQHYsYiONp+YUFvsWIdF0ahJmKAY6An9bRMp?=
 =?us-ascii?Q?NWNEJxCAS6t4+1I6bMjFXjIPZCQANuuHqtS5cdZZ7My0vRm0j2J8GJ5K+0MD?=
 =?us-ascii?Q?NVx8/GcypDmFmsLHICbDzrozrgVB25x7bNWoF5SFMwKZQP8uSlYXiXUotNeL?=
 =?us-ascii?Q?15U7VWw/YO2lw7Gz2DOnVTgAkhheE9YPAoE9uvmr?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 516facb7-4a9e-4a70-a801-08da87c2b73b
X-MS-Exchange-CrossTenant-AuthSource: DS7PR12MB5744.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 27 Aug 2022 00:25:59.9203
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 57bZELwsmMgGr8viQw9QtFEd/X/InWRsYLHpPjd16sDLS4FB79COyS3vjVTGhXKM
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR12MB7160
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--=_MailMate_2CB5A647-8E00-4DAB-BB7B-7F058B445749_=
Content-Type: text/plain
Content-Transfer-Encoding: quoted-printable

On 25 Aug 2022, at 17:30, alexlzhu@fb.com wrote:

> From: Alexander Zhu <alexlzhu@fb.com>
>
> This patch introduces a shrinker that will remove THPs in the lowest
> utilization bucket. As previously mentioned, we have observed that
> almost all of the memory waste when THPs are always enabled
> is contained in the lowest utilization bucket. The shrinker will
> add these THPs to a list_lru and split anonymous THPs based off
> information from kswapd. It requires the changes from
> thp_utilization to identify the least utilized THPs, and the
> changes to split_huge_page to identify and free zero pages
> within THPs.

How stale could the information in the utilization bucket be? Is it
possible that THP shrinker splits a THP used to have a lot of
zero-filled subpages but now have all subpages filled with useful
values? In Patch 2, split_huge_page() only unmap zero-filled subpages,
but for THP shrinker, should it verify the utilization before it
splits the page?

>
> Signed-off-by: Alexander Zhu <alexlzhu@fb.com>
> ---
>  include/linux/huge_mm.h  |  7 +++
>  include/linux/list_lru.h | 24 +++++++++++
>  include/linux/mm_types.h |  5 +++
>  mm/huge_memory.c         | 92 ++++++++++++++++++++++++++++++++++++++--=

>  mm/list_lru.c            | 49 +++++++++++++++++++++
>  mm/page_alloc.c          |  6 +++
>  6 files changed, 180 insertions(+), 3 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index c9086239deb7..13bd470173d2 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -192,6 +192,8 @@ static inline int split_huge_page(struct page *page=
)
>  }
>  void deferred_split_huge_page(struct page *page);
>
> +void add_underutilized_thp(struct page *page);
> +
>  void __split_huge_pmd(struct vm_area_struct *vma, pmd_t *pmd,
>  		unsigned long address, bool freeze, struct folio *folio);
>
> @@ -302,6 +304,11 @@ static inline struct list_head *page_deferred_list=
(struct page *page)
>  	return &page[2].deferred_list;
>  }
>
> +static inline struct list_head *page_underutilized_thp_list(struct pag=
e *page)
> +{
> +	return &page[3].underutilized_thp_list;
> +}
> +
>  #else /* CONFIG_TRANSPARENT_HUGEPAGE */
>  #define HPAGE_PMD_SHIFT ({ BUILD_BUG(); 0; })
>  #define HPAGE_PMD_MASK ({ BUILD_BUG(); 0; })
> diff --git a/include/linux/list_lru.h b/include/linux/list_lru.h
> index b35968ee9fb5..c2cf146ea880 100644
> --- a/include/linux/list_lru.h
> +++ b/include/linux/list_lru.h
> @@ -89,6 +89,18 @@ void memcg_reparent_list_lrus(struct mem_cgroup *mem=
cg, struct mem_cgroup *paren
>   */
>  bool list_lru_add(struct list_lru *lru, struct list_head *item);
>
> +/**
> + * list_lru_add_page: add an element to the lru list's tail
> + * @list_lru: the lru pointer
> + * @page: the page containing the item
> + * @item: the item to be deleted.
> + *
> + * This function works the same as list_lru_add in terms of list
> + * manipulation. Used for non slab objects contained in the page.
> + *
> + * Return value: true if the list was updated, false otherwise
> + */
> +bool list_lru_add_page(struct list_lru *lru, struct page *page, struct=
 list_head *item);
>  /**
>   * list_lru_del: delete an element to the lru list
>   * @list_lru: the lru pointer
> @@ -102,6 +114,18 @@ bool list_lru_add(struct list_lru *lru, struct lis=
t_head *item);
>   */
>  bool list_lru_del(struct list_lru *lru, struct list_head *item);
>
> +/**
> + * list_lru_del_page: delete an element to the lru list
> + * @list_lru: the lru pointer
> + * @page: the page containing the item
> + * @item: the item to be deleted.
> + *
> + * This function works the same as list_lru_del in terms of list
> + * manipulation. Used for non slab objects contained in the page.
> + *
> + * Return value: true if the list was updated, false otherwise
> + */
> +bool list_lru_del_page(struct list_lru *lru, struct page *page, struct=
 list_head *item);
>  /**
>   * list_lru_count_one: return the number of objects currently held by =
@lru
>   * @lru: the lru pointer.
> diff --git a/include/linux/mm_types.h b/include/linux/mm_types.h
> index cf97f3884fda..05667a2030c0 100644
> --- a/include/linux/mm_types.h
> +++ b/include/linux/mm_types.h
> @@ -151,6 +151,11 @@ struct page {
>  			/* For both global and memcg */
>  			struct list_head deferred_list;
>  		};
> +		struct { /* Third tail page of compound page */
> +			unsigned long _compound_pad_3; /* compound_head */
> +			unsigned long _compound_pad_4;
> +			struct list_head underutilized_thp_list;
> +		};
>  		struct {	/* Page table pages */
>  			unsigned long _pt_pad_1;	/* compound_head */
>  			pgtable_t pmd_huge_pte; /* protected by page->ptl */
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index 0f774a7c0727..03dc42eba0ba 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -8,6 +8,7 @@
>  #include <linux/mm.h>
>  #include <linux/sched.h>
>  #include <linux/sched/mm.h>
> +#include <linux/sched/clock.h>
>  #include <linux/sched/coredump.h>
>  #include <linux/sched/numa_balancing.h>
>  #include <linux/highmem.h>
> @@ -85,6 +86,8 @@ static atomic_t huge_zero_refcount;
>  struct page *huge_zero_page __read_mostly;
>  unsigned long huge_zero_pfn __read_mostly =3D ~0UL;
>
> +struct list_lru huge_low_util_page_lru;
> +
>  static void thp_utilization_workfn(struct work_struct *work);
>  static DECLARE_DELAYED_WORK(thp_utilization_work, thp_utilization_work=
fn);
>
> @@ -269,6 +272,46 @@ static struct shrinker huge_zero_page_shrinker =3D=
 {
>  	.seeks =3D DEFAULT_SEEKS,
>  };
>
> +static enum lru_status low_util_free_page(struct list_head *item,
> +					  struct list_lru_one *lru,
> +					  spinlock_t *lock,
> +					  void *cb_arg)
> +{
> +	struct page *head =3D compound_head(list_entry(item,
> +									struct page,
> +									underutilized_thp_list));
> +
> +	if (get_page_unless_zero(head)) {
> +		lock_page(head);
> +		list_lru_isolate(lru, item);
> +		split_huge_page(head);
> +		unlock_page(head);
> +		put_page(head);
> +	}
> +
> +	return LRU_REMOVED_RETRY;
> +}
> +
> +static unsigned long shrink_huge_low_util_page_count(struct shrinker *=
shrink,
> +						     struct shrink_control *sc)
> +{
> +	return list_lru_shrink_count(&huge_low_util_page_lru, sc);
> +}
> +
> +static unsigned long shrink_huge_low_util_page_scan(struct shrinker *s=
hrink,
> +						    struct shrink_control *sc)
> +{
> +	return list_lru_shrink_walk(&huge_low_util_page_lru, sc, low_util_fre=
e_page, NULL);
> +}
> +
> +static struct shrinker huge_low_util_page_shrinker =3D {
> +	.count_objects =3D shrink_huge_low_util_page_count,
> +	.scan_objects =3D shrink_huge_low_util_page_scan,
> +	.seeks =3D DEFAULT_SEEKS,
> +	.flags =3D SHRINKER_NUMA_AWARE | SHRINKER_MEMCG_AWARE |
> +		SHRINKER_NONSLAB,
> +};
> +
>  #ifdef CONFIG_SYSFS
>  static ssize_t enabled_show(struct kobject *kobj,
>  			    struct kobj_attribute *attr, char *buf)
> @@ -521,13 +564,18 @@ static int __init hugepage_init(void)
>  		goto err_slab;
>
>  	schedule_delayed_work(&thp_utilization_work, HZ);
> +	err =3D register_shrinker(&huge_low_util_page_shrinker, "thp-low-util=
");
> +	if (err)
> +		goto err_low_util_shrinker;
>  	err =3D register_shrinker(&huge_zero_page_shrinker, "thp-zero");
>  	if (err)
>  		goto err_hzp_shrinker;
>  	err =3D register_shrinker(&deferred_split_shrinker, "thp-deferred_spl=
it");
>  	if (err)
>  		goto err_split_shrinker;
> -
> +	err =3D list_lru_init_memcg(&huge_low_util_page_lru, &huge_low_util_p=
age_shrinker);
> +	if (err)
> +		goto err_low_util_list_lru;
>  	/*
>  	 * By default disable transparent hugepages on smaller systems,
>  	 * where the extra memory used could hurt more than TLB overhead
> @@ -543,11 +591,16 @@ static int __init hugepage_init(void)
>  		goto err_khugepaged;
>
>  	return 0;
> +
>  err_khugepaged:
> +	list_lru_destroy(&huge_low_util_page_lru);
> +err_low_util_list_lru:
>  	unregister_shrinker(&deferred_split_shrinker);
>  err_split_shrinker:
>  	unregister_shrinker(&huge_zero_page_shrinker);
>  err_hzp_shrinker:
> +	unregister_shrinker(&huge_low_util_page_shrinker);
> +err_low_util_shrinker:
>  	khugepaged_destroy();
>  err_slab:
>  	hugepage_exit_sysfs(hugepage_kobj);
> @@ -622,6 +675,7 @@ void prep_transhuge_page(struct page *page)
>  	 */
>
>  	INIT_LIST_HEAD(page_deferred_list(page));
> +	INIT_LIST_HEAD(page_underutilized_thp_list(page));
>  	set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
>  }
>
> @@ -2491,8 +2545,7 @@ static void __split_huge_page_tail(struct page *h=
ead, int tail,
>  			 (1L << PG_dirty)));
>
>  	/* ->mapping in first tail page is compound_mapcount */
> -	VM_BUG_ON_PAGE(tail > 2 && page_tail->mapping !=3D TAIL_MAPPING,
> -			page_tail);
> +	VM_BUG_ON_PAGE(tail > 3 && page_tail->mapping !=3D TAIL_MAPPING, page=
_tail);
>  	page_tail->mapping =3D head->mapping;
>  	page_tail->index =3D head->index + tail;
>  	page_tail->private =3D 0;
> @@ -2698,6 +2751,7 @@ int split_huge_page_to_list(struct page *page, st=
ruct list_head *list)
>  	struct folio *folio =3D page_folio(page);
>  	struct page *head =3D &folio->page;
>  	struct deferred_split *ds_queue =3D get_deferred_split_queue(head);
> +	struct list_head *underutilized_thp_list =3D page_underutilized_thp_l=
ist(head);
>  	XA_STATE(xas, &head->mapping->i_pages, head->index);
>  	struct anon_vma *anon_vma =3D NULL;
>  	struct address_space *mapping =3D NULL;
> @@ -2796,6 +2850,8 @@ int split_huge_page_to_list(struct page *page, st=
ruct list_head *list)
>  			list_del(page_deferred_list(head));
>  		}
>  		spin_unlock(&ds_queue->split_queue_lock);
> +		if (!list_empty(underutilized_thp_list))
> +			list_lru_del_page(&huge_low_util_page_lru, head, underutilized_thp_=
list);
>  		if (mapping) {
>  			int nr =3D thp_nr_pages(head);
>
> @@ -2838,6 +2894,7 @@ int split_huge_page_to_list(struct page *page, st=
ruct list_head *list)
>  void free_transhuge_page(struct page *page)
>  {
>  	struct deferred_split *ds_queue =3D get_deferred_split_queue(page);
> +	struct list_head *underutilized_thp_list =3D page_underutilized_thp_l=
ist(page);
>  	unsigned long flags;
>
>  	spin_lock_irqsave(&ds_queue->split_queue_lock, flags);
> @@ -2846,6 +2903,12 @@ void free_transhuge_page(struct page *page)
>  		list_del(page_deferred_list(page));
>  	}
>  	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
> +	if (!list_empty(underutilized_thp_list))
> +		list_lru_del_page(&huge_low_util_page_lru, page, underutilized_thp_l=
ist);
> +
> +	if (PageLRU(page))
> +		__clear_page_lru_flags(page);
> +
>  	free_compound_page(page);
>  }
>
> @@ -2886,6 +2949,26 @@ void deferred_split_huge_page(struct page *page)=

>  	spin_unlock_irqrestore(&ds_queue->split_queue_lock, flags);
>  }
>
> +void add_underutilized_thp(struct page *page)
> +{
> +	VM_BUG_ON_PAGE(!PageTransHuge(page), page);
> +
> +	if (PageSwapCache(page))
> +		return;
> +
> +	/*
> +	 * Need to take a reference on the page to prevent the page from gett=
ing free'd from
> +	 * under us while we are adding the THP to the shrinker.
> +	 */
> +	if (!get_page_unless_zero(page))
> +		return;
> +
> +	if (!is_huge_zero_page(page) && is_anon_transparent_hugepage(page))
> +		list_lru_add_page(&huge_low_util_page_lru, page, page_underutilized_=
thp_list(page));
> +
> +	put_page(page);
> +}
> +
>  static unsigned long deferred_split_count(struct shrinker *shrink,
>  		struct shrink_control *sc)
>  {
> @@ -3424,6 +3507,9 @@ static void thp_util_scan(unsigned long pfn_end)
>  		/* Group THPs into utilization buckets */
>  		bucket =3D num_utilized_pages * THP_UTIL_BUCKET_NR / HPAGE_PMD_NR;
>  		bucket =3D min(bucket, THP_UTIL_BUCKET_NR - 1);
> +		if (bucket =3D=3D 0)
> +			add_underutilized_thp(page);
> +
>  		thp_scan.buckets[bucket].nr_thps++;
>  		thp_scan.buckets[bucket].nr_zero_pages +=3D (HPAGE_PMD_NR - num_util=
ized_pages);
>  	}
> diff --git a/mm/list_lru.c b/mm/list_lru.c
> index a05e5bef3b40..7e8b324cc840 100644
> --- a/mm/list_lru.c
> +++ b/mm/list_lru.c
> @@ -140,6 +140,32 @@ bool list_lru_add(struct list_lru *lru, struct lis=
t_head *item)
>  }
>  EXPORT_SYMBOL_GPL(list_lru_add);
>
> +bool list_lru_add_page(struct list_lru *lru, struct page *page, struct=
 list_head *item)
> +{
> +	int nid =3D page_to_nid(page);
> +	struct list_lru_node *nlru =3D &lru->node[nid];
> +	struct list_lru_one *l;
> +	struct mem_cgroup *memcg;
> +
> +	spin_lock(&nlru->lock);
> +	if (list_empty(item)) {
> +		memcg =3D page_memcg(page);
> +		memcg_list_lru_alloc(memcg, lru, GFP_KERNEL);
> +		l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
> +		list_add_tail(item, &l->list);
> +		/* Set shrinker bit if the first element was added */
> +		if (!l->nr_items++)
> +			set_shrinker_bit(memcg, nid,
> +					 lru_shrinker_id(lru));
> +		nlru->nr_items++;
> +		spin_unlock(&nlru->lock);
> +		return true;
> +	}
> +	spin_unlock(&nlru->lock);
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(list_lru_add_page);
> +
>  bool list_lru_del(struct list_lru *lru, struct list_head *item)
>  {
>  	int nid =3D page_to_nid(virt_to_page(item));
> @@ -160,6 +186,29 @@ bool list_lru_del(struct list_lru *lru, struct lis=
t_head *item)
>  }
>  EXPORT_SYMBOL_GPL(list_lru_del);
>
> +bool list_lru_del_page(struct list_lru *lru, struct page *page, struct=
 list_head *item)
> +{
> +	int nid =3D page_to_nid(page);
> +	struct list_lru_node *nlru =3D &lru->node[nid];
> +	struct list_lru_one *l;
> +	struct mem_cgroup *memcg;
> +
> +	spin_lock(&nlru->lock);
> +	if (!list_empty(item)) {
> +		memcg =3D page_memcg(page);
> +		memcg_list_lru_alloc(memcg, lru, GFP_KERNEL);
> +		l =3D list_lru_from_memcg_idx(lru, nid, memcg_kmem_id(memcg));
> +		list_del_init(item);
> +		l->nr_items--;
> +		nlru->nr_items--;
> +		spin_unlock(&nlru->lock);
> +		return true;
> +	}
> +	spin_unlock(&nlru->lock);
> +	return false;
> +}
> +EXPORT_SYMBOL_GPL(list_lru_del_page);
> +
>  void list_lru_isolate(struct list_lru_one *list, struct list_head *ite=
m)
>  {
>  	list_del_init(item);
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index e5486d47406e..a2a33b4d71db 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1327,6 +1327,12 @@ static int free_tail_pages_check(struct page *he=
ad_page, struct page *page)
>  		 * deferred_list.next -- ignore value.
>  		 */
>  		break;
> +	case 3:
> +		/*
> +		 * the third tail page: ->mapping is
> +		 * underutilized_thp_list.next -- ignore value.
> +		 */
> +		break;
>  	default:
>  		if (page->mapping !=3D TAIL_MAPPING) {
>  			bad_page(page, "corrupted mapping in tail page");
> -- =

> 2.30.2


--
Best Regards,
Yan, Zi

--=_MailMate_2CB5A647-8E00-4DAB-BB7B-7F058B445749_=
Content-Description: OpenPGP digital signature
Content-Disposition: attachment; filename=signature.asc
Content-Type: application/pgp-signature; name=signature.asc

-----BEGIN PGP SIGNATURE-----

iQJDBAEBCgAtFiEEh7yFAW3gwjwQ4C9anbJR82th+ooFAmMJZJQPHHppeUBudmlk
aWEuY29tAAoJEJ2yUfNrYfqKAWEP/jLxA8apFYxLImWk4IxfqSa/mB+ktvPPKIOV
Qef752r5j6ZAjagCN0+WMram/opM1E3i+v8jIfclpjBpRpHTgwppBxOPDqVw7RNl
A6atl2ITZxpdgJyUNs8igy/sQPvR1CY4sRGKcKHt0xO1lyenZ/JTkRdd+wtbUq9+
5o37Th1a05uA7hhhYrgRuLdou588GWYR9MSIQHEX9HK94/yPGUWzkiARbHofDncX
Vb3/bPh8sbQythm2dVozjj1s8YV5iPP/1oJyTmVWDJksJrfskZeqelpkiw8RiyFa
mUOQGxd2tRcjk1SGw3S6s68V29aaUkGR4DrOu1m1aNb59+poJOEgQFHZutV2n9yU
3ioBhS39aLV9FP+aOVswVyotgzny52B88/QllAUFsBx8d5WCuIRk70YmaPgt8KYd
0HZhJmCU3tkQhw74R5AA2HJlJDAs2uYCoK79gCddufb4FiGqk/kw/Kln1m/2vOYf
awE7mGhAO2kfcNEEHcu27XTVaIkNvtFVF/+hcqboUKlPs652ozSeO9n3TCBp1EFp
O/8zaQVxYDMUi3ZTBxi5UUV04F3Gm2Sov4tjU09iFDfd26wznWvu6oddOu2JAV7R
hoWLkIzb66WP7cFtIeVAJeYmFFm+K5YiVz75USJdvSp6ThUQM8nVbR9mGEhL7bGW
sfoBnk93
=4D/r
-----END PGP SIGNATURE-----

--=_MailMate_2CB5A647-8E00-4DAB-BB7B-7F058B445749_=--
