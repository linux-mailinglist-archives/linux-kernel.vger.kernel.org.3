Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B28F50AF6F
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 07:11:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444127AbiDVFNu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 01:13:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49390 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386384AbiDVFNs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 01:13:48 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 142CC4BFFE
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 22:10:57 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id B38E11570;
        Thu, 21 Apr 2022 22:10:56 -0700 (PDT)
Received: from [10.163.40.48] (unknown [10.163.40.48])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AD00C3F5A1;
        Thu, 21 Apr 2022 22:10:47 -0700 (PDT)
Message-ID: <905f22d6-0671-21b2-a341-bdc5ba02e59c@arm.com>
Date:   Fri, 22 Apr 2022 10:41:34 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next v5 2/5] mm: page_table_check: move
 pxx_user_accessible_page into x86
Content-Language: en-US
To:     Tong Tiangen <tongtiangen@huawei.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, x86@kernel.org,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        linux-arm-kernel@lists.infradead.org,
        linux-riscv@lists.infradead.org,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220421082042.1167967-1-tongtiangen@huawei.com>
 <20220421082042.1167967-3-tongtiangen@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220421082042.1167967-3-tongtiangen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.1 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Similar to previous commits on the same file, the following subject
line format, would have been preferred.

mm/page_table_check: <description>

On 4/21/22 13:50, Tong Tiangen wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> The pxx_user_accessible_page() check the PTE bit, it's

s/check/checks			 ^^^^

> architecture-specific code, move them into x86's pgtable.h
The commit message should have been more clear, atleast complete in
sentences. I dont want to be bike shedding here but this is definitely
incomplete. These helpers are being moved out to make the page table
check framework, platform independent. Hence the commit message should
mention this.

> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/x86/include/asm/pgtable.h | 19 +++++++++++++++++++
>  mm/page_table_check.c          | 17 -----------------
>  2 files changed, 19 insertions(+), 17 deletions(-)
> 
> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
> index b7464f13e416..564abe42b0f7 100644
> --- a/arch/x86/include/asm/pgtable.h
> +++ b/arch/x86/include/asm/pgtable.h
> @@ -1447,6 +1447,25 @@ static inline bool arch_has_hw_pte_young(void)
>  	return true;
>  }
>  
> +#ifdef CONFIG_PAGE_TABLE_CHECK
> +static inline bool pte_user_accessible_page(pte_t pte)
> +{
> +	return (pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) & _PAGE_USER);
> +}
> +
> +static inline bool pmd_user_accessible_page(pmd_t pmd)
> +{
> +	return pmd_leaf(pmd) && (pmd_val(pmd) & _PAGE_PRESENT) &&
> +		(pmd_val(pmd) & _PAGE_USER);
> +}
> +
> +static inline bool pud_user_accessible_page(pud_t pud)
> +{
> +	return pud_leaf(pud) && (pud_val(pud) & _PAGE_PRESENT) &&
> +		(pud_val(pud) & _PAGE_USER);

A line break is not really required here (and above as well). As single
complete line would still be within 100 characters.

> +}
> +#endif
> +
>  #endif	/* __ASSEMBLY__ */
>  
>  #endif /* _ASM_X86_PGTABLE_H */
> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
> index eb0d0b71cdf6..3692bea2ea2c 100644
> --- a/mm/page_table_check.c
> +++ b/mm/page_table_check.c
> @@ -52,23 +52,6 @@ static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
>  	return (void *)(page_ext) + page_table_check_ops.offset;
>  }
>  
> -static inline bool pte_user_accessible_page(pte_t pte)
> -{
> -	return (pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) & _PAGE_USER);
> -}
> -
> -static inline bool pmd_user_accessible_page(pmd_t pmd)
> -{
> -	return pmd_leaf(pmd) && (pmd_val(pmd) & _PAGE_PRESENT) &&
> -		(pmd_val(pmd) & _PAGE_USER);
> -}
> -
> -static inline bool pud_user_accessible_page(pud_t pud)
> -{
> -	return pud_leaf(pud) && (pud_val(pud) & _PAGE_PRESENT) &&
> -		(pud_val(pud) & _PAGE_USER);
> -}
> -
>  /*
>   * An enty is removed from the page table, decrement the counters for that page
>   * verify that it is of correct type and counters do not become negative.

With above mentioned code cleanup and commit message changes in place.

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
