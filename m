Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5CCDB55D4CC
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:14:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233541AbiF0I2K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 27 Jun 2022 04:28:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233173AbiF0I17 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 27 Jun 2022 04:27:59 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 6D6FA632E
        for <linux-kernel@vger.kernel.org>; Mon, 27 Jun 2022 01:27:50 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 319C71758;
        Mon, 27 Jun 2022 01:27:50 -0700 (PDT)
Received: from [10.162.42.6] (unknown [10.162.42.6])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id F401B3F5A1;
        Mon, 27 Jun 2022 01:27:46 -0700 (PDT)
Message-ID: <a4a88954-be9a-d953-81ff-a72c7898d5c9@arm.com>
Date:   Mon, 27 Jun 2022 13:57:44 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.9.1
Subject: Re: [PATCH] mm: hugetlb: kill set_huge_swap_pte_at()
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Qi Zheng <zhengqi.arch@bytedance.com>, mike.kravetz@oracle.com,
        akpm@linux-foundation.org, catalin.marinas@arm.com,
        will@kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org
References: <20220626145717.53572-1-zhengqi.arch@bytedance.com>
 <f0cfe169-44fa-5653-d454-149ef286d3bb@arm.com>
 <037fc8c3-9b71-cb83-8882-95d5459a494f@bytedance.com>
 <b46f5390-830d-08fd-0d6d-3fda7d31c36a@arm.com>
 <Yrlf1iej4/BL2znu@FVFYT0MHHV2J.usts.net>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Yrlf1iej4/BL2znu@FVFYT0MHHV2J.usts.net>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 6/27/22 13:14, Muchun Song wrote:
> On Mon, Jun 27, 2022 at 12:44:19PM +0530, Anshuman Khandual wrote:
>>
>>
>> On 6/27/22 12:25, Qi Zheng wrote:
>>>
>>>
>>> On 2022/6/27 14:18, Anshuman Khandual wrote:
>>>>
>>>>
>>>> On 6/26/22 20:27, Qi Zheng wrote:
>>>>> The commit e5251fd43007 ("mm/hugetlb: introduce set_huge_swap_pte_at()
>>>>> helper") add set_huge_swap_pte_at() to handle swap entries on
>>>>> architectures that support hugepages consisting of contiguous ptes.
>>>>> And currently the set_huge_swap_pte_at() is only overridden by arm64.
>>>>>
>>>>> The set_huge_swap_pte_at() provide a sz parameter to help determine
>>>>> the number of entries to be updated. But in fact, all hugetlb swap
>>>>> entries contain pfn information, so we can find the corresponding
>>>>> folio through the pfn recorded in the swap entry, then the folio_size()
>>>>> is the number of entries that need to be updated.
>>>>>
>>>>> And considering that users will easily cause bugs by ignoring the
>>>>> difference between set_huge_swap_pte_at() and set_huge_pte_at().
>>>>> Let's handle swap entries in set_huge_pte_at() and remove the
>>>>> set_huge_swap_pte_at(), then we can call set_huge_pte_at()
>>>>> anywhere, which simplifies our coding.
>>>>>
>>>>> Signed-off-by: Qi Zheng <zhengqi.arch@bytedance.com>
>>>>> ---
>>>>> ï¿½ arch/arm64/include/asm/hugetlb.h |ï¿½ 3 ---
>>>>> ï¿½ arch/arm64/mm/hugetlbpage.cï¿½ï¿½ï¿½ï¿½ï¿½ | 34 ++++++++++++++++----------------
>>>>> ï¿½ include/linux/hugetlb.hï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 13 ------------
>>>>> ï¿½ mm/hugetlb.cï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ |ï¿½ 8 +++-----
>>>>> ï¿½ mm/rmap.cï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ | 11 +++--------
>>>>> ï¿½ 5 files changed, 23 insertions(+), 46 deletions(-)
>>>>>
>>>>> diff --git a/arch/arm64/include/asm/hugetlb.h b/arch/arm64/include/asm/hugetlb.h
>>>>> index 1fd2846dbefe..d20f5da2d76f 100644
>>>>> --- a/arch/arm64/include/asm/hugetlb.h
>>>>> +++ b/arch/arm64/include/asm/hugetlb.h
>>>>> @@ -46,9 +46,6 @@ extern void huge_pte_clear(struct mm_struct *mm, unsigned long addr,
>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ pte_t *ptep, unsigned long sz);
>>>>> ï¿½ #define __HAVE_ARCH_HUGE_PTEP_GET
>>>>> ï¿½ extern pte_t huge_ptep_get(pte_t *ptep);
>>>>> -extern void set_huge_swap_pte_at(struct mm_struct *mm, unsigned long addr,
>>>>> -ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ï¿½ pte_t *ptep, pte_t pte, unsigned long sz);
>>>>> -#define set_huge_swap_pte_at set_huge_swap_pte_at
>>>>> ï¿½ ï¿½ void __init arm64_hugetlb_cma_reserve(void);
>>>>> ï¿½ diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
>>>>> index c9e076683e5d..58b89b9d13e0 100644
>>>>> --- a/arch/arm64/mm/hugetlbpage.c
>>>>> +++ b/arch/arm64/mm/hugetlbpage.c
>>>>> @@ -238,6 +238,13 @@ static void clear_flush(struct mm_struct *mm,
>>>>> ï¿½ï¿½ï¿½ï¿½ï¿½ flush_tlb_range(&vma, saddr, addr);
>>>>> ï¿½ }
>>>>> ï¿½ +static inline struct folio *hugetlb_swap_entry_to_folio(swp_entry_t entry)
>>>>> +{
>>>>> +ï¿½ï¿½ï¿½ VM_BUG_ON(!is_migration_entry(entry) && !is_hwpoison_entry(entry));
>>>>> +
>>>>> +ï¿½ï¿½ï¿½ return page_folio(pfn_to_page(swp_offset(entry)));
>>>>> +}
>>>>
>>>> Extracting this huge page size from swap entry is an additional operation which
>>>> will increase the over all cost for set_huge_swap_pte_at(). At present the size
>>>
>>> Hmm, I think this cost is very small. And replacing
>>> set_huge_swap_pte_at() by transparently handling swap entries helps
>>> reduce possible bugs, which is worthwhile.
>>
>> Possible bugs ? There are just six call sites for this function.
> 
> I think it is easy to make mistakes (see commit 5d4af6195c87).
> I usually think of why the swap entry is special for HugeTLB pages
> compared to normal pages (why we do not have set_swap_pte_at?).
> set_huge_swap_pte_at() make HugeTLB more special, killing it
> can make HugeTLB more consistent with normal page. From the point
> of view of code maintenance, I think it is better to kill it. What
> do you think?

Okay, alright. Lets drop set_huge_swap_pte_at() which helps make
HugeTLB less special.

> 
> Thanks.
> 
>> Although this proposed patch is functionally correct, I dont see
>> a valid enough reason to increase the overall cost in the path.
>>
> 
> 
