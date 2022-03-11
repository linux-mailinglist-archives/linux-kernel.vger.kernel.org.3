Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 464264D68A4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 19:47:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350975AbiCKSrw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 13:47:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39172 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350937AbiCKSrt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 13:47:49 -0500
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 627A51D3075
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:46:45 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1647024404;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=cdCxcrAevEZHqc92XuqPKvYzSkW0LanGysNAk/gJ4Qw=;
        b=XY1LkfYbB/BBxEbkIZEBKIFrs8Bje+nZT7aZ3fZqnz6B0/UESBErgnmb+Gj+e+OsExjvLt
        zU0bwrZXcT9AOnaHKYEYAM4lb99+lZs4xg9gYaOsJQjim6KSOY0uCQB7W0J3YvKmdFFwWp
        wNh61ri4ObLDDnUsdERkCM4O+10wubk=
Received: from mail-wr1-f72.google.com (mail-wr1-f72.google.com
 [209.85.221.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-665-Vcp24fwANnmk5Bj4wUGIcQ-1; Fri, 11 Mar 2022 13:46:43 -0500
X-MC-Unique: Vcp24fwANnmk5Bj4wUGIcQ-1
Received: by mail-wr1-f72.google.com with SMTP id l10-20020a05600012ca00b001f1e4669c98so3101779wrx.23
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 10:46:43 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:organization:in-reply-to
         :content-transfer-encoding;
        bh=cdCxcrAevEZHqc92XuqPKvYzSkW0LanGysNAk/gJ4Qw=;
        b=OVHfIZfJQjqveVSOL8ndR5kwjIGaoPJ4RID80hZ6Kjp6kzmuj/g7AMesExZ+TwKqDF
         2ZHrlkhc/eCFKZWtOu7TFaeEKy4v+4dPG4fdR1GoMv0Smnsa/5+u2UbOip/j1zTPRrcf
         ljOSe5gkwHM4JtPS7BdKUjrJ4Vd/SdJgbfi/1ww2mxqLJNe3kKiV3OuxEADZKwgO4Xez
         IBvn/IWJ/24UKNjNooMFruNbg7ifJ43FEXltHkbq5/1XzQKB48aDlJfEhA7ASXdrDGdW
         dNBKypkIa0/CkGrHO50O1XdTRcLnKWsJd6LZxYcJFiiZbohzfa+LEz1CSzxRYP25eBlx
         RxGQ==
X-Gm-Message-State: AOAM530XQNbx74HZ+a/0uyIKkSV5hl5xeLvS7tB6s5uON4rqofMQI5Y+
        NLzRX9YCpF6aUyxqcWFBMT2Awhd1xjV9TEujfyeEVKj2pMDXEHdoLdNfEIsbHNSJUmADO2W0nJU
        vlR0VCvBTsOfqjjFJvjcMpx59QZoGg70AiRlmqLA/EzJQyB43ewNiP9QHGI+mCz2wSpG4vQh1
X-Received: by 2002:a5d:4392:0:b0:1f1:e683:de90 with SMTP id i18-20020a5d4392000000b001f1e683de90mr8614104wrq.551.1647024402216;
        Fri, 11 Mar 2022 10:46:42 -0800 (PST)
X-Google-Smtp-Source: ABdhPJxfAFsFJNjP2WAVMmvR3g4l59FurG0ixdEGpD6xl6oaQhcpIVH+xHtP4OaMFR/yotx8JEh5EA==
X-Received: by 2002:a5d:4392:0:b0:1f1:e683:de90 with SMTP id i18-20020a5d4392000000b001f1e683de90mr8614053wrq.551.1647024401688;
        Fri, 11 Mar 2022 10:46:41 -0800 (PST)
Received: from ?IPV6:2003:cb:c707:8200:163d:7a08:6e61:87a5? (p200300cbc7078200163d7a086e6187a5.dip0.t-ipconnect.de. [2003:cb:c707:8200:163d:7a08:6e61:87a5])
        by smtp.gmail.com with ESMTPSA id m3-20020a5d6a03000000b001f06621641fsm7019213wru.96.2022.03.11.10.46.39
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 11 Mar 2022 10:46:41 -0800 (PST)
Message-ID: <a0bd6f52-7bb5-0c32-75c8-2c7c592c2d6d@redhat.com>
Date:   Fri, 11 Mar 2022 19:46:39 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.6.2
Subject: Re: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as
 PG_anon_exclusive for PageAnon() pages
Content-Language: en-US
To:     linux-kernel@vger.kernel.org
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
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-11-david@redhat.com>
From:   David Hildenbrand <david@redhat.com>
Organization: Red Hat
In-Reply-To: <20220308141437.144919-11-david@redhat.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-2.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,NICE_REPLY_A,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On 08.03.22 15:14, David Hildenbrand wrote:
> The basic question we would like to have a reliable and efficient answer
> to is: is this anonymous page exclusive to a single process or might it
> be shared?
> 
> In an ideal world, we'd have a spare pageflag. Unfortunately, pageflags
> don't grow on trees, so we have to get a little creative for the time
> being.
> 
> Introduce a way to mark an anonymous page as exclusive, with the
> ultimate goal of teaching our COW logic to not do "wrong COWs", whereby
> GUP pins lose consistency with the pages mapped into the page table,
> resulting in reported memory corruptions.
> 
> Most pageflags already have semantics for anonymous pages, so we're left
> with reusing PG_slab for our purpose: for PageAnon() pages PG_slab now
> translates to PG_anon_exclusive, teach some in-kernel code that manually
> handles PG_slab about that.
> 
> Add a spoiler on the semantics of PG_anon_exclusive as documentation. More
> documentation will be contained in the code that actually makes use of
> PG_anon_exclusive.
> 
> We won't be clearing PG_anon_exclusive on destructive unmapping (i.e.,
> zapping) of page table entries, page freeing code will handle that when
> also invalidate page->mapping to not indicate PageAnon() anymore.
> Letting information about exclusivity stick around will be an important
> property when adding sanity checks to unpinning code.
> 
> RFC notes: in-tree tools/cgroup/memcg_slabinfo.py looks like it might need
> 	   some care. We'd have to lookup the head page and check if
> 	   PageAnon() is set. Similarly, tools living outside the kernel
> 	   repository like crash and makedumpfile might need adaptions.
> 
> Cc: Roman Gushchin <guro@fb.com>
> Signed-off-by: David Hildenbrand <david@redhat.com>
> ---

I'm currently testing with the following. My tests so far with a swapfile on
all different kinds of weird filesystems (excluding networking fs, though)
revealed no surprises so far:



From 13aeb929722e38d162d03baa75eadb8c2c84359d Mon Sep 17 00:00:00 2001
From: David Hildenbrand <david@redhat.com>
Date: Mon, 20 Dec 2021 20:23:51 +0100
Subject: [PATCH] mm/page-flags: reuse PG_mappedtodisk as PG_anon_exclusive for
 PageAnon() pages

The basic question we would like to have a reliable and efficient answer
to is: is this anonymous page exclusive to a single process or might it
be shared? We need that information for ordinary/single pages, hugetlb
pages, and possibly each subpage of a THP.

Introduce a way to mark an anonymous page as exclusive, with the
ultimate goal of teaching our COW logic to not do "wrong COWs", whereby
GUP pins lose consistency with the pages mapped into the page table,
resulting in reported memory corruptions.

Most pageflags already have semantics for anonymous pages, however,
PG_mappedtodisk should never apply to pages in the swapcache, so let's
reuse that flag.

As PG_has_hwpoisoned also uses that flag on the second tail page of a
compound page, convert it to PG_waiters instead, which is marked as
PF_ONLY_HEAD and does definetly not apply to any tail pages.
__split_huge_page() properly does a ClearPageHasHWPoisoned() before
continuing with the THP split.

Use custom page flag modification functions such that we can do
additional sanity checks. Add a spoiler on the semantics of
PG_anon_exclusive as documentation. More documentation will be contained
in the code that actually makes use of PG_anon_exclusive.

We won't be clearing PG_anon_exclusive on destructive unmapping (i.e.,
zapping) of page table entries, page freeing code will handle that when
also invalidate page->mapping to not indicate PageAnon() anymore.
Letting information about exclusivity stick around will be an important
property when adding sanity checks to unpinning code.

Note that we properly clear the flag in free_pages_prepare() via
PAGE_FLAGS_CHECK_AT_PREP for each individual subpage of a compound page,
so there is no need to manually clear the flag.

Signed-off-by: David Hildenbrand <david@redhat.com>
---
 include/linux/page-flags.h | 84 +++++++++++++++++++++++++++++++++++++-
 mm/hugetlb.c               |  2 +
 mm/memory.c                | 11 +++++
 mm/memremap.c              |  9 ++++
 mm/swapfile.c              |  4 ++
 tools/vm/page-types.c      |  8 +++-
 6 files changed, 116 insertions(+), 2 deletions(-)

diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
index 1c3b6e5c8bfd..ac68d28b5e1f 100644
--- a/include/linux/page-flags.h
+++ b/include/linux/page-flags.h
@@ -142,6 +142,60 @@ enum pageflags {
 
 	PG_readahead = PG_reclaim,
 
+	/*
+	 * Depending on the way an anonymous folio can be mapped into a page
+	 * table (e.g., single PMD/PUD/CONT of the head page vs. PTE-mapped
+	 * THP), PG_anon_exclusive may be set only for the head page or for
+	 * subpages of an anonymous folio.
+	 *
+	 * PG_anon_exclusive is *usually* only expressive in combination with a
+	 * page table entry. Depending on the page table entry type it might
+	 * store the following information:
+	 *
+	 *	Is what's mapped via this page table entry exclusive to the
+	 *	single process and can be mapped writable without further
+	 *	checks? If not, it might be shared and we might have to COW.
+	 *
+	 * For now, we only expect PTE-mapped THPs to make use of
+	 * PG_anon_exclusive in subpages. For other anonymous compound
+	 * folios (i.e., hugetlb), only the head page is logically mapped and
+	 * holds this information.
+	 *
+	 * For example, an exclusive, PMD-mapped THP only has PG_anon_exclusive
+	 * set on the head page. When replacing the PMD by a page table full
+	 * of PTEs, PG_anon_exclusive, if set on the head page, will be set on
+	 * all tail pages accordingly. Note that converting from a PTE-mapping
+	 * to a PMD mapping using the same compound page is currently not
+	 * possible and consequently doesn't require care.
+	 *
+	 * If GUP wants to take a reliable pin (FOLL_PIN) on an anonymous page,
+	 * it should only pin if the relevant PG_anon_bit is set. In that case,
+	 * the pin will be fully reliable and stay consistent with the pages
+	 * mapped into the page table, as the bit cannot get cleared (e.g., by
+	 * fork(), KSM) while the page is pinned. For anonymous pages that
+	 * are mapped R/W, PG_anon_exclusive can be assumed to always be set
+	 * because such pages cannot possibly be shared.
+	 *
+	 * The page table lock protecting the page table entry is the primary
+	 * synchronization mechanism for PG_anon_exclusive; GUP-fast that does
+	 * not take the PT lock needs special care when trying to clear the
+	 * flag.
+	 *
+	 * Page table entry types and PG_anon_exclusive:
+	 * * Present: PG_anon_exclusive applies.
+	 * * Swap: the information is lost. PG_anon_exclusive was cleared.
+	 * * Migration: the entry holds this information instead.
+	 *		PG_anon_exclusive was cleared.
+	 * * Device private: PG_anon_exclusive applies.
+	 * * Device exclusive: PG_anon_exclusive applies.
+	 * * HW Poison: PG_anon_exclusive is stale and not changed.
+	 *
+	 * If the page may be pinned (FOLL_PIN), clearing PG_anon_exclusive is
+	 * not allowed and the flag will stick around until the page is freed
+	 * and folio->mapping is cleared.
+	 */
+	PG_anon_exclusive = PG_mappedtodisk,
+
 	/* Filesystems */
 	PG_checked = PG_owner_priv_1,
 
@@ -176,7 +230,7 @@ enum pageflags {
 	 * Indicates that at least one subpage is hwpoisoned in the
 	 * THP.
 	 */
-	PG_has_hwpoisoned = PG_mappedtodisk,
+	PG_has_hwpoisoned = PG_waiters,
 #endif
 
 	/* non-lru isolated movable page */
@@ -920,6 +974,34 @@ extern bool is_free_buddy_page(struct page *page);
 
 __PAGEFLAG(Isolated, isolated, PF_ANY);
 
+static __always_inline int PageAnonExclusive(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
+	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
+	return test_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
+}
+
+static __always_inline void SetPageAnonExclusive(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(!PageAnon(page) || PageKsm(page), page);
+	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
+	set_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
+}
+
+static __always_inline void ClearPageAnonExclusive(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(!PageAnon(page) || PageKsm(page), page);
+	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
+	clear_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
+}
+
+static __always_inline void __ClearPageAnonExclusive(struct page *page)
+{
+	VM_BUG_ON_PGFLAGS(!PageAnon(page), page);
+	VM_BUG_ON_PGFLAGS(PageHuge(page) && !PageHead(page), page);
+	__clear_bit(PG_anon_exclusive, &PF_ANY(page, 1)->flags);
+}
+
 #ifdef CONFIG_MMU
 #define __PG_MLOCKED		(1UL << PG_mlocked)
 #else
diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 9fb990d95dab..1ff0b9e1e28e 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -1669,6 +1669,8 @@ void free_huge_page(struct page *page)
 	VM_BUG_ON_PAGE(page_mapcount(page), page);
 
 	hugetlb_set_page_subpool(page, NULL);
+	if (PageAnon(page))
+		__ClearPageAnonExclusive(page);
 	page->mapping = NULL;
 	restore_reserve = HPageRestoreReserve(page);
 	ClearHPageRestoreReserve(page);
diff --git a/mm/memory.c b/mm/memory.c
index 7b32f422798d..d01fab481134 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -3671,6 +3671,17 @@ vm_fault_t do_swap_page(struct vm_fault *vmf)
 		goto out_nomap;
 	}
 
+	/*
+	 * PG_anon_exclusive reuses PG_mappedtodisk for anon pages. A swap pte
+	 * must never point at an anonymous page in the swapcache that is
+	 * PG_anon_exclusive. Sanity check that this holds and especially, that
+	 * no filesystem set PG_mappedtodisk on a page in the swapcache. Sanity
+	 * check after taking the PT lock and making sure that nobody
+	 * concurrently faulted in this page and set PG_anon_exclusive.
+	 */
+	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
+	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
+
 	/*
 	 * Remove the swap entry and conditionally try to free up the swapcache.
 	 * We're already holding a reference on the page but haven't mapped it
diff --git a/mm/memremap.c b/mm/memremap.c
index 6aa5f0c2d11f..160ea92e4e17 100644
--- a/mm/memremap.c
+++ b/mm/memremap.c
@@ -478,6 +478,15 @@ void free_devmap_managed_page(struct page *page)
 
 	mem_cgroup_uncharge(page_folio(page));
 
+	/*
+	 * Note: we don't expect anonymous compound pages yet. Once supported
+	 * and we could PTE-map them similar to THP, we'd have to clear
+	 * PG_anon_exclusive on all tail pages.
+	 */
+	VM_BUG_ON_PAGE(PageAnon(page) && PageCompound(page), page);
+	if (PageAnon(page))
+		__ClearPageAnonExclusive(page);
+
 	/*
 	 * When a device_private page is freed, the page->mapping field
 	 * may still contain a (stale) mapping value. For example, the
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 7edc8e099b22..493acb967b7a 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1796,6 +1796,10 @@ static int unuse_pte(struct vm_area_struct *vma, pmd_t *pmd,
 		goto out;
 	}
 
+	/* See do_swap_page() */
+	BUG_ON(!PageAnon(page) && PageMappedToDisk(page));
+	BUG_ON(PageAnon(page) && PageAnonExclusive(page));
+
 	dec_mm_counter(vma->vm_mm, MM_SWAPENTS);
 	inc_mm_counter(vma->vm_mm, MM_ANONPAGES);
 	get_page(page);
diff --git a/tools/vm/page-types.c b/tools/vm/page-types.c
index b1ed76d9a979..381dcc00cb62 100644
--- a/tools/vm/page-types.c
+++ b/tools/vm/page-types.c
@@ -80,9 +80,10 @@
 #define KPF_SOFTDIRTY		40
 #define KPF_ARCH_2		41
 
-/* [48-] take some arbitrary free slots for expanding overloaded flags
+/* [47-] take some arbitrary free slots for expanding overloaded flags
  * not part of kernel API
  */
+#define KPF_ANON_EXCLUSIVE	47
 #define KPF_READAHEAD		48
 #define KPF_SLOB_FREE		49
 #define KPF_SLUB_FROZEN		50
@@ -138,6 +139,7 @@ static const char * const page_flag_names[] = {
 	[KPF_SOFTDIRTY]		= "f:softdirty",
 	[KPF_ARCH_2]		= "H:arch_2",
 
+	[KPF_ANON_EXCLUSIVE]	= "d:anon_exclusive",
 	[KPF_READAHEAD]		= "I:readahead",
 	[KPF_SLOB_FREE]		= "P:slob_free",
 	[KPF_SLUB_FROZEN]	= "A:slub_frozen",
@@ -472,6 +474,10 @@ static int bit_mask_ok(uint64_t flags)
 
 static uint64_t expand_overloaded_flags(uint64_t flags, uint64_t pme)
 {
+	/* Anonymous pages overload PG_mappedtodisk */
+	if ((flags & BIT(ANON)) && (flags & BIT(MAPPEDTODISK)))
+		flags ^= BIT(MAPPEDTODISK) | BIT(ANON_EXCLUSIVE);
+
 	/* SLOB/SLUB overload several page flags */
 	if (flags & BIT(SLAB)) {
 		if (flags & BIT(PRIVATE))
-- 
2.35.1


-- 
Thanks,

David / dhildenb

