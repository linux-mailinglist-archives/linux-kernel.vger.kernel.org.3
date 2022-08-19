Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B455A59A623
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 21:17:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350720AbiHSTHj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 15:07:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350705AbiHSTHg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 15:07:36 -0400
Received: from mga02.intel.com (mga02.intel.com [134.134.136.20])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E44210A74C
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 12:07:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple;
  d=intel.com; i=@intel.com; q=dns/txt; s=Intel;
  t=1660936051; x=1692472051;
  h=date:from:to:cc:subject:message-id:references:
   in-reply-to:mime-version;
  bh=3GsQRz3fDV6MKOyAc61nm9btRxh+MGkAqIuFwASsT1U=;
  b=ZJNbDtWXT4fvn+GBniQ87rRAD2jfXEC9CpsKXbxa1qq1b/EfgwQ/TtE9
   Rqn0iCOtO9+2vJE15Q44Yjn2uCHfWwIrbxKPfdFRfsMSlZU0SDfMGA8qY
   AB1fCIG6hlSgvH6Cu+vFuaByfmg97HZMNKgNvDJsLinwI7jKleXvXBTy+
   5WGKypqxZHwWYISNuCLl4R+EoV3uXZyboetRb1nswaeQTFIZYD0NC52r+
   vzepnCCPBTkzGiCSg+30tVAoZKz0RfVXIrJnEdsH09G7m5P5+XlyG0M/q
   By01jyW1OxzI0vEXagpE8Yi4itGEOANoyP/F+77b94zlJBjtGrEmcyWR5
   g==;
X-IronPort-AV: E=McAfee;i="6500,9779,10444"; a="280041435"
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="280041435"
Received: from orsmga001.jf.intel.com ([10.7.209.18])
  by orsmga101.jf.intel.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 19 Aug 2022 12:07:31 -0700
X-ExtLoop1: 1
X-IronPort-AV: E=Sophos;i="5.93,248,1654585200"; 
   d="scan'208";a="641356859"
Received: from fmsmsx601.amr.corp.intel.com ([10.18.126.81])
  by orsmga001.jf.intel.com with ESMTP; 19 Aug 2022 12:07:30 -0700
Received: from fmsmsx609.amr.corp.intel.com (10.18.126.89) by
 fmsmsx601.amr.corp.intel.com (10.18.126.81) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31; Fri, 19 Aug 2022 12:07:30 -0700
Received: from FMSEDG603.ED.cps.intel.com (10.1.192.133) by
 fmsmsx609.amr.corp.intel.com (10.18.126.89) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.31 via Frontend Transport; Fri, 19 Aug 2022 12:07:30 -0700
Received: from NAM12-MW2-obe.outbound.protection.outlook.com (104.47.66.43) by
 edgegateway.intel.com (192.55.55.68) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.1.2375.28; Fri, 19 Aug 2022 12:07:30 -0700
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=n1KenoSwDrQRRu9VLg/PUWaqO5GYd7vVelhrYbb6Q/9viHQV1aUUrUGtfEcnkADuI5I8WB88V7UKpQHurIejNCCS7w/ahW9Tm3uMWExUm9rrA/I63EPKASXKaZD2JMUgTkpNtaTG41wllRzj76aEqCaUdeK2j9lPBi8T8oKzZRQfuPpik2GYRNVRKf0PLJR3Y4+p6N1BTsfbbh7ns88jx6ZQ9YAeyQ7g79CriXvOBmySTWrxNmjvmhZIWF3mVVkiGel2Am1r/lwruspyYejnSLVmyETzT4wsI0yUtGSzpImI81htmS5/cjJTzNwQr5slAri8vag0vGNXgnXNuQbTPQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=WLC/Fj9I4ptQAr8BFo7u0eJ66hdCg2uEl9/D5/lEDwQ=;
 b=RZ0pEJRE9JxGeka2TjCzLtTsb6H/Bx4inUMqpCKelF8jBq2f2EXP0DRpiIXcTOsWdR6VcpsVnpguUSfXsyO7e36tuz/jAJtyReV/z0bp/ama/J3x3Xn24N/cfi8dQRK+Fti+duBh5N3ttCBvrJVCWihD40cYfY2H8JQ5HontxbhOoH+ooho75ag+xk3feK1r6sLS0jxwkkmnoLOMnfPjRo9qSUCf7cRkmbfHjfY1BAp1yhb84iSVOmjB4ZJdKKJnGb24CN1ZFz1lzFukrMNOd0DTRDI1n7x9ga+xYBbyNPkmLlXfMQfuKd3UWeFUQNg7WsnqS3dfOCH2PIb0aRF/tg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=intel.com; dmarc=pass action=none header.from=intel.com;
 dkim=pass header.d=intel.com; arc=none
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=intel.com;
Received: from CY5PR11MB6139.namprd11.prod.outlook.com (2603:10b6:930:29::17)
 by CY4PR11MB1943.namprd11.prod.outlook.com (2603:10b6:903:123::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5546.16; Fri, 19 Aug
 2022 19:07:28 +0000
Received: from CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513]) by CY5PR11MB6139.namprd11.prod.outlook.com
 ([fe80::a012:82da:5edb:513%7]) with mapi id 15.20.5525.011; Fri, 19 Aug 2022
 19:07:28 +0000
Date:   Fri, 19 Aug 2022 12:07:26 -0700
From:   Lucas De Marchi <lucas.demarchi@intel.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
CC:     <iommu@lists.linux.dev>, Joerg Roedel <joro@8bytes.org>,
        Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Kevin Tian <kevin.tian@intel.com>, <yi.l.liu@intel.com>,
        <linux-kernel@vger.kernel.org>, <matthew.auld@intel.com>,
        Anusha Srivatsa <anusha.srivatsa@intel.com>
Subject: Re: [PATCH 1/1] iommu/vt-d: Fix possible recursive lock in
 iommu_flush_dev_iotlb()
Message-ID: <20220819190154.xbb5inovlyi2nmez@ldmartin-desk2.lan>
References: <20220817025650.3253959-1-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset="us-ascii"; format=flowed
Content-Disposition: inline
In-Reply-To: <20220817025650.3253959-1-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW4P223CA0023.NAMP223.PROD.OUTLOOK.COM
 (2603:10b6:303:80::28) To CY5PR11MB6139.namprd11.prod.outlook.com
 (2603:10b6:930:29::17)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ebb1b63a-1c6d-4828-ca02-08da82160f20
X-MS-TrafficTypeDiagnostic: CY4PR11MB1943:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: u9rOzKgD0jMl1yT04AxNhViZb7VC7bAwnFQ/adhqGqgG4BvIQ44yxWp347hWaF2ZHCOKaXw+B4FjfZBpAnxKFdXOgZcYeIUrAefaA46vTgUuSfBjVGgngZfQqcgICz6uZI7jFCYqCdgf3qoujqomi5fTFE9xVIGZflf5IFbBOFKxb8+1kqA6tlClvj6CdMIaQ2fx7tzL1K0WqmCyhlYlRyx9vBju2vHqU2qlqfwNVg7+5je0ND+Xa+YDdp9FRvsaAF6xvlybr31lXbC3FzS5tZrtDQfHn5QLj2NQemtaKhqbVPOepmseBhmIg8jdqBdlz4WAv3G5I32alXNvVxL8eO2mqFNRSNaBVP9a4wNL7HSQtFBk3mOdam5FtrsKtj0a+NjP2qNnNq+MKaPQNQzOuf8F2AVuCtCM73ceYSpy1Up+gcOoGZbE/PldEc+Z1rnxGy0O7wV7rm6tv3Cx+bJLextvmQ7ASujqGCntfpjrx4Tbx5ptJM0nQgdWCzQ3J6uCQScWAdzI+q5ZLElcQIe6/e26NTEcHJmiaZHlyLi8Iv+A3QYVeBWtJCC+WdQ8u7zo8qWzxPRG4PkCFdl+H1TJLarILutc/t80MYiK99A6S9ndQ0wPiwJaDJmghDhUFzt4nEnTBhshn9Dg5zUEx/aVizIM3dns2cYMH6HpYyDKd+/9aSB+m3+XahskCZHpJKSaJlypaaAv9AqcrEojlvDasg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CY5PR11MB6139.namprd11.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(376002)(39860400002)(396003)(366004)(136003)(346002)(6486002)(6506007)(2906002)(66556008)(4326008)(66946007)(8676002)(66476007)(8936002)(5660300002)(9686003)(478600001)(82960400001)(41300700001)(86362001)(26005)(6512007)(316002)(36756003)(186003)(54906003)(1076003)(6916009)(38100700002)(83380400001);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?B98UsvpNF7aX5hRiyFGPNbpriIoZDT1d8jNkayHuxYKRsn/Jr0oyjEbxo8EQ?=
 =?us-ascii?Q?AlamykzVFA+oTFNcTZ8XYXTz4HV+8Nx5RUY6w9kedycA/PBDsEEtwgK0+2V1?=
 =?us-ascii?Q?yHPyWSGYcUVp8xSMB6K92Nv5vlEs3qowGNhV+Dx40XPtDC+WyQQPqQbEquCC?=
 =?us-ascii?Q?KfZBQoEzXIU+qDfTWCmXVkdRsEAGOPOX6UlHYA6cwpKg3EDL0FTHa53PtPwc?=
 =?us-ascii?Q?OXNajoVwzfV1iWX2c675uGE9HYCMGuJV/LxFVVvSCWL8qxSfxj/IugIYWWdr?=
 =?us-ascii?Q?yjr3OWWVbEIMbdD2yXJtlPZ2bJkDCiUmFtLA3F+w8MgxU5Sf0j5EHD3tNQTP?=
 =?us-ascii?Q?mEnxw7ISKHK0cM0cIXiAKeDvfSuD5dd/q0Wm9CZyM7eJzd8BUs9UF51D7Egf?=
 =?us-ascii?Q?6haYcmqdOwANxzM+fqd31DT8/q3EUj4EA2II7REUV7rywjN9XnO1Zw5cl73K?=
 =?us-ascii?Q?LEnArdZ/jaP/y+I6z0kwSjI1guKT0n8Bej5mwLMw6Zvxq9YwNOVnB/JTclb6?=
 =?us-ascii?Q?Fq4EZrajAxfejvPn0RFLlYwIQw8PZ57Okslahvg9OqgesQEIZtso68erAcJo?=
 =?us-ascii?Q?P4U/zoM/WgP32t5721cQMz52tsQ0lA87kL2UJrqsG72sMz6mV9cQB3YMMeAu?=
 =?us-ascii?Q?u0DZS7htZ8rhV54g6qxnfJWiZAuFlg6LSQRhj7ZjKDhGJxG/VZ6m1D4tXjkf?=
 =?us-ascii?Q?0vZtC8w1NS2ysOOA96f8zzuOJm4DCxW5KPHujmJq8JOn913L8eiegZ8Dn7Gj?=
 =?us-ascii?Q?swxLHiOAJK17XOyj6qJoZpnLpSNCOW/tGvNgaekyFJOM8DBU9j6+v2AjsQWg?=
 =?us-ascii?Q?xtkyzH0E8uFmQuDOM/i5wY1hLOVDtf46TWkz38tkvxauuk9aqpD2tT3U58kt?=
 =?us-ascii?Q?OXxyBynF1cnxvIi3w5ciNJ6TK13gV5Wti8MfYi+7LYLPy3IzyaP5Ou9m+64M?=
 =?us-ascii?Q?qiB4tsHzQaj+3JqY83uPft5GUYvEtrJyXYwLZ6e7SHtdPcWy4DXgV479FmQT?=
 =?us-ascii?Q?3Dp4JEYt7fXLGwTDDP2eE89Z/RkiSqbwrQhoK6rEgVxlIUHfD0ozmAyZycbW?=
 =?us-ascii?Q?1doUDhSp5jWM0AOb333oPQA8JmqDzsUvxlq1H8w6N2YgckKyYUBLp4+IIQbv?=
 =?us-ascii?Q?r38It1hyvgU6fABTIzfT0HE+N0u9yTThp6kxMOeEcHLixToXDUfFbdkNylVu?=
 =?us-ascii?Q?X4tNK5oUlhY01Bixjvl6NSoUv3CTR+HKcKMxmN8Zin+2VHSw8YBycmzJvpcr?=
 =?us-ascii?Q?gdCyLR2wtdxs5jAs5CiW+WAZkuJ0hgeJIFg08oaYmSsuMvvy9fsTTZ2Lmdbc?=
 =?us-ascii?Q?1JQgCSLDOvtG+mcDEJUhv9OPUwRB2nRTpqcLVJcE09T2JVRBZBuKpMd8G5Mk?=
 =?us-ascii?Q?pZMaAg0jnCFaKdromKPGr/d2DatMpnJBUzAshPnlidBgHjO8huULzfiT+RLG?=
 =?us-ascii?Q?0QtWy8WftKqbqJNeHudOWFK8y/VNiOcjIQVXkn4W0gYjHqbWQXUowG1Z2YTz?=
 =?us-ascii?Q?mM3Fxfpg7m+TiJT8IN1/6Fe87wbESN7dIY/VhX9y2NGQx5HeydbvDduB1pAt?=
 =?us-ascii?Q?SrKXE0WMt3yxTkJkJISlLyz9d5fjR/La1RdRxr3j1Vj9X1ESOwOoTk4Dng+C?=
 =?us-ascii?Q?Zw=3D=3D?=
X-MS-Exchange-CrossTenant-Network-Message-Id: ebb1b63a-1c6d-4828-ca02-08da82160f20
X-MS-Exchange-CrossTenant-AuthSource: CY5PR11MB6139.namprd11.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Aug 2022 19:07:28.3856
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 46c98d88-e344-4ed4-8496-4ed7712e255d
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: kClZSkwc22xs0l2tp1gJvGFvD9RWlqhKvFg/DnZp568q1JkzLAjCccJ77Jd12yOmp6LKioH101HN2DIej5VUGkDQ9N7/id3y2MhHgT9ICnE=
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR11MB1943
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

On Wed, Aug 17, 2022 at 10:56:50AM +0800, Lu Baolu wrote:
>The per domain spinlock is acquired in iommu_flush_dev_iotlb(), which
>is possbile to be called in the interrupt context. For instance,
>
>  <IRQ>
>  iommu_flush_dev_iotlb
>  iommu_flush_iotlb_psi
>  intel_iommu_tlb_sync
>  iommu_iotlb_sync
>  __iommu_dma_unmap
>  ? nvme_unmap_data
>  nvme_unmap_data
>  nvme_pci_complete_rq
>  nvme_irq
>  __handle_irq_event_percpu
>  handle_irq_event_percpu
>  handle_irq_event
>  handle_edge_irq
>  __common_interrupt
>  common_interrupt
>
>This coverts the spin_lock/unlock() into the irq save/restore varieties
>to avoid the possible recursive locking issues.
>
>Fixes: ffd5869d93530 ("iommu/vt-d: Replace spin_lock_irqsave() with spin_lock()")
>Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>

drm-intel's CI system got completely blocked after the backmerge of
6.0-rc1 with this error:

<4> [15.072336] ================================
<4> [15.072337] WARNING: inconsistent lock state
<4> [15.072339] 6.0.0-rc1-CI_DRM_11990-g6590d43d39b9+ #1 Not tainted
<4> [15.072342] --------------------------------
<4> [15.072344] inconsistent {SOFTIRQ-ON-W} -> {IN-SOFTIRQ-W} usage.
<4> [15.072346] swapper/6/0 [HC0[0]:SC1[1]:HE1:SE0] takes:
<4> [15.072349] ffff88810440d678 (&domain->lock){+.?.}-{2:2}, at: iommu_flush_dev_iotlb.part.61+0x23/0x80
<4> [15.072356] {SOFTIRQ-ON-W} state was registered at:
<4> [15.072359]   lock_acquire+0xd3/0x310
<4> [15.072361]   _raw_spin_lock+0x2a/0x40
<4> [15.072364]   domain_update_iommu_cap+0x20b/0x2c0
<4> [15.072366]   intel_iommu_attach_device+0x5bd/0x860
<4> [15.072369]   __iommu_attach_device+0x18/0xe0
<4> [15.072372]   bus_iommu_probe+0x1f3/0x2d0
<4> [15.072374]   bus_set_iommu+0x82/0xd0
<4> [15.072377]   intel_iommu_init+0xe45/0x102a
<4> [15.072381]   pci_iommu_init+0x9/0x31
<4> [15.072384]   do_one_initcall+0x53/0x2f0
<4> [15.072387]   kernel_init_freeable+0x18f/0x1e1
<4> [15.072389]   kernel_init+0x11/0x120
<4> [15.072392]   ret_from_fork+0x1f/0x30
<4> [15.072394] irq event stamp: 162354
<4> [15.072396] hardirqs last  enabled at (162354): [<ffffffff81b59274>] _raw_spin_unlock_irqrestore+0x54/0x70
<4> [15.072400] hardirqs last disabled at (162353): [<ffffffff81b5901b>] _raw_spin_lock_irqsave+0x4b/0x50
<4> [15.072404] softirqs last  enabled at (162338): [<ffffffff81e00323>] __do_softirq+0x323/0x48e
<4> [15.072408] softirqs last disabled at (162349): [<ffffffff810c1588>] irq_exit_rcu+0xb8/0xe0
<4> [15.072412] 
other info that might help us debug this:
<4> [15.072414]  Possible unsafe locking scenario:
<4> [15.072416]        CPU0
<4> [15.072417]        ----
<4> [15.072418]   lock(&domain->lock);
<4> [15.072420]   <Interrupt>
<4> [15.072422]     lock(&domain->lock);
<4> [15.072423] 
  *** DEADLOCK ***
<4> [15.072426] 1 lock held by swapper/6/0:
<4> [15.072427]  #0: ffffc900002b8ea8 ((&cookie->fq_timer)){+.-.}-{0:0}, at: call_timer_fn+0x0/0x2c0
<4> [15.072433] 


After locally applying this patch the error is gone and machines are
back to life.

Acked-by: Lucas De Marchi <lucas.demarchi@intel.com>

thanks
Lucas De Marchi

>---
> drivers/iommu/intel/iommu.c | 39 ++++++++++++++++++++++---------------
> 1 file changed, 23 insertions(+), 16 deletions(-)
>
>diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
>index 2d0d2ef820d2..8d4f6f0b6c1c 100644
>--- a/drivers/iommu/intel/iommu.c
>+++ b/drivers/iommu/intel/iommu.c
>@@ -495,8 +495,9 @@ static int domain_update_device_node(struct dmar_domain *domain)
> {
> 	struct device_domain_info *info;
> 	int nid = NUMA_NO_NODE;
>+	unsigned long flags;
>
>-	spin_lock(&domain->lock);
>+	spin_lock_irqsave(&domain->lock, flags);
> 	list_for_each_entry(info, &domain->devices, link) {
> 		/*
> 		 * There could possibly be multiple device numa nodes as devices
>@@ -508,7 +509,7 @@ static int domain_update_device_node(struct dmar_domain *domain)
> 		if (nid != NUMA_NO_NODE)
> 			break;
> 	}
>-	spin_unlock(&domain->lock);
>+	spin_unlock_irqrestore(&domain->lock, flags);
>
> 	return nid;
> }
>@@ -1336,19 +1337,20 @@ iommu_support_dev_iotlb(struct dmar_domain *domain, struct intel_iommu *iommu,
> 			u8 bus, u8 devfn)
> {
> 	struct device_domain_info *info;
>+	unsigned long flags;
>
> 	if (!iommu->qi)
> 		return NULL;
>
>-	spin_lock(&domain->lock);
>+	spin_lock_irqsave(&domain->lock, flags);
> 	list_for_each_entry(info, &domain->devices, link) {
> 		if (info->iommu == iommu && info->bus == bus &&
> 		    info->devfn == devfn) {
>-			spin_unlock(&domain->lock);
>+			spin_unlock_irqrestore(&domain->lock, flags);
> 			return info->ats_supported ? info : NULL;
> 		}
> 	}
>-	spin_unlock(&domain->lock);
>+	spin_unlock_irqrestore(&domain->lock, flags);
>
> 	return NULL;
> }
>@@ -1357,8 +1359,9 @@ static void domain_update_iotlb(struct dmar_domain *domain)
> {
> 	struct device_domain_info *info;
> 	bool has_iotlb_device = false;
>+	unsigned long flags;
>
>-	spin_lock(&domain->lock);
>+	spin_lock_irqsave(&domain->lock, flags);
> 	list_for_each_entry(info, &domain->devices, link) {
> 		if (info->ats_enabled) {
> 			has_iotlb_device = true;
>@@ -1366,7 +1369,7 @@ static void domain_update_iotlb(struct dmar_domain *domain)
> 		}
> 	}
> 	domain->has_iotlb_device = has_iotlb_device;
>-	spin_unlock(&domain->lock);
>+	spin_unlock_irqrestore(&domain->lock, flags);
> }
>
> static void iommu_enable_dev_iotlb(struct device_domain_info *info)
>@@ -1458,14 +1461,15 @@ static void iommu_flush_dev_iotlb(struct dmar_domain *domain,
> 				  u64 addr, unsigned mask)
> {
> 	struct device_domain_info *info;
>+	unsigned long flags;
>
> 	if (!domain->has_iotlb_device)
> 		return;
>
>-	spin_lock(&domain->lock);
>+	spin_lock_irqsave(&domain->lock, flags);
> 	list_for_each_entry(info, &domain->devices, link)
> 		__iommu_flush_dev_iotlb(info, addr, mask);
>-	spin_unlock(&domain->lock);
>+	spin_unlock_irqrestore(&domain->lock, flags);
> }
>
> static void iommu_flush_iotlb_psi(struct intel_iommu *iommu,
>@@ -2427,6 +2431,7 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
> {
> 	struct device_domain_info *info = dev_iommu_priv_get(dev);
> 	struct intel_iommu *iommu;
>+	unsigned long flags;
> 	u8 bus, devfn;
> 	int ret;
>
>@@ -2438,9 +2443,9 @@ static int domain_add_dev_info(struct dmar_domain *domain, struct device *dev)
> 	if (ret)
> 		return ret;
> 	info->domain = domain;
>-	spin_lock(&domain->lock);
>+	spin_lock_irqsave(&domain->lock, flags);
> 	list_add(&info->link, &domain->devices);
>-	spin_unlock(&domain->lock);
>+	spin_unlock_irqrestore(&domain->lock, flags);
>
> 	/* PASID table is mandatory for a PCI device in scalable mode. */
> 	if (sm_supported(iommu) && !dev_is_real_dma_subdevice(dev)) {
>@@ -4064,6 +4069,7 @@ static void dmar_remove_one_dev_info(struct device *dev)
> 	struct device_domain_info *info = dev_iommu_priv_get(dev);
> 	struct dmar_domain *domain = info->domain;
> 	struct intel_iommu *iommu = info->iommu;
>+	unsigned long flags;
>
> 	if (!dev_is_real_dma_subdevice(info->dev)) {
> 		if (dev_is_pci(info->dev) && sm_supported(iommu))
>@@ -4075,9 +4081,9 @@ static void dmar_remove_one_dev_info(struct device *dev)
> 		intel_pasid_free_table(info->dev);
> 	}
>
>-	spin_lock(&domain->lock);
>+	spin_lock_irqsave(&domain->lock, flags);
> 	list_del(&info->link);
>-	spin_unlock(&domain->lock);
>+	spin_unlock_irqrestore(&domain->lock, flags);
>
> 	domain_detach_iommu(domain, iommu);
> 	info->domain = NULL;
>@@ -4396,19 +4402,20 @@ static void domain_set_force_snooping(struct dmar_domain *domain)
> static bool intel_iommu_enforce_cache_coherency(struct iommu_domain *domain)
> {
> 	struct dmar_domain *dmar_domain = to_dmar_domain(domain);
>+	unsigned long flags;
>
> 	if (dmar_domain->force_snooping)
> 		return true;
>
>-	spin_lock(&dmar_domain->lock);
>+	spin_lock_irqsave(&dmar_domain->lock, flags);
> 	if (!domain_support_force_snooping(dmar_domain)) {
>-		spin_unlock(&dmar_domain->lock);
>+		spin_unlock_irqrestore(&dmar_domain->lock, flags);
> 		return false;
> 	}
>
> 	domain_set_force_snooping(dmar_domain);
> 	dmar_domain->force_snooping = true;
>-	spin_unlock(&dmar_domain->lock);
>+	spin_unlock_irqrestore(&dmar_domain->lock, flags);
>
> 	return true;
> }
>-- 
>2.25.1
>
>
