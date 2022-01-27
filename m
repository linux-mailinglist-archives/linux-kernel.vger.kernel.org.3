Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8B19249DA7E
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 07:16:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229725AbiA0GQo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 01:16:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46990 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbiA0GQi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 01:16:38 -0500
Received: from mail-lj1-x236.google.com (mail-lj1-x236.google.com [IPv6:2a00:1450:4864:20::236])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA5C0C061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:16:37 -0800 (PST)
Received: by mail-lj1-x236.google.com with SMTP id t9so2708971lji.12
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 22:16:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=lZy6gIz8qsTv0+hK2j40vK3ScNlxjlwiIEPx+AHPFmQ=;
        b=gfHvxonGQZNWpONnpbroF5pN4q+Ao4xpUNORiEE/sJTdmtmUK1oA0qGA2EVkjlQZze
         MRZh4SEDA8T7ZuaXzBl/rE5aw4N6rbFNcHtigYxQkO3iiLoLyNUx2ukA9T18kvF9L+E8
         kUtVmTpypsv48HyNoa+68oNYsZYc6V06RurlMfIIr4YU5bipH3YKYcstE+kAE3SNZ0bC
         D4aMHUwBz/sScruYLJTMaicaoTQG866b+Ar9aPCr0J/soX8riYF2MvsaI7gbheAO7q03
         d6hvBOWjL0Pr5zXg/jdehrvycl4IKyrCK4P6syExUNzUwNxGIxohzfS5UFeP0szz4XRJ
         Lorw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=lZy6gIz8qsTv0+hK2j40vK3ScNlxjlwiIEPx+AHPFmQ=;
        b=Pv4rHdo9vcQDYvOVPNjXXsjO2gkKyG1o4CnJ2ewPnC5zqkL74Yod2ZCYWY7qLGAAlD
         YtdAmz0GOcUza6XrOourR4T59X9W+xfydIQaQPRv+M7SY90dEtF4/E836b6a0FJnpDog
         VXaMe1SdtTtG96lDXjtAlEv7Hry5bE4aSDcIwdE96NRRIN7jeUBcRWMZzMNRRhG+qYoA
         Dio4W65vQB/EDknWf3NyKQQ9MakYN3vQsdMdcMj7Gbyc4klTZvOhqq9efsZnpPX6YuBf
         Lu9szXenOM37YJixCXFISxppmIL4N/yLS/qeT3crrakV6pKYjtyadhPRDe4Qahfjr7Ir
         Ddxw==
X-Gm-Message-State: AOAM530Ff61ipziVmhLBiEnaAK4x2yKI6MxzyFc1Y+HHQuQTxo/kBiuZ
        RTH2V3PlGWeYVErXSb4lOEDobvAyDTS2lHdWCBrQ1Q==
X-Google-Smtp-Source: ABdhPJz5gd2qhZtwnW5MAlPYqN+yaqd8BfTvPZc8JvC0qS7m/esHFmu85pKzNq8KbT2EuNgK5NcPsqWC3ANmyksCCns=
X-Received: by 2002:a05:651c:1987:: with SMTP id bx7mr1885036ljb.136.1643264196116;
 Wed, 26 Jan 2022 22:16:36 -0800 (PST)
MIME-Version: 1.0
References: <20220125162938.838382-1-jens.wiklander@linaro.org> <20220125162938.838382-6-jens.wiklander@linaro.org>
In-Reply-To: <20220125162938.838382-6-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 27 Jan 2022 11:46:24 +0530
Message-ID: <CAFA6WYN6=D9anxMTECEhhiuWwnKz54KFBx_BkajWzz-9RbM-_Q@mail.gmail.com>
Subject: Re: [PATCH v3 05/12] tee: replace tee_shm_alloc()
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
> tee_shm_alloc() is replaced by three new functions,
>
> tee_shm_alloc_user_buf() - for user mode allocations, replacing passing
> the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF
>
> tee_shm_alloc_kernel_buf() - for kernel mode allocations, slightly
> optimized compared to using the flags TEE_SHM_MAPPED | TEE_SHM_DMA_BUF.
>
> tee_shm_alloc_priv_kernel_buf() - primarily for TEE driver internal use.

Need update: tee_shm_alloc_priv_buf()?

>
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
>  drivers/tee/optee/ffa_abi.c |   3 +-
>  drivers/tee/optee/smc_abi.c |   5 +-
>  drivers/tee/tee_shm.c       | 108 +++++++++++++++++++++++-------------
>  include/linux/tee_drv.h     |  16 +-----
>  6 files changed, 75 insertions(+), 64 deletions(-)
>

With minor comments incorporated, feel free to add:

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

> diff --git a/drivers/tee/optee/call.c b/drivers/tee/optee/call.c
> index b25cc1fac945..bd49ec934060 100644
> --- a/drivers/tee/optee/call.c
> +++ b/drivers/tee/optee/call.c
> @@ -120,7 +120,7 @@ struct tee_shm *optee_get_msg_arg(struct tee_context *ctx, size_t num_params,
>         if (optee->rpc_arg_count)
>                 sz += OPTEE_MSG_GET_ARG_SIZE(optee->rpc_arg_count);
>
> -       shm = tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED | TEE_SHM_PRIV);
> +       shm = tee_shm_alloc_priv_buf(ctx, sz);
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
> index e690d9420966..d71880ede6d6 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -439,8 +439,7 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                 shm = optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
>                 break;
>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> -               shm = tee_shm_alloc(ctx, arg->params[0].u.value.b,
> -                                   TEE_SHM_MAPPED | TEE_SHM_PRIV);
> +               shm = tee_shm_alloc_priv_buf(ctx, arg->params[0].u.value.b);
>                 break;
>         default:
>                 arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index b679037ea794..66d5d1b56b95 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -650,7 +650,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                 shm = optee_rpc_cmd_alloc_suppl(ctx, sz);
>                 break;
>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> -               shm = tee_shm_alloc(ctx, sz, TEE_SHM_MAPPED | TEE_SHM_PRIV);
> +               shm = tee_shm_alloc_priv_buf(ctx, sz);
>                 break;
>         default:
>                 arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> @@ -775,8 +775,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
>
>         switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
>         case OPTEE_SMC_RPC_FUNC_ALLOC:
> -               shm = tee_shm_alloc(ctx, param->a1,
> -                                   TEE_SHM_MAPPED | TEE_SHM_PRIV);
> +               shm = tee_shm_alloc_priv_buf(ctx, param->a1);
>                 if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
>                         reg_pair_from_64(&param->a1, &param->a2, pa);
>                         reg_pair_from_64(&param->a4, &param->a5,
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index f0a9cccd2f2c..dc02afd7b5c9 100644
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
>
>  /**
> @@ -157,10 +159,36 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
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
> + * tee_shm_alloc_priv_buf() - Allocate shared memory for a privatly shared

typo: s/privatly/privately/

-Sumit

> + *                           kernel buffer
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
> +struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
> +{
> +       u32 flags = TEE_SHM_MAPPED | TEE_SHM_PRIV | TEE_SHM_POOL;
> +
> +       return shm_alloc_helper(ctx, size, sizeof(long) * 2, flags, -1);
> +}
> +EXPORT_SYMBOL_GPL(tee_shm_alloc_priv_buf);
> +
>  struct tee_shm *tee_shm_register(struct tee_context *ctx, unsigned long addr,
>                                  size_t length, u32 flags)
>  {
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index ed641dc314bd..7f038f8787c7 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -273,21 +273,7 @@ static inline void tee_shm_pool_free(struct tee_shm_pool *pool)
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
> +struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size);
>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size);
>
>  /**
> --
> 2.31.1
>
