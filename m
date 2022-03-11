Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6EAFC4D5BAE
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 07:39:50 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346689AbiCKGkq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 01:40:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57044 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238501AbiCKGkm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 01:40:42 -0500
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id F00343EF13
        for <linux-kernel@vger.kernel.org>; Thu, 10 Mar 2022 22:39:39 -0800 (PST)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 93C7814BF;
        Thu, 10 Mar 2022 22:39:39 -0800 (PST)
Received: from [10.163.33.198] (unknown [10.163.33.198])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id E653F3F99C;
        Thu, 10 Mar 2022 22:39:37 -0800 (PST)
Message-ID: <2abaff3b-455a-c345-be93-0036b8dd1519@arm.com>
Date:   Fri, 11 Mar 2022 12:09:37 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/huge_memory: remove unneeded local variable follflags
Content-Language: en-US
To:     Miaohe Lin <linmiaohe@huawei.com>, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220310131253.30970-1-linmiaohe@huawei.com>
 <90246c21-94e9-e64e-dd83-fce45de89f72@arm.com>
 <15d17cb9-6eae-0345-8e67-da30a5978300@huawei.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <15d17cb9-6eae-0345-8e67-da30a5978300@huawei.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.9 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 3/11/22 11:56, Miaohe Lin wrote:
> On 2022/3/11 12:51, Anshuman Khandual wrote:
>> Hi Miaohe,
>>
>> On 3/10/22 18:42, Miaohe Lin wrote:
>>> We can pass FOLL_GET | FOLL_DUMP to follow_page directly to simplify
>>> the code a bit.
>>>
>>> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
>>> ---
>>>  mm/huge_memory.c | 4 +---
>>>  1 file changed, 1 insertion(+), 3 deletions(-)
>>>
>>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>>> index 3557aabe86fe..418d077da246 100644
>>> --- a/mm/huge_memory.c
>>> +++ b/mm/huge_memory.c
>>> @@ -2838,7 +2838,6 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>>>  	 */
>>>  	for (addr = vaddr_start; addr < vaddr_end; addr += PAGE_SIZE) {
>>>  		struct vm_area_struct *vma = find_vma(mm, addr);
>>> -		unsigned int follflags;
>>>  		struct page *page;
>>>  
>>>  		if (!vma || addr < vma->vm_start)
>>> @@ -2851,8 +2850,7 @@ static int split_huge_pages_pid(int pid, unsigned long vaddr_start,
>>>  		}
>>>  
>>>  		/* FOLL_DUMP to ignore special (like zero) pages */
>>> -		follflags = FOLL_GET | FOLL_DUMP;
>>> -		page = follow_page(vma, addr, follflags);
>>> +		page = follow_page(vma, addr, FOLL_GET | FOLL_DUMP);
>>>  
>>>  		if (IS_ERR(page))
>>>  			continue;
>>
>> LGTM, but there is another similar instance in add_page_for_migration()
>> inside mm/migrate.c, requiring this exact clean up.
>>
> 
> Thanks for comment. That similar case is done in my previous patch series[1]
> aimed at migration cleanup and fixup. It might be more suitable to do that
> clean up in that specialized series?

Both these similar scenarios i.e the one proposed here and other one in the
migration series, should be folded into a separate single patch, either here
or in the series itself.

> 
> [1]:https://lore.kernel.org/linux-mm/20220304093409.25829-4-linmiaohe@huawei.com/
> 
>> Hence with that change in place.
>>
>> Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> Thanks again.
> 
>> .
>>
> 
