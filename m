Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 15AE4521D70
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:04:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345491AbiEJPHx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:07:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36078 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346232AbiEJPG4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:06:56 -0400
Received: from NAM02-SN1-obe.outbound.protection.outlook.com (mail-sn1anam02on2050.outbound.protection.outlook.com [40.107.96.50])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 43EB718C582
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 07:34:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=iiqukb+FWJdGRcDPg1axDbVLDxpKDEybp7XdAOj9G45ALAfqU3zmyPAF+g18ZHlQZ4M+bv+x41L1scDvnQPqGKvOIwwuQ/aKiJCBwhVBdgq/9TwJDL2vVJkKwlSBIjTeG4ULQfYER06Yki9LvVAAtITz4JI/9p0mAMjEYNb9Gqw1mgyqjSozCDdaDCFPxn6nkB2v5tJ5O0W5rI/6XgV2OeZa/toXcfzNA3saXnwyOiA/Xw7jyp2BrzTlpxs2hfjTJw54j1GqGeACUlNZOicZ7yS/ARb/1qModSZS/mbFKx1qqFD53woNk9Zk+qOY/x73kF0M2H0Uda2oHBKIU7TlRQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=G4DtRP/5PtYFWpBG3TlhiYI79WN7SEw3HCiGre2SxUM=;
 b=RGJYX3NbGQk+x5/ym1YfT0tx/Dplwx6I0jrczN2Onvc9CmemTTry5aF4hZYNfwkXdEDlRNjVFO4dALw5CICSUyArArn4R3e94d+Z52SI+xZXWt5dcRLwhCm4kwBetYCXpQL0gZOxaMkfBnJM9CfpLvku6h/maL4KV1DT68Kb6S8nZMHSao+5kUtTQCqyJxWXoajVrO2syC/Yh7AU3lU4ZX5y6xz3QQAIFnL3njhD7fWVKYd8j9NtaKfAnV5cLz3PVHw5CHC6mJaEZRxeOKzjzIsrIqHwmAEtIrIGSZpMDR4+vMQnSuSlmNA5quQ6vJSv0UBzST/0XhtImdLK9bQ1TQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=G4DtRP/5PtYFWpBG3TlhiYI79WN7SEw3HCiGre2SxUM=;
 b=ZxvIeH3U8QiLwbIzsPpJnDVTIh5EKN7oRv+e6t+EeSxBaaEfwK5jE5k0i7xneBXAfTbPrKhZZUhmWyJAWdgqHjhwb+AsZ7rdBFovOLDhpsTZaH+iLVrb/1cz01uzZkjWZDZXCAHIsM3IKZnO4cBPdUv8+2yfTFHq17y/jj8yVEIJ9n3EOzRHA8ZevbNA5EsTASwtLdlmT6gyfYGT52QLRI2dZXRZ9P56WaT6QnodtCnSE1ZyCEP0uIdJNfjMxrqSo5AG0CmsMuZaf/Pun4xv3dtqzQ1GMmTp5u46hXqRKGwk3nz5MhFWEZCjlcfwJwYF2Kh5nPYwz6Mqwb4OTvuFNg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by DM6PR12MB3737.namprd12.prod.outlook.com (2603:10b6:5:1c5::32) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.22; Tue, 10 May
 2022 14:34:06 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 14:34:06 +0000
Date:   Tue, 10 May 2022 11:34:05 -0300
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Jean-Philippe Brucker <jean-philippe@linaro.org>
Subject: Re: [PATCH v6 02/12] iommu: Add pasid_bits field in struct dev_iommu
Message-ID: <20220510143405.GE49344@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-3-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510061738.2761430-3-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0170.namprd13.prod.outlook.com
 (2603:10b6:208:2bd::25) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 8e3e3cc3-f725-4f76-9505-08da32922329
X-MS-TrafficTypeDiagnostic: DM6PR12MB3737:EE_
X-Microsoft-Antispam-PRVS: <DM6PR12MB373768412D943D917C7E9820C2C99@DM6PR12MB3737.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: rZs4cab8ske7OC+S37VNsxIQpfDEliYbrd/4LGQcKKhiib6IjigSoAzdYjV21CHwx9j12WoTXH/mX5JkC+MzxEBG+T2W9BNb7JSHzpDBIRHAw/5W2TvQUrge2Ay9NCGlv37VexqTBKPTd3KxwjBaFBcaMPSToV1FvoSmlX2JnYXTFjiZ/GewJ/ICX2sgTgR0d2ueDPnN9IegyhiWgFgyf+uLer/hDhsaOcQkSOo9UPQewAl2wLp1EU317IzvmFicXjc+laP5ztspX8IY3h4r6cOUD88iuBANFu2DxBXCX+aZqaEcR9ZvktJMu5z1pkYoPxu8rGLhN1KJrMzfIOAV0oYTnsSGbou1XMix8imMSl4wMXglsPq1hkZ97et6QZ7l0wGAAFpJjPT0GxfvZ7Uyzqz5cOdwpvMq9BRpvBXzEzykuK2BQXNSAAiQMEpwupD7Dce8V5fZlOb2652q3FgJ0RxvPdedmKDnkTPGDA1SKwuIml1wJqqGK7M/oUL/WiW699lcbtD51pSnAko8qfiUJj0WoLKTvflidZ1dkRcoMFfFfSAu232XSZSkI1BHkMrczGEAlh/3W6Br7nPSsNPHRyhHw94YJhJDMSuqSucFVON/Ns7ucpTj49OVrKdhqZP6ET529pzTatSONHdPRUi25A==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(26005)(83380400001)(8936002)(2616005)(4326008)(66476007)(6916009)(66946007)(66556008)(54906003)(8676002)(38100700002)(6512007)(316002)(6486002)(508600001)(33656002)(2906002)(5660300002)(7416002)(186003)(1076003)(6506007)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?i+pzLiI6cpSyYGykE3fMna2Aom5U+6mT8ds8raaZE9HRjXfOHwsopHPZ4zJK?=
 =?us-ascii?Q?ihkS/BCM/xLnjejXWyk4z2dKHbFrf3MlMOtD6EdBnzr52eLD+ECybqbHhTkL?=
 =?us-ascii?Q?+PT/j8ySWOo1Fa88M3FtFI1BZKJG50Z2VDXNd6qvB8T7STcHW8C0w1euaUG1?=
 =?us-ascii?Q?GmjxqSBaU1t8F3K9b1TUEAvh3L7RloqlNLUyRf7F+1cslzZS5rZDSAePYhmp?=
 =?us-ascii?Q?sBuEuMmx1tBqecxWPX1F8nLlVkKNhvgYftO7SSZgUSffUNzH+FJ+4rPVeH6J?=
 =?us-ascii?Q?yQnG3r0UHH6ttp649ucN1lYZZYHmVAXFBHiA0uC190v5M1z2IM7lMY/fXmGV?=
 =?us-ascii?Q?WBH/8CXkXXBmvh3VH1VmXsmYLOgY4Yivni2wNQgt/fgQX98+3Lm5DYenNaX8?=
 =?us-ascii?Q?/0gdxTDx9ROHq7MoGwI32N4PAbPiP9579G7aCJDyhUEc9y4fv3tWuzZYMS6m?=
 =?us-ascii?Q?ucQTKqfheMXF428K8X/0FNdjeXYW34oNmLRfxI5BoKrJVXnL8uPpBKg1nT53?=
 =?us-ascii?Q?VRSNPf+1efiLvCnusyHkhQEU45kNLw0xYzRJ1oWj8cit/AK7pmjzXJSX101H?=
 =?us-ascii?Q?hjXlmZMUS7CfC4mcXPtjSKmCFoUdC11EqtgJPg+aV4UXC2EDfy0B1XqSDOGB?=
 =?us-ascii?Q?4r50+ME3z2YLk44T4odaeHgax9mDpbTOItwcT9QBWZ88sLc5RDe/NTHVnQGt?=
 =?us-ascii?Q?aN8KBEK1A+blfLeauid9v0/YxjIXTlD+7bVup4Y1IM0IcjSRDPAe5d9vDb8y?=
 =?us-ascii?Q?MnHgSgJHXdtfMB3CVuGL26AQF6PkWTXIylNsrKkerWirPzx58QUXYTvNM1Jg?=
 =?us-ascii?Q?sFyu8FvJwhZXmG/p8wNTyZDGFIEovn3jatSMmBY48bQlJgriC5liQMK8s8Q/?=
 =?us-ascii?Q?l9ylJD7eYtgGDwjGjkLt2QVSO8W0BzIKiCOjcsXsGYuAlgWVbhwPaFHIct5Q?=
 =?us-ascii?Q?4/TnQZiTRqJQXEwi8EzvhmJRsDzVXKH8uweA7yo7+TOVoexyko7tn2EPFLNM?=
 =?us-ascii?Q?0IioLEWPxe03yRxq83KAP73UVLWj/V3qDnC/6QUn3VOwJ+yYSlv0GhTN4ayB?=
 =?us-ascii?Q?EpVLdgc6leR/5WD3TsALrkYOkMwj4O3wm4XxIqLHxZgHDsugXJ8uxNOQBqHo?=
 =?us-ascii?Q?T7eNnHd8WbFUe4RVgLWFSbe+844WmR/1bfaBej8UcJLVcOFA4jcefvK4EVw4?=
 =?us-ascii?Q?tUMHMWCGOplv7i+S43E5wPyo68Urpb/AzxF+O8nmGDj7B0dWGmLnlRV5AwzO?=
 =?us-ascii?Q?5fKgE5lQxNJVh3ltVo7mD4fIpyLVDUwto/s0+ulkRa/LCMFGtqFTAAWvUXHf?=
 =?us-ascii?Q?Hn9qLXPXA4whW6VJy+H083MChyPQFZYNFIOInUt4z8k95VXQmqsdjlktDQqt?=
 =?us-ascii?Q?2aaa5rZJ20HyM46CisJJy7cJY+u7/5Ddt3QCTLqCO7112GvcqNZqs8kcF4CW?=
 =?us-ascii?Q?hEhy2aCBUvQ8ME+92NCQA/GRl4Oo+cturOrMNO5YzWctaR4SmFOClg2iycOy?=
 =?us-ascii?Q?ZP2VfhmWasV7rqGM2i9VMj1g2JFIW0NaDcjt0iEdJRVObNsvekQCpRvLvjhj?=
 =?us-ascii?Q?vDTH3qya6mFp22Yl0mKnOqaPK/I6UhIDGQJ2DPlf01AH3TKV2BMyoph5fBxQ?=
 =?us-ascii?Q?eF3DJnTkgMWkAhYpyWCuwNAbfNnma88D2eMCT8bwsc18ZeYqZu2VXQFcPWp3?=
 =?us-ascii?Q?/nQvyXtJKFnoWtKqU5OAgdSGQVwaFeDg/t2qrd6Rxx5Lw4D9q9yTMDxy1QbC?=
 =?us-ascii?Q?+ksdnGhoZg=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 8e3e3cc3-f725-4f76-9505-08da32922329
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 14:34:06.4449
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: LixuMJZjbvb3Uyxz2g8mJJ1fRpCPOI5aMhBrsVTHwFFmYl7GWdkzHsZsoUPgPK1S
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM6PR12MB3737
X-Spam-Status: No, score=-1.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, May 10, 2022 at 02:17:28PM +0800, Lu Baolu wrote:

>  int iommu_device_register(struct iommu_device *iommu,
> diff --git a/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> index 627a3ed5ee8f..afc63fce6107 100644
> +++ b/drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c
> @@ -2681,6 +2681,8 @@ static struct iommu_device *arm_smmu_probe_device(struct device *dev)
>  	    smmu->features & ARM_SMMU_FEAT_STALL_FORCE)
>  		master->stall_enabled = true;
>  
> +	dev->iommu->pasid_bits = master->ssid_bits;
>  	return &smmu->iommu;
>  
>  err_free_master:
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 2990f80c5e08..99643f897f26 100644
> +++ b/drivers/iommu/intel/iommu.c
> @@ -4624,8 +4624,11 @@ static struct iommu_device *intel_iommu_probe_device(struct device *dev)
>  			if (pasid_supported(iommu)) {
>  				int features = pci_pasid_features(pdev);
>  
> -				if (features >= 0)
> +				if (features >= 0) {
>  					info->pasid_supported = features | 1;
> +					dev->iommu->pasid_bits =
> +						fls(pci_max_pasids(pdev)) - 1;
> +				}

It is not very nice that both the iommu drivers have to duplicate the
code to read the pasid capability out of the PCI device.

IMHO it would make more sense for the iommu layer to report the
capability of its own HW block only, and for the core code to figure
out the master's limitation using a bus-specific approach.

It is also unfortunate that the enable/disable pasid is inside the
iommu driver as well - ideally the PCI driver itself would do this
when it knows it wants to use PASIDs.

The ordering interaction with ATS makes this look quite annoying
though. :(

I'm also not convinced individual IOMMU drivers should be forcing ATS
on, there are performance and functional implications here. Using ATS
or not is possibly best left as an administrator policy controlled by
the core code. Again we seem to have some mess.

Jason
