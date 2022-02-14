Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF2D14B4F51
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 12:51:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352666AbiBNLuV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 06:50:21 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:50692 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351877AbiBNLuM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 06:50:12 -0500
Received: from mail-pf1-x42f.google.com (mail-pf1-x42f.google.com [IPv6:2607:f8b0:4864:20::42f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAE48C5B
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:48:16 -0800 (PST)
Received: by mail-pf1-x42f.google.com with SMTP id i6so26870283pfc.9
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 03:48:16 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=ACeEDhjbHou3oxxSi+z3/EFjDqtxOJyqeUY/TfA+geY=;
        b=maJJV4uuDmViELDnZ8rGFDbSt54X8jw9p/lpD+DvonMOEbQn4ISNEYpBPzV42bHC3R
         q/Ue1reO9qQhC7MLSbhEnrgprt/+Q5gnnjd6iiOnXD8ME/hGJ87Tzffnz8zdPUp3jfLH
         CF6DbvM7DWmhiqP23YjVssFf1+rLmzWGlb+iVC9iAFuXWhMQQXBnhdq9ZA1iKXIzQoAp
         o4GlgqcJP+lmjx4j5h0Fgav7G/E/ylF1Q+Uc7nMOX9VJsuChmtz79ERir3C44pD92uHO
         IqLmJypWwIBfaiIFCdHIbLfay2A/x2sKQcl8LOZOfjfDqk4BZWGbJmVqxw2Hce62iwpb
         rlWQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=ACeEDhjbHou3oxxSi+z3/EFjDqtxOJyqeUY/TfA+geY=;
        b=bny+n/Vi5e4tSff3Jkq4R++5RdcGkKqS5jRcUb7pNzlDEI3vfuzpmI0HGcljpxXlnK
         UGQTFy/DVB3gxLkH25kM1S3xrOegEE2MNWOcchkk9GLM9lBWfh4d1kilsrn9Zkr3+eOC
         +fgzXOJqE+evCxW8DZvVC6HiCs3JR39hkvqFkANn5U9eCtMjWmBK8miXvU7Hmjcy/kK4
         hNIjkpYD+pP+eteLjmlWi3VEoK/i/zlNhRFIELLO4lWgGrQVl775XbmEpJ2KbAgWPg4k
         Ux4+uTtwwbhJ290jcho2d6+AyGvATZjabRcG83j5MawDjumQV/zBwoBZ0/Pu88Epo9+2
         dowA==
X-Gm-Message-State: AOAM531PLfDNK2LkjZog8eeVMw3WgCNJT7jGhZk7ouplX35XYQJ/FDO7
        LT7HY0v6sfMKm9Sa7oWFNfBtJVZnP8rxsP0BnsPalw==
X-Google-Smtp-Source: ABdhPJzyht2sLOqKatKCERaOVqnbRYQqbqkfmAliRfq7yt5zPALxS4EABZfzEIoZB0kXepbCSRhVO9Xi7MZI3OAC6WQ=
X-Received: by 2002:a05:6a00:1682:: with SMTP id k2mr14191457pfc.69.1644839296340;
 Mon, 14 Feb 2022 03:48:16 -0800 (PST)
MIME-Version: 1.0
References: <20220210091053.2045809-1-yangyingliang@huawei.com>
In-Reply-To: <20220210091053.2045809-1-yangyingliang@huawei.com>
From:   Jens Wiklander <jens.wiklander@linaro.org>
Date:   Mon, 14 Feb 2022 12:48:05 +0100
Message-ID: <CAHUa44GPbzw_usSZcSqtZodaz6AKVbFGWjkDzJ3FiT5LMx8=KQ@mail.gmail.com>
Subject: Re: [PATCH -next] tee: optee: fix error return code in probe function
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

On Thu, Feb 10, 2022 at 10:00 AM Yang Yingliang
<yangyingliang@huawei.com> wrote:
>
> If teedev_open() fails, probe function need return
> error code.
>
> Fixes: aceeafefff73 ("optee: use driver internal tee_context for some rpc")
> Reported-by: Hulk Robot <hulkci@huawei.com>
> Signed-off-by: Yang Yingliang <yangyingliang@huawei.com>
> ---
>  drivers/tee/optee/ffa_abi.c | 4 +++-
>  drivers/tee/optee/smc_abi.c | 4 +++-
>  2 files changed, 6 insertions(+), 2 deletions(-)

Well spotted, I'm picking up this.

Thanks,
Jens

>
> diff --git a/drivers/tee/optee/ffa_abi.c b/drivers/tee/optee/ffa_abi.c
> index f2bf6c61197f..f744ab15bf2c 100644
> --- a/drivers/tee/optee/ffa_abi.c
> +++ b/drivers/tee/optee/ffa_abi.c
> @@ -869,8 +869,10 @@ static int optee_ffa_probe(struct ffa_device *ffa_dev)
>         optee_supp_init(&optee->supp);
>         ffa_dev_set_drvdata(ffa_dev, optee);
>         ctx = teedev_open(optee->teedev);
> -       if (IS_ERR(ctx))
> +       if (IS_ERR(ctx)) {
> +               rc = PTR_ERR(ctx);
>                 goto err_rhashtable_free;
> +       }
>         optee->ctx = ctx;
>         rc = optee_notif_init(optee, OPTEE_DEFAULT_MAX_NOTIF_VALUE);
>         if (rc)
> diff --git a/drivers/tee/optee/smc_abi.c b/drivers/tee/optee/smc_abi.c
> index 1a55339c7072..c517d310249f 100644
> --- a/drivers/tee/optee/smc_abi.c
> +++ b/drivers/tee/optee/smc_abi.c
> @@ -1417,8 +1417,10 @@ static int optee_probe(struct platform_device *pdev)
>
>         platform_set_drvdata(pdev, optee);
>         ctx = teedev_open(optee->teedev);
> -       if (IS_ERR(ctx))
> +       if (IS_ERR(ctx)) {
> +               rc = PTR_ERR(ctx);
>                 goto err_supp_uninit;
> +       }
>         optee->ctx = ctx;
>         rc = optee_notif_init(optee, max_notif_value);
>         if (rc)
> --
> 2.25.1
>
