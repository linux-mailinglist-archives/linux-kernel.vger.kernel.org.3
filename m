Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA8D550B07E
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:25:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444343AbiDVG1O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:27:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390268AbiDVG1L (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:27:11 -0400
Received: from mga14.intel.com (mga14.intel.com [192.55.52.115])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28A04506F2
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:24:19 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1650608659; x=1682144659;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=a3vnLJKYviKPVU7ERlCQTS90byLzAhepdBVAHb+iu0M=;
  b=YwZv0qN60ncliOR1w0p1kIswmf91UHGlMmuY2w36B4W66TJCWRiJWs40
   vtA3HZggqFo05khfKTNgzK1AIjAPfcoub753/7sGb6OvF9aE2cfnYQ6iY
   2ktAqumNfaQRGtTYfb/gjFVrNkXAE7i/eAskW8wAPEJXLNXli3lMwMBEA
   kUWj0+tHvyjGKHhH2JxAaeqj064KhlbIxlqAqUsR9Urmq55ggmlgDzL6y
   +mWjSGfdqWU9/JL8ruf5b9S7Yv0Pg7BwhJBU6zuKa/o+Hdz1GmrW8Rkiv
   uJF6z/TtzBgSK2/yFI17rK101ZO3sXfXMO104BMu8YMiNMXlVAFFpNOh/
   g==;
X-IronPort-AV: E=McAfee;i="6400,9594,10324"; a="264756869"
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="264756869"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga103.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 21 Apr 2022 23:24:18 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.90,280,1643702400"; 
   d="scan'208";a="562919494"
Received: from fmsmsx604.amr.corp.intel.com ([10.18.126.84])
  by fmsmga007.fm.intel.com with ESMTP; 21 Apr 2022 23:24:18 -0700
Received: from fmsmsx607.amr.corp.intel.com (10.18.126.87) by
 fmsmsx604.amr.corp.intel.com (10.18.126.84) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27; Thu, 21 Apr 2022 23:24:18 -0700
Received: from fmsedg602.ED.cps.intel.com (10.1.192.136) by
 fmsmsx607.amr.corp.intel.com (10.18.126.87) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.27 via Frontend Transport; Thu, 21 Apr 2022 23:24:18 -0700
Received: from NAM10-BN7-obe.outbound.protection.outlook.com (104.47.70.106)
 by edgegateway.intel.com (192.55.55.71) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2308.27; Thu, 21 Apr 2022 23:24:18 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=TrxkcVY45EvzfxPoPVOYtCSOOJTtOPElEKBn+ri5ZeuH9/fJiWUc+ALBZzNm3x9H4nhRqTrwZD/3OlSBunPnoL2wWwLhWuE07fikF5qazBPPJZcddPSfQt9wxK5UwdRnt5PoMxFEDrmj5xNVqHktVBLURVawh7R9Ta3IAFiFTimmXSH2pKliu67KoVXqbKZWHrmuNvKI+EzCZDosIDDWA2HPNPeG3ibYuNRdCeqRg99eTtpzvjG8/igx+JH2Lw+QRvKDOoHiT6xMHXts0bx4eT3W9Gt5ovtbm082DbMvlwwUeXlChU0b39alUHNHk92zY8SvOWeItLV0UZxX1+WYQw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=pJT2ZVCo+0CtX6v5bpMJpjbIESB9q7GexBpSg44kMec=;
 b=BSI3RCXHhvEjfsrZGlMELANsMSMGAFeTWsImUX37xtA1sWpl/SgNYpgE60G4pBfB39YUEBlGuHl3tOdxq+/mLOlMgmzqFbbX9NcwhHjo5fYVWz4BURWSJtNJVmtX+1DVPm9c0A4Z4qQLJ6qM0XoYLusaozGhvWNaJoZgQyjgWUz3bIBFvfsXqo2DZAaoY+CTALLTlmXMCMHtXQhVwoxW+9zsjr74PrLv75QeXrUu3D4nsihUYA3o9FEyrDHFv8lA/nU2EMrNlbTQaj3wYt3Vd/hI+ffMAawnhWnzp7l9r/71DgbPHek5t63o6++N5lkNwVjS1v9DuRd9v4bNtF3rmg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from BYAPR11MB3062.namprd11.prod.outlook.com (2603:10b6:a03:92::18)
 by PH0PR11MB4855.namprd11.prod.outlook.com (2603:10b6:510:41::12) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5186.13; Fri, 22 Apr
 2022 06:24:14 +0000
Received: from BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::30f5:ac84:8cae:c977]) by BYAPR11MB3062.namprd11.prod.outlook.com
 ([fe80::30f5:ac84:8cae:c977%6]) with mapi id 15.20.5164.026; Fri, 22 Apr 2022
 06:24:14 +0000
Date:   Fri, 22 Apr 2022 14:24:05 +0800
From:   Aaron Lu <aaron.lu@intel.com>
To:     "ying.huang@intel.com" <ying.huang@intel.com>
CC:     Yang Shi <shy828301@gmail.com>, Michal Hocko <mhocko@suse.com>,
        "Andrew Morton" <akpm@linux-foundation.org>,
        Linux MM <linux-mm@kvack.org>,
        "Linux Kernel Mailing List" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH] mm: swap: determine swap device by using page nid
Message-ID: <YmJKBaq1yj6/iBJ3@ziqianlu-desk1>
References: <20220407020953.475626-1-shy828301@gmail.com>
 <Yk6cutNf5sOuYbDl@ziqianlu-nuc9qn>
 <CAHbLzkq+eKcKCsxXDTiOcBxk8FjMdWBqOxwi4N_NG7PZWbAAkA@mail.gmail.com>
 <Yl/FS9enAD4V8jG3@ziqianlu-nuc9qn>
 <f27ec36beb3cf1dbbfc3b8835e586d5d6fe7f561.camel@intel.com>
 <YmETEHnK/FiNbLO7@ziqianlu-desk1>
 <6f7210be7353d1c01dc9f872b2692b83f87f5452.camel@intel.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <6f7210be7353d1c01dc9f872b2692b83f87f5452.camel@intel.com>
X-ClientProxiedBy: HK2PR0401CA0011.apcprd04.prod.outlook.com
 (2603:1096:202:2::21) To BYAPR11MB3062.namprd11.prod.outlook.com
 (2603:10b6:a03:92::18)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: f931b2a6-3caa-490e-3606-08da2428b880
X-MS-TrafficTypeDiagnostic: PH0PR11MB4855:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-Microsoft-Antispam-PRVS: <PH0PR11MB48558D0259FAC6DA96988E998BF79@PH0PR11MB4855.namprd11.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0JJQxSmH5R9t+F8QB2HpSsrmFHlgfCRnonAUf85BTn2q3MgINxtUTpb/8zWl2+tvFczg60m9pqdxfH0RaOV6zwdJjlU4+PJOPiitrBpXClYNMWG0AdZLx3Ti8YjVsjHOaeCQpJih2IvnMmkGExCi4wxvDRWnPeiHWE3NCHRSF6Fl68ze2WChGeQdjTu6eK9xsiRVAOwwdT72IrxcRjdKV+t8vyEz6RhS5J8v+ksrXKJR7K0lkcaW6KGwEMmTbnsbRdaWMBVz0fu3lE4OPzKIwbg2v6/YutZaW4lsrM/CIEMkPvO54L1YFrQcrhU+Mfp1RzXzjPE58hDzVY8Hehnr6aMuuj5bg8bpEZ4GvMYWFao4EBxNES461PiUt5yNkoFhMOhfLPaf4+dLohbXethH4XjWjAqA4wFtj+AsYytF3CBopqSdBUt0GFFLSzjTJn5chjd0IDFHkmabD14AamEoOHTB2vsfPYbX7tTrNSbd6tVRWJSO6uHUw288+/T35wTrzAmlcabGiAbtgEaF9x3QuTqNzAU7Ph+HhqlJ9uzhLs3lXX/6g+7GgtEManVDww4GP7MhTyhbXBW/SoLw0it+ypbSHn1xLcciyyN0+Zr4eh0x0eyQXB5vR1o1TKGyqx+d58rzVSjsoF29l9Z5TBFFVa7vWmC7iy4aJk+Yw40Ftz8frs9tQgWsgp7xnFa8hOKlSWrUCn3puoNSyfYq9kecDg2xENvtytOVFkkfgj8AZxQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BYAPR11MB3062.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(366004)(66556008)(38100700002)(33716001)(5660300002)(66476007)(66946007)(8676002)(6862004)(316002)(4326008)(6666004)(8936002)(2906002)(186003)(966005)(6486002)(6636002)(6506007)(86362001)(508600001)(83380400001)(44832011)(26005)(9686003)(6512007)(82960400001)(54906003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3aHfeClzLR347pvXlFfceg0Gd9Uk3QlrF05qC1Y3Pv/cA4UnoXqwwPrsvam8?=
 =?us-ascii?Q?vUTg1QQlP8zaNfpOioeX2Vu+z1bblCeSdRb4bMMexZDDoSpOBRwUTo64UVYU?=
 =?us-ascii?Q?t/2pwNLyAp9MCiE+dx3TQ2CZzbDA4sYzbAKMXfF73FHOaIm6yDSNqPHmHGvR?=
 =?us-ascii?Q?dudKFWrV/MspuuTx1M2z4YgCo9ItunwVfuA9Ey2G4+N9NbXtyfbrZS3X81qd?=
 =?us-ascii?Q?CpH1kHUVtQwaU+uGLNZhzbtOyD99D5DTOCQX+wny+9NUiuaFhXGCdNo506VA?=
 =?us-ascii?Q?mbuGYrz0Pmch05c1r7XNPrjrwKDoGmk+pAuLZOcRJAm5fv0MwS6iMARuEeut?=
 =?us-ascii?Q?QxERt/pplx9b1VDWf2XWuQ+GlNRro+UONpuSqkj0cnT+Jqh2pJse0e3eZ5Al?=
 =?us-ascii?Q?jLo0bdpxyoQ9QDoowwh29n0g6pDJGeMm0Sc5IC6EvI7h5Q6ozxaxEi3C9Nml?=
 =?us-ascii?Q?fu+UwnATU8uwWTE5N1k5+yVsrfVojkpUXSmEOx7p7KRtGQiSVxJqg+0IIjok?=
 =?us-ascii?Q?+ivn9H49jk8wSVCjtMgKh03+qio553AZWAGqwfIf66qz5539t63OsARSdrOf?=
 =?us-ascii?Q?BjY0RYQ3rdx6qqUN4RRrbnJX0sY+O53kwr6iNgzTigMe2uoTjn7lWP5JIkp9?=
 =?us-ascii?Q?x0s+b21xxOW01+YweT0wBKxhORU1ufiRz9xTO4fx9YnSSXPx27rZJgwnaQve?=
 =?us-ascii?Q?gze9SKnTJsedaXIAU3fioZQv1Ziga6aDxoYPn4r9BEAQM0NzOagW/vxvMrfS?=
 =?us-ascii?Q?VQhz00npC/5ZaVKtN5iD/VI8fhnYCbLnvlYKiRue+/9dZ6t92ZFzm9uLZEZR?=
 =?us-ascii?Q?nnyaC7ugs3XMz7k5+xw2WHXL6Ri2zqUoWKGzjM8s7hjtMjnw+EzXgaS6e/7w?=
 =?us-ascii?Q?Zg7OQhkDR1IE+5HduRdvRsTvlj+ui38zKI4/Dv3JsAGyVHdBYI8lDAKz3k4y?=
 =?us-ascii?Q?Rh543sxsKJjVMeMK7ysYWqNNkqWd8zvttsT4/3IWoLmoa2en7ara5zCPOc/a?=
 =?us-ascii?Q?4Pu7p7CWqNuc96QhKgGMgN07mHdtiNyodsVnqqsBNZjzvn3iRkNsLYVlCKFC?=
 =?us-ascii?Q?vOuJ99sBhyUsYjlGf+nv5zACOtzit5Htu43X+hyGsz9ez0nISV1GE3YyQZvg?=
 =?us-ascii?Q?xPBtWQYx0hVNy18+PnL+kB2WbVfqVO2lcp7eOX2y8yN7Br6D2RqvxvpRxxg4?=
 =?us-ascii?Q?IL9hi6h4xn1oSY79Svi+c4H+9CxpLZNL2AZ7xB3K7ahl25As5OWqqcmFL1Er?=
 =?us-ascii?Q?i5PfBxqJ54LtoJEipBLJXmEkT+qI6Mlt55xCWm6pKcqkZx89PGvvOGfRmonq?=
 =?us-ascii?Q?ldath/PqMQCZdAfIs7eaepahW0+mN9aqEK5yUfpU/od7wMEhsZ1DAyqOa2KM?=
 =?us-ascii?Q?D9OPzSv68AkVBOXnS0EYqb0xbgnktX1rT8MnH/0po8JAfWS8v7o2OtygD1WG?=
 =?us-ascii?Q?KoxGrZQGZ5ZbRpUU9jOQulq5aui0M/G5sVKWsgJleLWB1SAHGBFZd/f2fhg9?=
 =?us-ascii?Q?hgTJsbaY8mQ1YxyvWViS5JRU14VIUQ8jlF7UfQxDLlHql+n1/LzzHHFz6DFo?=
 =?us-ascii?Q?vHnXTzjI+sgPoVUktgU7xqAD6XuJTrsVfoDe9ILdeR1lowr8xv9Ic0Auda3+?=
 =?us-ascii?Q?bb1ek4qe11+mgAGGLmtIkgATIwS0YwSFridylhGG128CGgGUC0uMhq/TSFri?=
 =?us-ascii?Q?7Re80R2h0k2gQd9XLteqJUrNaxBPTTBjlmdYNT9LVZZJNEoCCcI2leHN91lk?=
 =?us-ascii?Q?HNNEQ28VZw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: f931b2a6-3caa-490e-3606-08da2428b880
X-MS-Exchange-CrossTenant-AuthSource: BYAPR11MB3062.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 22 Apr 2022 06:24:14.2798
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: yfqDuCDL3gfS4JpWySXKXTQyVMG2oLgVadF73IkYwDltlOO/LaJVQcxi/fR/aNBhvVFWMsohdwJARIUZu7yf2g==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH0PR11MB4855
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Apr 21, 2022 at 04:34:09PM +0800, ying.huang@intel.com wrote:
> On Thu, 2022-04-21 at 16:17 +0800, Aaron Lu wrote:
> > On Thu, Apr 21, 2022 at 03:49:21PM +0800, ying.huang@intel.com wrote:

... ...

> > > For swap-in latency, we can use pmbench, which can output latency
> > > information.
> > > 
> > 
> > OK, I'll give pmbench a run, thanks for the suggestion.
> 
> Better to construct a senario with more swapin than swapout.  For
> example, start a memory eater, then kill it later.

What about vm-scalability/case-swapin?
https://git.kernel.org/pub/scm/linux/kernel/git/wfg/vm-scalability.git/tree/case-swapin

I think you are pretty familiar with it but still:
1) it starts $nr_task processes and each mmaps $size/$nr_task area and
   then consumes the memory, after this, it waits for a signal;
2) start another process to consume $size memory to push the memory in
   step 1) to swap device;
3) kick processes in step 1) to start accessing their memory, thus
   trigger swapins. The metric of this testcase is the swapin throughput.

I plan to restrict the cgroup's limit to $size.

Considering there is only one NVMe drive attached to node 0, I will run
the test as described before:
1) bind processes to run on node 0, allocate on node 1 to test the
   performance when reclaimer's node id is the same as swap device's.
2) bind processes to run on node 1, allocate on node 0 to test the
   performance when page's node id is the same as swap device's.

Ying and Yang,

Let me know what you think about the case used and the way the test is
conducted.
