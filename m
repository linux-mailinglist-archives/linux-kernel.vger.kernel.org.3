Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 10F00506CCD
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 14:51:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348188AbiDSMyQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 08:54:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237698AbiDSMyO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 08:54:14 -0400
Received: from NAM11-DM6-obe.outbound.protection.outlook.com (mail-dm6nam11on2042.outbound.protection.outlook.com [40.107.223.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC18236B7E;
        Tue, 19 Apr 2022 05:51:30 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=oWI6sCydZCVqFcXEnICDD5MbwpeykUoLv+7LGrwYAlrk+VriZC69HIUiAisB/x7EL3aFfdHBVJNE8tiNZhGz12f3C/3BDJ2kWTwhm0bGG6LbetcAKGkEdCNyQZSCDZepqnLpLOk7U+hIPCcqd/ZXC8FGa+Y+w3D8Joy+2km6K1I/HUBP1T5cZCE+4Ca2hl+kGhw0LBSHui2t3Q5x+E4s2BV9/Jy8puz0OfvEjq579D3AN3XbnKwQUtrdKvp1JajrIMAEXAZoi8xTbY72oFOCeGOr/WuNBTXNyBSM+/n7RYPhTjDLmOsTjg6+SH9V8cTMiIo6c//RnmHHJk/TXwiRxg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=sCM9r/wnzfDG4/UL3qWzulPN+QyzzWHoODVHvwGqRPo=;
 b=TruY9QR2MMtBASU1KdZbiwQ7r+VqEE3O3xMTOE6WTht1DYRGhkyzTrYLMjSALioHqmA4GDYKMLMdXXqoQr+ApBYM/Re2gfuA4BmdrhCkw/XODNhTKp6EEBQBx68YVjPbRTiAlWoc2A6XXnNhjTQ7oxHlSAGVe0kWmD8Xb7BdWubnbD/ZbxSILKrl8iWRhI7Kd1v6gMqCPWd7tnzUIQnrsGWIdIwtgHHCAps5+ngXcrcfBs+tpGFjBqEHsWX3yvNvxnlY3m00nMqlJbxSladUip2klC06X+AMBAki5U5fCQCykiyU7BX9tAqZENvnVTmn6et5M/6abCeqW2fd4tkv/w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=sCM9r/wnzfDG4/UL3qWzulPN+QyzzWHoODVHvwGqRPo=;
 b=hplbNPx5Two1BBQKuj7khbfryglhmiiY/bXmUHxGwFUPs3nPz2NW//NljiW4O/39RhcFkPkrqYNrrxyNle0tr7ghEQ6NwTbGpG3w2XLQJJbBUnO9z65/ypd6GJedQRV85BtcnRqXstNbRh3ViizCJJHAmKQ7fWrHMdVswvV4cFvQ0Ft5tsfZYRcp/qS3u0XeIiSeyhnphBs+aN5PtfSU7Yuup/rOJRYcd012gRL16aexnbRwiqajKJAOiSu4dawvNbaxqLhmlMt4YF1VXMEbe3tkV6PlJSmFamaMoshwpDxnY7NiL3ehH3GU68R+K/AoXsEYMvM1XbGCdWq57e+5Zw==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from CO6PR12MB5444.namprd12.prod.outlook.com (2603:10b6:5:35e::8) by
 DM6PR12MB3180.namprd12.prod.outlook.com (2603:10b6:5:182::28) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5164.20; Tue, 19 Apr 2022 12:51:18 +0000
Received: from CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0]) by CO6PR12MB5444.namprd12.prod.outlook.com
 ([fe80::a4b2:cd18:51b1:57e0%4]) with mapi id 15.20.5186.013; Tue, 19 Apr 2022
 12:51:18 +0000
Message-ID: <9959df86-e3d3-9b65-44c1-55f2a68bee26@nvidia.com>
Date:   Tue, 19 Apr 2022 13:51:06 +0100
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [Patch v1] iommu: arm-smmu: disable large page mappings for
 Nvidia arm-smmu
Content-Language: en-US
To:     Ashish Mhetre <amhetre@nvidia.com>, thierry.reding@gmail.com,
        vdumpa@nvidia.com, will@kernel.org, robin.murphy@arm.com,
        joro@8bytes.org, linux-tegra@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Cc:     nicolinc@nvidia.com, Snikam@nvidia.com,
        Pritesh Raithatha <praithatha@nvidia.com>
References: <20220417090432.21110-1-amhetre@nvidia.com>
From:   Jon Hunter <jonathanh@nvidia.com>
In-Reply-To: <20220417090432.21110-1-amhetre@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: AM6PR10CA0036.EURPRD10.PROD.OUTLOOK.COM
 (2603:10a6:209:89::49) To CO6PR12MB5444.namprd12.prod.outlook.com
 (2603:10b6:5:35e::8)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 2078c21c-7740-4fe5-4c9f-08da22034ba4
X-MS-TrafficTypeDiagnostic: DM6PR12MB3180:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB318076A097FDDE13D23F465BD9F29@DM6PR12MB3180.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: CElxR09K0fh0/Ul5sULHPI9uwtGF2PQDeNgv/PhIembT+63gfTZcqB5RYmRIpMw2L0Z7lsSZEUeUVWo5xDl8Wj5RLsvFUxgZmCIGCCrjZQ64sEsP6+BggHcJcYFb2h6t/O4zt0weBZ8oN3M4adiwAgPiLMvFEn0cJ6TYMOxALKHYfJm0qdc3WwcsfD5q94a13T4CGie/+5Pxlg1wDGkOjN9YTCyxNWhddd+ZPL6p8X4aR9a9E5YLS+57rmT460PWkLo0dcxdTs4D59qw8Plw7Odblb6ANy61+KcWTOR1FGpFyWO8ShwQdoEMxmxl6FDYsavN7tiWK3ZLTrXeHhw+PIKgOgkpSw4ZrvwU6lZJt/SjfH7EkJqf7a/kbz42tTfjn76KYCocy4I+WeKIIfyUIIzxSVutP95N3BIsDGwBC9ePWUcu48+bo5vPrTjG/wf4WcVvyJDN3a+zwkc3Iaw1L4gG5a8VpjYL0abLBqxm8ukEiOmnpFsGznPlTxWi3CZ199mX2E5BuIE3POLc7Z4FNdA/OqWmgnLuF785HXrORFoVEKvG+00vJEQ/DUO+/vfM7G4Oh22D8Ue3bqN3k67wlwUmofEac4JrcsUSlscJ/Fx7vKyEFJByzNuix1dPH3j5rXYJ+2LZ878rzdb7xh3IyHSuAt3xIt8jE2OydZNdkQRHO+Pu8p+cr/omam9ONdrBTt+5YxcUAg+B9ebNxlpirqlcFLOxJhb5zjAdYPvLDh7E1s/C658lu1J4+3frKCVmWDPAl3TnopnWQ4xtkhsF7Q==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:CO6PR12MB5444.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(6666004)(86362001)(83380400001)(31696002)(66946007)(186003)(26005)(316002)(921005)(6486002)(38100700002)(8676002)(66476007)(66556008)(107886003)(5660300002)(2616005)(4326008)(508600001)(8936002)(6506007)(36756003)(31686004)(2906002)(55236004)(6512007)(53546011)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?WndSNnc5ZlZIb2QxNkV5R2VkbDJYZC84bjlMQzdPQXBieXJMMkk4cTVyc0ZK?=
 =?utf-8?B?V1k4TzdCcW1jSml4QWxQNGFUN2hVeEZEU3pHaFhVNjlzWkpzenV4WlVQNnZn?=
 =?utf-8?B?TDV3ek5aOXpwNm1INzZueTZKWnFDQnJxNUlOUVBicUxZdmxTdjNpcVl0SzU3?=
 =?utf-8?B?eDBpSzBDZ21TMlRXMkhvVVFOK2h3QUNyeHdoektGTjBhWEZEaSt0WU5BLzhC?=
 =?utf-8?B?QzdkM0FJTW5yMDZOOFMxSnBRemI1c3pxVVVFSGdGbjRLYTBrTjByd3FrNWI5?=
 =?utf-8?B?aE9lcUhaSkd2TXJFUHhFcC9KNndIeElCR1l3WGI3NVNBdWZ5Smo2WlpBemU5?=
 =?utf-8?B?NlcwU1dSM21DdkFLcW1FZEYrMk5vMjJHZUpSRzBIMGVVbFlpUERISksvT1Mw?=
 =?utf-8?B?OUNkUUNmTDVOMXZoSTA3TGZsVzRvd0E5cUtjSEdMTUlIa0RTR0JDb3c2ODRU?=
 =?utf-8?B?amRIOStYYkZQSDZDZ1FTak5yYllYOUxyTER6d1d3bjhYWDZFejlwZmhrTWkr?=
 =?utf-8?B?cW9FaVptUTZRUm1hK0pCbmpqdnZUcGNzY01mbmlMZEU4NThZaFp3cUFoTnFX?=
 =?utf-8?B?QXI2N2RNUUtJaHNaRDNZRUdwNnM1cG5YN3hrNEdqNC9SUHh3VnJEb2llSUhZ?=
 =?utf-8?B?RkFiSWMwUXdTeGwzZVQ0STh2N1RQM3kvTWk2UGwyNExPM3RSQmd2NzNNczR1?=
 =?utf-8?B?Tk1MdnBTc3RJL0ZBWEpOWkg0QjFiSDZlWGFqaFl5TWZ3RGlRcGtHdHd0VG9t?=
 =?utf-8?B?VStsRXQyZ0J4a1RkRmZSb2RMTlNjMjRiUjZxaWN1OVhDNzhPVUVmNFlNb09I?=
 =?utf-8?B?ZDF3TnBJeEdOKzZwS2tqdlVyZ25PQ2lwMDJVSzBMNzlRN2dpV2ZqZ1RCUXg4?=
 =?utf-8?B?K1d2SUhoU3VwR3hjcnhwMHp0R0xIT2ZNMkJLS05JVmwrL2E5UGdKL1ppK2JY?=
 =?utf-8?B?ZE53eGN0NFJSQStycm56TkJXL3BZNHZiQ2dzSXdjWGJhMkYzemJGNW1LWTFx?=
 =?utf-8?B?QlNVMkpDM3l6dHFOZ2JpVTI1Ly90bVhYWG1va2MvNXpwbE1Zenc5UkI1SVh2?=
 =?utf-8?B?MnUvY0FYQTlUNnRGMVo2QTdyb3Y3QUJDdFlnakx5em54TE5WcHErS3VYdkFT?=
 =?utf-8?B?QjZVeW5uK3l0WkwxWmVNSHk2aGRJbFZzMmZVTkdFMnAxaEhHc3htUkpEVHV2?=
 =?utf-8?B?bzBiMXlPTTBYc2FYamwvMHVHWVlweDlWc2ExMmVDYkhoWThTZ2JpbktwQitO?=
 =?utf-8?B?ek1uOEsvL2JpcStNUUpMamhJQmF6Qm9tZTBYTkFwdHVReUxuSXozS29GdHE3?=
 =?utf-8?B?emtqeWcxT1JyVVRBQjRRdWVwUkJVcE1aWEc4Wm4rblRURWt3L0I0eEt2ZVRk?=
 =?utf-8?B?NUtrU1h3WGQ1Yk5QZXhvQlkxZ25vQ09LSWZLdzJuTm1qN21ocWhmSFp0TnN2?=
 =?utf-8?B?dHpQbHRFMVp5WGIrd2ZBMFdZNGVIY3Fyd2YrSHlDSUJ5U3oxUlNaTzR5cFR5?=
 =?utf-8?B?TjZJRDRwZjBjTlVKam10Q0p6WG9zQjEyeWZZOGF1RXdLVGpDaklVaTNmVXA0?=
 =?utf-8?B?eVd0ODNEZkYreHZZaTRXSnpWWm5pSkhzRXFQYndxNThyRnBoU3NubGtJcEE0?=
 =?utf-8?B?TldBd2ozSU1VSTh6c3FwL2VNT2wxQUlCR0xNRlRvVzQ3bUFONDJsMGhPdlFa?=
 =?utf-8?B?ZDBHenNOTHV3VDg3V2tISFA2SmlXV1NSc3FSQ0x6R1lXcTZ4allhcENuVzhk?=
 =?utf-8?B?WnZtZ0l1UzhreEszcVlPNjV2Z0RCRS9FUllvSUhwWWVNN0svVHZLYjl5dHJQ?=
 =?utf-8?B?YTI2UElSVWFBWjl3aUp4R20wNVdXUDhneTE1WXpsL2IzNUswQi9FQmFIUjJG?=
 =?utf-8?B?MlFOa1JzK2E1K1NCdFphb0FmUGx2TlVlZHMrcWUwMG9PMGlkY3BiWWhpT0pU?=
 =?utf-8?B?SFY1bm0yK0tkTUVQUGlQV0xmMUFCcXFzblhRYWJPU0hTcWMzNVRwUEgxQ1A2?=
 =?utf-8?B?cy9zZVVFVHpBWWlMQ1E1WmlERzQ1MTFTTWdzYUNzN3cxeStJbVc5ajhNc25N?=
 =?utf-8?B?VS9Oam52NzZTQlBNSlYybGhlVXdJaHFYK1Ywa0lBTmVsUmU2RzJWaGplRUMw?=
 =?utf-8?B?c1JoaGhMSzhmK245VE1qNlV3Q29lUWRFVThYaEZHMG1JWnJVSWF4aTlVb2lL?=
 =?utf-8?B?VzVablFuNnVoWjRmRVZyazZRcWI5cjZqUis0Q2JBTGVzTnd6Vlc0eHQ0Z1dZ?=
 =?utf-8?B?VWExcFNTRmFJWlR1WUo3MHhkVDlkNmJsdjQvejJoYS9Eem5xTDluNXJsTHNF?=
 =?utf-8?B?TG1BeitNVUM0NlkzNGJydzB6NHNLWmdaazVMSHYydjk5TFNNYnV4Ykg1WFdG?=
 =?utf-8?Q?b8dSgqUCkj5SHMOg=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 2078c21c-7740-4fe5-4c9f-08da22034ba4
X-MS-Exchange-CrossTenant-AuthSource: CO6PR12MB5444.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 19 Apr 2022 12:51:18.0351
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: nVOvZGySa1DGy9mhpx+vI2bKbOOBwIJ4lhuPyCtzNcK5pwEJoZFLx/ViJmdHTYAhKuHu06YG0/KIrw8Tu74p3w==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3180
X-Spam-Status: No, score=-4.9 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


On 17/04/2022 10:04, Ashish Mhetre wrote:
> Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
> entries to not be invalidated correctly. The problem is that the walk
> cache index generated for IOVA is not same across translation and
> invalidation requests. This is leading to page faults when PMD entry is
> released during unmap and populated with new PTE table during subsequent
> map request. Disabling large page mappings avoids the release of PMD
> entry and avoid translations seeing stale PMD entry in walk cache.
> Fix this by limiting the page mappings to PAGE_SIZE for Tegra194 and
> Tegra234 devices. This is recommended fix from Tegra hardware design
> team.
> 
> Co-developed-by: Pritesh Raithatha <praithatha@nvidia.com>
> Signed-off-by: Pritesh Raithatha <praithatha@nvidia.com>
> Signed-off-by: Ashish Mhetre <amhetre@nvidia.com>
> ---
>   drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c | 23 ++++++++++++++++++++
>   drivers/iommu/arm/arm-smmu/arm-smmu.c        |  3 +++
>   drivers/iommu/arm/arm-smmu/arm-smmu.h        |  1 +
>   3 files changed, 27 insertions(+)
> 
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> index 01e9b50b10a1..b7a3d06da2f4 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu-nvidia.c
> @@ -258,6 +258,27 @@ static void nvidia_smmu_probe_finalize(struct arm_smmu_device *smmu, struct devi
>   			dev_name(dev), err);
>   }
>   
> +static void nvidia_smmu_cfg_pgsize_bitmap(struct arm_smmu_device *smmu)
> +{
> +	const struct device_node *np = smmu->dev->of_node;
> +
> +	/*
> +	 * Tegra194 and Tegra234 SoCs have the erratum that causes walk cache
> +	 * entries to not be invalidated correctly. The problem is that the walk
> +	 * cache index generated for IOVA is not same across translation and
> +	 * invalidation requests. This is leading to page faults when PMD entry
> +	 * is released during unmap and populated with new PTE table during
> +	 * subsequent map request. Disabling large page mappings avoids the
> +	 * release of PMD entry and avoid translations seeing stale PMD entry in
> +	 * walk cache.
> +	 * Fix this by limiting the page mappings to PAGE_SIZE on Tegra194 and
> +	 * Tegra234.
> +	 */
> +	if (of_device_is_compatible(np, "nvidia,tegra234-smmu") ||
> +	    of_device_is_compatible(np, "nvidia,tegra194-smmu"))
> +		smmu->pgsize_bitmap = PAGE_SIZE;
> +}
> +
>   static const struct arm_smmu_impl nvidia_smmu_impl = {
>   	.read_reg = nvidia_smmu_read_reg,
>   	.write_reg = nvidia_smmu_write_reg,
> @@ -268,10 +289,12 @@ static const struct arm_smmu_impl nvidia_smmu_impl = {
>   	.global_fault = nvidia_smmu_global_fault,
>   	.context_fault = nvidia_smmu_context_fault,
>   	.probe_finalize = nvidia_smmu_probe_finalize,
> +	.cfg_pgsize_bitmap = nvidia_smmu_cfg_pgsize_bitmap,
>   };
>   
>   static const struct arm_smmu_impl nvidia_smmu_single_impl = {
>   	.probe_finalize = nvidia_smmu_probe_finalize,
> +	.cfg_pgsize_bitmap = nvidia_smmu_cfg_pgsize_bitmap,
>   };
>   
>   struct arm_smmu_device *nvidia_smmu_impl_init(struct arm_smmu_device *smmu)
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.c b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> index 568cce590ccc..3692a19a588a 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.c
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.c
> @@ -1872,6 +1872,9 @@ static int arm_smmu_device_cfg_probe(struct arm_smmu_device *smmu)
>   	if (smmu->features & ARM_SMMU_FEAT_FMT_AARCH64_64K)
>   		smmu->pgsize_bitmap |= SZ_64K | SZ_512M;
>   
> +	if (smmu->impl && smmu->impl->cfg_pgsize_bitmap)
> +		smmu->impl->cfg_pgsize_bitmap(smmu);
> +
>   	if (arm_smmu_ops.pgsize_bitmap == -1UL)
>   		arm_smmu_ops.pgsize_bitmap = smmu->pgsize_bitmap;
>   	else
> diff --git a/drivers/iommu/arm/arm-smmu/arm-smmu.h b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> index 2b9b42fb6f30..5d9b03024969 100644
> --- a/drivers/iommu/arm/arm-smmu/arm-smmu.h
> +++ b/drivers/iommu/arm/arm-smmu/arm-smmu.h
> @@ -442,6 +442,7 @@ struct arm_smmu_impl {
>   	void (*write_s2cr)(struct arm_smmu_device *smmu, int idx);
>   	void (*write_sctlr)(struct arm_smmu_device *smmu, int idx, u32 reg);
>   	void (*probe_finalize)(struct arm_smmu_device *smmu, struct device *dev);
> +	void (*cfg_pgsize_bitmap)(struct arm_smmu_device *smmu);
>   };
>   
>   #define INVALID_SMENDX			-1


Reviewed-by: Jon Hunter <jonathanh@nvidia.com>
Tested-by: Jon Hunter <jonathanh@nvidia.com>

Thanks!
Jon

-- 
nvpublic
