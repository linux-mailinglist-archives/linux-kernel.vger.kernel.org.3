Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D57C04B81F7
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 08:49:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230470AbiBPHpO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 02:45:14 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:34700 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230439AbiBPHpJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 02:45:09 -0500
Received: from mail-pf1-x42e.google.com (mail-pf1-x42e.google.com [IPv6:2607:f8b0:4864:20::42e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 814B31A1300
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:44:50 -0800 (PST)
Received: by mail-pf1-x42e.google.com with SMTP id i6so1480773pfc.9
        for <linux-kernel@vger.kernel.org>; Tue, 15 Feb 2022 23:44:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=idVPFv+DSP7Si9bHKwJJc9JjyE+2OuKAEjgsCztUSos=;
        b=gy/dL5TIr1X+xakwzesx8ufBPPqKcsEU/MydhPv52av2EGesaFMns/kPwGnB/HR1NV
         j/o5MsXn5rMr6hyt1iZ38HeGLOfghXgiWLc97H+V2w2t/HnnCzA021pn0+M0Y0/HM6k2
         yaaWfNRT+5YJMn9WoA3zcKvWOPkOgjtZVSrp2azu4vidQ/eYhHoyhagV8E85N943KU7d
         DxtM25hc6bJWAtYfl/DiUG1mmGjiotzQPs+HaxZ+gUBv3AU0QFz2Y0etWKp3ghE2TWR3
         nuBvqBdCamH9pH0gl1k4u/bTQBTZGwXYDgiHejfbDYpi+N+NhvMKEmlRCfzLrjn7O9DO
         b9eg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=idVPFv+DSP7Si9bHKwJJc9JjyE+2OuKAEjgsCztUSos=;
        b=LDr5cytpynH253+f72N4Z1pwq0ZSTirXboY32XdyiLfgbkTotktGx8l5B1CbhWjWn9
         EWz2ClnhtEPf0Ny5o3PYLGwRpff/PNeqeiKh4+LUewsFin7sdZEHIB9Br68cQX0RWELq
         8I25aycso9o3s4hk5pjTFJVENkPRUBUWBnFqGHa/QdvRwjf3tPWm7+cW7gWY9YHQ5OnM
         VCNfMRmRSYyu+DRlZ+IUdU9pvw56L8MP8AtLvhOinzzprY4y/L2gPT0cYKaMxeL24wA5
         s8Q4mJ1779DhujMVzz0xqoG4dFvc2/jymE8gS0nV/I8RcUc1jqEHaojd4rlabSSlqs+g
         mZDA==
X-Gm-Message-State: AOAM533B0+qzOc6ytCUvLsybmBs/EP+IQIIRdPu7TqPq/v4Ljdbcg42l
        NPhPhthOUqjgH+zceTq6X61M6IG3jkmudo9YxcY87g==
X-Google-Smtp-Source: ABdhPJzuIh5wWz46XEA0zvfNNZJo1eWh+z4xvjWNgivErUGhnKJ5WQ58yHemMMrLvrGS19L1gJrURpQMej4oPpcEOEM=
X-Received: by 2002:a05:6a00:2301:b0:4e1:5842:48d7 with SMTP id
 h1-20020a056a00230100b004e1584248d7mr2037614pfh.14.1644997489966; Tue, 15 Feb
 2022 23:44:49 -0800 (PST)
MIME-Version: 1.0
References: <20220213162110.27210-1-phil.chang@mediatek.com>
In-Reply-To: <20220213162110.27210-1-phil.chang@mediatek.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 16 Feb 2022 08:44:39 +0100
Message-ID: <CAHUa44HynmNkNdzxu0R0NALLja86jT2WGEVcz0rCYfpxt=bjdw@mail.gmail.com>
Subject: Re: [PATCH] tee: make tee_shm_register_kernel_buf vmalloc supported
To:     Phil Chang <Phil.Chang@mediatek.com>
Cc:     matthias.bgg@gmail.com, op-tee@lists.trustedfirmware.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
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

On Sun, Feb 13, 2022 at 5:21 PM Phil Chang <phil.chang@mediatek.com> wrote:
>
> In some low-memory devices, it's hard to aquire large-orders pages,
> this patch allowed user using scatter pages to register shm.
>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> ---
>  drivers/tee/optee/call.c |  2 +-
>  drivers/tee/tee_shm.c    | 40 ++++++++++++++++++++++++++++------------
>  2 files changed, 29 insertions(+), 13 deletions(-)
>
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
> index f31e29e8f1ca..861403588485 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -23,22 +23,38 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>                                 struct page **pages)
>  {
> -       struct kvec *kiov;
> -       size_t n;
>         int rc;
>
> -       kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> -       if (!kiov)
> -               return -ENOMEM;
> -
> -       for (n = 0; n < page_count; n++) {
> -               kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> -               kiov[n].iov_len = PAGE_SIZE;
> +       if (is_vmalloc_addr((void *)start)) {
> +               struct page *page;
> +               int i;
> +
> +               for (i = 0; i < page_count; i++) {

page_count is of an unsigned type and i is of a signed type, this is
bound to cause a warning.
Please move the "n" variable below to the top of this function and use
that as an index variable here too.

> +                       page = vmalloc_to_page((void *)(start + PAGE_SIZE * i));
> +                       if (!page)
> +                               return -ENOMEM;
> +
> +                       get_page(page);
> +                       pages[i] = page;
> +               }
> +               rc = page_count;
> +       } else {
> +               struct kvec *kiov;
> +               size_t n;
> +
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
>         }
>
> -       rc = get_kernel_pages(kiov, page_count, 0, pages);
> -       kfree(kiov);
> -
>         return rc;
>  }
>
> --
> 2.25.1

This patch makes sense. Please fix the comment above and post a v3
(with a changelog this time).

Cheers,
Jens
