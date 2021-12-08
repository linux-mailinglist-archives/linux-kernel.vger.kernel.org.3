Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7120946D426
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Dec 2021 14:10:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234120AbhLHNOO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Dec 2021 08:14:14 -0500
Received: from mail-bn8nam11on2089.outbound.protection.outlook.com ([40.107.236.89]:12608
        "EHLO NAM11-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230458AbhLHNON (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Dec 2021 08:14:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=RSN2vGybU2pmdxEVCQSYMH7FbonZvwVLOze9TZMEPkBwOnpip1ShAuUZGHCdoHscmxrfLw78pfmYRfjvKVaKGBE9O+VOjEsguVOjvt3kxL2Roy2YxrI+f2aProrqWKVRTMegFXF+f4XPoqa6SdNlD38fPbYlM7sGuCQCGFgtfSDc7SczpQNF/qShOvFIirxd+wEkbEi4IL/FuDI+NTzuGSYYK1apBAsluzWpG+31NYf0UpO7N/8SWbye73ELfW45EvNR5yCGS9YI3HgwlOsK16DSIeN3hNW5koiDiYKzczx+z18Bdt8jbn0FXlnSZGm1NWER6Btdwn8Pf8Okf3MjEw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=bbXn/sGzQRi4rppNW9Q4pXNzHctD6wQEoY1oyGd6U5I=;
 b=WBhaEzATK3n8sH3opGOwjVm/csvkuEEHlVrJL3XsTYV9XeOxuvEfzdrrtVK2Z/u+IdqGs+D7fDXcrUWrXRB3ShEDv5sHfogwCeNJk3ZgLRsyFAPvbPOENdFYwI9+POrZanI96P9hShMrJpTr9aPDcysArm5GP6swZkxSuaYimjY8gBNpDaycDS5G5zEk6Ix0q7T+aTUE9TutyaicHE7jXREDxMdX9tHsl2ElczfqhBVLtEpdrfGD+U67uT84bNKi5Ob5yuKi786A9rHwlkj0B1BlxiQrgGk2RlczNTxDmIqa8OMGEpz73KgyA/RVtTXUap3/mMQXDgGbtocODpQKJg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=bbXn/sGzQRi4rppNW9Q4pXNzHctD6wQEoY1oyGd6U5I=;
 b=FHhZspazaGW6Sox8rjuHfREKAAtKhZN+uhob2iBkkiJzTWLMWHFlX43we5XS+7SoomNla2zggK7/3Ze6+0rnPeHcyyZJwz44w+Lmbd5jNicCwAJiWlXxPnUNclUZrK0jw/bIROwC1wAok/4lw9Kj1LsRUUUKkVCi+rfw9T6zfbk4LFLLlxjw6NqTtnISyG78qx20pLSusGvIUvqyX3kHySEpb6jNyCFVVfWPNYc3AV3/lfJY7AeWc12kYDIwCSbmc+7FT7mbMMf2v949RvT4cLeJ/Z2qyP9Qq9ESDbAyPOSLM5FFrgsyAYgwnhdrWZtvUufbqxQUQIIv8MMZ24SJpA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5334.namprd12.prod.outlook.com (2603:10b6:208:31d::17) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Wed, 8 Dec
 2021 13:10:40 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.013; Wed, 8 Dec 2021
 13:10:40 +0000
Date:   Wed, 8 Dec 2021 09:10:38 -0400
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
Subject: Re: [PATCH 0/4] Enable PASID for DMA API users
Message-ID: <20211208131038.GQ6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
X-ClientProxiedBy: YT3PR01CA0044.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::29) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 316d7ef9-c1d8-42b0-0bbc-08d9ba4c2202
X-MS-TrafficTypeDiagnostic: BL1PR12MB5334:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB53345852765C696E77C7DBC5C26F9@BL1PR12MB5334.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:2000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 78urUZBs3Vujws5FQzkVwOBK0lR06oUDW501MQYOG5qx7lVdvsWYLgHc9LZcUsBq+8VDIYSdYtCmHdSy+G5QP+rinwOB6X7NOE9NrbxernvNu0ArTBaI8vORU5DwZrceSFMc0uQY8Iig0vzF714J34R3Virni+M/iUwtqgQNKuOx3aRMixV8xARSBm0Bcb3zyi89WBXF2M4eBDMaJbm9t3fHZBwgcY52iw2GDzEXrUaSgWKOoXf+BRku1PUb0dpIDwVLmwGcgjQ5aj1In3svHnqUAwr92g+PkXn/rtGZ/KR/5bB9/7XqFXVVEcgvTgIRodqGBguSyYNNZ/4Vp2CmzSHBhJXGtOVFWY8jE6560NYlDtjrAqUtXdFW9gC+tsy1DoAtsQsVi4hn6sWqkVMMSGuMv86cNNW322SjCjQLEy5Gg5p4slBLgvc0L4v8QY5+QaCGBpM3rlTETt5xIxihZ6hbab2BjBJWv3lNX41zN38bSYalOk4J/tO/jyzUxnGOhv/hGYAzRn16H5tI75emuFJaRTNaKzoeQJ29IOdtjmeYFNH2CEAzgCR8O+0t1EGaOpdawhb/muEY1wSz+UXaN88BkgQ/nwx+3TtXw0rRrtQptzLiwcYee7uPVpAO1l6zlkoQ+lq8051j/lG6TMNkhy76eaPKhPO/bePMD0J3pCvs5HpEh/aAODor/ZxH9+kOorQjWac/4GsoumgxGPcgzfZvb9kkXDd5g76Sm+o7EOPKZgjDxIMj58Kiv+zOXk5hGZFGpQIS1eQ/2QOuu37voLyFvEnLYzm5kRMbXBQV0vUQzjgAXvooIWkwULjzG3r3U9Lg7efSe+Lkc+dQPW/+GA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(1076003)(36756003)(2906002)(6916009)(2616005)(316002)(33656002)(54906003)(66946007)(66476007)(966005)(26005)(7416002)(83380400001)(8676002)(8936002)(186003)(508600001)(6506007)(5660300002)(86362001)(6512007)(38100700002)(4326008)(66556008)(6486002)(26730200005)(19860200003);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?1uEWws27wVZr2l2JielrxH+uqfcekB3XniFSdi6kEzDmsr0SlnQFbLw3IEGM?=
 =?us-ascii?Q?8QT3afHU6oUMxpK21bUMIadnL/5yViyGTZoin9N9xG84U/eHhqgvP4QDpKxo?=
 =?us-ascii?Q?7JxXPZx3FeHSI0ZWaWa50ji6pApG8F1Ug6j2Fc/nw9ZBSwmXqupOOrpKGMxh?=
 =?us-ascii?Q?Rk5r6oy4NqTzHd/V0Vw1mCebc0pEbd1TqxoTrjyqWV6yWCGaDMGR7bqX7nZI?=
 =?us-ascii?Q?+2quz83TwJu9VBKjBay9ROE6G7V8nbCdCxCHLRBZ5URwCXt2qgJ129ob66kj?=
 =?us-ascii?Q?EWgjiQbyY+aldzLahGDoFxCHEDLCEsDny+r/akQaL+q3im6zRrQfuv1vrHTG?=
 =?us-ascii?Q?HY+Lc4Jf2uUpj2j6nLJO5bXQjFfOSvg4a6BV4yoAkmB5URTk4krA5lZlHbY7?=
 =?us-ascii?Q?COftDO165uhdoc4XhUE2mYMvEhe9kwzdC08TgtJpKJceKYYb4lYF6CgckKHa?=
 =?us-ascii?Q?C916i66kw03VW91BFCYLnqUQIrzTxEW3On3GBP/b1vWKzIIx9QtIvmC5wFXd?=
 =?us-ascii?Q?lRRxRquSWKH+OLPTQeaAs0CEhi4FP66WFZj02ycdqB7wnuMVHdcDNt66KUgT?=
 =?us-ascii?Q?mf/q4uqlV+GPe0Kg+2QxQKl0N0DuENCYOzpexVGlNlGjorj5m5QnvYu5kJ0V?=
 =?us-ascii?Q?361bclur6Vk1M3JbTDK3Zfn9RcHlbK0rsuD5UDAgZvaga+skypKNhAW7r/uL?=
 =?us-ascii?Q?fMrHPUu2OjWD4t29EaSqUWdd2n5mJ2rY6+5ciL99mUneRemgKT49v+H+LtFc?=
 =?us-ascii?Q?Z/zUx3oFz8aZ6F6K05BBEeYCCp83Jt5GA2nI3XjXDoZ1krP+0IgDQ/+1m2De?=
 =?us-ascii?Q?tn2XI1SxzIUNZBWmLZ5/iTG2ySfBF+mwsDDkiSTPg4NKn0JVWTONtiUpPr3Q?=
 =?us-ascii?Q?8SSj5uSHx7PP53kypfRdL7oshg8jEU3IrrrPORXno6ltk/LsOhvVyweYoyMs?=
 =?us-ascii?Q?zdebJZa8yZPd6E/1HI9L6t4Ve68W4Ln4jt6RrE+xlZ/PYVT9gWT1EWsc4Lio?=
 =?us-ascii?Q?Rad3e+hyKFl+RLGRIMo/vyE7YGj2ceNoaUsqn1AYUxuTq0EReAKGYK50K1Lt?=
 =?us-ascii?Q?4N616T8CjVRvNLXIVSFZfh8Op1jvTh4Lo1mVGpFfVfmNtFiEuED6GVCIc6+d?=
 =?us-ascii?Q?Iw2cbvH3WyeQ1MardvDDmmwfp4CDnQwdxMSDlkMrreqmCRezL049wIXaaLyf?=
 =?us-ascii?Q?qfBZ1SHm9f6zsL4aqISZepaYLc0w+0ZE3yWENI2iASYgZAX+x/y96P/5a1RZ?=
 =?us-ascii?Q?nofXKcihk8oJv/NUvxsBFBoHybUvf9bwEKzoa5d8AXYCUZGYC2dJqo8AYHwf?=
 =?us-ascii?Q?OPAn3Ala7lV5vHUK/rbwj+TNZTDLtPNFvNkIky/aAlMZGRHTUbhar8o53YlX?=
 =?us-ascii?Q?hr7K07ih093aPgjqkjhZ6t1u3N51Nz2mAWGOG/RdjhAv1qVwvCK69+vhlvZT?=
 =?us-ascii?Q?1QNiRo/vl6pkyk4M3X+Pyu+KeOvP+qGiAA/8IUqe2LnagyDQs8JVImbrxxMT?=
 =?us-ascii?Q?Kn45QoRPoOLFOPIWXMozJazZTv/y47WE0AdbGhyePt4RMWP3bDmraf1+j08R?=
 =?us-ascii?Q?NS7HArWOhd8o21vZx8w=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 316d7ef9-c1d8-42b0-0bbc-08d9ba4c2202
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 08 Dec 2021 13:10:40.1413
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: uKISWEwsqCjlke6loRYBZE7GClDJz6j0MBJuJY2aiqSNtvB8qGVoGVSW1UQTCOdk
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5334
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 05:47:10AM -0800, Jacob Pan wrote:
> Modern accelerators such as Intel's Data Streaming Accelerator (DSA) can
> perform DMA requests with PASID, which is a finer granularity than the
> device's requester ID(RID). In fact, work submissions on DSA shared work
> queues require PASID.

Lets use plain langauge please:

DSA HW cannot do DMA from its RID, so always requires a PASID, even
for kernel controlled DMA.

To allow it to use the DMA API we must associate a PASID with the
iommu_domain that the DMA API is already using for the device's RID.

This way DMA tagged with the PASID will be treated exactly the same as
DMA originating from the RID.

> DMA mapping API is the de facto standard for in-kernel DMA. However, it
> operates on a per device/RID basis which is not PASID-aware.
> 
> This patch introduces the following driver facing API that enables DMA API
> PASID usage: ioasid_t iommu_enable_pasid_dma(struct device *dev);

This is the wrong API, IMHO

It should be more like

int iommu_get_dma_api_pasid(struct device *dev, ioasid_t *pasid);
void iommu_destroy_dma_api_pasid(struct device *dev);

> A PASID field is added to struct device for the purposes of storing kernel
> DMA PASID and flushing device IOTLBs. A separate use case in interrupt

And this really should not be touching the struct device at all.

At worst the PASID should be stored in the iommu_group.

> message store (IMS) also hinted adding a PASID field to struct device.
> https://lore.kernel.org/all/87pmx73tfw.ffs@nanos.tec.linutronix.de/
> IMS virtualization and DMA API does not overlap.

This is under debate, I'm skeptical it will happen considering the new
direction for this work.

> Once enabled, device drivers can continue to use DMA APIs as-is. There is
> no difference in terms of mapping in dma_handle between without PASID and
> with PASID.  The DMA mapping performed by IOMMU will be identical for both
> requests with and without PASID (legacy), let it be IOVA or PA in case of
> pass-through.

In other words all this does is connect the PASID to the normal
DMA-API owned iommu_domain.

Jason
