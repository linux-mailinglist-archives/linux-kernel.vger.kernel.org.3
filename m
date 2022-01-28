Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6510049FB68
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 15:12:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346969AbiA1OMy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 09:12:54 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1349010AbiA1OMu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 09:12:50 -0500
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EA1BDC061714
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:12:49 -0800 (PST)
Received: by mail-qk1-x729.google.com with SMTP id 13so5571822qkd.13
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 06:12:49 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=pW8HUtDpplimNLF2CLmh+/zR9BaFSxUrjVW3dcve0d0=;
        b=P5iuM96H9lqFOaxy1I2t3PcPe3JPR22lzIPkG1NUop8BYKaSiqy68S94/epPm/Q3dR
         QjH8cgSSLRMAEm0bcTPRN7kenWzcdpkT3uejuQse13CQbwlfzNirXS6pImmbutoWHjux
         SvhUop6MjuLyeoNDyFb3Z39uGOH3oPtYm7Ifmq0AX6viMA4jKdzK7O9QHtPJyzY7KBzb
         x0/dpvDGi3N8KnUOqAUWCC+4ME92e6YjOW1KkFO85KkHXiz9Q/ABmbwIAjQOgZCPfUN9
         5v794rewSg0AMcjOnl0EVGWUuQ+Quz4kdViTJiuHvzV/dj/62/4neBnz+F1StgZw0HoG
         W2Fg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=pW8HUtDpplimNLF2CLmh+/zR9BaFSxUrjVW3dcve0d0=;
        b=zDciKCevEVn6rRfvonOgBCsTkTH3mJCPzekwapu022EgEZmvK0eA55pZqLGXBsWa89
         VM7dacFtt0mW6odxCne+jlIoll6+LYEGpdimX5+V5KMus2ePdKw+jy5Lht7OxFRZJ6MS
         32B2U6+N89G1dD28DpgEefN2rxnhvvQhglYfBWOhcMzTAsPu5e1MLqqAt5Ps3UjRyBxf
         8M7qmn4gyVksrWPu+mh3LW5UQsE0kHsFqz1mDj45E+Qv9FegjEIWtgeQl2S/8pP7YejL
         8taPHgA6QPSnPCUQeITqSVdGtghefGWJTDo9Jl5F5HJ3ygcvZ1O1QYegNu7OxTu1/Cay
         vVZw==
X-Gm-Message-State: AOAM5315eZnCdB+7FjfaQGtRivm1mgN770JYj2shr/hhQhPXrkXH37Av
        wlDmh0QU5WhyU64YBAWZ1l+8HQ==
X-Google-Smtp-Source: ABdhPJx6W2a3Y5SkuhgE1UG03KL5xeW48BWJttjFLnCpEZdkTGp02saQeE6z+nGyCpTr4Itdmcr/YQ==
X-Received: by 2002:a05:620a:240a:: with SMTP id d10mr5865137qkn.670.1643379169097;
        Fri, 28 Jan 2022 06:12:49 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id 18sm2414040qka.126.2022.01.28.06.12.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 06:12:48 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nDRzb-007UIZ-8F; Fri, 28 Jan 2022 10:12:47 -0400
Date:   Fri, 28 Jan 2022 10:12:47 -0400
From:   Jason Gunthorpe <jgg@ziepe.ca>
To:     Peter Xu <peterx@redhat.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] mm: Fix invalid page pointer returned with FOLL_PIN gups
Message-ID: <20220128141247.GS8034@ziepe.ca>
References: <20220125033700.69705-1-peterx@redhat.com>
 <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
 <20220127004206.GP8034@ziepe.ca>
 <YfJjhop3senAUjue@xz-m1.local>
 <20220127152538.GQ8034@ziepe.ca>
 <YfNIjqPpty0YkLJP@xz-m1.local>
 <20220128023127.GR8034@ziepe.ca>
 <YfNiWHDYH0dtj9rK@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfNiWHDYH0dtj9rK@xz-m1.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 11:26:16AM +0800, Peter Xu wrote:

> diff --git a/mm/gup.c b/mm/gup.c
> index 8ebc04058e97..b3a109114968 100644
> +++ b/mm/gup.c
> @@ -439,10 +439,6 @@ static struct page *no_page_table(struct vm_area_struct *vma,
>  static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
>                 pte_t *pte, unsigned int flags)
>  {
> -       /* No page to get reference */
> -       if (flags & (FOLL_GET | FOLL_PIN))
> -               return -EFAULT;
> -
>         if (flags & FOLL_TOUCH) {
>                 pte_t entry = *pte;
> 
> Then the convertion will make sure it behaves like before.  There is a very
> slight side effect on FOLL_TOUCH above but it shouldn't be a major concern, at
> least not in the vfio use case

You mean that it touches the page even though it will not return the
page? This is what devmap is doing already :\

> IMHO the other site follow_devmap_pud() is tricker, because we can't simply
> remove the two lines here:

Sure, but I didn't ask to fix everything, just trend toward something
sane - if you drop the 4 line above then your patch will do what it
needs to do, we don't need to jump into devmap to fix this bug.

> -       /*
> -        * device mapped pages can only be returned if the
> -        * caller will manage the page reference count.
> -        *
> -        * At least one of FOLL_GET | FOLL_PIN must be set, so assert that here:
> -        */
> -       if (!(flags & (FOLL_GET | FOLL_PIN)))
> -               return ERR_PTR(-EEXIST);
> -
>         pfn += (addr & ~PUD_MASK) >> PAGE_SHIFT;
>         *pgmap = get_dev_pagemap(pfn, *pgmap);
>         if (!*pgmap)
> 
> Because with the old code we'll 100% return -EEXIST as long as we don't have
> GET|PIN (e.g. mlock), but then later when the two lines removed we'll start to
> try call get_dev_pagemap(), if it returned something we'll start to fetch the
> page.

This is part of the "return codes don't make any sense" I was
complaining about..

devmap has a populated PTE and a struct page, it shouldn't be
returning -EFAULT. Failure to get the struct page is either EEXIST or
NULL (take a fault to resolve the race).

[as we've discussed before the get_dev_pagemap shouldn't even be here
at all, I suppose this is why it is so weird looking]

> That part looks fine, __get_user_pages() will still continue but ignore the
> page* returned.

IMHO it would be clearer if the __get_user_pages() checked the struct
page zone and rejected the cases it doesn't want than to sprinkle
these checks all over the place based on PMD flags.

We want to go in this direction anyhow so we can remove the pmd_dax()
flag..

> But what if get_dev_pagemap() returned NULL?  Then we'll start to return
> -EFAULT where we used to constantly return -EEXIST.  

IHMO most of the EFAULTs in the walker call chain are pretty
questionable..

they should ideally be
EEXIST or NULL. eg why does get_gate_page() return EFAULT for a
non-present page? That should be NULL and faultin_page() should
generate the EFAULT

> > For instance, should we return -EEXIST in other cases like devmap and
> > more that have PTEs present but are not returnable? It is already
> > really confusing (and probably wrong) that we sometimes return NULL
> > for populated PTEs. NULL causes faultin_page() to be called on
> > something we already know is populated, seems like nonsense.
> 
> Could you elaborate what's the "return NULL" confusion you mentioned?

Returning null for a popoulated PTE as a permanent failure is
nonsense.

NULL means 'call faultin_page()', it should be used on populated pages
that ought to have a struct page but for some racy reason is
unavailable. The faultin should resolve that race and make the pte
either fully non-present or restore the struct page.

> > It is not about useful, it is about understandable and
> > consistency.. There should be clear rules about when and what errno to
> > return in every case, we should trend in that direction.
> 
> I see that both you and John has a strong preference on at least the
> WARN_ON_ONCE() in the patch.

Well, I wanted to see the WARN_ON_ONCE avoided by making it
unnecessary by construction, not just deleted :\
 
Jason
