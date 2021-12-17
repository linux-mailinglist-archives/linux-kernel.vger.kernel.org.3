Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9EDFA47977F
	for <lists+linux-kernel@lfdr.de>; Sat, 18 Dec 2021 00:26:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230241AbhLQX0U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 18:26:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54774 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229512AbhLQX0T (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 18:26:19 -0500
Received: from mail-ed1-x52b.google.com (mail-ed1-x52b.google.com [IPv6:2a00:1450:4864:20::52b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3861DC061574
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 15:26:19 -0800 (PST)
Received: by mail-ed1-x52b.google.com with SMTP id z5so13658519edd.3
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 15:26:19 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=WST3wy6+xYPOuwZfmt2/JLJvcXf3cy26kl3RLbkPveE=;
        b=VXGkS6mNdOeYceL24plAqQedawFCC8HX6+aSsCsVUhO2s6J2TZ1wsFmTez6n6ZomIG
         5YBwdy2IW3gUrcz7i1tItWl9dq+k4ECH2BsU3alhEJ8YHr5HifsTOO3nAPkUG8bB06jL
         ahLbuER/HW4tHaC0gLpnI/AXbWLi6gpSl3ka0=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=WST3wy6+xYPOuwZfmt2/JLJvcXf3cy26kl3RLbkPveE=;
        b=k3LKAhIzGFv+GCdGH4fOIGRe/A8AdsE9dmp/QGFbMaSw7ZcOpzOaQGVrO7cif7alXi
         P1eOovQu4JZ5jWVhdZ9fPuE47c0bRQ6QoKH5TDK9LcyDmgijXshOiUgq1VlRnSW166RK
         ozBM6zEqd2krTbI/vqofLe9lXg2ssZcZY8/wp87Qpc18B4sfDYkwh33w9mHKCpkwrN61
         wwUEm5r/DzxVf75h+J7DDY5qVZYy4ME0dKnjDn9v0bqy5G6GWCANpgD6nZdz7olrTVpQ
         2a5t/5w/6z3jcZTin8VII0n8fPR85QMFT3o0f85rrn1BuUBZrelpF5HiNhzZsBSqR0D7
         Se0A==
X-Gm-Message-State: AOAM532gEQhUchzslMi7uzdoYCBXxmasxAf9D/OnwYJPrpRvygWj7+SK
        7cA2gab2hRb0MOAlQAxB6AGYjEJFIkCfy2RFJpI=
X-Google-Smtp-Source: ABdhPJyw2lo6L/HtPd8pxrSo4qvT2ywsrWl8e33s6nXGHcou8tNm1vcj7tZX3UkHP0YQrycw0Sth/A==
X-Received: by 2002:a17:907:3daa:: with SMTP id he42mr4278623ejc.160.1639783577651;
        Fri, 17 Dec 2021 15:26:17 -0800 (PST)
Received: from mail-ed1-f44.google.com (mail-ed1-f44.google.com. [209.85.208.44])
        by smtp.gmail.com with ESMTPSA id v3sm4121227edc.69.2021.12.17.15.26.17
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 17 Dec 2021 15:26:17 -0800 (PST)
Received: by mail-ed1-f44.google.com with SMTP id z29so13552614edl.7
        for <linux-kernel@vger.kernel.org>; Fri, 17 Dec 2021 15:26:17 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr4203233wru.97.1639783240817;
 Fri, 17 Dec 2021 15:20:40 -0800 (PST)
MIME-Version: 1.0
References: <20211217113049.23850-1-david@redhat.com> <20211217113049.23850-7-david@redhat.com>
 <CAHk-=wgL5u3XMgfUN6BOqVO0OvPx3-LEri1ju-1TW4dFhHQO4g@mail.gmail.com>
 <9c3ba92e-9e36-75a9-9572-a08694048c1d@redhat.com> <CAHk-=wghsZByyzCqb5EbKzZtAbrFvQCViD+jK9HQL4viqUb6Ow@mail.gmail.com>
 <e93f3fc9-00fd-5404-83f9-136b372e4867@redhat.com> <CAHk-=wiFhVXZH_ht_dYQ_g2WNuhvWVrv8MjZ8B8_g6Kz2cZrHw@mail.gmail.com>
 <02cf4dcf-74e8-9cbd-ffbf-8888f18a9e8a@redhat.com> <CAHk-=wiujJLsLdGQho8oSbEe2-B1k1tJg6pzePkbqZBqEZL56A@mail.gmail.com>
 <f271bb98-dfdd-1126-d9b9-3103e4398e00@redhat.com>
In-Reply-To: <f271bb98-dfdd-1126-d9b9-3103e4398e00@redhat.com>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Fri, 17 Dec 2021 15:20:24 -0800
X-Gmail-Original-Message-ID: <CAHk-=wjvoTRSb87R-D50yOXqX4mshjiiAyurAKCsdW0_J+sf7A@mail.gmail.com>
Message-ID: <CAHk-=wjvoTRSb87R-D50yOXqX4mshjiiAyurAKCsdW0_J+sf7A@mail.gmail.com>
Subject: Re: [PATCH v1 06/11] mm: support GUP-triggered unsharing via
 FAULT_FLAG_UNSHARE (!hugetlb)
To:     David Hildenbrand <david@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
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
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>, Jann Horn <jannh@google.com>,
        Michal Hocko <mhocko@kernel.org>,
        Nadav Amit <namit@vmware.com>, Rik van Riel <riel@surriel.com>,
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

On Fri, Dec 17, 2021 at 2:43 PM David Hildenbrand <david@redhat.com> wrote:
>
> The pages stay PageAnon(). swap-backed pages simply set a bit IIRC.
> mapcount still applies.

Our code-base is too large for me to remember all the details, but if
we still end up having PageAnon for swapbacked pages, then mapcount
can increase from another process faulting in an pte with that swap
entry.

And mmap_sem doesn't protect against that. Again, page_lock() does.

And taking the page lock was a big performance issue.

One of the reasons that new COW handling is so nice is that you can do
things like

                if (!trylock_page(page))
                        goto copy;

exactly because in the a/b world order, the copy case is always safe.

In your model, as far as I can tell, you leave the page read-only and
a subsequent COW fault _can_ happen, which means that now the
subsequent COW needs to b every very careful, because if it ever
copies a page that was GUP'ed, you just broke the rules.

So COWing too much is a bug (because it breaks the page from the GUP),
but COWing too little is an even worse problem (because it measn that
now the GUP user can see data it shouldn't have seen).

Our old code literally COWed too  little. It's why all those changes
happened in the first place.

This is why I'm pushing that whole story line of

 (1) COW is based purely on refcounting, because that's the only thing
that obviously can never COW too little.

 (2) GUP pre-COWs (the thing I called the "(a)" rule earlier) and then
makes sure to not mark pinned pages COW again (that "(b)" rule).

and here "don't use page_mapcount()" really is about that (1).

You do seem to have kept (1) in that your COW rules don't seem to
change (but maybe I missed it), but because your GUP-vs-COW semantics
are very different indeed, I'm not at all convinced about (2).

            Linus
