Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DB66654E66D
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Jun 2022 17:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235942AbiFPPxw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Jun 2022 11:53:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377763AbiFPPxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Jun 2022 11:53:43 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6468E2E6AA
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:53:42 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id g10-20020a17090a708a00b001ea8aadd42bso1890987pjk.0
        for <linux-kernel@vger.kernel.org>; Thu, 16 Jun 2022 08:53:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=soZ7Z/kpV8xfUd7TwDWGDyhSUZL5/aKbtE1H8BWznbY=;
        b=ALXXbN/beUYRTTZ5Parx1g8FvpVXPo7FUkg1yB3NJT3YrGYfREprfS4eN7h8M/xOyn
         5pJlexqpbjbMHbjLHVj8X3IBDTuE0iSiVJLefdXt/4xB0F/3+kvHnD1yGuGmTefLOSfS
         tzaF3Ec5EBOs/Mpn9ORW/uyIIA4JL6TbRABvZxIMV7cTZJz2fWSZ3NEFenN6gSvg2vN0
         GR0lOSNB2RiwgdFbGWGDTxncxFNzIZKvdrTc7Wb4/LbGj5TtBLrqm8NQqiyZfPybSvwG
         9owOYbeP3wiRgnsb9uKRM5vGkAas1C0Cv5hTyUm18on0yUy3KFYUQVlHxnieFiXF7EtD
         +dJw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=soZ7Z/kpV8xfUd7TwDWGDyhSUZL5/aKbtE1H8BWznbY=;
        b=lpWeahpMvSg6wspdU68e625smkDyW3TgJNcrhrPwSAZAcKW1Pm6+In4b89OKhnRiho
         jyDyXJgWu848kM0GjlQNeGDPHUdcMWJpN3QDeTF+oYc88heY+YM20ffj9XdVQ5u7VIxo
         hOY6+SQYie4Ts3OnMQLP++tBsJrLiWWDJTl1VABbJiea24CgHpMB5U4S1kFrjfJbMn+n
         /LC0BSROXCGCM5yzofPASngmZyJmW1cW2Xwt0iaSDGZXhnzmDhe33YQP/b3AVQWCFWsY
         cF4ILUOGF6kQ0Lykpm3999cTcDO2oXeNKqEbwjMaj6YbaGJkpZHqMerPWFA3C6ph3MnA
         LcsQ==
X-Gm-Message-State: AJIora/3JZPrqBdEtvr9ZqjAiJUx4cydoU/McKCyKoSkgWm+34iWodIK
        qkAgerTK3EeiaRAPPSGdylWRinsfu/qDBzdAbfQ=
X-Google-Smtp-Source: AGRyM1szceTmJvxBZDzYIbp8ZWRdBS34Xb5GVhAHComIv9CyqCx8/p7Ht9+z/srDnTdeCQWSDcrDfEaabYT1T5+eyzc=
X-Received: by 2002:a17:902:c40a:b0:163:d38e:3049 with SMTP id
 k10-20020a170902c40a00b00163d38e3049mr5237599plk.87.1655394821875; Thu, 16
 Jun 2022 08:53:41 -0700 (PDT)
MIME-Version: 1.0
References: <20220611084731.55155-1-linmiaohe@huawei.com> <20220611084731.55155-8-linmiaohe@huawei.com>
 <CAHbLzkoYkN+QzdfSUkHbLMUYX=zkrgGCrqM6xRaVssFSJh9KqA@mail.gmail.com> <87617483-7945-30e2-471e-578da4f4d9c7@huawei.com>
In-Reply-To: <87617483-7945-30e2-471e-578da4f4d9c7@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Thu, 16 Jun 2022 08:53:29 -0700
Message-ID: <CAHbLzkqAJK3C8svOm4mhCP_oP6od=NMKpeW9=oRcczDJ=FXPcw@mail.gmail.com>
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

On Thu, Jun 16, 2022 at 12:42 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> On 2022/6/16 7:58, Yang Shi wrote:
> > On Sat, Jun 11, 2022 at 1:47 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
> >>
> >> Transhuge swapcaches won't be freed in __collapse_huge_page_copy().
> >> It's because release_pte_page() is not called for these pages and
> >> thus free_page_and_swap_cache can't grab the page lock. These pages
> >> won't be freed from swap cache even if we are the only user until
> >> next time reclaim. It shouldn't hurt indeed, but we could try to
> >> free these pages to save more memory for system.
> >
> >
> >>
> >> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
> >> ---
> >>  include/linux/swap.h | 5 +++++
> >>  mm/khugepaged.c      | 1 +
> >>  mm/swap.h            | 5 -----
> >>  3 files changed, 6 insertions(+), 5 deletions(-)
> >>
> >> diff --git a/include/linux/swap.h b/include/linux/swap.h
> >> index 8672a7123ccd..ccb83b12b724 100644
> >> --- a/include/linux/swap.h
> >> +++ b/include/linux/swap.h
> >> @@ -456,6 +456,7 @@ static inline unsigned long total_swapcache_pages(void)
> >>         return global_node_page_state(NR_SWAPCACHE);
> >>  }
> >>
> >> +extern void free_swap_cache(struct page *page);
> >>  extern void free_page_and_swap_cache(struct page *);
> >>  extern void free_pages_and_swap_cache(struct page **, int);
> >>  /* linux/mm/swapfile.c */
> >> @@ -540,6 +541,10 @@ static inline void put_swap_device(struct swap_info_struct *si)
> >>  /* used to sanity check ptes in zap_pte_range when CONFIG_SWAP=0 */
> >>  #define free_swap_and_cache(e) is_pfn_swap_entry(e)
> >>
> >> +static inline void free_swap_cache(struct page *page)
> >> +{
> >> +}
> >> +
> >>  static inline int add_swap_count_continuation(swp_entry_t swp, gfp_t gfp_mask)
> >>  {
> >>         return 0;
> >> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> >> index ee0a719c8be9..52109ad13f78 100644
> >> --- a/mm/khugepaged.c
> >> +++ b/mm/khugepaged.c
> >> @@ -756,6 +756,7 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
> >>         list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
> >>                 list_del(&src_page->lru);
> >>                 release_pte_page(src_page);
> >> +               free_swap_cache(src_page);
> >
> > Will this really work? The free_swap_cache() will just dec refcounts
> > without putting the page back to buddy. So the hugepage is not
> > actually freed at all. Am I missing something?
>
> Thanks for catching this! If page is on percpu lru_pvecs cache, page will
> be released when lru_pvecs are drained. But if not, free_swap_cache() won't
> free the page as it assumes the caller has a reference on the page and thus
> only does page_ref_sub(). Does the below change looks sense for you?

THP gets drained immediately so they won't stay in pagevecs.

>
> diff --git a/mm/khugepaged.c b/mm/khugepaged.c
> index 52109ad13f78..b8c96e33591d 100644
> --- a/mm/khugepaged.c
> +++ b/mm/khugepaged.c
> @@ -755,8 +755,12 @@ static void __collapse_huge_page_copy(pte_t *pte, struct page *page,
>
>         list_for_each_entry_safe(src_page, tmp, compound_pagelist, lru) {
>                 list_del(&src_page->lru);
> -               release_pte_page(src_page);
> +               mod_node_page_state(page_pgdat(src_page),
> +                                   NR_ISOLATED_ANON + page_is_file_lru(src_page),
> +                                   -compound_nr(src_page));
> +               unlock_page(src_page);
>                 free_swap_cache(src_page);
> +               putback_lru_page(src_page);

I'm not sure if it is worth it or not for a rare corner case since THP
should not stay in swapcache unless try_to_unmap() in vmscan fails
IIUC. And it is not guaranteed that free_swap_cache() will get the
page lock.

>         }
>  }
>
> Thanks!
>
> >
> >>         }
> >>  }
> >>
> >> diff --git a/mm/swap.h b/mm/swap.h
> >> index 0193797b0c92..863f6086c916 100644
> >> --- a/mm/swap.h
> >> +++ b/mm/swap.h
> >> @@ -41,7 +41,6 @@ void __delete_from_swap_cache(struct page *page,
> >>  void delete_from_swap_cache(struct page *page);
> >>  void clear_shadow_from_swap_cache(int type, unsigned long begin,
> >>                                   unsigned long end);
> >> -void free_swap_cache(struct page *page);
> >>  struct page *lookup_swap_cache(swp_entry_t entry,
> >>                                struct vm_area_struct *vma,
> >>                                unsigned long addr);
> >> @@ -81,10 +80,6 @@ static inline struct address_space *swap_address_space(swp_entry_t entry)
> >>         return NULL;
> >>  }
> >>
> >> -static inline void free_swap_cache(struct page *page)
> >> -{
> >> -}
> >> -
> >>  static inline void show_swap_cache_info(void)
> >>  {
> >>  }
> >> --
> >> 2.23.0
> >>
> >>
> > .
> >
>
