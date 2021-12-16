Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38F174769E5
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 06:51:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230172AbhLPFvC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:51:02 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48347 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229711AbhLPFvA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:51:00 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639633859;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=XJ16aaddk0IskgGChPHNllZ5/FTCKcwfaGzYXjxHG3s=;
        b=bWzfwrmZz945s37a3ECPe2AChqdqWXWDObHssEAUc7aPQUQGxHIb2uWexqEkBe67TKrwcy
        xlErwXD9aNzf70D6SxtAdSS2eFP6R9oR6mD0HBogDoTOrvimQXH+wE5+FqnqMg5XJA/ejg
        j4t1LpclGWn64eFA67hYH+GfaZ09nFc=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-417-QCnvxBo3MzerfKWENVPpdA-1; Thu, 16 Dec 2021 00:50:58 -0500
X-MC-Unique: QCnvxBo3MzerfKWENVPpdA-1
Received: by mail-wr1-f70.google.com with SMTP id s23-20020adf9797000000b001a24674f0f7so88352wrb.9
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 21:50:58 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=XJ16aaddk0IskgGChPHNllZ5/FTCKcwfaGzYXjxHG3s=;
        b=PLeSM5HrM+h0TCzRrtklaKJNUsAXSYZF00MGcVmOuXattJRO46/UDtjVXpagmghozC
         o64kz2DLrSBKrXXUrZvRZMWc5vIIjp/HvyOUDdM4o+3S74/VSszuDFmkE9v8q2z5oan3
         WJRXsYsmT8B/75M6w01vg/tScYslCAYQTfDc1CvaZD3kiym4Csv9rfjKNIOwbdN4ClwW
         8htKgxhFVrlt9KRoiAORn/2nPvirJN6FGPO8GmjmpcimgJGRwRazLzTCc0TNvcoUbR4/
         dsYrbmKRZnL98kuaP/bwBCIjlBKJfGer/dngTGxgn4bEyBFq1zX0H1SFulwRQWd+5ZKK
         yb0g==
X-Gm-Message-State: AOAM532MMLTBMq6vNk18sUr4z+gkmGLZCMluRozxVL0yxwOgWPbvy+vM
        gyI0j5JhUcbM3xsKRCSYQ2xScnfZYMkyQAva3zLWJngW1viQ7bYxKxn673P+h9LRbEriYmi1pa7
        7nY/HBk+hwHgv8hkChvKzv9ci
X-Received: by 2002:a05:600c:3c8a:: with SMTP id bg10mr3377279wmb.106.1639633856686;
        Wed, 15 Dec 2021 21:50:56 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzTNseQ2yXKap40Rqqicn+6SuZGW7QXCaMxBJD7KzDF0oiX8vRTe84g8uFp+8cFIQT9hrGDfg==
X-Received: by 2002:a05:600c:3c8a:: with SMTP id bg10mr3377261wmb.106.1639633856467;
        Wed, 15 Dec 2021 21:50:56 -0800 (PST)
Received: from xz-m1.local ([64.64.123.12])
        by smtp.gmail.com with ESMTPSA id r7sm3701875wrq.29.2021.12.15.21.50.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 21:50:55 -0800 (PST)
Date:   Thu, 16 Dec 2021 13:50:47 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Alistair Popple <apopple@nvidia.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Axel Rasmussen <axelrasmussen@google.com>,
        Nadav Amit <nadav.amit@gmail.com>,
        Mike Rapoport <rppt@linux.vnet.ibm.com>,
        Hugh Dickins <hughd@google.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Jerome Glisse <jglisse@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>
Subject: Re: [PATCH v6 03/23] mm: Check against orig_pte for finish_fault()
Message-ID: <YbrTtx7gtOX+ZCia@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com>
 <20211115075522.73795-4-peterx@redhat.com>
 <6260997.DYpkEd5BTb@nvdebian>
 <YbrQ2bsEYsfHrIIV@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YbrQ2bsEYsfHrIIV@xz-m1.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 01:38:33PM +0800, Peter Xu wrote:
> On Thu, Dec 16, 2021 at 04:01:47PM +1100, Alistair Popple wrote:
> > On Monday, 15 November 2021 6:55:02 PM AEDT Peter Xu wrote:
> > > We used to check against none pte and in those cases orig_pte should always be
> > > none pte anyway.
> > 
> > Is that always true? From what I can see in handle_pte_fault() orig_pte only
> > gets initialised in the !pmd_none() case so might not be pte_none.
> 
> I believe it's true, otherwise I must have overlooked.
> 
> IMHO it's not "when we set orig_pte" that matters - note that finish_fault()
> (that this patch modifies) is only called for file-backed memories, and it's
> only called in do_fault() where the pte is not mapped at all.
> 
> DAX seems to call it too, but still DAX comes from do_fault() too, afaict.
> 
> The pte will not be mapped in two cases in handle_pte_fault():
> 
>   - When pmd_none
> 
>   - When !pmd_none, however if we find that pte_none==true, that's:
> 
>         if (pte_none(vmf->orig_pte)) {
>                 pte_unmap(vmf->pte);
>                 vmf->pte = NULL;
>         }
> 
> So when we're already in do_fault(), afaict, orig_pte must be pte_none().
> Another side note is that, IIUC pte_none() is a looser check than the
> pte_val()==0 and it should be arch dependent.

So one more thing I forgot to mention... Of course above is based on the fact
that orig_pte will be initialized to zero when creating vmf structure, and
that's done in __handle_mm_fault():

	struct vm_fault vmf = {
		.vma = vma,
		.address = address & PAGE_MASK,
		.flags = flags,
		.pgoff = linear_page_index(vma, address),
		.gfp_mask = __get_fault_gfp_mask(vma),
	};

I'm not sure whether I should explicitly set it to pte_val(0), in most C
programs we'll already assume it's a proper reset of orig_pte value in c99
initialization format, but if anyone thinks we should do that explicitly plus
some comments I can do that too.

> 
> Thanks,
> 
> > 
> > > This change prepares us to be able to call do_fault() on !none ptes.  For
> > > example, we should allow that to happen for pte marker so that we can restore
> > > information out of the pte markers.
> > > 
> > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > ---
> > >  mm/memory.c | 2 +-
> > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > 
> > > diff --git a/mm/memory.c b/mm/memory.c
> > > index 04662b010005..d5966d9e24c3 100644
> > > --- a/mm/memory.c
> > > +++ b/mm/memory.c
> > > @@ -4052,7 +4052,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> > >  				      vmf->address, &vmf->ptl);
> > >  	ret = 0;
> > >  	/* Re-check under ptl */
> > > -	if (likely(pte_none(*vmf->pte)))
> > > +	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
> > >  		do_set_pte(vmf, page, vmf->address);
> > >  	else
> > >  		ret = VM_FAULT_NOPAGE;
> > > 
> > 
> > 
> > 
> > 
> 
> -- 
> Peter Xu

-- 
Peter Xu

