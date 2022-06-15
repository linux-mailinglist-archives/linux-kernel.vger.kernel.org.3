Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6165B54D596
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 01:59:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348951AbiFOX6k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 15 Jun 2022 19:58:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37898 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347635AbiFOX6c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 15 Jun 2022 19:58:32 -0400
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A2DFD41999
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:58:31 -0700 (PDT)
Received: by mail-pj1-x102d.google.com with SMTP id y13-20020a17090a154d00b001eaaa3b9b8dso27754pja.2
        for <linux-kernel@vger.kernel.org>; Wed, 15 Jun 2022 16:58:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=8FxRBjQ0UOjYH2PrzD6Nb5pD0gKIkBB2NSnuTdmjdco=;
        b=BLH1wVDpXIg/aGye42+V5ZSnYf2qgfj028inxDJF/QYFv6aPBZH3fjtcTPpASjZ7mm
         eqShbHrAZ4iNKuhCfzD5e7moJmC9XOGQrFtRnK4h5aPUp11FaoG2uXDtCvPYh6Ty8KIR
         Lba8W53JDVcaEAf3SWKRvN9W5cyF2XKYN8gpNCKesEPYb27YuctmmSb0MuYST1yGp1rH
         RD44er+jfH0JSNzyvV1Kj2LJ7A8xHfQ3Okxdg0JQKUoUoSfc17Yo3ndTOx+5tKrTMBhV
         R6M+u7B9D/kWFpe2tGQDmfp+Ppjhsv3t+dWJuF2AetPdBGMXfTKYUULxlwdtbzQrSdzu
         yMlA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=8FxRBjQ0UOjYH2PrzD6Nb5pD0gKIkBB2NSnuTdmjdco=;
        b=4Xqy+A7tRDX3BKXothcDJnXwY23vyraAaNh3iQ/wkrmX6b9uc4zcCLcuAk+lfw/Nxm
         xgjuBjHQb9xgAju/ZRtoDZrBHD+aH0IjacvEyVKwNtjoNkPmNvZ1Htes7+JTpsGlsLQB
         Bl5su20sT4/ywPQcf0afaoi2RCRqwvhGXqU+Zq2Ba+yL00rXOU0rFg5rHZtdeDLH4gA6
         xuofC0/NT3bpSTnMTPxTCJAYyG4TREWD3TIc2PkNQo54HZxPwC9NXvBVFbeu0u/pAARZ
         Nl2+z91dLWRD0YioWMaV0660JKn8YN1nr19h+iHy1vo7pwb4HPksybvgn/oPkWQOM1ET
         u0ng==
X-Gm-Message-State: AJIora/INxMbNtXPH26zjaTnYVn3yWuGe5Ig+eZ+8gol/GZQm+B89tsj
        m3cGTntCExfJ/mU7HZS93Q4bt8byOci3vlAIv00=
X-Google-Smtp-Source: AGRyM1sE6LYz1fWBC04OJuVZ0XWPmKRJFBmTCPS5LZU2JO8pJPrnXtONFiBV6F33//N22+HluOPNvCky+PoLDF5LgUE=
X-Received: by 2002:a17:903:32c4:b0:167:6e6f:204b with SMTP id
 i4-20020a17090332c400b001676e6f204bmr1965881plr.117.1655337511162; Wed, 15
 Jun 2022 16:58:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220611084731.55155-1-linmiaohe@huawei.com> <20220611084731.55155-8-linmiaohe@huawei.com>
In-Reply-To: <20220611084731.55155-8-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 15 Jun 2022 16:58:18 -0700
Message-ID: <CAHbLzkoYkN+QzdfSUkHbLMUYX=zkrgGCrqM6xRaVssFSJh9KqA@mail.gmail.com>
Subject: Re: [PATCH 7/7] mm/khugepaged: try to free transhuge swapcache when possible
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Andrea Arcangeli <aarcange@redhat.com>,
        Matthew Wilcox <willy@infradead.org>,
        Vlastimil Babka <vbabka@suse.cz>,
        David Howells <dhowells@redhat.com>, NeilBrown <neilb@suse.de>,
        Alistair Popple <apopple@nvidia.com>,
        David Hildenbrand <david@redhat.com>,
        Suren Baghdasaryan <surenb@google.com>,
        Peter Xu <peterx@redhat.com>, Linux MM <linux-mm@kvack.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Jun 11, 2022 at 1:47 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> Transhuge swapcaches won't be freed in __collapse_huge_page_copy().
> It's because release_pte_page() is not called for these pages and
> thus free_page_and_swap_cache can't grab the page lock. These pages
> won't be freed from swap cache even if we are the only user until
> next time reclaim. It shouldn't hurt indeed, but we could try to
> free these pages to save more memory for system.


>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> ---
>  include/linux/swap.h | 5 +++++
>  mm/khugepaged.c      | 1 +
>  mm/swap.h            | 5 -----
>  3 files changed, 6 insertions(+), 5 deletions(-)
>
> diff --git a/include/linux/swap.h b/include/linux/swap.h
> index 8672a7123ccd..ccb83b12b724 100644
> --- a/include/linux/swap.h
> +++ b/include/linux/swap.h
> @@ -456,6 +456,7 @@ static inline unsigned long total_swapcache_pages(void)
>         return global_node_page_state(NR_SWAPCACHE);
>  }
>
> +extern void free_swap_cache(struct page *page);
>  extern void free_page_and_swap_cache(struct page *);
>  extern void free_pages_and_swap_cache(struct page **, int);
>  /* linux/mm/swapfile.c */
> @@ -540,6 +541,10 @@ static inline void put_swap_device(struct swap_info_struct *si)
>  /* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
>  #define free_swap_and_cache(e) is_pfn_swap_entry(e)
>
> +static inline void free_swap_cache(struct page *page)
> +{
> +}
> +
>  static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
>  {
>         return 0;
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index ee0a719c8be9..52109ad13f78 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -756,6 +756,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>         list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
>                 list_del(&src_page->lru);
>                 release_pte_page(src_page);
> +               free_swap_cache(src_page);

Will this really work? The free_swap_cache() will just dec refcounts
without putting the page back to buddy. So the hugepage is not
actually freed at all. Am I missing something?

>         }
>  }
>
> diff --git a/mm/swap.h b/mm/swap.h
> index 0193797b0c92..863f6086c916 100644
> --- a/mm/swap.h
> +++ b/mm/swap.h
> @@ -41,7 +41,6 @@ void __delete_from_swap_cache(struct page *page,
>  void delete_from_swap_cache(struct page *page);
>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
>                                   unsigned long end);
> -void free_swap_cache(struct page *page);
>  struct page *lookup_swap_cache(swp_entry_t entry,
>                                struct vm_area_struct *vma,
>                                unsigned long addr);
> @@ -81,10 +80,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
>         return NULL;
>  }
>
> -static inline void free_swap_cache(struct page *page)
> -{
> -}
> -
>  static inline void show_swap_cache_info(void)
>  {
>  }
> --
> 2.23.0
>
>
