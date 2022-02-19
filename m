Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96D9D4BC9B4
	for <lists+linux-kernel@lfdr.de>; Sat, 19 Feb 2022 19:09:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242743AbiBSSJ3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 19 Feb 2022 13:09:29 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:40000 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235751AbiBSSJ1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 19 Feb 2022 13:09:27 -0500
Received: from ams.source.kernel.org (ams.source.kernel.org [145.40.68.75])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 300D09FF6;
        Sat, 19 Feb 2022 10:09:08 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id D1BDFB8006F;
        Sat, 19 Feb 2022 18:09:06 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 29D80C004E1;
        Sat, 19 Feb 2022 18:09:02 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1645294145;
        bh=SJGNoJSmk16eqKEQZWdKnvYqxDTdBErC26etaQ5PC1A=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=lIX8R5N1CoJpvx8LOuW6TkpjpHQkD6KVt0quHBJIeFi9BaDZCHKqM+469JlUbAG0Z
         RNEr3ThPpg9JtQhSS59wK4UJupelYiD5EXi7c2r9UUfokgxhfINvBb5YzJcffub8l7
         W763NZexVKGBW0tnUAN7+51Lj5N7/G5KW8WNSCMucyTn+zanj4T+7buzLZom720cQ4
         x7uG6BZs2p5gx1TGGWt6wsPYKXrqeTaoRjSPAqG7UkmYzjt1yf/5TXao0Ai1lQ2tlz
         X/CVXpiycBTe3N5BiF8w8GvxKYaspxe/SO8HOn4YzR80FxwIrJuNlSLmkyJ3la0hVC
         K01y36+fuzohA==
Date:   Sat, 19 Feb 2022 18:15:52 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-iio@vger.kernel.org,
        bsp-development.geo@leica-geosystems.com
Subject: Re: [PATCH V2 5/5] iio: accel: sca3300: Add inclination channels.
Message-ID: <20220219181552.5ade5dd1@jic23-huawei>
In-Reply-To: <20220217062705.2867149-6-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220217062705.2867149-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220217062705.2867149-6-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-7.2 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Thu, 17 Feb 2022 06:27:05 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> Different with SCA3300, SCL3300 can output inclination angles.
> Angles are formed from acceleration with following equations:
> ANG_X =3D atan2(accx / =E2=88=9A(accy^2 + accz^2)),
> ANG_Y =3D atan2(accy / =E2=88=9A(accx^2 + accz^2)),
> ANG_Z =3D atan2(accz / =E2=88=9A(accx^2 + accy^2)),
>=20
> The commit add output of the raw value,scale
> and scale_available of angles.

Hi,

As it came up in another review today, could you confirm
the units of incli after application of scale?  The units
of angles have unfortunately become a bit of a mess over time :(
See the BNO055 review for more discussion.

incli is documented as being in degrees so that should be the case here
as well.

Otherwise, just one comment inline which is really a request to add a little
more to the description of patch 3 to say it is preparing the way for addit=
ional
channels.

Looks good to me.
Thanks,

Jonathan


>=20
> New interfaces:
>   in_incli_scale
>   in_incli_scale_available
>   in_incli_x_raw
>   in_incli_y_raw
>   in_incli_z_raw
>=20
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
> ---
>  drivers/iio/accel/sca3300.c | 48 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 48 insertions(+)
>=20
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index 123ab9a784d2..5c86b143d17a 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -64,6 +64,9 @@ enum sca3300_scan_indexes {
>  	SCA3300_ACC_Y,
>  	SCA3300_ACC_Z,
>  	SCA3300_TEMP,
> +	SCA3300_INCLI_X,
> +	SCA3300_INCLI_Y,
> +	SCA3300_INCLI_Z,
>  	SCA3300_TIMESTAMP,
>  };
> =20
> @@ -88,6 +91,24 @@ enum sca3300_scan_indexes {
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
> @@ -115,6 +136,9 @@ static const struct iio_chan_spec scl3300_channels[] =
=3D {
>  	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Y, 0x2, Y),
>  	SCA3300_ACCEL_CHANNEL(SCA3300_ACC_Z, 0x3, Z),
>  	SCA3300_TEMP_CHANNEL(SCA3300_TEMP, 0x05),
> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_X, 0x09, X),
> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Y, 0x0A, Y),
> +	SCA3300_INCLI_CHANNEL(SCA3300_INCLI_Z, 0x0B, Z),
>  	IIO_CHAN_SOFT_TIMESTAMP(SCA3300_TIMESTAMP),
>  };
> =20
> @@ -124,17 +148,28 @@ static const int scl3300_lp_freq_table[] =3D {40, 7=
0, 10, 10};
>  static const int sca3300_accel_scale_table[][2] =3D {{0, 370}, {0, 741},=
 {0, 185}, {0, 185}};
>  static const int scl3300_accel_scale_table[][2] =3D {{0, 167}, {0, 333},=
 {0, 83}, {0, 83}};
> =20
> +static const int scl3300_incli_scale_table[][2] =3D {{0, 5495}, {0, 5495=
}, {0, 5495}, {0, 5495}};
> +
>  static const unsigned long sca3300_scan_masks[] =3D {
>  	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
>  	BIT(SCA3300_TEMP),
>  	0,
>  };
> =20
> +static const unsigned long scl3300_scan_masks[] =3D {
> +	BIT(SCA3300_ACC_X) | BIT(SCA3300_ACC_Y) | BIT(SCA3300_ACC_Z) |
> +	BIT(SCA3300_TEMP)  |
> +	BIT(SCA3300_INCLI_X) | BIT(SCA3300_INCLI_Y) | BIT(SCA3300_INCLI_Z),
> +	0,
> +};
> +
>  struct sca3300_chip_info {
>  	const struct iio_chan_spec *channels;
>  	enum sca3300_chip_type chip_type;
>  	const int (*accel_scale_table)[2];
> +	const int (*incli_scale_table)[2];
>  	unsigned int num_accel_scales;
> +	unsigned int num_incli_scales;
>  	unsigned long scan_masks;
>  	unsigned int num_freqs;
>  	const int *freq_table;
> @@ -172,14 +207,18 @@ static const struct sca3300_chip_info sca3300_chip_=
info_tbl[] =3D {
>  		.scan_masks =3D sca3300_scan_masks,
>  		.channels =3D sca3300_channels,
>  		.chip_type =3D CHIP_SCA3300,
> +		.incli_scale_table =3D NULL,
> +		.num_incli_scales =3D 0,
>  		.name =3D "sca3300",
>  		.chip_id =3D 0x51,
>  		.num_freqs =3D 2,
>  	},
>  	[CHIP_SCL3300] =3D {
>  		.num_accel_scales =3D ARRAY_SIZE(scl3300_accel_scale_table)*2-1,
> +		.num_incli_scales =3D ARRAY_SIZE(scl3300_lp_freq_table)-1,
>  		.num_channels =3D ARRAY_SIZE(scl3300_channels),
>  		.accel_scale_table =3D scl3300_accel_scale_table,
> +		.incli_scale_table =3D scl3300_incli_scale_table,
>  		.freq_table =3D scl3300_lp_freq_table,
>  		.scan_masks =3D sca3300_scan_masks,
>  		.channels =3D scl3300_channels,
> @@ -378,6 +417,10 @@ static int sca3300_read_raw(struct iio_dev *indio_de=
v,
>  		if (ret)
>  			return ret;
>  		switch (chan->type) {
> +		case IIO_INCLI:

Ah. This is why you had the switch in the earlier patch. Makes sense now!
Please add to the description of patch 3 that it also prepares for the addi=
tion of
extra channels.

> +			*val =3D  data->chip_info->incli_scale_table[reg_val][0];
> +			*val2 =3D data->chip_info->incli_scale_table[reg_val][1];
> +			return IIO_VAL_INT_PLUS_MICRO;
>  		case IIO_ACCEL:
>  			*val =3D  data->chip_info->accel_scale_table[reg_val][0];
>  			*val2 =3D data->chip_info->accel_scale_table[reg_val][1];
> @@ -507,6 +550,11 @@ static int sca3300_read_avail(struct iio_dev *indio_=
dev,
>  	switch (mask) {
>  	case IIO_CHAN_INFO_SCALE:
>  		switch (chan->type) {
> +		case IIO_INCLI:
> +			*vals =3D (const int *)data->chip_info->incli_scale_table;
> +			*length =3D data->chip_info->num_incli_scales;
> +			*type =3D IIO_VAL_INT_PLUS_MICRO;
> +			return IIO_AVAIL_LIST;
>  		case IIO_ACCEL:
>  			*vals =3D (const int *)data->chip_info->accel_scale_table;
>  			*length =3D data->chip_info->num_accel_scales;

