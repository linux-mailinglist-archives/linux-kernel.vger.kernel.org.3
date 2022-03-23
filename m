Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8361E4E5405
	for <lists+linux-kernel@lfdr.de>; Wed, 23 Mar 2022 15:09:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236980AbiCWOKd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 23 Mar 2022 10:10:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47288 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236534AbiCWOKc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 23 Mar 2022 10:10:32 -0400
Received: from mail-qt1-x829.google.com (mail-qt1-x829.google.com [IPv6:2607:f8b0:4864:20::829])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 36D3936B6B;
        Wed, 23 Mar 2022 07:09:02 -0700 (PDT)
Received: by mail-qt1-x829.google.com with SMTP id bp39so1195376qtb.6;
        Wed, 23 Mar 2022 07:09:02 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=Nnzujr/9w5yv7VmfvBVj8t7Pp/lBvu+cUel9AUsKnc4=;
        b=GxnGH8X4pwCOkQmivYx30gdwX5XCZATNOUdp+xEy9onfcRfUvfh2fuHKplV2r+M9ma
         HtIQlDdTD6RQbQjT4b32YoG/EZvYcS3Nxz1OTSLYv9JH3Rmt1LD7nLjkJpvwOpP0d+g1
         DG+fXtGFMZ8tvjD2s4wXaIGEaS01HoeqzuvsRPiI1M00PS24yXZvUpR4Bn9neZX1WOU8
         dYSKFQB6tUPtfRlxL0fPcdBYT5/fXaeEBth1fyQ9unbiZ6153ftpSucVL4rqqNcqK0nW
         ZF6wuqfA8plRqW+HwqpE8zQbZ10H3lGAyekwTW3NywUY0K9nyDqTnxOC6U0V2tjLUuXz
         o5Ww==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=Nnzujr/9w5yv7VmfvBVj8t7Pp/lBvu+cUel9AUsKnc4=;
        b=BEyC91msxzVM2XU9Jv1sQgKbyZBoYAlXWZ0MTUukLqsRma8K1/FkVd2asWxY+vKC1a
         R5wqK4Iw+2qJXy7vrgCrBvjbsvWxy3jLQ3zUP6DNwriS0S/2khkIcnCIE8YNB+y2yuEL
         fLMQ8frT4GhPmV1zBdImD9GjKrCGkngeA6XzTNgn9e1IIFJ6bMCa2A0BN7ZzG/xrF/5G
         Tr7uywJeTFhIvENjl4TlCzaF8FoJekLlGf4yVGZCL5Ty19DglTTl3kWDCfXFVIA1tK2k
         zEbPdd/9SkXZfAHlH+lwf3+4gtpPV3Xhna9iN8x0fhPPG6k3EiAiA9DFAKMy8RK77AOB
         8fAg==
X-Gm-Message-State: AOAM5314fovckF7J+4lJq8LhI+9NdLPbGx5hB9wHfMkKYPlusNrczhoK
        dWZkm6FF/wVXGHWT7sBOcyX4i1avh05MBULB+rQ=
X-Google-Smtp-Source: ABdhPJxF6vyzbewMOMHuSjYrXVW47XC4GaWj3ntkDGXVgqTUkYhzPwYCL2S4HPEezVTQ6ott/O6ehDSMtUkYTHuH9VQ=
X-Received: by 2002:a05:622a:291:b0:2e1:fee4:8a56 with SMTP id
 z17-20020a05622a029100b002e1fee48a56mr20587862qtw.624.1648044541317; Wed, 23
 Mar 2022 07:09:01 -0700 (PDT)
MIME-Version: 1.0
References: <20220311164628.378849-1-gengcixi@gmail.com> <20220311164628.378849-6-gengcixi@gmail.com>
In-Reply-To: <20220311164628.378849-6-gengcixi@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Wed, 23 Mar 2022 22:09:47 +0800
Message-ID: <CADBw62qJCHrGSX7+yMfo7SV9SGdQwyYPFc6zcBn=cmfOuMgMTA@mail.gmail.com>
Subject: Re: [PATCH V2 5/7] iio: adc: sc27xx: add support for PMIC sc2730
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     jic23@kernel.org, Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>,
        =?UTF-8?B?5pyx546J5piOIChZdW1pbmcgWmh1LzExNDU3KQ==?= 
        <yuming.zhu1@unisoc.com>, linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, Mar 12, 2022 at 12:47 AM Cixi Geng <gengcixi@gmail.com> wrote:
>
> From: Cixi Geng <cixi.geng1@unisoc.com>
>
> sc2730 is the product of sc27xx series.
>
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/iio/adc/sc27xx_adc.c | 108 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 107 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 2603ce313b07..b89637c051ac 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -13,9 +13,11 @@
>  #include <linux/slab.h>
>
>  /* PMIC global registers definition */
> +#define SC2730_MODULE_EN               0x1808
>  #define SC2731_MODULE_EN               0xc08
>  #define SC27XX_MODULE_ADC_EN           BIT(5)
>  #define SC2721_ARM_CLK_EN              0xc0c
> +#define SC2730_ARM_CLK_EN              0x180c
>  #define SC2731_ARM_CLK_EN              0xc10
>  #define SC27XX_CLK_ADC_EN              BIT(5)
>  #define SC27XX_CLK_ADC_CLK_EN          BIT(6)
> @@ -293,6 +295,80 @@ static int sc2721_adc_get_ratio(int channel, int scale)
>         return SC27XX_VOLT_RATIO(1, 1);
>  }
>
> +static int sc2730_adc_get_ratio(int channel, int scale)
> +{
> +       switch (channel) {
> +       case 14:
> +               switch (scale) {
> +               case 0:
> +                       return SC27XX_VOLT_RATIO(68, 900);
> +               case 1:
> +                       return SC27XX_VOLT_RATIO(68, 1760);
> +               case 2:
> +                       return SC27XX_VOLT_RATIO(68, 2327);
> +               case 3:
> +                       return SC27XX_VOLT_RATIO(68, 3654);
> +               default:
> +                       return SC27XX_VOLT_RATIO(1, 1);
> +               }
> +       case 15:
> +               switch (scale) {
> +               case 0:
> +                       return SC27XX_VOLT_RATIO(1, 3);
> +               case 1:
> +                       return SC27XX_VOLT_RATIO(1000, 5865);
> +               case 2:
> +                       return SC27XX_VOLT_RATIO(500, 3879);
> +               case 3:
> +                       return SC27XX_VOLT_RATIO(500, 6090);
> +               default:
> +                       return SC27XX_VOLT_RATIO(1, 1);
> +               }
> +       case 16:
> +               switch (scale) {
> +               case 0:
> +                       return SC27XX_VOLT_RATIO(48, 100);
> +               case 1:
> +                       return SC27XX_VOLT_RATIO(480, 1955);
> +               case 2:
> +                       return SC27XX_VOLT_RATIO(480, 2586);
> +               case 3:
> +                       return SC27XX_VOLT_RATIO(48, 406);
> +               default:
> +                       return SC27XX_VOLT_RATIO(1, 1);
> +               }
> +       case 21:
> +       case 22:
> +       case 23:
> +               switch (scale) {
> +               case 0:
> +                       return SC27XX_VOLT_RATIO(3, 8);
> +               case 1:
> +                       return SC27XX_VOLT_RATIO(375, 1955);
> +               case 2:
> +                       return SC27XX_VOLT_RATIO(375, 2586);
> +               case 3:
> +                       return SC27XX_VOLT_RATIO(300, 3248);
> +               default:
> +                       return SC27XX_VOLT_RATIO(1, 1);
> +               }
> +       default:
> +               switch (scale) {
> +               case 0:
> +                       return SC27XX_VOLT_RATIO(1, 1);
> +               case 1:
> +                       return SC27XX_VOLT_RATIO(1000, 1955);
> +               case 2:
> +                       return SC27XX_VOLT_RATIO(1000, 2586);
> +               case 3:
> +                       return SC27XX_VOLT_RATIO(1000, 4060);
> +               default:
> +                       return SC27XX_VOLT_RATIO(1, 1);
> +               }
> +       }
> +       return SC27XX_VOLT_RATIO(1, 1);
> +}
> +
>  static int sc2731_adc_get_ratio(int channel, int scale)
>  {
>         switch (channel) {
> @@ -349,6 +425,22 @@ static void sc2720_adc_scale_init(struct sc27xx_adc_data *data)
>         }
>  }
>
> +static void sc2730_adc_scale_init(struct sc27xx_adc_data *data)
> +{
> +       int i;
> +
> +       for (i = 0; i < SC27XX_ADC_CHANNEL_MAX; i++) {
> +               if (i == 5 || i == 10 || i == 19 || i == 30 || i == 31)
> +                       data->channel_scale[i] = 3;
> +               else if (i == 7 || i == 9)
> +                       data->channel_scale[i] = 2;
> +               else if (i == 13)
> +                       data->channel_scale[i] = 1;
> +               else
> +                       data->channel_scale[i] = 0;
> +       }
> +}
> +
>  static void sc2731_adc_scale_init(struct sc27xx_adc_data *data)
>  {
>         int i;
> @@ -449,7 +541,8 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>                                                     SC27XX_ADC_REFVOL_VDD28,
>                                                     SC27XX_ADC_REFVOL_VDD28);
>                         if (ret_volref) {
> -                               dev_err(data->dev, "failed to set the volref 2.8V, ret_volref = 0x%x\n,ret_volref");
> +                               dev_err(data->dev, "failed to set the volref 2.8V, ret_volref = 0x%x\n",
> +                                       ret_volref);

Do not add unrelated changes in this patch.

-- 
Baolin Wang
