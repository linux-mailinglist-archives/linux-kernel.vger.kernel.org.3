Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E44704934E7
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 07:17:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351729AbiASGRV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 01:17:21 -0500
Received: from foss.arm.com ([217.140.110.172]:47708 "EHLO foss.arm.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S234904AbiASGRT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 01:17:19 -0500
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 4898FD6E;
        Tue, 18 Jan 2022 22:17:19 -0800 (PST)
Received: from [10.163.74.69] (unknown [10.163.74.69])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 3F7143F73D;
        Tue, 18 Jan 2022 22:17:14 -0800 (PST)
Subject: Re: [PATCH] vmap(): don't allow invalid pages
To:     Matthew Wilcox <willy@infradead.org>,
        Yury Norov <yury.norov@gmail.com>
Cc:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nicholas Piggin <npiggin@gmail.com>,
        Ding Tianhong <dingtianhong@huawei.com>,
        Alexey Klimov <aklimov@redhat.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-mm@kvack.org, Uladzislau Rezki <urezki@gmail.com>
References: <20220118235244.540103-1-yury.norov@gmail.com>
 <Yedgj+Lo2eru8197@casper.infradead.org>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
Message-ID: <cfe4c63e-57c0-2a9d-c3e9-959bc77b87c6@arm.com>
Date:   Wed, 19 Jan 2022 11:47:18 +0530
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:68.0) Gecko/20100101
 Thunderbird/68.10.0
MIME-Version: 1.0
In-Reply-To: <Yedgj+Lo2eru8197@casper.infradead.org>
Content-Type: text/plain; charset=utf-8
Content-Language: en-US
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/19/22 6:21 AM, Matthew Wilcox wrote:
> On Tue, Jan 18, 2022 at 03:52:44PM -0800, Yury Norov wrote:
>> vmap() takes struct page *pages as one of arguments, and user may provide
>> an invalid pointer which would lead to DABT at address translation later.
> 
> Could we spell out 'DABT'?  Presumably that's an ARM-specific thing.
> Just like we don't say #PF for Intel page faults, I think this is
> probably a 'data abort'?

Right, it is data abort.

> 
>> Currently, kernel checks the pages against NULL. In my case, however, the
>> address was not NULL, and was big enough so that the hardware generated
>> Address Size Abort on arm64.

Could you please provide the actual abort stack here with details.

>>
>> Interestingly, this abort happens even if copy_from_kernel_nofault() is
>> used, which is quite inconvenient for debugging purposes. 
>>
>> This patch adds a pfn_valid() check into vmap() path, so that invalid
>> mapping will not be created.
>>
>> RFC: https://lkml.org/lkml/2022/1/18/815
>> v1: use pfn_valid() instead of adding an arch-specific
>>     arch_vmap_page_valid(). Thanks to Matthew Wilcox for the hint.

This should be after the '---' below.

>>
>> Signed-off-by: Yury Norov <yury.norov@gmail.com>
> 
> Suggested-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> 
>> ---
>>  mm/vmalloc.c | 2 ++
>>  1 file changed, 2 insertions(+)
>>
>> diff --git a/mm/vmalloc.c b/mm/vmalloc.c
>> index d2a00ad4e1dd..a4134ee56b10 100644
>> --- a/mm/vmalloc.c
>> +++ b/mm/vmalloc.c
>> @@ -477,6 +477,8 @@ static int vmap_pages_pte_range(pmd_t *pmd, unsigned long addr,
>>  			return -EBUSY;
>>  		if (WARN_ON(!page))
>>  			return -ENOMEM;
>> +		if (WARN_ON(!pfn_valid(page_to_pfn(page))))
>> +			return -EINVAL;
>>  		set_pte_at(&init_mm, addr, pte, mk_pte(page, prot));
>>  		(*nr)++;
>>  	} while (pte++, addr += PAGE_SIZE, addr != end);
>> -- 
>> 2.30.2
>>

Why should not this just scan over the entire user provided struct page
array and make sure that all pages there in are valid via above method,
but in vmap() itself before calling vmap_pages_range(). Because seems
like a single invalid page detected in vmap_pages_pte_range() will
anyways abort the entire vmap(). This will also enable us to drop the
existing NULL check above.
