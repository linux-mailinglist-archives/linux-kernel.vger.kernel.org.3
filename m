Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 324C3588783
	for <lists+linux-kernel@lfdr.de>; Wed,  3 Aug 2022 08:42:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233271AbiHCGlr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 3 Aug 2022 02:41:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237343AbiHCGln (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 3 Aug 2022 02:41:43 -0400
Received: from mga04.intel.com (mga04.intel.com [192.55.52.120])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F169039BB8
        for <linux-kernel@vger.kernel.org>; Tue,  2 Aug 2022 23:41:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1659508902; x=1691044902;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=e6UEXdVPhefBi16wQWAQyhTcYPcdV+gA7w+Sa2nqUO8=;
  b=HA0+Lqwi1NDiANLxp63LO16+yI9pwAUfsv8HUmUSR1L/8jdaDjXAt5hm
   amuy+987tKFT5zovEzipYyrwKacRZAUbKMUhO2fDdSES5sR0w0iVknCw7
   xIKrsNShC1d/AaGgp6gEIKR555EGig03gOAbEbBMsH5geuVEjoev7wEXF
   2/FC+ogvRt57p9VWrNUjLzo9kfDyBlB2PgVXy9r+TGhIrp9qo3Y3/27nA
   AleMjGuAN6SbzqmGhOcw3SYLXW/Vnw6sh7vB8G2Sx7DmHY0RtB71TqN4A
   0qm0jAGfFQT5fLx5022gNN9yz/GuPeAAloem1MQUSTDLqPzvSr2NMOX95
   A==;
X-IronPort-AV: E=McAfee;i="6400,9594,10427"; a="288356319"
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="288356319"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by fmsmga104.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 02 Aug 2022 23:41:42 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,213,1654585200"; 
   d="scan'208";a="635572848"
Received: from fmsmsx605.amr.corp.intel.com ([10.18.126.85])
  by orsmga001.jf.intel.com with ESMTP; 02 Aug 2022 23:41:42 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx605.amr.corp.intel.com (10.18.126.85) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 23:41:41 -0700
Received: from fmsmsx606.amr.corp.intel.com (10.18.126.86) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28; Tue, 2 Aug 2022 23:41:41 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx606.amr.corp.intel.com (10.18.126.86) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.28 via Frontend Transport; Tue, 2 Aug 2022 23:41:41 -0700
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (104.47.55.105)
 by edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Tue, 2 Aug 2022 23:41:40 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=SIDezd8Z9vrwjN+9idxIovxF8CT4zv2INU1kPoaXxsLKTwg/vtQUgDrXjMDuvdLwSQy3H7+3lC5fWiv9275ysJYXsPNVcnEw7400Vfnan1HvQdHYSeO367v+NeEQu7lwkwZLEtUK8UqPkV+8kNG5kRKrgnVy9GUc6g1y0sOHIWSFDb0Tbst3x6sqDeBXM4udDQTr5hPb2rzrPrLbBw54e+WJ2S+jW5rzzh5TRvuAbiGE9DFyv7Xxky4mp1jRw0FfSEezn03e1zeGzSsVZqup4scsBMRw4ZkS0BcAECf7yrQxwdDgHGMc0Q2/xTu+oZpLVPUaa8u/MEtCcaYsSCjZ8A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=7RaLc1AGQyI9HJB2SbA4tRRWQ18UZ5I2fWPyQYhQKZ0=;
 b=ny60R2+JZzVw83HrSFiJRvEY9YLUuo1xG1LdkraGCD+OG2EFa+oOcOPPkBMXXIFvVgX73ZxnItYGvqBhNq7HqrTZkFj3P1XN/7uKkUbL81j9Ti9dI6Igw3MfO6YXZ+x4QTUYo4+PQoFq/RGfNApumlHL9vxyBe+zPH/oHFatA0Pk74shIPQMThDkBxZJ0yXkNVUYUcoBuK4mzC+6vrhWN1YF/o5vfSBKmWTOcmzCY61t1Xny0x10kZnZROBHtcxAFRYB0i5FST2hcQuUlSVp3d6qqcg7O74qZfadUT/qA9MGAXFlojIEt63+p35y18qQlHCnXs/xevBQTMAKAEVFOg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by SN7PR11MB6750.namprd11.prod.outlook.com (2603:10b6:806:266::21) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5482.14; Wed, 3 Aug
 2022 06:41:33 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::8525:4565:6b49:dc55%6]) with mapi id 15.20.5458.024; Wed, 3 Aug 2022
 06:41:33 +0000
Date:   Wed, 3 Aug 2022 14:41:20 +0800
From:   Feng Tang <feng.tang@intel.com>
To:     Michal Hocko <mhocko@suse.com>
CC:     Muchun Song <songmuchun@bytedance.com>,
        "akpm@linux-foundation.org" <akpm@linux-foundation.org>,
        "bwidawsk@kernel.org" <bwidawsk@kernel.org>,
        "dave.hansen@linux.intel.com" <dave.hansen@linux.intel.com>,
        "linux-mm@kvack.org" <linux-mm@kvack.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [PATCH] mm: mempolicy: fix policy_nodemask() for
 MPOL_PREFERRED_MANY case
Message-ID: <YuoYkPk+YzdPNvmN@feng-snb>
References: <20220801084207.39086-1-songmuchun@bytedance.com>
 <YueXhmiFcI8iw3OI@dhcp22.suse.cz>
 <YuecP/RKXWz7QAs0@feng-skl>
 <YuidPA9knCOoaT0c@FVFYT0MHHV2J>
 <Yui7hWZYMX31ktOr@feng-skl>
 <YujGy8EIeZc1Avc7@FVFYT0MHHV2J>
 <YujUyCIBjFj+FzX5@feng-skl>
 <YujoLQt09Js/sSQL@dhcp22.suse.cz>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <YujoLQt09Js/sSQL@dhcp22.suse.cz>
X-ClientProxiedBy: SG2PR06CA0230.apcprd06.prod.outlook.com
 (2603:1096:4:ac::14) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8f596738-0744-44d8-05f3-08da751b34b1
X-MS-TrafficTypeDiagnostic: SN7PR11MB6750:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Z6PSG+KY76xUgE6ekJ4cf/c87eaIIj8uAQMXwvuawsMUKR3j+1n2RnDXtuvNNPsMmq7FlSC441lOAokx/h/nAKlKryIoyBXezOB79MG6t+2UJfY3t1b1O1ZW3+SWvxAYrCJsbWfRPqjzIMAKUQ7HkljxTtbaAmYcdJPURsENTSIB3JeS4hUqdIrbeN2Xezuxi77lP0ZytMoEQhHJooWGPwevFrpQfzkMVQHGK/gRa4A2PjgmjCiTEvzA6R18641UMGtibjuFi1GDl4ulIHcVq4z66Tp9gpLxVEA054FXX4f4pLqdWzRk6T5iy6WZRBHRdjQg+O77UaYPTCDouOEDqW9I9fcwnN/Qn3wbA+yoEKnKLYDQnkXFBraindQwtdSqkJaEP3tJ7KhsFu2aCtEPd51leSHaASuBmV+wB9snpu8URBZN4Vs6Dx2eBIlH92rqRuAUoloIFHFoM4meHpW/jgPyAxnR/cECPdNIet6GlUNIHZ09Q6B6qiOV4JfAt4pKeEff3KAmlgPpEVpKC9jB2/eiSftTLDnOTBMwJqqumWuL1Xj3U4ee6tjEfxRgmV4EoH2gvawvoto6seHiyEOh5jrjgpH6ZHqWKey9Wcku+/thS0bQExwGfgi+zSaTJ78PRl/qOGUXaCLAvdInP2vuBpcitGdXsSxS13TEfWxsR1mhtAhVkJGy8yvzUo/DljIWRmKwpKs1mi/UofFwgIyPSJOOc+8kxxphSgRu1aeZgwi7OMarJi55BprsoUfA2AwX+FWf1EcaeZfxEVlkK29uadLEvKITvjJxE8CboI/irg8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(366004)(39860400002)(396003)(136003)(66946007)(38100700002)(44832011)(9686003)(26005)(6512007)(82960400001)(6486002)(6506007)(6666004)(41300700001)(66556008)(478600001)(66476007)(5660300002)(4326008)(8676002)(2906002)(8936002)(86362001)(54906003)(316002)(6916009)(186003)(33716001)(67856001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?zqDpoNIXJyXqnaUQhIfM9BwiiVL0M3wIAg3Bb28qbE6+p2aDPcYGhdZXoHFB?=
 =?us-ascii?Q?Vdqtfc43EZGSu9vpDQrRSasZ1a+y3eDp5dLLEhXLyknxOot/R13Mv5Wl0peP?=
 =?us-ascii?Q?7dcwTYyQ421yZUByaBxYKd/3/BsA0WOYu34nfs4ygi3B0MjUWEg0ckPnt7oo?=
 =?us-ascii?Q?0YqRmkWpC3ljRcQ0kVJXtfHRoq+Un/FJ840AgcoZB2ioIwvoePcF1xIgJjSn?=
 =?us-ascii?Q?ZGLjyJkrpcfBN3mVwTHTaJTxwOcJr1DXbLcfexs0dAEhDRrwFLNvUxz4YpLl?=
 =?us-ascii?Q?jCF9zYoNpMtZnlR6VsdTpL+04rdok9CEd0Whps0HsCck2QJJ+wygCiwtfyzY?=
 =?us-ascii?Q?p4P+95yRHPmnHw1iiJmnIDgmEsJMFNXyXw58PxqWOSq5bpQXbVpIW33saLAp?=
 =?us-ascii?Q?1FlFUIkHEoutlcCd4sF54M8BeIZ1CP2C5JzQA8AlONH2YA5yAk90OhNpIRMr?=
 =?us-ascii?Q?Lmg2+H5Jqlq89ChrflwauDl2NzaEOcUE14Sx7iZEN2UkfYwxuwJ1dvuyAy2k?=
 =?us-ascii?Q?pFBqG/k8uuq5hKbwOoH7ul7yRARCa8F1bbWxKonqtLTNtUKpneV1R21KQjY0?=
 =?us-ascii?Q?Yt/Sxrhy+7+9hAc1gx64KlT/o6nVl4KAMkrhr3HljFcehSAC36U+xjxeki5t?=
 =?us-ascii?Q?RZ9Nmzuo0W+K37EifxPp4pEWwJCgOgye3m6k12dmmSdEkFZN3jjfhefz4vrk?=
 =?us-ascii?Q?4UIh04D3AedLfFCK9LwgB605oDPw1hSEJLKmJxqcbVw+TM2G43MtkI6QhPn3?=
 =?us-ascii?Q?0eZN+KCasG9+DQRAs0xuMNaPrvmJs5gwV4MMreoOoCOH3pWB0tOju2z/R6N0?=
 =?us-ascii?Q?qPDTru7aajgiX1lAP5pUfXrzjaWFs7CwJoJMcwiZdV7piTU0OtBSfTPzG4zp?=
 =?us-ascii?Q?jXm7s0DDzn7dlqdSvt6bPm7OqaVKlQLAOU3YTlNMLebYS7nTfYg9Z3r0uvo7?=
 =?us-ascii?Q?BIjgfivFuQMHpaUinkjJ6g8pMtQKXbV/ej4FwBUNRAtT8Ptatu/nMfjI04sd?=
 =?us-ascii?Q?n0nsOtsCnprrjxzckHSrW78NYKdCc9aG4VCd7nccQ/zDALkhEX6b46NQdeVM?=
 =?us-ascii?Q?ZhFrO0+gfOaZBc/BQF7QzSF1pKF+ZtGVRzBoNJxMhBVeRCix3CGYRbByIv6r?=
 =?us-ascii?Q?+eJpcRQldtVzvMFjgIozLS3WP3JMzr8nulEPFWV3YKa4AskCmmF2lNRl+IkO?=
 =?us-ascii?Q?m2Dmp5h4smUmGM3Jfgh79XTlk3TZBn3t89kVFvIexXIfniRdkoH9jq9OJC8p?=
 =?us-ascii?Q?x3ojKVqTbndVc5TiEZYMjEUG6Nr/jl2nZ1dLgc9rUA7ONpZzWslbt6s7Wp3r?=
 =?us-ascii?Q?rdLxMu5mPntoMcn+qj6tOj7STcWT61P6jrWzu23AcpylCjfOU8pYYru8qKvL?=
 =?us-ascii?Q?ch5/3tykM6kTpwZ+lHstG+HBLgyEN77F+Viv1DYx+TSnZrURE3Mm7QJOsBTo?=
 =?us-ascii?Q?b1i4aHIKwmppzB9x5GhannTbajhEy0eHFgASOHUAUIwZmRoAyOnLaQROgasl?=
 =?us-ascii?Q?q334sbUpv977CychFGWHPrTIAV9u2sEoz226keQYH/Vc/a7PfXVKd8btGwgb?=
 =?us-ascii?Q?vITXiaiz1lQfw3pljbzBhWCFspqKNyif9hJgT4mm?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 8f596738-0744-44d8-05f3-08da751b34b1
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Aug 2022 06:41:33.6804
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Jo7XIadSLcvthOcpeKuB6g4UqLYzY2OmHddSxXztefjz5ZTumN1uAXJW1ba0ry9EXIfA5pDdJzDRAJYO1Noscw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SN7PR11MB6750
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Aug 02, 2022 at 05:02:37PM +0800, Michal Hocko wrote:
> Please make sure to CC Mike on hugetlb related changes.

OK.

> I didn't really get to grasp your proposed solution but it feels goind
> sideways. The real issue is that hugetlb uses a dedicated allocation
> scheme which is not fully MPOL_PREFERRED_MANY aware AFAICS. I do not
> think we should be tricking that by providing some fake nodemasks and
> what not.
> 
> The good news is that allocation from the pool is MPOL_PREFERRED_MANY
> aware because it first tries to allocation from the preffered node mask
> and then fall back to the full nodemask (dequeue_huge_page_vma).
> If the existing pools cannot really satisfy that allocation then it
> tries to allocate a new hugetlb page (alloc_fresh_huge_page) which also
> performs 2 stage allocation with the node mask and no node masks. But
> both of them might fail.
> 
> The bad news is that other allocation functions - including those that
> allocate to the pool are not fully MPOL_PREFERRED_MANY aware. E.g.
> __nr_hugepages_store_common paths which use the allocating process
> policy to fill up the pool so the pool could be under provisioned if
> that context is using MPOL_PREFERRED_MANY.

Thanks for the check!

So you mean if the prferred nodes don't have enough pages, we should
also fallback to all like dequeue_huge_page_vma() does?

Or we can user a policy API which return nodemask for MPOL_BIND and 
NULL for all other policies, like allowed_mems_nr() needs.

--- a/include/linux/mempolicy.h
+++ b/include/linux/mempolicy.h
@@ -158,6 +158,18 @@ static inline nodemask_t *policy_nodemask_current(gfp_t gfp)
 	return policy_nodemask(gfp, mpol);
 }
 
+#ifdef CONFIG_HUGETLB_FS
+static inline nodemask_t *strict_policy_nodemask_current(void)
+{
+	struct mempolicy *mpol = get_task_policy(current);
+
+	if (mpol->mode == MPOL_BIND)
+		return &mpol->nodes;
+
+	return NULL;
+}
+#endif
+

> Wrt. allowed_mems_nr (i.e. hugetlb_acct_memory) this is a reservation
> code and I have to admit I do not really remember details there. This is
> a subtle code and my best guess would be that policy_nodemask_current
> should be hugetlb specific and only care about MPOL_BIND.

The API needed by allowed_mem_nr() is a little different as it has gfp
flag and cpuset config to consider.

Thanks,
Feng

[snip]
