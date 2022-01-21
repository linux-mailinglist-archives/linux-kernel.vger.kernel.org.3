Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EBBC5495FD9
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:37:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350609AbiAUNhP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:37:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235175AbiAUNhO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:37:14 -0500
Received: from mail-lf1-x12e.google.com (mail-lf1-x12e.google.com [IPv6:2a00:1450:4864:20::12e])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5A71EC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 05:37:13 -0800 (PST)
Received: by mail-lf1-x12e.google.com with SMTP id x7so33914436lfu.8
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 05:37:13 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=mBhkS/ZeBxLH+0BxP3Hcg+id4TNzZIL//WN86Dn8RYs=;
        b=x9Ir7LHom4o+ADME8JtW07SVKmDNsIXNlPz1iDMp+KM0QPMCYb2SEDruDrsXNqTClF
         dTqpFp4THjkOSNT91XRsmm4I4ZAbhLviNHqvlfMyHNxzPfhZJYmlv0R6hX5YGkZEbK4g
         Y8XmdLwhhJ2LzPRsZs2oxcIaf7wmzXAhqL8fdBVLnQ3pRD8M6UAUldaBEjbUzE+ZvWWu
         3NETef2qgXY07Thoqj3C+RozJlVeKzweu5O1M8c3Oy6cfoJFqSx7dOX4VPicGGiZafFi
         ZcsZrgzfzYgbqPkZYV/E4Asg6Y+nxuDhoPI5XqEWccVeDFhvac1d36+JtYja+EFeq3ot
         pUAw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=mBhkS/ZeBxLH+0BxP3Hcg+id4TNzZIL//WN86Dn8RYs=;
        b=00qPLw1+yiQE52tsOhQTLj9FkNYKqXzc8iHd2Hpw3rHQlJ2EwGmkRpvJAUVecY5+sx
         PbHlEEYStrmExfXFvZWhKKfdYc3yMyHOrh/9XfoFEevjq8W6oAybNJV6r6uJ+XdryizZ
         xvpznceXhj6C3m1e+ET2OUXyTZzFooICg2rlpJK46in6IWVpYgX9/aMkZAIlbqitfF0b
         MgvRgN/csqkc5o+WcqksHjJc2nHKLicz8BKu+6fO3zW/q1u/lbBZkpo+0hDrUidjdpi8
         GiosuSZvgvfprG41he2hjNg8o5NQtZzXEXl48Zkd88yeSTr7hMZdULiCO5GtsxVF+X1q
         cbTg==
X-Gm-Message-State: AOAM530ttk9cAp1ewHMRri9u5aZpnn2ChddcNi1Bgp4fCkJUA5SBZAzQ
        UMEGm1pM/0YLBandg6Ooc4O7rD3mHPljeJ8CNeHZKQ==
X-Google-Smtp-Source: ABdhPJw0Uz5EDrVS5BH+Q2F8dOtspzUs1qCd3DElliyxkJ+CzKsGSXLJSzOJQLI1yqi5oAJ5LhE1gLqzbSXxtvsb8K8=
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr3690841lfr.253.1642772231555;
 Fri, 21 Jan 2022 05:37:11 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
 <20220114150824.3578829-8-jens.wiklander@linaro.org> <CAFA6WYN+NU6uj=R5y4A6RomWeKc74orvB7ouia8Sxuwxaz_-2w@mail.gmail.com>
 <ad7311fe-0655-e235-f755-2eb3425c79c1@forissier.org>
In-Reply-To: <ad7311fe-0655-e235-f755-2eb3425c79c1@forissier.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Fri, 21 Jan 2022 19:07:00 +0530
Message-ID: <CAFA6WYNo2xJ8VncpwbHG65hTTshxa-SWaPnGCB2v3KCTGogJkQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/12] optee: use driver internal tee_contex for some rpc
To:     Jerome Forissier <jerome@forissier.org>
Cc:     Jens Wiklander <jens.wiklander@linaro.org>,
        linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 21 Jan 2022 at 18:58, Jerome Forissier <jerome@forissier.org> wrote:
>
> On 1/21/22 13:54, Sumit Garg wrote:
> > + Jerome, Etienne
> >
> > On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
> >>
> >> Uses the new driver internal tee_context when allocating driver private
> >> shared memory. This decouples the shared memory object from its original
> >> tee_context. This is needed when the life time of such a memory
> >> allocation outlives the client tee_context.
> >>
> >> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> >> ---
> >>  drivers/tee/optee/ffa_abi.c | 16 ++++++++--------
> >>  drivers/tee/optee/smc_abi.c |  7 ++++---
> >>  2 files changed, 12 insertions(+), 11 deletions(-)
> >>
> >
> > I guess with this patch we should no longer see issues [1] reported earlier.
>
> Correct. I have tested [1] again in QEMU with this whole series applied
> and the issue is gone.
>

Thanks for the confirmation.

Jens,

Can we have a Fixes tag for this and CC stable? I know it won't be
directly applicable to stable kernels but we can help with a backport.

-Sumit

> --
> Jerome
>
> >
> > FWIW,
> >
> > Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> >
> > [1] https://github.com/OP-TEE/optee_os/issues/1918
> >
> > -Sumit
> >
> >> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> >> index 88a028d4fb7b..5ec484b42432 100644
> >> --- a/drivers/tee/optee/ffa_abi.c
> >> +++ b/drivers/tee/optee/ffa_abi.c
> >> @@ -424,6 +424,7 @@ static struct tee_shm_pool *optee_ffa_shm_pool_alloc_pages(void)
> >>   */
> >>
> >>  static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> >> +                                             struct optee *optee,
> >>                                               struct optee_msg_arg *arg)
> >>  {
> >>         struct tee_shm *shm;
> >> @@ -439,7 +440,7 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> >>                 shm = optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
> >>                 break;
> >>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> >> -               shm = tee_shm_alloc_priv_kernel_buf(ctx,
> >> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx,
> >>                                                     arg->params[0].u.value.b);
> >>                 break;
> >>         default:
> >> @@ -493,14 +494,13 @@ static void handle_ffa_rpc_func_cmd_shm_free(struct tee_context *ctx,
> >>  }
> >>
> >>  static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
> >> +                                   struct optee *optee,
> >>                                     struct optee_msg_arg *arg)
> >>  {
> >> -       struct optee *optee = tee_get_drvdata(ctx->teedev);
> >> -
> >>         arg->ret_origin = TEEC_ORIGIN_COMMS;
> >>         switch (arg->cmd) {
> >>         case OPTEE_RPC_CMD_SHM_ALLOC:
> >> -               handle_ffa_rpc_func_cmd_shm_alloc(ctx, arg);
> >> +               handle_ffa_rpc_func_cmd_shm_alloc(ctx, optee, arg);
> >>                 break;
> >>         case OPTEE_RPC_CMD_SHM_FREE:
> >>                 handle_ffa_rpc_func_cmd_shm_free(ctx, optee, arg);
> >> @@ -510,12 +510,12 @@ static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
> >>         }
> >>  }
> >>
> >> -static void optee_handle_ffa_rpc(struct tee_context *ctx, u32 cmd,
> >> -                                struct optee_msg_arg *arg)
> >> +static void optee_handle_ffa_rpc(struct tee_context *ctx, struct optee *optee,
> >> +                                u32 cmd, struct optee_msg_arg *arg)
> >>  {
> >>         switch (cmd) {
> >>         case OPTEE_FFA_YIELDING_CALL_RETURN_RPC_CMD:
> >> -               handle_ffa_rpc_func_cmd(ctx, arg);
> >> +               handle_ffa_rpc_func_cmd(ctx, optee, arg);
> >>                 break;
> >>         case OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT:
> >>                 /* Interrupt delivered by now */
> >> @@ -582,7 +582,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
> >>                  * above.
> >>                  */
> >>                 cond_resched();
> >> -               optee_handle_ffa_rpc(ctx, data->data1, rpc_arg);
> >> +               optee_handle_ffa_rpc(ctx, optee, data->data1, rpc_arg);
> >>                 cmd = OPTEE_FFA_YIELDING_CALL_RESUME;
> >>                 data->data0 = cmd;
> >>                 data->data1 = 0;
> >> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> >> index 1dbb13b08381..f2ef76451443 100644
> >> --- a/drivers/tee/optee/smc_abi.c
> >> +++ b/drivers/tee/optee/smc_abi.c
> >> @@ -621,6 +621,7 @@ static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
> >>  }
> >>
> >>  static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> >> +                                         struct optee *optee,
> >>                                           struct optee_msg_arg *arg,
> >>                                           struct optee_call_ctx *call_ctx)
> >>  {
> >> @@ -650,7 +651,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
> >>                 shm = optee_rpc_cmd_alloc_suppl(ctx, sz);
> >>                 break;
> >>         case OPTEE_RPC_SHM_TYPE_KERNEL:
> >> -               shm = tee_shm_alloc_priv_kernel_buf(ctx, sz);
> >> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx, sz);
> >>                 break;
> >>         default:
> >>                 arg->ret = TEEC_ERROR_BAD_PARAMETERS;
> >> @@ -746,7 +747,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
> >>         switch (arg->cmd) {
> >>         case OPTEE_RPC_CMD_SHM_ALLOC:
> >>                 free_pages_list(call_ctx);
> >> -               handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
> >> +               handle_rpc_func_cmd_shm_alloc(ctx, optee, arg, call_ctx);
> >>                 break;
> >>         case OPTEE_RPC_CMD_SHM_FREE:
> >>                 handle_rpc_func_cmd_shm_free(ctx, arg);
> >> @@ -775,7 +776,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
> >>
> >>         switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
> >>         case OPTEE_SMC_RPC_FUNC_ALLOC:
> >> -               shm = tee_shm_alloc_priv_kernel_buf(ctx, param->a1);
> >> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx, param->a1);
> >>                 if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
> >>                         reg_pair_from_64(&param->a1, &param->a2, pa);
> >>                         reg_pair_from_64(&param->a4, &param->a5,
> >> --
> >> 2.31.1
> >>
