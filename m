Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A964B4BB8F1
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Feb 2022 13:13:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235052AbiBRMNf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Feb 2022 07:13:35 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232493AbiBRMNc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Feb 2022 07:13:32 -0500
Received: from mga18.intel.com (mga18.intel.com [134.134.136.126])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D1FEC25B2C1
        for <linux-kernel@vger.kernel.org>; Fri, 18 Feb 2022 04:13:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1645186395; x=1676722395;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=0FWhpIRDXNyTyVGCPRs9V0KNQTyQYAYuK8x20xHyQl8=;
  b=ii7uji99TPHTjah2YwxARJywAe5SL32RCstzKnTOwemNqH1iFbkN/+IU
   azwNH78+sbKqo0TPYesWBVgzrIUHPuaG9J59AHV64UypGyznBET4/pas3
   wGei9ajCjmF/6qGrm7kWArpPFyuN9arzIQ4laVrYBLDIv/BRbS1E63CEg
   sOpW7OJWg/1oeEF0KS3OFbsv0K22VLxXE2lnHL+R9oQ6xLO27JDlTe76l
   iTct9/WnwH/YEK+9VvuGFQ8hogaIglf4WuVqeevrMNeuzjLF3cuazdCrb
   0vz4ekYL+np/gjLcaJ33q/hekdUx80ZGFrFTxNFKv2MK+prwFteJ7m/wg
   w==;
X-IronPort-AV: E=McAfee;i="6200,9189,10261"; a="234646195"
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="234646195"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga106.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 18 Feb 2022 04:13:15 -0800
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.88,378,1635231600"; 
   d="scan'208";a="637724838"
Received: from fmsmsx606.amr.corp.intel.com ([10.18.126.86])
  by orsmga004.jf.intel.com with ESMTP; 18 Feb 2022 04:13:15 -0800
Received: from fmsmsx610.amr.corp.intel.com (10.18.126.90) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 04:13:14 -0800
Received: from fmsmsx612.amr.corp.intel.com (10.18.126.92) by
 fmsmsx610.amr.corp.intel.com (10.18.126.90) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20; Fri, 18 Feb 2022 04:13:14 -0800
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx612.amr.corp.intel.com (10.18.126.92) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.20 via Frontend Transport; Fri, 18 Feb 2022 04:13:14 -0800
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.109)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.20; Fri, 18 Feb 2022 04:13:13 -0800
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bJUZMmJIBtrUb9HN/e3WfdmHVWSTO1NCH07CrsrxxboyvRHfsxTxhPeeyulmRc4P48TyiSGvU2Pvkwmyf1Jgb6YHcDXlLOrHWE4qeHJYIA6q/ZL9OcFl+MD1Ar5ozvj/R6WVufggej/IiUFjX6crhw4nzEQYsi8whfezmTSjbQqNt5iP0tmtjwJeXRgjePBEnhYETIJRe/2h6I/zlfMcRQmuk5Lunx18ooVo+hc2iZgXroU6YsL2sSDJZnIx/si8ZplSi2IM8gufb2FtXNSdK1rphk/t/ag6n8raz3kKQdDrhwAUK0IQbJX6U+izpdHIbn4CSGTXsnYZulX2lOb4ug==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=fOXZJBQXForZSnT9mEQmVcLf7bdSFEH51QXDXXU9sgo=;
 b=Uaxj+rt6d5+IrsJPKMZxtXVifbzrIkAkgvAOsCsnB9BdPpQmrBTIoILV8bZ1RHyvyFe4/A/Xz3QHPqSuLEPwfwrUzYU9dhTWj/rtNdiMSkzy85tEDQa1rpcW1GuM+yX/8QOpNsLFpGHR/rk7icdvZBjAES0OirQlF79V1UvmB4dHdqd/bolBi5vd3qpP5Rd9UdSWvrpTDgolusxyJ9LQ53rDO+UMK0750kZRR7ZkJEF3ZBYXGL5oFKGzY12yCaJxjuMoCpNl44TsE3FGj9u6LuyrmNIBM+FkN3tLV4j4DwEB3/7raDdCngB485DL5NBr95qrSqGlG34b263G1jclyw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by CH2PR11MB4200.namprd11.prod.outlook.com (2603:10b6:610:3d::33) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4995.17; Fri, 18 Feb
 2022 12:13:11 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::c813:43ec:221:d68b%6]) with mapi id 15.20.4995.024; Fri, 18 Feb 2022
 12:13:11 +0000
Date:   Fri, 18 Feb 2022 20:13:04 +0800
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
Message-ID: <Yg+NUEazDNNtpVzv@ziqianlu-nuc9qn>
References: <20220217002227.5739-1-mgorman@techsingularity.net>
 <20220217002227.5739-6-mgorman@techsingularity.net>
 <Yg83rppnpmXPbln4@ziqianlu-nuc9qn>
 <20220218094716.GY3366@techsingularity.net>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220218094716.GY3366@techsingularity.net>
X-ClientProxiedBy: HKAPR04CA0004.apcprd04.prod.outlook.com
 (2603:1096:203:d0::14) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: e9fa3128-04e6-412e-9b57-08d9f2d807d0
X-MS-TrafficTypeDiagnostic: CH2PR11MB4200:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <CH2PR11MB4200A53195DC7E0AE086DE9B8B379@CH2PR11MB4200.namprd11.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8tBytZaSp2spSc0+pl5R/d3nWP6HLR2uHkdxzuG96A5I6RGanYELMsDWLU9NCR3Q4+7jzWILT5chPoCGz0v3szhb+CXSgp5z5CdeRktITPzYrdz4Q3cs4K1Od/Xl52K0f8aeeXHPi/ET4ktzZtteyt+tVWIA4qWrjxbpBsXT2rUv8jetLh5b15clxuZK/5IuB97CAuV85gQBWctpdI1lzj1PFH5mT7n/0N7KSHhXSi5fAr38qq57V6uPWwaL1ryA9hPNxyzcuEzoybQroQObW1j10Ig2c0Fhkb/eQH+bm3CytWWn0Vq4uGz0pgNnQbTBksGwt6LNLMRuVRyVs6obdUSyXIzw77RtQTmaa8oQpsg37qVu//HohQgy9IfmtagRPvNZNrHAASKIBnRRsbOu5I/EtvT6uwSyrAxb30FoJvnZ7YROKJwopDSItFJaAATok78hNRZxtPkWIFbEJsQ+j+LpF3ofU3jTj09I4rocfCpCEJJe8jC29L7Igh6DgvvziCtQCadc45a3SX/4VcaYjbF+bGE77sojEosUt2GePXOnZdk+qmYMRuPVWFC6O/ZkHtVy1o5zJWK2RTBU74Z1aTvV/p9Jqm9N4+6Qh4FcRx2wiSxyunvtj82YvuOVE/H/7ggLOkxD2Z6j6IFetqMhPG8EjxcotRK4xvOluFfzqDnZaGvU+rppqPm3/Uc1FIhWny8GtIej48JybMwj388mDw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(54906003)(6916009)(6666004)(186003)(26005)(316002)(5660300002)(44832011)(33716001)(82960400001)(86362001)(6506007)(2906002)(9686003)(8936002)(83380400001)(6512007)(6486002)(66556008)(66476007)(8676002)(508600001)(66946007)(38100700002)(4326008)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?P3gDZclgcqoiSvRE3KTQd2Z1OnNtHk4h786dGzvWyqGvYBNja8Y7tH/sSOrY?=
 =?us-ascii?Q?kWxMWQGltwSb+RfrukbidkgzBvVEahhf1+pmJgaYLY6dsNNSd8+5dM4Y1aR9?=
 =?us-ascii?Q?N2x1ae1e44IRjO/3yBl7Q7XBBzuZEQZnNhzOSA/qzzgA0VpfEUYkKiTzzbCC?=
 =?us-ascii?Q?m1REOq5nb/IVSmtw5aUFIegxpTIdsSBXPLc3Ius0JI8TjRcmD2APyRBd0QUM?=
 =?us-ascii?Q?nghWtDkFWHGlLI/xi39P1HpvAIlPcT6XqiuD4VxHVwHv+LbTuoHqITHnGsvo?=
 =?us-ascii?Q?E7N4mzSBXGXak4adFR0utA1P2eoCwca5nSPby4XFotRUxgFviw6t5QPkMBF4?=
 =?us-ascii?Q?JpmuFq+0vvoiMOncyOQ06npRA2BsPYWp7c5dk4VFrpVxT4VsWGaFIUELOkE6?=
 =?us-ascii?Q?jzzUkPj+hkf4KVGiJ8RbGlwqZBEt4W1fj5TiovjyEQ+JGCWqD2YKGgcYQa1E?=
 =?us-ascii?Q?BeXvaGmPzozYV6NuB5RwSJRU5U962gyQpk5q5/5gifBa4gtkTKUc7wZ3tdys?=
 =?us-ascii?Q?G1h5cCn7VCWYnUW3FgqfDA08l15oISRIESvpsv75XkUqmzE3RZx6rbW1dLlA?=
 =?us-ascii?Q?xGpeExYosjdQzqGnJxM0s6UB2m5J62mFDYr5zlKbjDF6BtxdMCDpd9t3U0IP?=
 =?us-ascii?Q?YABq7dlK0geCDryuae/X+g1EELk+8bFirMIcrrCzPuC10AzQGt/Sy03YgpGs?=
 =?us-ascii?Q?qqOTlIuYhv9t8h0laQ1x4c0mxJMz3fkfNZIi6ujS5utLPOP7hlbkbXRsKm+y?=
 =?us-ascii?Q?FOryV8qJWJC3MdqKInh9Q/9wZnzD/UWvVE40BMlj8MWqvuOZ/5nukvL9iGRj?=
 =?us-ascii?Q?hfcN/6doiA5kV1zRE2sMxx0kM34FhYo2ft48rw3GxT4ccbBkAh8G4ODP4YYA?=
 =?us-ascii?Q?nZ92889h4wbibdcu0yPEsXNAqi93KE/Y3zle/8z35zVgtqt6CH0HmCagyMIr?=
 =?us-ascii?Q?ZYu3A5XpEaiVuYkA35F9G3cqdSv0sia3HI64iNI/rV8cnI/U4rzFK6e329nY?=
 =?us-ascii?Q?LyPe8GXTD/ZQ4UE9Np3TCdFls2lVX7GOxBuy59nUedhkC23C7+7UgYAQdjmW?=
 =?us-ascii?Q?YN09XUBc+iIgzfTQXlJqkeGK59CC3hgCGt3qEBlLYF9Ic8Ssjznlqc6LiKH1?=
 =?us-ascii?Q?+/5ipEgYqE0FM/Kmkf54XWatO+Ufr0h+J90zje4qtMaVfWrIsaO7nA+Nl3J+?=
 =?us-ascii?Q?rvmyZGybzUlymobtUA425IAWQIQ/dL2xVeHCxCgU7vzH/UJs7T42LnDxwGIy?=
 =?us-ascii?Q?/TkDQGjhc9smogZjM+GrX1SOqtDtZZ1tHO4clqkgBSON/yOsTbRUVTThY1HC?=
 =?us-ascii?Q?YxpdNRN40XzHirI0h+0qtMvl5Ff1uxqgfaAutKN7eJy4vQiPX5R1P47SDKgl?=
 =?us-ascii?Q?bo9nIoLhGlqGTlf49MDKNwHtahx5rpZILbZLivxneoM8D4CJKhwOkw1ThzZi?=
 =?us-ascii?Q?NPQYxJQc6F5HuSbggVVF1yORst3GrErFB/y8O8VqcY1Fl0v7TkRNmy8eGeLF?=
 =?us-ascii?Q?HJhbn8XFtZd5IsL4+ANq8Jytxju74GFD3+g9HKO44fyvwKnH3DyZt4FUVFJc?=
 =?us-ascii?Q?eNa6ugq9M/1U9iUDlWZrQ8XpyfJf9ebm9o9C/c8J1lzY8QdP4yaXf01Jedy8?=
 =?us-ascii?Q?41FQ43tauOyG1YO5K0egPwk=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: e9fa3128-04e6-412e-9b57-08d9f2d807d0
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 18 Feb 2022 12:13:11.0573
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: koCm51cmnkrGXGZPYCGYv0dy/yeXekG1rDTIJWmwanjHI1WmR/kaQEKuQ6+rSkKMlx2D+d3DEcL+4v5GZW3uxg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CH2PR11MB4200
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-2.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Feb 18, 2022 at 09:47:16AM +0000, Mel Gorman wrote:
> On Fri, Feb 18, 2022 at 02:07:42PM +0800, Aaron Lu wrote:
> > > @@ -1498,12 +1508,6 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> > >  			if (bulkfree_pcp_prepare(page))
> > >  				continue;
> > >  
> > > -			/* Encode order with the migratetype */
> > > -			page->index <<= NR_PCP_ORDER_WIDTH;
> > > -			page->index |= order;
> > > -
> > > -			list_add_tail(&page->lru, &head);
> > > -
> > >  			/*
> > >  			 * We are going to put the page back to the global
> > >  			 * pool, prefetch its buddy to speed up later access
> > > @@ -1517,36 +1521,18 @@ static void free_pcppages_bulk(struct zone *zone, int count,
> > >  				prefetch_buddy(page, order);
> > >  				prefetch_nr--;
> > >  			}
> > 
> > The comment above 'if (prefetch_nr)' says: "We are going to put the page
> > back to the global pool, prefetch its buddy to speed up later access
> > under zone->lock..." will have to be modified as the prefetch is now
> > done inside the lock.
> > 
> 
> Yes, that was my understanding.
> 
> > I remember prefetch_buddy()'s original intent is to fetch the buddy
> > page's 'struct page' before acquiring the zone lock to speed up
> > operations inside the locked region. Now that the zone lock is acquired
> > early, whether to still keep the prefetch_buddy() inside the lock
> > becomes questionable.
> > 
> 
> I agree. I wanted to take it out but worried it might stall (drumroll)
> the rest of the series as evaluating prefetch is machine specific. Before

Understood.

> this series I thought it was possible that the prefetched lines would be
> flushed if the lists were large enough. Due to free_factor, it's possible
> we are 10's of thousands of pages and the prefetched pages would be
> evicted. It would require a fairly small cache though.

Makes sense.

> 
> There are still two reasons why I thought it should go away as a
> follow-up to the series.
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
> It's point 1 that was my main concern. We are paying a guaranteed cost for
> a maybe win if prefetching is fast enough and it would be very difficult to
> spot what percentage of prefetches actually helped. It was more clear-cut
> when the buddy freeing was deferred as there was more time for the prefetch
> to complete.

Both points make sense to me.

I'm also thinking since zone lock contention is much better
now(presumbly due to your free_factor patchset) than before, these
techniques(pick pages to free before acquiring lock and prefetch buddy
on free path) make less sense now.

> 
> > After the nr_task=4/16/64 tests finished, I'll also test the effect of
> > removing prefetch_buddy() here.
> > 
> 
> I'd appreciate it. I think the patch is this (build tested only);
> 

Looks good to me, thanks!

> --8<--
> mm/page_alloc: Do not prefetch buddies during bulk free
> 
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
> Suggested-by: Aaron Lu <aaron.lu@intel.com>
> Signed-off-by: Mel Gorman <mgorman@techsingularity.net>
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
