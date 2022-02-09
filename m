Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4F2404AF3B2
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 15:09:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234783AbiBIOI7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 09:08:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232625AbiBIOI4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 09:08:56 -0500
Received: from mail-pj1-x102d.google.com (mail-pj1-x102d.google.com [IPv6:2607:f8b0:4864:20::102d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DFE5AC0613C9
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 06:08:59 -0800 (PST)
Received: by mail-pj1-x102d.google.com with SMTP id a11-20020a17090a740b00b001b8b506c42fso5291330pjg.0
        for <linux-kernel@vger.kernel.org>; Wed, 09 Feb 2022 06:08:59 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=4GSA+MzKjvqPDhg4I9J/SlptsUClj2HqyJ6LbJyLVRw=;
        b=mQk7ituQamI7be7xkOztPf6yto+sOJQsoCO0cC9twSGfwdexyPIzNLL+0euyFTVtnd
         /uyf8L0tExlUpzCRNkxDRG0ZPksNXVW07jejtlIHImbILg2XXpCVVcpXnmejMqVhKBFx
         eBr2Fg1tWUD1hrEFWFfIbYontlHxsFVBA9R6Y7/DhN12WkqNdENOsr+S/a5Kw/to1GRg
         t5uSnqkrydRufZE7KqQPDHFQydFvyMn7luw0qQdAx0YJ1XYU/QoUQoQkNtoStldbApEK
         tAk7DFLUAsxCZJq3rYq0JNp/ddGfqzGpFkTtvGsf3X81sMVL23178BpXfjuxyhdKPIvA
         sVfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=4GSA+MzKjvqPDhg4I9J/SlptsUClj2HqyJ6LbJyLVRw=;
        b=pEUGfWigeOGbYO9IEgjaPOs8RL6Eny0RCsy+y6/pZW+uVgEDzipPsvuRZYZnpefF6y
         xiUti7gxyNcjrZPiOpn+/Cc0pirJ646kZL+8p/3/hXyc3zFmhhjAqGCgBizsNSdwqVyH
         75gDb2eQ1Bvq+DUJEk4N2LY2dF7AufKNrfnR9CX7WT1CgubToKhtQiVamc5O0oQzUnXO
         D5sRRnz3wBKtnGV2TLXDNOfnWDtXpUuq+7xDQvL74MH8PgGltC4XYZgzwq2FH2qnPXXR
         RcwDoN8BnxYe+2nxg6XGavGrc7jVuI8ZMhULPlIU++1838BDt0aQLkjIui+mV3Toi0U2
         uIzA==
X-Gm-Message-State: AOAM531S5cTyNl+b6BdzklQsMPAs2jAtyJZNMj6/49qBUjBmTzo4brAN
        pw/l3ioFDwWNzzc8TBM41OHQsBpZH3YQiiLim1D7W3rqpZA=
X-Google-Smtp-Source: ABdhPJxwLukxDMwzR5g+uTLxH+x3XJwpanYZrXEh2OiNzPr2/JKq3KMK2jK5d4B4C1lVShqG6mh+QnMKxRe5+uUDfrI=
X-Received: by 2002:a17:90b:1e50:: with SMTP id pi16mr3659910pjb.16.1644415739061;
 Wed, 09 Feb 2022 06:08:59 -0800 (PST)
MIME-Version: 1.0
References: <20220204093359.359059-1-jens.wiklander@linaro.org> <20220204093359.359059-9-jens.wiklander@linaro.org>
In-Reply-To: <20220204093359.359059-9-jens.wiklander@linaro.org>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Wed, 9 Feb 2022 15:08:48 +0100
Message-ID: <CAHUa44HkQtstCyUt_J962rzysFnOJOP+e3T2gL7nV+6V5hfa9A@mail.gmail.com>
Subject: Re: [PATCH v4 08/10] KEYS: trusted: tee: use tee_shm_register_kernel_buf()
To:     linux-kernel@vger.kernel.org, op-tee@lists.trustedfirmware.org,
        Jarkko Sakkinen <jarkko@kernel.org>
Cc:     Sumit Garg <sumit.garg@linaro.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
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

Hi Jarkko,

On Fri, Feb 4, 2022 at 10:34 AM Jens Wiklander
<jens.wiklander@linaro.org> wrote:
>
> Uses the new simplified tee_shm_register_kernel_buf() function instead
> of the old tee_shm_alloc() function which required specific
> TEE_SHM-flags
>
> Reviewed-by: Sumit Garg <sumit.garg@linaro.org>
> Signed-off-by: Jens Wiklander <jens.wiklander@linaro.org>
> ---
>  security/keys/trusted-keys/trusted_tee.c | 23 +++++++++--------------
>  1 file changed, 9 insertions(+), 14 deletions(-)

Since this patch depends on other patches in this patch set and vice
versa is it OK if I take this patch via my tree? I'm aiming for v5.18
with this.

Thanks,
Jens

>
>
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
