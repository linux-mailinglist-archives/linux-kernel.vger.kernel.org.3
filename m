Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6070358AE2D
	for <lists+linux-kernel@lfdr.de>; Fri,  5 Aug 2022 18:29:52 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241469AbiHEQ3n (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 5 Aug 2022 12:29:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59402 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241330AbiHEQ31 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 5 Aug 2022 12:29:27 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 661B7753AC
        for <linux-kernel@vger.kernel.org>; Fri,  5 Aug 2022 09:29:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659716965;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=O1CTGsepbWky42F1RTyXU8gWqoR/QXpIkPCqa2oyjX8=;
        b=aXvjaJyLTLsLWZYHy0zC8aPCt1KsDIqZl26FFxPLPEIvY8R8ciiVZg0qKP9uIHhwgXWw+Y
        L0dbQkAQD1zUk746U45/6A2MLX3rIltN15P4eXHE7ZRLM7f8WAP8TjPyO1ft+UkaqttC2h
        7gONttD0qHj1Wx+LlYRskR0uoJ5MsNs=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-321-ueNZDC8lPCW2W3-DDWq09w-1; Fri, 05 Aug 2022 12:29:16 -0400
X-MC-Unique: ueNZDC8lPCW2W3-DDWq09w-1
Received: by mail-wr1-f72.google.com with SMTP id e14-20020adfa44e000000b0021f15a9f984so615233wra.20
        for <linux-kernel@vger.kernel.org>; Fri, 05 Aug 2022 09:29:16 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:in-reply-to:subject:organization:from
         :references:cc:to:content-language:user-agent:mime-version:date
         :message-id:x-gm-message-state:from:to:cc;
        bh=O1CTGsepbWky42F1RTyXU8gWqoR/QXpIkPCqa2oyjX8=;
        b=vqs1KuXwayFx1VbW3UjKl8wbVeJPqhwe2efnLLY2KjLy0VMrK56GzioF1P6evwG/nu
         ICvIaV2kaIlNGInYZDZb1hyLf30aEOaOfptLgtyNBfLtVwR4Lg0bdfoAXIZukqYEI1ES
         G8DqSCb6wfM2h8LI7x+drLXmXTTrPqi/M1HYfcQgq+oJPCFkqmYcKjZWZcSowbdxVbUd
         LSfhN7ELkVbPZgH1lyM3ByD6okpPI6pPx2gcKWmZhTze9HrCwrrJMYlMdFlrffGBs1qI
         +RWtzOTuGWIzAqtWIi5vqVnFlOAdiTIi4rdr5cgOcHaKtIipJmsD5qHVOzT6EEnLZCGI
         TLSA==
X-Gm-Message-State: ACgBeo06GFFyVt705Ky6pBhdhvPfZtlcyA7lzIMADjYTSJHvsx/edDrt
        8XVomccFPF+sRuaLCOuo2cFt6GJayig9UBQsEpV3Z36ryCkDz/4Jzuww1SqntgeycOFrM71G9p5
        j7tvhwkz46Y7x0rraLO5sCovQ
X-Received: by 2002:a5d:6b10:0:b0:21e:4bbd:e893 with SMTP id v16-20020a5d6b10000000b0021e4bbde893mr4876975wrw.613.1659716955715;
        Fri, 05 Aug 2022 09:29:15 -0700 (PDT)
X-Google-Smtp-Source: AA6agR6gSfiuOmIzGGnakz5kqQKANQjqtdgDGvfuY8GUxyjWL663RBOrC690GnTBbkDorGJ4vk59Ig==
X-Received: by 2002:a5d:6b10:0:b0:21e:4bbd:e893 with SMTP id v16-20020a5d6b10000000b0021e4bbde893mr4876944wrw.613.1659716955386;
        Fri, 05 Aug 2022 09:29:15 -0700 (PDT)
Received: from ?IPV6:2003:cb:c706:fb00:f5c3:24b2:3d03:9d52? (p200300cbc706fb00f5c324b23d039d52.dip0.t-ipconnect.de. [2003:cb:c706:fb00:f5c3:24b2:3d03:9d52])
        by smtp.gmail.com with ESMTPSA id j20-20020a05600c485400b003a3561d4f3fsm4498609wmo.43.2022.08.05.09.28.55
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 05 Aug 2022 09:29:09 -0700 (PDT)
Message-ID: <e0d9b4c4-1195-730a-5838-08c10905adaf@redhat.com>
Date:   Fri, 5 Aug 2022 18:28:41 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.11.0
Content-Language: en-US
To:     Mike Kravetz <mike.kravetz@oracle.com>,
        Miaohe Lin <linmiaohe@huawei.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Muchun Song <songmuchun@bytedance.com>,
        Michal Hocko <mhocko@suse.com>, Peter Xu <peterx@redhat.com>,
        Naoya Horiguchi <naoya.horiguchi@linux.dev>,
        "Aneesh Kumar K . V" <aneesh.kumar@linux.vnet.ibm.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Davidlohr Bueso <dave@stgolabs.net>,
        Prakash Sangappa <prakash.sangappa@oracle.com>,
        James Houghton <jthoughton@google.com>,
        Mina Almasry <almasrymina@google.com>,
        Pasha Tatashin <pasha.tatashin@soleen.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Ray Fucillo <Ray.Fucillo@intersystems.com>,
        Andrew Morton <akpm@linux-foundation.org>
References: <20220706202347.95150-1-mike.kravetz@oracle.com>
 <20220706202347.95150-5-mike.kravetz@oracle.com>
 <ee6af38d-f797-a64f-e5c4-78bad3753aca@huawei.com> <YuGLT+RlCynFM9Z4@monkey>
 <ae24c722-0b4a-def4-8cfe-e8b3b48a22c6@huawei.com> <YuK9KqTLqEGavv7N@monkey>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [RFC PATCH v4 4/8] hugetlbfs: catch and handle truncate racing
 with page faults
In-Reply-To: <YuK9KqTLqEGavv7N@monkey>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 28.07.22 18:45, Mike Kravetz wrote:
> On 07/28/22 10:02, Miaohe Lin wrote:
>> On 2022/7/28 3:00, Mike Kravetz wrote:
>>> On 07/27/22 17:20, Miaohe Lin wrote:
>>>> On 2022/7/7 4:23, Mike Kravetz wrote:
>>>>> Most hugetlb fault handling code checks for faults beyond i_size.
>>>>> While there are early checks in the code paths, the most difficult
>>>>> to handle are those discovered after taking the page table lock.
>>>>> At this point, we have possibly allocated a page and consumed
>>>>> associated reservations and possibly added the page to the page cache.
>>>>>
>>>>> When discovering a fault beyond i_size, be sure to:
>>>>> - Remove the page from page cache, else it will sit there until the
>>>>>   file is removed.
>>>>> - Do not restore any reservation for the page consumed.  Otherwise
>>>>>   there will be an outstanding reservation for an offset beyond the
>>>>>   end of file.
>>>>>
>>>>> The 'truncation' code in remove_inode_hugepages must deal with fault
>>>>> code potentially removing a page/folio from the cache after the page was
>>>>> returned by filemap_get_folios and before locking the page.  This can be
>>>>> discovered by a change in folio_mapping() after taking folio lock.  In
>>>>> addition, this code must deal with fault code potentially consuming
>>>>> and returning reservations.  To synchronize this, remove_inode_hugepages
>>>>> will now take the fault mutex for ALL indices in the hole or truncated
>>>>> range.  In this way, it KNOWS fault code has finished with the page/index
>>>>> OR fault code will see the updated file size.
>>>>>
>>>>> Signed-off-by: Mike Kravetz <mike.kravetz@oracle.com>
>>>>> ---
>>>>
>>>> <snip>
>>>>
>>>>> @@ -5606,8 +5610,10 @@ static vm_fault_t hugetlb_no_page(struct mm_struct *mm,
>>>>>  
>>>>>  	ptl = huge_pte_lock(h, mm, ptep);
>>>>>  	size = i_size_read(mapping->host) >> huge_page_shift(h);
>>>>> -	if (idx >= size)
>>>>> +	if (idx >= size) {
>>>>> +		beyond_i_size = true;
>>>>
>>>> Thanks for your patch. There is one question:
>>>>
>>>> Since races between hugetlb pagefault and truncate is guarded by hugetlb_fault_mutex,
>>>> do we really need to check it again after taking the page table lock?
>>>>
>>>
>>> Well, the fault mutex can only guard a single hugetlb page.  The fault mutex
>>> is actually an array/table of mutexes hashed by mapping address and file index.
>>> So, during truncation we take take the mutex for each page as they are
>>> unmapped and removed.  So, the fault mutex only synchronizes operations
>>> on one specific page.  The idea with this patch is to coordinate the fault
>>> code and truncate code when operating on the same page.
>>>
>>> In addition, changing the file size happens early in the truncate process
>>> before taking any locks/mutexes.
>>
>> I wonder whether we can somewhat live with it to make code simpler. When changing the file size happens
>> after checking i_size but before taking the page table lock in hugetlb_fault, the truncate code would
>> remove the hugetlb page from the page cache for us after hugetlb_fault finishes if we don't roll back
>> when checking i_size again under the page table lock?
>>
>> In a word, if hugetlb_fault see a truncated inode, back out early. If not, let truncate code does its
>> work. So we don't need to complicate the already complicated error path. Or am I miss something?
>>
> 
> Thank you! I believe your observations and suggestions are correct.
> 
> We can just let the fault code proceed after the early "idx >= size",
> and let the truncation code remove the page.  This also eliminates the
> need for patch 3 (hugetlbfs: move routine remove_huge_page to hugetlb.c).

At least remaining the functions would be very welcome nonetheless :)

> 
> I will make these changes in the next version.

Just so I understand correctly, we want to let fault handling code back
out early if we find any incompatible change, and simply retry the
fault? I'm thinking about some kind of a high-level seqcount.

-- 
Thanks,

David / dhildenb

