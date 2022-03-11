Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CFEEC4D6AD5
	for <lists+linux-kernel@lfdr.de>; Sat, 12 Mar 2022 00:27:17 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229834AbiCKWzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 17:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34718 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiCKWyk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 17:54:40 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7F9442BE122
        for <linux-kernel@vger.kernel.org>; Fri, 11 Mar 2022 14:28:23 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=SzKX99Cocy/lwgU3tnCH1Vt8ZkKR8jjaQaAMFI9xwxc=; b=nRWaKR4qwPKfFozcskyUoAynnV
        jv/gIbaWr0G1z+JE77V8iiPRV4WKN1S/2xymJG5jcRHfRLh0T4A8ZwzHeWyOk2n35+GEh71diCwg5
        izPd/42UPCFqErRfIqqh4r2DBmO+RZFwI3Aff8KbvJASbG2Nt/5RLYEkCtHUubuTyFL6iqDpqQWxa
        m/XbgA9zah0cwIIsuevRuaOp0n8DvPWmwaWpdPpyTfpfx6x/Rz1LahjBDgObRj+5KZdKS1EZYABGF
        peDL4T18VlLbtMm2XFEcPyDDKr9z5MwBNw2Kiu7AH1eX3vDM2iLu/s0aomnYK3GXY4qDeFA/YCtiY
        VjyL3oUA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nSmOp-001uVY-CC; Fri, 11 Mar 2022 21:02:11 +0000
Date:   Fri, 11 Mar 2022 21:02:11 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
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
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
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
Subject: Re: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as
 PG_anon_exclusive for PageAnon() pages
Message-ID: <Yiu400H9JNtC03Co@casper.infradead.org>
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-11-david@redhat.com>
 <a0bd6f52-7bb5-0c32-75c8-2c7c592c2d6d@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <a0bd6f52-7bb5-0c32-75c8-2c7c592c2d6d@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Mar 11, 2022 at 07:46:39PM +0100, David Hildenbrand wrote:
> I'm currently testing with the following. My tests so far with a swapfile on
> all different kinds of weird filesystems (excluding networking fs, though)
> revealed no surprises so far:

I like this a lot better than reusing PG_swap.  Thanks!

I'm somewhat reluctant to introduce a new flag that can be set on tail
pages.  Do we lose much if it's always set only on the head page?

> +++ b/include/linux/page-flags.h
> @@ -142,6 +142,60 @@ enum pageflags {
>  
>  	PG_readahead = PG_reclaim,
>  
> +	/*
> +	 * Depending on the way an anonymous folio can be mapped into a page
> +	 * table (e.g., single PMD/PUD/CONT of the head page vs. PTE-mapped
> +	 * THP), PG_anon_exclusive may be set only for the head page or for
> +	 * subpages of an anonymous folio.
> +	 *
> +	 * PG_anon_exclusive is *usually* only expressive in combination with a
> +	 * page table entry. Depending on the page table entry type it might
> +	 * store the following information:
> +	 *
> +	 *	Is what's mapped via this page table entry exclusive to the
> +	 *	single process and can be mapped writable without further
> +	 *	checks? If not, it might be shared and we might have to COW.
> +	 *
> +	 * For now, we only expect PTE-mapped THPs to make use of
> +	 * PG_anon_exclusive in subpages. For other anonymous compound
> +	 * folios (i.e., hugetlb), only the head page is logically mapped and
> +	 * holds this information.
> +	 *
> +	 * For example, an exclusive, PMD-mapped THP only has PG_anon_exclusive
> +	 * set on the head page. When replacing the PMD by a page table full
> +	 * of PTEs, PG_anon_exclusive, if set on the head page, will be set on
> +	 * all tail pages accordingly. Note that converting from a PTE-mapping
> +	 * to a PMD mapping using the same compound page is currently not
> +	 * possible and consequently doesn't require care.
> +	 *
> +	 * If GUP wants to take a reliable pin (FOLL_PIN) on an anonymous page,
> +	 * it should only pin if the relevant PG_anon_bit is set. In that case,
> +	 * the pin will be fully reliable and stay consistent with the pages
> +	 * mapped into the page table, as the bit cannot get cleared (e.g., by
> +	 * fork(), KSM) while the page is pinned. For anonymous pages that
> +	 * are mapped R/W, PG_anon_exclusive can be assumed to always be set
> +	 * because such pages cannot possibly be shared.
> +	 *
> +	 * The page table lock protecting the page table entry is the primary
> +	 * synchronization mechanism for PG_anon_exclusive; GUP-fast that does
> +	 * not take the PT lock needs special care when trying to clear the
> +	 * flag.
> +	 *
> +	 * Page table entry types and PG_anon_exclusive:
> +	 * * Present: PG_anon_exclusive applies.
> +	 * * Swap: the information is lost. PG_anon_exclusive was cleared.
> +	 * * Migration: the entry holds this information instead.
> +	 *		PG_anon_exclusive was cleared.
> +	 * * Device private: PG_anon_exclusive applies.
> +	 * * Device exclusive: PG_anon_exclusive applies.
> +	 * * HW Poison: PG_anon_exclusive is stale and not changed.
> +	 *
> +	 * If the page may be pinned (FOLL_PIN), clearing PG_anon_exclusive is
> +	 * not allowed and the flag will stick around until the page is freed
> +	 * and folio->mapping is cleared.
> +	 */

... I also don't think this is the right place for this comment.  Not
sure where it should go.

> +static __always_inline void SetPageAnonExclusive(struct page *page)
> +{
> +	VM_BUG_ON_PGFLAGS(!PageAnon(page) || PageKsm(page), page);

hm.  seems to me like we should have a PageAnonNotKsm which just
does
	return ((unsigned long)page->mapping & PAGE_MAPPING_FLAGS) ==
			PAGE_MAPPING_ANON;
because that's "a bit" inefficient.  OK, that's just a VM_BUG_ON,
but we have other users in real code:

mm/migrate.c:   if (PageAnon(page) && !PageKsm(page))
mm/page_idle.c: need_lock = !PageAnon(page) || PageKsm(page);
mm/rmap.c:      if (!is_locked && (!PageAnon(page) || PageKsm(page))) {

