Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 12057488F43
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 05:26:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230460AbiAJEZu (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 23:25:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238514AbiAJEY2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 23:24:28 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89152C061751
        for <linux-kernel@vger.kernel.org>; Sun,  9 Jan 2022 20:24:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=Content-Transfer-Encoding:MIME-Version:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:In-Reply-To:References;
        bh=c2L1I+DzBtehfPSZQn1qXS87cPLZWHt8WVa3GahCeM4=; b=WhYNzq+abSf+DUdGbT06fryP5p
        A5gEECuziNmmmvjZtYtEVBw+1u1k8J0jgA2UTtxwb1WU5m4AWRWjITYcBOAtAbZGdgONFTRBnlqxP
        vVZCpMzCJnfU+GLw/t8ehhC8lScO6nCcc5B4C2x2f1MkaHZwaS67xacLkWs/37pnB3Xrt+Mwsn/2V
        FKujHyPyMjTX8wxDIFqTS5q6/8eDI5SAkqSTYtKZEOiZP5caVDAjCt09YH0KRwItbsmKKNtLXd60B
        wiwQV8h6MXtL3EXAxlRaqAPMLBtDxyofQ9Deow4ba4wMW7lYM5IxXuSWsIjLV/RBfNgioHY7pO8QH
        0ffMLnJg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1n6mE7-0025wQ-P4; Mon, 10 Jan 2022 04:24:11 +0000
From:   "Matthew Wilcox (Oracle)" <willy@infradead.org>
To:     linux-mm@kvack.org
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Christoph Hellwig <hch@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        linux-kernel@vger.kernel.org, Jason Gunthorpe <jgg@ziepe.ca>
Subject: [PATCH v2 00/28] Convert GUP to folios
Date:   Mon, 10 Jan 2022 04:23:38 +0000
Message-Id: <20220110042406.499429-1-willy@infradead.org>
X-Mailer: git-send-email 2.31.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch series is against my current folio for-next branch.  I know
it won't apply to sfr's next tree, and it's not for-next material yet.
I intend to submit it for 5.18 after I've rebased it to one of the
5.17-rc releases.

The overall effect of this (ignoring the primary "preparing for folios
that are not PAGE or PMD sized" purpose) is to reduce the size of gup.o
by ~700 bytes in the config I normally test with.

This patchset just converts existing implementations to use folios.
There's no new API for consumers here to provide information in a more
efficient (address, length) format.  That will be a separate patchset.

In v2, I've tried to address all the comments from the reviews I got
on v1.  Apologies if I missed anything; I got a lot of good feedback.
Primarily I separated out the folio changes (later) from the "While
I'm looking at this ..." changes (earlier).  I'm not sure the story
of the patchset is necessarily coherent this way, but it should be
easier to review.

Another big change is that compound_pincount is now available to all
compound pages, not just those that are order-2-or-higher.  Patch 11.

I did notice one bug in my original patchset which I'm disappointed GCC
didn't diagnose:

		pages[nr++] = nth_page(page, nr);

Given the massive reorg of the patchset, I didn't feel right using
anyone's SoB from v1 on any of the patches.  But, despite the increased
number of patches, I hope it's easier to review than v1.

And I'd dearly love a better name than 'folio_nth'.  page_nth() is
a temporary construct, so doesn't need a better name.  If you need
context, it's in the gup_folio_range_next() patch and its job
is to tell you, given a page and a folio, what # page it is within
a folio (so a number between [0 and folio_nr_pages())).

Matthew Wilcox (Oracle) (28):
  gup: Remove for_each_compound_range()
  gup: Remove for_each_compound_head()
  gup: Change the calling convention for compound_range_next()
  gup: Optimise compound_range_next()
  gup: Change the calling convention for compound_next()
  gup: Fix some contiguous memmap assumptions
  gup: Remove an assumption of a contiguous memmap
  gup: Handle page split race more efficiently
  gup: Turn hpage_pincount_add() into page_pincount_add()
  gup: Turn hpage_pincount_sub() into page_pincount_sub()
  mm: Make compound_pincount always available
  mm: Add folio_put_refs()
  mm: Add folio_pincount_ptr()
  mm: Convert page_maybe_dma_pinned() to use a folio
  gup: Add try_get_folio() and try_grab_folio()
  mm: Remove page_cache_add_speculative() and
    page_cache_get_speculative()
  gup: Add gup_put_folio()
  hugetlb: Use try_grab_folio() instead of try_grab_compound_head()
  gup: Convert try_grab_page() to call try_grab_folio()
  gup: Convert gup_pte_range() to use a folio
  gup: Convert gup_hugepte() to use a folio
  gup: Convert gup_huge_pmd() to use a folio
  gup: Convert gup_huge_pud() to use a folio
  gup: Convert gup_huge_pgd() to use a folio
  gup: Convert compound_next() to gup_folio_next()
  gup: Convert compound_range_next() to gup_folio_range_next()
  mm: Add isolate_lru_folio()
  gup: Convert check_and_migrate_movable_pages() to use a folio

 Documentation/core-api/pin_user_pages.rst |  18 +-
 arch/powerpc/include/asm/mmu_context.h    |   1 -
 include/linux/mm.h                        |  70 +++--
 include/linux/mm_types.h                  |  13 +-
 include/linux/pagemap.h                   |  11 -
 mm/debug.c                                |  14 +-
 mm/folio-compat.c                         |   8 +
 mm/gup.c                                  | 359 ++++++++++------------
 mm/hugetlb.c                              |   7 +-
 mm/internal.h                             |   8 +-
 mm/page_alloc.c                           |   3 +-
 mm/rmap.c                                 |   6 +-
 mm/vmscan.c                               |  43 ++-
 13 files changed, 263 insertions(+), 298 deletions(-)

-- 
2.33.0

