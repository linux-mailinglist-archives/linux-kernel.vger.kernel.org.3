Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00E6D520D7A
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 08:01:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236970AbiEJGFd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 02:05:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59998 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233823AbiEJGF3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 02:05:29 -0400
Received: from mail-pj1-x1035.google.com (mail-pj1-x1035.google.com [IPv6:2607:f8b0:4864:20::1035])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3283F29ED22;
        Mon,  9 May 2022 23:01:32 -0700 (PDT)
Received: by mail-pj1-x1035.google.com with SMTP id t11-20020a17090ad50b00b001d95bf21996so1185565pju.2;
        Mon, 09 May 2022 23:01:32 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=XQQYvbl9hUacAPEZ+LW/8LA5nUubKeczZLoxSCDlwOw=;
        b=jFTt+K4E8KUfJCl7/NROgzlyUhIUBKAfHN3HYk75JZXFpf6yTKMMea3l1BeO4P+KW+
         dsevyiK2sBkhJmL9rTyc3MNI6++W4e1LDNb34baEZmft322rs/Nry8J6P9k+Pg5xAYr+
         WXTzCdCBZvSag24xn9b1OvawRpvog4m3Je9Hbe/qNI0QScas4faIvR7oJZKxsHeeIqm7
         YwTduWMbScgxnEgpbgmenTpyS3LJFZYMcAtaHZIi8sZ84rN1BDVYfSd9vcfUdQwcyXaL
         A/fbP+Anc/wCs5TY15hjFUiBE4/sJ6RNdZHvKDm7fEqq6dqDJrbcujez6bqn0Gqqe4dv
         boeg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=XQQYvbl9hUacAPEZ+LW/8LA5nUubKeczZLoxSCDlwOw=;
        b=0PAyU1BH80hHLY9gRaMTj5zT00djyRmV8olJkRtKsYqCM0S1O2lcEgIrAvIlYhLH/b
         QEflH9+yplXL/ryYk24Z/4afD4FMElA7rZRzzOCCBhdSQ7pJj/TZuDFk9IDSrmFx5i3r
         m06syhUDa0WWpqzLE0IoKQ0/IKubIe6bvqb+PjK2LSRqSkDCbcMWxgUZP2X4qhqGqgZD
         f4N9sIz1rdRizJE4DvcJGON5GiqEHZrS7RFiRW4eK/ipYMqJkmstfE6bKR7qg8+m+erN
         h1cdLCQS4U7FwxpHSjyHWClXmfIrnpIqtlFcs0ZP1SC9jBTPXhCmpyUOzaAQPWyupgXa
         kGtA==
X-Gm-Message-State: AOAM531vRMwK7Afvb/e50tx8GeLXH+0UUhsu0xUKc2jh2YLdOcMF3xgF
        zulocuyuOo4NAFEermwdknk0J2I6XovAr2xx9Z6StK/j
X-Google-Smtp-Source: ABdhPJyOmFJx+/p0huKYuxZ6kCYAoYW9ro3IU2imwqK05ydLZI0MtKW90ffY0cwPV7XVeW1p9gWlRo/dueIFhiTHChY=
X-Received: by 2002:a17:90b:4f81:b0:1dc:681e:248 with SMTP id
 qe1-20020a17090b4f8100b001dc681e0248mr30215317pjb.98.1652162491702; Mon, 09
 May 2022 23:01:31 -0700 (PDT)
MIME-Version: 1.0
References: <20220509134629.440965-1-Qing-wu.Li@leica-geosystems.com.cn> <20220509134629.440965-2-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220509134629.440965-2-Qing-wu.Li@leica-geosystems.com.cn>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Tue, 10 May 2022 09:01:20 +0300
Message-ID: <CA+U=DspAJMq7hp9RixzZcjW=rR7tEMdrHuyS23cgjmq62vmPeA@mail.gmail.com>
Subject: Re: [PATCH V1 1/5] iio: accel: bmi088: Modified the scale calculate
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
> The units after application of scale are 100*m/s^2,
> The scale calculation is only for the device
> with the range of 3, 6, 12, and 24g,
> but some other chips have a range of 2, 4, 6, and 8g.
>
> Modified the formula to a scale list.
> The scales in the list are calculated by 1/sensitivity*9.8.
> The new units after the application of scale are m/s^2.
>
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/bmi088-accel-core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index a06dae5c971d..0c58ffdd00e3 100644
> --- a/drivers/iio/accel/bmi088-accel-core.c
> +++ b/drivers/iio/accel/bmi088-accel-core.c
> @@ -119,6 +119,7 @@ struct bmi088_accel_chip_info {
>         u8 chip_id;
>         const struct iio_chan_spec *channels;
>         int num_channels;
> +       const int scale_table[4][2];
>  };
>
>  struct bmi088_accel_data {
> @@ -280,6 +281,7 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
>         struct bmi088_accel_data *data = iio_priv(indio_dev);
>         struct device *dev = regmap_get_device(data->regmap);
>         int ret;
> +       int reg;
>
>         switch (mask) {
>         case IIO_CHAN_INFO_RAW:
> @@ -330,13 +332,12 @@ static int bmi088_accel_read_raw(struct iio_dev *indio_dev,
>                                 return ret;
>
>                         ret = regmap_read(data->regmap,
> -                                         BMI088_ACCEL_REG_ACC_RANGE, val);
> +                                         BMI088_ACCEL_REG_ACC_RANGE, &reg);

Curios: do we need to validate the value of `reg` here?
If it goes outside of the 0...3 range, I can see a bit of access
violation (kernel panic) happening.

>                         if (ret)
>                                 goto out_read_raw_pm_put;
> -
> -                       *val2 = 15 - (*val & 0x3);
> -                       *val = 3 * 980;
> -                       ret = IIO_VAL_FRACTIONAL_LOG2;

Not sure what the policy is about changing this now.
I'll leave this to Jonathan.

> +                       *val = data->chip_info->scale_table[reg][0];
> +                       *val2 = data->chip_info->scale_table[reg][1];
> +                       ret = IIO_VAL_INT_PLUS_MICRO;
>
>                         goto out_read_raw_pm_put;
>                 default:
> @@ -432,6 +433,7 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
>                 .chip_id = 0x1E,
>                 .channels = bmi088_accel_channels,
>                 .num_channels = ARRAY_SIZE(bmi088_accel_channels),
> +               .scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},

I like the idea of this scale_table.
It makes things easier to see (what's happening) without looking into
the datasheet much.

>         },
>  };
>
> --
> 2.25.1
>
