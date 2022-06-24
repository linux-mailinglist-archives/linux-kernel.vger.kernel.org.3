Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6B12755A150
	for <lists+linux-kernel@lfdr.de>; Fri, 24 Jun 2022 20:55:59 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230458AbiFXSvy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 24 Jun 2022 14:51:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229751AbiFXSvv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 24 Jun 2022 14:51:51 -0400
Received: from mail-vk1-xa29.google.com (mail-vk1-xa29.google.com [IPv6:2607:f8b0:4864:20::a29])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 21CC681726
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:51:51 -0700 (PDT)
Received: by mail-vk1-xa29.google.com with SMTP id n187so1606937vkn.11
        for <linux-kernel@vger.kernel.org>; Fri, 24 Jun 2022 11:51:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=google.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=f+KB5A9ZpXRBOGLRH7DVETVdHE7Tly7PtMb324fnHg0=;
        b=Bb5vqOXA7AxPyZxq8gpHAGLuTEdugkG+oQaCw8OF59I7gyQQL/F1tIh9p0B+Zw/J01
         GZJyhBIIwVTeLO0wvEABar0lkjPdHp1P44B3cCUMb0sTaTMbuMKHo0Q60dIR7lsAqUe6
         lLiGyEH1gkpH5LgBFecM4gCA3r3LugGWPRFTH3gy0xaERpEB4Idl/1Z46GQbMkoLaIml
         QwH2EVCeeaoKAtf07VekbnP511aRvslqoHt6iYZJcGh+KzFjP+02BYXXjKw2u41b5hIq
         dc/uEx4Kk0RbUMpD9ht7i4E26ed4S9wYIFh5DbnezOiDmLssWfaUdJDKmG/Bon0jud0g
         zVFA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=f+KB5A9ZpXRBOGLRH7DVETVdHE7Tly7PtMb324fnHg0=;
        b=4Tqn7EzvanLdIiNj/t7Oq6YmX0LXjqxVuJyvZQ4d8cc4RDTp6LKAQikrszwK+hDcZr
         2jt5xci3v39QWobFnEZx+qUyxocDoan7i4Y3hxDiezChcZaWj5mld2D9Jm2PnXhwwqHK
         stqWE7lauvb3J+EllPD5XwM9jD2w6Ip7dbLChgpvl1FMOkyGihbx1LFFB46jtzJGk+bS
         5OmKIXasBnqXJQqZcrLkH6TxqzwwyhErX4UPmIvNkXQqrjTTCA/5pxzxg/JkeY4xmIFB
         hdseSzoQuPlhxfa3qkH/XyGOSXEA4H/AULEg9VP2rYIaFvwM6WpK7Ac96IWQ0Juqzj5/
         Wz9A==
X-Gm-Message-State: AJIora9tyqTZb9e7AZkt9iDKxFDtIpzIv9aNaHttGRGINQpobZngyM78
        YmTbxXcd2TW23+TKodSvbdrHHvdLRMpOTQ47GH1ubw==
X-Google-Smtp-Source: AGRyM1uUFolFbpO1U+5VwUItji0OCRCyAC8zr093at7K7mAiNXeD25qxAOkH159LoeV4qyfU76TNovGu9OsiibZszI4=
X-Received: by 2002:a05:6122:1479:b0:36c:502b:fdda with SMTP id
 r25-20020a056122147900b0036c502bfddamr149274vkp.14.1656096710059; Fri, 24 Jun
 2022 11:51:50 -0700 (PDT)
MIME-Version: 1.0
References: <20220624173656.2033256-1-jthoughton@google.com> <20220624173656.2033256-3-jthoughton@google.com>
In-Reply-To: <20220624173656.2033256-3-jthoughton@google.com>
From:   Mina Almasry <almasrymina@google.com>
Date:   Fri, 24 Jun 2022 11:51:38 -0700
Message-ID: <CAHS8izP0+ThdqEmp_v4s+n=Yw15w-JR2tudwVA=rX5WQL-KwMg@mail.gmail.com>
Subject: Re: [RFC PATCH 02/26] hugetlb: sort hstates in hugetlb_init_hstates
To:     James Houghton <jthoughton@google.com>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Muchun Song <songmuchun@bytedance.com>,
        Peter Xu <peterx@redhat.com>,
        David Hildenbrand <david@redhat.com>,
        David Rientjes <rientjes@google.com>,
        Axel Rasmussen <axelrasmussen@google.com>,
        Jue Wang <juew@google.com>,
        Manish Mishra <manish.mishra@nutanix.com>,
        "Dr . David Alan Gilbert" <dgilbert@redhat.com>,
        linux-mm@kvack.org, linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-17.6 required=5.0 tests=BAYES_00,DKIMWL_WL_MED,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,USER_IN_DEF_DKIM_WL,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, Jun 24, 2022 at 10:37 AM James Houghton <jthoughton@google.com> wrote:
>
> When using HugeTLB high-granularity mapping, we need to go through the
> supported hugepage sizes in decreasing order so that we pick the largest
> size that works. Consider the case where we're faulting in a 1G hugepage
> for the first time: we want hugetlb_fault/hugetlb_no_page to map it with
> a PUD. By going through the sizes in decreasing order, we will find that
> PUD_SIZE works before finding out that PMD_SIZE or PAGE_SIZE work too.
>

Mostly nits:

Reviewed-by: Mina Almasry <almasrymina@google.com>

> Signed-off-by: James Houghton <jthoughton@google.com>
> ---
>  mm/hugetlb.c | 40 +++++++++++++++++++++++++++++++++++++---
>  1 file changed, 37 insertions(+), 3 deletions(-)
>
> diff --git a/mm/hugetlb.c b/mm/hugetlb.c
> index a57e1be41401..5df838d86f32 100644
> --- a/mm/hugetlb.c
> +++ b/mm/hugetlb.c
> @@ -33,6 +33,7 @@
>  #include <linux/migrate.h>
>  #include <linux/nospec.h>
>  #include <linux/delayacct.h>
> +#include <linux/sort.h>
>
>  #include <asm/page.h>
>  #include <asm/pgalloc.h>
> @@ -48,6 +49,10 @@
>
>  int hugetlb_max_hstate __read_mostly;
>  unsigned int default_hstate_idx;
> +/*
> + * After hugetlb_init_hstates is called, hstates will be sorted from largest
> + * to smallest.
> + */
>  struct hstate hstates[HUGE_MAX_HSTATE];
>
>  #ifdef CONFIG_CMA
> @@ -3144,14 +3149,43 @@ static void __init hugetlb_hstate_alloc_pages(struct hstate *h)
>         kfree(node_alloc_noretry);
>  }
>
> +static int compare_hstates_decreasing(const void *a, const void *b)
> +{
> +       const int shift_a = huge_page_shift((const struct hstate *)a);
> +       const int shift_b = huge_page_shift((const struct hstate *)b);
> +
> +       if (shift_a < shift_b)
> +               return 1;
> +       if (shift_a > shift_b)
> +               return -1;
> +       return 0;
> +}
> +
> +static void sort_hstates(void)

Maybe sort_hstates_descending(void) for extra clarity.

> +{
> +       unsigned long default_hstate_sz = huge_page_size(&default_hstate);
> +
> +       /* Sort from largest to smallest. */

I'd remove this redundant comment; it's somewhat obvious what the next
line does.

> +       sort(hstates, hugetlb_max_hstate, sizeof(*hstates),
> +            compare_hstates_decreasing, NULL);
> +
> +       /*
> +        * We may have changed the location of the default hstate, so we need to
> +        * update it.
> +        */
> +       default_hstate_idx = hstate_index(size_to_hstate(default_hstate_sz));
> +}
> +
>  static void __init hugetlb_init_hstates(void)
>  {
>         struct hstate *h, *h2;
>
> -       for_each_hstate(h) {
> -               if (minimum_order > huge_page_order(h))
> -                       minimum_order = huge_page_order(h);
> +       sort_hstates();
>
> +       /* The last hstate is now the smallest. */

Same, given that above is sort_hstates().

> +       minimum_order = huge_page_order(&hstates[hugetlb_max_hstate - 1]);
> +
> +       for_each_hstate(h) {
>                 /* oversize hugepages were init'ed in early boot */
>                 if (!hstate_is_gigantic(h))
>                         hugetlb_hstate_alloc_pages(h);
> --
> 2.37.0.rc0.161.g10f37bed90-goog
>
