Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 144555AC569
	for <lists+linux-kernel@lfdr.de>; Sun,  4 Sep 2022 18:26:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234592AbiIDQ0B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 4 Sep 2022 12:26:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229596AbiIDQZ7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 4 Sep 2022 12:25:59 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C795832B9E;
        Sun,  4 Sep 2022 09:25:54 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 6524A60FC6;
        Sun,  4 Sep 2022 16:25:54 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 351CAC433C1;
        Sun,  4 Sep 2022 16:25:51 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1662308753;
        bh=/ywGo6+O9qSkIDxMvanfumzxcybk0P0hGmwfPWknuqE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=L9/wZuZ4w4cgcjs0v/cTLvPe7X7RiL0ypfwdIqWIgEgJ1vS0/8HbUv6gwHTTOSpTO
         WlU0QBv+JgrBYaFBdanMFiTPw2NHR0DXCBYKPmL6cGjM0w8Ktcv7mBBgoLbcVhkG2T
         kTXkwGXirJ0sZTc+6+XYUy6CiZ6H5IDdoErVh7E9qNiWQEQaLf4kgJPbOUdPYG93zM
         E19nm4bz7zh0JSf5sRxbXkJDP7t96NXMvKV+2F6F4J7WC6/VZzoQlcv30mZQplCbMh
         qIuEa5WBNaSq0/8Gkrq83nX/bIM2m4EYMuS8SVMtWwnHz/uv5CW3ViZf/ymYa9Jjnr
         Xcw7ax6blj1Sg==
Date:   Sun, 4 Sep 2022 16:51:45 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Ramona Bolboaca <ramona.bolboaca@analog.com>
Cc:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <linux-iio@vger.kernel.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>
Subject: Re: [PATCH v2 2/2] iio: adc: add max11205 adc driver
Message-ID: <20220904165145.39cb4f75@jic23-huawei>
In-Reply-To: <20220904165003.192d5030@jic23-huawei>
References: <20220831133021.215625-1-ramona.bolboaca@analog.com>
        <20220831133021.215625-2-ramona.bolboaca@analog.com>
        <20220904165003.192d5030@jic23-huawei>
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

On Sun, 4 Sep 2022 16:50:03 +0100
Jonathan Cameron <jic23@kernel.org> wrote:

> On Wed, 31 Aug 2022 16:30:21 +0300
> Ramona Bolboaca <ramona.bolboaca@analog.com> wrote:
> 
> > Adding support for max11205 16-bit single-channel ultra-low power
> > delta-sigma adc.
> > The MAX11205 is compatible with the 2-wire interface and uses
> > SCLK and RDY/DOUT for serial communications. In this mode, all
> > controls are implemented by timing the high or low phase of the SCLK.
> > The 2-wire serial interface only allows for data to be read out through
> > the RDY/DOUT output.
> > 
> > Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX11205.pdf
> > Signed-off-by: Ramona Bolboaca <ramona.bolboaca@analog.com>  
> 
> Given the requested changes below and those from Andy and Kryzstof are minor, I'll just
> tweak them whilst applying.

On that note, applied to the togreg branch of iio.git (with changes as noted)
and pushed out as testing for 0-day to see if it can find anything we missed.

Thanks,

Jonathan

> 
> Diff for this patch was below.  The long line for chip_info is a bit ugly but
> not too bad...
> 
> diff --git a/drivers/iio/adc/max11205.c b/drivers/iio/adc/max11205.c
> index 68e6082e70e5..fc90fed81eb6 100644
> --- a/drivers/iio/adc/max11205.c
> +++ b/drivers/iio/adc/max11205.c
> @@ -1,6 +1,6 @@
>  // SPDX-License-Identifier: GPL-2.0
>  /*
> - * max11205 16-Bit Delta-Sigma ADC
> + * Maxim MAX11205 16-Bit Delta-Sigma ADC
>   *
>   * Datasheet: https://datasheets.maximintegrated.com/en/ds/MAX1240-max11205.pdf
>   * Copyright (C) 2022 Analog Devices, Inc.
> @@ -19,20 +19,20 @@
>  #define MAX11205A_OUT_DATA_RATE        116
>  #define MAX11205B_OUT_DATA_RATE        13
>  
> -enum chip_type {
> +enum max11205_chip_type {
>         TYPE_MAX11205A,
>         TYPE_MAX11205B,
>  };
>  
> -struct chip_info {
> +struct max11205_chip_info {
>         unsigned int    out_data_rate;
>         const char      *name;
>  };
>  
>  struct max11205_state {
> -       const struct chip_info  *chip_info;
> -       struct regulator        *vref;
> -       struct ad_sigma_delta   sd;
> +       const struct max11205_chip_info *chip_info;
> +       struct regulator                *vref;
> +       struct ad_sigma_delta           sd;
>  };
>  
>  static const struct ad_sigma_delta_info max11205_sigma_delta_info = {
> @@ -81,12 +81,12 @@ static const struct iio_chan_spec max11205_channels[] = {
>                         .endianness = IIO_BE
>                 },
>                 .info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> -               BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> -               BIT(IIO_CHAN_INFO_SCALE),
> +                                     BIT(IIO_CHAN_INFO_SAMP_FREQ) |
> +                                     BIT(IIO_CHAN_INFO_SCALE),
>         },
>  };
>  
> -static const struct chip_info max11205_chip_info[] = {
> +static const struct max11205_chip_info max11205_chip_info[] = {
>         [TYPE_MAX11205A] = {
>                 .out_data_rate = MAX11205A_OUT_DATA_RATE,
>                 .name = "max11205a",
> @@ -117,9 +117,9 @@ static int max11205_probe(struct spi_device *spi)
>         ad_sd_init(&st->sd, indio_dev, spi, &max11205_sigma_delta_info);
>  
>         st->chip_info = device_get_match_data(&spi->dev);
> -
>         if (!st->chip_info)
> -               st->chip_info = (const struct chip_info *)spi_get_device_id(spi)->driver_data;
> +               st->chip_info =
> +                       (const struct max11205_chip_info *)spi_get_device_id(spi)->driver_data;
>  
>         indio_dev->name = st->chip_info->name;
>         indio_dev->modes = INDIO_DIRECT_MODE;
> 
> > ---
> > changes in v2:
> >  - add chip_info null pointer check
> >  - add support for probing with ACPI table
> >  - remove function for module removal
> >  - remove irq flag from max11205_sigma_delta_info
> >  - add missing commas and missing spaces
> >  - remove redundant blank line
> >  - wrap text to 75-80 chars
> >  - removed typos in commit message
> >  drivers/iio/adc/Kconfig    |  14 +++
> >  drivers/iio/adc/Makefile   |   1 +
> >  drivers/iio/adc/max11205.c | 183 +++++++++++++++++++++++++++++++++++++
> >  3 files changed, 198 insertions(+)
> >  create mode 100644 drivers/iio/adc/max11205.c
> >   
> 
> > +enum chip_type {
> > +	TYPE_MAX11205A,
> > +	TYPE_MAX11205B,
> > +};
> > +
> > +struct chip_info {
> > +	unsigned int	out_data_rate;
> > +	const char	*name;
> > +};  
> Prefix these enums and structures with max11205.
> 
> They have very generic names, so it's definitely possible that
> something with the same name might be added to a header included
> by this driver
> > +
> > +struct max11205_state {
> > +	const struct chip_info	*chip_info;
> > +	struct regulator	*vref;
> > +	struct ad_sigma_delta	sd;
> > +};
> > +  
> 
> 
> > +static const struct iio_chan_spec max11205_channels[] = {
> > +	{
> > +		.type = IIO_VOLTAGE,
> > +		.indexed = 1,
> > +		.scan_type = {
> > +			.sign = 's',
> > +			.realbits = 16,
> > +			.storagebits = 16,
> > +			.endianness = IIO_BE
> > +		},
> > +		.info_mask_separate = BIT(IIO_CHAN_INFO_RAW) |
> > +		BIT(IIO_CHAN_INFO_SAMP_FREQ) |  
> 
> Code editors always get confused on these, but please add an
> indent to this line and the next one. Either align it with the BIT()
> above, or just push it in one tab.
> 
> > +		BIT(IIO_CHAN_INFO_SCALE),
> > +	},
> > +};  
> 
> 

