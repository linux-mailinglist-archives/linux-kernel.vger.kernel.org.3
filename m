Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A647746722C
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 07:45:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378596AbhLCGtO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 01:49:14 -0500
Received: from us-smtp-delivery-124.mimecast.com ([170.10.133.124]:37335 "EHLO
        us-smtp-delivery-124.mimecast.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S234449AbhLCGtN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 01:49:13 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1638513949;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         in-reply-to:in-reply-to:references:references;
        bh=B0n7JcNAcYn+Bd11okNue8IqT9XrfBBrxPPRZCGg20A=;
        b=XZZGPtpeyVaHcfgnJq0Wqoq3RYIvLKVFTIdJ/z8yZScgR9zIHi1fbArBEv2vkKt7ovKHmT
        CqphCpcl9Yy1XOml9tIqTZJ+3U+ub/fOsYP+JqPS6JmUe11ryukRBw3BWkTqtS8AVouMys
        TMUlA0W7TccY/YnpbjuPWF44jmcnEzQ=
Received: from mail-wm1-f72.google.com (mail-wm1-f72.google.com
 [209.85.128.72]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-314-jaBjDCGaNaqBb7bqisk7oA-1; Fri, 03 Dec 2021 01:45:48 -0500
X-MC-Unique: jaBjDCGaNaqBb7bqisk7oA-1
Received: by mail-wm1-f72.google.com with SMTP id g11-20020a1c200b000000b003320d092d08so1021244wmg.9
        for <linux-kernel@vger.kernel.org>; Thu, 02 Dec 2021 22:45:47 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:in-reply-to;
        bh=B0n7JcNAcYn+Bd11okNue8IqT9XrfBBrxPPRZCGg20A=;
        b=v/C8tm9WIbTJSzzg23p55igBHfW/wwx0Fd4LYvonsorgPk60rwRsScphCdoaKQrpci
         jNwt7qeFOQ8+Jlu+qBv5eJstqqcx4l6XZzherSuVsNL9zJah7dcYOYXRRjIxlPqJTnVt
         3jj4UPshavF87/vQ/FtNiDaEqoaVp513xU+H1btvEVJM907yZ3LPjx2lfnNhRP/UyOdc
         N11VoAfLCj1FSrj7JETuFhMFAXRh5TLfoYGq2SvmoaF6T30IQcDkNCoV8Uft6jljQ+Eg
         WF9Hcfk7I9WoIQhOh241o2z6tik2Cmu82fDS2ZXN2vV2Ku1vydKt3yA0Vd+n0M4A5d+u
         aTzA==
X-Gm-Message-State: AOAM532S3+2sIufplxLlj5ikKtyBXQJgcBXnUpwBQXzoz1SDxXXANeC7
        C2JExqyGeAuuksJ+AwLjISDxKEomJXj0KLSrtxyUxDKfnfB6rGlgIR6LX1/9HllK+y1NbkiTqMb
        vBLkimKcUq3HtLVb0VMIdmQ/j
X-Received: by 2002:a05:600c:d0:: with SMTP id u16mr12211152wmm.7.1638513946725;
        Thu, 02 Dec 2021 22:45:46 -0800 (PST)
X-Google-Smtp-Source: ABdhPJw4QxLQdwPZWAy1sF4nI2kLftVNVchu51EysUwQMm50HtRmJU/m6AC98u7ekwAGwe+6P2l5Zg==
X-Received: by 2002:a05:600c:d0:: with SMTP id u16mr12211119wmm.7.1638513946428;
        Thu, 02 Dec 2021 22:45:46 -0800 (PST)
Received: from xz-m1.local ([64.64.123.26])
        by smtp.gmail.com with ESMTPSA id o9sm1810290wrs.4.2021.12.02.22.45.40
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 02 Dec 2021 22:45:46 -0800 (PST)
Date:   Fri, 3 Dec 2021 14:45:37 +0800
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
Message-ID: <Yam9EezLTANRA+Rf@xz-m1.local>
References: <20211115075522.73795-1-peterx@redhat.com>
 <11462319.U46FXHIEPT@nvdebian>
 <YambOGGK/K7saiHM@xz-m1.local>
 <3832555.7SGzcYD3YQ@nvdebian>
MIME-Version: 1.0
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
In-Reply-To: <3832555.7SGzcYD3YQ@nvdebian>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Dec 03, 2021 at 04:35:38PM +1100, Alistair Popple wrote:
> > > > +static inline pte_marker pte_marker_get(swp_entry_t entry)
> > > > +{
> > > > +	return swp_offset(entry) & PTE_MARKER_MASK;
> > > 
> > > I'm not sure the PTE_MARKER_MASK adds much, especially as we only have one
> > > user. I don't see a problem with open-coding these kind of checks (ie.
> > 
> > It's more or less a safety belt to make sure anything pte_marker_get() returned
> > will be pte_marker defined bits only.
> > 
> > > swp_offset(entry) & PTE_MARKER_UFFD_WP) as you kind of end up doing that anyway.
> > > Alternatively if you want helper functions I think it would be better to define
> > > them for each marker. Eg: is_pte_marker_uffd_wp().
> > 
> > Yes we can have something like is_pte_marker_uffd_wp(), I didn't do that
> > explicitly because I want us to be clear that pte_marker is a bitmask, so
> > calling "is_*" will be slightly opaque - strictly speaking it should be
> > "pte_marker_has_uffd_wp_bit()" if there will be more bits defined, but then the
> > name of the helper will look a bit odd too.  Hence I just keep the only
> > interface to fetch the whole marker and use "&" in the call sites to check.
> 
> Why does a caller need to care if it's a bitmask or not though? Isn't that an
> implementation detail that could be left to the "is_*" functions? I must admit
> I'm still working through the rest of this series though - is it because you
> end up storing some kind of value in the upper bits of the PTE marker?

Nop. I'm just afraid the caller could overlook the fact that it's a bitmask,
then there can be code like:

  if (is_pte_marker_uffd_wp(*ptep) && drop_uffd_wp)
      pte_clear(ptep)

While we should only do:

  if (is_pte_marker_uffd_wp(*ptep) && drop_uffd_wp)
      // remove uffd-wp bit in the pte_marker, keep the reset bitmask

I could be worrying too much, there's no real user of it.  If you prefer the
helper a lot I can add it in the new version.  Thanks,

-- 
Peter Xu

