Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E0DBB4FAE9A
	for <lists+linux-kernel@lfdr.de>; Sun, 10 Apr 2022 17:59:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240408AbiDJQBr (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Apr 2022 12:01:47 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230406AbiDJQBp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Apr 2022 12:01:45 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 210F41DA70;
        Sun, 10 Apr 2022 08:59:33 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 8603BB80D93;
        Sun, 10 Apr 2022 15:59:32 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id AFF06C385A1;
        Sun, 10 Apr 2022 15:59:28 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1649606371;
        bh=nxWSgZ6QV1YNN9V9CNS3iaXkT7YERMhYwVEy9OTmqQY=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=AMxbN4Bjwxhx5BOTYjYk8H8JCh7xcK4BomlOghBawaawO0WMGwU6GsZQn7UyLp+05
         xEyHtYYYv4n57ORmB7NLLBWXaXj5vZV1CW6KGKSw/Yt2QLn/EkXaNUNfJW5Gpcv3pC
         me+1I81/fWZC9nnqc/mHXLUMv4Cbeg5mXJ58ow2GtqI/wGv4yFKufC1e2xt0PxKSVk
         1F2IoIbrPfwqgEIE8irYI6P/xqVzfb+vTOilTQogdGUIBzoX1mphCTlxFMdoSVY5Xb
         /8foDS8HVkt604Iu/hn078utflaJGT/zO2oL8Q1SEqFvV6lup7Oqpw6B3XLWkAlBDp
         EgIvV2/0m/6HA==
Date:   Sun, 10 Apr 2022 17:07:21 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     =?UTF-8?B?TWHDrXJh?= Canal <maira.canal@usp.br>
Cc:     lars@metafoo.de, michael.hennerich@analog.com,
        linux-iio@vger.kernel.org, linux-kernel@vger.kernel.org,
        Marcelo Schmitt <marcelo.schmitt1@gmail.com>,
        Nuno =?UTF-8?B?U8Oh?= <nuno.sa@analog.com>
Subject: Re: [PATCH v2] iio: ad7266: convert probe to full device-managed
Message-ID: <20220410170721.58abd877@jic23-huawei>
In-Reply-To: <20220407115621.10781-1-maira.canal@usp.br>
References: <20220407115621.10781-1-maira.canal@usp.br>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu,  7 Apr 2022 08:56:21 -0300
Ma=C3=ADra Canal <maira.canal@usp.br> wrote:

> Convert probe functions to device-managed variants, with exception of
> the regulator, which required a devm_add_action_or_reset() hook
> registration.
>=20
> Reviewed-by: Marcelo Schmitt <marcelo.schmitt1@gmail.com>
> Reviewed-by: Nuno S=C3=A1 <nuno.sa@analog.com>
> Signed-off-by: Ma=C3=ADra Canal <maira.canal@usp.br>

Nice. I tweaked the subject to be iio: adc: ad7266:=20
I don't always remember to ensure subjects are consistent so you will find
all sorts of minor variants on the titles in IIO, but ideally it takes the
form I've change this one to.

Applied to the togreg branch of iio.git which will be initially pushed out
as testing to let 0-day see if it can find any problems.  If that's fine
I'll push it out as togreg later in the week and that gets picked up
for linux-next.

Thanks,

Jonathan

> ---
>  drivers/iio/adc/ad7266.c | 44 +++++++++++++---------------------------
>  1 file changed, 14 insertions(+), 30 deletions(-)
>=20
> diff --git a/drivers/iio/adc/ad7266.c b/drivers/iio/adc/ad7266.c
> index c17d9b5fbaf6..f20d39f0bc01 100644
> --- a/drivers/iio/adc/ad7266.c
> +++ b/drivers/iio/adc/ad7266.c
> @@ -378,6 +378,11 @@ static const char * const ad7266_gpio_labels[] =3D {
>  	"ad0", "ad1", "ad2",
>  };
> =20
> +static void ad7266_reg_disable(void *reg)
> +{
> +	regulator_disable(reg);
> +}
> +
>  static int ad7266_probe(struct spi_device *spi)
>  {
>  	struct ad7266_platform_data *pdata =3D spi->dev.platform_data;
> @@ -398,9 +403,13 @@ static int ad7266_probe(struct spi_device *spi)
>  		if (ret)
>  			return ret;
> =20
> +		ret =3D devm_add_action_or_reset(&spi->dev, ad7266_reg_disable, st->re=
g);
> +		if (ret)
> +			return ret;
> +
>  		ret =3D regulator_get_voltage(st->reg);
>  		if (ret < 0)
> -			goto error_disable_reg;
> +			return ret;
> =20
>  		st->vref_mv =3D ret / 1000;
>  	} else {
> @@ -423,7 +432,7 @@ static int ad7266_probe(struct spi_device *spi)
>  						      GPIOD_OUT_LOW);
>  				if (IS_ERR(st->gpios[i])) {
>  					ret =3D PTR_ERR(st->gpios[i]);
> -					goto error_disable_reg;
> +					return ret;
>  				}
>  			}
>  		}
> @@ -433,7 +442,6 @@ static int ad7266_probe(struct spi_device *spi)
>  		st->mode =3D AD7266_MODE_DIFF;
>  	}
> =20
> -	spi_set_drvdata(spi, indio_dev);
>  	st->spi =3D spi;
> =20
>  	indio_dev->name =3D spi_get_device_id(spi)->name;
> @@ -459,35 +467,12 @@ static int ad7266_probe(struct spi_device *spi)
>  	spi_message_add_tail(&st->single_xfer[1], &st->single_msg);
>  	spi_message_add_tail(&st->single_xfer[2], &st->single_msg);
> =20
> -	ret =3D iio_triggered_buffer_setup(indio_dev, &iio_pollfunc_store_time,
> +	ret =3D devm_iio_triggered_buffer_setup(&spi->dev, indio_dev, &iio_poll=
func_store_time,
>  		&ad7266_trigger_handler, &iio_triggered_buffer_setup_ops);
>  	if (ret)
> -		goto error_disable_reg;
> -
> -	ret =3D iio_device_register(indio_dev);
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
> -	struct iio_dev *indio_dev =3D spi_get_drvdata(spi);
> -	struct ad7266_state *st =3D iio_priv(indio_dev);
> +		return ret;
> =20
> -	iio_device_unregister(indio_dev);
> -	iio_triggered_buffer_cleanup(indio_dev);
> -	if (!IS_ERR(st->reg))
> -		regulator_disable(st->reg);
> +	return devm_iio_device_register(&spi->dev, indio_dev);
>  }
> =20
>  static const struct spi_device_id ad7266_id[] =3D {
> @@ -502,7 +487,6 @@ static struct spi_driver ad7266_driver =3D {
>  		.name	=3D "ad7266",
>  	},
>  	.probe		=3D ad7266_probe,
> -	.remove		=3D ad7266_remove,
>  	.id_table	=3D ad7266_id,
>  };
>  module_spi_driver(ad7266_driver);

