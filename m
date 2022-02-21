Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EFB234BD5AD
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 07:00:34 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344823AbiBUGAE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Feb 2022 01:00:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47176 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234157AbiBUGAC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Feb 2022 01:00:02 -0500
Received: from mail-lf1-x12c.google.com (mail-lf1-x12c.google.com [IPv6:2a00:1450:4864:20::12c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B33D850E36
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:59:39 -0800 (PST)
Received: by mail-lf1-x12c.google.com with SMTP id e5so16554243lfr.9
        for <linux-kernel@vger.kernel.org>; Sun, 20 Feb 2022 21:59:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z3epHuUYfz+WUAI/LAxK3vgXKIpB82CcxkhBmhauKLc=;
        b=Gdf1eQMxTIf+KJfkNJ1tawz7LJdaENEUBQlsbA/YqS9D0+LexQ4E3qAbP22oj7o1a7
         Bn9pw+0SyArLWzePBxy8J7t3vndI82jDKSB+9zgjVcRM7l9rFyTbtg02NZvNjuDEMffP
         TQ4XjNbgD80wurfeSqpb3VSbVSg7DKeWhYSeKD/6mXqz8s5zOvg7wwA1BgvgHBAOw6wt
         1dFpug5qRLI+Qis6eEyR6bMEKckuXTQTkF4TQ4VsZlmxHzVYkfVXNzo8Oav0ehsOgfyL
         oE436/LNzxVnicfKH9NhedWD8HAJWAFQ1O/7xUfQZjgU8ayLgQH7QZ9YTkUXzzHruFjy
         o8aA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z3epHuUYfz+WUAI/LAxK3vgXKIpB82CcxkhBmhauKLc=;
        b=dgE43GaDUH/i5l3ml/aC0EWwIHziR4ronejT4CI4mb75X5ajT2jJcbBc14SoI+hKDR
         eXO5UqxFAM0mLHwxizkrrPaGfTWELRvukgvVHOn378pA070YU126x6kSniOsLI8aG/Hj
         DvhRUP8GLGxTrsA3h2xGZ/DbhBn3xr+HvGZyYpYlwhSBcFoLxaI+ZMFH7puSdYUAGCUG
         irBGcLH5OG1fy9q4W7E0IlQ2f1Xr3hWZf9EJ7jfZZeFYSbJQOh8nDLWJljD3XKGZnneS
         0xzLEwT5zHQhU0jXY+H85lvrgEd63zoqMLUubHrAj9gcKIEudjYi9lcMHav+16AzD6ev
         s8jQ==
X-Gm-Message-State: AOAM531gGyh0HLj1gshmaVvimyDPgcVZ+F8utd4Peyn0OPUJJNRuFH4M
        bm6E7q7W8vblqEM/Sov43QSbB6mxtHZ9lDJXUFKygQ==
X-Google-Smtp-Source: ABdhPJxCztzqv2Asz9YqnW6boj0syKAMz2iapKRHDJ0jArJ/slDF0+6ARy1ddqQXcPuEgOEASBxgAWy7OunXAyvqZ1w=
X-Received: by 2002:a05:6512:965:b0:443:7340:9893 with SMTP id
 v5-20020a056512096500b0044373409893mr13045429lft.119.1645423178084; Sun, 20
 Feb 2022 21:59:38 -0800 (PST)
MIME-Version: 1.0
References: <20220218141004.16912-1-phil.chang@mediatek.com>
In-Reply-To: <20220218141004.16912-1-phil.chang@mediatek.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Mon, 21 Feb 2022 11:29:26 +0530
Message-ID: <CAFA6WYMtxbJXh=WHLPg5gg7JMKUGy+NdKTh9Jb3RbNO97kjoDg@mail.gmail.com>
Subject: Re: [PATCH v3] tee: make tee_shm_register_kernel_buf vmalloc supported
To:     Phil Chang <phil.chang@mediatek.com>
Cc:     jens.wiklander@linaro.org, matthias.bgg@gmail.com,
        op-tee@lists.trustedfirmware.org, linux-kernel@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 18 Feb 2022 at 19:40, Phil Chang <phil.chang@mediatek.com> wrote:
>
> In some low-memory devices, it's hard to aquire large-orders pages,
> this patch allowed user using scatter pages to register shm.
>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
>
> Changelog
>         v2 -> v3: use the "n" variable to walk through "page_count"
>
>  drivers/tee/optee/call.c |  2 +-
>  drivers/tee/tee_shm.c    | 37 ++++++++++++++++++++++++++-----------
>  2 files changed, 27 insertions(+), 12 deletions(-)
>

Apart from minor nit below, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index bd49ec934060..2082e632adff 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -362,7 +362,7 @@ int optee_check_mem_type(unsigned long start, size_t num_pages)
>          * Allow kernel address to register with OP-TEE as kernel
>          * pages are configured as normal memory only.
>          */
> -       if (virt_addr_valid(start))
> +       if (virt_addr_valid(start) || is_vmalloc_addr((void *)start))
>                 return 0;
>
>         mmap_read_lock(mm);
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index f31e29e8f1ca..1412adad9397 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -23,21 +23,36 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>                                 struct page **pages)
>  {
> -       struct kvec *kiov;

> -       size_t n;
>         int rc;
> +       size_t n;

nit: this redundant change can be removed.

-Sumit

>
> -       kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -       if (!kiov)
> -               return -ENOMEM;
> +       if (is_vmalloc_addr((void *)start)) {
> +               struct page *page;
>
> -       for (n = 0; n < page_count; n++) {
> -               kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> -               kiov[n].iov_len = PAGE_SIZE;
> -       }
> +               for (n = 0; n < page_count; n++) {
> +                       page = vmalloc_to_page((void *)(start + PAGE_SIZE * n));
> +                       if (!page)
> +                               return -ENOMEM;
> +
> +                       get_page(page);
> +                       pages[n] = page;
> +               }
> +               rc = page_count;
> +       } else {
> +               struct kvec *kiov;
>
> -       rc = get_kernel_pages(kiov, page_count, 0, pages);
> -       kfree(kiov);
> +               kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> +               if (!kiov)
> +                       return -ENOMEM;
> +
> +               for (n = 0; n < page_count; n++) {
> +                       kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> +                       kiov[n].iov_len = PAGE_SIZE;
> +               }
> +
> +               rc = get_kernel_pages(kiov, page_count, 0, pages);
> +               kfree(kiov);
> +       }
>
>         return rc;
>  }
> --
> 2.25.1
