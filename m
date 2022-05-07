Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0F87151E7E1
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 16:46:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446543AbiEGOuW (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 10:50:22 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47216 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237680AbiEGOuT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:50:19 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48F6436160;
        Sat,  7 May 2022 07:46:32 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id C4A3C60C20;
        Sat,  7 May 2022 14:46:31 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 339EFC385A6;
        Sat,  7 May 2022 14:46:29 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651934791;
        bh=IJQgXI4haDxQ5Z/UmjXXGDxAcmJR03HgVd9diG67Wks=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ljalxrLVltoHE9PsDvUgrgJ6iZORBX9nT2nMxk4rXLuor+VDjrM5hL4PnDCWcLx+V
         SA5id1ooLPNXEBZ1qaaB9G8WpoiRm24ZB5wNAjELdKTceFsxjPQsPnUjpyzZT7FbH8
         lBEUdDFHkovp1FXWIqBfVWtSnu3t7tiAvCS72D37dy0DBP+tWhX0IRaDgVxjtU1W77
         mHUgbVSVES8Vx7Wd18cnVY7y0daXD/z8dtbfWAwyzkDsrJMs9Dgt3MEmBj7S/q3zEC
         53vLJlICeb0KXgDRdc0RDcAjLGVAx1m6wD+aCJIgnvshDwhFntxjHWLJz/NsYOHG0V
         RMNlKGKO4fM7A==
Date:   Sat, 7 May 2022 15:54:58 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 3/5] iio: accel: sca3300: modified to support multi
 chips
Message-ID: <20220507155458.150ea6f7@jic23-huawei>
In-Reply-To: <20220504133612.604304-4-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220504133612.604304-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 May 2022 13:36:10 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> The drive support sca3300 only.
> There are some other similar chips, for instance, SCL3300.
> Prepare the way for multiple chips and additional channels.
> Modify the driver to read the device id.
> Add the tables for the corresponding id to support multiple chips.
> Add prepares for the addition of extra channels.
> Add prepares for handling the operation modes for multiple chips.
> 
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>

These tags were not give, so don't add them...

Various other comment inline, many of which probably overlap with other reviews

Thanks,

Jonathan

> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/sca3300.c | 180 ++++++++++++++++++++++++++++--------
>  1 file changed, 141 insertions(+), 39 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index ff16d2cc8c70..1e0e6a2f7a63 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -37,7 +37,6 @@
>  
>  /* Device ID */
>  #define SCA3300_REG_WHOAMI	0x10
> -#define SCA3300_WHOAMI_ID	0x51
>  
>  /* Device return status and mask */
>  #define SCA3300_VALUE_RS_ERROR	0x3
> @@ -93,15 +92,35 @@ static const struct iio_chan_spec sca3300_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
> -static const int sca3300_lp_freq[] = {70, 70, 70, 10};
> -static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
> +static const int sca3300_freq_tbl[] = {70, 10};
> +static const int sca3300_freq_modes_map[] = {0, 0, 0, 1};
>  
> +static const int sca3300_accel_scale_tbl[][2] = {{0, 370}, {0, 741}, {0, 185}};
> +static const int sca3300_accel_scale_modes_map[] = {0, 1, 2, 2};
> +
> +static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
>  static const unsigned long sca3300_scan_masks[] = {
>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>  	BIT(SCA3300_TEMP),
>  	0
>  };
>  
> +struct sca3300_chip_info {

See below, though others already mentioned it.

> +	const struct iio_chan_spec *channels;
> +	const int (*accel_scale_table)[2];
> +	const int *accel_scale_modes_map;
> +	const unsigned long *scan_masks;
> +	const int *avail_modes_table;
> +	const int *freq_modes_map;
> +	const int *freq_table;
> +	const u8 num_accel_scales;
> +	const u8 num_avail_modes;
> +	const u8 num_channels;
> +	const u8 num_freqs;
> +	const u8 chip_id;
> +	const char *name;
> +};
> +
>  /**
>   * struct sca3300_data - device data
>   * @spi: SPI device structure
> @@ -117,10 +136,28 @@ struct sca3300_data {
>  		s16 channels[4];
>  		s64 ts __aligned(sizeof(s64));
>  	} scan;
> +	const struct sca3300_chip_info *chip;
>  	u8 txbuf[4] ____cacheline_aligned;
>  	u8 rxbuf[4];
>  };
>  
> +static const struct sca3300_chip_info sca3300_chip_tbl[] = {

Others commented on this but definitely don't do this.  Keep the order
the same as that of the structure definition and for that
order them so that related items are next to each other.

> +	{	.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale_tbl)*2,
> +		.accel_scale_modes_map = sca3300_accel_scale_modes_map,
> +		.accel_scale_table = sca3300_accel_scale_tbl,
> +		.num_channels = ARRAY_SIZE(sca3300_channels),
> +		.freq_modes_map = sca3300_freq_modes_map,
> +		.avail_modes_table = sca3300_avail_modes_map,
> +		.freq_table = sca3300_freq_tbl,
> +		.scan_masks = sca3300_scan_masks,
> +		.channels = sca3300_channels,
> +		.num_avail_modes = 4,
> +		.name = "sca3300",
> +		.chip_id = 0x51,
> +		.num_freqs = 2,
> +	},
> +};
> +
>  DECLARE_CRC8_TABLE(sca3300_crc_table);
>  
>  static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
> @@ -227,36 +264,80 @@ static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
>  	return sca3300_error_handler(sca_data);
>  }
>  
> +static int sca3300_set_op_mode(struct sca3300_data *sca_data, int index)
> +{
> +	int mode;
> +
> +	if ((index < 0) || (index >= sca_data->chip->num_avail_modes))
> +		return -EINVAL;
> +
> +	mode = sca_data->chip->avail_modes_table[index];
> +
> +	return sca3300_write_reg(sca_data, SCA3300_REG_MODE, mode);

	return sca3300_write_reg(sca_data, SCA3300_REG_MODE,
				 sca_data->chip->avail_modes_table[index]);
doesn't hurt reability or lead to particularly long line length so
better to save us a few lines of code and the local variable.

> +}
> +
> +static int sca3300_get_op_mode(struct sca3300_data *sca_data, int *index)
> +{
> +	int reg_val;
> +	int ret;
> +	int i;
> +
> +	ret = sca3300_read_reg(sca_data, SCA3300_REG_MODE, &reg_val);
> +	if (ret)
> +		return ret;
> +
> +	for (i = 0; i < sca_data->chip->num_avail_modes; i++) {
> +		if (sca_data->chip->avail_modes_table[i] == reg_val) {
> +			*index = i;
> +			break;
			return 0;
> +		}
> +	}
> +
> +	return ret;

Not an error if we get here without finding a match?

> +}
> +
>  static int sca3300_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int val, int val2, long mask)
>  {
>  	struct sca3300_data *data = iio_priv(indio_dev);
> +	int mode = -1;
>  	int reg_val;
> +	int index;
>  	int ret;
>  	int i;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> -		if (val)
> +		if (chan->type != IIO_ACCEL)
>  			return -EINVAL;
> -
> -		for (i = 0; i < ARRAY_SIZE(sca3300_accel_scale); i++) {
> -			if (val2 == sca3300_accel_scale[i][1])
> -				return sca3300_write_reg(data, SCA3300_REG_MODE, i);
> +		for (i = 0; i < data->chip->num_avail_modes; i++) {
> +			index = data->chip->accel_scale_modes_map[i];
> +			if ((val == data->chip->accel_scale_table[index][0]) &&
> +			(val2 == data->chip->accel_scale_table[index][1])) {

Align this so it is clear that the second line is part of the ocnditional.

			if ((val...
			    (val2 ==

> +				mode = i;
> +				break;
> +			}

What if there isn't a match?

>  		}
> -		return -EINVAL;
> -
> +		return sca3300_set_op_mode(data, mode);
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> +		ret = sca3300_get_op_mode(data, &reg_val);
>  		if (ret)
>  			return ret;
> -		/* freq. change is possible only for mode 3 and 4 */
> -		if (reg_val == 2 && val == sca3300_lp_freq[3])
> -			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
> -		if (reg_val == 3 && val == sca3300_lp_freq[2])
> -			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
> -		return -EINVAL;
> +		index = data->chip->accel_scale_modes_map[reg_val];
> +		for (i = 0; i < data->chip->num_avail_modes; i++) {
> +			int index_new = data->chip->accel_scale_modes_map[i];
> +			int index_freq = data->chip->freq_modes_map[i];
> +
> +			if (val == data->chip->freq_table[index_freq]) {
> +				if (data->chip->accel_scale_table[index] ==
> +				data->chip->accel_scale_table[index_new]) {

as before, fix alignment and handle case where there isn't a match.


> +					mode = i;
> +					break;
> +				}
> +			}
> +		}
> +		return sca3300_set_op_mode(data, mode);
>  	default:
>  		return -EINVAL;
>  	}
> @@ -267,8 +348,9 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct sca3300_data *data = iio_priv(indio_dev);
> -	int ret;
>  	int reg_val;
> +	int index;
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -277,17 +359,25 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
>  			return ret;
>  		return IIO_VAL_INT;
>  	case IIO_CHAN_INFO_SCALE:
> -		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> +		ret = sca3300_get_op_mode(data, &reg_val);
>  		if (ret)
>  			return ret;
> -		*val = 0;
> -		*val2 = sca3300_accel_scale[reg_val][1];
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			index = data->chip->accel_scale_modes_map[reg_val];
> +			*val = data->chip->accel_scale_table[index][0];
> +			*val2 = data->chip->accel_scale_table[index][1];
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> +
> +		ret = sca3300_get_op_mode(data, &reg_val);
>  		if (ret)
>  			return ret;
> -		*val = sca3300_lp_freq[reg_val];
> +		index = data->chip->freq_modes_map[reg_val];
> +		*val = data->chip->freq_table[index];
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -331,6 +421,7 @@ static int sca3300_init(struct sca3300_data *sca_data,
>  {
>  	int value = 0;
>  	int ret;
> +	int i;
>  
>  	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
>  				SCA3300_MODE_SW_RESET);
> @@ -347,12 +438,22 @@ static int sca3300_init(struct sca3300_data *sca_data,
>  	if (ret)
>  		return ret;
>  
> -	if (value != SCA3300_WHOAMI_ID) {
> -		dev_err(&sca_data->spi->dev,
> -			"device id not expected value, %d != %u\n",
> -			value, SCA3300_WHOAMI_ID);
> +	for (i = 0; i < ARRAY_SIZE(sca3300_chip_tbl); i++) {
> +		if (sca3300_chip_tbl[i].chip_id == value)
> +			break;
> +	}
> +	if (i == ARRAY_SIZE(sca3300_chip_tbl)) {
> +		dev_err(&sca_data->spi->dev, "Invalid chip %x\n", value);
>  		return -ENODEV;
>  	}
> +
> +	indio_dev->available_scan_masks = sca3300_chip_tbl[i].scan_masks;
> +	indio_dev->num_channels = sca3300_chip_tbl[i].num_channels;
> +	indio_dev->channels = sca3300_chip_tbl[i].channels;
> +	sca_data->chip = &sca3300_chip_tbl[i];
> +	indio_dev->name = sca3300_chip_tbl[i].name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
>  	return 0;
>  }
>  
> @@ -384,15 +485,21 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
>  			      const int **vals, int *type, int *length,
>  			      long mask)
>  {
> +	struct sca3300_data *data = iio_priv(indio_dev);
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
> -		*vals = (const int *)sca3300_accel_scale;
> -		*length = ARRAY_SIZE(sca3300_accel_scale) * 2 - 2;
> -		*type = IIO_VAL_INT_PLUS_MICRO;
> -		return IIO_AVAIL_LIST;
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			*vals = (const int *)data->chip->accel_scale_table;
> +			*length = data->chip->num_accel_scales;
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		*vals = &sca3300_lp_freq[2];
> -		*length = 2;
> +		*vals = (const int *)data->chip->freq_table;
> +		*length = data->chip->num_freqs;
>  		*type = IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
>  	default:
> @@ -424,11 +531,6 @@ static int sca3300_probe(struct spi_device *spi)
>  	crc8_populate_msb(sca3300_crc_table, SCA3300_CRC8_POLYNOMIAL);
>  
>  	indio_dev->info = &sca3300_info;
> -	indio_dev->name = SCA3300_ALIAS;
> -	indio_dev->modes = INDIO_DIRECT_MODE;
> -	indio_dev->channels = sca3300_channels;
> -	indio_dev->num_channels = ARRAY_SIZE(sca3300_channels);
> -	indio_dev->available_scan_masks = sca3300_scan_masks;
>  
>  	ret = sca3300_init(sca_data, indio_dev);
>  	if (ret) {

