Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33A174E5D11
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Mar 2022 03:08:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346232AbiCXCJu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 22:09:50 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348652AbiCXCJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 22:09:25 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4E161617A
        for <linux-kernel@vger.kernel.org>; Wed, 23 Mar 2022 19:07:54 -0700 (PDT)
Received: from kwepemi500008.china.huawei.com (unknown [172.30.72.55])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KP7qD2mtszCqsq;
        Thu, 24 Mar 2022 10:05:44 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi500008.china.huawei.com (7.221.188.139) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 10:07:51 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2308.21; Thu, 24 Mar 2022 10:07:50 +0800
Message-ID: <0c95c24d-b980-a8b3-9c68-e10d16e05e10@huawei.com>
Date:   Thu, 24 Mar 2022 10:07:49 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.1
Subject: Re: [PATCH -next v2 2/4] mm: page_table_check: add hooks to public
 helpers
To:     Pasha Tatashin <pasha.tatashin@soleen.com>
CC:     Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        "maintainer:X86 ARCHITECTURE (32-BIT AND 64-BIT)" <x86@kernel.org>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        "Catalin Marinas" <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        "Paul Walmsley" <paul.walmsley@sifive.com>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Albert Ou <aou@eecs.berkeley.edu>,
        LKML <linux-kernel@vger.kernel.org>,
        linux-mm <linux-mm@kvack.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        <linux-riscv@lists.infradead.org>
References: <20220322144447.3563146-1-tongtiangen@huawei.com>
 <20220322144447.3563146-3-tongtiangen@huawei.com>
 <CA+CK2bAa96oE0FbtJUjAJ=vpuzQsW3R60K9SUhca6mZ3BL1f8w@mail.gmail.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <CA+CK2bAa96oE0FbtJUjAJ=vpuzQsW3R60K9SUhca6mZ3BL1f8w@mail.gmail.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/3/24 1:42, Pasha Tatashin 写道:
> On Tue, Mar 22, 2022 at 10:25 AM Tong Tiangen <tongtiangen@huawei.com> wrote:
>>
>> Move ptep_clear() to the include/linux/pgtable.h and add page table check
>> relate hooks to some helpers, it's prepare for support page table check
>> feature on new architecture.
>>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> ---
>>   arch/x86/include/asm/pgtable.h | 10 ----------
>>   include/linux/pgtable.h        | 27 +++++++++++++++++++--------
>>   2 files changed, 19 insertions(+), 18 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index 8cd6514e3052..8c85f2eabbaa 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1077,16 +1077,6 @@ static inline pte_t ptep_get_and_clear_full(struct mm_struct *mm,
>>          return pte;
>>   }
>>
>> -#define __HAVE_ARCH_PTEP_CLEAR
>> -static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>> -                             pte_t *ptep)
>> -{
>> -       if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
>> -               ptep_get_and_clear(mm, addr, ptep);
>> -       else
>> -               pte_clear(mm, addr, ptep);
>> -}
>> -
>>   #define __HAVE_ARCH_PTEP_SET_WRPROTECT
>>   static inline void ptep_set_wrprotect(struct mm_struct *mm,
>>                                        unsigned long addr, pte_t *ptep)
>> diff --git a/include/linux/pgtable.h b/include/linux/pgtable.h
>> index f4f4077b97aa..d27fd0ed84a9 100644
>> --- a/include/linux/pgtable.h
>> +++ b/include/linux/pgtable.h
>> @@ -12,6 +12,7 @@
>>   #include <linux/bug.h>
>>   #include <linux/errno.h>
>>   #include <asm-generic/pgtable_uffd.h>
>> +#include <linux/page_table_check.h>
>>
>>   #if 5 - defined(__PAGETABLE_P4D_FOLDED) - defined(__PAGETABLE_PUD_FOLDED) - \
>>          defined(__PAGETABLE_PMD_FOLDED) != CONFIG_PGTABLE_LEVELS
>> @@ -259,14 +260,6 @@ static inline int pmdp_clear_flush_young(struct vm_area_struct *vma,
>>   #endif /* CONFIG_TRANSPARENT_HUGEPAGE */
>>   #endif
>>
>> -#ifndef __HAVE_ARCH_PTEP_CLEAR
>> -static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>> -                             pte_t *ptep)
>> -{
>> -       pte_clear(mm, addr, ptep);
>> -}
>> -#endif
>> -
>>   #ifndef __HAVE_ARCH_PTEP_GET_AND_CLEAR
>>   static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>                                         unsigned long address,
>> @@ -274,10 +267,23 @@ static inline pte_t ptep_get_and_clear(struct mm_struct *mm,
>>   {
>>          pte_t pte = *ptep;
>>          pte_clear(mm, address, ptep);
>> +       page_table_check_pte_clear(mm, address, pte);
>>          return pte;
>>   }
>>   #endif
>>
>> +#ifndef __HAVE_ARCH_PTEP_CLEAR
>> +static inline void ptep_clear(struct mm_struct *mm, unsigned long addr,
>> +                             pte_t *ptep)
>> +{
>> +#ifdef CONFIG_PAGE_TABLE_CHECK
>> +       ptep_get_and_clear(mm, addr, ptep);
>> +#else
>> +       pte_clear(mm, addr, ptep);
>> +#endif
> 
> I have a preference to use if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK))
> instead of #ifdef. The end result is the same. Otherwise it looks
> good.
> 
> Thanks,
> Pasha
> .

I have a little hesitation when making this change , in theory, add if 
here may affect the performance a little in some scenarios. However, the 
impact on the whole call path should be small.

I will send v3 using if (IS_ENABLED(CONFIG_PAGE_TABLE_CHECK)).

Thanks.
Tong
.
