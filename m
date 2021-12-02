Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3C8BB465D3F
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:11:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345237AbhLBEO4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:14:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37668 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344656AbhLBEOx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:14:53 -0500
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 671D4C061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 20:11:28 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=OaBMbitmgEZNmXAV8f1LwzxghmeIu1lnXqfudDNWxHQ=; b=dgh3VQawoWcliXFV6oysLyGov1
        1KRPdaINHDE/kTfyc7+HOgBroutE4t8I8JLCyjqEKCZB46dGhXbfj2G0mH5B6i/2LbslkCItf3MeB
        zmFMwoponOBvaMaOrmlY02XkID88tpLgCkP6Ni/R7LFhS6wkhqCplDeLefJA1bJz3SvIyjl4pVQnm
        XOVS0qv/kuD1zvT+uKsWOvh0uFjdL4xsYBgDjgTY6zr8cBOk0vIUa1JTN8LXTlm8yOnq579vf6a7C
        BofUjuC1ZOmdVXEpOjvBF7zNiHhxtQd6Lnv2F+dHFA5V4a1g3prlf1une5UzgW1AL8dxn3ZnomOHu
        Wr5DpEEg==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1msdRE-002KU4-Pj; Thu, 02 Dec 2021 04:11:16 +0000
Date:   Thu, 2 Dec 2021 04:11:16 +0000
From:   Matthew Wilcox <willy@infradead.org>
To:     Jann Horn <jannh@google.com>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Subject: Re: [5.4 PATCH] mm/gup: Do not force a COW break on file-backed
 memory
Message-ID: <YahHZOnT1Uh41XnP@casper.infradead.org>
References: <20211201231757.332199-1-willy@infradead.org>
 <CAG48ez3YNCNZB7AktmRoYLsBQjwBdwueRUXbkFgNVMsgjmCTGA@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAG48ez3YNCNZB7AktmRoYLsBQjwBdwueRUXbkFgNVMsgjmCTGA@mail.gmail.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 02, 2021 at 04:51:47AM +0100, Jann Horn wrote:
> On Thu, Dec 2, 2021 at 12:18 AM Matthew Wilcox (Oracle)
> <willy@infradead.org> wrote:
> > Commit 17839856fd58 ("gup: document and work around "COW can break either
> > way" issue") forces a COW break, even for read-only GUP.  This interacts
> > badly with CONFIG_READ_ONLY_THP_FOR_FS as it tries to write to a read-only
> > PMD and follow_trans_huge_pmd() returns NULL which induces an endless
> > loop as __get_user_pages() interprets that as page-not-present, tries
> > to fault it in and retries the follow_page_mask().
> >
> > The issues fixed by 17839856fd58 don't apply to files.  We know which way
> > the COW breaks; the page cache keeps the original and any modifications
> > are private to that process.  There's no optimisation that allows a
> > process to reuse a file-backed MAP_PRIVATE page.  So we can skip the
> > breaking of the COW for file-backed mappings.
> >
> > This problem only exists in v5.4.y; other stable kernels either predate
> > CONFIG_READ_ONLY_THP_FOR_FS or they include commit a308c71bf1e6 ("mm/gup:
> > Remove enfornced COW mechanism").
> >
> > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > ---
> >  mm/gup.c | 3 ++-
> >  1 file changed, 2 insertions(+), 1 deletion(-)
> >
> > diff --git a/mm/gup.c b/mm/gup.c
> > index 3ef769529548..d55e02411010 100644
> > --- a/mm/gup.c
> > +++ b/mm/gup.c
> > @@ -176,7 +176,8 @@ static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
> >   */
> >  static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned int flags)
> >  {
> > -       return is_cow_mapping(vma->vm_flags) && (flags & FOLL_GET);
> > +       return is_cow_mapping(vma->vm_flags) && vma_is_anonymous(vma) &&
> > +               (flags & FOLL_GET);
> >  }
> 
> To be fully correct, the check would have to check for PageAnon(), not
> whether the mapping is anonymous, right? Since a private file mapping
> can still contain anonymous pages from a prior CoW?

Oh, right.  So parent process maps a file with MAP_PRIVATE, writes to
it, gets an anon page, forks.  Child stuffs the page into a pipe,
unmaps page.  Parent writes to page again, now child can read() the
modification?

The problem is that we don't even get to seeing the struct page with
the current code paths.  And we're looking for a fix for RO THP that's
less intrusive for v5.4 than backporting

09854ba94c6a ("mm: do_wp_page() simplification")
1a0cf26323c8 ("mm/ksm: Remove reuse_ksm_page()")
a308c71bf1e6 ("mm/gup: Remove enfornced COW mechanism")

The other patch we've been kicking around (and works) is:

 static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned
int flags)
 {
-       return is_cow_mapping(vma->vm_flags) && (flags & FOLL_GET);
+       return is_cow_mapping(vma->vm_flags) &&
+               (!(vma->vm_flags & VM_DENYWRITE)) && (flags & FOLL_GET);
 }

That limits the change to be only text pages.  Generally programs do
not write to their text pages, and they certainly don't write *secrets*
to their text pages; if somebody else can read it, that's probably not
a problem in the same way as writing to a page of heap.

