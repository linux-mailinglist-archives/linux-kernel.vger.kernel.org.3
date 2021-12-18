Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 3BBFE479C14
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 19:37:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233860AbhLRShs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 18 Dec 2021 13:37:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49276 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233837AbhLRShr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 18 Dec 2021 13:37:47 -0500
Received: from mail-ed1-x535.google.com (mail-ed1-x535.google.com [IPv6:2a00:1450:4864:20::535])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C7123C061574
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 10:37:46 -0800 (PST)
Received: by mail-ed1-x535.google.com with SMTP id z7so20825167edc.11
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 10:37:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=DHTFz7y22Ngs5ZQxLbmaebOcqARcdRZHKk6yXTOe9EM=;
        b=KHty4RXfZaDHjvIjUqBBf0UyRMBkN3UgDjrhi6CiMCObmA+JHse/h1kJiaRhoWRtKw
         dFFzw5XLjSH0a0Il6X2AftPA7gnQoObE7o+xGFiCuH4xOSQXXRADfVxklzeySVgKlmNC
         urFD6ysEJPJWuyHHTwJcTUzaDAQFmO0eR2yh0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=DHTFz7y22Ngs5ZQxLbmaebOcqARcdRZHKk6yXTOe9EM=;
        b=ssN0Q5ADE2hzcV/v5paNfAtmjOciekpQoR3ad/xRnJhynuF5GAp8uosxfLMVoAkiYN
         dwsIAFuspl2a6P0aYyR5q/ehTxa8utITJN4vMq/hdrDtj7FKocHpE5FHgvr3hmNk1erD
         6IHcuVjUtPL01JNaUTpFKzlqUAQxL7e/5kI13bPtQnJHwfWcWSmN2HfiUUVYwN9cDsRD
         /Y7lVavMthbwe8Dln/Tqkwh6FJX3FX6vZHkflHPDW8xYHqipUdLMcMYxsjrUkQRpbUqj
         H4TOntsIgRRBXCOxKIAU+ssoK0z25l6TGozp32ZBejIenKWrQuPEGnjaE74+qx1ZuUgr
         KaLw==
X-Gm-Message-State: AOAM532wJKb1a5Mxy2ZWdnAZYcbYws8P2IXK63t2mz04l9SbxiMLiJxF
        2THGyd0qwXWZHGYAA3aUGGCOvIT5M3PXJ0M0R68=
X-Google-Smtp-Source: ABdhPJz+wRoI4D13oKviKATg7RxUSArvkw4vdwvsEfLmH6ehM5xUzNagH6rsjx5lKjnatD9xT4rZug==
X-Received: by 2002:aa7:cb1a:: with SMTP id s26mr8370008edt.19.1639852665082;
        Sat, 18 Dec 2021 10:37:45 -0800 (PST)
Received: from mail-wr1-f41.google.com (mail-wr1-f41.google.com. [209.85.221.41])
        by smtp.gmail.com with ESMTPSA id p4sm3836300eju.98.2021.12.18.10.37.42
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Sat, 18 Dec 2021 10:37:43 -0800 (PST)
Received: by mail-wr1-f41.google.com with SMTP id e5so10715073wrc.5
        for <linux-kernel@vger.kernel.org>; Sat, 18 Dec 2021 10:37:42 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr7008989wru.97.1639852662653;
 Sat, 18 Dec 2021 10:37:42 -0800 (PST)
MIME-Version: 1.0
References: <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com>
 <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com> <CAHk-=wiR2Q5TQn_Vy10esOOshAego4wTCxgfDtVCxAw74hP5hg@mail.gmail.com>
 <0aa27d7d-0db6-94ee-ca16-91d19997286b@redhat.com> <CAHk-=wgKACiq4sygvRwvJ7bE+dnbMVftoudEVvcbyws6G_FDyw@mail.gmail.com>
 <0de1a3cb-8286-15bd-aec1-2b284bf8918a@redhat.com> <719D2770-97EF-4CF5-81E6-056B0B55A996@vmware.com>
 <CAHk-=wjnPt3H1JV=04iJQ6LjiF31RrM4Zg3QUKTr9MswUZk4xg@mail.gmail.com>
 <D54E059F-9757-46DB-919C-A31A067276CB@vmware.com> <Yb1rqe7u0YRxqzgh@casper.infradead.org>
In-Reply-To: <Yb1rqe7u0YRxqzgh@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Sat, 18 Dec 2021 10:37:26 -0800
X-Gmail-Original-Message-ID: <CAHk-=wisX4UAD+cy5HsgjFhY8eQHBzepXaosjZLDPLx967kdCw@mail.gmail.com>
Message-ID: <CAHk-=wisX4UAD+cy5HsgjFhY8eQHBzepXaosjZLDPLx967kdCw@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     Matthew Wilcox <willy@infradead.org>
Cc:     Nadav Amit <namit@vmware.com>,
        David Hildenbrand <david@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        Hugh Dickins <hughd@google.com>,
        David Rientjes <rientjes@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        John Hubbard <jhubbard@nvidia.com>,
        Jason Gunthorpe <jgg@nvidia.com>,
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

On Fri, Dec 17, 2021 at 9:03 PM Matthew Wilcox <willy@infradead.org> wrote:
>
> Why are we comparing page_count() against 1 and not 1 + PageLRU(page)?
> Having a reference from the LRU should be expected.  Is it because of
> some race that we'd need to take the page lock to protect against?

The LRU doesn't actually count towards a reference - the LRU list is
maintained independently of the lifetime of the page (and is torn down
on last release - which wouldn't work if the LRU list itself held a
ref to the page).

But atr least some of the code that gathers up pages to then put them
on the LRU list takes a ref to the pages before passing them off, just
to guarantee to keep them around during the operation.

So yes, various things can increment page counts in a transitory manner.

I still *much* prefer a reliable COW over one that doesn't happen enough.

The page count can have these (on the whole fairly rare) blips. That's
ok. The page count is still *reliable*, in ways that teh mapcount can
never be. The mapcount fundamentally doesn't show "other non-mapped
users".

So Nadav is correct that unnecessary cow events will cause extra work
(and the TLB flush is a good point - just marking a page writable
as-is is much cheaper).

But I'm looking at teh actual code, and the actual logic, and I am
dismissign the whole mapcount games completely.

David has a 10-patch series (plus one test) of complex, grotty,
hard-to-understand code with new flags.

I posted a patch that removed 10 lines, and fixes the problem case his
test-case was designed for.

I think that really speaks to the issues.

My approach is *simpler* and a hell of a lot more robust. And as
mentioned, I can explain it.

And christ the thing I'm advocating for is WHAT WE ALREADY DO FOR
99.99% of all cases. Why? Because it's literally how the regular COW
paths work TODAY.

And we had benchmarks show performance improvements (or no movement at
all) from when we made those changes. Not the downsides that people
claim.

It's only the THP paths that are broken (and possibly some individual
mis-uses of GUP - people have mentioned virtio).

So nbow people are trying to do a fragile, complex thing that was
shown to be problematic for the common case, and they are doing it for
the insanely rare case? When a ten-line removal patch fixes that one
too?

              Linus

PS. Yes, yes, that 10-line removal patch is obviously still not
tested, it's still likely incomplete because the THP case needs to do
the page-pinning logic on the other side too, so I'm very obviously
over-simplifying. But the fact that the *normal* pages already do this
correctly - and don't use mapcount - should really make people go
"Hmm".
