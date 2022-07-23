Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7901457EF68
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:15:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237416AbiGWOPX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:15:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47656 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233797AbiGWOPS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:15:18 -0400
Received: from NAM12-DM6-obe.outbound.protection.outlook.com (mail-dm6nam12on2076.outbound.protection.outlook.com [40.107.243.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D0D3B95AB
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:15:16 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=Krkpu7huA7r2Yg3F4ykQTdrip8/LBbGjY5+HN8g7m1K7MpmhwxJndjpXUHZBSdC/c6L5/S0+KJFlaA6UlvLOC7NEOTo1JYh3P6LFEvHUCMb0j8sl720tBTBS9wuqR0plcBNdlAbeVHtO2VHN/ZFUozWA2tnW7AosnyAnthhV6VsyG+T9snq4emNDUqDoe+lh9mV4Fg/FPqZvfgWAOlV0yjIUfx04vNvr/mWE8y0eq+ZCVtDJJTTju16jKQLE0PQyFYNGdgWfm7Z3spnnyrgAziuLJZ4obYpnoEQbr8Kncsz5L0ICLTkjkUDYyX47qC8kVWOQm2J3JaZ0Y9qqUsAQdQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=u9QcqkCcxvg7HCrTGVLe6iQA2d1FAOtFoCj1F4I7UVY=;
 b=S0LW5L91Pv11fGOzXS5soTTXYXq3xoeliVkF2qfRIYSIjdyyl8MASK4cG+H44bcG9KOfveoTAejFSmRw7D50KewqbJ7c5pls47EAcD1ap4EAnKTw3ymv9KAb4xX69gHgeYCzUd04DvVaiTTey3RuxddgwGdoDdu06bXkRu3mIfGb8jTaOAURYJp8WOtZR1dPf3+jhaoUSZa6VKdQFYGFtzHJp2/uBnAbSqZhsNQOUjavxxoU0na1GkIcvs5KQAt2Z/fu0JPxAFCP0zH/h7lm7VPCSkA93csrX7qfGf4uArCSatNy3n0Vy2xTYBoqcBSDaaG92hoDL4F2r+z9HeFQLQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=u9QcqkCcxvg7HCrTGVLe6iQA2d1FAOtFoCj1F4I7UVY=;
 b=AULk64Mt5urr/RcMuh5hETpkNw33pu/Wzm/gcY70CYnUvxgyRabcGNaSb7F6TxgHJ+FJtU5VdTYrc7wwkE2BLyASvVZ5h3u5UnTGRBaQnfWPblfEQIk/n3CJwR5NBy8eo0/H0czu6yQStGN7taLrALCnj7fS1f3/UdwQHk/Gq933YJC5dJjqPxLAzTnkS+B+F6+sLfGJztIjuuNg4jC0p+Ls6mdB3Kdt/Y6J3lObIbfxH6ocsD+7S4XkdgWmk2CJAcoNSNIubN5eNGwWFxq3YgnWL77m5WvKJoVS7dnl8SRuQw+CcVCXYKaHVXuZbTIVUmdEsUqhQboSVTjjnHmwCg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3308.namprd12.prod.outlook.com (2603:10b6:5:182::31) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.18; Sat, 23 Jul
 2022 14:15:15 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 14:15:15 +0000
Date:   Sat, 23 Jul 2022 11:15:12 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Vinod Koul <vkoul@kernel.org>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        Zhangfei Gao <zhangfei.gao@linaro.org>,
        Zhu Tony <tony.zhu@intel.com>, iommu@lists.linux.dev,
        linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v10 05/12] iommu: Add IOMMU SVA domain support
Message-ID: <20220723141512.GE79279@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-6-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-6-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MW4PR03CA0185.namprd03.prod.outlook.com
 (2603:10b6:303:b8::10) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 88abd1a4-7f93-4399-7615-08da6cb5c36d
X-MS-TrafficTypeDiagnostic: DM6PR12MB3308:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 8OOK8vDYpbJSswuWAKOY06AvUiNAkSdYCpXEv5BUVzLvB0XRtSGijj+JrzC3dw+4kRaqiyN0RLNXYi4RB0Jw9f+HZ3C4tK5aroRgVhnyVRBTPtSthn+wAqhXNpfnWwz3XjBoWeRWxoZ9liZJUV5Q53UT3oxHhIzsm2EqDlS3lXKid4Yjv3hXrdNzvpg9+/orNSHqu8QExAgonQ6s0VtMXeD697bJRUoNs7piIx2osiB179YHQKWdJ/JCZIDEPVCrHIB61v6Isb/j/zkZg4lk0zGlJPSTzR1VwE1T3oiTnE7sGJLfAz9Mh0FU8MieNUlB+PZIhrU/YefB3bxT6V5nQOj3YyK6AGWr8vc+CpJY7m4P9mGNIw17/a4Fz6+HXXkze5QhOL3V5aso++APXYh0CiHR5NdIwrcd8mtK6MqtBW00erLSsroKbv1o0Ho4D21/qaumNGsG2qYb8qteWb/sBdFc4DvPm87rAgxyFFzExc7OD+E5TzlVNRjCx8dxVe5MW/A4ERl78kHDEJAf/h+MG+E+471Zg/40KuYhe4afLVU2lOqF3lygWl4LyvNQTn3PP3cZyLNMxJ0+gTUtzOmu5pKncWprXz3yC2lmGhI5zkA565YdfLj88NwL6+ez3++ZdfHLVg+NmAOvUQPrn2NFoVAK56AB3WsYiPTAlSgkiV7+IwupGkdyILzneGkgS4KSk/V1g56cJBwoJZzhXn5MlRN5tRqi/jUBo+UlEhIYCJxgaSQqrzIWXMqTczFAY40J
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(376002)(346002)(136003)(396003)(39860400002)(316002)(36756003)(38100700002)(4326008)(5660300002)(66476007)(8676002)(66556008)(54906003)(33656002)(6916009)(66946007)(2906002)(6486002)(83380400001)(26005)(478600001)(41300700001)(6512007)(6506007)(7416002)(1076003)(86362001)(6666004)(2616005)(186003)(8936002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?xz7n0YqVXLR5+vxZP+CRIPStzwzDNllPVBd6rn/0HU73N8+uZLSwKd6pSfda?=
 =?us-ascii?Q?2pctjw4dJLRRQJNBmk1pjUf+bG7HevLHGf652nYBh/qyV1f+enPQcsaHQgei?=
 =?us-ascii?Q?oFbbDeA1bm12EzYhIjF3RvhfHMV7YV2fh3+0v5P++rDwL5eqzHE7qPZPO2H0?=
 =?us-ascii?Q?4Ee35c8bo9xMjeYvRw7F/LqdcnVtiBStwLRAkn7y5r7+H4CjlVo/2WNMDQHu?=
 =?us-ascii?Q?z3l/oec4Hkw+2z4LeLlDnrD9BkYK/8OINYVgSjV2ZRV+yJA8FOB3/MUep4O5?=
 =?us-ascii?Q?fCNsN4ELD4am4lLQ04sCT3Oy9CjGTs5YwtBy3z9WeooNB10kxdWfMAo4CfiH?=
 =?us-ascii?Q?i9p68Z/MtU3H3jlGCqbwZiS4YvTiP9WYZzDUsmPf2DH+IIP6ykGATbcb9UeO?=
 =?us-ascii?Q?G9+SMfnQNqhFuvcdwcDvaYwrTWq1TZdLedqTvRh4Vtci+97PuaNyQQ48/g3J?=
 =?us-ascii?Q?OkRL0m8kSoaFtROc0Vr2i6ARl3IX9JpXH8wUqJfwj28/M8ygggykH1eJJ79z?=
 =?us-ascii?Q?3G6i/oQFSwsF/K9rF1mHVvuZrWJx8/a0T4HVpbhWdpXUu8QbCYYdX5Sd79Xk?=
 =?us-ascii?Q?y3NBZJ/39WHMukh7BV0loyayg8KLSTIs6v5WZYSf0KDVGXyMAT9ePn0cCWpv?=
 =?us-ascii?Q?N2BQ0dgLXvcz1zyuGsFeIGK3as/CH18uZN6WaOzVe/sIy0ZH7A5SmWK8fsuK?=
 =?us-ascii?Q?BAs7Fjl351oirTcsKB4NI9bBchfGpgQz3KQ12aCItu7Od6QOYCIgfiodQzmT?=
 =?us-ascii?Q?siigOXtH8w6kOcSewSl9aHLehLA1AW7mT99+EcaEDro7Wfi+KnP1ti7segre?=
 =?us-ascii?Q?fOakWOAQy1EkWCzs39mE7z8WyAT86T6yOHyHyifenPpekgja6Fq5cz0t0TzY?=
 =?us-ascii?Q?qDVO8wdpuXVXIhFLkOjz6bvDT/JeYjl/qQ0AQkCiKi/XqHPNXW5zjTDvbIVA?=
 =?us-ascii?Q?yn7JgAUNJWaYsd2366nZDwkisPuEF9DyF8GamFPKNIQQSk1EmX5ERDaYsDz9?=
 =?us-ascii?Q?uJT44GfttyOA1ueqrs12Mc5+JKJngvnTl6p9ydSZAPNYndR2GOMY2dlw0Djy?=
 =?us-ascii?Q?KZ26LmM8IkPp4CJPx5plDbCfoSasYkOHZYZ1gvvWO3li+3MHiW+8+4koWB88?=
 =?us-ascii?Q?8kLV6eax/1pReAX7wA3n7d0/VysxgNDqbl/iW3Y0kekKVYs0k4y7TGEKzpbT?=
 =?us-ascii?Q?6ar0HBZaqI0qV/Eaidur47XETfVKD95VyaUL3SYEO/GsjM5ohyCRF/s5TCMI?=
 =?us-ascii?Q?0jL1gRy1QfTk46ZshL3wE9zbz2rz8jzmYtcjRhPi18yj3sRzqXy/mpRZl69x?=
 =?us-ascii?Q?OCBCX7pfrdEv846Oh/+XopT9Ud8FhdFbACrDNw9Tnw1p/VIPKBQ19oUISx2e?=
 =?us-ascii?Q?IGeRdc/5HJCLV1nwuyQXb+ET3m6E6EGM3e8xGxAhamiV36qdJBGU8yPD2S7d?=
 =?us-ascii?Q?TWQCaD/Fj14ZPLC7Ifld21E9QzkzgF4MivQ9aCN2mGelWhk9Ij+7HotaLhat?=
 =?us-ascii?Q?OhxZ3yUMflCHFq5TR8V0FSMyBe9MQnNJAlpTYw8wcnSn5ZOkR3hCs9kBY8ig?=
 =?us-ascii?Q?abmjCVa4KMXU+dpjr6rZfexnMUr5PrZgcavY8Zvc?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 88abd1a4-7f93-4399-7615-08da6cb5c36d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 14:15:15.0894
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: bxb2ijhSPFPysTJioXTH8WVMdo/7aUyt6LuDlpSW/1UaxaE0UZ7RIl94rjQpIuhY
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3308
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:07:03PM +0800, Lu Baolu wrote:
> The sva iommu_domain represents a hardware pagetable that the IOMMU
> hardware could use for SVA translation. This adds some infrastructure
> to support SVA domain in the iommu common layer. It includes:
> 
> - Extend the iommu_domain to support a new IOMMU_DOMAIN_SVA domain
>   type. The IOMMU drivers that support allocation of the SVA domain
>   should provide its own sva domain specific iommu_domain_ops.
> - Add a helper to allocate an SVA domain. The iommu_domain_free()
>   is still used to free an SVA domain.
> 
> The report_iommu_fault() should be replaced by the new
> iommu_report_device_fault(). Leave the existing fault handler with the
> existing users and the newly added SVA members excludes it.
> 
> Suggested-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Suggested-by: Jason Gunthorpe <jgg@nvidia.com>
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  include/linux/iommu.h | 24 ++++++++++++++++++++++--
>  drivers/iommu/iommu.c | 20 ++++++++++++++++++++
>  2 files changed, 42 insertions(+), 2 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
