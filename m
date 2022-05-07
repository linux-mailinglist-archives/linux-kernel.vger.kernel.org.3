Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9697B51E7DC
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 16:38:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1392288AbiEGOmO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 10:42:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42386 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1385563AbiEGOmM (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 10:42:12 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9E873E0EA;
        Sat,  7 May 2022 07:38:23 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 40EB660AFA;
        Sat,  7 May 2022 14:38:23 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ABF39C385A5;
        Sat,  7 May 2022 14:38:20 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1651934302;
        bh=BqPf3eWIIjQrK9/r/Z8NDj3BNQR3sDaLaLL6MbnKxr4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=PmvehBWSa7i3TW4sVXMWr7bFqaqpFN8dAaC1KZdjwfJh1K8vNUNKRyzcqjDs7Z8Qa
         1YZ+hLIx7gt6i2sHd6S8D48TQPAc5/1kmmid//p3WUwieDSilDVh4uHUysvrOMeAad
         KDUkiy6QT7EpuzxfL9rnbYMy7QZxai8x5LKNatCzg3jgn/V72giZ1o8sV3e1181vm0
         Ks3PYvCFzlxI4RPMQmC0lN8KBXdz5Nsc7b8v6E8gcQ6Qqe6h/xTBufC9+AAW3c/OWU
         JVKZPHsndzBXhuHG79pWmHvN/7jW88CbJhzTa2ZTte2bvx8UYfKcZaquO3jB3nj7Zg
         Sa4iFkl+h7jQw==
Date:   Sat, 7 May 2022 15:46:49 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        Rob Herring <robh@kernel.org>
Subject: Re: [PATCH V3 5/5] iio: accel: sca3300: Add inclination channels
Message-ID: <20220507154649.54d91a41@jic23-huawei>
In-Reply-To: <20220504133612.604304-6-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220504133612.604304-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220504133612.604304-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.33; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Wed,  4 May 2022 13:36:12 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Different from SCA3300, SCL3300 can output inclination angles.
> Angles are formed from acceleration with following equations:
> ANG_X =3D atan2(accx / =E2=88=9A(accy^2 + accz^2)),
> ANG_Y =3D atan2(accy / =E2=88=9A(accx^2 + accz^2)),
> ANG_Z =3D atan2(accz / =E2=88=9A(accx^2 + accy^2)),
>=20
> The commit adds the output of the raw value, scale
> and scale_available of angles.
>=20
> New interfaces:
>   in_incli_scale
>   in_incli_scale_available
>   in_incli_x_raw
>   in_incli_y_raw
>   in_incli_z_raw
> Data converted by application of scale to degrees.
>=20
> Reviewed-by: Rob Herring <robh@kernel.org>
> Reviewed-by: Andy Shevchenko <andy.shevchenko@gmail.com>
> Reviewed-by: Jonathan Cameron <jic23@kernel.org>

Don't add tags for other people.  They have to be explicitly given by the p=
erson
in question.

This isn't reflecting that people reviewed the code, but that they
reviewed the code and are happy with it.  That's not yet the case
and even if they are happy, it is up to individual reviewers to give
a tag or not as they wish.

Easy to tell in my case as I don't use that email address for tags ;)

Jonathan



> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/sca3300.c | 79 ++++++++++++++++++++++++++++++++++++-
>  1 file changed, 77 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index 040f8e1a1327..cf588f014407 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -42,12 +42,18 @@
>  #define SCA3300_VALUE_RS_ERROR	0x3
>  #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
> =20
> +#define SCA3300_REG_ANG_CTRL 0x0C
> +#define SCA3300_ANG_ENABLE   0x1F
> +
>  enum sca3300_scan_indexes {
>  	SCA3300_ACC_X =3D 0,
>  	SCA3300_ACC_Y,
>  	SCA3300_ACC_Z,
>  	SCA3300_TEMP,
>  	SCA3300_TIMESTAMP,
> +	SCA3300_INCLI_X,
> +	SCA3300_INCLI_Y,
> +	SCA3300_INCLI_Z,
>  };
> =20
>  #define SCA3300_ACCEL_CHANNEL(index, reg, axis) {			\
> @@ -71,6 +77,24 @@ enum sca3300_scan_indexes {
>  	},								\
>  }
> =20
> +#define SCA3300_INCLI_CHANNEL(index, reg, axis) {			\
> +	.type =3D IIO_INCLI,						\
> +	.address =3D reg,							\
> +	.modified =3D 1,							\
> +	.channel2 =3D IIO_MOD_##axis,					\
> +	.info_mask_shared_by_type =3D BIT(IIO_CHAN_INFO_SCALE),		\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_RAW),			\
> +	.info_mask_shared_by_type_available =3D				\
> +	BIT(IIO_CHAN_INFO_SCALE),					\
> +	.scan_index =3D index,						\
> +	.scan_type =3D {							\
> +		.sign =3D 's',						\
> +		.realbits =3D 16,						\
> +		.storagebits =3D 16,					\
> +		.endianness =3D IIO_CPU,					\
> +	},								\
> +}
> +
>  #define SCA3300_TEMP_CHANNEL(index, reg) {				\
>  		.type =3D IIO_TEMP,					\
>  		.address =3D reg,						\
> @@ -102,28 +126,54 @@ static const int scl3300_accel_scale_tbl[][2] =3D {=
{0, 167}, {0, 333}, {0, 83}};
>  static const int sca3300_accel_scale_modes_map[] =3D {0, 1, 2, 2};
>  static const int scl3300_accel_scale_modes_map[] =3D {0, 1, 2};
> =20
> +static const int scl3300_incli_scale_tbl[][2] =3D {{0, 5495}};
> +static const int scl3300_incli_scale_modes_map[] =3D {0, 0, 0};
> +
>  static const int sca3300_avail_modes_map[] =3D {0, 1, 2, 3};
>  static const int scl3300_avail_modes_map[] =3D {0, 1, 3};
> +
> +static const struct iio_chan_spec scl3300_channels[] =3D {
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_X, 0x1, X),
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
> +	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
> +	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
> +	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),
> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
> +};
> +
>  static const unsigned long sca3300_scan_masks[] =3D {
>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>  	BIT(SCA3300_TEMP),
>  	0
>  };
> =20
> +static const unsigned long scl3300_scan_masks[] =3D {
> +	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
> +	BIT(SCA3300_TEMP) |
> +	BIT(SCA3300_INCLI_X) | BIT(SCA3300_INCLI_Y) | BIT(SCA3300_INCLI_Z),
> +	0
> +};
> +
>  struct sca3300_chip_info {
>  	const struct iio_chan_spec *channels;
>  	const int (*accel_scale_table)[2];
> +	const int (*incli_scale_table)[2];
>  	const int *accel_scale_modes_map;
> +	const int *incli_scale_modes_map;
>  	const unsigned long *scan_masks;
>  	const int *avail_modes_table;
>  	const int *freq_modes_map;
>  	const int *freq_table;
>  	const u8 num_accel_scales;
> +	const u8 num_incli_scales;
>  	const u8 num_avail_modes;
>  	const u8 num_channels;
>  	const u8 num_freqs;
>  	const u8 chip_id;
>  	const char *name;
> +	const bool angle;
>  };
> =20
>  /**
> @@ -156,24 +206,32 @@ static const struct sca3300_chip_info sca3300_chip_=
tbl[] =3D {
>  		.freq_table =3D sca3300_freq_tbl,
>  		.scan_masks =3D sca3300_scan_masks,
>  		.channels =3D sca3300_channels,
> +		.incli_scale_modes_map =3D NULL,
> +		.incli_scale_table =3D NULL,
> +		.num_incli_scales =3D 0,
>  		.num_avail_modes =3D 4,
>  		.name =3D "sca3300",
>  		.chip_id =3D 0x51,
>  		.num_freqs =3D 2,
> +		.angle =3D false,
>  	},
>  	{	.num_accel_scales =3D ARRAY_SIZE(scl3300_accel_scale_tbl)*2,
> +		.num_incli_scales =3D ARRAY_SIZE(scl3300_incli_scale_tbl)*2,
>  		.accel_scale_modes_map =3D scl3300_accel_scale_modes_map,
> +		.incli_scale_modes_map =3D scl3300_incli_scale_modes_map,
>  		.accel_scale_table =3D scl3300_accel_scale_tbl,
> -		.num_channels =3D ARRAY_SIZE(sca3300_channels),
> +		.incli_scale_table =3D scl3300_incli_scale_tbl,
> +		.num_channels =3D ARRAY_SIZE(scl3300_channels),
>  		.avail_modes_table =3D scl3300_avail_modes_map,
>  		.freq_modes_map =3D scl3300_freq_modes_map,
>  		.scan_masks =3D sca3300_scan_masks,
>  		.freq_table =3D scl3300_freq_tbl,
> -		.channels =3D sca3300_channels,
> +		.channels =3D scl3300_channels,
>  		.num_avail_modes =3D 3,
>  		.name =3D "scl3300",
>  		.chip_id =3D 0xC1,
>  		.num_freqs =3D 3,
> +		.angle =3D true,
>  	},
>  };
> =20
> @@ -382,6 +440,11 @@ static int sca3300_read_raw(struct iio_dev *indio_de=
v,
>  		if (ret)
>  			return ret;
>  		switch (chan->type) {
> +		case IIO_INCLI:
> +			index =3D data->chip->incli_scale_modes_map[reg_val];
> +			*val =3D data->chip->incli_scale_table[index][0];
> +			*val2 =3D data->chip->incli_scale_table[index][1];
> +			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
>  			index =3D data->chip->accel_scale_modes_map[reg_val];
>  			*val =3D data->chip->accel_scale_table[index][0];
> @@ -473,6 +536,13 @@ static int sca3300_init(struct sca3300_data *sca_dat=
a,
>  	indio_dev->name =3D sca3300_chip_tbl[i].name;
>  	indio_dev->modes =3D INDIO_DIRECT_MODE;
> =20
> +	if (sca_data->chip->angle) {
> +		ret =3D sca3300_write_reg(sca_data, SCA3300_REG_ANG_CTRL,
> +					SCA3300_ANG_ENABLE);
> +		if (ret)
> +			return ret;
> +	}
> +
>  	return 0;
>  }
> =20
> @@ -508,6 +578,11 @@ static int sca3300_read_avail(struct iio_dev *indio_=
dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
> +		case IIO_INCLI:
> +			*vals =3D (const int *)data->chip->incli_scale_table;
> +			*length =3D data->chip->num_incli_scales;
> +			*type =3D IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
>  		case IIO_ACCEL:
>  			*vals =3D (const int *)data->chip->accel_scale_table;
>  			*length =3D data->chip->num_accel_scales;

