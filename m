Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D10C8476ACA
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 08:07:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234322AbhLPHHJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 02:07:09 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:48002 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231839AbhLPHHI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 02:07:08 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639638427;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=nQ+Kpk46ja0vs/b2m8ekD9wFfyzwjf/LHl8S2lBKZxU=;
        b=BCHyM/Ki515VCy5NEQz6E3A8CETke1iDahXg87xhPe+u806swRxasb0ijf6OqcK81ld1Lp
        uDkBxxYVZxJM5WCqSlxxf9pvHeHdDwZJAP8EAm9PRv7STOENEv/9d0YW5g1IMC+Ln5TI/j
        h0/i7Kp6ZXdy4T5ohl3iys/nl2WzMwo=
Received: from mail-wr1-f69.google.com (mail-wr1-f69.google.com
 [209.85.221.69]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-473-8R2x-gYNOCy34im32VBGPA-1; Thu, 16 Dec 2021 02:07:05 -0500
X-MC-Unique: 8R2x-gYNOCy34im32VBGPA-1
Received: by mail-wr1-f69.google.com with SMTP id h7-20020adfaa87000000b001885269a937so6636392wrc.17
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 23:07:05 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=nQ+Kpk46ja0vs/b2m8ekD9wFfyzwjf/LHl8S2lBKZxU=;
        b=AWOaVQJoo0a1KqwJmtiG3qCHpw8VZGV5qy93zR8MUke7oJCheoh4WzIoFOBksYljL0
         86XJ9Pf3y4yKOnKI8d6+bpWLtkg+IQoAo7aZA78FkYIeHadLWdsFxSYB5sEamkeT+Qty
         x0LvPeLMPHEIr0gr3H7cf2D54F5UGY+eFDblEiPSWJ+czPXvHswmEwz0QF62ptu0F3ED
         CoGkGQB9vSzdm04s0BO6rAEpcqPzu54n6n92zJRnLtADGKJUxlP3CaFx0CIQ17W7nuZr
         YubIedidgWJ8fCC1TEaDMs24nXFpfaIT+yslXU72ZThyQfAFzCuB/0tUe6cPvWhdbtko
         Kq9g==
X-Gm-Message-State: AOAM532qXZJmXk0pm9Z0OCaJWMHSLwEbcS2dcZtx8Abn6kDCrbqRnSn0
        zdGwMEiHIPPpcWN2oauVCORIo7p04Nzx/tgR7h8lIW5sZSck4BoqZ+cBJdaPc+Dx5Bd3IQkvoaE
        +2VQGgPXPwhsATSP0a6r0X+OX
X-Received: by 2002:a1c:1b8c:: with SMTP id b134mr3573647wmb.44.1639638424523;
        Wed, 15 Dec 2021 23:07:04 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwav4mRKCNtGfR52yIgz6K6ln37TyJ5phqOa6m4S7cyT8hD9zfrRfGiph7ff3D1FA16sYT4rg==
X-Received: by 2002:a1c:1b8c:: with SMTP id b134mr3573628wmb.44.1639638424284;
        Wed, 15 Dec 2021 23:07:04 -0800 (PST)
Received: from xz-m1.local ([64.64.123.12])
        by smtp.gmail.com with ESMTPSA id a1sm5048409wri.89.2021.12.15.23.06.58
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 23:07:03 -0800 (PST)
Date:   Thu, 16 Dec 2021 15:06:54 +0800
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
Message-ID: <Ybrljg7nWppMpfMG@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com>
 <YbrQ2bsEYsfHrIIV@xz-m1.local>
 <YbrTtx7gtOX+ZCia@xz-m1.local>
 <1760244.MLhrlNdmRJ@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1760244.MLhrlNdmRJ@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 05:23:40PM +1100, Alistair Popple wrote:
> On Thursday, 16 December 2021 4:50:47 PM AEDT Peter Xu wrote:
> > On Thu, Dec 16, 2021 at 01:38:33PM +0800, Peter Xu wrote:
> > > On Thu, Dec 16, 2021 at 04:01:47PM +1100, Alistair Popple wrote:
> > > > On Monday, 15 November 2021 6:55:02 PM AEDT Peter Xu wrote:
> > > > > We used to check against none pte and in those cases orig_pte should always be
> > > > > none pte anyway.
> > > > 
> > > > Is that always true? From what I can see in handle_pte_fault() orig_pte only
> > > > gets initialised in the !pmd_none() case so might not be pte_none.
> > > 
> > > I believe it's true, otherwise I must have overlooked.
> > > 
> > > IMHO it's not "when we set orig_pte" that matters - note that finish_fault()
> > > (that this patch modifies) is only called for file-backed memories, and it's
> > > only called in do_fault() where the pte is not mapped at all.
> > > 
> > > DAX seems to call it too, but still DAX comes from do_fault() too, afaict.
> > > 
> > > The pte will not be mapped in two cases in handle_pte_fault():
> > > 
> > >   - When pmd_none
> > > 
> > >   - When !pmd_none, however if we find that pte_none==true, that's:
> > > 
> > >         if (pte_none(vmf->orig_pte)) {
> > >                 pte_unmap(vmf->pte);
> > >                 vmf->pte = NULL;
> > >         }
> > > 
> > > So when we're already in do_fault(), afaict, orig_pte must be pte_none().
> > > Another side note is that, IIUC pte_none() is a looser check than the
> > > pte_val()==0 and it should be arch dependent.
> > 
> > So one more thing I forgot to mention... Of course above is based on the fact
> > that orig_pte will be initialized to zero when creating vmf structure, and
> > that's done in __handle_mm_fault():
> > 
> > 	struct vm_fault vmf = {
> > 		.vma = vma,
> > 		.address = address & PAGE_MASK,
> > 		.flags = flags,
> > 		.pgoff = linear_page_index(vma, address),
> > 		.gfp_mask = __get_fault_gfp_mask(vma),
> > 	};
> > 
> > I'm not sure whether I should explicitly set it to pte_val(0), in most C
> > programs we'll already assume it's a proper reset of orig_pte value in c99
> > initialization format, but if anyone thinks we should do that explicitly plus
> > some comments I can do that too.
> 
> Ok, that was really my question. Is:
> 
> 	if (likely(pte_none(*vmf->pte)))
> 
> equivalent to:
> 
> 	if (likely(pte_same(*vmf->pte, __pte(0))))
> 
> for every architecture? Looking at Xtensa for example suggests it might not be:
> 
> arch/xtensa/include/asm/pgtable.h:
> # define pte_none(pte)	 (pte_val(pte) == (_PAGE_CA_INVALID | _PAGE_USER))

Yes, another good question...

I never expected arch that has pte_none(pte_val(0))==false.. but indeed xtensa
is one of them.  I digged a bit more, s390 seems to be the other one.

I wondered how it could have worked - I thought e.g. pte_alloc_one() will
always return a pgtable page will all zero-filled, whose allocation should
require __GFP_ZERO anyway.  But then I quickly noticed that pte_alloc_one() is
per-arch too..  That explains, because per-arch can re-initialize the default
pte values.

S390 re-initializes its pgtable pages in arch/s390/mm/pgalloc.c:

     unsigned long *page_table_alloc(struct mm_struct *mm)
        memset64((u64 *)table, _PAGE_INVALID, PTRS_PER_PTE);

While similarly xtensa has:

#define pte_clear(mm,addr,ptep)						\
	do { update_pte(ptep, __pte(_PAGE_CA_INVALID | _PAGE_USER)); } while (0)

The solution should be simple - I could re-introduce FAULT_FLAG_UFFD_WP.  That
flag used to exist in older versions, e.g. this is v1 of current patchset where
it is defined:

https://lore.kernel.org/lkml/20210323004912.35132-6-peterx@redhat.com/

I thought this patch can greatly simplify things but I overlooked the
pte_none() check you mentioned.  So it seems I have no good choice but add that
flag back.

There's another alternative is we do pte_clear() on vmf->orig_pte as the new
way to initialize it.  I believe it should work too for s390 and xtensa.

Any preference?

Thanks,

> 
> > > 
> > > Thanks,
> > > 
> > > > 
> > > > > This change prepares us to be able to call do_fault() on !none ptes.  For
> > > > > example, we should allow that to happen for pte marker so that we can restore
> > > > > information out of the pte markers.
> > > > > 
> > > > > Signed-off-by: Peter Xu <peterx@redhat.com>
> > > > > ---
> > > > >  mm/memory.c | 2 +-
> > > > >  1 file changed, 1 insertion(+), 1 deletion(-)
> > > > > 
> > > > > diff --git a/mm/memory.c b/mm/memory.c
> > > > > index 04662b010005..d5966d9e24c3 100644
> > > > > --- a/mm/memory.c
> > > > > +++ b/mm/memory.c
> > > > > @@ -4052,7 +4052,7 @@ vm_fault_t finish_fault(struct vm_fault *vmf)
> > > > >  				      vmf->address, &vmf->ptl);
> > > > >  	ret = 0;
> > > > >  	/* Re-check under ptl */
> > > > > -	if (likely(pte_none(*vmf->pte)))
> > > > > +	if (likely(pte_same(*vmf->pte, vmf->orig_pte)))
> > > > >  		do_set_pte(vmf, page, vmf->address);
> > > > >  	else
> > > > >  		ret = VM_FAULT_NOPAGE;
> > > > > 
> > > > 
> > > > 
> > > > 
> > > > 
> > > 
> > 
> > 
> 
> 
> 
> 

-- 
Peter Xu

