Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 69D96562D61
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:04:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236114AbiGAIEX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:04:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33954 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235807AbiGAIEV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:04:21 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 392BC6F34C
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:04:20 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VI.SzeZ_1656662655;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VI.SzeZ_1656662655)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 16:04:16 +0800
Message-ID: <1234a28a-dca0-5836-9066-4ab2d4fbcc95@linux.alibaba.com>
Date:   Fri, 1 Jul 2022 16:04:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v3 2/3] mm: Add PUD level pagetable account
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <6a6a768634b9ce8537154264e35e6a66a79b6ca8.1656586863.git.baolin.wang@linux.alibaba.com>
 <Yr2wlqQkpsffTvd/@linux.ibm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Yr2wlqQkpsffTvd/@linux.ibm.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/30/2022 10:17 PM, Mike Rapoport wrote:
> On Thu, Jun 30, 2022 at 07:11:15PM +0800, Baolin Wang wrote:
>> Now the PUD level ptes are always protected by mm->page_table_lock,
>> which means no split pagetable lock needed. So the generic PUD level
>> pagetable pages allocation will not call pgtable_pte_page_ctor/dtor(),
>> that means we will miss to account PUD level pagetable pages.
>>
>> Adding pagetable account by calling pgtable_page_inc() or
>> pgtable_page_dec() when allocating or freeing PUD level pagetable
>> pages to help to get an accurate pagetable accounting.
>>
>> Moreover this patch will also mark the PUD level pagetable with PG_table
>> flag, which will help to do sanity validation in unpoison_memory() and
>> get more accurate pagetable accounting by /proc/kpageflags interface.
>>
>> Meanwhile converting the architectures with using generic PUD pagatable
>> allocation to add corresponding pgtable_page_inc() or pgtable_page_dec()
>> to account PUD level pagetable.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   arch/arm64/include/asm/tlb.h         |  5 ++++-
>>   arch/loongarch/include/asm/pgalloc.h | 11 ++++++++---
>>   arch/mips/include/asm/pgalloc.h      | 11 ++++++++---
>>   arch/s390/include/asm/tlb.h          |  1 +
>>   arch/x86/mm/pgtable.c                |  5 ++++-
>>   include/asm-generic/pgalloc.h        | 12 ++++++++++--
>>   6 files changed, 35 insertions(+), 10 deletions(-)
>>
>> diff --git a/arch/arm64/include/asm/tlb.h b/arch/arm64/include/asm/tlb.h
>> index c995d1f..1772df9 100644
>> --- a/arch/arm64/include/asm/tlb.h
>> +++ b/arch/arm64/include/asm/tlb.h
>> @@ -94,7 +94,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
>>   static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
>>   				  unsigned long addr)
>>   {
>> -	tlb_remove_table(tlb, virt_to_page(pudp));
>> +	struct page *page = virt_to_page(pudp);
>> +
>> +	pgtable_page_dec(page);
> 
> Using pgtable_pud_page_ctor() and pgtable_pud_page_dtor() would be
> consistent with what we currently have for PTEs and PMDs.
> 
> This applies to all the additions of pgtable_page_dec() and
> pgtable_page_inc().

OK. I can add pgtable_pud_page_ctor() and pgtable_pud_page_dtor() 
helpers to keep consistent, which are just wrappers of 
pgtable_page_inc() and pgtable_page_dec().

> 
>> +	tlb_remove_table(tlb, page);
>>   }
>>   #endif
>>   
>> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
>> index b0a57b2..19bfe14 100644
>> --- a/arch/loongarch/include/asm/pgalloc.h
>> +++ b/arch/loongarch/include/asm/pgalloc.h
>> @@ -89,10 +89,15 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>>   static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>>   {
>>   	pud_t *pud;
>> +	struct page *page;
>>   
>> -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
>> -	if (pud)
>> -		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
>> +	page = alloc_pages(GFP_KERNEL, PUD_ORDER);
>> +	if (!page)
>> +		return NULL;
>> +
>> +	pgtable_page_inc(page);
>> +	pud = (pud_t *)page_address(page);
>> +	pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
>>   	return pud;
>>   }
>>   
>> diff --git a/arch/mips/include/asm/pgalloc.h b/arch/mips/include/asm/pgalloc.h
>> index 867e9c3..990f614 100644
>> --- a/arch/mips/include/asm/pgalloc.h
>> +++ b/arch/mips/include/asm/pgalloc.h
>> @@ -89,11 +89,16 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>>   
>>   static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>>   {
>> +	struct page *page;
>>   	pud_t *pud;
>>   
>> -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
>> -	if (pud)
>> -		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
>> +	page = alloc_pages(GFP_KERNEL, PUD_ORDER);
>> +	if (!page)
>> +		return NULL;
>> +
>> +	pgtable_page_inc(page);
>> +	pud = (pud_t *)page_address(page);
>> +	pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
>>   	return pud;
>>   }
>>   
>> diff --git a/arch/s390/include/asm/tlb.h b/arch/s390/include/asm/tlb.h
>> index fe6407f..744e2d7 100644
>> --- a/arch/s390/include/asm/tlb.h
>> +++ b/arch/s390/include/asm/tlb.h
>> @@ -125,6 +125,7 @@ static inline void pud_free_tlb(struct mmu_gather *tlb, pud_t *pud,
>>   {
>>   	if (mm_pud_folded(tlb->mm))
>>   		return;
>> +	pgtable_page_dec(virt_to_page(pud));
>>   	tlb->mm->context.flush_mm = 1;
>>   	tlb->freed_tables = 1;
>>   	tlb->cleared_p4ds = 1;
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index a932d77..5e46e31 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -76,8 +76,11 @@ void ___pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmd)
>>   #if CONFIG_PGTABLE_LEVELS > 3
>>   void ___pud_free_tlb(struct mmu_gather *tlb, pud_t *pud)
>>   {
>> +	struct page *page = virt_to_page(pud);
>> +
>> +	pgtable_page_dec(page);
>>   	paravirt_release_pud(__pa(pud) >> PAGE_SHIFT);
>> -	paravirt_tlb_remove_table(tlb, virt_to_page(pud));
>> +	paravirt_tlb_remove_table(tlb, page);
>>   }
>>   
>>   #if CONFIG_PGTABLE_LEVELS > 4
>> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
>> index 977bea1..11350f7 100644
>> --- a/include/asm-generic/pgalloc.h
>> +++ b/include/asm-generic/pgalloc.h
>> @@ -149,11 +149,16 @@ static inline void pmd_free(struct mm_struct *mm, pmd_t *pmd)
>>   
>>   static inline pud_t *__pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>>   {
>> +	struct page *page;
>>   	gfp_t gfp = GFP_PGTABLE_USER;
>>   
>>   	if (mm == &init_mm)
>>   		gfp = GFP_PGTABLE_KERNEL;
>> -	return (pud_t *)get_zeroed_page(gfp);
>> +	page = alloc_pages(gfp, 0);
>> +	if (!page)
>> +		return NULL;
>> +	pgtable_page_inc(page);
>> +	return (pud_t *)page_address(page);
>>   }
>>   
>>   #ifndef __HAVE_ARCH_PUD_ALLOC_ONE
>> @@ -174,8 +179,11 @@ static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long addr)
>>   
>>   static inline void __pud_free(struct mm_struct *mm, pud_t *pud)
>>   {
>> +	struct page *page = virt_to_page(pud);
>> +
>>   	BUG_ON((unsigned long)pud & (PAGE_SIZE-1));
>> -	free_page((unsigned long)pud);
>> +	pgtable_page_dec(page);
>> +	__free_page(page);
>>   }
>>   
>>   #ifndef __HAVE_ARCH_PUD_FREE
>> -- 
>> 1.8.3.1
>>
> 
