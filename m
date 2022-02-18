Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A62E54BB1CA
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 07:08:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231202AbiBRGIS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 01:08:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:45178 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229745AbiBRGIK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 01:08:10 -0500
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ABF5565AD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Feb 2022 22:07:54 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645164474; x=1676700474;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=hheLX4RZ/F0ATOxbce9B9cSJ5TEeP4wR7Cko5Vz8x3k=;
  b=AB6pRxRNRXjLHkPJzGmp5zoX11GQWAuZcCqyD2KRVaWv4xJ9gnEt49sI
   WExpZlWqtdDTifdp126DDZ9+Mv4JYE45QH4W9XYTp3vOXmn/YU/Tip1/I
   UYpolsfCOls3lsBa3bz72LIhJUfQ13wtuLZD6XJlPiKGjfYYZmrnW5PzA
   5zSrDDQGveHzJSlvXs0698opMldDRps8laNTHPygzlOoQ/IgkEcmxG+lU
   hKsinyZODz5AqloRVjcUwlIMy4O1r3yGjViH/SlJ6BbFKiGOZ0xndhYN+
   7eYbJYv5YGo6qNNt9SL6FCRAfEB/BiTldNAVSiRtwGmp8mlFn66M2Itr0
   A==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="248655015"
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="248655015"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 17 Feb 2022 22:07:54 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,377,1635231600"; 
   d="scan'208";a="572179713"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by orsmga001.jf.intel.com with ESMTP; 17 Feb 2022 22:07:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 22:07:53 -0800
Received: from fmsmsx611.amr.corp.intel.com (10.18.126.91) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Thu, 17 Feb 2022 22:07:53 -0800
Received: from fmsedg601.ED.cps.intel.com (10.1.192.135) by
 fmsmsx611.amr.corp.intel.com (10.18.126.91) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Thu, 17 Feb 2022 22:07:53 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.108)
 by edgegateway.intel.com (192.55.55.70) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Thu, 17 Feb 2022 22:07:52 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=kKJCQsww3iipJ0N9Vf1QuDfKgPBtQ4DtHjNTxKcelwXnTdc7nXzCi6Hk9nqOXVYg3aUW69F064trKaXVZ6JYjJuKi06aFC7p8ROhwsFHfACdDsOHBFLBJgi45XGwnwysFeNdq3ytqaTS2L9HDKTAzVClUDk/B6w9UE5s0PmoisAM7JZpFCg2LBttWmBApygdYtvpb7iKmVuBo91gTSi5gBsBaAH8QYwCPobZrjvIzqmgJMhoBRNoVPVWO4iZT4pXIA9QfdSbHcF4/SEe+Bp+uu8Izp/aUCf6uvjkwp8rL9ZnUkfVJISA98XpDThigUzR5yszJ3B4Feagv3+QG2ByFA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=k7W8EuXNFSFKeTRFS+kf1w8ei+7zU3V4qaP6QOKJIpk=;
 b=gvugcnw0KcWf1DiHWM7gL0373VjdytdbbhTVrMdMwvEGGg9C72MaEBuARdGKiSSfy96arkv8LkJrDPnXYfuW3wBiXT+MCZREd1DjkOk3vQFqrx6ZSUyZOfCsoqWRB36+8aCjsSUZw5AYxZpRlVy3K6GSQWYjhWZT4/9/jtSz4CK+wQVerNf94UFX5wqpblCn9AU6G9ODktS+j+q9eo8QMx6F90QRNdR9b18Lk865/vTl5oz5LkKkzmNn5V9IwFJ/R5ghfIRu89CqKTiGwaST04tzZQorZwi8NlS3KjXYjpv4Z0Rr1EAITSp38o6vHwUWTJazP5h/3vRBouDszBgJFQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by DM6PR11MB4675.namprd11.prod.outlook.com (2603:10b6:5:2ac::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.14; Fri, 18 Feb
 2022 06:07:50 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b%6]) with mapi id 15.20.4995.022; Fri, 18 Feb 2022
 06:07:50 +0000
Date:   Fri, 18 Feb 2022 14:07:42 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     Mel Gorman <mgorman@techsingularity.net>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Michal Hocko <mhocko@kernel.org>,
        Jesper Dangaard Brouer <brouer@redhat.com>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux-MM <linux-mm@kvack.org>
Subject: Re: [PATCH 5/6] mm/page_alloc: Free pages in a single pass during
 bulk free
Message-ID: <Yg83rppnpmXPbln4@ziqianlu-nuc9qn>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-6-mgorman@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220217002227.5739-6-mgorman@techsingularity.net>
X-ClientProxiedBy: HK2PR0401CA0024.apcprd04.prod.outlook.com
 (2603:1096:202:2::34) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: dd5c098e-8241-4098-2ede-08d9f2a4fdf2
X-MS-TrafficTypeDiagnostic: DM6PR11MB4675:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <DM6PR11MB4675B85EB89C2354B17E97168B379@DM6PR11MB4675.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7219;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pS/VD8ozIVU/OnjjMmpt4fNjE3eorULpTrSJ1VeVWy/Y1U2er5NWEzyPbjLxTrYAk6/X5xUJXAfT/fcZz1mN06JUvdv6buc777w60V5CkKJby7avZJq0CRMJ4QsX95jGIWLnA5qpE34cYMB6qOBol+6t4Hbcu8qR9QmnSvyMATBhWS5Nj3hd7ImXdTE9vr16ozlr4vhToFuwdRECmNpkxRI2nmAFRlldTUwd+hLPHTxNe6z2mh2QEjDohqCmYLaB+fzA3mqKdzfPPvesrbWEuj5E1tiJ3BcVp43pXQa9EmMxbT/CdivcAFn1gLttpI5uKeHbRRt7w2pvGlaYZZZl4GqVe+L6h8PdvI12OBGzzB78X4PA4748Qt7/IZ+0NE4YCivVxTABlU/oHPnxk4l5rP/JAxEuEX4cJz6B+9upDSbvnE33DI3G3sig0DXWBeVlBz4j1N0jP5RDiLYki/I9zD7Y4BjYKdl04V4vfbPMj0L7/uG2OpJTRn1fM8ahwv20sV3Vr+GHI5BNPt4IWFKpi8as4FjdV1EjV89lhHcLG4RyHvgqlsZErwuZfGZNqhDo3kFfr2e+3eiLG/EP5gN43Dh1CdLo9oXiJjjgVqFgcR7Rz0mM0FfoQ6vLFfGW+FhdbP8pTlr/9mcWC/SIGDcCAA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(6506007)(83380400001)(6916009)(8676002)(4326008)(66476007)(6666004)(66946007)(508600001)(66556008)(6486002)(6512007)(9686003)(33716001)(5660300002)(8936002)(26005)(186003)(82960400001)(316002)(2906002)(38100700002)(86362001)(44832011);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1cpsBq/GJkUmpfDdxtJAAmGFEPvtUnbreHMwwandX05DJi8n42OI1vQHFJ6n?=
 =?us-ascii?Q?FTj12FoLs4NGbyyDz/Ok9G6vSGaBRpMyOVkF/yjxhLdX9TSiA/4dp1gO3lXh?=
 =?us-ascii?Q?GivNfKVDg6eEW8WSlKDtJBvj+nMsWwaZBPPefu0u42JT7R8HdSjgRwAFnV2H?=
 =?us-ascii?Q?/DCSkLvfhHX/hYZSJnP+pxUVIczsI+Z9fkxiWRju/XxzvuLyYrMFrie1A9t8?=
 =?us-ascii?Q?LjE30kc89wWKMRmT7z2pjYM3AHg8Go36q3oQ/iMmKOS4E0g7SOObaNsLiZV5?=
 =?us-ascii?Q?6krvQNpRNB0BsfJpST/dZWx3FraS3oT0/3LgKTXJiPBr1k0WtMGdaGwTdZ2Y?=
 =?us-ascii?Q?sYPKJcrNbmHHoo8vSGfISx6N79QgTRoRCh9nepLcYD3rEemQfXr5nPt1oFkT?=
 =?us-ascii?Q?byFZoK4KHv2NqHP1bmdYDg4CZwog5AS5Ts9b8h0zZduTtlbyNRZy1i54XBv3?=
 =?us-ascii?Q?MmzT3l4+ulvADqcNlDRcgPiO+GjIRzeIUwlWofpygH8TeL4G9ItNsb62aAPh?=
 =?us-ascii?Q?qGI6WoKhbm7jCQgzg1r5bbfBNfOoaXHzlFvYlm7pmcg62P8Qg/zWZgiQSoED?=
 =?us-ascii?Q?8QRi1smR77cfVgxrXwyTb+A9UaJFbNLmLg33QhaOrXHQi8k4hR5wZaRb+YKQ?=
 =?us-ascii?Q?HFFWKmoP5XbTX6M3IeZvZC2fV1LxnP0S22MlhvxvFut57MjT+fvNNM/VaIlP?=
 =?us-ascii?Q?0rURviusP5j3PO05BstRVgEcCP4CcAR2UIf69PDuIM5PftPnaivrgDAxrjIg?=
 =?us-ascii?Q?RezXIL5LGIRSu38rU9PMohyCNl2BZVeZaxEGofmVVCZ81pA2SuMBLbugPaEa?=
 =?us-ascii?Q?dZU0hdwn7+5bBJJMSqz2QPrvTHvH2e4pHQq25AxoAfv+DgIKNXbSU4HLK+sA?=
 =?us-ascii?Q?qr06PS5FGETQr0W2kIFUI4dbR5qikQGxmFnfp6xJJiFMwEVvJo7rgVRzeuqv?=
 =?us-ascii?Q?GVF5RaLgmSrhXl3z7hEkUHchtLNnFQK2WRFvtiPep8wJywrGqEXBZ8tPSK0I?=
 =?us-ascii?Q?6+ECybPIIeYG7Wc3H9rkyPVMnaYzwPc9C2qVPsTpM3tCanmDGhGgKPNVgr1m?=
 =?us-ascii?Q?odcZArGEiS8wWXB8HOY1poeOkqpVfktUHgmDIY7ALdtbs1pNiguZ6mbsIfMV?=
 =?us-ascii?Q?q/1mpZuTecaR3SYI2i+FQXMIKj4QWKy/3ZltnUciRaX8j4y8CpvTZAy3UnAM?=
 =?us-ascii?Q?7MQYiNh6Sxlsw5DBec7Dwgq8t71s72wpFt1V50wiPKHe0hEYSHlbg80KJJfj?=
 =?us-ascii?Q?ZoQs0y+Fj5aM4Y77Yzf7md0fijE3VKcfoyq7J/AlIZ/tErcutBIrhv0SjIfi?=
 =?us-ascii?Q?+qqgulM9Sum9gu2tNAEsNtBUO31OZKmu1Ib1ggxq4RNjPFVbCkw45QB7oBLR?=
 =?us-ascii?Q?v3vo1DhO/yK3TIv4nyHKokpcV2p4weB8GfPsnpL7/IKPDvjBp9CEthku2TlG?=
 =?us-ascii?Q?41XgBGIH+wxVGW1VPNpZoON5KOWn1mNhdUZlEdrkK/J8YFtE4s6xOe3MESqa?=
 =?us-ascii?Q?Kmde9kDG4DqfbGNuEaP9L6ZKNPXR299Qg2KzJ/4w/xbXfC/POMWgfvPleLDY?=
 =?us-ascii?Q?2zLd+9gg5oQKibYvQko/SLOleTgci7y/bkLVtou8fLYs82Z7BN2nh0NTb+ge?=
 =?us-ascii?Q?GQnqslCF6EPso9TcjP9uZxA=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: dd5c098e-8241-4098-2ede-08d9f2a4fdf2
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 06:07:50.2138
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: cbB87HFOtu34vdNiVLxGk5wZuGTVkNg9GSVleaaE19BHFsazTSMxk8VFW9tJlQnnlhbWYolGZGj7yiWos48Lvw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR11MB4675
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Feb 17, 2022 at 12:22:26AM +0000, Mel Gorman wrote:

... ...

> ---
>  mm/page_alloc.c | 56 +++++++++++++++++++------------------------------
>  1 file changed, 21 insertions(+), 35 deletions(-)
> 
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 635a4e0f70b4..68e2132717c5 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -1455,8 +1455,7 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	unsigned int order;
>  	int prefetch_nr = READ_ONCE(pcp->batch);
>  	bool isolated_pageblocks;
> -	struct page *page, *tmp;
> -	LIST_HEAD(head);
> +	struct page *page;
>  
>  	/*
>  	 * Ensure proper count is passed which otherwise would stuck in the
> @@ -1467,6 +1466,13 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  	/* Ensure requested pindex is drained first. */
>  	pindex = pindex - 1;
>  
> +	/*
> +	 * local_lock_irq held so equivalent to spin_lock_irqsave for
> +	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
> +	 */
> +	spin_lock(&zone->lock);
> +	isolated_pageblocks = has_isolate_pageblock(zone);
> +
>  	while (count > 0) {
>  		struct list_head *list;
>  		int nr_pages;
> @@ -1489,7 +1495,11 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  		nr_pages = 1 << order;
>  		BUILD_BUG_ON(MAX_ORDER >= (1<<NR_PCP_ORDER_WIDTH));
>  		do {
> +			int mt;
> +
>  			page = list_last_entry(list, struct page, lru);
> +			mt = get_pcppage_migratetype(page);
> +
>  			/* must delete to avoid corrupting pcp list */
>  			list_del(&page->lru);
>  			count -= nr_pages;
> @@ -1498,12 +1508,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  			if (bulkfree_pcp_prepare(page))
>  				continue;
>  
> -			/* Encode order with the migratetype */
> -			page->index <<= NR_PCP_ORDER_WIDTH;
> -			page->index |= order;
> -
> -			list_add_tail(&page->lru, &head);
> -
>  			/*
>  			 * We are going to put the page back to the global
>  			 * pool, prefetch its buddy to speed up later access
> @@ -1517,36 +1521,18 @@ static void free_pcppages_bulk(struct zone *zone, int count,
>  				prefetch_buddy(page, order);
>  				prefetch_nr--;
>  			}

The comment above 'if (prefetch_nr)' says: "We are going to put the page
back to the global pool, prefetch its buddy to speed up later access
under zone->lock..." will have to be modified as the prefetch is now
done inside the lock.

I remember prefetch_buddy()'s original intent is to fetch the buddy
page's 'struct page' before acquiring the zone lock to speed up
operations inside the locked region. Now that the zone lock is acquired
early, whether to still keep the prefetch_buddy() inside the lock
becomes questionable.

After the nr_task=4/16/64 tests finished, I'll also test the effect of
removing prefetch_buddy() here.

Thanks,
Aaron

> -		} while (count > 0 && !list_empty(list));
> -	}
>  
> -	/*
> -	 * local_lock_irq held so equivalent to spin_lock_irqsave for
> -	 * both PREEMPT_RT and non-PREEMPT_RT configurations.
> -	 */
> -	spin_lock(&zone->lock);
> -	isolated_pageblocks = has_isolate_pageblock(zone);
> +			/* MIGRATE_ISOLATE page should not go to pcplists */
> +			VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> +			/* Pageblock could have been isolated meanwhile */
> +			if (unlikely(isolated_pageblocks))
> +				mt = get_pageblock_migratetype(page);
>  
> -	/*
> -	 * Use safe version since after __free_one_page(),
> -	 * page->lru.next will not point to original list.
> -	 */
> -	list_for_each_entry_safe(page, tmp, &head, lru) {
> -		int mt = get_pcppage_migratetype(page);
> -
> -		/* mt has been encoded with the order (see above) */
> -		order = mt & NR_PCP_ORDER_MASK;
> -		mt >>= NR_PCP_ORDER_WIDTH;
> -
> -		/* MIGRATE_ISOLATE page should not go to pcplists */
> -		VM_BUG_ON_PAGE(is_migrate_isolate(mt), page);
> -		/* Pageblock could have been isolated meanwhile */
> -		if (unlikely(isolated_pageblocks))
> -			mt = get_pageblock_migratetype(page);
> -
> -		__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
> -		trace_mm_page_pcpu_drain(page, order, mt);
> +			__free_one_page(page, page_to_pfn(page), zone, order, mt, FPI_NONE);
> +			trace_mm_page_pcpu_drain(page, order, mt);
> +		} while (count > 0 && !list_empty(list));
>  	}
> +
>  	spin_unlock(&zone->lock);
>  }
>  
> -- 
> 2.31.1
> 
