Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 125C246620A
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 12:07:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357167AbhLBLKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 06:10:18 -0500
Received: from mail-dm6nam12on2072.outbound.protection.outlook.com ([40.107.243.72]:39713
        "EHLO NAM12-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S237400AbhLBLKQ (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 06:10:16 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=bYO2zHD/0ZBOJ+XOOJXuIb889rwms0SMC6neMft6+JTMeJIuFI+BCY85cYvJjPlvaTtE1DpXbrShHdutYcBr1qp+uaTC1zRB7ZXvT29ZagKdo5QQUrIgDPnoba9Kl/kqs3vDWYrqxevoUpFSzeUXWKJkoibwmCU6wID3UxVlD8iL25XcLwnoNeYzUFRMbN0x+OZFoDNTsP0iAv0XikHuOQLpak4zLaZY78qRHdN5z4ftr415LjykTa0QLL5u7eco501PX7kKwv/NxcyHtjEQ0jNdhlfG8IBCe6zgzssCfqIc0Pm/ikKhFZWpNYKosGv5s4jVFVFJm6yR9uetRd93jw==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=20LiXx7vnCprmhSsO8DIFcyVYnlmwrqIkCX2omPU0pw=;
 b=fqDvjZFTffVYj4IhS78zS4S1QLyIxHN73y8pDLQqCT41ieywhgVWDvBYyplHHOndnwF5jdNE1NEgWAzE/OAVJ7GBGK+6IdUZZv/5hKpAY8MonrrFafCOg83Pi2pH1wv7xXLY1/YbKE893GSXCJlVYLrYKPs8snPSrLPR/S91bRaatQyAv0n/zhBaJfKxiz142sa8vdEljSEEWK3gExhaGHWE8UCNO/SY8G43ybNfxcDftaoUTzfBK/6T9YqPCpTGPkWyByo+egeA74gTDGKMZZbgDTRQIjzD95k5yuF44gInfUPlcShC+fNd4SYY8fVDQJWcyyCzJy/RRZC78fHmlA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.32) smtp.rcpttodomain=suse.cz smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=20LiXx7vnCprmhSsO8DIFcyVYnlmwrqIkCX2omPU0pw=;
 b=NDeiUN3VvChPdU3tXYBWzsQcfSnJE3y/n2hI2bhluZupcjVmdxy/tXkZIHXa6sr3wquEpiNlZ12p+yhEaBr41zbJ2h03fnzurtHDVZC6yUmuN5if7mjb0mK1bp3wmBmMf7j2xMJeXWQnK8TxsqUbinjCnuRUALdwXnIRyVf7yJbtesP5Gzywa7ZWbHNvsxrXYektAbTpdcc6GpGnu2E2q0tRIBwLYE9hHDQfaMed8p1JSrgZebdU3tMrvNriTvigVWuKYxB00jDorYRfL84A7+6LDoDTz3+WoIgh6sZ89hEiPJ7b8CIo248G0Pjli2bXJCbvJYR7J5YVhjDKS/UUKQ==
Received: from CO2PR04CA0174.namprd04.prod.outlook.com (2603:10b6:104:4::28)
 by BL0PR12MB2372.namprd12.prod.outlook.com (2603:10b6:207:4d::14) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.16; Thu, 2 Dec
 2021 11:06:52 +0000
Received: from CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
 (2603:10b6:104:4:cafe::9b) by CO2PR04CA0174.outlook.office365.com
 (2603:10b6:104:4::28) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.17 via Frontend
 Transport; Thu, 2 Dec 2021 11:06:52 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.32)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.32 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.32; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.32) by
 CO1NAM11FT031.mail.protection.outlook.com (10.13.174.118) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Thu, 2 Dec 2021 11:06:52 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HQMAIL109.nvidia.com
 (172.20.187.15) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Thu, 2 Dec
 2021 03:06:51 -0800
Received: from nvdebian.localnet (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 2 Dec 2021
 03:06:48 -0800
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        Peter Xu <peterx@redhat.com>
CC:     David Hildenbrand <david@redhat.com>, <peterx@redhat.com>,
        "Andrea Arcangeli" <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        "Vlastimil Babka" <vbabka@suse.cz>,
        Hugh Dickins <hughd@google.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details specified
Date:   Thu, 2 Dec 2021 22:06:46 +1100
Message-ID: <5393877.lttFOZEo4r@nvdebian>
In-Reply-To: <20211115134951.85286-2-peterx@redhat.com>
References: <20211115134951.85286-1-peterx@redhat.com> <20211115134951.85286-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL101.nvidia.com (172.20.187.10) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 3154c215-2829-49f3-71cf-08d9b583d834
X-MS-TrafficTypeDiagnostic: BL0PR12MB2372:
X-Microsoft-Antispam-PRVS: <BL0PR12MB2372C3E70A1B07F6DE0FC3B2DF699@BL0PR12MB2372.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:8882;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: 0oggoW+AJ7uuC4p9166BUk6Jvis7i4EaWSHe4+wBRZjpwcY60P80VouCNcltIzxJAmXRaV3O/5QdJiNP4V18Ut5BFzXpVWlvYvYAgZWa5G4iBp6bYVBT8TNyTdxYOtdHYHY9hv7+M3WGvYHxU4yzXNfptr5FL0OIAwQZ65/j2E8Fa8I/e0bJ0V6B93rxBYo4pHHj6Xy9PuRBAgf8cEsHOmwjtbdi9zjUVBcpL0ZNLaxQJAVnEZY0IrnjMoByvAYEsOBvLr3LNplTv8u/6RUfTLASNjBk76/vzxqs62nzQfY/JinoUi1lh+XE4sJxn3SvfPdzglIhRci13nC+KX/p9JsVi3nYe+b9o2Q46UTIv4/6g0inHgJW/SU3Wi5ACUT/rEuQ61TM0jngSrDPFmgXreX1shL8uwYbjJSVIMtXGaGjqArtjJZLFckjPMNsd8T6r7i+isV2ULEopzz0krYdWE1V2XeaNbzA41oEYq+FHrtIViOzJvFhNx+4TdAs+DZLB7lN72vVwBedzyseEWiyLd9+NHtyrrRXZ7lo18FDKFFJOJn/wncN6gBwiOZXKEiWyMQgc4FzEHsyyk6bphRCRH5rsEnIgNH7+ljPXwOkNZFbMByqhlgR3LbZ8vJDAMQFRlRuxl516xCqtLOp7qNb+xKtme7uagF59p5RmJ5c0V0ehztW8qo3pjHh7qoAfu/WA20xTRPJFVTsrdsbkzR0IMUteoPclAaih63vEonTZbTko1kdhFT4HbitzC2kyL7Rk9uh90Gc0fq6XMq/EqYq/x2TiQXaXSFJB8yjEECOvVV4nfNDbvwvDKpAZFyEt3ao
X-Forefront-Antispam-Report: CIP:216.228.112.32;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid01.nvidia.com;CAT:NONE;SFS:(4636009)(46966006)(36840700001)(40470700001)(40460700001)(4326008)(82310400004)(36860700001)(83380400001)(16526019)(7636003)(33716001)(8936002)(186003)(336012)(70586007)(70206006)(356005)(426003)(47076005)(8676002)(26005)(54906003)(110136005)(2906002)(9576002)(316002)(86362001)(7416002)(508600001)(5660300002)(9686003)(39026012)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 02 Dec 2021 11:06:52.1201
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: 3154c215-2829-49f3-71cf-08d9b583d834
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.32];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT031.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: BL0PR12MB2372
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tuesday, 16 November 2021 12:49:50 AM AEDT Peter Xu wrote:
> This check existed since the 1st git commit of Linux repository, but at that
> time there's no page migration yet so I think it's okay.
> 
> With page migration enabled, it should logically be possible that we zap some
> shmem pages during migration.  When that happens, IIUC the old code could have
> the RSS counter accounted wrong on MM_SHMEMPAGES because we will zap the ptes
> without decreasing the counters for the migrating entries.  I have no unit test
> to prove it as I don't know an easy way to trigger this condition, though.
> 
> Besides, the optimization itself is already confusing IMHO to me in a few points:

I've spent a bit of time looking at this and think it would be good to get
cleaned up as I've found it hard to follow in the past. What I haven't been
able to confirm is if anything relies on skipping swap entries or not. From
you're description it sounds like skipping swap entries was done as an
optimisation rather than for some functional reason is that correct?

>   - The wording "skip swap entries" is confusing, because we're not skipping all
>     swap entries - we handle device private/exclusive pages before that.
> 
>   - The skip behavior is enabled as long as zap_details pointer passed over.
>     It's very hard to figure that out for a new zap caller because it's unclear
>     why we should skip swap entries when we have zap_details specified.
> 
>   - With modern systems, especially performance critical use cases, swap
>     entries should be rare, so I doubt the usefulness of this optimization
>     since it should be on a slow path anyway.
> 
>   - It is not aligned with what we do with huge pmd swap entries, where in
>     zap_huge_pmd() we'll do the accounting unconditionally.
> 
> This patch drops that trick, so we handle swap ptes coherently.  Meanwhile we
> should do the same mapping check upon migration entries too.

I agree, and I'm not convinced the current handling is very good - if we
skip zapping a migration entry then the page mapping might get restored when
the migration entry is removed.

In practice I don't think that is a problem as the migration entry target page
will be locked, and if I'm understanding things correctly callers of
unmap_mapping_*() need to have the page(s) locked anyway if they want to be
sure the page is unmapped. But it seems removing the migration entries better
matches the intent and I can't think of a reason why they should be skipped.

> Signed-off-by: Peter Xu <peterx@redhat.com>
> ---
>  mm/memory.c | 6 ++----
>  1 file changed, 2 insertions(+), 4 deletions(-)
> 
> diff --git a/mm/memory.c b/mm/memory.c
> index 8f1de811a1dc..e454f3c6aeb9 100644
> --- a/mm/memory.c
> +++ b/mm/memory.c
> @@ -1382,16 +1382,14 @@ static unsigned long zap_pte_range(struct mmu_gather *tlb,
>  			continue;
>  		}
>  
> -		/* If details->check_mapping, we leave swap entries. */
> -		if (unlikely(details))
> -			continue;
> -
>  		if (!non_swap_entry(entry))
>  			rss[MM_SWAPENTS]--;
>  		else if (is_migration_entry(entry)) {
>  			struct page *page;
>  
>  			page = pfn_swap_entry_to_page(entry);
> +			if (unlikely(zap_skip_check_mapping(details, page)))
> +				continue;
>  			rss[mm_counter(page)]--;
>  		}
>  		if (unlikely(!free_swap_and_cache(entry)))
> 




