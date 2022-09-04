Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BBEA5AC7FE
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 00:29:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234693AbiIDW3O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 18:29:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231335AbiIDW3K (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 18:29:10 -0400
Received: from NAM10-DM6-obe.outbound.protection.outlook.com (mail-dm6nam10on2064.outbound.protection.outlook.com [40.107.93.64])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B303626102
        for <linux-kernel@vger.kernel.org>; Sun,  4 Sep 2022 15:29:08 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; s=arcselector9901; d=microsoft.com; cv=none;
 b=DkblG8PbVLPOXGOJdR9Odc65rzB1XN7CrNjPl6f9OOu+0PdG1k+tNStqK4RBeFnYwlFWMFZNtTc3E+PWgjqcnHQ1nlVafzJr83EYP9QHbSU4FqH+OKyMawxQKs4kZiYgxZJZgThJjh2m6Mju8lKfcnNkfJdCyKJlliaCGL5rhsG5MQKEyRaf0QUALuJkEbF/9hk/gDqvY6dWDZ7/iodDAptIq0Cg48VxfBTPjINO12p33MaaehNC/n9YDiVShMOiRvypB4XsQdMIVWvZc9DSWaStHPrJFYART0ch9/T2sSf9wk9fNWA5f35vpt/9uWoL0ZSN99mPCSGsKpZr1n5WoA==
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=microsoft.com;
 s=arcselector9901;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-AntiSpam-MessageData-ChunkCount:X-MS-Exchange-AntiSpam-MessageData-0:X-MS-Exchange-AntiSpam-MessageData-1;
 bh=g4JSkIma5xPNW3OHuKyA2ss69erEPeF3RvvjizAK7i8=;
 b=JOe/Sjy7cg3J8KxxR3Gt8e/lUPauVbPU1pC6JX9UhLsGF+2uO8L/Hw7x2wpSwrfyX8FAi5pIQBL8YTOMzn9/q+XCPZ9WNnRUmQHB7ZCLcPoWbNhavoaUvQKVb+/ETnnKJd4fhm2zTF7MqnlptHuXa9Mi6rXyr+WxZCrkry3YI28Vk8Zcg4KgB7oT69TKUJLfM7XPV/afrnm4iHe9gn0G+0tQnO6pzS6LGymlHdO0dPgJd2UlGwCcAn4kIr3A33clSMUBmbrHaObO/cYq2bbWmVJ1b/O2vnxm7y9Ex4iZ5/O9fzehaxQmC8ye+HsawtXLAyjxAMQYAp71kdAGVHp6Pg==
ARC-Authentication-Results: i=1; mx.microsoft.com 1; spf=pass
 smtp.mailfrom=nvidia.com; dmarc=pass action=none header.from=nvidia.com;
 dkim=pass header.d=nvidia.com; arc=none
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=Nvidia.com;
 s=selector2;
 h=From:Date:Subject:Message-ID:Content-Type:MIME-Version:X-MS-Exchange-SenderADCheck;
 bh=g4JSkIma5xPNW3OHuKyA2ss69erEPeF3RvvjizAK7i8=;
 b=iCm4evj+4sAUNis0W2pese9mtwFTFImHlwJ+BiB7CbZ/vFC7AUfNeKAVeavLC3Aq2hSNYLvSvkfjG+WJ7L3NtAe6LlaH9DoJy8QbcFT/qaEex+/NGvDwhQSTf4TGP5AVeZGaGfPJNt5JNrzd1G4Kh8/dA11y4bY+nmRwS8uOUVr6VkFziYZDXqnSAHxRNLnJohdkguf6RnnKlwlU4QVDhEPTRLDpiQnZezI2GClP8Qc6e2TTaQFCncf1fr/6kHv0qkH1ifmibo85Prx5Qo6PvwQC6HXiH2Nln/EnQ+Y8LMi1ecR01ta5AC6gSLS9d2H0kAh22owWHDMllMoqg4z6uQ==
Authentication-Results: dkim=none (message not signed)
 header.d=none;dmarc=none action=none header.from=nvidia.com;
Received: from BY5PR12MB4130.namprd12.prod.outlook.com (2603:10b6:a03:20b::16)
 by DS0PR12MB7632.namprd12.prod.outlook.com (2603:10b6:8:11f::11) with
 Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.20.5588.12; Sun, 4 Sep
 2022 22:29:06 +0000
Received: from BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5]) by BY5PR12MB4130.namprd12.prod.outlook.com
 ([fe80::508d:221c:9c9e:e1a5%9]) with mapi id 15.20.5588.018; Sun, 4 Sep 2022
 22:29:06 +0000
Message-ID: <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
Date:   Sun, 4 Sep 2022 15:29:04 -0700
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>, david@redhat.com,
        peterx@redhat.com, kirill.shutemov@linux.intel.com, jgg@nvidia.com,
        hughd@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
From:   John Hubbard <jhubbard@nvidia.com>
In-Reply-To: <20220901222707.477402-1-shy828301@gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-ClientProxiedBy: BY5PR20CA0024.namprd20.prod.outlook.com
 (2603:10b6:a03:1f4::37) To BY5PR12MB4130.namprd12.prod.outlook.com
 (2603:10b6:a03:20b::16)
MIME-Version: 1.0
X-MS-PublicTrafficType: Email
X-MS-Office365-Filtering-Correlation-Id: 5267f562-40cf-4d23-a401-08da8ec4e10b
X-MS-TrafficTypeDiagnostic: DS0PR12MB7632:EE_
X-MS-Exchange-SenderADCheck: 1
X-MS-Exchange-AntiSpam-Relay: 0
X-Microsoft-Antispam: BCL:0;
X-Microsoft-Antispam-Message-Info: AoMhvy+2I3+gY9suhvIqCibOF8Z5dwEDKlILmOYY93VSE3Gvi4leauuJVXgxX/bXax06VxyiYWTO7mW/4xSTsbDQzK+NG6EC6BoOsn7pvkLPBszf/7mHwj26BWxb0l4DxbgUKu3CHA7M3oyJmyglFzRqT7nOGLJO7yYc6RaG/t/lbOKEwd5XoAwTfL3IXJIUS+lwVrY4bUBlIIoAZ6koZaeVkc06OpNAOzaOccguPejJuF/EWkLFpmPdaxS2n7ecAg6YxC6hbK0GrpCeatkQLxUQwlAm+8M2hSTVfS/Ohg5FvsRILBVHtYDIAqSyloSny5nXnbztqe4GndpGNMtKQ05L1oZTIbAXgmS/rc8P54pguZVCkx/A9B9AH4HTVo8HZTaygWo5t7IPU1yeR/vO0RuzvfZC8KiHbJqo9z3NfXwNYW4r7fGsL/ZpkXdvOjqawM2a1Ks9H9FN4BaL6oUkKCV2WqEQFGjn0iyVQ6a4tbvw/KQ3kks4+SX7tb4ajAAOS190XSAKQsPV234Ve0vpOuHuOSbYGgM9ipJM95Wr06GG+yLQ6EXd8VAk3KZqCx20QOHYOGFHhTvBUUpPXZ/KqdR3xIjxTKS6/JmnIFSuUDTk2nIXkZrCa2i+cERNs3Tpo50jBVXoMOdayn19XZ5XYgLzZoio5PKBSREY1jRRrDoWD2dqiYdUrpnnUE+NF3t0fyrphsw7vSKaw/NfYLQEcOSjTqNLUdlGlqNHf0wolTU1ZVgrlkhsAqEY5o1chgsbmu3oH77cfEBO4wwYuuZuKyBf2hpovK2+v5XE1fclU84=
X-Forefront-Antispam-Report: CIP:255.255.255.255;CTRY:;LANG:en;SCL:1;SRV:;IPV:NLI;SFV:NSPM;H:BY5PR12MB4130.namprd12.prod.outlook.com;PTR:;CAT:NONE;SFS:(13230016)(4636009)(136003)(39860400002)(376002)(366004)(346002)(396003)(186003)(38100700002)(83380400001)(66476007)(66556008)(4326008)(8676002)(36756003)(66946007)(2616005)(31686004)(316002)(6486002)(86362001)(478600001)(31696002)(26005)(53546011)(6512007)(8936002)(2906002)(6506007)(41300700001)(5660300002)(43740500002)(45980500001);DIR:OUT;SFP:1101;
X-MS-Exchange-AntiSpam-MessageData-ChunkCount: 1
X-MS-Exchange-AntiSpam-MessageData-0: =?utf-8?B?akRLcWNBSUFDeGxYUnlRcVVzMUJqSW4yR29jYXUxQlJiZmJqSnliQnBJYitT?=
 =?utf-8?B?MXVQUFJrYUd3YTg3a2cvZHc4dHFzclR6SGlLaFpMTkx3NXJtdTdBR0pZQ09l?=
 =?utf-8?B?VGt3akhqU21XVEVmbFYvQWhKLzZnR2xtNGR3bFlHQVBtZ0pNZ2RSVTlvTWd2?=
 =?utf-8?B?bFh6MXhqOE1EbjR0d0VVekh5ZzhDTWVDK2huRTRqZTdxbWVpakdUTHc4YTdj?=
 =?utf-8?B?Q01MeGw4NHYxeG1LZXV6ZWppNit2blZWY29ucjJpY3FJdWlXbzNCVVEyNm1O?=
 =?utf-8?B?bDN2blB4VEVhSXpHRlhqNnl5VVV2a1k5YjZzT0FlTUd6OXBzTlRreHUvVFZz?=
 =?utf-8?B?SXVHdW90NFREWHRobXdJNEpTYWk3Z1BDUnVyTWtLS3k1OHdCNmRqSG1Qaitt?=
 =?utf-8?B?dk85MHVDU3h1UDFoUHBnWFFYdy82dk9WZGNTd3JtU1NDRnRCcTVHNXNGUjht?=
 =?utf-8?B?QTVyU0ZSRnVoTDhGaVQ0KzJQZmdKZmpLOVY1c2RjOTl3TzU4OEU4ZWQ5RU85?=
 =?utf-8?B?VHFnTXVDbTU2djB5NUdwZmM5b3p3VllkZkNUTjBkdDc4aytWYVJHa0VqTFRt?=
 =?utf-8?B?eXh1bHMxbUlzSCtiWUo1MzV5eU5UVzNObW8rbEZjYlRQWHAvM1l1NWVTeVlY?=
 =?utf-8?B?MVVCU0EwbFpSTVhlTEYyTTZFK1JvbnRlVzhKbGdRaHAxQVVJQ3N2RGE1ZEFh?=
 =?utf-8?B?bTdkZmpPUEdEYWx0RkMvRkltendRTXBqeCsxVCtrbm1peW5lWUtFZGs0UDZW?=
 =?utf-8?B?S0xLMndHN0xBcG8zMW1hSkRST1RZWUx5R1E2RWJBb0NyY3B4TjQwQTQxQm9F?=
 =?utf-8?B?YmlCNElUWFBoMHVyZEthcXdOSndjTGM5clVnRGgzTGYxR1BXOXJ6ZlZ6TmhD?=
 =?utf-8?B?T2N6S3FkU1dDbGxtMkhUTlN5dkppZVI5L2hTSFo5cWhXVlFVNERVRlJzUzJQ?=
 =?utf-8?B?UmdsTXk2YTdHd2RqSmI0Ty90ODRwRjVqWUNLRUQ4UTNxYUcyK3l3REV2UHp4?=
 =?utf-8?B?WVRXaVBScFlxN1p6K0lHM3BOL09wSVl3SHQ3V09FUERQMjBINWphM1d3MkU3?=
 =?utf-8?B?Y3JqUVBSUDdnU0V3dDJ1ZnpRbEJkWThndU1keUZRVklyczlGR3BDaWkxYnZ1?=
 =?utf-8?B?SjFEaURhaGwxUEtYVTV0V3c2K0dCQjRWZnNIMG02UkxqZkJyMXNNUDNXRGlh?=
 =?utf-8?B?RFMrWEM2aWtSbmJTRjhyWG41VkJKZzJyNzlwRHlHYXlEUEVrOXl2aUI0blpO?=
 =?utf-8?B?VHZDaVNOUGJUdDhWeElBZlBKUEhUUVJJVnQ4Tm1hSDBTaGFwU0wrenFOMUFn?=
 =?utf-8?B?b1NFOU1ZUG5nNXhlNGhPaE5DbzFzSytpalhaL2t1ZWc0Y0hhbTR5UG1lYlZO?=
 =?utf-8?B?dk4yMlFxakkzcWZKWnZ0d2hLYWhXOWtUejY4Wkp0bGxLUnJ4ejRnZU1RNUho?=
 =?utf-8?B?bkMzT2FNZm1mTDJQdk43YVl1bzUxcFgvSURqYUU5N1JFK0hsSVE3S3J2WDM5?=
 =?utf-8?B?NDRaUWkzekR0NU9HOUVyaitMN0NFUVZSc0ZxNk5xem03TDVRS1dkTnU4WGQy?=
 =?utf-8?B?Q3NNQ0JIRlZwTk5iZ1B5d3ZGN0Y0cVk0dWc4b2NuRUY0UGRlVFBWS0dGSitt?=
 =?utf-8?B?Wk1EaEx6amgyeEF6bHcrL1hsdHhERG9WV2cydjdadThySFI2OE5kTkk2aUNw?=
 =?utf-8?B?SC9MSDR6MzZHNi9mbmo0dzJjN2pXQ1o4QW5ka0d3VW53emtXNm56Q0VKM3lC?=
 =?utf-8?B?dFFTZUhMV0p5bTBhUjFnSG93bVliSlRic2FuSXU5cTkrVVNDek5GbTdGaUlG?=
 =?utf-8?B?bEdJb0ZTNTlVOHg4dEZwUWsxT05CaGRJV0hZVVFSUERhOXJLTDZ1ZDZsSnpP?=
 =?utf-8?B?RGZsM1huUUZ2QnR5ZHM2R0JNQzNnVGkxRjN3bDVHK215djZCaEVwaGkvMFRU?=
 =?utf-8?B?SUZ4THdNZkZRTXV1UDh4UXBEYkt0OVZPNGc4MGNpRGIyY1hiTWRUUUNNM3dX?=
 =?utf-8?B?MC9oVnBFMCtpZW8ySXVnTzZUTkliQU1LeCsrVUlhWWE1bjU3LzRBWkdrSFk4?=
 =?utf-8?B?N1VueDYxMGkyOHFwbDdFeitYelpXV0FmQ3NGOS9KYTdHQmEzRDlvYzJrU2hJ?=
 =?utf-8?Q?hYOFWbyiKRb8zeUI/+aPPJIeX?=
X-OriginatorOrg: Nvidia.com
X-MS-Exchange-CrossTenant-Network-Message-Id: 5267f562-40cf-4d23-a401-08da8ec4e10b
X-MS-Exchange-CrossTenant-AuthSource: BY5PR12MB4130.namprd12.prod.outlook.com
X-MS-Exchange-CrossTenant-AuthAs: Internal
X-MS-Exchange-CrossTenant-OriginalArrivalTime: 04 Sep 2022 22:29:06.8280
 (UTC)
X-MS-Exchange-CrossTenant-FromEntityHeader: Hosted
X-MS-Exchange-CrossTenant-Id: 43083d15-7273-40c1-b7db-39efd9ccc17a
X-MS-Exchange-CrossTenant-MailboxType: HOSTED
X-MS-Exchange-CrossTenant-UserPrincipalName: HITmvUurmS2T6fSumfzZ5GC+yk5rrgobqigvg0AIJt1ubZrhQ/7dAN0VLLz3Blt7bOMUVQ/4xUwy7IthcUolyw==
X-MS-Exchange-Transport-CrossTenantHeadersStamped: DS0PR12MB7632
X-Spam-Status: No, score=-2.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FORGED_SPF_HELO,
        NICE_REPLY_A,RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 9/1/22 15:27, Yang Shi wrote:
> Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
> introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
> sufficient to handle concurrent GUP-fast in all cases, it only handles
> traditional IPI-based GUP-fast correctly.  On architectures that send
> an IPI broadcast on TLB flush, it works as expected.  But on the
> architectures that do not use IPI to broadcast TLB flush, it may have
> the below race:
> 
>    CPU A                                          CPU B
> THP collapse                                     fast GUP
>                                               gup_pmd_range() <-- see valid pmd
>                                                   gup_pte_range() <-- work on pte
> pmdp_collapse_flush() <-- clear pmd and flush
> __collapse_huge_page_isolate()
>     check page pinned <-- before GUP bump refcount
>                                                       pin the page
>                                                       check PTE <-- no change
> __collapse_huge_page_copy()
>     copy data to huge page
>     ptep_clear()
> install huge pmd for the huge page
>                                                       return the stale page
> discard the stale page

Hi Yang,

Thanks for taking the trouble to write down these notes. I always
forget which race we are dealing with, and this is a great help. :)

More...

> 
> The race could be fixed by checking whether PMD is changed or not after
> taking the page pin in fast GUP, just like what it does for PTE.  If the
> PMD is changed it means there may be parallel THP collapse, so GUP
> should back off.
> 
> Also update the stale comment about serializing against fast GUP in
> khugepaged.
> 
> Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")
> Signed-off-by: Yang Shi <shy828301@gmail.com>
> ---
>  mm/gup.c        | 30 ++++++++++++++++++++++++------
>  mm/khugepaged.c | 10 ++++++----
>  2 files changed, 30 insertions(+), 10 deletions(-)
> 
> diff --git a/mm/gup.c b/mm/gup.c
> index f3fc1f08d90c..4365b2811269 100644
> --- a/mm/gup.c
> +++ b/mm/gup.c
> @@ -2380,8 +2380,9 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
>  }
>  
>  #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
> -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> -			 unsigned int flags, struct page **pages, int *nr)
> +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> +			 unsigned long end, unsigned int flags,
> +			 struct page **pages, int *nr)
>  {
>  	struct dev_pagemap *pgmap = NULL;
>  	int nr_start = *nr, ret = 0;
> @@ -2423,7 +2424,23 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>  			goto pte_unmap;
>  		}
>  
> -		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
> +		/*
> +		 * THP collapse conceptually does:
> +		 *   1. Clear and flush PMD
> +		 *   2. Check the base page refcount
> +		 *   3. Copy data to huge page
> +		 *   4. Clear PTE
> +		 *   5. Discard the base page
> +		 *
> +		 * So fast GUP may race with THP collapse then pin and
> +		 * return an old page since TLB flush is no longer sufficient
> +		 * to serialize against fast GUP.
> +		 *
> +		 * Check PMD, if it is changed just back off since it
> +		 * means there may be parallel THP collapse.
> +		 */

As I mentioned in the other thread, it would be a nice touch to move
such discussion into the comment header.

> +		if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
> +		    unlikely(pte_val(pte) != pte_val(*ptep))) {


That should be READ_ONCE() for the *pmdp and *ptep reads. Because this
whole lockless house of cards may fall apart if we try reading the
page table values without READ_ONCE(). 

That's a rather vague statement, and in fact, the READ_ONCE() should
be paired with a page table write somewhere else, to make that claim
more precise.


>  			gup_put_folio(folio, 1, flags);
>  			goto pte_unmap;
>  		}
> @@ -2470,8 +2487,9 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>   * get_user_pages_fast_only implementation that can pin pages. Thus it's still
>   * useful to have gup_huge_pmd even if we can't operate on ptes.
>   */
> -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
> -			 unsigned int flags, struct page **pages, int *nr)
> +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
> +			 unsigned long end, unsigned int flags,
> +			 struct page **pages, int *nr)
>  {
>  	return 0;
>  }
> @@ -2791,7 +2809,7 @@ static int gup_pmd_range(pud_t *pudp, pud_t pud, unsigned long addr, unsigned lo
>  			if (!gup_huge_pd(__hugepd(pmd_val(pmd)), addr,
>  					 PMD_SHIFT, next, flags, pages, nr))
>  				return 0;
> -		} else if (!gup_pte_range(pmd, addr, next, flags, pages, nr))
> +		} else if (!gup_pte_range(pmd, pmdp, addr, next, flags, pages, nr))
>  			return 0;
>  	} while (pmdp++, addr = next, addr != end);
>  
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 2d74cf01f694..518b49095db3 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -1049,10 +1049,12 @@ static int collapse_huge_page(struct mm_struct *mm, unsigned long address,
>  
>  	pmd_ptl = pmd_lock(mm, pmd); /* probably unnecessary */
>  	/*
> -	 * After this gup_fast can't run anymore. This also removes
> -	 * any huge TLB entry from the CPU so we won't allow
> -	 * huge and small TLB entries for the same virtual address
> -	 * to avoid the risk of CPU bugs in that area.
> +	 * This removes any huge TLB entry from the CPU so we won't allow
> +	 * huge and small TLB entries for the same virtual address to
> +	 * avoid the risk of CPU bugs in that area.
> +	 *
> +	 * Parallel fast GUP is fine since fast GUP will back off when
> +	 * it detects PMD is changed.
>  	 */
>  	_pmd = pmdp_collapse_flush(vma, address, pmd);

To follow up on David Hildenbrand's note about this in the nearby thread...
I'm also not sure if pmdp_collapse_flush() implies a memory barrier on 
all arches. It definitely does do an atomic op with a return value on x86,
but that's just one arch.


thanks,

-- 
John Hubbard
NVIDIA

>  	spin_unlock(pmd_ptl);

