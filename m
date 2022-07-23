Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 81D1657EFA3
	for <lists+linux-kernel@lfdr.de>; Sat, 23 Jul 2022 16:27:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237884AbiGWO1Z (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 23 Jul 2022 10:27:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237750AbiGWO1X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 23 Jul 2022 10:27:23 -0400
Received: from NAM10-MW2-obe.outbound.protection.outlook.com (mail-mw2nam10on2066.outbound.protection.outlook.com [40.107.94.66])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E73313F9C
        for <linux-kernel@vger.kernel.org>; Sat, 23 Jul 2022 07:27:22 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=HaBCkwAkcRHg6q9fBtR4xnDevxZZa8iy36rDbduV8T3hhBg3Lu6u6aQrT26gdR9vRiWLLK42YOTkK3PUAL8iR0WcTgGMm4bKLZC06dTC+4JRIHwnH/uy8R3HbZXZMT9Lzt6JKLvv0W48tBExvs8HeDVMMuL39W7dOFgNkJ3NDReHvb2faU6A/y7P0YPgbxVJmLq+3e87UeVrG34ovA2zTr3t3idL9Oxf5p7Md5fy3wG7ZwmhUMPfc7dtrROjBXKTqE7q2/q+hHh7mH2BDmMstL06XGRw6g3MB+e5Q5DGw0qDM6lQZsN+wm0ze/H6cBc7DJwRT0g7rU9c0J8QO9QPsw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=LO+PNWT2YzMqkc7c+xxdSVyKay6XxXY4XpgMVx+YsnY=;
 b=GwBfrfVdqLHaHZE6WSj4Q2WXQdNtn6eldayqw4M9HMZXM+SIt3+oDQy9Kdb4jvXlkzFITRcWXl7g2ZAwm3tsoRoSrH/S0FfSX0BGKfqHZeZQHlso5blZ0f/lGJ9N22vS0u4SAkP1AAYPZER+QnDZ96/P/Gw+BfQwCAN+oATqfEknImcup6rwssQ8bSN2KmkP7BdKZpJcbEMONBUgI+pJqhIJ6cpgCa8MWpic9as26Q1GHr8y3dFgV0Ak7Ll9TmEOUOrfXIXUsemwPVZ0/UCsAeGONZzREMYJujnK63Rv6OPV87RHVS5vNnDS3DB5C0h5fSDnZKwBOP193Jn7CteT/Q==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=LO+PNWT2YzMqkc7c+xxdSVyKay6XxXY4XpgMVx+YsnY=;
 b=rQx/fpZZjKUPjkZWx9sBLs17jpkQ65nB6iOFrH/LnHq7b6d8x7vrOS3rKmAbxlXCw5dr+0hjAnie3mZW7ZgebW+JKhyrLbmF9ltoZtro0HiWvb5Trc2Fjq+Sr8e/x0JlowVoH9/BxE29cB8sRdbFQz2MGAel6sHSICChEWxAyFQTPVXNkQ39cnBoIu6uEaRSWFh8l8t04EmSdyY0sQ7kTcZnLYzawcFYt+sRjIsDVxd0gKrbihsF6pq7GQBCCuDnHvonZWgrtO42LrjHSChTG8fhnQLx3F1G0rVrMAKU/UmMBID4b8ZMEXsmzAuXKwyErQ0tNPlEyBx5NoMPyXj2aA==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by MWHPR12MB1933.namprd12.prod.outlook.com (2603:10b6:300:10b::22) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5458.19; Sat, 23 Jul
 2022 14:27:21 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ac35:7c4b:3282:abfb%3]) with mapi id 15.20.5458.021; Sat, 23 Jul 2022
 14:27:21 +0000
Date:   Sat, 23 Jul 2022 11:27:18 -0300
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
Subject: Re: [PATCH v10 09/12] iommu: Remove SVA related callbacks from iommu
 ops
Message-ID: <20220723142718.GI79279@nvidia.com>
References: <20220705050710.2887204-1-baolu.lu@linux.intel.com>
 <20220705050710.2887204-10-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220705050710.2887204-10-baolu.lu@linux.intel.com>
X-ClientProxiedBy: MWH0EPF00056D0F.namprd21.prod.outlook.com
 (2603:10b6:30f:fff2:0:1:0:11) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: ee84ece8-9748-42f9-e68e-08da6cb77417
X-MS-TrafficTypeDiagnostic: MWHPR12MB1933:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: Vpy+xptoma8E1YDnDxIfUrQTOF4ajwTJrZ5O/cmfj0/bh7H496qSoPee8yjr/wVn/nTR1PFbShrtXyI/oOW1WxOPPQ/MBuxlDlpHxKyeroefT1jQkZpGzBXoq8Joggtm6pDFhZcda2tYr/r/UI1JQ7ialkMSsilJfvIWRSLjCHNnNdBS6jW6lFn9nSjfrhhzmUlZj2WiDXEuqJlKCpCDgAYQ8YkayfNSKHWu3LdcT4EPxLoCrDs3JscnBzqXwXKQn16dvLA7xjLkthXmmFlB586sIuufId3Cd97scEZZ1qHkbRF1C1r29GoPSmd06UsNacpO/kJhX2nxgOO7pVtsuHj6qzT813eu4V0aowflT7BJyeuSw3MqOb3F8+Hr6szWFDXdcou5nyTWm6Lx0zUnHqSQpQfmN1GT13fEL8ndP7spmEGRiRCAfIDoWgtumJGdvGqSEr23DvzRoHVAeK/F3sG4Y94i60JUWGxSc+LgJ4hnVEXAn5p2A82WRt86pHwZX9QaeDVmr0IYifxV5f38ILOvgsWEsaCS+u4CpSkWkS0joKY4EnHgw3fbqGOwa+iwCK2MRtd7Up0xaAhwEEVi645PejPiNQFVMneq8pq1q+b7J0CIn1+tDbNyowbkFQgfrH0s3JQ4oX4BZmc2BGS+GCXFGid38ThBy1M0CsxhpiMhQaEKRxeMwuQ0QIrs2Lh9W1Qm5kU4ymr5I13VTASJONRV5wLeRrlXcQFJSCBQYlM=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(366004)(396003)(136003)(39860400002)(346002)(376002)(4744005)(66476007)(8936002)(5660300002)(66556008)(2906002)(8676002)(66946007)(7416002)(83380400001)(4326008)(36756003)(86362001)(38100700002)(6916009)(186003)(6512007)(6666004)(41300700001)(33656002)(6506007)(316002)(54906003)(2616005)(478600001)(1076003)(6486002)(26005);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?W7F9rKTxjI2kYYMhDFolaTIT4lo5oMsxU3t2XsbX2tmHwf0aFOgIWol/rbwH?=
 =?us-ascii?Q?j7C/z52/zF/oDLpks/GQI4IgPH2tuEI0En4ZwYsU9SkFYkC6pkeUNdnFI5az?=
 =?us-ascii?Q?EDh9P9ppRvhBfiWA3J3ywmyoJNiQdKxlhd8Z1V/iwZlz7jNDftfqtaM84UlC?=
 =?us-ascii?Q?wztLACHR3AdUT/32prFMuHGWw+84URg3Xn5xZc7sjPRYkbOIki1Uidsn+ido?=
 =?us-ascii?Q?OU7Ug0A1s7jWwOdBHFJ5jPptzN4aexshz7ot4sPovh5PjJskw9cIrFwa3LIs?=
 =?us-ascii?Q?/Rf8YKImjwHTDgU+zqWt9oCkmnOnEYVxBm5tcgNxMBDscyFQcNbW5RDtoqy4?=
 =?us-ascii?Q?CiiUzbzUYB4p3G4VQeKunOJPYt8qf3eSmSd0u1BW4wBbO1lecaNLor3BaelU?=
 =?us-ascii?Q?ydnjTkFmROG+hdHqHH3jReDk0LJGXbN4ZdfRp/SJMW1OdhFCT42ibopKA8rZ?=
 =?us-ascii?Q?nrdmhbc6mM5jMb/zBxsY+rYumuao6UFKz033pLLAXDoHHijL25Jm5cDCLnFH?=
 =?us-ascii?Q?sEtcp7/MeA9kTDqK52LPuL+e+gnPglogRNfKyCh1ACsbyjxsIXhOcFoVT+0j?=
 =?us-ascii?Q?HRY3tRN2nOmxxowSejbN5e1XHmFU6DACa7fi5NxrKXbNHCWnk8MBUjxk5i4D?=
 =?us-ascii?Q?dwj0Fhzjs7ko+uL4F5JI9EokomvPbFXnf9Mfat66PW5g91yZvZeBN5TaME4I?=
 =?us-ascii?Q?s85SI9wpkbZyj9YcG8/zX4b1cQ/B7o5Pr9KW4VPWL524CPfsocq1CT3va0gi?=
 =?us-ascii?Q?z/ng2LCFs/CXpDdCXZibAqpWPZZvWkcb+KutR8WenYKqa/q2MHaMZ5ok4CrF?=
 =?us-ascii?Q?GkTVasbXdmNwXi+c7yzplg8kIEdc1S7WXBuzaUaBZOCTDdCGD9eFmDe6ZBxB?=
 =?us-ascii?Q?a5/KqS8gzAaWxKopALzX1jiof+z4Wmxk/z1+Hs8ZVruiDjUKxPcfg09M9rOp?=
 =?us-ascii?Q?VzyE0U4NbWjbScE3mUyGNnlEMPBzwLNY1YL5D60HJNu9wrKSVpsuYxUBYgpv?=
 =?us-ascii?Q?QJu3toj+5AG85t5afMbkOm0MDxwcl0+/dvo4AT6QC9/E1Xmq3lVRFKXD2+s6?=
 =?us-ascii?Q?qG9B+Sc6hG2d8ZB5mdiZeZw82bpbQ4zVlBCAq4hsLGm2BfheGCRlJl9xmmaJ?=
 =?us-ascii?Q?+8q31UU+LB+P5/Euueh9MlxKHZprKS7GtwG/Qec7zKEzh8A+kX1+csAjGPUg?=
 =?us-ascii?Q?01pUpRfgroJMVOODo+oqoPJwDFg+lHjquJO/z75UuIso0g9rYgSyQqcxgC83?=
 =?us-ascii?Q?iiOmEOUAoMYGB2JJn2KbyZsIU4RfXF5ONuMZrVw8FTDjURToATADUIpVfP2k?=
 =?us-ascii?Q?BMIdVDsmDL7T+rdiZKwNSHRMo2As0b8wdIuC1Ursk9H6cCQz7ZbQ/8B0KUx5?=
 =?us-ascii?Q?063ht2HJlPD6LMuIbRUxHC+fWDGH0ICwRRh9E05BcWAIoHfXHqnqCxRNAsr+?=
 =?us-ascii?Q?Up0xvCD3ZoNNmFMQaSM0lulUxb34I784QR+eA9nzNxdQn/v7wtcYuPnfOxJg?=
 =?us-ascii?Q?YozaxvPlCES9GZvqCg0Te5j+3qKm0fi99abAl2Dcxdboatx+nWKZ7Zy3c2zM?=
 =?us-ascii?Q?dHTBP2aZb3bp7JocO94gsj17xN3RARbtVqhuWfmZ?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: ee84ece8-9748-42f9-e68e-08da6cb77417
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 23 Jul 2022 14:27:20.9746
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: PojpME5foVB5+zfwklyt8jkQlpM0ueHWNG/aeRq9njUUlVsJEKzG89upIwJV3w9O
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MWHPR12MB1933
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 05, 2022 at 01:07:07PM +0800, Lu Baolu wrote:
> These ops'es have been replaced with the dev_attach/detach_pasid domain
> ops'es. There's no need for them anymore. Remove them to avoid dead
> code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Jean-Philippe Brucker <jean-philippe@linaro.org>
> Reviewed-by: Kevin Tian <kevin.tian@intel.com>
> Tested-by: Zhangfei Gao <zhangfei.gao@linaro.org>
> Tested-by: Tony Zhu <tony.zhu@intel.com>
> ---
>  include/linux/intel-iommu.h                   |  3 --
>  include/linux/iommu.h                         |  7 ---
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.h   | 16 ------
>  .../iommu/arm/arm-smmu-v3/arm-smmu-v3-sva.c   | 40 ---------------
>  drivers/iommu/arm/arm-smmu-v3/arm-smmu-v3.c   |  3 --
>  drivers/iommu/intel/iommu.c                   |  3 --
>  drivers/iommu/intel/svm.c                     | 49 -------------------
>  7 files changed, 121 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
