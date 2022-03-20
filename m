Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C65794E1C18
	for <lists+linux-kernel@lfdr.de>; Sun, 20 Mar 2022 15:50:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245288AbiCTOva (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Mar 2022 10:51:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55392 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238877AbiCTOv2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Mar 2022 10:51:28 -0400
Received: from sin.source.kernel.org (sin.source.kernel.org [145.40.73.55])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 56D54D9E99;
        Sun, 20 Mar 2022 07:50:05 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by sin.source.kernel.org (Postfix) with ESMTPS id A8659CE1011;
        Sun, 20 Mar 2022 14:50:03 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 589DAC340E9;
        Sun, 20 Mar 2022 14:49:58 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1647787801;
        bh=D7lCT9NowQDd5LC7h5VdPtA58AH9iAhEA2bA752V190=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=BwtJ9WO0EFCr2R1DmUxan78yIzhHoJ3a6AXujCwt8uQVB/EuNA8cWJgSTB2jmdtgu
         d3omkVCvMrfHqMppzfOPwrdK7vSxYOdBlmtUWSPCE7bIIFe8g1oPelh+t8FfJz4bjH
         rU4GbWWfYYUPn+w2oPAAUGGqPaiu33DJF7B5euHj30OXdYntw3/acdRe6V6Bg/2ZHz
         ihPiaY0ksGon5eIzOcRgfvOo4fk+bAWo1mx/O4E7nUS94mHq8eIZc76Bzip1qnblUt
         9Tj6GA8g2wcu/LPGaKDBt46pfQy9wAooJe+3Syg6Ee35C9gXMqwWTV3/1YZHIDQtg2
         2oaukbeCUQxeA==
Date:   Sun, 20 Mar 2022 14:57:24 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Cixi Geng <gengcixi@gmail.com>
Cc:     lars@metafoo.de, robh+dt@kernel.org, orsonzhai@gmail.com,
        baolin.wang7@gmail.com, zhang.lyra@gmail.com, lgirdwood@gmail.com,
        broonie@kernel.org, yuming.zhu1@unisoc.com,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V2 7/7] iio: adc: sc27xx: add Ump9620 ADC suspend and
 resume pm support
Message-ID: <20220320145724.5513f466@jic23-huawei>
In-Reply-To: <20220311164628.378849-8-gengcixi@gmail.com>
References: <20220311164628.378849-1-gengcixi@gmail.com>
        <20220311164628.378849-8-gengcixi@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-8.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sat, 12 Mar 2022 00:46:28 +0800
Cixi Geng <gengcixi@gmail.com> wrote:

> From: Cixi Geng <cixi.geng1@unisoc.com>
> 
> Ump9620 ADC suspend and resume pm optimization, configuration
> 0x6490_ 0350(PAD_ CLK26M_ SINOUT_ PMIC_ 1P8 ) bit 8.
> 
> Signed-off-by: Yuming Zhu <yuming.zhu1@unisoc.com>
> Signed-off-by: Cixi Geng <cixi.geng1@unisoc.com>
> ---
>  drivers/iio/adc/sc27xx_adc.c | 88 ++++++++++++++++++++++++++++++++++--
>  1 file changed, 84 insertions(+), 4 deletions(-)
> 
> diff --git a/drivers/iio/adc/sc27xx_adc.c b/drivers/iio/adc/sc27xx_adc.c
> index e9b680e9c275..b038b1dfc91f 100644
> --- a/drivers/iio/adc/sc27xx_adc.c
> +++ b/drivers/iio/adc/sc27xx_adc.c
> @@ -11,6 +11,7 @@
>  #include <linux/regmap.h>
>  #include <linux/regulator/consumer.h>
>  #include <linux/slab.h>
> +#include <linux/pm_runtime.h>
>  
>  /* PMIC global registers definition */
>  #define SC2730_MODULE_EN		0x1808
> @@ -83,6 +84,9 @@
>  /* ADC default channel reference voltage is 2.8V */
>  #define SC27XX_ADC_REFVOL_VDD28		2800000
>  
> +/* 10s delay before suspending the ADC IP */
> +#define SC27XX_ADC_AUTOSUSPEND_DELAY	10000
> +
>  enum sc27xx_pmic_type {
>  	SC27XX_ADC,
>  	SC2721_ADC,
> @@ -96,6 +100,7 @@ enum ump96xx_scale_cal {
>  };
>  
>  struct sc27xx_adc_data {
> +	struct iio_dev *indio_dev;
>  	struct device *dev;
>  	struct regulator *volref;
>  	struct regmap *regmap;
> @@ -605,6 +610,9 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>  		return ret;
>  	}
>  
> +	if (data->var_data->pmic_type == UMP9620_ADC)
> +		pm_runtime_get_sync(data->indio_dev->dev.parent);

If you need the indio_dev in here then pass it in to the function. 
Don't introduce a hack / loop of references like this.

> +
>  	/*
>  	 * According to the sc2721 chip data sheet, the reference voltage of
>  	 * specific channel 30 and channel 31 in ADC module needs to be set from
> @@ -688,6 +696,11 @@ static int sc27xx_adc_read(struct sc27xx_adc_data *data, int channel,
>  		}
>  	}
>  
> +	if (data->var_data->pmic_type == UMP9620_ADC) {
> +		pm_runtime_mark_last_busy(data->indio_dev->dev.parent);
> +		pm_runtime_put_autosuspend(data->indio_dev->dev.parent);
> +	}
> +
>  	hwspin_unlock_raw(data->hwlock);
>  
>  	if (!ret)
> @@ -927,9 +940,11 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>  
>  	/* Enable 26MHz crvstal oscillator wait cycles for UMP9620 ADC */
>  	if (data->var_data->pmic_type == UMP9620_ADC) {
> -		ret = regmap_update_bits(data->regmap, UMP9620_XTL_WAIT_CTRL0,
> -					 UMP9620_XTL_WAIT_CTRL0_EN,
> -					 UMP9620_XTL_WAIT_CTRL0_EN);
> +		pm_runtime_get(data->dev);

Why the queued version?  Is there a race condition, or do we not actually need it
turned on at all at this point?

> +		if (ret) {
> +			dev_err(data->dev, "failed to set the UMP9620 ADC clk26m bit8 on IP\n");

This level of detail may make sense in the implementation of the runtime pm, but it doesn't
make sense here where that detail isn't available.

> +			goto clean_adc_clk26m_bit8;

As such I'd also rename this label.  It's just runtime_get failed - we shouldn't care about
the details here.

> +		}
>  	}
>  
>  	/* Enable ADC work clock */
> @@ -971,6 +986,10 @@ static int sc27xx_adc_enable(struct sc27xx_adc_data *data)
>  	regmap_update_bits(data->regmap, data->var_data->module_en,
>  			   SC27XX_MODULE_ADC_EN, 0);
>  
> +clean_adc_clk26m_bit8:
> +	if (data->var_data->pmic_type == UMP9620_ADC)
> +		pm_runtime_put(data->dev);
> +
>  	return ret;
>  }
>  
> @@ -1069,6 +1088,8 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  	if (!indio_dev)
>  		return -ENOMEM;
>  
> +	platform_set_drvdata(pdev, indio_dev);
> +
>  	sc27xx_data = iio_priv(indio_dev);
>  
>  	sc27xx_data->regmap = dev_get_regmap(dev->parent, NULL);
> @@ -1111,7 +1132,10 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  		}
>  	}
>  
> +	sc27xx_data->dev = dev;
>  	sc27xx_data->var_data = pdata;
> +	sc27xx_data->indio_dev = indio_dev;
Why?  Any time I see the iio_dev pointed to by the iio_priv() data it
rings alarm bells.  There should be no situation where you need to
do this.

> +
>  	sc27xx_data->var_data->init_scale(sc27xx_data);
>  
>  	ret = sc27xx_adc_enable(sc27xx_data);
> @@ -1126,14 +1150,35 @@ static int sc27xx_adc_probe(struct platform_device *pdev)
>  		return ret;
>  	}
>  
> +	indio_dev->dev.parent = dev;
>  	indio_dev->name = dev_name(dev);
>  	indio_dev->modes = INDIO_DIRECT_MODE;
>  	indio_dev->info = &sc27xx_info;
>  	indio_dev->channels = sc27xx_channels;
>  	indio_dev->num_channels = ARRAY_SIZE(sc27xx_channels);
> +
> +	if (sc27xx_data->var_data->pmic_type == UMP9620_ADC) {
> +		pm_runtime_set_autosuspend_delay(dev,
> +						 SC27XX_ADC_AUTOSUSPEND_DELAY);
> +		pm_runtime_use_autosuspend(dev);
> +		pm_runtime_set_suspended(dev);
> +		pm_runtime_enable(dev);
> +		pm_runtime_get(dev);

Why does turning it on here make sense?  If it is already on you can
set the state with pm_runtime_set_active().

> +	}
> +
>  	ret = devm_iio_device_register(dev, indio_dev);
> -	if (ret)
> +	if (ret) {
>  		dev_err(dev, "could not register iio (ADC)");
> +		goto err_iio_register;
> +	}
> +
> +	return 0;
> +
> +err_iio_register:
> +	if (sc27xx_data->var_data->pmic_type == UMP9620_ADC) {
> +		pm_runtime_put(dev);
> +		pm_runtime_disable(dev);
> +	}
>  
>  	return ret;
>  }
> @@ -1148,11 +1193,46 @@ static const struct of_device_id sc27xx_adc_of_match[] = {
>  };
>  MODULE_DEVICE_TABLE(of, sc27xx_adc_of_match);
>  
> +static int sc27xx_adc_runtime_suspend(struct device *dev)
> +{
> +	struct sc27xx_adc_data *sc27xx_data = iio_priv(dev_get_drvdata(dev));
> +
> +	/* clean the UMP9620 ADC clk26m bit8 on IP */
> +	if (sc27xx_data->var_data->pmic_type == UMP9620_ADC)
> +		regmap_update_bits(sc27xx_data->regmap, UMP9620_XTL_WAIT_CTRL0,
> +				UMP9620_XTL_WAIT_CTRL0_EN, 0);
> +
> +	return 0;
> +}
> +
> +static int sc27xx_adc_runtime_resume(struct device *dev)
> +{
> +	int ret = 0;

Value not used, so don't set it.

> +	struct sc27xx_adc_data *sc27xx_data = iio_priv(dev_get_drvdata(dev));
> +
> +	/* set the UMP9620 ADC clk26m bit8 on IP */
> +	if (sc27xx_data->var_data->pmic_type == UMP9620_ADC) {
> +		ret = regmap_update_bits(sc27xx_data->regmap, UMP9620_XTL_WAIT_CTRL0,
> +				UMP9620_XTL_WAIT_CTRL0_EN, UMP9620_XTL_WAIT_CTRL0_EN);
> +		if (ret) {
> +			dev_err(dev, "failed to set the UMP9620 ADC clk26m bit8 on IP\n");
> +			return ret;
> +		}
> +	}
> +
> +	return 0;
> +}
> +
> +static const struct dev_pm_ops sc27xx_adc_pm_ops = {
> +	SET_RUNTIME_PM_OPS(sc27xx_adc_runtime_suspend, sc27xx_adc_runtime_resume, NULL)

I'm curious, could you safely use DEFINE_RUNTIME_DEV_PM_OPS()
which would also supply sleep functions via pm_runtime_force_suspend.
Seems likely to work 'fine' though may not be the best possible implementation
of suspend and resume ops.

Even if not, for new code this should be using the new macro 
RUNTIME_PM_OPS() in conjunction with pm_ptr() below.

> +};
> +
>  static struct platform_driver sc27xx_adc_driver = {
>  	.probe = sc27xx_adc_probe,
>  	.driver = {
>  		.name = "sc27xx-adc",
>  		.of_match_table = sc27xx_adc_of_match,
> +		.pm	= &sc27xx_adc_pm_ops,
pm_ptr()

>  	},
>  };
>  

