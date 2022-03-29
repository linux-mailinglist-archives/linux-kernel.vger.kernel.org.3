Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 931964EB4F2
	for <lists+linux-kernel@lfdr.de>; Tue, 29 Mar 2022 22:57:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232624AbiC2U46 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 29 Mar 2022 16:56:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232599AbiC2U4y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 29 Mar 2022 16:56:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id B0579B1ABE
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:55:09 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1648587308;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=e9prqv3sLrb2nHVYFNlrQEoqAWhCBkFnosz374taqY0=;
        b=cX8q/ToUHdDK4SyKBde3KuQ4WTZJHzYVedkBCEHJvZBhphgtX42Jykei+LRqj8T2Yfe+hS
        sKgnAbLCD1pNV5Fl5rlcHL/u3wF36B8xgK8nC3bmu1zeubXBEC/Px9wKNrjX9Of9Fbn6e6
        B+uIR6ec9QwbNddTuOwSh1LRGvVWm7k=
Received: from mail-wm1-f71.google.com (mail-wm1-f71.google.com
 [209.85.128.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-583-LaERkl61NIem-WpqsRYkKg-1; Tue, 29 Mar 2022 16:55:07 -0400
X-MC-Unique: LaERkl61NIem-WpqsRYkKg-1
Received: by mail-wm1-f71.google.com with SMTP id q186-20020a1c43c3000000b0038ce534d9e2so5384852wma.0
        for <linux-kernel@vger.kernel.org>; Tue, 29 Mar 2022 13:55:07 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=e9prqv3sLrb2nHVYFNlrQEoqAWhCBkFnosz374taqY0=;
        b=zRNvXL1MKi5wersv3AsKyHvoIaoJa3lpva3PTXmsmpf3Njl5x6kYihjIh3A69zvL0i
         pK5oDZMI0Ty5atNarg8zu5wGrzeKZt6uE8wGlhGY21g5bGn/N1nA/bbBDLJpKKxuuhzV
         vO92tpCXzREKgaNKCiRDfob0NT1MQfVCx5Qhi+PImA7PvzWTil2qvBwKsZNJeTpklnWI
         iYEQ4xb2fh2Ey/fPUDcKqbfd/BQspb+iAIBn6JzW4jbeJgjfbE6PvAPQ4jElxoAovZgl
         iUPkYI/Zvno8Yo0+yPWCRHuRxb52yIKJxP8HGOmKe3xq/09cNscI6pBblmgvag2ft07r
         Egsg==
X-Gm-Message-State: AOAM530AFoCuRbXonnOr3O/OD7rAPoD6+8s7Sg8N85DaECtLJfwbof/d
        7aMKdeK+SgiW0D2CvYpC5DzMmFHy3ZhG3cq5O9/ArumfchWIxIJoOp7+7dQbhXHrN4grIaYFdFy
        sWrHV8oVtW0hED7NN3/t1RuAE
X-Received: by 2002:a5d:43d2:0:b0:204:5f97:d003 with SMTP id v18-20020a5d43d2000000b002045f97d003mr34200480wrr.417.1648587306097;
        Tue, 29 Mar 2022 13:55:06 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwQ0oo38c3JdMOTHM0L5sTBmpbmX6iEHiESq0hozhnmU6VejvkingkAddMYKlNw2MIAKJYznQ==
X-Received: by 2002:a5d:43d2:0:b0:204:5f97:d003 with SMTP id v18-20020a5d43d2000000b002045f97d003mr34200467wrr.417.1648587305820;
        Tue, 29 Mar 2022 13:55:05 -0700 (PDT)
Received: from ?IPV6:2003:cb:c708:af00:7a8a:46df:a7c3:c4c7? (p200300cbc708af007a8a46dfa7c3c4c7.dip0.t-ipconnect.de. [2003:cb:c708:af00:7a8a:46df:a7c3:c4c7])
        by smtp.gmail.com with ESMTPSA id z13-20020a5d440d000000b00203f2b010b1sm15631407wrq.44.2022.03.29.13.55.04
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 29 Mar 2022 13:55:05 -0700 (PDT)
Message-ID: <b46a5be4-27a0-6ab6-0f98-658ca82339db@redhat.com>
Date:   Tue, 29 Mar 2022 22:55:03 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Khalid Aziz <khalid.aziz@oracle.com>, linux-kernel@vger.kernel.org
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Liang Zhang <zhangliang5@huawei.com>,
        Pedro Gomes <pedrodemargomes@gmail.com>,
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org
References: <20220315104741.63071-1-david@redhat.com>
 <20220315104741.63071-2-david@redhat.com>
 <d98bd1f9-e9b7-049c-7bde-3348b074eb18@redhat.com>
 <909cc1b6-6f4f-4c45-f418-31d5dd5acaa3@oracle.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 01/15] mm/rmap: fix missing swap_free() in
 try_to_unmap() after arch_unmap_one() failed
In-Reply-To: <909cc1b6-6f4f-4c45-f418-31d5dd5acaa3@oracle.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 29.03.22 22:42, Khalid Aziz wrote:
> On 3/29/22 07:59, David Hildenbrand wrote:
>> On 15.03.22 11:47, David Hildenbrand wrote:
>>> In case arch_unmap_one() fails, we already did a swap_duplicate(). let's
>>> undo that properly via swap_free().
>>>
>>> Fixes: ca827d55ebaa ("mm, swap: Add infrastructure for saving page metadata on swap")
>>> Reviewed-by: Khalid Aziz <khalid.aziz@oracle.com>
>>> Signed-off-by: David Hildenbrand <david@redhat.com>
>>> ---
>>>   mm/rmap.c | 1 +
>>>   1 file changed, 1 insertion(+)
>>>
>>> diff --git a/mm/rmap.c b/mm/rmap.c
>>> index 6a1e8c7f6213..f825aeef61ca 100644
>>> --- a/mm/rmap.c
>>> +++ b/mm/rmap.c
>>> @@ -1625,6 +1625,7 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>>   				break;
>>>   			}
>>>   			if (arch_unmap_one(mm, vma, address, pteval) < 0) {
>>> +				swap_free(entry);
>>>   				set_pte_at(mm, address, pvmw.pte, pteval);
>>>   				ret = false;
>>>   				page_vma_mapped_walk_done(&pvmw);
>>
>> Hi Khalid,
>>
>> I'm a bit confused about the semantics if arch_unmap_one(), I hope you can clarify.
>>
>>
>> See patch #11 in this series, were we can fail unmapping after arch_unmap_one() succeeded. E.g.,
>>
>> @@ -1623,6 +1634,24 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
>>   				page_vma_mapped_walk_done(&pvmw);
>>   				break;
>>   			}
>> +			if (anon_exclusive &&
>> +			    page_try_share_anon_rmap(subpage)) {
>> +				swap_free(entry);
>> +				set_pte_at(mm, address, pvmw.pte, pteval);
>> +				ret = false;
>> +				page_vma_mapped_walk_done(&pvmw);
>> +				break;
>> +			}
>> +			/*
>> +			 * Note: We don't remember yet if the page was mapped
>> +			 * exclusively in the swap entry, so swapin code has
>> +			 * to re-determine that manually and might detect the
>> +			 * page as possibly shared, for example, if there are
>> +			 * other references on the page or if the page is under
>> +			 * writeback. We made sure that there are no GUP pins
>> +			 * on the page that would rely on it, so for GUP pins
>> +			 * this is fine.
>> +			 */
>>   			if (list_empty(&mm->mmlist)) {
>>   				spin_lock(&mmlist_lock);
>>   				if (list_empty(&mm->mmlist))
>>
>>
>> For now, I was under the impression that we don't have to undo anything after
>> arch_unmap_one() succeeded, because we seem to not do anything for two
>> cases below. But looking into arch_unmap_one() and how it allocates stuff I do
>> wonder what we would actually want to do here -- I'd assume we'd want to
>> trigger the del_tag_store() somehow?
> 
> Hi David,
> 

Hi,

thanks for your fast reply.

> Currently once arch_unmap_one() completes successfully, we are at the point of no return for this pte. It will be 
> replaced by swap pte soon thereafter. Patch 11 adds another case where we may return without replacing current pte with 
> swap pte. For now could you resolve this by moving the above code block in patch 11 to before the call to 
> arch_unmap_one(). That still leaves open the issue having the flexibility of undoing what arch_unmap_one() does for some 
> other reason in future. That will require coming up with a properly architected way to do it.

I really want clearing PG_anon_exclusive be the last action, without
eventually having to set it again and overcomplicating
PG_anon_exclusive/rmap handling. Ideally, we'd have a "arch_remap_one()"
that just reverts what arch_unmap_one() did.

> 
>>
>> arch_unmap_one() calls adi_save_tags(), which allocates memory.
>> adi_restore_tags()->del_tag_store() reverts that operation and ends up
>> freeing memory conditionally; However, it's only
>> called from arch_do_swap_page().
>>
>>
>> Here is why I have to scratch my head:
>>
>> a) arch_do_swap_page() is only called from do_swap_page(). We don't do anything similar
>> for mm/swapfile.c:unuse_pte(), aren't we missing something?
> 
> My understanding of this code path maybe flawed, so do correct me if this does not sound right. unused_pte() is called 
> upon user turning off swap on a device. unused_pte() is called by unused_pte_range() which swaps the page back in from 
> swap device before calling unuse_pte(). Once the page is read back in from swap, ultimately access to the va for the 
> page will result in call to __handle_mm_fault() which in turn will call handle_pte_fault() to insert a new pte for this 
> mapping and handle_pte_fault() will call arch_do_swap_page() which will restore the tags.

unuse_pte() will replace a swap pte directly by a proper, present pte,
just like do_swap_page() would. You won't end up in do_swap_page()
anymore and arch_do_swap_page() won't be called, because there is no
swap PTE anymore.

> 
>>
>> b) try_to_migrate_one() does the arch_unmap_one(), but who will do the
>> restore+free after migration succeeded or failed, aren't we missing something?
> 
> try_to_migrate_one() replaces the current pte with a migration pte after calling arch_unmap_one(). This causes 
> __handle_mm_fault() to be called when a reference to the va covered by migration pte is made. This will in turn finally 
> result in a call to arch_do_swap_page() which restores the tags.

Migration PTEs are restore via mm/migrate.c:remove_migration_ptes().
arch_do_swap_page() won't be called.

What you mention is if someone accesses the migration PTE while
migration is active and the migration PTEs have not been removed yet.
While we'll end up in do_swap_page(), we'll do a migration_entry_wait(),
followed by an effective immediate "return 0;". arch_do_swap_page()
won't get called.


So in essence, I think this doesn't work as expected yet. In the best
case we don't immediately free memory. In the worst case we lose the tags.

-- 
Thanks,

David / dhildenb

