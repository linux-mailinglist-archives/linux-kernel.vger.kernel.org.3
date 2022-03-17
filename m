Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 82D9D4DC221
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 10:00:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231638AbiCQJBg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 05:01:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33262 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231650AbiCQJBe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 05:01:34 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 8DDDB1D08DD
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:00:16 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647507615;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=CEdqsAQgxWBE6LqF2BTOKci65noXcTnmAaK4eVtIxl8=;
        b=cqA7eclLj0kE/uEw04ztWUYKLIftR2ouHKcBRhI21BzNiiV1asUDQFp0bEaNtaJ7AuYcn2
        lkvUP4CqExnYhDclvmXaexRsr5X3mXyPDmTwn+wmNQ5MwLVc4vTnvmnwe6+imoMJIKkqGs
        P1XZL5b/ZdOBPaEz4tJ3M825BobZYek=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-590--WK8ui2PNHScqRimV-sMCA-1; Thu, 17 Mar 2022 05:00:14 -0400
X-MC-Unique: -WK8ui2PNHScqRimV-sMCA-1
Received: by mail-wr1-f69.google.com with SMTP id a5-20020adfc445000000b00203dcb13954so1311369wrg.23
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 02:00:14 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=CEdqsAQgxWBE6LqF2BTOKci65noXcTnmAaK4eVtIxl8=;
        b=xAtrSZC+42pUvL/yNKF8MK9nCLbyDzk9b2P3CbzHV4GJq8V12rqxVlFoKFqDEZPsKU
         DUwDpX7Q/gEraZ61eKDJ9w2xyHCSiItvNIXdmUx0L028nv7CZ6x/DW8g2ceA2RdkMTi9
         Eu+/oYkDumtPmlD40AI3DLQ+I+WtDuzPL39C9ciJt/SOOWmkTgJqz0D/+i7V70jKT9zW
         Bb9oWherY5Q5ebzW+DGcohDrWU2fdnXvs4Rjh+WQ/SRTUQRhtuFC2Q1ge3HKiJ6F+vDu
         Uwi5tTcAf7whSyr2e+f9nHniWejKpciCG4W5Vy4l2jn70f+yz6Ti/cc3Ue5Y+z3z7igA
         qpvg==
X-Gm-Message-State: AOAM5323ibrDelikt6KKwobAxYLVY4sg0rUni8NEEtvPp+K353x4RWoG
        BBpl2d5uWxxS/YFTs4qKuGCDN+7nQdmjCYMCe48Kc21ZOaRIAaSlxlTXzPTYG0UVmRIGVjmU3f+
        VYGIw5fDPvXlNlA4o2/yaFBpw
X-Received: by 2002:a05:600c:1e06:b0:389:b587:27fb with SMTP id ay6-20020a05600c1e0600b00389b58727fbmr2929344wmb.18.1647507612916;
        Thu, 17 Mar 2022 02:00:12 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJyd+psZAnDBKHw/YgYAQwONCE2ZhVBDpmP1w9vLJpbcwmWM1vQC6XDuiirz8atwnr4FiSjK3Q==
X-Received: by 2002:a05:600c:1e06:b0:389:b587:27fb with SMTP id ay6-20020a05600c1e0600b00389b58727fbmr2929308wmb.18.1647507612542;
        Thu, 17 Mar 2022 02:00:12 -0700 (PDT)
Received: from ?IPV6:2a09:80c0:192:0:20af:34be:985b:b6c8? ([2a09:80c0:192:0:20af:34be:985b:b6c8])
        by smtp.gmail.com with ESMTPSA id c11-20020a05600c0a4b00b0037c91e085ddsm8408655wmq.40.2022.03.17.02.00.11
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 17 Mar 2022 02:00:12 -0700 (PDT)
Message-ID: <92caaf7b-92a6-8485-d53e-728c3aac30c3@redhat.com>
Date:   Thu, 17 Mar 2022 10:00:10 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
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
 <20220315104741.63071-5-david@redhat.com>
 <CAHbLzkqs04Y+2oNP1Tvhk7wOK4LQnD5vuCMVU9o6+-=UAUDwXA@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH v2 04/15] mm/rmap: split page_dup_rmap() into
 page_dup_file_rmap() and page_try_dup_anon_rmap()
In-Reply-To: <CAHbLzkqs04Y+2oNP1Tvhk7wOK4LQnD5vuCMVU9o6+-=UAUDwXA@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H5,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 16.03.22 21:02, Yang Shi wrote:
> On Tue, Mar 15, 2022 at 3:50 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> ... and move the special check for pinned pages into
>> page_try_dup_anon_rmap() to prepare for tracking exclusive anonymous
>> pages via a new pageflag, clearing it only after making sure that there
>> are no GUP pins on the anonymous page.
>>
>> We really only care about pins on anonymous pages, because they are
>> prone to getting replaced in the COW handler once mapped R/O. For !anon
>> pages in cow-mappings (!VM_SHARED && VM_MAYWRITE) we shouldn't really
>> care about that, at least not that I could come up with an example.
>>
>> Let's drop the is_cow_mapping() check from page_needs_cow_for_dma(), as we
>> know we're dealing with anonymous pages. Also, drop the handling of
>> pinned pages from copy_huge_pud() and add a comment if ever supporting
>> anonymous pages on the PUD level.
>>
>> This is a preparation for tracking exclusivity of anonymous pages in
>> the rmap code, and disallowing marking a page shared (-> failing to
>> duplicate) if there are GUP pins on a page.
>>
>> RFC notes: if I'm missing something important for !anon pages, we could
>>            similarly handle it via page_try_dup_file_rmap().
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  include/linux/mm.h   |  5 +----
>>  include/linux/rmap.h | 48 +++++++++++++++++++++++++++++++++++++++++++-
>>  mm/huge_memory.c     | 27 ++++++++-----------------
>>  mm/hugetlb.c         | 16 ++++++++-------
>>  mm/memory.c          | 17 +++++++++++-----
>>  mm/migrate.c         |  2 +-
>>  6 files changed, 78 insertions(+), 37 deletions(-)
>>
>> diff --git a/include/linux/mm.h b/include/linux/mm.h
>> index 391b950e919d..63ee06001189 100644
>> --- a/include/linux/mm.h
>> +++ b/include/linux/mm.h
>> @@ -1322,16 +1322,13 @@ static inline bool is_cow_mapping(vm_flags_t flags)
>>
>>  /*
>>   * This should most likely only be called during fork() to see whether we
>> - * should break the cow immediately for a page on the src mm.
>> + * should break the cow immediately for an anon page on the src mm.
>>   *
>>   * The caller has to hold the PT lock and the vma->vm_mm->->write_protect_seq.
>>   */
>>  static inline bool page_needs_cow_for_dma(struct vm_area_struct *vma,
>>                                           struct page *page)
>>  {
>> -       if (!is_cow_mapping(vma->vm_flags))
>> -               return false;
>> -
>>         VM_BUG_ON(!(raw_read_seqcount(&vma->vm_mm->write_protect_seq) & 1));
>>
>>         if (!test_bit(MMF_HAS_PINNED, &vma->vm_mm->flags))
>> diff --git a/include/linux/rmap.h b/include/linux/rmap.h
>> index e704b1a4c06c..92c3585b8c6a 100644
>> --- a/include/linux/rmap.h
>> +++ b/include/linux/rmap.h
>> @@ -180,11 +180,57 @@ void hugepage_add_anon_rmap(struct page *, struct vm_area_struct *,
>>  void hugepage_add_new_anon_rmap(struct page *, struct vm_area_struct *,
>>                                 unsigned long);
>>
>> -static inline void page_dup_rmap(struct page *page, bool compound)
>> +static inline void __page_dup_rmap(struct page *page, bool compound)
>>  {
>>         atomic_inc(compound ? compound_mapcount_ptr(page) : &page->_mapcount);
>>  }
>>
>> +static inline void page_dup_file_rmap(struct page *page, bool compound)
>> +{
>> +       __page_dup_rmap(page, compound);
>> +}
>> +
>> +/**
>> + * page_try_dup_anon_rmap - try duplicating a mapping of an already mapped
>> + *                         anonymous page
>> + * @page: the page to duplicate the mapping for
>> + * @compound: the page is mapped as compound or as a small page
>> + * @vma: the source vma
>> + *
>> + * The caller needs to hold the PT lock and the vma->vma_mm->write_protect_seq.
>> + *
>> + * Duplicating the mapping can only fail if the page may be pinned; device
>> + * private pages cannot get pinned and consequently this function cannot fail.
>> + *
>> + * If duplicating the mapping succeeds, the page has to be mapped R/O into
>> + * the parent and the child. It must *not* get mapped writable after this call.
>> + *
>> + * Returns 0 if duplicating the mapping succeeded. Returns -EBUSY otherwise.
>> + */
>> +static inline int page_try_dup_anon_rmap(struct page *page, bool compound,
>> +                                        struct vm_area_struct *vma)
>> +{
>> +       VM_BUG_ON_PAGE(!PageAnon(page), page);
>> +
>> +       /*
>> +        * If this page may have been pinned by the parent process,
>> +        * don't allow to duplicate the mapping but instead require to e.g.,
>> +        * copy the page immediately for the child so that we'll always
>> +        * guarantee the pinned page won't be randomly replaced in the
>> +        * future on write faults.
>> +        */
>> +       if (likely(!is_device_private_page(page) &&
>> +           unlikely(page_needs_cow_for_dma(vma, page))))
>> +               return -EBUSY;
>> +
>> +       /*
>> +        * It's okay to share the anon page between both processes, mapping
>> +        * the page R/O into both processes.
>> +        */
>> +       __page_dup_rmap(page, compound);
>> +       return 0;
>> +}
>> +
>>  /*
>>   * Called from mm/vmscan.c to handle paging out
>>   */
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index cda88d8ac1bd..c126d728b8de 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1097,23 +1097,16 @@ int copy_huge_pmd(struct mm_struct *dst_mm, struct mm_struct *src_mm,
>>         src_page = pmd_page(pmd);
>>         VM_BUG_ON_PAGE(!PageHead(src_page), src_page);
>>
>> -       /*
>> -        * If this page is a potentially pinned page, split and retry the fault
>> -        * with smaller page size.  Normally this should not happen because the
>> -        * userspace should use MADV_DONTFORK upon pinned regions.  This is a
>> -        * best effort that the pinned pages won't be replaced by another
>> -        * random page during the coming copy-on-write.
>> -        */
>> -       if (unlikely(page_needs_cow_for_dma(src_vma, src_page))) {
>> +       get_page(src_page);
>> +       if (unlikely(page_try_dup_anon_rmap(src_page, true, src_vma))) {
>> +               /* Page maybe pinned: split and retry the fault on PTEs. */
>> +               put_page(src_page);
> 
> Do we have to do the get_page()/put_page() sequence? It seems we don't
> have to get the page before calling page_try_dup_anon_rmap(), right?
> We just need to bump page refcount when dupping rmap successfully. So
> we could do:
> 
> if (unlikely(page_try_dup_anon_rmap(src_page, true, src_vma))) {
>     /* do something */
> }
> 
> get_page(src_page)

I refrained from doing that in this series because I wasn't able to
convince myself that it is completely sane.

Increasing the refcount before the mapcount here results in an
interesting property (when unmap is done similarly, in reverse order):
reading a snapshot of page_count()+mapcount() at a random point in
time guarantees that page_count() >= mapcount.

Now, the issue I see with changing that is the following: We seem
to have some code that tries detecting additional references on a
mapped page. While such checks can deal with false positives ("there
is an additional reference"), false negatives ("these is no
additional reference") could be bad.

One example I stumbled over is KSM code:


		/*
		 * Check that no O_DIRECT or similar I/O is in progress on the
		 * page
		 */
		if (page_mapcount(page) + 1 + swapped != page_count(page)) {
			set_pte_at(mm, pvmw.address, pvmw.pte, entry);
			goto out_unlock;
		}


Imagine there is an additional reference but another process sharing the
page did the mapcount++ but not the refcount++ yet. You'd get a false negative.


Now, I'm not sure if there is anything else protecting us from this,
however, it rather made me be very careful about changing the order
of things here. So in the context of this patch, I won't be messing with
the order.

Thanks!

-- 
Thanks,

David / dhildenb

