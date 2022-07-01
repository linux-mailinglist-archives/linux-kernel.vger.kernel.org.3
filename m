Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F0AF0562D53
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:02:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235601AbiGAIBI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:01:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59104 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235545AbiGAIA7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:00:59 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2E82E6F35F
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 01:00:57 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046050;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=5;SR=0;TI=SMTPD_---0VI.Tio9_1656662454;
Received: from 30.97.48.59(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VI.Tio9_1656662454)
          by smtp.aliyun-inc.com;
          Fri, 01 Jul 2022 16:00:54 +0800
Message-ID: <13b2cc16-fb1a-eeb8-7a15-d20f4ba42a48@linux.alibaba.com>
Date:   Fri, 1 Jul 2022 16:00:59 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.10.0
Subject: Re: [RFC PATCH v3 1/3] mm: Factor out the pagetable pages account
 into new helper function
To:     Mike Rapoport <rppt@linux.ibm.com>
Cc:     akpm@linux-foundation.org, willy@infradead.org, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
References: <cover.1656586863.git.baolin.wang@linux.alibaba.com>
 <9c527d4d2eb1f457306e575ce16c6acdd8141e02.1656586863.git.baolin.wang@linux.alibaba.com>
 <Yr2vFQVPUWX3t9RB@linux.ibm.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <Yr2vFQVPUWX3t9RB@linux.ibm.com>
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



On 6/30/2022 10:11 PM, Mike Rapoport wrote:
> On Thu, Jun 30, 2022 at 07:11:14PM +0800, Baolin Wang wrote:
>> Factor out the pagetable pages account into new helper functions to avoid
>> duplicated code. Meanwhile these helper functions also will be used to
>> account pagetable pages which do not need split pagetale lock.
>>
>> Meanwhile convert to use mod_lruvec_page_state() in case of non-order-0
>> page table allocation.
> 
> These are *very* rare. I think only parisc may have non-order-0 pmd and pud
> tables.

s390 also has non-order-0 page table allocation, but they both do not 
use the generic page table allocation now.

> With that, I'd suggest making use of compound_nr() build time opt-in.

After more thinking, I'd prefer to change back to use 
inc_lruvec_page_state()/dec_lruvec_page_state(), since now no 
architecures will need non-order-0 page table allocation.

After this patchset, I plan to convert parisc and s390 to use generic 
pagetable allocation, then I will add non-order-0 page table allocation 
support. Like Matthew suggested, maybe I need change the API to pass the 
number of pages.

>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   include/linux/mm.h | 24 ++++++++++++++++--------
>>   1 file changed, 16 insertions(+), 8 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index a2270e3..3be6d2c 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -2353,20 +2353,30 @@ static inline void pgtable_init(void)
>>   	pgtable_cache_init();
>>   }
>>   
>> +static inline void pgtable_page_inc(struct page *page)
>> +{
>> +	__SetPageTable(page);
>> +	mod_lruvec_page_state(page, NR_PAGETABLE, compound_nr(page));
>> +}
>> +
>> +static inline void pgtable_page_dec(struct page *page)
>> +{
>> +	__ClearPageTable(page);
>> +	mod_lruvec_page_state(page, NR_PAGETABLE, -compound_nr(page));
>> +}
>> +
>>   static inline bool pgtable_pte_page_ctor(struct page *page)
>>   {
>>   	if (!ptlock_init(page))
>>   		return false;
>> -	__SetPageTable(page);
>> -	inc_lruvec_page_state(page, NR_PAGETABLE);
>> +	pgtable_page_inc(page);
>>   	return true;
>>   }
>>   
>>   static inline void pgtable_pte_page_dtor(struct page *page)
>>   {
>>   	ptlock_free(page);
>> -	__ClearPageTable(page);
>> -	dec_lruvec_page_state(page, NR_PAGETABLE);
>> +	pgtable_page_dec(page);
>>   }
>>   
>>   #define pte_offset_map_lock(mm, pmd, address, ptlp)	\
>> @@ -2452,16 +2462,14 @@ static inline bool pgtable_pmd_page_ctor(struct page *page)
>>   {
>>   	if (!pmd_ptlock_init(page))
>>   		return false;
>> -	__SetPageTable(page);
>> -	inc_lruvec_page_state(page, NR_PAGETABLE);
>> +	pgtable_page_inc(page);
>>   	return true;
>>   }
>>   
>>   static inline void pgtable_pmd_page_dtor(struct page *page)
>>   {
>>   	pmd_ptlock_free(page);
>> -	__ClearPageTable(page);
>> -	dec_lruvec_page_state(page, NR_PAGETABLE);
>> +	pgtable_page_dec(page);
>>   }
>>   
>>   /*
>> -- 
>> 1.8.3.1
>>
> 
