Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 86091533A06
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 11:38:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237659AbiEYJiM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 05:38:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46356 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232788AbiEYJiK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 05:38:10 -0400
Received: from foss.arm.com (foss.arm.com [217.140.110.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 95F316567
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 02:38:09 -0700 (PDT)
Received: from usa-sjc-imap-foss1.foss.arm.com (unknown [10.121.207.14])
        by usa-sjc-mx-foss1.foss.arm.com (Postfix) with ESMTP id 3D43C1FB;
        Wed, 25 May 2022 02:38:09 -0700 (PDT)
Received: from [10.163.37.70] (unknown [10.163.37.70])
        by usa-sjc-imap-foss1.foss.arm.com (Postfix) with ESMTPSA id 079CD3F70D;
        Wed, 25 May 2022 02:38:06 -0700 (PDT)
Message-ID: <7e692769-daca-65cb-2263-c4be9b99ed38@arm.com>
Date:   Wed, 25 May 2022 15:08:03 +0530
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH] mm/memory_hotplug: Drop 'reason' argument from
 check_pfn_span()
Content-Language: en-US
To:     Oscar Salvador <osalvador@suse.de>
Cc:     linux-mm@kvack.org, David Hildenbrand <david@redhat.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        linux-kernel@vger.kernel.org
References: <20220525033910.3781764-1-anshuman.khandual@arm.com>
 <Yo3n8Zagb68zuMqa@localhost.localdomain>
From:   Anshuman Khandual <anshuman.khandual@arm.com>
In-Reply-To: <Yo3n8Zagb68zuMqa@localhost.localdomain>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.0 required=5.0 tests=BAYES_00,NICE_REPLY_A,
        RCVD_IN_DNSWL_HI,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 5/25/22 13:55, Oscar Salvador wrote:
> On Wed, May 25, 2022 at 09:09:09AM +0530, Anshuman Khandual wrote:
>> In check_pfn_span(), a 'reason' string is being used to recreate the caller
>> function name, while printing the warning message. It is really unnecessary
>> as the warning message could just be printed inside the caller depending on
>> the return code. Currentlyy there are just two callers for check_pfn_span()
>                    Currently

Ahh, will fix.

>> i.e  __add_pages() and __remove_pages(). Let's clean this up.
>>
>> Cc: David Hildenbrand <david@redhat.com>
>> Cc: Andrew Morton <akpm@linux-foundation.org>
>> Cc: linux-mm@kvack.org
>> Cc: linux-kernel@vger.kernel.org
>> Signed-off-by: Anshuman Khandual <anshuman.khandual@arm.com>
> 
> One could argue if this is really a cleanup.
> I kind of agree that the "reason" thingy is a bit shaky, but instead of having a
> single place where we call WARN(), we now do have two.

check_pfn_span() is basically ensuring minimum alignment for both pfn and
nr_pages. Resulting error message when this alignment check does not hold
true, is caller specific than not.

> 
>> ---
>>  mm/memory_hotplug.c | 19 +++++++++----------
>>  1 file changed, 9 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/memory_hotplug.c b/mm/memory_hotplug.c
>> index 416b38ca8def..9b3d7295ef93 100644
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
>>  		return -EINVAL;
>> -	}
>>  	return 0;
>>  }
>>  
>> @@ -320,9 +315,11 @@ int __ref __add_pages(int nid, unsigned long pfn, unsigned long nr_pages,
>>  		altmap->alloc = 0;
>>  	}
>>  
>> -	err = check_pfn_span(pfn, nr_pages, "add");
>> -	if (err)
>> +	err = check_pfn_span(pfn, nr_pages);
>> +	if (err) {
>> +		WARN(1, "Misaligned %s start: %#lx end: #%lx\n", __func__, pfn, pfn + nr_pages - 1);
>>  		return err;
>> +	}
> 
> If you want to further clean this up, I would just do 
> 
>  if (check_pfn_span()) {
>          WARN(....)
>          return -EINVAL;
>  }
> 
> here as we do in __remove_pages(). check_pfn_span() can either return 0 or -EINVAL,
> so I think it is fine.

Sure, will change.
