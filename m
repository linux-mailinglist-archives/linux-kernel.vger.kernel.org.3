Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1DB94C5783
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Feb 2022 19:33:39 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232606AbiBZSeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Feb 2022 13:34:11 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60186 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230402AbiBZSeK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Feb 2022 13:34:10 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4BBAD18C7AB;
        Sat, 26 Feb 2022 10:33:35 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id E8202B80860;
        Sat, 26 Feb 2022 18:33:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 43758C340E8;
        Sat, 26 Feb 2022 18:33:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645900412;
        bh=lSu0A1Wi4WCquwkc+g3+bvWBkVSP1arWBzs+Q13OS98=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eVjb2Hh6gbxL7jo2jmVewblhyT+0ZAEfbzsOxYsYIf48yllP0BagzI6gRc/niGn+/
         wnYRjEKd3P1iFBlSbwpFDnCYmE1GE2x1oIVZp5XY3sSMRKy8n0azHoV5hv9kayhAHz
         7a6YLiAtSAzieKsw9I/AfI7LI536J2F/laDdYEN2a4tQ+vHkFoJ7Vma+6ILXgt0wPY
         GeEx3ULus33PnAwW1Y6tfEas9DVlUQJXAAUrsJxbnSLLiZ2rXkLrAqkYy8Y3atmSka
         ph1Te8J+B5nH5k/hYUl7DUF27DO6N3qi0/Cp61waD8uL9xhsnPULRSVSwNw56PNSFb
         SD05Qfguylmfg==
Date:   Sat, 26 Feb 2022 18:40:33 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     Jagath Jog J <jagathjog1996@gmail.com>
Cc:     lars@metafoo.de, andy.shevchenko@gmail.com, sst@poczta.fm,
        robh+dt@kernel.org, linux-iio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v5 2/7] iio: potentiometer: Add available functionality
Message-ID: <20220226184033.5ec94a17@jic23-huawei>
In-Reply-To: <20220223163525.13399-3-jagathjog1996@gmail.com>
References: <20220223163525.13399-1-jagathjog1996@gmail.com>
        <20220223163525.13399-3-jagathjog1996@gmail.com>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
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

On Wed, 23 Feb 2022 22:05:20 +0530
Jagath Jog J <jagathjog1996@gmail.com> wrote:

> Adding available functionality for DS1803 driver which
> will show the minimum, step and maximum values that the
> driver can accepts through sysfs entry.
> Now using the max value present in avail array instead of chip
> type specific macro to make the driver flexible to add other
> type of potentiometer with different max position value.
> 
> Signed-off-by: Jagath Jog J <jagathjog1996@gmail.com>
> ---
>  drivers/iio/potentiometer/ds1803.c | 61 ++++++++++++++++++++++--------
>  1 file changed, 45 insertions(+), 16 deletions(-)
> 
> diff --git a/drivers/iio/potentiometer/ds1803.c b/drivers/iio/potentiometer/ds1803.c
> index 3c542a50ece6..9610269bed7f 100644
> --- a/drivers/iio/potentiometer/ds1803.c
> +++ b/drivers/iio/potentiometer/ds1803.c
> @@ -16,7 +16,6 @@
>  #include <linux/module.h>
>  #include <linux/mod_devicetable.h>
>  
> -#define DS1803_MAX_POS		255
>  #define DS1803_WRITE(chan)	(0xa8 | ((chan) + 1))
>  
>  enum ds1803_type {
> @@ -26,27 +25,23 @@ enum ds1803_type {
>  };
>  
>  struct ds1803_cfg {
> +	int avail[3];
>  	int kohms;
>  };
>  
> -static const struct ds1803_cfg ds1803_cfg[] = {
> -	[DS1803_010] = { .kohms =  10, },
> -	[DS1803_050] = { .kohms =  50, },
> -	[DS1803_100] = { .kohms = 100, },
> -};
> -
>  struct ds1803_data {
>  	struct i2c_client *client;
>  	const struct ds1803_cfg *cfg;
>  };
>  
> -#define DS1803_CHANNEL(ch) {					\
> -	.type = IIO_RESISTANCE,					\
> -	.indexed = 1,						\
> -	.output = 1,						\
> -	.channel = (ch),					\
> -	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),		\
> -	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),	\
> +#define DS1803_CHANNEL(ch) {						\
> +	.type = IIO_RESISTANCE,						\
> +	.indexed = 1,							\
> +	.output = 1,							\
> +	.channel = (ch),						\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_RAW),   \
>  }
>  
>  static const struct iio_chan_spec ds1803_channels[] = {
> @@ -54,6 +49,21 @@ static const struct iio_chan_spec ds1803_channels[] = {
>  	DS1803_CHANNEL(1),
>  };
>  
> +static const struct ds1803_cfg ds1803_cfg[] = {
> +	[DS1803_010] = {
> +	  .avail = { 0, 1, 255 },
Why non standard indenting.  These should be a tab in rather than
a couple of spaces.

I'll fixup whilst applying.

Jonathan

> +	  .kohms =  10,
> +	},
> +	[DS1803_050] = {
> +	  .avail = { 0, 1, 255 },
> +	  .kohms =  50,
> +	},
> +	[DS1803_100] = {
> +	  .avail = { 0, 1, 255 },
> +	  .kohms = 100,
> +	},
> +};
> +
>  static int ds1803_read_raw(struct iio_dev *indio_dev,
>  			   struct iio_chan_spec const *chan,
>  			   int *val, int *val2, long mask)
> @@ -75,7 +85,7 @@ static int ds1803_read_raw(struct iio_dev *indio_dev,
>  
>  	case IIO_CHAN_INFO_SCALE:
>  		*val = 1000 * data->cfg->kohms;
> -		*val2 = DS1803_MAX_POS;
> +		*val2 = data->cfg->avail[2]; /* Max wiper position */
>  		return IIO_VAL_FRACTIONAL;
>  	}
>  
> @@ -88,13 +98,14 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
>  {
>  	struct ds1803_data *data = iio_priv(indio_dev);
>  	int pot = chan->channel;
> +	int max_pos = data->cfg->avail[2];
>  
>  	if (val2 != 0)
>  		return -EINVAL;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> -		if (val > DS1803_MAX_POS || val < 0)
> +		if (val > max_pos || val < 0)
>  			return -EINVAL;
>  		break;
>  	default:
> @@ -104,9 +115,27 @@ static int ds1803_write_raw(struct iio_dev *indio_dev,
>  	return i2c_smbus_write_byte_data(data->client, DS1803_WRITE(pot), val);
>  }
>  
> +static int ds1803_read_avail(struct iio_dev *indio_dev,
> +			     struct iio_chan_spec const *chan,
> +			     const int **vals, int *type,
> +			     int *length, long mask)
> +{
> +	struct ds1803_data *data = iio_priv(indio_dev);
> +
> +	switch (mask) {
> +	case IIO_CHAN_INFO_RAW:
> +		*vals = data->cfg->avail;
> +		*length = ARRAY_SIZE(data->cfg->avail);
> +		*type = IIO_VAL_INT;
> +		return IIO_AVAIL_RANGE;
> +	}
> +	return -EINVAL;
> +}
> +
>  static const struct iio_info ds1803_info = {
>  	.read_raw = ds1803_read_raw,
>  	.write_raw = ds1803_write_raw,
> +	.read_avail = ds1803_read_avail,
>  };
>  
>  static int ds1803_probe(struct i2c_client *client, const struct i2c_device_id *id)

