Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 32A62551EFC
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 16:37:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242871AbiFTOgq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 20 Jun 2022 10:36:46 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1343791AbiFTOgY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 20 Jun 2022 10:36:24 -0400
Received: from casper.infradead.org (casper.infradead.org [IPv6:2001:8b0:10b:1236::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF555045F;
        Mon, 20 Jun 2022 06:51:26 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed;
        d=infradead.org; s=casper.20170209; h=In-Reply-To:Content-Type:MIME-Version:
        References:Message-ID:Subject:Cc:To:From:Date:Sender:Reply-To:
        Content-Transfer-Encoding:Content-ID:Content-Description;
        bh=3nJ8UIdQ3wJLLObnCPDGMrY/Ip+7bRcAjuoN/EdmAzQ=; b=BgcfAC5G1x9v3ZsuqGDv6IbiMk
        ZensPvnmQlxLWC/RMXWgjaM3c32cIOyVCIA4/hwZlar71cmE+1xhhCheXlefGq+k/tMUoFA8B5aSy
        DtBzrvA03mNvi6u8dBmiCPKdGmgxXbeIb8wVjg1k+zzwPMNQFwDyo7ZH7803XsVJPTp/Y4PC4SWXM
        gCIg1Vzhgvk9b12W+D+Xbjku0EhdIHB5Lvt0QxnLwbUT1+AZEp5E8c3t3ttTKZmL/83KdLsk0WGGw
        setMcQWvm6OdFg8iSC2+7BcP50SFU2LrFLYNTACZcjc3PXMoPgKiqiAciqKSn/Q7/cRy7Lr4aC0Yb
        Y2dTZVdw==;
Received: from willy by casper.infradead.org with local (Exim 4.94.2 #2 (Red Hat Linux))
        id 1o3HoE-005CUg-Bp; Mon, 20 Jun 2022 13:51:18 +0000
Date:   Mon, 20 Jun 2022 14:51:18 +0100
From:   Matthew Wilcox <willy@infradead.org>
To:     Muchun Song <songmuchun@bytedance.com>
Cc:     Stephen Rothwell <sfr@canb.auug.org.au>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Oscar Salvador <osalvador@suse.de>
Subject: Re: linux-next: build failures after merge of the mm tree
Message-ID: <YrB7Vq/WlGK99fxz@casper.infradead.org>
References: <20220620164246.0d3f7784@canb.auug.org.au>
 <CAMZfGtWmGOr1LRBnKGVeqP8p47xyaA0ny_rotdHmgLx8DOk6xg@mail.gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
In-Reply-To: <CAMZfGtWmGOr1LRBnKGVeqP8p47xyaA0ny_rotdHmgLx8DOk6xg@mail.gmail.com>
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, Jun 20, 2022 at 03:11:31PM +0800, Muchun Song wrote:
> Thanks for your report. It is fixed in thread [1].
> 
> https://lore.kernel.org/all/20220619133851.68184-3-songmuchun@bytedance.com/ [1]

No, it's a different problem.  I suggest dropping/reverting

https://lore.kernel.org/linux-mm/20220617175020.717127-20-willy@infradead.org/

> On Mon, Jun 20, 2022 at 2:42 PM Stephen Rothwell <sfr@canb.auug.org.au> wrote:
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
> > --
> > Cheers,
> > Stephen Rothwell
