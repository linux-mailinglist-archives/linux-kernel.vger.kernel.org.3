Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3FA405ABDFA
	for <lists+linux-kernel@lfdr.de>; Sat,  3 Sep 2022 11:27:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232553AbiICJ1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 3 Sep 2022 05:27:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49680 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229667AbiICJ1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 3 Sep 2022 05:27:12 -0400
Received: from mail-qk1-x732.google.com (mail-qk1-x732.google.com [IPv6:2607:f8b0:4864:20::732])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2D599ABD5B;
        Sat,  3 Sep 2022 02:27:11 -0700 (PDT)
Received: by mail-qk1-x732.google.com with SMTP id a10so3399784qkl.13;
        Sat, 03 Sep 2022 02:27:11 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=FMss4nvageHB6cqXPlGEFtiQOpQh9GnVLRZoHj1mbA8=;
        b=jtriAd1CLHhcG1iTDUlsp34s74uPtVr3bly1796PlHwrIik6+ac+pXJN6MKF2/RKzG
         37eoexXnTlKAvs1yare8K6DMDcOWMnVyoT0RrzAHD+nCqeCjSCArK1X8S/MZ/Yy0ItRy
         LIlv9suNc6YCTOe2r88yIWBXmY2VIOhogiYB+5ToIMohDWS6FveJkwHbOqrEGyLyAQGJ
         XqxjPreSBAlwPyaTFNbCqiQYzzFWot574rF71XAmpHtJXoucbqhKpWJKWA6tPsMGuyWb
         dXT5cCkKBFnbNUAzETGYiKJ3ogBkENPMngNnK6/rfeC0Id0HZ5V2+9MEKLhaiLoCq++l
         fJmw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=FMss4nvageHB6cqXPlGEFtiQOpQh9GnVLRZoHj1mbA8=;
        b=lhrHToA+dhpeWsUIPtPFn/PvdoBJxbpp5pWpviPLZWOLk0+dF9dKDhvMLE5yruOlti
         1AsY0ZTNVXJr1xnWl58OpNAGjR2sFvRnH93IM3CDIMo+Oo/gIhPURh0XXic2GWSiMT0w
         0gQexLelcCyg4HmODWsTVU89x51o/bGbOwvZNWlfArYs2DVqyLfYwm5hP9b7525HmNLE
         4pLbWuwmjgRG/9aP7eLwosXIdstwjj0zK00JBU5RJtxd4llPUvPTADKowP0hbBiiF0cT
         pg2yhAR8s26CJAtKfpUYp11dIKZDElIKPV/sfK+GSXdXv+1JN2uFyfr5oxhMJlI8HzYy
         kDAQ==
X-Gm-Message-State: ACgBeo0+0PnXphvL4wWxJtXIQRMQK2ehRp16Gdn+kt8CpuGK8F/gJEbr
        LcnqJF+IbuUq47g5mIbw3CB/k3TpijrtZ8rE0ZsB3EG270c=
X-Google-Smtp-Source: AA6agR4ea/vo9mWWNQFqdXnMV81u7jF5AoHAj26MN+aoZ6NOkdj/ds3sYW4lAEIlHWkn1f9wSLhMwZw9jtnavgYZFiY=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr26052121qko.383.1662197230214; Sat, 03
 Sep 2022 02:27:10 -0700 (PDT)
MIME-Version: 1.0
References: <20220903050252.2711950-1-o.rempel@pengutronix.de> <20220903050252.2711950-2-o.rempel@pengutronix.de>
In-Reply-To: <20220903050252.2711950-2-o.rempel@pengutronix.de>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 3 Sep 2022 12:26:32 +0300
Message-ID: <CAHp75Veyyd9XEom4ya0ZcKoxzbtJ4kKLCSUzwiLxzfnMkpMGXg@mail.gmail.com>
Subject: Re: [PATCH v5 2/3] iio: adc: tsc2046: add vref support
To:     Oleksij Rempel <o.rempel@pengutronix.de>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Sascha Hauer <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>
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

On Sat, Sep 3, 2022 at 8:03 AM Oleksij Rempel <o.rempel@pengutronix.de> wrote:
>
> If VREF pin is attached, we should use external VREF source instead of
> the internal. Otherwise we will get wrong measurements on some of the channel
> types.

FWIW,
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Oleksij Rempel <o.rempel@pengutronix.de>
> ---
> changes v5:
> - add "the" before channel
> - refactor error handling on regulator registration
> - use MILLI instead of 1000
> changes v4:
> - use vref_reg pointer instead of bool use_internal_vref
> - move regulator registration to a separate function
> - rework error handling
> - add devm_add_action_or_reset
> ---
>  drivers/iio/adc/ti-tsc2046.c | 57 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 55 insertions(+), 2 deletions(-)
>
> diff --git a/drivers/iio/adc/ti-tsc2046.c b/drivers/iio/adc/ti-tsc2046.c
> index 0d9436a69cbfb..c7601b29b3bef 100644
> --- a/drivers/iio/adc/ti-tsc2046.c
> +++ b/drivers/iio/adc/ti-tsc2046.c
> @@ -8,7 +8,9 @@
>  #include <linux/bitfield.h>
>  #include <linux/delay.h>
>  #include <linux/module.h>
> +#include <linux/regulator/consumer.h>
>  #include <linux/spi/spi.h>
> +#include <linux/units.h>
>
>  #include <asm/unaligned.h>
>
> @@ -175,6 +177,8 @@ struct tsc2046_adc_priv {
>         u32 time_per_bit_ns;
>
>         struct tsc2046_adc_ch_cfg ch_cfg[TI_TSC2046_MAX_CHAN];
> +       unsigned int vref_mv;
> +       struct regulator *vref_reg;

I would put pointer first since it will make sizeof(priv) 4 bytes less
on some architectures due to padding elimination.

>  };
>
>  #define TI_TSC2046_V_CHAN(index, bits, name)                   \
> @@ -252,7 +256,9 @@ static u8 tsc2046_adc_get_cmd(struct tsc2046_adc_priv *priv, int ch_idx,
>         case TI_TSC2046_ADDR_AUX:
>         case TI_TSC2046_ADDR_VBAT:
>         case TI_TSC2046_ADDR_TEMP0:
> -               pd |= TI_TSC2046_SER | TI_TSC2046_PD1_VREF_ON;
> +               pd |= TI_TSC2046_SER;
> +               if (!priv->vref_reg)
> +                       pd |= TI_TSC2046_PD1_VREF_ON;
>         }
>
>         return TI_TSC2046_START | FIELD_PREP(TI_TSC2046_ADDR, ch_idx) | pd;
> @@ -468,7 +474,7 @@ static int tsc2046_adc_read_raw(struct iio_dev *indio_dev,
>                  * So, it is better to use external voltage-divider driver
>                  * instead, which is calculating complete chain.
>                  */
> -               *val = TI_TSC2046_INT_VREF;
> +               *val = priv->vref_mv;
>                 *val2 = chan->scan_type.realbits;
>                 return IIO_VAL_FRACTIONAL_LOG2;
>         }
> @@ -740,6 +746,49 @@ static void tsc2046_adc_parse_fwnode(struct tsc2046_adc_priv *priv)
>         }
>  }
>
> +static void tsc2046_adc_regulator_disable(void *data)
> +{
> +       struct tsc2046_adc_priv *priv = data;
> +
> +       regulator_disable(priv->vref_reg);
> +}
> +
> +static int tsc2046_adc_configure_regulator(struct tsc2046_adc_priv *priv)
> +{
> +       struct device *dev = &priv->spi->dev;
> +       int ret;
> +
> +       priv->vref_reg = devm_regulator_get_optional(dev, "vref");
> +       if (IS_ERR(priv->vref_reg)) {
> +               /* If regulator exists but can't be get, return an error */
> +               if (PTR_ERR(priv->vref_reg) != -ENODEV)
> +                       return PTR_ERR(priv->vref_reg);
> +               priv->vref_reg = NULL;
> +       }
> +       if (!priv->vref_reg) {
> +               /* Use internal reference */
> +               priv->vref_mv = TI_TSC2046_INT_VREF;
> +               return 0;
> +       }
> +
> +       ret = regulator_enable(priv->vref_reg);
> +       if (ret)
> +               return ret;
> +
> +       ret = devm_add_action_or_reset(dev, tsc2046_adc_regulator_disable,
> +                                      priv);
> +       if (ret)
> +               return ret;
> +
> +       ret = regulator_get_voltage(priv->vref_reg);
> +       if (ret < 0)
> +               return ret;
> +
> +       priv->vref_mv = ret / MILLI;
> +
> +       return 0;
> +}
> +
>  static int tsc2046_adc_probe(struct spi_device *spi)
>  {
>         const struct tsc2046_adc_dcfg *dcfg;
> @@ -781,6 +830,10 @@ static int tsc2046_adc_probe(struct spi_device *spi)
>         indio_dev->num_channels = dcfg->num_channels;
>         indio_dev->info = &tsc2046_adc_info;
>
> +       ret = tsc2046_adc_configure_regulator(priv);
> +       if (ret)
> +               return ret;
> +
>         tsc2046_adc_parse_fwnode(priv);
>
>         ret = tsc2046_adc_setup_spi_msg(priv);
> --
> 2.30.2
>


-- 
With Best Regards,
Andy Shevchenko
