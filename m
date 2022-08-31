Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D8CE5A7BC9
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 12:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230347AbiHaK6R (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 06:58:17 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229877AbiHaK6P (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 06:58:15 -0400
Received: from mail-lf1-x132.google.com (mail-lf1-x132.google.com [IPv6:2a00:1450:4864:20::132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E06BDCAC8D
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:58:13 -0700 (PDT)
Received: by mail-lf1-x132.google.com with SMTP id p16so1383797lfd.6
        for <linux-kernel@vger.kernel.org>; Wed, 31 Aug 2022 03:58:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=EFAV4WEK5stmAHxUEUHCn6nHNOVfz5EcrC5HG9nC0L0=;
        b=TrKg4RpjRhTmZU6+NyIj3FIJlB5oy5u6MHW4keQZtLbFwFHVeTePGp3uQJptaL8jq9
         iysvOTAfSNn8YrrneywiP6RUO1qDdhNzyeoVsnCagBb+cktPGQqAUxXNrWaBqjh+F16L
         7Dj06suMjC9J5OYlr8gsG3hdX9o8StC++sar7dwyGKhDS+47/dEYUnL/SA2CkQRgfCyK
         NyUVPhh2LtA3aEaTDlxw1NsFmO8Hu2mdfJNDZYaf/xSJ54PkMpTI/150MEsRiQJi8ge6
         yD0q4c37A0Kavrd/sYnNdn3MaqQXZnfrTJMHM6ml6lXQQDZXDr+i51A6n36phBnQpmmv
         ENlQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=EFAV4WEK5stmAHxUEUHCn6nHNOVfz5EcrC5HG9nC0L0=;
        b=tx6zurKCMEga2GqvdMpMstcB7CCACrFQlaw0o6uax5KvfkDcQIkh1SVzd6jy7Egq8w
         oZDfaJ76BphINzZwiEVN+dBy5I+Z4Q/irZeB3v3yIRpIfep2mcaZU8tJLziExGi4FrIx
         MY+W3mDBadCvLIlmSwRkfrFasEtv9qtoBaDf1aM8NxtJo7r6JvkTwtiw8As2FyyKoJyE
         yVYOirFrA+sj++RQ2e0cx+FUESwmwlNajPmU4qUrwN81w5ZXwO5qBatw+i2U0CVEE8+z
         pt9vllFAAMfPfKU/vR1Av5sC4sySpqx7L8pt+kL4I082+Zr6ffTV+uC/4M1EbZ0ntWsc
         ML9Q==
X-Gm-Message-State: ACgBeo1JZ6oFWMSXtuYAV8T2c6znnBbEKGkRv2ZJmZ9P1tFveV3yZxiX
        EEwCfAKT3JWlr7eAkeEOks2MH/ZiyCGDrkjz36vXMw==
X-Google-Smtp-Source: AA6agR7xOzjW0ef6vY9nzjerelKHRmdyEZ2OR07rJOgwcxwH042wuitq29ChubRwifYM7b9Z/JljAl/s06CyPVYJJVs=
X-Received: by 2002:a05:6512:3192:b0:494:6055:6413 with SMTP id
 i18-20020a056512319200b0049460556413mr5569304lfe.109.1661943492247; Wed, 31
 Aug 2022 03:58:12 -0700 (PDT)
MIME-Version: 1.0
References: <20220830100700.344594-1-sudeep.holla@arm.com> <20220830100700.344594-9-sudeep.holla@arm.com>
In-Reply-To: <20220830100700.344594-9-sudeep.holla@arm.com>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Wed, 31 Aug 2022 16:28:01 +0530
Message-ID: <CAFA6WYPXsLt692eW3_tqy+=aLz7W-Ymh-RqZuqATeHpzGp8Tkw@mail.gmail.com>
Subject: Re: [PATCH 8/9] tee: optee: Drop ffa_ops in optee_ffa structure
To:     Sudeep Holla <sudeep.holla@arm.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Marc Bonnici <marc.bonnici@arm.com>,
        Valentin Laurent <valentin.laurent@trustonic.com>,
        Lukas Hanel <lukas.hanel@trustonic.com>,
        Coboy Chen <coboy.chen@mediatek.com>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, 30 Aug 2022 at 15:40, Sudeep Holla <sudeep.holla@arm.com> wrote:
>
> Since the ffa_device itself carries ffa_dev_ops now, there is no need
> to keep a copy in optee_ffa structure.
>
> Drop ffa_ops in the optee_ffa structure as it is not needed anymore.
>
> Signed-off-by: Sudeep Holla <sudeep.holla@arm.com>
> ---
>  drivers/tee/optee/ffa_abi.c       | 9 ++++-----
>  drivers/tee/optee/optee_private.h | 1 -
>  2 files changed, 4 insertions(+), 6 deletions(-)
>

Is this patch doing anything different from patch #2? If not then I
think both should be squashed.

-Sumit

> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 7ec0a2f9a63b..7257b42d0545 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -271,8 +271,8 @@ static int optee_ffa_shm_register(struct tee_context *ctx, struct tee_shm *shm,
>                                   unsigned long start)
>  {
>         struct optee *optee = tee_get_drvdata(ctx->teedev);
> -       const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_ops;
>         struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
> +       const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
>         struct ffa_mem_region_attributes mem_attr = {
>                 .receiver = ffa_dev->vm_id,
>                 .attrs = FFA_MEM_RW,
> @@ -314,8 +314,8 @@ static int optee_ffa_shm_unregister(struct tee_context *ctx,
>                                     struct tee_shm *shm)
>  {
>         struct optee *optee = tee_get_drvdata(ctx->teedev);
> -       const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_ops;
>         struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
> +       const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
>         u64 global_handle = shm->sec_world_id;
>         struct ffa_send_direct_data data = {
>                 .data0 = OPTEE_FFA_UNREGISTER_SHM,
> @@ -342,7 +342,7 @@ static int optee_ffa_shm_unregister_supp(struct tee_context *ctx,
>                                          struct tee_shm *shm)
>  {
>         struct optee *optee = tee_get_drvdata(ctx->teedev);
> -       const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_ops;
> +       const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_dev->ops;
>         u64 global_handle = shm->sec_world_id;
>         int rc;
>
> @@ -529,8 +529,8 @@ static int optee_ffa_yielding_call(struct tee_context *ctx,
>                                    struct optee_msg_arg *rpc_arg)
>  {
>         struct optee *optee = tee_get_drvdata(ctx->teedev);
> -       const struct ffa_dev_ops *ffa_ops = optee->ffa.ffa_ops;
>         struct ffa_device *ffa_dev = optee->ffa.ffa_dev;
> +       const struct ffa_dev_ops *ffa_ops = ffa_dev->ops;
>         struct optee_call_waiter w;
>         u32 cmd = data->data0;
>         u32 w4 = data->data1;
> @@ -817,7 +817,6 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>
>         optee->ops = &optee_ffa_ops;
>         optee->ffa.ffa_dev = ffa_dev;
> -       optee->ffa.ffa_ops = ffa_ops;
>         optee->rpc_param_count = rpc_param_count;
>
>         teedev = tee_device_alloc(&optee_ffa_clnt_desc, NULL, optee->pool,
> diff --git a/drivers/tee/optee/optee_private.h b/drivers/tee/optee/optee_private.h
> index a33d98d17cfd..04ae58892608 100644
> --- a/drivers/tee/optee/optee_private.h
> +++ b/drivers/tee/optee/optee_private.h
> @@ -111,7 +111,6 @@ struct optee_smc {
>   */
>  struct optee_ffa {
>         struct ffa_device *ffa_dev;
> -       const struct ffa_dev_ops *ffa_ops;
>         /* Serializes access to @global_ids */
>         struct mutex mutex;
>         struct rhashtable global_ids;
> --
> 2.37.2
>
