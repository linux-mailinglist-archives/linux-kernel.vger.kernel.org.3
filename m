Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D9D5521E9F
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 17:28:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241731AbiEJPcM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 11:32:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345930AbiEJPbO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 11:31:14 -0400
Received: from NAM04-MW2-obe.outbound.protection.outlook.com (mail-mw2nam08on2071.outbound.protection.outlook.com [40.107.101.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 06E6512A8A
        for <linux-kernel@vger.kernel.org>; Tue, 10 May 2022 08:23:33 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=JcDfWsw3sPhLz1sXsaPbkXZeS0K8rxSJpsgziQspvevlekw11lUS8DBtvdqMhTPGVcSg3Q9LtyJ19vGUV05nD/R/wGW5UJ5jNRyK3qS021EiwE2cXYXBwJ/YMT+uI5Dpt+rctltk+425fGj9oXHpIQJNrpcIo6FFrBddF6mQ83mQRZy5JY0Nquk7Zs6QFoWpah1DCzFv1EHg42FfXmgtmalDQ+DJ7FxhSYQjVH8+DrDpK2dsXq1LVfofdXiPy4eZerL+AMsUD3N4d0OVJmUYQESncaoRBrB4m308x/L91TPstg93oGwLiqCSdUnfZdaYA1aFndTMBtiXNr2VMbfD9A==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=x3qxxIbtinC5jkEoro+y7CsWf73geLNZE15fSbU/ee8=;
 b=EBKJtbEoWJ6KrKpcOrqV0MhuiLCGPutSk0qiT+ZaKn9PTbtV0v8S8r10rivrzWtmiNPF9l8b/vHlDReQ56MfZ7icJAuek92SrhUglEMBMJpbyTW4vPCfAzn8+d2XgFDoEVNKpogCMhZVFPhHFiKFKmg7UgHC6c6XT2EhHqrNSWi831vvmMSGE/yeeSuqqZh9NoZeG/G4aoxbFC8EOycCmHugSn6WJkA1mgfpi9VPt0prJYIXPHkWi4DgYE0SE99v4YBSx2k6KSbgVh5bIKqDtUzLNxtzVPfdg0xvadE+HTMwJ1aAFYTFA8ohi96DD1VvNgLPA3YuQMmo7yf+mhknDA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=x3qxxIbtinC5jkEoro+y7CsWf73geLNZE15fSbU/ee8=;
 b=SzY0Wxer5Yw7Wj0ITp7faq7wIuXSXaTvUo9dc2HmY65102Kznnq2PbEyMygk0ULoTm1jKQg0HX+b5y087NbQ56uRIZ/9yRkSB/zZXPKcq2BRVQ6JnHZyLdxhjwQesFcIIU22lNYqoTMDUFszyy+itX2tDgkDOnHD5UIceOe+tUlY4VwGVyv1Q7epUNZ3uWd2XFuJBYy1xZ+8MMOEbpoNX0eOeDDC+ZedFlS3jt4lU2mi6mWK2NdLcoRBePdkoMQzZ2aimyG8zPh7oIAYx7PnkZaL4Hw2IdYFdei9xhC73At/xWAini+LPgmRYEH+s5ekPCe1ofKoSG4iGuVstITKWA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by SA0PR12MB4510.namprd12.prod.outlook.com (2603:10b6:806:94::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5227.20; Tue, 10 May
 2022 15:23:31 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ec2d:9167:1b47:2db2%5]) with mapi id 15.20.5227.023; Tue, 10 May 2022
 15:23:31 +0000
Date:   Tue, 10 May 2022 12:23:30 -0300
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
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 08/12] iommu/sva: Use attach/detach_pasid_dev in SVA
 interfaces
Message-ID: <20220510152330.GG49344@nvidia.com>
References: <20220510061738.2761430-1-baolu.lu@linux.intel.com>
 <20220510061738.2761430-9-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220510061738.2761430-9-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MN2PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:208:e8::43) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d21d48eb-8269-4bb9-328d-08da32990a5d
X-MS-TrafficTypeDiagnostic: SA0PR12MB4510:EE_
X-Microsoft-Antispam-PRVS: <SA0PR12MB4510F3AC35E738FFD69C75A0C2C99@SA0PR12MB4510.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: yKFdoNKvmzmmGQuR4nRkIuUQ1xSpjQKPornHDXOQioVKRZ924bEXwQ/1qxpV3TdmviZoRHgUy3qz4SAl5WP8QqNps0dROr229MnAepo/yTzavNMmaijQ0W9WAf1bSFDUb6VTlRIvDc7yMlFdQl3qLbhCzG4m0kgHMrCV7gIRPUUSGwM+oxIYRYo7rFmYWyixtFz2naWIGm3B0e+cap3w8mnxNRLYnHYurjp6AunAWSLfi63DvowVCvpWjT8Ovuu/KAg90hZzg0n1JY2giwUvzO/0FXwrBli6dUoXdprP5DvZNfacg+BgvVu2uPPuES/7F1juT0NFEfeHKZlw6balTK4UGl/5WZAVfOqmlj3QIVBCD8dXIMNFApKasEzthtP4z6rAX4t7POARPYN7Ec5iC9o3d4bvzdFableV+9Gc47KnZnN/WB87r/nA9ucgiVhX5YhcBemrlCNEYRm3nkmWuN4TefEAjFCCEUlriYGqds2HxtD6Jf9q477h0Lm5r8y/xU2gtvFBJULL/pNL/16bI2FkDub+9HQulQApvw9RiCVtW/kk96T965j6xuI4DebgSMNXDiV5RbTW5sE6v//vE82rW2qJ30LHB8xitGuHukYFQZbKn69pSrr44a8J/VgXLySRM5drha6w0ty3e0nvqA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(38100700002)(508600001)(6486002)(8936002)(316002)(54906003)(66556008)(6916009)(86362001)(66946007)(8676002)(4326008)(66476007)(6512007)(7416002)(83380400001)(26005)(6506007)(186003)(2616005)(1076003)(2906002)(33656002)(36756003)(5660300002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?9hPr+psUlkUgXgMNl6vvbxl9+dC92QB+XfR3E/B0gGW/ddIIW7nAfgcVF+kn?=
 =?us-ascii?Q?XoEZrkS89x4goNFRkbFmDA6V0Qrg/FE4qdrn9lkGTrce1vBcnFNUJkO7V5cO?=
 =?us-ascii?Q?+OVnKqwViwCtdotitG9PPT+u9A7igKri64tQniStUeuVg+phdFKP9tol22MO?=
 =?us-ascii?Q?1Zx0ZmaO2GnaE+Bp948hzgseJv+X9JDV3SLPJ61ctBNzxKTS2oycNdnrlG78?=
 =?us-ascii?Q?jSAADRRj2j3OniCRC1j80R0d4ofbYni/jNvgFW5EvcRl3p9rKcumsPJ3iL1K?=
 =?us-ascii?Q?kLO8Losm8Y9lzyBjx4cXJUVQ1UfZ3mJF0q1py9YiUC0tpfA0F7l5euaefZSB?=
 =?us-ascii?Q?N5S2SpEEkxQ50iHkMrvjzE3x9UldsThCJvPeyZS5VKGnSauSCjPTM9YeHh1z?=
 =?us-ascii?Q?PJ2vgappWkgXNmon8u2UweBIklOyafzZziOwZsN7XQcxHKkMng/Rss0blT+E?=
 =?us-ascii?Q?yAUrlR/04TR9yeZQIjOS2d7KQv+DZysDtotAXFZfYwyz77m/lXQQjCB6sgra?=
 =?us-ascii?Q?0Iv5XXLxV/N2IwzUf4nZM/6bca4R3mNm9xxHzKdUBsmNMcuzJrlG2cFEghbU?=
 =?us-ascii?Q?IqE4YURTaiURCgebbdiGv3bLhYFIsrl1hc+V2iGDOIOmgT7XaXqiKv/XbHy4?=
 =?us-ascii?Q?UZSeaBK1Mz/Ps/4UOSLhnG1JgcTJQSyBSNOXKahyf80NQoE99Yhk+4FgTZms?=
 =?us-ascii?Q?tUD1kAfpM9c1nQNg7ykFabF6Wcl3/xcQLvW8IzY4jDJWwLPMTC017sQV+yWd?=
 =?us-ascii?Q?Iv1aGKPGnQWvrg5vbcDuLxpWf4n8yoF5Q3K/qJ8p2mI+mnfG6JQbCnQNmoyL?=
 =?us-ascii?Q?pCu7XKK42DrFZikr9Um9pQyqji6g061W160aX/lSikylSGRWTEVzfZ4YtdXQ?=
 =?us-ascii?Q?wUDKDmkKsh+NvvfhVOC5YFFVdIZplK7206PopnyztzmgiF/+EtKMN5Yo20kx?=
 =?us-ascii?Q?pdojqHReE7yS+pvgKfaYNFTZQlFJNlBvAPWQzahNGrQUiAUisLoNVgB0k5oM?=
 =?us-ascii?Q?Q/ezi3Ehz2mp8ZlMAc/3C9C89osZsXatCYwMpNUP+u2x+BYFEYogbRlxDx9Y?=
 =?us-ascii?Q?AKcYKn4UbdrILKL47nVIjrFeuiJejuTkUXRchZ13jdtfa/N/FStAFz/MwYUr?=
 =?us-ascii?Q?TEKe6uOgC1zfteL9f8TYjAD1YUpJb/EWNdTWSLcpoPIbPmGfQlAgdyhPjCka?=
 =?us-ascii?Q?jjjeBZDZrHaVL3vQCeHwFCtyTNVO7U5d9yV+BSm+RZzcYzlXHe9mU7F6BG/f?=
 =?us-ascii?Q?MRH/j9gm6pXSqEi28fPPRJsH75fqsNyyJ0niICSLxIRsBB+E/noRhcoi5GiW?=
 =?us-ascii?Q?zY87Vy0vATMS6bIF3Tozko0v1R3TrizoCMVif+4hczrxlON7o11uw6H89jXV?=
 =?us-ascii?Q?VoZa1KSoyDY1ffaM3+aPS/CRsmA6lR4ZFKdlTr2/xe8gOZXPvawNhotcADkm?=
 =?us-ascii?Q?evUiGeW6znhirh9yJ10ml5HhWedZ/YA29J3FvbzonRz15pgiTZmb4QrShHAY?=
 =?us-ascii?Q?L43ew/zfwtILemfLI2tVUwUTWhz/QOJwljatY60isjk85VC6bGON2lyog+nZ?=
 =?us-ascii?Q?tbWFPhISZNhTecJZGzsqgEVrLKqGUSATdpKg9gKV1Z6rjiTRMy3OdCuHQqR5?=
 =?us-ascii?Q?zErVbQwa1krVolJWNzrl2mWc15HrLCrStapttzFrI91073KyC825qBak4UcX?=
 =?us-ascii?Q?omf8kL1uOAcW8zAHAHPVYDJb0gLQxnGPLIoYL0kkfQYSuQ6f+jrmb37BKcMP?=
 =?us-ascii?Q?Xyna2sZYXw=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d21d48eb-8269-4bb9-328d-08da32990a5d
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 May 2022 15:23:31.3017
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 8MsOCAssO5PH2fj2sl5glfreOBl9QF/xGVSBLqqWKhyAeTF6i2bmUOLLZ4Mqb2Yj
X-MS-Exchange-Transport-CrossTenantHeadersStamped: SA0PR12MB4510
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

On Tue, May 10, 2022 at 02:17:34PM +0800, Lu Baolu wrote:

> +/**
> + * iommu_sva_bind_device() - Bind a process address space to a device
> + * @dev: the device
> + * @mm: the mm to bind, caller must hold a reference to mm_users
> + * @drvdata: opaque data pointer to pass to bind callback
> + *
> + * Create a bond between device and address space, allowing the device to access
> + * the mm using the returned PASID. If a bond already exists between @device and
> + * @mm, it is returned and an additional reference is taken. Caller must call
> + * iommu_sva_unbind_device() to release each reference.
> + *
> + * iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) must be called first, to
> + * initialize the required SVA features.
> + *
> + * On error, returns an ERR_PTR value.
> + */
> +struct iommu_sva *
> +iommu_sva_bind_device(struct device *dev, struct mm_struct *mm, void *drvdata)
> +{
> +	int ret = -EINVAL;
> +	struct iommu_sva *handle;
> +	struct iommu_domain *domain;
> +
> +	/*
> +	 * TODO: Remove the drvdata parameter after kernel PASID support is
> +	 * enabled for the idxd driver.
> +	 */
> +	if (drvdata)
> +		return ERR_PTR(-EOPNOTSUPP);

Why is this being left behind? Clean up the callers too please.

> +	/* Allocate mm->pasid if necessary. */
> +	ret = iommu_sva_alloc_pasid(mm, 1, (1U << dev->iommu->pasid_bits) - 1);
> +	if (ret)
> +		return ERR_PTR(ret);
> +
> +	mutex_lock(&iommu_sva_lock);
> +	/* Search for an existing bond. */
> +	handle = xa_load(&dev->iommu->sva_bonds, mm->pasid);
> +	if (handle) {
> +		refcount_inc(&handle->users);
> +		goto out_success;
> +	}

How can there be an existing bond?

dev->iommu is per-device

The device_group_immutable_singleton() insists on a single device
group

Basically 'sva_bonds' is the same thing as the group->pasid_array.

Assuming we leave room for multi-device groups this logic should just
be

	group = iommu_group_get(dev);
	if (!group)
		return -ENODEV;

	mutex_lock(&group->mutex);
	domain = xa_load(&group->pasid_array, mm->pasid);
	if (!domain || domain->type != IOMMU_DOMAIN_SVA || domain->mm != mm)
		domain = iommu_sva_alloc_domain(dev, mm);

?

And stick the refcount in the sva_domain

Also, given the current arrangement it might make sense to have a
struct iommu_domain_sva given that no driver is wrappering this in
something else.

Jason
