Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2683C46D45E
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:23:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232825AbhLHN0c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:26:32 -0500
Received: from mail-bn8nam12on2074.outbound.protection.outlook.com ([40.107.237.74]:38816
        "EHLO NAM12-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S229747AbhLHN0b (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:26:31 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=m2fnPjAr52E9+CFbS7bUMLJ39Ao+UbF/ffXQpavhW2+K8+McIcRC/LS9CYQRjDh8yY0pRY+tTAr3Cnb6a6XBjaAb+HxXdfhjt59758Jz/oJeka1ZSFZWdcM5AQpTdsAEbuwjAAtNUeHJHupVoKeDSJT1DcZcANzbAV4P2A6HzAsa+w+OGh0697TlLPD0NFxFQ7FG89ExopQ9tDVXEc4ft0gkt8GsV579URECxa3RuAL3LnmTxO+ZELUDNVJ7prF+cf1eCMEYpnnoJK3UBXt38lE8GWzO99OirYUdIcMrz7nXxT14GWuey/s7sfoAG9vT6XNAoRgt4veV+2y4SEgszA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=JRH4IUntJZEcnLX5Fr7h7KJOBCaze0wvpnH+8p8+OWY=;
 b=bkclbGc+ZDNddeo7eef+eSWRa3mbbQgQCe3MIXvx6xmj9aEjscQ68joLYVD42UkfXISkyFWK/757nwHJ9abHTj94OUE1Bsl7LC32KydZTKnOtBAAn3oEQVTS0bIrrgaeXrATzhV65jrW1DcW/SfCIHUb97t/3hOX6QSlWQXnamYdXBvDbnQEtWrhmUZzwranq+l5ErK24il2VbyDmiZ8Ml3fzcZCSN/RIANx2tj9d9lrZIE2x1OOtzDBdA23s/IqACuLAZDCPNGlK2K/WlEqgGcUgorl8UGK0G4sdZ2xDHzFLWG9WAZpTBjJ9nEBzONbXpGq/DnpQ4w0cPjNvm7TtA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=JRH4IUntJZEcnLX5Fr7h7KJOBCaze0wvpnH+8p8+OWY=;
 b=NIYGI0zof8WdH5IBR07NxaEGFyw3L/DtV+1zI4Kj++r91Eu2h+gjHkStNYFHVxZL8RxuGHPrzMUpU6lYsLtUluLt3RkIIT3wI6mgLqCN7Y8BSFBDp1XAFuKdpr/B54GFBSt1xfgZKrQLhSsIT060cM82Um66a4Cbt26NOGWn3dVttpJ66UEDP50JT7Mi+tCa1rt76++8SC2snBVCSm4bPvEN3omOyPsO9SO/ZWQ0gGN/nYY0zWSvPipruu+wpl8DOvYVZyODZOxGPJbgPa6jJ+TKLcrbywaxFh5oUb0BrJ4GXJuWpqpBuDOjIKPvyXZLfizp9ClSCWnxhLdxYSrAAA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5030.namprd12.prod.outlook.com (2603:10b6:208:313::19) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 13:22:57 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 13:22:57 +0000
Date:   Wed, 8 Dec 2021 09:22:55 -0400
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
Subject: Re: [PATCH 3/4] iommu/vt-d: Support PASID DMA for in-kernel usage
Message-ID: <20211208132255.GS6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-4-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638884834-83028-4-git-send-email-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: YT1PR01CA0125.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:2c::34) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 0a140503-8dce-483a-e29b-08d9ba4dd992
X-MS-TrafficTypeDiagnostic: BL1PR12MB5030:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5030F71F7F40A788F1574972C26F9@BL1PR12MB5030.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: A95oQlIg7j9eSTJTBdPukHb8KPK7BDaEEwWiyhdrqmjeV79IEgmRLQerkk6OzmFe2XMLMTl8lHWzlT2KqLMbTH9kCXLfD6Fp7NsFNUTYQRWc056b8eFgu6KVUEI7B/bSaYF6XDuNna+F4n9ZwU+/RDKWxs+F32R6U+VwyVyC5/isKPVyZYGF4BOM6BcchjG+vs/OqNdyy1yh/Q1JwvPST+cRd6sY1LfwAtw/YaEzb5/MEp3qKXdlsk4Xze0cUYSC8nN6fQESsHb1Q+rGoLAZxf0cwWAlHI685os8uUrR5bTA1JELQHSnqAQT2jelHftc2ch7D2p3TEsYgVs6Vw+wdhaM0/kajgwjSsezFi0IJA45v2np/N39ywukmqMmKl+5X/po4t/3qIUgDADFNFFqWglz+ICTyEiSrY+9DvTLfX6mF2Dgvcb+Xcc7NSEqFTKH0n+8VKupCeHrrTrCEA9Bo+62CRhZFuLKPvLUShYAmwNFSBLsIHvvOXK1HE0lnLZ5d06HbBFDUJpCHIcRstaWYla0tEm0xIS4B89SwTIE5EL86uKfgdRw00jK1S6QSa/5w4sDtuMfj+iRiGlfvPVXXX8Gq97luzkapzC+/kUqx52GzOjjJ194F+4Llvjdo/lHvpIFsI3oMmgVYq7dftn/bg==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(8676002)(6916009)(8936002)(38100700002)(83380400001)(86362001)(2906002)(54906003)(316002)(5660300002)(6512007)(4326008)(2616005)(36756003)(26005)(186003)(66946007)(1076003)(33656002)(66476007)(7416002)(508600001)(6506007)(66556008)(6486002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?QLah0oL6u0MA67ZpIg7gZfEEIYVF9oparFwHAoaDYxa/wiMcCqKTTCZ32Kfq?=
 =?us-ascii?Q?Jr/jCxI1M9y/2C2CuINHhgDYDKmB70DspP/j5fayeM30L+KouyNfWVw9r6Sw?=
 =?us-ascii?Q?ygtUAxlIT1j0XXDQB8IH+tB4K9otoQpoAG8g/kpan5TAoWGqhQJzBPA/hxcG?=
 =?us-ascii?Q?WbpFGgA28/xHB8JTN+l2L7BhLmgVPsdIwBECuHLWh8x/Mu4m+6WLbqiATegw?=
 =?us-ascii?Q?mCt8/xrJQ3SsQBjDxDhk2d7hG6xzvtz+utYnlg2GdE1IsiU5WZjipFAJ5L3o?=
 =?us-ascii?Q?30F1in0Sp5axCKZgdaHlIj87DxpTeqLJr5m10O1d/YP3vPD4HnvlOhSE8NvI?=
 =?us-ascii?Q?B84d2WK17w/vCmz0QYcJ+GHvrMdGBljr5JQkCMWFM0uKkM4xY266DRSNMm22?=
 =?us-ascii?Q?L/wY61xmnIBqmeSZiLULCPVgSxAOfxmb6RteCVVs9cr//Xbv4cWwhaSPxOgE?=
 =?us-ascii?Q?u/Xz2t54vZS7r584Tk1ExiCvT2TtRDjOOXz591e5c8Rc5mtABLs6F0uiybnY?=
 =?us-ascii?Q?wmg8gkytpWxUpDh3zEvf2uEIg+Zws8St+SAUU9hXWYtRNkRa98NWhP12EUMX?=
 =?us-ascii?Q?QDHUeUm8lm/zt3NRtW1Aqdbr1MgENSMZnvQAC0PWU+MpPuh8DlVlR1+e/f9i?=
 =?us-ascii?Q?QiRc2kbfu7V78YTh7MACGKAKtFTxRsoAMfWXB9Ypatn4UZxyqRwmF0XRk4+J?=
 =?us-ascii?Q?SJlfjziiV3hSsBxPYlveIPAU0GR94CyiJjqSi4kMBGXyOcQ71OZ6tdSErbMR?=
 =?us-ascii?Q?FUtptlkYVbI9aNCZTFolOBMH093Zyv8x+Ewy6h6P9IWoRkMFNDMlmOu+iZRb?=
 =?us-ascii?Q?S1NQYucvrdYkrX4pUofwRdGGR1BuSsIc/T3688M/PQHR9ITM0+vXEJ0Ilebr?=
 =?us-ascii?Q?yYNjtpydYYueB2xLFd4KDo4zKLFnu54u3NnPV79Uqyjih/CodWizzckU2vIv?=
 =?us-ascii?Q?t4Ddya4CQ1SzTyxVFFY7UVl+pUtAaeuV7xHnrxBgKP6xyeF/YQuJjL58EGJw?=
 =?us-ascii?Q?8bXcpFLg21oNUiwk81/m5z6/G4YqU+Z8M/QPT+cmu1qaPzh8Olso7dGQTCFb?=
 =?us-ascii?Q?qVrR4kmqSi7J43t52cxl4SMs1wemyn59ytsotZMLGRcUcbgCscZrDGs8lWYz?=
 =?us-ascii?Q?UZBZD83xIRdH5L6EFNq8WH5hsUDCWL4BVVplUaJE3w79Nt+OkLcynJcPInBi?=
 =?us-ascii?Q?qqW+zMsjUMUJm6TsfOExb7ceFe2XuumvLYzP7cwstNbnMNEkUfdH6yKewl7r?=
 =?us-ascii?Q?J9PTiE/Jpqadp5QqZJc1BJyoe8X/55n1lqYi4/LL6nxG4LYqvOCSXD1jLF3H?=
 =?us-ascii?Q?TAUysJ698UcD7YNqtnZrNIFWQGRX1XV2y0HlWz1AgC6sJ0t43rKfIf5GcSdp?=
 =?us-ascii?Q?TmJXWgCGsd4LuIK0r8Gp9ddv7YHrz3pf/uAEcPdHEl6miOC8kSkfR/5ip/XC?=
 =?us-ascii?Q?xc/0vdslMRcLtWxdZRbgvRYsw9WDwz5pslb/RPleoJZLaWlsQq8PmTk32fVH?=
 =?us-ascii?Q?C6SEodcdipw4b7KQ7ltcb5oU00pNiJKQ/OsJOhzCeDhmypqS84Fv7yMK9rUC?=
 =?us-ascii?Q?FxXh5TTuowEpyvRJOVI=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 0a140503-8dce-483a-e29b-08d9ba4dd992
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 13:22:57.6584
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: MeKC5+BaWUUkCYV8XkTv0E3zQr8mCf1GlwgkTF5HIu52VvmU8X2Tq79hPfN5LOYV
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5030
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:47:13AM -0800, Jacob Pan wrote:
> Between DMA requests with and without PASID (legacy), DMA mapping APIs
> are used indiscriminately on a device. Therefore, we should always match
> the addressing mode of the legacy DMA when enabling kernel PASID.
> 
> This patch adds support for VT-d driver where the kernel PASID is
> programmed to match RIDPASID. i.e. if the device is in pass-through, the
> kernel PASID is also in pass-through; if the device is in IOVA mode, the
> kernel PASID will also be using the same IOVA space.
> 
> There is additional handling for IOTLB and device TLB flush w.r.t. the
> kernel PASID. On VT-d, PASID-selective IOTLB flush is also on a
> per-domain basis; whereas device TLB flush is per device. Note that
> IOTLBs are used even when devices are in pass-through mode. ATS is
> enabled device-wide, but the device drivers can choose to manage ATS at
> per PASID level whenever control is available.
> 
> Signed-off-by: Jacob Pan <jacob.jun.pan@linux.intel.com>
>  drivers/iommu/intel/iommu.c | 105 +++++++++++++++++++++++++++++++++++-
>  drivers/iommu/intel/pasid.c |   7 +++
>  include/linux/intel-iommu.h |   3 +-
>  3 files changed, 113 insertions(+), 2 deletions(-)
> 
> diff --git a/drivers/iommu/intel/iommu.c b/drivers/iommu/intel/iommu.c
> index 60253bc436bb..a2ef6b9e4bfc 100644
> +++ b/drivers/iommu/intel/iommu.c
> @@ -1743,7 +1743,14 @@ static void domain_flush_piotlb(struct intel_iommu *iommu,
>  	if (domain->default_pasid)
>  		qi_flush_piotlb(iommu, did, domain->default_pasid,
>  				addr, npages, ih);
> -
> +	if (domain->kernel_pasid && !domain_type_is_si(domain)) {
> +		/*
> +		 * REVISIT: we only do PASID IOTLB inval for FL, we could have SL
> +		 * for PASID in the future such as vIOMMU PT. this doesn't get hit.
> +		 */
> +		qi_flush_piotlb(iommu, did, domain->kernel_pasid,
> +				addr, npages, ih);
> +	}
>  	if (!list_empty(&domain->devices))
>  		qi_flush_piotlb(iommu, did, PASID_RID2PASID, addr, npages, ih);
>  }
> @@ -5695,6 +5702,100 @@ static void intel_iommu_iotlb_sync_map(struct iommu_domain *domain,
>  	}
>  }
>  
> +static int intel_enable_pasid_dma(struct device *dev, u32 pasid)
> +{

This seems like completely the wrong kind of op.

At the level of the iommu driver things should be iommu_domain centric

The op should be

int attach_dev_pasid(struct iommu_domain *domain, struct device *dev, ioasid_t pasid)

Where 'dev' purpose is to provide the RID

The iommu_domain passed in should be the 'default domain' ie the table
used for on-demand mapping, or the passthrough page table.

> +	struct intel_iommu *iommu = device_to_iommu(dev, NULL, NULL);
> +	struct device_domain_info *info;

I don't even want to know why an iommu driver is tracking its own
per-device state. That seems like completely wrong layering.

Jason
