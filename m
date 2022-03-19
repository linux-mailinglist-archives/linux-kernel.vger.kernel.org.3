Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD0D24DE76B
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Mar 2022 11:21:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242675AbiCSKWn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Mar 2022 06:22:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234305AbiCSKWm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Mar 2022 06:22:42 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id CAFEC7B10E
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 03:21:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647685279;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=OvsAcCgAjUW2171nbSV5fLYlxKVlJ4wv4UmYKGOvCc8=;
        b=SN1SGvE5JpOnjEx0SQpnTInrtkf3bt5sFwt3z8dKu1rylxU8K3YffGYg/Qo4/pigLC8w4+
        CZaQipE5am/srR8cJv1WH/k6jJF/iOeyWOq7g9MvMZ+lfy8Q9QKJbIz0A0/uzCV/z8g4+4
        /ESDqO4CaV5kNuV4FllM7/7TRD3QCBA=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-X--4W0tQNZSE6REkzpiKFA-1; Sat, 19 Mar 2022 06:21:18 -0400
X-MC-Unique: X--4W0tQNZSE6REkzpiKFA-1
Received: by mail-wm1-f69.google.com with SMTP id k41-20020a05600c1ca900b00389a2b983efso3991859wms.4
        for <linux-kernel@vger.kernel.org>; Sat, 19 Mar 2022 03:21:17 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=OvsAcCgAjUW2171nbSV5fLYlxKVlJ4wv4UmYKGOvCc8=;
        b=vK9zzJT65NVTI4pGmUQ4e6H9B2FNDZMFqDfBhm+63c5Mt8XWJwldZ9g4wZb/ZCcvLh
         oo+6q7kGB+4BcCpB85E7jy072wTUcLqPow3kD5yA3eLrWx8gAbb/J9dfRQgo83iv7A2A
         drOZzUpuz17Ops4PYXbuQdGuplT0EHCEP6RiYBMAzM0ikUng5tbbZ6VLpiW8+Gg/dzcz
         HgO2c0UMPAdwNqq4v56LrmKEd5u38UQeEgy9sq1Tj2RyU/cinpFpMUS7OgK6OuGHFlVS
         dzMBciYwkgC9AgNMN2946pJJzTiRVsh7TtI9G5KDCH6vZZf1Jvmm1sWeFBaNfD0yNOT0
         zOCQ==
X-Gm-Message-State: AOAM531uP3uaSdAsu0XFZOdu0D/v/yU8GS1FJPqf02/JalSvdeRKPLQZ
        loYTA8LUk8vHte5VwgjvdMVuZWvDMC1bYJNWQuULGXJbWa1BVkiRehwNy0aGRrw14N/iL5QArpr
        FFR5HBZYUrhGq/v6Yv+tB4RFg
X-Received: by 2002:a05:600c:4f86:b0:389:d5bf:a7f3 with SMTP id n6-20020a05600c4f8600b00389d5bfa7f3mr11917834wmq.49.1647685276678;
        Sat, 19 Mar 2022 03:21:16 -0700 (PDT)
X-Google-Smtp-Source: ABdhPJza4wMjyHUucCoGMnxfrItDn1G281WPHPQanj/5sqBaUD+1OnDhfr4+BiMnPygUqnMDknNPXg==
X-Received: by 2002:a05:600c:4f86:b0:389:d5bf:a7f3 with SMTP id n6-20020a05600c4f8600b00389d5bfa7f3mr11917786wmq.49.1647685276060;
        Sat, 19 Mar 2022 03:21:16 -0700 (PDT)
Received: from ?IPV6:2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8? (p200300d82f249200124ef0bf6f8ccbd8.dip0.t-ipconnect.de. [2003:d8:2f24:9200:124e:f0bf:6f8c:cbd8])
        by smtp.gmail.com with ESMTPSA id z5-20020a05600c0a0500b0037bb8df81a2sm14816035wmp.13.2022.03.19.03.21.14
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 19 Mar 2022 03:21:15 -0700 (PDT)
Message-ID: <2505408d-6cc7-f14e-79a4-c5a1c716f737@redhat.com>
Date:   Sat, 19 Mar 2022 11:21:14 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v2 11/15] mm: remember exclusively mapped anonymous pages
 with PG_anon_exclusive
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
 <20220315104741.63071-12-david@redhat.com>
 <CAHbLzkpTTf_16tDrS5TxWPif0ZOwFoJ1ys-PFtLhYK6XGowTYA@mail.gmail.com>
 <2b280ac6-9d39-58c5-b255-f39b1dac607b@redhat.com>
 <CAHbLzko_VjR6_rx+i8Qn9cKU3mvLC2A0t92ZtYqmE7QD5PH8pg@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <CAHbLzko_VjR6_rx+i8Qn9cKU3mvLC2A0t92ZtYqmE7QD5PH8pg@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-3.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H4,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 18.03.22 21:29, Yang Shi wrote:
> On Thu, Mar 17, 2022 at 2:06 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> On 16.03.22 22:23, Yang Shi wrote:
>>> On Tue, Mar 15, 2022 at 3:52 AM David Hildenbrand <david@redhat.com> wrote:
>>>>
>>>> Let's mark exclusively mapped anonymous pages with PG_anon_exclusive as
>>>> exclusive, and use that information to make GUP pins reliable and stay
>>>> consistent with the page mapped into the page table even if the
>>>> page table entry gets write-protected.
>>>>
>>>> With that information at hand, we can extend our COW logic to always
>>>> reuse anonymous pages that are exclusive. For anonymous pages that
>>>> might be shared, the existing logic applies.
>>>>
>>>> As already documented, PG_anon_exclusive is usually only expressive in
>>>> combination with a page table entry. Especially PTE vs. PMD-mapped
>>>> anonymous pages require more thought, some examples: due to mremap() we
>>>> can easily have a single compound page PTE-mapped into multiple page tables
>>>> exclusively in a single process -- multiple page table locks apply.
>>>> Further, due to MADV_WIPEONFORK we might not necessarily write-protect
>>>> all PTEs, and only some subpages might be pinned. Long story short: once
>>>> PTE-mapped, we have to track information about exclusivity per sub-page,
>>>> but until then, we can just track it for the compound page in the head
>>>> page and not having to update a whole bunch of subpages all of the time
>>>> for a simple PMD mapping of a THP.
>>>>
>>>> For simplicity, this commit mostly talks about "anonymous pages", while
>>>> it's for THP actually "the part of an anonymous folio referenced via
>>>> a page table entry".
>>>>
>>>> To not spill PG_anon_exclusive code all over the mm code-base, we let
>>>> the anon rmap code to handle all PG_anon_exclusive logic it can easily
>>>> handle.
>>>>
>>>> If a writable, present page table entry points at an anonymous (sub)page,
>>>> that (sub)page must be PG_anon_exclusive. If GUP wants to take a reliably
>>>> pin (FOLL_PIN) on an anonymous page references via a present
>>>> page table entry, it must only pin if PG_anon_exclusive is set for the
>>>> mapped (sub)page.
>>>>
>>>> This commit doesn't adjust GUP, so this is only implicitly handled for
>>>> FOLL_WRITE, follow-up commits will teach GUP to also respect it for
>>>> FOLL_PIN without !FOLL_WRITE, to make all GUP pins of anonymous pages
>>>> fully reliable.
>>>>
>>>> Whenever an anonymous page is to be shared (fork(), KSM), or when
>>>> temporarily unmapping an anonymous page (swap, migration), the relevant
>>>> PG_anon_exclusive bit has to be cleared to mark the anonymous page
>>>> possibly shared. Clearing will fail if there are GUP pins on the page:
>>>> * For fork(), this means having to copy the page and not being able to
>>>>   share it. fork() protects against concurrent GUP using the PT lock and
>>>>   the src_mm->write_protect_seq.
>>>> * For KSM, this means sharing will fail. For swap this means, unmapping
>>>>   will fail, For migration this means, migration will fail early. All
>>>>   three cases protect against concurrent GUP using the PT lock and a
>>>>   proper clear/invalidate+flush of the relevant page table entry.
>>>>
>>>> This fixes memory corruptions reported for FOLL_PIN | FOLL_WRITE, when a
>>>> pinned page gets mapped R/O and the successive write fault ends up
>>>> replacing the page instead of reusing it. It improves the situation for
>>>> O_DIRECT/vmsplice/... that still use FOLL_GET instead of FOLL_PIN,
>>>> if fork() is *not* involved, however swapout and fork() are still
>>>> problematic. Properly using FOLL_PIN instead of FOLL_GET for these
>>>> GUP users will fix the issue for them.
>>>>
>>>> I. Details about basic handling
>>>>
>>>> I.1. Fresh anonymous pages
>>>>
>>>> page_add_new_anon_rmap() and hugepage_add_new_anon_rmap() will mark the
>>>> given page exclusive via __page_set_anon_rmap(exclusive=1). As that is
>>>> the mechanism fresh anonymous pages come into life (besides migration
>>>> code where we copy the page->mapping), all fresh anonymous pages will
>>>> start out as exclusive.
>>>>
>>>> I.2. COW reuse handling of anonymous pages
>>>>
>>>> When a COW handler stumbles over a (sub)page that's marked exclusive, it
>>>> simply reuses it. Otherwise, the handler tries harder under page lock to
>>>> detect if the (sub)page is exclusive and can be reused. If exclusive,
>>>> page_move_anon_rmap() will mark the given (sub)page exclusive.
>>>>
>>>> Note that hugetlb code does not yet check for PageAnonExclusive(), as it
>>>> still uses the old COW logic that is prone to the COW security issue
>>>> because hugetlb code cannot really tolerate unnecessary/wrong COW as
>>>> huge pages are a scarce resource.
>>>>
>>>> I.3. Migration handling
>>>>
>>>> try_to_migrate() has to try marking an exclusive anonymous page shared
>>>> via page_try_share_anon_rmap(). If it fails because there are GUP pins
>>>> on the page, unmap fails. migrate_vma_collect_pmd() and
>>>> __split_huge_pmd_locked() are handled similarly.
>>>>
>>>> Writable migration entries implicitly point at shared anonymous pages.
>>>> For readable migration entries that information is stored via a new
>>>> "readable-exclusive" migration entry, specific to anonymous pages.
>>>>
>>>> When restoring a migration entry in remove_migration_pte(), information
>>>> about exlusivity is detected via the migration entry type, and
>>>> RMAP_EXCLUSIVE is set accordingly for
>>>> page_add_anon_rmap()/hugepage_add_anon_rmap() to restore that
>>>> information.
>>>>
>>>> I.4. Swapout handling
>>>>
>>>> try_to_unmap() has to try marking the mapped page possibly shared via
>>>> page_try_share_anon_rmap(). If it fails because there are GUP pins on the
>>>> page, unmap fails. For now, information about exclusivity is lost. In the
>>>> future, we might want to remember that information in the swap entry in
>>>> some cases, however, it requires more thought, care, and a way to store
>>>> that information in swap entries.
>>>>
>>>> I.5. Swapin handling
>>>>
>>>> do_swap_page() will never stumble over exclusive anonymous pages in the
>>>> swap cache, as try_to_migrate() prohibits that. do_swap_page() always has
>>>> to detect manually if an anonymous page is exclusive and has to set
>>>> RMAP_EXCLUSIVE for page_add_anon_rmap() accordingly.
>>>>
>>>> I.6. THP handling
>>>>
>>>> __split_huge_pmd_locked() has to move the information about exclusivity
>>>> from the PMD to the PTEs.
>>>>
>>>> a) In case we have a readable-exclusive PMD migration entry, simply insert
>>>> readable-exclusive PTE migration entries.
>>>>
>>>> b) In case we have a present PMD entry and we don't want to freeze
>>>> ("convert to migration entries"), simply forward PG_anon_exclusive to
>>>> all sub-pages, no need to temporarily clear the bit.
>>>>
>>>> c) In case we have a present PMD entry and want to freeze, handle it
>>>> similar to try_to_migrate(): try marking the page shared first. In case
>>>> we fail, we ignore the "freeze" instruction and simply split ordinarily.
>>>> try_to_migrate() will properly fail because the THP is still mapped via
>>>> PTEs.
>>
>> Hi,
>>
>> thanks for the review!
>>
>>>
>>> How come will try_to_migrate() fail? The afterward pvmw will find
>>> those PTEs then convert them to migration entries anyway IIUC.
>>>
>>
>> It will run into that code:
>>
>>>> @@ -1903,6 +1938,15 @@ static bool try_to_migrate_one(struct page *page, struct vm_area_struct *vma,
>>>>                                 page_vma_mapped_walk_done(&pvmw);
>>>>                                 break;
>>>>                         }
>>>> +                       VM_BUG_ON_PAGE(pte_write(pteval) && PageAnon(page) &&
>>>> +                                      !anon_exclusive, page);
>>>> +                       if (anon_exclusive &&
>>>> +                           page_try_share_anon_rmap(subpage)) {
>>>> +                               set_pte_at(mm, address, pvmw.pte, pteval);
>>>> +                               ret = false;
>>>> +                               page_vma_mapped_walk_done(&pvmw);
>>>> +                               break;
>>>> +                       }
>>
>> and similarly fail the page_try_share_anon_rmap(), at which point
>> try_to_migrate() stops and the caller will still observe a
>> "page_mapped() == true".
> 
> Thanks, I missed that. Yes, the page will still be mapped. This should
> trigger the VM_WARN_ON_ONCE in unmap_page(), if this change will make
> this happen more often, we may consider removing that warning even
> though it is "once" since seeing a mapped page may become a normal
> case (once DIO is switched to FOLL_PIN, it may be more often). Anyway
> we don't have to remove it right now.

Oh, very good catch! I wasn't able to trigger that warning in my testing
so far. Interestingly, arch_unmap_one() could theoretically make this
fail already and trigger the warning.

Apart from that warning, split_huge_page_to_list() should work as
expected: freezing the refcount will fail if still mapped and we'll remap.

I'll include a separate patch to just remove that VM_WARN_ON_ONCE -- thanks!

-- 
Thanks,

David / dhildenb

