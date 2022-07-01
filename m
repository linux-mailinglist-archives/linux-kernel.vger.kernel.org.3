Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48B68563054
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 11:38:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236058AbiGAJg5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 05:36:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56780 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231218AbiGAJgy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 05:36:54 -0400
Received: from mail-ej1-x633.google.com (mail-ej1-x633.google.com [IPv6:2a00:1450:4864:20::633])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 71E1374DC7
        for <linux-kernel@vger.kernel.org>; Fri,  1 Jul 2022 02:36:53 -0700 (PDT)
Received: by mail-ej1-x633.google.com with SMTP id sb34so2963506ejc.11
        for <linux-kernel@vger.kernel.org>; Fri, 01 Jul 2022 02:36:53 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=bgdev-pl.20210112.gappssmtp.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=HqN6gsZLn+7W2GK3DI99kLZinpSFsebxTIv53VNrtsU=;
        b=uDBz3d3kU2zdCx2lHgG5l7Tmm7TiRP7fNmRni+vyb0xyKi2uRe645kqaJ+4xN2BdcM
         r2ahZAYgMhnzAqJX3hI60LJo71NTb0A0i9iHQrLEuRjcPilWkT34uRmEDldzQkjK0OOA
         8XSy/OBHBWauzBLiN/ZnfceSpWSXTr0jAuDlwb1+o/F/w/HEMeWou2MCTn+R5OJYdG9w
         m/RkzbVkZ7IYTg4PqGfLsmHn7YF55KPRpYpXzvlYRxL/uODqCPDM9xXKXxNyEMohL00n
         0OElABHzxKkhqT4n9HbVrvkYe6H2YqhiUY9PlC4Pu4s9Tc5X5FFmMpW2DNQFLISgQoOs
         1aCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=HqN6gsZLn+7W2GK3DI99kLZinpSFsebxTIv53VNrtsU=;
        b=NagyCc8b6QRbi2LdCcTFvpXfpCEWfaXpyAAr3wSMo6O93nVVtDycziZoKOWe0ci6HK
         9jPveAunQIgz4Cj17/jmiDvBWI8HQtWPfE1DxlDaj6lam+kNj4MwC9+1V7F+OQtA2FRs
         qBFPToO5dv0NIejdi/u5LT4BnZia13fFC1dHahLvXJ2oKMGV4nPB4aN+qZ7IbbOgvjxA
         D39n7HFR/VUHSI4mMe7kBBQ0dDRFCxmm7ePmz0JFJfVf44S4O4NfBywnsVFbZ9RFobrS
         lo8w0GqqTT3Ki/f0co2OKduM8qdCqI3IMKj1LHjoGonx+98k7jA+JTqZEMmCE8A1MltR
         WXyw==
X-Gm-Message-State: AJIora8WrYthr4t6lvEZRFgly9Xw0iYZTpifbLUJTQrGw7fDBX7CisnJ
        URFyp6X//T2V/D7uNmX6WKrT2bx76yJ0ZGzw3n0uENv1kOg=
X-Google-Smtp-Source: AGRyM1uqVf4QruzDeZcUxRarw0cJSku6NKTwUkQ90gaAQi/CQvLKiUmIhfla5jhN908dDp6/Ah79bIZv0T5TX1xzen0=
X-Received: by 2002:a17:907:8a25:b0:726:c9f2:2f5e with SMTP id
 sc37-20020a1709078a2500b00726c9f22f5emr13106586ejc.286.1656668212022; Fri, 01
 Jul 2022 02:36:52 -0700 (PDT)
MIME-Version: 1.0
References: <20220628195913.36940-1-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220628195913.36940-1-andriy.shevchenko@linux.intel.com>
From:   Bartosz Golaszewski <brgl@bgdev.pl>
Date:   Fri, 1 Jul 2022 11:36:41 +0200
Message-ID: <CAMRc=McB4XXpGK4=PwNX8n60r-2yC=hbN2fPjQTZ1SUh8dd9yA@mail.gmail.com>
Subject: Re: [PATCH v1 1/2] gpio: adnp: use simple i2c probe function
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-gpio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Tue, Jun 28, 2022 at 9:59 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
>
> The i2c probe functions here don't use the id information provided in
> their second argument, so the single-parameter i2c probe function
> ("probe_new") can be used instead.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/gpio/gpio-adnp.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>
> diff --git a/drivers/gpio/gpio-adnp.c b/drivers/gpio/gpio-adnp.c
> index cc349d4e4973..075782831044 100644
> --- a/drivers/gpio/gpio-adnp.c
> +++ b/drivers/gpio/gpio-adnp.c
> @@ -485,8 +485,7 @@ static int adnp_gpio_setup(struct adnp *adnp, unsigned int num_gpios,
>         return 0;
>  }
>
> -static int adnp_i2c_probe(struct i2c_client *client,
> -                                   const struct i2c_device_id *id)
> +static int adnp_i2c_probe(struct i2c_client *client)
>  {
>         struct device_node *np = client->dev.of_node;
>         struct adnp *adnp;
> @@ -535,7 +534,7 @@ static struct i2c_driver adnp_i2c_driver = {
>                 .name = "gpio-adnp",
>                 .of_match_table = adnp_of_match,
>         },
> -       .probe = adnp_i2c_probe,
> +       .probe_new = adnp_i2c_probe,
>         .id_table = adnp_i2c_id,
>  };
>  module_i2c_driver(adnp_i2c_driver);
> --
> 2.35.1
>

Applied, thanks!

Bart
