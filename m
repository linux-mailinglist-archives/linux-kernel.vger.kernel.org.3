Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 926055AD506
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 16:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238498AbiIEOgt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 10:36:49 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34100 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbiIEOgQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 10:36:16 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3582F5C977
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 07:35:19 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R981e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046059;MF=baolin.wang@linux.alibaba.com;NM=1;PH=DS;RN=10;SR=0;TI=SMTPD_---0VOUw8Ef_1662388503;
Received: from 30.32.67.179(mailfrom:baolin.wang@linux.alibaba.com fp:SMTPD_---0VOUw8Ef_1662388503)
          by smtp.aliyun-inc.com;
          Mon, 05 Sep 2022 22:35:09 +0800
Message-ID: <9f098ff0-26d7-477c-13fa-cb878981e1ac@linux.alibaba.com>
Date:   Mon, 5 Sep 2022 22:35:13 +0800
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; Win64; x64; rv:91.0) Gecko/20100101
 Thunderbird/91.13.0
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
To:     David Hildenbrand <david@redhat.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
 <0c9d9774-77dd-fd93-b5b6-fc63f3d01b7f@linux.alibaba.com>
 <383fec21-9801-9b60-7570-856da2133ea9@redhat.com>
 <a7dd4376-bce2-ee79-623f-fa11d301b80d@redhat.com>
From:   Baolin Wang <baolin.wang@linux.alibaba.com>
In-Reply-To: <a7dd4376-bce2-ee79-623f-fa11d301b80d@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-11.6 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 9/5/2022 7:11 PM, David Hildenbrand wrote:
> On 05.09.22 12:24, David Hildenbrand wrote:
>> On 05.09.22 12:16, Baolin Wang wrote:
>>>
>>>
>>> On 9/5/2022 3:59 PM, David Hildenbrand wrote:
>>>> On 05.09.22 00:29, John Hubbard wrote:
>>>>> On 9/1/22 15:27, Yang Shi wrote:
>>>>>> Since general RCU GUP fast was introduced in commit 2667f50e8b81 
>>>>>> ("mm:
>>>>>> introduce a general RCU get_user_pages_fast()"), a TLB flush is no
>>>>>> longer
>>>>>> sufficient to handle concurrent GUP-fast in all cases, it only 
>>>>>> handles
>>>>>> traditional IPI-based GUP-fast correctly.  On architectures that send
>>>>>> an IPI broadcast on TLB flush, it works as expected.  But on the
>>>>>> architectures that do not use IPI to broadcast TLB flush, it may have
>>>>>> the below race:
>>>>>>
>>>>>>       CPU A                                          CPU B
>>>>>> THP collapse                                     fast GUP
>>>>>>                                                  gup_pmd_range() <--
>>>>>> see valid pmd
>>>>>>                                                      gup_pte_range()
>>>>>> <-- work on pte
>>>>>> pmdp_collapse_flush() <-- clear pmd and flush
>>>>>> __collapse_huge_page_isolate()
>>>>>>        check page pinned <-- before GUP bump refcount
>>>>>>                                                          pin the page
>>>>>>                                                          check PTE 
>>>>>> <--
>>>>>> no change
>>>>>> __collapse_huge_page_copy()
>>>>>>        copy data to huge page
>>>>>>        ptep_clear()
>>>>>> install huge pmd for the huge page
>>>>>>                                                          return the
>>>>>> stale page
>>>>>> discard the stale page
>>>>>
>>>>> Hi Yang,
>>>>>
>>>>> Thanks for taking the trouble to write down these notes. I always
>>>>> forget which race we are dealing with, and this is a great help. :)
>>>>>
>>>>> More...
>>>>>
>>>>>>
>>>>>> The race could be fixed by checking whether PMD is changed or not 
>>>>>> after
>>>>>> taking the page pin in fast GUP, just like what it does for PTE.  
>>>>>> If the
>>>>>> PMD is changed it means there may be parallel THP collapse, so GUP
>>>>>> should back off.
>>>>>>
>>>>>> Also update the stale comment about serializing against fast GUP in
>>>>>> khugepaged.
>>>>>>
>>>>>> Fixes: 2667f50e8b81 ("mm: introduce a general RCU
>>>>>> get_user_pages_fast()")
>>>>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>>>>>> ---
>>>>>>     mm/gup.c        | 30 ++++++++++++++++++++++++------
>>>>>>     mm/khugepaged.c | 10 ++++++----
>>>>>>     2 files changed, 30 insertions(+), 10 deletions(-)
>>>>>>
>>>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>>>> index f3fc1f08d90c..4365b2811269 100644
>>>>>> --- a/mm/gup.c
>>>>>> +++ b/mm/gup.c
>>>>>> @@ -2380,8 +2380,9 @@ static void __maybe_unused undo_dev_pagemap(int
>>>>>> *nr, int nr_start,
>>>>>>     }
>>>>>>     #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>>>>>> -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned
>>>>>> long end,
>>>>>> -             unsigned int flags, struct page **pages, int *nr)
>>>>>> +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>>>>>> +             unsigned long end, unsigned int flags,
>>>>>> +             struct page **pages, int *nr)
>>>>>>     {
>>>>>>         struct dev_pagemap *pgmap = NULL;
>>>>>>         int nr_start = *nr, ret = 0;
>>>>>> @@ -2423,7 +2424,23 @@ static int gup_pte_range(pmd_t pmd, unsigned
>>>>>> long addr, unsigned long end,
>>>>>>                 goto pte_unmap;
>>>>>>             }
>>>>>> -        if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>>>>>> +        /*
>>>>>> +         * THP collapse conceptually does:
>>>>>> +         *   1. Clear and flush PMD
>>>>>> +         *   2. Check the base page refcount
>>>>>> +         *   3. Copy data to huge page
>>>>>> +         *   4. Clear PTE
>>>>>> +         *   5. Discard the base page
>>>>>> +         *
>>>>>> +         * So fast GUP may race with THP collapse then pin and
>>>>>> +         * return an old page since TLB flush is no longer 
>>>>>> sufficient
>>>>>> +         * to serialize against fast GUP.
>>>>>> +         *
>>>>>> +         * Check PMD, if it is changed just back off since it
>>>>>> +         * means there may be parallel THP collapse.
>>>>>> +         */
>>>>>
>>>>> As I mentioned in the other thread, it would be a nice touch to move
>>>>> such discussion into the comment header.
>>>>>
>>>>>> +        if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
>>>>>> +            unlikely(pte_val(pte) != pte_val(*ptep))) {
>>>>>
>>>>>
>>>>> That should be READ_ONCE() for the *pmdp and *ptep reads. Because this
>>>>> whole lockless house of cards may fall apart if we try reading the
>>>>> page table values without READ_ONCE().
>>>>
>>>> I came to the conclusion that the implicit memory barrier when grabbing
>>>> a reference on the page is sufficient such that we don't need READ_ONCE
>>>> here.
>>>
>>> IMHO the compiler may optimize the code 'pte_val(*ptep)' to be always
>>> get from a register, then we can get an old value if other thread did
>>> set_pte(). I am not sure how the implicit memory barrier can pervent the
>>> compiler optimization? Please correct me if I missed something.
>>
>> IIUC, an memory barrier always implies a compiler barrier.
>>
> 
> To clarify what I mean, Documentation/atomic_t.txt documents
> 
> NOTE: when the atomic RmW ops are fully ordered, they should also imply 
> a compiler barrier.

Right, I agree. That means the complier can not optimize the order of 
the 'pte_val(*ptep)', however what I am confusing is that the complier 
can still save the value of *ptep into a register or stack instead of 
reloading from memory?

A similar issue in commit d6c1f098f2a7 ("mm/swap_state: fix a data race 
in swapin_nr_pages").

--- a/mm/swap_state.c
+++ b/mm/swap_state.c
@@ -509,10 +509,11 @@ static unsigned long swapin_nr_pages(unsigned long 
offset)
                 return 1;

         hits = atomic_xchg(&swapin_readahead_hits, 0);
-       pages = __swapin_nr_pages(prev_offset, offset, hits, max_pages,
+       pages = __swapin_nr_pages(READ_ONCE(prev_offset), offset, hits,
+                                 max_pages,
                                   atomic_read(&last_readahead_pages));
         if (!hits)
-               prev_offset = offset;
+               WRITE_ONCE(prev_offset, offset);
         atomic_set(&last_readahead_pages, pages);

         return pages;
