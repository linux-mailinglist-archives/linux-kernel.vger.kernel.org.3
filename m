Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E10A759D443
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 10:24:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242744AbiHWIUI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 23 Aug 2022 04:20:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45802 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242795AbiHWIP6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 23 Aug 2022 04:15:58 -0400
Received: from mga06.intel.com (mga06b.intel.com [134.134.136.31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9BAD46DAE5
        for <linux-kernel@vger.kernel.org>; Tue, 23 Aug 2022 01:10:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661242228; x=1692778228;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=Ek8lcxdOcbzlriEyrFMTYky0SfCP0denXtCZc4A9B/0=;
  b=IiZUY3p1OLY6CgcQVcRKz7+AuswCYl5Q+sBwoQhiWUbBzGc2wd6ThxhN
   piG+s0GnbLayaWZES+9wH4Cjz92pZSPa6N/oISvC8sWS9wJEgOT6q9QiS
   0OQe2hUffrw+T35V29RopoqJs35l/+WX01rLnO0X7jYSREqf6hIDguHNu
   epd7S4IF00ujEP//t/YWznmS1Rqm84IEfkCL5jWDYUFaNqqgySnB3Rdl2
   nbspOlVkXmml0TpO8NCJEy6H28utex54y2HP27w1uHvFbvNNo2zbFQwah
   ZGQ06Vo1CCUZSU9hF+kg3eq0rpvnVJCNmh/2/4neXKwwUKLt9STcuIQFM
   Q==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="355353810"
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="355353810"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by orsmga104.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 23 Aug 2022 01:10:27 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,257,1654585200"; 
   d="scan'208";a="751604100"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga001.fm.intel.com with ESMTP; 23 Aug 2022 01:10:26 -0700
Received: from orsmsx611.amr.corp.intel.com (10.22.229.24) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 01:10:26 -0700
Received: from orsmsx607.amr.corp.intel.com (10.22.229.20) by
 ORSMSX611.amr.corp.intel.com (10.22.229.24) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Tue, 23 Aug 2022 01:10:25 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx607.amr.corp.intel.com (10.22.229.20) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Tue, 23 Aug 2022 01:10:25 -0700
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (104.47.59.174)
 by edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Tue, 23 Aug 2022 01:10:25 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=ITyBGALHtQsVWr95CM2tnf/VQmN9HXlUYc71M2EioypfIid4jJ8hm+zhcDNXBwDOMc4CxEUXVZQm4C05U4hj76Bx2vqh/rWj5V80FDcemIRnGEd+84Ke4lK27H/VdsCoKbUT4UBZPwSr3ttxznynVwqwP4Mg6rglyAW2jONEVsudZR4k95toL/gDkU/M+5+LWIP0AC3yqdwhffOk4FCzB7ZrD5ueytQQjee5nMYE6Ch9CPpQ1gruOTC1T8m581QvILx3GXwuXsdhL41sqmYLKX+7XpJHiem6BW5D5PnNFKDjjlXIkLnDQxbOpuwfR8P1SiW9ubI/s+e/TdFcRspqnA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=ckEb/+NkfQVbwoKdOfV6fj/hCnQihIWx/MCRO6KnoXY=;
 b=WaeMdA9BiPPydVNNa/3ESkjWW1/tTA1X02uLPvPJycdZ9G7l/WBumYdE89KKPOdA0K4JZSEd/svpHMzyYOkKbwd2YQKvWTTWFkqrY1Zdh48eRyQ9jKYwbbBCOslUxK6OfxRPjyIHJvWjdOtHK0OVAtw9D5TmrF4i9BGqfSz1gP8DyQpnEUxypqqXyqycfHXRFER7dt5s0tsVPVEvOUWadHbUsS4Akrmn0IXnoE8gNa1gksjnxOBsx/XZOZ2ZSE9Uva4YQuCQsTjIFv2cIb9A4Zc22bZeB3ZkIt8r+hBBRvJW2/NatkrcyJ9jhSndJiLnDDyaiQLsVOiBTQPx+f78IQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by DM4PR11MB6019.namprd11.prod.outlook.com (2603:10b6:8:60::5) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5546.23; Tue, 23 Aug 2022 08:10:24 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::7c1d:1bee:fe96:695c]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::7c1d:1bee:fe96:695c%5]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 08:10:23 +0000
Date:   Tue, 23 Aug 2022 16:09:54 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <yangyicong@hisilicon.com>, <peterz@infradead.org>,
        <mingo@redhat.com>, <juri.lelli@redhat.com>,
        <vincent.guittot@linaro.org>, <tim.c.chen@linux.intel.com>,
        <gautham.shenoy@amd.com>, <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <jonathan.cameron@huawei.com>,
        <ego@linux.vnet.ibm.com>, <srikar@linux.vnet.ibm.com>,
        <linuxarm@huawei.com>, <21cnbao@gmail.com>,
        <guodong.xu@linaro.org>, <hesham.almatary@huawei.com>,
        <john.garry@huawei.com>, <shenyang39@huawei.com>,
        <kprateek.nayak@amd.com>, <wuyun.abel@bytedance.com>
Subject: Re: [PATCH v7 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <YwSLUuSgUPwV1580@chenyu5-mobl1>
References: <20220822073610.27205-1-yangyicong@huawei.com>
 <20220822073610.27205-3-yangyicong@huawei.com>
 <YwRNXrBG9iq1jGZW@chenyu5-mobl1>
 <53b1fc3c-b6a9-a4cb-433a-c5c6af1d1dac@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <53b1fc3c-b6a9-a4cb-433a-c5c6af1d1dac@huawei.com>
X-ClientProxiedBy: SG2P153CA0030.APCP153.PROD.OUTLOOK.COM (2603:1096:4:c7::17)
 To MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9fb9a779-d2e4-4b6a-1b5e-08da84deedd3
X-MS-TrafficTypeDiagnostic: DM4PR11MB6019:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8Qtxc41A+od2Fshn4Z7P549dkXO6bc008NcCkz7JV9mnYshKBJDUigJEmjo33tyshse4zFdqMRGUfTGa2JzM1ivjLIJy1sgQbrlUwA5IFvLmtG+A3xF89ejFRbtSrAl009iWq0m4SSpprVy8T2gbyKdA2k0XPJIDF0hatKkUcXwqsIn1yflxMLc22NE624c4gW0wLsQZQMxFwhe8Tb6c/nApQgeUU7aW15mHm4MX8S5IZAEnEr9YtsNhQWmkBIYssZwReP9cH2wcAKT93fv7hb4CqnH/HDDNN/WqTQ0jePoU/i4D56KPBKY9n6/akrUtWF6xxk2mSdkVMK5nf/JDdOH0ysEOQCXaMBW9CgrzZU9CMmQDAduHcu/XtGQme4gAri+ekkKjBRR+t6JedCK7LvPkFrLaLm2IgGI4AivAFoyCmGdWS4QjoqbrGXHTlrlo6RlXlkKF5AlkTeEyE/evR2svMD7aOtJNl70/yRGyfv70ic0WsR06FpIzHuplc+uqksxWd0Dr79qq3Kln5rfiWC82kkyoSNoIqPoDw+cjzRbMqT1zZUg+vmG36k9OJsqnpkYqCd4kB1Ok5Z1lppp4zH3JQllq64KYZ3BM3AL0Bgli+nhN443JEGry8nG9KGJ6nccoMAhqfNffJW6YBSVHXyEt7UH8L4ijPn4HFWF7o9hd7UY78S5sPOOrsoQQKT92MpsInShOOO7G2dtu52X1zMOh1Db0b4RM1OWJNmpDJoQ=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(346002)(376002)(396003)(136003)(39860400002)(366004)(86362001)(82960400001)(38100700002)(316002)(6916009)(8936002)(66476007)(7416002)(5660300002)(4326008)(8676002)(66556008)(2906002)(83380400001)(66946007)(186003)(478600001)(9686003)(6486002)(53546011)(6506007)(6512007)(41300700001)(6666004)(33716001)(26005);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?+p+1CCT1x2c7RZbNz0N3lPBpBPkBkI5t0a1UFW7t3lrTLBvqpve7Va9yrNw+?=
 =?us-ascii?Q?r+xn+mfdUEDgZ+DX0jpOG5/ZBxAuBYQF968ibKi/YD6SOa+R/6F/L1L2YvvE?=
 =?us-ascii?Q?TruEE0Um62CqqpSxKRQb6fmbeG7IXWR8C9ZdqE8n/pWDhDdyu2xG3M874Wfz?=
 =?us-ascii?Q?xBAYniOWk6wgF03xPgyd7ypmlIziVTrz6X25/DF3Jd4oIC6TvhM8vB2Vkqy9?=
 =?us-ascii?Q?1h5V3BvmIWSqIpLtIzpc2KcPKsokP8pTwq2G19e+srXBywcgBjB1r1LDI0SF?=
 =?us-ascii?Q?Sant9ZQDfJaWomn8efTFppLDqgFd3Wt0EOXLxb0z//i7xsWq27zZSKj0O8gn?=
 =?us-ascii?Q?lEX9KHN7E804lqyHjIEB+yIExY9ql9ypYhK0bgcXOsUuathwNmFzi+uhK4Uc?=
 =?us-ascii?Q?NNOxc9ltMz5DVrM1p9qfP2AjL7IPJug1ZgsLY9XiELqu1V+BA5Rslf+BqMPQ?=
 =?us-ascii?Q?Ohrsb2f+ZD/qoWFFevCNuUfkywjC8xy5qFj5CNJKsD3xnhEQ8b/FbGNNkVs4?=
 =?us-ascii?Q?CCXoLD3+GKgGdPgcOt/0kxBFkcjGdB3MtU5bBVAAduMd22k4FxljLbn1aANN?=
 =?us-ascii?Q?Ir93NG8ADwHOawJzd4jF5XOFBGKCh30oaxAXTIq/f3xp5qf6kyeGWXHjH/Fc?=
 =?us-ascii?Q?V92cMS03hfCQ3d96Ymbz6O8FZOAYLltLPCOkumtC1s7PVVz2JTmEQD8qqCHi?=
 =?us-ascii?Q?aRoWMnlDX6XxZCa8cFqMuHSATu11cyLA4zFRXZZMGymv77cAts2VV617JtN1?=
 =?us-ascii?Q?4A6V/EVpVsbj5Y13Xu0j0z/qoKprhS/6dAiud7YYslnl8z59lIwKNtksf8p/?=
 =?us-ascii?Q?vBywC7WZHv/CNW/M8NhlyiTxl+oUlc3Tu+Clp2XWDXadTswnFbuCgeeX+/3N?=
 =?us-ascii?Q?Of1D7cr1ZbWFSrpWB+eYkDVuup4FSNwBDOm30Zp+SE5dJG4f6gKqcYOB/QGb?=
 =?us-ascii?Q?+P9bwXVVBwXGhvG811dCdK+3YJqoMDwIBzxHb0ScD31bmU/YpWlm1RDtuhqh?=
 =?us-ascii?Q?clGY9ybFhc8SIbK0YG2YnciAacGgEQ2A3kQOE6A87VHZhd1ov7TUSjbFUzdS?=
 =?us-ascii?Q?ZNWKuYKcH5I8CU9YOaiq6HjEgeoHVFjqdQzpqbaNpThP1KoLe5SWJ0gMzrhw?=
 =?us-ascii?Q?ZJ1Az3gkO7wW2aN9ZiZLlEl2ideeYTTSHxwITU1Csvdq/AtQoU2Tlmw/k2VW?=
 =?us-ascii?Q?muWsbdeq4QPLV+X5vMahw5aYV38lTIFh51sql/PJsqLd/Kz6y6O8jm59sdyg?=
 =?us-ascii?Q?FMi5PY8c0pFKOEXv3wCEite1UGHmq+xiu6/CIX7baad39vJ4kkJ8dmFbYCTa?=
 =?us-ascii?Q?RphSqOfy6pZp6kxin3AwC5KcFzXkxYy7K/XIamuCuNN12/YuShijQISFwEeN?=
 =?us-ascii?Q?24VjO+1AtFVO0+lcAwMurS9M0a+FiyB4kv050B24J8zvqFmGvCXhmHtAzAXF?=
 =?us-ascii?Q?IJ+IPlKO53/4HSstSSFKw5WrY1gaPvgBJcu2zZB2lg1bsCAcvoqmihHq8gkV?=
 =?us-ascii?Q?NVErTkw+JrX1DUVtyHXEgnL8BeI24IA0ST07hgGIwJQsDIwjVRPcXMrC4syN?=
 =?us-ascii?Q?VZJRJ6AaLBQqWELbcx0zNOEkaPs520utld8+/A3l?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 9fb9a779-d2e4-4b6a-1b5e-08da84deedd3
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 08:10:23.6956
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: w10QcTs13Xlj4j6jxDCV/lpbzfNmxEitTsgD1WoyyoKAeMxKCCe0kXOMq3oRO5blG0JFYygLMe1cPmTQ00J1Zg==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM4PR11MB6019
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

On 2022-08-23 at 15:48:00 +0800, Yicong Yang wrote:
> On 2022/8/23 11:45, Chen Yu wrote:
> > On 2022-08-22 at 15:36:10 +0800, Yicong Yang wrote:
> >> From: Barry Song <song.bao.hua@hisilicon.com>
> >>
> >> For platforms having clusters like Kunpeng920, CPUs within the same cluster
> >> have lower latency when synchronizing and accessing shared resources like
> >> cache. Thus, this patch tries to find an idle cpu within the cluster of the
> >> target CPU before scanning the whole LLC to gain lower latency.
> >>
> >> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
> >> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
> >>
> >> With this patch, We noticed enhancement on tbench within one numa or cross
> >> two numa.
> >>
> >> On numa 0:
> >>                              6.0-rc1                patched
> >> Hmean     1        351.20 (   0.00%)      396.45 *  12.88%*
> >> Hmean     2        700.43 (   0.00%)      793.76 *  13.32%*
> >> Hmean     4       1404.42 (   0.00%)     1583.62 *  12.76%*
> >> Hmean     8       2833.31 (   0.00%)     3147.85 *  11.10%*
> >> Hmean     16      5501.90 (   0.00%)     6089.89 *  10.69%*
> >> Hmean     32     10428.59 (   0.00%)    10619.63 *   1.83%*
> >> Hmean     64      8223.39 (   0.00%)     8306.93 *   1.02%*
> >> Hmean     128     7042.88 (   0.00%)     7068.03 *   0.36%*
> >>
> >> On numa 0-1:
> >>                              6.0-rc1                patched
> >> Hmean     1        363.06 (   0.00%)      397.13 *   9.38%*
> >> Hmean     2        721.68 (   0.00%)      789.84 *   9.44%*
> >> Hmean     4       1435.15 (   0.00%)     1566.01 *   9.12%*
> >> Hmean     8       2776.17 (   0.00%)     3007.05 *   8.32%*
> >> Hmean     16      5471.71 (   0.00%)     6103.91 *  11.55%*
> >> Hmean     32     10164.98 (   0.00%)    11531.81 *  13.45%*
> >> Hmean     64     17143.28 (   0.00%)    20078.68 *  17.12%*
> >> Hmean     128    14552.70 (   0.00%)    15156.41 *   4.15%*
> >> Hmean     256    12827.37 (   0.00%)    13326.86 *   3.89%*
> >>
> >> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
> >> in the code has not been tested but it supposed to work.
> >>
> >> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> >> [https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
> >> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> >> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> >> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> >> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> >> ---
> >>  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
> >>  kernel/sched/sched.h    |  2 ++
> >>  kernel/sched/topology.c | 10 ++++++++++
> >>  3 files changed, 39 insertions(+), 3 deletions(-)
> >>
> >> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> >> index 914096c5b1ae..6fa77610d0f5 100644
> >> --- a/kernel/sched/fair.c
> >> +++ b/kernel/sched/fair.c
> >> @@ -6437,6 +6437,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
> >>  		}
> >>  	}
> >>  
> >> +	if (static_branch_unlikely(&sched_cluster_active)) {
> >> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
> >> +
> >> +		if (sdc) {
> >> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
> > Looks good to me. One minor question, why don't we use
> > cpumask_and(cpus, sched_domain_span(sdc), cpus);
> >> +				if (!cpumask_test_cpu(cpu, cpus))
> >> +					continue;
> > so above check can be removed in each loop?
> 
> Since we'll need to recalculate the mask of rest CPUs to test in the LLC after scanning the cluster CPUs.
>
I was thinking of introducing a temporary variable
cpumask_and(cpus_cluster, sched_domain_span(sdc), cpus);
and iterate this cpus_cluster in the loop. But since the
cpus is reused, it is ok to be as it is.
> > Besides may I know what version this patch
> > is based on? since I failed to apply the patch on v6.0-rc2. Other than that:
> > 
> 
> It's on 6.0-rc1 when sent but can be cleanly rebased on rc2:
> 
> yangyicong@ubuntu:~/mainline_linux/linux_sub_workspace$ git log --oneline -3
> 0079c27ba265 (HEAD -> topost-cls-v7, topost-cls-v6) sched/fair: Scan cluster before scanning LLC in wake-up path
> 1ecb9e322bd7 sched: Add per_cpu cluster domain info and cpus_share_lowest_cache API
I did not apply 1/2, and that was why it failed I think. Thanks for explaination.

Thanks,
Chenyu
> 1c23f9e627a7 (tag: v6.0-rc2, origin/master, origin/HEAD, master) Linux 6.0-rc2
> 
> So I'm not sure where's the problem...
> 
> > Reviewed-by: Chen Yu <yu.c.chen@intel.com>
> > 
> 
> Thanks!
> 
> > thanks,
> > Chenyu
> >> +
> >> +				if (has_idle_core) {
> >> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> >> +					if ((unsigned int)i < nr_cpumask_bits)
> >> +						return i;
> >> +				} else {
> >> +					if (--nr <= 0)
> >> +						return -1;
> >> +					idle_cpu = __select_idle_cpu(cpu, p);
> >> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
> >> +						return idle_cpu;
> >> +				}
> >> +			}
> >> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
> >> +		}
> >> +	}
> > .
> > 
