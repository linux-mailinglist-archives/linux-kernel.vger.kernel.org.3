Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A9A81585FD9
	for <lists+linux-kernel@lfdr.de>; Sun, 31 Jul 2022 18:29:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232102AbiGaQ3V (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 31 Jul 2022 12:29:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229674AbiGaQ3U (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 31 Jul 2022 12:29:20 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 46131EE1E;
        Sun, 31 Jul 2022 09:29:19 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id DEAD160DE2;
        Sun, 31 Jul 2022 16:29:18 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id C5298C433D6;
        Sun, 31 Jul 2022 16:29:15 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1659284958;
        bh=JthxeVFbfuzHSO33MDR1TYklhGOPp63bRbDdZ78ZHaM=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lGiQslx/VYA4rdAXbqi4fQ8TOLCyA90OD7AOWNXSDAO0gdidvYXfopnG6s00RU+gL
         GIQjv16LA/NOQl5eIIP4Jv/4Xqp/elVNaIf2HHYIrVwBRDyyHowtpZnGk1i7t64jQB
         SO38gIjsGXs2Ipjg0g9zbZwLw4RhxQnGZ8q30I6SP/uY/xd71XQ8JEHEXTDovccC0M
         TiI6x7/8wsEeCFmawKLWLLT/gWZYwHZJ2alDBBN8PUo9Rq3zBq9xG77CdCpViurwRJ
         aJZzj2O/pvd7Xw3NobsxwKI0Ml5ikrdbWraw14CKBxXN/G+CZSU3akM8Z0na3xNqm7
         UKPwwvLZzxvjQ==
Date:   Sun, 31 Jul 2022 17:39:29 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v4 4/9] iio: adc: mcp3911: use resource-managed version
 of iio_device_register
Message-ID: <20220731173929.473bbf2e@jic23-huawei>
In-Reply-To: <20220722130726.7627-5-marcus.folkesson@gmail.com>
References: <20220722130726.7627-1-marcus.folkesson@gmail.com>
        <20220722130726.7627-5-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Fri, 22 Jul 2022 15:07:21 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Keep using managed resources as much as possible.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/adc/Kconfig   |  2 ++
>  drivers/iio/adc/mcp3911.c | 51 ++++++++++++++++++++-------------------
>  2 files changed, 28 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7fe5930891e0..3b5db59f3931 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -718,6 +718,8 @@ config MCP3422
>  config MCP3911
>  	tristate "Microchip Technology MCP3911 driver"
>  	depends on SPI
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER

This is unrelated to the devm cleanups, so should be in the patch that
introduces the code that needs them (next patch I think).

Thanks,

Jonathan



>  	help
>  	  Say yes here to build support for Microchip Technology's MCP3911
>  	  analog to digital converter.
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 890af7dca62d..00dadb1761dc 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -258,6 +258,18 @@ static int mcp3911_config(struct mcp3911 *adc)
>  	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
>  }
>  
> +static void mcp3911_cleanup_clock(void *_adc)
> +{
> +	struct mcp3911 *adc = _adc;
> +	clk_disable_unprepare(adc->clki);
> +}
> +
> +static void mcp3911_cleanup_regulator(void *_adc)
> +{
> +	struct mcp3911 *adc = _adc;
> +	regulator_disable(adc->vref);
> +}
> +
>  static int mcp3911_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -286,6 +298,11 @@ static int mcp3911_probe(struct spi_device *spi)
>  		ret = regulator_enable(adc->vref);
>  		if (ret)
>  			return ret;
> +
> +		ret = devm_add_action_or_reset(&spi->dev,
> +				mcp3911_cleanup_regulator, adc);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	adc->clki = devm_clk_get(&adc->spi->dev, NULL);
> @@ -296,21 +313,25 @@ static int mcp3911_probe(struct spi_device *spi)
>  			dev_err(&adc->spi->dev,
>  				"failed to get adc clk (%ld)\n",
>  				PTR_ERR(adc->clki));
> -			ret = PTR_ERR(adc->clki);
> -			goto reg_disable;
> +			return PTR_ERR(adc->clki);
>  		}
>  	} else {
>  		ret = clk_prepare_enable(adc->clki);
>  		if (ret < 0) {
>  			dev_err(&adc->spi->dev,
>  				"Failed to enable clki: %d\n", ret);
> -			goto reg_disable;
> +			return ret;
>  		}
> +
> +		ret = devm_add_action_or_reset(&spi->dev,
> +				mcp3911_cleanup_clock, adc);
> +		if (ret)
> +			return ret;
>  	}
>  
>  	ret = mcp3911_config(adc);
>  	if (ret)
> -		goto clk_disable;
> +		return ret;
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -322,31 +343,11 @@ static int mcp3911_probe(struct spi_device *spi)
>  
>  	mutex_init(&adc->lock);
>  
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto clk_disable;
> -
> -	return ret;
> -
> -clk_disable:
> -	clk_disable_unprepare(adc->clki);
> -reg_disable:
> -	if (adc->vref)
> -		regulator_disable(adc->vref);
> -
> -	return ret;
> +	return devm_iio_device_register(&adc->spi->dev, indio_dev);
>  }
>  
>  static void mcp3911_remove(struct spi_device *spi)
>  {
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct mcp3911 *adc = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	clk_disable_unprepare(adc->clki);
> -	if (adc->vref)
> -		regulator_disable(adc->vref);
>  }
>  
>  static const struct of_device_id mcp3911_dt_ids[] = {

