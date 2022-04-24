Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D858B50CF64
	for <lists+linux-kernel@lfdr.de>; Sun, 24 Apr 2022 06:34:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237538AbiDXEhS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 24 Apr 2022 00:37:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231513AbiDXEhN (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 24 Apr 2022 00:37:13 -0400
Received: from mail-ej1-x634.google.com (mail-ej1-x634.google.com [IPv6:2a00:1450:4864:20::634])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B735263D6
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 21:34:13 -0700 (PDT)
Received: by mail-ej1-x634.google.com with SMTP id i27so23592751ejd.9
        for <linux-kernel@vger.kernel.org>; Sat, 23 Apr 2022 21:34:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=NMPVhO322uRvW4wqOFytQMqWXVF6MqnlRZpkBGXZkD4=;
        b=Qfpn63omQO+LaU94AP11P+BH8G1Cx+nRlmx/zm+/i239z2pBlO82Tm5UrkzVGKozxF
         YXehEc5M7127yXsH+AqhUAi+I2uOQYCDNfUQsYSJ3VfQExHShI8PNBG5BKRb9eAx58tg
         Gjg66Eku+RxuW8dRwfiLpkzMDpeeJDzjGAKEGksnoYu4D7N8uOXAuS7V8wwVgCNvDEaC
         4A5bvwPgvpldnBT4FXALN/eou7A9ZvV/dzB7HKHsvsrdpP8pp/d2k+JjyoG+rciQvfo1
         C2IasGNWs22tc5IAAbcEd/TP49wXKF+XKFgnsgjWEIpSwoPuBhPpZ1XKwr3j4Nt6tlj3
         h9ag==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=NMPVhO322uRvW4wqOFytQMqWXVF6MqnlRZpkBGXZkD4=;
        b=pcepA7pIskikh8z29+Z2i5IksQaeEJJGs3+5UHIC+beoV9JokfJs3sb9KIDOa4omWc
         TVYSJZCRgD+UW7QtnpGGl810T4qq/Td2+pixyKPWdTmxs/mgNK21vkXPveOgZBfDggVm
         vyKAxnBoA4ltyvsUai4CDnM5Wz+kaj3OYo3VR0oi2ANzidVhGQ6rIimaEXiOQgA2c8m2
         E/CMnXqQvJx47ViKvtHL8yzlo/XYv/rulXjEw3Rm5J1YmNeznonPlIDuzM/MvlGuPxS3
         WGGdPmIaoUydLURkKl0KHow6ohqcO3n6GvYpsyC7qcG1hrw27/jvea1SmFLr6Jtp5BQk
         kvJQ==
X-Gm-Message-State: AOAM532fG3oLIsPC70f00Of+HJVgvr0AxH3YL/ZuWgIHl6p2vcIMQrUz
        fwQo0mO7hsfMSXOdXY9dmQg+RqdP+tABaYS035w=
X-Google-Smtp-Source: ABdhPJznRxqjruhF6HjM9fyrlu0bowE7Y8O5joGhHDjkHw45KRU8x5Wno1N583/AnR+pZksazfYTTGXsYUl0gZTXI78=
X-Received: by 2002:a17:907:7f09:b0:6f0:2991:9c76 with SMTP id
 qf9-20020a1709077f0900b006f029919c76mr10559045ejc.170.1650774852174; Sat, 23
 Apr 2022 21:34:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220424032734.1542-1-lipeifeng@oppo.com>
In-Reply-To: <20220424032734.1542-1-lipeifeng@oppo.com>
From:   Barry Song <21cnbao@gmail.com>
Date:   Sun, 24 Apr 2022 16:34:01 +1200
Message-ID: <CAGsJ_4xVSnGNVQLbkPu2oib2qjaji_kiKvePUZJaRhnCkX4SaA@mail.gmail.com>
Subject: Re: [PATCH] mm/page_alloc: give priority to free cma-pages from
 pcplist to buddy
To:     =?UTF-8?B?5p2O5Z+56ZSLKHdpbmsp?= <lipeifeng@oppo.com>,
        Christoph Hellwig <hch@lst.de>,
        Marek Szyprowski <m.szyprowski@samsung.com>,
        robin.murphy@arm.com
Cc:     Andrew Morton <akpm@linux-foundation.org>, peifeng55@gmail.com,
        Linux-MM <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>,
        =?UTF-8?B?5byg6K+X5piOKFNpbW9uIFpoYW5nKQ==?= 
        <zhangshiming@oppo.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Apr 24, 2022 at 3:28 PM <lipeifeng@oppo.com> wrote:
>
> From: lipeifeng <lipeifeng@oppo.com>
>
> Cma-pages will be fallback to movable pages in many scenarios.when cma
> pages are freed to pcplist, we give priority to free it from pcplist
> to buddy in order to  avoids cma-pages to be used as movable-pages soon
> if there is enough free-movable-pages, which saves more cma-pages in
> buddy to decrease pages migration when cma_alloc.
>
> Signed-off-by: lipeifeng <lipeifeng@oppo.com>
> ---

+ Christoph, Marek, Robin as it is cma-related.


>  mm/page_alloc.c | 28 ++++++++++++++++++++++++----
>  1 file changed, 24 insertions(+), 4 deletions(-)
>
> diff --git a/mm/page_alloc.c b/mm/page_alloc.c
> index 3589feb..69369ed 100644
> --- a/mm/page_alloc.c
> +++ b/mm/page_alloc.c
> @@ -3372,7 +3372,7 @@ static int nr_pcp_high(struct per_cpu_pages *pcp, struct zone *zone)
>  }
>
>  static void free_unref_page_commit(struct page *page, unsigned long pfn,
> -                                  int migratetype, unsigned int order)
> +                                  int migratetype, unsigned int order, bool fast_free)
>  {
>         struct zone *zone = page_zone(page);
>         struct per_cpu_pages *pcp;
> @@ -3382,7 +3382,10 @@ static void free_unref_page_commit(struct page *page, unsigned long pfn,
>         __count_vm_event(PGFREE);
>         pcp = this_cpu_ptr(zone->per_cpu_pageset);
>         pindex = order_to_pindex(migratetype, order);
> -       list_add(&page->lru, &pcp->lists[pindex]);
> +       if (fast_free)
> +               list_add_tail(&page->lru, &pcp->lists[pindex]);
> +       else
> +               list_add(&page->lru, &pcp->lists[pindex]);

Ok. This is interesting, we used to have a separate cma pcp list but
now MIGRATE_CMA is an outsider so cma pages are placed in the
MIGRATE_MOVABLE list.

enum migratetype {
        MIGRATE_UNMOVABLE,
        MIGRATE_MOVABLE,
        MIGRATE_RECLAIMABLE,
        MIGRATE_PCPTYPES,       /* the number of types on the pcp lists */
        MIGRATE_HIGHATOMIC = MIGRATE_PCPTYPES,
#ifdef CONFIG_CMA
        ...
        MIGRATE_CMA,
#endif
#ifdef CONFIG_MEMORY_ISOLATION
        MIGRATE_ISOLATE,        /* can't allocate from here */
#endif
        MIGRATE_TYPES
};

#define NR_PCP_LISTS (MIGRATE_PCPTYPES * (PAGE_ALLOC_COSTLY_ORDER + 1
+ NR_PCP_THP))

>         pcp->count += 1 << order;
>         high = nr_pcp_high(pcp, zone);
>         if (pcp->count >= high) {
> @@ -3400,6 +3403,7 @@ void free_unref_page(struct page *page, unsigned int order)
>         unsigned long flags;
>         unsigned long pfn = page_to_pfn(page);
>         int migratetype;
> +       bool fast_free = false;
>
>         if (!free_unref_page_prepare(page, pfn, order))
>                 return;
> @@ -3419,9 +3423,15 @@ void free_unref_page(struct page *page, unsigned int order)
>                 }
>                 migratetype = MIGRATE_MOVABLE;
>         }
> +       /*
> +        * Give priority to free cma-pages to buddy in order to
> +        * decrease pages migration when cma_alloc.
> +        */
> +       if (migratetype == MIGRATE_CMA)
> +               fast_free = true;
>
>         local_lock_irqsave(&pagesets.lock, flags);
> -       free_unref_page_commit(page, pfn, migratetype, order);
> +       free_unref_page_commit(page, pfn, migratetype, order, fast_free);
>         local_unlock_irqrestore(&pagesets.lock, flags);
>  }
>
> @@ -3459,6 +3469,8 @@ void free_unref_page_list(struct list_head *list)
>
>         local_lock_irqsave(&pagesets.lock, flags);
>         list_for_each_entry_safe(page, next, list, lru) {
> +               bool fast_free = false;
> +
>                 pfn = page_private(page);
>                 set_page_private(page, 0);
>
> @@ -3467,11 +3479,19 @@ void free_unref_page_list(struct list_head *list)
>                  * to the MIGRATE_MOVABLE pcp list.
>                  */
>                 migratetype = get_pcppage_migratetype(page);
> +
> +               /*
> +                * Give priority to free cma-pages to buddy in order to
> +                * decrease pages migration when cma_alloc.
> +                */
> +               if (migratetype == MIGRATE_CMA)
> +                       fast_free = true;
> +
>                 if (unlikely(migratetype >= MIGRATE_PCPTYPES))
>                         migratetype = MIGRATE_MOVABLE;
>
>                 trace_mm_page_free_batched(page);
> -               free_unref_page_commit(page, pfn, migratetype, 0);
> +               free_unref_page_commit(page, pfn, migratetype, 0, fast_free);

i'd  call get_pcppage_migratetype() again in free_unref_page_commit()
rather than adding a parameter to increase a couple cross functions.

>
>                 /*
>                  * Guard against excessive IRQ disabled times when we get
> --
> 2.7.4
>

Thanks
Barry
