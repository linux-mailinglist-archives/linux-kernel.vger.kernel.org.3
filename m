Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 890EC56D481
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 08:09:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229670AbiGKGJg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 02:09:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49992 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229469AbiGKGJf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 02:09:35 -0400
Received: from mail-pl1-x62f.google.com (mail-pl1-x62f.google.com [IPv6:2607:f8b0:4864:20::62f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B040A44B
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:09:34 -0700 (PDT)
Received: by mail-pl1-x62f.google.com with SMTP id c13so3602964pla.6
        for <linux-kernel@vger.kernel.org>; Sun, 10 Jul 2022 23:09:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=V0rcV06U3WIn3O5UNkF+0CP8tSpeEXIUs1+Som6c9Gg=;
        b=LU1rAOGmOn+43YOFKj09xuQ5pIBAiMPiAm/JlURJbUS28k9Q5pHqzijZq3QKAQ41D3
         acp0jhmJVygrwBW0v8s4VRXKsYbmO2D/p0VeUaGKGdsX2dK0rUoqhXZ3i+7d4tYCsf5j
         ArulmyuT4qsqKCunnqsQGl7aYXw4toLruOxeRFqc7V1bw+TSwTjChHNq+pa5JVPY7fYa
         nWw/vXh/LU3XWueM4FWC6vRig+vTyasMNDN58+s7ev8D6k6a2TmArkWaWzh6WCZ5lL0d
         3gEDM93cN+GwNuOb6QAWFyym4khU/RL2bT8QhPn0kyY4y5Bq4QnkF7hb+njKN4vFm6w/
         ukQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=V0rcV06U3WIn3O5UNkF+0CP8tSpeEXIUs1+Som6c9Gg=;
        b=kCIwgRv/z3aLNthqYkdz9xlqsW+7Xi2KJzlKRUKUgPAw1BQBeuztQ9SAdVHhUJvQMe
         RflBPEJ8dD9bAvBLlHZR1PGGckBfXmNqlECvigVmK+IaLL8RkLOPteb8sDj+dPjf/5jo
         /hkWIRE11fTPBdRuwAktaxBiFEk0gEcolO8QqIcn/UAkDE18OJuklj9PK9bwq8TF2GOk
         MynKGv7AEhkvOwL3kSHbg56Fc7pkyVy/PXOC2Oa6fkjg+ubyvM885AUs8j8ggVeAZjoQ
         Oc/TEJpVl9oaBL71+P7b/1Y8LJNuoqRuRXelDS2mtQjLj+kLnUMIaALCmCsXIpb6nESU
         5ptA==
X-Gm-Message-State: AJIora8ZrGMUvNkakkAqxu1LV5wkYdG2hSAo6YSvdrT6zoBjFPhf1WaD
        GFs9o0WyWL8SzOaW7ISAMVdkBZO5GbiMBCY454b2Gg==
X-Google-Smtp-Source: AGRyM1uP0Jh3rkKs5VgO9qyKcUlY22NFtnBfQaFZGI1Xy3935fw0xQ+eWSj8QqWcb7v+HYpyiePFgvUe4ZJIdRsTgcQ=
X-Received: by 2002:a17:902:c94b:b0:16a:3f98:84fd with SMTP id
 i11-20020a170902c94b00b0016a3f9884fdmr16809871pla.70.1657519773680; Sun, 10
 Jul 2022 23:09:33 -0700 (PDT)
MIME-Version: 1.0
References: <20220628065216.901194-1-yangyingliang@huawei.com>
In-Reply-To: <20220628065216.901194-1-yangyingliang@huawei.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 11 Jul 2022 08:09:22 +0200
Message-ID: <CAHUa44Gxs9-wB6xJ9+Fbkgzw+n8UkpLOzj0GDX4toH_O5Dtqwg@mail.gmail.com>
Subject: Re: [PATCH] optee: smc_abi.c: fix wrong pointer passed to IS_ERR/PTR_ERR()
To:     Yang Yingliang <yangyingliang@huawei.com>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        sumit.garg@linaro.org
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

On Tue, Jun 28, 2022 at 8:42 AM Yang Yingliang <yangyingliang@huawei.com> wrote:
>
> It should be 'rpc_arg' pass to IS_ERR/PTR_ERR().
>
> Fixes: ed8faf6c8f8c ("optee: add OPTEE_SMC_CALL_WITH_RPC_ARG and OPTEE_SMC_CALL_WITH_REGD_ARG")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/tee/optee/smc_abi.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)

I'm picking up this. I've added some description in the commit message.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 385cb0aee610..a1c1fa1a9c28 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -884,8 +884,8 @@ static int optee_smc_do_call_with_arg(struct tee_context *ctx,
>
>                 rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
>                 rpc_arg = tee_shm_get_va(shm, offs + rpc_arg_offs);
> -               if (IS_ERR(arg))
> -                       return PTR_ERR(arg);
> +               if (IS_ERR(rpc_arg))
> +                       return PTR_ERR(rpc_arg);
>         }
>
>         if  (rpc_arg && tee_shm_is_dynamic(shm)) {
> --
> 2.25.1
>
