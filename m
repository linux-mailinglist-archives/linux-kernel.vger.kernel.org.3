Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1D4114EC671
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 16:24:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346811AbiC3OZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 10:25:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346792AbiC3OZ3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 10:25:29 -0400
Received: from NAM02-DM3-obe.outbound.protection.outlook.com (mail-dm3nam07on2056.outbound.protection.outlook.com [40.107.95.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2FC911FCD04;
        Wed, 30 Mar 2022 07:23:44 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nQoXEms3mzbjQSWQZ/yREaolKNcUYiV9txiQSdAraOOtEM0NS42C246wNm9BbOwcrjlZ5DzFE6FjMBZllol7ZFZijbkcZtwaBdGwBrGyjsZFt1+T3RFXS3FGGCdeVcfHNHEU0yd7+kpOVNYYrh2T2KCZI/ZohL+dOnS6GEuPTv3gd9mCLXueQ8y3x+ndkh9Ac44QeLzPgZJsG4Y2hWOqDjj3ds98p7QuQcoQql2/T1G+hexFl/ZoNfihMvdcMk8HdqVDLq4b2fFq8Hr6to9RKlkTjEt0MpMVuSZirsWtDbh/9bUvmOsxVIGgTek77NlO6qLgV2UQpE5MWJI8JaNxJA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=DL7meHWL8ryXYZn9Aua7YjberUh98VRP2+3eC4HHATQ=;
 b=Um0Fn1wkw6nI5JH0FCKSEO3QmF2hZHOsw3C5TFlYqNvyP6DIi5BUnRLbfazB0cPtKTjQuLEKX1Z0zF1dtyuLhomDcs4g0qm+ce5VX/QxcmAzl4vOELnTjVHhQj9dCDeFcX9dXL/XUUqwSZbP7uDX6jYxTz6fkoLpGPM/o/yb7gIvoYjtmZd/fis0iwayN2cxFcEe9Kb9xGvlaqRTFgoti/JV7u9Tlid+0J+KrhF11P3gfsE0l0aJlauduStkKlPAtiA3HfcLx6FGveBoo5lT/o9oduNd5Z3Nndv0dzplpiUQRNt+3T8Yxrbq82na01G5uJj6q+Kp1QI6dL4FSlxXWQ==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=DL7meHWL8ryXYZn9Aua7YjberUh98VRP2+3eC4HHATQ=;
 b=UI+Xih9oxU9aF7UwmghQyue2sDKC8IL7mjr7J64n9yERKz+Z0fKuSuKucL1uefpTjOu5gxJi6z8fg4eCDaJh1JrRq0/RQId5H91pghK2UKMSbIrBy7mYkpeMZ4MT1EYKmMyv446S0DO/Mml7wHeHl+2G89UJEp/lQv4zCUkAgs9B0LKcxRKyvNs02zT3l6Yr2ioB8TDolvnCRWMZml3pgYn6TQkhsjqy4LiBwIrUsopYceHtFo0+4nI4sKLGqHEmrUoz6L+ccjNWd1Y4dVct9+rkICvkBWdB449Qjzck3K+veelZZiJ+Cj4QIZM6DttPuVvIySGS7yLRpVVhn/8j+Q==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1663.namprd12.prod.outlook.com (2603:10b6:301:e::9) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5123.16; Wed, 30 Mar
 2022 14:23:41 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::11a0:970a:4c24:c70c%6]) with mapi id 15.20.5102.027; Wed, 30 Mar 2022
 14:23:41 +0000
Date:   Wed, 30 Mar 2022 11:23:40 -0300
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        Kevin Tian <kevin.tian@intel.com>,
        Ashok Raj <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Robin Murphy <robin.murphy@arm.com>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        Liu Yi L <yi.l.liu@intel.com>,
        Jacob jun Pan <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        Christoph Hellwig <hch@lst.de>, linux-omap@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org, regressions@lists.linux.dev
Subject: Re: [PATCH v4 8/9] iommu: Remove unused argument in
 is_attach_deferred
Message-ID: <20220330142340.GA2111031@nvidia.com>
References: <20220216025249.3459465-1-baolu.lu@linux.intel.com>
 <20220216025249.3459465-9-baolu.lu@linux.intel.com>
 <YkRiawC2T9g+CHSJ@atomide.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YkRiawC2T9g+CHSJ@atomide.com>
X-ClientProxiedBy: MN2PR12CA0006.namprd12.prod.outlook.com
 (2603:10b6:208:a8::19) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: d1eba7fc-a0d3-4914-2476-08da1258e38e
X-MS-TrafficTypeDiagnostic: MWHPR12MB1663:EE_
X-Microsoft-Antispam-PRVS: <MWHPR12MB1663004C51A5AF486F8DDEFCC21F9@MWHPR12MB1663.namprd12.prod.outlook.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: MB+qZbPNXK/x2UGxY2DZChLd9OZf+ksg7c84J5NoxBB4q7ZXBRIW5OLncW4Lh0M/NEhF5S3gZXY9ALR98wd9HfTdn7EaWfZx/CurT68f1+WhNwpZunG6Lc983Sau1yvE0sHzGfanUpwqRsycx8Lr561Ho7KuRN849d/FGTaS4ahm7qKUK9cCSXrutPTYOUOIAywmJTHo98juqeiMA2GoXajIPhejXKz0i/tfI1DCifNWNBOsmv+bkEsgtfifhrYQdzp/P64mtM04WPWTO/pIX7o9jarF3/SUAbLUHCmbfaaxAIR+aMT6BqWg+fXaV4znvziVa+gVOodQBl/KfhjVAounUUxQ5KU1+jpinnQndV2hnSVaJ7hJUpcM9Q6PzI+RuskQJBMebkwA2cJcj+nAYA48TOOb3riCQ0WMGSzO8oU7D+mUP12ePCiLmgn94A4GaD9POIaRPwIKcJfcIy9dallSKbXciKXMLRLTZWM+v/AdQdTGW3bSWoqR+nQtL82aA2F/3oMHWmaJxhnXMjxXTlAE/j0Xn73TYd6TMWVytzQKWZQ4fKw5Ee8Aer7+LX/0g/rVa0Z0LrNhhn3wlHioJHGp/fvoiM+LW83m+c0C81lSZJ49QUnbp9ZYXF1s8pd46JD81d2dvcZt6C115X2l3w==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(36756003)(2906002)(2616005)(1076003)(83380400001)(186003)(26005)(8936002)(5660300002)(4326008)(7416002)(6486002)(508600001)(54906003)(38100700002)(66476007)(66556008)(66946007)(6506007)(6512007)(316002)(8676002)(6916009)(33656002)(86362001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?XtlpNTlduBsNL9wn7QgF1sLzYlA+FLjTfeFRR5zVgdv5LwMBAkAVf8/z0Bjr?=
 =?us-ascii?Q?ZkqRtJdxfxM44cNfqxm5OhWku7YAP6Az8KxHbZBXGbxSlqIfae8qB7pnpZp5?=
 =?us-ascii?Q?52m31HdCXuqQhFDO+IV+XY4zGH3omJF+/IsCdkH6hcQS0OWkVZVSiS3JCdzS?=
 =?us-ascii?Q?xWRuKJIs4BzClkqRqqLPKAzVg7BsrzX3yfJ4LEsIR2+Lt6kavJEr0iaOliky?=
 =?us-ascii?Q?KNK/6r7eoU/3V0hhIoY85G6UMITJS9IGsp3Ff4QrWKLjbVMloewWt8FLEd7j?=
 =?us-ascii?Q?zZQ90eZZVYrr1B/JssUWRjAM/pvjHZgKgGyG4F37Rukgnx6nruMIRM++H3zj?=
 =?us-ascii?Q?VUsBoZm8xIqfUMNmI2sAQZVQIdsJ8Ss2IjyWUwa7qUL8q57zyM61Mxv/vekd?=
 =?us-ascii?Q?4kEs7sENE27nOiKUaU5vFptVpYoycGd0COuRhzZlnJ8Q+cPPe32Y/v98mqCs?=
 =?us-ascii?Q?CQ9oodJAbC+kzEiysPTQxASiBGgqYBoSyXAC0LUldYBM3hK9zTj4lHX2qgGV?=
 =?us-ascii?Q?tcT4hUeqwyyEiMX0/wJ61hsHAfVEpBUtNgPO65Rdv0ZNhEio09uwD7bq/oEe?=
 =?us-ascii?Q?iePG83SfqPcOyftGMdaR6ypg7cVbrD+YWzQaVKrFyqO1wOI2W39gN91ehyPb?=
 =?us-ascii?Q?pPA5wR2e26Qcv34RxqNzlX7ltq4WvciC8WEd/Bg1GBPQWf0gR3jBL+XtQ3+h?=
 =?us-ascii?Q?NdsZga6CdaOLFoz01ZVSsYjzBvMOEjo5n6e9LI0b6iVRr26g+ucox6lLcacx?=
 =?us-ascii?Q?/rC1OWXOXO2+n6MuWSSVlyQLleweeSIWQGfEYzuy4U0/hDzQQXkwWC+PFHJP?=
 =?us-ascii?Q?WMi0DH+svaXflgKTQXez3O1HJxv/uOVbxLcsvDKlqk0SwVOx05JN8F/Trcdt?=
 =?us-ascii?Q?bQhVExxr530Y0vYW2nhcHKWASD/MRHwgIUCSZqG937Z/YEw7W0Larb6Y9n0V?=
 =?us-ascii?Q?lU/OZ9bmOfYykPMgkgXNiiy7o7Ibm44omj5O9jcs8gU8g0CcdLKY7IJW5zNI?=
 =?us-ascii?Q?1KSb91efd9EniQ6CjcvZcG8+mLDMrS9mzMrI1MG6P3IfKwLzZ3g/hNfk1akz?=
 =?us-ascii?Q?NxomHhQ1AZSB3RwN1o55iVhTBZ47UfFTbEOUMEoCToAI/tWz1r/oAds6Lgon?=
 =?us-ascii?Q?4qLFx413Hae/Df/hvGreVyCVaqnatvcIfFZEsXIl3meKSl5eq09OmEhr4gji?=
 =?us-ascii?Q?pZ6UtqrqqoSYKwnj4knaWMam4ECh6JMv1qGvyQntgpQxoWFI4U0YldUG/PFQ?=
 =?us-ascii?Q?M0nHoi8qtLcKwsWTt08ufFmTsSuk1kHzBJJ2RAqzAJB3MXy69Jgt8AXWbGvA?=
 =?us-ascii?Q?3kIQ2cij0fdI27u043MhResmQHYXjYjBU/aumsxOm1xLIwvqPBHQ8yDBP3xq?=
 =?us-ascii?Q?KZXbryiwP0KhRwRTxErl/aDjAGiGgyq0BpnmVGwhcMulICG/VHTGkw5/MR98?=
 =?us-ascii?Q?xTZtan26KlwPjETDZssLXskjDfXeLFXx8UaFv6SlxBemFqSmucWDXHZ1R1gR?=
 =?us-ascii?Q?svdDI55hZbRdlB/W0ZDiFp8jHLbweBASK1ZzfdcGn5H7raiqSQN8HGyCOIoC?=
 =?us-ascii?Q?pOlWoKhaBfjtFuZGN09QreCEec5TfIL4h2rNTqG6V7CE/0KWsyVp8Ny2gbBh?=
 =?us-ascii?Q?Bg4u109t57pm1DjqPCdQHdj5CSKDL4ddSIiZkZTxk7b76A9ebipD9fl02qGH?=
 =?us-ascii?Q?UddtVoAZdYtrGQRDBTTsh+JzFD4wUGQFVjSgIK1e4I06/RTxXvt3iBe5g1wz?=
 =?us-ascii?Q?skfvN81kfQ=3D=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: d1eba7fc-a0d3-4914-2476-08da1258e38e
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 30 Mar 2022 14:23:41.2699
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: 0+l4O1enbSUCT3SyT5EX/NOs+DXeq526DJ/oaj6YncDTCkhkEZkneZ+P+L7SG3Rw
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1663
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Mar 30, 2022 at 05:00:39PM +0300, Tony Lindgren wrote:
> Hi,
> 
> * Lu Baolu <baolu.lu@linux.intel.com> [700101 02:00]:
> > The is_attach_deferred iommu_ops callback is a device op. The domain
> > argument is unnecessary and never used. Remove it to make code clean.
> 
> Looks like this causes a regression for at least drivers/iommu/omap-iommu.c.
> 
> To me it seems the issue is there is no is_attach_deferred implemented, so
> we get a NULL pointer dereference at virtual address 00000008:
> 
> __iommu_probe_device from probe_iommu_group+0x2c/0x38
> probe_iommu_group from bus_for_each_dev+0x74/0xbc
> bus_for_each_dev from bus_iommu_probe+0x34/0x2e8
> bus_iommu_probe from bus_set_iommu+0x80/0xc8
> bus_set_iommu from omap_iommu_init+0x88/0xcc
> omap_iommu_init from do_one_initcall+0x44/0x24c
> 
> Any ideas for a fix?
> 
> It would be good to fix this quickly so we don't end up with a broken
> v5.18-rc1..
> 
> For reference, this is mainline commit 41bb23e70b50 ("iommu: Remove unused
> argument in is_attach_deferred").

Are you confident in the bisection? I don't see how that commit could
NULL deref..

Can you find the code that is the NULL deref?

Jason
