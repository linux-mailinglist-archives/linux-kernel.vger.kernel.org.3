Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 817AF582806
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 15:55:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiG0NzN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 09:55:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56112 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233157AbiG0NzK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 09:55:10 -0400
Received: from mail-lf1-x12f.google.com (mail-lf1-x12f.google.com [IPv6:2a00:1450:4864:20::12f])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 715F4357DC
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:55:05 -0700 (PDT)
Received: by mail-lf1-x12f.google.com with SMTP id a23so24868604lfm.10
        for <linux-kernel@vger.kernel.org>; Wed, 27 Jul 2022 06:55:05 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=sdiNy+K85E6T6Q5Cx2+M4h0HkFCwZdyqW9o88JSTZPk=;
        b=ouwOadP/hMPQTv7thHahdc2e7AKPdNrRyZIzuSCyE6KR79AcLZ1PgpjXmT9MMsFFe+
         1zA+2ZTzeceEo5I43eLCqk2H6A2UNkkIWR1Ep1nEs2pSVxW15D9AJtlMxSubnfRudbeL
         oh3nDontOF+AHAGff/Yfw9dGU+wytr6YSTkhz8ZAqI2ceTI3z6o6Ti+NKFXZA9LtRIw3
         cOAFYT4cGMahOlgmJmmquCa03KI5Bu0PEFQ9bXriZjGWS3+bC84X2IYQAC4pJ30/IASp
         XiqU9TEEtOyhGcOEcVk+G36+de7briY0Ic0XEgACqvi9cyLvpPbAMwAG0U6qVJe8dzz4
         acjw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=sdiNy+K85E6T6Q5Cx2+M4h0HkFCwZdyqW9o88JSTZPk=;
        b=fVS1sSePZ46idbT5IdIgDQZhrkefOo7+OxPwojXIU9/kF2DsH5h/S+G3fOT4DZzJ1f
         y0grDTF4nHT5yFYzegmCrD0kZRKIR1JJ+YJY7A4zqGQyiz7PFeL94dOvRg1m3WJCpqko
         qfEiCeUx1Oa4lyQhyuoKjyu3PRDFpA3yVdYg4QsASZnqbHqeJPKoYQvuOSJ3n22EndGk
         JE7hpnp48rJ1bTpE4IiZCoZWzYGHJBftQ4WB4rE9WzZF+WoRWZXZeZkOQegZHLeja7Kd
         usvPtj/MFYjYgB4Nj8V9HkSarWQe3I5I8HXsRfHeXdvB7amA2BsxOxv20yIdIHJCfJ6h
         13nQ==
X-Gm-Message-State: AJIora9ceR5YW0T3nKTJoabbc42fT9/G5oif+RRIIfdCFHt5hLcYePvP
        K8DfwYCHWIqokzGKhpk1yVP6e5pOsD+NdfbvkTWRng==
X-Google-Smtp-Source: AGRyM1sNAQoXPZGQGR853MTNOGh+Bg6eDRkS0Wih4mISvpT8XTjJxWzxG6yZi37ackDpTTd4Ki6S1sp/2dZXQtCrhIQ=
X-Received: by 2002:a05:6512:1320:b0:488:8fcc:e196 with SMTP id
 x32-20020a056512132000b004888fcce196mr8068316lfu.602.1658930103636; Wed, 27
 Jul 2022 06:55:03 -0700 (PDT)
MIME-Version: 1.0
References: <20220727013349.3056826-1-saravanak@google.com>
In-Reply-To: <20220727013349.3056826-1-saravanak@google.com>
From:   Sam Protsenko <semen.protsenko@linaro.org>
Date:   Wed, 27 Jul 2022 16:54:52 +0300
Message-ID: <CAPLW+4kwcE3itHaJZUt23_EUdbb3emXbfrcAjXvhm10d53oFCg@mail.gmail.com>
Subject: Re: [PATCH v1] pinctrl: samsung: Finish initializing the gpios before
 registering them
To:     Saravana Kannan <saravanak@google.com>
Cc:     Tomasz Figa <tomasz.figa@gmail.com>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Linus Walleij <linus.walleij@linaro.org>,
        kernel-team@android.com, linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed, 27 Jul 2022 at 04:33, Saravana Kannan <saravanak@google.com> wrote:
>
> As soon as a gpio is registered, it should be usable by a consumer. So,
> do all the initialization before registering the gpios. Without this
> change, a consumer can request a GPIO IRQ and have the gpio to IRQ
> mapping fail.
>
> Signed-off-by: Saravana Kannan <saravanak@google.com>
> ---

Reviewed-by: Sam Protsenko <semen.protsenko@linaro.org>

>  drivers/pinctrl/samsung/pinctrl-samsung.c | 8 ++++----
>  1 file changed, 4 insertions(+), 4 deletions(-)
>
> diff --git a/drivers/pinctrl/samsung/pinctrl-samsung.c b/drivers/pinctrl/samsung/pinctrl-samsung.c
> index 26d309d2516d..a302b38a63a8 100644
> --- a/drivers/pinctrl/samsung/pinctrl-samsung.c
> +++ b/drivers/pinctrl/samsung/pinctrl-samsung.c
> @@ -1168,15 +1168,15 @@ static int samsung_pinctrl_probe(struct platform_device *pdev)
>         if (ret)
>                 goto err_put_banks;
>
> -       ret = samsung_gpiolib_register(pdev, drvdata);
> -       if (ret)
> -               goto err_unregister;
> -
>         if (ctrl->eint_gpio_init)
>                 ctrl->eint_gpio_init(drvdata);
>         if (ctrl->eint_wkup_init)
>                 ctrl->eint_wkup_init(drvdata);
>
> +       ret = samsung_gpiolib_register(pdev, drvdata);
> +       if (ret)
> +               goto err_unregister;
> +
>         platform_set_drvdata(pdev, drvdata);
>
>         return 0;
> --
> 2.37.1.359.gd136c6c3e2-goog
>
