Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EE142553086
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 13:14:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348992AbiFULOy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 07:14:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59964 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348360AbiFULOw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 07:14:52 -0400
Received: from mail-yb1-xb2a.google.com (mail-yb1-xb2a.google.com [IPv6:2607:f8b0:4864:20::b2a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8576429CA6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:14:51 -0700 (PDT)
Received: by mail-yb1-xb2a.google.com with SMTP id r3so23876050ybr.6
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 04:14:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=yTjJ0DM8UhfLUxnJgLF1yIGlrKBlqdpXoPMj/z5vlI8=;
        b=5b6BBFCna+oCdlTQAsmmddI1nNzy/HGy2Wj8rNb4up3wBw/q1UFl4HhcBq8VFlbkox
         dmbkQHzAqLeQytnQ9CE0xMBFOVPXJlc40Fj80hAmNJNRvZbfIflzxHiBJjXI3A3qAjdh
         gxyL0X3gjaGkKfelem7RxJmmiE2NVbcQi4X++/0ni5kdyhF7fwyGJZHakYaPgiiJ8Q5T
         5rksYIOs68P0XXPah4TaPOYqHh5XSWU0m6VzWyXZYEn9h1o7VZrY+pDo+jl3CAo34vGW
         PzZbtIxmSmqXSc0xP7dbc4gTqiegp0C1cJqIMbyXmRBtdJ66OtdOa7gutoESRqHHprvT
         8Ffw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=yTjJ0DM8UhfLUxnJgLF1yIGlrKBlqdpXoPMj/z5vlI8=;
        b=5BZ+tkDGOuF2+uovARIqY851Pddva3vB0hg7bso1Ix3Y2vu11mvltnf7UhMAF5/NUz
         p1TtMPZLZ7ETGQq8RjE9UthcIMWtOoVrcOyNcTHnfnccw3h53yjwqEWUVUee01f12H4q
         mDWWmHjRgeIWvo3Z8aHHB5TblmHjyrClEwyt+/xB9xLgyMOFEC6MUCCTmql3cT9FjKIQ
         AkNxcH2VrAZxnGzyHZMUUS8cdELiFfq8wsA4Hrhb1s5nLKKsi++RxImHJhSdFcLKQ04a
         O8G35iMEAWSQiZMUQJYV814WJSO5fo9YL/ufCWr3PP3qgFzZWWcazp+fEO7vqb3WyKw6
         qpfw==
X-Gm-Message-State: AJIora8omFhG3pbELf1zQ1iSXh3std/kJFkxuDAJ1e82KJimpnWRyggk
        3flTMNxkJEdmJeZdra6ZsK6/63xS4SmO7iC+PDTkBA==
X-Google-Smtp-Source: AGRyM1uueA1T7Oig/PE3Ow5Ua3OljfQyd9wJyYgZG3tA3cfWlxrzAD4imH7uKaj12EBuo2dqrUPyHy+BsiBoHgnkoEk=
X-Received: by 2002:a25:b218:0:b0:664:6da5:b5c5 with SMTP id
 i24-20020a25b218000000b006646da5b5c5mr30977101ybj.6.1655810090707; Tue, 21
 Jun 2022 04:14:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220620164246.0d3f7784@canb.auug.org.au> <20220621171800.0397976a@canb.auug.org.au>
In-Reply-To: <20220621171800.0397976a@canb.auug.org.au>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 21 Jun 2022 19:14:13 +0800
Message-ID: <CAMZfGtWkzpLPBQHM5WQ7yFTFiTY8o7NU-z+01O-KbEYdc9AFdw@mail.gmail.com>
Subject: Re: [External] Re: linux-next: build failures after merge of the mm tree
To:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 21, 2022 at 3:18 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
>
> Hi all,
>
> On Mon, 20 Jun 2022 16:42:46 +1000 Stephen Rothwell <sfr@canb.auug.org.au> wrote:
> >
> > Hi all,
> >
> > After merging the mm tree, today's linux-next build (x86_64 allnoconfig)
> > failed like this:
> >
> > In file included from arch/x86/include/asm/page.h:86,
> >                  from arch/x86/include/asm/thread_info.h:12,
> >                  from include/linux/thread_info.h:60,
> >                  from arch/x86/include/asm/preempt.h:7,
> >                  from include/linux/preempt.h:78,
> >                  from include/linux/spinlock.h:55,
> >                  from include/linux/mmzone.h:8,
> >                  from include/linux/gfp.h:6,
> >                  from include/linux/slab.h:15,
> >                  from include/linux/crypto.h:20,
> >                  from arch/x86/kernel/asm-offsets.c:9:
> > include/linux/mm.h: In function 'destroy_large_folio':
> > include/asm-generic/memory_model.h:35:21: error: implicit declaration of function 'page_to_section'; did you mean 'present_section'? [-Werror=implicit-function-declaration]
> >    35 |         int __sec = page_to_section(__pg);                      \
> >       |                     ^~~~~~~~~~~~~~~
> > include/asm-generic/memory_model.h:40:32: note: in definition of macro '__pfn_to_page'
> >    40 | ({      unsigned long __pfn = (pfn);                    \
> >       |                                ^~~
> > include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
> >    52 | #define page_to_pfn __page_to_pfn
> >       |                     ^~~~~~~~~~~~~
> > include/linux/mm.h:214:38: note: in expansion of macro 'page_to_pfn'
> >   214 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
> >       |                                      ^~~~~~~~~~~
> > include/linux/page-flags.h:312:33: note: in expansion of macro 'nth_page'
> >   312 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
> >       |                                 ^~~~~~~~
> > include/linux/mm.h:928:38: note: in expansion of macro 'folio_page'
> >   928 |         enum compound_dtor_id dtor = folio_page(folio, 1)->compound_dtor;
> >       |                                      ^~~~~~~~~~
> > In file included from include/linux/memcontrol.h:20,
> >                  from include/linux/swap.h:9,
> >                  from include/linux/suspend.h:5,
> >                  from arch/x86/kernel/asm-offsets.c:13:
> > include/linux/mm.h: At top level:
> > include/linux/mm.h:1556:29: error: conflicting types for 'page_to_section'; have 'long unsigned int(const struct page *)'
> >  1556 | static inline unsigned long page_to_section(const struct page *page)
> >       |                             ^~~~~~~~~~~~~~~
> > In file included from arch/x86/include/asm/page.h:86,
> >                  from arch/x86/include/asm/thread_info.h:12,
> >                  from include/linux/thread_info.h:60,
> >                  from arch/x86/include/asm/preempt.h:7,
> >                  from include/linux/preempt.h:78,
> >                  from include/linux/spinlock.h:55,
> >                  from include/linux/mmzone.h:8,
> >                  from include/linux/gfp.h:6,
> >                  from include/linux/slab.h:15,
> >                  from include/linux/crypto.h:20,
> >                  from arch/x86/kernel/asm-offsets.c:9:
> > include/asm-generic/memory_model.h:35:21: note: previous implicit declaration of 'page_to_section' with type 'int()'
> >    35 |         int __sec = page_to_section(__pg);                      \
> >       |                     ^~~~~~~~~~~~~~~
> > include/asm-generic/memory_model.h:40:32: note: in definition of macro '__pfn_to_page'
> >    40 | ({      unsigned long __pfn = (pfn);                    \
> >       |                                ^~~
> > include/asm-generic/memory_model.h:52:21: note: in expansion of macro '__page_to_pfn'
> >    52 | #define page_to_pfn __page_to_pfn
> >       |                     ^~~~~~~~~~~~~
> > include/linux/mm.h:214:38: note: in expansion of macro 'page_to_pfn'
> >   214 | #define nth_page(page,n) pfn_to_page(page_to_pfn((page)) + (n))
> >       |                                      ^~~~~~~~~~~
> > include/linux/page-flags.h:312:33: note: in expansion of macro 'nth_page'
> >   312 | #define folio_page(folio, n)    nth_page(&(folio)->page, n)
> >       |                                 ^~~~~~~~
> > include/linux/mm.h:928:38: note: in expansion of macro 'folio_page'
> >   928 |         enum compound_dtor_id dtor = folio_page(folio, 1)->compound_dtor;
> >       |                                      ^~~~~~~~~~
> > cc1: some warnings being treated as errors
> >
> > Caused by commit (I think)
> >
> >   d3b90b76e101 ("mm: convert destroy_compound_page() to destroy_large_folio()")
> >
> > I have reverted these commits fot today:
> >
> > 56629699b3dd mm/swap: convert __delete_from_swap_cache() to a folio
> > e5085f2cc241 mm/swap: convert delete_from_swap_cache() to take a folio
> > 169f02f4efb1 mm: convert page_swap_flags to folio_swap_flags
> > d3b90b76e101 mm: convert destroy_compound_page() to destroy_large_folio()
> >
> > Then I got:
> >
> > mm/hugetlb_vmemmap.c: In function 'vmemmap_optimizable_pages':
> > mm/hugetlb_vmemmap.c:110:24: error: implicit declaration of function 'sparse_decode_mem_map' [-Werror=implicit-function-declaration]
> >   110 |         vmemmap_page = sparse_decode_mem_map(ms->section_mem_map,
> >       |                        ^~~~~~~~~~~~~~~~~~~~~
> > mm/hugetlb_vmemmap.c:110:22: warning: assignment to 'struct page *' from 'int' makes pointer from integer without a cast [-Wint-conversion]
> >   110 |         vmemmap_page = _sparsedecode_mem_map(ms->section_mem_map,
> >       |                      ^
> > cc1: some warnings being treated as errors
> >
> > from my arm64 defconfig build.
> >
> > Caused by commit
> >
> >   10a768735470 ("mm: memory_hotplug: make hugetlb_optimize_vmemmap compatible with memmap_on_memory")
> >
> > So I gave up and used the mm tree from next-20220617 for today.
>
> Today, I reverted the following commits instead:
>
> 10a768735470 mm: memory_hotplug: make hugetlb_optimize_vmemmap compatible with memmap_on_memory

For this one, I have fixed it in thread [1]. Hopefully, Andrew can
pick it into "mm" or "next" branch.

[1] https://lore.kernel.org/all/20220620110616.12056-1-songmuchun@bytedance.com/

Thanks.

> cececf2df493 mm: memory_hotplug: enumerate all supported section flags
> 56629699b3dd mm/swap: convert __delete_from_swap_cache() to a folio
> e5085f2cc241 mm/swap: convert delete_from_swap_cache() to take a folio
> 169f02f4efb1 mm: convert page_swap_flags to folio_swap_flags
> d3b90b76e101 mm: convert destroy_compound_page() to destroy_large_folio()
> 19211dae45bb mm/swap: convert __page_cache_release() to use a folio
>
> --
> Cheers,
> Stephen Rothwell
