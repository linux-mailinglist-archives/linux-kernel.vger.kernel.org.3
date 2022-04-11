Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 297C24FB730
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 11:17:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244457AbiDKJTO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 05:19:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39856 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236206AbiDKJTL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 05:19:11 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0C74E2C67F
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 02:16:58 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C22B2ED1;
        Mon, 11 Apr 2022 02:16:57 -0700 (PDT)
Received: from [10.163.38.140] (unknown [10.163.38.140])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id A9ABB3F73B;
        Mon, 11 Apr 2022 02:16:51 -0700 (PDT)
Message-ID: <46a99793-2e24-f3c5-c63f-ab2ad88966ea@arm.com>
Date:   Mon, 11 Apr 2022 14:47:26 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable
 HUGETLB_PAGE_FREE_VMEMMAP for arm64
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Oscar Salvador <osalvador@suse.de>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        David Rientjes <rientjes@google.com>,
        Mark Rutland <mark.rutland@arm.com>,
        Catalin Marinas <catalin.marinas@arm.com>, james.morse@arm.com,
        Barry Song <21cnbao@gmail.com>,
        LAK <linux-arm-kernel@lists.infradead.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        Xiongchun duan <duanxiongchun@bytedance.com>,
        Fam Zheng <fam.zheng@bytedance.com>,
        Muchun Song <smuchun@gmail.com>
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <20220331065640.5777-2-songmuchun@bytedance.com>
 <d6e2581e-a8ac-4848-2c64-4a221bd03bca@arm.com>
 <CAMZfGtWyXmPwZWsH_pP_M7p30uBww8BdP0DRXQRjBkT_VP=uUA@mail.gmail.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <CAMZfGtWyXmPwZWsH_pP_M7p30uBww8BdP0DRXQRjBkT_VP=uUA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 4/5/22 14:08, Muchun Song wrote:
> On Tue, Apr 5, 2022 at 12:44 PM Anshuman Khandual
> <anshuman.khandual@arm.com> wrote:
>>
>>
>>
>> On 3/31/22 12:26, Muchun Song wrote:
>>> 1st concern:
>>> '''
>>> But what happens when a hot remove section's vmemmap area (which is
>>> being teared down) is nearby another vmemmap area which is either created
>>> or being destroyed for HugeTLB alloc/free purpose. As you mentioned
>>> HugeTLB pages inside the hot remove section might be safe. But what about
>>> other HugeTLB areas whose vmemmap area shares page table entries with
>>> vmemmap entries for a section being hot removed ? Massive HugeTLB alloc
>>> /use/free test cycle using memory just adjacent to a memory hotplug area,
>>> which is always added and removed periodically, should be able to expose
>>> this problem.
>>> '''
>>>
>>> Answer: At the time memory is removed, all HugeTLB pages either have been
>>> migrated away or dissolved.  So there is no race between memory hot remove
>>> and free_huge_page_vmemmap().  Therefore, HugeTLB pages inside the hot
>>> remove section is safe.  Let's talk your question "what about other
>>
>> HugeTLB pages inside the memory range is safe but concern is about the
>> vmemmap mapping for the HugeTLB which might share intermediate entries
>> with vmemmap mapping for the memory range/section being removed.
> 
> The shared page table level only could be PMD, PUD and PGD, the PTE
> page table cannot be shared with other sections, and we only exchange
> PTEs for vmemmap mapping.

Right, the shared entries (if any) are not at the leaf level.

> 
>>
>>> HugeTLB areas whose vmemmap area shares page table entries with vmemmap
>>> entries for a section being hot removed ?", the question is not
>>
>> Right.
>>
>>> established.  The minimal granularity size of hotplug memory 128MB (on
>>> arm64, 4k base page), any HugeTLB smaller than 128MB is within a section,
>>> then, there is no share PTE page tables between HugeTLB in this section
>>
>> 128MB is the hot removable granularity but, its corresponding vmemmap
>> range is smaller i.e (128MB/4K) * sizeof(struct page). Memory section
>> getting hot removed (its vmemmap mapping being teared down) along with
>> HugeTLB (on another section) vmemmap remap operation, could not collide
>> while inside vmemmap mapping areas on init_mm ?
> 
> The boundary address of a section is aligned with 128MB and its
> corresponding vmemmap boundary address is aligned with 2MB
> which is mapped with a separated PTE page table (or a PMD entry).

Even if these PMD entries split during HugeTLB remapping, they will not
conflict with another memory section being removed simultaneously. Also
any shared page table pages will not be freed, during memory hot remove
operation as vmemmap remap does not delete any entries.

But just wondering if during PMD slit and PTE page table page addition,
these PMD entries could not be empty, even temporarily ?

> Different sections do not share the same PTE, there are no conflicts
> between a hot removed section and a remapping vmemmap section
> since we are operating on different PTE. Right?
> 
>>
>>> and ones in other sections and a HugeTLB page could not cross two
>>> sections.  In this case, the section cannot be freed.  Any HugeTLB bigger
>>
>> Right, they dont cross into two different sections.
>>
>>> than 128MB (section size) whose vmemmap pages is an integer multiple of
>>> 2MB (PMD-mapped).  As long as:
>>>
>>>   1) HugeTLBs are naturally aligned, power-of-two sizes
>>>   2) The HugeTLB size >= the section size
>>>   3) The HugeTLB size >= the vmemmap leaf mapping size
>>>
>>> Then a HugeTLB will not share any leaf page table entries with *anything
>>> else*, but will share intermediate entries.  In this case, at the time memory
>>> is removed, all HugeTLB pages either have been migrated away or dissolved.
>>> So there is also no race between memory hot remove and
>>> free_huge_page_vmemmap().
>>
>> If they just share intermediate entries, free_empty_tables() will not free
>> up page table pages, as there will be valid non-zero entries in them. But
> 
> Right.
> 
>> the problem here is not UAF, its accessing wrong entries and crashing while
>> de-referncing the pointer. Hence I am wondering if no such scenario can be
>> possible.
>>
> 
> What's the wrong entries? You mean the reused vmemmap page entries?
> If so, I think free_empty_tables() will not cause any crash.  The hot removed
> operation couldn't reach those entries since those addresses mapped with
> those reused entries are not included in the range of the hot removed section.

Fair enough. I guess if intermediate PMD entries during split, during HugeTLB
vmemmap remap, cannot be empty (even temporarily), this should be fine.
