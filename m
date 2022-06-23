Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CEF315571AF
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:43:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231668AbiFWEl6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:41:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39554 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239635AbiFWDcg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:32:36 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 365D83584F
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:32:34 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R141e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046049;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VH9dVlt_1655955150;
Received: from 30.97.48.163(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VH9dVlt_1655955150)
          by smtp.aliyun-inc.com;
          Thu, 23 Jun 2022 11:32:31 +0800
Message-ID: <d5dea8e0-2121-0bde-4510-73ae3b4b8767@linux.alibaba.com>
Date:   Thu, 23 Jun 2022 11:32:37 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v2 2/3] mm: Add PUD level pagetable account
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
 <f7b2a6f6f5dfecbcac07fa3e187f10860c3a39ee.1655887440.git.baolin.wang@linux.alibaba.com>
 <YrMpZlQHMuCy06/m@linux.ibm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YrMpZlQHMuCy06/m@linux.ibm.com>
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



On 6/22/2022 10:38 PM, Mike Rapoport wrote:
> On Wed, Jun 22, 2022 at 04:58:53PM +0800, Baolin Wang wrote:
>> Now the PUD level ptes are always protected by mm->page_table_lock,
>> which means no split pagetable lock needed. So the generic PUD level
>> pagetable pages allocation will not call pgtable_pte_page_ctor/dtor(),
>> that means we will miss to account PUD level pagetable pages.
>>
>> Adding pagetable account by calling pgtable_set_and_inc() or
>> pgtable_clear_and_dec() when allocating or freeing PUD level pagetable
>> pages to help to get an accurate pagetable accounting.
>>
>> Moreover this patch will also mark the PUD level pagetable with PG_table
>> flag, which will help to do sanity validation in unpoison_memory() and
>> get more accurate pagetable accounting by /proc/kpageflags interface.
>>
>> Meanwhile converting the architectures with using generic PUD pagatable
>> allocation to add corresponding pgtable_set_and_inc() or pgtable_clear_and_dec()
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
>> index c995d1f..47e0623 100644
>> --- a/arch/arm64/include/asm/tlb.h
>> +++ b/arch/arm64/include/asm/tlb.h
>> @@ -94,7 +94,10 @@ static inline void __pmd_free_tlb(struct mmu_gather *tlb, pmd_t *pmdp,
>>   static inline void __pud_free_tlb(struct mmu_gather *tlb, pud_t *pudp,
>>   				  unsigned long addr)
>>   {
>> -	tlb_remove_table(tlb, virt_to_page(pudp));
>> +	struct page *page = virt_to_page(pudp);
>> +
>> +	pgtable_clear_and_dec(page);
>> +	tlb_remove_table(tlb, page);
>>   }
>>   #endif
>>   
>> diff --git a/arch/loongarch/include/asm/pgalloc.h b/arch/loongarch/include/asm/pgalloc.h
>> index b0a57b2..50a896f 100644
>> --- a/arch/loongarch/include/asm/pgalloc.h
>> +++ b/arch/loongarch/include/asm/pgalloc.h
>> @@ -89,10 +89,15 @@ static inline pmd_t *pmd_alloc_one(struct mm_struct *mm, unsigned long address)
>>   static inline pud_t *pud_alloc_one(struct mm_struct *mm, unsigned long address)
>>   {
>>   	pud_t *pud;
>> +	struct page *pg;
> 
> 	struct page *page;
> 
> looks better IMO.

Sure.

> 
>> +
>> +	pg = alloc_pages(GFP_KERNEL & ~__GFP_HIGHMEM, PUD_ORDER);
>> +	if (!pg)
>> +		return NULL;
>>   
>> -	pud = (pud_t *) __get_free_pages(GFP_KERNEL, PUD_ORDER);
>> -	if (pud)
>> -		pud_init((unsigned long)pud, (unsigned long)invalid_pmd_table);
>> +	pgtable_set_and_inc(pg);
>> +	pud = (pud_t *)page_address(pg);
> 
> I don't think __get_free_pages() should be replaced with alloc_pages()
> here, just call pgtable_set_and_inc() with virt_to_page(pud).
> 
> The same applies for the cases below.

Sure. Will do in next version. Thanks.
