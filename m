Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 971D35613E5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 10:00:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233631AbiF3H7p (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 30 Jun 2022 03:59:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233394AbiF3H7X (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 30 Jun 2022 03:59:23 -0400
Received: from mail-yb1-xb35.google.com (mail-yb1-xb35.google.com [IPv6:2607:f8b0:4864:20::b35])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEA1F41335;
        Thu, 30 Jun 2022 00:59:22 -0700 (PDT)
Received: by mail-yb1-xb35.google.com with SMTP id v38so21636882ybi.3;
        Thu, 30 Jun 2022 00:59:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=7MP5GHlDBz5qUBJM/rdPcagSQgWmgbugUAfn9X+EbPI=;
        b=MvlmhMdvCX0fOp6/DkwVMF5vlZ0JpaTaTV49Il5G1LWGds8RQvBCoBc8cNJHicn1Fw
         YO89CzXD79pwRqkGZxdopRhAPLk1V6gLgr+f6rYrXXCAV38/2BeUAUkmk3Q6F/LGFcm+
         5X+/YS5nw57yG4+tW6qFekvP62Ccq5Nvd7qHsiTdLEZgS6nOznAVD4LMgbYE12QDP3oY
         ZnXt2NopbzqYExnJ4GbFAQgBBnObf85yh1w7fFqdLDOhqeXs7jeG23WJdIPzdXvJ2bL1
         jggesymAkqmlfFWN+Kkj6BzZfCwQS+lI5pFKzkOEiUGZkgHwk0KuiSA1Im1WD4qjt1By
         eLfA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=7MP5GHlDBz5qUBJM/rdPcagSQgWmgbugUAfn9X+EbPI=;
        b=MK8SzpvPi6LY2gBqoeFzEPmotknFx5nJ5L5JFXiSo9uDQFEtl3wbFXfbPc0DU6TSHs
         aAhTjhXLMagZZ0+LN2F0sohMUEKodZDWAWxHLmw1XrY++i3vQkKN77fqfxvvYsGxD7W+
         9ZXe/ZJA0IpLpdrCKeouIWBVDqBOR0cCKISTrvCQ5rHRVGarsvMIPDm54dYoQNcJhqk2
         IxjkFUiynP9tfEBqI6j72gkPWOjeygfb90yizNIL4mZ+j2jNlopfek7OqWnJ9FbA7vYJ
         gmc1u3eq/q5icN9HNDF76LCY8q5AA7PkOyJ2JOXlGK0FKP7RCx/gI4R6YWaO/3iDMdKX
         Rl8A==
X-Gm-Message-State: AJIora9B70WPjcQ1jsHomWtXV3LCHoZDURwyzV+dct9fzohusq5yZ1Ts
        IMLd3L6c0cdkrd9+wxa3jsePnCwHlPhR24eb2BA=
X-Google-Smtp-Source: AGRyM1sAP6R80Xtpm32PldM6Znhs8CkaWqS6Pt4rrF++mtsTAQk1UqwTGr7FxwbV4MK5ygAuB+kSjKSIGST8/glMWt8=
X-Received: by 2002:a25:ca0a:0:b0:66b:4e6c:e094 with SMTP id
 a10-20020a25ca0a000000b0066b4e6ce094mr8543875ybg.296.1656575961813; Thu, 30
 Jun 2022 00:59:21 -0700 (PDT)
MIME-Version: 1.0
References: <20220629143046.213584-1-aidanmacdonald.0x0@gmail.com> <20220629143046.213584-10-aidanmacdonald.0x0@gmail.com>
In-Reply-To: <20220629143046.213584-10-aidanmacdonald.0x0@gmail.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Thu, 30 Jun 2022 09:58:39 +0200
Message-ID: <CAHp75VfHT_kNAySz2=i9+-reU=UOHuQ9cxTq_5+qUOmcMpQtrQ@mail.gmail.com>
Subject: Re: [PATCH v4 09/15] iio: adc: axp20x_adc: Replace adc_en2 flag with
 adc_en2_mask field
To:     Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
Cc:     Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Chen-Yu Tsai <wens@csie.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Sebastian Reichel <sre@kernel.org>,
        Lee Jones <lee.jones@linaro.org>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>, quic_gurus@quicinc.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>,
        Michael Walle <michael@walle.cc>,
        Randy Dunlap <rdunlap@infradead.org>,
        "open list:GPIO SUBSYSTEM" <linux-gpio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        Linux PM <linux-pm@vger.kernel.org>
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

On Wed, Jun 29, 2022 at 4:30 PM Aidan MacDonald
<aidanmacdonald.0x0@gmail.com> wrote:
>
> The adc_en2 flag is essentially specific to axp20x-compatible devices
> because it hardcodes register values. Replace it with a mask field
> so the register value can be specified in device match data.

Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Aidan MacDonald <aidanmacdonald.0x0@gmail.com>
> ---
>  drivers/iio/adc/axp20x_adc.c | 16 +++++++---------
>  1 file changed, 7 insertions(+), 9 deletions(-)
>
> diff --git a/drivers/iio/adc/axp20x_adc.c b/drivers/iio/adc/axp20x_adc.c
> index ab25e6e1ff65..75bda94dbce1 100644
> --- a/drivers/iio/adc/axp20x_adc.c
> +++ b/drivers/iio/adc/axp20x_adc.c
> @@ -623,9 +623,9 @@ struct axp_data {
>         int                             num_channels;
>         struct iio_chan_spec const      *channels;
>         unsigned long                   adc_en1_mask;
> +       unsigned long                   adc_en2_mask;
>         int                             (*adc_rate)(struct axp20x_adc_iio *info,
>                                                     int rate);
> -       bool                            adc_en2;
>         struct iio_map                  *maps;
>  };
>
> @@ -634,8 +634,8 @@ static const struct axp_data axp20x_data = {
>         .num_channels = ARRAY_SIZE(axp20x_adc_channels),
>         .channels = axp20x_adc_channels,
>         .adc_en1_mask = AXP20X_ADC_EN1_MASK,
> +       .adc_en2_mask = AXP20X_ADC_EN2_MASK,
>         .adc_rate = axp20x_adc_rate,
> -       .adc_en2 = true,
>         .maps = axp20x_maps,
>  };
>
> @@ -645,7 +645,6 @@ static const struct axp_data axp22x_data = {
>         .channels = axp22x_adc_channels,
>         .adc_en1_mask = AXP22X_ADC_EN1_MASK,
>         .adc_rate = axp22x_adc_rate,
> -       .adc_en2 = false,
>         .maps = axp22x_maps,
>  };
>
> @@ -655,7 +654,6 @@ static const struct axp_data axp813_data = {
>         .channels = axp813_adc_channels,
>         .adc_en1_mask = AXP22X_ADC_EN1_MASK,
>         .adc_rate = axp813_adc_rate,
> -       .adc_en2 = false,
>         .maps = axp22x_maps,
>  };
>
> @@ -713,10 +711,10 @@ static int axp20x_probe(struct platform_device *pdev)
>         /* Enable the ADCs on IP */
>         regmap_write(info->regmap, AXP20X_ADC_EN1, info->data->adc_en1_mask);
>
> -       if (info->data->adc_en2)
> -               /* Enable GPIO0/1 and internal temperature ADCs */
> +       if (info->data->adc_en2_mask)
>                 regmap_update_bits(info->regmap, AXP20X_ADC_EN2,
> -                                  AXP20X_ADC_EN2_MASK, AXP20X_ADC_EN2_MASK);
> +                                  info->data->adc_en2_mask,
> +                                  info->data->adc_en2_mask);
>
>         /* Configure ADCs rate */
>         info->data->adc_rate(info, 100);
> @@ -741,7 +739,7 @@ static int axp20x_probe(struct platform_device *pdev)
>  fail_map:
>         regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>
> -       if (info->data->adc_en2)
> +       if (info->data->adc_en2_mask)
>                 regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
>
>         return ret;
> @@ -757,7 +755,7 @@ static int axp20x_remove(struct platform_device *pdev)
>
>         regmap_write(info->regmap, AXP20X_ADC_EN1, 0);
>
> -       if (info->data->adc_en2)
> +       if (info->data->adc_en2_mask)
>                 regmap_write(info->regmap, AXP20X_ADC_EN2, 0);
>
>         return 0;
> --
> 2.35.1
>


-- 
With Best Regards,
Andy Shevchenko
