Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D9CC4707A3
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:48:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244635AbhLJRwb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:52:31 -0500
Received: from mail-sn1anam02on2081.outbound.protection.outlook.com ([40.107.96.81]:50561
        "EHLO NAM02-SN1-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S230526AbhLJRw3 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:52:29 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=dsQSzqYJt2cIK56FU9YJfJ6Vso7WfL/a987HtzizJbXl2iBEIyaYsUbTRFSjXZNKzx/yXu1L0f6w7heXgRHPhVOdD5ocMD5AIqOOL0n5nzzlJTwYG1YKee1mvzWg3qwzAvlpSW3ZRZmVal1LkoECL0onJzrJaVracYH9loeVIXi0DcqSlgXv7HWctFMK2EU6H5WMqtKg/C9h3iuKGtQpcqGqWJzB48mc3adc9jv8OAtMy4o5h/rD7XSv8aVz8XdRC3tHus2068N2tkNnmDSCMGy5T8QxkasjhLyLSWeYrlGKmXAJ71HmssRmBa9mVSy1grDodwxn8afRgplHB8BAIw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=8/0ZXjwj1NIv3U2OVT4Ql+ROMFrTe5ImH+dhb7aszs0=;
 b=H5ywAXc4KGMdlK0OTrtFVGHNxZrKeGX7lABj6PxLOChyQdSti1tubCsJSOJ91YGtMGfn1vqweya3Z1eCa71QuvdTujLVqpmQwcktMi5LkUuHX6nIZLnfcrXg8rr167SpicEBBQMiIqgPmEZOVm31pRwzo0uEIyukKKiXqzInaYuNci+mQCJkxsxKd+unDi7grYJnAf7MSGDUb/3pGjDhj6Ijs0E3gfkQ+iyAOmd/a870R0/tl1qoBB9RtAAjaMp4TUlUjWuAxd4bP/uFC5uoLaGRiTPkAfzSILCOv9HNuse5bcL8OiorLucJbg8egwaQMAJ0Fei4sVFf982MOO+elw==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=8/0ZXjwj1NIv3U2OVT4Ql+ROMFrTe5ImH+dhb7aszs0=;
 b=L92iLo5zJombS2rBzRm1cdkNOT64CX9J2eDJ/wSpUM3lC4xb7N7Bh0QxdHRow6rMNIpUMgHGArfCj7kNNQjZz1xRI720MqOLQ57FG6tSSc674ZqLUWhtwBXOA9xcCYDjVRwBH71OfjzmQLJTiU4PXfG14kyHOBoRoxHcXgYobMV+/gKwOJwaF0GrwOv9U2ao783VkuN/D+bUDOVOiO5VK6tS0Sen+FpLqoyC0zhqgHPlC9CQcRUHwTNW1hnYTYTJPpoe3Lt2B1rMYI0tkHaRg3qJ7AsjUN+5U2O2YPwpJUT8fvwzyPGdjUL3CTrFS4oo7Noz+r0ISKQxapRaSsrbhQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BL0PR12MB5506.namprd12.prod.outlook.com (2603:10b6:208:1cb::22)
 by BL0PR12MB5539.namprd12.prod.outlook.com (2603:10b6:208:1c3::15) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4778.11; Fri, 10 Dec
 2021 17:48:50 +0000
Received: from BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11]) by BL0PR12MB5506.namprd12.prod.outlook.com
 ([fe80::d8be:e4e4:ce53:6d11%7]) with mapi id 15.20.4778.015; Fri, 10 Dec 2021
 17:48:50 +0000
Date:   Fri, 10 Dec 2021 13:48:48 -0400
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
Message-ID: <20211210174848.GH6385@nvidia.com>
References: <1638884834-83028-1-git-send-email-jacob.jun.pan@linux.intel.com>
 <1638884834-83028-4-git-send-email-jacob.jun.pan@linux.intel.com>
 <20211208132255.GS6385@nvidia.com>
 <20211208111659.6de22e52@jacob-builder>
 <9f724b3a-6028-43d7-b4fc-d8a939e7b2cf@linux.intel.com>
 <20211209152113.64b817b9@jacob-builder>
 <921a766f-d826-2ca4-f739-4d196b32a681@linux.intel.com>
 <20211210095025.38af67ce@jacob-builder>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20211210095025.38af67ce@jacob-builder>
X-ClientProxiedBy: YT3PR01CA0058.CANPRD01.PROD.OUTLOOK.COM
 (2603:10b6:b01:82::7) To BL0PR12MB5506.namprd12.prod.outlook.com
 (2603:10b6:208:1cb::22)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 369a3467-fe5f-43ba-35cc-08d9bc05532b
X-MS-TrafficTypeDiagnostic: BL0PR12MB5539:EE_
X-Microsoft-Antispam-PRVS: <BL0PR12MB553994595CE8CE9FC6E1E40DC2719@BL0PR12MB5539.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:7691;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: eqJELN2Y/G9j+WvgnNXFrSieowtsUidt8krTOegLmd96Axx9cIh+st8lIZAOqdGDImshwtkUdHU4HaJDPZrPWlrsz/vrjtw7RNcXY6UUrykZtXWd2si5KTmD1u+fJrvmSDF5InFn7Fxp4vBRu6Wngd37HGH4hlH8+cu6J0q3H5Kr1eOUzKFsL4q+3NBufs3fI1YaU6KzzVCR24fDNtrZrCdf602dyKtS+AXj5rDUxN6qE5RXDF8zdS3aCF8v0+sQsYNTuZ3m8zNeI56KD80ygLZ6ovY9ze3OvnUBDRfs7bTdLApINUB33smXS4AAeYa02Cg5P32LJTV2fx6OQ49lkONhPhPQBbbYvr7cH3ZKBuKwXz89a/yH2oMubWsSCpFpRMyT99QgylFas9ICoVNYX1ZEohFBMs9TJxgRHfaasAPwlibDn7Ezx09iHnN20xnJvci4ZeQgzLegDDM55P3xwJcIU7Wm64tLTUELcSSLuYsDrot3sB00DhxrWfFbHS0tPISpec7MG6QmrJdf3k6Zs2PyS5BGOtuamzGdnGcZgeo1UALcuoxCjvq7D/iUa9hS2ZXMnn0shB+UXCxroaMcFnMnN01xrWwyZ52B3X0rKLvGhbmJM/EgTuXtZiFOCK9Z6Zo4FQr6z8etVGklolulnw==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BL0PR12MB5506.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(4636009)(366004)(6486002)(2616005)(54906003)(66946007)(6512007)(86362001)(66476007)(66556008)(508600001)(2906002)(38100700002)(7416002)(26005)(6506007)(8676002)(33656002)(1076003)(36756003)(5660300002)(186003)(6916009)(316002)(4744005)(8936002)(4326008);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?0TWRHduN/3HmuS9VtjNsJY9NIbwSFb1RovjUmPY5dLEwHXQp5lrz/GkpmsG3?=
 =?us-ascii?Q?+87TD7DiBuapd8ms+H13VoqAUyH4SzK34oINJT0qjRzJGmVMJQCIewqNt6ZF?=
 =?us-ascii?Q?QNFHH0roEkQeO5evIGLLOY2iBElmF3JGx4UFNJAqSm3q0XXAZNzlW/7AUiZy?=
 =?us-ascii?Q?Wdfyoe+68V8v111O2DDpoDgmTfhqMCWLWKwk40i8TxwW63jklKM9nSWeSSdD?=
 =?us-ascii?Q?HB/qaoUNrjdKT+/dPBYHF5TNcJz7w4i2UPyadlDW0bd5WYy5kNAduN5odGYu?=
 =?us-ascii?Q?BfFOCAQl+kJqFF97h+cqLYx+ATnFkZ/6nPWHBy0XHD+2e+Lzgh/xRPkrhVwu?=
 =?us-ascii?Q?qWzKIYozGI+qupbUQ5tDvgsFcUZbEy23DDUryva9FbjBM35cZoiX4X3+O+yG?=
 =?us-ascii?Q?hFc5j7kAxgSo8EheC74gBKTcGQX+ReXGWYfWiTJPgBaz/Ou6WfFvC48wXMWL?=
 =?us-ascii?Q?GzIOikByAav/RJ7jydQJahhQT288vfKdBeRudh47BKkTPUSgXtDYBzzsfpLt?=
 =?us-ascii?Q?fm8TMvhQbysRZzrQTYbUdTAqdk9ihuxmp4M/WTMShX6rSU07YUb2g6ATNW+d?=
 =?us-ascii?Q?YwKrthvZK+2kJraZgMsaEde0ieoPKqJ/c3ywCBlmDSp/5vGDZNfWmCLs/OmR?=
 =?us-ascii?Q?+aTgWivicYtgO2AbUW422hDq7gKJRhgHJ4/vZb38lDxoPWOACF7dKsol6gO+?=
 =?us-ascii?Q?kc/swoao+HuG1Wlo5VLkL9arq063JJjWqDgfyVjlr4dKyMS0tIOrS6a1fVL2?=
 =?us-ascii?Q?/PMFxtXMJevHNg4QAxXJivlJoWSG5pLp8k63d5AGoeHr+gyMK+/aoE3uVrae?=
 =?us-ascii?Q?fxwWOmzkIKIbNghM8hCWIDtm2FQPfvWO9v2u8Iqyj3pOTJMrP6gxew3n8DIQ?=
 =?us-ascii?Q?4bLLgg9YYEqPBCrxozF0CTKwwOHnwBio2bFyLmhSNTikZDgpK5Yg07Ovea/G?=
 =?us-ascii?Q?t/hvpUVKhZNxLe99oEFmxpBLOMygQ5BaDO0u3OZe2Khw7OIKhUWQL2rh/I9y?=
 =?us-ascii?Q?LyQ4M8Zca6+WcM3ape2/hd12d9VHj1QxbokTaKeJVBF93P/O+1A5Z/nodCiK?=
 =?us-ascii?Q?IPtNcU0ZZ/FV9Oe9R63JXM5WcaBJVzWBhaa30kixgJSBwfKiULfI6Fgw7lrq?=
 =?us-ascii?Q?re5YrheXP2vLNh7UIqn2XB7z5J1mDf1VQxcaoyWHIwKjXFJDop1JI+F0dnN4?=
 =?us-ascii?Q?HhZt1oAndsAq+PNuJNjB6NZ/s6OArckJPZO2evUepZDdWROYlK37Ll0v7Yg3?=
 =?us-ascii?Q?uv/Y18Qb2wt12ZbINjETtA3Pm22vIprhHvWdpshy5FP02b9mHxvaT3zMa9kH?=
 =?us-ascii?Q?LUy92FvAu01QBmDSznzlnlHIaZU/jyg6/9bZn749nP5ETcxCJb15yycjP4+f?=
 =?us-ascii?Q?etFIkFpfTICGutwRYxv3FDE+1fyGR6PUg77RMwrV9Y44xPagEdBlUahAPArP?=
 =?us-ascii?Q?HBTTYCW+LUD4oN4KKc4txM2naRsWtgL+jlxGC3qFb6dfxmTyIaCq94FESitN?=
 =?us-ascii?Q?iKJK4QzDrP7ljostaoEUrhQGMbbwQMwChjMZjmz2abfPvRN5wQonc1Wp+C/D?=
 =?us-ascii?Q?22/YM2ynVmEbZP7eC7A=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 369a3467-fe5f-43ba-35cc-08d9bc05532b
X-MS-Exchange-CrossTenant-AuthSource: BL0PR12MB5506.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 10 Dec 2021 17:48:50.6772
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: oaHMsTEHespnlgPCfH1qFnh7G7/GD9d+n53TGVEAUMrwq7QcaavBR3gkcTDusEl1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB5539
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 10, 2021 at 09:50:25AM -0800, Jacob Pan wrote:

> > Tying pasid to an iommu_domain is not a good idea. An iommu_domain
> > represents an I/O address translation table. It could be attached to a
> > device or a PASID on the device.
> 
> I don;t think we can avoid storing PASID at domain level or the group's
> default domain. IOTLB flush is per domain. Default domain of DMA type
> is already tying to PASID0, right?

No, it is just wrong.

If the HW requires a list of everything that is connected to the
iommu_domain then it's private iommu_domain should have that list.

But it is a *list* not a single PASID.

If one device has 10 PASID's pointing to this domain you must flush
them all if that is what the HW requires.

Jason
