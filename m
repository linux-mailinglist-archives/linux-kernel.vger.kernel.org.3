Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 095AD49DA5C
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 06:56:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236357AbiA0F4k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 00:56:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42586 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229551AbiA0F4k (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 00:56:40 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89004C061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 21:56:39 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x7so3194802lfu.8
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 21:56:39 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=aWo9W/WInyDbr5JfxL7Bup7u3tR1b8/tTnuJ7YJQp/E=;
        b=dIe8WmtT4h+k9PRa+NCQrvieWHmicawGJlyvjCykypB6nHPnj+hsVXuBun+m/bwgLL
         EjAaka1ar/xN6STAB29BqbI8OxeDpNTmDL7r7RtZHDK+mWdvNvBSDcCSDJuZRFsP7PHQ
         b+JhkwrFXrox71O05p8qR1kFRuCM4//9zXwjwLer2wH/5FdL0tAUsduHmeN+g1zu8PTE
         EPE3CFM+HcbyiXST0gTfiCam0k6qakteakYYCPEVf5e3JKlW7sCfEjSSnY11t+Lk8T/N
         P77KqoEEK+u60u+XVNPJrAhY1HRn+HgVh3Iu2e8PMxH6OESsutWpwJxzNvnS+0Cq0Kqj
         ORwQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=aWo9W/WInyDbr5JfxL7Bup7u3tR1b8/tTnuJ7YJQp/E=;
        b=VZK4pW5xZ6y8ULWAqPhsisDUOatgOrAByCRnw2T+2saq1j5KapFd1e13NHaYYUTf8L
         wa04D3Zsby7BU1t/DpsFK8iiWdYIwfIDJ7hXGWLNTzDdxgP2Ndv6c5ot+TXT5wSSkZiD
         QeycozfHdEGGzqpvSy1IkBnkrHZH10dJXxRvuKK1xuPLSGB/2XK+ZCsJTdQtZR7USaoA
         D4hkgXAZRQoycr9RzmKO4p8RUQEFp99v5RpgesB9mKkxrGxglnTjibcxHm7iBR11rhc9
         U5uxl5R5QDMu0tmTCJk+N+KPlQpLmv9PYazaUxtEUrRVu3sppEFgJTe38mANlHNAOoAQ
         FrJQ==
X-Gm-Message-State: AOAM5301SHmQgOuYoAPPe9NP9QbdrvHCJaFgWbq7r1cO1/njEYg4sJyu
        P0xpb4tWMxRy7hjw6PhUvl3r8aBlWvSPRxv090xv3g==
X-Google-Smtp-Source: ABdhPJwNDBjGsqpl/tRbz98l7hIwUvWv5WcXCbtnXgVMLOcWqaXnMoRIaexKUzuBr/qFpcxri36UbKZ7ubLsgRJNtQQ=
X-Received: by 2002:a05:6512:3ac:: with SMTP id v12mr1849337lfp.40.1643262997883;
 Wed, 26 Jan 2022 21:56:37 -0800 (PST)
MIME-Version: 1.0
References: <20220125162938.838382-1-jens.wiklander@linaro.org> <20220125162938.838382-4-jens.wiklander@linaro.org>
In-Reply-To: <20220125162938.838382-4-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 27 Jan 2022 11:26:26 +0530
Message-ID: <CAFA6WYOT7capu1RrK57HAu_qKvG65X_C1-esw3DyD4_9LeKZSg@mail.gmail.com>
Subject: Re: [PATCH v3 03/12] tee: add tee_shm_alloc_user_buf()
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
> Adds a new function tee_shm_alloc_user_buf() or user mode allocations,

typo: s/or/for/

> replacing passing the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF to
> tee_shm_alloc().
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c     |  2 +-
>  drivers/tee/tee_private.h  |  2 ++
>  drivers/tee/tee_shm.c      | 17 +++++++++++++++++
>  drivers/tee/tee_shm_pool.c |  2 +-
>  include/linux/tee_drv.h    |  2 +-
>  5 files changed, 22 insertions(+), 3 deletions(-)
>

Apart from minor comments below:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index 3fc426dad2df..a15812baaeb1 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -297,7 +297,7 @@ static int tee_ioctl_shm_alloc(struct tee_context *ctx,
>         if (data.flags)
>                 return -EINVAL;
>
> -       shm = tee_shm_alloc(ctx, data.size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +       shm = tee_shm_alloc_user_buf(ctx, data.size);
>         if (IS_ERR(shm))
>                 return PTR_ERR(shm);
>
> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> index e55204df31ce..e09c8aa5d967 100644
> --- a/drivers/tee/tee_private.h
> +++ b/drivers/tee/tee_private.h
> @@ -68,4 +68,6 @@ void tee_device_put(struct tee_device *teedev);
>  void teedev_ctx_get(struct tee_context *ctx);
>  void teedev_ctx_put(struct tee_context *ctx);
>
> +struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
> +
>  #endif /*TEE_PRIVATE_H*/
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 499fccba3d74..7e7e762fc1de 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -127,6 +127,23 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc);
>
> +/**
> + * tee_shm_alloc_user_buf() - Allocate shared memory for user space
> + * @ctx:       Context that allocates the shared memory
> + * @size:      Requested size of shared memory
> + *
> + * Memory allocated as user space shared memory is automatically freed when
> + * the TEE file pointer is closed. The primary usage of this function is
> + * when the TEE driver doesn't support registering ordinary user space
> + * memory.
> + *
> + * @returns a pointer to 'struct tee_shm'
> + */
> +struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
> +{
> +       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +}
> +
>  /**
>   * tee_shm_alloc_kernel_buf() - Allocate shared memory for kernel buffer
>   * @ctx:       Context that allocates the shared memory
> diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
> index a9f9d50fd181..0e460347138a 100644
> --- a/drivers/tee/tee_shm_pool.c
> +++ b/drivers/tee/tee_shm_pool.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0-only
>  /*
> - * Copyright (c) 2015, Linaro Limited
> + * Copyright (c) 2015, 2017, 2022 Linaro Limited

Redundant change?

>   */
>  #include <linux/device.h>
>  #include <linux/dma-buf.h>
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 6b0f0d01ebdf..975500b2553e 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2015-2016, Linaro Limited
> + * Copyright (c) 2015-2022 Linaro Limited

Ditto?

-Sumit

>   */
>
>  #ifndef __TEE_DRV_H
> --
> 2.31.1
>
