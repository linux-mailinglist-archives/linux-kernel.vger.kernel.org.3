Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A24064AF3D1
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:12:49 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234631AbiBIOMR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:12:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49630 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231739AbiBIOMO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:12:14 -0500
Received: from mail-pl1-x631.google.com (mail-pl1-x631.google.com [IPv6:2607:f8b0:4864:20::631])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A6B3C06157B
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:12:17 -0800 (PST)
Received: by mail-pl1-x631.google.com with SMTP id w1so2301975plb.6
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 06:12:17 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Qg8T1crwzUwuFecEvHnR132IlE6aqW2e+kw1sG1Oxd4=;
        b=iq4cTiOkmGir8nW9HfLUcvRBOzlEzmBDh7xwYkfwXJqRM1Ai/BnroS5ouQZmKixf1O
         Boa6gdlp8Km6hf2YgzJAYlo4d4C1jaI5BSF+3kpfB64k95xbRm3f9JJJOVW335ZJU8CN
         BC/FmOgXSliNaZU7ohank8g2zBIAP8vN3Xk3y7MhwqEqOJD/VCDWug9JaKupWI0sRPrx
         XaCLpSyZvYbIB/uSEed5C3SQAQaeDl9ji5Se3ImRoRfw+l3LAQETX8976WNuW3CMMb4N
         GRV9qX/QpV8tI1zyn8U5mSyZp9U+RyY+UbomMXqDRzzszKG1AwVAv1GdLDsQtN4kQE9F
         ti2A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Qg8T1crwzUwuFecEvHnR132IlE6aqW2e+kw1sG1Oxd4=;
        b=pq7BpT0DbRuACorspOYtlli+Zf+ZT7A575jYkJS8aIVcLkr3TU5dorWcBJrq5Pxwwi
         eJUNcHLv4oCrMQiomeBnXGLXZGB7Qu2TayMHzvywytIZ8OB9bwQIyJDN2CaXxRNu8cRS
         0npy51oAHeCnEya38F9UJ/dscrxU10f+wosh4ADLbD5GsJq1xjUbkfhr96lRd1ywxxSF
         VLro3JaCnpnH42U5kNDiwX6NCHi4Qgl3ASpCx9PPFKEIBw2Si1Qh2bIBqxS79GxFD1BS
         fd6phF4AGD7AJyhGwK5AzHKX+ORZLHaX2Xbnxn5SlGWLt9t23fdWbp7/O+bMFdMZpzkI
         3vUg==
X-Gm-Message-State: AOAM532uLdsBgk3K5ZojzWifLG1MrrMMWA77PfOX14GJL+8PW1MFaw/d
        d98OTmIxDvOMTqD0slWA7kOFOYrQ3f0oISBVoDcuz4RRRJk=
X-Google-Smtp-Source: ABdhPJz3yig9RLBIJUks89Ne8S8578e5JtD52ZEeugRMTuwjzBHfw4T5Aj+XunP2pnxZ1etS9DkqumwOHOu97PipcwE=
X-Received: by 2002:a17:90b:3882:: with SMTP id mu2mr2799418pjb.150.1644415936651;
 Wed, 09 Feb 2022 06:12:16 -0800 (PST)
MIME-Version: 1.0
References: <20220204093359.359059-1-jens.wiklander@linaro.org> <20220204093359.359059-2-jens.wiklander@linaro.org>
In-Reply-To: <20220204093359.359059-2-jens.wiklander@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 9 Feb 2022 15:12:05 +0100
Message-ID: <CAHUa44F8JVw1vab_BBPx7iXMevYRAtMtpYQpa+PDQosV9_y7zA@mail.gmail.com>
Subject: Re: [PATCH v4 01/10] hwrng: optee-rng: use tee_shm_alloc_kernel_buf()
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Devaraj Rangasamy <Devaraj.Rangasamy@amd.com>,
        Rijo Thomas <Rijo-john.Thomas@amd.com>,
        David Howells <dhowells@redhat.com>,
        Tyler Hicks <tyhicks@linux.microsoft.com>
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

Hi Herbert,

On Fri, Feb 4, 2022 at 10:34 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Uses the new simplified tee_shm_alloc_kernel_buf() function instead of
> the old deprecated tee_shm_alloc() function which required specific
> TEE_SHM-flags.
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  drivers/char/hw_random/optee-rng.c | 6 +++---
>  1 file changed, 3 insertions(+), 3 deletions(-)

Since this patch depends on other patches in this patch set and vice
versa is it OK if I take this patch via my tree? I'm aiming for v5.18
with this.

Thanks,
Jens

>
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
