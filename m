Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A0D1849DB28
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 08:05:55 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237083AbiA0HFj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 02:05:39 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229823AbiA0HFi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 02:05:38 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F8CAC061714
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:05:37 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id z19so3405326lfq.13
        for <linux-kernel@vger.kernel.org>; Wed, 26 Jan 2022 23:05:37 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=VEs3/BPpNcs6H/lryR7s0xOZJxnWWYdbwKoEn/89vTQ=;
        b=PsACTuZtFylpSGN3rTOC+QJ+vgMRxHFVTbRdN7MdWpU43id8YimElgS0Q07l5eAYru
         91dQhPlUwBoedDNlozaAgvHjNupyw37G1j/vHs3k9S7r+634wejuNokQOU6wMTIV5MRI
         ZdJ98JIrEfvMTZ0/K+tNMarGgaOPPaUND4yR6fiYU3wgfTdILwE9dXS7NfqvU+y7Bjjn
         42ZF+3UnwnpoU9mbB0ue8Oz7eIDSAOu2BdKipUmzZxuJHt2AaiAiS0ILCjzbdWYTb9cT
         wfALMUgXh91LoUw6smgkubvHxnwNAzYjd7Firiws7lN7iUUcHpEqsr9UhzdCVvUXh8vv
         hWJQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=VEs3/BPpNcs6H/lryR7s0xOZJxnWWYdbwKoEn/89vTQ=;
        b=1nRpMIBvia5tTUTS5/CzMvYoKAX251E80CTbqa1dmUgT77j6RduZLknsZCB/z90XGH
         /fTH6FqCDHIsRfR+32eKsftu4jglgC8Qp+5SP9IZPELFXf0D9g+hqUeBmazRxIguKUSo
         xEY1Xp5LFzggSl9hsOU2d5MRnb2n1w4fmnLTq6empQioEWtAerYyY+NbXtJlDF6Z0WES
         WvdedMmBvwZixItpoBMegVrc9WRYUlADALWYLrfqAuqjCAdq1p5h/JLQ9lEBaboNnb8i
         yYNdgmVkeLdYI2soLFTVeKDygfXxxC+rqmbYoOVWFXo8O69tGYTJUSYkZey+7mBCbQi0
         JspA==
X-Gm-Message-State: AOAM533mEHM1f0CcpkTRwBf9F7Fwz9/uge+ePOOxMhmaxjH7AkeVfI/L
        23Vb40iiHMHKOy/XFBdWsshnVJ6aZE1NWdBRWSJKRw==
X-Google-Smtp-Source: ABdhPJya0Z00ZJWHhq/UoPC+VQWrQn/3SH2lBBfbzZzRIXryYSx0Fwf67uBlvK8qdiSBRreO3ILIma+SOfMzWCQbbJQ=
X-Received: by 2002:a05:6512:a96:: with SMTP id m22mr2058935lfu.119.1643267135611;
 Wed, 26 Jan 2022 23:05:35 -0800 (PST)
MIME-Version: 1.0
References: <20220125162938.838382-1-jens.wiklander@linaro.org> <20220125162938.838382-13-jens.wiklander@linaro.org>
In-Reply-To: <20220125162938.838382-13-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 27 Jan 2022 12:35:24 +0530
Message-ID: <CAFA6WYNqEgwDBqhTiufgrsKu8AfDG=Pkk0dccPErt6+dFNudbw@mail.gmail.com>
Subject: Re: [PATCH v3 12/12] tee: refactor TEE_SHM_* flags
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
> Removes the redundant TEE_SHM_DMA_BUF, TEE_SHM_EXT_DMA_BUF,
> TEE_SHM_MAPPED and TEE_SHM_KERNEL_MAPPED flags.
>
> Assigns new values to the remaining flags to void gaps.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/smc_abi.c |  4 ++--
>  drivers/tee/tee_shm.c       | 23 +++++++++++------------
>  drivers/tee/tee_shm_pool.c  |  2 +-
>  include/linux/tee_drv.h     | 21 +++++++++------------
>  4 files changed, 23 insertions(+), 27 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 9c1c9cfb7488..0895c5146dfa 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -228,7 +228,7 @@ static int optee_to_msg_param(struct optee *optee,
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_OUTPUT:
>                 case TEE_IOCTL_PARAM_ATTR_TYPE_MEMREF_INOUT:
> -                       if (tee_shm_is_registered(p->u.memref.shm))
> +                       if (tee_shm_is_dynamic(p->u.memref.shm))
>                                 rc = to_msg_param_reg_mem(mp, p);
>                         else
>                                 rc = to_msg_param_tmp_mem(mp, p);
> @@ -669,7 +669,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>
>         sz = tee_shm_get_size(shm);
>
> -       if (tee_shm_is_registered(shm)) {
> +       if (tee_shm_is_dynamic(shm)) {
>                 struct page **pages;
>                 u64 *pages_list;
>                 size_t page_num;
> diff --git a/drivers/tee/tee_shm.c b/drivers/tee/tee_shm.c
> index c3a29022ec72..d9deb1f50022 100644
> --- a/drivers/tee/tee_shm.c
> +++ b/drivers/tee/tee_shm.c
> @@ -58,7 +58,7 @@ static void tee_shm_release(struct tee_device *teedev, struct tee_shm *shm)
>  {
>         if (shm->flags & TEE_SHM_POOL) {
>                 teedev->pool->ops->free(teedev->pool, shm);
> -       } else if (shm->flags & TEE_SHM_REGISTER) {
> +       } else if (shm->flags & TEE_SHM_DYNAMIC) {
>                 int rc = teedev->desc->ops->shm_unregister(shm->ctx, shm);
>
>                 if (rc)
> @@ -139,8 +139,7 @@ static struct tee_shm *shm_alloc_helper(struct tee_context *ctx, size_t size,
>   */
>  struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
>  {
> -       u32 flags = TEE_SHM_MAPPED | TEE_SHM_DMA_BUF | TEE_SHM_REGISTER |
> -                   TEE_SHM_POOL;
> +       u32 flags = TEE_SHM_DYNAMIC | TEE_SHM_POOL;
>         struct tee_device *teedev = ctx->teedev;
>         struct tee_shm *shm;
>         void *ret;
> @@ -185,7 +184,7 @@ struct tee_shm *tee_shm_alloc_user_buf(struct tee_context *ctx, size_t size)
>   */
>  struct tee_shm *tee_shm_alloc_kernel_buf(struct tee_context *ctx, size_t size)
>  {
> -       u32 flags = TEE_SHM_MAPPED | TEE_SHM_REGISTER | TEE_SHM_POOL;
> +       u32 flags = TEE_SHM_DYNAMIC | TEE_SHM_POOL;
>
>         return shm_alloc_helper(ctx, size, PAGE_SIZE, flags, -1);
>  }
> @@ -209,7 +208,7 @@ EXPORT_SYMBOL_GPL(tee_shm_alloc_kernel_buf);
>   */
>  struct tee_shm *tee_shm_alloc_priv_buf(struct tee_context *ctx, size_t size)
>  {
> -       u32 flags = TEE_SHM_MAPPED | TEE_SHM_PRIV | TEE_SHM_POOL;
> +       u32 flags = TEE_SHM_PRIV | TEE_SHM_POOL;
>
>         return shm_alloc_helper(ctx, size, sizeof(long) * 2, flags, -1);
>  }
> @@ -306,7 +305,7 @@ register_shm_helper(struct tee_context *ctx, unsigned long addr,
>  struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>                                           unsigned long addr, size_t length)
>  {
> -       u32 flags = TEE_SHM_DMA_BUF | TEE_SHM_USER_MAPPED | TEE_SHM_REGISTER;
> +       u32 flags = TEE_SHM_USER_MAPPED | TEE_SHM_DYNAMIC;
>         struct tee_device *teedev = ctx->teedev;
>         struct tee_shm *shm;
>         void *ret;
> @@ -350,7 +349,7 @@ struct tee_shm *tee_shm_register_user_buf(struct tee_context *ctx,
>  struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>                                             void *addr, size_t length)
>  {
> -       u32 flags = TEE_SHM_REGISTER | TEE_SHM_KERNEL_MAPPED;
> +       u32 flags = TEE_SHM_DYNAMIC;
>
>         return register_shm_helper(ctx, (unsigned long)addr, length, flags, -1);
>  }
> @@ -394,7 +393,7 @@ int tee_shm_get_fd(struct tee_shm *shm)
>  {
>         int fd;
>
> -       if (!(shm->flags & TEE_SHM_DMA_BUF))
> +       if (shm->id < 0)
>                 return -EINVAL;
>
>         /* matched by tee_shm_put() in tee_shm_op_release() */
> @@ -424,7 +423,7 @@ EXPORT_SYMBOL_GPL(tee_shm_free);
>   */
>  int tee_shm_va2pa(struct tee_shm *shm, void *va, phys_addr_t *pa)
>  {
> -       if (!(shm->flags & TEE_SHM_MAPPED))
> +       if (!shm->kaddr)
>                 return -EINVAL;
>         /* Check that we're in the range of the shm */
>         if ((char *)va < (char *)shm->kaddr)
> @@ -446,7 +445,7 @@ EXPORT_SYMBOL_GPL(tee_shm_va2pa);
>   */
>  int tee_shm_pa2va(struct tee_shm *shm, phys_addr_t pa, void **va)
>  {
> -       if (!(shm->flags & TEE_SHM_MAPPED))
> +       if (!shm->kaddr)
>                 return -EINVAL;
>         /* Check that we're in the range of the shm */
>         if (pa < shm->paddr)
> @@ -474,7 +473,7 @@ EXPORT_SYMBOL_GPL(tee_shm_pa2va);
>   */
>  void *tee_shm_get_va(struct tee_shm *shm, size_t offs)
>  {
> -       if (!(shm->flags & TEE_SHM_MAPPED))
> +       if (!shm->kaddr)
>                 return ERR_PTR(-EINVAL);
>         if (offs >= shm->size)
>                 return ERR_PTR(-EINVAL);
> @@ -549,7 +548,7 @@ void tee_shm_put(struct tee_shm *shm)
>                  * the refcount_inc() in tee_shm_get_from_id() never starts
>                  * from 0.
>                  */
> -               if (shm->flags & TEE_SHM_DMA_BUF)
> +               if (shm->id >= 0)
>                         idr_remove(&teedev->idr, shm->id);
>                 do_release = true;
>         }
> diff --git a/drivers/tee/tee_shm_pool.c b/drivers/tee/tee_shm_pool.c
> index 71e0f8ae69aa..058bfbac657a 100644
> --- a/drivers/tee/tee_shm_pool.c
> +++ b/drivers/tee/tee_shm_pool.c
> @@ -30,7 +30,7 @@ static int pool_op_gen_alloc(struct tee_shm_pool *pool, struct tee_shm *shm,
>          * This is from a static shared memory pool so no need to register
>          * each chunk, and no need to unregister later either.
>          */
> -       shm->flags &= ~TEE_SHM_REGISTER;
> +       shm->flags &= ~TEE_SHM_DYNAMIC;
>         return 0;
>  }
>
> diff --git a/include/linux/tee_drv.h b/include/linux/tee_drv.h
> index a3b663ef0694..911cad324acc 100644
> --- a/include/linux/tee_drv.h
> +++ b/include/linux/tee_drv.h
> @@ -20,14 +20,11 @@
>   * specific TEE driver.
>   */
>
> -#define TEE_SHM_MAPPED         BIT(0)  /* Memory mapped by the kernel */
> -#define TEE_SHM_DMA_BUF                BIT(1)  /* Memory with dma-buf handle */
> -#define TEE_SHM_EXT_DMA_BUF    BIT(2)  /* Memory with dma-buf handle */
> -#define TEE_SHM_REGISTER       BIT(3)  /* Memory registered in secure world */
> -#define TEE_SHM_USER_MAPPED    BIT(4)  /* Memory mapped in user space */
> -#define TEE_SHM_POOL           BIT(5)  /* Memory allocated from pool */
> -#define TEE_SHM_KERNEL_MAPPED  BIT(6)  /* Memory mapped in kernel space */
> -#define TEE_SHM_PRIV           BIT(7)  /* Memory private to TEE driver */
> +#define TEE_SHM_DYNAMIC                BIT(0)  /* Dynamic shared memory registered */
> +                                       /* in secure world */
> +#define TEE_SHM_USER_MAPPED    BIT(1)  /* Memory mapped in user space */
> +#define TEE_SHM_POOL           BIT(2)  /* Memory allocated from pool */
> +#define TEE_SHM_PRIV           BIT(3)  /* Memory private to TEE driver */
>
>  struct device;
>  struct tee_device;
> @@ -280,13 +277,13 @@ struct tee_shm *tee_shm_register_kernel_buf(struct tee_context *ctx,
>                                             void *addr, size_t length);
>
>  /**
> - * tee_shm_is_registered() - Check if shared memory object in registered in TEE
> + * tee_shm_is_dynamic() - Check if shared memory object is of the dynamic kind
>   * @shm:       Shared memory handle
> - * @returns true if object is registered in TEE
> + * @returns true if object is dynamic shared memory
>   */
> -static inline bool tee_shm_is_registered(struct tee_shm *shm)
> +static inline bool tee_shm_is_dynamic(struct tee_shm *shm)
>  {
> -       return shm && (shm->flags & TEE_SHM_REGISTER);
> +       return shm && (shm->flags & TEE_SHM_DYNAMIC);
>  }
>
>  /**
> --
> 2.31.1
>
