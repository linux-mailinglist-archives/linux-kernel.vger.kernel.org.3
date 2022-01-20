Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1AD7F494C77
	for <lists+linux-kernel@lfdr.de>; Thu, 20 Jan 2022 12:04:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230227AbiATLD5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 20 Jan 2022 06:03:57 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230194AbiATLDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 20 Jan 2022 06:03:51 -0500
Received: from mail-lf1-x131.google.com (mail-lf1-x131.google.com [IPv6:2a00:1450:4864:20::131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6EDBC061746
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:03:50 -0800 (PST)
Received: by mail-lf1-x131.google.com with SMTP id br17so20147377lfb.6
        for <linux-kernel@vger.kernel.org>; Thu, 20 Jan 2022 03:03:50 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=z6aDbLAg1egTdSqTVtk9By3PMXPmi+G/cYIh7ycaNEU=;
        b=ZR4UXB0LdG1gp6J/C7/ed/bFLl0mS8GpFId+rr1frgw9gy6a01+saH+zjFZ3JswdYN
         cn7wZ67ab7TepRZbfAh0bs0yHibDriSUy7GYgMpI3wV5nxaWlPtCm5BFppitH2oH7l0e
         tMv7HSBZsUcZVEA0V8MvrAkiGNSrpJn/r6ceAKbB7Q5OinLXYeUvcoXQCHSps1kWYtbv
         oQQnUivm38W1ERdUXy8VtkxiWkdWqg0lBweTZQt7z4TRBHWcYnTZjDaOc5JxwhNA057y
         jDRDhIygGPgRzlKYej3KAbbdjgBx7z76+RUepVpD9fapof6JmwmEYYh7/4BFRCvtUGFm
         ErRg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=z6aDbLAg1egTdSqTVtk9By3PMXPmi+G/cYIh7ycaNEU=;
        b=CU//MwOV7+oGfXYWMkPqozG00A9RPV6SRf1zq8yLa7iKjX99y7Ux+FQpawykMUP0i1
         CZpKsMc6WXSSfc7arSXwuleu6lryCXeGGsh3SplkSyarIhh9Ap1QXqdXiVQCMNz/qRXJ
         Jymq3sJbeUJ/WSplvrHO9RJD/EIkKni95bdjksuG88/4GSqYV72SY7fegE4dAgQzZZMn
         dNyroDTuz4GA0XnioB25vy9ofzTp6DLzTnH0zXwkXCUrmf/D4t0t26HDxLwgYZKAANbb
         rZ6FJ/y7ZwS2oDn9/gMHmhJFQD1GOeGeAj1JVUqkpQnynb52rTpNFvv0XaRfEjpcXxrt
         KpQw==
X-Gm-Message-State: AOAM5322EnfSv6wx4M7cqvmMwmrqDbv9oaacfFXHFK+aqLOH+2nrsZCk
        qnkoenhUeVYiHDyQ5UzK4rXV0dVLAv2DpFa1kD4DYw==
X-Google-Smtp-Source: ABdhPJw4iiHUKgkeetN7Qb4VwPWDC3q1GL64ry0MbJUtFan/OcdsCWYmj+BOI9oYH+udW7FB31yPTDPCVc3lZMIpT34=
X-Received: by 2002:a05:6512:34d3:: with SMTP id w19mr12534948lfr.253.1642676629157;
 Thu, 20 Jan 2022 03:03:49 -0800 (PST)
MIME-Version: 1.0
References: <20220114150824.3578829-1-jens.wiklander@linaro.org> <20220114150824.3578829-11-jens.wiklander@linaro.org>
In-Reply-To: <20220114150824.3578829-11-jens.wiklander@linaro.org>
From:   Sumit Garg <sumit.garg@linaro.org>
Date:   Thu, 20 Jan 2022 16:33:37 +0530
Message-ID: <CAFA6WYOhetqNbPdTtugOsOnwQECx6S_m0aF0V33CSC86GLuY9Q@mail.gmail.com>
Subject: Re: [PATCH v2 10/12] KEYS: trusted: tee: use tee_shm_register_kernel_buf()
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
> Uses the new simplified tee_shm_register_kernel_buf() function instead
> of the old tee_shm_alloc() function which required specific
> TEE_SHM-flags
>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)
>

Reviewed-by: Sumit Garg <sumit.garg@linaro.org>

-Sumit

> diff --git a/security/keys/trusted-keys/trusted_tee.c b/security/keys/trusted-keys/trusted_tee.c
> index 2ce66c199e1d..c8626686ee1b 100644
> --- a/security/keys/trusted-keys/trusted_tee.c
> +++ b/security/keys/trusted-keys/trusted_tee.c
> @@ -70,17 +70,15 @@ static int trusted_tee_seal(struct trusted_key_payload *p, char *datablob)
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
>
> -       reg_shm_in = tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
> -                                     p->key_len, TEE_SHM_DMA_BUF |
> -                                     TEE_SHM_KERNEL_MAPPED);
> +       reg_shm_in = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> +                                                p->key_len);
>         if (IS_ERR(reg_shm_in)) {
>                 dev_err(pvt_data.dev, "key shm register failed\n");
>                 return PTR_ERR(reg_shm_in);
>         }
>
> -       reg_shm_out = tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
> -                                      sizeof(p->blob), TEE_SHM_DMA_BUF |
> -                                      TEE_SHM_KERNEL_MAPPED);
> +       reg_shm_out = tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
> +                                                 sizeof(p->blob));
>         if (IS_ERR(reg_shm_out)) {
>                 dev_err(pvt_data.dev, "blob shm register failed\n");
>                 ret = PTR_ERR(reg_shm_out);
> @@ -131,17 +129,15 @@ static int trusted_tee_unseal(struct trusted_key_payload *p, char *datablob)
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
>
> -       reg_shm_in = tee_shm_register(pvt_data.ctx, (unsigned long)p->blob,
> -                                     p->blob_len, TEE_SHM_DMA_BUF |
> -                                     TEE_SHM_KERNEL_MAPPED);
> +       reg_shm_in = tee_shm_register_kernel_buf(pvt_data.ctx, p->blob,
> +                                                p->blob_len);
>         if (IS_ERR(reg_shm_in)) {
>                 dev_err(pvt_data.dev, "blob shm register failed\n");
>                 return PTR_ERR(reg_shm_in);
>         }
>
> -       reg_shm_out = tee_shm_register(pvt_data.ctx, (unsigned long)p->key,
> -                                      sizeof(p->key), TEE_SHM_DMA_BUF |
> -                                      TEE_SHM_KERNEL_MAPPED);
> +       reg_shm_out = tee_shm_register_kernel_buf(pvt_data.ctx, p->key,
> +                                                 sizeof(p->key));
>         if (IS_ERR(reg_shm_out)) {
>                 dev_err(pvt_data.dev, "key shm register failed\n");
>                 ret = PTR_ERR(reg_shm_out);
> @@ -192,8 +188,7 @@ static int trusted_tee_get_random(unsigned char *key, size_t key_len)
>         memset(&inv_arg, 0, sizeof(inv_arg));
>         memset(&param, 0, sizeof(param));
>
> -       reg_shm = tee_shm_register(pvt_data.ctx, (unsigned long)key, key_len,
> -                                  TEE_SHM_DMA_BUF | TEE_SHM_KERNEL_MAPPED);
> +       reg_shm = tee_shm_register_kernel_buf(pvt_data.ctx, key, key_len);
>         if (IS_ERR(reg_shm)) {
>                 dev_err(pvt_data.dev, "key shm register failed\n");
>                 return PTR_ERR(reg_shm);
> --
> 2.31.1
>
