Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E3E2A49F618
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 10:17:35 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1347543AbiA1JRd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 04:17:33 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:55420 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S238113AbiA1JRc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 04:17:32 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1643361451;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=HELvDGfjkvgKy1/ohwPlGG55+ChCuadaIUai4Iw6WCU=;
        b=F07BhXihFDRJC0Xbqh9dDdqck0f6wtfSZYp/pbroZK5XtAAUt2lQfPmapl9ED/XmhkDpZs
        ps5bLHuR9vSxKg3bSdnbUK0hPHoUtu3K0nWV0XPcGBvV8dIxe14FdR351ELIXW7f1PU78Q
        zJAejgt87C07LcHGyTslfmYgH6DoDfI=
Received: from mail-pf1-f200.google.com (mail-pf1-f200.google.com
 [209.85.210.200]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-49-t_NdTEazPiGEtAEqWCPLvg-1; Fri, 28 Jan 2022 04:17:30 -0500
X-MC-Unique: t_NdTEazPiGEtAEqWCPLvg-1
Received: by mail-pf1-f200.google.com with SMTP id v3-20020a622f03000000b004c412d02ca3so3242349pfv.20
        for <linux-kernel@vger.kernel.org>; Fri, 28 Jan 2022 01:17:30 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=HELvDGfjkvgKy1/ohwPlGG55+ChCuadaIUai4Iw6WCU=;
        b=wNwLK4q+SZrSl6tUK9btTmUzpvE/Grx8Vu7A+KqZWrTQF8EHiCcXiSrMAtNQjD89aG
         QFRFHkTtpXXsbPk1iT1iyylsfx/cHmLIENCcP0vFWgO4TWRqUmybKJXEujttfHRn11SB
         aohr+iiGiBNRfSh2uIJ5svx0LyAWwLHRsm4HHumvnjA0JEGqN+eQP6VGTbkxrw7u/n2A
         XoP9rzS7i1IVwCuhqUu6ugYXpGT7PPzPEBeQKngwyihPjOlMrgFVV7tau41z8ZxF9iiM
         oSBEfA/kx+7ldxc1Iyl0w0JdmEPJ8Mk1dwMtpc4KJHj4kfdzYpu0yR/HS+9RS2tTPyh7
         Rl1Q==
X-Gm-Message-State: AOAM533B3JrHQmaOe9uWW3li9ViFJ7jVkbXkNq3Bc3NfgKkp/0EeenRW
        l3wQdksaxHHJR42q652XtMKxmrL3LPBhFlVs4XQXVi7ivJA7bC6LddF1dtG4uPxp2dm8/Pnlg/l
        3DOgXhhvlXWptqCw7rY9VXXvz
X-Received: by 2002:a62:b618:: with SMTP id j24mr7053571pff.42.1643361449168;
        Fri, 28 Jan 2022 01:17:29 -0800 (PST)
X-Google-Smtp-Source: ABdhPJwJUib2tg8TssIShjoWPInQTxWLqWGZsk7gmVYgnhQsPD7E9YoVX10D9JX6mFLaZs+6SCVmCQ==
X-Received: by 2002:a62:b618:: with SMTP id j24mr7053536pff.42.1643361448715;
        Fri, 28 Jan 2022 01:17:28 -0800 (PST)
Received: from xz-m1.local ([94.177.118.75])
        by smtp.gmail.com with ESMTPSA id h13sm5804420pfv.188.2022.01.28.01.17.24
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 28 Jan 2022 01:17:28 -0800 (PST)
Date:   Fri, 28 Jan 2022 17:17:21 +0800
From:   Peter Xu <peterx@redhat.com>
To:     David Hildenbrand <david@redhat.com>
Cc:     linux-mm@kvack.org, linux-kernel@vger.kernel.org,
        Alistair Popple <apopple@nvidia.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        John Hubbard <jhubbard@nvidia.com>,
        Hugh Dickins <hughd@google.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>
Subject: Re: [PATCH v3 3/4] mm: Change zap_details.zap_mapping into even_cows
Message-ID: <YfO0oRm3I+8We6u1@xz-m1.local>
References: <20220128045412.18695-1-peterx@redhat.com>
 <20220128045412.18695-4-peterx@redhat.com>
 <847ceb80-d379-b704-8b47-0d662468370b@redhat.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <847ceb80-d379-b704-8b47-0d662468370b@redhat.com>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 28, 2022 at 10:03:20AM +0100, David Hildenbrand wrote:
> On 28.01.22 05:54, Peter Xu wrote:
> > Currently we have a zap_mapping pointer maintained in zap_details, when it is
> > specified we only want to zap the pages that has the same mapping with what the
> > caller has specified.
> > 
> > But what we want to do is actually simpler: we want to skip zapping
> > private (COW-ed) pages in some cases.  We can refer to unmap_mapping_pages()
> > callers where we could have passed in different even_cows values.  The other
> > user is unmap_mapping_folio() where we always want to skip private pages.
> > 
> > According to Hugh, we used a mapping pointer for historical reason, as
> > explained here:
> > 
> >   https://lore.kernel.org/lkml/391aa58d-ce84-9d4-d68d-d98a9c533255@google.com/
> > 
> > Quotting partly from Hugh:
> 
> s/Quotting/Quoting/

Will fix.

> 
> > 
> >   Which raises the question again of why I did not just use a boolean flag
> >   there originally: aah, I think I've found why.  In those days there was a
> >   horrible "optimization", for better performance on some benchmark I guess,
> >   which when you read from /dev/zero into a private mapping, would map the zero
> >   page there (look up read_zero_pagealigned() and zeromap_page_range() if you
> >   dare).  So there was another category of page to be skipped along with the
> >   anon COWs, and I didn't want multiple tests in the zap loop, so checking
> >   check_mapping against page->mapping did both.  I think nowadays you could do
> >   it by checking for PageAnon page (or genuine swap entry) instead.
> > 
> > This patch replaced the zap_details.zap_mapping pointer into the even_cows
> > boolean, then we check it against PageAnon.
> > 
> > Suggested-by: Hugh Dickins <hughd@google.com>
> > Signed-off-by: Peter Xu <peterx@redhat.com>
> > ---
> >  mm/memory.c | 16 +++++++---------
> >  1 file changed, 7 insertions(+), 9 deletions(-)
> > 
> > diff --git a/mm/memory.c b/mm/memory.c
> > index 14d8428ff4db..ffa8c7dfe9ad 100644
> > --- a/mm/memory.c
> > +++ b/mm/memory.c
> > @@ -1309,8 +1309,8 @@ copy_page_range(struct vm_area_struct *dst_vma, struct vm_area_struct *src_vma)
> >   * Parameter block passed down to zap_pte_range in exceptional cases.
> >   */
> >  struct zap_details {
> > -	struct address_space *zap_mapping;	/* Check page->mapping if set */
> >  	struct folio *single_folio;	/* Locked folio to be unmapped */
> > +	bool even_cows;			/* Zap COWed private pages too? */
> >  };
> >  
> >  /* Whether we should zap all COWed (private) pages too */
> > @@ -1321,13 +1321,10 @@ static inline bool should_zap_cows(struct zap_details *details)
> >  		return true;
> >  
> >  	/* Or, we zap COWed pages only if the caller wants to */
> > -	return !details->zap_mapping;
> > +	return details->even_cows;
> >  }
> >  
> > -/*
> > - * We set details->zap_mapping when we want to unmap shared but keep private
> > - * pages. Return true if we should zap this page, false otherwise.
> > - */
> > +/* Decides whether we should zap this page with the page pointer specified */
> >  static inline bool should_zap_page(struct zap_details *details, struct page *page)
> >  {
> >  	/* If we can make a decision without *page.. */
> > @@ -1338,7 +1335,8 @@ static inline bool should_zap_page(struct zap_details *details, struct page *pag
> >  	if (!page)
> >  		return true;
> >  
> > -	return details->zap_mapping == page_rmapping(page);
> > +	/* Otherwise we should only zap non-anon pages */
> > +	return !PageAnon(page);
> >  }
> >  
> >  static unsigned long zap_pte_range(struct mmu_gather *tlb,
> > @@ -3403,7 +3401,7 @@ void unmap_mapping_folio(struct folio *folio)
> >  	first_index = folio->index;
> >  	last_index = folio->index + folio_nr_pages(folio) - 1;
> >  
> > -	details.zap_mapping = mapping;
> > +	details.even_cows = false;
> 
> Already initialized to 0 via struct zap_details details = { };
> 
> We could think about
> 
> struct zap_details details = {
> 	.single_folio = folio,
> };
> 
> >  	details.single_folio = folio;
> >  
> >  	i_mmap_lock_write(mapping);
> > @@ -3432,7 +3430,7 @@ void unmap_mapping_pages(struct address_space *mapping, pgoff_t start,
> >  	pgoff_t	first_index = start;
> >  	pgoff_t	last_index = start + nr - 1;
> >  
> > -	details.zap_mapping = even_cows ? NULL : mapping;
> > +	details.even_cows = even_cows;
> >  	if (last_index < first_index)
> >  		last_index = ULONG_MAX;
> >  
> 
> Eventually
> 
> struct zap_details details = {
> 	.even_cows = even_cows,
> };

I think in the very initial version I have had that C99 init format but I
dropped it for some reason, perhaps when rebasing to the single_page work to
avoid touching the existing code.

Since as you mentioned single_folio is another.. let's do the cleanup on top?

Thanks,

-- 
Peter Xu

