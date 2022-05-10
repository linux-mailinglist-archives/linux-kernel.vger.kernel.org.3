Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6097F520E8B
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 09:33:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238557AbiEJHhJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 03:37:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238134AbiEJHFj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 03:05:39 -0400
Received: from mail-pl1-x62a.google.com (mail-pl1-x62a.google.com [IPv6:2607:f8b0:4864:20::62a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A47A52D1FF;
        Tue, 10 May 2022 00:01:42 -0700 (PDT)
Received: by mail-pl1-x62a.google.com with SMTP id d22so15934405plr.9;
        Tue, 10 May 2022 00:01:42 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=2bJfSI26+416H0cEFrU+Zj4BNqCl1B3sTgbKXFNXPmU=;
        b=pH2kT7ap04SLVR0W2AufymCpw+0zDuir2vcSkD2zlgTbXoFv0I+hvEUmzHBhC0yVbP
         bdCggCJk5d0N5vDSecMBSjkZmXMh/23fwOUvUlkEe7O11UP0qAlo6ZwGAYPdqiccZCZk
         MGRU/GGJvh6X7CKhSQ7cG/RkMGSktmXYIVGWNr2sP9FU233uyKPK30EOLEa0t9T4c7XZ
         2KLXjuqccEWbyT7XS0np1ZM/Xaz/3UuYYyKrhkUO4/pCVpHhenPI3VAlx5enizuLYPiZ
         T00J+LS3BZpJ0jIiGwN9p8SXonfgYg74PtzMDhkkCIca+QBS3SWW9aZyn0e1s8J4gUu5
         ckvA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=2bJfSI26+416H0cEFrU+Zj4BNqCl1B3sTgbKXFNXPmU=;
        b=SZHNhBspEU0szhnnGwN5IZz7K/nwgJE+63NCZuCwkeNzYOQ7Ew+NYQ98xTFQsiIzWY
         OSOHSs98TnfxxVjUj6gwqlD6vmN8TPJZwS9b4faO/5mV1v3eTZ8Ydj6IQnvwMIRTHjii
         /MwKhg5WCgb/3OTAvDtyickVbvBVVBptdlN2+rk02HU6tBEGxnZqIvEesrsCXyfD07t6
         42EnTWLtI0yR4a6Ad5auISE3Xb++qH6gAQcjhAB5BHpFAiUwJQBsSQgPykdVIahDJgzM
         lTZeOg6yHWGNg5SMLAe+2sGw09erMGwwYNq/7IMeBk+4gqdxZsBCmYDnYvCKc2p2Ti6J
         cAew==
X-Gm-Message-State: AOAM530XBhliuUs7fra5X2etVETK16e1bqYXMZiXSi4g9CsyxO3wePb4
        SPka+7e6U17yzQB43HmKCxyQj1KLvp77sIkU7H4=
X-Google-Smtp-Source: ABdhPJyDmgLmJ+UkJgAmBSmdDMtmzjuyKFW/3yG342AEob6jkHlqPUT3Il3Ejn0ZEYkPLKl3+UiO/aPNPRmvT8azFCs=
X-Received: by 2002:a17:902:6f16:b0:15e:f719:34ec with SMTP id
 w22-20020a1709026f1600b0015ef71934ecmr15720145plk.166.1652166102198; Tue, 10
 May 2022 00:01:42 -0700 (PDT)
MIME-Version: 1.0
References: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn> <20220509134629.440965-5-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220509134629.440965-5-Qing-wu.Li@leica-geosystems.com.cn>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 10 May 2022 10:01:31 +0300
Message-ID: <CA+U=Dsp_vvANuXUwjKC-6g8daBOCFargRZ0r=AbkCwG9KifgHA@mail.gmail.com>
Subject: Re: [PATCH V1 4/5] iio: accel: bmi088: Make it possible to config scales.
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        mchehab+huawei@kernel.org, linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
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

On Mon, May 9, 2022 at 4:46 PM LI Qingwu
<Qing-wu.Li@leica-geosystems.com.cn> wrote:
>
> All the sensors can set the scales by writing the range register 0x41,
> The current driver has no interface to configure it.
> The commit adds the interface for config the scales.

With the warnings fixed:


Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>


>
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/bmi088-accel-core.c | 32 +++++++++++++++++++++++++++
>  1 file changed, 32 insertions(+)
>
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index 44cbe098c093..7c78cfb321ee 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -237,6 +237,23 @@ static int bmi088_accel_set_sample_freq(struct bmi088_accel_data *data, int val)
>                                   BMI088_ACCEL_MODE_ODR_MASK, regval);
>  }
>
> +static int bmi088_accel_set_scale(struct bmi088_accel_data *data, int val, int val2)
> +{
> +       unsigned int i;
> +       int ret;
> +       int reg;
> +
> +       for (i = 0; i < 4; i++)
> +               if (val == data->chip_info->scale_table[i][0] &&
> +                   val2 == data->chip_info->scale_table[i][1])
> +                       break;
> +
> +       if (i >= 4)
> +               return -EINVAL;
> +
> +       return regmap_write(data->regmap, BMI088_ACCEL_REG_ACC_RANGE, i);
> +}
> +
>  static int bmi088_accel_get_temp(struct bmi088_accel_data *data, int *val)
>  {
>         int ret;
> @@ -368,7 +385,13 @@ static int bmi088_accel_read_avail(struct iio_dev *indio_dev,
>                              const int **vals, int *type, int *length,
>                              long mask)
>  {
> +       struct bmi088_accel_data *data = iio_priv(indio_dev);
>         switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               *vals = (const int *)data->chip_info->scale_table;
> +               *length = 8;
> +               *type = IIO_VAL_INT_PLUS_MICRO;
> +               return IIO_AVAIL_LIST;
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 *type = IIO_VAL_INT_PLUS_MICRO;
>                 *vals = bmi088_sample_freqs;
> @@ -388,6 +411,14 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
>         int ret;
>
>         switch (mask) {
> +       case IIO_CHAN_INFO_SCALE:
> +               ret = pm_runtime_resume_and_get(dev);
> +               if (ret)
> +                       return ret;
> +               ret = bmi088_accel_set_scale(data, val, val2);
> +               pm_runtime_mark_last_busy(dev);
> +               pm_runtime_put_autosuspend(dev);
> +               return ret;
>         case IIO_CHAN_INFO_SAMP_FREQ:
>                 ret = pm_runtime_resume_and_get(dev);
>                 if (ret)
> @@ -410,6 +441,7 @@ static int bmi088_accel_write_raw(struct iio_dev *indio_dev,
>         .info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE) | \
>                                 BIT(IIO_CHAN_INFO_SAMP_FREQ), \
>         .info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SAMP_FREQ), \
> +                               BIT(IIO_CHAN_INFO_SCALE ), \
>         .scan_index = AXIS_##_axis, \
>  }
>
> --
> 2.25.1
>
