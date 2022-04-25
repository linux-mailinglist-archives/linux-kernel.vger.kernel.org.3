Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 43D9D50D8F6
	for <lists+linux-kernel@lfdr.de>; Mon, 25 Apr 2022 07:52:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236115AbiDYFza (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 25 Apr 2022 01:55:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231330AbiDYFzW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 25 Apr 2022 01:55:22 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 1694B36318
        for <linux-kernel@vger.kernel.org>; Sun, 24 Apr 2022 22:52:17 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id ACB7F1FB;
        Sun, 24 Apr 2022 22:52:16 -0700 (PDT)
Received: from [10.163.40.250] (unknown [10.163.40.250])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5DF9A3F774;
        Sun, 24 Apr 2022 22:52:06 -0700 (PDT)
Message-ID: <0f4de9db-1e36-b9d8-bd94-6e3ec3842940@arm.com>
Date:   Mon, 25 Apr 2022 11:22:58 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH -next v5 3/5] mm: page_table_check: add hooks to public
 helpers
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
 <20220421082042.1167967-4-tongtiangen@huawei.com>
 <7fc56f41-a3c2-76be-7a20-dda392f3c4fc@arm.com>
 <eaf17cfc-880e-2181-b253-d520781c428f@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <eaf17cfc-880e-2181-b253-d520781c428f@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-8.8 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/24/22 09:40, Tong Tiangen wrote:
> 
> 
> 在 2022/4/22 14:05, Anshuman Khandual 写道:
>>
>>
>> On 4/21/22 13:50, Tong Tiangen wrote:
>>> Move ptep_clear() to the include/linux/pgtable.h and add page table check
>>> relate hooks to some helpers, it's prepare for support page table check
>>> feature on new architecture.
>>
>> Could instrumenting generic page table helpers (fallback instances when its
>> corresponding __HAVE_ARCH_XXX is not defined on the platform), might add all
>> the page table check hooks into paths on platforms which have not subscribed
>> ARCH_SUPPORTS_PAGE_TABLE_CHECK in the first place ? Although these looks have
>> !CONFIG_PAGE_TABLE_CHECK fallback stubs in the header, hence a build problem
>> gets avoided.
> 
> Right, build problems are avoided by fallback stubs in the header file.

Although there might not be a build problem as such, but should non subscribing
platforms get their page table helpers instrumented with page table check hooks
in the first place ? The commit message should address these questions.

> 
>>
>>>
>>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>>> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>>> ---
>>>   arch/x86/include/asm/pgtable.h | 10 ----------
>>>   include/linux/pgtable.h        | 26 ++++++++++++++++++--------
>>>   2 files changed, 18 insertions(+), 18 deletions(-)
>>>
>>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>>> index 564abe42b0f7..51cd39858f81 100644
>>> --- a/arch/x86/include/asm/pgtable.h
>>> +++ b/arch/x86/include/asm/pgtable.h
>>> @@ -1073,16 +1073,6 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>>>       return pte;
>>>   }
>>>   -#define __HAVE_ARCH_PTEP_CLEAR
>>
>> AFICS X86 is the only platform subscribing __HAVE_ARCH_PTEP_CLEAR. Hence if
>> this is getting dropped for generic ptep_clear(), then no need to add back
>> #ifnded __HAVE_ARCH_PTEP_CLEAR construct. Generic ptep_clear() is the only
>> definition for all platforms ?
>>
>> Also if this patch is trying to drop off __HAVE_ARCH_PTEP_CLEAR along with
>> other page table check related changes, it needs to be done via a separate
>> patch instead.
> 
> Agreed.
> IMO, this fix can be patched later.
> 
>>
>>> -static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>>> -                  pte_t *ptep)
>>> -{
>>> -    if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
>>> -        ptep_get_and_clear(mm, addr, ptep);
>>> -    else
>>> -        pte_clear(mm, addr, ptep);
>>> -}
>>> -
>>>   #define __HAVE_ARCH_PTEP_SET_WRPROTECT
>>>   static inline void ptep_set_wrprotect(struct mm_struct *mm,
>>>                         unsigned long addr, pte_t *ptep)
>>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>>> index 49ab8ee2d6d7..10d2d91edf20 100644
>>> --- a/include/linux/pgtable.h
>>> +++ b/include/linux/pgtable.h
>>> @@ -12,6 +12,7 @@
>>>   #include <linux/bug.h>
>>>   #include <linux/errno.h>
>>>   #include <asm-generic/pgtable_uffd.h>
>>> +#include <linux/page_table_check.h>
>>>     #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED) - \
>>>       defined(__PAGETABLE_PMD_FOLDED) != CONFIG_PGTABLE_LEVELS
>>> @@ -272,14 +273,6 @@ static inline bool arch_has_hw_pte_young(void)
>>>   }
>>>   #endif
>>>   -#ifndef __HAVE_ARCH_PTEP_CLEAR
>>> -static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>>> -                  pte_t *ptep)
>>> -{
>>> -    pte_clear(mm, addr, ptep);
>>> -}
>>> -#endif
>>> -
>>>   #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>>   static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>                          unsigned long address,
>>> @@ -287,10 +280,22 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>>   {
>>>       pte_t pte = *ptep;
>>>       pte_clear(mm, address, ptep);
>>> +    page_table_check_pte_clear(mm, address, pte);
>>>       return pte;
>>>   }
>>>   #endif
>>>   +#ifndef __HAVE_ARCH_PTEP_CLEAR
>>> +static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>>> +                  pte_t *ptep)
>>> +{
>>> +    if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
>>> +        ptep_get_and_clear(mm, addr, ptep);
>>> +    else
>>> +        pte_clear(mm, addr, ptep);
>>
>> Could not this be reworked to avoid IS_ENABLED() ? This is confusing. If the page
>> table hooks can be added to all potential page table paths via generic helpers,
>> irrespective of CONFIG_PAGE_TABLE_CHECK option, there is no rationale for doing
>> a IS_ENABLED() check here.
>>
> 
> From the perspective of code logic, we need to check the pte before being cleared. Whether pte check is required depends on IS_ENABLED().
> 
> Are there any suggestions for better implementation?

But other generic page table helpers already have page table check hooks
instrumented without IS_ENABLED() checks, then why this is any different.

> 
> Thank you,
> Tong.
> 
>>> +}
>>> +#endif
>>> +
>>>   #ifndef __HAVE_ARCH_PTEP_GET
>>>   static inline pte_t ptep_get(pte_t *ptep)
>>>   {
>>> @@ -360,7 +365,10 @@ static inline pmd_t pmdp_huge_get_and_clear(struct mm_struct *mm,
>>>                           pmd_t *pmdp)
>>>   {
>>>       pmd_t pmd = *pmdp;
>>> +
>>>       pmd_clear(pmdp);
>>> +    page_table_check_pmd_clear(mm, address, pmd);
>>> +
>>>       return pmd;
>>>   }
>>>   #endif /* __HAVE_ARCH_PMDP_HUGE_GET_AND_CLEAR */
>>> @@ -372,6 +380,8 @@ static inline pud_t pudp_huge_get_and_clear(struct mm_struct *mm,
>>>       pud_t pud = *pudp;
>>>         pud_clear(pudp);
>>> +    page_table_check_pud_clear(mm, address, pud);
>>> +
>>>       return pud;
>>>   }
>>>   #endif /* __HAVE_ARCH_PUDP_HUGE_GET_AND_CLEAR */
>> .
