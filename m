Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E950E47B3DA
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Dec 2021 20:39:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231958AbhLTTju (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Dec 2021 14:39:50 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231847AbhLTTjd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Dec 2021 14:39:33 -0500
Received: from mail-ed1-x533.google.com (mail-ed1-x533.google.com [IPv6:2a00:1450:4864:20::533])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 70B8AC061756
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:39:15 -0800 (PST)
Received: by mail-ed1-x533.google.com with SMTP id m21so15564665edc.0
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:39:15 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linux-foundation.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=0HEIGasiDjlyDxa0Yi+2EmuRxngp8FedzY8QNTfhikI=;
        b=X/tYG9QpqUmW6+H6ZYV0nRa4/njzoyToFNJ9zOYVkDvcTiybU29zVqv9btuh6Q6Zb+
         ZU8bp6ncsBiJHAlMaETRxIEeO1W44QSEarGybDoySgE1Kihe9Znw3ZOsf+trnjzPi50n
         9dzynaN+Ov3/Bl4U4xx2HsvgbBFtRQJeRiMJI=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=0HEIGasiDjlyDxa0Yi+2EmuRxngp8FedzY8QNTfhikI=;
        b=Q/55OUjnlOUmgSwG3fuomGAgxggmVIi2bI0LanMYXhLss+0rrZLGPNo/Cfkd7FuPzE
         W0mr9QXQUYbes/g5oaRonzKPLA5VdtNJU2PnAYxGoxMaJASao59F+ejDDi0iSooags2b
         45bZXswhLqqqV13OcqTYm7ExE/jqjV4yLqs6W+BKi+tYc9UDzPlPWTOWwhw1Lst95yvV
         c8kwYjnhkhnbtOghJ0iU2FxGnpfO4SIJG5dkU+g6dpCyoKU10KPkKC09LHwlyDa4tYaR
         XN3//pQddF5+QL1JEmls4/VsdcSPdkCvXDqw7qChz4yCgA+UsVSxok+NOKfGgUBqMaK4
         8oxQ==
X-Gm-Message-State: AOAM530mJJ8kuSpxuUP23rLeyOmXweQB6LbIkYh3xMl7Xvhix6+wwyzI
        /CWQWMFK/jQsjRd4sM44q/Kuukul7qXbHsk9tWc=
X-Google-Smtp-Source: ABdhPJwNtqLwHcEsiu0bZYsb9Sn/4RN0en5IvXwSeNtNS26zJbH1jgJJ5/WwK9kmSx65DKA4v20DbQ==
X-Received: by 2002:a17:906:f44:: with SMTP id h4mr2541440ejj.113.1640029153813;
        Mon, 20 Dec 2021 11:39:13 -0800 (PST)
Received: from mail-wr1-f54.google.com (mail-wr1-f54.google.com. [209.85.221.54])
        by smtp.gmail.com with ESMTPSA id do16sm5612841ejc.190.2021.12.20.11.39.11
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Mon, 20 Dec 2021 11:39:12 -0800 (PST)
Received: by mail-wr1-f54.google.com with SMTP id c4so22190415wrd.9
        for <linux-kernel@vger.kernel.org>; Mon, 20 Dec 2021 11:39:11 -0800 (PST)
X-Received: by 2002:a5d:6211:: with SMTP id y17mr2559324wru.97.1640029151469;
 Mon, 20 Dec 2021 11:39:11 -0800 (PST)
MIME-Version: 1.0
References: <5CA1D89F-9DDB-4F91-8929-FE29BB79A653@vmware.com>
 <CAHk-=wh-ETqwd6EC2PR6JJzCFHVxJgdbUcMpW5MS7gCa76EDsQ@mail.gmail.com>
 <4D97206A-3B32-4818-9980-8F24BC57E289@vmware.com> <CAHk-=whxvVQReBqZeaV41=sAWfT4xTfn6sMSWDfkHKVS3zX85w@mail.gmail.com>
 <5A7D771C-FF95-465E-95F6-CD249FE28381@vmware.com> <CAHk-=wgMuSkumYxeaaxbKFoAbw_gjYo1eRXXSFcBHzNG2xauTA@mail.gmail.com>
 <CAHk-=whYT0Q1F=bxG0yi=LN5gXY64zBwefsbkLoRiP5p598d5A@mail.gmail.com>
 <fca16906-8e7d-5d04-6990-dfa8392bad8b@redhat.com> <Yb+gId/gXocrlJYD@casper.infradead.org>
 <YcDNaoGcGS6ypucg@casper.infradead.org> <YcDRC7e0fNAMYi3m@casper.infradead.org>
In-Reply-To: <YcDRC7e0fNAMYi3m@casper.infradead.org>
From:   Linus Torvalds <torvalds@linux-foundation.org>
Date:   Mon, 20 Dec 2021 11:38:55 -0800
X-Gmail-Original-Message-ID: <CAHk-=whUE9RdzXcsQ6VrD5fNU3BtXWjhSa4XPy7bZQTHhdr3Rg@mail.gmail.com>
Message-ID: <CAHk-=whUE9RdzXcsQ6VrD5fNU3BtXWjhSa4XPy7bZQTHhdr3Rg@mail.gmail.com>
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

On Mon, Dec 20, 2021 at 10:53 AM Matthew Wilcox <willy@infradead.org> wrote:
>
> It makes me wonder if reuse_swap_page() can also be based on refcount
> instead of mapcount?

I suspect it doesn't even need refcount.

For regular pages, after we've copied the page, all we do right now is

                if (page_copied)
                        free_swap_cache(old_page);

which is basically just an optimistic trylock_page() followed by
try_to_free_swap().

And that then pretty much simply checks "are there any swap users
left" and deletes it from the swap cache if not.

The "free_swap_cache()" thing is actually just an optimization to
avoid having memory pressure do it later.  So it doesn't have to be
exact.

In fact, I thought that swap is so unusual that it's not even needed
at all, but I was wrong. See how this was re-introduced in commit
f4c4a3f48480 ("mm: free idle swap cache page after COW") because yes,
some loads still have swap space allocated.

In theory, it would probably be a good idea at COW time to see if the
page ref is 2, and if it's a swap cache page, and try to do that swap
cache removal even earlier, so that the page actually gets re-used
(instead of copied and then the swap entry removed).

But swap is such a non-issue these days that I doubt it matters, and
it's probably better to keep the swap handling in the unusual path.

So mapcount and refcount aren't what matters for the swap cache.

The swap count obviously *does* matter - because it means that some
mapping has a reference to this swap entry (not as a page, but as an
actual swap pointer).

But the mapcount is irrelevant -  any users that have the swap page
actually mapped, don't actually need to be a swapcache page.

Even the refcount doesn't really matter, afaik. The only "refcount" we
care about is that swapcount - that's what actually reference counts
the swap cases.

try_to_free_swap() does check for one particular kind of reference: it
does a check for PageWriteback(). We don't want to remove the thing
from the swap cache if it's under active IO.

(This codepath does need the page lock, though, thus all those
"page_trylock()" things).

                   Linus
