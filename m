Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 14AA24CA5CB
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:19:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237309AbiCBNTk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:19:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236810AbiCBNTi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:19:38 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C2F044D240
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:18:53 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id q11so1512169pln.11
        for <linux-kernel@vger.kernel.org>; Wed, 02 Mar 2022 05:18:53 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=qK9d2CW5Qjm76cCegwle8ny9+Ev6C07txl5fuKAcuhc=;
        b=NfQZaZ+q0ThsmrmmiMdQJE5ZqDxPW3SQms7rRu6Rjpb1Xp/TZ30rbx4EAneBfMi/In
         L0RwOsoQ4+z9AP83cTrpdZsB1/FPKvt9JVDUQTu11QHVXhtiUx8Q/VA8RmRY2OwUojO/
         xyeshltWB2Ovpmj4dTxG8febqDnclwVD6JVY57Sw+DS4roS5ktML+furTRsrzPzgMQod
         EsxqnBlwXPljzmQgOwKq322hSjG6MfvMEvhSAJypu1noSulyNAARlSV8ql21DM50GFWa
         WKvg8nGfZWwPbrGUO2Q4QIV66ZhQeO29SYqasCiKOyMkhlb265k/y00H4uoTV70b2gOk
         YnbA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=qK9d2CW5Qjm76cCegwle8ny9+Ev6C07txl5fuKAcuhc=;
        b=bDEd5KlC0lW5o21O1EtKVkYOm3B8mKp7Axh+vaD0k/vjP/9s64BSCE8fN5/9CPuMaw
         Qd7UbU6OSOkENO1GvxN093dTWk8R2/V3nd+NA9Ty7hCIPKFhB6GB9iXu4XM1nurmCyeE
         cwrquZPs/KjA3AiHZ5G83i8LoUFP+2CxRfUWAe/TG3Efbf6/CdAH2KVMGnkax07DgNmf
         UflqLEtTtxNgJYQWPd5MZcBVfcJhWsNeieucWo3Cthi1VhGgWdiUphvOb6Pfp82+e4PC
         H9DMoy8naaJJt0ysajNmiqfdKNrSLbZzru+q/urtplkFRUKgYZFihRsdetA/GejRq7OX
         /K2Q==
X-Gm-Message-State: AOAM5308IXbNQCSmOjZELu65a3k/34lm3Lt5q4IUUDBSRBv9SrSSsofj
        /ee2Pya9fVZqYJMT2lNVt/SxnIyRXU6gJVKcREAZAQ==
X-Google-Smtp-Source: ABdhPJzHllgvusx07u5CjUMpJFy7+fqUKXMPYz4mlr4zSQ8nq4cL6t+YcI+JLAVgOK3OmOA3gjwGDbQpT1+MahuuqTA=
X-Received: by 2002:a17:90a:fe86:b0:1bc:6935:346 with SMTP id
 co6-20020a17090afe8600b001bc69350346mr27461224pjb.150.1646227133275; Wed, 02
 Mar 2022 05:18:53 -0800 (PST)
MIME-Version: 1.0
References: <20220225152040.31896-1-phil.chang@mediatek.com>
In-Reply-To: <20220225152040.31896-1-phil.chang@mediatek.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 2 Mar 2022 14:18:41 +0100
Message-ID: <CAHUa44GDg7hAAFsmeOOkeqi8_1P1Q6jATRdnV9b6S-DhpEEQrA@mail.gmail.com>
Subject: Re: [PATCH v4] tee: make tee_shm_register_kernel_buf vmalloc supported
To:     Phil Chang <Phil.Chang@mediatek.com>
Cc:     sumit.garg@linaro.org, matthias.bgg@gmail.com,
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

On Fri, Feb 25, 2022 at 4:20 PM Phil Chang <phil.chang@mediatek.com> wrote:
>
> In some low-memory devices, it's hard to aquire large-orders pages,
> this patch allowed user using scatter pages to register shm.
>
> Signed-off-by: Phil Chang <phil.chang@mediatek.com>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> ---
>  drivers/tee/optee/call.c |  2 +-
>  drivers/tee/tee_shm.c    | 35 +++++++++++++++++++++++++----------
>  2 files changed, 26 insertions(+), 11 deletions(-)

Looks good to me. Unfortunately this is too late for the coming merge
window, so it's going to be the one after that. Meanwhile it will be
in linux-next.

Thanks,
Jens


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
> index f31e29e8f1ca..836872467dc6 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -23,21 +23,36 @@ static void shm_put_kernel_pages(struct page **pages, size_t page_count)
>  static int shm_get_kernel_pages(unsigned long start, size_t page_count,
>                                 struct page **pages)
>  {
> -       struct kvec *kiov;
>         size_t n;
>         int rc;
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
> +
> +               kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> +               if (!kiov)
> +                       return -ENOMEM;
>
> -       rc = get_kernel_pages(kiov, page_count, 0, pages);
> -       kfree(kiov);
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
>
