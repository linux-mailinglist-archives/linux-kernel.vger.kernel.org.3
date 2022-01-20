Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 8CB24494CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:18:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230400AbiATLS0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:18:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230401AbiATLSZ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:18:25 -0500
Received: from mail-lf1-x136.google.com (mail-lf1-x136.google.com [IPv6:2a00:1450:4864:20::136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 00730C061574
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:18:24 -0800 (PST)
Received: by mail-lf1-x136.google.com with SMTP id m3so20541966lfu.0
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:18:24 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Amn5nz57pKhIkTgsHr7p16Jd1Ov8SUYin81inWM2Dwg=;
        b=p8x7Om1rnQkcz1/jew3DCVV8FvWmnp9yNagWL/9EL6EJF0ElBYjhp9CyHE/jLfYzjZ
         NHzuKoqWiMzkBxVEmloEYuSj230PdJqk0e2I8hvgLX6NfCKdnmknpO5qPOlV4IXl16RS
         Yn1XQ2o3YulOb0P1wzIkJKlCwjtgl+qMn3QAYAltJsbMuwc0Uda/icCTARhDucRUOmF0
         tht7Hqlmi68tC85wS+odAgBeU4bt0wGVMikktpp2kuyrDUosLfyUhiusMTzUm5FTp6Vb
         ez1uoGGyHsY9BtiCkQmj2vqKL7T64OfMQYeBWyh5rtb1SRdw3Yn4DvQR9DdoNRe5XOmX
         1Wfw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Amn5nz57pKhIkTgsHr7p16Jd1Ov8SUYin81inWM2Dwg=;
        b=DdccImsnxmcc3HLKhijGJgFnqF8JSXjELh4RyagDmg+l7UBQ7d6DvhM8zjkhfMidlR
         Qd/+RCTLsQYmm3/EM3KrJs/FDabxYzjw9+ClrRNGTyU3Z0oYP3U6QVfP54yIzenBETl9
         WGKll1DuzhcW6F+Hp7QEO9CoWn+tHVqd7TPanS8Fn+34A7/n+n9kKV8A4t/+82vDG1wx
         brx7nkMezFsSVMvyKE7XR8sdTSYNDt/ZaQrjM2c8PhZOxsbk66j6Wtuj8QloASkEeRXH
         iUrgf2Sj0V/LaE9BMSy4d3LzczJDP24zlZPNPjRjKZDjL4RRVbBrU9y7y0r2RJqcq76P
         /5NA==
X-Gm-Message-State: AOAM533eNxP+4xdl6bEqzlxA0hGydhqOEi3JqtRvkwpP8YUyAwM6hjZy
        RbjjaCsWaCNWpzyjI+dKzHPJTj/jLo2v0pgk6WtbfA==
X-Google-Smtp-Source: ABdhPJxQHaMSKm85jH4aaTyYNQX+I1NowVzG0JC4DPnEzaYLeyQdcJD1CETdfTGF6FMkyLWgsZGLv1GAPriR4BPFYKI=
X-Received: by 2002:a05:6512:3406:: with SMTP id i6mr24592500lfr.116.1642677503367;
 Thu, 20 Jan 2022 03:18:23 -0800 (PST)
MIME-Version: 1.0
References: <20220120074232.1084967-1-jens.wiklander@linaro.org>
In-Reply-To: <20220120074232.1084967-1-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 20 Jan 2022 16:48:12 +0530
Message-ID: <CAFA6WYO=9Rw7R+QEgunjtdM=63L1AzYxx26452=+uj7SuPiE7Q@mail.gmail.com>
Subject: Re: [PATCH v2] optee: add error checks in optee_ffa_do_call_with_arg()
To:     Jens Wiklander <jens.wiklander@linaro.org>
Cc:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        David Laight <David.Laight@aculab.com>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 20 Jan 2022 at 13:12, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Adds error checking in optee_ffa_do_call_with_arg() for correctness.
>
> Fixes: 4615e5a34b95 ("optee: add FF-A support")
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/tee/optee/ffa_abi.c | 15 ++++++++++++---
>  1 file changed, 12 insertions(+), 3 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index 20a1b1a3d965..0775759a29c0 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -619,9 +619,18 @@ static int optee_ffa_do_call_with_arg(struct tee_context *ctx,
>                 .data2 = (u32)(shm->sec_world_id >> 32),
>                 .data3 = shm->offset,
>         };
> -       struct optee_msg_arg *arg = tee_shm_get_va(shm, 0);
> -       unsigned int rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> -       struct optee_msg_arg *rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
> +       struct optee_msg_arg *arg;
> +       unsigned int rpc_arg_offs;
> +       struct optee_msg_arg *rpc_arg;
> +
> +       arg = tee_shm_get_va(shm, 0);
> +       if (IS_ERR(arg))
> +               return PTR_ERR(arg);
> +
> +       rpc_arg_offs = OPTEE_MSG_GET_ARG_SIZE(arg->num_params);
> +       rpc_arg = tee_shm_get_va(shm, rpc_arg_offs);
> +       if (IS_ERR(rpc_arg))
> +               return PTR_ERR(rpc_arg);
>
>         return optee_ffa_yielding_call(ctx, &data, rpc_arg);
>  }
> --
> 2.31.1
>
