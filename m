Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 269EB504E5D
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Apr 2022 11:28:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237518AbiDRJac (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Apr 2022 05:30:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49118 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237506AbiDRJa0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Apr 2022 05:30:26 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6127315FEF
        for <linux-kernel@vger.kernel.org>; Mon, 18 Apr 2022 02:27:46 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id E67F5ED1;
        Mon, 18 Apr 2022 02:27:45 -0700 (PDT)
Received: from [10.163.37.247] (unknown [10.163.37.247])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id D84413F7B4;
        Mon, 18 Apr 2022 02:27:37 -0700 (PDT)
Message-ID: <1c314feb-cd78-2bb3-462e-4ea3cefe122e@arm.com>
Date:   Mon, 18 Apr 2022 14:58:20 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next v4 3/4] arm64: mm: add support for page table check
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
References: <20220418034444.520928-1-tongtiangen@huawei.com>
 <20220418034444.520928-4-tongtiangen@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220418034444.520928-4-tongtiangen@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-10.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 4/18/22 09:14, Tong Tiangen wrote:
> From: Kefeng Wang <wangkefeng.wang@huawei.com>
> 
> As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table
> check"), add some necessary page table check hooks into routines that
> modify user page tables.
> 
> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> ---
>  arch/arm64/Kconfig               |  1 +
>  arch/arm64/include/asm/pgtable.h | 65 +++++++++++++++++++++++++++++---
>  2 files changed, 61 insertions(+), 5 deletions(-)
> 
> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
> index e80fd2372f02..7114d2d5155e 100644
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
> index 930077f7b572..9f8f97a7cc7c 100644
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
> @@ -312,7 +314,7 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
>  		     __func__, pte_val(old_pte), pte_val(pte));
>  }
>  
> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
> +static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>  			      pte_t *ptep, pte_t pte)
>  {
>  	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
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
>  #define pud_leaf(pud)		pud_sect(pud)
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
> @@ -872,11 +912,21 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> +static inline pte_t __ptep_get_and_clear(struct mm_struct *mm,
> +				       unsigned long address, pte_t *ptep)
> +{
> +	return __pte(xchg_relaxed(&pte_val(*ptep), 0));
> +}
> +
>  #define __HAVE_ARCH_PTEP_GET_AND_CLEAR
>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  				       unsigned long address, pte_t *ptep)
>  {
> -	return __pte(xchg_relaxed(&pte_val(*ptep), 0));
> +	pte_t pte = __ptep_get_and_clear(mm, address, ptep);
> +
> +	page_table_check_pte_clear(mm, address, pte);
> +
> +	return pte;
>  }
>  
>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
> @@ -884,7 +934,11 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>  static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>  					    unsigned long address, pmd_t *pmdp)
>  {
> -	return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
> +	pmd_t pmd = pte_pmd(__ptep_get_and_clear(mm, address, (pte_t *)pmdp));
> +
> +	page_table_check_pmd_clear(mm, address, pmd);
> +
> +	return pmd;
>  }
>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>  
> @@ -918,6 +972,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>  static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>  		unsigned long address, pmd_t *pmdp, pmd_t pmd)
>  {
> +	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
>  	return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
>  }
>  #endif

Ran this series on arm64 platform after enabling

- CONFIG_PAGE_TABLE_CHECK
- CONFIG_PAGE_TABLE_CHECK_ENFORCED (avoiding kernel command line option)

After some time, the following error came up

[   23.266013] ------------[ cut here ]------------
[   23.266807] kernel BUG at mm/page_table_check.c:90!
[   23.267609] Internal error: Oops - BUG: 0 [#1] PREEMPT SMP
[   23.268503] Modules linked in:                                                                    
[   23.269012] CPU: 1 PID: 30 Comm: khugepaged Not tainted 5.18.0-rc3-00004-g60aa8e363a91 #2
[   23.270383] Hardware name: linux,dummy-virt (DT)
[   23.271210] pstate: 40400005 (nZcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
[   23.272445] pc : page_table_check_clear.isra.6+0x114/0x148
[   23.273429] lr : page_table_check_clear.isra.6+0x64/0x148
[   23.274395] sp : ffff80000afb3ca0
[   23.274994] x29: ffff80000afb3ca0 x28: fffffc00022558e8 x27: ffff80000a27f628
[   23.276260] x26: ffff800009f9f2b0 x25: ffff00008a8d5000 x24: ffff800009f09fa0                     
[   23.277527] x23: 0000ffff89e00000 x22: ffff800009f09fb8 x21: ffff000089414cc0
[   23.278798] x20: 0000000000000200 x19: fffffc00022a0000 x18: 0000000000000001
[   23.280066] x17: 0000000000000001 x16: 0000000000000000 x15: 0000000000000003
[   23.281331] x14: 0000000000000068 x13: 00000000000000c0 x12: 0000000000000010
[   23.282602] x11: fffffc0002320008 x10: fffffc0002320000 x9 : ffff800009fa1000
[   23.283868] x8 : 00000000ffffffff x7 : 0000000000000001 x6 : ffff800009fa1f08
[   23.285135] x5 : 0000000000000000 x4 : 0000000000000000 x3 : 0000000000000000
[   23.286406] x2 : 00000000ffffffff x1 : ffff000080f2800c x0 : ffff000080f28000
[   23.287673] Call trace:
[   23.288123]  page_table_check_clear.isra.6+0x114/0x148
[   23.289043]  __page_table_check_pmd_clear+0x3c/0x50
[   23.289918]  pmdp_collapse_flush+0x114/0x370
[   23.290692]  khugepaged+0x1170/0x19e0
[   23.291356]  kthread+0x110/0x120
[   23.291945]  ret_from_fork+0x10/0x20
[   23.292596] Code: 91001041 b8e80024 51000482 36fffd62 (d4210000) 
[   23.293678] ---[ end trace 0000000000000000 ]---
[   23.294511] note: khugepaged[30] exited with preempt_count 2

Looking into file mm/page_table_check.c where this problem occured.

/*
 * An enty is removed from the page table, decrement the counters for that page
 * verify that it is of correct type and counters do not become negative.
 */
static void page_table_check_clear(struct mm_struct *mm, unsigned long addr,
                                   unsigned long pfn, unsigned long pgcnt)
{
        struct page_ext *page_ext;
        struct page *page;
        unsigned long i;
        bool anon;

        if (!pfn_valid(pfn))
                return;

        page = pfn_to_page(pfn);
        page_ext = lookup_page_ext(page);
        anon = PageAnon(page);

        for (i = 0; i < pgcnt; i++) {
                struct page_table_check *ptc = get_page_table_check(page_ext);

                if (anon) {
                        BUG_ON(atomic_read(&ptc->file_map_count));
                        BUG_ON(atomic_dec_return(&ptc->anon_map_count) < 0);
                } else {
                        BUG_ON(atomic_read(&ptc->anon_map_count));
 Triggered here ====>>  BUG_ON(atomic_dec_return(&ptc->file_map_count) < 0);
                }
                page_ext = page_ext_next(page_ext);
        }
}

Could you explain what was expected during pmdp_collapse_flush() which when
failed, triggered this BUG_ON() ? This counter seems to be page table check
specific, could it just go wrong ? I have not looked into the details about
page table check mechanism.

- Anshuman
