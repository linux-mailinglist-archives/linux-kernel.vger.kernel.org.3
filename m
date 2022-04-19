Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 901715072F3
	for <lists+linux-kernel@lfdr.de>; Tue, 19 Apr 2022 18:30:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354628AbiDSQcU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 12:32:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44194 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229538AbiDSQcS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 12:32:18 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 0E6DC289BB
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:29:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1650385774;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5DfINRDdhXkP4ETnLQBnkCvvjlr01rXpqh9mx4OBLIE=;
        b=OK3T6lqjSatwRD/5uBHESI9J1S2exZvI1vWl8tEmvjXSWuODnbzIeFjibDhV8T1uKUHaDT
        N4OO5CSnt02weSodi5CDvHtgXVQaq7q0ZPYxkFWh1Sd6zHuBZrjJ0bFxV6L+4GQ9TpHuGZ
        Fcos8xjuw1Ad7mIjiyThxw9T/APjt+Y=
Received: from mail-ej1-f70.google.com (mail-ej1-f70.google.com
 [209.85.218.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-654-bK_DcqgSP8WcXmKKZjcbGQ-1; Tue, 19 Apr 2022 12:29:30 -0400
X-MC-Unique: bK_DcqgSP8WcXmKKZjcbGQ-1
Received: by mail-ej1-f70.google.com with SMTP id mp18-20020a1709071b1200b006e7f314ecb3so6259646ejc.23
        for <linux-kernel@vger.kernel.org>; Tue, 19 Apr 2022 09:29:30 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=5DfINRDdhXkP4ETnLQBnkCvvjlr01rXpqh9mx4OBLIE=;
        b=dxJin2kXeac7BHefx3N+GqJwrywuOQ4M7cn6HOw/DZAxI+dRxcJ8HcP/Aq2fdhfSzo
         JPQWwnRF5v6I+hq8QPgAU2AVDEVv0lpGM5jca2ufJb7RPdpDFE4t8xKq6DTkoZQK0Qz9
         r7RC78RL5HVQ/EQxvi4mBaJUzn6JK2XTHdD3Cm6mL1K3x4OyZhdutVf2mJvJ6GQsVOsB
         /8kbUf6IkmcW6NsSCk0zTBni+8hvfQSjSbH4Hm5r4HdJm+ODgwrLnIS93mAG3ItrbFmH
         zSqORqVJvHiK6PMNjI4PnUd+gXVSnXA2/R9Tr6nPhOFI2tRKz5SpCQTIzntG6giQ/ikK
         2wbQ==
X-Gm-Message-State: AOAM533i8XUao0ssqGr0Fa/bX6xW7lbjgLSpbE1NBMP5hYeyMMmul8yy
        EAGHJyIxY5ugrimKJ6xxlBNp89fxNR9NQqkcZmrln/+wYgx8uBxcE0NMZTsSq33Zdf7LpIClu1H
        JVcV8wNqGc5pEVKkKEnj4xOa7
X-Received: by 2002:a05:6402:1691:b0:41d:6b0a:657d with SMTP id a17-20020a056402169100b0041d6b0a657dmr18478749edv.192.1650385769636;
        Tue, 19 Apr 2022 09:29:29 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJwamgE0FLRdBphf+ZM6UrkLzqNkK1a4km6/iSAlvUfstbr2FYphqKj6T9p9W7HMHApptH5OxQ==
X-Received: by 2002:a05:6402:1691:b0:41d:6b0a:657d with SMTP id a17-20020a056402169100b0041d6b0a657dmr18478729edv.192.1650385769407;
        Tue, 19 Apr 2022 09:29:29 -0700 (PDT)
Received: from ?IPV6:2003:cb:c704:5d00:d8c2:fbf6:a608:957a? (p200300cbc7045d00d8c2fbf6a608957a.dip0.t-ipconnect.de. [2003:cb:c704:5d00:d8c2:fbf6:a608:957a])
        by smtp.gmail.com with ESMTPSA id x1-20020a170906148100b006efa8a81a52sm2599923ejc.120.2022.04.19.09.29.27
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Tue, 19 Apr 2022 09:29:28 -0700 (PDT)
Message-ID: <c003964a-9fa1-b17c-158a-8ccbf4ff8656@redhat.com>
Date:   Tue, 19 Apr 2022 18:29:26 +0200
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v3 14/16] mm: support GUP-triggered unsharing of anonymous
 pages
Content-Language: en-US
To:     Vlastimil Babka <vbabka@suse.cz>, linux-kernel@vger.kernel.org
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
        Jann Horn <jannh@google.com>, Michal Hocko <mhocko@kernel.org>,
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
References: <20220329160440.193848-1-david@redhat.com>
 <20220329160440.193848-15-david@redhat.com>
 <9005b167-db08-c967-463b-5e0e092cbb6c@suse.cz>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <9005b167-db08-c967-463b-5e0e092cbb6c@suse.cz>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-6.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_LOW,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 14.04.22 19:15, Vlastimil Babka wrote:
> On 3/29/22 18:04, David Hildenbrand wrote:
>> Whenever GUP currently ends up taking a R/O pin on an anonymous page that
>> might be shared -- mapped R/O and !PageAnonExclusive() -- any write fault
>> on the page table entry will end up replacing the mapped anonymous page
>> due to COW, resulting in the GUP pin no longer being consistent with the
>> page actually mapped into the page table.
>>
>> The possible ways to deal with this situation are:
>>  (1) Ignore and pin -- what we do right now.
>>  (2) Fail to pin -- which would be rather surprising to callers and
>>      could break user space.
>>  (3) Trigger unsharing and pin the now exclusive page -- reliable R/O
>>      pins.
>>
>> We want to implement 3) because it provides the clearest semantics and
>> allows for checking in unpin_user_pages() and friends for possible BUGs:
>> when trying to unpin a page that's no longer exclusive, clearly
>> something went very wrong and might result in memory corruptions that
>> might be hard to debug. So we better have a nice way to spot such
>> issues.
>>
>> To implement 3), we need a way for GUP to trigger unsharing:
>> FAULT_FLAG_UNSHARE. FAULT_FLAG_UNSHARE is only applicable to R/O mapped
>> anonymous pages and resembles COW logic during a write fault. However, in
>> contrast to a write fault, GUP-triggered unsharing will, for example, still
>> maintain the write protection.
>>
>> Let's implement FAULT_FLAG_UNSHARE by hooking into the existing write fault
>> handlers for all applicable anonymous page types: ordinary pages, THP and
>> hugetlb.
>>
>> * If FAULT_FLAG_UNSHARE finds a R/O-mapped anonymous page that has been
>>   marked exclusive in the meantime by someone else, there is nothing to do.
>> * If FAULT_FLAG_UNSHARE finds a R/O-mapped anonymous page that's not
>>   marked exclusive, it will try detecting if the process is the exclusive
>>   owner. If exclusive, it can be set exclusive similar to reuse logic
>>   during write faults via page_move_anon_rmap() and there is nothing
>>   else to do; otherwise, we either have to copy and map a fresh,
>>   anonymous exclusive page R/O (ordinary pages, hugetlb), or split the
>>   THP.
>>
>> This commit is heavily based on patches by Andrea.
>>
>> Co-developed-by: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: Andrea Arcangeli <aarcange@redhat.com>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
> 
> Acked-by: Vlastimil Babka <vbabka@suse.cz>
> 
> Modulo a nit and suspected logical bug below.

Thanks!

>> @@ -4515,8 +4550,11 @@ static inline vm_fault_t create_huge_pmd(struct vm_fault *vmf)
>>  /* `inline' is required to avoid gcc 4.1.2 build error */
>>  static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
>>  {
>> +	const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
>> +
>>  	if (vma_is_anonymous(vmf->vma)) {
>> -		if (userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
>> +		if (unlikely(unshare) &&
> 
> Is this condition flipped, should it be "likely(!unshare)"? As the similar
> code in do_wp_page() does.

Good catch, this should affect uffd-wp on THP -- it wouldn't trigger as expected. Thanks a lot for finding that!

> 
>> +		    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
>>  			return handle_userfault(vmf, VM_UFFD_WP);
>>  		return do_huge_pmd_wp_page(vmf);
>>  	}
>> @@ -4651,10 +4689,11 @@ static vm_fault_t handle_pte_fault(struct vm_fault *vmf)
>>  		update_mmu_tlb(vmf->vma, vmf->address, vmf->pte);
>>  		goto unlock;
>>  	}
>> -	if (vmf->flags & FAULT_FLAG_WRITE) {
>> +	if (vmf->flags & (FAULT_FLAG_WRITE|FAULT_FLAG_UNSHARE)) {
>>  		if (!pte_write(entry))
>>  			return do_wp_page(vmf);
>> -		entry = pte_mkdirty(entry);
>> +		else if (likely(vmf->flags & FAULT_FLAG_WRITE))
>> +			entry = pte_mkdirty(entry);
>>  	}
>>  	entry = pte_mkyoung(entry);
>>  	if (ptep_set_access_flags(vmf->vma, vmf->address, vmf->pte, entry,
> 


So the following on top, right?


diff --git a/mm/memory.c b/mm/memory.c
index 8b3cb73f5e44..4584c7e87a70 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3137,7 +3137,7 @@ static vm_fault_t wp_page_copy(struct vm_fault *vmf)
                        free_swap_cache(old_page);
                put_page(old_page);
        }
-       return page_copied && !unshare ? VM_FAULT_WRITE : 0;
+       return (page_copied && !unshare) ? VM_FAULT_WRITE : 0;
 oom_free_new:
        put_page(new_page);
 oom:
@@ -4604,7 +4604,7 @@ static inline vm_fault_t wp_huge_pmd(struct vm_fault *vmf)
        const bool unshare = vmf->flags & FAULT_FLAG_UNSHARE;
 
        if (vma_is_anonymous(vmf->vma)) {
-               if (unlikely(unshare) &&
+               if (likely(!unshare) &&
                    userfaultfd_huge_pmd_wp(vmf->vma, vmf->orig_pmd))
                        return handle_userfault(vmf, VM_UFFD_WP);
                return do_huge_pmd_wp_page(vmf);


-- 
Thanks,

David / dhildenb

