Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id AE0324670BA
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 04:30:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347387AbhLCDdh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 22:33:37 -0500
Received: from mail-dm6nam11on2050.outbound.protection.outlook.com ([40.107.223.50]:30038
        "EHLO NAM11-DM6-obe.outbound.protection.outlook.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1345105AbhLCDdd (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 22:33:33 -0500
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=mDjWi2U+g2TtkXCrnY+YyragdBMgrxQUbyG8ABEeqI1/AjoUXzoduYJM/NtuoxU9BGgbOilH9WzxMZjhRmSCMib4Jkkm8cMJkwWmTPZBMXJaySQeEbhJkKiNxnk7k85jK8zSbau8ZMmli+fOEEw7FfawpIwqBjOSMqLzIsZlfZ3zY/ODTmNDuXwcYDFs5ScOyULw+DBElwBIq0PFUJh4McJMAM039n5Sugbf12UiqJbdVUyoJ8dtMMvCfK6ATHv6/mwuymOvaHVRhkwB8uJem1zLMJZNtb0g4wRJ7Kzluq9oaEyEvheCIJKZKxiUUw/6oSHNkhWZWONhrVqsQxp9Dg==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=b2ss4Jf4fa4k2q9mpKnmYo1chIwyuFjgPaKo42Oyq7s=;
 b=DOen21eXCHzJf0iCuNh/ZdxFYeC5UkUQg9wqsf3NjubFADr4xSmlVJMVSKUnCi3I2x1S1hhk6tNoEzU5b4frkS719J6BD/QiFLzhlY/xnlCJSLxocPFWoBV+e49UmwcVXKPGGReo5WQ3nXHS3IY5+FpZhnPl/dccTLKHoClRACmZ6/MEVE2YhnKUmLosvMoFEv8gUEL1b+qz9j9n6BTHIfS4MVQ5lSqRWBTKMZfbT1A7f4vOHgG+GP/sNajTL/6pZ4N4qEmosCodsYdUOSK9o66AN963vYY2IRQbeAX0Jm6+xJcDfm6jmAjyMdUy+jwqZ8R9HMPeZ7wZIMJDQKv3YA==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass (sender ip is
 216.228.112.34) smtp.rcpttodomain=redhat.com smtp.mailfrom=nvidia.com;
 dmarc=pass (p=quarantine sp=quarantine pct=100) action=none
 header.from=nvidia.com; dkim=none (message not signed); arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=b2ss4Jf4fa4k2q9mpKnmYo1chIwyuFjgPaKo42Oyq7s=;
 b=Z3LVIYJRQug0L4+tuB6t1BsfA7wuDa3fLCiHEhlERkyu5KLoQzvZ9Rds3yyoSpMdUDPE8V6dxAhv9GjgsWYbZUpcvoSXSXowZsNZ0DbaiT2TfARxCaoQxZa1Zl2iPyeocxV1fCPAuHiPTHGN8BTXKj8v5AWZLSN++PuhTIJQT+aQAQzLrfg6SzfwR5DilXX1SHJ/Fm5vD3OmKb7BJvih37CSMnJ/RGJC0ZW/7YrHrf+dK0y9LeXLjg9Cz7l4nOvq0E9vMs+ex+LT45Sql0G04c2is8BAOOtf2tLC18Ei35ZchDLylinW0a5ihYJPoKg9k03zIRYNYKXWINmpzuvlpg==
Received: from MWHPR13CA0016.namprd13.prod.outlook.com (2603:10b6:300:16::26)
 by MN2PR12MB2894.namprd12.prod.outlook.com (2603:10b6:208:10a::27) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4734.23; Fri, 3 Dec
 2021 03:30:08 +0000
Received: from CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
 (2603:10b6:300:16:cafe::f0) by MWHPR13CA0016.outlook.office365.com
 (2603:10b6:300:16::26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.4755.9 via Frontend
 Transport; Fri, 3 Dec 2021 03:30:08 +0000
X-MS-Exchange-Authentication-Results: spf=pass (sender IP is 216.228.112.34)
 smtp.mailfrom=nvidia.com; dkim=none (message not signed)
 header.d=none;dmarc=pass action=none header.from=nvidia.com;
Received-SPF: Pass (protection.outlook.com: domain of nvidia.com designates
 216.228.112.34 as permitted sender) receiver=protection.outlook.com;
 client-ip=216.228.112.34; helo=mail.nvidia.com;
Received: from mail.nvidia.com (216.228.112.34) by
 CO1NAM11FT061.mail.protection.outlook.com (10.13.175.200) with Microsoft SMTP
 Server (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.20.4755.13 via Frontend Transport; Fri, 3 Dec 2021 03:30:07 +0000
Received: from rnnvmail201.nvidia.com (10.129.68.8) by HQMAIL107.nvidia.com
 (172.20.187.13) with Microsoft SMTP Server (TLS) id 15.0.1497.18; Fri, 3 Dec
 2021 03:30:06 +0000
Received: from nvdebian.localnet (172.20.187.5) by rnnvmail201.nvidia.com
 (10.129.68.8) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.986.9; Thu, 2 Dec 2021
 19:30:03 -0800
From:   Alistair Popple <apopple@nvidia.com>
To:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Peter Xu <peterx@redhat.com>
CC:     Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        "Matthew Wilcox" <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>, <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v6 01/23] mm: Introduce PTE_MARKER swap entry
Date:   Fri, 3 Dec 2021 14:30:00 +1100
Message-ID: <11462319.U46FXHIEPT@nvdebian>
In-Reply-To: <20211115075522.73795-2-peterx@redhat.com>
References: <20211115075522.73795-1-peterx@redhat.com> <20211115075522.73795-2-peterx@redhat.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7Bit
Content-Type: text/plain; charset="us-ascii"
X-Originating-IP: [172.20.187.5]
X-ClientProxiedBy: HQMAIL107.nvidia.com (172.20.187.13) To
 rnnvmail201.nvidia.com (10.129.68.8)
X-EOPAttributedMessage: 0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: b6a01478-009b-44ed-7988-08d9b60d3465
X-MS-TrafficTypeDiagnostic: MN2PR12MB2894:
X-Microsoft-Antispam-PRVS: <MN2PR12MB2894BA9BAE5E4E08FE5549C7DF6A9@MN2PR12MB2894.namprd12.prod.outlook.com>
X-MS-Oob-TLC-OOBClassifiers: OLM:10000;
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: U/+1uMJG0vx9FC+m9tJzq6WHoscne/0W0hj6E1cl3vLfbHlDjxg37Ml2DS7qKiaLgHzeVe+5hPxb0KOxIQp/UDm5uRixUEFbQD28yAFNTSGoREddM93t4iyWKyaFeKCM+OB8UJMVdHAUFQvQDHab9R4XdxYcwTsE84e+Rr6YuoecZWagS5aZyPOkeFd+0ISRnm58e4YtPAiTeOtYiSv6Ak/LwX28Xomy7c1F/bIW2vWxTBRDFY7XeDGJzmwsaSnfx2+fFm6YdTtDAsTgPwoqIFrhhtiUrAHL1JR3JVXILY1XsJ5SS6fEgoOB3sW/rXw8kykSf5E1714L1iq9VcXrWBLkbAzVo1a8SJX7kkcs3xVHGsMOsMA4QNX8wmmeN5tco87LAkWTB0mgPzhDDPHTFU5rQjYMhSB1quj4reg7ahF0hn6egdgxwVcYuck9bFyx4Sjwwy95jnMEhDgA8qYu2wchten3lbVb+9r32OGdab3mwoXU5NQTOmcRBegrNu+HJf/Z8jjbDd0liSZtId2eUyYAfKd/EHpyz9S4f69rXJOLxJ00JAWbcc8xD0NQ1bE/ZV8BalhHyD79JNGgevU7R0hfb5fXhJofEwuneBR9wYSSe4rTk432/yVdm70ogx6udPUUIbXB41JMumqi+8gXvZLs02GaZ/HotT2vjibQlY1fRCa1CWa/fC4bnETpHKbbU/SirW6QRe8BinXWL+pNHp5/rHEl5zXTQM8f8lBUTBWrE0yYXI1Qqsz5tdvaI5wGgkk3HLsg2ROkMmZzOwqCJSKHuj74R1wUXaeVzNAf3yA=
X-Forefront-Antispam-Report: CIP:216.228.112.34;CTRY:US;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:mail.nvidia.com;PTR:schybrid03.nvidia.com;CAT:NONE;SFS:(4636009)(36840700001)(46966006)(40470700001)(110136005)(33716001)(426003)(9576002)(5660300002)(8676002)(54906003)(26005)(2906002)(33656002)(7416002)(7636003)(70586007)(336012)(508600001)(9686003)(4326008)(16526019)(8936002)(47076005)(70206006)(186003)(86362001)(36860700001)(82310400004)(40460700001)(356005)(316002)(2101003);DIR:OUT;SFP:1101;
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 03 Dec 2021 03:30:07.6719
 (UTC)
X-MS-Exchange-CrossTenant-Network-Message-Id: b6a01478-009b-44ed-7988-08d9b60d3465
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-OriginalAttributedTenantConnectingIp: TenantId=43083d15-7273-40c1-b7db-39efd9ccc17a;Ip=[216.228.112.34];Helo=[mail.nvidia.com]
X-MS-Exchange-CrossTenant-AuthSource: CO1NAM11FT061.eop-nam11.prod.protection.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Anonymous
X-MS-Exchange-CrossTenant-FromEntityHeader: HybridOnPrem
X-MS-Exchange-Transport-CrossTenantHeadersStamped: MN2PR12MB2894
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Monday, 15 November 2021 6:55:00 PM AEDT Peter Xu wrote:

[...]

> diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> index d356ab4047f7..5103d2a4ae38 100644
> --- a/include/linux/swapops.h
> +++ b/include/linux/swapops.h
> @@ -247,6 +247,84 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
>  
>  #endif
>  
> +typedef unsigned long pte_marker;
> +
> +#define  PTE_MARKER_MASK     (0)
> +
> +#ifdef CONFIG_PTE_MARKER
> +
> +static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> +{
> +	return swp_entry(SWP_PTE_MARKER, marker);
> +}
> +
> +static inline bool is_pte_marker_entry(swp_entry_t entry)
> +{
> +	return swp_type(entry) == SWP_PTE_MARKER;
> +}
> +
> +static inline pte_marker pte_marker_get(swp_entry_t entry)
> +{
> +	return swp_offset(entry) & PTE_MARKER_MASK;

I'm not sure the PTE_MARKER_MASK adds much, especially as we only have one
user. I don't see a problem with open-coding these kind of checks (ie.
swp_offset(entry) & PTE_MARKER_UFFD_WP) as you kind of end up doing that anyway.
Alternatively if you want helper functions I think it would be better to define
them for each marker. Eg: is_pte_marker_uffd_wp().

> +}
> +
> +static inline bool is_pte_marker(pte_t pte)
> +{
> +	return is_swap_pte(pte) && is_pte_marker_entry(pte_to_swp_entry(pte));
> +}
> +
> +#else /* CONFIG_PTE_MARKER */
> +
> +static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> +{
> +	/* This should never be called if !CONFIG_PTE_MARKER */

Can we leave this function undefined then? That way we will get an obvious
build error.

Overall I'm liking the swap entry approach a lot more than the special pte
approach, but maybe that's just because I'm more familiar with special swap
entries :-)

> +	WARN_ON_ONCE(1);
> +	return swp_entry(0, 0);
> +}
> +
> +static inline bool is_pte_marker_entry(swp_entry_t entry)
> +{
> +	return false;
> +}
> +
> +static inline pte_marker pte_marker_get(swp_entry_t entry)
> +{
> +	return 0;
> +}
> +
> +static inline bool is_pte_marker(pte_t pte)
> +{
> +	return false;
> +}
> +
> +#endif /* CONFIG_PTE_MARKER */
> +
> +static inline pte_t make_pte_marker(pte_marker marker)
> +{
> +	return swp_entry_to_pte(make_pte_marker_entry(marker));
> +}
> +
> +/*
> + * This is a special version to check pte_none() just to cover the case when
> + * the pte is a pte marker.  It existed because in many cases the pte marker
> + * should be seen as a none pte; it's just that we have stored some information
> + * onto the none pte so it becomes not-none any more.
> + *
> + * It should be used when the pte is file-backed, ram-based and backing
> + * userspace pages, like shmem.  It is not needed upon pgtables that do not
> + * support pte markers at all.  For example, it's not needed on anonymous
> + * memory, kernel-only memory (including when the system is during-boot),
> + * non-ram based generic file-system.  It's fine to be used even there, but the
> + * extra pte marker check will be pure overhead.
> + *
> + * For systems configured with !CONFIG_PTE_MARKER this will be automatically
> + * optimized to pte_none().
> + */
> +static inline int pte_none_mostly(pte_t pte)
> +{
> +	return pte_none(pte) || is_pte_marker(pte);
> +}
> +
>  static inline struct page *pfn_swap_entry_to_page(swp_entry_t entry)
>  {
>  	struct page *p = pfn_to_page(swp_offset(entry));
> diff --git a/mm/Kconfig b/mm/Kconfig
> index 068ce591a13a..66f23c6c2032 100644
> --- a/mm/Kconfig
> +++ b/mm/Kconfig
> @@ -897,6 +897,13 @@ config IO_MAPPING
>  config SECRETMEM
>  	def_bool ARCH_HAS_SET_DIRECT_MAP && !EMBEDDED
>  
> +config PTE_MARKER
> +	def_bool n
> +	bool "Marker PTEs support"
> +
> +	help
> +	  Allows to create marker PTEs for file-backed memory.
> +
>  source "mm/damon/Kconfig"
>  
>  endmenu
> 




