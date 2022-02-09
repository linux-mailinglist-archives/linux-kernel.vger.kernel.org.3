Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id C30814AF2C4
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 14:31:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231683AbiBINan (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 08:30:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46140 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233888AbiBINag (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 08:30:36 -0500
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2046.outbound.protection.outlook.com [40.107.93.46])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 23741C050CEC
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 05:30:35 -0800 (PST)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=LMd8CziiRdeP7DL64akjB7iac+nJ63UnADvVRSc/YrNm68Vq5kM81jlhesoJWxqBMhziWz+8eT8WfGpnI0BhOU6mlqqWOEzer5kdETJVv9EOHMFk7wBkkh+h8sXuyMN1omBNh/ufZd0tdPf/9Ws0N8PEJWjswnD1M2G1JoHLIh8CUlpXon3nqLzX1wZ3/JWeV0vnm/EW2Rk8+9zDEjrQIMKvG6oAZ36wXyrvU5aVtJvRnA3T4/0iRIqZ8nZHb30U2npUsAAJstqqzesLoL2DWgl9SS6OgIzpX2aTlbOjtK8p8hhqW/nvFQ93pJvFd0lBMhzG1IeHt6DGd1wnHBIERA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=e9InnL68PJ/neibrzSDYcjAAZB/OxYs3905Od5VS6sw=;
 b=CAAIb2QRvmrxmJXut/pPlJMvxCg3TvBnX8/6MTVpb4YIuMc/n+8s3QJKtiYLTOoqj2fy8xeVUf9CqPZLf4TSXF1Y0UFsSX5qWN2D1XPPO0yfayC4DabKXLJhO6MGCHwMJ+V4+VXFlPh7UHPQwNxFEjUcKpqALWvbRuCGsIo7b2WM8HJwZXnjkzXsxzjqAuXZfcOXUU9Pi+isnwbOgBkqut6b9kcHxN9nIIjpFE3QOpQkKmudGPb6pREuWrn2NWpMjxKOk1Z5P9gvWHTco9xi/vyqaSd+q9CtJSV9bBywRBkF8TdHH5tIJAAdXHuZDiO9v2OpqArW4xinJrqlhglTfw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=e9InnL68PJ/neibrzSDYcjAAZB/OxYs3905Od5VS6sw=;
 b=SGWXxUx7IZttd4SYXCTzNXwo6qoJQOikHg6OUvacauoHnvU7NgRlqFlTT8tq8WzxVc0X+pe8zBgIfwmxqpxVfIMF523PU28U48ysV9S9fPvR8n4iSXbVayXRKrGtVARjyvlWq61a8RcqqivNMO/uV8ncKKZ8/mvJRbZYiTnrlVPlnb6UKWl+y2o7L1G1P64re1BoyVEEmy5vbBYoAZEdWnm/JYWci6MEVmtewp3eKdd1eUcoGMEbPAg7Q/rEIEfqhjFd1Anm6GQT3jzRxgBsSij0Lk7KONIDTBmsRnODB53oYyD0KHTr/i4/2XYowVPFEGvJU9PZwx1PzXO08fYhIQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by CY4PR1201MB2533.namprd12.prod.outlook.com (2603:10b6:903:d9::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4951.12; Wed, 9 Feb
 2022 13:30:33 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::e8f4:9793:da37:1bd3%4]) with mapi id 15.20.4975.011; Wed, 9 Feb 2022
 13:30:33 +0000
Date:   Wed, 9 Feb 2022 09:30:31 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Lu Baolu <baolu.lu@linux.intel.com>
Cc:     Joerg Roedel <joro@8bytes.org>,
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
        Christoph Hellwig <hch@lst.de>
Subject: Re: [PATCH v2 03/10] iommu/vt-d: Remove aux-domain related callbacks
Message-ID: <20220209133031.GU4160@nvidia.com>
References: <20220208012559.1121729-1-baolu.lu@linux.intel.com>
 <20220208012559.1121729-4-baolu.lu@linux.intel.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220208012559.1121729-4-baolu.lu@linux.intel.com>
X-ClientProxiedBy: BL1PR13CA0068.namprd13.prod.outlook.com
 (2603:10b6:208:2b8::13) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 777372e4-4f99-45f3-66b0-08d9ebd058f6
X-MS-TrafficTypeDiagnostic: CY4PR1201MB2533:EE_
X-Microsoft-Antispam-PRVS: <CY4PR1201MB2533603CF5A569AC430CBC99C22E9@CY4PR1201MB2533.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:1728;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: uFmBZRT6sQuIP0VFf3eBUn8tXbP3PJabyEOox/pSAk1XzT7gY920KPmEXjtnE5i/m/bWnSSbckdPKF36+4LDiTSeCXeVsm4zfV5YqW1qty0GdgrTZ20pkZL8RmqA57h+wYdUGPw+ZNf0vhVIiIgbE0O2686gGDVl4t0tjKIY8WLt+/IEMxHqMyUCoOnxAIU8BQkAiirxfLjqOUrVG/+3YoCkm2iBPzLuSp3BXEQCBeOHc5RRjdxd74nxHGHtOpf8OHZU6Z/Seviu90JKDFLVkrEV51UJPlaaHRFu3lobjoHhqOCKKgcm0+uv37+gvegyvxzgsj6yeiPjPqxUQhcYazs/fAaQ+4JNkoTxgMnYFDlGWZSWhOHbxTfSGcxXpvQCDvqPzoA6RSYXoQAXwFGfV2vX1eE0Q0HZEn1O5xkBr0n4cxpVDFO+4Sc582fmA8rxI/98dfG6It2ys2GDAkr4PCcHb4OlVr1pD8YaAVS9lUkCwD0YUG6vwniRMvJA7N0mT4LxIjJvr7AOSPKuE1zCQmAbujjEra8W+qu9M8K4cPRx2ErUgfxnVAdLtz0oaB4e3hG9Gb/r451a0S0nOT3wT1G+fom6VwMKA6HS3rp99BBNGb+YVlu5d8e8juFtHNFWvGt0wzwXJzZuBY1t4uqQow==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(5660300002)(66556008)(6486002)(66946007)(66476007)(36756003)(83380400001)(7416002)(508600001)(8936002)(4326008)(8676002)(33656002)(38100700002)(86362001)(316002)(4744005)(2616005)(6506007)(26005)(186003)(1076003)(6916009)(54906003)(6512007)(2906002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?cpr7Wo4tggIaYwLVmg60FBHukAGWUMtOHFd1rlETI8ha1Nx/O4Tb6o78oNTh?=
 =?us-ascii?Q?8zAoCamww1bCA/zsVmPm1UB44YfUeH4ZGAvyUTAyl1YoBu5Asj/rYV0irUTx?=
 =?us-ascii?Q?EF7+MCbYF5vlA9l0Nz9eugKEqqDv7OurwgxLaQXCyRkCHUOzGjshABj0tc52?=
 =?us-ascii?Q?b//g0v09Z8XEe0eQuLiXf4IfTey2hIWhwpo3xL0qFAvsTb0LDPB7T0m3p2Qj?=
 =?us-ascii?Q?YImbEjvC+qCwqB7bKL/Z+npwyZSGNwDQ4Q4yZo+Aajlanj/RC1J164gQv7Av?=
 =?us-ascii?Q?VY0Z9181MFNM1uaghSOfltW02Dxxtkoz1bRfGUSwNQluz9BaJlf4gfDm1WV/?=
 =?us-ascii?Q?3+5HEnmAPis1qkH+X66sy+ppiEUW/97MaE5lLNI4iq6VjVF0GX8r8dYZIHSM?=
 =?us-ascii?Q?jFfGnGP1J6RyqyAezOclpLyUL5EBR/0/TSws2zesQepAsNQMqnXxeKxaOaSV?=
 =?us-ascii?Q?sw+5Ce2pP8+L4RIB9z/51wN/4xUmqnXNh3GkdLa6NRImEC3rzaEuMHYGQ4xo?=
 =?us-ascii?Q?qgWzsDWeqjcXjile5suuRraFQ7TaxFx8bAQ/p8gDxJgrf896Y6PR2H783+gn?=
 =?us-ascii?Q?ADC3n+wSckuAkNn846g3AtfxCZ2EfScT6eYtQNxhCfJcuU1o5v4Lcwt63khN?=
 =?us-ascii?Q?KCE1xBRfByPPxUNwYEVWYWrFuekE/j2iIzNoIre1dO3iSFNW/sl7isx2Kmft?=
 =?us-ascii?Q?2uGctwHjf25uPWx17WLM48J9EQtdx726a3AWzt5JVeA9G6vasK9smpGZMOxu?=
 =?us-ascii?Q?W0MW8/1mkvtYh1FdrPgKZ0ttj+5WojyLF9A0ovRrnXqcFdlm7f9EEFj7WGW3?=
 =?us-ascii?Q?E59X4JUQZSUfrJhrRR+nj3v8JeYQZMRD6hnOEGd6WmdjAMHFV4TBz/fmns5l?=
 =?us-ascii?Q?ltsHjVRfu9oExwy4P5Y0OdA9d/lEEFQ4tuyo8I4ZclfaNr3D8X/kGZEitUpb?=
 =?us-ascii?Q?KUbMwDgZbGaqWXV3MHYXWDoWkaNsi+UXRtPR9sYYXJZnqHIa8f/ijvodMgCv?=
 =?us-ascii?Q?BDQy8MmTv4ZormiANrNiEyi8V71ZK8zmpJ0JaOD7GU6AOZ18c0pozM+ug8SS?=
 =?us-ascii?Q?5w2joAHBMNyUCOtiVCnqbU71fwDCGX/D5Ns99nAyhL2o96KByWWhYEfoe0ib?=
 =?us-ascii?Q?OF20W0NBNulGF1fOVmvkSGyMo3nKc20sEFko2e9KgaehitesFDvxu66ckk+B?=
 =?us-ascii?Q?usCu2tPKyGhhuUy65pKmxMEfRgdb8eQp3BFnDQORfSzN6ycATWJI1NHsuEQm?=
 =?us-ascii?Q?Qlpum6ovN48TT+Au+DOdpbrSWa4ICXac1UcrM8S5BtePGys01U7bN21rM2aH?=
 =?us-ascii?Q?X0gRPn2rDAijqkLZr8qMiUOuFY+p5RACJZOs9gSOg857uQMwiiJINKJX2bEH?=
 =?us-ascii?Q?ZGFi2NfKMkXlNtcVawoHXSUPnCQxx4zBFEnjZnu/dfj8srjvrjHzQgh/b5Hw?=
 =?us-ascii?Q?3jCZsDafL6K6SinqPgBuF8rQSJoJ7OTKvERykKmT05C80jNRAKxkzzFgCoKq?=
 =?us-ascii?Q?j04eNd05UEkDfaFwWknc5NqNQgfkbLFcIiu0TqrKIWWePLD4MlxePjJa/a59?=
 =?us-ascii?Q?nkGCFCby3nfGIwd/qyc=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 777372e4-4f99-45f3-66b0-08d9ebd058f6
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 09 Feb 2022 13:30:32.9309
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: S1lvlapuNmei/ji+Hs20zlmD213sdbCe7eYebvxmeIf6AR/nyXfqM9K3oJZLKp9c
X-MS-Exchange-Transport-CrossTenantHeadersStamped: CY4PR1201MB2533
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Feb 08, 2022 at 09:25:52AM +0800, Lu Baolu wrote:
> The aux-domain related callbacks are not called in the tree. Remove them
> to avoid dead code.
> 
> Signed-off-by: Lu Baolu <baolu.lu@linux.intel.com>
> Reviewed-by: Christoph Hellwig <hch@lst.de>
> ---
>  include/linux/intel-iommu.h   |  17 --
>  drivers/iommu/intel/debugfs.c |   3 +-
>  drivers/iommu/intel/iommu.c   | 309 +---------------------------------
>  3 files changed, 3 insertions(+), 326 deletions(-)

Reviewed-by: Jason Gunthorpe <jgg@nvidia.com>

Jason
