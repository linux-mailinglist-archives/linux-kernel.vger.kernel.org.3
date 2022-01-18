Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 91CF8492681
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 14:11:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241893AbiARNLi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 08:11:38 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238429AbiARNLe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 08:11:34 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96555C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 05:11:33 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id x7so70436578lfu.8
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 05:11:33 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=TVZaPKiTrsKRccgkQsYbK/pQLkqx8K3+Dy6ZGqF9QZA=;
        b=pQYJtfx2w4zuiE62aojn4PLOdpiyQrAbWcBncTzDWYYISGz7tW6CEkat1z81YSOJrW
         R5VGOQ/dff5gjz4oeMbb2rWoGmzv8DzMMd8sgHnQcNx/TCxkqJHQq/Wl0yyH5Gxi9cWA
         jG9EkPopRUiiQDbPIyZ6W6L51mGx+8V8CoRAfDgqkSxgfj5G0WhOv5+yMNJEiWJT9HjU
         bg/n0FFVCg6QzlS6T21XfbnEDfzOMr7TjGYofvQpHrvKiIQGQ1SDQBZ3+BIfBy6pLUp3
         yEqeP2rA8kGPIQhKmxVtGeZfn+wy9oyo54aBpNbFCqGkLCKXeFDIkGX+JId30JVLopaR
         EmhA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=TVZaPKiTrsKRccgkQsYbK/pQLkqx8K3+Dy6ZGqF9QZA=;
        b=gacTWPnFiKJTGYwg9xV9KQs6KwuRQftr3dKlmUsym44Wb/TV89g9hd4084/obbhi8R
         8Wq8lxhONlJn3zZ50c69ULETeuThcLXEmyStUunwcTMHPk/4fFsiS+Ozew9PVwhKeZq8
         bm/A5ZXpcgmhvXPk6qD1G4QicRyHtfyfMYsEE4JY7WYEV2d5J5JwfghddbuDCB5BirJF
         ER8sQTmVrfyQh7dwvw4SZOnSNklF44uDlPnH27+90MiZkLdw1RDu+Smpj4FY1QIFJIAJ
         lri/2/RTe1ycGplssGqQoydHslc4V/MireWAkfXShMowzJVPXTy0byT3gADK/YSOsgda
         g1JA==
X-Gm-Message-State: AOAM532roKggvMDxPr/BlzYWSGrTS7dn0670XK3jSLCAk/s2nmUIpLt4
        CVUDqbMP0pwu+i11/NvIhlXk1LMAoOylve3xL2ZNRY6q86fdK24A
X-Google-Smtp-Source: ABdhPJwTin1i185n0G5k6Sa5fRYD5qqBBZCdHCS0O4wZk8JaZwm8A8Dm4+1nnaPHe3VE/87RVKiPeqsfkqRkbXxuVF0=
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr2395401lfr.253.1642511491968;
 Tue, 18 Jan 2022 05:11:31 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org> <20220114150824.3578829-4-jens.wiklander@linaro.org>
In-Reply-To: <20220114150824.3578829-4-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 18 Jan 2022 18:41:20 +0530
Message-ID: <CAFA6WYOG263--zk9djUT1ueeXBCbg62fo95ZRJ1c733KULpUhw@mail.gmail.com>
Subject: Re: [PATCH v2 03/12] tee: add tee_shm_alloc_user_buf()
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

On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Adds a new function tee_shm_alloc_user_buf() or user mode allocations,
> replacing passing the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF to
> tee_shm_alloc().
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c     |  2 +-
>  drivers/tee/tee_shm.c      | 18 ++++++++++++++++++
>  drivers/tee/tee_shm_pool.c |  2 +-
>  include/linux/tee_drv.h    |  3 ++-
>  4 files changed, 22 insertions(+), 3 deletions(-)
>
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

Since it's the only place this API would be used within the driver
itself and I can't see any future usage from other kernel drivers..

>         if (IS_ERR(shm))
>                 return PTR_ERR(shm);
>
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 499fccba3d74..b43178986985 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -127,6 +127,24 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
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
> +EXPORT_SYMBOL_GPL(tee_shm_alloc_user_buf);
> +

..so I don't see any value-add for this export..

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
>   */
>  #include <linux/device.h>
>  #include <linux/dma-buf.h>
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 6b0f0d01ebdf..26b450484ac1 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -1,6 +1,6 @@
>  /* SPDX-License-Identifier: GPL-2.0-only */
>  /*
> - * Copyright (c) 2015-2016, Linaro Limited
> + * Copyright (c) 2015-2022 Linaro Limited
>   */
>
>  #ifndef __TEE_DRV_H
> @@ -308,6 +308,7 @@ void *tee_get_drvdata(struct tee_device *teedev);
>   * @returns a pointer to 'struct tee_shm'
>   */
>  struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags);
> +struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);

..and it should rather belong to drivers/tee/tee_private.h.

-Sumit

>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
>
>  /**
> --
> 2.31.1
>
