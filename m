Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 7B0FE4696FF
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Dec 2021 14:28:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244466AbhLFNbu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 08:31:50 -0500
Received: from foss.arm.com ([217.140.110.172]:57460 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S244397AbhLFNbp (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 08:31:45 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 106DB6D;
        Mon,  6 Dec 2021 05:28:17 -0800 (PST)
Received: from [10.57.34.58] (unknown [10.57.34.58])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id C84B03F73D;
        Mon,  6 Dec 2021 05:28:15 -0800 (PST)
Message-ID: <0c55d229-67a4-c5fa-4d0d-9f1497330e45@arm.com>
Date:   Mon, 6 Dec 2021 13:28:11 +0000
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (Windows NT 10.0; rv:91.0) Gecko/20100101
 Thunderbird/91.3.2
Subject: Re: [PATCH 4/9] iommu/amd: Simplify pagetable freeing
Content-Language: en-GB
To:     Joerg Roedel <joro@8bytes.org>
Cc:     will@kernel.org, iommu@lists.linux-foundation.org,
        suravee.suthikulpanit@amd.com, baolu.lu@linux.intel.com,
        willy@infradead.org, linux-kernel@vger.kernel.org,
        john.garry@huawei.com
References: <cover.1637671820.git.robin.murphy@arm.com>
 <0a98d76325d6899808afb1118629c22427629c7c.1637671820.git.robin.murphy@arm.com>
 <Ya4EwWkvDpuvoEjF@8bytes.org>
From:   Robin Murphy <robin.murphy@arm.com>
In-Reply-To: <Ya4EwWkvDpuvoEjF@8bytes.org>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 2021-12-06 12:40, Joerg Roedel wrote:
> On Tue, Nov 23, 2021 at 02:10:39PM +0000, Robin Murphy wrote:
>> For reasons unclear, pagetable freeing is an effectively recursive
>> method implemented via an elaborate system of templated functions that
>> turns out to account for 25% of the object file size. Implementing it
>> using regular straightforward recursion makes the code simpler, and
>> seems like a good thing to do before we work on it further. As part of
>> that, also fix the types to avoid all the needless casting back and
>> forth which just gets in the way.
> 
> Nice cleanup! The stack of functions came from the fact that recursion
> was pretty much discouraged in the kernel. But in this case it looks
> well bounded and should be fine.

I did wonder about explicitly clamping lvl to ensure that it couldn't 
possibly recurse any further than the multi-function version, but given 
that you'd need to craft a suitable bogus pagetable in addition to 
corrupting the arguments to be able to exploit it at all, that seemed 
perhaps a little too paranoid. Happy to add something like:

	if (WARN_ON(lvl > PAGE_MODE_7_LEVEL))
		return NULL;

if you like, though.

>> +static struct page *free_pt_lvl(u64 *pt, struct page *freelist, int lvl)
>> +{
>> +	u64 *p;
>> +	int i;
>> +
>> +	for (i = 0; i < 512; ++i) {
>> +		/* PTE present? */
>> +		if (!IOMMU_PTE_PRESENT(pt[i]))
>> +			continue;
>> +
>> +		/* Large PTE? */
>> +		if (PM_PTE_LEVEL(pt[i]) == 0 ||
>> +		    PM_PTE_LEVEL(pt[i]) == 7)
>> +			continue;
>> +
>> +		p = IOMMU_PTE_PAGE(pt[i]);
>> +		if (lvl > 2)
> 
> I thinkt this function deserves a couple of comments. It took me a while
> to make sense of the 'lvl > 2' comparision. I think it is right, but if
> I have think again I'd appreciate a comment :)

Heh, it's merely a direct transformation of the logic encoded in the 
existing "DEFINE_FREE_PT_FN(...)" cases - I assume that's just an 
optimisation, so I'll add a comment to that effect.

Thanks,
Robin.
