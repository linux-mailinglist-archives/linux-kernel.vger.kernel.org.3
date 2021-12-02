Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2268A465D73
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Dec 2021 05:34:44 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355485AbhLBEh4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 1 Dec 2021 23:37:56 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42746 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355360AbhLBEht (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 1 Dec 2021 23:37:49 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BD29DC061574
        for <linux-kernel@vger.kernel.org>; Wed,  1 Dec 2021 20:34:25 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id u22so52419689lju.7
        for <linux-kernel@vger.kernel.org>; Wed, 01 Dec 2021 20:34:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=KT4+ThzPToPwG8WHB54fTTopdp95Q9/t6ImLhzRoaVE=;
        b=Q+n7hXy3FuOw/95x9CZ85UjLLYFb9+vIMsq49bqo0+kLhCv6zEKc3BX5Wr/g7Fq63I
         Reaxon0EfvptNWPO+bqJMK2U+pKSAZklTP9uzJWF3JWyTRPaSSuX1d5F+vEvGnHUE9FZ
         cqwqlOKmZtvoqt4JnCQVs7MhynwPyW8HWWDa+Ys0zxJ664At5joWfiwbX4uIizNzox4v
         1LqtYUEUcL9ZvSWCXrGBQj8p/6I2Pg7jNBCXvdQCWjoT/7K0ucr4BVI68l8sOcqPO0R1
         hWQZoUags1bTjaigc9QChIDzSLRUAxCM7qGlYJHp03/cM4iNtoIjlkNYMiBKqmU2gqua
         2mag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=KT4+ThzPToPwG8WHB54fTTopdp95Q9/t6ImLhzRoaVE=;
        b=2NMA6iZINrB0kJUEsEo6HNehKwHKbLmg0TP5coLP3/S7zwDsB+aDqlg9VDWp+rY1AU
         R7TinlnOeult3hVdkwkskl7a/OP6RCQXjyS9/lqUHw7jKDjrkt8lwX/dYoXIwZTMTHgS
         2K8sFBbj/V4M9YrL+UlnidjjoCnevmaArfKsTxje4EdVHELHyp/BtdNp9uzeAXIAzhKy
         TuxIMGfK8Gn3qVh9CtMqf9dPtzLfjwjT2Fbai9E9rFa86MSCEENNBJxyUzBiUwZE9ZpI
         0/djK5AXmFHaFGH2oRG2AGzyllviZCmgFPI03/pLtX89DAbG8fMt09KRsE9mZRtzs/r2
         kgvA==
X-Gm-Message-State: AOAM5321dvDuh8b7kMemVmMuDFGtJO5TZ6c4GZGd1sLEaGrbfm++K3J3
        nYQLF+GtSIuihUteSKoU+I+knYExip0y8dAv67tBoA==
X-Google-Smtp-Source: ABdhPJxFsQTBROC0TdK8woZVFuKCiZHiiNEnW0O2qirGLrQJknz0//X0k9dM0v2xwX2cHpIWu2jT8nFBFBIQPkAeXqw=
X-Received: by 2002:a2e:95d2:: with SMTP id y18mr9274159ljh.93.1638419662807;
 Wed, 01 Dec 2021 20:34:22 -0800 (PST)
MIME-Version: 1.0
References: <20211201231757.332199-1-willy@infradead.org> <CAG48ez3YNCNZB7AktmRoYLsBQjwBdwueRUXbkFgNVMsgjmCTGA@mail.gmail.com>
 <YahHZOnT1Uh41XnP@casper.infradead.org>
In-Reply-To: <YahHZOnT1Uh41XnP@casper.infradead.org>
From:   Jann Horn <jannh@google.com>
Date:   Thu, 2 Dec 2021 05:33:56 +0100
Message-ID: <CAG48ez39USd-eKf_vQ78vqHEcM89pTwDE5-_DG5891Zt1VTWUA@mail.gmail.com>
Subject: Re: [5.4 PATCH] mm/gup: Do not force a COW break on file-backed memory
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Linus Torvalds <torvalds@linux-foundation.org>,
        Jan Kara <jack@suse.cz>,
        Kirill Shutemov <kirill@shutemov.name>,
        Oleg Nesterov <oleg@redhat.com>,
        Christoph Hellwig <hch@lst.de>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Mike Kravetz <mike.kravetz@oracle.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 2, 2021 at 5:11 AM Matthew Wilcox <willy@infradead.org> wrote:
> On Thu, Dec 02, 2021 at 04:51:47AM +0100, Jann Horn wrote:
> > On Thu, Dec 2, 2021 at 12:18 AM Matthew Wilcox (Oracle)
> > <willy@infradead.org> wrote:
> > > Commit 17839856fd58 ("gup: document and work around "COW can break either
> > > way" issue") forces a COW break, even for read-only GUP.  This interacts
> > > badly with CONFIG_READ_ONLY_THP_FOR_FS as it tries to write to a read-only
> > > PMD and follow_trans_huge_pmd() returns NULL which induces an endless
> > > loop as __get_user_pages() interprets that as page-not-present, tries
> > > to fault it in and retries the follow_page_mask().
> > >
> > > The issues fixed by 17839856fd58 don't apply to files.  We know which way
> > > the COW breaks; the page cache keeps the original and any modifications
> > > are private to that process.  There's no optimisation that allows a
> > > process to reuse a file-backed MAP_PRIVATE page.  So we can skip the
> > > breaking of the COW for file-backed mappings.
> > >
> > > This problem only exists in v5.4.y; other stable kernels either predate
> > > CONFIG_READ_ONLY_THP_FOR_FS or they include commit a308c71bf1e6 ("mm/gup:
> > > Remove enfornced COW mechanism").
> > >
> > > Signed-off-by: Matthew Wilcox (Oracle) <willy@infradead.org>
> > > ---
> > >  mm/gup.c | 3 ++-
> > >  1 file changed, 2 insertions(+), 1 deletion(-)
> > >
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index 3ef769529548..d55e02411010 100644
> > > --- a/mm/gup.c
> > > +++ b/mm/gup.c
> > > @@ -176,7 +176,8 @@ static inline bool can_follow_write_pte(pte_t pte, unsigned int flags)
> > >   */
> > >  static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned int flags)
> > >  {
> > > -       return is_cow_mapping(vma->vm_flags) && (flags & FOLL_GET);
> > > +       return is_cow_mapping(vma->vm_flags) && vma_is_anonymous(vma) &&
> > > +               (flags & FOLL_GET);
> > >  }
> >
> > To be fully correct, the check would have to check for PageAnon(), not
> > whether the mapping is anonymous, right? Since a private file mapping
> > can still contain anonymous pages from a prior CoW?
>
> Oh, right.  So parent process maps a file with MAP_PRIVATE, writes to
> it, gets an anon page, forks.  Child stuffs the page into a pipe,
> unmaps page.  Parent writes to page again, now child can read() the
> modification?

Yeah - in theory that could happen e.g. with an ELF's .data section?
Those end up as writable private file mappings.

(I don't know whether that actually has real-world relevance though,
I'm just saying it's semantically off in theory.)

> The problem is that we don't even get to seeing the struct page with
> the current code paths.  And we're looking for a fix for RO THP that's
> less intrusive for v5.4 than backporting
>
> 09854ba94c6a ("mm: do_wp_page() simplification")
> 1a0cf26323c8 ("mm/ksm: Remove reuse_ksm_page()")
> a308c71bf1e6 ("mm/gup: Remove enfornced COW mechanism")
>
> The other patch we've been kicking around (and works) is:
>
>  static inline bool should_force_cow_break(struct vm_area_struct *vma, unsigned
> int flags)
>  {
> -       return is_cow_mapping(vma->vm_flags) && (flags & FOLL_GET);
> +       return is_cow_mapping(vma->vm_flags) &&
> +               (!(vma->vm_flags & VM_DENYWRITE)) && (flags & FOLL_GET);
>  }
>
> That limits the change to be only text pages.  Generally programs do
> not write to their text pages, and they certainly don't write *secrets*
> to their text pages; if somebody else can read it, that's probably not
> a problem in the same way as writing to a page of heap.

Hm, yeah. It's not exactly beautiful, but I guess it should do the job
for fixing stable...

It's a good thing that VM_DENYWRITE still exists in the 5.4 branch. ^^
