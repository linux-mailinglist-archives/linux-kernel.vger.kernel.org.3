Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77ECA4769E1
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 06:46:04 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229962AbhLPFpn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 00:45:43 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:41756 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S229528AbhLPFpm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 00:45:42 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1639633541;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=ukexlmknN2bRyzPsMC8Ut5pZb/Whnh9Gt8bGl/njzhs=;
        b=WQrkKlb0YFjt8R/9tE9OsvjqQ1J1Dj7SCaPDSHE7+rRubXcJj4fKPovq4aa/y2YVGv0pU3
        IWCMTeL+rWZlr+CxnvyxgPNjq9+5J+t5+er+NMj4uw6pySzEMpvdX/3IeCN96OrYvudCGN
        3DGdLQlyzLt2Z4JqKj1m+P/5v3jx128=
Received: from mail-wr1-f71.google.com (mail-wr1-f71.google.com
 [209.85.221.71]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-492-GeZcPohMMDiPk5ViB3z2cQ-1; Thu, 16 Dec 2021 00:45:38 -0500
X-MC-Unique: GeZcPohMMDiPk5ViB3z2cQ-1
Received: by mail-wr1-f71.google.com with SMTP id b1-20020a5d6341000000b001901ddd352eso6570229wrw.7
        for <linux-kernel@vger.kernel.org>; Wed, 15 Dec 2021 21:45:38 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=ukexlmknN2bRyzPsMC8Ut5pZb/Whnh9Gt8bGl/njzhs=;
        b=XRu4xbDDSr9vpP4Ojj96I2OIrZUkcfZPk4qR2hbe0xkqRn2KZ3D1ioiQ8EZK59pJcK
         gARhWo/TvkgPwKXF8B7fMrz0Au9ITRL2zxXaLfltsvfGtPXeogkuDMNocnxPXWTNE6Sd
         acQb3bTke3NobBBxAaH6irsavAi42kkL3A5HR80WuwAfsIayjeC2Pc7i2t6gqSSrUGc/
         RdM1Lx2zlz3kAUJu6zR+pS+Iw9o2JKzqSKwEIFpax/NoZ+d9YYpc7lRwg3luxxVpUP0I
         oSzo95C94PbGsa2nylLDMLU43tmCcxrvUX44smCy/EhPtq8QluCTHkp44b2mpEH8GGl/
         TXOg==
X-Gm-Message-State: AOAM530fr+B1o+Tp+t9LpJ1dISQ35U6yBM/HxyK/pmLJcFq4h0AjgZVr
        d5w4t31Og6WkJQl0M5J3xvnKMH2ySdFwa2QrfgZl3j4omiXTZUGVUY9MurcnYC+0jVtGDZfDBfn
        /EVSHTl32dbQZr3x7epT4MiWp
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr3343665wrm.653.1639633537358;
        Wed, 15 Dec 2021 21:45:37 -0800 (PST)
X-Google-Smtp-Source: ABdhPJzQBc7M7omjm4rc1bX/tOyMmrpU90UBTk9xAd2dr7Ei2BweLZKTpAQzSQ0/9pSESzfXM8bPwg==
X-Received: by 2002:adf:e4cc:: with SMTP id v12mr3343642wrm.653.1639633537135;
        Wed, 15 Dec 2021 21:45:37 -0800 (PST)
Received: from xz-m1.local ([64.64.123.12])
        by smtp.gmail.com with ESMTPSA id e1sm1681835wrc.74.2021.12.15.21.45.31
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 15 Dec 2021 21:45:36 -0800 (PST)
Date:   Thu, 16 Dec 2021 13:45:28 +0800
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
Subject: Re: [PATCH v6 04/23] mm/uffd: PTE_MARKER_UFFD_WP
Message-ID: <YbrSeADehDoToV6L@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com>
 <20211115075522.73795-5-peterx@redhat.com>
 <1966495.R0KUr5dvoW@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <1966495.R0KUr5dvoW@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Dec 16, 2021 at 04:18:50PM +1100, Alistair Popple wrote:
> On Monday, 15 November 2021 6:55:03 PM AEDT Peter Xu wrote:
> 
> [...]
> 
> > +/*
> > + * Returns true if this is a swap pte and was uffd-wp wr-protected in either
> > + * forms (pte marker or a normal swap pte), false otherwise.
> > + */
> > +static inline bool pte_swp_uffd_wp_any(pte_t pte)
> > +{
> > +#ifdef CONFIG_PTE_MARKER_UFFD_WP
> > +	if (!is_swap_pte(pte))
> > +		return false;
> > +
> > +	if (pte_swp_uffd_wp(pte))
> > +		return true;
> 
> If I'm not mistaken normal swap uffd-wp ptes can still exist when
> CONFIG_PTE_MARKER_UFFD_WP=n so shouldn't this be outside the #ifdef protection?
> 
> In fact we could drop the #ifdef entirely here as it is safe to call
> is_pte_marker_uffd_wp() without CONFIG_PTE_MARKER_UFFD_WP.

But if CONFIG_PTE_MARKER_UFFD_WP=n then it means we don't support file-backed
uffd-wp.  The thing is pte_swp_uffd_wp_any() is only needed for file-backed..
Anonymous uffd-wp code never uses it.

In other words, pte_swp_uffd_wp() is indeed still a valid helper, however this
specific function (pte_swp_uffd_wp_any) may not really be necessary anymore.

Keeping the "#ifdef" could still help, imho, to generate clean code for direct
calls to pte_swp_uffd_wp_any() if someone wants to turn pte markers off,
e.g. we could still have chance to optimize below:

        if (pte_swp_uffd_wp_any(pte) &&
                !(zap_flags & ZAP_FLAG_DROP_MARKER))
                set_huge_pte_at(mm, address, ptep,
                                make_pte_marker(PTE_MARKER_UFFD_WP));
        else
                huge_pte_clear(mm, address, ptep, sz);

Into:

        huge_pte_clear(mm, address, ptep, sz);

with any decent compiler.

That's majorly why I still slightly prefer to keep it, and that's also one of
the major reason to have the config knob, imho.

Thanks,

-- 
Peter Xu

