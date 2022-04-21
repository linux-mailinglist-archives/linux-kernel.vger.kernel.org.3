Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E2CA3509E91
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 13:33:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1388791AbiDULfv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 07:35:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60588 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229845AbiDULft (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 07:35:49 -0400
Received: from mail-pl1-x629.google.com (mail-pl1-x629.google.com [IPv6:2607:f8b0:4864:20::629])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1281140D0
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:33:00 -0700 (PDT)
Received: by mail-pl1-x629.google.com with SMTP id h12so896599plf.12
        for <linux-kernel@vger.kernel.org>; Thu, 21 Apr 2022 04:33:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=x8vc5Lqzum4lYDosmWy4L9nn8ptNN2qPG9vpBgUE29c=;
        b=WreX/8/GVFQwIgFsNGXkM/1h4E/2rdW6bda3eIkkC4EDnv20mtqcz+bfpGzPbmLSdU
         /6WSAoqGkCatJS7pWJf/h9LRxRByUSgTbJXuIaoZSJYP0W4QVh+qCGldGbiS78GdIZJE
         340OQ23cpojJjq0MoSf2aDDTemNfKoE119MccYMEhTUaezA1IXGBmim2yk/GNoN9Rhoj
         mjekibaHqyrUXVd3Avqiyly0MKzJF/ykBWz7EpFJIaTE/Pf2hC3He5k/r5/bm5lAYesp
         20pGJcfn0UFZfORzJb4im45Rn8pcnWJCN9cWva6GftviGOQlWEq92YZT3UwK0S4XHO0L
         TY4g==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=x8vc5Lqzum4lYDosmWy4L9nn8ptNN2qPG9vpBgUE29c=;
        b=URMPBDboXufqlB0CQ3+3HbRxd+vY1FFf1oO3kNJLFlRikrhLf6R/IcAjF3Yc5RZSqy
         tWbKBf8SNKi8g1WgXdM7zGxSgMlJkDgfT6IJiLbnwi+F+1/eDrDgiEo+IkvrLIWeKxhz
         nP2uv/JEziyjl2LC/Z8esK7sSuflFwn7E3lcjA/qduGj9XezZEMJfUir1g8U14wodGtV
         2c4vgMZP+OXCufIh11EG9Bc+UHqLXOC7d+oDxwBrvO9Kw3uEg8s3Cy7Cw6CNVp3eWJT8
         m+T5i57kEgRV5QTwbZq8BjYtUuEHAHnBYUI1N/vDvVeItrzOq0+pzNrRH2YFj5h5t7Jt
         I2GQ==
X-Gm-Message-State: AOAM530rWlDrwUtXlPYp+vTuuOkYZ7NLbBokrpHrFcBugwjItmqmTXjW
        WBGWSZoVz+AHDri+zOTAmrAU/3xL450fXbIJ+CfH9VmbIUo=
X-Google-Smtp-Source: ABdhPJzzjL5494LiOh34wJhWlahqbI+slZAIUW8Kh9mNSmJJ1L8g5Bgy5Qz7OzqzEG3wvnduM6/LUtDFF0LJ23aJhn8=
X-Received: by 2002:a17:903:1212:b0:156:3ddc:84bd with SMTP id
 l18-20020a170903121200b001563ddc84bdmr24577436plh.70.1650540780111; Thu, 21
 Apr 2022 04:33:00 -0700 (PDT)
MIME-Version: 1.0
References: <20220413054418.71996-1-jens.wiklander@linaro.org>
In-Reply-To: <20220413054418.71996-1-jens.wiklander@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 21 Apr 2022 13:32:49 +0200
Message-ID: <CAHUa44FVPNT9zWNDdFE7GcwBT5O12+KeXtnELBrJPFFttK-aBw@mail.gmail.com>
Subject: Re: [PATCH v3 0/4] OP-TEE RPC argument cache
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, Apr 13, 2022 at 7:44 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Hi all,
>
> This patchset optimizes handling of the argument struct passed to
> call_with_arg when doing a yielding call to OP-TEE.
>
> Prior to this was this struct allocated before the yielding call and
> then freed after it had returned. In case many calls are made in succession
> this results in quite a bit of unnecessary allocte/free and possibly also
> switching back and forth to secure work in order to register if needed.
>
> Another optimization handles the way the argument struct needed to do RPC
> is passed. Please see the patch "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
> OPTEE_SMC_CALL_WITH_REGD_ARG" for details.
>
> Thanks,
> Jens
>
> v1->v2:
> * Split out a separate commit "optee: rename rpc_arg_count to
>   rpc_param_count"
> * Check optee->rpc_param_count before calling optee_disable_shm_cache().
> * Mention OPTEE_SMC_CALL_WITH_REGD_ARG in commit message.
>
> v2->v3:
> * Applied Sumit's R-B to "optee: rename rpc_arg_count to rpc_param_count"
>   and "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG"
> * Fixed some review comments to "optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
>   OPTEE_SMC_CALL_WITH_REGD_ARG"
> * Rebased on v5.18-rc1
>
>
> Jens Wiklander (4):
>   optee: rename rpc_arg_count to rpc_param_count
>   optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and
>     OPTEE_SMC_CALL_WITH_REGD_ARG
>   optee: add FF-A capability OPTEE_FFA_SEC_CAP_ARG_OFFSET
>   optee: cache argument shared memory structs
>
>  drivers/tee/optee/call.c          | 238 ++++++++++++++++++++++++------
>  drivers/tee/optee/core.c          |   1 +
>  drivers/tee/optee/ffa_abi.c       |  36 +++--
>  drivers/tee/optee/optee_ffa.h     |  12 +-
>  drivers/tee/optee/optee_private.h |  31 +++-
>  drivers/tee/optee/optee_smc.h     |  48 +++++-
>  drivers/tee/optee/smc_abi.c       | 162 +++++++++++++++-----
>  7 files changed, 428 insertions(+), 100 deletions(-)

I'm going to pick up this if there are no further comments.

Thanks,
Jens

>
> --
> 2.31.1
>
