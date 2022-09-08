Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E14715B1282
	for <lists+linux-kernel@lfdr.de>; Thu,  8 Sep 2022 04:27:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230363AbiIHC1X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 22:27:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49640 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230283AbiIHC0m (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 22:26:42 -0400
Received: from mga05.intel.com (mga05.intel.com [192.55.52.43])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CBDD880526
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 19:26:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1662603983; x=1694139983;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=+t9dwtCJi5+1AacS78+cIz+C3eE4SfQwz+O5LvQ60Ts=;
  b=MqSkYe8YdXdk9HnJm/D1O887VZ8WQfT03HQqeykenjgZXADgmiLlcy+A
   u/mF7EFALjelguNHiBeto/T0UcbqweRu4wlJSOMhDs4d8Fg0s4ETaoO+g
   4cuwV7Z/GgMCVQ4bdgSBHMFKiEI2GWAPfscGfxfyaIPwVbkSWUGDtR5A/
   UBIS3h9Oeu2PO70+uQ5tNS1vZask2DufSh7hZfEfthzOqYfpWUJey5tXW
   TE20LYkIDN3J1H2QYW7Lj0cMpwlyZw0PbHSkoC7W7qgzumGaMrGu8ozs7
   F522jx7hT8Lhzt0p3to4LuLeJ2VF4ILS26EhVkjb8ZAzpA2Ii8GsNbT5J
   A==;
X-IronPort-AV: E=McAfee;i="6500,9779,10463"; a="383339378"
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="383339378"
Received: from fmsmga007.fm.intel.com ([10.253.24.52])
  by fmsmga105.fm.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Sep 2022 19:26:23 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,298,1654585200"; 
   d="scan'208";a="617304496"
Received: from orsmsx602.amr.corp.intel.com ([10.22.229.15])
  by fmsmga007.fm.intel.com with ESMTP; 07 Sep 2022 19:26:22 -0700
Received: from orsmsx608.amr.corp.intel.com (10.22.229.21) by
 ORSMSX602.amr.corp.intel.com (10.22.229.15) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 19:26:21 -0700
Received: from orsmsx603.amr.corp.intel.com (10.22.229.16) by
 ORSMSX608.amr.corp.intel.com (10.22.229.21) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Wed, 7 Sep 2022 19:26:21 -0700
Received: from ORSEDG602.ED.cps.intel.com (10.7.248.7) by
 orsmsx603.amr.corp.intel.com (10.22.229.16) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Wed, 7 Sep 2022 19:26:21 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.45) by
 edgegateway.intel.com (134.134.137.103) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.31; Wed, 7 Sep 2022 19:26:21 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=GreGfphrgv/sTbgUSRXEziC2Y4g50uX+UfZNvSUjX5thhR8ljstFq+NCJ6xzFGZV3PyJHUaLcIvhXkf9nSc1lfPw0g2mKqJz640n2T7JJQomqLIvalU+g0N8WyAvKogWDr8u9X9l5bLF153ll4NSRoHVD/KYJ4xQp//qdMg8EOr454nRDGFjy6bD75XMrl2fsOjzfW23mmFM/glE0pjN3/FBn2ke2yVLao/eRi3XZRgaQxf7O0IQrZCI2aEmpZN7lnOllhOF+h0nbp1ah0PhGIGkU/ahyiGehCrdlftc2tECQJT4fcNGcB9pk20+kU1WRIIpeEjpLgYjewbVIks3iQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=weeHLEhWsr6UzwiZQE9yX3DYY2F40i8CQoalS6wd7eg=;
 b=V5afpqK0bfiyQovmyJnhhYby9NWlTBxSSjZpriaHbswtjAfQSR7xfQs5zqz2Egw2XPxMjWL2EVpEAWQ5nGSI+UL/5X4YfX1ZbvMty8wiXQ7OEMQiQz9bMrnZLjLFC4Z+5vHixZveWOLhhA3oMz7doEEeL7aN15olWLQFSDcdG4KAJxmaPvBa/RwhW1lknuJcbbo6NXrgJf/aevVEs8WxfA+1MEyoE75sk0iDbP1JtMPjkYySmLyMBmIdg5op1zxsWInfvPvb3jsuKhsl6RX8fPn54il86PM/uWMX06mhg5Uwzehzhf0gCFRDvmi1slTJkCRr5zWH346n+Q0T+UizpA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from MN0PR11MB6304.namprd11.prod.outlook.com (2603:10b6:208:3c0::7)
 by BN6PR1101MB2098.namprd11.prod.outlook.com (2603:10b6:405:52::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Thu, 8 Sep
 2022 02:26:18 +0000
Received: from MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e]) by MN0PR11MB6304.namprd11.prod.outlook.com
 ([fe80::4c8f:1e3c:5288:d77e%7]) with mapi id 15.20.5588.015; Thu, 8 Sep 2022
 02:26:18 +0000
Date:   Thu, 8 Sep 2022 10:25:40 +0800
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
        "kasan-dev@googlegroups.com" <kasan-dev@googlegroups.com>,
        Robin Murphy <robin.murphy@arm.com>,
        John Garry <john.garry@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: Re: [PATCH v5 1/4] mm/slub: enable debugging memory wasting of
 kmalloc
Message-ID: <YxlSpK4Jo97g1OB/@feng-clx>
References: <20220907071023.3838692-1-feng.tang@intel.com>
 <20220907071023.3838692-2-feng.tang@intel.com>
 <Yxin8k0BFijbkGK0@hyeyoo>
Content-Type: text/plain; charset="us-ascii"
Content-Disposition: inline
In-Reply-To: <Yxin8k0BFijbkGK0@hyeyoo>
X-ClientProxiedBy: SG2PR06CA0215.apcprd06.prod.outlook.com
 (2603:1096:4:68::23) To MN0PR11MB6304.namprd11.prod.outlook.com
 (2603:10b6:208:3c0::7)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 651d7945-719a-47a2-8cb3-08da91418308
X-MS-TrafficTypeDiagnostic: BN6PR1101MB2098:EE_
X-LD-Processed: 46c98d88-e344-4ed4-8496-4ed7712e255d,ExtAddr
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Je9L6/XS+ecEoi0pneVgs1pZDJ3KFTVU61ph7c3QO0U05C/K9y+SYRf9EZihxnPm01dbuYqjG92W68EnfWyYVB/LkYNzGTb7EqUjEuSw8mjCKMA2AdwddHXgmgVp4KJ+mex2F9UspJ9Ffb30FXQEZDD0zU1NHDGRJ9Z08E7OmOZ+4As6/5uBffvL1u77vK1aKNtXtrFoGTw+2mN+HsUKh8SCW3f0SFwVwS2XjJ+zw+CwaJlQdUCF/0hobhy4vPl9otxxILDRIbXFCeusWW+ILTbJh6yX6ILBJvwYqRsS2yd3mdOjG7/1TZcSfICWYBw+uwGanQRP3jBlngR3zotXuVs5o6uO3Zm3wKOb1Bm/gwQQHkYrJbJbQTkE7wD+RvUKZFwO/Q2gY15zhJ0Xql6lWGNvHOREQGOkblCpTztu8/jC/YGHGQsN98OmiAxq1RtBLsKWEojQrw9+CRX2KvCvFTqrMuoupuHaW9Kfl/7xPU2CViK34jC9jT1S63j63koLAq3IA/YPZ4pUaYZ8s+n4R9PwwkIuelyuVjpL2HAsBAjHahwgC3RxtD5b89RuByOfs5GYFSkEMWTtAYV94rkskX29uQsoU/n0XkximWr/kUSTaEsGPSaGrowGOLImAvuprkNIB5rSJYa+AwjRrbmpdPo4rfLVvCUXqW5BxfJiq13D2zrbWBZ/Z0ShgQi9PTnmndiSWMNrROgqKl6tbmCh2YaVBLTbJtqCc7J0cce3qvzFoMJcl01Nxrc7xE0jZtkXZSiBVSip18R34DOD/Ig69g==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN0PR11MB6304.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(7916004)(376002)(136003)(366004)(346002)(396003)(39860400002)(86362001)(2906002)(6506007)(9686003)(6666004)(26005)(6512007)(44832011)(4326008)(8676002)(8936002)(66556008)(33716001)(66476007)(66946007)(7416002)(5660300002)(41300700001)(82960400001)(6916009)(54906003)(38100700002)(83380400001)(966005)(316002)(478600001)(6486002)(186003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?C+2CcWo/0lvAABD7TZ3BAmLmylL3/DkMcK60quFWXCvfPP9StjGKkl3CmafU?=
 =?us-ascii?Q?oEjNQdcL9GOJPXOl+WEe4TtRGmYWmUMeHzTHQ4aYU99RbzMM8gfAgsG+NDTT?=
 =?us-ascii?Q?1BNQUinyq7hse0E+bFRUqaseG0N39d2ThCH28Rr2bzfvWdooSIVcNrvIsjO5?=
 =?us-ascii?Q?SI9S7Pl01km7hL/4JD9i+qYkefd9JWdR+EmZhNHvQrKF+/Img7/cqd+EgcdM?=
 =?us-ascii?Q?/TA8M+4IAul8UCNmaKZxuOdXvabbEbO3+9vQCgAI4IBtACzksq1f9F1Qmmhp?=
 =?us-ascii?Q?2EgSYjySo11h34UwePfvNyfEElMdHvI7EcomkIc9+GAv0b88aGj0clvPIctN?=
 =?us-ascii?Q?LavbevK68aeseZij81pi7bH71ggF0QNEKfn/w5/TV4ptNaISzt6ztAtPlHtY?=
 =?us-ascii?Q?8rPV2XQpb1GKyN0+AI/S37YizuHGiUIY1CcF3tB9b+RqB7GjEehxkg8Piub5?=
 =?us-ascii?Q?f0sekP1Z3v25A9ONyN8SxdOOcKwNSZPBU70ouHwAkCvosu11HYT6cdCbsr2f?=
 =?us-ascii?Q?ZwIeXAzFWeToHb5QTEBaeQaEDdPAvCkWzzCt1Aa1whHLkCTlLgIO0mut7kvq?=
 =?us-ascii?Q?ep60VARV/C6VdF6Z13NHMQkDVgvXTOosUK8jdGpKw11kPahHDvizqU95efzV?=
 =?us-ascii?Q?ph2tcWMEEFQeHiUfKP8QSYBhW4mdZXXXMDx7q7jZa92N9IfJiO7SIROJjODn?=
 =?us-ascii?Q?jJgAkxRzNQIeEgJER5ci/FaJZMVIkc/kzkF2JfI3q8pSs/tCOdmqz2lpGe6K?=
 =?us-ascii?Q?aylcrPqi9V90RiLMwr9VLFz1BRuHtOmZY4IGpDVO7i6PGlubmKGQRc2VOEuf?=
 =?us-ascii?Q?Bcs4iCvA+IY89suQu1Pd9jKyvH2x8VlferG/jbDelVbu0LOoEqw1nabaKozn?=
 =?us-ascii?Q?TvKrumQkmEXZs4w3Z/r8mTkqap0jQsuaFsp9Vd+3C4LeO9EKZKIxgLayTRoq?=
 =?us-ascii?Q?hjNFGK1H96m9fxi177cjO6PbgCpfEop+NoxZP7pUY5EtoWrC9oIOENw2N5cL?=
 =?us-ascii?Q?WH6/v8tmS0nSqC7QTwVm3p8A1wjoAqpiLlhw4hmn8bAc1fw7DHIVWF5R/K8D?=
 =?us-ascii?Q?WFHJlkEzarrMPfThD5bA6uMYr6qtL6B+YHU16esoQ5UCPaHsiQO/npRkjyWf?=
 =?us-ascii?Q?hbDI3xsyU7ZEtyODCZ4Mws+q1B5D7XydL+sA3tuA9a3Xl14p2bh6N8SpH1Td?=
 =?us-ascii?Q?PSCWiVv+a9vACXpgwgNVvHoZq8CzqkPQRLQhzWtp3fwR3M3w3ucrL015RgoE?=
 =?us-ascii?Q?eBtt7xMKKC4MwWWVg842I+U+vxwAEuMx5hQiNMUXS+pnaLj/5Xf12u9de3P8?=
 =?us-ascii?Q?Jl73ldzwRn0zh4CWt+eym2fD1Z+U/6PWLSIBTOkopF6u1XaGqReyEG1gxmRq?=
 =?us-ascii?Q?lO7w5bzhi+Eq1SwkWsPVvzc5LAjRbQhUNt1enCgcYCjiNrnpW1+gCE7JUEaE?=
 =?us-ascii?Q?tysX7P8Qc+Kta57PB6QUccew8R7L65PakZgHNqReFkCQ8DPOF5YRMtfbDzmY?=
 =?us-ascii?Q?8rJRPGQwo4Xdn/Lh52m/3qG6zgbtNAqJcGEtsqFyH3B4kfSeri5UCJvP1mVf?=
 =?us-ascii?Q?IVcK9YD3Yi7DnlSzIayoc2/AAXTxzGIhb3efa0Ux?=
X-MS-Exchange-CrossTenant-Network-Message-Id: 651d7945-719a-47a2-8cb3-08da91418308
X-MS-Exchange-CrossTenant-AuthSource: MN0PR11MB6304.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Sep 2022 02:26:18.4873
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: Xg6P0fk5DdUoVB1ddMNO1O0w81jGvSv3WZt/kt9HsaX4E4bTQ5/LKB7il08serrfPG87+EYCQTuRaYB2yAOiTA==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BN6PR1101MB2098
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

On Wed, Sep 07, 2022 at 10:17:22PM +0800, Hyeonggon Yoo wrote:
> On Wed, Sep 07, 2022 at 03:10:20PM +0800, Feng Tang wrote:
> > kmalloc's API family is critical for mm, with one nature that it will
> > round up the request size to a fixed one (mostly power of 2). Say
> > when user requests memory for '2^n + 1' bytes, actually 2^(n+1) bytes
> > could be allocated, so in worst case, there is around 50% memory
> > space waste.
> > 
> > The wastage is not a big issue for requests that get allocated/freed
> > quickly, but may cause problems with objects that have longer life
> > time.
> > 
> > We've met a kernel boot OOM panic (v5.10), and from the dumped slab
> > info:
> > 
> >     [   26.062145] kmalloc-2k            814056KB     814056KB
> > 
> > >From debug we found there are huge number of 'struct iova_magazine',
> > whose size is 1032 bytes (1024 + 8), so each allocation will waste
> > 1016 bytes. Though the issue was solved by giving the right (bigger)
> > size of RAM, it is still nice to optimize the size (either use a
> > kmalloc friendly size or create a dedicated slab for it).
> > 
> > And from lkml archive, there was another crash kernel OOM case [1]
> > back in 2019, which seems to be related with the similar slab waste
> > situation, as the log is similar:
> > 
> >     [    4.332648] iommu: Adding device 0000:20:02.0 to group 16
> >     [    4.338946] swapper/0 invoked oom-killer: gfp_mask=0x6040c0(GFP_KERNEL|__GFP_COMP), nodemask=(null), order=0, oom_score_adj=0
> >     ...
> >     [    4.857565] kmalloc-2048           59164KB      59164KB
> > 
> > The crash kernel only has 256M memory, and 59M is pretty big here.
> > (Note: the related code has been changed and optimised in recent
> > kernel [2], these logs are just picked to demo the problem, also
> > a patch changing its size to 1024 bytes has been merged)
> > 
> > So add an way to track each kmalloc's memory waste info, and
> > leverage the existing SLUB debug framework (specifically
> > SLUB_STORE_USER) to show its call stack of original allocation,
> > so that user can evaluate the waste situation, identify some hot
> > spots and optimize accordingly, for a better utilization of memory.
> > 
> > The waste info is integrated into existing interface:
> > '/sys/kernel/debug/slab/kmalloc-xx/alloc_traces', one example of
> > 'kmalloc-4k' after boot is:
> > 
> >  126 ixgbe_alloc_q_vector+0xbe/0x830 [ixgbe] waste=233856/1856 age=280763/281414/282065 pid=1330 cpus=32 nodes=1
> >      __kmem_cache_alloc_node+0x11f/0x4e0
> >      __kmalloc_node+0x4e/0x140
> >      ixgbe_alloc_q_vector+0xbe/0x830 [ixgbe]
> >      ixgbe_init_interrupt_scheme+0x2ae/0xc90 [ixgbe]
> >      ixgbe_probe+0x165f/0x1d20 [ixgbe]
> >      local_pci_probe+0x78/0xc0
> >      work_for_cpu_fn+0x26/0x40
> >      ...
> > 
> > which means in 'kmalloc-4k' slab, there are 126 requests of
> > 2240 bytes which got a 4KB space (wasting 1856 bytes each
> > and 233856 bytes in total), from ixgbe_alloc_q_vector().
> > 
> > And when system starts some real workload like multiple docker
> > instances, there could are more severe waste.
> > 
> > [1]. https://lkml.org/lkml/2019/8/12/266
> > [2]. https://lore.kernel.org/lkml/2920df89-9975-5785-f79b-257d3052dfaf@huawei.com/
> > 
> > [Thanks Hyeonggon for pointing out several bugs about sorting/format]
> > [Thanks Vlastimil for suggesting way to reduce memory usage of
> >  orig_size and keep it only for kmalloc objects]
> > 
> > Signed-off-by: Feng Tang <feng.tang@intel.com>
> > Cc: Robin Murphy <robin.murphy@arm.com>
> > Cc: John Garry <john.garry@huawei.com>
> > Cc: Kefeng Wang <wangkefeng.wang@huawei.com>
> > ---
> >  Documentation/mm/slub.rst |  33 +++++---
> >  include/linux/slab.h      |   2 +
> >  mm/slub.c                 | 156 ++++++++++++++++++++++++++++----------
> >  3 files changed, 141 insertions(+), 50 deletions(-)
> > 
> 
> Looks good to me.
> Reviewed-by: Hyeonggon Yoo <42.hyeyoo@gmail.com>
 
Thank you!

> > diff --git a/Documentation/mm/slub.rst b/Documentation/mm/slub.rst
> 
> [...]
> 
> > +/* Structure holding parameters for get_partial() call chain */
> > +struct partial_context {
> > +	struct slab **slab;
> > +	gfp_t flags;
> > +	int orig_size;
> 
> Nit: unsigned int orig_size
 
Yes, will change. 'unsigned int' is more consistent with the orig_size saved
in meta data and others members size/object_size/inuse/offset of kmem_cache.

Thanks,
Feng

> Thanks!
> 
