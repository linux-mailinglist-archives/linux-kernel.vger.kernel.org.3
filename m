Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE37E5A8D0C
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 07:05:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232743AbiIAFFn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 01:05:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiIAFFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 01:05:38 -0400
Received: from mga17.intel.com (mga17.intel.com [192.55.52.151])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B007E58A5
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 22:05:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662008737; x=1693544737;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=bTut+xNrNxfUTM6XOFAy5JOD6z6nBJqTRrX1DH3iLU4=;
  b=Cwy3L+p3LyewIckLbcTcRSO4IJIwvNnDmMkonVtGgN/SaJiSJpaOJhRt
   /p36JqlwWu18uD9ISUj1Uy18OmYAzWsE6u9AAO3FR1mYR5qWbJt2IlJ4Y
   rPXeW3GH3y5NIVq0vXh4hyKLEN3n7DtfJfd0L/67GFn0cOfsf7EDIazgt
   By6A+Ly/Z1YK4QWcEM2BPdirnJ4TqNVbloK3t4WLCL7TurIgBFs9gQOcg
   JvHxJmWTUy9VNl9JoRqoqQ5e+4RTtTvxsf+2jNXIeRmmjw377yj59oqHp
   L3s9vxjQDI+QIa4eWfB0coWxHUaur8oC2FcFGR6SLR5VnFXuPI7w0/pXH
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10456"; a="276019119"
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="276019119"
Received: from fmsmga006.fm.intel.com ([10.253.24.20])
  by fmsmga107.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 31 Aug 2022 22:05:37 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,280,1654585200"; 
   d="scan'208";a="857695870"
Received: from orsmsx601.amr.corp.intel.com ([10.22.229.14])
  by fmsmga006.fm.intel.com with ESMTP; 31 Aug 2022 22:05:36 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX601.amr.corp.intel.com (10.22.229.14) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 22:05:36 -0700
Received: from orsmsx610.amr.corp.intel.com (10.22.229.23) by
 ORSMSX607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 31 Aug 2022 22:05:35 -0700
Received: from orsedg603.ED.cps.intel.com (10.7.248.4) by
 orsmsx610.amr.corp.intel.com (10.22.229.23) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 31 Aug 2022 22:05:35 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.176)
 by edgegateway.intel.com (134.134.137.100) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 31 Aug 2022 22:05:35 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TH343hudc1uyMkxBlAaj1eg3OJQWyEiwREN+aQBSCghWjsA9JYAL2cj1G3C7hwUUC5tK0DnzH8ubkFQvoVC2hBY52iE6xJ2V3SnWm/ywmLjQwDhG6rIDuWTUB+7slQjESjuvl8sm9pIPMVoL+W11z5DyUcVxe4ir2c/+7CJLBGknUcAfwvftgttTpp/7WW9DIBk3RhqTWNgmeshwVbueu3qNtHn9ciPDRyDTq5v0U7OmIjDyAaoMNswnaF74N5TqqKBxThbZtT8OiLRZiNWZVnm1R17HNmVkScxDy0s1AN7VE5tsKaaELCIK6oYIt3LYWY/gH37Wh52sLXkgncB3pA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=5f4kEruow+OgRWWHQ7IpC0ucOXjjTpni2PGoj1OLTRM=;
 b=etozzs6ASHiHXzCsXsWnOe+pumU48ECzwOOF9DtcMVpN0h1+mFcxKL8T1ZPinfVCU2O9GAkVkpkcVL0lkK7mXeSJn4PcJZ4QPWwdKa99PEqBVxvmol8p2g61zn9ezF3aoQALvLBrusDk1/A/N7NrCmoBroQe/Q5RWgpw8v2L3keIzfS+fvWlAX21G6b+pZ9IyCsYCzEc+s8Chj9nMVME5tYzSDxgIOMVK5pfTmcjyxk0e7IB/gG56xNqzHFBltQ4PKvMvARExcTqkCZF3kGYEJS2OPeER2dejvU+O7M9/S0WYqM6rWYRejGlWo2zALCy/5iTBdgzcqtIgguAPC3r/A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by MN2PR11MB4536.namprd11.prod.outlook.com (2603:10b6:208:26a::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.10; Thu, 1 Sep
 2022 05:05:34 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::d446:1cb8:3071:f4e8%5]) with mapi id 15.20.5588.010; Thu, 1 Sep 2022
 05:05:34 +0000
Date:   Thu, 1 Sep 2022 13:04:58 +0800
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
        "Hansen, Dave" <dave.hansen@intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        "John Garry" <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v4 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <YxA9etTqGsaogfZ6@feng-clx>
References: <20220829075618.69069-1-feng.tang@intel.com>
 <20220829075618.69069-2-feng.tang@intel.com>
 <Yw91n/AzjmAXmdh8@hyeyoo>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yw91n/AzjmAXmdh8@hyeyoo>
X-ClientProxiedBy: SG2PR06CA0196.apcprd06.prod.outlook.com (2603:1096:4:1::28)
 To MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: cd5b83c2-2051-4cc1-5ef1-08da8bd799b6
X-MS-TrafficTypeDiagnostic: MN2PR11MB4536:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: JgUId1aXnBPbcq956fmolI0YOMem2mazvtaG0U7FAUzx762vtUD1HB6qHNCOTPUlU1249ABhkW6UI7bsAdlblME6918KwkCg9LZoAfZGNknYG3qpAXkacJTPKaovgyEcvugICdA37zDobg/QM+mhg/J0j8E6wx0gIQFjtTLy3KdmzQ5hbU7MuOD2aQaF88wtBKf88FFmuxRrBe1eEqhg0lCQSI7ynCeY7TwvuO9dlHJ8s19UpmsFn8Kpa0IBBa+oBS5Fj9dcMes21sjWU+tQD8s//C2WooFgX6zl7GyB7SJpjm1B0u36ojPh+Op2fJQ6Q3BEbhZ5i1s9vHUWHg7Ws3ZPPuNUPX4cCwLn7rrCJ+6Ercy3m+VYQMeF55H+qXg4nAh5nZpexaPYLnnuUq1QDcL5okia6NnsHgDxoQ94cdz5kiv6pNXCnGpuSQYiTPtWhhLVMjdVTWwvHyaSBUPk1VCB2LL1b9//tnqo5pj+QFsDV822H9IrvprPDxNSnhz57y61rc5Nl4bxCELrkGvp5vKqKWFSbhuAod0tuQDf5WBusmRbm5HrqVvRrH1JSc9nwR11MWtSqtz4TN/fxCCaDfN8FSafC70lrNKR1eTOgpjHRu1Nq2oXoRnEt6EjwAIT/ZJWx7Jku3WUe3ulqck9McwdCzRnTrUSgIXOkpiqvC8zJUsQ1GNMNMxWDvXmNcWQod3xOjiTz9gFcvqDKjVEXYU53zRAynBNA0rSANFkvMR3Tah3ibh3IMTSPHSYm5MF
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(136003)(376002)(366004)(396003)(39860400002)(82960400001)(2906002)(8936002)(66946007)(66556008)(83380400001)(186003)(6916009)(316002)(54906003)(44832011)(5660300002)(7416002)(66476007)(4326008)(8676002)(41300700001)(33716001)(6506007)(9686003)(6666004)(6512007)(26005)(38100700002)(478600001)(86362001)(966005)(6486002);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?Q7Et+R0iaZlryo6qCRnaDvSf7oRHTyUqmK9AUiFNwoIKOSDZxe+lGpeUT+QZ?=
 =?us-ascii?Q?BwcLtrb1ykwSOQIT4HGupgK5XJ1YfWhBwNA5If6ci6vRWetB70VbMoMxZiRj?=
 =?us-ascii?Q?0kB9OwUjVzwfZdjhlnvsUEscbi+hjbV0J2RFQFlJifIJSnNtr0u0B28U0kxw?=
 =?us-ascii?Q?G+mStLIKLGSrijWZaqZNUgk5jLw7lNsQja0BV5ggEp0UJtJDl7r7yxkSwB+0?=
 =?us-ascii?Q?duJ/Kv7kEeQ+c4jWOsrx22GbKWgsagDBf/i9SPJU/YR7sw3gyFNnpJXn/sNx?=
 =?us-ascii?Q?g9HUipb/TLLysGLQvQeFump8irIolPQGf8L/IQNV2EiUqwU1LtY4RX996Bej?=
 =?us-ascii?Q?CE0oGxGJNhAzbthssnCxemOfRSkLqocCqvJiY46SIQFTA273OQjhVnNAObP3?=
 =?us-ascii?Q?BVdYkOk6XMBS+IMXs0YFdwuFcmTmYtU4KJA6C+nkunW6xmpd3msXPuwJTPQ4?=
 =?us-ascii?Q?J3tYLZ0YdA+WYfAX2Kwm12/6aLxY6ZAJ2i9JJcXHRIHmFNoQnLS9KJUALPc1?=
 =?us-ascii?Q?z+1sVpmTHdm8Q0tPTRCtn017JOUt1YWc22iZFsp7etrpcm8hzHA7gNU/7GbT?=
 =?us-ascii?Q?Wy1Md3nUh9Qj/8z08LvfPzZDndqZF09t4nIfx7qL7IBLB2eN92A0aKHuJR9o?=
 =?us-ascii?Q?+/9nuutbRj5M74KlgQ6kenEbEmi6KJ3CHji0Z3K4w6PUFYVUgKzG0N0sql7J?=
 =?us-ascii?Q?14k/wJCpnNUqtTHo800FqjE9mAXL4uOM8NRbhbGN7DhrAsz0WEJUJw94Sn4w?=
 =?us-ascii?Q?SjApufsD/idDj+vqeHQsIWL0YvjQ7FKXVSUX4tNbvdefub9XgEnRSbebKie3?=
 =?us-ascii?Q?9Tz9tX6JGrSrtSsDmURc260/p+K7W5JfVcSsiFkVF7s51BKhipCMSGT8e104?=
 =?us-ascii?Q?fbvmi+LxS7erIMGkeOOK/ue+3AvlPs1l/2zIDut3dKVxn5Vy3bJspEM1Yuwe?=
 =?us-ascii?Q?q+hBF7+M3tpbpC+qnf/hX+My7fP4qSX9T8Z6xuI9VwxiQF0uM3sDmW+Sxwr6?=
 =?us-ascii?Q?+9wQTplfkd+VXyn2BcTPlHes+Oe6K+dhhxFQ8aSYhoZ+Y0IO9lIQ08Yz+5eX?=
 =?us-ascii?Q?lObVOm8lge0tXXQdaxf1dq/BorzSzWxFfcB3a3I5OO5Q0JURrQFeWLu15iAK?=
 =?us-ascii?Q?leKIChLbYsP7uozfQKFNL38qgC0E1ZeZ3Nuebi41eEJXusxLYyQjWCsifdQB?=
 =?us-ascii?Q?eVTxvaFbReOtBO4b07Net07FbhvnGQqug3yT5FMHi2Knf/0C/XJ+XIvkXSkd?=
 =?us-ascii?Q?BQx2wPqLvEaZ0KV7MrhdSAJSFd6h0lVuyx0C9LwyyfBuuGDrbJiuT6ZvgfKS?=
 =?us-ascii?Q?uqHtjUycnGEo6B9rTGaFxanIXEqLOJ0l8Pe6YEl/XS0E20ywJ3Em30HsrfHs?=
 =?us-ascii?Q?tvHzTDlSI1RL/h1mJqjFr21/qtQv/P09EM1bn9oYeDJ8wf7/VCuJj/bNlMud?=
 =?us-ascii?Q?k+30+Ak/UvPCQuIbIWUi1DBZJujQpxY4wnxjcNz2VSxfntEXIdUA0is9iDnz?=
 =?us-ascii?Q?OeZwgeBvu/D38k+1cxeB5ntqdUgmCU6Wo5aaOE59ET6MR5cenfzi3gx9GlDs?=
 =?us-ascii?Q?qqTGk9R3oQ1LTv8eSAw2BflDs0XEM01g2QRGgi8X?=
X-MS-Exchange-CrossTenant-Network-Message-Id: cd5b83c2-2051-4cc1-5ef1-08da8bd799b6
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 01 Sep 2022 05:05:34.1159
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 6X0BFVEJVNGDke5ud/jaxGIHeLgS8yLWeYx5qevOYe07Um0NSggXjfjUdxZEheHedCnw6ZKav9vwz1VYNyDY/A==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR11MB4536
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

On Wed, Aug 31, 2022 at 10:52:15PM +0800, Hyeonggon Yoo wrote:
> On Mon, Aug 29, 2022 at 03:56:15PM +0800, Feng Tang wrote:
> > kmalloc's API family is critical for mm, with one nature that it will
> > round up the request size to a fixed one (mostly power of 2). Say
> > when user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
> > could be allocated, so in worst case, there is around 50% memory
> > space waste.
> > 
> 
> [...]
> 
> >  static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> > -			  unsigned long addr, struct kmem_cache_cpu *c)
> > +			  unsigned long addr, struct kmem_cache_cpu *c, unsigned int orig_size)
> >  {
> >  	void *freelist;
> >  	struct slab *slab;
> > @@ -3115,6 +3158,7 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  
> >  		if (s->flags & SLAB_STORE_USER)
> >  			set_track(s, freelist, TRACK_ALLOC, addr);
> > +		set_orig_size(s, freelist, orig_size);
> >  
> >  		return freelist;
> >  	}
> > @@ -3140,6 +3184,8 @@ static void *___slab_alloc(struct kmem_cache *s, gfp_t gfpflags, int node,
> >  		 */
> >  		if (s->flags & SLAB_STORE_USER)
> >  			set_track(s, freelist, TRACK_ALLOC, addr);
> > +		set_orig_size(s, freelist, orig_size);
> > +
> >  		return freelist;
> >  	}
> 
> Maybe we can move set_track() and set_orig_size() to after slab_post_alloc_hook().
> something like alloc/free hooks for debugging caches? (and drop orig_size parameter.) 

Yep, we discussed this during v3 review
https://lore.kernel.org/lkml/442d2b9c-9f07-8954-b90e-b4a9f8b64303@intel.com/

Will revisit this considering recent refactoring and the following
kmalloc data redzone patches.

Thanks,
Feng

> Thanks!
