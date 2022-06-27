Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 37ADD55DA1D
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:22:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232422AbiF0GSt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 02:18:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53258 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232040AbiF0GSs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 02:18:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 438982713
        for <linux-kernel@vger.kernel.org>; Sun, 26 Jun 2022 23:18:47 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 10B471758;
        Sun, 26 Jun 2022 23:18:47 -0700 (PDT)
Received: from [10.162.42.6] (unknown [10.162.42.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B19AE3F5A1;
        Sun, 26 Jun 2022 23:18:43 -0700 (PDT)
Message-ID: <f0cfe169-44fa-5653-d454-149ef286d3bb@arm.com>
Date:   Mon, 27 Jun 2022 11:48:40 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: hugetlb: kill set_huge_swap_pte_at()
Content-Language: en-US
To:     Qi Zheng <zhengqi.arch@bytedance.com>, mike.kravetz@oracle.com,
        songmuchun@bytedance.com, akpm@linux-foundation.org,
        catalin.marinas@arm.com, will@kernel.org
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/26/22 20:27, Qi Zheng wrote:
> The commit e5251fd43007 ("mm/hugetlb: introduce set_huge_swap_pte_at()
> helper") add set_huge_swap_pte_at() to handle swap entries on
> architectures that support hugepages consisting of contiguous ptes.
> And currently the set_huge_swap_pte_at() is only overridden by arm64.
> 
> The set_huge_swap_pte_at() provide a sz parameter to help determine
> the number of entries to be updated. But in fact, all hugetlb swap
> entries contain pfn information, so we can find the corresponding
> folio through the pfn recorded in the swap entry, then the folio_size()
> is the number of entries that need to be updated.
> 
> And considering that users will easily cause bugs by ignoring the
> difference between set_huge_swap_pte_at() and set_huge_pte_at().
> Let's handle swap entries in set_huge_pte_at() and remove the
> set_huge_swap_pte_at(), then we can call set_huge_pte_at()
> anywhere, which simplifies our coding.
> 
> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
> ---
>  arch/arm64/include/asm/hugetlb.h |  3 ---
>  arch/arm64/mm/hugetlbpage.c      | 34 ++++++++++++++++----------------
>  include/linux/hugetlb.h          | 13 ------------
>  mm/hugetlb.c                     |  8 +++-----
>  mm/rmap.c                        | 11 +++--------
>  5 files changed, 23 insertions(+), 46 deletions(-)
> 
> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
> index 1fd2846dbefe..d20f5da2d76f 100644
> --- a/arch/arm64/include/asm/hugetlb.h
> +++ b/arch/arm64/include/asm/hugetlb.h
> @@ -46,9 +46,6 @@ extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>  			   pte_t *ptep, unsigned long sz);
>  #define __HAVE_ARCH_HUGE_PTEP_GET
>  extern pte_t huge_ptep_get(pte_t *ptep);
> -extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
> -				 pte_t *ptep, pte_t pte, unsigned long sz);
> -#define set_huge_swap_pte_at set_huge_swap_pte_at
>  
>  void __init arm64_hugetlb_cma_reserve(void);
>  
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index c9e076683e5d..58b89b9d13e0 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -238,6 +238,13 @@ static void clear_flush(struct mm_struct *mm,
>  	flush_tlb_range(&vma, saddr, addr);
>  }
>  
> +static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
> +{
> +	VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
> +
> +	return page_folio(pfn_to_page(swp_offset(entry)));
> +}

Extracting this huge page size from swap entry is an additional operation which
will increase the over all cost for set_huge_swap_pte_at(). At present the size
value is readily available near set_huge_swap_pte_at() call sites.
