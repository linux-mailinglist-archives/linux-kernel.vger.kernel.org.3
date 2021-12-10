Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0953B47096A
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 19:53:47 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245632AbhLJS5U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 13:57:20 -0500
Received: from mail-bn8nam08on2049.outbound.protection.outlook.com ([40.107.100.49]:35040
        "EHLO NAM04-BN8-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S234293AbhLJS5T (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 13:57:19 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=nyghvEoWgQJgEuutv+dg4EGpkhKj9nfmGO7XtY2Jk+RQIdGYt0tHZrFKiIiD4KLAGeFD7/T/YE6Dv9NS9fBQviqXFsUJWMypuuaoWPLEE9bIWb/ZaneiNW9Hmq+3iOWpvVh2kosaM7zUjWlVAOTBL/uM+gwA0YQhz7phfN94qNY6oCTZSsXs4+2tYiL+v9yE5fA+jSeFn+bKYk8tP3K6XgldnZ67MXqC3peXV0xf5a3IbzproHel4LdMz0BXm76rKzEA68Pw4JK+Ruv/boJXPojlPjbGg+0J62AHuwyU3KADtWhzcbkbmCm44UyG9qVWvFHpNPETkC50hTOnr9bpqg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=rRpYNNuggQYxfde0W7gq0iLTjRuUypszDZr4ICrDhw4=;
 b=EFy+KPiPU1rKehQdmexPobT/Yw9K0DnTW8Xg4FBlnI0pH5XQ0J5eOYMn5Jo+izeWwxSR8WXaZBOScGkpgvkl52HzTLVd8IurUJBCbI4Z/NXz2Mjb/gInTRvVUTT/hjMlrafSAgI1NnhudWmXvD0N2p9MtNqSu94VeUz3/2rRg/Zai1hikcz9Z+Lf9uCxLSziL1B+eUMV0dGo08+AH2V/SvRImB0Doh1kWO47PXs3o0ZJzFd2W6NPzZoRFFN/i8IMpDGPeH3rkN0GF85tvdguHz4KL/ppq8jmMoz5/+STheWotw0B1qUQfJi0qsoOlmKEr6Xd5IsiO18qB5HqsNtOgA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=rRpYNNuggQYxfde0W7gq0iLTjRuUypszDZr4ICrDhw4=;
 b=cERteRusziPE1EFFEW+2Vvfx1Jmsr9OXLG9nGQndXXwe2N8MQ9ITA0pvcYqLBEgrs5jr2D4nLKq4HOf+ilpwxMbO15zX4dpcoCAS5TXxpKFZJU1mVwGGGiuy3Z2KFXy48T12JYR+ypjQJ9T9NiWXXP0djaDeQ9fbpi8mho+qBPEidI5thq+Px4OPmvR7EJtLqwH4bR6jd/dwnk22N3ptaNCy89VDr+H0qjQwkGR9Km+Mt3oJNdaL5HI3xvXsZDDbb+hL2F1u4pLnGn9G1LNYJ9El69shmgZqC7Y/5Muyal4mqXPDNs6Mo8NeM39K0athIHTCf9+QqOg7MPzDukjCdg==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL1PR12MB5363.namprd12.prod.outlook.com (2603:10b6:208:317::23) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.11; Fri, 10 Dec
 2021 18:53:42 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 18:53:42 +0000
Date:   Fri, 10 Dec 2021 14:53:40 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Jacob Pan <jacob.jun.pan@linux.intel.com>
Cc:     Lu Baolu <baolu.lu@linux.intel.com>,
        iommu@lists.linux-foundation.org,
        LKML <linux-kernel@vger.kernel.org>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jean-Philippe Brucker <jean-philippe@linaro.com>,
        Jacob Pan <jacob.jun.pan@intel.com>,
        Raj Ashok <ashok.raj@intel.com>,
        "Kumar, Sanjay K" <sanjay.k.kumar@intel.com>,
        Dave Jiang <dave.jiang@intel.com>,
        Tony Luck <tony.luck@intel.com>, Yi Liu <yi.l.liu@intel.com>,
        "Tian, Kevin" <kevin.tian@intel.com>,
        Barry Song <21cnbao@gmail.com>,
        "Zanussi, Tom" <tom.zanussi@intel.com>,
        Dan Williams <dan.j.williams@intel.com>
Subject: Re: [PATCH 3/4] iommu/vt-d: Support PASID DMA for in-kernel usage
Message-ID: <20211210185340.GI6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208132255.GS6385@nvidia.com>
 <20211208111659.6de22e52@jacob-builder>
 <9f724b3a-6028-43d7-b4fc-d8a939e7b2cf@linux.intel.com>
 <20211209152113.64b817b9@jacob-builder>
 <921a766f-d826-2ca4-f739-4d196b32a681@linux.intel.com>
 <20211210095025.38af67ce@jacob-builder>
 <20211210174848.GH6385@nvidia.com>
 <20211210101820.58b24b77@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210101820.58b24b77@jacob-builder>
X-ClientProxiedBy: YT2PR01CA0026.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:38::31) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 1e6fcc32-309e-4ec7-5a82-08d9bc0e6308
X-MS-TrafficTypeDiagnostic: BL1PR12MB5363:EE_
X-Microsoft-Antispam-PRVS: <BL1PR12MB5363C648A1C53A3D99F50060C2719@BL1PR12MB5363.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:5236;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: pulgaPbsGx0ye+DPsN66vPJTezI5CjV5793DRPcOIAzU2HFpZPxq+I00SCrDvI8yoezfhEBk9fhMfqA16HIfxCuqiOuj9nJFfTS33lOJXSgtVLjIkRM8m0CM6RvVRPKqQ7+5b5CecF8nOdbDETas11JFIX8rTrC5bYp6V3DYMik7uSQVWQE2cXenxmUBuwgEZC2dq3sfbfgiEpGvSsbex4wsEbqk4p5bpP6mrPJ6TpiTiMPyNMA2OsBravcdv++4FOLaC75A/Q/ySzcEzJkq3GK1KD9Ii+uZV2HhNCzdCMStq76OtVRuN10YU9BPc0mrRptux2s1c4hXeKuxnQXnLvy4mxVPQ+TUkSj0CZMEwnygwhVm+nPzLdsejagNRmWVgwWaUFdjj949fuxnCI1+fuoYhYyK0y17RPcy5jNvgvB8b9sOaV0LG1lpmUexy0+Mz46M1GfUmfjGLVYHiwxvXA24GUu4YoUbM0yAVhHFK91mLR9lEjlCvk4r/7g7FaCaU4dQYj69YGzu3aOmlJ+i02FNNNHJdU9gT7ERefm7WMndus4r8YD54bjXvpCTeZfyRuR6xrdyUcgX0ZWHPudKSE7dhc0/vM1kiZuZ2jyQYzUjnYpA2tDXsIYRcvb93qlIiy1O4Zh5sWJO7ekFpuJ6TA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(4326008)(1076003)(36756003)(2906002)(6916009)(6486002)(66556008)(8676002)(33656002)(8936002)(86362001)(508600001)(66946007)(6512007)(7416002)(26005)(66476007)(186003)(38100700002)(5660300002)(2616005)(4744005)(54906003)(6506007)(316002);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?5VqrZKN2K0W59GBBwV9rCgXITglBYbeTnCqTzO0lsn8LkQGyqjrjvk5qSMrE?=
 =?us-ascii?Q?CU9jQadCt+khThr6LiKSxmUiY4Tw0hFCsNQwFRDvihImxK/jkr7IhWgbrHxx?=
 =?us-ascii?Q?xYLC5wBVm3+XR2i9HFV7Y+GWkRmdrLr5ui0m4vWx9XMLQbfHeZ/3pEw/l+by?=
 =?us-ascii?Q?qtHdnPM8rA6xkVwLUr5WAFnEpEVD2RveY5Sa8zid+bFwKodaFyYJEySVGO5x?=
 =?us-ascii?Q?TphqFibjVtZhkqo6Y/LdHMFkHByZXTE2dN/EmGZzhUe15/0kHkWzQ/F1yn4K?=
 =?us-ascii?Q?2xXzFPw+C7p1zDD5cMmcoyLuUfbpdkR7e4BeGaBDInqduAPxB+bhOEQpOcRP?=
 =?us-ascii?Q?0KC7Nb9BJBtYNJ8uax8P4mkWjUjQTYNulz1oelXDbQSoP652iFpIAd4gv9h9?=
 =?us-ascii?Q?IiVOH67dGc97LFW3vkh48AKe5VpWynMLJnFkUBJbTmvNdBas1hjBaut6A2rV?=
 =?us-ascii?Q?0rRbBVwDZwkGuXwC5i6eLpoTxRSGWpZ/GFkOTLng44kDqp5lQSPgteaSRvlU?=
 =?us-ascii?Q?M25WGdMAM4DWnKNkwmhjSpt8dZHt4QGsdG1z8gDvfnqjLvjQMFSI5NNbzuKl?=
 =?us-ascii?Q?P43RgIsnW3Ga3+pG+EBh1soN4+w8eiq6LbM2u6rBBJvOgAcqLRw/YKDAJusl?=
 =?us-ascii?Q?a2fQrghAlFK8s47vQEm18HUk93estIdlwZnielm29nwCo+n8LvBw5lUbkocR?=
 =?us-ascii?Q?b8XeNoNzuG1Of+CVCw9y0c/rq1nH16Z49xE7pzb7kfqMAp5cISL0c32mBFp6?=
 =?us-ascii?Q?UFdHZc1SudaUhjBsPbo4aRTbqLF24+Hry9UVe+Ds5p/jiED/i0o3+LE9DSg3?=
 =?us-ascii?Q?M6BU3zrw/6qJzxiOS78NTmxHzUOqXV1h5wFltACnLbfu+p712bNoL+f4Ye7z?=
 =?us-ascii?Q?9g/QiPu1Tr0lCDA9Vc82bJ3YOmYM63lFeycB/jqDXJnv+q5oLowKAAeGc3lO?=
 =?us-ascii?Q?A59zYqiUZk2/K0Ahtavj/WxVvw9tS82fd66cli5m1wtsYuYRcu306ZKHLe4e?=
 =?us-ascii?Q?IIDnoXwHD3+8nT1NGK8HCPWbd6u8GJUw4BySvFwBVpZDKqy1/XOdUFCLsclj?=
 =?us-ascii?Q?s7EVjm94IWyO/zQFm8CWfM9g6Gvo6+99vjBrpZWhc3pq3QURkz3NfRQarzZU?=
 =?us-ascii?Q?sn0KwGtYbptTqmOdqusC4DVa5CY+QrPqgub+0XnjL7zoLkBGKGAqdz0ixAHJ?=
 =?us-ascii?Q?t0M8kdEn25+FPk9h/Aq8goN1GDtwNpD3FNy83PXTQnlYeeAuotXgxadPoO1d?=
 =?us-ascii?Q?EKQsI1isiQM9ujVLrXg3qoqLo6EYS7uQlxbAHlcxaS1Ctho2iVIIvt+9Yf5R?=
 =?us-ascii?Q?EurX/lzKLk8OaQdm8lZpiCnM3NuXTHcQugK9zjiJ1Gd64Md2689ttJgzdRuu?=
 =?us-ascii?Q?wOCvZpGnRQqrBpv7iPR8bSkgTxAOkMrHc1RvBtKRxulpTsK6gZhQUWJWKtIY?=
 =?us-ascii?Q?xj+WJZnXr7AZoo29MNDVQBgH3ksNLyLfc7FBhmmieBBOiZEdBz2uOhRYvVQz?=
 =?us-ascii?Q?Ck1DQaYXz12egv1JgQ0oX/QmxenC2JAWQi1l+xQ62mtWiseHJt8TspiKp72Q?=
 =?us-ascii?Q?tIXZxfniaL5DMN46MU8=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 1e6fcc32-309e-4ec7-5a82-08d9bc0e6308
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 18:53:42.7940
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: W2G6Mhqc4Ks+bN8aeuvzNFO+Z9WE6ZtdCQlaay6pND8v7PsnEl5Zlgtl2BkLKn5t
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL1PR12MB5363
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 10:18:20AM -0800, Jacob Pan wrote:

> > If one device has 10 PASID's pointing to this domain you must flush
> > them all if that is what the HW requires.
> > 
> Yes. My point is that other than PASID 0 is a given, we must track the 10
> PASIDs to avoid wasted flush. It also depend on how TLBs are tagged and
> flush granularity available. But at the API level, should we support all the
> cases?

Yes, iommufd will expose all the cases to userspace and anything is
possible.

A scheme that can only attach a domain to one PASID is functionally
useless except for this IDXD problem, so don't make something so
broken.

Jason
