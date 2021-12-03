Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 38CEC46710F
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 05:21:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239850AbhLCEYs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Dec 2021 23:24:48 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:39349 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229777AbhLCEYr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Dec 2021 23:24:47 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638505284;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=U0DvXToWkjNdJ/hviORYDrqU29CNpTdKjgszLzYXKNA=;
        b=iKb4mh69S+oGa/ProVi3512lpH12IYk+0O886bw9gEz3h9pgLs6sbN1ZhTGA6tEK/2kUFZ
        crf+22x9/HMbrb13VFfg3WVN4ImaSEcjIo9kQkoBKbJePyfqfsZFebeRIeRRrrRz5FRk/z
        ul+Mi++6GHp/i4N9l2bO1Nhyze15LAw=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-501-JAKzsUNOO7qZ5VkvW0ux8w-1; Thu, 02 Dec 2021 23:21:22 -0500
X-MC-Unique: JAKzsUNOO7qZ5VkvW0ux8w-1
Received: by mail-wm1-f72.google.com with SMTP id 205-20020a1c00d6000000b003335d1384f1so2789770wma.3
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 20:21:22 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=U0DvXToWkjNdJ/hviORYDrqU29CNpTdKjgszLzYXKNA=;
        b=P/SB64NhHiP2/PW2R5Z5sjUX9q6QPhGx6+YrPr9HgG+DrqxBDbWTMqpGG9XtSGiCS6
         xqhhvtKNcExOwO9d+WXa/W7qa4fXGAY33qF25X3hGHiAGuV6UuMdDjaGjxfL6QyDjyKq
         kB3gkinbY62JHdg0CprLHdWvirPoHivbmtg8isKjH8coG/A2uS3pGDpba7XURn1aIVJh
         nJTkSnBRIHwZF+jTcEk+Fvya38MpT1GURqCtXz9XbW1dYLkI82P0QA+l7LlheASuJxuE
         J+yI5XAkrjCKDoDDcdy016Wik/WwcbOisKKpHHLaTlI+YUOikTFXgLvC/9DV/eD3M9Bx
         Ps7Q==
X-Gm-Message-State: AOAM532nal9+gGY3yfJfPvjT5Gd7+mH5S5Imd+9W9eKkQODOnZ6MMY3t
        UL93pH4X8nrvqCe9P+T/NZA+AM1YFlbZEOO9PnBUzvD8Q67BqJDQW2aOpkNuKX06UoqmZJtCM5s
        VihdHAz4h3RQ2IPFyTk70Esa0
X-Received: by 2002:a7b:c017:: with SMTP id c23mr11778181wmb.137.1638505281697;
        Thu, 02 Dec 2021 20:21:21 -0800 (PST)
X-Google-Smtp-Source: ABdhPJylxWV4mpD2tDaOEiuslxoimzq4PYi2YQm8Z/wgHD2G7olVBGDTmTAVQuBSN9IENsBZdAI1cw==
X-Received: by 2002:a7b:c017:: with SMTP id c23mr11778152wmb.137.1638505281489;
        Thu, 02 Dec 2021 20:21:21 -0800 (PST)
Received: from xz-m1.local ([64.64.123.26])
        by smtp.gmail.com with ESMTPSA id u13sm4241484wmq.14.2021.12.02.20.21.15
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 20:21:20 -0800 (PST)
Date:   Fri, 3 Dec 2021 12:21:12 +0800
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
Subject: Re: [PATCH v6 01/23] mm: Introduce PTE_MARKER swap entry
Message-ID: <YambOGGK/K7saiHM@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com>
 <20211115075522.73795-2-peterx@redhat.com>
 <11462319.U46FXHIEPT@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <11462319.U46FXHIEPT@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 02:30:00PM +1100, Alistair Popple wrote:
> On Monday, 15 November 2021 6:55:00 PM AEDT Peter Xu wrote:
> 
> [...]
> 
> > diff --git a/include/linux/swapops.h b/include/linux/swapops.h
> > index d356ab4047f7..5103d2a4ae38 100644
> > --- a/include/linux/swapops.h
> > +++ b/include/linux/swapops.h
> > @@ -247,6 +247,84 @@ static inline int is_writable_migration_entry(swp_entry_t entry)
> >  
> >  #endif
> >  
> > +typedef unsigned long pte_marker;
> > +
> > +#define  PTE_MARKER_MASK     (0)
> > +
> > +#ifdef CONFIG_PTE_MARKER
> > +
> > +static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> > +{
> > +	return swp_entry(SWP_PTE_MARKER, marker);
> > +}
> > +
> > +static inline bool is_pte_marker_entry(swp_entry_t entry)
> > +{
> > +	return swp_type(entry) == SWP_PTE_MARKER;
> > +}
> > +
> > +static inline pte_marker pte_marker_get(swp_entry_t entry)
> > +{
> > +	return swp_offset(entry) & PTE_MARKER_MASK;
> 
> I'm not sure the PTE_MARKER_MASK adds much, especially as we only have one
> user. I don't see a problem with open-coding these kind of checks (ie.

It's more or less a safety belt to make sure anything pte_marker_get() returned
will be pte_marker defined bits only.

> swp_offset(entry) & PTE_MARKER_UFFD_WP) as you kind of end up doing that anyway.
> Alternatively if you want helper functions I think it would be better to define
> them for each marker. Eg: is_pte_marker_uffd_wp().

Yes we can have something like is_pte_marker_uffd_wp(), I didn't do that
explicitly because I want us to be clear that pte_marker is a bitmask, so
calling "is_*" will be slightly opaque - strictly speaking it should be
"pte_marker_has_uffd_wp_bit()" if there will be more bits defined, but then the
name of the helper will look a bit odd too.  Hence I just keep the only
interface to fetch the whole marker and use "&" in the call sites to check.

> 
> > +}
> > +
> > +static inline bool is_pte_marker(pte_t pte)
> > +{
> > +	return is_swap_pte(pte) && is_pte_marker_entry(pte_to_swp_entry(pte));
> > +}
> > +
> > +#else /* CONFIG_PTE_MARKER */
> > +
> > +static inline swp_entry_t make_pte_marker_entry(pte_marker marker)
> > +{
> > +	/* This should never be called if !CONFIG_PTE_MARKER */
> 
> Can we leave this function undefined then? That way we will get an obvious
> build error.

We can, but then we need more macros to cover the common code.  E.g. currently
in hugetlb_change_protection() we have:

        /* None pte */
        if (unlikely(uffd_wp))
                /* Safe to modify directly (none->non-present). */
                set_huge_pte_at(mm, address, ptep,
                                make_pte_marker(PTE_MARKER_UFFD_WP));

If we drop this definition, to let it compile with !PTE_MARKER, we'll need:

+#ifdef PTE_MARKER
        /* None pte */
        if (unlikely(uffd_wp))
                /* Safe to modify directly (none->non-present). */
                set_huge_pte_at(mm, address, ptep,
                                make_pte_marker(PTE_MARKER_UFFD_WP));
+#endif

Comparing to adding macro checks over a few other places, I figured maybe it's
easier to define them in the header once then we proper WARN_ON_ONCE() if
triggered (while they should just never).

> 
> Overall I'm liking the swap entry approach a lot more than the special pte
> approach, but maybe that's just because I'm more familiar with special swap
> entries :-)

Swap entry solution is definitely cleaner to me if not considering wasting it
with one bit.

Operating on pte directly is actually slightly more challenging, because we
don't have the protection of is_swap_pte() anymore.  It can help shield out
quite some strange stuff due to the pte->swp level hierachy.

Thanks,

-- 
Peter Xu

