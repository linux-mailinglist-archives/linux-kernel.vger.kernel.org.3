Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0B8B7577059
	for <lists+linux-kernel@lfdr.de>; Sat, 16 Jul 2022 19:12:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231319AbiGPRMo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 16 Jul 2022 13:12:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35458 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229558AbiGPRMm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 16 Jul 2022 13:12:42 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 12501205F8;
        Sat, 16 Jul 2022 10:12:42 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id A4B62611A6;
        Sat, 16 Jul 2022 17:12:41 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id DE4ACC34114;
        Sat, 16 Jul 2022 17:12:38 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1657991561;
        bh=QqiZZQTVSZ0tfmZYds66sL+4hp+9gkTchdBIv7flkQ0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=U7P4pQ6KBqpJpWfTRPFRIK5A50BHmJHxbAr2XEdNLKGYVcB8wFfiWsb3BMp2iGXlr
         sHSZIf7cfkpuiHtIMXDn6AdUMWJ+vO1KOH+BsfvmQCVoIqg3ef5mCjsxFhG3l3GcSo
         AqvJcTwP/CShTPPNM+WgakqCdUr+dnDChBjzy/5Zv5g3HsWSVLTtFMiVy/fK0YTfhW
         cBv8demJPdwFEgoWHuFMfE05RrnQ2ZQEKk5+QPc+9Jk6FbcYXOJ1u1MxJeOuEKIABl
         /KdU81weXMcnX7XcFYKF7GPSP136m6dsz7D+tymJT/U0irU+F0+cA6yRHC1SPAiKCM
         vtCQvwW4emvxQ==
Date:   Sat, 16 Jul 2022 18:22:32 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Marcus Folkesson <marcus.folkesson@gmail.com>
Cc:     Kent Gustavsson <kent@minoris.se>,
        Lars-Peter Clausen <lars@metafoo.de>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-iio@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH v3 4/9] iio: adc: mcp3911: use resource-managed version
 of iio_device_register
Message-ID: <20220716182232.5e7da71c@jic23-huawei>
In-Reply-To: <20220704172116.195841-5-marcus.folkesson@gmail.com>
References: <20220704172116.195841-1-marcus.folkesson@gmail.com>
        <20220704172116.195841-5-marcus.folkesson@gmail.com>
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

On Mon,  4 Jul 2022 19:21:11 +0200
Marcus Folkesson <marcus.folkesson@gmail.com> wrote:

> Keep using managed resources as much as possible.
> 
> Signed-off-by: Marcus Folkesson <marcus.folkesson@gmail.com>
> ---
>  drivers/iio/adc/mcp3911.c | 43 ++++++++++++++++-----------------------
>  1 file changed, 18 insertions(+), 25 deletions(-)
> 
> diff --git a/drivers/iio/adc/mcp3911.c b/drivers/iio/adc/mcp3911.c
> index 890af7dca62d..f5fd9da6ab55 100644
> --- a/drivers/iio/adc/mcp3911.c
> +++ b/drivers/iio/adc/mcp3911.c
> @@ -258,6 +258,16 @@ static int mcp3911_config(struct mcp3911 *adc)
>  	return  mcp3911_write(adc, MCP3911_REG_CONFIG, configreg, 2);
>  }
>  
> +static void mcp3911_cleanup(void *_adc)

Very rarely a good idea to cleanup more than one thing in a given
devm_ callback.

> +{
> +	struct mcp3911 *adc = _adc;
> +
> +	if (adc->clki)
> +		clk_disable_unprepare(adc->clki);
> +	if (adc->vref)
> +		regulator_disable(adc->vref);
> +}
> +
>  static int mcp3911_probe(struct spi_device *spi)
>  {
>  	struct iio_dev *indio_dev;
> @@ -271,6 +281,10 @@ static int mcp3911_probe(struct spi_device *spi)
>  	adc = iio_priv(indio_dev);
>  	adc->spi = spi;
>  
> +	ret = devm_add_action_or_reset(&spi->dev, mcp3911_cleanup, adc);
> +	if (ret)
> +		return ret;

You should only register this 'after' what it cleans up.  I want to see
a clear pairing between setup and tear down.

In this particular case register two callbacks, and only register them
if they have anything to do. i.e. the ->clki and ->vref are not null
respectively.

Jonathan


> +
>  	adc->vref = devm_regulator_get_optional(&adc->spi->dev, "vref");
>  	if (IS_ERR(adc->vref)) {
>  		if (PTR_ERR(adc->vref) == -ENODEV) {
> @@ -296,21 +310,20 @@ static int mcp3911_probe(struct spi_device *spi)
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
>  	}
>  
>  	ret = mcp3911_config(adc);
>  	if (ret)
> -		goto clk_disable;
> +		return ret;
>  
>  	indio_dev->name = spi_get_device_id(spi)->name;
>  	indio_dev->modes = INDIO_DIRECT_MODE;
> @@ -322,31 +335,11 @@ static int mcp3911_probe(struct spi_device *spi)
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

