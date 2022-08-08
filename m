Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11F4158C93B
	for <lists+linux-kernel@lfdr.de>; Mon,  8 Aug 2022 15:17:33 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234573AbiHHNR3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 8 Aug 2022 09:17:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59146 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233946AbiHHNR0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 8 Aug 2022 09:17:26 -0400
Received: from mail-qt1-x82d.google.com (mail-qt1-x82d.google.com [IPv6:2607:f8b0:4864:20::82d])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9A0D226F6;
        Mon,  8 Aug 2022 06:17:25 -0700 (PDT)
Received: by mail-qt1-x82d.google.com with SMTP id a4so1677467qto.10;
        Mon, 08 Aug 2022 06:17:25 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=keJvvuxY+DljIPbAKycRkrQWZ9q+w8P5iUoKjKCUfF0=;
        b=cnMKJA0S3S2yDzpUf7DokNU7ZCZ7gyEVxUT+e7HqDS7SJT7jVgNTStSffi8wD4P1qc
         7M+cXD+Pl3Tf7YbsAWoisB6U4mr6gCWFe0/1QkJiaeCURjjB5a1yRF+fcF1aawh7Ii4y
         UrIdE/RE7Nw3kIDrl3mXth4pfktvC4AxyVkhlmRYuCqZHjJsNssD+IePpgUnmscgSvgA
         n1tF4QaTyHmKNVOeFSUYZ3+ggYmoevbm4hA30rXMqml9rKFIG2FAW7qwGUAp+cPG3TAq
         vOKacpKpusNsFKPN9xOWijuaSRrHYMExJDXxL4GXtPTq7FSoznDszx5eWLb6cJkt5BL3
         EnPA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=keJvvuxY+DljIPbAKycRkrQWZ9q+w8P5iUoKjKCUfF0=;
        b=t3KqwiXXkdBaVu8YmyxFmcGxJuno9GCWbsr0ZbowztlVAfTjbi2xiz/lTCSxnFa9BV
         FS6HjJR3t4hVqQsoTIPUaDYwGpFWGOa5g/JYlnumtwFEx+lTr4AdzXuxGiT8VdNCsyuL
         IiNXsuGmQrGr62OxaR46M4iHkAJwV5ZKhqy0kUpuNZQklPfr2uf1Mn0EETuNxhMWO5up
         s7hg8/TCgNUIguFi6W8rwgJlugpVBjX1TWHfJZdBmTH1h3yG0bN4xbUzgWyxa+PwVobv
         xuZZXd/WqLAO4NIZcV7HjGMqbMQzZ6OHo/767KfxP9Hvot3k60UeBqKTzsKtiAgtXajw
         gDkA==
X-Gm-Message-State: ACgBeo3G+dPHvhetNn/Ot2o2GT/8EoXxj5rQbTVLj/AJ0uBI0SQFDNoS
        7fjLO3bz+CrXgY9istY0luHvZ/p6qa5LLKTzUj8=
X-Google-Smtp-Source: AA6agR7hDpStlNRxIfMMDWA6POmSAO0pE5vIlu1j+57ugjjgAtS6AH53+W91AYdhfSgZRlBkRXZQuHxusy/dJYI0eCU=
X-Received: by 2002:ac8:7fd1:0:b0:31e:e9c0:c071 with SMTP id
 b17-20020ac87fd1000000b0031ee9c0c071mr16009872qtk.481.1659964644308; Mon, 08
 Aug 2022 06:17:24 -0700 (PDT)
MIME-Version: 1.0
References: <20220807104027.10808-1-paul@crapouillou.net>
In-Reply-To: <20220807104027.10808-1-paul@crapouillou.net>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Mon, 8 Aug 2022 15:16:48 +0200
Message-ID: <CAHp75VeafLqtdhasZ2mnk2sYv++a-HirHSePCcxteqPqBBy_uw@mail.gmail.com>
Subject: Re: [PATCH] leds: max8997: Don't error if there is no pdata
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Linux LED Subsystem <linux-leds@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, Aug 7, 2022 at 12:40 PM Paul Cercueil <paul@crapouillou.net> wrote:
>
> The driver will works just fine if no platform data was supplied.

s/works/work/
  ...or...
s/will//

With the above fix,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/leds/leds-max8997.c | 7 +------
>  1 file changed, 1 insertion(+), 6 deletions(-)
>
> diff --git a/drivers/leds/leds-max8997.c b/drivers/leds/leds-max8997.c
> index c0bddb33888d..c8d7f55c9dec 100644
> --- a/drivers/leds/leds-max8997.c
> +++ b/drivers/leds/leds-max8997.c
> @@ -238,11 +238,6 @@ static int max8997_led_probe(struct platform_device *pdev)
>         char name[20];
>         int ret = 0;
>
> -       if (pdata == NULL) {
> -               dev_err(&pdev->dev, "no platform data\n");
> -               return -ENODEV;
> -       }
> -
>         led = devm_kzalloc(&pdev->dev, sizeof(*led), GFP_KERNEL);
>         if (led == NULL)
>                 return -ENOMEM;
> @@ -258,7 +253,7 @@ static int max8997_led_probe(struct platform_device *pdev)
>         led->iodev = iodev;
>
>         /* initialize mode and brightness according to platform_data */
> -       if (pdata->led_pdata) {
> +       if (pdata && pdata->led_pdata) {
>                 u8 mode = 0, brightness = 0;
>
>                 mode = pdata->led_pdata->mode[led->id];

-- 
With Best Regards,
Andy Shevchenko
