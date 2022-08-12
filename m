Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72D22591716
	for <lists+linux-kernel@lfdr.de>; Sat, 13 Aug 2022 00:04:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235500AbiHLWEf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 12 Aug 2022 18:04:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48578 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231698AbiHLWEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 12 Aug 2022 18:04:33 -0400
Received: from mail-qk1-x735.google.com (mail-qk1-x735.google.com [IPv6:2607:f8b0:4864:20::735])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C27A2B5150;
        Fri, 12 Aug 2022 15:04:31 -0700 (PDT)
Received: by mail-qk1-x735.google.com with SMTP id a15so1381832qko.4;
        Fri, 12 Aug 2022 15:04:31 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc;
        bh=AzIu4aA/+AqKkggas3Kqyvru1P34qBu2L3JhdqfLcx8=;
        b=PhF+gDMm+TCffCHQFFGVSeYt27NJu5EyoDUatrjS+kiB7VcIkyK9b6OWH/xm7ngJka
         wlDVMv3uXm7rjUDwxGCS7LigIkLLuUyH2iMFYt3h3hksFRAMFXyIk3/HJ45OuSZG25ZJ
         Hf7JXUK6p8IkBDVZCCJUCyoiB+DF6etM6/hbUs/rO2+5grbkYvyNP08xCYB0wO2lrV0h
         nWM+EJWzlKYyYHyjjRogphcd80zwu1pmJkFoE8rArWZqPvQkYkuwhrSiubf38xB+PUb4
         bUdKlHcrUYVWN+qIrfaME6Ei3OxnS61e3XSQIgo8mvaM2egxo0qXkVbGELayr5/2WAWt
         cE+A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc;
        bh=AzIu4aA/+AqKkggas3Kqyvru1P34qBu2L3JhdqfLcx8=;
        b=xc8Ggk9hjXQ5+TZlao9cXhWHEWCQ7HWdOq4Hc04QkzjxarQNAjaBc6XEyHGxjE1cYj
         uyTaIjsd55gJAmztqUiCEhYNXxdn64WbSw9vqvKPlWPcLFfSC3nSQsoyjLA+SILki8f9
         ZrdvxGaUFTj1eIbZZ8zuL3m7QaiBS3vd2TY5Rj9FRHFeIddmtUPSUzWojUuHZeArzgYB
         tSWk17ijFzNHlfDXxTVVLDJCQ24k4HCayCtG6csbEfanc16Gl1+lRBG4KX9vxJKQRLuZ
         dwMPehpM03b3Yx30UC/jpEeCk4DXNdO5gPOD6CLK/35uLRATN2BjS0efs7dZmQifHNtS
         Ykdw==
X-Gm-Message-State: ACgBeo2c9N++K93/uKSrSMlFIi23VYAXYRPKRIQegNlhfxRdr4of7wVb
        nEfTkubwGMFE1Touo2syMjHNIfMp2sW415VvfKJL0xZR
X-Google-Smtp-Source: AA6agR7+7JyxkRGLPnsSMbBpb5xvTqoCDc/NLEbKqYteyXw98yvmpIUBq3M94HfA/95cALZi6fnDJ+iEJTbL1JjZcXg=
X-Received: by 2002:ae9:e311:0:b0:6ba:e711:fb27 with SMTP id
 v17-20020ae9e311000000b006bae711fb27mr1548274qkf.320.1660341870794; Fri, 12
 Aug 2022 15:04:30 -0700 (PDT)
MIME-Version: 1.0
References: <20220809211246.251006-1-eajames@linux.ibm.com> <20220809211246.251006-2-eajames@linux.ibm.com>
In-Reply-To: <20220809211246.251006-2-eajames@linux.ibm.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Sat, 13 Aug 2022 01:03:54 +0300
Message-ID: <CAHp75Vf5wcabm_-oKGN2m7z=L2xu1D6wtzKLhu6n19Uhq8yijQ@mail.gmail.com>
Subject: Re: [PATCH v4 1/2] iio: pressure: dps310: Refactor startup procedure
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio <linux-iio@vger.kernel.org>,
        Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Joel Stanley <joel@jms.id.au>
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

On Wed, Aug 10, 2022 at 12:12 AM Eddie James <eajames@linux.ibm.com> wrote:
>
> Move the startup procedure into a function, and correct a missing
> check on the return code for writing the PRS_CFG register.

Code looks good, one remark below.
Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>

> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> Reviewed-by: Joel Stanley <joel@jms.id.au>
> ---
>  drivers/iio/pressure/dps310.c | 188 ++++++++++++++++++----------------
>  1 file changed, 99 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 36fb7ae0d0a9..c706a8b423b5 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -159,6 +159,102 @@ static int dps310_get_coefs(struct dps310_data *data)
>         return 0;
>  }
>
> +/*
> + * Some versions of the chip will read temperatures in the ~60C range when
> + * it's actually ~20C. This is the manufacturer recommended workaround
> + * to correct the issue. The registers used below are undocumented.
> + */
> +static int dps310_temp_workaround(struct dps310_data *data)
> +{
> +       int rc;
> +       int reg;
> +
> +       rc = regmap_read(data->regmap, 0x32, &reg);
> +       if (rc)
> +               return rc;
> +
> +       /*
> +        * If bit 1 is set then the device is okay, and the workaround does not
> +        * need to be applied
> +        */
> +       if (reg & BIT(1))
> +               return 0;
> +
> +       rc = regmap_write(data->regmap, 0x0e, 0xA5);
> +       if (rc)
> +               return rc;
> +
> +       rc = regmap_write(data->regmap, 0x0f, 0x96);
> +       if (rc)
> +               return rc;

This code already exists, but still want to ask, is it really
byte-registers here and not be16/le16 one? In such a case perhaps bulk
write can be used to reflect it better?

> +       rc = regmap_write(data->regmap, 0x62, 0x02);
> +       if (rc)
> +               return rc;
> +
> +       rc = regmap_write(data->regmap, 0x0e, 0x00);
> +       if (rc)
> +               return rc;
> +
> +       return regmap_write(data->regmap, 0x0f, 0x00);

Ditto.

> +}
> +
> +static int dps310_startup(struct dps310_data *data)
> +{
> +       int rc;
> +       int ready;
> +
> +       /*
> +        * Set up pressure sensor in single sample, one measurement per second
> +        * mode
> +        */
> +       rc = regmap_write(data->regmap, DPS310_PRS_CFG, 0);
> +       if (rc)
> +               return rc;
> +
> +       /*
> +        * Set up external (MEMS) temperature sensor in single sample, one
> +        * measurement per second mode
> +        */
> +       rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
> +       if (rc)
> +               return rc;
> +
> +       /* Temp and pressure shifts are disabled when PRC <= 8 */
> +       rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +                              DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
> +       if (rc)
> +               return rc;
> +
> +       /* MEAS_CFG doesn't update correctly unless first written with 0 */
> +       rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> +                              DPS310_MEAS_CTRL_BITS, 0);
> +       if (rc)
> +               return rc;
> +
> +       /* Turn on temperature and pressure measurement in the background */
> +       rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> +                              DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
> +                              DPS310_TEMP_EN | DPS310_BACKGROUND);
> +       if (rc)
> +               return rc;
> +
> +       /*
> +        * Calibration coefficients required for reporting temperature.
> +        * They are available 40ms after the device has started
> +        */
> +       rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> +                                     ready & DPS310_COEF_RDY, 10000, 40000);
> +       if (rc)
> +               return rc;
> +
> +       rc = dps310_get_coefs(data);
> +       if (rc)
> +               return rc;
> +
> +       return dps310_temp_workaround(data);
> +}
> +
>  static int dps310_get_pres_precision(struct dps310_data *data)
>  {
>         int rc;
> @@ -677,52 +773,12 @@ static const struct iio_info dps310_info = {
>         .write_raw = dps310_write_raw,
>  };
>
> -/*
> - * Some verions of chip will read temperatures in the ~60C range when
> - * its actually ~20C. This is the manufacturer recommended workaround
> - * to correct the issue. The registers used below are undocumented.
> - */
> -static int dps310_temp_workaround(struct dps310_data *data)
> -{
> -       int rc;
> -       int reg;
> -
> -       rc = regmap_read(data->regmap, 0x32, &reg);
> -       if (rc < 0)
> -               return rc;
> -
> -       /*
> -        * If bit 1 is set then the device is okay, and the workaround does not
> -        * need to be applied
> -        */
> -       if (reg & BIT(1))
> -               return 0;
> -
> -       rc = regmap_write(data->regmap, 0x0e, 0xA5);
> -       if (rc < 0)
> -               return rc;
> -
> -       rc = regmap_write(data->regmap, 0x0f, 0x96);
> -       if (rc < 0)
> -               return rc;
> -
> -       rc = regmap_write(data->regmap, 0x62, 0x02);
> -       if (rc < 0)
> -               return rc;
> -
> -       rc = regmap_write(data->regmap, 0x0e, 0x00);
> -       if (rc < 0)
> -               return rc;
> -
> -       return regmap_write(data->regmap, 0x0f, 0x00);
> -}
> -
>  static int dps310_probe(struct i2c_client *client,
>                         const struct i2c_device_id *id)
>  {
>         struct dps310_data *data;
>         struct iio_dev *iio;
> -       int rc, ready;
> +       int rc;
>
>         iio = devm_iio_device_alloc(&client->dev,  sizeof(*data));
>         if (!iio)
> @@ -747,54 +803,8 @@ static int dps310_probe(struct i2c_client *client,
>         if (rc)
>                 return rc;
>
> -       /*
> -        * Set up pressure sensor in single sample, one measurement per second
> -        * mode
> -        */
> -       rc = regmap_write(data->regmap, DPS310_PRS_CFG, 0);
> -
> -       /*
> -        * Set up external (MEMS) temperature sensor in single sample, one
> -        * measurement per second mode
> -        */
> -       rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
> -       if (rc < 0)
> -               return rc;
> -
> -       /* Temp and pressure shifts are disabled when PRC <= 8 */
> -       rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
> -                              DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
> -       if (rc < 0)
> -               return rc;
> -
> -       /* MEAS_CFG doesn't update correctly unless first written with 0 */
> -       rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> -                              DPS310_MEAS_CTRL_BITS, 0);
> -       if (rc < 0)
> -               return rc;
> -
> -       /* Turn on temperature and pressure measurement in the background */
> -       rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> -                              DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
> -                              DPS310_TEMP_EN | DPS310_BACKGROUND);
> -       if (rc < 0)
> -               return rc;
> -
> -       /*
> -        * Calibration coefficients required for reporting temperature.
> -        * They are available 40ms after the device has started
> -        */
> -       rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> -                                     ready & DPS310_COEF_RDY, 10000, 40000);
> -       if (rc < 0)
> -               return rc;
> -
> -       rc = dps310_get_coefs(data);
> -       if (rc < 0)
> -               return rc;
> -
> -       rc = dps310_temp_workaround(data);
> -       if (rc < 0)
> +       rc = dps310_startup(data);
> +       if (rc)
>                 return rc;
>
>         rc = devm_iio_device_register(&client->dev, iio);
> --
> 2.31.1
>


-- 
With Best Regards,
Andy Shevchenko
