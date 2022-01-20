Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7F56049527A
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:37:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377066AbiATQhM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:37:12 -0500
Received: from foss.arm.com ([217.140.110.172]:44522 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S231576AbiATQhM (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:37:12 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 84CF0ED1;
        Thu, 20 Jan 2022 08:37:11 -0800 (PST)
Received: from [10.57.68.26] (unknown [10.57.68.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id AC96A3F73D;
        Thu, 20 Jan 2022 08:37:08 -0800 (PST)
Message-ID: <e6fde086-16b9-430f-5510-5296ef74a4e7@arm.com>
Date:   Thu, 20 Jan 2022 16:37:01 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] vmap(): don't allow invalid pages
Content-Language: en-GB
To:     "Russell King (Oracle)" <linux@armlinux.org.uk>
Cc:     Matthew Wilcox <willy@infradead.org>,
        Yury Norov <yury.norov@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <f85b3cac-29e7-4179-e078-fd859040c294@arm.com>
 <Yeg79CcofyNuVLid@casper.infradead.org>
 <e9226eb4-4ecf-ac01-e823-ff507a354ac5@arm.com>
 <YehilqRvYLhryUk4@shell.armlinux.org.uk>
 <319b09bc-56a2-207f-6180-3cc7d8cd43d1@arm.com>
 <Yeldih0PHotN4/bn@shell.armlinux.org.uk>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yeldih0PHotN4/bn@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-20 13:03, Russell King (Oracle) wrote:
> On Thu, Jan 20, 2022 at 12:22:35PM +0000, Robin Murphy wrote:
>> On 2022-01-19 19:12, Russell King (Oracle) wrote:
>>> On Wed, Jan 19, 2022 at 06:43:10PM +0000, Robin Murphy wrote:
>>>> Indeed, my impression is that the only legitimate way to get hold of a page
>>>> pointer without assumed provenance is via pfn_to_page(), which is where
>>>> pfn_valid() comes in. Thus pfn_valid(page_to_pfn()) really *should* be a
>>>> tautology.
>>>
>>> That can only be true if pfn == page_to_pfn(pfn_to_page(pfn)) for all
>>> values of pfn.
>>>
>>> Given how pfn_to_page() is defined in the sparsemem case:
>>>
>>> #define __pfn_to_page(pfn)                              \
>>> ({	unsigned long __pfn = (pfn);                    \
>>> 	struct mem_section *__sec = __pfn_to_section(__pfn);    \
>>> 	__section_mem_map_addr(__sec) + __pfn;          \
>>> })
>>> #define page_to_pfn __page_to_pfn
>>>
>>> that isn't the case, especially when looking at page_to_pfn():
>>>
>>> #define __page_to_pfn(pg)                                       \
>>> ({      const struct page *__pg = (pg);                         \
>>>           int __sec = page_to_section(__pg);                      \
>>> 	(unsigned long)(__pg - __section_mem_map_addr(__nr_to_section(__sec))); \
>>> })
>>>
>>> Where:
>>>
>>> static inline unsigned long page_to_section(const struct page *page)
>>> {
>>> 	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
>>> }
>>>
>>> So if page_to_section() returns something that is, e.g. zero for an
>>> invalid page in a non-zero section, you're not going to end up with
>>> the right pfn from page_to_pfn().
>>
>> Right, I emphasised "should" in an attempt to imply "in the absence of
>> serious bugs that have further-reaching consequences anyway".
>>
>>> As I've said now a couple of times, trying to determine of a struct
>>> page pointer is valid is the wrong question to be asking.
>>
>> And doing so in one single place, on the justification of avoiding an
>> incredibly niche symptom, is even more so. Not to mention that an address
>> size fault is one of the best possible outcomes anyway, vs. the untold
>> damage that may stem from accesses actually going through to random parts of
>> the physical memory map.
> 
> I don't see it as a "niche" symptom.

The commit message specifically cites a Data Abort "at address 
translation later". Broadly speaking, a Data Abort due to an address 
size fault only occurs if you've been lucky enough that the bogus PA 
which got mapped is so spectacularly wrong that it's beyond the range 
configured in TCR.IPS. How many other architectures even have a 
mechanism like that?

> If we start off with the struct page being invalid, then the result of
> page_to_pfn() can not be relied upon to produce something that is
> meaningful - which is exactly why the vmap() issue arises.
> 
> With a pfn_valid() check, we at least know that the PFN points at
> memory.

No, we know it points to some PA space which has a struct page to 
represent it. pfn_valid() only says that pfn_to_page() will yield a 
valid result. That also includes things like reserved pages covering 
non-RAM areas, where a kernel VA mapping existing at all could 
potentially be fatal to the system even if it's never explicitly 
accessed - for all we know it might be a carveout belonging to 
overly-aggressive Secure software such that even a speculative prefetch 
might trigger an instant system reset.

> However, that memory could be _anything_ in the system - it
> could be the kernel image, and it could give userspace access to
> change kernel code.
> 
> So, while it is useful to do a pfn_valid() check in vmap(), as I said
> to willy, this must _not_ be the primary check. It should IMHO use
> WARN_ON() to make it blatently obvious that it should be something we
> expect _not_ to trigger under normal circumstances, but is there to
> catch programming errors elsewhere.

Rather, "to partially catch unrelated programming errors elsewhere, 
provided the buggy code happens to call vmap() rather than any of the 
many other functions with a struct page * argument." That's where it 
stretches my definition of "useful" just a bit too far. It's not about 
perfect being the enemy of good, it's about why vmap() should be 
special, and death by a thousand "useful" cuts - if we don't trust the 
pointer, why not check its alignment for basic plausibility first? If it 
seems valid, why not check if the page flags look sensible to make sure? 
How many useful little checks is too many? Every bit of code footprint 
and execution overhead imposed unconditionally on all end users to 
theoretically save developers' debugging time still adds up. Although on 
that note, it looks like arch/arm's pfn_valid() is still a linear scan 
of the memblock array, so the overhead of adding that for every page in 
every vmap() might not even be so small...

Robin.
