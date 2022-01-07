Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 77CCC487396
	for <lists+linux-kernel@lfdr.de>; Fri,  7 Jan 2022 08:33:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344185AbiAGHdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 7 Jan 2022 02:33:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234699AbiAGHdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 7 Jan 2022 02:33:51 -0500
Received: from mail-qv1-xf30.google.com (mail-qv1-xf30.google.com [IPv6:2607:f8b0:4864:20::f30])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B003BC061245;
        Thu,  6 Jan 2022 23:33:51 -0800 (PST)
Received: by mail-qv1-xf30.google.com with SMTP id r6so4734215qvr.13;
        Thu, 06 Jan 2022 23:33:51 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=mime-version:references:in-reply-to:from:date:message-id:subject:to
         :cc;
        bh=OWA1fdbzmylL4NYUKt7VSHUi8U/n20t6ksYYhfNxj8U=;
        b=dqBvjEJ42WPrTh6ySpy7KW/04ETvvXvpUF7wFNrq5p3b3IVpJoa4ixSXPIG1c72JSM
         8f2fBwRpoSpmM9K1RpR/o1REC0MhWWe0M4nCxXxDMhf6/p3TmK/mT7Igowysoh+jCnwj
         sEh1MT0UzLvdg8xhBYHMMmDuB8mQiTj7dJJo3780QL2Ld4ttUVp7038PyXWFtFL+w29k
         9qVfwXaLPUPSwQTsTUgEn5pgS2pmCq3hsAqaF5oSxmdwejCPRe1s23oSJCUj9DxULdQK
         jWKFWlxB1aayOxfmtS6ZFKApRKRa+0aSri3Lth5Xb9Eopwojupyz50R8ctwAazDDWz7X
         wvCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:mime-version:references:in-reply-to:from:date
         :message-id:subject:to:cc;
        bh=OWA1fdbzmylL4NYUKt7VSHUi8U/n20t6ksYYhfNxj8U=;
        b=hOkBZYecikIxv23NRZ0t+UFSc5sYHuzAOPJYS9uckA5sjVmKFMLQQ8jhNEpJiNcjvp
         btdR3LS41O9eq/suVMsediKkCZA9rOmq+dDRigwbZ8rJ9fDSVDYh1kbGhl+ES5kTlSDi
         M35XDMPYFLvtriMg2PzGj8TxqOPXdcn2dzlvO4MVbB++dM9R0eAlpXGG3vidbbBsC8tR
         bDIQTee/CfArRxq0mIMHJbz7LpEso44Foe6PDwg/hab710NjBosvRYr5Fft589LfzUGj
         /Y45cng6FRIfgOMRQRfrlBScdLFMm0Yl5e0yyzgN3G8ugttcrN7PcVbQyoKTYo6y3wVp
         N5/g==
X-Gm-Message-State: AOAM531XdsMUg0FCpVXTqrKncn7jy5YeR/ZbPfnB0WRtoV5KzgG/iJv9
        MEnfHpP70KyxRLqPV8VGPJXq4F3QySYrPTYq2I8=
X-Google-Smtp-Source: ABdhPJwaXB9IYwGWMkewpDaud/Nyq0WCEzceD9GziR40a5CzBY5Pqs7Yf5uvZaZs+Xiuux+TdQsFUbO0DPEI0rnTeIs=
X-Received: by 2002:a05:6214:2504:: with SMTP id gf4mr2063513qvb.11.1641540830896;
 Thu, 06 Jan 2022 23:33:50 -0800 (PST)
MIME-Version: 1.0
References: <20220106125947.139523-1-gengcixi@gmail.com> <20220106125947.139523-8-gengcixi@gmail.com>
In-Reply-To: <20220106125947.139523-8-gengcixi@gmail.com>
From:   Baolin Wang <baolin.wang7@gmail.com>
Date:   Fri, 7 Jan 2022 15:34:32 +0800
Message-ID: <CADBw62qd6RuHnxnkf1gQZERtq08okXC4asDBQ=6m_T_P_JDxqw@mail.gmail.com>
Subject: Re: [PATCH 7/7] iio: adc: sc27xx: add Ump9620 ADC suspend and resume
 pm support
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     Orson Zhai <orsonzhai@gmail.com>,
        Chunyan Zhang <zhang.lyra@gmail.com>, jic23@kernel.org,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>, lgirdwood@gmail.com,
        Mark Brown <broonie@kernel.org>, yuming.zhu1@unisoc.com,
        linux-iio@vger.kernel.org,
        Devicetree List <devicetree@vger.kernel.org>,
        LKML <linux-kernel@vger.kernel.org>
Content-Type: text/plain; charset="UTF-8"
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, Jan 6, 2022 at 9:00 PM Cixi Geng <gengcixi@gmail.com> wrote:
>
> From: Cixi Geng <cixi.geng1@unisoc.com>
>
> Ump9620 ADC suspend and resume pm optimization, configuration
> 0x6490_ 0350(PAD_ CLK26M_ SINOUT_ PMIC_ 1P8 ) bit 8.
>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> ---
>  drivers/iio/adc/sc27xx_adc.c | 103 ++++++++++++++++++++++++++++++++++-
>  1 file changed, 102 insertions(+), 1 deletion(-)
>
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index 68b967f32498..cecda8d53474 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -11,6 +11,7 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>
>  /* PMIC global registers definition */
>  #define SC2730_MODULE_EN               0x1808
> @@ -83,6 +84,9 @@
>  /* ADC default channel reference voltage is 2.8V */
>  #define SC27XX_ADC_REFVOL_VDD28                2800000
>
> +/* 10s delay before suspending the ADC IP */
> +#define SC27XX_ADC_AUTOSUSPEND_DELAY   10000
> +
>  enum sc27xx_pmic_type {
>         SC27XX_ADC,
>         SC2721_ADC,
> @@ -618,6 +622,9 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>                 return ret;
>         }
>
> +       if (data->var_data->pmic_type == UMP9620_ADC)
> +               pm_runtime_get_sync(data->indio_dev->dev.parent);
> +
>         /*
>          * According to the sc2721 chip data sheet, the reference voltage of
>          * specific channel 30 and channel 31 in ADC module needs to be set from
> @@ -700,6 +707,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>                 }
>         }
>
> +       if (data->var_data->pmic_type == UMP9620_ADC) {
> +               pm_runtime_mark_last_busy(data->indio_dev->dev.parent);
> +               pm_runtime_put_autosuspend(data->indio_dev->dev.parent);
> +       }
> +
>         hwspin_unlock_raw(data->hwlock);
>
>         if (!ret)
> @@ -947,6 +959,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>                 ret = regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
>                                          UMP9620_XTL_WAIT_CTRL0_EN,
>                                          UMP9620_XTL_WAIT_CTRL0_EN);
> +               if (ret) {
> +                       dev_err(data->dev, "failed to set the UMP9620 ADC clk26m bit8 on IP\n");
> +                       goto clean_adc_clk26m_bit8;
> +               }
>         }
>
>         /* Enable ADC work clock */
> @@ -988,6 +1004,11 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>         regmap_update_bits(data->regmap, data->var_data->module_en,
>                            SC27XX_MODULE_ADC_EN, 0);
>
> +clean_adc_clk26m_bit8:
> +       if (data->var_data->pmic_type == UMP9620_ADC)
> +               regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
> +                               UMP9620_XTL_WAIT_CTRL0_EN, 0);

Can you hide this into the pm runtime callbacks?

> +
>         return ret;
>  }
>
> @@ -1086,6 +1107,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>         if (!indio_dev)
>                 return -ENOMEM;
>
> +       platform_set_drvdata(pdev, indio_dev);
> +
>         sc27xx_data = iio_priv(indio_dev);
>
>         sc27xx_data->regmap = dev_get_regmap(dev->parent, NULL);
> @@ -1126,7 +1149,10 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>                 }
>         }
>
> +       sc27xx_data->dev = dev;
>         sc27xx_data->var_data = pdata;
> +       sc27xx_data->indio_dev = indio_dev;
> +
>         sc27xx_data->var_data->init_scale(sc27xx_data);
>
>         ret = sc27xx_adc_enable(sc27xx_data);
> @@ -1137,18 +1163,39 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>
>         ret = devm_add_action_or_reset(dev, sc27xx_adc_disable, sc27xx_data);
>         if (ret) {
> +               sc27xx_adc_disable(sc27xx_data);
>                 dev_err(dev, "failed to add ADC disable action\n");
>                 return ret;
>         }
>
> +       indio_dev->dev.parent = dev;
>         indio_dev->name = dev_name(dev);
>         indio_dev->modes = INDIO_DIRECT_MODE;
>         indio_dev->info = &sc27xx_info;
>         indio_dev->channels = sc27xx_channels;
>         indio_dev->num_channels = ARRAY_SIZE(sc27xx_channels);
> +
> +       if (sc27xx_data->var_data->pmic_type == UMP9620_ADC) {
> +               pm_runtime_set_autosuspend_delay(dev,
> +                                                SC27XX_ADC_AUTOSUSPEND_DELAY);
> +               pm_runtime_use_autosuspend(dev);
> +               pm_runtime_set_suspended(dev);
> +               pm_runtime_enable(dev);
> +       }
> +
>         ret = devm_iio_device_register(dev, indio_dev);
> -       if (ret)
> +       if (ret) {
>                 dev_err(dev, "could not register iio (ADC)");
> +               goto err_iio_register;
> +       }
> +
> +       return 0;
> +
> +err_iio_register:
> +       if (sc27xx_data->var_data->pmic_type == UMP9620_ADC) {
> +               pm_runtime_put(dev);

I don't think the pm_runtime_put() is needed, since you did not get
the counter before, right?

> +               pm_runtime_disable(dev);
> +       }
>
>         return ret;
>  }
> @@ -1163,11 +1210,65 @@ static const struct of_device_id sc27xx_adc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
>
> +static int sc27xx_adc_remove(struct platform_device *pdev)
> +{
> +       struct iio_dev *indio_dev = platform_get_drvdata(pdev);
> +       struct sc27xx_adc_data *sc27xx_data = iio_priv(indio_dev);
> +
> +       if (sc27xx_data->var_data->pmic_type == UMP9620_ADC) {
> +               pm_runtime_put(&pdev->dev);

You did not get the pm count, why put it firstly?

> +               pm_runtime_disable(&pdev->dev);
> +
> +               /* set the UMP9620 ADC clk26m bit8 on IP */
> +               regmap_update_bits(sc27xx_data->regmap, UMP9620_XTL_WAIT_CTRL0,
> +                               UMP9620_XTL_WAIT_CTRL0_EN, 0);
> +       }
> +
> +       return 0;
> +}
> +
> +static int sc27xx_adc_runtime_suspend(struct device *dev)
> +{
> +       struct sc27xx_adc_data *sc27xx_data = iio_priv(dev_get_drvdata(dev));
> +
> +       /* clean the UMP9620 ADC clk26m bit8 on IP */
> +       if (sc27xx_data->var_data->pmic_type == UMP9620_ADC)
> +               regmap_update_bits(sc27xx_data->regmap, UMP9620_XTL_WAIT_CTRL0,
> +                               UMP9620_XTL_WAIT_CTRL0_EN, 0);
> +
> +       return 0;
> +}
> +
> +static int sc27xx_adc_runtime_resume(struct device *dev)
> +{
> +       int ret = 0;

no need to initialize it.

> +       struct sc27xx_adc_data *sc27xx_data = iio_priv(dev_get_drvdata(dev));
> +
> +       /* set the UMP9620 ADC clk26m bit8 on IP */
> +       if (sc27xx_data->var_data->pmic_type == UMP9620_ADC) {
> +               ret = regmap_update_bits(sc27xx_data->regmap, UMP9620_XTL_WAIT_CTRL0,
> +                               UMP9620_XTL_WAIT_CTRL0_EN, UMP9620_XTL_WAIT_CTRL0_EN);
> +               if (ret) {
> +                       dev_err(dev, "failed to set the UMP9620 ADC clk26m bit8 on IP\n");
> +                       return ret;
> +               }
> +       }
> +
> +       return 0;
> +}
> +
> +static const struct dev_pm_ops sc27xx_adc_pm_ops = {
> +       .runtime_suspend = &sc27xx_adc_runtime_suspend,
> +       .runtime_resume = &sc27xx_adc_runtime_resume,
> +};

Please use SET_RUNTIME_PM_OPS macro.

> +
>  static struct platform_driver sc27xx_adc_driver = {
>         .probe = sc27xx_adc_probe,
> +       .remove = sc27xx_adc_remove,
>         .driver = {
>                 .name = "sc27xx-adc",
>                 .of_match_table = sc27xx_adc_of_match,
> +               .pm     = &sc27xx_adc_pm_ops,
>         },
>  };
>
> --
> 2.25.1
>


-- 
Baolin Wang
