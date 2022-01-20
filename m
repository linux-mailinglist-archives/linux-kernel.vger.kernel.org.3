Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71C6A495213
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 17:11:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376951AbiATQJd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 11:09:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376905AbiATQJZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 11:09:25 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6EF62C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 08:09:25 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=zJ6ZyTp9w0QanKEybJL1wVq2X76sHQEksAa3eQdzWn8=; b=BdPlRD8JRTV4pEZr0B5wQ6GBlA
        5mYj4H7KwJl8k+P9OLhNx39oUQUVqh+O27sCTpmIkm+3laShc0uHwi3ESZTbAcbFsbK12a56bqqVW
        +wS0fZHCsVHkYCgiKoiWn155QPo4VIyQ+JSiNhU+Yj3KxxovS450WqcFCcwS61YXCOJe5bFRRRKn+
        fTeCdKF0ZIBoYt3aO4RTRD5HjcMb82OKThQr6+LKuhjXCFMvx1JNAnF48K4d0Ixv712TKHHMR0m5U
        M9RdU5u/buAAfZruSUSUIpCoeOA8l2JnffatL7avPFWFnb17tMHUo3kEvA4n4Nw4QHXfo60S+HT4w
        Xy9rG1tw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1nAZzx-00EQ98-U9; Thu, 20 Jan 2022 16:09:17 +0000
Date:   Thu, 20 Jan 2022 16:09:17 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     David Hildenbrand <david@redhat.com>
Cc:     "zhangliang (AG)" <zhangliang5@huawei.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux-MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        wangzhigang17@huawei.com,
        Linus Torvalds <torvalds@linux-foundation.org>
Subject: Re: [PATCH] mm: reuse the unshared swapcache page in do_wp_page
Message-ID: <YemJLR08tsY4s/nN@casper.infradead.org>
References: <fb02087a-b102-c91e-ab65-fb02cc8ee0a2@huawei.com>
 <9cd7eee2-91fd-ddb8-e47d-e8585e5baa05@redhat.com>
 <b6df4f7f-c080-ad6c-d1ad-098115f016f3@huawei.com>
 <747ff31c-6c9e-df6c-f14d-c43aa1c77b4a@redhat.com>
 <Yel0BXVyj8uvsWJX@casper.infradead.org>
 <e2580cfa-a529-934d-861a-091c4a9714d4@redhat.com>
 <YemBl4ZVtJqtAVwV@casper.infradead.org>
 <759f9bc8-0b10-7f0f-28a6-f292bed9053f@redhat.com>
 <YemDry2rkD2VUcw9@casper.infradead.org>
 <88a8b1a3-232d-df9c-d7f6-0ea9f2dd4b36@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <88a8b1a3-232d-df9c-d7f6-0ea9f2dd4b36@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 20, 2022 at 04:51:47PM +0100, David Hildenbrand wrote:
> 
> >> Yes, we are talking past each other and no, I am talking about fully
> >> mapped THP, just mapped via PTEs.
> >>
> >> Please refer to our THP COW logic: do_huge_pmd_wp_page()
> > 
> > You're going to have to be a bit more explicit.  That's clearly handling
> > the case where there's a PMD mapping.  If there is _also_ a PTE mapping,
> > then obviously the page is mapped more than once and can't be reused!
> > 
> >>>
> >>>>> Anon THP is always going to start out aligned (and can be moved by
> >>>>> mremap()).  Arguably it should be broken up if it's moved so it can be
> >>>>> reformed into aligned THPs by khugepaged.
> >>>>
> >>>> Can you elaborate, I'm missing the point where something gets moved. I
> >>>> don't care about mremap() at all here.
> >>>>
> >>>>
> >>>> 1. You have a read-only, PTE mapped THP
> >>>> 2. Write fault on the THP
> >>>> 3. We PTE-map the THP because we run into a false positive in our COW
> >>>>    logic to handle COW on PTE
> >>>> 4. Write fault on the PTE
> >>>> 5. We always have to COW each and every sub-page and can never reuse,
> >>>>    because page_count() > 1
> >>>>
> >>>> That's essentially what reuse_swap_page() tried to handle before.
> >>>> Eventually optimizing for this is certainly the next step, but I'd like
> >>>> to document which effect the removal of reuse_swap_page() will have to THP.
> >>>
> >>> I'm talking about step 0.  How do we get a read-only, PTE-mapped THP?
> >>> Through mremap() or perhaps through an mprotect()/mmap()/munmap() that
> >>> failed to split the THP.
> >>
> >> do_huge_pmd_wp_page()
> > 
> > I feel you could be a little more verbose about what you think is
> > going on here.  Are you talking about the fallback: path where we
> > call __split_huge_pmd()?
> 
> Sorry, I was less verbose because I was just sending out the
> patch+description to Linus' reply and was assuming you're going to read
> it anyways ;)

This reply arrived before your reply to Linus ;-)  Anyway ...

> Yes, I'm speaking about exactly that fallback path.

OK, so in that fallback path, we're already determined the THP has
more than one reference to it (ok, maybe that extra reference was
temporary and now gone), but we've already split the PMD down into
PTEs, and COWed one of the other pages that was in the THP.  If
anything, we should be more aggressive about COWing the remaining
pages in the THP, not looking for reasons why we might be able to
avoid COWing this particular page.
