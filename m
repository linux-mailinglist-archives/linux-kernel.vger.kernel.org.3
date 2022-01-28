Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9D20249F09A
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 02:36:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345136AbiA1Bg0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 20:36:26 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:23908 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235209AbiA1Bg0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 20:36:26 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643333785;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JcYKtS421ws0gC+d9NqwTyqIBwVVHbKtxBormtVmgOQ=;
        b=Rl22Y9aQHQAjo/r7m9DgUcGuBaOLbPNWvbuTB1B20C5wTYLzkweOSeVUcBJGEqr1JZ6AiW
        16SHwpVE7IaFGE/4SCrYQhODEb2t6YS72clg3TqnA/vXZiNBbzpbL736ErpZocK6njLSV7
        ssyy9ABUBBaSKKJoTEMej+nuA0RzM9k=
Received: from mail-wm1-f69.google.com (mail-wm1-f69.google.com
 [209.85.128.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-447-tAissa03MxauhYCuSBocXQ-1; Thu, 27 Jan 2022 20:36:24 -0500
X-MC-Unique: tAissa03MxauhYCuSBocXQ-1
Received: by mail-wm1-f69.google.com with SMTP id s190-20020a1ca9c7000000b00347c6c39d9aso2258266wme.5
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 17:36:23 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JcYKtS421ws0gC+d9NqwTyqIBwVVHbKtxBormtVmgOQ=;
        b=bM++s5MrmjFvttwD2ygBKyFZYJ88byYboe0TVz+ekphSALEKV/G4sitV5XUKRSdP4B
         NI20y7JXQ6n+V0ZWMqx6vkN2hWag7xILeaKVSEdszQfFeN32xVtOHl5EjMG7/puBD2aY
         tOA5jHxsihaZHfj4nqxPkMfhwEo691Vks/LWWo+cy1EBblGPb3PUNzmH+kMLE/KleNgk
         XmERZl/JMEGCopTpO1jLCqxUIBFvF79CFpTguey1E2knh/xROb2tqSA0oHX/SjJJ3YqU
         Qb4+vUmTYtAldi1aJuIMDMrKNTTNP9CYjiJfTrsOmjUMSeSBr3zRLTMV9vtzjNbOul2d
         6FiQ==
X-Gm-Message-State: AOAM5309iy2aAMXno+gtU13oYjpIporX/kFb9Azyup+us4p+cXJVk4ye
        hiZv2mS1jeYcgtCywyDALzwUIoZsTKw8pKnVFaVSeKpYYgVOaU3A0SoycLfqdGCzt9fm7u2J85z
        RhS4pbZTq03aGdW5gVvWS+A+V
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr5230157wri.700.1643333782837;
        Thu, 27 Jan 2022 17:36:22 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw+hI5kCTICGWtlKGl7cRSb69fbDbnUyNCyIAHUqHS4kKgcVWKvvMjpxzsrRpePTXKPGiDEcA==
X-Received: by 2002:a5d:64e2:: with SMTP id g2mr5230140wri.700.1643333782535;
        Thu, 27 Jan 2022 17:36:22 -0800 (PST)
Received: from xz-m1.local ([64.64.123.9])
        by smtp.gmail.com with ESMTPSA id m6sm3903137wrw.54.2022.01.27.17.36.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 17:36:22 -0800 (PST)
Date:   Fri, 28 Jan 2022 09:36:14 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] mm: Fix invalid page pointer returned with FOLL_PIN gups
Message-ID: <YfNIjqPpty0YkLJP@xz-m1.local>
References: <20220125033700.69705-1-peterx@redhat.com>
 <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
 <20220127004206.GP8034@ziepe.ca>
 <YfJjhop3senAUjue@xz-m1.local>
 <20220127152538.GQ8034@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127152538.GQ8034@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 11:25:38AM -0400, Jason Gunthorpe wrote:
> On Thu, Jan 27, 2022 at 05:19:56PM +0800, Peter Xu wrote:
> 
> > > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > > index f0af462ac1e2..8ebc04058e97 100644
> > > > > +++ b/mm/gup.c
> > > > > @@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
> > > > >   		pte_t *pte, unsigned int flags)
> > > > >   {
> > > > >   	/* No page to get reference */
> > > > > -	if (flags & FOLL_GET)
> > > > > +	if (flags & (FOLL_GET | FOLL_PIN))
> > > > >   		return -EFAULT;
> > > > 
> > > > Yes. This clearly fixes the problem that the patch describes, and also
> > > > clearly matches up with the Fixes tag. So that's correct.
> > > 
> > > It is a really confusing though, why not just always return -EEXIST
> > > here?
> > 
> > Because in current code GUP handles -EEXIST and -EFAULT differently?
> 
> That has nothing to do with here. We shouldn't be deciding what the
> top layer does way down here. Return the correct error code for what
> was discovered at this layer the upper loop should make the decision
> what it should do
> 
> > We do early bail out on -EFAULT.  -EEXIST was first introduced in 2015 from
> > Kirill for not failing some mlock() or mmap(MAP_POPULATE) on dax (1027e4436b6).
> > Then in 2017 it got used again with pud-sized thp (a00cc7d9dd93d) on dax too.
> > They seem to service the same goal and it seems to be designed that -EEXIST
> > shouldn't fail GUP immediately.
> 
> It must fail GUP immeidately if there is a pages list.

Right, but my point is we don't have an user at all for follow_page_mask()
returning -EEXIST with a **page which is non-NULL.  Or did I miss it?

> 
> Callers that want an early failure must pass in NULL for pages, it is
> just that simple. It has nothing to do with the FOLL flags.
> 
> A WARN_ON would be appropriate to compare the FOLL flags against the
> pages. eg FOLL_GET without a pages is nonsense and should be
> immediately aborted. On the other hand, we avoid this by construction
> internal to gup.c

We have something like that already, although it's only a VM_BUG_ON() not a
BUG_ON() or WARN_ON() at the entry of __get_user_pages():

	VM_BUG_ON(!!pages != !!(gup_flags & (FOLL_GET | FOLL_PIN)));

> 
> > > > Here, however, I think we need to consider this a little more carefully,
> > > > and attempt to actually fix up this case. It is never going to be OK
> > > > here, to return a **pages array that has these little landmines of
> > > > potentially uninitialized pointers. And so continuing on *at all* seems
> > > > very wrong.
> > > 
> > > Indeed, it should just be like this:
> > > 
> > > @@ -1182,6 +1182,10 @@ static long __get_user_pages(struct mm_struct *mm,
> > >                          * Proper page table entry exists, but no corresponding
> > >                          * struct page.
> > >                          */
> > > +                       if (pages) {
> > > +                               page = ERR_PTR(-EFAULT);
> > > +                               goto out;
> > > +                       }
> > >                         goto next_page;
> > >                 } else if (IS_ERR(page)) {
> > >                         ret = PTR_ERR(page);
> > 
> > IIUC not failing -EEXIST immediately seems to be what we want.
> 
> Which is what this does, for the only case it is acceptable - a null
> page list.
> 
> > From that POV, WARN_ON_ONCE() helps better on exposing an illegal return of
> > -EEXIST (as mentioned in the commit message) than the -EFAULT convertion, IMHO.
> 
> Again, that is upside down, -EEXIST should not be a illegal return. It
> should be valid, have a defined meaning 'the vaddr exists but has no
> struct page' and the top loop, and only the top loop, makes the
> decision what to do about it.

I believe this works too and I think I get your point, but as stated above it's
just not used yet so the path is not useful to any real code path.

Especially with above VM_BUG_ON() it means if we'll go into the "if (pages)" we
should have already triggered the VM_BUG_ON() condition when entering the function.

Thanks,

-- 
Peter Xu

