Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 073A24C1153
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Feb 2022 12:33:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239928AbiBWLdd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Feb 2022 06:33:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239905AbiBWLdZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Feb 2022 06:33:25 -0500
Received: from mga03.intel.com (mga03.intel.com [134.134.136.65])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CF1B38BC1
        for <linux-kernel@vger.kernel.org>; Wed, 23 Feb 2022 03:32:56 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645615976; x=1677151976;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=2a63wU3scb2T8pAc8pJj210pZFkOjJ9UzhgYpUmFgqM=;
  b=WMdi5p5tWtj2n0OYmmu4z35GwMRok8F6xBhFssqHnGl8ErC+rpAtM6dO
   /+B7JZxPb7PCAg6lkTs9NSVdXa+tjO6wqMmuliwJDARFhoYYKwE15Fxq1
   PuOjSq2l8QcaluajdfasWstfzC+mXff9waPNGKKRQ+kVNtuWjEZ4BGfek
   nS6H7acmLeaT+b2xYZgSGvHw8L9tshtc5o2KCRSvPnM59Z5Wkq1CbGfIf
   2zYvubq0e4q8hWEtdRKKMF9RJS3k1KI/ti9UvJelK7sUGr69wc2XgHTOk
   ZNDH9nwP0StjjN3zaS+DnwcEym5woY+dqqKD+I3pNY1OEl/HyQJHXyIzr
   g==;
X-IronPort-AV: E=McAfee;i="6200,9189,10266"; a="251862204"
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="251862204"
Received: from orsmga008.jf.intel.com ([10.7.209.65])
  by orsmga103.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Feb 2022 03:32:55 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,390,1635231600"; 
   d="scan'208";a="548203216"
Received: from orsmsx606.amr.corp.intel.com ([10.22.229.19])
  by orsmga008.jf.intel.com with ESMTP; 23 Feb 2022 03:32:55 -0800
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX606.amr.corp.intel.com (10.22.229.19) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Wed, 23 Feb 2022 03:32:55 -0800
Received: from orsmsx601.amr.corp.intel.com (10.22.229.14) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Wed, 23 Feb 2022 03:32:55 -0800
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21 via Frontend Transport; Wed, 23 Feb 2022 03:32:55 -0800
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.172)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Wed, 23 Feb 2022 03:32:54 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=QqseRzM8YzFIfK2MqBZXxVPaEvD50WJnquvg2lrPsL/9+uFpF9snGL8wNAugpYQj2A4dQYSs9fwodsdE79F8eKGqR2qU9OTRAIDORZXnH8xoqvga17bdvEriOBP+Fy05IfvOrZIVQ5owe7r2ypkseCmq+p8eaLL0t/KySiacgiDQx7dQQjk8CSg4MO3AWVq2Ovmb/zm9vUCASdITFaNeUOKtMgqf7WmeNvo/qDuS73jZ6iPJGNPDCUNOteb8VDQa467zqmOT90Dz61gftliuVmz+KKW0NLUkPc/CC5Z4fRHwDUGikeJCSUOVD+nNfuAh41Sjv9m5vFHoPoH4ycxfpg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JrjjcVG393IJVweGiIXW9N4DwVd3bSk6NJsfgQzSdEY=;
 b=MZ5P+VThTbrDg1daErmHc0UDDWs1VJPk2lNQ/tpiO1XLw9Vt22ifQgs10bMEEHWwArphjkM487aw4LiM4DtbZ4aifNJspDZSi4d/4U0iY/s9Eu37KljmPkRUjVpY12Dd3DJbwht3VrVWAuie84J8yh6CllgkfWz9WVHvYaiNJby2BV0F4ZmmtCrNObb2Gb+5Fhj8JjcGF+XaTGP9axtq0eDAtRLi9OrptFznjqGQLgXy7PbzURRdi0bN7RDswS1nCZoHzFtM+ATZexyOlrV14ZMFnwt08vLjJ8D/hHu23quFkq9RNfyYf44wT21SWbir62a594sSUh5AGDQqgzzKKw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by MW4PR11MB5872.namprd11.prod.outlook.com (2603:10b6:303:169::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5017.22; Wed, 23 Feb
 2022 11:32:52 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b%6]) with mapi id 15.20.4995.027; Wed, 23 Feb 2022
 11:32:52 +0000
Date:   Wed, 23 Feb 2022 19:32:49 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 1/1] mm/page_alloc: Do not prefetch buddies during bulk
 free
Message-ID: <YhYbYUqJLwJ4IrCc@ziqianlu-nuc9qn>
References: <20220221094119.15282-1-mgorman@techsingularity.net>
 <20220221094119.15282-2-mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220221094119.15282-2-mgorman@techsingularity.net>
X-ClientProxiedBy: HK2PR02CA0135.apcprd02.prod.outlook.com
 (2603:1096:202:16::19) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 403926b5-5cea-4741-95ed-08d9f6c03a7d
X-MS-TrafficTypeDiagnostic: MW4PR11MB5872:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <MW4PR11MB58727315E759EF9ECA3DC8008B3C9@MW4PR11MB5872.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Qh5wF94skRn7i3adnlfydgkHqQBp6rtk9BObsvluTlEhrpTOUlqy2Zs+IYHB8zABSVgdwC8GAnTzTdSMj7sr12lyLRIDCY69FEMKgGaRp1wXYwY22kZQi+RzrPjF9mz28QdOBXKeEu16dyLZf/JeFKe9OjMCPyrmfdniE4c/4iIvw/2jP3rAFOmXebxt3FBdIZRDYFygLgIxZnh0dWhfSzDpkq88Bh8ml+LCBVvcDBFs4+EQ1Swhi0a7lGHhjwhWZiuyOQSkW6XLiwfFI1l6CV0XSX3ivCWQA0U+Zj+3AidX9WdeSo2d4GouLdEz8nFrhHed1hBE7C3ldvNlNOCSLYZS/K8eIANvmkLCjDBhQTNejm+SEgQaRdFwvnxDApXNzsk7NYYn+WRaeD4WOjR4o8sqt7oRPsl3R9DGnLav2hGh56RBF5kOfTsM0Bk/keNRT5MQpCIZsbS1jfRZozaULYeb3BTKu6oSQi8e3b3VjnSHm6zUlwCcwDi1RNItgjzrRqWqY3p3eb46MazXFuE7MoXn0bOCTqttDT822jFjjsaJZgN/5BshfWTTlwlBDBm61kO8IcHICV79liyLxbr4nTsoY5yHccxnqeis7po75M6gA2q0KtZdqu0JI6s3ozU9utGfmM4mAGt2svd4gZ2e+g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(38100700002)(8676002)(66556008)(4326008)(316002)(6916009)(66946007)(66476007)(508600001)(54906003)(6486002)(86362001)(82960400001)(186003)(26005)(6666004)(9686003)(83380400001)(6506007)(6512007)(44832011)(5660300002)(33716001)(2906002)(8936002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?LJL/afzawKL0DLll0MTiK5vtiVDAKyaUqbs7zpk501DjVykX7kWdqP2LqlNY?=
 =?us-ascii?Q?4rKm29yK4QsBOfqsMZQNNPzGxRwbCZYl+Ke40eBq9TZhVYoEeyUCRWOgHXMe?=
 =?us-ascii?Q?ZzJd1USZmm3fFVtx4UFj+icBXyM7ugaTDQ+wiREQnZCTYnKNnoX+1II+yBRL?=
 =?us-ascii?Q?bfaAbTZB9oQAP4n+f4mdMSawp3stVgsw8P+nGfPb6pBA3Pf9TJrqMquViHkh?=
 =?us-ascii?Q?remklZB3lapeU3gwqJ4x1IQWys9N9DxbV/0Hwzg9CwIdcOJQrrlFtbtUVlQi?=
 =?us-ascii?Q?wU67Jfax134crigHsacfLo43fBwcKMx+YJZquKuKYHzpIC5pd3tNYuV1qFAz?=
 =?us-ascii?Q?3BloheqlAEzdB8zh1VpZRkKfFT6iXA3ClnnHZeI4j5Zy3R/X6rZsoSOyaptf?=
 =?us-ascii?Q?lxp2OXrrf3NS3qV7Z5WjI1ka5JHiqdeq8TaWMRxRu9R5tCG8OkHO/S+unnif?=
 =?us-ascii?Q?zLSZ9Miv4BbTN8FFOxENQk/Zb3q268dyATuf3gu+lgwPKWf0kB43i6I8N6K+?=
 =?us-ascii?Q?GSZtx7PAQnwY8YuxGtSQHGb1WfWrsjE0clThgDyRJnbk/ZLm8Nde6haH6DJ6?=
 =?us-ascii?Q?kTpi2FA6yLHiMloO7Ud0R8ClO7chbygbbFKoxLfPUtYuuE0P2j5bIcC7iRgA?=
 =?us-ascii?Q?dNRLNdiIY59TnDOn7uiMGuoStQ2vxPvDhasBLrBEVVcw/ugbp6xpYMMEG4XN?=
 =?us-ascii?Q?tkmWZ9xbbbL41MuUDEqf0XsZz7jrtRhfXt3/SMtxDHhUZfjxke2gd3HiD9EZ?=
 =?us-ascii?Q?9XyZDHAwy2RxaaICUbQvIPwC9g2UAWHMVO1W3UfJNa9co5ecwGkAEOJdJSEV?=
 =?us-ascii?Q?xnfS+CK/n19bQleeE7oJtLwKt146NKM8lbFhfH03kfWMX45zpq7cLs3wxgxO?=
 =?us-ascii?Q?lqG3jqx6atcDaav6VEsDybX1Kti2XuO5y5lKxmdmzUY3xyNfC5UXfj5qr4ZQ?=
 =?us-ascii?Q?YVbpziRRRl6k3YpfzWULzZiksAO4Q3Z9wSDwblwmy1yCXkwbOhzYW/UJqbok?=
 =?us-ascii?Q?Kv+d+pDCpFhcnOKOj0S+oChkAZdY0vJwl4KIvrhPwYIro64VrPpkOED2xBzJ?=
 =?us-ascii?Q?NkrrIuV7p4gmI3UBKvGbHGvuEN2Hy5Ch5Sreqbpjh6YCFjPRE7kNfmdgpC7j?=
 =?us-ascii?Q?Aj/C+a9Sr5HqLB3k07ZzzxYEuCHRB6lb7rR+IrmTkgG8bF7C2M455Ng2pitB?=
 =?us-ascii?Q?2h0FIMyPxma3REf0h7FunbA97sKJEaYO4gjhzGxieJnMIzqzUDe3N6C2QJDu?=
 =?us-ascii?Q?02uT6oYewycANdGr+ssbiSdtIZtcLFuprJcWKgsL+ndi0YuGv+py/5+QWSMg?=
 =?us-ascii?Q?2SWn693chUr+wVkownEgG3MNHk09iFOzeqrWSOkKa27A/4V3agNamYtsWK7t?=
 =?us-ascii?Q?HI/34/tH+tWeBJPRbru+B4MCeD+YDz+jBUu4D2aYEPQmZrp8MOgg2R1YclGR?=
 =?us-ascii?Q?jPNbwUbkNpo8YMIYw8pLVjJELljY3IL8rym+EBVuwvKE3A1kux8anGAbIBj4?=
 =?us-ascii?Q?Cx/ZG/uy3fue8zmnS3eyxsSExuO8aBrV5flpLBbHGko2wUKTdFeszhykxoOE?=
 =?us-ascii?Q?GjrI1Ekk7OrYSa6V/3zktnieVLQL2KOd9t5Wx9RFyvTs5vg2i4HBJMs+oLcS?=
 =?us-ascii?Q?NAS/u3ZUoHp1Oma6lhs2468=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 403926b5-5cea-4741-95ed-08d9f6c03a7d
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Feb 2022 11:32:52.6192
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w9mAmJZgJwXHTufEnX/6htSD9cPuD2Lfhkk2SJUALPfoSxzBBS/HgiJd8sV8j7r8AqCmK+zmQPw6XLpRDaqHTg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB5872
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Feb 21, 2022 at 09:41:19AM +0000, Mel Gorman wrote:
> free_pcppages_bulk() has taken two passes through the pcp lists since
> commit 0a5f4e5b4562 ("mm/free_pcppages_bulk: do not hold lock when picking
> pages to free") due to deferring the cost of selecting PCP lists until
> the zone lock is held.
> 
> As the list processing now takes place under the zone lock, it's less
> clear that this will always benefit for two reasons.
> 
> 1. There is a guaranteed cost to calculating the buddy which definitely
>    has to be calculated again. However, as the zone lock is held and
>    there is no deferring of buddy merging, there is no guarantee that the
>    prefetch will have completed when the second buddy calculation takes
>    place and buddies are being merged.  With or without the prefetch, there
>    may be further stalls depending on how many pages get merged. In other
>    words, a stall due to merging is inevitable and at best only one stall
>    might be avoided at the cost of calculating the buddy location twice.
> 
> 2. As the zone lock is held, prefetch_nr makes less sense as once
>    prefetch_nr expires, the cache lines of interest have already been
>    merged.
> 
> The main concern is that there is a definite cost to calculating the
> buddy location early for the prefetch and it is a "maybe win" depending
> on whether the CPU prefetch logic and memory is fast enough. Remove the
> prefetch logic on the basis that reduced instructions in a path is always
> a saving where as the prefetch might save one memory stall depending on
> the CPU and memory.
> 
> In most cases, this has marginal benefit as the calculations are a small
> part of the overall freeing of pages. However, it was detectable on at
> least one machine.
> 
>                               5.17.0-rc3             5.17.0-rc3
>                     mm-highpcplimit-v2r1     mm-noprefetch-v1r1
> Min       elapsed      630.00 (   0.00%)      610.00 (   3.17%)
> Amean     elapsed      639.00 (   0.00%)      623.00 *   2.50%*
> Max       elapsed      660.00 (   0.00%)      660.00 (   0.00%)
> 
> Suggested-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>

Reviewed-by: Aaron Lu <aaron.lu@intel.com>

Thanks,
Aaron

> ---
>  mm/page_alloc.c | 24 ------------------------
>  1 file changed, 24 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index de9f072d23bd..2d5cc098136d 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1432,15 +1432,6 @@ static bool bulkfree_pcp_prepare(struct page *page)
>  }
>  #endif /* CONFIG_DEBUG_VM */
>  
> -static inline void prefetch_buddy(struct page *page, unsigned int order)
> -{
> -	unsigned long pfn = page_to_pfn(page);
> -	unsigned long buddy_pfn = __find_buddy_pfn(pfn, order);
> -	struct page *buddy = page + (buddy_pfn - pfn);
> -
> -	prefetch(buddy);
> -}
> -
>  /*
>   * Frees a number of pages from the PCP lists
>   * Assumes all pages on list are in same zone.
> @@ -1453,7 +1444,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	int min_pindex = 0;
>  	int max_pindex = NR_PCP_LISTS - 1;
>  	unsigned int order;
> -	int prefetch_nr = READ_ONCE(pcp->batch);
>  	bool isolated_pageblocks;
>  	struct page *page;
>  
> @@ -1508,20 +1498,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			if (bulkfree_pcp_prepare(page))
>  				continue;
>  
> -			/*
> -			 * We are going to put the page back to the global
> -			 * pool, prefetch its buddy to speed up later access
> -			 * under zone->lock. It is believed the overhead of
> -			 * an additional test and calculating buddy_pfn here
> -			 * can be offset by reduced memory latency later. To
> -			 * avoid excessive prefetching due to large count, only
> -			 * prefetch buddy for the first pcp->batch nr of pages.
> -			 */
> -			if (prefetch_nr) {
> -				prefetch_buddy(page, order);
> -				prefetch_nr--;
> -			}
> -
>  			/* MIGRATE_ISOLATE page should not go to pcplists */
>  			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
>  			/* Pageblock could have been isolated meanwhile */
> -- 
> 2.26.2
> 
