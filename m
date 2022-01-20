Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D7DEE494BF4
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 11:41:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1376361AbiATKln (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 05:41:43 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234719AbiATKlm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 05:41:42 -0500
Received: from mail-lf1-x12a.google.com (mail-lf1-x12a.google.com [IPv6:2a00:1450:4864:20::12a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63788C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:41:42 -0800 (PST)
Received: by mail-lf1-x12a.google.com with SMTP id s30so19941078lfo.7
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 02:41:42 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=o0Pf4BLMNbsyxJbWMDamcRPEtGavybScaRJHNcslWA4=;
        b=HvvmAOtNIhpoH5gXdRIoUBz2iiu+qcdTRHqqAm6HAynRr8tmXOYqt4SD8hNccb0Qwj
         Nh4ezH6xaFEBmx6evlEOrX/oj4zSHZ7FnxONo68UwNcYGCskAkKcF9hGFJNJ+UlgolLB
         d5UMBe9UnQhmzZx7EViMMaCYyDTasiqgCRnpONeztcEHur/iXIxfkdapp96aG1eaD1VJ
         wYGuFv2nE9sdqNqnR/FWF0FoO25eVbwVgimF2kgQr0muR6dasi22AnilKiH3FU3Z7kC7
         imzGinrTvk/z5XhgMInb6xaf1sgyzL3XPzN2SSsa5fp2d3KmmNgNC4UGWsJ72JLwJ75/
         ke7Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=o0Pf4BLMNbsyxJbWMDamcRPEtGavybScaRJHNcslWA4=;
        b=OcW93c41hqewN2tmffYgJrIQiztxnz9NqJruB8UBURNI2I7u1Bzwr1lMYwy1fRFJz1
         XNERt0HGKJSIAEd1jwTaEMCRP/gLOP+s3p7MkepJYIXQFj2WfRMhUl3jL61z3we4vAu1
         hCYrRtHyXiqH7K2J/IelkUIKfrctj7o5pzfb5I1rxAHumdKheMDXm+vmgdQEosmyZh1d
         BiQKqYX31lSAllt5/4q8hwVz6NQK3Pvf04tgmeGQxYaPHEjsyCPVMxdzoYr/ELdYn4MK
         EA304xyiNnc9Kbqpf3Ax1VjS2yLLR4e+l3BqDU6O/p0JDCUBfyErpwpl34mzlAfnmUaD
         xhvA==
X-Gm-Message-State: AOAM530BINkytm1dOy1gUqJQsq3w+apQvM4sQq668HUoD7u2/84WnJHb
        XNJnfOmGCvJi+HUlpfrCtkwJ++w0wQmpwG5/w7SClQ==
X-Google-Smtp-Source: ABdhPJwp5lKDks6/Q7rxSdkrKmc3iUo8Ysp/fXnpV8GBQxVXfG44JBgxh/K6NrKgLeiFpOoZDkXnWfGLUEQuimD2bqA=
X-Received: by 2002:a2e:b8c9:: with SMTP id s9mr17516494ljp.136.1642675300603;
 Thu, 20 Jan 2022 02:41:40 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org> <20220114150824.3578829-6-jens.wiklander@linaro.org>
In-Reply-To: <20220114150824.3578829-6-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 20 Jan 2022 16:11:29 +0530
Message-ID: <CAFA6WYNgwPNxmKWs=84AhYY40iPmK371oscM1iT9rmwTTdcgiA@mail.gmail.com>
Subject: Re: [PATCH v2 05/12] tee: replace tee_shm_alloc()
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
> tee_shm_alloc() is replaced by three new functions,
>
> tee_shm_alloc_user_buf() - for user mode allocations, replacing passing
> the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF
>
> tee_shm_alloc_kernel_buf() - for kernel mode allocations, slightly
> optimized compared to using the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF.
>
> tee_shm_alloc_priv_kernel_buf() - primarily for TEE driver internal use.
>

This name seems ambiguous to me and I would rather prefer it named as
tee_shm_alloc_priv_buf().

I noticed that you have done flags refactoring as part of patch #12.
So rest looks fine to me.

-Sumit

> This also makes the interface easier to use as we can get rid of the
> somewhat hard to use flags parameter.
>
> The TEE subsystem and the TEE drivers are updated to use the new
> functions instead.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/call.c    |   2 +-
>  drivers/tee/optee/device.c  |   5 +-
>  drivers/tee/optee/ffa_abi.c |   4 +-
>  drivers/tee/optee/smc_abi.c |   5 +-
>  drivers/tee/tee_shm.c       | 109 +++++++++++++++++++++++-------------
>  include/linux/tee_drv.h     |  17 +-----
>  6 files changed, 78 insertions(+), 64 deletions(-)
>
> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index b25cc1fac945..fd6ad7d6fbee 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -120,7 +120,7 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
>         if (optee->rpc_arg_count)
>                 sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_arg_count);
>
> -       shm = tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED | TEE_SHM_PRIV);
> +       shm = tee_shm_alloc_priv_kernel_buf(ctx, sz);
>         if (IS_ERR(shm))
>                 return shm;
>
> diff --git a/drivers/tee/optee/device.c b/drivers/tee/optee/device.c
> index 128a2d2a50a1..f3947be13e2e 100644
> --- a/drivers/tee/optee/device.c
> +++ b/drivers/tee/optee/device.c
> @@ -121,10 +121,9 @@ static int __optee_enumerate_devices(u32 func)
>         if (rc < 0 || !shm_size)
>                 goto out_sess;
>
> -       device_shm = tee_shm_alloc(ctx, shm_size,
> -                                  TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +       device_shm = tee_shm_alloc_kernel_buf(ctx, shm_size);
>         if (IS_ERR(device_shm)) {
> -               pr_err("tee_shm_alloc failed\n");
> +               pr_err("tee_shm_alloc_kernel_buf failed\n");
>                 rc = PTR_ERR(device_shm);
>                 goto out_sess;
>         }
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index e690d9420966..18963f7e4d48 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -439,8 +439,8 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                 shm = optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
>                 break;
>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> -               shm = tee_shm_alloc(ctx, arg->params[0].u.value.b,
> -                                   TEE_SHM_MAPPED | TEE_SHM_PRIV);
> +               shm = tee_shm_alloc_priv_kernel_buf(ctx,
> +                                                   arg->params[0].u.value.b);
>                 break;
>         default:
>                 arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index b679037ea794..196cd4316d7d 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -650,7 +650,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                 shm = optee_rpc_cmd_alloc_suppl(ctx, sz);
>                 break;
>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> -               shm = tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED | TEE_SHM_PRIV);
> +               shm = tee_shm_alloc_priv_kernel_buf(ctx, sz);
>                 break;
>         default:
>                 arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> @@ -775,8 +775,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
>
>         switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
>         case OPTEE_SMC_RPC_FUNC_ALLOC:
> -               shm = tee_shm_alloc(ctx, param->a1,
> -                                   TEE_SHM_MAPPED | TEE_SHM_PRIV);
> +               shm = tee_shm_alloc_priv_kernel_buf(ctx, param->a1);
>                 if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
>                         reg_pair_from_64(&param->a1, &param->a2, pa);
>                         reg_pair_from_64(&param->a4, &param->a5,
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index 2c8ce0c6801a..d51bf97ce7e5 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -49,25 +49,14 @@ static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
>         tee_device_put(teedev);
>  }
>
> -struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
> +static struct tee_shm *shm_alloc_helper(struct tee_context *ctx, size_t size,
> +                                       size_t align, u32 flags, int id)
>  {
>         struct tee_device *teedev = ctx->teedev;
>         struct tee_shm *shm;
> -       size_t align;
>         void *ret;
>         int rc;
>
> -       if (!(flags & TEE_SHM_MAPPED)) {
> -               dev_err(teedev->dev.parent,
> -                       "only mapped allocations supported\n");
> -               return ERR_PTR(-EINVAL);
> -       }
> -
> -       if ((flags & ~(TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_PRIV))) {
> -               dev_err(teedev->dev.parent, "invalid shm flags 0x%x", flags);
> -               return ERR_PTR(-EINVAL);
> -       }
> -
>         if (!tee_device_get(teedev))
>                 return ERR_PTR(-EINVAL);
>
> @@ -84,18 +73,16 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
>         }
>
>         refcount_set(&shm->refcount, 1);
> -       shm->flags = flags | TEE_SHM_POOL;
> +       shm->flags = flags;
> +       shm->id = id;
> +
> +       /*
> +        * We're assigning this as it is needed if the shm is to be
> +        * registered. If this function returns OK then the caller expected
> +        * to call teedev_ctx_get() or clear shm->ctx in case it's not
> +        * needed any longer.
> +        */
>         shm->ctx = ctx;
> -       if (flags & TEE_SHM_DMA_BUF) {
> -               align = PAGE_SIZE;
> -               /*
> -                * Request to register the shm in the pool allocator below
> -                * if supported.
> -                */
> -               shm->flags |= TEE_SHM_REGISTER;
> -       } else {
> -               align = 2 * sizeof(long);
> -       }
>
>         rc = teedev->pool->ops->alloc(teedev->pool, shm, size, align);
>         if (rc) {
> @@ -103,28 +90,14 @@ struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags)
>                 goto err_kfree;
>         }
>
> -       if (flags & TEE_SHM_DMA_BUF) {
> -               mutex_lock(&teedev->mutex);
> -               shm->id = idr_alloc(&teedev->idr, shm, 1, 0, GFP_KERNEL);
> -               mutex_unlock(&teedev->mutex);
> -               if (shm->id < 0) {
> -                       ret = ERR_PTR(shm->id);
> -                       goto err_pool_free;
> -               }
> -       }
> -
>         teedev_ctx_get(ctx);
> -
>         return shm;
> -err_pool_free:
> -       teedev->pool->ops->free(teedev->pool, shm);
>  err_kfree:
>         kfree(shm);
>  err_dev_put:
>         tee_device_put(teedev);
>         return ret;
>  }
> -EXPORT_SYMBOL_GPL(tee_shm_alloc);
>
>  /**
>   * tee_shm_alloc_user_buf() - Allocate shared memory for user space
> @@ -140,7 +113,36 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc);
>   */
>  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
>  {
> -       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +       u32 flags = TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER |
> +                   TEE_SHM_POOL;
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
> +       shm = shm_alloc_helper(ctx, size, PAGE_SIZE, flags, id);
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
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_user_buf);
>
> @@ -158,10 +160,37 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc_user_buf);
>   */
>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
>  {
> -       return tee_shm_alloc(ctx, size, TEE_SHM_MAPPED);
> +       u32 flags = TEE_SHM_MAPPED | TEE_SHM_REGISTER | TEE_SHM_POOL;
> +
> +       return shm_alloc_helper(ctx, size, PAGE_SIZE, flags, -1);
>  }
>  EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
>
> +/**
> + * tee_shm_alloc_priv_kernel_buf() - Allocate shared memory for a privatly
> + *                                  shared kernel buffer
> + * @ctx:       Context that allocates the shared memory
> + * @size:      Requested size of shared memory
> + *
> + * This function returns similar shared memory as
> + * tee_shm_alloc_kernel_buf(), but with the difference that the memory
> + * might not be registered in secure world in case the driver supports
> + * passing memory not registered in advance.
> + *
> + * This function should normally only be used internally in the TEE
> + * drivers.
> + *
> + * @returns a pointer to 'struct tee_shm'
> + */
> +struct tee_shm *tee_shm_alloc_priv_kernel_buf(struct tee_context *ctx,
> +                                             size_t size)
> +{
> +       u32 flags = TEE_SHM_MAPPED | TEE_SHM_PRIV | TEE_SHM_POOL;
> +
> +       return shm_alloc_helper(ctx, size, sizeof(long) * 2, flags, -1);
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_kernel_buf);
> +
>  struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>                                  size_t length, u32 flags)
>  {
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index 808aa23308c2..e71cb0411e9c 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -273,22 +273,9 @@ static inline void tee_shm_pool_free(struct tee_shm_pool *pool)
>   */
>  void *tee_get_drvdata(struct tee_device *teedev);
>
> -/**
> - * tee_shm_alloc() - Allocate shared memory
> - * @ctx:       Context that allocates the shared memory
> - * @size:      Requested size of shared memory
> - * @flags:     Flags setting properties for the requested shared memory.
> - *
> - * Memory allocated as global shared memory is automatically freed when the
> - * TEE file pointer is closed. The @flags field uses the bits defined by
> - * TEE_SHM_* above. TEE_SHM_MAPPED must currently always be set. If
> - * TEE_SHM_DMA_BUF global shared memory will be allocated and associated
> - * with a dma-buf handle, else driver private memory.
> - *
> - * @returns a pointer to 'struct tee_shm'
> - */
> -struct tee_shm *tee_shm_alloc(struct tee_context *ctx, size_t size, u32 flags);
>  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size);
> +struct tee_shm *tee_shm_alloc_priv_kernel_buf(struct tee_context *ctx,
> +                                             size_t size);
>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
>
>  /**
> --
> 2.31.1
>
