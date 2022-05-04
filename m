Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1A76B51959B
	for <lists+linux-kernel@lfdr.de>; Wed,  4 May 2022 04:49:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343551AbiEDCwV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 22:52:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56342 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231154AbiEDCwT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 22:52:19 -0400
Received: from out30-44.freemail.mail.aliyun.com (out30-44.freemail.mail.aliyun.com [115.124.30.44])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6D78820BFB
        for <linux-kernel@vger.kernel.org>; Tue,  3 May 2022 19:48:43 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R511e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VCA2Nsv_1651632519;
Received: from 30.32.81.226(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VCA2Nsv_1651632519)
          by smtp.aliyun-inc.com(127.0.0.1);
          Wed, 04 May 2022 10:48:40 +0800
Message-ID: <a88cb6bd-5440-9283-dd52-43b42f031d1c@linux.alibaba.com>
Date:   Wed, 4 May 2022 10:49:23 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.8.1
Subject: Re: [PATCH v2 3/3] mm: rmap: Use flush_cache_range() to flush cache
 for hugetlb pages
To:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org
Cc:     almasrymina@google.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1651056365.git.baolin.wang@linux.alibaba.com>
 <dc903b378d1e2d26bbbe85409ab9d009631f175c.1651056365.git.baolin.wang@linux.alibaba.com>
 <0b986dc4-5843-3e2d-c2df-5a2e9f13e6ab@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <0b986dc4-5843-3e2d-c2df-5a2e9f13e6ab@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-12.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/4/2022 4:17 AM, Mike Kravetz wrote:
> On 4/27/22 03:52, Baolin Wang wrote:
>> Now we will use flush_cache_page() to flush cache for anonymous hugetlb
>> pages when unmapping or migrating a hugetlb page mapping, but the
>> flush_cache_page() only handles a PAGE_SIZE range on some architectures
>> (like arm32, arc and so on), which will cause potential cache issues.
>> Thus change to use flush_cache_range() to cover the whole size of a
>> hugetlb page.
>>
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/rmap.c | 90 ++++++++++++++++++++++++++++++++++-----------------------------
>>   1 file changed, 48 insertions(+), 42 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 4f0d115..6fdd198 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1528,13 +1528,7 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>   		anon_exclusive = folio_test_anon(folio) &&
>>   				 PageAnonExclusive(subpage);
>>   
>> -		if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
>> -			/*
>> -			 * To call huge_pmd_unshare, i_mmap_rwsem must be
>> -			 * held in write mode.  Caller needs to explicitly
>> -			 * do this outside rmap routines.
>> -			 */
>> -			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>> +		if (folio_test_hugetlb(folio)) {
>>   			/*
>>   			 * huge_pmd_unshare may unmap an entire PMD page.
>>   			 * There is no way of knowing exactly which PMDs may
>> @@ -1544,22 +1538,31 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>   			 */
>>   			flush_cache_range(vma, range.start, range.end);
>>   
>> -			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
>> -				flush_tlb_range(vma, range.start, range.end);
>> -				mmu_notifier_invalidate_range(mm, range.start,
>> -							      range.end);
>> -
>> +			if (!folio_test_anon(folio)) {
>>   				/*
>> -				 * The ref count of the PMD page was dropped
>> -				 * which is part of the way map counting
>> -				 * is done for shared PMDs.  Return 'true'
>> -				 * here.  When there is no other sharing,
>> -				 * huge_pmd_unshare returns false and we will
>> -				 * unmap the actual page and drop map count
>> -				 * to zero.
>> +				 * To call huge_pmd_unshare, i_mmap_rwsem must be
>> +				 * held in write mode.  Caller needs to explicitly
>> +				 * do this outside rmap routines.
>>   				 */
>> -				page_vma_mapped_walk_done(&pvmw);
>> -				break;
>> +				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>> +
>> +				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
>> +					flush_tlb_range(vma, range.start, range.end);
>> +					mmu_notifier_invalidate_range(mm, range.start,
>> +								      range.end);
>> +
>> +					/*
>> +					 * The ref count of the PMD page was dropped
>> +					 * which is part of the way map counting
>> +					 * is done for shared PMDs.  Return 'true'
>> +					 * here.  When there is no other sharing,
>> +					 * huge_pmd_unshare returns false and we will
>> +					 * unmap the actual page and drop map count
>> +					 * to zero.
>> +					 */
>> +					page_vma_mapped_walk_done(&pvmw);
>> +					break;
>> +				}
>>   			}
>>   		} else {
>>   			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
>> @@ -1885,13 +1888,7 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>   		anon_exclusive = folio_test_anon(folio) &&
>>   				 PageAnonExclusive(subpage);
>>   
>> -		if (folio_test_hugetlb(folio) && !folio_test_anon(folio)) {
>> -			/*
>> -			 * To call huge_pmd_unshare, i_mmap_rwsem must be
>> -			 * held in write mode.  Caller needs to explicitly
>> -			 * do this outside rmap routines.
>> -			 */
>> -			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>> +		if (folio_test_hugetlb(folio)) {
>>   			/*
>>   			 * huge_pmd_unshare may unmap an entire PMD page.
>>   			 * There is no way of knowing exactly which PMDs may
>> @@ -1901,22 +1898,31 @@ static bool try_to_migrate_one(struct folio *folio, struct vm_area_struct *vma,
>>   			 */
>>   			flush_cache_range(vma, range.start, range.end);
>>   
>> -			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
>> -				flush_tlb_range(vma, range.start, range.end);
>> -				mmu_notifier_invalidate_range(mm, range.start,
>> -							      range.end);
>> -
>> +			if (!folio_test_anon(folio)) {
>>   				/*
>> -				 * The ref count of the PMD page was dropped
>> -				 * which is part of the way map counting
>> -				 * is done for shared PMDs.  Return 'true'
>> -				 * here.  When there is no other sharing,
>> -				 * huge_pmd_unshare returns false and we will
>> -				 * unmap the actual page and drop map count
>> -				 * to zero.
>> +				 * To call huge_pmd_unshare, i_mmap_rwsem must be
>> +				 * held in write mode.  Caller needs to explicitly
>> +				 * do this outside rmap routines.
>>   				 */
>> -				page_vma_mapped_walk_done(&pvmw);
>> -				break;
>> +				VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>> +
>> +				if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
>> +					flush_tlb_range(vma, range.start, range.end);
>> +					mmu_notifier_invalidate_range(mm, range.start,
>> +								      range.end);
>> +
>> +					/*
>> +					 * The ref count of the PMD page was dropped
>> +					 * which is part of the way map counting
>> +					 * is done for shared PMDs.  Return 'true'
>> +					 * here.  When there is no other sharing,
>> +					 * huge_pmd_unshare returns false and we will
>> +					 * unmap the actual page and drop map count
>> +					 * to zero.
>> +					 */
>> +					page_vma_mapped_walk_done(&pvmw);
>> +					break;
>> +				}
>>   			}
>>   		} else {
>>   			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
> 
> Thanks,
> The code looks fine.  It is unfortunate that we need so many levels of
> indenting and exceed 80 columns.  But, that is OK.

I'll do a cleanup to make it more readable with factoring the hugetlb 
case into a new function after the fix series[1].

[1] 
https://lore.kernel.org/linux-arm-kernel/20220503120343.6264e126@thinkpad/T/

> 
> Reviewed-by: Mike Kravetz <mike.kravetz@oracle.com>
> 
> I see you have a followup series to address the call to ptep_clear_flush()
> for hugetlb pages not unmapped via huge_pmd_share and will take a look at
> that soon.

Thanks.
