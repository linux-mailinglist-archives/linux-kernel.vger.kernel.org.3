Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8E36E46B09A
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 03:30:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238565AbhLGCd5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Dec 2021 21:33:57 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.129.124]:33639 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S231561AbhLGCd4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Dec 2021 21:33:56 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638844226;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=uinQkAT8jXoUvyzyhCOVwlkCtrtOX2gIF/TEODj1I7E=;
        b=dcGBMH7JFMzi6K+jAFKiwu0s4DtxJsdndsNYSieeG9zgvFCJHbKubQ/MmkM22b3zGzXaXc
        gKfYpd1uxewviKMi/uQ6Z4C4U6njqI1PV92sqCGxBY7YsEJZM+N4WJsI5koAtNHLXxh8tk
        kThGu8d+ZR+hkEN306LZfd5W9QjrJ+U=
Received: from mail-wm1-f70.google.com (mail-wm1-f70.google.com
 [209.85.128.70]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-427-icjzRMhIOUaCkQgpl9ZRHw-1; Mon, 06 Dec 2021 21:30:25 -0500
X-MC-Unique: icjzRMhIOUaCkQgpl9ZRHw-1
Received: by mail-wm1-f70.google.com with SMTP id 187-20020a1c02c4000000b003335872db8dso6981288wmc.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Dec 2021 18:30:25 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=uinQkAT8jXoUvyzyhCOVwlkCtrtOX2gIF/TEODj1I7E=;
        b=cBSPaeX8+EgQswmGwsx+7IenawXVs4jOGw8549m5BB6w88e6zvwLheVAcqkFfQAUwa
         M5pSHi6fsrvoPL5z72ttgclxqWhlSw+SKBej1MNqkdV/E97gIjIxlfFjHvSiFVv04kzQ
         7a291gE4ieWAAC6e2EjTgQ+gNiDOP1eMHyG2miqZN43/OerRIf9iKNO6GibIiltjRO4q
         SuVOKs5ehFa+9YNV1jJ1GskRG8M7hC1SettxsQCf4cuuRR+wiJ21o/44U+AO2vOhRvE4
         yXthdKOdrENBUcLjC5s74d77iPQMS3wrAMitl4TZvYw0G7CPbO6zOZb6BjiSCg/shUE5
         vzfA==
X-Gm-Message-State: AOAM531XkigXTtXi0wVhgZlpgG2CNShTHb4civDcRM/eVw48fgXLgSy3
        04r6gYnt6KRspsbS/R240ZeDHptCbjjZtMKLHbpCG2BHkbpRYE4RFEayYDd2U+sqc/g93SEUacU
        FDqMIRx7M5s2+f7TmusYdpBbL
X-Received: by 2002:a05:600c:4982:: with SMTP id h2mr3206042wmp.4.1638844224348;
        Mon, 06 Dec 2021 18:30:24 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzeVKI+ZZziPdOTSoGsMuoEIaeoXMQlA2tWiydlHsa+VaTJOSQSgnLr7MLbYzRBe16eEVXBdw==
X-Received: by 2002:a05:600c:4982:: with SMTP id h2mr3206029wmp.4.1638844224132;
        Mon, 06 Dec 2021 18:30:24 -0800 (PST)
Received: from xz-m1.local ([85.203.46.174])
        by smtp.gmail.com with ESMTPSA id l26sm1112119wms.15.2021.12.06.18.30.18
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Dec 2021 18:30:23 -0800 (PST)
Date:   Tue, 7 Dec 2021 10:30:15 +0800
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
Message-ID: <Ya7HN5N/5Po/x28Y@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com>
 <3832555.7SGzcYD3YQ@nvdebian>
 <Yam9EezLTANRA+Rf@xz-m1.local>
 <2190897.LADUpQAO2C@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <2190897.LADUpQAO2C@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Dec 07, 2021 at 01:12:23PM +1100, Alistair Popple wrote:
> On Friday, 3 December 2021 5:45:37 PM AEDT Peter Xu wrote:
> > On Fri, Dec 03, 2021 at 04:35:38PM +1100, Alistair Popple wrote:
> > > > > > +static inline pte_marker pte_marker_get(swp_entry_t entry)
> > > > > > +{
> > > > > > +	return swp_offset(entry) & PTE_MARKER_MASK;
> > > > > 
> > > > > I'm not sure the PTE_MARKER_MASK adds much, especially as we only have one
> > > > > user. I don't see a problem with open-coding these kind of checks (ie.
> > > > 
> > > > It's more or less a safety belt to make sure anything pte_marker_get() returned
> > > > will be pte_marker defined bits only.
> > > > 
> > > > > swp_offset(entry) & PTE_MARKER_UFFD_WP) as you kind of end up doing that anyway.
> > > > > Alternatively if you want helper functions I think it would be better to define
> > > > > them for each marker. Eg: is_pte_marker_uffd_wp().
> > > > 
> > > > Yes we can have something like is_pte_marker_uffd_wp(), I didn't do that
> > > > explicitly because I want us to be clear that pte_marker is a bitmask, so
> > > > calling "is_*" will be slightly opaque - strictly speaking it should be
> > > > "pte_marker_has_uffd_wp_bit()" if there will be more bits defined, but then the
> > > > name of the helper will look a bit odd too.  Hence I just keep the only
> > > > interface to fetch the whole marker and use "&" in the call sites to check.
> > > 
> > > Why does a caller need to care if it's a bitmask or not though? Isn't that an
> > > implementation detail that could be left to the "is_*" functions? I must admit
> > > I'm still working through the rest of this series though - is it because you
> > > end up storing some kind of value in the upper bits of the PTE marker?
> > 
> > Nop. I'm just afraid the caller could overlook the fact that it's a bitmask,
> > then there can be code like:
> > 
> >   if (is_pte_marker_uffd_wp(*ptep) && drop_uffd_wp)
> >       pte_clear(ptep)
> > 
> > While we should only do:
> > 
> >   if (is_pte_marker_uffd_wp(*ptep) && drop_uffd_wp)
> >       // remove uffd-wp bit in the pte_marker, keep the reset bitmask
> 
> I'm not sure how having the helper function prevents or changes this though? In
> fact I just noticed this in patch 8:
> 
>                              if (uffd_wp_resolve &&
>                                     (pte_marker_get(entry) & PTE_MARKER_UFFD_WP)) {
>                                         pte_clear(vma->vm_mm, addr, pte);
>                                         pages++;
>                                 }
> 
> And if I'm understanding your point correctly isn't that wrong because if there
> were other users of pte markers they would inadvertently get cleared? Unless of
> course I've missed something - I haven't looked at patch 8 yet for context. To
> help with the above situation I think you would need a helper for clearing
> ptes.

What I wanted to say is pte_marker_get() will make sure the caller will be
aware of the fact that the marker is a bitmask.  But it's true at least my
example might make it even more confusing..

> 
> > I could be worrying too much, there's no real user of it.  If you prefer the
> > helper a lot I can add it in the new version.  Thanks,
> 
> It's not a massive issue, but I do think either defining a helper or open
> coding the bit check is clearer. I think we can worry about other users if/when
> they appear.

OK, I'll add it.  Thanks,

-- 
Peter Xu

