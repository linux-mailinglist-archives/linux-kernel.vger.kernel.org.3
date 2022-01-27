Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4885D49E5FD
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 16:25:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237455AbiA0PZr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 10:25:47 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237296AbiA0PZl (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 10:25:41 -0500
Received: from mail-qv1-xf34.google.com (mail-qv1-xf34.google.com [IPv6:2607:f8b0:4864:20::f34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC5F7C061714
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:25:40 -0800 (PST)
Received: by mail-qv1-xf34.google.com with SMTP id o9so3058773qvy.13
        for <linux-kernel@vger.kernel.org>; Thu, 27 Jan 2022 07:25:40 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=ziepe.ca; s=google;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:in-reply-to;
        bh=01nTXFi9SgWDzYJcR7cfPlKiH9k3njJK1816W1y8hvM=;
        b=jwPzjxzIwGCJOWitpalJJ4hk1VnpHBFvsKc8TDDXTfrJNqEx5ZyTbwP74nc+pyfEbS
         Q8TL8MM8KXOImBnER2cGbVufisfizVFaDxomUOquLe9bRi6mqR00d/bny1vmyYma1ayi
         08QTu+T4WBBWXkUd/BjmxTlrZ1LIbAMD3Rbhpw+l3rl3YDNO83UuTaUABlXbNQ2jcyTb
         JLsOgrhsebW40nQycd07NJbTy0OToeBWI89qyXMmUCgwBs6jqwSnX3U4EOBzEh04bKtc
         ksWA7DdHDAdmkuGbiQBsRhsO3U7mw+w0vVYlg2GHnfLjq5YauyvXlfucL1cRhfSulXVf
         Ee9w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=01nTXFi9SgWDzYJcR7cfPlKiH9k3njJK1816W1y8hvM=;
        b=OiEgC5Q1GTjsO4FzzJFfsqvn65bM6Hf17ldMOwDc4uF2bAjGXWw6mUku2KfpAxrCXc
         o3EnmSL2A4HJALWu+AAO0XQ491G5G2DLNcP4uc6e3WfCTQ/eiSbyFXdUxN32VoVRMWma
         6O/Y4dccOxdG2hSFG/5iZ7OKqLadWnvzgGCDlndSSmWf7UHsJDOgFKwZ8Zn+DP55RTz3
         ca8wx3voIgQk9Q5cvFsM3SpVyPVsy4t2P1Xx7Sv6RqWNpcRUZq+zylDThxRFSEa01C0T
         GFMZlpq/0gBh+DMpYA7eJIO4iE9RcJFLbjKlKQaj0QTRQhiOBwGg1oFv+Q9mAa2Uxu8v
         O6bQ==
X-Gm-Message-State: AOAM533F2tdugJKagWwgvmS59zgIWK8b8eYochw9i4/sEDek/M5usdxE
        rDBHp9FrvHeoFuiXaOD0hnQENQ==
X-Google-Smtp-Source: ABdhPJz4IMI6Co+Rr3F5Ew/nw2aicMV8fDTyHCn6Q5S8fZS74BiFgjGj6u/P0xhV31zH++3E+ARD5w==
X-Received: by 2002:ad4:5942:: with SMTP id eo2mr3648579qvb.29.1643297140104;
        Thu, 27 Jan 2022 07:25:40 -0800 (PST)
Received: from ziepe.ca (hlfxns017vw-142-162-113-129.dhcp-dynamic.fibreop.ns.bellaliant.net. [142.162.113.129])
        by smtp.gmail.com with ESMTPSA id k20sm1448791qtx.64.2022.01.27.07.25.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 27 Jan 2022 07:25:39 -0800 (PST)
Received: from jgg by mlx with local (Exim 4.94)
        (envelope-from <jgg@ziepe.ca>)
        id 1nD6eY-006Y5a-Lt; Thu, 27 Jan 2022 11:25:38 -0400
Date:   Thu, 27 Jan 2022 11:25:38 -0400
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
Message-ID: <20220127152538.GQ8034@ziepe.ca>
References: <20220125033700.69705-1-peterx@redhat.com>
 <f5400544-f602-0bb4-5cb1-5ac682e41974@nvidia.com>
 <20220127004206.GP8034@ziepe.ca>
 <YfJjhop3senAUjue@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <YfJjhop3senAUjue@xz-m1.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 27, 2022 at 05:19:56PM +0800, Peter Xu wrote:

> > > > diff --git a/mm/gup.c b/mm/gup.c
> > > > index f0af462ac1e2..8ebc04058e97 100644
> > > > +++ b/mm/gup.c
> > > > @@ -440,7 +440,7 @@ static int follow_pfn_pte(struct vm_area_struct *vma, unsigned long address,
> > > >   		pte_t *pte, unsigned int flags)
> > > >   {
> > > >   	/* No page to get reference */
> > > > -	if (flags & FOLL_GET)
> > > > +	if (flags & (FOLL_GET | FOLL_PIN))
> > > >   		return -EFAULT;
> > > 
> > > Yes. This clearly fixes the problem that the patch describes, and also
> > > clearly matches up with the Fixes tag. So that's correct.
> > 
> > It is a really confusing though, why not just always return -EEXIST
> > here?
> 
> Because in current code GUP handles -EEXIST and -EFAULT differently?

That has nothing to do with here. We shouldn't be deciding what the
top layer does way down here. Return the correct error code for what
was discovered at this layer the upper loop should make the decision
what it should do

> We do early bail out on -EFAULT.  -EEXIST was first introduced in 2015 from
> Kirill for not failing some mlock() or mmap(MAP_POPULATE) on dax (1027e4436b6).
> Then in 2017 it got used again with pud-sized thp (a00cc7d9dd93d) on dax too.
> They seem to service the same goal and it seems to be designed that -EEXIST
> shouldn't fail GUP immediately.

It must fail GUP immeidately if there is a pages list.

Callers that want an early failure must pass in NULL for pages, it is
just that simple. It has nothing to do with the FOLL flags.

A WARN_ON would be appropriate to compare the FOLL flags against the
pages. eg FOLL_GET without a pages is nonsense and should be
immediately aborted. On the other hand, we avoid this by construction
internal to gup.c

> > > Here, however, I think we need to consider this a little more carefully,
> > > and attempt to actually fix up this case. It is never going to be OK
> > > here, to return a **pages array that has these little landmines of
> > > potentially uninitialized pointers. And so continuing on *at all* seems
> > > very wrong.
> > 
> > Indeed, it should just be like this:
> > 
> > @@ -1182,6 +1182,10 @@ static long __get_user_pages(struct mm_struct *mm,
> >                          * Proper page table entry exists, but no corresponding
> >                          * struct page.
> >                          */
> > +                       if (pages) {
> > +                               page = ERR_PTR(-EFAULT);
> > +                               goto out;
> > +                       }
> >                         goto next_page;
> >                 } else if (IS_ERR(page)) {
> >                         ret = PTR_ERR(page);
> 
> IIUC not failing -EEXIST immediately seems to be what we want.

Which is what this does, for the only case it is acceptable - a null
page list.

> From that POV, WARN_ON_ONCE() helps better on exposing an illegal return of
> -EEXIST (as mentioned in the commit message) than the -EFAULT convertion, IMHO.

Again, that is upside down, -EEXIST should not be a illegal return. It
should be valid, have a defined meaning 'the vaddr exists but has no
struct page' and the top loop, and only the top loop, makes the
decision what to do about it.

Jason
