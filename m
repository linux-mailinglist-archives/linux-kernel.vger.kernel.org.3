Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A239B4AF416
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:29:21 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235015AbiBIO3L (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:29:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233010AbiBIO3I (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:29:08 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 50538C06157B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:29:12 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=eIF08KcMpl5r29rPiQe9+6ZkSSpvO+hinKiqWMtDBSw=; b=oj44LeKt1qxycyFeTCQRMXiQqd
        4VhwfEU3oOTLW+gPnSCXOuyJT4uiRmzCJo6lHaioJ88h04fktbf61OSYQeO9gafWkZNshRMa9/eSl
        0ImOQoptpWW/k8aD8/4EaWgAZNUjL7ooSRDHy7vkBtjGzqLxp+cKz6paZQsNqL5Khem5GftWcXbNw
        EgTpQiFfeOGaJAUiNVcklqkzxhb/U/2BWNaXERwgF4cX1Yev583OCBmcZaKH0xMT/lCb5UjMTCTUp
        snHr5CedN/FAthzUI+5fvM+/cf3nPSR75ZWYYOD2Zo7Yq0LKYHjVL/WvVDb0SNQfz9ENetNZjUyN6
        eBXAL6tA==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nHny1-007w0y-Cn; Wed, 09 Feb 2022 14:29:09 +0000
Date:   Wed, 9 Feb 2022 14:29:09 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Mauricio Faria de Oliveira <mfo@canonical.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 51/75] mm/rmap: Convert try_to_unmap() to take a folio
Message-ID: <YgPPtW9V3opFHMwx@casper.infradead.org>
References: <20220204195852.1751729-1-willy@infradead.org>
 <20220204195852.1751729-52-willy@infradead.org>
 <CAO9xwp2+3Sh-X8xcukLxp5NE3pLWTx=KqVhivDB33W1Xci7uHQ@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAO9xwp2+3Sh-X8xcukLxp5NE3pLWTx=KqVhivDB33W1Xci7uHQ@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Feb 09, 2022 at 11:24:34AM -0300, Mauricio Faria de Oliveira wrote:
> Hi Andrew and Matthew,
> 
> On Fri, Feb 4, 2022 at 5:00 PM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> >
> > Change both callers and the worker function try_to_unmap_one().
> ...
> > diff --git a/mm/rmap.c b/mm/rmap.c
> ...
> > @@ -1598,8 +1602,8 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >                         }
> >
> >                         /* MADV_FREE page check */
> > -                       if (!PageSwapBacked(page)) {
> > -                               if (!PageDirty(page)) {
> > +                       if (!folio_test_swapbacked(folio)) {
> > +                               if (!folio_test_dirty(folio)) {
> >                                         /* Invalidate as we cleared the pte */
> >                                         mmu_notifier_invalidate_range(mm,
> >                                                 address, address + PAGE_SIZE);
> > @@ -1608,11 +1612,11 @@ static bool try_to_unmap_one(struct page *page, struct vm_area_struct *vma,
> >                                 }
> >
> >                                 /*
> > -                                * If the page was redirtied, it cannot be
> > +                                * If the folio was redirtied, it cannot be
> >                                  * discarded. Remap the page to page table.
> >                                  */
> >                                 set_pte_at(mm, address, pvmw.pte, pteval);
> > -                               SetPageSwapBacked(page);
> > +                               folio_set_swapbacked(folio);
> >                                 ret = false;
> >                                 page_vma_mapped_walk_done(&pvmw);
> >                                 break;
> ...
> 
> This conflicts with patch [1], currently in mmotm, and I'll send
> another version anyway.
> Should that patch be on top of these folio changes, or the other way around?

Andrew and I need to resolve conflicts between this series and other
patches in his tree.  You don't need to worry about this.

> The latter would help w/ the stable backports that don't have folios
> yet, but I can
> send backports there as well; not a problem.
> 
> Thanks,
> 
> [1] https://lkml.kernel.org/r/20220131230255.789059-1-mfo@canonical.com
> [PATCH v3] mm: fix race between MADV_FREE reclaim and blkdev direct IO read
> 
> -- 
> Mauricio Faria de Oliveira
> 
