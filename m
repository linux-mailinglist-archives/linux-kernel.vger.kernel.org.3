Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F2B6F530294
	for <lists+linux-kernel@lfdr.de>; Sun, 22 May 2022 13:09:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244885AbiEVLJK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 07:09:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241469AbiEVLJI (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 07:09:08 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1682D3BBE8;
        Sun, 22 May 2022 04:09:07 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id BCA32B80AC0;
        Sun, 22 May 2022 11:09:05 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 9EA7FC385AA;
        Sun, 22 May 2022 11:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653217744;
        bh=AVArGOXhwSYyaL2HHKnlBrQQIXmOh82zUGw0Op8w/cU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=MhFKBcGQrQ6ZWTKEHjFXDxI4gY9yQHRvAH7+QMr8gxivFu5Rd6N+FAiZkDkrMqUkf
         YKeaqM39mCMsUD/B+Xvx6+1t35adBDnU8l7HMtiRPYgQZlXlsJy8nBWPuB+v1gfVsq
         LEwLsarbXwK4nAK+/gidZb+Wx7H51xTEAJazPMqkNnwCdxU0z0l6t8u+bRSGqrXXEb
         ENFJ9kFAMZlGFo+54ENYAE0esCysdlAS3AlEhyE5NT47RWLguBuYCagPIKv55JvG9m
         CGIy1JIzSO55fCqlA6t38x5Yd8vp0dQ/jw0lr2k2YeHF0ob5DfG/KbrzIWpgNP3WNk
         FmMaJCG+QUbww==
Date:   Sun, 22 May 2022 12:17:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org
Subject: Re: [PATCH V7 5/5] iio: accel: sca3300: Add inclination channels
Message-ID: <20220522121749.01807970@jic23-huawei>
In-Reply-To: <20220522070419.409556-6-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220522070419.409556-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220522070419.409556-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Sun, 22 May 2022 07:04:19 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Different from SCA3300, SCL3300 can output inclination angles.
> Angles are formed from acceleration with following equations:
> ANG_X = atan2(accx , sqrt(pow(accy , 2) + pow(accz , 2)))
> ANG_Y = atan2(accy , sqrt(pow(accx , 2) + pow(accz , 2)))
> ANG_Z = atan2(accz , sqrt(pow(accx , 2) + pow(accy , 2)))
> 
> The commit adds the output of the raw value, scale
> and scale_available of angles.
> 
> New interfaces:
>   in_incli_scale
>   in_incli_scale_available
>   in_incli_x_raw
>   in_incli_y_raw
>   in_incli_z_raw
> Data converted by application of scale to degrees.
> 
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>

Hi Li,

A few small things to tidy up in this patch. See inline.


Thanks,

Jonathan

> ---
>  drivers/iio/accel/sca3300.c | 76 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index 10bedb14d4f0..9094f16458de 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -44,12 +44,18 @@
>  #define SCA3300_VALUE_RS_ERROR	0x3
>  #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
>  
> +#define SCL3300_REG_ANG_CTRL 0x0C
> +#define SCL3300_ANG_ENABLE   0x1F
> +
>  enum sca3300_scan_indexes {
>  	SCA3300_ACC_X = 0,
>  	SCA3300_ACC_Y,
>  	SCA3300_ACC_Z,
>  	SCA3300_TEMP,
>  	SCA3300_TIMESTAMP,
> +	SCA3300_INCLI_X,
> +	SCA3300_INCLI_Y,
> +	SCA3300_INCLI_Z,
>  };
>  
>  #define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
> @@ -73,6 +79,24 @@ enum sca3300_scan_indexes {
>  	},								\
>  }
>  
> +#define SCA3300_INCLI_CHANNEL(index, reg, axis) {			\
> +	.type = IIO_INCLI,						\
> +	.address = reg,							\
> +	.modified = 1,							\
> +	.channel2 = IIO_MOD_##axis,					\
> +	.info_mask_shared_by_type = BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_separate = BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type_available =				\
> +	BIT(IIO_CHAN_INFO_SCALE),					\

I don't think you need this line wrap.

> +	.scan_index = index,						\
> +	.scan_type = {							\
> +		.sign = 's',						\
> +		.realbits = 16,						\
> +		.storagebits = 16,					\
> +		.endianness = IIO_CPU,					\
> +	},								\
> +}
> +
>  #define SCA3300_TEMP_CHANNEL(index, reg) {				\
>  		.type = IIO_TEMP,					\
>  		.address = reg,						\
> @@ -106,15 +130,36 @@ static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
>  static const int scl3300_accel_scale[][2] = {{0, 167}, {0, 333}, {0, 83}};
>  static const int scl3300_accel_scale_map[] = {0, 1, 2};
>  
> +static const int scl3300_incli_scale[][2] = {{0, 5495}};
> +static const int scl3300_incli_scale_map[] = {0, 0, 0};
> +
>  static const int sca3300_avail_modes_map[] = {0, 1, 2, 3};
>  static const int scl3300_avail_modes_map[] = {0, 1, 3};
>  
> +static const struct iio_chan_spec scl3300_channels[] = {
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
> +	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
> +	IIO_CHAN_SOFT_TIMESTAMP(4),
> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
> +};
> +
>  static const unsigned long sca3300_scan_masks[] = {
>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>  	BIT(SCA3300_TEMP),
>  	0
>  };
>  
> +static const unsigned long scl3300_scan_masks[] = {
> +	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
> +	BIT(SCA3300_TEMP) |
> +	BIT(SCA3300_INCLI_X) | BIT(SCA3300_INCLI_Y) | BIT(SCA3300_INCLI_Z),
> +	0
> +};
> +
>  struct sca3300_chip_info {
>  	const char *name;
>  	const unsigned long *scan_masks;
> @@ -123,6 +168,9 @@ struct sca3300_chip_info {
>  	u8 num_accel_scales;
>  	const int (*accel_scale)[2];
>  	const int *accel_scale_map;
> +	const int (*incli_scale)[2];
> +	const int *incli_scale_map;
> +	u8 num_incli_scales;
>  	u8 num_freqs;
>  	const int *freq_table;
>  	const int *freq_map;
> @@ -131,6 +179,7 @@ struct sca3300_chip_info {
>  	u8 chip_id;
>  };
>  
> +
Unrelated and unwanted white space chagne.

>  /**
>   * struct sca3300_data - device data
>   * @spi: SPI device structure
> @@ -168,12 +217,16 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
>  		.num_avail_modes = 4,
>  		.chip_id = SCA3300_WHOAMI_ID,
>  	},
> -	{	.scan_masks = sca3300_scan_masks,
> -		.channels = sca3300_channels,
> -		.num_channels = ARRAY_SIZE(sca3300_channels),
> +	{

ah. The whitespace change belongs in patch 4.

> +		.scan_masks = scl3300_scan_masks,
> +		.channels = scl3300_channels,
> +		.num_channels = ARRAY_SIZE(scl3300_channels),
>  		.num_accel_scales = ARRAY_SIZE(scl3300_accel_scale)*2,
>  		.accel_scale = scl3300_accel_scale,
>  		.accel_scale_map = scl3300_accel_scale_map,
> +		.incli_scale = scl3300_incli_scale,
> +		.incli_scale_map = scl3300_incli_scale_map,
> +		.num_incli_scales =  ARRAY_SIZE(scl3300_incli_scale)*2,
>  		.num_freqs = ARRAY_SIZE(scl3300_lp_freq),
>  		.freq_table = scl3300_lp_freq,
>  		.freq_map = scl3300_lp_freq_map,
> @@ -400,6 +453,11 @@ static int sca3300_read_raw(struct iio_dev *indio_dev,
>  		if (ret)
>  			return ret;
>  		switch (chan->type) {
> +		case IIO_INCLI:
> +			index = data->chip->incli_scale_map[index];
> +			*val  = data->chip->incli_scale[index][0];
> +			*val2 = data->chip->incli_scale[index][1];
> +			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
>  			index = data->chip->accel_scale_map[index];
>  			*val  = data->chip->accel_scale[index][0];
> @@ -486,6 +544,13 @@ static int sca3300_init(struct sca3300_data *sca_data,
>  
>  	sca_data->chip = &sca3300_chip_tbl[i];
>  
> +	if (value == SCL3300_WHOAMI_ID) {

I don't like feature decisions being based directly on a WHOAMI.
That tends not to scale as you add more supported parts to the driver.

I think this is the only case you now have.

Better would be to add a 'inclination_supported' bool to your chip info
and make the decision based on that.  I wouldn't use whether incli_scale
is set as that would hurt readability when compared to a new member
serving just this purpose.


> +		ret = sca3300_write_reg(sca_data, SCL3300_REG_ANG_CTRL,
> +					SCL3300_ANG_ENABLE);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
>  
> @@ -521,6 +586,11 @@ static int sca3300_read_avail(struct iio_dev *indio_dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
> +		case IIO_INCLI:
> +			*vals = (const int *)data->chip->incli_scale;
> +			*length = data->chip->num_incli_scales;
> +			*type = IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
>  		case IIO_ACCEL:
>  			*vals = (const int *)data->chip->accel_scale;
>  			*length = data->chip->num_accel_scales;

