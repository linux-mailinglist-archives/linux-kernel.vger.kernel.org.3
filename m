Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4726550F2E2
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 09:43:16 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344229AbiDZHqQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 03:46:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51632 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344171AbiDZHqN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 03:46:13 -0400
Received: from mail-vs1-xe34.google.com (mail-vs1-xe34.google.com [IPv6:2607:f8b0:4864:20::e34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9858133E69
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:43:06 -0700 (PDT)
Received: by mail-vs1-xe34.google.com with SMTP id f32so16673267vsv.1
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 00:43:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=F6hORQhWD4R4PBBaL15o7cQDBZSUWYx9+THQUkS8oik=;
        b=nXY/jyTlv7QAuUsIJPC7aUL8xu31SPzL1bxZweM6Hbt56IqaVYOxOqVmdLCuEH7OCi
         FUYT8m9jDymm04MoMEF3hNYKUGc4hcmG6bS3lNCUKekqAgf7bXYLMCCFJdVK7ZTTQoUN
         LeQaEzTmHc7Ehq7uWn9SY4+ygDmk8YOugiY/F4wliaccWAY4pyuc/MRBTdsPK0chG/2y
         dyfCk6HxBfCr+SfSf1dxCTreUXtNre0vItXXdjMAv4E0MDdSxPldz0rSkhE2IZPEPtgj
         PMgud5bgboNo28FLcNcjPBLHuNgaiJ1CVnanYSVbXTOOgvoC5YjdZQdmMK/LUhpjov3c
         Y6nQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=F6hORQhWD4R4PBBaL15o7cQDBZSUWYx9+THQUkS8oik=;
        b=A2roUgwaaUL9SsvUTnJ6VJY+UJZEvy/eCqY0uNunBMtDJzJ52YFu/xSA8qH198OfAz
         eeUbMfRmyeYz/rzPV6dG0re6h8cbaNwkY7sqiQIsHiWSr4n5trIzrRtGJrfRYQ12zrCs
         pzsQDfoMFeUJUH2Juw5YOCv0MMLZRADm4hxntCxEq6z45aOsLCITsk/Z4Bf/qrP1VUdz
         px5N6XKXBQGWZ4eDzJAQ1XgaDIEqI2lQU4ANPm5rBMxfZT2IXMqAbGpXrwH4XVcss7h2
         A5Na4Ld78aHUy88PKF6KJppoB2WAlr0J4RgK+LLHF9SWb7dORsCqPJtEkGYiLGlrfStp
         Otqw==
X-Gm-Message-State: AOAM530fKmkWK2FRwLV5Sg6Zo0i04HNkGwflaD1wLTXokNLpNJxmt/pE
        dqqxpgkNSEsR5UzrBxRIHE1UpajAOYPBc9u3MriiQQ==
X-Google-Smtp-Source: ABdhPJwrYwHJliqqvdxOxEXGiUwfDiSxoM+Qnd1xHIJRZWoed1Am6bjcaOL5Pk10UbnYyCsT4xwysfqq8d6vEqmiqek=
X-Received: by 2002:a67:cb02:0:b0:32c:2690:be39 with SMTP id
 b2-20020a67cb02000000b0032c2690be39mr6421711vsl.81.1650958985634; Tue, 26 Apr
 2022 00:43:05 -0700 (PDT)
MIME-Version: 1.0
References: <20220407031525.2368067-1-yuzhao@google.com> <20220407031525.2368067-15-yuzhao@google.com>
 <20220411191645.91078752f29b82aea7ee508c@linux-foundation.org>
In-Reply-To: <20220411191645.91078752f29b82aea7ee508c@linux-foundation.org>
From:   Yu Zhao <yuzhao@google.com>
Date:   Tue, 26 Apr 2022 01:42:29 -0600
Message-ID: <CAOUHufaUPeAB8N11REc-43V2SLEMgE2ZbyFofnpZAhF+tL8ebg@mail.gmail.com>
Subject: Re: [PATCH v10 14/14] mm: multi-gen LRU: design doc
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Stephen Rothwell <sfr@rothwell.id.au>,
        Linux-MM <linux-mm@kvack.org>, Andi Kleen <ak@linux.intel.com>,
        Aneesh Kumar <aneesh.kumar@linux.ibm.com>,
        Barry Song <21cnbao@gmail.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Hillf Danton <hdanton@sina.com>, Jens Axboe <axboe@kernel.dk>,
        Jesse Barnes <jsbarnes@google.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Jonathan Corbet <corbet@lwn.net>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        Mel Gorman <mgorman@suse.de>,
        Michael Larabel <Michael@michaellarabel.com>,
        Michal Hocko <mhocko@kernel.org>,
        Mike Rapoport <rppt@kernel.org>,
        Rik van Riel <riel@surriel.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        Will Deacon <will@kernel.org>,
        Ying Huang <ying.huang@intel.com>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:DOCUMENTATION" <linux-doc@vger.kernel.org>,
        linux-kernel <linux-kernel@vger.kernel.org>,
        Kernel Page Reclaim v2 <page-reclaim@google.com>,
        "the arch/x86 maintainers" <x86@kernel.org>,
        Brian Geffon <bgeffon@google.com>,
        Jan Alexander Steffens <heftig@archlinux.org>,
        Oleksandr Natalenko <oleksandr@natalenko.name>,
        Steven Barrett <steven@liquorix.net>,
        Suleiman Souhlal <suleiman@google.com>,
        Daniel Byrne <djbyrne@mtu.edu>,
        Donald Carr <d@chaos-reins.com>,
        =?UTF-8?Q?Holger_Hoffst=C3=A4tte?= <holger@applied-asynchrony.com>,
        Konstantin Kharlamov <Hi-Angel@yandex.ru>,
        Shuang Zhai <szhai2@cs.rochester.edu>,
        Sofia Trinh <sofia.trinh@edi.works>,
        Vaibhav Jain <vaibhav@linux.ibm.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Apr 11, 2022 at 8:16 PM Andrew Morton <akpm@linux-foundation.org> wrote:
>
> On Wed,  6 Apr 2022 21:15:26 -0600 Yu Zhao <yuzhao@google.com> wrote:
>
> > Add a design doc.
> >
> >
> > ...
> >
> > +Design overview
> > +===============
> > +Objectives
> > +----------
> > +The design objectives are:
> > +
> > +* Good representation of access recency
> > +* Try to profit from spatial locality
> > +* Fast paths to make obvious choices
> > +* Simple self-correcting heuristics
> > +
> > +The representation of access recency is at the core of all LRU
> > +implementations. In the multi-gen LRU, each generation represents a
> > +group of pages with similar access recency. Generations establish a
> > +common frame of reference and therefore help make better choices,
> > +e.g., between different memcgs on a computer or different computers in
> > +a data center (for job scheduling).
>
> Does MGLRU have any special treatment for used-once pages?

Yes. Single-use pages are assumed to be the cheapest to reclaim:

"The first tier contains single-use unmapped clean pages, which are
the best bet."

> > +Exploiting spatial locality improves efficiency when gathering the
> > +accessed bit. A rmap walk targets a single page and does not try to
> > +profit from discovering a young PTE. A page table walk can sweep all
> > +the young PTEs in an address space, but the address space can be too
> > +large to make a profit. The key is to optimize both methods and use
> > +them in combination.
> > +
> > +Fast paths reduce code complexity and runtime overhead. Unmapped pages
> > +do not require TLB flushes; clean pages do not require writeback.
> > +These facts are only helpful when other conditions, e.g., access
> > +recency, are similar. With generations as a common frame of reference,
> > +additional factors stand out. But obvious choices might not be good
> > +choices; thus self-correction is required.
> > +
> > +The benefits of simple self-correcting heuristics are self-evident.
> > +Again, with generations as a common frame of reference, this becomes
> > +attainable. Specifically, pages in the same generation can be
> > +categorized based on additional factors, and a feedback loop can
> > +statistically compare the refault percentages across those categories
> > +and infer which of them are better choices.
> > +
> > +Assumptions
> > +-----------
> > +The protection of hot pages and the selection of cold pages are based
> > +on page access channels and patterns. There are two access channels:
> > +
> > +* Accesses through page tables
> > +* Accesses through file descriptors
> > +
> > +The protection of the former channel is by design stronger because:
> > +
> > +1. The uncertainty in determining the access patterns of the former
> > +   channel is higher due to the approximation of the accessed bit.
> > +2. The cost of evicting the former channel is higher due to the TLB
> > +   flushes required and the likelihood of encountering the dirty bit.
> > +3. The penalty of underprotecting the former channel is higher because
> > +   applications usually do not prepare themselves for major page
> > +   faults like they do for blocked I/O. E.g., GUI applications
> > +   commonly use dedicated I/O threads to avoid blocking the rendering
> > +   threads.
> > +
> > +There are also two access patterns:
> > +
> > +* Accesses exhibiting temporal locality
> > +* Accesses not exhibiting temporal locality
> > +
> > +For the reasons listed above, the former channel is assumed to follow
> > +the former pattern unless ``VM_SEQ_READ`` or ``VM_RAND_READ`` is
> > +present, and the latter channel is assumed to follow the latter
> > +pattern unless outlying refaults have been observed.
>
> What about MADV_SEQUENTIAL?    Or did we propogate that into the fd?

MADV_SEQUENTIAL is VM_SEQ_READ. I think you mean
POSIX_FADV_SEQUENTIAL. We don't need to propagate it to the fd. Pages
sequentially accessed through fd, i.e., detected by
mark_page_accessed(), fall into the single-use category.

> > +Workflow overview
> > +=================
> > +Evictable pages are divided into multiple generations for each
> > +``lruvec``. The youngest generation number is stored in
> > +``lrugen->max_seq`` for both anon and file types as they are aged on
> > +an equal footing. The oldest generation numbers are stored in
> > +``lrugen->min_seq[]`` separately for anon and file types as clean file
> > +pages can be evicted regardless of swap constraints. These three
> > +variables are monotonically increasing.
> > +
> >
> > ...
> >
> > +Summary
> > +-------
> > +The multi-gen LRU can be disassembled into the following parts:
> > +
> > +* Generations
> > +* Page table walks
> > +* Rmap walks
> > +* Bloom filters
> > +* The PID controller
> > +
> > +The aging and the eviction is a producer-consumer model; specifically,
> > +the latter drives the former by the sliding window over generations.
> > +Within the aging, rmap walks drive page table walks by inserting hot
> > +densely populated page tables to the Bloom filters. Within the
> > +eviction, the PID controller uses refaults as the feedback to select
> > +types to evict and tiers to protect.
>
> It's cool to see a PID controller in there.
>
> How do we know that it converges well, that it doesn't exhibit instability, etc?

Divergence can be easily avoided by using sane parameters. A more
specific problem for our use case is how to establish a (relative)
time domain. We can't just use wall clock since different CPUs run at
the different speeds. Even for the same CPU, it scans pages at
different rates under different memory pressure. So generations serve
as a time dimension. For each new generation, we refresh the PID
controller to minimize the chance of it locking in a bad state. It may
make poor choices now and then, but it should never make poor choices
all the time.
