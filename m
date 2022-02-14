Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 12D064B4203
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 07:35:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240779AbiBNGfR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 01:35:17 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:43090 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232182AbiBNGfQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 01:35:16 -0500
Received: from mail-qt1-x833.google.com (mail-qt1-x833.google.com [IPv6:2607:f8b0:4864:20::833])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B6ED56752;
        Sun, 13 Feb 2022 22:35:07 -0800 (PST)
Received: by mail-qt1-x833.google.com with SMTP id l14so14635036qtp.7;
        Sun, 13 Feb 2022 22:35:07 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=pyb5tWJcRHnLtMA4aomMpy/PR66GTMIsvJog689hRGc=;
        b=kFGI58gk9L2wKQUEXFTQIbvdGcIcQo5SWS5Le+2Bz/yzMVC5mL9Te3zCOzUeI/andg
         R0jO0pc9xYLWZ+lp0vuQyxunwlel8M6GupgUxW/zH0nsL/hjLvSsyDDsuWkSwUzoEw8g
         QnHGQ55wKBkp1SdkzYlni7GuAzsLnTJWGNrSA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=pyb5tWJcRHnLtMA4aomMpy/PR66GTMIsvJog689hRGc=;
        b=qWM2lD0FiSyjenC+hFRgn4xxKENpSyQHJGMFMSWRf7BsY6bEj8h3Q/n+SiTWfZ+V7N
         NNZzKF9F+Ik4wJImsHErqmzobbqY/nSq5hEmK6bEAmmlr2CBnTM//p25xV/j4jEqKJT8
         6bnOr0wchajCTUmvQGq7kxBmhKy8R2GCLqEcQsKaPy1Bt2NbyU72OUbG3qRJzhT0Jaa/
         isWLGJLdw08Wx9880vDWqSQqf/OKq/BZMsxZIr81kyRfGZ6yf6edD2b80nPxVBtCBt2b
         j+xxArrwVST2Hv7NrlXf2DSwPLC5jaWVpfvSJx3vMiSGAJaMER+lm8ZWjgJKiZ858o66
         pSNQ==
X-Gm-Message-State: AOAM532TQON+3EZ4uAbeY50eiVwNcu9I7iBYbRn3hwvlTm9EIqNB+CEl
        B9wYqGcTYljSGlccPv+c/9nhvKRqx/gWRWRQJFk=
X-Google-Smtp-Source: ABdhPJy9s/aFAuJqTSusNQt/lR4CkUZcKtx0CGfkmUOzhA2dqTW3wBKR7IQwfNsd1r9E1dqpyJV0U7n8PscONOlIaho=
X-Received: by 2002:ac8:7e91:: with SMTP id w17mr8357451qtj.678.1644820506485;
 Sun, 13 Feb 2022 22:35:06 -0800 (PST)
MIME-Version: 1.0
References: <20220214032708.854-1-jammy_huang@aspeedtech.com>
In-Reply-To: <20220214032708.854-1-jammy_huang@aspeedtech.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Mon, 14 Feb 2022 06:34:54 +0000
Message-ID: <CACPK8XcLJuWitefi8LTAxDrhzAVe3b88haQYAJRLX5M=ceDg5g@mail.gmail.com>
Subject: Re: [PATCH] media: aspeed: Use of_device_get_match_data() helper
To:     Jammy Huang <jammy_huang@aspeedtech.com>
Cc:     Eddie James <eajames@linux.ibm.com>,
        Mauro Carvalho Chehab <mchehab@kernel.org>,
        Andrew Jeffery <andrew@aj.id.au>, linux-media@vger.kernel.org,
        OpenBMC Maillist <openbmc@lists.ozlabs.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        linux-aspeed <linux-aspeed@lists.ozlabs.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.5 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 14 Feb 2022 at 03:27, Jammy Huang <jammy_huang@aspeedtech.com> wrote:
>
> Use of_device_get_match_data() to simplify the code.
>
> Signed-off-by: Jammy Huang <jammy_huang@aspeedtech.com>
> ---
>  drivers/media/platform/aspeed-video.c | 8 ++------
>  1 file changed, 2 insertions(+), 6 deletions(-)
>
> diff --git a/drivers/media/platform/aspeed-video.c b/drivers/media/platform/aspeed-video.c
> index 3904ded2052a..d4acf84cda9b 100644
> --- a/drivers/media/platform/aspeed-video.c
> +++ b/drivers/media/platform/aspeed-video.c
> @@ -13,6 +13,7 @@
>  #include <linux/module.h>
>  #include <linux/mutex.h>
>  #include <linux/of.h>
> +#include <linux/of_device.h>
>  #include <linux/of_irq.h>
>  #include <linux/of_reserved_mem.h>
>  #include <linux/platform_device.h>
> @@ -2451,7 +2452,6 @@ MODULE_DEVICE_TABLE(of, aspeed_video_of_match);
>  static int aspeed_video_probe(struct platform_device *pdev)
>  {
>         const struct aspeed_video_config *config;
> -       const struct of_device_id *match;
>         struct aspeed_video *video;
>         int rc;
>
> @@ -2463,11 +2463,7 @@ static int aspeed_video_probe(struct platform_device *pdev)
>         if (IS_ERR(video->base))
>                 return PTR_ERR(video->base);
>
> -       match = of_match_node(aspeed_video_of_match, pdev->dev.of_node);
> -       if (!match)
> -               return -EINVAL;
> -
> -       config = match->data;
> +       config = of_device_get_match_data(&pdev->dev);

While normally this driver won't have probed without matching on some
data, it would be sensible to add a check for a null pointer here.

>         video->version = config->version;
>         video->jpeg_mode = config->jpeg_mode;
>         video->comp_size_read = config->comp_size_read;
> --
> 2.25.1
>
