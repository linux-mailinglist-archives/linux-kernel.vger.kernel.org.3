Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 2DCD3495F4E
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 13:55:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349264AbiAUMzH (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 07:55:07 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50894 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238446AbiAUMzG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 07:55:06 -0500
Received: from mail-lj1-x233.google.com (mail-lj1-x233.google.com [IPv6:2a00:1450:4864:20::233])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 879C8C061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:55:05 -0800 (PST)
Received: by mail-lj1-x233.google.com with SMTP id x26so30247ljd.4
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 04:55:05 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xfiy8gZOOW+9H67jmVHeVgd/ayOSNsnBTv5kLbhWfxI=;
        b=IPNv7jbHyE/nsqQj+BtYDZgCHJA+GVDzheHD6UTLBWJegenaC2wzAsINvXot7rNhAH
         /Qdxa2Z2ifMnYnlnINZ3XBR8mPnp+P6J2INts/FYkMWy6eutBqv7QKr/SZBB6URwLWjk
         b+55KmuAlrfJzfvp3Q0rMjYavrUAnONSlCmhMeTX5rT9j/jG/QNlyXkLxiAygDNQaNP8
         rBkxYC5Cx/KuRcj9dtUfaUkLlIVeO30jXpKsrcStMm50w9oDyWSULRR6uAMjx6DLOoX6
         vuZM8iA5vKLpXLLiG7TnN0Hpur/jDu8UkBcuPlE2OjVuDImzDe2Q6HPUFy+YGQyxRA94
         xtPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xfiy8gZOOW+9H67jmVHeVgd/ayOSNsnBTv5kLbhWfxI=;
        b=g0v8M6SjmNFPAGGWDpanOiR4BVxIOmfvK8rNLSCcoT9phtO3RWAC6h4mWFaTqza6nr
         j9kP0WtEve379agjmze0ul/pha1fWUauMrNdAX0c45/57JVsVa8BXjI3rCHlLEMQc/iA
         kt//nh7CHgky7UQiydATZCMzEdZTzFgzoUfEq7IDuzhMtROd+3zAja6X6e9ukx6BC0eE
         qj32c5WIPRWulWJI6ohAyV5RSf7JN0l+QSiKdt30YnGbBe8FW3aarMZS3s4pGhQHum2o
         WanfYjNNbg8MUnjn6o6ZbUgzRMtgxztnir9f1K6DPqb0OaWgmgc7YbPwawhOPDgS0Fza
         yR2w==
X-Gm-Message-State: AOAM530Hh20cr0C7szWYkqJ5K+q7NZXvsGf53nHWasFFAXkdoyQxiHjn
        tmU1s8QtpEDULcmZgCfAFgqlhUfnfypzUkwVjk/GcQ==
X-Google-Smtp-Source: ABdhPJzv0ePEkC7L+NRFMFpBQ1yf95VNXX3bPF63PAstZh4pZmbQB2H7pU39XceYKuXz1eNWQPCi4wjQZ7gNIoChkEc=
X-Received: by 2002:a2e:bf04:: with SMTP id c4mr3165322ljr.271.1642769703172;
 Fri, 21 Jan 2022 04:55:03 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org> <20220114150824.3578829-8-jens.wiklander@linaro.org>
In-Reply-To: <20220114150824.3578829-8-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 21 Jan 2022 18:24:52 +0530
Message-ID: <CAFA6WYN+NU6uj=R5y4A6RomWeKc74orvB7ouia8Sxuwxaz_-2w@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] optee: use driver internal tee_contex for some rpc
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Jerome Forissier <jerome@forissier.org>,
        Etienne Carriere <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

+ Jerome, Etienne

On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Uses the new driver internal tee_context when allocating driver private
> shared memory. This decouples the shared memory object from its original
> tee_context. This is needed when the life time of such a memory
> allocation outlives the client tee_context.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/ffa_abi.c | 16 ++++++++--------
>  drivers/tee/optee/smc_abi.c |  7 ++++---
>  2 files changed, 12 insertions(+), 11 deletions(-)
>

I guess with this patch we should no longer see issues [1] reported earlier.

FWIW,

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

[1] https://github.com/OP-TEE/optee_os/issues/1918

-Sumit

> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 88a028d4fb7b..5ec484b42432 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -424,6 +424,7 @@ static struct tee_shm_pool *optee_ffa_shm_pool_alloc_pages(void)
>   */
>
>  static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> +                                             struct optee *optee,
>                                               struct optee_msg_arg *arg)
>  {
>         struct tee_shm *shm;
> @@ -439,7 +440,7 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                 shm = optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
>                 break;
>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> -               shm = tee_shm_alloc_priv_kernel_buf(ctx,
> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx,
>                                                     arg->params[0].u.value.b);
>                 break;
>         default:
> @@ -493,14 +494,13 @@ static void handle_ffa_rpc_func_cmd_shm_free(struct tee_context *ctx,
>  }
>
>  static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
> +                                   struct optee *optee,
>                                     struct optee_msg_arg *arg)
>  {
> -       struct optee *optee = tee_get_drvdata(ctx->teedev);
> -
>         arg->ret_origin = TEEC_ORIGIN_COMMS;
>         switch (arg->cmd) {
>         case OPTEE_RPC_CMD_SHM_ALLOC:
> -               handle_ffa_rpc_func_cmd_shm_alloc(ctx, arg);
> +               handle_ffa_rpc_func_cmd_shm_alloc(ctx, optee, arg);
>                 break;
>         case OPTEE_RPC_CMD_SHM_FREE:
>                 handle_ffa_rpc_func_cmd_shm_free(ctx, optee, arg);
> @@ -510,12 +510,12 @@ static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
>         }
>  }
>
> -static void optee_handle_ffa_rpc(struct tee_context *ctx, u32 cmd,
> -                                struct optee_msg_arg *arg)
> +static void optee_handle_ffa_rpc(struct tee_context *ctx, struct optee *optee,
> +                                u32 cmd, struct optee_msg_arg *arg)
>  {
>         switch (cmd) {
>         case OPTEE_FFA_YIELDING_CALL_RETURN_RPC_CMD:
> -               handle_ffa_rpc_func_cmd(ctx, arg);
> +               handle_ffa_rpc_func_cmd(ctx, optee, arg);
>                 break;
>         case OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT:
>                 /* Interrupt delivered by now */
> @@ -582,7 +582,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
>                  * above.
>                  */
>                 cond_resched();
> -               optee_handle_ffa_rpc(ctx, data->data1, rpc_arg);
> +               optee_handle_ffa_rpc(ctx, optee, data->data1, rpc_arg);
>                 cmd = OPTEE_FFA_YIELDING_CALL_RESUME;
>                 data->data0 = cmd;
>                 data->data1 = 0;
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 1dbb13b08381..f2ef76451443 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -621,6 +621,7 @@ static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
>  }
>
>  static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> +                                         struct optee *optee,
>                                           struct optee_msg_arg *arg,
>                                           struct optee_call_ctx *call_ctx)
>  {
> @@ -650,7 +651,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>                 shm = optee_rpc_cmd_alloc_suppl(ctx, sz);
>                 break;
>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> -               shm = tee_shm_alloc_priv_kernel_buf(ctx, sz);
> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx, sz);
>                 break;
>         default:
>                 arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> @@ -746,7 +747,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
>         switch (arg->cmd) {
>         case OPTEE_RPC_CMD_SHM_ALLOC:
>                 free_pages_list(call_ctx);
> -               handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
> +               handle_rpc_func_cmd_shm_alloc(ctx, optee, arg, call_ctx);
>                 break;
>         case OPTEE_RPC_CMD_SHM_FREE:
>                 handle_rpc_func_cmd_shm_free(ctx, arg);
> @@ -775,7 +776,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
>
>         switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
>         case OPTEE_SMC_RPC_FUNC_ALLOC:
> -               shm = tee_shm_alloc_priv_kernel_buf(ctx, param->a1);
> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx, param->a1);
>                 if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
>                         reg_pair_from_64(&param->a1, &param->a2, pa);
>                         reg_pair_from_64(&param->a4, &param->a5,
> --
> 2.31.1
>
