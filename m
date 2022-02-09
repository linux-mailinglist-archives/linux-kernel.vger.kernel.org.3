Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5977C4AEBFD
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 09:16:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238556AbiBIIPz convert rfc822-to-8bit (ORCPT
        <rfc822;lists+linux-kernel@lfdr.de>); Wed, 9 Feb 2022 03:15:55 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57292 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240664AbiBIIPu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 03:15:50 -0500
Received: from mail-vs1-f45.google.com (mail-vs1-f45.google.com [209.85.217.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B58CBC0613CA
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 00:15:53 -0800 (PST)
Received: by mail-vs1-f45.google.com with SMTP id a19so1718649vsi.2
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 00:15:53 -0800 (PST)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc:content-transfer-encoding;
        bh=CCbpx5jLa8X1+FwaGeKkcnSoDsrgs8CZ2w84UAyChHY=;
        b=wbeb+XQbXBO6k+XQKwz3tHc5yras5NA3fo94VGDJSgrFIkwZmJhY2rMmdS38jhx95i
         +w3/MwBPlktClzK6eC0M6SCJIZYhlQ58Vek/LJEi6VSE6G//PQPPzwJUNNdlkwdPijkl
         qd6p0SNF7LpYkFpuCKbI9PeORNXblTDcoTVmQdD8gfdEXmYnWM2Keo/O0BpvczAJCgDs
         mdC5WmG5Igt/zhCzuaGa024l0nZ9HEO+PflogjqRSPOd/Kcd/e1cKWj6+IJxd3tXt46I
         fiUPD7ahO1nyNbPGMeA2MVIZiAcdcCcG4eurKe0dmO1QY6tGmzhOcMBp2f6FufqvnQh6
         Copg==
X-Gm-Message-State: AOAM532IMOzH+XJUGdChLNTR6rwmzjkWoJvhIvQEZG/3EnrmTmZxGQLf
        M3gH+hIKKlyCd7PYbl+reS3UvNXt2ZUjaw==
X-Google-Smtp-Source: ABdhPJweOsZ0csEoYaTIFOApCcjncj1LGulNvsrB23cLBPnxXElOpc7x//+EwkGoC6ECqvHytFngKA==
X-Received: by 2002:a05:6102:2251:: with SMTP id e17mr310750vsb.13.1644394552090;
        Wed, 09 Feb 2022 00:15:52 -0800 (PST)
Received: from mail-vk1-f176.google.com (mail-vk1-f176.google.com. [209.85.221.176])
        by smtp.gmail.com with ESMTPSA id a21sm679398vsl.16.2022.02.09.00.15.50
        for <linux-kernel@vger.kernel.org>
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 09 Feb 2022 00:15:51 -0800 (PST)
Received: by mail-vk1-f176.google.com with SMTP id m131so711322vkm.7
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 00:15:50 -0800 (PST)
X-Received: by 2002:a1f:2555:: with SMTP id l82mr414163vkl.7.1644394550779;
 Wed, 09 Feb 2022 00:15:50 -0800 (PST)
MIME-Version: 1.0
References: <8e4356d-9622-a7f0-b2c-f116b5f2efea@google.com> <eadba522-cfe1-b0d6-56fc-7bc9f649b89d@google.com>
In-Reply-To: <eadba522-cfe1-b0d6-56fc-7bc9f649b89d@google.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 9 Feb 2022 09:15:39 +0100
X-Gmail-Original-Message-ID: <CAMuHMdVxrYioQX1H8CPpYcSADN=22Se-pW14fPu9R0G+6iDtYw@mail.gmail.com>
Message-ID: <CAMuHMdVxrYioQX1H8CPpYcSADN=22Se-pW14fPu9R0G+6iDtYw@mail.gmail.com>
Subject: Re: [PATCH 10/13] mm/munlock: mlock_page() munlock_page() batch by pagevec
To:     Hugh Dickins <hughd@google.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Michal Hocko <mhocko@suse.com>,
        Vlastimil Babka <vbabka@suse.cz>,
        "Kirill A. Shutemov" <kirill@shutemov.name>,
        Matthew Wilcox <willy@infradead.org>,
        David Hildenbrand <david@redhat.com>,
        Alistair Popple <apopple@nvidia.com>,
        Johannes Weiner <hannes@cmpxchg.org>,
        Rik van Riel <riel@surriel.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Yu Zhao <yuzhao@google.com>, Greg Thelen <gthelen@google.com>,
        Shakeel Butt <shakeelb@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux MM <linux-mm@kvack.org>
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8BIT
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Hugh,

On Wed, Feb 9, 2022 at 3:46 AM Hugh Dickins <hughd@google.com> wrote:
> A weakness of the page->mlock_count approach is the need for lruvec lock
> while holding page table lock.  That is not an overhead we would allow on
> normal pages, but I think acceptable just for pages in an mlocked area.
> But let's try to amortize the extra cost by gathering on per-cpu pagevec
> before acquiring the lruvec lock.
>
> I have an unverified conjecture that the mlock pagevec might work out
> well for delaying the mlock processing of new file pages until they have
> got off lru_cache_add()'s pagevec and on to LRU.
>
> The initialization of page->mlock_count is subject to races and awkward:
> 0 or !!PageMlocked or 1?  Was it wrong even in the implementation before
> this commit, which just widens the window?  I haven't gone back to think
> it through.  Maybe someone can point out a better way to initialize it.
>
> Bringing lru_cache_add_inactive_or_unevictable()'s mlock initialization
> into mm/mlock.c has helped: mlock_new_page(), using the mlock pagevec,
> rather than lru_cache_add()'s pagevec.
>
> Experimented with various orderings: the right thing seems to be for
> mlock_page() and mlock_new_page() to TestSetPageMlocked before adding to
> pagevec, but munlock_page() to leave TestClearPageMlocked to the later
> pagevec processing.
>
> Dropped the VM_BUG_ON_PAGE(PageTail)s this time around: they have made
> their point, and the thp_nr_page()s already contain a VM_BUG_ON_PGFLAGS()
> for that.
>
> This still leaves acquiring lruvec locks under page table lock each time
> the pagevec fills (or a THP is added): which I suppose is rather silly,
> since they sit on pagevec waiting to be processed long after page table
> lock has been dropped; but I'm disinclined to uglify the calling sequence
> until some load shows an actual problem with it (nothing wrong with
> taking lruvec lock under page table lock, just "nicer" to do it less).
>
> Signed-off-by: Hugh Dickins <hughd@google.com>

Thanks for your patch, which is now commit cbaf47432c909044
("mm/munlock: mlock_page() munlock_page() batch by pagevec") in
next-20220209.

> --- a/mm/internal.h
> +++ b/mm/internal.h
> @@ -402,7 +402,8 @@ extern int mlock_future_check(struct mm_struct *mm, unsigned long flags,
>   *
>   * mlock is usually called at the end of page_add_*_rmap(),
>   * munlock at the end of page_remove_rmap(); but new anon
> - * pages are managed in lru_cache_add_inactive_or_unevictable().
> + * pages are managed by lru_cache_add_inactive_or_unevictable()
> + * calling mlock_new_page().
>   *
>   * @compound is used to include pmd mappings of THPs, but filter out
>   * pte mappings of THPs, which cannot be consistently counted: a pte
> @@ -425,6 +426,9 @@ static inline void munlock_vma_page(struct page *page,
>             (compound || !PageTransCompound(page)))
>                 munlock_page(page);
>  }
> +void mlock_new_page(struct page *page);
> +bool need_mlock_page_drain(int cpu);
> +void mlock_page_drain(int cpu);

This is inside an #ifdef CONFIG_MMU section.

> --- a/mm/swap.c
> +++ b/mm/swap.c

> @@ -640,6 +634,7 @@ void lru_add_drain_cpu(int cpu)
>                 pagevec_lru_move_fn(pvec, lru_lazyfree_fn);
>
>         activate_page_drain(cpu);
> +       mlock_page_drain(cpu);

noreply@ellerman.id.au reported for m5272c3_defconfig:

    mm/swap.c:637:2: error: implicit declaration of function
‘mlock_page_drain’ [-Werror=implicit-function-declaration]

http://kisskb.ellerman.id.au/kisskb/buildresult/14694567/

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
