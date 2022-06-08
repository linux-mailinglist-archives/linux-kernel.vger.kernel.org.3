Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 23D9C5438AC
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 18:17:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245267AbiFHQQ5 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 12:16:57 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245245AbiFHQQ4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 12:16:56 -0400
Received: from mail-ej1-x630.google.com (mail-ej1-x630.google.com [IPv6:2a00:1450:4864:20::630])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20E6E3CA4F;
        Wed,  8 Jun 2022 09:16:55 -0700 (PDT)
Received: by mail-ej1-x630.google.com with SMTP id o7so9153349eja.1;
        Wed, 08 Jun 2022 09:16:55 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=RulrCroV+cJFfdecqwchHiiW/aMfDe+YTb7wp3z5Uvw=;
        b=ZG5ZRvUUiR5wvuU1XGn+fQLGxRbZbhvBllxNQQqjt3osLgM1EECsTAkuWanRrZ5+MY
         2HM0LtKxkyTSKeBOWaTNwLNkAJDGWnTIgzAfNLvEfk9N6diBW5jESUvzUZk9ohk4Xjqk
         1d6aozWmcT5Qj3Kv+OQp6+vbJRaoqGcv23GgRIuCbNKyT+jlgTq6q6HzhYF3x2FnhxeZ
         JtciVjOQ3FToH3zAGbRnlIYCAw03wVYG+BO1ZyVKjMS08K09CDzA4aZYhZd6PJiPsNHF
         aho20Pq4iqrXlJDvSDivHJXn+ZY+syzt1kSfi2u8rmryfwrR/hVULRMw81YOdUKrhSQo
         YnCQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=RulrCroV+cJFfdecqwchHiiW/aMfDe+YTb7wp3z5Uvw=;
        b=AnRCXT2Ay43W8dAwnPBadZjbp1hn/A1NKje2GKNWDQwq36D88+zz7XZ+YiI82mMfDp
         p2vlibxupL7AGb0tbfjf4+SgT7JP/QHt8yQxZenzfJd3X/zVMR+LXDfbXlPrgxdFIOsI
         ibqEgM5YpwCT8wfOZARr0pSLRn90bDYTVAB/5yrkVcDekf2FMG+3+W+gtE5yeBaTqX9q
         ZOp9j8r/3wZwVJfoO5Az4zT8o50vYXUM4HQ/eEzkA0iPjmlTG4UHqu27v+2UE4l7jaPV
         nn2TxEzMqpmicyPiAfV3uX9frcSdaRkSULMdrDTYqQX00dDRZaxDnhAfzD+ULvLvTAxU
         y0DQ==
X-Gm-Message-State: AOAM530OG5hzqjXwsa08pqoplczGNodcaHahiVpR71RTth/ULlEInlOZ
        B2+XWKWuH09Sojd+1rwB7pCrdRBABqFntvgaJEA=
X-Google-Smtp-Source: ABdhPJzC25VNWovNJxyxqoY+z+J343yMcTvxYwXOTWVpZYW2hxqNCcOD/G9PR2DhoS/NkUCbRh5rZ8JHiz3PV3h7bZw=
X-Received: by 2002:a17:906:149:b0:711:fca6:bc2f with SMTP id
 9-20020a170906014900b00711fca6bc2fmr2287384ejh.497.1654705013642; Wed, 08 Jun
 2022 09:16:53 -0700 (PDT)
MIME-Version: 1.0
References: <20220608113553.32083-1-shreeya.patel@collabora.com> <20220608113553.32083-3-shreeya.patel@collabora.com>
In-Reply-To: <20220608113553.32083-3-shreeya.patel@collabora.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Wed, 8 Jun 2022 18:16:17 +0200
Message-ID: <CAHp75VcpHO-_Dghdc0VFjT=us-95h1b03Jmg32odJuuJZRy8aA@mail.gmail.com>
Subject: Re: [PATCH v5 2/2] iio: light: Add support for ltrf216a sensor
To:     Shreeya Patel <shreeya.patel@collabora.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, Zhigang.Shi@liteon.com,
        krisman@collabora.com, linux-iio <linux-iio@vger.kernel.org>,
        devicetree <devicetree@vger.kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Collabora Kernel ML <kernel@collabora.com>,
        alvaro.soliverez@collabora.com, Dmitry Osipenko <digetx@gmail.com>
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

On Wed, Jun 8, 2022 at 1:37 PM Shreeya Patel
<shreeya.patel@collabora.com> wrote:
>
> From: Zhigang Shi <Zhigang.Shi@liteon.com>
>
> Add initial support for ltrf216a ambient light sensor.
>
> Datasheet: gitlab.steamos.cloud/shreeya/iio/-/blob/main/LTRF216A.pdf

https?

...

> +#define LTRF216A_ALS_READ_DATA_DELAY   20000

What units?

...

> +/* Window Factor is needed when device is under Window glass

the device

> + * with coated tinted ink. This is to compensate the light loss

for the?

> + * due to the lower transmission rate of the window glass.
> + */

/*
 * Multi-line comments should look
 * like this very example. Find the difference.
 */

...

> +static int ltrf216a_init(struct iio_dev *indio_dev)
> +{
> +       struct ltrf216a_data *data = iio_priv(indio_dev);
> +       int ret = 0;

Useless assignment.

> +
> +       /* enable sensor */
> +       ret |= FIELD_PREP(LTRF216A_ALS_ENABLE_MASK, 1);

This is bad code. Use another variable with distinguashable name.

> +       ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, ret);

Can this driver utilize regmap I2C?

> +       if (ret < 0)
> +               dev_err(&data->client->dev,
> +                       "Error writing to LTRF216A_MAIN_CTRL while enabling the sensor: %d\n", ret);
> +
> +       return ret;
> +}

...

> +static int ltrf216a_disable(struct iio_dev *indio_dev)
> +{
> +       struct ltrf216a_data *data = iio_priv(indio_dev);
> +       int ret = 0;

Useless assignment.

> +       ret = i2c_smbus_write_byte_data(data->client, LTRF216A_MAIN_CTRL, 0);
> +       if (ret < 0)

> +               dev_err(&data->client->dev,
> +                       "Error writing to LTRF216A_MAIN_CTRL while disabling the sensor: %d\n",
> +                       ret);

With a temporary variable for the device this may be located on one line.
Same for the similar cases.

> +       return ret;
> +}

...

> +#ifdef CONFIG_PM

Why? Can't it be hidden by using pm_sleep_ptr() or alike?

> +static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
> +{
> +       struct device *dev = &data->client->dev;
> +       int ret = 0, suspended;

Useless assignment. Please, go thru all your code and drop these
potentially dangerous assignments.

> +
> +       if (on) {
> +               suspended = pm_runtime_suspended(dev);
> +               ret = pm_runtime_get_sync(dev);
> +
> +               /* Allow one integration cycle before allowing a reading */
> +               if (suspended)
> +                       msleep(ltrf216a_int_time_reg[0][0]);
> +       } else {
> +               pm_runtime_mark_last_busy(dev);
> +               ret = pm_runtime_put_autosuspend(dev);
> +       }
> +
> +       return ret;
> +}
> +#else
> +static int ltrf216a_set_power_state(struct ltrf216a_data *data, bool on)
> +{
> +       return 0;
> +}
> +#endif
> +
> +int ltrf216a_check_for_data(struct i2c_client *client)
> +{
> +       int ret;
> +
> +       ret = i2c_smbus_read_byte_data(client, LTRF216A_MAIN_STATUS);
> +       if (ret < 0) {
> +               dev_err(&client->dev, "Failed to read LTRF216A_MAIN_STATUS register: %d\n", ret);

> +               return ret;

Dup.

> +       }
> +
> +       return ret;
> +}

...

> +#ifdef CONFIG_PM_SLEEP

Oh, please no.

> +#endif

...

> +static const struct dev_pm_ops ltrf216a_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(pm_runtime_force_suspend,
> +                               pm_runtime_force_resume)
> +       SET_RUNTIME_PM_OPS(ltrf216a_runtime_suspend,
> +                          ltrf216a_runtime_resume, NULL)
> +};

Use pm_sleep_ptr() and corresponding top-level macros.

-- 
With Best Regards,
Andy Shevchenko
