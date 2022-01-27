Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8863549DACB
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:36:03 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236822AbiA0GgC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:36:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51466 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236808AbiA0Gf6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:35:58 -0500
Received: from mail-lj1-x22e.google.com (mail-lj1-x22e.google.com [IPv6:2a00:1450:4864:20::22e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD8A7C061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:35:57 -0800 (PST)
Received: by mail-lj1-x22e.google.com with SMTP id t7so2774663ljc.10
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:35:57 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=iXQyqo2emP8qs30+0vsyywvi13y9qFkO62eUsmTUog0=;
        b=wwwXm6orfaLkx3b880PAp1JYR9VKcE1pMHFQXnQtPFB3iE83rLvURHaBx+3W2RrE2Q
         C6TAQDuE8lWMb74FEXnD6AQRmrHhlNMNeM+9PSZcXqC592pXbih3fvs7PKN9E9YSI+4R
         /FjsbvFlZWt3ZmG6hBSJHbe8TEw05KRaBWcrS4jnW355VmhQYHVVTVH886I7BnIiarGo
         MilbeetbGTPJAK/uX8tB5BvvDefattBOZ6NrlC51roK4ecQq+dPOIO6QfWyapZLgfIis
         xwEFa2ZZo/7F9NbsNZENIL3ixHHxQN9E0nklaVCrBn6p9HOLyeyN5dGVR/gPbHmJ0ed2
         kk8w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=iXQyqo2emP8qs30+0vsyywvi13y9qFkO62eUsmTUog0=;
        b=eAZnFzy5koJX8iYH25wkuBSDldV2c7KZ9EM83THvmeNTkWuRMLRCmTVXZpI+8BYivH
         x6WnRbnYuJJWvxds2SJxafVCDcutS8thcSQm3By4TXD2GZ68d7KXpULtdZmO9jklFWvD
         e0nu0zz2sgmiLcGrtfUHEJllRszTfo2iJshvBpLP7bCbiHi5OATd6OwJa8XC6xuLP5pJ
         6LTyzMCicAiJpp+seDFjb0rYds0py9cLIuPLnIrpKJ0o5M1OsW3cFW+F13Y612QSm3Cz
         fIOUNH6kX+9vkcn54AWdpFs1bIjcxl/4iEmFACey1wJjjM06ogDmBQxe5tomayCRq8/Y
         3XUQ==
X-Gm-Message-State: AOAM531s/z34Gi/Q8KqNLLU7kz5lS4P3sqWk52gDRafw9pmd0QOXK4ir
        zZK5wdCXakGD8ddGew0fCeJX2unIjqLwWY6RXdHlaA==
X-Google-Smtp-Source: ABdhPJzgcAhG/yvXzJx+0mXeXSUdrcGsqUAi3C6zwmDEwEUXGAMBlGHYLwSretDBscBWjflPH0/cD/mQikS1/dH4+js=
X-Received: by 2002:a05:651c:1987:: with SMTP id bx7mr1922502ljb.136.1643265356024;
 Wed, 26 Jan 2022 22:35:56 -0800 (PST)
MIME-Version: 1.0
References: <20220125162938.838382-1-jens.wiklander@linaro.org> <20220125162938.838382-10-jens.wiklander@linaro.org>
In-Reply-To: <20220125162938.838382-10-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 27 Jan 2022 12:05:44 +0530
Message-ID: <CAFA6WYPebuZK6iFyAKih72CL4HGsPO6kBhcMXzk=0kg=kVCo1w@mail.gmail.com>
Subject: Re: [PATCH v3 09/12] tee: add tee_shm_register_{user,kernel}_buf()
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
> Adds the two new functions tee_shm_register_user_buf() and
> tee_shm_register_kernel_buf() which should be used instead of the old
> tee_shm_register().
>
> This avoids having the caller supplying the flags parameter which
> exposes a bit more than desired of the internals of the TEE subsystem.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/tee_core.c    |  3 +--
>  drivers/tee/tee_private.h |  2 ++
>  drivers/tee/tee_shm.c     | 33 +++++++++++++++++++++++++++++++++
>  include/linux/tee_drv.h   |  2 ++
>  4 files changed, 38 insertions(+), 2 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/tee_core.c b/drivers/tee/tee_core.c
> index a15812baaeb1..8aa1a4836b92 100644
> --- a/drivers/tee/tee_core.c
> +++ b/drivers/tee/tee_core.c
> @@ -334,8 +334,7 @@ tee_ioctl_shm_register(struct tee_context *ctx,
>         if (data.flags)
>                 return -EINVAL;
>
> -       shm = tee_shm_register(ctx, data.addr, data.length,
> -                              TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
> +       shm = tee_shm_register_user_buf(ctx, data.addr, data.length);
>         if (IS_ERR(shm))
>                 return PTR_ERR(shm);
>
> diff --git a/drivers/tee/tee_private.h b/drivers/tee/tee_private.h
> index 7265f47c6d8e..409cadcc1cff 100644
> --- a/drivers/tee/tee_private.h
> +++ b/drivers/tee/tee_private.h
> @@ -58,5 +58,7 @@ void teedev_ctx_get(struct tee_context *ctx);
>  void teedev_ctx_put(struct tee_context *ctx);
>
>  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
> +struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> +                                         unsigned long addr, size_t length);
>
>  #endif /*TEE_PRIVATE_H*/
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index dc02afd7b5c9..0b6f7aabbf88 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -299,6 +299,39 @@ struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_register);
>
> +/**
> + * tee_shm_register_user_buf() - Register a userspace shared memory buffer
> + * @ctx:       Context that registers the shared memory
> + * @addr:      The userspace address of the shared buffer
> + * @length:    Length of the shared buffer
> + *
> + * @returns a pointer to 'struct tee_shm'
> + */
> +struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
> +                                         unsigned long addr, size_t length)
> +{
> +       return tee_shm_register(ctx, addr, length,
> +                               TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED);
> +}
> +
> +/**
> + * tee_shm_register_kernel_buf() - Register kernel memory to be shared with
> + *                                secure world
> + * @ctx:       Context that registers the shared memory
> + * @addr:      The buffer
> + * @length:    Length of the buffer
> + *
> + * @returns a pointer to 'struct tee_shm'
> + */
> +
> +struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> +                                           void *addr, size_t length)
> +{
> +       return tee_shm_register(ctx, (unsigned long)addr, length,
> +                               TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_register_kernel_buf);
> +
>  static int tee_shm_fop_release(struct inode *inode, struct file *filp)
>  {
>         tee_shm_put(filp->private_data);
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 7f038f8787c7..c9d2cc32a5ed 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -287,6 +287,8 @@ struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
>   */
>  struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>                                  size_t length, u32 flags);
> +struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
> +                                           void *addr, size_t length);
>
>  /**
>   * tee_shm_is_registered() - Check if shared memory object in registered in TEE
> --
> 2.31.1
>
