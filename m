Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 16E1F5ACD43
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 10:02:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236074AbiIEIAL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 04:00:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236130AbiIEH7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 03:59:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F20AA15820
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 00:59:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662364792;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=T3vGy5cq6ys68yKBKgaE/pN38o35BFl+yOw6ci17fe4=;
        b=aAkNgwdblTvQIUnIMQOBjqGhuynlFIAArtV/18PYZh9mvne+hoa13m5WHvP2zoR16kgNAl
        G9BB0YFtwcyGT8deQW5TshmXGlk32KmEh0H2z5ODUouAIPXpok/5hPVKmgW5nqkBInMbQv
        K5nqN56EYaZM1WPQOwu2iEQgoTj4ADo=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-463-xDXNzVUjNNWkPug33bMaeA-1; Mon, 05 Sep 2022 03:59:50 -0400
X-MC-Unique: xDXNzVUjNNWkPug33bMaeA-1
Received: by mail-wr1-f70.google.com with SMTP id r17-20020adfbb11000000b00228663f217fso377397wrg.20
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 00:59:50 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :content-language:references:cc:to:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=T3vGy5cq6ys68yKBKgaE/pN38o35BFl+yOw6ci17fe4=;
        b=55I/mgsMlBq0VKOmPiLTZE6gm/1pFNA1lHm4L2lbPmLiUxlvayKWtUPHhAL1i5wFn8
         0d1xiXHprtaXl0NOfwFA2d4Rb/q2UBgdBaV2fius7efofWVFOUMHpyq6vgd/Ew69CMOh
         ngIwW60HuE5Evv2Ye6Dpdw4l44U7vRL5O7Yf70+LeQP/zih1gM54xLdkoX6bpxlEJlIu
         F4Nc11GSREWa5GU+ecEaSPh1ctuZPeEerMcFOvYgZmlvLz3zgzNw+PINoNS9f5SGUsct
         r2iKdVsnd8IPocWnUPyizBxV72Wa5qbbyW/0WiuRoY9HngNLm1JfcQTQ8E5gIUqgzSjV
         FnKQ==
X-Gm-Message-State: ACgBeo3JFcxHQe1xfj92Qwu42JbUDgvUK1BuzZYyCaXxEtaUppVtPism
        cpI7HVtRW+dAd0NQGPZavtB99pkzp/JgHJjnLaYUBKyDsowqvBFdoX9PcDfIcgEbVGX6RdsJwuS
        Ji1DU0t2rDlMA4v3etdv/nJYC
X-Received: by 2002:adf:fa11:0:b0:228:bfb5:d56a with SMTP id m17-20020adffa11000000b00228bfb5d56amr603239wrr.353.1662364789554;
        Mon, 05 Sep 2022 00:59:49 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6HhqhcIyLud9D5sDVD/HFFRKEi5R562fjRiufPlrgYGebgESfbmLTsyjQZJVUDzsT/I0IzIg==
X-Received: by 2002:adf:fa11:0:b0:228:bfb5:d56a with SMTP id m17-20020adffa11000000b00228bfb5d56amr603221wrr.353.1662364789215;
        Mon, 05 Sep 2022 00:59:49 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id f6-20020adff586000000b00228c375d81bsm631245wro.2.2022.09.05.00.59.48
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 00:59:48 -0700 (PDT)
Message-ID: <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
Date:   Mon, 5 Sep 2022 09:59:47 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
To:     John Hubbard <jhubbard@nvidia.com>, Yang Shi <shy828301@gmail.com>,
        peterx@redhat.com, kirill.shutemov@linux.intel.com, jgg@nvidia.com,
        hughd@google.com, akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
In-Reply-To: <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.22 00:29, John Hubbard wrote:
> On 9/1/22 15:27, Yang Shi wrote:
>> Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
>> introduce a general RCU get_user_pages_fast()"), a TLB flush is no longer
>> sufficient to handle concurrent GUP-fast in all cases, it only handles
>> traditional IPI-based GUP-fast correctly.  On architectures that send
>> an IPI broadcast on TLB flush, it works as expected.  But on the
>> architectures that do not use IPI to broadcast TLB flush, it may have
>> the below race:
>>
>>     CPU A                                          CPU B
>> THP collapse                                     fast GUP
>>                                                gup_pmd_range() <-- see valid pmd
>>                                                    gup_pte_range() <-- work on pte
>> pmdp_collapse_flush() <-- clear pmd and flush
>> __collapse_huge_page_isolate()
>>      check page pinned <-- before GUP bump refcount
>>                                                        pin the page
>>                                                        check PTE <-- no change
>> __collapse_huge_page_copy()
>>      copy data to huge page
>>      ptep_clear()
>> install huge pmd for the huge page
>>                                                        return the stale page
>> discard the stale page
> 
> Hi Yang,
> 
> Thanks for taking the trouble to write down these notes. I always
> forget which race we are dealing with, and this is a great help. :)
> 
> More...
> 
>>
>> The race could be fixed by checking whether PMD is changed or not after
>> taking the page pin in fast GUP, just like what it does for PTE.  If the
>> PMD is changed it means there may be parallel THP collapse, so GUP
>> should back off.
>>
>> Also update the stale comment about serializing against fast GUP in
>> khugepaged.
>>
>> Fixes: 2667f50e8b81 ("mm: introduce a general RCU get_user_pages_fast()")
>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>> ---
>>   mm/gup.c        | 30 ++++++++++++++++++++++++------
>>   mm/khugepaged.c | 10 ++++++----
>>   2 files changed, 30 insertions(+), 10 deletions(-)
>>
>> diff --git a/mm/gup.c b/mm/gup.c
>> index f3fc1f08d90c..4365b2811269 100644
>> --- a/mm/gup.c
>> +++ b/mm/gup.c
>> @@ -2380,8 +2380,9 @@ static void __maybe_unused undo_dev_pagemap(int *nr, int nr_start,
>>   }
>>   
>>   #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>> -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>> -			 unsigned int flags, struct page **pages, int *nr)
>> +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>> +			 unsigned long end, unsigned int flags,
>> +			 struct page **pages, int *nr)
>>   {
>>   	struct dev_pagemap *pgmap = NULL;
>>   	int nr_start = *nr, ret = 0;
>> @@ -2423,7 +2424,23 @@ static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned long end,
>>   			goto pte_unmap;
>>   		}
>>   
>> -		if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>> +		/*
>> +		 * THP collapse conceptually does:
>> +		 *   1. Clear and flush PMD
>> +		 *   2. Check the base page refcount
>> +		 *   3. Copy data to huge page
>> +		 *   4. Clear PTE
>> +		 *   5. Discard the base page
>> +		 *
>> +		 * So fast GUP may race with THP collapse then pin and
>> +		 * return an old page since TLB flush is no longer sufficient
>> +		 * to serialize against fast GUP.
>> +		 *
>> +		 * Check PMD, if it is changed just back off since it
>> +		 * means there may be parallel THP collapse.
>> +		 */
> 
> As I mentioned in the other thread, it would be a nice touch to move
> such discussion into the comment header.
> 
>> +		if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
>> +		    unlikely(pte_val(pte) != pte_val(*ptep))) {
> 
> 
> That should be READ_ONCE() for the *pmdp and *ptep reads. Because this
> whole lockless house of cards may fall apart if we try reading the
> page table values without READ_ONCE().

I came to the conclusion that the implicit memory barrier when grabbing 
a reference on the page is sufficient such that we don't need READ_ONCE 
here.

If we still intend to change that code, we should fixup all GUP-fast 
functions in a similar way. But again, I don't think we need a change here.


>> -	 * After this gup_fast can't run anymore. This also removes
>> -	 * any huge TLB entry from the CPU so we won't allow
>> -	 * huge and small TLB entries for the same virtual address
>> -	 * to avoid the risk of CPU bugs in that area.
>> +	 * This removes any huge TLB entry from the CPU so we won't allow
>> +	 * huge and small TLB entries for the same virtual address to
>> +	 * avoid the risk of CPU bugs in that area.
>> +	 *
>> +	 * Parallel fast GUP is fine since fast GUP will back off when
>> +	 * it detects PMD is changed.
>>   	 */
>>   	_pmd = pmdp_collapse_flush(vma, address, pmd);
> 
> To follow up on David Hildenbrand's note about this in the nearby thread...
> I'm also not sure if pmdp_collapse_flush() implies a memory barrier on
> all arches. It definitely does do an atomic op with a return value on x86,
> but that's just one arch.
> 

I think a ptep/pmdp clear + TLB flush really has to imply a memory 
barrier, otherwise TLB flushing code might easily mess up with 
surrounding code. But we should better double-check.

s390x executes an IDTE instruction, which performs serialization (-> 
memory barrier). arm64 seems to use DSB instructions to enforce memory 
ordering.

-- 
Thanks,

David / dhildenb

