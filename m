Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C35A846D42A
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:14:08 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234136AbhLHNRh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:17:37 -0500
Received: from mail-mw2nam08on2076.outbound.protection.outlook.com ([40.107.101.76]:59547
        "EHLO NAM04-MW2-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230001AbhLHNRe (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:17:34 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RkH/oxIL+moDRbVacd6Hb85f9YPIuR5kojeDP/gFaUftSZrbCu4WAqqCHV1XLoCxAv4b9mGEtuw3LS7z/RSymMeGblA0d34HYnFHIKxyIvaH9IiNV22AAac/IAJZ49mpJRG+VgeWjqgPdzw8j5NxfU0y+JkCZO0Wdt24wVvgex08Xiz6RMUuJHzVxIunGk0xARKOh59yucZqxGTm9W7vfXjfeJFoGPne2lG6Ra1pp7uxCcaWuh9i7gub38kRFfbkVEcm/3KM3dNLFEq7AhTEj2j+M4pJbLMZeW7EQokTJDt7wmC9+mi0evzvIEH8NxALxdSfO9tXgYEzpx2MOEXaUQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KDKi3j/1QrirE6QiKRp8rZAnNCq0E141dTesSNEeytM=;
 b=NNNOQ+aMFxxLZgAFip96COn4IbfpZuAaD+6GF8GIZXjR6zp0is2DeHweY6bR4Famv0mgh3gDG0Op3J/pP6v8ycYhsR6yzAjfASrvEEf3J+/0P3YwRE2z82omv8ZRahNYN6c0vvFzWCJAGHJuuuezl8FrqJcxW3cUH6PtmIjzEM0p+t8wrHor9utqANXE/IzsexXM61Ur5SallBlyi9xFbwdPiIHGHDiM6JPo5oE4JwtSepioY4trmNTDL6RxWioVnm1onnBq5zgN6wDzupTq4m93cvRiBjuiXx2tapgfZuk4v9GoUk1uAqJlKEIpbpuWCTEyfNZvIsQ3Oj0YWrsUHQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KDKi3j/1QrirE6QiKRp8rZAnNCq0E141dTesSNEeytM=;
 b=QKrUhWMR0SdX8cB3C1WKUVyultMAKpirDl+vmW4M4IIBX2Hvfxdt2yn4arXEON1717apLiCQe6racmEFJKj4WeXu0uxVO6hfdIzRjBZtPsEGbWHkNX349XzO6+wAfRkMkp/QRxMtca9P9mOVU38iblFG7E3dpzeiRqHWJ2Xujzjrl1y8B8wJFGyMpRbYOMjuFs37abSZh/Rp4oPs28ZQQkS4/MOqhUFY46mQ3faD0qPC6SaLQSM9CXOQ5+HzCTox6k3HEuz/uh0cm084OBZDkpnL6JUObwMkSNlxTloE6rdER2hNbXVVJHvEAxeOt1ijMifGglPpR2HNE3464qaUfg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5064.namprd12.prod.outlook.com (2603:10b6:208:30a::16) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.28; Wed, 8 Dec
 2021 13:14:00 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 13:14:00 +0000
Date:   Wed, 8 Dec 2021 09:13:58 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Message-ID: <20211208131358.GR6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: YT3PR01CA0019.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:86::33) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 833c1d84-671d-4834-3165-08d9ba4c994a
X-MS-TrafficTypeDiagnostic: BL1PR12MB5064:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5064B82E332612D493813D53C26F9@BL1PR12MB5064.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: OB7yS5p0o/dntEtHItptgDUfnP4A1LtK9G3voppBYb621glMdC6kYFXcPH5YSF3/ggw1TWjBimJ6NGZOEsrnItalwP5T0NDbD4hB970OcbqrfeGj7zVxBZO2ShZtTZ3bcXadzcr4Q/OrcXsppid9jQUFUYCEPq3D37FAr3qQdYMCtL1E6AcebQ+qaFuehGh8pj7SqGhshCRG5VSOZ0p9ZLE6Z0+CMuFlGb8OQ3+2OROl8U6333SuVY0jtdEtDF8xUkVbVQs3yx2rS/+JK6/8akPgx66lPlPBLjzaVUrn1K8WLy7ETg5gKVOoiq2uNbAgYPhLrLvAvufM1aAULeaOhrDs5ZV81GJnbsh+vGv0NzS/TGY/4nsxG0fzS88BjTiBANTg+ZXECUcmEMXTkzO+tLx8PlZ45PIsKJ2c2Uzmw3jVGEGBq01BUMOcrRPmMJWfGN2L1FG1kvKd7dpkeQnvLJwcWBqN4+UuFGXLimXsa92Mf3oGw3uOMthG6DBEvlsY8F6GGYRgrM9pM+pC8vzRoNhZBXoAhlvq9CJxZmSk0sGqREXGHPQU4wrS9/t8ZwKh6AFtT/evwwROZo51axa3OOlR+9s0qBwuYZpU4gYUpXFtbB2LgjfhNdoH3764tS57VSNHxKELcDZAHhWL7dpQrw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(36756003)(6486002)(66476007)(6916009)(2906002)(5660300002)(508600001)(6506007)(26005)(1076003)(66556008)(38100700002)(66946007)(7416002)(33656002)(54906003)(316002)(4326008)(83380400001)(86362001)(2616005)(8936002)(6512007)(8676002)(186003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?L3+3FX8MG/nmYC4Qdit6bkytkd+/apbZVzz16sJd8uYVZLGvmMJNabQeXUqq?=
 =?us-ascii?Q?CFuU+ZjNTA1MScoVf8HSn0IWurUzSJvthLc5Aysv4bM64rWz25GYCasgA3oR?=
 =?us-ascii?Q?6ZsUwycU4FII6xkjKM5Fxu3nj9Ou/KIirMwitJf8l80N1cYlWaoQxA0O46RB?=
 =?us-ascii?Q?u/ENQyzPsbbwkjyFqsiiFENQpZqLoXp0LcJtaV8uuTFRFM+A/rkxCk+CDpae?=
 =?us-ascii?Q?JXvEsB2X+SR59TWrpIKoR2bZpWWfPjmym+B4kPhsD4Ti002Zlp1ZcIvYxwqG?=
 =?us-ascii?Q?G7jD5WuptjdB7Xs4Jhj+W4eWIS90GwIZzLJsopd8PFV5s43ogqWjTl0O+ims?=
 =?us-ascii?Q?ymJUU/2PKMSk8LyWnESTJ8Hs4Q+M716DhydglUEl1UiX1/300Rh1p/bBWYMN?=
 =?us-ascii?Q?soFBS14RHdl/HMQa2NqwHBtosC4+Ebl4Tb+aG0ym3/z1uBsrtstsPjTfByit?=
 =?us-ascii?Q?vFMWkXT2nZ5piOOs1uTiPft5luK96Vk2mm1MQdGl4NDC5oF0aVmqGHIz11ZY?=
 =?us-ascii?Q?QQx8JlPtviRfaJzEbxmCQ5JcrrzLbgTM7OmSr/I/g2W7UtZTRsh7cRa+neJn?=
 =?us-ascii?Q?FpOjv7mmZJ/vPuQPlD6vJYZ/fvC0Wd49YkRjZXTFZtWJ0quPL4UEHKrnnNzY?=
 =?us-ascii?Q?cU51KxY8E+A4pAV8OU4+ndgFt8/YtR1bViqLp0sVsL+5HobNeMJJPqezQZYj?=
 =?us-ascii?Q?rtOcWB0sQhyNF3iVhZRi8uZQr2DlLzGN/O1QS7qrMMDj53Qjyfqp67Cd1hc5?=
 =?us-ascii?Q?SxWxp0t6+TMbQx/MemxtziYx5LG8Ajixn/8slAp4L4NLgaDe+1l5xoquBGXj?=
 =?us-ascii?Q?bVW2nT8NqNGr4//NpF99U9UQq0/OkweWmMhW+pq9V3LvjpW6tSBMzQGRAMM7?=
 =?us-ascii?Q?LBnlVfVUeo0nFWMC0IIXpSS2eASCzEZy0SSGidnz14rC1ljkq+dl6dao+UHP?=
 =?us-ascii?Q?lC50GMn2fxdDa4hh9tK0IZczeaoupBF0xxckIgRVK7MaXVuvbTZKcFJ8MBr1?=
 =?us-ascii?Q?qSDv6ZFJdouE5+C2Wj0HELylRHTdijEYU2I415j1jxule+y6XrQSD+d5b0ZV?=
 =?us-ascii?Q?wxrZu/sEKEV0AvkCbfGMT7/hQUFfwW3gEsOlULNrC6+SnEBuvt0DCu2quAqF?=
 =?us-ascii?Q?8AFIRFggOu9IltKFEiib0gZw6z7fU9Wat2uM1LE5blkwCbtqEmCOlBx0kTbV?=
 =?us-ascii?Q?cqQpibZjbZb6FfNq+aDZowk5zXQAk+fc/r8OKc8cuImRmAEe4NZVziXxeHDl?=
 =?us-ascii?Q?X3gXJo/dPt+fHCXptnjUXSPXPbhzN95Q/T7AmhK+gBQkeRifHglXsGaAq8H2?=
 =?us-ascii?Q?BuO6dfrS2DmxKASsnIT/XDrKTNGoRkIQ/7XA1tESpUq97mZwfe5Ji6W1jkmT?=
 =?us-ascii?Q?4YJT4ngqiTvNdEI+/a/4ZDtqrQHEjXfnoXyvNvJPn+Z8SwlU1xdlV2M/nj6D?=
 =?us-ascii?Q?vjOeIFH6pX4SQElWlObqSftLTck6V8+nsnTY0i1HXIBsuvbd0awPNlwQEwuu?=
 =?us-ascii?Q?waBtdxa+QiVlFd+tD/5k2LKEtng/YArvDIwj8s5v3kUnl2fPD3vF8DUwrsG4?=
 =?us-ascii?Q?fD0a4gHrJUXWztdWFhU=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 833c1d84-671d-4834-3165-08d9ba4c994a
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 13:14:00.4493
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: eEgU7R2yuRPSU+s831g0ipC53TPxyhw4fhx4pMNs1dmVUlNlxTAkUQ1+Ncr+cXPI
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5064
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:47:14AM -0800, Jacob Pan wrote:
> In-kernel DMA should be managed by DMA mapping API. The existing kernel
> PASID support is based on the SVA machinery in SVA lib that is intended
> for user process SVA. The binding between a kernel PASID and kernel
> mapping has many flaws. See discussions in the link below.
> 
> This patch utilizes iommu_enable_pasid_dma() to enable DSA to perform DMA
> requests with PASID under the same mapping managed by DMA mapping API.
> In addition, SVA-related bits for kernel DMA are removed. As a result,
> DSA users shall use DMA mapping API to obtain DMA handles instead of
> using kernel virtual addresses.

Er, shouldn't this be adding dma_map/etc type calls?

You can't really say a driver is using the DMA API without actually
calling the DMA API..

> +	/*
> +	 * Try to enable both in-kernel and user DMA request with PASID.
> +	 * PASID is supported unless both user and kernel PASID are
> +	 * supported. Do not fail probe here in that idxd can still be
> +	 * used w/o PASID or IOMMU.
> +	 */
> +	if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) ||
> +		idxd_enable_system_pasid(idxd)) {
> +		dev_warn(dev, "Failed to enable PASID\n");
> +	} else {
> +		set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
>  	}

Huh? How can the driver keep going if PASID isn't supported? I thought
the whole point of this was because the device cannot do DMA without
PASID at all?

Jason
