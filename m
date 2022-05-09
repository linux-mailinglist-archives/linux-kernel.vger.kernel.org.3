Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0DDC651F83A
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 11:30:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237642AbiEIJds (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 05:33:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57324 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238629AbiEIJL5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 05:11:57 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8144518A681
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 02:08:03 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 430B21480;
        Mon,  9 May 2022 02:08:03 -0700 (PDT)
Received: from [10.163.34.187] (unknown [10.163.34.187])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 594C83F66F;
        Mon,  9 May 2022 02:07:54 -0700 (PDT)
Message-ID: <730c7b4a-663f-d7e3-6e0f-090d322103d4@arm.com>
Date:   Mon, 9 May 2022 14:39:04 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next v7 5/6] arm64/mm: Enable
 ARCH_SUPPORTS_PAGE_TABLE_CHECK
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
References: <20220507110114.4128854-1-tongtiangen@huawei.com>
 <20220507110114.4128854-6-tongtiangen@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220507110114.4128854-6-tongtiangen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/7/22 16:31, Tong Tiangen wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table check")
> , enable ARCH_SUPPORTS_PAGE_TABLE_CHECK on arm64.
> 
> Add additional page table check stubs for page table helpers, these stubs
> can be used to check the existing page table entries.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>

Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>

> ---
>  arch/arm64/Kconfig               |  1 +
>  arch/arm64/include/asm/pgtable.h | 61 ++++++++++++++++++++++++++++----
>  2 files changed, 56 insertions(+), 6 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index 272c75af9302..3055fb5b3fb4 100644
> --- a/arch/arm64/Kconfig
> +++ b/arch/arm64/Kconfig
> @@ -92,6 +92,7 @@ config ARM64
>  	select ARCH_SUPPORTS_ATOMIC_RMW
>  	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>  	select ARCH_SUPPORTS_NUMA_BALANCING
> +	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
>  	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
>  	select ARCH_WANT_DEFAULT_BPF_JIT
>  	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
> index 8ebf1cec5d90..4e61cde27f9f 100644
> --- a/arch/arm64/include/asm/pgtable.h
> +++ b/arch/arm64/include/asm/pgtable.h
> @@ -33,6 +33,7 @@
>  #include <linux/mmdebug.h>
>  #include <linux/mm_types.h>
>  #include <linux/sched.h>
> +#include <linux/page_table_check.h>
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>  #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
> @@ -96,6 +97,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>  #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
>  #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
>  #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
> +#define pte_user(pte)		(!!(pte_val(pte) & PTE_USER))
>  #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
>  #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
>  #define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
> @@ -312,8 +314,8 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
>  		     __func__, pte_val(old_pte), pte_val(pte));
>  }
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> -			      pte_t *ptep, pte_t pte)
> +static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
> +				pte_t *ptep, pte_t pte)
>  {
>  	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
>  		__sync_icache_dcache(pte);
> @@ -343,6 +345,13 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>  	set_pte(ptep, pte);
>  }
>  
> +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> +			      pte_t *ptep, pte_t pte)
> +{
> +	page_table_check_pte_set(mm, addr, ptep, pte);
> +	return __set_pte_at(mm, addr, ptep, pte);
> +}
> +
>  /*
>   * Huge pte definitions.
>   */
> @@ -454,6 +463,8 @@ static inline int pmd_trans_huge(pmd_t pmd)
>  #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
>  #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
>  #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
> +#define pmd_user(pmd)		pte_user(pmd_pte(pmd))
> +#define pmd_user_exec(pmd)	pte_user_exec(pmd_pte(pmd))
>  #define pmd_cont(pmd)		pte_cont(pmd_pte(pmd))
>  #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
>  #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
> @@ -501,8 +512,19 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>  #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
>  #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>  
> -#define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
> -#define set_pud_at(mm, addr, pudp, pud)	set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud))
> +static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
> +			      pmd_t *pmdp, pmd_t pmd)
> +{
> +	page_table_check_pmd_set(mm, addr, pmdp, pmd);
> +	return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
> +}
> +
> +static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
> +			      pud_t *pudp, pud_t pud)
> +{
> +	page_table_check_pud_set(mm, addr, pudp, pud);
> +	return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud));
> +}
>  
>  #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
>  #define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)
> @@ -643,6 +665,24 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>  #define pud_present(pud)	pte_present(pud_pte(pud))
>  #define pud_leaf(pud)		(pud_present(pud) && !pud_table(pud))
>  #define pud_valid(pud)		pte_valid(pud_pte(pud))
> +#define pud_user(pud)		pte_user(pud_pte(pud))
> +
> +#ifdef CONFIG_PAGE_TABLE_CHECK
> +static inline bool pte_user_accessible_page(pte_t pte)
> +{
> +	return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
> +}
> +
> +static inline bool pmd_user_accessible_page(pmd_t pmd)
> +{
> +	return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
> +}
> +
> +static inline bool pud_user_accessible_page(pud_t pud)
> +{
> +	return pud_present(pud) && pud_user(pud);
> +}
> +#endif
>  
>  static inline void set_pud(pud_t *pudp, pud_t pud)
>  {
> @@ -876,7 +916,11 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				       unsigned long address, pte_t *ptep)
>  {
> -	return __pte(xchg_relaxed(&pte_val(*ptep), 0));
> +	pte_t pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
> +
> +	page_table_check_pte_clear(mm, address, pte);
> +
> +	return pte;
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -884,7 +928,11 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>  					    unsigned long address, pmd_t *pmdp)
>  {
> -	return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
> +	pmd_t pmd = __pmd(xchg_relaxed(&pmd_val(*pmdp), 0));
> +
> +	page_table_check_pmd_clear(mm, address, pmd);
> +
> +	return pmd;
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> @@ -918,6 +966,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>  static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  		unsigned long address, pmd_t *pmdp, pmd_t pmd)
>  {
> +	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
>  	return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
>  }
>  #endif
