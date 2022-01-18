Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 165C1492580
	for <lists+linux-kernel@lfdr.de>; Tue, 18 Jan 2022 13:12:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241466AbiARMMb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 18 Jan 2022 07:12:31 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53228 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231645AbiARMMa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 18 Jan 2022 07:12:30 -0500
Received: from mail-lf1-x135.google.com (mail-lf1-x135.google.com [IPv6:2a00:1450:4864:20::135])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F513C061574
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 04:12:29 -0800 (PST)
Received: by mail-lf1-x135.google.com with SMTP id o12so53072165lfu.12
        for <linux-kernel@vger.kernel.org>; Tue, 18 Jan 2022 04:12:29 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=O0nO+p0mq+fNTi0hni+PrFNutDwLefWblmd/crLHIYA=;
        b=c5MkvKz3tw6WehTzvGkTSapgdZqH37RI/Ggpn3ABaoOMcuSIKaXpptGFqfyvQPJzAX
         Lbqiz9O1eOY34Sp7HHSF7x04xM1AZhWcDLB5PYfxxrbCzrfJmBcjrWxf1xRF4lcuTkAZ
         +iocIoGaLzSm39rt3hniekTUmsSfcEYd76fNHV7Pfm6yloVq9e2dizU+218JMPjziWjY
         yXE9cGw7Qzs7XrqWNXLZKcyND1KoA5WzKJjB5nIs6PUecZX7LJwKjf9vN0zxbfhN1J2C
         AYc9wOFvLsSdcbBhEadamDZNWM2TsmkC6iGJovLIiz44dg7pqTnLCCYsp2ZuMABRWG3P
         H3pg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=O0nO+p0mq+fNTi0hni+PrFNutDwLefWblmd/crLHIYA=;
        b=V7d6cNylALmt2WOZbzC+jfaTdHwDVwg67noNggHBWEA5tjdm+FZCEvnojQ1GY4OreV
         fIgDcoMDm1X1H2guqXVx7XpYDIbeL3QjcA4hPTVGojV8rho7Di9apR90WvInYC5vwi6c
         dz8eQIpzef7Z8etYtUY211kY2MmRQk+4dZ7Oypg8p84GU/xICyOdkY04KF8wk1zS3f49
         63tNxFv23Fnb8g8NkgtxCSSUVV4Jh1mWIc5OrwJ8AbirXNStldbPGU41N1gGLJHMStz6
         ryqpHG3088Z/Bf+x7tiRNTGQmWfIKyylp3FcQoUJgyILqivW6SzvwVCqnny3Lh3f3wl7
         +7Ow==
X-Gm-Message-State: AOAM530cRQ8vBQAm4xVXcKCUDSOv/z/rlsk4fzwni7VasLyM4A7Xe7p6
        C8zg2extEhcl773buZdveT+qGrn0N/ufukikgFOrGw==
X-Google-Smtp-Source: ABdhPJwNkDZ0ELEXfXMdLuXClxR/z96DJExiguJEonSNk178iRMlQYAf8DHl3quU8Wz5IuMrUT4C0SP8P7DNrqLwtkM=
X-Received: by 2002:ac2:4d59:: with SMTP id 25mr20046985lfp.327.1642507947618;
 Tue, 18 Jan 2022 04:12:27 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org> <20220114150824.3578829-2-jens.wiklander@linaro.org>
In-Reply-To: <20220114150824.3578829-2-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Tue, 18 Jan 2022 17:42:16 +0530
Message-ID: <CAFA6WYOrzbs-AYoMUGv5s_5k0cq0rqb7MVjr8szkB4mYakyJGg@mail.gmail.com>
Subject: Re: [PATCH v2 01/12] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
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

On Fri, 14 Jan 2022 at 20:38, Jens Wiklander <jens.wiklander@linaro.org> wrote:
>
> Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> the old deprecated tee_shm_alloc() function which required specific
> TEE_SHM-flags.
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/char/hw_random/optee-rng.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/drivers/char/hw_random/optee-rng.c b/drivers/char/hw_random/optee-rng.c
> index 135a82590923..a948c0727b2b 100644
> --- a/drivers/char/hw_random/optee-rng.c
> +++ b/drivers/char/hw_random/optee-rng.c
> @@ -145,10 +145,10 @@ static int optee_rng_init(struct hwrng *rng)
>         struct optee_rng_private *pvt_data = to_optee_rng_private(rng);
>         struct tee_shm *entropy_shm_pool = NULL;
>
> -       entropy_shm_pool = tee_shm_alloc(pvt_data->ctx, MAX_ENTROPY_REQ_SZ,
> -                                        TEE_SHM_MAPPED | TEE_SHM_DMA_BUF);
> +       entropy_shm_pool = tee_shm_alloc_kernel_buf(pvt_data->ctx,
> +                                                   MAX_ENTROPY_REQ_SZ);
>         if (IS_ERR(entropy_shm_pool)) {
> -               dev_err(pvt_data->dev, "tee_shm_alloc failed\n");
> +               dev_err(pvt_data->dev, "tee_shm_alloc_kernel_buf failed\n");
>                 return PTR_ERR(entropy_shm_pool);
>         }
>
> --
> 2.31.1
>
