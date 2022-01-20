Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E718494FDF
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 15:12:19 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345085AbiATOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 09:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56412 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344741AbiATOMP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 09:12:15 -0500
Received: from mail-wm1-x32d.google.com (mail-wm1-x32d.google.com [IPv6:2a00:1450:4864:20::32d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 975CEC061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:12:14 -0800 (PST)
Received: by mail-wm1-x32d.google.com with SMTP id c2so12387061wml.1
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 06:12:14 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Aw6uuAfXuKRPHYmglRvRNpBEU4LlACsaVNNrzJEtTyw=;
        b=mwOPn85cXxRyxvbQXv9Ak0PvELdBdfNtOCUi8SqBmEb9ncHIHvTeej7ZOVbzZzZZTz
         TN/y+Wlh0zNadcnZ3YeffDbJgrl5X5yh/qdtZatuJq2lB9O9xPAqqHkBao0zK85vhdBl
         wQZp3GK2j+CAOF5eQdArKWUiax0kZz2V6MUGj5f+P31hnEOzlU/0cEviso2iNsZWYhtz
         0KEKdAddiiHCuGSO2FT0A5d6nM/R6VOyyRezwgrdO2SeNGjOVYFgCdHEf/Fk6cVgO6oM
         M98HGcfoh2hvD73dwdNqRkyfz6IiEWf7KpD9idDCYz8/beo+tKoMLtnssxRARwoUd0BZ
         byMw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Aw6uuAfXuKRPHYmglRvRNpBEU4LlACsaVNNrzJEtTyw=;
        b=ClIdnQcwUjEQx5KJTcDUUTH+iMX6CvLdqLwkm5WnFLjAjLCY7ifp7Ea5hH9ZaPq7Xd
         Ex7jfwE6Wy7yiwgtRM3X11SMHw/FNMZsnKyydMYz1FX3UoHvva8HIQn44aJYFBuVscT1
         LMrFkTvZPMLyXKa+OTS5a2Aeh2QTGRW96x9BPC9sbfPFzaeWn6kJtzkDXyhiIeAidFZs
         JqGsUl/pQX5NeKXgYpk7DAEvpvLdRs2lL4TlhrChThBtHDAK1yC/3YeZPFGK8Aq6fWMg
         ajWfHN2h4dh/z+CuNE3Ma+/Wxeps4OfJIfNO7Ucllc7GHLNPJyRBJeODPPlhk5+dVAhN
         ErYw==
X-Gm-Message-State: AOAM5336mD2KNhnZZQV6JZUUCNN7taWVeMjTGIvIK8LgSVACX6O8g0Ae
        s1s4B0MXPhJu2SlF8HYWjeG7ePZVJN5aByzH5Ui4UA==
X-Google-Smtp-Source: ABdhPJzE0DM92j4674Kuwc9O/zRRASMKqQg9kWSOS3XgOO/Yt6N4uPbf6slDBW0Jj7KtRb382ibf520ErepftJtxF8U=
X-Received: by 2002:adf:e312:: with SMTP id b18mr28585471wrj.321.1642687933021;
 Thu, 20 Jan 2022 06:12:13 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
 <20220114150824.3578829-12-jens.wiklander@linaro.org> <CAFA6WYMQX_e4JKugQFV=87Wvvo2HAfpWLHHK2_MShGBqHBvh-A@mail.gmail.com>
In-Reply-To: <CAFA6WYMQX_e4JKugQFV=87Wvvo2HAfpWLHHK2_MShGBqHBvh-A@mail.gmail.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 20 Jan 2022 15:12:02 +0100
Message-ID: <CAHUa44H6ANeQYtsbXtZJ--bwJ0S6DTeCDDm3BfE3SGGvZiqgOw@mail.gmail.com>
Subject: Re: [PATCH v2 11/12] tee: replace tee_shm_register()
To:     Sumit Garg <sumit.garg@linaro.org>
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

On Thu, Jan 20, 2022 at 12:51 PM Sumit Garg <sumit.garg@linaro.org> wrote:
>
> On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >
> > tee_shm_register() is replaced by the previously introduced functions
> > tee_shm_register_user_buf() and tee_shm_register_kernel_buf().
> >
> > Since there are not external callers left we can remove tee_shm_register()
> > and refactor the remains.
> >
> > Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> > ---
> >  drivers/tee/tee_shm.c   | 157 +++++++++++++++++++++++-----------------
> >  include/linux/tee_drv.h |  11 ---
> >  2 files changed, 91 insertions(+), 77 deletions(-)
> >
> > diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> > index 6a1dbce75616..fe3e5977dd7c 100644
> > --- a/drivers/tee/tee_shm.c
> > +++ b/drivers/tee/tee_shm.c
> > @@ -12,17 +12,43 @@
> >  #include <linux/uio.h>
> >  #include "tee_private.h"
> >
> > +static void shm_put_kernel_pages(struct page **pages, unsigned long npages)
> > +{
> > +       unsigned long n;
>
> nit: Can we have a consistent prototype for the number of pages?
> size_t as used by struct tee_shm or unsigned long? Same holds true for
> variables below as well: npages, page_count, num_pages, n.

Fair point, I'll fix what's changed here.

>
> > +
> > +       for (n = 0; n < npages; n++)
> > +               put_page(pages[n]);
> > +}
> > +
> > +static int shm_get_kernel_pages(unsigned long start, int page_count,
> > +                               struct page **pages)
> > +{
> > +       struct kvec *kiov;
> > +       unsigned int n;
> > +       int rc;
> > +
> > +       kiov = kcalloc(page_count, sizeof(*kiov), GFP_KERNEL);
> > +       if (!kiov)
> > +               return -ENOMEM;
> > +
> > +       for (n = 0; n < page_count; n++) {
> > +               kiov[n].iov_base = (void *)(start + n * PAGE_SIZE);
> > +               kiov[n].iov_len = PAGE_SIZE;
> > +       }
> > +
> > +       rc = get_kernel_pages(kiov, page_count, 0, pages);
> > +       kfree(kiov);
> > +
> > +       return rc;
> > +}
> > +
> >  static void release_registered_pages(struct tee_shm *shm)
> >  {
> >         if (shm->pages) {
> > -               if (shm->flags & TEE_SHM_USER_MAPPED) {
> > +               if (shm->flags & TEE_SHM_USER_MAPPED)
> >                         unpin_user_pages(shm->pages, shm->num_pages);
> > -               } else {
> > -                       size_t n;
> > -
> > -                       for (n = 0; n < shm->num_pages; n++)
> > -                               put_page(shm->pages[n]);
> > -               }
> > +               else
> > +                       shm_put_kernel_pages(shm->pages, shm->num_pages);
> >
> >                 kfree(shm->pages);
> >         }
> > @@ -191,28 +217,24 @@ struct tee_shm *tee_shm_alloc_priv_kernel_buf(struct tee_context *ctx,
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_kernel_buf);
> >
> > -struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> > -                                size_t length, u32 flags)
> > +static struct tee_shm *
> > +register_shm_helper(struct tee_context *ctx, unsigned long addr,
> > +                   size_t length, u32 flags, int id)
> >  {
> >         struct tee_device *teedev = ctx->teedev;
> > -       const u32 req_user_flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED;
> > -       const u32 req_kernel_flags = TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED;
> >         struct tee_shm *shm;
> > +       unsigned long start;
> > +       int num_pages;
> >         void *ret;
> >         int rc;
> > -       int num_pages;
> > -       unsigned long start;
> > -
> > -       if (flags != req_user_flags && flags != req_kernel_flags)
> > -               return ERR_PTR(-ENOTSUPP);
> >
> >         if (!tee_device_get(teedev))
> >                 return ERR_PTR(-EINVAL);
> >
> >         if (!teedev->desc->ops->shm_register ||
> >             !teedev->desc->ops->shm_unregister) {
> > -               tee_device_put(teedev);
> > -               return ERR_PTR(-ENOTSUPP);
> > +               ret = ERR_PTR(-ENOTSUPP);
>
> Checkpatch warns about this error code:
>
> WARNING: ENOTSUPP is not a SUSV4 error code, prefer EOPNOTSUPP
> #104: FILE: drivers/tee/tee_shm.c:236:
> + ret = ERR_PTR(-ENOTSUPP);

I noticed that too. I'd rather keep it as it is for now as changing
would a bit of a ABI change even if I doubt that anyone is depending
on this particular errno value.

>
> > +               goto err_dev_put;
> >         }
> >
> >         teedev_ctx_get(ctx);
> > @@ -220,13 +242,13 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >         shm = kzalloc(sizeof(*shm), GFP_KERNEL);
> >         if (!shm) {
> >                 ret = ERR_PTR(-ENOMEM);
> > -               goto err;
> > +               goto err_ctx_put;
> >         }
> >
> >         refcount_set(&shm->refcount, 1);
> > -       shm->flags = flags | TEE_SHM_REGISTER;
> > +       shm->flags = flags;
> >         shm->ctx = ctx;
> > -       shm->id = -1;
> > +       shm->id = id;
> >         addr = untagged_addr(addr);
> >         start = rounddown(addr, PAGE_SIZE);
> >         shm->offset = addr - start;
> > @@ -235,71 +257,45 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> >         shm->pages = kcalloc(num_pages, sizeof(*shm->pages), GFP_KERNEL);
> >         if (!shm->pages) {
> >                 ret = ERR_PTR(-ENOMEM);
> > -               goto err;
> > +               goto err_free_shm;
> >         }
> >
> > -       if (flags & TEE_SHM_USER_MAPPED) {
> > +       if (flags & TEE_SHM_USER_MAPPED)
> >                 rc = pin_user_pages_fast(start, num_pages, FOLL_WRITE,
> >                                          shm->pages);
> > -       } else {
> > -               struct kvec *kiov;
> > -               int i;
> > -
> > -               kiov = kcalloc(num_pages, sizeof(*kiov), GFP_KERNEL);
> > -               if (!kiov) {
> > -                       ret = ERR_PTR(-ENOMEM);
> > -                       goto err;
> > -               }
> > -
> > -               for (i = 0; i < num_pages; i++) {
> > -                       kiov[i].iov_base = (void *)(start + i * PAGE_SIZE);
> > -                       kiov[i].iov_len = PAGE_SIZE;
> > -               }
> > -
> > -               rc = get_kernel_pages(kiov, num_pages, 0, shm->pages);
> > -               kfree(kiov);
> > -       }
> > +       else
> > +               rc = shm_get_kernel_pages(start, num_pages, shm->pages);
> >         if (rc > 0)
> >                 shm->num_pages = rc;
> >         if (rc != num_pages) {
> >                 if (rc >= 0)
> >                         rc = -ENOMEM;
> >                 ret = ERR_PTR(rc);
> > -               goto err;
> > -       }
> > -
> > -       mutex_lock(&teedev->mutex);
> > -       shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> > -       mutex_unlock(&teedev->mutex);
> > -
> > -       if (shm->id < 0) {
> > -               ret = ERR_PTR(shm->id);
> > -               goto err;
> > +               goto err_put_shm_pages;
> >         }
> >
> >         rc = teedev->desc->ops->shm_register(ctx, shm, shm->pages,
> >                                              shm->num_pages, start);
> >         if (rc) {
> >                 ret = ERR_PTR(rc);
> > -               goto err;
> > +               goto err_put_shm_pages;
> >         }
> >
> >         return shm;
> > -err:
> > -       if (shm) {
> > -               if (shm->id >= 0) {
> > -                       mutex_lock(&teedev->mutex);
> > -                       idr_remove(&teedev->idr, shm->id);
> > -                       mutex_unlock(&teedev->mutex);
> > -               }
> > -               release_registered_pages(shm);
> > -       }
> > +err_put_shm_pages:
> > +       if (flags & TEE_SHM_USER_MAPPED)
> > +               unpin_user_pages(shm->pages, shm->num_pages);
> > +       else
> > +               shm_put_kernel_pages(shm->pages, shm->num_pages);
> > +       kfree(shm->pages);
> > +err_free_shm:
> >         kfree(shm);
> > +err_ctx_put:
> >         teedev_ctx_put(ctx);
> > +err_dev_put:
> >         tee_device_put(teedev);
> >         return ret;
> >  }
> > -EXPORT_SYMBOL_GPL(tee_shm_register);
> >
> >  /**
> >   * tee_shm_register_user_buf() - Register a userspace shared memory buffer
> > @@ -312,8 +308,36 @@ EXPORT_SYMBOL_GPL(tee_shm_register);
> >  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> >                                           unsigned long addr, size_t length)
> >  {
> > -       return tee_shm_register(ctx, addr, length,
> > -                               TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
> > +       u32 f = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
>
> nit: I would prefer to write variable name as "flags" for clarity.
>
> > +       struct tee_device *teedev = ctx->teedev;
> > +       struct tee_shm *shm;
> > +       void *ret;
> > +       int id;
> > +
> > +       mutex_lock(&teedev->mutex);
> > +       id = idr_alloc(&teedev->idr, NULL, 1, 0, GFP_KERNEL);
> > +       mutex_unlock(&teedev->mutex);
> > +
>
> nit: redundant extra line.
>
> > +       if (id < 0)
> > +               return ERR_PTR(id);
> > +
> > +       shm = register_shm_helper(ctx, addr, length, f, id);
> > +       if (IS_ERR(shm)) {
> > +               mutex_lock(&teedev->mutex);
> > +               idr_remove(&teedev->idr, id);
> > +               mutex_unlock(&teedev->mutex);
> > +               return shm;
> > +       }
> > +
> > +       mutex_lock(&teedev->mutex);
> > +       ret = idr_replace(&teedev->idr, shm, id);
> > +       mutex_unlock(&teedev->mutex);
> > +       if (IS_ERR(ret)) {
> > +               tee_shm_free(shm);
> > +               return ret;
> > +       }
> > +
> > +       return shm;
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_register_user_buf);
> >
> > @@ -330,8 +354,9 @@ EXPORT_SYMBOL_GPL(tee_shm_register_user_buf);
> >  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> >                                             void *addr, size_t length)
> >  {
> > -       return tee_shm_register(ctx, (unsigned long)addr, length,
> > -                               TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
> > +       u32 f = TEE_SHM_REGISTER | TEE_SHM_KERNEL_MAPPED;
>
> Ditto.

Thanks,
Jens

>
> -Sumit
>
> > +
> > +       return register_shm_helper(ctx, (unsigned long)addr, length, f, -1);
> >  }
> >  EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
> >
> > diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> > index 029c9a0590cc..e4f32885e273 100644
> > --- a/include/linux/tee_drv.h
> > +++ b/include/linux/tee_drv.h
> > @@ -278,17 +278,6 @@ struct tee_shm *tee_shm_alloc_priv_kernel_buf(struct tee_context *ctx,
> >                                               size_t size);
> >  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
> >
> > -/**
> > - * tee_shm_register() - Register shared memory buffer
> > - * @ctx:       Context that registers the shared memory
> > - * @addr:      Address is userspace of the shared buffer
> > - * @length:    Length of the shared buffer
> > - * @flags:     Flags setting properties for the requested shared memory.
> > - *
> > - * @returns a pointer to 'struct tee_shm'
> > - */
> > -struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
> > -                                size_t length, u32 flags);
> >  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> >                                           unsigned long addr, size_t length);
> >  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> > --
> > 2.31.1
> >
