Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5755A5665B4
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 10:59:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231283AbiGEI7e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 04:59:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59638 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230256AbiGEI7C (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 04:59:02 -0400
Received: from mail-yw1-x112f.google.com (mail-yw1-x112f.google.com [IPv6:2607:f8b0:4864:20::112f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EB0313F97
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 01:58:14 -0700 (PDT)
Received: by mail-yw1-x112f.google.com with SMTP id 00721157ae682-31c8a1e9e33so49700747b3.5
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 01:58:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bytedance-com.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sM5rr9XH930eMe+kKhMsrEpS8+IPKvTQlFpKhuzpyAU=;
        b=38vV6/TJ24n7ZRM4dXO+EOoIM3G0xx/XnQXc9Glp1uqA544gEpeagWAFsenHIrKFSF
         W069zwwKj98Bd+S769HbRNi+cMUrSnwbNZbozK20e1obKid5j8W0KjW4LEnO+Pngmtud
         Pmcv8lwD8McDk/wvANcocgVAwtBReujNJo695N2bfKHK/xPkdX/lsRfJd/dlpas3O2Xb
         oNKSqQEdq+REzQ8v+7CVgoEmFOSNhKUcR/AGx/TJYl5/1BW+OufMuW78WCvz8E2W6x/P
         KPefbeugobgTR+TmuSplx2yupgD/SB0v0Q9pvr6/AIp+a2j1zMWgAllt1N0EyiOjGm/y
         rzVw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sM5rr9XH930eMe+kKhMsrEpS8+IPKvTQlFpKhuzpyAU=;
        b=bHnh6o9pRjNbzDcawJ1qQjXGXbZ7re+WQtoD887125LGLNcOFoDfCFU7I/Rv4/xkHr
         5zFS1ChDQ90PXH2xHrVnmdMqlwa1CIjd8cCvSjWWLxGBW48VfYLelawp1teSBSoYWQWj
         M+ACIhWKKAGStIB88UfNeU0pJweprKx19UxqNikom1jkvMmGNLWh54tKVu7C0+d4Um/p
         igDhYsnKGX+f3f0EJroDh0M0RMjvWKoZfcIwH1GKLW0YVnt6IC7oO0apMInlpIGFsRaN
         E8vZIE+1iHu4deKNG5U5Bqwhvn2TcM4ORfiwxlstp7UQj8AMdGoZxoYE3DcrFC77xMqj
         0m5w==
X-Gm-Message-State: AJIora/13+Nl6gtbUYs8Xj2SSPaZ/LQD+J2jFQ1ZSdMd068onhC1BTun
        mtUANShlkdZhkzhXhNr9g9ZN7Q79AtpI0kvN+5FbNu4a2Vddl+Ns
X-Google-Smtp-Source: AGRyM1va8+mozJ6MLCCADrMSp3rFlDT7KZwHQfIDDRmqkm7426jzkiTnTKQLD6GSwQ1Id83zf5nN73UAoOeee8SelpI=
X-Received: by 2002:a81:f0d:0:b0:31c:8860:c59f with SMTP id
 13-20020a810f0d000000b0031c8860c59fmr15088183ywp.31.1657011493729; Tue, 05
 Jul 2022 01:58:13 -0700 (PDT)
MIME-Version: 1.0
References: <20220705062953.914256-1-luofei@unicloud.com>
In-Reply-To: <20220705062953.914256-1-luofei@unicloud.com>
From:   Muchun Song <songmuchun@bytedance.com>
Date:   Tue, 5 Jul 2022 16:57:35 +0800
Message-ID: <CAMZfGtUOA81Srwp0OLDMx5Nnpz=s_qmG_a3zauzNyd9AYZzReQ@mail.gmail.com>
Subject: Re: [PATCH] mm,hwpoison,hugetlb: defer dissolve hwpoison hugepage
 when allocating vmemmap failed
To:     luofei <luofei@unicloud.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Linux Memory Management List <linux-mm@kvack.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jul 5, 2022 at 2:32 PM luofei <luofei@unicloud.com> wrote:
>
> When dissolving hwpoison hugepage, if the allocation of vmemmap page
> failed, the faulty page should not be put back on the hugepage free
> list, which will cause the faulty pages to be reused. It's better to

Hi luofei,

How did it happen? If a hugepage is poisoned, then the head page's
flag will be set to PageHWPoison. See the code of
dequeue_huge_page_node_exact() which will filter out hwpoisoned
page. So the hwpoisoned pages cannot be reused, hopefully, I am
not missing something important.

> postpone the reexecution of dissolve operation.
>
> Meanwhile when the page fault handling program calls
> dissolve_free_huge_page() to dissolve the faulty page, the basic page
> fault processing operation(such as migration pages and unmap etc)
> has actually completed. There is no need to return -ENOMEM error code
> to the upper layer for temporarily vmemmap page allocation failure,
> which will cause the caller to make a wrong judgment. So just defer
> dissolve and return success.
>
> Signed-off-by: luofei <luofei@unicloud.com>
> ---
>  mm/hugetlb.c | 34 +++++++++++++++++++++-------------
>  1 file changed, 21 insertions(+), 13 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index ca081078e814..db25458eb0a5 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -90,6 +90,9 @@ struct mutex *hugetlb_fault_mutex_table ____cacheline_aligned_in_smp;
>
>  /* Forward declaration */
>  static int hugetlb_acct_memory(struct hstate *h, long delta);
> +static LLIST_HEAD(hpage_freelist);
> +static void free_hpage_workfn(struct work_struct *work);
> +static DECLARE_DELAYED_WORK(free_hpage_work, free_hpage_workfn);
>
>  static inline bool subpool_is_free(struct hugepage_subpool *spool)
>  {
> @@ -1535,15 +1538,21 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>         if (hstate_is_gigantic(h) && !gigantic_page_runtime_supported())
>                 return;
>
> -       if (hugetlb_vmemmap_restore(h, page))
> +       if (hugetlb_vmemmap_restore(h, page)) {
> +               if (unlikely(PageHWPoison(page))) {
> +                       llist_add((struct llist_node *)&page->mapping, &hpage_freelist);
> +                       schedule_delayed_work(&free_hpage_work, HZ);
> +                       goto out;
> +               }
>                 goto fail;
> +       }
>
>         /*
>          * Move PageHWPoison flag from head page to the raw error pages,
>          * which makes any healthy subpages reusable.
>          */
>         if (unlikely(PageHWPoison(page) && hugetlb_clear_page_hwpoison(page)))
> -               goto fail;
> +               goto out;
>
>         for (i = 0; i < pages_per_huge_page(h);
>              i++, subpage = mem_map_next(subpage, page, i)) {
> @@ -1574,6 +1583,8 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>          */
>         add_hugetlb_page(h, page, true);
>         spin_unlock_irq(&hugetlb_lock);
> +out:
> +       return;
>  }
>
>  /*
> @@ -1587,8 +1598,6 @@ static void __update_and_free_page(struct hstate *h, struct page *page)
>   * to be cleared in free_hpage_workfn() anyway, it is reused as the llist_node
>   * structure of a lockless linked list of huge pages to be freed.
>   */
> -static LLIST_HEAD(hpage_freelist);
> -
>  static void free_hpage_workfn(struct work_struct *work)
>  {
>         struct llist_node *node;
> @@ -1616,12 +1625,11 @@ static void free_hpage_workfn(struct work_struct *work)
>                 cond_resched();
>         }
>  }
> -static DECLARE_WORK(free_hpage_work, free_hpage_workfn);
>
>  static inline void flush_free_hpage_work(struct hstate *h)
>  {
>         if (hugetlb_vmemmap_optimizable(h))
> -               flush_work(&free_hpage_work);
> +               flush_delayed_work(&free_hpage_work);
>  }
>
>  static void update_and_free_page(struct hstate *h, struct page *page,
> @@ -1634,13 +1642,9 @@ static void update_and_free_page(struct hstate *h, struct page *page,
>
>         /*
>          * Defer freeing to avoid using GFP_ATOMIC to allocate vmemmap pages.
> -        *
> -        * Only call schedule_work() if hpage_freelist is previously
> -        * empty. Otherwise, schedule_work() had been called but the workfn
> -        * hasn't retrieved the list yet.
>          */
> -       if (llist_add((struct llist_node *)&page->mapping, &hpage_freelist))
> -               schedule_work(&free_hpage_work);
> +       llist_add((struct llist_node *)&page->mapping, &hpage_freelist);
> +       schedule_delayed_work(&free_hpage_work, 0);
>  }
>
>  static void update_and_free_pages_bulk(struct hstate *h, struct list_head *list)
> @@ -2118,11 +2122,15 @@ int dissolve_free_huge_page(struct page *page)
>                 rc = hugetlb_vmemmap_restore(h, head);
>                 if (!rc) {
>                         update_and_free_page(h, head, false);
> -               } else {
> +               } else if (!PageHWPoison(head)) {
>                         spin_lock_irq(&hugetlb_lock);
>                         add_hugetlb_page(h, head, false);
>                         h->max_huge_pages++;
>                         spin_unlock_irq(&hugetlb_lock);
> +               } else {
> +                       llist_add((struct llist_node *)&head->mapping, &hpage_freelist);
> +                       schedule_delayed_work(&free_hpage_work, HZ);
> +                       rc = 0;
>                 }
>
>                 return rc;
> --
> 2.27.0
>
