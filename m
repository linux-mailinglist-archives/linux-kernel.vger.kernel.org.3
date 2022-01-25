Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 0956949B77A
	for <lists+linux-kernel@lfdr.de>; Tue, 25 Jan 2022 16:19:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1582042AbiAYPTo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 25 Jan 2022 10:19:44 -0500
Received: from mail-dm3nam07on2080.outbound.protection.outlook.com ([40.107.95.80]:48384
        "EHLO NAM02-DM3-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S238472AbiAYPQN (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 25 Jan 2022 10:16:13 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=O669EKuCOWqwE7s2ljkE5hICzW3hrRCIYv7LrJEtSRNpOL428z5QjRuOHdFbjWeq4O6O3I43876UqddXLZ/pVpl7Hk7GN/JdLe1OAO2lEEXdGIInNkeXZ/YvW0Z4Gqp7kCVynH+XH1ICOZvySx2onnhU9fV2BRKU7JYHZJsdkTVNFusLsLonad293uyxTvHvd4kEGjonPAftfUXQ5NSpLwxvrxlylW20msXtx6RDFLWBPZ4Stn57fXO80bK8PRDzUgfeRKRNGCObz8LIodSorW3QoPf7ES2+21//4P5v2ZKgnSOAGZFWBSGT+SnjlvyZR3oo4i3U4Nupsa8l89Gb6g==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=KHGvXQ78QFu7KagOiUqMS3vQ+pwUnAqPSdOGxLtZZW8=;
 b=FpMdVWRzS69o7RClzY72ng+32mhMs/VRnizbJze5CXdd/RGhOnjoUwsEGIPDRu2M3vPnx5I5apvqAGQl+5hYAkNTqSSCPR8yoBiqdmWoGMq1MbneflxvBB0a+hnQT2HzZlH95+EezfnNh8KzVv5UVwt2NZGaX6SrCPxtiu9qgHlP1DHApPcCoWXoNFAu7OmTxk9nhcyPpMF0r5iEZF4lcnpRN1ogOwl9Vcfx9JNFvtCNgNAXoCkuNJCdRjP/pTgEMPVmDz8pNKZ8VD7hOmYMZyPYnYCOSwzuwARBBLbS/+R6poGG5NPrk4t277sFgSnaJN9oRSGL/v0iaMn3pMD1ag==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=none; dmarc=none;
 dkim=none; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=KHGvXQ78QFu7KagOiUqMS3vQ+pwUnAqPSdOGxLtZZW8=;
 b=cFVhMEuT3onMSEre+UGsKXbL+KZBtP22RZpSTE+M/KUlMwo4Lm1z3Jyi/DzFnkdWIQtNEdA1yIgXSq9Uvz0xoZzdCyeogeEoWIw/7t2fftDadf6iJqqpuOdPahnDlttd6jfHuLBBF9p+X++3hYmY6lQKeOOjbj0jpKr3Nr9XmIOgmxyZ+0bKOi+H1pfG/In/C/3+V4KhD3H4RbArHrpm25qTyW44Fuj51Gpk00LjvqfEYkvMUrjiGfqGhVUmAzUle7ULp2AOiS4DAg6klrVJXyIclLLlWJd3P6RR825lwkyejWutuhE9fHKDbt4U9xtnGQWS3NyR786Zd8yoqkW++g==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from MN2PR12MB4192.namprd12.prod.outlook.com (2603:10b6:208:1d5::15)
 by BYAPR12MB3077.namprd12.prod.outlook.com (2603:10b6:a03:db::10) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4930.15; Tue, 25 Jan
 2022 15:16:03 +0000
Received: from MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2]) by MN2PR12MB4192.namprd12.prod.outlook.com
 ([fe80::ad3f:373f:b7d3:19c2%7]) with mapi id 15.20.4909.019; Tue, 25 Jan 2022
 15:16:03 +0000
Date:   Tue, 25 Jan 2022 11:16:02 -0400
From:   Jason Gunthorpe <jgg@nvidia.com>
To:     Robin Murphy <robin.murphy@arm.com>
Cc:     "Tian, Kevin" <kevin.tian@intel.com>,
        Lu Baolu <baolu.lu@linux.intel.com>,
        Joerg Roedel <joro@8bytes.org>,
        Christoph Hellwig <hch@infradead.org>,
        Ben Skeggs <bskeggs@redhat.com>,
        "Raj, Ashok" <ashok.raj@intel.com>, Will Deacon <will@kernel.org>,
        Alex Williamson <alex.williamson@redhat.com>,
        Eric Auger <eric.auger@redhat.com>,
        "Liu, Yi L" <yi.l.liu@intel.com>,
        "Pan, Jacob jun" <jacob.jun.pan@intel.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        "iommu@lists.linux-foundation.org" <iommu@lists.linux-foundation.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 0/7] iommu cleanup and refactoring
Message-ID: <20220125151602.GL84788@nvidia.com>
References: <20220124071103.2097118-1-baolu.lu@linux.intel.com>
 <BN9PR11MB52767F46CC13601306001B9E8C5E9@BN9PR11MB5276.namprd11.prod.outlook.com>
 <20220124174404.GG966497@nvidia.com>
 <7febcba4-f5bf-6bf6-6180-895b18d1b806@arm.com>
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <7febcba4-f5bf-6bf6-6180-895b18d1b806@arm.com>
X-ClientProxiedBy: MN2PR16CA0052.namprd16.prod.outlook.com
 (2603:10b6:208:234::21) To MN2PR12MB4192.namprd12.prod.outlook.com
 (2603:10b6:208:1d5::15)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c5a3a866-9692-4879-2b0a-08d9e0159a2b
X-MS-TrafficTypeDiagnostic: BYAPR12MB3077:EE_
X-Microsoft-Antispam-PRVS: <BYAPR12MB30775192D9525C3CE8F9FE87C25F9@BYAPR12MB3077.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:9508;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: s+J0SKBa5DofkRSV+vpHFr9513oa/N4z+JKVE47Pxg8LLvWry62dN0Snmm+deI03NhnmFFBoPSL33WUVQNuCzfoeDDS+OpfZpRPv8LfngEsfxu6FT2CmX69JPLbhnfYBroCn5uVO/BWZMWjrUQuEExmX78UlP2cEuGEQ3W8aypFPJRjoJ67JAQNu9zdxxwmu9Ws+2j39a3MhyW4E3F7JdqdIF/87/ASau1PfyDFGtFHkY3QF26adx8h351XxMAhQBhSZvfwKGwyLvJtCD5Kw0WvJJDUr9/YSZC9INpSXCzb56g3reiD2+K7YTvAdr4SN6cqFERSiBSZNDXQtxFi7DFuf3PE+Vf3Jz/aAeSuENlJMUYhQ2DfBNWC9t7DfnZc87oYBZRX1W2QW8aYfJ5coFCP828CeYhWA09d0lSqnp/B4bderM/re1131qfUkzbTBT7JABEwEzcD8YNJoAWn2wiaHDPD9h/k4Z6ASfc9o5sfK072TP9R2X+dhHVcgLwom1bxLqXQupps5oG8Pms7S9T3fBZ5aegdWXe6X685l6/+t/DsTuesucDVDcqEspo1M0gR3A8GFhiNC2ZegQ3N8b6vSSnrS7ed0AFPVmuc71tjK9GimwUJuoX13ny21hTLAtv+GK7MvnHnyvhnZZUvhpA==
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:MN2PR12MB4192.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230001)(4636009)(366004)(508600001)(2616005)(54906003)(26005)(186003)(316002)(33656002)(66946007)(1076003)(66556008)(66476007)(6486002)(6916009)(36756003)(5660300002)(6512007)(8676002)(4326008)(7416002)(6506007)(8936002)(38100700002)(2906002)(86362001)(20210929001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?us-ascii?Q?3ZwYLpIfzEs+DIRHdmtlIgSQy7ETqCC/scpj9yn0uuEnRcMAi4omVewX8vQd?=
 =?us-ascii?Q?6Dhm/OwGTkAkJ/pQU9BuCsUZN3ZWIc5YBt5o5l0K6gx9WS1OWrMGBQM01lNt?=
 =?us-ascii?Q?UhgCtSwkZsFW+i4u0ucDtossJSFEtYLFbc6+LbVVoRahcI9WwnyhwcCuHqYG?=
 =?us-ascii?Q?/RYbtiyI4sgVbl23TzFDq+T6kcaN3PqVOFa1kLKLw0t2AoW528h0Ai4v5UC0?=
 =?us-ascii?Q?WZCuKIzoe//w+FMAALVdchtgivncPwMRPCXMSuYj1zh8dR8Ggtg/hbGZg/3z?=
 =?us-ascii?Q?9WiTb/v010gO31a/6P3RJZO/LzDvN6B6TX9R7J7AVBTE7gabnkdRPmqN5auy?=
 =?us-ascii?Q?CMQLdXmbp/sJHiVpv8aJJurrxEGrA+NMOrRYGh2RCj8rHrbe4J5KDZNP1iY+?=
 =?us-ascii?Q?8yK8oqDoQewZbgs/4xQAIyxWHDE+amGl6/ydhp7QzbyovwN4L6aoM2jaaWgy?=
 =?us-ascii?Q?saNn7qHfOCsJ5KNjEBFy8kfs4J6yoqfqlSPY8dtTDnW84od9DDQcpKD/FBDb?=
 =?us-ascii?Q?B4Up54AU2pBymfvcy2tADqvsbxaR5oOvEIa1H3nWhenvTAun0gzQhqx5zuhD?=
 =?us-ascii?Q?VdVp/I5rzjLR2Qn9oZ2wCWZtMPkUucT7ORiVgEKcTeW7pA/jPIOI/yvGp7h9?=
 =?us-ascii?Q?MHJDczV+TmsvpOaWxcYlmD8pen//3LPnaxqAN/5FIqJC9fv0U8RjDnup3rCe?=
 =?us-ascii?Q?9g5wLZAPEZIdK5/BsobfdioBkHasVt4fTiQNJZJs/MNGOYiqa32K662FFMt9?=
 =?us-ascii?Q?w/HZQMhIlW3IU/HQ5i2jLN5d9akna5e4EeOnoYQXVeUrDM0UwDwPXdNnxipD?=
 =?us-ascii?Q?lBCmbi9bc48fDda5AfTC5XzTGgD0YzkfGQvhu6gyHF25tFZvVp6b4PcUxfJB?=
 =?us-ascii?Q?oZp2X0Fy6/a2JNHL4tvA6VJpw5EgHNM3s6HIV4A90KE4GD3UDJrR9fiSISwr?=
 =?us-ascii?Q?hpOJ27pIQKPoIIiYbENog4Ug5CMidqoMMRcgf26g4NQCf3bMD7LXhj1ygsrq?=
 =?us-ascii?Q?7LuS+wQmBlz6gNCpzigYKoTJbFMiafHARhakKbU8mPkKqsedGIeHYBTRVOIW?=
 =?us-ascii?Q?UE3RlfZRyL9rAEMNfkhs9onsm3AiIxgTyRntiWyyiYMGd0HOGAWJdJGWPkJs?=
 =?us-ascii?Q?rnbUZdallMfjh+cmkEEIvxkzxyiIvBTyicynetIr2uR+npx55snBXfnIAgLq?=
 =?us-ascii?Q?MKa8nU0we6WdukQkIIXmXz2zQACPYdJdXAKs3sN43iZE0cUy8AoPqDG9HT0B?=
 =?us-ascii?Q?MS9PHeoisRrhx7OXhgY5X5opBo2jykI5ZGGIo5biNqgFWRqoSARmDN8s6H5S?=
 =?us-ascii?Q?ABNEM/mVh7+P3Uyrgq2SughkcXcon2REkVZFBo1xkMVa7bO95pvOr8eGDgHb?=
 =?us-ascii?Q?OPlvMliO26okBzU4A9SsVyPoqXbO98i0ugbJa78wPM62NTPCBezxpRe6fb7P?=
 =?us-ascii?Q?2i4fzqudAxEKd+/RhaYZQJ6TTNxaO8wrg7wTpnmyvvp42Ixf/jVkSpYOAmth?=
 =?us-ascii?Q?K/RBrfx4oOK3hTdBnGko646w2cnEdFpQZf0zzxmuwPl8xoQFj0lrW+TRkxnD?=
 =?us-ascii?Q?9K8vFSaYH86OQOI2fRY=3D?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c5a3a866-9692-4879-2b0a-08d9e0159a2b
X-MS-Exchange-CrossTenant-AuthSource: MN2PR12MB4192.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 25 Jan 2022 15:16:03.6497
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: tXyDcFzAtE+nyECXXmYxXt42KMrVny98o4veJFhPqX/Ya/dpmPtBkmQyOXWwiXs1
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BYAPR12MB3077
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jan 25, 2022 at 02:48:02PM +0000, Robin Murphy wrote:
 
> Agreed, certainly an IOMMU_DOMAIN_SVA type that can both encapsulate the mm
> and effectively replace iommu_sva seems like a logical and fairly small next
> step. We already have the paradigm of different domain types supporting
> different ops, so initially an SVA domain would simply allow bind/unbind
> rather than attach/detach/map/unmap.

I hope we can quickly get to a PASID enabled generic attach/detach
scheme - we really need this to do the uAPI part of this interface.

> they are fundamentally different things in their own right, and the ideal
> API should give us the orthogonality to also bind a device to an SVA domain
> without PASID (e.g. for KVM stage 2, or userspace assignment of simpler
> fault/stall-tolerant devices), or attach PASIDs to regular iommu_domains.

Yes, these are orthogonal things. A iommu driver that supports PASID
ideally should support PASID enabled attach/detatch for every
iommu_domain type it supports.

SVA should not be entangled with PASID beyond that SVA is often used
with PASID - a SVA iommu_domain should be fully usable with a RID too.

I'm hoping to see the core iommu code provide some simplified "SVA"
API that under the covers creates a SVA domain and then does a normal
PASID attach using the global PASID in the mm_struct - the
driver should not care what, or even if, PASID is used for a SVA
domain.

Jason
