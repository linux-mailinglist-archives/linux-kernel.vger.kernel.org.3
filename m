Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A2E3E494DD1
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 13:23:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237223AbiATMWo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 07:22:44 -0500
Received: from foss.arm.com ([217.140.110.172]:35958 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S232146AbiATMWn (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 07:22:43 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 91B2FED1;
        Thu, 20 Jan 2022 04:22:42 -0800 (PST)
Received: from [10.57.68.26] (unknown [10.57.68.26])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 97FE53F774;
        Thu, 20 Jan 2022 04:22:40 -0800 (PST)
Message-ID: <319b09bc-56a2-207f-6180-3cc7d8cd43d1@arm.com>
Date:   Thu, 20 Jan 2022 12:22:35 +0000
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <YehilqRvYLhryUk4@shell.armlinux.org.uk>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-19 19:12, Russell King (Oracle) wrote:
> On Wed, Jan 19, 2022 at 06:43:10PM +0000, Robin Murphy wrote:
>> Indeed, my impression is that the only legitimate way to get hold of a page
>> pointer without assumed provenance is via pfn_to_page(), which is where
>> pfn_valid() comes in. Thus pfn_valid(page_to_pfn()) really *should* be a
>> tautology.
> 
> That can only be true if pfn == page_to_pfn(pfn_to_page(pfn)) for all
> values of pfn.
> 
> Given how pfn_to_page() is defined in the sparsemem case:
> 
> #define __pfn_to_page(pfn)                              \
> ({	unsigned long __pfn = (pfn);                    \
> 	struct mem_section *__sec = __pfn_to_section(__pfn);    \
> 	__section_mem_map_addr(__sec) + __pfn;          \
> })
> #define page_to_pfn __page_to_pfn
> 
> that isn't the case, especially when looking at page_to_pfn():
> 
> #define __page_to_pfn(pg)                                       \
> ({      const struct page *__pg = (pg);                         \
>          int __sec = page_to_section(__pg);                      \
> 	(unsigned long)(__pg - __section_mem_map_addr(__nr_to_section(__sec))); \
> })
> 
> Where:
> 
> static inline unsigned long page_to_section(const struct page *page)
> {
> 	return (page->flags >> SECTIONS_PGSHIFT) & SECTIONS_MASK;
> }
> 
> So if page_to_section() returns something that is, e.g. zero for an
> invalid page in a non-zero section, you're not going to end up with
> the right pfn from page_to_pfn().

Right, I emphasised "should" in an attempt to imply "in the absence of 
serious bugs that have further-reaching consequences anyway".

> As I've said now a couple of times, trying to determine of a struct
> page pointer is valid is the wrong question to be asking.

And doing so in one single place, on the justification of avoiding an 
incredibly niche symptom, is even more so. Not to mention that an 
address size fault is one of the best possible outcomes anyway, vs. the 
untold damage that may stem from accesses actually going through to 
random parts of the physical memory map.

Robin.
