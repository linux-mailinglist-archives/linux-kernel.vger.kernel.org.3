Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 381FC49DDC2
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 10:20:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238459AbiA0JUJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 04:20:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41540 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S235110AbiA0JUI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 04:20:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643275207;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=D90RcPe2iP0PJhb56Gwnt9wR3ymnukzeMLhlgOBOsAE=;
        b=RAt+ySqTz/431XcXXIQAWegNfTA20uNzLBdC+4MPRF1w6Wm8wLafH9vZknZSStUIOHvOC2
        9wJ+BFbxIHZUD5nGY2rzXAETnxPSaonQT8kJ0FZmCh37Bz/UtdhAPQyhYaTeBe4iqCZn8A
        S2BXY+gE6dNVmeo28lG5n9TiWazXHMI=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-jNQmOvA7Pg-5WByaLi-Cpg-1; Thu, 27 Jan 2022 04:20:05 -0500
X-MC-Unique: jNQmOvA7Pg-5WByaLi-Cpg-1
Received: by mail-wm1-f72.google.com with SMTP id j18-20020a05600c1c1200b0034aeea95dacso3886762wms.8
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 01:20:04 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=D90RcPe2iP0PJhb56Gwnt9wR3ymnukzeMLhlgOBOsAE=;
        b=6BBcCAsiUcY325aO6/mUNHe0aomlfEiA6UlZK/JXJ98OtA7B7mkkArMrPQHIJwYYU0
         ZGA2i29AYfxJQ2BSOGpQ29Ceiaf6OrkTzZOL6RRDG2d3hYUR7FGdOczH0/Sl6DwNdUwd
         zSl1+ZXq8tY8QgxAPyZpMtOaGzxdqYhezD6rmWPnEh3K/cH802+4SlIq6NsdOI3IaUqF
         69iw2uUfpbHXPlruHOHEZXnRSAr3abSSMjSBPAW4KYPdecFOodLtuxQLEshwAHBjFySE
         nhCInbyzKbbO4F/nGOs3TdbpqV1SWJJZ3WoLQ4p2CdkN8pqAGpU3/t029ztXLoHf43+v
         d+iQ==
X-Gm-Message-State: AOAM530nhcsM4xv2/tcl+ePZ2437ZgKF4AhgM2akNEUjEoXeE7L3hlkc
        XxCC/Fl6SIbBC1HVtBPGWOmfvnXEfXOXh8hd4QFDNQtuEAQ9jId2LsOERqOCBlDE9pVhBJAyiCe
        HacTB7LohV242nLyuo7BRmzks
X-Received: by 2002:adf:ed42:: with SMTP id u2mr2173938wro.519.1643275203623;
        Thu, 27 Jan 2022 01:20:03 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzImXo3+kGFtUKSYJ9XLCMH17wHTiavXdqjp17eDf6LfthOyYuCcsF6VJeC/6/KbiQqQPURDA==
X-Received: by 2002:adf:ed42:: with SMTP id u2mr2173911wro.519.1643275203266;
        Thu, 27 Jan 2022 01:20:03 -0800 (PST)
Received: from xz-m1.local ([85.203.46.170])
        by smtp.gmail.com with ESMTPSA id t1sm1920673wre.45.2022.01.27.01.19.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 01:20:02 -0800 (PST)
Date:   Thu, 27 Jan 2022 17:19:56 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Jason Gunthorpe <jgg@ziepe.ca>, John Hubbard <jhubbard@nvidia.com>
Cc:     John Hubbard <jhubbard@nvidia.com>, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Jan Kara <jack@suse.cz>,
        =?utf-8?B?SsOpcsO0bWU=?= Glisse <jglisse@redhat.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Alex Williamson <alex.williamson@redhat.com>
Subject: Re: [PATCH] mm: Fix invalid page pointer returned with FOLL_PIN gups
Message-ID: <YfJjhop3senAUjue@xz-m1.local>
References: <20220125033700.69705-1-peterx@redhat.com>
 <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
 <20220127004206.GP8034@ziepe.ca>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <20220127004206.GP8034@ziepe.ca>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi, Jason, John,

On Wed, Jan 26, 2022 at 08:42:06PM -0400, Jason Gunthorpe wrote:
> On Wed, Jan 26, 2022 at 04:15:02PM -0800, John Hubbard wrote:
> 
> > > We had that -EEXIST logic since commit 1027e4436b6a ("mm: make GUP handle pfn
> > > mapping unless FOLL_GET is requested") which seems very reasonable.  It could
> > > be that when we reworked GUP with FOLL_PIN we could have overlooked that
> > > special path in commit 3faa52c03f44 ("mm/gup: track FOLL_PIN pages"), even if
> > > that commit rightfully touched up follow_devmap_pud() on checking FOLL_PIN when
> > > it needs to return an -EEXIST.
> 
> It sounds like this commit was all about changing the behavior of
> follow_page()
> 
> It feels like that is another ill-fated holdover from the effort to
> make pageless DAX that doesn't exist anymore.
> 
> Can we safely drop it now?

Not quite familiar with the dax effort, but just to note again that this patch
fixes an immediate breakage, hence IMHO we should still merge it first (not
mention it's a one-liner..).

> 
> Regardless..
> 
> > > diff --git a/mm/gup.c b/mm/gup.c
> > > index f0af462ac1e2..8ebc04058e97 100644
> > > +++ b/mm/gup.c
> > > @@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
> > >   		pte_t *pte, unsigned int flags)
> > >   {
> > >   	/* No page to get reference */
> > > -	if (flags & FOLL_GET)
> > > +	if (flags & (FOLL_GET | FOLL_PIN))
> > >   		return -EFAULT;
> > 
> > Yes. This clearly fixes the problem that the patch describes, and also
> > clearly matches up with the Fixes tag. So that's correct.
> 
> It is a really confusing though, why not just always return -EEXIST
> here?

Because in current code GUP handles -EEXIST and -EFAULT differently?

We do early bail out on -EFAULT.  -EEXIST was first introduced in 2015 from
Kirill for not failing some mlock() or mmap(MAP_POPULATE) on dax (1027e4436b6).
Then in 2017 it got used again with pud-sized thp (a00cc7d9dd93d) on dax too.
They seem to service the same goal and it seems to be designed that -EEXIST
shouldn't fail GUP immediately.

> 
> The caller will always see the error code and refrain from trying to
> pin it and unwind upwards, just the same as -EFAULT. 
> 
> We shouldn't need to test the flags at this point at all.
> 
> > >   	if (flags & FOLL_TOUCH) {
> > > @@ -1181,7 +1181,13 @@ static long __get_user_pages(struct mm_struct *mm,
> > >   			/*
> > >   			 * Proper page table entry exists, but no corresponding
> > >   			 * struct page.
> > > +			 *
> > > +			 * Warn if we jumped over even with a valid **pages.
> > > +			 * It shouldn't trigger in practise, but when there's
> > > +			 * buggy returns on -EEXIST we'll warn before returning
> > > +			 * an invalid page pointer in the array.
> > >   			 */
> > > +			WARN_ON_ONCE(pages);
> > 
> > Here, however, I think we need to consider this a little more carefully,
> > and attempt to actually fix up this case. It is never going to be OK
> > here, to return a **pages array that has these little landmines of
> > potentially uninitialized pointers. And so continuing on *at all* seems
> > very wrong.
> 
> Indeed, it should just be like this:
> 
> @@ -1182,6 +1182,10 @@ static long __get_user_pages(struct mm_struct *mm,
>                          * Proper page table entry exists, but no corresponding
>                          * struct page.
>                          */
> +                       if (pages) {
> +                               page = ERR_PTR(-EFAULT);
> +                               goto out;
> +                       }
>                         goto next_page;
>                 } else if (IS_ERR(page)) {
>                         ret = PTR_ERR(page);

IIUC not failing -EEXIST immediately seems to be what we want.  We've discussed
the only (unless I overlooked something...) two sites that can return -EEXIST
in follow_page_mask() context; if it is triggered somewhere else unexpectedly
it is a programming error and needs fixing, imho.  Hence the gup code shouldn't
rely on the -EEXIST -> -EFAULT transition to work at all in any existing case.

From that POV, WARN_ON_ONCE() helps better on exposing an illegal return of
-EEXIST (as mentioned in the commit message) than the -EFAULT convertion, IMHO.

Thanks,

-- 
Peter Xu

