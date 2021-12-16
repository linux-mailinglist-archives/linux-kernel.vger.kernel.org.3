Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 856F0476A4D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 07:17:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234044AbhLPGRn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 01:17:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:41868 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S233788AbhLPGRm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 01:17:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639635461;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=JTAAipSdxplCwnfADSfkf6WRGcIFn/Xcf9agoPWCSvw=;
        b=Vv8P+x0IwOacAO3oF08p9rUceT5ez+6gM6a66B8o9WlG7e6QwI8EEGa9Rh6dGmDepnIgem
        MRgbZycTYbmqDb/2Lpa15RSBJ4atR+umMbnizLCTdh4WVyUe3aD6aNKwEfl+aD7YS18C9W
        xm4oAEPGTYhgQD1/jYJ4dtndC5u98Sk=
Received: from mail-wr1-f70.google.com (mail-wr1-f70.google.com
 [209.85.221.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-219-Y14nDjFfMWeFM-4SHXjbRQ-1; Thu, 16 Dec 2021 01:17:40 -0500
X-MC-Unique: Y14nDjFfMWeFM-4SHXjbRQ-1
Received: by mail-wr1-f70.google.com with SMTP id o4-20020adfca04000000b0018f07ad171aso6553170wrh.20
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 22:17:39 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=JTAAipSdxplCwnfADSfkf6WRGcIFn/Xcf9agoPWCSvw=;
        b=4fMl8yW6Z119TNdkZQKOkZmTDLWYVsf9SLg9e8ewexw6qlI6a1DtzXIC1yyVHhMwhu
         4NSN9f+3ocO2ruwllJUWl+ym/qMvxdhGk8Szd32bDrhZxF0JIN3ZzJR8plkKT0GgN/eA
         a8tXKb2VCG61E9Pj+GLpX23V0xvk9fAszFjo3vvpc9PeJ+70w2e1S5QuXNkL5/M4wbu9
         rYn22dHyo+dEHOGjdioowJjllIvTq/vbLRhvoArd1E74YP2Sh6uaiURNipxQuNTWiXV5
         YUqCEbBIV4GkTzGrdOSxX+1vOt+henAO0PbymvCJkVeQJ2B6c6WqRiQcKYp2ZRVKKxP2
         VWfg==
X-Gm-Message-State: AOAM531M5cs2u2FB99hnummGvPB460H23kYY+nn95uOsssHZUDqRqwmT
        q3feRrJDi5qTbvUltna68H9mDorq94MIukFFV4ScADgPn7RFZOtDA+us2oAp8RC4PvtSyG6PT8v
        oh7FJEafE7yXbfoeh/a9FB/NY
X-Received: by 2002:a1c:5445:: with SMTP id p5mr3340426wmi.137.1639635459014;
        Wed, 15 Dec 2021 22:17:39 -0800 (PST)
X-Google-Smtp-Source: ABdhPJx5F1AM8DC7VjDSGVSRjq6rFDGqOUuKdnL2Ii76RjwKADHFlTYDOytKoME8UxXfxV+cFxUN+g==
X-Received: by 2002:a1c:5445:: with SMTP id p5mr3340408wmi.137.1639635458780;
        Wed, 15 Dec 2021 22:17:38 -0800 (PST)
Received: from xz-m1.local ([64.64.123.12])
        by smtp.gmail.com with ESMTPSA id w8sm3924782wre.106.2021.12.15.22.17.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 22:17:38 -0800 (PST)
Date:   Thu, 16 Dec 2021 14:17:30 +0800
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
Subject: Re: [PATCH v6 06/23] mm/shmem: Handle uffd-wp special pte in page
 fault handler
Message-ID: <YbrZ+p8MPLdk/Lvi@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com>
 <20211115075522.73795-7-peterx@redhat.com>
 <6587740.tPqSsf18xI@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <6587740.tPqSsf18xI@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 04:56:42PM +1100, Alistair Popple wrote:
> On Monday, 15 November 2021 6:55:05 PM AEDT Peter Xu wrote:
> 
> [...]
> 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index d5966d9e24c3..e8557d43a87d 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -3452,6 +3452,43 @@ static vm_fault_t remove_device_exclusive_entry(struct vm_fault *vmf)
> >  	return 0;
> >  }
> >  
> > +static vm_fault_t pte_marker_clear(struct vm_fault *vmf)
> > +{
> > +	vmf->pte = pte_offset_map_lock(vmf->vma->vm_mm, vmf->pmd,
> > +				       vmf->address, &vmf->ptl);
> > +	/*
> > +	 * Be careful so that we will only recover a special uffd-wp pte into a
> > +	 * none pte.  Otherwise it means the pte could have changed, so retry.
> > +	 */
> > +	if (is_pte_marker(*vmf->pte))
> > +		pte_clear(vmf->vma->vm_mm, vmf->address, vmf->pte);
> > +	pte_unmap_unlock(vmf->pte, vmf->ptl);
> > +	return 0;
> > +}
> > +
> > +/*
> > + * This is actually a page-missing access, but with uffd-wp special pte
> > + * installed.  It means this pte was wr-protected before being unmapped.
> > + */
> > +static vm_fault_t pte_marker_handle_uffd_wp(struct vm_fault *vmf)
> > +{
> > +	/* Careful!  vmf->pte unmapped after return */
> > +	if (!pte_unmap_same(vmf))
> 
> Hasn't vmf->pte already been unmapped by do_swap_page() by the time we get
> here?

Great catch, thanks!

It was needed before with the "swap special pte" version because that was
handled outside do_swap_page().  After the rebase I forgot to remove it.

I believe it didn't crash simply because we've got commit 2ca99358671a ("mm:
clear vmf->pte after pte_unmap_same() returns", 2021-11-06) very recently so it
just became a safe no-op, so all things will still work.

I'll drop it.

> 
> > +		return 0;
> > +
> > +	/*
> > +	 * Just in case there're leftover special ptes even after the region
> > +	 * got unregistered - we can simply clear them.  We can also do that
> > +	 * proactively when e.g. when we do UFFDIO_UNREGISTER upon some uffd-wp
> > +	 * ranges, but it should be more efficient to be done lazily here.
> > +	 */
> > +	if (unlikely(!userfaultfd_wp(vmf->vma) || vma_is_anonymous(vmf->vma)))
> > +		return pte_marker_clear(vmf);
> > +
> > +	/* do_fault() can handle pte markers too like none pte */
> > +	return do_fault(vmf);
> > +}
> > +
> >  static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
> >  {
> >  	swp_entry_t entry = pte_to_swp_entry(vmf->orig_pte);
> > @@ -3465,8 +3502,11 @@ static vm_fault_t handle_pte_marker(struct vm_fault *vmf)
> >  	if (WARN_ON_ONCE(vma_is_anonymous(vmf->vma) || !marker))
> >  		return VM_FAULT_SIGBUS;
> >  
> > -	/* TODO: handle pte markers */
> > -	return 0;
> > +	if (marker & PTE_MARKER_UFFD_WP)
> 
> Can we make this check `marker == PTE_MARKER_UFFD_WP`? There is currently only
> one user of pte markers, and from what I can tell pte_marker_handle_uffd_wp()
> wouldn't do the correct thing if other users were added because it could clear
> non-uffd-wp markers. I don't think it's worth making it do the right thing now,
> but a comment noting that would be helpful.

Sure thing, and yeah I agree it's trivial and shouldn't matter in real-life.

I'll change it to "marker == PTE_MARKER_UFFD_WP" as you suggested, so if
there's surprise we'll get a sigbus.

Thanks,

> 
> > +		return pte_marker_handle_uffd_wp(vmf);
> > +
> > +	/* This is an unknown pte marker */
> > +	return VM_FAULT_SIGBUS;
> >  }

-- 
Peter Xu

