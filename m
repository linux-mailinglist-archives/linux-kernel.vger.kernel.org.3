Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D8B7C4EBE34
	for <lists+linux-kernel@lfdr.de>; Wed, 30 Mar 2022 12:00:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245076AbiC3KCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238630AbiC3KC2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 06:02:28 -0400
Received: from mail-qt1-f177.google.com (mail-qt1-f177.google.com [209.85.160.177])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3CBFABAB9A;
        Wed, 30 Mar 2022 03:00:42 -0700 (PDT)
Received: by mail-qt1-f177.google.com with SMTP id 10so17584228qtz.11;
        Wed, 30 Mar 2022 03:00:42 -0700 (PDT)
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=hBxbmNoSIF+gD71y4kkXlaJNmYHsVeI/sGoRnpdFxrc=;
        b=Tw/T7hD/xqazoecxtGArtYWbJK0bKqlAqYOq07ZxlLFHGD7nZtcVh1A92GXdyxOL/o
         2IpfjjBu13ZQ5e+O8LnEhEeix1ay6ZAClDj3XICpdl80LEw732DN7IL9aO5KSAAZUrqt
         OUwcoV8r+fUysn0A1e0gqRr82rS+1FNkndEVcLb190Ym/kuWRhirxws4KR41CgHx33DD
         WhofpQg0wJIcyVOgTrhjX9iEqYE5itOaB+UgUPKNpm4nXPvDMucKuQ2cpz3WvrtDyY+y
         0m6DVpucN0urbVGfQGqvO1DHDIinFn70TAIq4xlkvjVqGDd1KgwxajUN+lbOZOJxbFSo
         iwYQ==
X-Gm-Message-State: AOAM532x4Yaxfwksyr4aW7JU6zGSqGwtByPhqZcjuRmSQROvtYQ0aSyW
        xBpU0f9WWVCxUSz+SNfaZyG8sXf4Y6tq3A==
X-Google-Smtp-Source: ABdhPJykkKwS1AM+4JmK68uzouh1cZZ4tz9/SBFM42vfU6NeX+KAeJ3On0LSR4dJOTi+UR47bCm3kA==
X-Received: by 2002:a05:622a:110:b0:2e1:f084:d855 with SMTP id u16-20020a05622a011000b002e1f084d855mr32019303qtw.198.1648634440904;
        Wed, 30 Mar 2022 03:00:40 -0700 (PDT)
Received: from mail-yw1-f172.google.com (mail-yw1-f172.google.com. [209.85.128.172])
        by smtp.gmail.com with ESMTPSA id a9-20020ac85b89000000b002e2072c9dedsm17938796qta.67.2022.03.30.03.00.38
        (version=TLS1_3 cipher=TLS_AES_128_GCM_SHA256 bits=128/128);
        Wed, 30 Mar 2022 03:00:39 -0700 (PDT)
Received: by mail-yw1-f172.google.com with SMTP id 00721157ae682-2e6ceb45174so172514517b3.8;
        Wed, 30 Mar 2022 03:00:38 -0700 (PDT)
X-Received: by 2002:a25:45:0:b0:633:96e2:2179 with SMTP id 66-20020a250045000000b0063396e22179mr32596280yba.393.1648634438344;
 Wed, 30 Mar 2022 03:00:38 -0700 (PDT)
MIME-Version: 1.0
References: <20220329152926.50958-1-andriy.shevchenko@linux.intel.com> <20220329152926.50958-8-andriy.shevchenko@linux.intel.com>
In-Reply-To: <20220329152926.50958-8-andriy.shevchenko@linux.intel.com>
From:   Geert Uytterhoeven <geert@linux-m68k.org>
Date:   Wed, 30 Mar 2022 12:00:27 +0200
X-Gmail-Original-Message-ID: <CAMuHMdWs+OuxV0cO=XGYvOOJ0Mctwu6fKV5HnkdRBXNKkLE3uQ@mail.gmail.com>
Message-ID: <CAMuHMdWs+OuxV0cO=XGYvOOJ0Mctwu6fKV5HnkdRBXNKkLE3uQ@mail.gmail.com>
Subject: Re: [PATCH v2 07/13] pinctrl: renesas: rza1: Switch to use
 for_each_gpiochip_node() helper
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     Qianggui Song <qianggui.song@amlogic.com>,
        Krzysztof Kozlowski <krzk@kernel.org>,
        Fabien Dessenne <fabien.dessenne@foss.st.com>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        Linux ARM <linux-arm-kernel@lists.infradead.org>,
        "open list:ARM/Amlogic Meson..." <linux-amlogic@lists.infradead.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        openbmc@lists.ozlabs.org,
        Linux-Renesas <linux-renesas-soc@vger.kernel.org>,
        linux-samsung-soc <linux-samsung-soc@vger.kernel.org>,
        linux-stm32@st-md-mailman.stormreply.com,
        Linus Walleij <linus.walleij@linaro.org>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Andrew Lunn <andrew@lunn.ch>,
        Gregory Clement <gregory.clement@bootlin.com>,
        Sebastian Hesselbarth <sebastian.hesselbarth@gmail.com>,
        Avi Fishman <avifishman70@gmail.com>,
        Tomer Maimon <tmaimon77@gmail.com>,
        Tali Perry <tali.perry1@gmail.com>,
        Patrick Venture <venture@google.com>,
        Nancy Yuen <yuenn@google.com>,
        Benjamin Fair <benjaminfair@google.com>,
        Geert Uytterhoeven <geert+renesas@glider.be>,
        Tomasz Figa <tomasz.figa@gmail.com>,
        Sylwester Nawrocki <s.nawrocki@samsung.com>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Maxime Coquelin <mcoquelin.stm32@gmail.com>,
        Alexandre Torgue <alexandre.torgue@foss.st.com>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Philipp Zabel <p.zabel@pengutronix.de>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.4 required=5.0 tests=BAYES_00,
        FREEMAIL_FORGED_FROMDOMAIN,FREEMAIL_FROM,HEADER_FROM_DIFFERENT_DOMAINS,
        RCVD_IN_DNSWL_NONE,RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=no autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Andy,

On Tue, Mar 29, 2022 at 5:29 PM Andy Shevchenko
<andriy.shevchenko@linux.intel.com> wrote:
> Switch the code to use for_each_gpiochip_node() helper.
>
> While at it, in order to avoid additional churn in the future,
> switch to fwnode APIs where it makes sense.
>
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>

Thanks for your patch!

> --- a/drivers/pinctrl/renesas/pinctrl-rza1.c
> +++ b/drivers/pinctrl/renesas/pinctrl-rza1.c

> @@ -1166,17 +1167,17 @@ static const struct pinmux_ops rza1_pinmux_ops = {
>   * @range: pin range to register to pinctrl core
>   */
>  static int rza1_parse_gpiochip(struct rza1_pinctrl *rza1_pctl,
> -                              struct device_node *np,
> +                              struct fwnode_handle *fwnode,
>                                struct gpio_chip *chip,
>                                struct pinctrl_gpio_range *range)
>  {
>         const char *list_name = "gpio-ranges";
> -       struct of_phandle_args of_args;
> +       struct fwnode_reference_args of_args;

fw_args?

>         unsigned int gpioport;
>         u32 pinctrl_base;
>         int ret;
>
> -       ret = of_parse_phandle_with_fixed_args(np, list_name, 3, 0, &of_args);
> +       ret = fwnode_property_get_reference_args(fwnode, list_name, NULL, 3, 0, &of_args);
>         if (ret) {
>                 dev_err(rza1_pctl->dev, "Unable to parse %s list property\n",
>                         list_name);
> @@ -1197,13 +1198,12 @@ static int rza1_parse_gpiochip(struct rza1_pinctrl *rza1_pctl,
>
>         *chip           = rza1_gpiochip_template;
>         chip->base      = -1;
> -       chip->label     = devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pOFn",
> -                                        np);
> +       chip->label     = devm_kasprintf(rza1_pctl->dev, GFP_KERNEL, "%pfw", fwnode);

This changes the label from e.g. "/soc/pinctrl@fcfe3000/gpio-11" to "gpio-11".

%pfwP?

>         if (!chip->label)
>                 return -ENOMEM;
>
>         chip->ngpio     = of_args.args[2];
> -       chip->of_node   = np;
> +       chip->fwnode    = fwnode;
>         chip->parent    = rza1_pctl->dev;
>
>         range->id       = gpioport;

With the above fixed:
Reviewed-by: Geert Uytterhoeven <geert+renesas@glider.be>
Tested-by: Geert Uytterhoeven <geert+renesas@glider.be>
Acked-by: Geert Uytterhoeven <geert+renesas@glider.be>

Gr{oetje,eeting}s,

                        Geert

--
Geert Uytterhoeven -- There's lots of Linux beyond ia32 -- geert@linux-m68k.org

In personal conversations with technical people, I call myself a hacker. But
when I'm talking to journalists I just say "programmer" or something like that.
                                -- Linus Torvalds
