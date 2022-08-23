Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 390A659CFAF
	for <lists+linux-kernel@lfdr.de>; Tue, 23 Aug 2022 05:48:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239260AbiHWDqK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 22 Aug 2022 23:46:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42650 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238735AbiHWDqF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 22 Aug 2022 23:46:05 -0400
Received: from mga11.intel.com (mga11.intel.com [192.55.52.93])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 127A35E316
        for <linux-kernel@vger.kernel.org>; Mon, 22 Aug 2022 20:46:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1661226362; x=1692762362;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=eHZqSNr6S/IfAMbzaP4I/I9ZtG1oMiWe/30sjT7JjLs=;
  b=Q/NIMssyJbbT/sRluNLnwDMvvM3MHOQuCHB2v9nCu/TlGJfqTOuX296b
   HOwnzAWco3C+FtJaXaLK7zWQ1ntZyZWaf3hWhG4FXFJcmg8sd7D3UpWIU
   YZi2EIkJECckGfIUyg6lHMzwHLNSTxN7mH7mHmYTWzLPVyCD6MQAUkfJs
   Ab/2Yt+AbqeBwXp3LuFvN7hYNhDdQBW2OMNMQMszm4Ro287rSJ/Flx2rT
   0CVQ2dMBN2pTYg4JyGMASAXJOULvoN3lXmW3ZG0R1dFDvulTH8AyRnZIL
   DPLSu+hHxknEa8wj6Oqi8KIllHe0J7Mj52r6teHUR+glDFwYfXFvda9CF
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10447"; a="291138829"
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="291138829"
Received: from fmsmga001.fm.intel.com ([10.253.24.23])
  by fmsmga102.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 22 Aug 2022 20:46:01 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,256,1654585200"; 
   d="scan'208";a="751540582"
Received: from orsmsx603.amr.corp.intel.com ([10.22.229.16])
  by fmsmga001.fm.intel.com with ESMTP; 22 Aug 2022 20:46:00 -0700
Received: from orsmsx612.amr.corp.intel.com (10.22.229.25) by
 ORSMSX603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 20:46:00 -0700
Received: from orsmsx602.amr.corp.intel.com (10.22.229.15) by
 ORSMSX612.amr.corp.intel.com (10.22.229.25) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Mon, 22 Aug 2022 20:45:59 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Mon, 22 Aug 2022 20:45:59 -0700
Received: from NAM02-BN1-obe.outbound.protection.outlook.com (104.47.51.43) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Mon, 22 Aug 2022 20:45:58 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=jH8bQtc5mmAp3H1uRXKRE1ti9o9QLM6+gmL4mtlT89xqbLTPgsjTsGs7EKAyTbzTMhF2fNyLYLmMnoF1dz7SP6/B4Uem01O3P5DRCe6dPII4TOojk4Hu15UKxDy1ei0IX74LJrBlrg225p7s087lzFcZ/zQANRHUUu7oqgT497e1woQJm8t0ES+Vk7c7DT2oqtxlth/aZWyMt+L7/jEq/q63kzelVUZ8J9xieDfhhbHQTZb8F318y1/jSXD7PZru2SWBpQ3zKgCmnd7kVvPCp5lqVoYkYLLTZ7ShJIdYdrSXG9wJYgGUA7jcwMVLIYRLBhHZcCSgESrJdHAWWGiQhw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=eo/HZx+C6/8rdxFny0l02IIMgf92WXSVD1Ilfif4Dl4=;
 b=eCT6C+vkTQk/w2geBI8XhLiXLJgR/mKYNV/4JZ2SpcyMPGXB4TlVpeldPImQ+zNg1vVOweTzD66Bk/ZzHH/dqZ20xe1TbsGvH+wUrQZnR9TJhZPJ7Z+jVwxlCfF4XX1n3KydU+AOV2fEApYI8U2vj/5k346y6O91M4x/hENAXtWrJ5Z7pGv08EWmfszN6OWJmZQGSEBGmBRDIolU2zVcChy9BGxX4uqNPPYGr94dM0bU3sfApvYUS61Kjl2qO/20VApqnz2lFrqN3pkQrW7c9ET3A1jnp/NWKxKZTro/Tfx0UbnGmv21pMzTdE/E8rfw5bieAqQWPo+1kCwtQ95f9A==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6206.namprd11.prod.outlook.com (2603:10b6:208:3c6::8)
 by PH8PR11MB7094.namprd11.prod.outlook.com (2603:10b6:510:216::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.20; Tue, 23 Aug
 2022 03:45:57 +0000
Received: from MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::7c1d:1bee:fe96:695c]) by MN0PR11MB6206.namprd11.prod.outlook.com
 ([fe80::7c1d:1bee:fe96:695c%5]) with mapi id 15.20.5546.022; Tue, 23 Aug 2022
 03:45:57 +0000
Date:   Tue, 23 Aug 2022 11:45:34 +0800
From:   Chen Yu <yu.c.chen@intel.com>
To:     Yicong Yang <yangyicong@huawei.com>
CC:     <peterz@infradead.org>, <mingo@redhat.com>,
        <juri.lelli@redhat.com>, <vincent.guittot@linaro.org>,
        <tim.c.chen@linux.intel.com>, <gautham.shenoy@amd.com>,
        <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>, <dietmar.eggemann@arm.com>,
        <rostedt@goodmis.org>, <bsegall@google.com>, <bristot@redhat.com>,
        <prime.zeng@huawei.com>, <yangyicong@hisilicon.com>,
        <jonathan.cameron@huawei.com>, <ego@linux.vnet.ibm.com>,
        <srikar@linux.vnet.ibm.com>, <linuxarm@huawei.com>,
        <21cnbao@gmail.com>, <guodong.xu@linaro.org>,
        <hesham.almatary@huawei.com>, <john.garry@huawei.com>,
        <shenyang39@huawei.com>, <kprateek.nayak@amd.com>,
        <wuyun.abel@bytedance.com>
Subject: Re: [PATCH v7 2/2] sched/fair: Scan cluster before scanning LLC in
 wake-up path
Message-ID: <YwRNXrBG9iq1jGZW@chenyu5-mobl1>
References: <20220822073610.27205-1-yangyicong@huawei.com>
 <20220822073610.27205-3-yangyicong@huawei.com>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <20220822073610.27205-3-yangyicong@huawei.com>
X-ClientProxiedBy: SG2PR02CA0088.apcprd02.prod.outlook.com
 (2603:1096:4:90::28) To MN0PR11MB6206.namprd11.prod.outlook.com
 (2603:10b6:208:3c6::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: de54591b-caf2-4f73-a3d6-08da84b9fc8e
X-MS-TrafficTypeDiagnostic: PH8PR11MB7094:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Sxf98TKW2zhAsIKvTgTksk36vMZFJseFYZIoU258CAk5SA8RY2WNmR9sRfygqf6Nd60mhpMta2V3Es9GoVkegXbUW2tu008q39s9Qghw2DnIXYbz/VM+6wS1zr8s0m353DlNqyDbSqIgrF71nfpDeoBI+VsRYbbMgLoHj9lV6AgPzFJgLr8VkaaChPq6H+TbdlEU9LI10lYj8pM2xJRFbSRMrxkmTvJt1AdZCtbhyPibGEmon7SYwpk/buUhIvC3VIpj5UAhb6IfoX29oe9sGfSi24TS5lUvcgiW1pZNQnh6aQTEOIvnRWW4m9zAg3BcYe7RkE/DvuB2QTZZLoGGlVN6FF7h3DBVS6mG83Kni6R7bxlR88qwA1D5BfEjLLixQTMmP9anSpGhkJXjPM2zbYSgTpYWh7qlxWfYOfGasnz13B9CTe85CwFrEwshQUlXwCJO5xxs77I3qzAgoSC6TRZTNvOPrs7To0KFbFi1TxJKg7A6x+Zft5GwzGNjZ3UAaAMfsJVQS1mBZL6csLfAni78kHcWiWuObBlRRiJE2C8Y5vT0bXIP+veRJibKWYG3vZpho6Lnoexv9thbMzu6utIzrjN56y2cECAb9iO5toA9AH17X2knltgzwyMQ2BkgyUOJpkQu4HT79iUaDMc37PocubeahpfJev/yBw+1vwNN876Pk3Xua56upRe/xaIrvpgWLmoOSZV36VyKzmH+mV5YU1lgD2DihLCG8twKmr8=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6206.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(136003)(346002)(396003)(376002)(39860400002)(366004)(7416002)(5660300002)(8936002)(38100700002)(41300700001)(6486002)(6666004)(478600001)(4326008)(316002)(66556008)(66476007)(66946007)(8676002)(6916009)(53546011)(186003)(9686003)(6512007)(26005)(2906002)(83380400001)(6506007)(33716001)(82960400001)(86362001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?r/fG08gRBQh8oqPGcGocVNmvqFH/V5VR71APXDJlY0BBI8Bm5uLc5dJlrdsw?=
 =?us-ascii?Q?kl5veyapcMpV2Yzv9RVKVDVeoGZa7e2MLxbgB3a2pQ9n7Aa/gpZgEo4OMOlg?=
 =?us-ascii?Q?NmsrdJw1jnnMBI2CchQJduOhOdrU7K0E6RkEgH0i1kHV1gYjR8tLeNEyYa0u?=
 =?us-ascii?Q?/S3uO8hy3+uFfCVonjV000smfeTxNjevBRYt0P6PbBoNuddmdRJN1WB75pUG?=
 =?us-ascii?Q?HCwpSOYEtAf5qpAkzjzosMlnSjN/TgdHuKOUV8sVCbrbXJ/MEdFztQW3rW0i?=
 =?us-ascii?Q?KBuIiphm887Zi9ZmYtBa8Kq6re/X5wHmR4zDw4TUMpE5D2XLz3zwjbEDBzzo?=
 =?us-ascii?Q?l66+qAidbcSGkVFWMRPC2Gd9+ep1YeciWl9aDPwXrIwLipaXm0gIjYFZCwLe?=
 =?us-ascii?Q?WG7OqjP8YTn1AUcebYqAzX92XvHpisj2O8lPF+gTs5CuSV2JWbu1D11/4sWc?=
 =?us-ascii?Q?zhva6kZtH7QTl9ABa3YdxbtMCd7WnYiiuW5AuBmIXRHHWQTAQ7X/8ytAfjpa?=
 =?us-ascii?Q?xZJyAsNANfqO39c1QpA9R+wgtFlvWVDCBWIPdtOAbsJWnQVBO5b5Qu0YXQ/o?=
 =?us-ascii?Q?ilLU+WJmFQZf6rEHHdP/jkpF6V5INCHRQEk4QuSD4OvZdBQkNTjvgBIEIfIf?=
 =?us-ascii?Q?665mVoWHokS07KLPWSEUjBzLLcpAPp/vRT/h/r997rXldx2yTk/IFr+I16Gf?=
 =?us-ascii?Q?Nqz19sVEWcOaPW2bAYCrKdjlgI5oTX+oZ5LnCRheI1YLqQy8iCW3WHE1nRO3?=
 =?us-ascii?Q?+d4EHlmOkRywQhbGBNJAGzmseKErKDLH755nymTpsnfT/gHPqbZ2AgvWWi+r?=
 =?us-ascii?Q?d0GXCK7KycKTF85sm+mj5Xow2LGEb+/opKaqy/1jVEnNeo/TsHYlhWCd0JvM?=
 =?us-ascii?Q?34vxnfBkXjnn78cDPFwXxOtrIGbllUKAvhLFoiTbDFQhukFiQD39BJbXOSIr?=
 =?us-ascii?Q?a7wp4hML4FGKwG1QCN7oqvBDf7dFZRw/IeEBu0uKoTerP1qlzcYTbwdPIQkw?=
 =?us-ascii?Q?Rzsb5RBaGoU362ozSHlCO9XufAV73n6VqSqdT46ryIXV2JwTPXPtcDHRUoxi?=
 =?us-ascii?Q?fiWNNNocWO66QiscL795d8MhD742AYlYKOHDaf9i4/00o04AB5lZVMX5ymsK?=
 =?us-ascii?Q?qt0A4ze3cejl7QA1BCpehbWc6URzOHs17FhbeZbgc933GvoHKK6aGnF7V1h2?=
 =?us-ascii?Q?Xb9vS+7xGK9OzOrZTNhiUvSFaAc5RVqYU/W/soD4h1Jlj0Str3menlniuwHJ?=
 =?us-ascii?Q?FU8+VEhq94SHSSM/d9u7e4J04K9nqdXcoPhy/cHz0ezPLHrNZLp60iJON5Zy?=
 =?us-ascii?Q?z9XXBXDn3XRouJ0xrX+pMukdR0sXJH7SNhW43FaQmwO5Nv5oX5q7ZLzNcCwo?=
 =?us-ascii?Q?gpqKGy74laDMijm58h7imN3H2B0H1ilBMXt0/OuvjO9J+NJtJ/UT1Fy2qDj7?=
 =?us-ascii?Q?+mEmr4o9DHTiqLBFFE6ppiB1kbbrFMCMQLakp2GIKyjMtCjVmHzlqHZ+BdCm?=
 =?us-ascii?Q?D47Cb0oVotB/7L9ok1fUCldTzkANgFvkOvybj8Oix61BZmvjoxIj5R3wi0FI?=
 =?us-ascii?Q?UcsvChVHPG36JKneHdKHOhqspLdSmhoGqKgn+WR3?=
X-MS-Exchange-CrossTenant-Network-Message-Id: de54591b-caf2-4f73-a3d6-08da84b9fc8e
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6206.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Aug 2022 03:45:56.9868
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 07rZ29w+YuozTEa6xSoprjGtKJTuv50ZjI3goUYRhwYwKe5D4iOIKJ7LlT0Is1GvUw5U2BEu0CMBPBRCY6Y3jw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: PH8PR11MB7094
X-OriginatorOrg: intel.com
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-08-22 at 15:36:10 +0800, Yicong Yang wrote:
> From: Barry Song <song.bao.hua@hisilicon.com>
> 
> For platforms having clusters like Kunpeng920, CPUs within the same cluster
> have lower latency when synchronizing and accessing shared resources like
> cache. Thus, this patch tries to find an idle cpu within the cluster of the
> target CPU before scanning the whole LLC to gain lower latency.
> 
> Testing has been done on Kunpeng920 by pinning tasks to one numa and two
> numa. On Kunpeng920, Each numa has 8 clusters and each cluster has 4 CPUs.
> 
> With this patch, We noticed enhancement on tbench within one numa or cross
> two numa.
> 
> On numa 0:
>                              6.0-rc1                patched
> Hmean     1        351.20 (   0.00%)      396.45 *  12.88%*
> Hmean     2        700.43 (   0.00%)      793.76 *  13.32%*
> Hmean     4       1404.42 (   0.00%)     1583.62 *  12.76%*
> Hmean     8       2833.31 (   0.00%)     3147.85 *  11.10%*
> Hmean     16      5501.90 (   0.00%)     6089.89 *  10.69%*
> Hmean     32     10428.59 (   0.00%)    10619.63 *   1.83%*
> Hmean     64      8223.39 (   0.00%)     8306.93 *   1.02%*
> Hmean     128     7042.88 (   0.00%)     7068.03 *   0.36%*
> 
> On numa 0-1:
>                              6.0-rc1                patched
> Hmean     1        363.06 (   0.00%)      397.13 *   9.38%*
> Hmean     2        721.68 (   0.00%)      789.84 *   9.44%*
> Hmean     4       1435.15 (   0.00%)     1566.01 *   9.12%*
> Hmean     8       2776.17 (   0.00%)     3007.05 *   8.32%*
> Hmean     16      5471.71 (   0.00%)     6103.91 *  11.55%*
> Hmean     32     10164.98 (   0.00%)    11531.81 *  13.45%*
> Hmean     64     17143.28 (   0.00%)    20078.68 *  17.12%*
> Hmean     128    14552.70 (   0.00%)    15156.41 *   4.15%*
> Hmean     256    12827.37 (   0.00%)    13326.86 *   3.89%*
> 
> Note neither Kunpeng920 nor x86 Jacobsville supports SMT, so the SMT branch
> in the code has not been tested but it supposed to work.
> 
> Suggested-by: Peter Zijlstra <peterz@infradead.org>
> [https://lore.kernel.org/lkml/Ytfjs+m1kUs0ScSn@worktop.programming.kicks-ass.net]
> Tested-by: Yicong Yang <yangyicong@hisilicon.com>
> Signed-off-by: Barry Song <song.bao.hua@hisilicon.com>
> Signed-off-by: Yicong Yang <yangyicong@hisilicon.com>
> Reviewed-by: Tim Chen <tim.c.chen@linux.intel.com>
> ---
>  kernel/sched/fair.c     | 30 +++++++++++++++++++++++++++---
>  kernel/sched/sched.h    |  2 ++
>  kernel/sched/topology.c | 10 ++++++++++
>  3 files changed, 39 insertions(+), 3 deletions(-)
> 
> diff --git a/kernel/sched/fair.c b/kernel/sched/fair.c
> index 914096c5b1ae..6fa77610d0f5 100644
> --- a/kernel/sched/fair.c
> +++ b/kernel/sched/fair.c
> @@ -6437,6 +6437,30 @@ static int select_idle_cpu(struct task_struct *p, struct sched_domain *sd, bool
>  		}
>  	}
>  
> +	if (static_branch_unlikely(&sched_cluster_active)) {
> +		struct sched_domain *sdc = rcu_dereference(per_cpu(sd_cluster, target));
> +
> +		if (sdc) {
> +			for_each_cpu_wrap(cpu, sched_domain_span(sdc), target + 1) {
Looks good to me. One minor question, why don't we use
cpumask_and(cpus, sched_domain_span(sdc), cpus);
> +				if (!cpumask_test_cpu(cpu, cpus))
> +					continue;
so above check can be removed in each loop? Besides may I know what version this patch
is based on? since I failed to apply the patch on v6.0-rc2. Other than that:

Reviewed-by: Chen Yu <yu.c.chen@intel.com>

thanks,
Chenyu
> +
> +				if (has_idle_core) {
> +					i = select_idle_core(p, cpu, cpus, &idle_cpu);
> +					if ((unsigned int)i < nr_cpumask_bits)
> +						return i;
> +				} else {
> +					if (--nr <= 0)
> +						return -1;
> +					idle_cpu = __select_idle_cpu(cpu, p);
> +					if ((unsigned int)idle_cpu < nr_cpumask_bits)
> +						return idle_cpu;
> +				}
> +			}
> +			cpumask_andnot(cpus, cpus, sched_domain_span(sdc));
> +		}
> +	}
