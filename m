Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8400F532360
	for <lists+linux-kernel@lfdr.de>; Tue, 24 May 2022 08:40:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233910AbiEXGkQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 02:40:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233657AbiEXGkK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 02:40:10 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E143397282
        for <linux-kernel@vger.kernel.org>; Mon, 23 May 2022 23:40:07 -0700 (PDT)
Received: from kwepemi500010.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4L6kzw12hFz1JBnB;
        Tue, 24 May 2022 14:38:36 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500010.china.huawei.com (7.221.188.191) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 14:40:05 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 24 May 2022 14:40:03 +0800
Message-ID: <a5a95a70-c9ce-e030-dcb7-8734f85a17cc@huawei.com>
Date:   Tue, 24 May 2022 14:40:02 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v7 6/6] riscv/mm: Enable
 ARCH_SUPPORTS_PAGE_TABLE_CHECK
To:     Palmer Dabbelt <palmer@dabbelt.com>,
        Palmer Dabbelt <palmer@rivosinc.com>
CC:     <tglx@linutronix.de>, <mingo@redhat.com>, <bp@alien8.de>,
        <dave.hansen@linux.intel.com>, <x86@kernel.org>, <hpa@zytor.com>,
        <pasha.tatashin@soleen.com>, <anshuman.khandual@arm.com>,
        <akpm@linux-foundation.org>, <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        <aou@eecs.berkeley.edu>, <linux-kernel@vger.kernel.org>,
        <linux-mm@kvack.org>, <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>, <wangkefeng.wang@huawei.com>,
        <guohanjun@huawei.com>
References: <mhng-7c6392da-5321-4fc6-b0af-c6b41b300a6a@palmer-mbp2014>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <mhng-7c6392da-5321-4fc6-b0af-c6b41b300a6a@palmer-mbp2014>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/5/24 12:17, Palmer Dabbelt 写道:
> On Sat, 07 May 2022 04:01:14 PDT (-0700), tongtiangen@huawei.com wrote:
>> As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table 
>> check")
>> , enable ARCH_SUPPORTS_PAGE_TABLE_CHECK on riscv.
>>
>> Add additional page table check stubs for page table helpers, these stubs
>> can be used to check the existing page table entries.
>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
> 
> This doesn't build on rv32 (or presumably any other 32-bit arch) 
> something like this should do it
> 
>     diff --git a/arch/riscv/include/asm/pgtable.h 
> b/arch/riscv/include/asm/pgtable.h
>     index 2b18e4410c4d..ea658ed6a1b1 100644
>     --- a/arch/riscv/include/asm/pgtable.h
>     +++ b/arch/riscv/include/asm/pgtable.h
>     @@ -690,11 +690,13 @@ static inline bool 
> pmd_user_accessible_page(pmd_t pmd)
>          return pmd_leaf(pmd) && pmd_user(pmd);
>      }
>     +#ifdef CONFIG_64BIT
>      static inline bool pud_user_accessible_page(pud_t pud)
>      {
>          return pud_leaf(pud) && pud_user(pud);
>      }
>     -#endif
>     +#endif /* CONFIG_64BIT */
>     +#endif /* CONFIG_PAGE_TABLE_CHECK */
>      #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>      static inline int pmd_trans_huge(pmd_t pmd)
>     diff --git a/mm/page_table_check.c b/mm/page_table_check.c
>     index 3692bea2ea2c..ac9bddfa1398 100644
>     --- a/mm/page_table_check.c
>     +++ b/mm/page_table_check.c
>     @@ -165,6 +165,7 @@ void __page_table_check_pmd_clear(struct 
> mm_struct *mm, unsigned long addr,
>      }
>      EXPORT_SYMBOL(__page_table_check_pmd_clear);
>     +#if CONFIG_PGTABLE_LEVELS > 3
>      void __page_table_check_pud_clear(struct mm_struct *mm, unsigned 
> long addr,
>                        pud_t pud)
>      {
>     @@ -177,6 +178,7 @@ void __page_table_check_pud_clear(struct 
> mm_struct *mm, unsigned long addr,
>          }
>      }
>      EXPORT_SYMBOL(__page_table_check_pud_clear);
>     +#endif
>      void __page_table_check_pte_set(struct mm_struct *mm, unsigned long 
> addr,
>                      pte_t *ptep, pte_t pte)
>     @@ -208,6 +210,7 @@ void __page_table_check_pmd_set(struct mm_struct 
> *mm, unsigned long addr,
>      }
>      EXPORT_SYMBOL(__page_table_check_pmd_set);
>     +#if CONFIG_PGTABLE_LEVELS > 3
>      void __page_table_check_pud_set(struct mm_struct *mm, unsigned long 
> addr,
>                      pud_t *pudp, pud_t pud)
>      {
>     @@ -222,6 +225,7 @@ void __page_table_check_pud_set(struct mm_struct 
> *mm, unsigned long addr,
>          }
>      }
>      EXPORT_SYMBOL(__page_table_check_pud_set);
>     +#endif
>      void __page_table_check_pte_clear_range(struct mm_struct *mm,
>                          unsigned long addr,
> 
> with those changes this passes my tests, so
> 
> Acked-by: Palmer Dabbelt <palmer@rivosinc.com>
> 
> Feel free to take this along with the rest of them if that's easier, the 
> RISC-V bits are pretty light-weight.  Also happy to do some sort of 
> shared tag once the other issues get sorted out.
> 
> Thanks!

Hi, palmer, thanks for you reply.

I fixed the issue on riscv32 a few days ago. It seems that it can also 
solve the issue you said.

https://lore.kernel.org/lkml/20220517074548.2227779-2-tongtiangen@huawei.com/

Thanks,
Tong.
> 
>> ---
>>  arch/riscv/Kconfig               |  1 +
>>  arch/riscv/include/asm/pgtable.h | 71 +++++++++++++++++++++++++++++---
>>  2 files changed, 66 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/riscv/Kconfig b/arch/riscv/Kconfig
>> index 715390feb6ea..bb9fde09eea5 100644
>> --- a/arch/riscv/Kconfig
>> +++ b/arch/riscv/Kconfig
>> @@ -38,6 +38,7 @@ config RISCV
>>      select ARCH_SUPPORTS_ATOMIC_RMW
>>      select ARCH_SUPPORTS_DEBUG_PAGEALLOC if MMU
>>      select ARCH_SUPPORTS_HUGETLBFS if MMU
>> +    select ARCH_SUPPORTS_PAGE_TABLE_CHECK
>>      select ARCH_USE_MEMTEST
>>      select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT if MMU
>>      select ARCH_WANT_FRAME_POINTERS
>> diff --git a/arch/riscv/include/asm/pgtable.h 
>> b/arch/riscv/include/asm/pgtable.h
>> index 046b44225623..62e733c85836 100644
>> --- a/arch/riscv/include/asm/pgtable.h
>> +++ b/arch/riscv/include/asm/pgtable.h
>> @@ -114,6 +114,8 @@
>>  #include <asm/pgtable-32.h>
>>  #endif /* CONFIG_64BIT */
>>
>> +#include <linux/page_table_check.h>
>> +
>>  #ifdef CONFIG_XIP_KERNEL
>>  #define XIP_FIXUP(addr) ({                            \
>>      uintptr_t __a = (uintptr_t)(addr);                    \
>> @@ -315,6 +317,11 @@ static inline int pte_exec(pte_t pte)
>>      return pte_val(pte) & _PAGE_EXEC;
>>  }
>>
>> +static inline int pte_user(pte_t pte)
>> +{
>> +    return pte_val(pte) & _PAGE_USER;
>> +}
>> +
>>  static inline int pte_huge(pte_t pte)
>>  {
>>      return pte_present(pte) && (pte_val(pte) & _PAGE_LEAF);
>> @@ -446,7 +453,7 @@ static inline void set_pte(pte_t *ptep, pte_t pteval)
>>
>>  void flush_icache_pte(pte_t pte);
>>
>> -static inline void set_pte_at(struct mm_struct *mm,
>> +static inline void __set_pte_at(struct mm_struct *mm,
>>      unsigned long addr, pte_t *ptep, pte_t pteval)
>>  {
>>      if (pte_present(pteval) && pte_exec(pteval))
>> @@ -455,10 +462,17 @@ static inline void set_pte_at(struct mm_struct *mm,
>>      set_pte(ptep, pteval);
>>  }
>>
>> +static inline void set_pte_at(struct mm_struct *mm,
>> +    unsigned long addr, pte_t *ptep, pte_t pteval)
>> +{
>> +    page_table_check_pte_set(mm, addr, ptep, pteval);
>> +    __set_pte_at(mm, addr, ptep, pteval);
>> +}
>> +
>>  static inline void pte_clear(struct mm_struct *mm,
>>      unsigned long addr, pte_t *ptep)
>>  {
>> -    set_pte_at(mm, addr, ptep, __pte(0));
>> +    __set_pte_at(mm, addr, ptep, __pte(0));
>>  }
>>
>>  #define __HAVE_ARCH_PTEP_SET_ACCESS_FLAGS
>> @@ -479,7 +493,11 @@ static inline int ptep_set_access_flags(struct 
>> vm_area_struct *vma,
>>  static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>                         unsigned long address, pte_t *ptep)
>>  {
>> -    return __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
>> +    pte_t pte = __pte(atomic_long_xchg((atomic_long_t *)ptep, 0));
>> +
>> +    page_table_check_pte_clear(mm, address, pte);
>> +
>> +    return pte;
>>  }
>>
>>  #define __HAVE_ARCH_PTEP_TEST_AND_CLEAR_YOUNG
>> @@ -546,6 +564,13 @@ static inline unsigned long pmd_pfn(pmd_t pmd)
>>      return ((__pmd_to_phys(pmd) & PMD_MASK) >> PAGE_SHIFT);
>>  }
>>
>> +#define __pud_to_phys(pud)  (pud_val(pud) >> _PAGE_PFN_SHIFT << 
>> PAGE_SHIFT)
>> +
>> +static inline unsigned long pud_pfn(pud_t pud)
>> +{
>> +    return ((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT);
>> +}
>> +
>>  static inline pmd_t pmd_modify(pmd_t pmd, pgprot_t newprot)
>>  {
>>      return pte_pmd(pte_modify(pmd_pte(pmd), newprot));
>> @@ -567,6 +592,11 @@ static inline int pmd_young(pmd_t pmd)
>>      return pte_young(pmd_pte(pmd));
>>  }
>>
>> +static inline int pmd_user(pmd_t pmd)
>> +{
>> +    return pte_user(pmd_pte(pmd));
>> +}
>> +
>>  static inline pmd_t pmd_mkold(pmd_t pmd)
>>  {
>>      return pte_pmd(pte_mkold(pmd_pte(pmd)));
>> @@ -600,15 +630,39 @@ static inline pmd_t pmd_mkdirty(pmd_t pmd)
>>  static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>>                  pmd_t *pmdp, pmd_t pmd)
>>  {
>> -    return set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
>> +    page_table_check_pmd_set(mm, addr, pmdp, pmd);
>> +    return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
>> +}
>> +
>> +static inline int pud_user(pud_t pud)
>> +{
>> +    return pte_user(pud_pte(pud));
>>  }
>>
>>  static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
>>                  pud_t *pudp, pud_t pud)
>>  {
>> -    return set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud));
>> +    page_table_check_pud_set(mm, addr, pudp, pud);
>> +    return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud));
>> +}
>> +
>> +#ifdef CONFIG_PAGE_TABLE_CHECK
>> +static inline bool pte_user_accessible_page(pte_t pte)
>> +{
>> +    return pte_present(pte) && pte_user(pte);
>> +}
>> +
>> +static inline bool pmd_user_accessible_page(pmd_t pmd)
>> +{
>> +    return pmd_leaf(pmd) && pmd_user(pmd);
>>  }
>>
>> +static inline bool pud_user_accessible_page(pud_t pud)
>> +{
>> +    return pud_leaf(pud) && pud_user(pud);
>> +}
>> +#endif
>> +
>>  #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>  static inline int pmd_trans_huge(pmd_t pmd)
>>  {
>> @@ -634,7 +688,11 @@ static inline int 
>> pmdp_test_and_clear_young(struct vm_area_struct *vma,
>>  static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>>                      unsigned long address, pmd_t *pmdp)
>>  {
>> -    return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
>> +    pmd_t pmd = __pmd(atomic_long_xchg((atomic_long_t *)pmdp, 0));
>> +
>> +    page_table_check_pmd_clear(mm, address, pmd);
>> +
>> +    return pmd;
>>  }
>>
>>  #define __HAVE_ARCH_PMDP_SET_WRPROTECT
>> @@ -648,6 +706,7 @@ static inline void pmdp_set_wrprotect(struct 
>> mm_struct *mm,
>>  static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>>                  unsigned long address, pmd_t *pmdp, pmd_t pmd)
>>  {
>> +    page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
>>      return __pmd(atomic_long_xchg((atomic_long_t *)pmdp, pmd_val(pmd)));
>>  }
>>  #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
> .
