Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C756859ADE9
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 14:31:28 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346379AbiHTMbW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 20 Aug 2022 08:31:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59566 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345769AbiHTMbT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 20 Aug 2022 08:31:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 552231054C;
        Sat, 20 Aug 2022 05:31:16 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id CB03A6123B;
        Sat, 20 Aug 2022 12:31:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id CA29DC433D6;
        Sat, 20 Aug 2022 12:31:12 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1660998675;
        bh=Q7HkaVpw73+qdb/ZssCELVufl4/sqZYU7DccPj0VY0U=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Av+9dCDcK4VGU/nX+lKWGQn5ubXXk/pyDBKca5v4mhpBRH/gOcf+Lhpf9VlEeIbGd
         PdR7rTsPggcruxkjRHIwYBSM8gHLprIjNzZV9KHz3QQeRiVS/1gh7xoqH7o7yP5O3x
         RKkzLXDtMhiwz1RYt+YU51k7e+lHQYy0u+NQZZWx2hsWlkPSvXJOUkXcNQClrs/gu/
         VtrZlC82kool1Wx9agFCppyNaLE7Sj+MI7jF6UXheZp0FXKeq9opwnHFBGxJFlkPwr
         5VKiLNhznhOgjDxxo/ZfQvNJvOmngKT0XWe5BOnnBI9GfLP5OD5SZfVGVlhvyUZEhE
         uv7HUynxE3+bA==
Date:   Sat, 20 Aug 2022 13:41:50 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Andy Shevchenko <andy.shevchenko@gmail.com>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v6 4/9] iio: adc: mcp3911: use resource-managed version
 of iio_device_register
Message-ID: <20220820134150.2b45339c@jic23-huawei>
In-Reply-To: <20220815061625.35568-5-marcus.folkesson@gmail.com>
References: <20220815061625.35568-1-marcus.folkesson@gmail.com>
        <20220815061625.35568-5-marcus.folkesson@gmail.com>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 15 Aug 2022 08:16:20 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Keep using managed resources as much as possible.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> ---
>  drivers/iio/adc/mcp3911.c | 53 ++++++++++++---------------------------
>  1 file changed, 16 insertions(+), 37 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 890af7dca62d..7e2efe702e57 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -258,6 +258,13 @@ static int mcp3911_config(struct mcp3911 *adc)
>  	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
>  }
>  
> +static void mcp3911_cleanup_regulator(void *_adc)

Missed this on previous versions, but why not pass
the regulator pointer in as the parameter for the callback?

static void mcp391_cleanup_regulator(void *reg)
{
	regulator_disable(adc->vref);
}

Note this can't use the new devm_regulator_get_enable()
because we need access to the regulator within the driver.

I can tidy this up whilst applying (or given it's really minor I might
not bother :)

Note we are stalled at the moment with this series on getting the
fixes upstream.  I'll probably send that pull request shortly.

> +{
> +	struct mcp3911 *adc = _adc;
> +
> +	regulator_disable(adc->vref);
> +}
> +
>  static int mcp3911_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -286,9 +293,14 @@ static int mcp3911_probe(struct spi_device *spi)
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
> -	adc->clki = devm_clk_get(&adc->spi->dev, NULL);
> +	adc->clki = devm_clk_get_enabled(&adc->spi->dev, NULL);
>  	if (IS_ERR(adc->clki)) {
>  		if (PTR_ERR(adc->clki) == -ENOENT) {
>  			adc->clki = NULL;
> @@ -296,21 +308,13 @@ static int mcp3911_probe(struct spi_device *spi)
>  			dev_err(&adc->spi->dev,
>  				"failed to get adc clk (%ld)\n",
>  				PTR_ERR(adc->clki));
> -			ret = PTR_ERR(adc->clki);
> -			goto reg_disable;
> -		}
> -	} else {
> -		ret = clk_prepare_enable(adc->clki);
> -		if (ret < 0) {
> -			dev_err(&adc->spi->dev,
> -				"Failed to enable clki: %d\n", ret);
> -			goto reg_disable;
> +			return PTR_ERR(adc->clki);
>  		}
>  	}
>  
>  	ret = mcp3911_config(adc);
>  	if (ret)
> -		goto clk_disable;
> +		return ret;
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -322,31 +326,7 @@ static int mcp3911_probe(struct spi_device *spi)
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
> -}
> -
> -static void mcp3911_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> -	struct mcp3911 *adc = iio_priv(indio_dev);
> -
> -	iio_device_unregister(indio_dev);
> -
> -	clk_disable_unprepare(adc->clki);
> -	if (adc->vref)
> -		regulator_disable(adc->vref);
> +	return devm_iio_device_register(&adc->spi->dev, indio_dev);
>  }
>  
>  static const struct of_device_id mcp3911_dt_ids[] = {
> @@ -367,7 +347,6 @@ static struct spi_driver mcp3911_driver = {
>  		.of_match_table = mcp3911_dt_ids,
>  	},
>  	.probe = mcp3911_probe,
> -	.remove = mcp3911_remove,
>  	.id_table = mcp3911_id,
>  };
>  module_spi_driver(mcp3911_driver);

