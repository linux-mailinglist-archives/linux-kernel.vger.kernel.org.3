Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65CD1517B92
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 03:14:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230016AbiECBRF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 21:17:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229979AbiECBQ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 21:16:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E23F55007E
        for <linux-kernel@vger.kernel.org>; Mon,  2 May 2022 18:13:24 -0700 (PDT)
Received: from kwepemi500004.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4Kshly6yS3zhYnw;
        Tue,  3 May 2022 09:13:02 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500004.china.huawei.com (7.221.188.17) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 09:13:22 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 3 May 2022 09:13:21 +0800
Message-ID: <80f6c347-db5d-8836-bc79-60c7b2a6eed8@huawei.com>
Date:   Tue, 3 May 2022 09:13:20 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v6 5/6] arm64/mm: Enable
 ARCH_SUPPORTS_PAGE_TABLE_CHECK
To:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>, <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>
CC:     <linux-kernel@vger.kernel.org>, <linux-mm@kvack.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Guohanjun <guohanjun@huawei.com>
References: <20220426081036.1374452-1-tongtiangen@huawei.com>
 <20220426081036.1374452-6-tongtiangen@huawei.com>
 <ae74ea7c-9014-b162-f1e7-a66f402aee49@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <ae74ea7c-9014-b162-f1e7-a66f402aee49@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-5.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/29 14:18, Anshuman Khandual 写道:
> 
> 
> On 4/26/22 13:40, Tong Tiangen wrote:
>> From: Kefeng Wang <wangkefeng.wang@huawei.com>
>>
>> As commit d283d422c6c4 ("x86: mm: add x86_64 support for page table check")
>> , enable ARCH_SUPPORTS_PAGE_TABLE_CHECK on arm64.
>>
>> Add additional page table check stubs for page table helpers, these stubs
>> can be used to check the existing page table entries.
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> Reviewed-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>   arch/arm64/Kconfig               |  1 +
>>   arch/arm64/include/asm/pgtable.h | 59 +++++++++++++++++++++++++++++---
>>   2 files changed, 55 insertions(+), 5 deletions(-)
>>
>> diff --git a/arch/arm64/Kconfig b/arch/arm64/Kconfig
>> index 18a18a0e855d..c1509525ab8e 100644
>> --- a/arch/arm64/Kconfig
>> +++ b/arch/arm64/Kconfig
>> @@ -92,6 +92,7 @@ config ARM64
>>   	select ARCH_SUPPORTS_ATOMIC_RMW
>>   	select ARCH_SUPPORTS_INT128 if CC_HAS_INT128
>>   	select ARCH_SUPPORTS_NUMA_BALANCING
>> +	select ARCH_SUPPORTS_PAGE_TABLE_CHECK
>>   	select ARCH_WANT_COMPAT_IPC_PARSE_VERSION if COMPAT
>>   	select ARCH_WANT_DEFAULT_BPF_JIT
>>   	select ARCH_WANT_DEFAULT_TOPDOWN_MMAP_LAYOUT
>> diff --git a/arch/arm64/include/asm/pgtable.h b/arch/arm64/include/asm/pgtable.h
>> index ad9b221963d4..fe17788a6885 100644
>> --- a/arch/arm64/include/asm/pgtable.h
>> +++ b/arch/arm64/include/asm/pgtable.h
>> @@ -33,6 +33,7 @@
>>   #include <linux/mmdebug.h>
>>   #include <linux/mm_types.h>
>>   #include <linux/sched.h>
>> +#include <linux/page_table_check.h>
>>   
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>>   #define __HAVE_ARCH_FLUSH_PMD_TLB_RANGE
>> @@ -96,6 +97,7 @@ static inline pteval_t __phys_to_pte_val(phys_addr_t phys)
>>   #define pte_young(pte)		(!!(pte_val(pte) & PTE_AF))
>>   #define pte_special(pte)	(!!(pte_val(pte) & PTE_SPECIAL))
>>   #define pte_write(pte)		(!!(pte_val(pte) & PTE_WRITE))
>> +#define pte_user(pte)		(!!(pte_val(pte) & PTE_USER))
>>   #define pte_user_exec(pte)	(!(pte_val(pte) & PTE_UXN))
>>   #define pte_cont(pte)		(!!(pte_val(pte) & PTE_CONT))
>>   #define pte_devmap(pte)		(!!(pte_val(pte) & PTE_DEVMAP))
>> @@ -312,7 +314,7 @@ static inline void __check_racy_pte_update(struct mm_struct *mm, pte_t *ptep,
>>   		     __func__, pte_val(old_pte), pte_val(pte));
>>   }
>>   
>> -static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>> +static inline void __set_pte_at(struct mm_struct *mm, unsigned long addr,
>>   			      pte_t *ptep, pte_t pte)
> 
> A small nit. Subsequent line containing the arguments "pte_t *ptep ..."
> needs to be aligned properly, after '__' got added into set_pte_at().

OK, missing that, .will fix it next version.

> 
>>   {
>>   	if (pte_present(pte) && pte_user_exec(pte) && !pte_special(pte))
>> @@ -343,6 +345,13 @@ static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>>   	set_pte(ptep, pte);
>>   }
>>   
>> +static inline void set_pte_at(struct mm_struct *mm, unsigned long addr,
>> +			      pte_t *ptep, pte_t pte)
>> +{
>> +	page_table_check_pte_set(mm, addr, ptep, pte);
>> +	return __set_pte_at(mm, addr, ptep, pte);
>> +}
>> +
>>   /*
>>    * Huge pte definitions.
>>    */
>> @@ -454,6 +463,8 @@ static inline int pmd_trans_huge(pmd_t pmd)
>>   #define pmd_dirty(pmd)		pte_dirty(pmd_pte(pmd))
>>   #define pmd_young(pmd)		pte_young(pmd_pte(pmd))
>>   #define pmd_valid(pmd)		pte_valid(pmd_pte(pmd))
>> +#define pmd_user(pmd)		pte_user(pmd_pte(pmd))
>> +#define pmd_user_exec(pmd)	pte_user_exec(pmd_pte(pmd))
>>   #define pmd_cont(pmd)		pte_cont(pmd_pte(pmd))
>>   #define pmd_wrprotect(pmd)	pte_pmd(pte_wrprotect(pmd_pte(pmd)))
>>   #define pmd_mkold(pmd)		pte_pmd(pte_mkold(pmd_pte(pmd)))
>> @@ -501,8 +512,19 @@ static inline pmd_t pmd_mkdevmap(pmd_t pmd)
>>   #define pud_pfn(pud)		((__pud_to_phys(pud) & PUD_MASK) >> PAGE_SHIFT)
>>   #define pfn_pud(pfn,prot)	__pud(__phys_to_pud_val((phys_addr_t)(pfn) << PAGE_SHIFT) | pgprot_val(prot))
>>   
>> -#define set_pmd_at(mm, addr, pmdp, pmd)	set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd))
>> -#define set_pud_at(mm, addr, pudp, pud)	set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud))
>> +static inline void set_pmd_at(struct mm_struct *mm, unsigned long addr,
>> +			      pmd_t *pmdp, pmd_t pmd)
>> +{
>> +	page_table_check_pmd_set(mm, addr, pmdp, pmd);
>> +	return __set_pte_at(mm, addr, (pte_t *)pmdp, pmd_pte(pmd));
>> +}
>> +
>> +static inline void set_pud_at(struct mm_struct *mm, unsigned long addr,
>> +			      pud_t *pudp, pud_t pud)
>> +{
>> +	page_table_check_pud_set(mm, addr, pudp, pud);
>> +	return __set_pte_at(mm, addr, (pte_t *)pudp, pud_pte(pud));
>> +}
>>   
>>   #define __p4d_to_phys(p4d)	__pte_to_phys(p4d_pte(p4d))
>>   #define __phys_to_p4d_val(phys)	__phys_to_pte_val(phys)
>> @@ -643,6 +665,24 @@ static inline unsigned long pmd_page_vaddr(pmd_t pmd)
>>   #define pud_present(pud)	pte_present(pud_pte(pud))
>>   #define pud_leaf(pud)		pud_sect(pud)
>>   #define pud_valid(pud)		pte_valid(pud_pte(pud))
>> +#define pud_user(pud)		pte_user(pud_pte(pud))
>> +
>> +#ifdef CONFIG_PAGE_TABLE_CHECK
>> +static inline bool pte_user_accessible_page(pte_t pte)
>> +{
>> +	return pte_present(pte) && (pte_user(pte) || pte_user_exec(pte));
>> +}
>> +
>> +static inline bool pmd_user_accessible_page(pmd_t pmd)
>> +{
>> +	return pmd_present(pmd) && (pmd_user(pmd) || pmd_user_exec(pmd));
>> +}
>> +
>> +static inline bool pud_user_accessible_page(pud_t pud)
>> +{
>> +	return pud_present(pud) && pud_user(pud);
>> +}
>> +#endif
>>   
>>   static inline void set_pud(pud_t *pudp, pud_t pud)
>>   {
>> @@ -876,7 +916,11 @@ static inline int pmdp_test_and_clear_young(struct vm_area_struct *vma,
>>   static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>   				       unsigned long address, pte_t *ptep)
>>   {
>> -	return __pte(xchg_relaxed(&pte_val(*ptep), 0));
>> +	pte_t pte = __pte(xchg_relaxed(&pte_val(*ptep), 0));
>> +
>> +	page_table_check_pte_clear(mm, address, pte);
>> +
>> +	return pte;
>>   }
>>   
>>   #ifdef CONFIG_TRANSPARENT_HUGEPAGE
>> @@ -884,7 +928,11 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>   static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>>   					    unsigned long address, pmd_t *pmdp)
>>   {
>> -	return pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
>> +	pmd_t pmd = pte_pmd(__pte(xchg_relaxed(&pte_val(*(pte_t *)pmdp), 0)));
> 
> Why there is any change here ? Why not just the following instead, like what you did
> in ptep_get_and_clear() above. The page table entry return value here just needs to
> be preserved for subsequent page table check helpers.
> 
> 	pmd_t pmd = pte_pmd(ptep_get_and_clear(mm, address, (pte_t *)pmdp));
>

Hi Anshuman:
The purpose of what I do here is to avoid doing 
page_table_check_pte_clear() in ptep_get_and_clear(). there is no 
functional change here.

Thanks,
Tong.


>> +
>> +	page_table_check_pmd_clear(mm, address, pmd);
>> +
>> +	return pmd;
>>   }
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>   
>> @@ -918,6 +966,7 @@ static inline void pmdp_set_wrprotect(struct mm_struct *mm,
>>   static inline pmd_t pmdp_establish(struct vm_area_struct *vma,
>>   		unsigned long address, pmd_t *pmdp, pmd_t pmd)
>>   {
>> +	page_table_check_pmd_set(vma->vm_mm, address, pmdp, pmd);
>>   	return __pmd(xchg_relaxed(&pmd_val(*pmdp), pmd_val(pmd)));
>>   }
>>   #endif
> .
