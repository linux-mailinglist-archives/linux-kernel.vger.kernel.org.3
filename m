Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14E824F7443
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236916AbiDGDpI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:45:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235649AbiDGDpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:45:04 -0400
Received: from NAM11-CO1-obe.outbound.protection.outlook.com (mail-co1nam11on2096.outbound.protection.outlook.com [40.107.220.96])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 373C8140BD;
        Wed,  6 Apr 2022 20:43:04 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=gAAI7NweEZhV8aKUFy1v2g2Aqf/G712BLHN5pzry4ixGnDzuMHR2A4a0v0m/nMd+BiOIJIExG4gYxQqCzopls2lZCYrKo5QKDSRpIM3GMCFenvPJaqycvBMDCJghb1zyv2p6aE3xlWCtbqQgc1TCwnGZTap+FN96vqadPbosIj7rQiHCmGPrTr0v1m+NFSSdiDDbgEEmfWtgij7YJ34Jq4P+1UtyFOor7c3dPZxPCymA0Ovlwdg2xm4LyKs4qQTov0+R0iNhZ/+5urmO6bFydjATq0+058GA7HbJfZ7HjM190ynJB9s8q9JXE+1EC8UiaOXpOwX4u0ede8vXNYDPBg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=yZGz6eXuWWkMOFKJfw2DYr7RB4jTb/fXF+KUdwNY+28=;
 b=Wma5xbWJlG8/6xJLkrGYIiD1kU35F9+pjixskcHpg8+H0c0vD85VrScv5B3C8VwcX4wX64ExZQFVsfk77s+DCckryIOEefnc+4JFm59Yn42kQV9yxO6UqYaDquMDPyicAnEgKxj0rPCVErzW6A1IUxuj3Z+RKCaaE+/ltbYoOGmdgxA60gWZUsMjyhRPcdARSv7n2vsWh5VfjnBseo0rYRyEzeHw9oLkNdpE0RnH4aO/5AJ7VJ3jOhgz38N7AZYtcdulrsHcLNxNmjOh4X+Uwm4GdrQGM6YDNrOm2aU4WMnhdIBkBZPEHIJl2PviN33GFNnyLozkz18r0W5nUISr1w==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=os.amperecomputing.com; dmarc=pass action=none
 header.from=os.amperecomputing.com; dkim=pass
 header.d=os.amperecomputing.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
 d=os.amperecomputing.com; s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=yZGz6eXuWWkMOFKJfw2DYr7RB4jTb/fXF+KUdwNY+28=;
 b=Bs2LFfO/L9xJgIV7QNdA7evSl3p87cGQzxXZ8q5DZOQTqaVtU59zBIdknOAYshUXR6Ba+lqmpYbI/b9bUX6ADWetZxANav2CjzMGPl2JbwrfRkaGXOmBuveDQZr2A+UeZD/cknbEGtm4ApShaD1p4zKCzhIr4hzd6jcOhKBqxi4=
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=os.amperecomputing.com;
Received: from DM8PR01MB6824.prod.exchangelabs.com (2603:10b6:8:23::24) by
 DM5PR0102MB3511.prod.exchangelabs.com (2603:10b6:4:a9::17) with Microsoft
 SMTP Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.20.5123.19; Thu, 7 Apr 2022 03:42:54 +0000
Received: from DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::110f:73f9:cb5e:b9f5]) by DM8PR01MB6824.prod.exchangelabs.com
 ([fe80::110f:73f9:cb5e:b9f5%3]) with mapi id 15.20.5123.031; Thu, 7 Apr 2022
 03:42:54 +0000
Date:   Thu, 7 Apr 2022 11:39:36 +0000
From:   Huang Shijie <shijie@os.amperecomputing.com>
To:     Yu Zhao <yuzhao@google.com>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>, linux-mm@kvack.org,
        Andi Kleen <ak@linux.intel.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        linux-arm-kernel@lists.infradead.org, linux-doc@vger.kernel.org,
        linux-kernel@vger.kernel.org, page-reclaim@google.com,
        x86@kernel.org, Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        Holger =?iso-8859-1?Q?Hoffst=E4tte?= 
        <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Subject: Re: [PATCH v10 14/14] mm: multi-gen LRU: design doc
Message-ID: <Yk7NeO2e3ryadNEu@hsj>
References: <20220407031525.2368067-1-yuzhao@google.com>
 <20220407031525.2368067-15-yuzhao@google.com>
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <20220407031525.2368067-15-yuzhao@google.com>
X-ClientProxiedBy: CH2PR20CA0030.namprd20.prod.outlook.com
 (2603:10b6:610:58::40) To DM8PR01MB6824.prod.exchangelabs.com
 (2603:10b6:8:23::24)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: c2f41451-daaa-494b-a3cb-08da1848b28e
X-MS-TrafficTypeDiagnostic: DM5PR0102MB3511:EE_
X-Microsoft-Antispam-PRVS: <DM5PR0102MB3511FBB9A5ED9D3C81A37D1BEDE69@DM5PR0102MB3511.prod.exchangelabs.com>
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: dHvvfJ3fkcvYbEcra241yzOxu3VfGr08YxIN8/AgmObsKOxk2kIw6PXjCLOB/+B9ZT/xspxru0XiIGFy0Y1UXnW+3+G86iw9wigSKxmn3TNFrhu3jijGvQNC4vFpKt6zojHLHBV7n7zWFAEWWJmoFnseC1f+76jUCNaWma4afr49KyAB1B9394rZSHtuFnkcd9IUtWEPbUlzezTlzlLVPocLbHMpN+V5//MeAuR9y0a/53RfjurQ7z/NOzBi7K4qwj9Ge3iSWJe7yDX5tcgXxNnwR+ME97FvpY7QwgecXz0Kol5K8nFbXva7U98RMWeWgvLTQFFoN+OvLLq7K8+BkT5IPYzXVOV6f3I1u2jLJ8TGxE92+Gr5KCzWehi0Yv7vMAIFFs3RIWH5E4onnwixqa1NUC7PFg9D0yU0s4DuOIyHuhlEENhel2xf0ZXcxn/D11dgvam0Hed2/41CzH0aPnLnh6qsUUPlm5Hzgd2D4sQ62hoNqmlUfj8ruHMFEjM8JPm03YXEZ8V9VSVZ0VfQwjEom75ug6TO1aui/d4DgTImhkuPjT5ANVDpBc1gI2iUz6mL/3GB9M1V552ceI9MA3FPvg7LDC3h8yt3jDXGoFJUazY2RdCl+i2V2Ik/mtL3+fevwsGebwh8JTOMhtCbpDxR2xVqWqto12gmnzqpL3/nhzkrNNdxpTdEOT/SrXlzIhCWzwUo5kbCxOGSvQ/9qsp4TjFvoDTm52OeFZWwTMI=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:DM8PR01MB6824.prod.exchangelabs.com;PTR:;CAT:NONE;SFS:(13230001)(7916004)(4636009)(366004)(5660300002)(7416002)(6916009)(66476007)(508600001)(86362001)(7406005)(6486002)(54906003)(2906002)(66556008)(66946007)(4326008)(8676002)(83380400001)(38100700002)(6666004)(52116002)(38350700002)(8936002)(6512007)(66574015)(33716001)(9686003)(186003)(26005)(6506007)(316002)(23180200003);DIR:OUT;SFP:1102;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?iso-8859-1?Q?0njzo3f+NuHfkdW3St2mKFuwcF0OGAwiKDAtaB8q9JlvMg5k9BTQkxC5uL?=
 =?iso-8859-1?Q?09uaOzyZm//76qI3mIrunRuu5kGEaUy/pXRuifsf9EDvrmtoebxI69pZCv?=
 =?iso-8859-1?Q?WRJkZJCzvgPPwlyMK20aOwVMkuv8or1A60Tv6lNR6Fro+TlQc8POG1WB35?=
 =?iso-8859-1?Q?GgRWJvBUrK5wYN67825+1ZqglexZJr8Nf4x5/IlNrCZQJTL0UVFUyQC3gB?=
 =?iso-8859-1?Q?rryPu6isBKFpWkDRCSw3kb3FLP7Tp/YZuJ+3D3p5s1BnnrlqEtE4LG5TsE?=
 =?iso-8859-1?Q?jWlid+ha4e/+1ISDF8p/RqjlYIup9w/VX6J8dbh/MpluTNZR/Ku6zj92cj?=
 =?iso-8859-1?Q?+HayrQiai0PcFUz3CHVO3ouaq7DzC+1dLc+QoMoUCQXex4AsXGcpuqBUT7?=
 =?iso-8859-1?Q?X1PwhutUOCX3fetD/lQPpcIqtgIDKOvHhPZDTJ/EvSdl+8x8ywvRsXXr1h?=
 =?iso-8859-1?Q?5zs1MI2c+A5aRbRF22Ykc7S5SWV0hcumWvPME13Thmt9jfwy3vyvY7DxIS?=
 =?iso-8859-1?Q?cJt++QyzUBel4UZeqz2dZLMFM7ljq530YF5UQgIm2LN/Q35TTK5IYaghSx?=
 =?iso-8859-1?Q?OhRdGdw+9aUe41WGwqhPDqay9iEBAencHoynpxOcn9iVn3/MegQQEZ/8Iu?=
 =?iso-8859-1?Q?28q+nzfKmND801g7e0NefApZZAhrKiAiBHNVbrvrOi6iTiaa1tFVtKCUO9?=
 =?iso-8859-1?Q?m9XlllqKFdj6FppPRbqT+VJv7+4bifiO7mnKIbEjOxIHwlZ6LsEGsU9jC7?=
 =?iso-8859-1?Q?XVoN9/FijKvpk26EsJ+u6peuuqgwHvJRUmqCvUBFg7xjx15A9dmnhufVxn?=
 =?iso-8859-1?Q?i9kuf309YyI9OXaz8vLrtF8C9rX57q8Ck4WvQSshNFY4PCSy41ZD+1+3/B?=
 =?iso-8859-1?Q?QB08ysYxUPnlBvmpiiuHNLogUi+acHO9/K59pPudWL7ZUv9FLepAQjKruU?=
 =?iso-8859-1?Q?oeHqRZb2ctn1ajV+CSuZXXNDkS7T1TNhT7hXo1mKQx5c41cvIJGcI0lawi?=
 =?iso-8859-1?Q?qBRgTHq8vtOKZorS5KEbKGToKdgNOZzoF2EzNxxldpyKNCQK4k4pbXKCac?=
 =?iso-8859-1?Q?j594KLRdGYnZnfQmmJSmWNI2s8N3oS4VT7pevXJK0IV+6HYBvoQVfQzqHQ?=
 =?iso-8859-1?Q?4az5LvF+ymup3KOWdCXGZDbKZ89dK+p5pyLLr/MuHml5Drora9f0TRgDXK?=
 =?iso-8859-1?Q?Ej8k5a9Trsh7pOKQGBeZ9KcY29Dz2zMgTa/M4dOJtIE6C50zp+7itG5paK?=
 =?iso-8859-1?Q?63dJcPrgRkgUn+cSZYOrmPJcGsjt0B4wZkktOxfUQLpydUFPevE/uEzQGB?=
 =?iso-8859-1?Q?4MmzwtEpxBqdMgBIIRr08Uu7i2TBEArXnJcLSnkpOkl7iFXmzKS9WGISJL?=
 =?iso-8859-1?Q?wL/jvxT+CsG4FYSGx+sSSXRb1Kww2skumqK4Mg0RtsuTpifZJbhsb3e2Te?=
 =?iso-8859-1?Q?Ep8yUScci1Ds/qIqIjNKomJwopwq21CcsPm80IIg/w0bERoDZn3MsJzqfx?=
 =?iso-8859-1?Q?t1WOuClxcte6HDJn5MYggLLC7XBy+56m8X7AE1gx4txZEnvtSaFVW6/v1Z?=
 =?iso-8859-1?Q?kIillr/HInca1W8qAq7Qy0MhenxrTH+Iyva9C8qdBccJ17mbcH8wGm/ZM9?=
 =?iso-8859-1?Q?Zx5VnMzSOaYhNHR+58lt6uZjAh7mYIY1ph/y/sPfsR62Q97KHhLPUFY5mG?=
 =?iso-8859-1?Q?vV7MES/D2ShvJWrQxC800U7/3i2BdF0Goo2DlZ06L4wNth32XJPWl4G5ge?=
 =?iso-8859-1?Q?eLs9vrCFHznkFDmP3q3RgprI+RvhrLXsuNJZMENE0y/tbfbRpxZY9gJCaR?=
 =?iso-8859-1?Q?vQxSKGI1dKQUgN2yCJBgiV7e3PrFyVuPmo4xFNBMW+PGz5odMufS?=
X-OriginatorOrg: os.amperecomputing.com
X-MS-Exchange-CrossTenant-Network-Message-Id: c2f41451-daaa-494b-a3cb-08da1848b28e
X-MS-Exchange-CrossTenant-AuthSource: DM8PR01MB6824.prod.exchangelabs.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 07 Apr 2022 03:42:54.4374
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 3bc2b170-fd94-476d-b0ce-4229bdc904a7
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: hhFi8dO4qbnvTByEM4wmX1ugXsVGSBHEDtUFzLS8t/VG+/HDKt32y2oTtdufzOcU1ROZcNfMQMfQS/kj6AVTbB4y6PrzUDN/58hYEwd05O17JDU9JCtsXzFm5Sdwe/Nq
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DM5PR0102MB3511
X-Spam-Status: No, score=0.2 required=5.0 tests=BAYES_00,DATE_IN_FUTURE_06_12,
        DKIM_INVALID,DKIM_SIGNED,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Zhao Yu,
On Wed, Apr 06, 2022 at 09:15:26PM -0600, Yu Zhao wrote:
> [EXTERNAL EMAIL NOTICE: This email originated from an external sender. Please be mindful of safe email handling and proprietary information protection practices.]
> 
> 
> Add a design doc.
> 
> Signed-off-by: Yu Zhao <yuzhao@google.com>
> Acked-by: Brian Geffon <bgeffon@google.com>
> Acked-by: Jan Alexander Steffens (heftig) <heftig@archlinux.org>
> Acked-by: Oleksandr Natalenko <oleksandr@natalenko.name>
> Acked-by: Steven Barrett <steven@liquorix.net>
> Acked-by: Suleiman Souhlal <suleiman@google.com>
> Tested-by: Daniel Byrne <djbyrne@mtu.edu>
> Tested-by: Donald Carr <d@chaos-reins.com>
> Tested-by: Holger Hoffstätte <holger@applied-asynchrony.com>
> Tested-by: Konstantin Kharlamov <Hi-Angel@yandex.ru>
> Tested-by: Shuang Zhai <szhai2@cs.rochester.edu>
> Tested-by: Sofia Trinh <sofia.trinh@edi.works>
> Tested-by: Vaibhav Jain <vaibhav@linux.ibm.com>
> ---
>  Documentation/vm/index.rst        |   1 +
>  Documentation/vm/multigen_lru.rst | 160 ++++++++++++++++++++++++++++++
>  2 files changed, 161 insertions(+)
>  create mode 100644 Documentation/vm/multigen_lru.rst
> 
> diff --git a/Documentation/vm/index.rst b/Documentation/vm/index.rst
> index 44365c4574a3..b48434300226 100644
> --- a/Documentation/vm/index.rst
> +++ b/Documentation/vm/index.rst
> @@ -25,6 +25,7 @@ algorithms.  If you are looking for advice on simply allocating memory, see the
>     ksm
>     memory-model
>     mmu_notifier
> +   multigen_lru
>     numa
>     overcommit-accounting
>     page_migration
> diff --git a/Documentation/vm/multigen_lru.rst b/Documentation/vm/multigen_lru.rst
> new file mode 100644
> index 000000000000..9b29b87e1435
> --- /dev/null
> +++ b/Documentation/vm/multigen_lru.rst
> @@ -0,0 +1,160 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=============
> +Multi-Gen LRU
> +=============
> +The multi-gen LRU is an alternative LRU implementation that optimizes
> +page reclaim and improves performance under memory pressure. Page
> +reclaim decides the kernel's caching policy and ability to overcommit
> +memory. It directly impacts the kswapd CPU usage and RAM efficiency.
> +
> +Design overview
> +===============
> +Objectives
> +----------
> +The design objectives are:
> +
> +* Good representation of access recency
> +* Try to profit from spatial locality
> +* Fast paths to make obvious choices
> +* Simple self-correcting heuristics
> +
> +The representation of access recency is at the core of all LRU
> +implementations. In the multi-gen LRU, each generation represents a
> +group of pages with similar access recency. Generations establish a
> +common frame of reference and therefore help make better choices,
> +e.g., between different memcgs on a computer or different computers in
> +a data center (for job scheduling).
> +
> +Exploiting spatial locality improves efficiency when gathering the
> +accessed bit. A rmap walk targets a single page and does not try to
> +profit from discovering a young PTE. A page table walk can sweep all
> +the young PTEs in an address space, but the address space can be too
> +large to make a profit. The key is to optimize both methods and use
> +them in combination.
> +
> +Fast paths reduce code complexity and runtime overhead. Unmapped pages
> +do not require TLB flushes; clean pages do not require writeback.
> +These facts are only helpful when other conditions, e.g., access
> +recency, are similar. With generations as a common frame of reference,
> +additional factors stand out. But obvious choices might not be good
> +choices; thus self-correction is required.
> +
> +The benefits of simple self-correcting heuristics are self-evident.
> +Again, with generations as a common frame of reference, this becomes
> +attainable. Specifically, pages in the same generation can be
> +categorized based on additional factors, and a feedback loop can
> +statistically compare the refault percentages across those categories
> +and infer which of them are better choices.
It is better if we add a picture here to show the overview.. 

> +
> +Assumptions
> +-----------
> +The protection of hot pages and the selection of cold pages are based
> +on page access channels and patterns. There are two access channels:
> +
> +* Accesses through page tables
> +* Accesses through file descriptors
> +
> +The protection of the former channel is by design stronger because:
> +
> +1. The uncertainty in determining the access patterns of the former
> +   channel is higher due to the approximation of the accessed bit.
> +2. The cost of evicting the former channel is higher due to the TLB
> +   flushes required and the likelihood of encountering the dirty bit.
> +3. The penalty of underprotecting the former channel is higher because
> +   applications usually do not prepare themselves for major page
> +   faults like they do for blocked I/O. E.g., GUI applications
> +   commonly use dedicated I/O threads to avoid blocking the rendering
> +   threads.
> +
> +There are also two access patterns:
> +
> +* Accesses exhibiting temporal locality
> +* Accesses not exhibiting temporal locality
> +
> +For the reasons listed above, the former channel is assumed to follow
> +the former pattern unless ``VM_SEQ_READ`` or ``VM_RAND_READ`` is
> +present, and the latter channel is assumed to follow the latter
> +pattern unless outlying refaults have been observed.
> +
> +Workflow overview
> +=================
> +Evictable pages are divided into multiple generations for each
> +``lruvec``. The youngest generation number is stored in
> +``lrugen->max_seq`` for both anon and file types as they are aged on
> +an equal footing. The oldest generation numbers are stored in
> +``lrugen->min_seq[]`` separately for anon and file types as clean file
> +pages can be evicted regardless of swap constraints. These three
> +variables are monotonically increasing.
> +
> +Generation numbers are truncated into ``order_base_2(MAX_NR_GENS+1)``
> +bits in order to fit into the gen counter in ``folio->flags``. Each
> +truncated generation number is an index to ``lrugen->lists[]``. The
> +sliding window technique is used to track at least ``MIN_NR_GENS`` and
> +at most ``MAX_NR_GENS`` generations. The gen counter stores a value
> +within ``[1, MAX_NR_GENS]`` while a page is on one of
> +``lrugen->lists[]``; otherwise it stores zero.
> +
> +Each generation is divided into multiple tiers. Tiers represent
> +different ranges of numbers of accesses through file descriptors. A
> +page accessed ``N`` times through file descriptors is in tier
> +``order_base_2(N)``. In contrast to moving across generations, which
> +requires the LRU lock, moving across tiers only requires operations on
> +``folio->flags`` and therefore has a negligible cost. A feedback loop
> +modeled after the PID controller monitors refaults over all the tiers
> +from anon and file types and decides which tiers from which types to
> +evict or protect.
> +
> +There are two conceptually independent procedures: the aging and the
> +eviction. They form a closed-loop system, i.e., the page reclaim.

ditto.

> +
> +Aging
> +-----
> +The aging produces young generations. Given an ``lruvec``, it
> +increments ``max_seq`` when ``max_seq-min_seq+1`` approaches
> +``MIN_NR_GENS``. The aging promotes hot pages to the youngest
> +generation when it finds them accessed through page tables; the
> +demotion of cold pages happens consequently when it increments
> +``max_seq``. The aging uses page table walks and rmap walks to find
> +young PTEs. For the former, it iterates ``lruvec_memcg()->mm_list``
> +and calls ``walk_page_range()`` with each ``mm_struct`` on this list
> +to scan PTEs. On finding a young PTE, it clears the accessed bit and
> +updates the gen counter of the page mapped by this PTE to
> +``(max_seq%MAX_NR_GENS)+1``. After each iteration of this list, it
> +increments ``max_seq``. For the latter, when the eviction walks the
> +rmap and finds a young PTE, the aging scans the adjacent PTEs and
> +follows the same steps just described.
> +
> +Eviction
> +--------
> +The eviction consumes old generations. Given an ``lruvec``, it
> +increments ``min_seq`` when ``lrugen->lists[]`` indexed by
> +``min_seq%MAX_NR_GENS`` becomes empty. To select a type and a tier to
> +evict from, it first compares ``min_seq[]`` to select the older type.
> +If both types are equally old, it selects the one whose first tier has
> +a lower refault percentage. The first tier contains single-use
> +unmapped clean pages, which are the best bet. The eviction sorts a
> +page according to the gen counter if the aging has found this page
> +accessed through page tables and updated the gen counter. It also
> +moves a page to the next generation, i.e., ``min_seq+1``, if this page
> +was accessed multiple times through file descriptors and the feedback
> +loop has detected outlying refaults from the tier this page is in. To
> +do this, the feedback loop uses the first tier as the baseline, for
> +the reason stated earlier.
> +

Thanks
Huang Shijie
