Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5960C4BC9A5
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 18:57:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242741AbiBSR5j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 12:57:39 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:54572 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiBSR5h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 12:57:37 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 77951205DC;
        Sat, 19 Feb 2022 09:57:17 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 5C9A8B8006F;
        Sat, 19 Feb 2022 17:57:15 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id D150DC004E1;
        Sat, 19 Feb 2022 17:57:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645293434;
        bh=mrHby+KERtUZFmSGtJ89X47TWqTkSlnqjIRkCI0wMe0=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=YHOg7muw958DQ3m2c+IKIfGqOdDm8mJ8FDfRCW2rbeWGLiEsy4jBXbTnw5bTBG5aa
         IaTAcEp4sr0K4s8vP5LPzQ8St361/SrcefH4oI9E5iT791M4/NrVeS8LNyoE/HsKuO
         a+WKn5ghb1ZxkkDGplf0zN+ivGBUxyqeMbTF8ioA0VN79LdC9TEiGK8RSXzsI9UlEk
         gaxmOOHfCUxL7m/qJItfXYvxmAIp6Z9O0bUAONEuDAqDx/0PoH3vgSYZ/AFa11YgRL
         ldDQ9XsinNZTwpxF7T994lAL5PFSRc5SlLvgXc0ot9nK/MijRIoWnjCeUpMH0lqc4D
         C7rdSn26+RDdA==
Date:   Sat, 19 Feb 2022 18:04:01 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com,
        kernel test robot <lkp@intel.com>
Subject: Re: [PATCH V2 3/5] iio: accel: sca3300: modified to support multi
 chips
Message-ID: <20220219180401.10e50f1c@jic23-huawei>
In-Reply-To: <20220217062705.2867149-4-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220217062705.2867149-4-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 06:27:03 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

Hi,

A few comments inline.

Thanks,
Jonathan


> The drive support sca3300 only,there are some other similar chips,

space after only,

> for instance, SCL3300.
> modified the driver to read the device id,
> add the tables for the corresponding id to support multiple chips.
> 
> Reported-by: kernel test robot <lkp@intel.com>

I guess something was reported in v1.  When you have fixed a patch
make sure you say what was reported. It is also common to credit
fixes before merging just in the change log rather than with an explicit
entry like tis.

> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/sca3300.c | 156 +++++++++++++++++++++++++++---------
>  1 file changed, 118 insertions(+), 38 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index ff16d2cc8c70..b1748874c02d 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -37,12 +37,24 @@
>  
>  /* Device ID */
>  #define SCA3300_REG_WHOAMI	0x10
> -#define SCA3300_WHOAMI_ID	0x51
>  
>  /* Device return status and mask */
>  #define SCA3300_VALUE_RS_ERROR	0x3
>  #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
>  
> +enum sca3300_op_mode_indexes {
> +	OP_MOD_1 = 0,
> +	OP_MOD_2,
> +	OP_MOD_3,
> +	OP_MOD_4,
> +	OP_MOD_CNT,
> +};
> +
> +enum sca3300_chip_type {
> +	CHIP_SCA3300 = 0,
> +	CHIP_CNT
> +};
> +
>  enum sca3300_scan_indexes {
>  	SCA3300_ACC_X = 0,
>  	SCA3300_ACC_Y,
> @@ -91,15 +103,29 @@ static const struct iio_chan_spec sca3300_channels[] = {
>  	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
>  	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
> +	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),
>  };
>  
> -static const int sca3300_lp_freq[] = {70, 70, 70, 10};
> -static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
> +static const int sca3300_lp_freq_table[] = {70, 70, 70, 10};
> +static const int sca3300_accel_scale_table[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
>  
>  static const unsigned long sca3300_scan_masks[] = {
>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>  	BIT(SCA3300_TEMP),
> -	0
> +	0,

Unrelated change. Also last value can't be less bits set than 0 so this
is effectively a terminator and doesn't need the , (though I don't mind if there
is one as that reasoning is rather obscure!)

> +};
> +
> +struct sca3300_chip_info {
> +	const struct iio_chan_spec *channels;
> +	enum sca3300_chip_type chip_type;
> +	const int (*accel_scale_table)[2];
> +	unsigned int num_accel_scales;
> +	unsigned long scan_masks;
> +	unsigned int num_freqs;
> +	const int *freq_table;
> +	const char *name;
> +	int num_channels;
> +	u8 chip_id;
>  };
>  
>  /**
> @@ -114,13 +140,29 @@ struct sca3300_data {
>  	struct spi_device *spi;
>  	struct mutex lock;
>  	struct {
> -		s16 channels[4];
> +		s16 channels[SCA3300_TIMESTAMP - 1];

Why reduction is size?  The use of the enum -1 is
also confusing as it's not clear why that would be the
case so just use a number and add a comment if useful
on which channels it is.  

>  		s64 ts __aligned(sizeof(s64));
>  	} scan;
> +	const struct sca3300_chip_info *chip_info;
>  	u8 txbuf[4] ____cacheline_aligned;
>  	u8 rxbuf[4];
>  };
>  
> +static const struct sca3300_chip_info sca3300_chip_info_tbl[] = {
> +	[CHIP_SCA3300] = {
> +		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale_table)*2-1,
> +		.accel_scale_table = sca3300_accel_scale_table,
> +		.num_channels = ARRAY_SIZE(sca3300_channels),
> +		.freq_table = &sca3300_lp_freq_table[2],
> +		.scan_masks = sca3300_scan_masks,
> +		.channels = sca3300_channels,
> +		.chip_type = CHIP_SCA3300,
> +		.name = "sca3300",
> +		.chip_id = 0x51,
> +		.num_freqs = 2,
> +	},
> +};
> +
>  DECLARE_CRC8_TABLE(sca3300_crc_table);
>  
>  static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
> @@ -227,36 +269,57 @@ static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
>  	return sca3300_error_handler(sca_data);
>  }
>  
> +static int sca3300_set_op_mode(struct sca3300_data *sca_data, unsigned int mode)
> +{
> +	if ((mode < OP_MOD_1) || (mode >= OP_MOD_CNT))
> +		return -EINVAL;
> +
> +	return sca3300_write_reg(sca_data, SCA3300_REG_MODE, mode);
> +}
> +
>  static int sca3300_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int val, int val2, long mask)
>  {
>  	struct sca3300_data *data = iio_priv(indio_dev);
> +	int mode = -1;
>  	int reg_val;
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
> +		for (i = 0; i < OP_MOD_CNT; i++) {
> +			if ((val == data->chip_info->accel_scale_table[i][0]) &&
> +			(val2 == data->chip_info->accel_scale_table[i][1])) {
> +				mode = i;
> +				break;
> +			}
>  		}
> -		return -EINVAL;
> -
> +		return sca3300_set_op_mode(data, mode);
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
>  		if (ret)
>  			return ret;
> -		/* freq. change is possible only for mode 3 and 4 */
> -		if (reg_val == 2 && val == sca3300_lp_freq[3])
> -			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
> -		if (reg_val == 3 && val == sca3300_lp_freq[2])
> -			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
> -		return -EINVAL;
> +		for (i = 0; i < OP_MOD_CNT; i++) {
> +			if (val == data->chip_info->freq_table[i]) {
> +				mode = i;
> +				break;
> +			}
> +		}
> +		switch (data->chip_info->chip_type) {
> +		case CHIP_SCA3300:

I would prefer if chip_info included a field that expressed this. 
Ideally we want to just 'pick' static data from the chip_info structure
rather than having code depending on the chip type.

Perhaps chip_info->freq_modes_bitmap (with a better name).


> +			/* SCA330 freq. change is possible only for mode 3 and 4 */
> +			if (reg_val == OP_MOD_3 && mode == OP_MOD_4)
> +				return sca3300_set_op_mode(data, mode);
> +			if (reg_val == OP_MOD_4 && mode == OP_MOD_3)
> +				return sca3300_set_op_mode(data, mode);
> +			return -EINVAL;
> +		default:
> +			return -EINVAL;
> +		}
>  	default:
>  		return -EINVAL;
>  	}
> @@ -267,8 +330,8 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
>  			    int *val, int *val2, long mask)
>  {
>  	struct sca3300_data *data = iio_priv(indio_dev);
> -	int ret;
>  	int reg_val;
> +	int ret;
>  
>  	switch (mask) {
>  	case IIO_CHAN_INFO_RAW:
> @@ -280,14 +343,18 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
>  		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
>  		if (ret)
>  			return ret;
> -		*val = 0;
> -		*val2 = sca3300_accel_scale[reg_val][1];
> -		return IIO_VAL_INT_PLUS_MICRO;
> +		switch (chan->type) {
> +		case IIO_ACCEL:
> +			*val =  data->chip_info->accel_scale_table[reg_val][0];
> +			*val2 = data->chip_info->accel_scale_table[reg_val][1];
> +			return IIO_VAL_INT_PLUS_MICRO;
> +		}
Prefer
		default:
			return -EINVAL;
in the case statement as done in other similar paths.

However, why is the channel type check needed? (see below for similar)
 
> +		return -EINVAL;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
>  		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
>  		if (ret)
>  			return ret;
> -		*val = sca3300_lp_freq[reg_val];
> +		*val = data->chip_info->freq_table[reg_val];
>  		return IIO_VAL_INT;
>  	default:
>  		return -EINVAL;
> @@ -330,6 +397,7 @@ static int sca3300_init(struct sca3300_data *sca_data,
>  			struct iio_dev *indio_dev)
>  {
>  	int value = 0;
> +	int i = 0;

No need to initialize as will always be set by the for loop.

>  	int ret;
>  
>  	ret = sca3300_write_reg(sca_data, SCA3300_REG_MODE,
> @@ -347,12 +415,22 @@ static int sca3300_init(struct sca3300_data *sca_data,
>  	if (ret)
>  		return ret;
>  
> -	if (value != SCA3300_WHOAMI_ID) {
> -		dev_err(&sca_data->spi->dev,
> -			"device id not expected value, %d != %u\n",
> -			value, SCA3300_WHOAMI_ID);
> +	for (i = 0; i < ARRAY_SIZE(sca3300_chip_info_tbl); i++) {
> +		if (sca3300_chip_info_tbl[i].chip_id == value)
> +			break;
> +	}
> +	if (i == ARRAY_SIZE(sca3300_chip_info_tbl)) {
> +		dev_err(&sca_data->spi->dev, "Invalid chip %x\n", value);
>  		return -ENODEV;
>  	}
> +
> +	indio_dev->available_scan_masks = sca3300_chip_info_tbl[i].scan_masks;
> +	indio_dev->num_channels = sca3300_chip_info_tbl[i].num_channels;
> +	indio_dev->channels = sca3300_chip_info_tbl[i].channels;
> +	sca_data->chip_info = &sca3300_chip_info_tbl[i];
> +	indio_dev->name = sca3300_chip_info_tbl[i].name;
> +	indio_dev->modes = INDIO_DIRECT_MODE;
> +
>  	return 0;
>  }
>  
> @@ -384,15 +462,22 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
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

Why the need for a check on the channel type?  I don't particularly
mind having one but I think it will always be IIO_ACCEL and that hasn't
changed as a result of this patch.  So to keep the patch minimal I would
prefer not adding the check unless it is necessary.


> +			*vals = (const int *)data->chip_info->accel_scale_table;
> +			*length = data->chip_info->num_accel_scales;
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
> +		default:
> +			return -EINVAL;
> +		}
> +		return -EINVAL;
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		*vals = &sca3300_lp_freq[2];
> -		*length = 2;
> +		*vals = (const int *)data->chip_info->freq_table;
> +		*length = data->chip_info->num_freqs;
>  		*type = IIO_VAL_INT;
>  		return IIO_AVAIL_LIST;
>  	default:
> @@ -424,11 +509,6 @@ static int sca3300_probe(struct spi_device *spi)
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

