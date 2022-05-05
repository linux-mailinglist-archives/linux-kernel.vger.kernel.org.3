Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E142D51B765
	for <lists+linux-kernel@lfdr.de>; Thu,  5 May 2022 07:15:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243293AbiEEFSn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 5 May 2022 01:18:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51026 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243252AbiEEFSm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 5 May 2022 01:18:42 -0400
Received: from mail-pg1-x530.google.com (mail-pg1-x530.google.com [IPv6:2607:f8b0:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 03EBF6441
        for <linux-kernel@vger.kernel.org>; Wed,  4 May 2022 22:15:04 -0700 (PDT)
Received: by mail-pg1-x530.google.com with SMTP id 15so2826536pgf.4
        for <linux-kernel@vger.kernel.org>; Wed, 04 May 2022 22:15:03 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=rciyAge845BWG9mlD1S98CNzrOU1Orh/xcyyS8+TIrQ=;
        b=bA31F5qeB2Pfmy2yJFw8I9b+3ot/zzHb/yJxojfnI+MNjJ3kI6s4rlc2gJU5lbtW79
         PkpLTv6ge1hBlbzMb3QpHu4J+/8oHt0RjbIUUpFda0LgQsAeK+NmuXvBz7RQGO+3Sa+s
         TZxoKfN4NTFpb4U/b24rLCVWtCQregrsErcv3FL+icWAlZMCYfuCOEWGa4aZTlZeAjqM
         QreWzxf6FJfXQqqqSnsC+Cpb1hez/v+u80sfU/ANvJHJqQaqs0LyK+jASO6ZamI1d32m
         T0yBuucNpxwGVFfrZTwK/iRSFRYEcupCdfUaipP1OQpAJXE4bOILUumfnQkY4wCKZOom
         Uyjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=rciyAge845BWG9mlD1S98CNzrOU1Orh/xcyyS8+TIrQ=;
        b=Ns1kqG1IDoK/Q/DcMPOiMx7qhJh4Hr5O6kI6bF35vlh1KWs0ucP5Ie/NyHF9taj/WS
         741dENBTNsgDguZA9Yp+LZ/BSUYRQFxzkEPk0gjhPc7SdzT6FO6YVt3T2GppDgIxLyCL
         1Fpfm2sxvZHj07haWbbeDszj6aEu+W/hcOVwTle5mqIPq/wcoo7VkaWGFNiEP/EtkSxN
         DgS1w2THS0mAIT2YvUZlmfDJTCNWIw7CEzleHwR2jDn0s3l1Na+tCbwz3l8GsLz9dA1G
         ifcaBx1ecwquNIAfROAcfmqz/ynxAglCbbhAuW3rawOyuMDM3tCfOX/XWYD+8mclCNjA
         30TQ==
X-Gm-Message-State: AOAM5305lGzq4BhlE/RXr8/16SmqA/ZVygwlVcsrtVPTGqVUnJ6qbk05
        AITu3nK2d/MCLeEea/XyeVWspM4rnGeRg9sruJ/XCPZxnOs=
X-Google-Smtp-Source: ABdhPJxlwwNM4iOSdr/ZBBGMxgVjuOijnxzygeFIDXnlnvnoqmwR416mD5IiQuhTqX1wIGAHL1AWUNHtD7eb+tRgldM=
X-Received: by 2002:a63:db17:0:b0:3c1:dc15:7a6e with SMTP id
 e23-20020a63db17000000b003c1dc157a6emr19512781pgg.107.1651727703367; Wed, 04
 May 2022 22:15:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220426073338.3048192-1-jens.wiklander@linaro.org>
In-Reply-To: <20220426073338.3048192-1-jens.wiklander@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Thu, 5 May 2022 07:14:52 +0200
Message-ID: <CAHUa44HHR9Y5y-xM8Ss5+amUokV=yfpymJqMwPfNjcfi1aD4gw@mail.gmail.com>
Subject: Re: [PATCH v4 0/4] OP-TEE RPC argument cache
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org
Cc:     Sumit Garg <sumit.garg@linaro.org>
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

On Tue, Apr 26, 2022 at 9:33 AM Jens Wiklander
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
> v3->v4:
> * Updated "optee: cache argument shared memory structs" to work with older
>   versions of the SMC-ABI when using dynamic shared memory.
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
>  drivers/tee/optee/smc_abi.c       | 197 ++++++++++++++++++++-----
>  7 files changed, 461 insertions(+), 102 deletions(-)
>
> --
> 2.31.1
>

I've picked this up now.

Thanks,
Jens
