Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D1EA15AD149
	for <lists+linux-kernel@lfdr.de>; Mon,  5 Sep 2022 13:18:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236692AbiIELMI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 07:12:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41564 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238250AbiIELLt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 07:11:49 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 444CE5AC4D
        for <linux-kernel@vger.kernel.org>; Mon,  5 Sep 2022 04:11:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1662376305;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=/9Cvtrw/U3C3PcZffSYCQWLqBd8d9T5JEME0S1hKNLk=;
        b=aqS2woR9lsTJ60Ih7bZDl81mQq7GmUII3Rp1ZZOf0UWf0zNRyAYuxK9+SB0I2ZsOS8ALGp
        P3zCAiG+yob6YHfTd0RzIJswir7PH/S2jtDOWrHJYvzgKZZUwVdx5T5s0V3hNGk43sont2
        A5baWphVtXiu4b6vYAyENxKoqsM42P0=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.3, cipher=TLS_AES_128_GCM_SHA256) id
 us-mta-513-4DW1PIdZPCi-wYIv7B1saQ-1; Mon, 05 Sep 2022 07:11:43 -0400
X-MC-Unique: 4DW1PIdZPCi-wYIv7B1saQ-1
Received: by mail-wm1-f72.google.com with SMTP id h133-20020a1c218b000000b003a5fa79008bso7313739wmh.5
        for <linux-kernel@vger.kernel.org>; Mon, 05 Sep 2022 04:11:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:organization:references:cc:to
         :from:content-language:subject:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc:subject:date;
        bh=/9Cvtrw/U3C3PcZffSYCQWLqBd8d9T5JEME0S1hKNLk=;
        b=M5dAk8Ttm99u/s2L0E0kM2Yc2uqprWByqHA6PTw9RRA693xin3xDXzT0Aa3h3MNhfO
         ssdh9LEgOZPF/BCRpyeASP8uUF01zINZRBTeTWbPZJn1Mxw1x6VZfjSEuel4WLkomv3O
         n3zMW5VA5Tld5NYp2wbGbZn1Gj87JQ9jJFzlPs8f51QvcEBE1yQMoQ6Z5McJ4oxVhPzS
         5aHHHkegKf8LXV18MnahDAJcb0PFWKb34qxpV4W0DWNjgqgoI8Pct2FUsKujKSdhsoVY
         OIthQjJgwK+1jc2sAgZ6a3KcL0KiHNAoFJpx6nkVvrGRnqzePTajxdUl6ROhHDHrEKlu
         q6yQ==
X-Gm-Message-State: ACgBeo03+PpEkpGvjREECyhS+X/KaCIeHC+XPYxbZ0Wuvr4/lPqTYmD7
        HNwDV9JeQK1Fq2DEYTi+TDOPnWzeaNS31aRtZAMjgyaSwqvX0vnx4qAkA423k5rDSBcEP7X/xSk
        IHgCFuiXjR17viWbR8bK/WVlY
X-Received: by 2002:a5d:5407:0:b0:228:a79b:4432 with SMTP id g7-20020a5d5407000000b00228a79b4432mr1536887wrv.96.1662376301998;
        Mon, 05 Sep 2022 04:11:41 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6F7nD49xRoK7hZXeL9vTPJlS8kXvvv7EvTNB1WIlh8ZYBXAJKS/gT0AlixZTaK7FaHas63tQ==
X-Received: by 2002:a5d:5407:0:b0:228:a79b:4432 with SMTP id g7-20020a5d5407000000b00228a79b4432mr1536869wrv.96.1662376301662;
        Mon, 05 Sep 2022 04:11:41 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0? (p200300d82f0dba00c95131d7b2b08ba0.dip0.t-ipconnect.de. [2003:d8:2f0d:ba00:c951:31d7:b2b0:8ba0])
        by smtp.gmail.com with ESMTPSA id a6-20020a056000050600b0021e519eba9bsm8611739wrf.42.2022.09.05.04.11.40
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 05 Sep 2022 04:11:41 -0700 (PDT)
Message-ID: <a7dd4376-bce2-ee79-623f-fa11d301b80d@redhat.com>
Date:   Mon, 5 Sep 2022 13:11:40 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:102.0) Gecko/20100101
 Thunderbird/102.2.0
Subject: Re: [PATCH] mm: gup: fix the fast GUP race against THP collapse
Content-Language: en-US
From:   David Hildenbrand <david@redhat.com>
To:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Yang Shi <shy828301@gmail.com>, peterx@redhat.com,
        kirill.shutemov@linux.intel.com, jgg@nvidia.com, hughd@google.com,
        akpm@linux-foundation.org
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org
References: <20220901222707.477402-1-shy828301@gmail.com>
 <e6ad1084-c301-9f11-1fa7-7614bf859aaf@nvidia.com>
 <a969abc5-1ad0-4073-a1f9-82f0431a0104@redhat.com>
 <0c9d9774-77dd-fd93-b5b6-fc63f3d01b7f@linux.alibaba.com>
 <383fec21-9801-9b60-7570-856da2133ea9@redhat.com>
Organization: Red Hat
In-Reply-To: <383fec21-9801-9b60-7570-856da2133ea9@redhat.com>
Content-Type: text/plain; charset=UTF-8; format=flowed
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 05.09.22 12:24, David Hildenbrand wrote:
> On 05.09.22 12:16, Baolin Wang wrote:
>>
>>
>> On 9/5/2022 3:59 PM, David Hildenbrand wrote:
>>> On 05.09.22 00:29, John Hubbard wrote:
>>>> On 9/1/22 15:27, Yang Shi wrote:
>>>>> Since general RCU GUP fast was introduced in commit 2667f50e8b81 ("mm:
>>>>> introduce a general RCU get_user_pages_fast()"), a TLB flush is no
>>>>> longer
>>>>> sufficient to handle concurrent GUP-fast in all cases, it only handles
>>>>> traditional IPI-based GUP-fast correctly.  On architectures that send
>>>>> an IPI broadcast on TLB flush, it works as expected.  But on the
>>>>> architectures that do not use IPI to broadcast TLB flush, it may have
>>>>> the below race:
>>>>>
>>>>>       CPU A                                          CPU B
>>>>> THP collapse                                     fast GUP
>>>>>                                                  gup_pmd_range() <--
>>>>> see valid pmd
>>>>>                                                      gup_pte_range()
>>>>> <-- work on pte
>>>>> pmdp_collapse_flush() <-- clear pmd and flush
>>>>> __collapse_huge_page_isolate()
>>>>>        check page pinned <-- before GUP bump refcount
>>>>>                                                          pin the page
>>>>>                                                          check PTE <--
>>>>> no change
>>>>> __collapse_huge_page_copy()
>>>>>        copy data to huge page
>>>>>        ptep_clear()
>>>>> install huge pmd for the huge page
>>>>>                                                          return the
>>>>> stale page
>>>>> discard the stale page
>>>>
>>>> Hi Yang,
>>>>
>>>> Thanks for taking the trouble to write down these notes. I always
>>>> forget which race we are dealing with, and this is a great help. :)
>>>>
>>>> More...
>>>>
>>>>>
>>>>> The race could be fixed by checking whether PMD is changed or not after
>>>>> taking the page pin in fast GUP, just like what it does for PTE.  If the
>>>>> PMD is changed it means there may be parallel THP collapse, so GUP
>>>>> should back off.
>>>>>
>>>>> Also update the stale comment about serializing against fast GUP in
>>>>> khugepaged.
>>>>>
>>>>> Fixes: 2667f50e8b81 ("mm: introduce a general RCU
>>>>> get_user_pages_fast()")
>>>>> Signed-off-by: Yang Shi <shy828301@gmail.com>
>>>>> ---
>>>>>     mm/gup.c        | 30 ++++++++++++++++++++++++------
>>>>>     mm/khugepaged.c | 10 ++++++----
>>>>>     2 files changed, 30 insertions(+), 10 deletions(-)
>>>>>
>>>>> diff --git a/mm/gup.c b/mm/gup.c
>>>>> index f3fc1f08d90c..4365b2811269 100644
>>>>> --- a/mm/gup.c
>>>>> +++ b/mm/gup.c
>>>>> @@ -2380,8 +2380,9 @@ static void __maybe_unused undo_dev_pagemap(int
>>>>> *nr, int nr_start,
>>>>>     }
>>>>>     #ifdef CONFIG_ARCH_HAS_PTE_SPECIAL
>>>>> -static int gup_pte_range(pmd_t pmd, unsigned long addr, unsigned
>>>>> long end,
>>>>> -             unsigned int flags, struct page **pages, int *nr)
>>>>> +static int gup_pte_range(pmd_t pmd, pmd_t *pmdp, unsigned long addr,
>>>>> +             unsigned long end, unsigned int flags,
>>>>> +             struct page **pages, int *nr)
>>>>>     {
>>>>>         struct dev_pagemap *pgmap = NULL;
>>>>>         int nr_start = *nr, ret = 0;
>>>>> @@ -2423,7 +2424,23 @@ static int gup_pte_range(pmd_t pmd, unsigned
>>>>> long addr, unsigned long end,
>>>>>                 goto pte_unmap;
>>>>>             }
>>>>> -        if (unlikely(pte_val(pte) != pte_val(*ptep))) {
>>>>> +        /*
>>>>> +         * THP collapse conceptually does:
>>>>> +         *   1. Clear and flush PMD
>>>>> +         *   2. Check the base page refcount
>>>>> +         *   3. Copy data to huge page
>>>>> +         *   4. Clear PTE
>>>>> +         *   5. Discard the base page
>>>>> +         *
>>>>> +         * So fast GUP may race with THP collapse then pin and
>>>>> +         * return an old page since TLB flush is no longer sufficient
>>>>> +         * to serialize against fast GUP.
>>>>> +         *
>>>>> +         * Check PMD, if it is changed just back off since it
>>>>> +         * means there may be parallel THP collapse.
>>>>> +         */
>>>>
>>>> As I mentioned in the other thread, it would be a nice touch to move
>>>> such discussion into the comment header.
>>>>
>>>>> +        if (unlikely(pmd_val(pmd) != pmd_val(*pmdp)) ||
>>>>> +            unlikely(pte_val(pte) != pte_val(*ptep))) {
>>>>
>>>>
>>>> That should be READ_ONCE() for the *pmdp and *ptep reads. Because this
>>>> whole lockless house of cards may fall apart if we try reading the
>>>> page table values without READ_ONCE().
>>>
>>> I came to the conclusion that the implicit memory barrier when grabbing
>>> a reference on the page is sufficient such that we don't need READ_ONCE
>>> here.
>>
>> IMHO the compiler may optimize the code 'pte_val(*ptep)' to be always
>> get from a register, then we can get an old value if other thread did
>> set_pte(). I am not sure how the implicit memory barrier can pervent the
>> compiler optimization? Please correct me if I missed something.
> 
> IIUC, an memory barrier always implies a compiler barrier.
> 

To clarify what I mean, Documentation/atomic_t.txt documents

NOTE: when the atomic RmW ops are fully ordered, they should also imply 
a compiler barrier.

-- 
Thanks,

David / dhildenb

