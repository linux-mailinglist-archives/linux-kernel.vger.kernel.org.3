Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 601BD49DB15
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:00:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237025AbiA0HAM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:00:12 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiA0HAK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:00:10 -0500
Received: from mail-lf1-x12d.google.com (mail-lf1-x12d.google.com [IPv6:2a00:1450:4864:20::12d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C88CFC061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:00:09 -0800 (PST)
Received: by mail-lf1-x12d.google.com with SMTP id a28so3439967lfl.7
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:00:09 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=S7Wj6K+jdrqTZkqkW56gnD/1cpS4GP1Ik26U4sw7jvg=;
        b=BAxxNZhSZs694CyqzbmCWepfzKa403uxTzSj+Xf95rpbdhfhc8PB16YWPNqPwfHnTc
         FC60HlAqXGAdIPbDbxJv3Kymuvagsv6HdjzfjhPPcQC829ed1PZTAF5WhHqPCElkWYKm
         HX29J7TDrkf8VqZFRYIeGm+Z7oO35ua1yz7tPyQPvdmn7ZPnpSGhgJGAmeeUXG4WXTk9
         4ma8dG/kDgcWav+67Z7av5519IBCr47YjEEM2TcC4lU4lKoJDutmlxybnAHbQ+H7NKtC
         gfJbtq4zHpEQKbKD/eFrdoBulK/Mbjn4Oam8dPPrDP6pfiW+pB6skK/8P0xCL7Mkw2lw
         2Dnw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=S7Wj6K+jdrqTZkqkW56gnD/1cpS4GP1Ik26U4sw7jvg=;
        b=1hlvp+4C1IgYbGiiBM3No7xBJfWxfBiA65+w+wusvKWlr7IVd+rnVTaQjuuzLBgAcK
         ztrp7MG5wvANPbWeP+/Nkhzca4Wb2cM947xZfIzokidqilNprap+bumkkAmtm6OLtJSH
         stUQY3ohJ3hD48Ewq+YbCB6TXUsPg3A7GUth88+rE7Cgj3L1G7ZBMUZnvbjrqbsTkMHA
         YKT9zop/psO5fuabuYffdGjBnHnLeEUfPo+FIiQudRdfbAxvpm9ApMmGJLvjN1Gh4AxR
         h5DP5+zQ5KqSkDnJlqtzcFjVHUKf9f725oJ8PHfOg8M9S79krDbVFU4pXTGle2UO+cmC
         c2Sg==
X-Gm-Message-State: AOAM532fESdb4BkUH0bKdAo7vMlZskO9yF9+dFu+iT05C0SNgIojRpGm
        LDsFl1hOtpTbu9qXGRDph55VvqSMqK133R9jyLXavw==
X-Google-Smtp-Source: ABdhPJz2MFNM0gRU1auGkrMUJZ3yxHRVDSQZX+7uPy/CbRXXX+sXB5lsKd7ll3ETnLZTUBfWJdCkI9JuH7rJHSwwPTI=
X-Received: by 2002:a05:6512:3ac:: with SMTP id v12mr1971271lfp.40.1643266807407;
 Wed, 26 Jan 2022 23:00:07 -0800 (PST)
MIME-Version: 1.0
References: <20220125162938.838382-1-jens.wiklander@linaro.org> <20220125162938.838382-12-jens.wiklander@linaro.org>
In-Reply-To: <20220125162938.838382-12-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 27 Jan 2022 12:29:56 +0530
Message-ID: <CAFA6WYNzN_34fWdY+ANMp-TRCKr_tPN1RFhdQPjidDWkLKs0UA@mail.gmail.com>
Subject: Re: [PATCH v3 11/12] tee: replace tee_shm_register()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 25 Jan 2022 at 21:59, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> tee_shm_register() is replaced by the previously introduced functions
> tee_shm_register_user_buf() and tee_shm_register_kernel_buf().
>
> Since there are not external callers left we can remove tee_shm_register()
> and refactor the remains.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_shm.c   | 156 +++++++++++++++++++++++-----------------
>  include/linux/tee_drv.h |  11 ---
>  2 files changed, 90 insertions(+), 77 deletions(-)
>

Other than minor comment below, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 0b6f7aabbf88..c3a29022ec72 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -12,17 +12,43 @@
>  #include <linux/uio.h>
>  #include "tee_private.h"
>
> +static void shm_put_kernel_pages(struct page **pages, size_t page_count)
> +{
> +       size_t n;
> +
> +       for (n = 0; n < page_count; n++)
> +               put_page(pages[n]);
> +}
> +
> +static int shm_get_kernel_pages(unsigned long start, size_t page_count,
> +                               struct page **pages)
> +{
> +       struct kvec *kiov;
> +       size_t n;
> +       int rc;
> +
> +       kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> +       if (!kiov)
> +               return -ENOMEM;
> +
> +       for (n = 0; n < page_count; n++) {
> +               kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> +               kiov[n].iov_len = PAGE_SIZE;
> +       }
> +
> +       rc = get_kernel_pages(kiov, page_count, 0, pages);
> +       kfree(kiov);
> +
> +       return rc;
> +}
> +
>  static void release_registered_pages(struct tee_shm *shm)
>  {
>         if (shm->pages) {
> -               if (shm->flags & TEE_SHM_USER_MAPPED) {
> +               if (shm->flags & TEE_SHM_USER_MAPPED)
>                         unpin_user_pages(shm->pages, shm->num_pages);
> -               } else {
> -                       size_t n;
> -
> -                       for (n = 0; n < shm->num_pages; n++)
> -                               put_page(shm->pages[n]);
> -               }
> +               else
> +                       shm_put_kernel_pages(shm->pages, shm->num_pages);
>
>                 kfree(shm->pages);
>         }
> @@ -189,28 +215,24 @@ struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
>
> -struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> -                                size_t length, u32 flags)
> +static struct tee_shm *
> +register_shm_helper(struct tee_context *ctx, unsigned long addr,
> +                   size_t length, u32 flags, int id)
>  {
>         struct tee_device *teedev = ctx->teedev;
> -       const u32 req_user_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
> -       const u32 req_kernel_flags = TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED;
>         struct tee_shm *shm;
> +       unsigned long start;
> +       int num_pages;

s/int/size_t/

-Sumit

>         void *ret;
>         int rc;
> -       int num_pages;
> -       unsigned long start;
> -
> -       if (flags != req_user_flags && flags != req_kernel_flags)
> -               return ERR_PTR(-ENOTSUPP);
>
>         if (!tee_device_get(teedev))
>                 return ERR_PTR(-EINVAL);
>
>         if (!teedev->desc->ops->shm_register ||
>             !teedev->desc->ops->shm_unregister) {
> -               tee_device_put(teedev);
> -               return ERR_PTR(-ENOTSUPP);
> +               ret = ERR_PTR(-ENOTSUPP);
> +               goto err_dev_put;
>         }
>
>         teedev_ctx_get(ctx);
> @@ -218,13 +240,13 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>         shm = kzalloc(sizeof(*shm), GFP_KERNEL);
>         if (!shm) {
>                 ret = ERR_PTR(-ENOMEM);
> -               goto err;
> +               goto err_ctx_put;
>         }
>
>         refcount_set(&shm->refcount, 1);
> -       shm->flags = flags | TEE_SHM_REGISTER;
> +       shm->flags = flags;
>         shm->ctx = ctx;
> -       shm->id = -1;
> +       shm->id = id;
>         addr = untagged_addr(addr);
>         start = rounddown(addr, PAGE_SIZE);
>         shm->offset = addr - start;
> @@ -233,71 +255,45 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>         shm->pages = kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
>         if (!shm->pages) {
>                 ret = ERR_PTR(-ENOMEM);
> -               goto err;
> +               goto err_free_shm;
>         }
>
> -       if (flags & TEE_SHM_USER_MAPPED) {
> +       if (flags & TEE_SHM_USER_MAPPED)
>                 rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
>                                          shm->pages);
> -       } else {
> -               struct kvec *kiov;
> -               int i;
> -
> -               kiov = kcalloc(num_pages, sizeof(*kiov), GFP_KERNEL);
> -               if (!kiov) {
> -                       ret = ERR_PTR(-ENOMEM);
> -                       goto err;
> -               }
> -
> -               for (i = 0; i < num_pages; i++) {
> -                       kiov[i].iov_base = (void *)(start + i * PAGE_SIZE);
> -                       kiov[i].iov_len = PAGE_SIZE;
> -               }
> -
> -               rc = get_kernel_pages(kiov, num_pages, 0, shm->pages);
> -               kfree(kiov);
> -       }
> +       else
> +               rc = shm_get_kernel_pages(start, num_pages, shm->pages);
>         if (rc > 0)
>                 shm->num_pages = rc;
>         if (rc != num_pages) {
>                 if (rc >= 0)
>                         rc = -ENOMEM;
>                 ret = ERR_PTR(rc);
> -               goto err;
> -       }
> -
> -       mutex_lock(&teedev->mutex);
> -       shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> -       mutex_unlock(&teedev->mutex);
> -
> -       if (shm->id < 0) {
> -               ret = ERR_PTR(shm->id);
> -               goto err;
> +               goto err_put_shm_pages;
>         }
>
>         rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
>                                              shm->num_pages, start);
>         if (rc) {
>                 ret = ERR_PTR(rc);
> -               goto err;
> +               goto err_put_shm_pages;
>         }
>
>         return shm;
> -err:
> -       if (shm) {
> -               if (shm->id >= 0) {
> -                       mutex_lock(&teedev->mutex);
> -                       idr_remove(&teedev->idr, shm->id);
> -                       mutex_unlock(&teedev->mutex);
> -               }
> -               release_registered_pages(shm);
> -       }
> +err_put_shm_pages:
> +       if (flags & TEE_SHM_USER_MAPPED)
> +               unpin_user_pages(shm->pages, shm->num_pages);
> +       else
> +               shm_put_kernel_pages(shm->pages, shm->num_pages);
> +       kfree(shm->pages);
> +err_free_shm:
>         kfree(shm);
> +err_ctx_put:
>         teedev_ctx_put(ctx);
> +err_dev_put:
>         tee_device_put(teedev);
>         return ret;
>  }
> -EXPORT_SYMBOL_GPL(tee_shm_register);
>
>  /**
>   * tee_shm_register_user_buf() - Register a userspace shared memory buffer
> @@ -310,8 +306,35 @@ EXPORT_SYMBOL_GPL(tee_shm_register);
>  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>                                           unsigned long addr, size_t length)
>  {
> -       return tee_shm_register(ctx, addr, length,
> -                               TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
> +       u32 flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
> +       struct tee_device *teedev = ctx->teedev;
> +       struct tee_shm *shm;
> +       void *ret;
> +       int id;
> +
> +       mutex_lock(&teedev->mutex);
> +       id = idr_alloc(&teedev->idr, NULL, 1, 0, GFP_KERNEL);
> +       mutex_unlock(&teedev->mutex);
> +       if (id < 0)
> +               return ERR_PTR(id);
> +
> +       shm = register_shm_helper(ctx, addr, length, flags, id);
> +       if (IS_ERR(shm)) {
> +               mutex_lock(&teedev->mutex);
> +               idr_remove(&teedev->idr, id);
> +               mutex_unlock(&teedev->mutex);
> +               return shm;
> +       }
> +
> +       mutex_lock(&teedev->mutex);
> +       ret = idr_replace(&teedev->idr, shm, id);
> +       mutex_unlock(&teedev->mutex);
> +       if (IS_ERR(ret)) {
> +               tee_shm_free(shm);
> +               return ret;
> +       }
> +
> +       return shm;
>  }
>
>  /**
> @@ -327,8 +350,9 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>                                             void *addr, size_t length)
>  {
> -       return tee_shm_register(ctx, (unsigned long)addr, length,
> -                               TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
> +       u32 flags = TEE_SHM_REGISTER | TEE_SHM_KERNEL_MAPPED;
> +
> +       return register_shm_helper(ctx, (unsigned long)addr, length, flags, -1);
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
>
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index c9d2cc32a5ed..a3b663ef0694 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -276,17 +276,6 @@ void *tee_get_drvdata(struct tee_device *teedev);
>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
>
> -/**
> - * tee_shm_register() - Register shared memory buffer
> - * @ctx:       Context that registers the shared memory
> - * @addr:      Address is userspace of the shared buffer
> - * @length:    Length of the shared buffer
> - * @flags:     Flags setting properties for the requested shared memory.
> - *
> - * @returns a pointer to 'struct tee_shm'
> - */
> -struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> -                                size_t length, u32 flags);
>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>                                             void *addr, size_t length);
>
> --
> 2.31.1
>
