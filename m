Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7C5CB494018
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 19:43:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356873AbiASSnV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 13:43:21 -0500
Received: from foss.arm.com ([217.140.110.172]:34984 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356833AbiASSnU (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 13:43:20 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id C31131FB;
        Wed, 19 Jan 2022 10:43:19 -0800 (PST)
Received: from [10.57.67.190] (unknown [10.57.67.190])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 1E4B93F73D;
        Wed, 19 Jan 2022 10:43:16 -0800 (PST)
Message-ID: <e9226eb4-4ecf-ac01-e823-ff507a354ac5@arm.com>
Date:   Wed, 19 Jan 2022 18:43:10 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] vmap(): don't allow invalid pages
Content-Language: en-GB
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Yury Norov <yury.norov@gmail.com>,
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
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Yeg79CcofyNuVLid@casper.infradead.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2022-01-19 16:27, Matthew Wilcox wrote:
> On Wed, Jan 19, 2022 at 01:28:14PM +0000, Robin Murphy wrote:
>>> +		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
>>
>> Is it page_to_pfn() guaranteed to work without blowing up if page is invalid
>> in the first place? Looking at the CONFIG_SPARSEMEM case I'm not sure that's
>> true...
> 
> Even if it does blow up, at least it's blowing up here where someone
> can start to debug it, rather than blowing up on first access, where
> we no longer have the invlid struct page pointer.

But if that were the case then we'd blow up on the following line when 
mk_pte(page, prot) ends up calling it same anyway. Indeed it's arguably 
the best-case scenario since it would also blow up in page_address() if 
we hit the vmap_range loop rather than going down the 
vmap_small_pages_range_noflush() path.

Furthermore, if you *are* lucky enough to take a fault upon accessing a 
bogus mapping, then surely a phys_to_page() calculation on whatever 
ended up in the PTE should get you back the original "pointer" anyway, 
shouldn't it? Sure it's a bit more work to extract the caller out of the 
VMA if necessary, but hey, that's debugging! Maybe vmap() failing means 
you then pass the offending nonsense to __free_pages() and that ruins 
your day anyway...

The implications are infinitely worse if you've mapped something that 
did happen to be a valid page, but wasn't the *right* page, such that 
you don't fault but corrupt things or trigger a fatal system error 
instead. I'd echo Mark's point that if we can't trust a page pointer to 
be correct then we've already lost. In general the proportion of "wrong" 
pointers one can viably attempt to detect is so small that it's rarely 
ever worth trying, and the cases that are so obviously wrong tend to 
show up well enough in normal operation (although NULL-safety is of 
course a bit of a special case when it can simplify API usage).

> I don't think we have a 'page_valid' function which will tell us whether
> a random pointer is actually a struct page or not.

Indeed, my impression is that the only legitimate way to get hold of a 
page pointer without assumed provenance is via pfn_to_page(), which is 
where pfn_valid() comes in. Thus pfn_valid(page_to_pfn()) really 
*should* be a tautology.

I guess in this instance it would be technically feasible to implement a 
function which checks "is this a correctly-aligned pointer within memmap 
bounds", but IMO that would be a massive step in the wrong direction. 
We're developers; sometimes we introduce bugs when developing code, and 
it takes effort to debug them, but that still doesn't make it a good 
idea to optimise normal code paths for the expectation of writing new 
catastrophically-bad bugs. Plus logically if such a "page_valid()" check 
could be justified at all then that should rightfully lead to a 
churn-fest of adding it to pretty much every interface which accepts 
page pointers - one half of vmap() is hardly special.

FWIW, If anything I reckon a DEBUG_VM option that made checks within 
page_to_x/x_to_page as appropriate would help Yury's issue just as much, 
while having the potential to be considerably more useful in general.

Cheers,
Robin.
