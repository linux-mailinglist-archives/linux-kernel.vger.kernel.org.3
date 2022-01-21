Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 16556495917
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 06:19:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229831AbiAUFLl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 00:11:41 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:33728 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229608AbiAUFLk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 00:11:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1642741899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=L0wOMdBYCyHlL69KsDd6YPdAUhkVTm6hlziUz50KanQ=;
        b=RhmzszADGXsHu+YCINZp7IU7r1ZbOdmmFr++7LU/YoXVwx7D6OZ4eGxpATLE7aL3SU4rSm
        /0hkLRsCTNuI14f/B1ymCL8LajliDN8jkre0Y2LrM205jg3LM/leuwKUnNLL4KO9obO2jD
        wZq4OloWb6hRioRG0iJ/YcNdhIzFXFg=
Received: from mail-pg1-f198.google.com (mail-pg1-f198.google.com
 [209.85.215.198]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-50-FHHKSs1kMn-6PnCdiQ8SVg-1; Fri, 21 Jan 2022 00:11:38 -0500
X-MC-Unique: FHHKSs1kMn-6PnCdiQ8SVg-1
Received: by mail-pg1-f198.google.com with SMTP id g12-20020a63200c000000b00342cd03227aso4996249pgg.19
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 21:11:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=L0wOMdBYCyHlL69KsDd6YPdAUhkVTm6hlziUz50KanQ=;
        b=ht0fAiUDzoMjA7VOskK4smoeWbsy/MPRZulZzb1mqX1qKIs7cFv/ba1f1mk4pUmttk
         CJS9ssS3n72J5hgt6bRqb4SKnATputLneCuXsmVb2PDbkO11mG8mHnF2TCT6DQLGEg82
         8FzfpsPpSSRWr8rUI4CmExGXTj/vPXqJyqny3kkWbVYVPgqyWRU7GEYmtAMwQRLOoUsG
         A+zkZb57tP55zaMZwhzXrsG6+8cEbNiAQjtHByvpxxnxUUHawoMxcFlxGvMdSs+6r3Zi
         DXsuLH3HJghmc5+to+8SO18mNpl8J47NLGf5vY+stT87kyEKPDI2tBkQTAt59yOfklIh
         FmSA==
X-Gm-Message-State: AOAM532lW1m+V/xBtg1r342qZhazb7k05NUIGAnzcfGMw8Aa3szlS9/8
        riW8kU1/iidsftjdAKiA2MYX1j2k6ytojrIwCgDyO1Oy8oiiRUUrOwfTpiQVV1T13slTFqNNNgt
        j+bEywB7GgleBq89LhOXVUCNL
X-Received: by 2002:a17:902:ce8d:b0:14a:70dc:2050 with SMTP id f13-20020a170902ce8d00b0014a70dc2050mr2244417plg.11.1642741897052;
        Thu, 20 Jan 2022 21:11:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzRcsiVOFuX+avW7yYJ2HGJbIr7G7j9yQrgquRGZxjg0u6Uup+RYwh35T8s1mSwkgOQ53IHjw==
X-Received: by 2002:a17:902:ce8d:b0:14a:70dc:2050 with SMTP id f13-20020a170902ce8d00b0014a70dc2050mr2244386plg.11.1642741896537;
        Thu, 20 Jan 2022 21:11:36 -0800 (PST)
Received: from xz-m1.local ([94.177.118.81])
        by smtp.gmail.com with ESMTPSA id n4sm3778295pjf.0.2022.01.20.21.11.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 20 Jan 2022 21:11:35 -0800 (PST)
Date:   Fri, 21 Jan 2022 13:11:28 +0800
From:   Peter Xu <peterx@redhat.com>
To:     Hugh Dickins <hughd@google.com>
Cc:     linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        David Hildenbrand <david@redhat.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Yang Shi <shy828301@gmail.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Andrew Morton <akpm@linux-foundation.org>,
        Alistair Popple <apopple@nvidia.com>,
        "Kirill A . Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>
Subject: Re: [PATCH RFC v2 1/2] mm: Don't skip swap entry even if zap_details
 specified
Message-ID: <YepAgBz4EUXc/jrM@xz-m1.local>
References: <20211115134951.85286-1-peterx@redhat.com>
 <20211115134951.85286-2-peterx@redhat.com>
 <9937aaa-d9ab-2839-b0b7-691d85c9141@google.com>
 <Yd7VEXI+/Lu8MVOo@xz-m1.local>
 <Yd7W6ndSPkXQjurY@xz-m1.local>
 <391aa58d-ce84-9d4-d68d-d98a9c533255@google.com>
 <Yek6PaW8fAXY4Bft@xz-m1.local>
 <YeokbrpCdAGAYHEl@xz-m1.local>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <YeokbrpCdAGAYHEl@xz-m1.local>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jan 21, 2022 at 11:11:42AM +0800, Peter Xu wrote:
> On Thu, Jan 20, 2022 at 06:32:29PM +0800, Peter Xu wrote:
> > > Except that here we have no page to check, so it looks like you'll
> > > have to change should_zap_page() to deal with this case too, or just
> > > check details->check_mapping directly.
> > 
> > Yeah I prefer this, as we don't have the page* pointer anyway.
> > 
> > > Which raises the question again
> > > of why I did not just use a boolean flag there originally: aah, I think
> > > I've found why.  In those days there was a horrible "optimization", for
> > > better performance on some benchmark I guess, which when you read from
> > > /dev/zero into a private mapping, would map the zero page there (look
> > > up read_zero_pagealigned() and zeromap_page_range() if you dare).  So
> > > there was another category of page to be skipped along with the anon
> > > COWs, and I didn't want multiple tests in the zap loop, so checking
> > > check_mapping against page->mapping did both.  I think nowadays you
> > > could do it by checking for PageAnon page (or genuine swap entry)
> > > instead.
> > 
> > It must be PageAnon already, isn't it?
> 
> I think I see what you meant now..
> 
> I assume the special case is gone, how about I switch zap_mappings back into
> a boolean altogether in this patchset?  Thanks,

Oh, one more thing..

When reading the history and also your explanations above, I figured one thing
that may not be right for a long time, on zero page handling of zapping.

If to quote your comment above, we should keep the zero page entries too if
zap_details.zap_mapping is specified.  However it's not true for a long time, I
guess starting from when vm_normal_page() returns NULL for zero pfns.  I also
have a very strong feeling that in the old world the "page*" is non-NULL for
zero pages here.

So... I'm boldly thinking whether we should also need another fix upon the zero
page handling here too, probably before this whole patchset (so it'll be the
1st patch, it should directly apply to master) because if I'm right on above it
can be seen as another separate bug fix:

---8<---
diff --git a/mm/memory.c b/mm/memory.c
index f306e698a1e3..9b8348746e0b 100644
--- a/mm/memory.c
+++ b/mm/memory.c
@@ -1320,11 +1320,18 @@ struct zap_details {
 static inline bool
 zap_skip_check_mapping(struct zap_details *details, struct page *page)
 {
-       if (!details || !page)
+       /* No detail pointer or no zap_mapping pointer, zap all */
+       if (!details || !details->zap_mapping)
                return false;
 
-       return details->zap_mapping &&
-               (details->zap_mapping != page_rmapping(page));
+       /*
+        * For example, the zero page.  If the user wants to keep the private
+        * pages, zero page should also be in count.
+        */
+       if (!page)
+               return true;
+
+       return details->zap_mapping != page_rmapping(page);
 }
 
 static unsigned long zap_pte_range(struct mmu_gather *tlb,
---8<---

page can be NULL for e.g. PFNMAP and when error occured too above.  I assume we
don't need to bother with them (e.g., I don't think PFNMAP or MIXED should
specify even_cows=false at all, because there's no page cache layer), though.
Mostly it's about how we should handle zero page right.

Thanks,

-- 
Peter Xu

