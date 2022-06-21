Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 242C5552D64
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 10:49:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348251AbiFUItr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 04:49:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230049AbiFUItq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 04:49:46 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0CF882610D
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 01:49:44 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R101e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=xianting.tian@linux.alibaba.com;NM=1;PH=DS;RN=6;SR=0;TI=SMTPD_---0VH0a80n_1655801380;
Received: from B-LB6YLVDL-0141.local(mailfrom:xianting.tian@linux.alibaba.com fp:SMTPD_---0VH0a80n_1655801380)
          by smtp.aliyun-inc.com;
          Tue, 21 Jun 2022 16:49:41 +0800
Subject: Re: [PATCH] mm: fixup validation of buddy pfn
To:     David Hildenbrand <david@redhat.com>, akpm@linux-foundation.org,
        ziy@nvidia.com
Cc:     guoren@kernel.org, linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220621031118.3650529-1-xianting.tian@linux.alibaba.com>
 <c45a6850-772e-8d2c-9261-7621f242dbae@redhat.com>
From:   Xianting Tian <xianting.tian@linux.alibaba.com>
Message-ID: <502ccdeb-372c-1d05-4b5e-a962f39cfb55@linux.alibaba.com>
Date:   Tue, 21 Jun 2022 16:49:40 +0800
User-Agent: Mozilla/5.0 (Macintosh; Intel Mac OS X 10.15; rv:78.0)
 Gecko/20100101 Thunderbird/78.10.1
MIME-Version: 1.0
In-Reply-To: <c45a6850-772e-8d2c-9261-7621f242dbae@redhat.com>
Content-Type: text/plain; charset=utf-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,NICE_REPLY_A,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


在 2022/6/21 下午4:01, David Hildenbrand 写道:
> On 21.06.22 05:11, Xianting Tian wrote:
>> For RISC-V arch the first 2MB RAM could be reserved for opensbi,
>> and the arch code may don't create pages for the first 2MB RAM,
>> so it would have pfn_base=512 and mem_map began with 512th PFN when
>> CONFIG_FLATMEM=y.
>>
>> But __find_buddy_pfn algorithm thinks the start PFN 0, it could get
>> 0 PFN or less than the pfn_base value, so page_is_buddy() can't
>> verify the page whose PFN is 0 ~ 511, actually we don't have valid
>> pages for PFN 0 ~ 511.
>>
>> Actually, buddy system should not assume Arch cretaed pages for
>> reserved memory, Arch may don't know the implied limitation.
> Ehm, sorry, no. Archs have to stick to the rules of the buddy, not the
> other way around. Why should we add additional overhead to the buddy
> just because arch XYZ wants to be special?

We ever sent a patch to create mapping for the first 2MB RAM for RISC-V, 
But it is not accetped.

But I am just wondering, if we have the RAM whose physical base address 
is not 0, for example, start with 0x200000(2Mb).

Then the base PFN is (0x200000 >> 12) = 512, Do we still need to create 
mapping for the non-existing first 2Mb RAM,

if not, the issue still exist under the case?

>
> If at all, we should fail hard if an arch doesn't play with the rules
> and make this a VM_BUG_ON().
>
>> With this patch, we can gurantee a valid buddy no matter what we
>> have pages for reserved memory or not.
>>
>> Fixes: 8170ac4700d26f65 ("mm: wrap __find_buddy_pfn() with a necessary buddy page validation")
>> Signed-off-by: Xianting Tian <xianting.tian@linux.alibaba.com>
>> ---
>>   mm/internal.h | 6 +++++-
>>   1 file changed, 5 insertions(+), 1 deletion(-)
>>
>> diff --git a/mm/internal.h b/mm/internal.h
>> index c0f8fbe0445b..0ec446caeb2e 100644
>> --- a/mm/internal.h
>> +++ b/mm/internal.h
>> @@ -322,7 +322,8 @@ __find_buddy_pfn(unsigned long page_pfn, unsigned int order)
>>    * The found buddy can be a non PageBuddy, out of @page's zone, or its order is
>>    * not the same as @page. The validation is necessary before use it.
>>    *
>> - * Return: the found buddy page or NULL if not found.
>> + * Return: the found buddy page or NULL if not found or NULL if buddy pfn is
>> + *         not valid.
>>    */
>>   static inline struct page *find_buddy_page_pfn(struct page *page,
>>   			unsigned long pfn, unsigned int order, unsigned long *buddy_pfn)
>> @@ -330,6 +331,9 @@ static inline struct page *find_buddy_page_pfn(struct page *page,
>>   	unsigned long __buddy_pfn = __find_buddy_pfn(pfn, order);
>>   	struct page *buddy;
>>   
>> +	if (!pfn_valid(__buddy_pfn))
>> +		return NULL;
>> +
>>   	buddy = page + (__buddy_pfn - pfn);
>>   	if (buddy_pfn)
>>   		*buddy_pfn = __buddy_pfn;
>
