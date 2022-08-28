Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 784385A3EDD
	for <lists+linux-kernel@lfdr.de>; Sun, 28 Aug 2022 19:33:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230181AbiH1RdF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 28 Aug 2022 13:33:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53360 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229522AbiH1RdD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 28 Aug 2022 13:33:03 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 540959FEB;
        Sun, 28 Aug 2022 10:33:01 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 0BABDB80B84;
        Sun, 28 Aug 2022 17:33:00 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48EE0C433D6;
        Sun, 28 Aug 2022 17:32:57 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1661707978;
        bh=NfogdBuluk97OPjBMZxoFbvB0ss4BI36KZTSdkl4QQQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Vme9/mJ6gIfaMwlGX7syIHQJkjR8RzUaQkQX5JFB2gS3+tN9cgGuel0hZNpQmeASu
         8SUxOC9gpbU5t7PBvb77HBY0+uvHZze8r3giUTJJC0h29Nbibj5pqZffvVkq7TwuL6
         fQzCH7OVwna6lDc0eFOMRzNeZIh4gY73K2dUf3aY8YJBag9MFFQ6CVz6z6EJsuHYwo
         DJm0wfZdvxSOMsL/pSw2oa87gyL7DjBB3EnaAgQ8dqjmsi5L6HWPXvd5V8dE6ltOtJ
         T7m382bb6RJbUkGL1HEGyw4vx7JCl04q1WVJXrFSJS6U82pEsZYugT0acG4nxFJXDM
         D+lDL4NqkFhdA==
Date:   Sun, 28 Aug 2022 17:58:37 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH 2/2] iio: adc: add max11205 adc driver
Message-ID: <20220828175837.214c5f9d@jic23-huawei>
In-Reply-To: <20220824125203.685287-3-ramona.bolboaca@analog.com>
References: <20220824125203.685287-1-ramona.bolboaca@analog.com>
        <20220824125203.685287-3-ramona.bolboaca@analog.com>
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

On Wed, 24 Aug 2022 15:52:03 +0300
Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:

> Adding support for max11205 16-bit single-channel ultra-low power
> delta-sigma adc.
> The MAX11205 is compatible with the 2-wire interface and uses
> SCLK and RDY/DOUT for serial communica- tions. In this mode, all
> controls are implemented by tim- ing the high or low phase of the SCLK.
> The 2-wire serial interface only allows for data to be read out through the
> RDY/DOUT output.
> 
> Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX11205.pdf
> Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>
A few additional comments from me.

Jonathan

> ---
>  drivers/iio/adc/Kconfig    |  14 +++
>  drivers/iio/adc/Makefile   |   1 +
>  drivers/iio/adc/max11205.c | 192 +++++++++++++++++++++++++++++++++++++
>  3 files changed, 207 insertions(+)
>  create mode 100644 drivers/iio/adc/max11205.c
> 
> diff --git a/drivers/iio/adc/Kconfig b/drivers/iio/adc/Kconfig
> index 7fe5930891e0..f0de4516a302 100644
> --- a/drivers/iio/adc/Kconfig
> +++ b/drivers/iio/adc/Kconfig
> @@ -653,6 +653,20 @@ config MAX1118
>  	  To compile this driver as a module, choose M here: the module will be
>  	  called max1118.
>  
> +config MAX11205
> +	tristate "Maxim max11205 ADC driver"
> +	depends on SPI
> +	select AD_SIGMA_DELTA
> +	select IIO_BUFFER
> +	select IIO_TRIGGERED_BUFFER
> +
> +	help
> +	  Say yes here to build support for Maxim max11205
> +	  16-bit, single-channel ultra-low power delta-sigma ADC.

Wrap consistently to 75-80 chars.

> +
> +	  To compile this driver as a module, choose M here: the module will be
> +	  called max11205.
> +
>  config MAX1241
>  	tristate "Maxim max1241 ADC driver"
>  	depends on SPI_MASTER

...

> diff --git a/drivers/iio/adc/max11205.c b/drivers/iio/adc/max11205.c
> new file mode 100644
> index 000000000000..b2d9f9085fde
> --- /dev/null
> +++ b/drivers/iio/adc/max11205.c
> @@ -0,0 +1,192 @@


> +static const struct ad_sigma_delta_info max11205_sigma_delta_info = {
> +	.has_registers = false,
> +	.irq_flags = IRQF_TRIGGER_FALLING,

Generally IRQ direction should come from firmware (dt etc) as, just because
a device will only provide a particular type of interrupt, it's possible
the board designer did some cheap level conversion or interupt sharing
by putting an inverter in the path to the SoC pin.

We have some historical drivers where we hard coded it (and now can't
change that as there may be boards relying on it) but if possible
avoid introducing it for new drivers.

> +};
,,,

>
> +
> +static void max11205_remove(struct spi_device *spi)
> +{
> +	struct iio_dev *indio_dev = spi_get_drvdata(spi);
> +	struct max11205_state *st = iio_priv(indio_dev);
> +
> +	iio_device_unregister(indio_dev);

As Andy pointed out you have an issue here. Make sure you understand
what the devm_ device managed framework does.


> +	regulator_disable(st->vref);
> +}
> +
> +static const struct spi_device_id max11205_spi_ids[] = {
> +	{"max11205a", TYPE_MAX11205A},
Prefer space after { and before }

	{ "max11205a, TYPE_MAX11205A }, 

Driver doesn't currently support using this probing method though
for a reason that Andy raised.

> +	{"max11205b", TYPE_MAX11205B},
> +	{}
> +};
> +MODULE_DEVICE_TABLE(spi, max11205_spi_ids);
> +


