Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BF121527182
	for <lists+linux-kernel@lfdr.de>; Sat, 14 May 2022 16:01:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232874AbiENOBo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 14 May 2022 10:01:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60338 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230525AbiENOBc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 14 May 2022 10:01:32 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1EBD262F0;
        Sat, 14 May 2022 07:01:30 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 9D9A960F0B;
        Sat, 14 May 2022 14:01:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id BBF1DC34115;
        Sat, 14 May 2022 14:01:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1652536888;
        bh=IjsexA4QKvKiPnu9VPIN+xBIIykcF8S/oKoPdCTOtAQ=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=sTkGtUXt+E6IHCibIDVmnOG9XEawnYpMLshN1jntf+wWSbROPd4B8zEQ7ohtDzODb
         1F1rTgq6+2XRckCzITs/LFHpMFCb19FzJdu9ZHBYl4QDYY8qjVAMm2l7CAtP876c08
         Co2k5OyMK3Jr5luaUCs99MOxejU1bY0qHIFWa0barJpPPR6WhoPBIf0qAJ5lt7vLt1
         kH0J8uVpJ/5olht2BAOc4768/4FXZ38TEeWwHYph3nZVTAXzfCaQ3m/V3T3h3xjDrd
         Z5cPKH761JUAmbX76JTCRRk4zieyKSdLfm2BPtWsgV5OxrEqm7IYQSwYnyB5Ua2LpR
         gRDdGqs/CCKdA==
Date:   Sat, 14 May 2022 15:10:03 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH V6 3/5] iio: accel: sca3300: modified to support multi
 chips
Message-ID: <20220514151003.42fa5044@jic23-huawei>
In-Reply-To: <20220513124135.1295822-4-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220513124135.1295822-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220513124135.1295822-4-Qing-wu.Li@leica-geosystems.com.cn>
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

On Fri, 13 May 2022 12:41:33 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Prepare the way for multiple chips and additional channels:
> - Modify the driver to read the device ID and load the corresponding
>   sensor information from the table to support multiple chips
> - Add prepares for the addition of extra channels
> - Prepare for handling the operation modes for multiple chips
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
A few requests for additional comments inline where the handling
is 'unusual' enough to be non obvious to figure out.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/sca3300.c | 186 ++++++++++++++++++++++++++++--------
>  1 file changed, 145 insertions(+), 41 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index ff16d2cc8c70..bc6e0213e4aa 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -93,15 +93,35 @@ static const struct iio_chan_spec sca3300_channels[] = {
>  	IIO_CHAN_SOFT_TIMESTAMP(4),
>  };
>  
> -static const int sca3300_lp_freq[] = {70, 70, 70, 10};
> -static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}, {0, 185}};
> +static const int sca3300_lp_freq[] = {70, 10};
> +static const int sca3300_lp_freq_map[] = {0, 0, 0, 1};
>  
> +static const int sca3300_accel_scale[][2] = {{0, 370}, {0, 741}, {0, 185}};
> +static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
> +
> +static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
>  static const unsigned long sca3300_scan_masks[] = {
>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>  	BIT(SCA3300_TEMP),
>  	0
>  };
>  
> +struct sca3300_chip_info {
> +	const char *name;
> +	const unsigned long *scan_masks;
> +	const struct iio_chan_spec *channels;
> +	u8 num_channels;
> +	u8 num_accel_scales;
> +	const int (*accel_scale)[2];
> +	const int *accel_scale_map;
> +	u8 num_freqs;
> +	const int *freq_table;
> +	const int *freq_map;
> +	const int *avail_modes_table;
> +	u8 num_avail_modes;
> +	u8 chip_id;
> +};
> +
>  /**
>   * struct sca3300_data - device data
>   * @spi: SPI device structure
> @@ -117,10 +137,29 @@ struct sca3300_data {
>  		s16 channels[4];
>  		s64 ts __aligned(sizeof(s64));
>  	} scan;
> +	const struct sca3300_chip_info *chip;

Needs documentation as struct sca3300_data has kernel doc.
Also, move this above scan.  That way all the buffers used
for various purposes will remain together.

>  	u8 txbuf[4] ____cacheline_aligned;
>  	u8 rxbuf[4];
>  };
>  
> +static const struct sca3300_chip_info sca3300_chip_tbl[] = {
> +	{
> +		.name = "sca3300",
> +		.scan_masks = sca3300_scan_masks,
> +		.channels = sca3300_channels,
> +		.num_channels = ARRAY_SIZE(sca3300_channels),
> +		.num_accel_scales = ARRAY_SIZE(sca3300_accel_scale)*2,
> +		.accel_scale = sca3300_accel_scale,
> +		.accel_scale_map = sca3300_accel_scale_map,
> +		.num_freqs = ARRAY_SIZE(sca3300_lp_freq),
> +		.freq_table = sca3300_lp_freq,
> +		.freq_map = sca3300_lp_freq_map,
> +		.avail_modes_table = sca3300_avail_modes_map,
> +		.num_avail_modes = 4,
> +		.chip_id = SCA3300_WHOAMI_ID,
> +	},
> +};
> +
>  DECLARE_CRC8_TABLE(sca3300_crc_table);
>  
>  static int sca3300_transfer(struct sca3300_data *sca_data, int *val)
> @@ -227,36 +266,80 @@ static int sca3300_write_reg(struct sca3300_data *sca_data, u8 reg, int val)
>  	return sca3300_error_handler(sca_data);
>  }
>  
> +static int sca3300_set_op_mode(struct sca3300_data *sca_data, int index)
> +{
> +	if ((index < 0) || (index >= sca_data->chip->num_avail_modes))
> +		return -EINVAL;
> +
> +	return sca3300_write_reg(sca_data, SCA3300_REG_MODE,
> +				 sca_data->chip->avail_modes_table[index]);
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
> +	reg_val &= GENMASK(1, 0);
> +	for (i = 0; i < sca_data->chip->num_avail_modes; i++) {
> +		if (sca_data->chip->avail_modes_table[i] == reg_val)
> +			break;
> +	}
> +	if (i == sca_data->chip->num_avail_modes)
> +		return -EINVAL;
> +
> +	*index = i;
> +	return 0;
> +}
> +
> +static int sca3300_set_frequency(struct sca3300_data *data, int val)
> +{
> +	const struct sca3300_chip_info *chip = data->chip;
> +	unsigned int index;
> +	unsigned int i;
> +
> +	if (sca3300_get_op_mode(data, &index))
> +		return -EINVAL;
> +
> +	for (i = 0; i < chip->num_avail_modes; i++) {
> +		if ((val == chip->freq_table[chip->freq_map[i]]) &&

The conditions being checked here are far from obvious, so I think this would benefit
from an explanatory comment.

Something along the lines of,
"Find a mode in which the requested sampling frequency is available
 and the scaling currently set is retained".



> +		    (chip->accel_scale[chip->accel_scale_map[index]] ==
> +		     chip->accel_scale[chip->accel_scale_map[i]]))
> +			break;
> +	}
> +	if (i == chip->num_avail_modes)
> +		return -EINVAL;
> +
> +	return sca3300_set_op_mode(data, i);
> +}
> +
>  static int sca3300_write_raw(struct iio_dev *indio_dev,
>  			     struct iio_chan_spec const *chan,
>  			     int val, int val2, long mask)
>  {
>  	struct sca3300_data *data = iio_priv(indio_dev);
> -	int reg_val;
> -	int ret;
> +	int index;
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
> +			index = data->chip->accel_scale_map[i];

Also a comment here that we are letting scale take priority over
sampling frequency. That makes sense given we can only ever end up increasing
the sampling frequency which is unlikely to be a problem.

> +			if ((val  == data->chip->accel_scale[index][0]) &&
> +			    (val2 == data->chip->accel_scale[index][1])) {
> +				return sca3300_set_op_mode(data, i);
> +			}
>  		}
>  		return -EINVAL;
> -
>  	case IIO_CHAN_INFO_LOW_PASS_FILTER_3DB_FREQUENCY:
> -		ret = sca3300_read_reg(data, SCA3300_REG_MODE, &reg_val);
> -		if (ret)
> -			return ret;
> -		/* freq. change is possible only for mode 3 and 4 */
> -		if (reg_val == 2 && val == sca3300_lp_freq[3])
> -			return sca3300_write_reg(data, SCA3300_REG_MODE, 3);
> -		if (reg_val == 3 && val == sca3300_lp_freq[2])
> -			return sca3300_write_reg(data, SCA3300_REG_MODE, 2);
> -		return -EINVAL;
> +		return sca3300_set_frequency(data, val);
>  	default:
>  		return -EINVAL;
>  	}
