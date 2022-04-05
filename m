Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84A534F2236
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Apr 2022 06:47:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229569AbiDEEsw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Apr 2022 00:48:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57946 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229462AbiDEEsD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Apr 2022 00:48:03 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 48589694B8
        for <linux-kernel@vger.kernel.org>; Mon,  4 Apr 2022 21:44:40 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 48876D6E;
        Mon,  4 Apr 2022 21:44:40 -0700 (PDT)
Received: from [192.168.0.146] (unknown [172.31.20.19])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 5F9EE3F5A1;
        Mon,  4 Apr 2022 21:44:34 -0700 (PDT)
Message-ID: <d6e2581e-a8ac-4848-2c64-4a221bd03bca@arm.com>
Date:   Tue, 5 Apr 2022 10:15:02 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v4 2/2] arm64: mm: hugetlb: Enable
 HUGETLB_PAGE_FREE_VMEMMAP for arm64
Content-Language: en-US
To:     Muchun Song <songmuchun@bytedance.com>, will@kernel.org,
        akpm@linux-foundation.org, david@redhat.com, bodeddub@amazon.com,
        osalvador@suse.de, mike.kravetz@oracle.com, rientjes@google.com,
        mark.rutland@arm.com, catalin.marinas@arm.com, james.morse@arm.com,
        21cnbao@gmail.com
Cc:     linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, duanxiongchun@bytedance.com,
        fam.zheng@bytedance.com, smuchun@gmail.com
References: <20220331065640.5777-1-songmuchun@bytedance.com>
 <20220331065640.5777-2-songmuchun@bytedance.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <20220331065640.5777-2-songmuchun@bytedance.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/31/22 12:26, Muchun Song wrote:
> 1st concern:
> '''
> But what happens when a hot remove section's vmemmap area (which is
> being teared down) is nearby another vmemmap area which is either created
> or being destroyed for HugeTLB alloc/free purpose. As you mentioned
> HugeTLB pages inside the hot remove section might be safe. But what about
> other HugeTLB areas whose vmemmap area shares page table entries with
> vmemmap entries for a section being hot removed ? Massive HugeTLB alloc
> /use/free test cycle using memory just adjacent to a memory hotplug area,
> which is always added and removed periodically, should be able to expose
> this problem.
> '''
> 
> Answer: At the time memory is removed, all HugeTLB pages either have been
> migrated away or dissolved.  So there is no race between memory hot remove
> and free_huge_page_vmemmap().  Therefore, HugeTLB pages inside the hot
> remove section is safe.  Let's talk your question "what about other

HugeTLB pages inside the memory range is safe but concern is about the
vmemmap mapping for the HugeTLB which might share intermediate entries
with vmemmap mapping for the memory range/section being removed.

> HugeTLB areas whose vmemmap area shares page table entries with vmemmap
> entries for a section being hot removed ?", the question is not

Right.

> established.  The minimal granularity size of hotplug memory 128MB (on
> arm64, 4k base page), any HugeTLB smaller than 128MB is within a section,
> then, there is no share PTE page tables between HugeTLB in this section

128MB is the hot removable granularity but, its corresponding vmemmap
range is smaller i.e (128MB/4K) * sizeof(struct page). Memory section
getting hot removed (its vmemmap mapping being teared down) along with
HugeTLB (on another section) vmemmap remap operation, could not collide
while inside vmemmap mapping areas on init_mm ?

> and ones in other sections and a HugeTLB page could not cross two
> sections.  In this case, the section cannot be freed.  Any HugeTLB bigger

Right, they dont cross into two different sections.

> than 128MB (section size) whose vmemmap pages is an integer multiple of
> 2MB (PMD-mapped).  As long as:
> 
>   1) HugeTLBs are naturally aligned, power-of-two sizes
>   2) The HugeTLB size >= the section size
>   3) The HugeTLB size >= the vmemmap leaf mapping size
> 
> Then a HugeTLB will not share any leaf page table entries with *anything
> else*, but will share intermediate entries.  In this case, at the time memory
> is removed, all HugeTLB pages either have been migrated away or dissolved.
> So there is also no race between memory hot remove and
> free_huge_page_vmemmap().

If they just share intermediate entries, free_empty_tables() will not free
up page table pages, as there will be valid non-zero entries in them. But
the problem here is not UAF, its accessing wrong entries and crashing while
de-referncing the pointer. Hence I am wondering if no such scenario can be
possible.

> 
> 2nd concern:
> '''
> differently, not sure if ptdump would require any synchronization.
> 
> Dumping an wrong value is probably okay but crashing because a page table
> entry is being freed after ptdump acquired the pointer is bad. On arm64,
> ptdump() is protected against hotremove via [get|put]_online_mems().
> '''
> 
> Answer: The ptdump should be fine since vmemmap_remap_free() only exchanges
> PTEs or splits the PMD entry (which means allocating a PTE page table).  Both
> operations do not free any page tables (PTE), so ptdump cannot run into a
> UAF on any page tables.  The worst case is just dumping an wrong value.

Okay, fair enough. ptdump() might be just okay.
