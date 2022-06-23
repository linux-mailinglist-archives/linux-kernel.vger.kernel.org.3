Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B4557557235
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 06:58:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233455AbiFWEuH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 00:50:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240043AbiFWDeU (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 23:34:20 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 393543616B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 20:34:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R111e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VH9ZUOQ_1655955255;
Received: from 30.97.48.163(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VH9ZUOQ_1655955255)
          by smtp.aliyun-inc.com;
          Thu, 23 Jun 2022 11:34:15 +0800
Message-ID: <9e2719c0-5704-57ea-3e1c-ef9413acfe1a@linux.alibaba.com>
Date:   Thu, 23 Jun 2022 11:34:21 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v2 3/3] mm: Add kernel PTE level pagetable pages
 account
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1655887440.git.baolin.wang@linux.alibaba.com>
 <7882bbf467440f9a3ebe41d96ba5b6f384081bb7.1655887440.git.baolin.wang@linux.alibaba.com>
 <YrMqzWvc9x5HWm5v@linux.ibm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <YrMqzWvc9x5HWm5v@linux.ibm.com>
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



On 6/22/2022 10:44 PM, Mike Rapoport wrote:
> On Wed, Jun 22, 2022 at 04:58:54PM +0800, Baolin Wang wrote:
>> Now the kernel PTE level ptes are always protected by mm->page_table_lock
>> instead of split pagetable lock, so the kernel PTE level pagetable pages
>> are not accounted. Especially the vmalloc()/vmap() can consume lots of
>> kernel pagetable, so to get an accurate pagetable accounting, calling new
>> helpers pgtable_set_and_inc()/pgtable_clear_and_dec() when allocating or
>> freeing a kernel PTE level pagetable page.
> 
> This patch only adds accounting to the page tables allocated after boot,
> please mention this in the changelog.

OK. Will add in next version.

>   
>> Meanwhile converting architectures to use corresponding generic PTE pagetable
>> allocation and freeing functions.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> Reported-by: kernel test robot <oliver.sang@intel.com>
>> ---
>>   arch/csky/include/asm/pgalloc.h |  2 +-
>>   arch/microblaze/mm/pgtable.c    |  2 +-
>>   arch/openrisc/mm/ioremap.c      |  2 +-
>>   arch/x86/mm/pgtable.c           |  5 ++++-
>>   include/asm-generic/pgalloc.h   | 14 ++++++++++++--
>>   5 files changed, 19 insertions(+), 6 deletions(-)
>>
>> diff --git a/arch/csky/include/asm/pgalloc.h b/arch/csky/include/asm/pgalloc.h
>> index bbbd069..2443226 100644
>> --- a/arch/csky/include/asm/pgalloc.h
>> +++ b/arch/csky/include/asm/pgalloc.h
>> @@ -29,7 +29,7 @@ static inline pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>>   	pte_t *pte;
>>   	unsigned long i;
>>   
>> -	pte = (pte_t *) __get_free_page(GFP_KERNEL);
>> +	pte = __pte_alloc_one_kernel(mm);
>>   	if (!pte)
>>   		return NULL;
>>   
>> diff --git a/arch/microblaze/mm/pgtable.c b/arch/microblaze/mm/pgtable.c
>> index 9f73265..e96dd1b 100644
>> --- a/arch/microblaze/mm/pgtable.c
>> +++ b/arch/microblaze/mm/pgtable.c
>> @@ -245,7 +245,7 @@ unsigned long iopa(unsigned long addr)
>>   __ref pte_t *pte_alloc_one_kernel(struct mm_struct *mm)
>>   {
>>   	if (mem_init_done)
>> -		return (pte_t *)__get_free_page(GFP_KERNEL | __GFP_ZERO);
>> +		return __pte_alloc_one_kernel(mm);
>>   	else
>>   		return memblock_alloc_try_nid(PAGE_SIZE, PAGE_SIZE,
>>   					      MEMBLOCK_LOW_LIMIT,
>> diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
>> index daae13a..3453acc 100644
>> --- a/arch/openrisc/mm/ioremap.c
>> +++ b/arch/openrisc/mm/ioremap.c
>> @@ -118,7 +118,7 @@ pte_t __ref *pte_alloc_one_kernel(struct mm_struct *mm)
>>   	pte_t *pte;
>>   
>>   	if (likely(mem_init_done)) {
>> -		pte = (pte_t *)get_zeroed_page(GFP_KERNEL);
>> +		pte = __pte_alloc_one_kernel(mm);
>>   	} else {
>>   		pte = memblock_alloc(PAGE_SIZE, PAGE_SIZE);
>>   		if (!pte)
>> diff --git a/arch/x86/mm/pgtable.c b/arch/x86/mm/pgtable.c
>> index a8ab3f9..fc2b9ef 100644
>> --- a/arch/x86/mm/pgtable.c
>> +++ b/arch/x86/mm/pgtable.c
>> @@ -851,6 +851,7 @@ int pud_free_pmd_page(pud_t *pud, unsigned long addr)
>>   int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>>   {
>>   	pte_t *pte;
>> +	struct page *page;
>>   
>>   	pte = (pte_t *)pmd_page_vaddr(*pmd);
>>   	pmd_clear(pmd);
>> @@ -858,7 +859,9 @@ int pmd_free_pte_page(pmd_t *pmd, unsigned long addr)
>>   	/* INVLPG to clear all paging-structure caches */
>>   	flush_tlb_kernel_range(addr, addr + PAGE_SIZE-1);
>>   
>> -	free_page((unsigned long)pte);
>> +	page = virt_to_page(pte);
>> +	pgtable_clear_and_dec(page);
>> +	__free_page(page);
>>   
>>   	return 1;
>>   }
>> diff --git a/include/asm-generic/pgalloc.h b/include/asm-generic/pgalloc.h
>> index 328a714..2e20e9e 100644
>> --- a/include/asm-generic/pgalloc.h
>> +++ b/include/asm-generic/pgalloc.h
>> @@ -18,7 +18,14 @@
>>    */
>>   static inline pte_t *__pte_alloc_one_kernel(struct mm_struct *mm)
>>   {
>> -	return (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
>> +	struct page *page;
>> +	gfp_t gfp = GFP_PGTABLE_KERNEL;
>> +
>> +	page = alloc_pages(gfp & ~__GFP_HIGHMEM, 0);
>> +	if (!page)
>> +		return NULL;
>> +	pgtable_set_and_inc(page);
>> +	return (pte_t *)page_address(page);
> 
> {
> 	pte_t *pte = (pte_t *)__get_free_page(GFP_PGTABLE_KERNEL);
> 
> 	if (pte)
> 		pgtable_set_and_inc(virt_to_page(pte));
> 
> 	return pte;
> }
> 
> looks simpler, doesn't it?

Yes, will do in next version. Thanks for reviewing.
