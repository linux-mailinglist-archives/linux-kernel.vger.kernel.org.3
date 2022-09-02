Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 249255AB580
	for <lists+linux-kernel@lfdr.de>; Fri,  2 Sep 2022 17:41:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237312AbiIBPlY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 2 Sep 2022 11:41:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60560 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237057AbiIBPk6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 2 Sep 2022 11:40:58 -0400
Received: from mail-qk1-x729.google.com (mail-qk1-x729.google.com [IPv6:2607:f8b0:4864:20::729])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9432BBCAC;
        Fri,  2 Sep 2022 08:28:23 -0700 (PDT)
Received: by mail-qk1-x729.google.com with SMTP id f4so1967436qkl.7;
        Fri, 02 Sep 2022 08:28:23 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:from:to:cc:subject:date;
        bh=qcuKgKWohE6QzUcwgqFhX15U0Hek1FkeOTvh6SLmzzU=;
        b=f6s8V5mwfARQg1+0WkrvhfB3fpYRYAB0t+civVZBem+YlFAiN8GLBJYqmWSPx656Xf
         /ULlprHrvTEVtbocq9hzEkc2TqhDydxLGcAyrG7vFw+PdPGDwhQlTm2vtXxjurOcz04Z
         X8GqI+OR4WYC7GT6431vS/oj6f+EQaB6Eea2ieTJkf7fqLLMGlmS5puF9a9nFrCPjRUL
         cPdwnLJAPaqGsBnRoHnZ+30Arpipeqkmjy6gHAF2BIY8KbEdWSggpnVur2MI901qd09U
         LhjWQJY+VPja1SM0j3kAbNdbHyQZ13pS01dTXuNtGf0Sh4Ha2MTmUe4R8fVI3oMPI5e2
         mYQw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=cc:to:subject:message-id:date:from:in-reply-to:references
         :mime-version:x-gm-message-state:from:to:cc:subject:date;
        bh=qcuKgKWohE6QzUcwgqFhX15U0Hek1FkeOTvh6SLmzzU=;
        b=OOSLo2unzreF/S/4hwD9PANlXfS5LS2DMq+uzf4Aw+LTxgt4QMExGl2ZH7pIpj85Rc
         MmX572Je90upgPIK4/fgZcsjtvWRTK9lwS70Yvq2unG0KAcdBYC/hRlUFk/tR65CcxUi
         W6Xfu9GQi4Qiy9xHvl4djreUnfOp4COoYorhq5OUdKK3Q17Pop1Ut4MbO3CYnz+biAxY
         CbY1zkvGnmuyReUxhmATVXoB9ruFZaeRGVaezg3R/7+L08lZCvXVSoO6PhGfXf+WVhuK
         lCMp0+ZGBXkP3gZJmjL+0qK919IGQ0ISI73oqTudaR+fEOdOQqliPoqFJO1QzysSyioG
         sTsg==
X-Gm-Message-State: ACgBeo2A3yZLXCOrTAn6pVor8naTICGu8JaDqjHaosdMLkBOP5SBc33H
        szuDDl/Ku54a0v6W8Gm+CYnp+j0KggB0tabg/eI=
X-Google-Smtp-Source: AA6agR7xHP0lXpbu4U/j2zHQ1cmBA6TJvlMjAsfbFqAGBoFfORyZZKIQ7ex+LnSeY8Vgl7xHEc07uZCG8RdXkCPs+3c=
X-Received: by 2002:a05:620a:254d:b0:6ab:84b8:25eb with SMTP id
 s13-20020a05620a254d00b006ab84b825ebmr23655497qko.383.1662132502649; Fri, 02
 Sep 2022 08:28:22 -0700 (PDT)
MIME-Version: 1.0
References: <20220902131258.3316367-1-cmo@melexis.com>
In-Reply-To: <20220902131258.3316367-1-cmo@melexis.com>
From:   Andy Shevchenko <andy.shevchenko@gmail.com>
Date:   Fri, 2 Sep 2022 18:27:46 +0300
Message-ID: <CAHp75VdOHDHUVhVXj4L-6ZV25mTWTeO3s3EJQVgLxknXHKRUMg@mail.gmail.com>
Subject: Re: [PATCH 1/3] iio: temperature: mlx90632 Add runtime
 powermanagement modes
To:     Crt Mori <cmo@melexis.com>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        linux-iio <linux-iio@vger.kernel.org>,
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

On Fri, Sep 2, 2022 at 4:13 PM <cmo@melexis.com> wrote:
>
> From: Crt Mori <cmo@melexis.com>
>
> Sensor can operate in lower power modes and even make measurements when

The sensor
...or..
Sensors

> in those lower powered modes. The decision was taken that if measurement
> is not requested within 2 seconds the sensor will remain in SLEEP_STEP
> power mode, where measurements are triggered on request with setting the
> start of measurement bit (SOB). In this mode the measurements are taking
> a bit longer because we need to start it and complete it. Currently, in
> continuous mode we read ready data and this mode is activated if sensor
> measurement is requested within 2 seconds. The suspend timeout is
> increased to 6 seconds (instead of 3 before), because that enables more
> measurements in lower power mode (SLEEP_STEP), with the lowest refresh
> rate (2 seconds).

...

>  #define MLX90632_PWR_STATUS_CONTINUOUS MLX90632_PWR_STATUS(3) /* continuous*/
>
> +#define MLX90632_EE_RR(ee_val) (ee_val & GENMASK(10, 8)) /* Only Refresh Rate bits*/

Missed space. Seems like a copy'n'paste from previous comments that
lacks the space as well.

...

> +       unsigned long interraction_timestamp; /* in jiffies */

_ts for timestamp is a fine abbreviation. Also move comment to the kernel doc.

...

> +static int mlx90632_wakeup(struct mlx90632_data *data);

Can we avoid forward declaration? (I don't even see how it is used
among dozens of lines of below code in the patch)

>  static s32 mlx90632_pwr_set_sleep_step(struct regmap *regmap)
>  {

> +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(regmap_get_device(regmap)));

Why ping-ponging here and not using dev_get_drvdata()? Ditto for similar cases.

> +       struct mlx90632_data *data = iio_priv(indio_dev);
> +       s32 ret = 0;

Assignment is not needed, use 'return 0;' directly. Ditto for all
cases like this.

> +       if (data->powerstatus != MLX90632_PWR_STATUS_SLEEP_STEP) {
> +               ret = regmap_write_bits(regmap, MLX90632_REG_CONTROL,
> +                                       MLX90632_CFG_PWR_MASK,
> +                                       MLX90632_PWR_STATUS_SLEEP_STEP);
> +               if (ret < 0)
> +                       return ret;
> +
> +               data->powerstatus = MLX90632_PWR_STATUS_SLEEP_STEP;
> +       }
> +       return ret;
>  }

...

> +       reg = MLX90632_EE_RR(reg) >> 8;

This makes it harder to understand the semantics of reg, can we simply
unite this line with the below?

> +       return MLX90632_MEAS_MAX_TIME >> reg;

...

> +               refresh_time = refresh_time + ret;

+= ?

...

> +               refresh_time = refresh_time + ret;

+=

...

> +               refresh_time = refresh_time + ret;

Ditto.

...

> +       unsigned int reg_status;
>         int ret;

Keep the reversed xmas tree order (like here!) elsewhere for the sake
of consistency.

...

> +       ret = regmap_read_poll_timeout(data->regmap, MLX90632_REG_STATUS,
> +                                      reg_status,
> +                                      ((reg_status & MLX90632_STAT_BUSY) == 0),

Too many parentheses

> +                                      10000, 100 * 10000);
> +       if (ret < 0) {
> +               dev_err(&data->client->dev, "data not ready");
> +               return -ETIMEDOUT;
> +       }

...

> +       int current_powerstatus = data->powerstatus;

Please, split the assignment and move it closer to the first user.

...

> +       data->powerstatus = MLX90632_PWR_STATUS_HALT;
> +
> +       if (current_powerstatus == MLX90632_PWR_STATUS_SLEEP_STEP)
> +               return mlx90632_pwr_set_sleep_step(data->regmap);

> +       else

Redundant.

> +               return mlx90632_pwr_continuous(data->regmap);

...

> +               ret = read_poll_timeout(mlx90632_perform_measurement, meas, meas == 19,
> +                                       50000, 800000, false, data);
> +               if (ret != 0)

Drop this ' != 0' part. It's useless.

> +                       goto read_unlock;

> +

Seems redundant blank line.

...

> +       }
> +
>

Ditto.

...

> +       int ret = 0;

Redundant assignment. Use return 0; directly.

...

> +       if (time_in_range(now, data->interraction_timestamp,
> +                         data->interraction_timestamp +

> +                         msecs_to_jiffies(MLX90632_MEAS_MAX_TIME + 100))) {

With a local variable you will have better to read code.

> +       }


...

>         struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));

Maybe a separate patch to drop these here-there dereferences...

...

> +static int __maybe_unused mlx90632_pm_runtime_suspend(struct device *dev)

No __maybe_unused, use pm_ptr() / pm_sleep_ptr() below.

> +{
> +       struct iio_dev *indio_dev = i2c_get_clientdata(to_i2c_client(dev));
> +       struct mlx90632_data *data = iio_priv(indio_dev);
> +
> +       return mlx90632_pwr_set_sleep_step(data->regmap);
> +}
> +
> +const struct dev_pm_ops mlx90632_pm_ops = {
> +       SET_SYSTEM_SLEEP_PM_OPS(mlx90632_pm_suspend, mlx90632_pm_resume)
> +       SET_RUNTIME_PM_OPS(mlx90632_pm_runtime_suspend,
> +                          NULL, NULL)

Please, use new macros from pm.h / runtime_pm.h

> +};
> +EXPORT_SYMBOL_GPL(mlx90632_pm_ops);

Can we use special EXPORT macro from pm.h

-- 
With Best Regards,
Andy Shevchenko
