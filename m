Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6822C4F7332
	for <lists+linux-kernel@lfdr.de>; Thu,  7 Apr 2022 05:23:03 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240518AbiDGDWi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 23:22:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240218AbiDGDWR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 23:22:17 -0400
Received: from mail-oa1-x31.google.com (mail-oa1-x31.google.com [IPv6:2001:4860:4864:20::31])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3142616DB40;
        Wed,  6 Apr 2022 20:18:51 -0700 (PDT)
Received: by mail-oa1-x31.google.com with SMTP id 586e51a60fabf-deb9295679so5061703fac.6;
        Wed, 06 Apr 2022 20:18:51 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=date:from:to:cc:subject:message-id:references:mime-version
         :content-disposition:content-transfer-encoding:in-reply-to;
        bh=Ght5nf/a4dd18hL/qQGiRQ0l2PUenbK59ohuTXpkg0o=;
        b=Dv8okZfyOs2s0q2/Z78x2+XI9s6CaEcMsYk1Az8nM+XqlkMagXv/5mq3V5dNX+umM9
         0Kw3E3P4bDoHQhJnqClhhbAKLYrI6hcMS4k0RgDsmu4W6ZOXUbgb6Rr3EONy6X+UVNHq
         GCiM5hPmOutuqV6/Y7ojfnA5bhkGNrwWd2uTuUtpSHcAGhJqg50sUTYRi3nZTkC4MRbf
         vq4Dt4VEPGAPEPL9Dnrcjw+hJls++oIeDPRTMSdQnD6upj02mUmc1IV0W6GkyxAwBCsj
         xWzp+IjMfxDX8MRDBMIuIqlnJHPZQ2NHtfWlQcffCWBq5vYb9CORX314wPkQaAQQR6s0
         oZRA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:date:from:to:cc:subject:message-id:references
         :mime-version:content-disposition:content-transfer-encoding
         :in-reply-to;
        bh=Ght5nf/a4dd18hL/qQGiRQ0l2PUenbK59ohuTXpkg0o=;
        b=Ac/THa6SwuDNn8SScZV1A+AnZqXJGbLL+4i5HU1CVcU0NaXakoEGscKschVc380ups
         T4/zJHoP0Ha5IeoFMBy3A+00g6thezV0avYogtGrDPhvegyZos4e4NpGci1tJbBQQAJT
         2GWHUOzgP68urrDShgF3wgEDANzXaJybIFMGlAuv+QiSYCVAUQQDBM6egLiRgqYVJ8lb
         9nwMkPOjR1GtZdJ7XPFl21oG/I6Is3ahaE9Jz35nkFsOxRvwMchMtbgnPhxLvwRLAuOK
         G9WGkPzzdnfMGqdaTn6FaD36s2/BAQFcO2FNcaoYhA9ftgMOHq5D6cBlRiBIe4uwVLIL
         RmEA==
X-Gm-Message-State: AOAM533gJX1GQv7HHwDPHPYkugZu7mLNNN24pW5/oQXI7zGooc1FDGo/
        /GN7Fd/TNCrk2JOFDUcHqJ0NqeQ/116P7Q==
X-Google-Smtp-Source: ABdhPJymA4SB9+L1Q3Dfdub2VvN+0hBq3wh8/JHQficiSIa4fEZw2pHyudJEcki3iyYiIJeLJyo6fQ==
X-Received: by 2002:a05:6870:5705:b0:e1:de1d:1f81 with SMTP id k5-20020a056870570500b000e1de1d1f81mr5635440oap.249.1649301530397;
        Wed, 06 Apr 2022 20:18:50 -0700 (PDT)
Received: from marsc.168.1.7 ([2804:30c:b6b:3900:e3fc:1545:cb91:17fb])
        by smtp.gmail.com with ESMTPSA id u139-20020acaab91000000b002ecb2639985sm7116752oie.20.2022.04.06.20.18.48
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 06 Apr 2022 20:18:49 -0700 (PDT)
Date:   Thu, 7 Apr 2022 00:18:46 -0300
From:   Marcelo Schmitt <marcelo.schmitt1@gmail.com>
To:     =?iso-8859-1?Q?Ma=EDra?= Canal <maira.canal@usp.br>
Cc:     michael.hennerich@analog.com, lars@metafoo.de, jic23@kernel.org,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH] iio: ad7266: convert probe to full device-managed
Message-ID: <Yk5YFrp3etcJBF6A@marsc.168.1.7>
References: <Yk2t5D2x2+YorkTd@fedora>
MIME-Version: 1.0
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: 8bit
In-Reply-To: <Yk2t5D2x2+YorkTd@fedora>
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi Maíra,

On 04/06, Maíra Canal wrote:
> Convert probe functions to device-managed variants, with exception of
> the regulator, which required a devm_add_action_or_reset() hook
> registration.
> 
> Signed-off-by: Maíra Canal <maira.canal@usp.br>

Nice patch!
Minor nit inline.

Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>

> ---
> I apologize if you received this email more than once. For some reason, the
> patch is not showing up on the linux-iio mailing list. I believe that the
> problem was that Michael's Hennerich email on the MAINTAINERS list was
> Michael.Hennerich@analog.com instead of michael.hennerich@analog.com. Anyway,
> I am truly sorry with you received this email more than once.
> ---
>  drivers/iio/adc/ad7266.c | 43 +++++++++++++---------------------------
>  1 file changed, 14 insertions(+), 29 deletions(-)
> 
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index c17d9b5fbaf6..4f8f07d5c1a3 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -378,6 +378,11 @@ static const char * const ad7266_gpio_labels[] = {
>  	"ad0", "ad1", "ad2",
>  };
>  
> +static void ad7266_reg_disable(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
>  static int ad7266_probe(struct spi_device *spi)
>  {
>  	struct ad7266_platform_data *pdata = spi->dev.platform_data;
> @@ -398,9 +403,13 @@ static int ad7266_probe(struct spi_device *spi)
>  		if (ret)
>  			return ret;
>  
> +		ret = devm_add_action_or_reset(&spi->dev, ad7266_reg_disable, st->reg);
> +		if (ret)
> +			return ret;
> +
>  		ret = regulator_get_voltage(st->reg);
>  		if (ret < 0)
> -			goto error_disable_reg;
> +			return ret;
>  
>  		st->vref_mv = ret / 1000;
>  	} else {
> @@ -423,7 +432,7 @@ static int ad7266_probe(struct spi_device *spi)
>  						      GPIOD_OUT_LOW);
>  				if (IS_ERR(st->gpios[i])) {
>  					ret = PTR_ERR(st->gpios[i]);
> -					goto error_disable_reg;
> +					return ret;
>  				}
>  			}
>  		}
> @@ -459,35 +468,12 @@ static int ad7266_probe(struct spi_device *spi)
>  	spi_message_add_tail(&st->single_xfer[1], &st->single_msg);
>  	spi_message_add_tail(&st->single_xfer[2], &st->single_msg);
>  
> -	ret = iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +	ret = devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, &iio_pollfunc_store_time,
>  		&ad7266_trigger_handler, &iio_triggered_buffer_setup_ops);
>  	if (ret)
> -		goto error_disable_reg;
> -
> -	ret = iio_device_register(indio_dev);
> -	if (ret)
> -		goto error_buffer_cleanup;
> -
> -	return 0;
> -
> -error_buffer_cleanup:
> -	iio_triggered_buffer_cleanup(indio_dev);
> -error_disable_reg:
> -	if (!IS_ERR(st->reg))
> -		regulator_disable(st->reg);
> -
> -	return ret;
> -}
> -
> -static void ad7266_remove(struct spi_device *spi)
> -{
> -	struct iio_dev *indio_dev = spi_get_drvdata(spi);
With this removal, there is no other usage of driver_data so you may also remove
spi_set_drvdata(spi, indio_dev);

> -	struct ad7266_state *st = iio_priv(indio_dev);
> +		return ret;
>  
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	if (!IS_ERR(st->reg))
> -		regulator_disable(st->reg);
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
>  
>  static const struct spi_device_id ad7266_id[] = {
> @@ -502,7 +488,6 @@ static struct spi_driver ad7266_driver = {
>  		.name	= "ad7266",
>  	},
>  	.probe		= ad7266_probe,
> -	.remove		= ad7266_remove,
>  	.id_table	= ad7266_id,
>  };
>  module_spi_driver(ad7266_driver);
> -- 
> 2.35.1
> 
