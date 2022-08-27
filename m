Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23F3E5A35B6
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 09:54:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232873AbiH0HyJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 03:54:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230027AbiH0HyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 03:54:07 -0400
Received: from mail-lf1-x134.google.com (mail-lf1-x134.google.com [IPv6:2a00:1450:4864:20::134])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2872A2A40B
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 00:54:06 -0700 (PDT)
Received: by mail-lf1-x134.google.com with SMTP id m2so942238lfp.11
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 00:54:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=qMotkyLyfuzYTs8cUkh1HNEz4QJ/WmmadHhl7Jt1DmY=;
        b=DsJDBE3rKA03wvYjQRiUEIr3xrEZDQLItZKnjHG5ueTbZqsM4/yTZZTWSfr17GB/XQ
         Rwt3lz0euM8j92m94jSV5dCQQXtbbNqz7bpJOUTyVd+PQUf1IjRvHeONo22/T/e67uBU
         YqK47L4ic3p7StOG+SkJQih006KiRpqOBDqDHPSHwufIXL7uPkcOmqx88X9iUg7XFC7t
         bERTKkP/Y+BzuDAwIEO+ibVB4KNs0v8TDjAeuPBVzM5Kru/HMLm4+++ee30xDl8VfbSU
         k5bO9VxiySLN8kCQGU+/zGUFZP20wwd6dkxr+gH5sZ8wGXvtYdO4T/7TEoKsRo5ZLHr7
         SpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=qMotkyLyfuzYTs8cUkh1HNEz4QJ/WmmadHhl7Jt1DmY=;
        b=CcPah5HV6yVYntX6lCr/cmq2ZU9FqpiKuPV/o6z6s0RARB0BlRmxWAEfcP1BM2WI1c
         +y2yEVY3T560kORI/xgT7ORb2xoflBw0+4kJXUIBp1uRcWRumNPyRfqrqd/6An65aC/u
         s/2hebyCmnK1CDb1X04jFTTo0QyOlnVDifHwl3z1L8MoRybKb6FrmFPrStr2Fcq0dNRU
         hMoP1zerCsQYuI6heifpWVyDzaYMA5gHIL0qkevZeYTo0Cj6hwRicW208vch+Kqx9uAp
         rbfP5JK9xt1G/zAeEJkg1MSOdqVcHagwGMuGkdQDePkcTUC6V+Mm8uOO1I6EAxV6N3YR
         FGAA==
X-Gm-Message-State: ACgBeo2lhw9XZi/uhPDqR8AhD+JMc5OZsohPjNPemBjrMdZgcXgjXVUx
        UD1CYAJ0v11imo9stCVItDyUsRRrouUAhRU8WHj7FWGCc0s=
X-Google-Smtp-Source: AA6agR4LppQS/3wDkPRk2bMljwPa4EBqEZ8k6ssqzInCpLRmy+5MWuh4gDmQNV5tPqyqIsZXV5VEnX/4TohWZDDrAX4=
X-Received: by 2002:a05:6512:68f:b0:492:cbb1:c4b2 with SMTP id
 t15-20020a056512068f00b00492cbb1c4b2mr3811823lfe.130.1661586844506; Sat, 27
 Aug 2022 00:54:04 -0700 (PDT)
MIME-Version: 1.0
References: <1661496048-26410-1-git-send-email-zhaoyang.huang@unisoc.com> <e5856ab3-3cbc-929a-d885-ceb456b0d3b2@kernel.org>
In-Reply-To: <e5856ab3-3cbc-929a-d885-ceb456b0d3b2@kernel.org>
From:   Zhaoyang Huang <huangzhaoyang@gmail.com>
Date:   Sat, 27 Aug 2022 15:53:36 +0800
Message-ID: <CAGWkznG4vT9GaEHq85G9JDzkpqm4yHG7-Yt=em0AMc7yFWzytw@mail.gmail.com>
Subject: Re: [RFC PATCH] mm: introduce __GFP_TRACKLEAK to track in-kernel allocation
To:     "Vlastimil Babka (SUSE)" <vbabka@kernel.org>
Cc:     "zhaoyang.huang" <zhaoyang.huang@unisoc.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        "open list:MEMORY MANAGEMENT" <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>, Ke Wang <ke.wang@unisoc.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Aug 26, 2022 at 7:49 PM Vlastimil Babka (SUSE)
<vbabka@kernel.org> wrote:
>
> On 8/26/22 08:40, zhaoyang.huang wrote:
> > From: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> >
> > Kthread and drivers could fetch memory via alloc_pages directly which make them
> > hard to debug when leaking. Solve this by introducing __GFP_TRACELEAK and reuse
> > kmemleak mechanism which unified most of kernel cosuming pages into kmemleak.
>
> Can you expand how exactly this is expected to be used? So you first have to
> suspect some concrete allocation and add __GFP_TRACKLEAK to it?
It could be used to investigate suspicious drivers or kthread which
may introduce in-kernel leak during debug phase by enabling kmemleak.
This can be done via page owner things now. I would like to unified it
together with slab leak into kmemleak.
>
> > Signed-off-by: Zhaoyang Huang <zhaoyang.huang@unisoc.com>
> > ---
> >  include/linux/gfp.h        | 4 +++-
> >  include/linux/page-flags.h | 3 +++
> >  mm/kmemleak.c              | 2 +-
> >  mm/page_alloc.c            | 6 ++++++
> >  4 files changed, 13 insertions(+), 2 deletions(-)
> >
> > diff --git a/include/linux/gfp.h b/include/linux/gfp.h
> > index 2d2ccae..081ab54 100644
> > --- a/include/linux/gfp.h
> > +++ b/include/linux/gfp.h
> > @@ -68,6 +68,7 @@
> >  #else
> >  #define ___GFP_NOLOCKDEP     0
> >  #endif
> > +#define ___GFP_TRACKLEAK     0x10000000u
> >  /* If the above are modified, __GFP_BITS_SHIFT may need updating */
> >
> >  /*
> > @@ -259,12 +260,13 @@
> >  #define __GFP_SKIP_ZERO ((__force gfp_t)___GFP_SKIP_ZERO)
> >  #define __GFP_SKIP_KASAN_UNPOISON ((__force gfp_t)___GFP_SKIP_KASAN_UNPOISON)
> >  #define __GFP_SKIP_KASAN_POISON   ((__force gfp_t)___GFP_SKIP_KASAN_POISON)
> > +#define __GFP_TRACKLEAK   ((__force gfp_t)___GFP_TRACKLEAK)
> >
> >  /* Disable lockdep for GFP context tracking */
> >  #define __GFP_NOLOCKDEP ((__force gfp_t)___GFP_NOLOCKDEP)
> >
> >  /* Room for N __GFP_FOO bits */
> > -#define __GFP_BITS_SHIFT (27 + IS_ENABLED(CONFIG_LOCKDEP))
> > +#define __GFP_BITS_SHIFT (28 + IS_ENABLED(CONFIG_LOCKDEP))
> >  #define __GFP_BITS_MASK ((__force gfp_t)((1 << __GFP_BITS_SHIFT) - 1))
> >
> >  /**
> > diff --git a/include/linux/page-flags.h b/include/linux/page-flags.h
> > index e66f7aa..ef0f814 100644
> > --- a/include/linux/page-flags.h
> > +++ b/include/linux/page-flags.h
> > @@ -942,6 +942,7 @@ static inline bool is_page_hwpoison(struct page *page)
> >  #define PG_offline   0x00000100
> >  #define PG_table     0x00000200
> >  #define PG_guard     0x00000400
> > +#define PG_trackleak 0x00000800
> >
> >  #define PageType(page, flag)                                         \
> >       ((page->page_type & (PAGE_TYPE_BASE | flag)) == PAGE_TYPE_BASE)
> > @@ -1012,6 +1013,8 @@ static inline int page_has_type(struct page *page)
> >   */
> >  PAGE_TYPE_OPS(Guard, guard)
> >
> > +PAGE_TYPE_OPS(Trackleak, trackleak)
> > +
> >  extern bool is_free_buddy_page(struct page *page);
> >
> >  PAGEFLAG(Isolated, isolated, PF_ANY);
> > diff --git a/mm/kmemleak.c b/mm/kmemleak.c
> > index 422f28f..a182f5d 100644
> > --- a/mm/kmemleak.c
> > +++ b/mm/kmemleak.c
> > @@ -1471,7 +1471,7 @@ static void kmemleak_scan(void)
> >                       if (page_zone(page) != zone)
> >                               continue;
> >                       /* only scan if page is in use */
> > -                     if (page_count(page) == 0 || PageReserved(page))
> > +                     if (page_count(page) == 0)
> >                               continue;
> >                       scan_block(page, page + 1, NULL);
> >                       if (!(pfn & 63))
> > diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> > index e008a3d..d8995c6 100644
> > --- a/mm/page_alloc.c
> > +++ b/mm/page_alloc.c
> > @@ -1361,6 +1361,8 @@ static __always_inline bool free_pages_prepare(struct page *page,
> >               page->mapping = NULL;
> >       if (memcg_kmem_enabled() && PageMemcgKmem(page))
> >               __memcg_kmem_uncharge_page(page, order);
> > +     if (PageTrackleak(page))
> > +             kmemleak_free(page);
> >       if (check_free)
> >               bad += check_free_page(page);
> >       if (bad)
> > @@ -5444,6 +5446,10 @@ struct page *__alloc_pages(gfp_t gfp, unsigned int order, int preferred_nid,
> >               __free_pages(page, order);
> >               page = NULL;
> >       }
> > +     if (gfp & __GFP_TRACKLEAK) {
> > +             kmemleak_alloc(page_address(page), PAGE_SIZE << order, 1, gfp & ~__GFP_TRACKLEAK);
> > +             __SetPageTrackleak(page);
> > +     }
> >
> >       trace_mm_page_alloc(page, order, alloc_gfp, ac.migratetype);
> >
>
