Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 332404CAD78
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 19:24:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244456AbiCBSZd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 13:25:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45764 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232866AbiCBSZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 13:25:30 -0500
Received: from mail-ed1-x52d.google.com (mail-ed1-x52d.google.com [IPv6:2a00:1450:4864:20::52d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B0CAB65D8
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 10:24:47 -0800 (PST)
Received: by mail-ed1-x52d.google.com with SMTP id s14so3500754edw.0
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 10:24:46 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=5mW/DgEYHc6lx5ZGe3709yEtY8pwd8eOROaDalazgpU=;
        b=hHBVL0nLI4SEFVkQyemKiLQM4To85AQfwckY5ua0yrip8ueb3x8thwVswa/n3Ru31z
         3YvC6v0eT6CwlPk+t29WSczfspmsXkoHOq63nYXpeYYJ+bLmbQhNS7rhsQEbMTDaQlqf
         O20SfkZazwLAsM5FpuQ2IrctDoZW0w+yUJy+ltu/4v6kdrBMZtCRacVhkizd5uVSn4eg
         RWedA5CE8GMQ1fxROa38lwbhjty4csWx1KGli66uwA9MH/dshF6k9Vl3UJ5o2qPX7eNT
         c1p/YXOa9Ol/Jk/QReVRJnFgkIZV7MSqTeVMx1NVWve6maLsAVV+BO19ls+b10Ub3GzA
         ajoQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=5mW/DgEYHc6lx5ZGe3709yEtY8pwd8eOROaDalazgpU=;
        b=M2XlQWfPitnlS3E4/khsdB5Teevl4macPLTl4GfbFEZVqC1lFntyA98N+LYX5ahH6p
         iT0Ru0UV/1wZEd7J8Z/t6bTwbng2CImFEh9CeDy7O7VtcyySLL1lHqWbno8mMbp3wU6i
         0LATY24aEmgcxUNwzIACqNlENlXxb+QFIzSexXYwCFbbU0iASYB6diKtBeBQhgFw/G2V
         SiLvadCmkiFRhk21q3i3pUzREYGVAzZwqX77vlwcxeQU8wGejD9V8sQOx5MAEz5MQ1kf
         wxpNUQdFoYKwYTO3P7BLNvQAw81vmPfzeZfVxNt9OqP8NWN7Tl2UNrPTTiaUCVZbSDzv
         5RtA==
X-Gm-Message-State: AOAM533iEKAokpkLnSER7ZXsH7ScYGRJclUnakIb3LY/MwR4CoXfouBT
        /0GTowljmx9Pubjto7GDYOPqghsE9abobnaA9mvBhTTCV/E=
X-Google-Smtp-Source: ABdhPJwtlmacYkZgfLGIBKLJUts9jln6AiTmfmBKHxSbBSs2UVFp+qpxbXHGPViN2jlIhClwEUpNb8+GHMq4XSXNDGw=
X-Received: by 2002:a05:6402:2987:b0:414:39b0:7fc1 with SMTP id
 eq7-20020a056402298700b0041439b07fc1mr9800120edb.214.1646245485535; Wed, 02
 Mar 2022 10:24:45 -0800 (PST)
MIME-Version: 1.0
References: <20220302082145.12028-1-linmiaohe@huawei.com>
In-Reply-To: <20220302082145.12028-1-linmiaohe@huawei.com>
From:   Yang Shi <shy828301@gmail.com>
Date:   Wed, 2 Mar 2022 10:24:34 -0800
Message-ID: <CAHbLzkopyw2BtuWooTf_LGBWkkPdCiVGsFJERsWq8xSEdb=xXw@mail.gmail.com>
Subject: Re: [PATCH] mm/huge_memory: make is_transparent_hugepage() static
To:     Miaohe Lin <linmiaohe@huawei.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>,
        William Kucharski <william.kucharski@oracle.com>,
        Hugh Dickins <hughd@google.com>, Peter Xu <peterx@redhat.com>,
        Linux MM <linux-mm@kvack.org>,
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

On Wed, Mar 2, 2022 at 12:22 AM Miaohe Lin <linmiaohe@huawei.com> wrote:
>
> It's only used inside the huge_memory.c now. Don't export it and make
> it static. We can thus reduce the size of huge_memory.o a bit.
>
> Without this patch:
>    text    data     bss     dec     hex filename
>   32319    2965       4   35288    89d8 mm/huge_memory.o
>
> With this patch:
>    text    data     bss     dec     hex filename
>   32042    2957       4   35003    88bb mm/huge_memory.o
>
> Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>

Reviewed-by: Yang Shi <shy828301@gmail.com>

> ---
>  include/linux/huge_mm.h | 6 ------
>  mm/huge_memory.c        | 3 +--
>  2 files changed, 1 insertion(+), 8 deletions(-)
>
> diff --git a/include/linux/huge_mm.h b/include/linux/huge_mm.h
> index 0734aff8fa19..2999190adc22 100644
> --- a/include/linux/huge_mm.h
> +++ b/include/linux/huge_mm.h
> @@ -183,7 +183,6 @@ unsigned long thp_get_unmapped_area(struct file *filp, unsigned long addr,
>
>  void prep_transhuge_page(struct page *page);
>  void free_transhuge_page(struct page *page);
> -bool is_transparent_hugepage(struct page *page);
>
>  bool can_split_folio(struct folio *folio, int *pextra_pins);
>  int split_huge_page_to_list(struct page *page, struct list_head *list);
> @@ -341,11 +340,6 @@ static inline bool transhuge_vma_enabled(struct vm_area_struct *vma,
>
>  static inline void prep_transhuge_page(struct page *page) {}
>
> -static inline bool is_transparent_hugepage(struct page *page)
> -{
> -       return false;
> -}
> -
>  #define transparent_hugepage_flags 0UL
>
>  #define thp_get_unmapped_area  NULL
> diff --git a/mm/huge_memory.c b/mm/huge_memory.c
> index b49e1a11df2e..592588825c07 100644
> --- a/mm/huge_memory.c
> +++ b/mm/huge_memory.c
> @@ -533,7 +533,7 @@ void prep_transhuge_page(struct page *page)
>         set_compound_page_dtor(page, TRANSHUGE_PAGE_DTOR);
>  }
>
> -bool is_transparent_hugepage(struct page *page)
> +static inline bool is_transparent_hugepage(struct page *page)
>  {
>         if (!PageCompound(page))
>                 return false;
> @@ -542,7 +542,6 @@ bool is_transparent_hugepage(struct page *page)
>         return is_huge_zero_page(page) ||
>                page[1].compound_dtor == TRANSHUGE_PAGE_DTOR;
>  }
> -EXPORT_SYMBOL_GPL(is_transparent_hugepage);
>
>  static unsigned long __thp_get_unmapped_area(struct file *filp,
>                 unsigned long addr, unsigned long len,
> --
> 2.23.0
>
