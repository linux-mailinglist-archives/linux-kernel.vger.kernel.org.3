Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BAAF94D321A
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 16:47:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234007AbiCIPsU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 10:48:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51862 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234003AbiCIPsS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 10:48:18 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 281971168F1
        for <linux-kernel@vger.kernel.org>; Wed,  9 Mar 2022 07:47:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=vdXuYfWNlEBg1jF0U/VHbVW6m5OcNyEz8mZI/FExkbw=; b=qcUqrSnLtKP0UOdF/f/90gHPzs
        5YqFS2JldCVs7P0mTAzAmkVZZIquCsZzw65pQqhXex549NsY8fbJb3sCJkuNSbKtUQFF1jH0RIhx1
        S/6M67/4wmdoHSEYDsgEGkPOX+ZB5IVv3lCDCBi/egOC3T1TNTFoWh8/E95tfyK4XDV7lBH/L7fdt
        zPHEDnZ8c/TFrCchddtYNy4ImRfU9CkLH6p0LmFtwMJkk7EpLvu9YNJwxf0XVRMboS/q1++0fKvs8
        RX9z51Dfd92hI706KHgQm5EwIT7dex+W560h22tLkK2+G26wUsMtKJ11V0ZjMZOjZ7Mh+4koVSy00
        ZU3Bgolg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nRyWo-00HFIK-HN; Wed, 09 Mar 2022 15:47:06 +0000
Date:   Wed, 9 Mar 2022 15:47:06 +0000
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
        Oded Gabbay <oded.gabbay@gmail.com>, linux-mm@kvack.org,
        Alexander Potapenko <glider@google.com>
Subject: Re: [PATCH v1 10/15] mm/page-flags: reuse PG_slab as
 PG_anon_exclusive for PageAnon() pages
Message-ID: <YijL+qwc/Y1kmlnj@casper.infradead.org>
References: <20220308141437.144919-1-david@redhat.com>
 <20220308141437.144919-11-david@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <20220308141437.144919-11-david@redhat.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Mar 08, 2022 at 03:14:32PM +0100, David Hildenbrand wrote:
> The basic question we would like to have a reliable and efficient answer
> to is: is this anonymous page exclusive to a single process or might it
> be shared?

Is this supposed to be for PAGE_SIZE pages as well, or is it only used
on pages > PAGE_SIZE?

> In an ideal world, we'd have a spare pageflag. Unfortunately, pageflags
> don't grow on trees, so we have to get a little creative for the time
> being.

This feels a little _too_ creative to me.  There's now an implicit
requirement that SL[AOU]B doesn't use the bottom two bits of
->slab_cache, which is probably OK but would need to be documented.

I have plans to get rid of PageError and PagePrivate, but those are going
to be too late for you.  I don't think mappedtodisk has meaning for anon
pages, even if they're in the swapcache.  It would need PG_has_hwpoisoned
to shift to another bit ... but almost any bit will do for has_hwpoisoned.
Or have I overlooked something?

> @@ -920,6 +976,70 @@ extern bool is_free_buddy_page(struct page *page);
>  
>  __PAGEFLAG(Isolated, isolated, PF_ANY);
>  
> +static __always_inline bool folio_test_slab(struct folio *folio)
> +{
> +	return !folio_test_anon(folio) &&
> +	       test_bit(PG_slab, folio_flags(folio, FOLIO_PF_NO_TAIL));
> +}
> +
> +static __always_inline int PageSlab(struct page *page)
> +{
> +	return !PageAnon(page) &&
> +		test_bit(PG_slab, &PF_NO_TAIL(page, 0)->flags);
> +}

In case we do end up using this, this would be better implemented as

static __always_inline int PageSlab(struct page *page)
{
	return folio_test_slab(page_folio(page));
}

since PageAnon already has a page_folio() call embedded in it.

> +static __always_inline void __SetPageSlab(struct page *page)
> +{
> +	VM_BUG_ON_PGFLAGS(PageAnon(page), page);
> +	__set_bit(PG_slab, &PF_NO_TAIL(page, 1)->flags);
> +}

There's only one caller of __SetPageSlab() left, in kfence.  And that
code looks ... weird.

        for (i = 0; i < KFENCE_POOL_SIZE / PAGE_SIZE; i++) {
                if (!i || (i % 2))
                        continue;

                /* Verify we do not have a compound head page. */
                if (WARN_ON(compound_head(&pages[i]) != &pages[i]))
                        goto err;

                __SetPageSlab(&pages[i]);

I think the author probably intended WARN_ON(PageCompound(page)) because
they're actually verifying that it's not a tail page, rather than head
page.

> +static __always_inline void __ClearPageSlab(struct page *page)
> +{
> +	VM_BUG_ON_PGFLAGS(PageAnon(page), page);
> +	__clear_bit(PG_slab, &PF_NO_TAIL(page, 1)->flags);
> +}

There are no remaining callers of __ClearPageSlab().  yay.

