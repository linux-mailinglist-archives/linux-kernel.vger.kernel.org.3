Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CC98950F0EA
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 08:26:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245012AbiDZG3G (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 02:29:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52036 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245163AbiDZG26 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 02:28:58 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD4AF101F9
        for <linux-kernel@vger.kernel.org>; Mon, 25 Apr 2022 23:25:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04394;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VBJqdym_1650954348;
Received: from 30.236.11.146(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VBJqdym_1650954348)
          by smtp.aliyun-inc.com(127.0.0.1);
          Tue, 26 Apr 2022 14:25:49 +0800
Message-ID: <82632a98-e7e8-cf04-ea5c-f8c804184af8@linux.alibaba.com>
Date:   Tue, 26 Apr 2022 14:26:24 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.7.0
Subject: Re: [PATCH 2/2] mm: rmap: Move the cache flushing to the correct
 place for hugetlb PMD sharing
To:     Mike Kravetz <mike.kravetz@oracle.com>, akpm@linux-foundation.org
Cc:     almasrymina@google.com, songmuchun@bytedance.com,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <cover.1650810915.git.baolin.wang@linux.alibaba.com>
 <f5e3b77c5a4c646e000ffadbf6c3db0531a01795.1650810915.git.baolin.wang@linux.alibaba.com>
 <064da3bb-5b4b-7332-a722-c5a541128705@oracle.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <064da3bb-5b4b-7332-a722-c5a541128705@oracle.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.8 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/26/2022 8:20 AM, Mike Kravetz wrote:
> On 4/24/22 07:50, Baolin Wang wrote:
>> The cache level flush will always be first when changing an existing
>> virtual–>physical mapping to a new value, since this allows us to
>> properly handle systems whose caches are strict and require a
>> virtual–>physical translation to exist for a virtual address. So we
>> should move the cache flushing before huge_pmd_unshare().
>>
>> As Muchun pointed out[1], now the architectures whose supporting hugetlb
>> PMD sharing have no cache flush issues in practice. But I think we
>> should still follow the cache/TLB flushing rules when changing a valid
>> virtual address mapping in case of potential issues in future.
>>
>> [1] https://lore.kernel.org/all/YmT%2F%2FhuUbFX+KHcy@FVFYT0MHHV2J.usts.net/
>> Signed-off-by: Baolin Wang <baolin.wang@linux.alibaba.com>
>> ---
>>   mm/rmap.c | 40 ++++++++++++++++++++++------------------
>>   1 file changed, 22 insertions(+), 18 deletions(-)
>>
>> diff --git a/mm/rmap.c b/mm/rmap.c
>> index 61e63db..81872bb 100644
>> --- a/mm/rmap.c
>> +++ b/mm/rmap.c
>> @@ -1535,15 +1535,16 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>   			 * do this outside rmap routines.
>>   			 */
>>   			VM_BUG_ON(!(flags & TTU_RMAP_LOCKED));
>> +			/*
>> +			 * huge_pmd_unshare unmapped an entire PMD page.
> 
> Perhaps update this comment to say that huge_pmd_unshare 'may' unmap
> an entire PMD page?

Sure, will do.

> 
>> +			 * There is no way of knowing exactly which PMDs may
>> +			 * be cached for this mm, so we must flush them all.
>> +			 * start/end were already adjusted above to cover this
>> +			 * range.
>> +			 */
>> +			flush_cache_range(vma, range.start, range.end);
>> +
>>   			if (huge_pmd_unshare(mm, vma, &address, pvmw.pte)) {
>> -				/*
>> -				 * huge_pmd_unshare unmapped an entire PMD
>> -				 * page.  There is no way of knowing exactly
>> -				 * which PMDs may be cached for this mm, so
>> -				 * we must flush them all.  start/end were
>> -				 * already adjusted above to cover this range.
>> -				 */
>> -				flush_cache_range(vma, range.start, range.end);
>>   				flush_tlb_range(vma, range.start, range.end);
>>   				mmu_notifier_invalidate_range(mm, range.start,
>>   							      range.end);
>> @@ -1560,13 +1561,14 @@ static bool try_to_unmap_one(struct folio *folio, struct vm_area_struct *vma,
>>   				page_vma_mapped_walk_done(&pvmw);
>>   				break;
>>   			}
>> +		} else {
>> +			flush_cache_page(vma, address, pte_pfn(*pvmw.pte));
> 
> I know this call to flush_cache_page() existed before your change.  But, when
> looking at this now I wonder how hugetlb pages are handled?  Are there any
> versions of flush_cache_page() that take page size into account?

Thanks for reminding. I checked the flush_cache_page() implementation on 
some architectures (like arm32), they did not consider the hugetlb 
pages, so I think we may miss flushing the whole cache for hguetlb pages 
on some architectures.

With this patch, we can mitigate this issue, since we change to use 
flush_cache_range() to cover the possible range to flush cache for 
hugetlb pages. Bur for anon hugetlb pages, we should also convert to use
flush_cache_range() instead. I think we can do this conversion in a 
separate patch set with checking all the places, where using 
flush_cache_page() to flush cache for hugetlb pages. How do you think?
