Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 997E25B15CD
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 09:39:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230262AbiIHHjh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 8 Sep 2022 03:39:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229624AbiIHHjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 8 Sep 2022 03:39:33 -0400
Received: from mga09.intel.com (mga09.intel.com [134.134.136.24])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89B5AF3E
        for <linux-kernel@vger.kernel.org>; Thu,  8 Sep 2022 00:39:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662622771; x=1694158771;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=pMdMISeh1ClFihkpM9HmiSbIqTl75stP9m8TQ9Gj+g0=;
  b=E+e8sjSD4MTqYMtyKqTLrnMs1QKMEOW8se4h7cTP/rWdco2ce5syVAY9
   AEwPAiLYl65y5Q8htL+bLmdPJP9cPE1qhtbNbcIhj5oi0mQBP/rZiHOFM
   alkCHL+SWgt7vOJ7TaaH0nwNiuXn9064QBmxMj1mwfjnNYBh7xLepfN9I
   f3h467peeL2QYIfpDgqZkdNso117tzOWsGkJ2Sl53lsBREoM07Yz3uldR
   SztyidD05vpUau3HF4BxziCvN6llf+dusswo9vl5LpoAKqF/Ks3p5RXuz
   Pfis/ThLPl6nAM65RhB0HBO3eiEoAYgwyF6HMALjvqZ6/Rq2rfVpWWkdL
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="297902671"
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="297902671"
Received: from orsmga004.jf.intel.com ([10.7.209.38])
  by orsmga102.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 08 Sep 2022 00:39:22 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,299,1654585200"; 
   d="scan'208";a="740579675"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by orsmga004.jf.intel.com with ESMTP; 08 Sep 2022 00:39:22 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Thu, 8 Sep 2022 00:39:21 -0700
Received: from ORSEDG601.ED.cps.intel.com (10.7.248.6) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Thu, 8 Sep 2022 00:39:21 -0700
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (104.47.56.49) by
 edgegateway.intel.com (134.134.137.102) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Thu, 8 Sep 2022 00:39:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=VTKNy+l5QjnKW5Is3e58YsyY7dsKO75qupu2+dAtZgtfcbKCvvyPlJkvAZ/5p6uUrEJPrK9CwAIqCw/S/LW3ujPnq0seMP8gEL1kPcBSLHvVhlhxaAf8dtv7rmDYvg1vSf+eFxXSi1ShLVzoJFLCQkIIVMMeY/eNf09EuEvqX5/3XohJkwbWkXr7oOfrWQG6QUJu2qjox2J0nM7w/FCJHwIUtAtqvwb+zhSUr9yYHDPRQEoZQ/7/5DfRYf7qROYxLN2WFgyGFBBDxjfuxtx/bAJbLbMdDpzIqa/EudJzH7Ipy5iqgPQ3zSPL0igfiXul4F9G4V29tZe3qHOa0sHrGg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=HrKU3z79hQUKlS0FTmf5Co9tZwaYE8vTfPGCWHhAAhk=;
 b=Abs68qsQwVh5/98HaHtZP7hnW9eMOK9qnCNjeOkVsh+t2hVPPPr3y6GOiLbKjNvzH2bMoxga1fQNFA7EQE5jknb+/zvbs89ydTYztp9PDTVnEzUZOZkM6Tyz6VlqZ7FJSVzRVxg5dZTBElAq8Emo3wDRAoOxWV1CUU9Vk4lpnIvZB0PAfqnbCzpCPqobEW3U+N5UAcl16+FeJAuBBR3hhhdG3IKUH+bWi3FRR+xmhiX3WKUAVcUV3Yvb8fNfSB4FL804J8UjTX0h1MCF/4FzRn6e8J7NVQSAC6wv7MyU0VzN66/w7ki9wuBouUtWH3lneTYN+HzUMAWLvojeXkqT9w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MW4PR11MB6863.namprd11.prod.outlook.com (2603:10b6:303:222::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.18; Thu, 8 Sep
 2022 07:39:12 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e%7]) with mapi id 15.20.5588.015; Thu, 8 Sep 2022
 07:39:12 +0000
Date:   Thu, 8 Sep 2022 15:38:37 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Hyeonggon Yoo <42.hyeyoo@gmail.com>
CC:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        Christoph Lameter <cl@linux.com>,
        Pekka Enberg <penberg@kernel.org>,
        David Rientjes <rientjes@google.com>,
        Joonsoo Kim <iamjoonsoo.kim@lge.com>,
        Roman Gushchin <roman.gushchin@linux.dev>,
        "Dmitry Vyukov" <dvyukov@google.com>,
        Jonathan Corbet <corbet@lwn.net>,
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>
Subject: Re: [PATCH v5 2/4] mm/slub: only zero the requested size of buffer
 for kzalloc
Message-ID: <Yxmb/W4wmJnwA0Qt@feng-clx>
References: <20220907071023.3838692-1-feng.tang@intel.com>
 <20220907071023.3838692-3-feng.tang@intel.com>
 <YxixXhscutM0nw66@hyeyoo>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YxixXhscutM0nw66@hyeyoo>
X-ClientProxiedBy: SG2PR02CA0126.apcprd02.prod.outlook.com
 (2603:1096:4:188::11) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3538e9a4-07ed-4fb0-056e-08da916d3945
X-MS-TrafficTypeDiagnostic: MW4PR11MB6863:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Tqb3x8dzPV5WFzjc0IMQgdmsoct5A6ooP5Pg2nn9IXT1BhTi88/lkXpI8+1G+ltm2ZtDXyov2TqOpFYY6PpVv+3iBAvgG2bwDV58vbvrXm/qwETsvE8dRIt/+2rAV6HJx3aE1LDPkqfxzPFQIc2HqROIriB/P82rdlM6gMBSDE2Q3+jyVcvw5TQPOlB/M/CjjKlVayhN7EwzBmGXoUMY2jSNjLunLZD/qt/Ta93sTWR7ixShX0hJXFDQ/vmbZAakjxgKcKIRNpVoRNK1t+yhjKiu8qrVbKMgb+i12XyTrYEjxJJ0bybhwlLZckQWqwUFJzatdePju2WKhgZdxe2Lx/cQFjhdM/04jEeHKZHjdE0yzFhAWMy8wYwkTi5YRA478qwWVerQalu62cd69Une4KZ6Sv1qiaYNpPVNZL4Wnp9sdT2FTuZFPIBQEW92tiAeI19Ak+B/T7okbqVQPsDEs4xzsfvCSpsLKtkT30FXFhTFyHn5rFPWzcUspH64TNYv/+/Op2HRgspYRjx9qlskgLHumhPHOUpETmfZE9HoJS8axbm/m/yey8FPsA8BMGIuvXbTsS5Qb8j6eUbpALBsMlNebdQ5XL3Sd6J2BO8XanKY3SaL7zzN/SvyulHOS2JPgmbwwGK2F+w2EfMJ0K3x1DRx4Sxd1vjxd6oCrmVZE0K2hEj/VrKxgICEfEUrwSgu0/Ru+B8VLgPjZXX8eKwRUg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(366004)(396003)(39860400002)(136003)(376002)(41300700001)(478600001)(6666004)(26005)(7416002)(6506007)(44832011)(33716001)(9686003)(6512007)(8936002)(2906002)(82960400001)(5660300002)(38100700002)(186003)(66556008)(54906003)(6916009)(316002)(86362001)(66946007)(83380400001)(66476007)(8676002)(4326008)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?I8Sq/pwGYWcE8jz0mDzvo2MVcwz/C17M/6FzFaUuv5pI+8NEk4r2PCvLkpNv?=
 =?us-ascii?Q?gwLrhBRAxsAbfvGzdegSITvM6T+MluhUwo8M6ERP5skWPk4vRPNS3OIs8sey?=
 =?us-ascii?Q?/8JliCY6toC0v+7R6sFGopzyJscbkqBkms/VEfueXzf95dCWeF9CUG/iXOWs?=
 =?us-ascii?Q?rJCjSNymkbAg8AzaZb2V5/d2VJWEC1rn0gpr2+toOLqKfAwgtIVyqkzQ9AOs?=
 =?us-ascii?Q?URmFMKmgTPOBWKFroLKAJJh4FAg4tTVM2aCEQNSRs8HL5yna2kFnOKR7zfL8?=
 =?us-ascii?Q?90YUIe2bcmX7WY6S5pbmQ8jqY3UMyS6U32AcaOe+i1/tFIe5R7rUkU8qbYFj?=
 =?us-ascii?Q?4Z9DkbtbHW8O/jvoi0rlwkbhtHOztS62YWIXttJz34l4INWIu9FvSDlanc9T?=
 =?us-ascii?Q?9egCt14qtmS9UQ+5sB/ZxAPMGUHmmbMQnnHCgAQz2UVnYXr9X0l3bp6PRC/A?=
 =?us-ascii?Q?iyIqdcLE3gmcbKecoJ4885u91CxekAM2SmBKz8/KEjZNTkGxJ5zrNwn11YCm?=
 =?us-ascii?Q?TIpedQaYlD783uKc3Lwefu1y0PZ6vBKF0EyE/yQdu3wsaRC7BUcT2bB+tA98?=
 =?us-ascii?Q?YwA5bwK5oMra7F+z/Dq+r0nq3JSyxjikNiVfDUHWcNusfXYAPY2XyWxFx2EB?=
 =?us-ascii?Q?Hgiz84IpYodQAKEngs6/4YYSi8FnWsdjVqQl4w53TNJa5/LJJxeP9BctBXK8?=
 =?us-ascii?Q?AUhVzUm1HEgshdjtVw3wxfV6p9lnrO20NjZkt/k4/wA0NYYOYbJcLU/yd8t2?=
 =?us-ascii?Q?HU5wyKwmCdkoyeNC8YmJrVRJJyWrzsQvHvF6QrjLvJSjLfdB0CY5TEQ5R4fT?=
 =?us-ascii?Q?WkVq0D6D+rYBMUqz/f378UcyYCOF4rH24QztdFAI/XzK/PsGx5WYIcORzcWM?=
 =?us-ascii?Q?ZgUwU9rqXjqOg+6dGz+Mb5E7jInTT5+60+IOxr9H5lXqp4rRaSFhNN0OlrtL?=
 =?us-ascii?Q?cLGTh+MZ57w3LP/VyUnv4ubcGtIGYVUY/ePo2CYVi8bX7XvMIWEkycegR9iM?=
 =?us-ascii?Q?HAtcLy9Hnsxs5bHioN6rHexIpbkyx5pEcmpYbBomweGamNtZ8yE7oNkuZgoe?=
 =?us-ascii?Q?QXrOIcICPWHP4QIvG3uYdjWFlmKkVfydqmxaQBxj5MxUs68PGAqPB5lnzuT8?=
 =?us-ascii?Q?2COoBTsB6hmdQYnSg1PpFx8Z4pQrvAUKi8R9cXNkOVjhr3L1z9pRpdKlDD3g?=
 =?us-ascii?Q?xMrF9V2ZrfgFrQe6Mi71IS4wCrZroOYRCqHcN0yz0kYwuSra5ZtLk6YmQzYd?=
 =?us-ascii?Q?6uFyEjA7+S7vPoxc+tUeyf2Uc6QsNrega6p7Uomq5zo8p65pdnxH1LuYxDxj?=
 =?us-ascii?Q?XruRmZhqlsIpB8vLQOhmoIw4CxrhXXEeut4PtS/OW9ELN+UFtWO1M33j2jS6?=
 =?us-ascii?Q?Y3ayaSlXoeikWwyYXdSt0g41lyt6eICz+z03EjcCUPQlAJTu1QsT2t0jtuY/?=
 =?us-ascii?Q?YO4InW80leo2hVYR5q33OjyaUHW0elu6eS6J2b9oX6Wr37sxb4lTU7H2zudT?=
 =?us-ascii?Q?qq2Z+AyuHqJ48Y5KDxl0LCbCsX1i3ejFP/u5925iHX7ZuLvFMvjo0u3xMx72?=
 =?us-ascii?Q?3co4z4AjZyOk9/PSTmKsHusG6cazBUwdCVS1EhLS?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 3538e9a4-07ed-4fb0-056e-08da916d3945
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 07:39:12.5727
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3Br2P7REQv8q5/k28guH0OiAA8HxU3VpajMsKkACUTKDOcx3Jn5Mf9iFuMqAjOFWCczaDZXd4XmOJE5aYplqhg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MW4PR11MB6863
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Sep 07, 2022 at 10:57:34PM +0800, Hyeonggon Yoo wrote:
> On Wed, Sep 07, 2022 at 03:10:21PM +0800, Feng Tang wrote:
> > kzalloc/kmalloc will round up the request size to a fixed size
> > (mostly power of 2), so the allocated memory could be more than
> > requested. Currently kzalloc family APIs will zero all the
> > allocated memory.
> > 
> > To detect out-of-bound usage of the extra allocated memory, only
> > zero the requested part, so that sanity check could be added to
> > the extra space later.
> > 
> > For kzalloc users who will call ksize() later and utilize this
> > extra space, please be aware that the space is not zeroed any
> > more.
> 
> Can this break existing users?
> or should we initialize extra bytes to zero when someone called ksize()?

Good point!

As kmalloc caches' size are not strictly power of 2, the logical
usage for users is to call ksize() first to know the actual size.

I did a grep of both "xxzalloc" + "ksize" with cmd 

#git-grep " ksize(" | cut -f 1 -d':' | xargs grep zalloc | cut -f 1 -d':' | sort  -u

and got:

	arch/x86/kernel/cpu/microcode/amd.c
	drivers/base/devres.c
	drivers/net/ethernet/intel/igb/igb_main.c
	drivers/net/wireless/intel/iwlwifi/mvm/scan.c
	fs/btrfs/send.c
	include/linux/slab.h
	lib/test_kasan.c
	mm/mempool.c
	mm/nommu.c
	mm/slab_common.c
	security/tomoyo/memory.c

I roughly went through these files, and haven't found obvious breakage
regarding with data zeroing (I could miss something)

Also these patches has been in a tree monitored by 0Day, and some basic
sanity tests should have been run with 0Day's help, no problem with
this patch so far (one KASAN related problem was found though, see
patch 3/4).

And in worst case there is problem, we can fix it quickly.


> If it is not going to break something - I think we can add a comment of this.
> something like "... kzalloc() will initialize to zero only for @size bytes ..."
 
Agree, this is necessary. 

> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > ---
> >  mm/slab.c | 6 +++---
> >  mm/slab.h | 9 +++++++--
> >  mm/slub.c | 6 +++---
> >  3 files changed, 13 insertions(+), 8 deletions(-)
> > 
> > diff --git a/mm/slab.c b/mm/slab.c
> > index a5486ff8362a..73ecaa7066e1 100644
> > --- a/mm/slab.c
> > +++ b/mm/slab.c
> > @@ -3253,7 +3253,7 @@ slab_alloc_node(struct kmem_cache *cachep, struct list_lru *lru, gfp_t flags,
> >  	init = slab_want_init_on_alloc(flags, cachep);
> >  
> >  out:
> > -	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init);
> > +	slab_post_alloc_hook(cachep, objcg, flags, 1, &objp, init, 0);
> >  	return objp;
> >  }
> >  
> > @@ -3506,13 +3506,13 @@ int kmem_cache_alloc_bulk(struct kmem_cache *s, gfp_t flags, size_t size,
> >  	 * Done outside of the IRQ disabled section.
> >  	 */
> >  	slab_post_alloc_hook(s, objcg, flags, size, p,
> > -				slab_want_init_on_alloc(flags, s));
> > +				slab_want_init_on_alloc(flags, s), 0);
> >  	/* FIXME: Trace call missing. Christoph would like a bulk variant */
> >  	return size;
> >  error:
> >  	local_irq_enable();
> >  	cache_alloc_debugcheck_after_bulk(s, flags, i, p, _RET_IP_);
> > -	slab_post_alloc_hook(s, objcg, flags, i, p, false);
> > +	slab_post_alloc_hook(s, objcg, flags, i, p, false, 0);
> >  	kmem_cache_free_bulk(s, i, p);
> >  	return 0;
> >  }
> > diff --git a/mm/slab.h b/mm/slab.h
> > index d0ef9dd44b71..20f9e2a9814f 100644
> > --- a/mm/slab.h
> > +++ b/mm/slab.h
> > @@ -730,12 +730,17 @@ static inline struct kmem_cache *slab_pre_alloc_hook(struct kmem_cache *s,
> >  
> >  static inline void slab_post_alloc_hook(struct kmem_cache *s,
> >  					struct obj_cgroup *objcg, gfp_t flags,
> > -					size_t size, void **p, bool init)
> > +					size_t size, void **p, bool init,
> > +					unsigned int orig_size)
> >  {
> >  	size_t i;
> >  
> >  	flags &= gfp_allowed_mask;
> >  
> > +	/* If original request size(kmalloc) is not set, use object_size */
> > +	if (!orig_size)
> > +		orig_size = s->object_size;
> 
> I think it is more readable to pass s->object_size than zero

OK, will change. 

Thanks,
Feng


