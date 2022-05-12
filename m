Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C4DA45246A2
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 09:15:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1350827AbiELHPL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 03:15:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54014 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350809AbiELHPA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 03:15:00 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33F9079806;
        Thu, 12 May 2022 00:14:59 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id x52so3987007pfu.11;
        Thu, 12 May 2022 00:14:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=xGQI4Uoj1dr+aEskjWCNFPVBtuNGecDaxcbPpm4ndbA=;
        b=PnA7rPHXCzS0oh9lybb9R+lMue+sbKQL/J8VRDHkkRo9cxuqJmFC90BLUdvNpvQ3yx
         qPXAmh0JFJQTnsYzKtSTuNsch+PM+pzpvqXqxqmJCG2fLiMobPUPeAmiPzfxzF0XWnS+
         5PcntrBUmEy6FhaVNAByXc9KhN/x1BDMX/vOPaia5RKBnV84omjEVyuc1vf+LKeDxhoI
         kfc7kgpU61zQZ9B7SeHh4qnI9lzvmrnwDcfAWwue1iiSLlrZBAv99QX8smQQiMaJptm4
         3STjzwEVMbrpn5TsSZln4yuKG+nySs9CC47ZVfkRyYYWaPqG/Ch436vmVVVgwsYbm3e+
         /GSg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=xGQI4Uoj1dr+aEskjWCNFPVBtuNGecDaxcbPpm4ndbA=;
        b=74rV3RvDmpq4fnSpiS3h8gGap8kCb0Lwq4Oguew7zsbO2uLSyQw3p8g3+H9DnACmox
         HloOPnff1HvdOQfn+3N3zTyfD/iT197j4eS0KibXt0z6G//8k3ylXofr2Ed58q+LgQyj
         8PZFutmx5y9Yicn6rTuzwG0Ud8JSrwnA8c90HnOt8d4W82HIyWQwBRXK5RzAA1+g0SuK
         k6SOKfUyOqQAWQHj+QhhLdSBbNdVHNhxf7pkwz3++Wyvls1Pm5b5z0Pot8Z+DtDOq3Oh
         DhfkbcR0bQD6r13Tq5lT2QTrdlqSF7yVkzcFDIdVWa8wQOzSTuDxqQlBNBjT1hEi+lDc
         qkyg==
X-Gm-Message-State: AOAM5316E5W7Y3jHCjDUoeDVUIyOwVHGUrImyMm2r8+ikpNTfs2Zq+gJ
        VvGrEndzp7M4X+kFm4gkHE9rdaMKpeL4pMVWlPE=
X-Google-Smtp-Source: ABdhPJw4HsvF11WbCOm9ikh5D4rNFJFGTUUhY31uegaRVy95168mD6K7vmft6BvhzVCuzBBmHpUrY5u54uUBWfWg6HI=
X-Received: by 2002:a63:84c8:0:b0:3c6:4013:9e90 with SMTP id
 k191-20020a6384c8000000b003c640139e90mr23918919pgd.415.1652339698647; Thu, 12
 May 2022 00:14:58 -0700 (PDT)
MIME-Version: 1.0
References: <20220510141753.3878390-1-Qing-wu.Li@leica-geosystems.com.cn> <20220510141753.3878390-2-Qing-wu.Li@leica-geosystems.com.cn>
In-Reply-To: <20220510141753.3878390-2-Qing-wu.Li@leica-geosystems.com.cn>
From:   Alexandru Ardelean <ardeleanalex@gmail.com>
Date:   Thu, 12 May 2022 10:14:47 +0300
Message-ID: <CA+U=DsqUztHxrkYsWTNz8Xm1OxRK2Wkb7L7Csque4r1tEDz_ig@mail.gmail.com>
Subject: Re: [PATCH V2 1/6] iio: accel: bmi088: Modified the scale calculate
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        mchehab+huawei@kernel.org, linux-iio <linux-iio@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Mike Looijmans <mike.looijmans@topic.nl>,
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

On Tue, May 10, 2022 at 5:17 PM LI Qingwu
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

Strictly on the code:

Reviewed-by: Alexandru Ardelean <ardeleanalex@gmail.com>

On the change of IIO_VAL_FRACTIONAL_LOG2 -> IIO_VAL_INT_PLUS_MICRO  is
still up for discussion.

> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/bmi088-accel-core.c | 12 +++++++-----
>  1 file changed, 7 insertions(+), 5 deletions(-)
>
> diff --git a/drivers/iio/accel/bmi088-accel-core.c b/drivers/iio/accel/bmi088-accel-core.c
> index a06dae5c971d..9300313b63cb 100644
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
>                         if (ret)
>                                 goto out_read_raw_pm_put;
> -
> -                       *val2 = 15 - (*val & 0x3);
> -                       *val = 3 * 980;
> -                       ret = IIO_VAL_FRACTIONAL_LOG2;
> +                       *val = data->chip_info->scale_table[reg&0x03][0];
> +                       *val2 = data->chip_info->scale_table[reg&0x03][1];
> +                       ret = IIO_VAL_INT_PLUS_MICRO;
>
>                         goto out_read_raw_pm_put;
>                 default:
> @@ -432,6 +433,7 @@ static const struct bmi088_accel_chip_info bmi088_accel_chip_info_tbl[] = {
>                 .chip_id = 0x1E,
>                 .channels = bmi088_accel_channels,
>                 .num_channels = ARRAY_SIZE(bmi088_accel_channels),
> +               .scale_table = {{0, 897}, {0, 1795}, {0, 3590}, {0, 7179}},
>         },
>  };
>
> --
> 2.25.1
>
