Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CF45C537822
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 12:06:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234574AbiE3JDZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 05:03:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37164 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231466AbiE3JDV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 05:03:21 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 3E1C314D15
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 02:03:20 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 05DBC113E;
        Mon, 30 May 2022 02:03:20 -0700 (PDT)
Received: from [10.163.36.153] (unknown [10.163.36.153])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id B98243F73D;
        Mon, 30 May 2022 02:03:17 -0700 (PDT)
Message-ID: <6676b6a4-2d2d-27bf-2f71-b0c4767b71bf@arm.com>
Date:   Mon, 30 May 2022 14:33:18 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH V2] mm/memory_hotplug: Drop 'reason' argument from
 check_pfn_span()
Content-Language: en-US
To:     David Hildenbrand <david@redhat.com>, linux-mm@kvack.org
Cc:     Oscar Salvador <osalvador@suse.de>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220526021258.4030749-1-anshuman.khandual@arm.com>
 <8c5c5bd6-fea6-4c27-9a84-4b9c937068d7@redhat.com>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <8c5c5bd6-fea6-4c27-9a84-4b9c937068d7@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.4 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/30/22 12:24, David Hildenbrand wrote:
> On 26.05.22 04:12, Anshuman Khandual wrote:
>> In check_pfn_span(), a 'reason' string is being used to recreate the caller
>> function name, while printing the warning message. It is really unnecessary
>> as the warning message could just be printed inside the caller depending on
>> the return code. Currently there are just two callers for check_pfn_span()
>> i.e  __add_pages() and __remove_pages(). Let's clean this up.
>>
>> Cc: Oscar Salvador <osalvador@suse.de>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
>> ---
>> Changes in V2:
>>
>> - Fixed typo in commit message
>> - Dropped using 'ret' to capture check_pfn_span() return value in __add_pages()
>>
>> Changes in V1:
>>
>> https://lore.kernel.org/all/20220525033910.3781764-1-anshuman.khandual@arm.com/
>>
>>  mm/memory_hotplug.c | 20 +++++++++-----------
>>  1 file changed, 9 insertions(+), 11 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 416b38ca8def..3b24386e9276 100644
>> --- a/mm/memory_hotplug.c
>> +++ b/mm/memory_hotplug.c
>> @@ -220,8 +220,7 @@ static void release_memory_resource(struct resource *res)
>>  	kfree(res);
>>  }
>>  
>> -static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>> -		const char *reason)
>> +static int check_pfn_span(unsigned long pfn, unsigned long nr_pages)
>>  {
>>  	/*
>>  	 * Disallow all operations smaller than a sub-section and only
>> @@ -238,12 +237,8 @@ static int check_pfn_span(unsigned long pfn, unsigned long nr_pages,
>>  		min_align = PAGES_PER_SUBSECTION;
>>  	else
>>  		min_align = PAGES_PER_SECTION;
>> -	if (!IS_ALIGNED(pfn, min_align)
>> -			|| !IS_ALIGNED(nr_pages, min_align)) {
>> -		WARN(1, "Misaligned __%s_pages start: %#lx end: #%lx\n",
>> -				reason, pfn, pfn + nr_pages - 1);
>> +	if (!IS_ALIGNED(pfn, min_align) || !IS_ALIGNED(nr_pages, min_align))
> We could do
> 
> if (!IS_ALIGNED(pfn | nr_pages, min_align))


Sure, will change it.
