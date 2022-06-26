Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E470B55B287
	for <lists+linux-kernel@lfdr.de>; Sun, 26 Jun 2022 16:52:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230439AbiFZOwh (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 26 Jun 2022 10:52:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60858 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229441AbiFZOwg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 26 Jun 2022 10:52:36 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3F2D9DFA4;
        Sun, 26 Jun 2022 07:52:35 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id DB57EB80D25;
        Sun, 26 Jun 2022 14:52:33 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 81E0EC34114;
        Sun, 26 Jun 2022 14:52:30 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656255152;
        bh=u6dyc6OKriYarTY2U+MkEK+V7woHyhCx5GM205IhfN8=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=deskQJ3vFLEQarOrl6jQja54W8ONyt8TOomle7PkO3mwM1i6NB59x4gOwLnnp5SKV
         BUheZVCvQw/MZcQ7JEDbLnzabfWjvxVCKD1FXLtbi6jo2sLGvVhB7KRbS/Iy1roFpE
         2nIiSxJlZaPWm7wnXbOEVzFSdS32QVkUSfN4J6PFmfRn473jeJq0UAI2Nq8FUcDZAo
         Qd3eOxBd3vubKeYS9+0NshpBT/86f1hTg50OAqEL+vFmMJO6Nw791LpKhjFxou0e/t
         1mQDGlrZLKsH8agAVKPue8tyDk/AAiIK/EnthxUpJUae5Iz1/5mcd89g7acsvB458x
         +52U3JmbO2I3Q==
Date:   Sun, 26 Jun 2022 16:02:01 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        thomas.haemmerle@leica-geosystems.com, linux-iio@vger.kernel.org
Subject: Re: [PATCH V9 5/5] iio: accel: sca3300: Add inclination channels
Message-ID: <20220626160201.56a705be@jic23-huawei>
In-Reply-To: <20220529061853.3044893-6-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220529061853.3044893-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220529061853.3044893-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: 7bit
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Sun, 29 May 2022 06:18:53 +0000
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

I was looking at this driver whilst sanity checking something unrelated to
this patch and noticed...

sca3300_trigger_handler directly references sca3300_channels
rather than through indio_dev->channels. 

I think that means you'll get a buffer overrun if you enable the inclination
channels with buffered capture.  Please check if we need to modify that code
slightly.

I'm also fairly sure the timestamp will end up in the wrong place as
iio_push_to_buffers_with_timestamp() assumes it's at the end. Please confirm
you've tested with appropriate channels enabled and the test code in tools/iio

I think the changes needed are to put the incli channels before the timestamp
but you'll need to use separate enum for that.  Also make the trigger handler
use the channels array for the specific device via indio_dev->channels.

Thanks,

Jonathan

> ---
>  drivers/iio/accel/sca3300.c | 76 +++++++++++++++++++++++++++++++++++--
>  1 file changed, 73 insertions(+), 3 deletions(-)
> 
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index 9683dce21073..861f6906beee 100644
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
> @@ -73,6 +79,23 @@ enum sca3300_scan_indexes {
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
> +	.info_mask_shared_by_type_available = BIT(IIO_CHAN_INFO_SCALE), \
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
> @@ -106,15 +129,36 @@ static const int sca3300_accel_scale_map[] = {0, 1, 2, 2};
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
> @@ -123,12 +167,16 @@ struct sca3300_chip_info {
>  	u8 num_accel_scales;
>  	const int (*accel_scale)[2];
>  	const int *accel_scale_map;
> +	const int (*incli_scale)[2];
> +	const int *incli_scale_map;
> +	u8 num_incli_scales;
>  	u8 num_freqs;
>  	const int *freq_table;
>  	const int *freq_map;
>  	const int *avail_modes_table;
>  	u8 num_avail_modes;
>  	u8 chip_id;
> +	bool angle_supported;
>  };
>  
>  /**
> @@ -167,21 +215,26 @@ static const struct sca3300_chip_info sca3300_chip_tbl[] = {
>  		.avail_modes_table = sca3300_avail_modes_map,
>  		.num_avail_modes = 4,
>  		.chip_id = SCA3300_WHOAMI_ID,
> +		.angle_supported = false,
>  	},
>  	{
>  		.name = "scl3300",
> -		.scan_masks = sca3300_scan_masks,
> -		.channels = sca3300_channels,
> -		.num_channels = ARRAY_SIZE(sca3300_channels),
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
>  		.avail_modes_table = scl3300_avail_modes_map,
>  		.num_avail_modes = 3,
>  		.chip_id = SCL3300_WHOAMI_ID,
> +		.angle_supported = true,
>  	},
>  };
>  
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
> +	if (sca_data->chip->angle_supported) {
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

