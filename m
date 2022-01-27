Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 04E6549DC57
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:15:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237689AbiA0IOR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:14:17 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:50823 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S230231AbiA0ION (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:14:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643271252;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=332zgtmH+EWSRF3snsZ1Kz3rtbqJhLDbMW389irdY9c=;
        b=N3oh7KDSjR8QSCF3SH/KZs1Jv93j6fa3rzxRGo42d1As+HbK4ILrt6T3oeVyQoz/zFEYer
        OoLDzvr9T3uN5SzUN4AgYxPSX1+v5CcvShYx3+PLHOHQMOneX9Wh9yuG6ByFePZdPmOwaA
        FzP6K/JKRN9Cnvvud2FYJQmcxDrHKRA=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256-wjoFlqqDN-e0ekV1wAdpLw-1; Thu, 27 Jan 2022 03:14:11 -0500
X-MC-Unique: wjoFlqqDN-e0ekV1wAdpLw-1
Received: by mail-wr1-f71.google.com with SMTP id j21-20020adfa555000000b001db55dd5a1dso742520wrb.15
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 00:14:11 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent
         :content-language:to:cc:references:from:organization:subject
         :in-reply-to:content-transfer-encoding;
        bh=332zgtmH+EWSRF3snsZ1Kz3rtbqJhLDbMW389irdY9c=;
        b=F8zRRzQspKGYUf33idaD0/J1JZSI48NkMuf8i3FNMv4ngBR3dtm3L4irVdfv1irlOL
         pKywH4NSOi2+5k43Flj/4BiwJal8PeAkYaDn85Fa7GHNH35znRhqaor1BWUyRGxMxJ/c
         n//4frOqFoXIclbw2/DsmKRRICXnw1B8uf/O9v6wfOUQzWIGetaoCbKm4culAGkhDrhb
         Su7dtigRxDPsn46c6Jm4bjgOUgK4Tp1mNrEp1FHtAyk9XFX5wt49CXaPPZJddhL5V4U3
         AnAnrChS/26xk4bXkiZplmON1nYP4C6siOyWDk4/KnQcGDK9gZcg7c9mnslocEs4osn+
         owhQ==
X-Gm-Message-State: AOAM532nUCGWWGWPRJ2GM/APQhP8MzFvcN95vXRAK1X6U9qr5iviho5j
        cvFTEDWLpJv7a2VdpkbbpfBTvMxYs9s62yiIVZVYoj22xq/hxeWd+qLa/G2sH58fbCPLaGy5bMb
        UITbRFw82JMtvnJw5S4L2WB3q
X-Received: by 2002:adf:dc44:: with SMTP id m4mr2016215wrj.355.1643271250113;
        Thu, 27 Jan 2022 00:14:10 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxGIyXM+NTsPZiOOcTN0CZb2a1gVOKMozb4gtBexoN5OxuRr/wCTRIh2PIKKOC33JRVOtA67A==
X-Received: by 2002:adf:dc44:: with SMTP id m4mr2016171wrj.355.1643271249823;
        Thu, 27 Jan 2022 00:14:09 -0800 (PST)
Received: from ?IPV6:2003:cb:c70d:8300:4812:9d4f:6cd8:7f47? (p200300cbc70d830048129d4f6cd87f47.dip0.t-ipconnect.de. [2003:cb:c70d:8300:4812:9d4f:6cd8:7f47])
        by smtp.gmail.com with ESMTPSA id l13sm5507818wmq.22.2022.01.27.00.14.08
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Thu, 27 Jan 2022 00:14:09 -0800 (PST)
Message-ID: <1d1d4b01-961f-d7e7-491c-a482bdd3fded@redhat.com>
Date:   Thu, 27 Jan 2022 09:14:07 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.4.0
Content-Language: en-US
To:     Yang Shi <shy828301@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Linux MM <linux-mm@kvack.org>
References: <20220126095557.32392-1-david@redhat.com>
 <20220126095557.32392-6-david@redhat.com>
 <CAHbLzkqmxSTkh4WOQr8xzzMO94Gr8GuqH8Vn4T5q8rW7gkabYQ@mail.gmail.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
Subject: Re: [PATCH RFC v2 5/9] mm/huge_memory: streamline COW logic in
 do_huge_pmd_wp_page()
In-Reply-To: <CAHbLzkqmxSTkh4WOQr8xzzMO94Gr8GuqH8Vn4T5q8rW7gkabYQ@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 26.01.22 21:36, Yang Shi wrote:
> On Wed, Jan 26, 2022 at 2:00 AM David Hildenbrand <david@redhat.com> wrote:
>>
>> We currently have a different COW logic for anon THP than we have for
>> ordinary anon pages in do_wp_page(): the effect is that the issue reported
>> in CVE-2020-29374 is currently still possible for anon THP: an unintended
>> information leak from the parent to the child.
>>
>> Let's apply the same logic (page_count() == 1), with similar
>> optimizations to remove additional references first as we really want to
>> avoid PTE-mapping the THP and copying individual pages best we can.
>>
>> If we end up with a page that has page_count() != 1, we'll have to PTE-map
>> the THP and fallback to do_wp_page(), which will always copy the page.
>>
>> Note that KSM does not apply to THP.
>>
>> I. Interaction with the swapcache and writeback
>>
>> While a THP is in the swapcache, the swapcache holds one reference on each
>> subpage of the THP. So with PageSwapCache() set, we expect as many
>> additional references as we have subpages. If we manage to remove the
>> THP from the swapcache, all these references will be gone.
>>
>> Usually, a THP is not split when entered into the swapcache and stays a
>> compound page. However, try_to_unmap() will PTE-map the THP and use PTE
>> swap entries. There are no PMD swap entries for that purpose, consequently,
>> we always only swapin subpages into PTEs.
>>
>> Removing a page from the swapcache can fail either when there are remaining
>> swap entries (in which case COW is the right thing to do) or if the page is
>> currently under writeback.
>>
>> Having a locked, R/O PMD-mapped THP that is in the swapcache seems to be
>> possible only in corner cases, for example, if try_to_unmap() failed
>> after adding the page to the swapcache. However, it's comparatively easy to
>> handle.
>>
>> As we have to fully unmap a THP before starting writeback, and swapin is
>> always done on the PTE level, we shouldn't find a R/O PMD-mapped THP in the
>> swapcache that is under writeback. This should at least leave writeback
>> out of the picture.
>>
>> II. Interaction with GUP references
>>
>> Having a R/O PMD-mapped THP with GUP references (i.e., R/O references)
>> will result in PTE-mapping the THP on a write fault. Similar to ordinary
>> anon pages, do_wp_page() will have to copy sub-pages and result in a
>> disconnect between the GUP references and the pages actually mapped into
>> the page tables. To improve the situation in the future, we'll need
>> additional handling to mark anonymous pages as definitely exclusive to a
>> single process, only allow GUP pins on exclusive anon pages, and
>> disallow sharing of exclusive anon pages with GUP pins e.g., during
>> fork().
>>
>> III. Interaction with references from LRU pagevecs
>>
>> Similar to ordinary anon pages, we can have LRU pagevecs referencing our
>> THP. Reliably removing such references requires draining LRU pagevecs on
>> all CPUs -- lru_add_drain_all() -- a possibly expensive operation that can
>> sleep. For now, similar do do_wp_page(), let's conditionally drain the
>> local LRU pagevecs only if we detect !PageLRU().
>>
>> IV. Interaction with speculative/temporary references
>>
>> Similar to ordinary anon pages, other speculative/temporary references on
>> the THP, for example, from the pagecache or page migration code, will
>> disallow exclusive reuse of the page. We'll have to PTE-map the THP.
>>
>> Signed-off-by: David Hildenbrand <david@redhat.com>
>> ---
>>  mm/huge_memory.c | 19 +++++++++++++++----
>>  1 file changed, 15 insertions(+), 4 deletions(-)
>>
>> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
>> index 406a3c28c026..b6ba88a98266 100644
>> --- a/mm/huge_memory.c
>> +++ b/mm/huge_memory.c
>> @@ -1286,6 +1286,7 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>>         struct page *page;
>>         unsigned long haddr = vmf->address & HPAGE_PMD_MASK;
>>         pmd_t orig_pmd = vmf->orig_pmd;
>> +       int swapcache_refs = 0;
>>
>>         vmf->ptl = pmd_lockptr(vma->vm_mm, vmf->pmd);
>>         VM_BUG_ON_VMA(!vma->anon_vma, vma);
>> @@ -1303,7 +1304,6 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>>         page = pmd_page(orig_pmd);
>>         VM_BUG_ON_PAGE(!PageHead(page), page);
>>
>> -       /* Lock page for reuse_swap_page() */
>>         if (!trylock_page(page)) {
>>                 get_page(page);
>>                 spin_unlock(vmf->ptl);
>> @@ -1319,10 +1319,20 @@ vm_fault_t do_huge_pmd_wp_page(struct vm_fault *vmf)
>>         }
>>
>>         /*
>> -        * We can only reuse the page if nobody else maps the huge page or it's
>> -        * part.
>> +        * See do_wp_page(): we can only map the page writable if there are
>> +        * no additional references.
>>          */
>> -       if (reuse_swap_page(page)) {
>> +       if (PageSwapCache(page))
>> +               swapcache_refs = thp_nr_pages(page);
>> +       if (page_count(page) > 1 + swapcache_refs + !PageLRU(page))
>> +               goto unlock_fallback;
>> +       if (!PageLRU(page))
>> +               lru_add_drain();
> 
> IMHO, draining lru doesn't help out too much for THP since THP will be
> drained to LRU immediately once it is added into pagevec.

Oh, thanks, I think you're right. The interesting bit is

static bool pagevec_add_and_need_flush(struct pagevec *pvec, struct page
*page)
{
	bool ret = false;

	if (!pagevec_add(pvec, page) || PageCompound(page) ||
			lru_cache_disabled())
		ret = true;

	return ret;
}

Which indeed drains after adding it to the pagevec.

Will adjust the patch and update the description/comment accordingly,
thanks!

-- 
Thanks,

David / dhildenb

