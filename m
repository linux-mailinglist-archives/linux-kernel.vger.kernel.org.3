Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B306C533486
	for <lists+linux-kernel@lfdr.de>; Wed, 25 May 2022 03:01:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242932AbiEYBAh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 24 May 2022 21:00:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235637AbiEYBAe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 24 May 2022 21:00:34 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46A4D612BA;
        Tue, 24 May 2022 18:00:33 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id p5-20020a1c2905000000b003970dd5404dso2440969wmp.0;
        Tue, 24 May 2022 18:00:33 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=jms.id.au; s=google;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=v82a2cj+s7hBC3goU8nfxkf4sGScg9pyTS70ryF9fCI=;
        b=FKEupRn9pys1zDvgCll39WVcOGSZ10QbF389kgRV4yjgRiFaSvPs28+3+wrRcHYRlo
         RfEPenmU/3Rx94OywsjHx7DrA621+XPlKeU9xIlbcDPD9iHlZfWyDuJYFIWAm1Pz8hpD
         zeP47DEDg9KhD8CtEb74L246v2BuVPSnKhPrw=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=v82a2cj+s7hBC3goU8nfxkf4sGScg9pyTS70ryF9fCI=;
        b=gq3lMGiHZbBOPlKO8nCnS5j9JzXozH18zRXxy8z3Ee1UV2NLA/XKmLMrO1+ksKbJ4U
         UJiNrXfD0+pk6KY1wMEV2tFo9UnioK3w8ymQwLdchJFEa/ekbweG6HjCJvq6t8vuP0EB
         RubBuQ1q7VIaK6wcbbz7lMzWhnU3qAeNHkh8AykwdKGt5PE/1e5k1higlBIeAWrwHn/L
         R39Q49cxtePni+hkT1La7ESA7AQPEU+0xwPAjlLjLFfhidf0fEvuDHnMQzdmHrqgL0a6
         3AHESpVevkcI409y5Wya8zWCp77tT2X0zemIXGLumx0JOzvuhQeFN0DnwVaMhAIpp6HV
         /1Xw==
X-Gm-Message-State: AOAM530wnEs/vecMaJbZY/AJMApMcUPN+V+nHTQJ/0bBqAnpS9QI/2Ys
        pF8o3cao2v/d8T2rHgMVQN2/du/jAydlHJF3Ymk=
X-Google-Smtp-Source: ABdhPJxWRKI9k+mZ30K2P6PGnbERDvP8WQwwd71rw1E6hA+7aAJ1AYEQqBusIm+ro7tZVM5vKU746ealocg44miVe0E=
X-Received: by 2002:a05:600c:198f:b0:394:952d:9a72 with SMTP id
 t15-20020a05600c198f00b00394952d9a72mr5852732wmq.72.1653440431600; Tue, 24
 May 2022 18:00:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220524201729.39503-1-eajames@linux.ibm.com> <20220524201729.39503-2-eajames@linux.ibm.com>
In-Reply-To: <20220524201729.39503-2-eajames@linux.ibm.com>
From:   Joel Stanley <joel@jms.id.au>
Date:   Wed, 25 May 2022 01:00:19 +0000
Message-ID: <CACPK8XfMDuANSC-m85Uqmb2umFTd2wqbc8yvqJ+osru7Owbz9A@mail.gmail.com>
Subject: Re: [PATCH v3 1/2] iio: pressure: dps310: Refactor startup procedure
To:     Eddie James <eajames@linux.ibm.com>
Cc:     linux-iio@vger.kernel.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Jonathan Cameron <jic23@kernel.org>
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

On Tue, 24 May 2022 at 20:17, Eddie James <eajames@linux.ibm.com> wrote:
>
> Move the startup procedure into a function, and correct a missing
> check on the return code for writing the PRS_CFG register.
>
> Signed-off-by: Eddie James <eajames@linux.ibm.com>

Reviewed-by: Joel Stanley <joel@jms.id.au>

> ---
>  drivers/iio/pressure/dps310.c | 192 ++++++++++++++++++----------------
>  1 file changed, 103 insertions(+), 89 deletions(-)
>
> diff --git a/drivers/iio/pressure/dps310.c b/drivers/iio/pressure/dps310.c
> index 36fb7ae0d0a9..f79b274bb38d 100644
> --- a/drivers/iio/pressure/dps310.c
> +++ b/drivers/iio/pressure/dps310.c
> @@ -159,6 +159,106 @@ static int dps310_get_coefs(struct dps310_data *data)
>         return 0;
>  }
>
> +/*
> + * Some verions of chip will read temperatures in the ~60C range when
> + * its actually ~20C. This is the manufacturer recommended workaround
> + * to correct the issue. The registers used below are undocumented.
> + */
> +static int dps310_temp_workaround(struct dps310_data *data)
> +{
> +       int rc;
> +       int reg;
> +
> +       rc = regmap_read(data->regmap, 0x32, &reg);
> +       if (rc < 0)
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
> +       if (rc < 0)
> +               return rc;
> +
> +       rc = regmap_write(data->regmap, 0x0f, 0x96);
> +       if (rc < 0)
> +               return rc;
> +
> +       rc = regmap_write(data->regmap, 0x62, 0x02);
> +       if (rc < 0)
> +               return rc;
> +
> +       rc = regmap_write(data->regmap, 0x0e, 0x00);
> +       if (rc < 0)
> +               return rc;
> +
> +       return regmap_write(data->regmap, 0x0f, 0x00);
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
> +       if (rc < 0)
> +               return rc;
> +
> +       /*
> +        * Set up external (MEMS) temperature sensor in single sample, one
> +        * measurement per second mode
> +        */
> +       rc = regmap_write(data->regmap, DPS310_TMP_CFG, DPS310_TMP_EXT);
> +       if (rc < 0)
> +               return rc;
> +
> +       /* Temp and pressure shifts are disabled when PRC <= 8 */
> +       rc = regmap_write_bits(data->regmap, DPS310_CFG_REG,
> +                              DPS310_PRS_SHIFT_EN | DPS310_TMP_SHIFT_EN, 0);
> +       if (rc < 0)
> +               return rc;
> +
> +       /* MEAS_CFG doesn't update correctly unless first written with 0 */
> +       rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> +                              DPS310_MEAS_CTRL_BITS, 0);
> +       if (rc < 0)
> +               return rc;
> +
> +       /* Turn on temperature and pressure measurement in the background */
> +       rc = regmap_write_bits(data->regmap, DPS310_MEAS_CFG,
> +                              DPS310_MEAS_CTRL_BITS, DPS310_PRS_EN |
> +                              DPS310_TEMP_EN | DPS310_BACKGROUND);
> +       if (rc < 0)
> +               return rc;
> +
> +       /*
> +        * Calibration coefficients required for reporting temperature.
> +        * They are available 40ms after the device has started
> +        */
> +       rc = regmap_read_poll_timeout(data->regmap, DPS310_MEAS_CFG, ready,
> +                                     ready & DPS310_COEF_RDY, 10000, 40000);
> +       if (rc < 0)
> +               return rc;
> +
> +       rc = dps310_get_coefs(data);
> +       if (rc < 0)
> +               return rc;
> +
> +       rc = dps310_temp_workaround(data);
> +       if (rc < 0)
> +               return rc;
> +
> +       return 0;
> +}
> +
>  static int dps310_get_pres_precision(struct dps310_data *data)
>  {
>         int rc;
> @@ -677,52 +777,12 @@ static const struct iio_info dps310_info = {
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
> @@ -747,54 +807,8 @@ static int dps310_probe(struct i2c_client *client,
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
> 2.27.0
>
