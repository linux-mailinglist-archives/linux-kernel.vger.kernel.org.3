Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C40DD50B0A4
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 08:31:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1444134AbiDVGdX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 02:33:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444445AbiDVGdE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 02:33:04 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 61BE3E01A
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 23:30:09 -0700 (PDT)
Received: from kwepemi100023.china.huawei.com (unknown [172.30.72.54])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4Kl4Hy5T8mz1J9m3;
        Fri, 22 Apr 2022 14:29:18 +0800 (CST)
Received: from kwepemm600017.china.huawei.com (7.193.23.234) by
 kwepemi100023.china.huawei.com (7.221.188.59) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 14:30:05 +0800
Received: from [10.174.179.234] (10.174.179.234) by
 kwepemm600017.china.huawei.com (7.193.23.234) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 22 Apr 2022 14:30:04 +0800
Message-ID: <10215555-5eb6-d53d-5949-d603ce346d6f@huawei.com>
Date:   Fri, 22 Apr 2022 14:30:03 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.0
Subject: Re: [PATCH -next v5 2/5] mm: page_table_check: move
 pxx_user_accessible_page into x86
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
References: <20220421082042.1167967-1-tongtiangen@huawei.com>
 <20220421082042.1167967-3-tongtiangen@huawei.com>
 <905f22d6-0671-21b2-a341-bdc5ba02e59c@arm.com>
From:   Tong Tiangen <tongtiangen@huawei.com>
In-Reply-To: <905f22d6-0671-21b2-a341-bdc5ba02e59c@arm.com>
Content-Type: text/plain; charset="UTF-8"; format=flowed
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.174.179.234]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 kwepemm600017.china.huawei.com (7.193.23.234)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_MED,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



在 2022/4/22 13:11, Anshuman Khandual 写道:
> Similar to previous commits on the same file, the following subject
> line format, would have been preferred.
> 
> mm/page_table_check: <description>
> 
> On 4/21/22 13:50, Tong Tiangen wrote:
>> From: Kefeng Wang <wangkefeng.wang@huawei.com>
>>
>> The pxx_user_accessible_page() check the PTE bit, it's
> 
> s/check/checks			 ^^^^
> 
>> architecture-specific code, move them into x86's pgtable.h
> The commit message should have been more clear, atleast complete in
> sentences. I dont want to be bike shedding here but this is definitely
> incomplete. These helpers are being moved out to make the page table
> check framework, platform independent. Hence the commit message should
> mention this.

The commit message is not very clear and it is too simple.

Thanks.

> 
>>
>> Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
>> Signed-off-by: Tong Tiangen <tongtiangen@huawei.com>
>> Acked-by: Pasha Tatashin <pasha.tatashin@soleen.com>
>> ---
>>   arch/x86/include/asm/pgtable.h | 19 +++++++++++++++++++
>>   mm/page_table_check.c          | 17 -----------------
>>   2 files changed, 19 insertions(+), 17 deletions(-)
>>
>> diff --git a/arch/x86/include/asm/pgtable.h b/arch/x86/include/asm/pgtable.h
>> index b7464f13e416..564abe42b0f7 100644
>> --- a/arch/x86/include/asm/pgtable.h
>> +++ b/arch/x86/include/asm/pgtable.h
>> @@ -1447,6 +1447,25 @@ static inline bool arch_has_hw_pte_young(void)
>>   	return true;
>>   }
>>   
>> +#ifdef CONFIG_PAGE_TABLE_CHECK
>> +static inline bool pte_user_accessible_page(pte_t pte)
>> +{
>> +	return (pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) & _PAGE_USER);
>> +}
>> +
>> +static inline bool pmd_user_accessible_page(pmd_t pmd)
>> +{
>> +	return pmd_leaf(pmd) && (pmd_val(pmd) & _PAGE_PRESENT) &&
>> +		(pmd_val(pmd) & _PAGE_USER);
>> +}
>> +
>> +static inline bool pud_user_accessible_page(pud_t pud)
>> +{
>> +	return pud_leaf(pud) && (pud_val(pud) & _PAGE_PRESENT) &&
>> +		(pud_val(pud) & _PAGE_USER);
> 
> A line break is not really required here (and above as well). As single
> complete line would still be within 100 characters.
> 
Right, now one line can have 100 characters.

Thanks.

>> +}
>> +#endif
>> +
>>   #endif	/* __ASSEMBLY__ */
>>   
>>   #endif /* _ASM_X86_PGTABLE_H */
>> diff --git a/mm/page_table_check.c b/mm/page_table_check.c
>> index eb0d0b71cdf6..3692bea2ea2c 100644
>> --- a/mm/page_table_check.c
>> +++ b/mm/page_table_check.c
>> @@ -52,23 +52,6 @@ static struct page_table_check *get_page_table_check(struct page_ext *page_ext)
>>   	return (void *)(page_ext) + page_table_check_ops.offset;
>>   }
>>   
>> -static inline bool pte_user_accessible_page(pte_t pte)
>> -{
>> -	return (pte_val(pte) & _PAGE_PRESENT) && (pte_val(pte) & _PAGE_USER);
>> -}
>> -
>> -static inline bool pmd_user_accessible_page(pmd_t pmd)
>> -{
>> -	return pmd_leaf(pmd) && (pmd_val(pmd) & _PAGE_PRESENT) &&
>> -		(pmd_val(pmd) & _PAGE_USER);
>> -}
>> -
>> -static inline bool pud_user_accessible_page(pud_t pud)
>> -{
>> -	return pud_leaf(pud) && (pud_val(pud) & _PAGE_PRESENT) &&
>> -		(pud_val(pud) & _PAGE_USER);
>> -}
>> -
>>   /*
>>    * An enty is removed from the page table, decrement the counters for that page
>>    * verify that it is of correct type and counters do not become negative.
> 
> With above mentioned code cleanup and commit message changes in place.
> 
> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> .
