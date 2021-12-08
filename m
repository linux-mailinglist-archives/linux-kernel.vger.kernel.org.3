Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7746F46DA61
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 18:51:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238203AbhLHRyy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 12:54:54 -0500
Received: from mail-co1nam11on2047.outbound.protection.outlook.com ([40.107.220.47]:16746
        "EHLO NAM11-CO1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S232466AbhLHRyw (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 12:54:52 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=azVo+vNJ/WkVJGC+texnq58BdUyl3GCuA8evon67LA8a27LGNwqa6F6TUj7A4Sm2IjPy/SfHNzWDTViYFKBhTbKyjMKWU1pSuXVblotT5RIX5iQxc1HlX1u7pGC/Sy2dXDtO+CXly00n1CQMEuxknJGbrwBgf3Bb6U2QQEiqshjSPfsmlsXKLhqt4/syPlLYzOGREnT5jalwJmEZfTC4QNT9s2DKOfNCeHrIkHld6Z9wzIKFWYC7gW4WmDAYvwL0MABHUGRw+eUOyR0Rsir+Pr8xZzGZorEcrNXGKyzaht8CDaZ/iFMEwX7SjKo8CqGrYJCnlI41RcqpImiAAtxTYQ==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=AcoXZVN1GzJwfaF2X2LeCroFTPijQTAoz/lUQ1Uq0IM=;
 b=O+UxfVzzQRrHxsI4dJPdqc52ftMV2+qyaZZn/2sNULYrg1f5u0ASDeCeBRut1AfJngPsq1D7L0AsX2CO6uwZ6U0WQw/z6h+WCcd44PNLF2zh6ld5Zbjv4i6KE9KPPY0E5Gln5DFKhb8hLB87Pr3+2Ww/YezTfY7Pa+g0RTWrpVMCeS9cc4eDgL7PaSeA07I7vf6GwX6ffpj8Fz5wjzBinUWMscwwzDl6b00Ym+kj40nSTGHJO+SPuyIch74jiKV6RQjDjIWRIFS3xrzSW5EHnTP9jBAhl5m7K53oV/KsoanoxARFwPzNWvkvK5/P+MZv53pqHiMp69aD0ee3oR29ew==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=AcoXZVN1GzJwfaF2X2LeCroFTPijQTAoz/lUQ1Uq0IM=;
 b=HafHtItNTEUOt9w+pnwJ4TTC+hsGpoKi0BEOcN+deKnzZbtADd+NdgBFClsOua69jT0XTwmIj4oeVHHk4voERDKBJkScjhT1IUY3iQ5JpXni/7TroUcpWnTiUKg9fmyQBZCGiaWQbX5fzw2ZdYberKU1AiYvHu3lKlR/xkvp9NEnwSkQB00JdOuMfP0HfNVvIDo4Vi7dUQL8Y1OJjUrsbroZCp1W+WzkeZh9g1csUwSBgKdWtAVJyCz5gVbLIG48/sBCn3cS2ePbcT3Vq47eW3amEcKMZ4IvpbKM6rzRicjsySKYlIDNU3j6U3A0OF8jg0ubBvds4Wu0rNHfeGU/kA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5336.namprd12.prod.outlook.com (2603:10b6:208:314::8) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.12; Wed, 8 Dec
 2021 17:51:18 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 17:51:18 +0000
Date:   Wed, 8 Dec 2021 13:51:16 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Dave Jiang <dave.jiang@intel.com>
Cc:     Jacob Pan <jacob.jun.pan@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 4/4] dmaengine: idxd: Use DMA API for in-kernel DMA with
 PASID
Message-ID: <20211208175116.GC6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-5-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208131358.GR6385@nvidia.com>
 <1ffc1366-2711-3026-fb09-8f60a260f618@intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1ffc1366-2711-3026-fb09-8f60a260f618@intel.com>
X-ClientProxiedBy: CH2PR15CA0005.namprd15.prod.outlook.com
 (2603:10b6:610:51::15) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 9617ea28-1522-49d4-8518-08d9ba735635
X-MS-TrafficTypeDiagnostic: BL1PR12MB5336:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB533660BCA95CF7864670343AC26F9@BL1PR12MB5336.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: C1W6GhMhjGwzl7C0LjPgou4Ozl59sfma4a8ZeeQZEJ/N8pQw/Ee9CwK5Kh7BM4tnxkR4erhJFM0P6jDhVwdqb6OxOOID4ddeIjwuAh6IOApVCf5KXBbBVeZu1dMH2AdEqT62BFv5Vdu+eoLxTgIrSn/d9skVLGDvC2S2f2Bl+mD7l463h2H2VAhGpp/RgF2mpBrwXC8N86NT1TY1brGj4igRYHCYyPUZoIm65a1TeYBXf58TiI6DfQoRyH2VyFvVJUD458tW3GHRAeUA2MxJpMswiVqn6/5dCSLE1t7kQQvxtRiFq9oX7JLFNFuG8eCem5Bh8nVF2grbSY6pqyMyf1kQEaI46dHG83aPO6RvEWzfR3vBDH7/f3vf+6LeJ62G1O2sx0OXaoQuD/NJxra8oFrfn9hrsSqCGuix2yxmMHESYrJZBIFJol7rAxa+oGsSOEA5ODkf1IlEFBNNhBkNxm7fNrf51p9pRyHYKbNcGp0OLFYbQ9IQRWXtdDSCE07rOVobmOLZ7ncHrjsGhScZC41zbeGAzWM2/B4SXngtN/Rq9/uarBRsFhe4t7fUl/9wtmttHtYSw0pXbexgwdEdEaVn6OMK1P5V7fhO9rDesr64PJDY9/wJb8Dv8izQJSYDTxtCh1r9Khl7K9aUaZrBOA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(33656002)(66946007)(26005)(186003)(36756003)(7416002)(508600001)(66476007)(4326008)(6512007)(1076003)(6486002)(53546011)(2616005)(6506007)(66556008)(38100700002)(86362001)(2906002)(83380400001)(8676002)(8936002)(316002)(5660300002)(54906003)(6916009);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?tquEXPVtHOoGaWfsp/SqoLypE6AaUI9Z+5xT0cbSFrsKVery93oC3TF/h27d?=
 =?us-ascii?Q?5fM2JCI2g6Qym1yIHtHGLuVMs+8Jn0d1oD9lPkEyHWVh/MBA9F13HeX+9M0G?=
 =?us-ascii?Q?Js2B3Z9K7s1hISQgvu9uPcqoHJ/MSkvzEa1nOxRCPvNkiZlyVfO8nwZrfk2E?=
 =?us-ascii?Q?Z8EoyRUN6Nqh6pDNn7+UGVOgSjBkXG2GSHw2hwDXuvUxTlIHW7RsOvxp8QbW?=
 =?us-ascii?Q?woNMDdDSeXUR+zKYWiboITF64lNiSHY6fD7Lq0DlGt9iy/h9G+t20Na2KGBs?=
 =?us-ascii?Q?56WaKH45aVN44wYcGhSJl0uOucnAwOymMLf8F372NvKA+r8tjfStf6V/DPIy?=
 =?us-ascii?Q?jMwwji2zpBAHMrid73/b9Umk+jK/jGvUKIDVhBWNvdNofBF1hNpduGZ2h1AL?=
 =?us-ascii?Q?2G9uFkhQRSXD9o3DW6yxNCX2L4NMk9Q2YCI5RuSICdIMxK9DEkGsGrSmgTvd?=
 =?us-ascii?Q?OoBuCyMZKe5mVR54AOns7wpBwDnScrp7Qd7HjJgm5SQBUP8UPEZbrQQqiU3/?=
 =?us-ascii?Q?f36vPxjW0F4IfbvLgPDarIL9QBCY+Qu1aoLBpnENIMaC3n/5PHYCWf8NmQS5?=
 =?us-ascii?Q?w5Rh8vLn+Bq1hOtkUbYTvxFlMtPtcP9s5XVHPUePIMs/kvGJaEbjV9GML6rI?=
 =?us-ascii?Q?YicE26N66fE+HIEHBCXknSxQT1bvzkXHhiskMF3zoIlk8yBJsiUMH5XoMEo9?=
 =?us-ascii?Q?Vx73t+deg8VLnwIMdWkoduO1yuOTdUVnGKXvIUvqaad38UCM+TDPqlvqwS8H?=
 =?us-ascii?Q?SBkhsG4XYAJnTUBHiGlMT1aGriWDYxJtjGsCG3vxS5fXBVz/1IkKoCbPpNmu?=
 =?us-ascii?Q?waYRFgKWgL0YE7i/N8g7egqkDXtHEcVO+vEyZ2Ty558lDWK8E2YN22FTLrTW?=
 =?us-ascii?Q?42Mi6mvlNXtG03TEDXvtZbTG1buWuhlAgJzWpGod0Qn0yZ8vUGjDI3KTuz/a?=
 =?us-ascii?Q?5cz8E64L5SDFP0w4MulMmjtHF4MTil8HEzw7GOVwN/PKpBp7j3f5Err9ZPzj?=
 =?us-ascii?Q?Srzjfw7uraiU4vDxzlAc7mgl1z5rN/BKfoWj3Na/+4nnSPTJdInKAa7cJBjA?=
 =?us-ascii?Q?12k0yxn0qWG/z08NT7EFxUjco2/vaCxh7lvVu5IwIID/NY6N2Pw9vVrv1OU5?=
 =?us-ascii?Q?705p+NeQFQChWaZ4/V30Hgo6qRNdCYWqPR8O+icNtuuPf3lo3Rza+ePrT46C?=
 =?us-ascii?Q?bAy11AgObt6quZmGf/JEju0ZM6GQxx2epJ+W4byEXA8eW/7M0prUXgFDPWXY?=
 =?us-ascii?Q?k1r2gDlF0cb3uopeRgr3izbRqon44D1isduXIppsB7V7Xb700JowZW4pWgin?=
 =?us-ascii?Q?Zr91KTkfxTKrwFsvu691jVSNRKUqmQZr4zH7ps4EXfcuoUQT3GtLTZx/cHH1?=
 =?us-ascii?Q?J0etg6XenWTQGK/N1qMBI6Cp3y7ZOfZkysrsmPXQpP7tlm5Arg+0kPrHJ3a6?=
 =?us-ascii?Q?3VoI15eN2LJkOmsoL6rU5mwRr1Jf6dvRYTyNQCOdKyPDvCFo7NO8XG6P1Var?=
 =?us-ascii?Q?UyuWIiJm1QjYsARqUgifh+guqBLja0AAoCAfJd2+N4MHj5+cLb5aLjDoYd5C?=
 =?us-ascii?Q?G7/cEE6fgtmEfZqBxpQ=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 9617ea28-1522-49d4-8518-08d9ba735635
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 17:51:18.1551
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 3tN4LhEhi5/6la29eR+fpdqdTNHzGZv0dkKvPju1jFPeNgagGUMysh+aINddn1z5
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5336
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Dec 08, 2021 at 08:35:49AM -0700, Dave Jiang wrote:
> 
> On 12/8/2021 6:13 AM, Jason Gunthorpe wrote:
> > On Tue, Dec 07, 2021 at 05:47:14AM -0800, Jacob Pan wrote:
> > > In-kernel DMA should be managed by DMA mapping API. The existing kernel
> > > PASID support is based on the SVA machinery in SVA lib that is intended
> > > for user process SVA. The binding between a kernel PASID and kernel
> > > mapping has many flaws. See discussions in the link below.
> > > 
> > > This patch utilizes iommu_enable_pasid_dma() to enable DSA to perform DMA
> > > requests with PASID under the same mapping managed by DMA mapping API.
> > > In addition, SVA-related bits for kernel DMA are removed. As a result,
> > > DSA users shall use DMA mapping API to obtain DMA handles instead of
> > > using kernel virtual addresses.
> > Er, shouldn't this be adding dma_map/etc type calls?
> > 
> > You can't really say a driver is using the DMA API without actually
> > calling the DMA API..
> > 
> > > +	/*
> > > +	 * Try to enable both in-kernel and user DMA request with PASID.
> > > +	 * PASID is supported unless both user and kernel PASID are
> > > +	 * supported. Do not fail probe here in that idxd can still be
> > > +	 * used w/o PASID or IOMMU.
> > > +	 */
> > > +	if (iommu_dev_enable_feature(dev, IOMMU_DEV_FEAT_SVA) ||
> > > +		idxd_enable_system_pasid(idxd)) {
> > > +		dev_warn(dev, "Failed to enable PASID\n");
> > > +	} else {
> > > +		set_bit(IDXD_FLAG_PASID_ENABLED, &idxd->flags);
> > >   	}
> > Huh? How can the driver keep going if PASID isn't supported? I thought
> > the whole point of this was because the device cannot do DMA without
> > PASID at all?
> 
> There are 2 types of WQ supported with the DSA devices. A dedicated WQ type
> and a shared WQ type. The dedicated WQ type can support DMA with and without
> PASID. The shared wq type must have a PASID to operate. The driver can
> support dedicated WQ only without PASID usage when there is no PASID
> support.

Can you add to the cover letter why does the kernel require to use the
shared WQ?

Jason
