Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id DA2EA47A258
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Dec 2021 22:27:32 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235403AbhLSV12 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Dec 2021 16:27:28 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56806 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230488AbhLSV11 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Dec 2021 16:27:27 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 28D6EC061574
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 13:27:27 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id m21so3412430edc.0
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 13:27:27 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ZOShkgSsLUNxxfuqCgeDeOt2ke5//N9VVujAkHreXEg=;
        b=LqNmclrkwQCsbrNtIezCKp85izX4onfAiRFTRfPRPGRgPokTZlM7X1drmL6HICY2j9
         at/rEpYzr4ZXWvvP4fbrIrue8KwptDf7MKxC0s6vNlZujg3zNB3SersC3KyFG+JHqT3n
         b1+ZTJUiCalTiCm+t2714XkqPnvEoRzVbU9PY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ZOShkgSsLUNxxfuqCgeDeOt2ke5//N9VVujAkHreXEg=;
        b=lesRqPcdEyj4XGkON/edPd6e88E1x7A6ErZkI6gsgJW4f8r8JeVnum71xPVVHY10hI
         7+m10B18JIwNcqpJL6AsGsmzP21H/IVfJjgU7CDyFvSlpfuvL6S6LtRRPpz4VHgZ6fSo
         q/qTmVBquPDfDzsOBWgOYSDN/pBm3zRvg2u81KjDwLMwZtvBrp85dP7Cykj6SgbUMvT0
         e/Kq7kD54442CdYH8zyVvFpSuhoTwcrCDRque2j+wyvXnPRNvo0OaYYeCyCDWXoJrTrJ
         ovRnyBaX04bFU3Mmn1FdIJJ99XXfAuaLiva0mVkQ9Kzp1uBpNJV/vxyZ9wTflcCmFovD
         poGw==
X-Gm-Message-State: AOAM533HrDLilPGbWKwMj54qBWTV3Q3msl07MrDnmB4kVMDOgsJIazo1
        JEU/CR52eIsAVYsuJzoLDn3BBNl5/Ewrhwwzhv0=
X-Google-Smtp-Source: ABdhPJwFm96I3rXcJKVJK+og4neqe5AgddONmwMOZP/oqXGHm3B4rJdB/PaEeNb22ql/TGAwM2taNw==
X-Received: by 2002:aa7:cd09:: with SMTP id b9mr13264422edw.207.1639949245584;
        Sun, 19 Dec 2021 13:27:25 -0800 (PST)
Received: from mail-wr1-f42.google.com (mail-wr1-f42.google.com. [209.85.221.42])
        by smtp.gmail.com with ESMTPSA id j11sm5858477edv.0.2021.12.19.13.27.23
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sun, 19 Dec 2021 13:27:24 -0800 (PST)
Received: by mail-wr1-f42.google.com with SMTP id s1so10738173wra.6
        for <linux-kernel@vger.kernel.org>; Sun, 19 Dec 2021 13:27:23 -0800 (PST)
X-Received: by 2002:adf:8b0e:: with SMTP id n14mr10364723wra.281.1639949243461;
 Sun, 19 Dec 2021 13:27:23 -0800 (PST)
MIME-Version: 1.0
References: <CAHk-=wj7eSOhbWDeADL_BJKLzdDF5s_5R9v7d-4P3L6v1T3mpQ@mail.gmail.com>
 <20211218184233.GB1432915@nvidia.com> <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com> <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com> <Yb+gId/gXocrlJYD@casper.infradead.org>
In-Reply-To: <Yb+gId/gXocrlJYD@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sun, 19 Dec 2021 13:27:07 -0800
X-Gmail-Original-Message-ID: <CAHk-=wiAzmB-jiHvF+EZ1-b0X3ts4LAYHaVhzpzXEjmC0X95eg@mail.gmail.com>
Message-ID: <CAHk-=wiAzmB-jiHvF+EZ1-b0X3ts4LAYHaVhzpzXEjmC0X95eg@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Hildenbrand <david@redhat.com>,
        Nadav Amit <namit@vmware.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Mike Kravetz <mike.kravetz@oracle.com>,
        Mike Rapoport <rppt@linux.ibm.com>,
        Yang Shi <shy828301@gmail.com>,
        "Kirill A . Shutemov" <kirill.shutemov@linux.intel.com>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Roman Gushchin <guro@fb.com>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Peter Xu <peterx@redhat.com>,
        Donald Dutile <ddutile@redhat.com>,
        Christoph Hellwig <hch@lst.de>,
        Oleg Nesterov <oleg@redhat.com>, Jan Kara <jack@suse.cz>,
        Linux-MM <linux-mm@kvack.org>,
        "open list:KERNEL SELFTEST FRAMEWORK" 
        <linux-kselftest@vger.kernel.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Dec 19, 2021 at 1:12 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Can we get rid of ->mapcount altogether?  Three states:
>  - Not mapped
>  - Mapped exactly once
>  - Possibly mapped more than once

I don't think even that is useful. We should get rid of mapcount entirely.

It doesn't actually help to know "mapped exactly once", exactly
because even when that's true, there may be non-mapped references to
the page.

Mapped references really aren't that special in general.

One case where it *can* be special is on virtually indexed cache
architectures, where "is this mapped anywhere else" can be an issue
for cache flushing.

There the page_mapcount() can actually really matter, but it's such an
odd case that I'm not convinced it should be something the kernel VM
code should bend over backwards for.

And the count could be useful for 'rmap' operations, where you can
stop walking the rmap once you've found all mapped cases (paghe
migration being one case of this). But again, I'm not convinced the
serialization is worth it, or that it's a noticeable win.

However, I'm not 100% convinced it's worth it even there, and I'm not
sure we necessarily use it there.

So in general, I think page_mapcount() can be useful as a count for
those things that are _literally_ about "where is this page mapped".
Page migration, virtual cache coherency, things like that can
literally be about "how many different virtual mappings can we find".

It's just that pages can have a number of non-mapped users too, so
mapcount isn't all that meaningful in general.

And you can look it up with rmap too, and so I do think it would be
worth discussing whether we really should strive to maintain
'mapcount' at all.

> I appreciate "Not mapped" is not a state that anon pages can
> meaningfully have (maybe when they go into the swap cache?)

Absolutely. And we can keep references around to an anonymous page
even without it having any mapping or swap cache at all (ie "gup +
unmap").

So "Not mapped at all" is a possible case, without the page being free'd.

                Linus
