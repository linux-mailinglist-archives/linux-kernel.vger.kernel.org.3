Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E73BD495FBF
	for <lists+linux-kernel@lfdr.de>; Fri, 21 Jan 2022 14:28:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380697AbiAUN2X (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 21 Jan 2022 08:28:23 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58404 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380583AbiAUN2W (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 21 Jan 2022 08:28:22 -0500
Received: from mail-wm1-x334.google.com (mail-wm1-x334.google.com [IPv6:2a00:1450:4864:20::334])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B8A4BC061574
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 05:28:21 -0800 (PST)
Received: by mail-wm1-x334.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so22363497wmb.5
        for <linux-kernel@vger.kernel.org>; Fri, 21 Jan 2022 05:28:21 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=forissier-org.20210112.gappssmtp.com; s=20210112;
        h=message-id:date:mime-version:user-agent:subject:content-language:to
         :cc:references:from:in-reply-to:content-transfer-encoding;
        bh=Uilb7rtGXgQI2Rp/O4smGnTA3fqRZ18DddOLnlScU0g=;
        b=tV5Lwg5EcH1gBvbj7qCmrvpFck+165EvZrokCuII+O+fTkmh/5D29KVjVLeQM6a2h/
         cvixANVSFJnUMSzbhr4HAJ0gkpA1dO1yapOLeD5TPhuaIxaU5DjKPKpJZwMJHMNXtKVD
         VZaVUJHpL71buon3nniwbIrOriJezYU8AhnenQM30Iq9w269fqiDeo5agxT39pvXTQ20
         KofGSEfKrYXng0XfaMu6yPpq3h09PzR6j080TWWRCoUH7VZgnCZaLbElP67Iq0fzS4Gz
         LvHHtn8TVAkOYLAKP2Fs4UxVCeHnKJkq1kcrvWAAIAxvhitzjTa/f87DU8KwHQrXCKL+
         W9jQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:message-id:date:mime-version:user-agent:subject
         :content-language:to:cc:references:from:in-reply-to
         :content-transfer-encoding;
        bh=Uilb7rtGXgQI2Rp/O4smGnTA3fqRZ18DddOLnlScU0g=;
        b=seZWYndTfBLKHkPYx9ESXZvfPALyUPa3JR94aGfems8m0/R/NURQM5ONA8zAkKqTSE
         Mu/j7TE7brIdSkQQ5SntrrEH73p27AsYgyop2eOB7Hw41cKamL+IY53RhwdGiNS/EGkt
         VIy71L4DBXAiT2eKf7J5jMEfMmES0CtquiStp+1oo9v9KtCRQoJoGtxrSxbmCpuTvae+
         XSoDGzw6n2fLb40vWYFKUwoWSC89kEmNcSw6kR8AkcZfJZAyhoWj6Pp2uRNF6v8ugu7v
         ouiW7sDMF145ypOo4/HOCd8kBpns+nwKRkcTxpdMO5icZHpQHjdbm2WI6P2hKV7oX5Tn
         qLFQ==
X-Gm-Message-State: AOAM532ow4i9SCPNdRZVJoqtePEXP2DS77BHHWwZOdIPKs1BM3G3/lgj
        QE3UoNgF7Xov9BDsmBiqsB/ckA==
X-Google-Smtp-Source: ABdhPJxSnG6jfG0AG9wiZOOXJhJpztj5r/HoijRXcgyvn9ciXtN2tby1TS8psKWDI6hCZLpJt1ND+A==
X-Received: by 2002:a7b:c118:: with SMTP id w24mr702278wmi.179.1642771700024;
        Fri, 21 Jan 2022 05:28:20 -0800 (PST)
Received: from ?IPV6:2a01:e0a:3cb:7bb0:a60f:d9da:23e6:8bf2? ([2a01:e0a:3cb:7bb0:a60f:d9da:23e6:8bf2])
        by smtp.gmail.com with ESMTPSA id h9sm5575074wmq.8.2022.01.21.05.28.19
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Fri, 21 Jan 2022 05:28:19 -0800 (PST)
Message-ID: <ad7311fe-0655-e235-f755-2eb3425c79c1@forissier.org>
Date:   Fri, 21 Jan 2022 14:28:18 +0100
MIME-Version: 1.0
User-Agent: Mozilla/5.0 (X11; Linux x86_64; rv:91.0) Gecko/20100101
 Thunderbird/91.5.0
Subject: Re: [PATCH v2 07/12] optee: use driver internal tee_contex for some
 rpc
Content-Language: en-US
To:     Sumit Garg <sumit.garg@linaro.org>,
        Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Herbert Xu <herbert@gondor.apana.org.au>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>,
        Etienne Carriere <etienne.carriere@linaro.org>
References: <20220114150824.3578829-1-jens.wiklander@linaro.org>
 <20220114150824.3578829-8-jens.wiklander@linaro.org>
 <CAFA6WYN+NU6uj=R5y4A6RomWeKc74orvB7ouia8Sxuwxaz_-2w@mail.gmail.com>
From:   Jerome Forissier <jerome@forissier.org>
In-Reply-To: <CAFA6WYN+NU6uj=R5y4A6RomWeKc74orvB7ouia8Sxuwxaz_-2w@mail.gmail.com>
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 7bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org



On 1/21/22 13:54, Sumit Garg wrote:
> + Jerome, Etienne
> 
> On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>>
>> Uses the new driver internal tee_context when allocating driver private
>> shared memory. This decouples the shared memory object from its original
>> tee_context. This is needed when the life time of such a memory
>> allocation outlives the client tee_context.
>>
>> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
>> ---
>>  drivers/tee/optee/ffa_abi.c | 16 ++++++++--------
>>  drivers/tee/optee/smc_abi.c |  7 ++++---
>>  2 files changed, 12 insertions(+), 11 deletions(-)
>>
> 
> I guess with this patch we should no longer see issues [1] reported earlier.

Correct. I have tested [1] again in QEMU with this whole series applied
and the issue is gone.

-- 
Jerome

> 
> FWIW,
> 
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> 
> [1] https://github.com/OP-TEE/optee_os/issues/1918
> 
> -Sumit
> 
>> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
>> index 88a028d4fb7b..5ec484b42432 100644
>> --- a/drivers/tee/optee/ffa_abi.c
>> +++ b/drivers/tee/optee/ffa_abi.c
>> @@ -424,6 +424,7 @@ static struct tee_shm_pool *optee_ffa_shm_pool_alloc_pages(void)
>>   */
>>
>>  static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>> +                                             struct optee *optee,
>>                                               struct optee_msg_arg *arg)
>>  {
>>         struct tee_shm *shm;
>> @@ -439,7 +440,7 @@ static void handle_ffa_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>>                 shm = optee_rpc_cmd_alloc_suppl(ctx, arg->params[0].u.value.b);
>>                 break;
>>         case OPTEE_RPC_SHM_TYPE_KERNEL:
>> -               shm = tee_shm_alloc_priv_kernel_buf(ctx,
>> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx,
>>                                                     arg->params[0].u.value.b);
>>                 break;
>>         default:
>> @@ -493,14 +494,13 @@ static void handle_ffa_rpc_func_cmd_shm_free(struct tee_context *ctx,
>>  }
>>
>>  static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
>> +                                   struct optee *optee,
>>                                     struct optee_msg_arg *arg)
>>  {
>> -       struct optee *optee = tee_get_drvdata(ctx->teedev);
>> -
>>         arg->ret_origin = TEEC_ORIGIN_COMMS;
>>         switch (arg->cmd) {
>>         case OPTEE_RPC_CMD_SHM_ALLOC:
>> -               handle_ffa_rpc_func_cmd_shm_alloc(ctx, arg);
>> +               handle_ffa_rpc_func_cmd_shm_alloc(ctx, optee, arg);
>>                 break;
>>         case OPTEE_RPC_CMD_SHM_FREE:
>>                 handle_ffa_rpc_func_cmd_shm_free(ctx, optee, arg);
>> @@ -510,12 +510,12 @@ static void handle_ffa_rpc_func_cmd(struct tee_context *ctx,
>>         }
>>  }
>>
>> -static void optee_handle_ffa_rpc(struct tee_context *ctx, u32 cmd,
>> -                                struct optee_msg_arg *arg)
>> +static void optee_handle_ffa_rpc(struct tee_context *ctx, struct optee *optee,
>> +                                u32 cmd, struct optee_msg_arg *arg)
>>  {
>>         switch (cmd) {
>>         case OPTEE_FFA_YIELDING_CALL_RETURN_RPC_CMD:
>> -               handle_ffa_rpc_func_cmd(ctx, arg);
>> +               handle_ffa_rpc_func_cmd(ctx, optee, arg);
>>                 break;
>>         case OPTEE_FFA_YIELDING_CALL_RETURN_INTERRUPT:
>>                 /* Interrupt delivered by now */
>> @@ -582,7 +582,7 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
>>                  * above.
>>                  */
>>                 cond_resched();
>> -               optee_handle_ffa_rpc(ctx, data->data1, rpc_arg);
>> +               optee_handle_ffa_rpc(ctx, optee, data->data1, rpc_arg);
>>                 cmd = OPTEE_FFA_YIELDING_CALL_RESUME;
>>                 data->data0 = cmd;
>>                 data->data1 = 0;
>> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
>> index 1dbb13b08381..f2ef76451443 100644
>> --- a/drivers/tee/optee/smc_abi.c
>> +++ b/drivers/tee/optee/smc_abi.c
>> @@ -621,6 +621,7 @@ static void handle_rpc_func_cmd_shm_free(struct tee_context *ctx,
>>  }
>>
>>  static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>> +                                         struct optee *optee,
>>                                           struct optee_msg_arg *arg,
>>                                           struct optee_call_ctx *call_ctx)
>>  {
>> @@ -650,7 +651,7 @@ static void handle_rpc_func_cmd_shm_alloc(struct tee_context *ctx,
>>                 shm = optee_rpc_cmd_alloc_suppl(ctx, sz);
>>                 break;
>>         case OPTEE_RPC_SHM_TYPE_KERNEL:
>> -               shm = tee_shm_alloc_priv_kernel_buf(ctx, sz);
>> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx, sz);
>>                 break;
>>         default:
>>                 arg->ret = TEEC_ERROR_BAD_PARAMETERS;
>> @@ -746,7 +747,7 @@ static void handle_rpc_func_cmd(struct tee_context *ctx, struct optee *optee,
>>         switch (arg->cmd) {
>>         case OPTEE_RPC_CMD_SHM_ALLOC:
>>                 free_pages_list(call_ctx);
>> -               handle_rpc_func_cmd_shm_alloc(ctx, arg, call_ctx);
>> +               handle_rpc_func_cmd_shm_alloc(ctx, optee, arg, call_ctx);
>>                 break;
>>         case OPTEE_RPC_CMD_SHM_FREE:
>>                 handle_rpc_func_cmd_shm_free(ctx, arg);
>> @@ -775,7 +776,7 @@ static void optee_handle_rpc(struct tee_context *ctx,
>>
>>         switch (OPTEE_SMC_RETURN_GET_RPC_FUNC(param->a0)) {
>>         case OPTEE_SMC_RPC_FUNC_ALLOC:
>> -               shm = tee_shm_alloc_priv_kernel_buf(ctx, param->a1);
>> +               shm = tee_shm_alloc_priv_kernel_buf(optee->ctx, param->a1);
>>                 if (!IS_ERR(shm) && !tee_shm_get_pa(shm, 0, &pa)) {
>>                         reg_pair_from_64(&param->a1, &param->a2, pa);
>>                         reg_pair_from_64(&param->a4, &param->a5,
>> --
>> 2.31.1
>>
