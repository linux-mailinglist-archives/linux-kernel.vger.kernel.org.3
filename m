Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E8ADA4A35F6
	for <lists+linux-kernel@lfdr.de>; Sun, 30 Jan 2022 12:33:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354656AbiA3Ldy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 30 Jan 2022 06:33:54 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:39254 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345859AbiA3Ldx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 30 Jan 2022 06:33:53 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D50546115D;
        Sun, 30 Jan 2022 11:33:51 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 6207BC340EB;
        Sun, 30 Jan 2022 11:33:49 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1643542431;
        bh=5NKTHYf9qfw+XWWSSEmtx2NccHwHtTA8E7p6Ql+YmJE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=nPuA8lqgQqF9ABwZyTmeo4Li8F6WIZkJi4QlYJOmcYdILOS51VDoDzKmAd/lxrqY+
         ayAMwB6BxOjmZ0ibEcRu9Bmzt+4BqkupLDXVFhwXf+Eo17l/ieqUPWjYcblK4O0A8k
         SqQd7l4tNYLS9dP93M/f93j6kZmmjzbcKShp+FtBFu0zasbFczt/8zTwucx1uxNSKn
         5g8zMYcN9IqxJjc7su/rvTinxUQCHwfqkrYuFXD0VvLPDapJOUTFCiuOojMguvM1EX
         bnAuSxkxzji5dWoO+tubSobu04p9+izcDlWboignIILGld74LPTsdr3UvI+J1eKU0z
         jjmY8e+uwnD6Q==
Date:   Sun, 30 Jan 2022 11:40:14 +0000
From:   Jonathan Cameron <jic23@kernel.org>
To:     LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>
Cc:     lars@metafoo.de, robh+dt@kernel.org, tomas.melin@vaisala.com,
        andy.shevchenko@gmail.com, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH V1 2/6] iio: accel: sca3300: Add interface for operation
 modes.
Message-ID: <20220130114014.38923fb4@jic23-huawei>
In-Reply-To: <20220124093912.2429190-3-Qing-wu.Li@leica-geosystems.com.cn>
References: <20220124093912.2429190-1-Qing-wu.Li@leica-geosystems.com.cn>
        <20220124093912.2429190-3-Qing-wu.Li@leica-geosystems.com.cn>
X-Mailer: Claws Mail 4.0.0 (GTK+ 3.24.31; x86_64-pc-linux-gnu)
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: quoted-printable
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On Mon, 24 Jan 2022 09:39:08 +0000
LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn> wrote:

> The acceleration scale and the frequency were set via operation modes,
> the scal and frequency are both non-uniqueness,
> this leads to logic confusion for setting scale.and.frequency.
> it getting worse if add more different sensor types into the driver.
>=20
> The commit add an interface for set and get the operation modes.
> the following interfaces added:
> in_accel_op_mode_available
> in_op_mode
>=20
> SCA3300 operation modes table:
> | Mode | Full-scale | low pass filter frequency |
> | ---- | ---------- | ------------------------- |
> | 1    | =C2=B1 3 g      | 70 Hz                     |
> | 2    | =C2=B1 6 g      | 70 Hz                     |
> | 3    | =C2=B1 1.5 g    | 70 Hz                     |
> | 4    | =C2=B1 1.5 g    | 10 Hz                     |
>=20
> Signed-off-by: LI Qingwu <Qing-wu.Li@leica-geosystems.com.cn>

While it may seem convenient to expose this to userspace, the reality is
that generic userspace has no way to know how to use it.

That makes supplying this control a bad idea however convenient it
may seem.  It's not unusual to have these sorts of constraints on
devices and so the ABI always assumes any setting may modify any other
and / or change what is available for a given setting.

If you need a particular combination for your own userspace, then
make the userspace aware of the constraints rather than exposing it
as a 'mode' which the userspace will need to know about anyway.

Jonathan


> ---
>  drivers/iio/accel/sca3300.c | 55 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 55 insertions(+)
>=20
> diff --git a/drivers/iio/accel/sca3300.c b/drivers/iio/accel/sca3300.c
> index 083ae2a47ad9..e26b3175b3c6 100644
> --- a/drivers/iio/accel/sca3300.c
> +++ b/drivers/iio/accel/sca3300.c
> @@ -42,6 +42,38 @@
>  /* Device return status and mask */
>  #define SCA3300_VALUE_RS_ERROR	0x3
>  #define SCA3300_MASK_RS_STATUS	GENMASK(1, 0)
> +enum sca3300_op_mode_indexes {
> +	OP_MOD_1 =3D 0,
> +	OP_MOD_2,
> +	OP_MOD_3,
> +	OP_MOD_4,
> +	OP_MOD_CNT
> +};
> +
> +static const char * const sca3300_op_modes[] =3D {
> +	[OP_MOD_1] =3D "1",
> +	[OP_MOD_2] =3D "2",
> +	[OP_MOD_3] =3D "3",
> +	[OP_MOD_4] =3D "4"
> +};
> +
> +static int sca3300_get_op_mode(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan);
> +static int sca3300_set_op_mode(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan, unsigned int mode);
> +
> +static const struct iio_enum sca3300_op_mode_enum =3D {
> +	.items =3D sca3300_op_modes,
> +	.num_items =3D ARRAY_SIZE(sca3300_op_modes),
> +	.get =3D sca3300_get_op_mode,
> +	.set =3D sca3300_set_op_mode,
> +};
> +
> +static const struct iio_chan_spec_ext_info sca3300_ext_info[] =3D {
> +	IIO_ENUM("op_mode", IIO_SHARED_BY_DIR, &sca3300_op_mode_enum),
> +	IIO_ENUM_AVAILABLE("op_mode", &sca3300_op_mode_enum),
> +	{ }
> +};
> =20
>  enum sca3300_scan_indexes {
>  	SCA3300_ACC_X =3D 0,
> @@ -70,6 +102,7 @@ enum sca3300_scan_indexes {
>  		.storagebits =3D 16,					\
>  		.endianness =3D IIO_CPU,					\
>  	},								\
> +	.ext_info =3D sca3300_ext_info,					\
>  }
> =20
>  #define SCA3300_TEMP_CHANNEL(index, reg) {				\
> @@ -400,6 +433,28 @@ static int sca3300_read_avail(struct iio_dev *indio_=
dev,
>  	}
>  }
> =20
> +static int sca3300_get_op_mode(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan)
> +{
> +	int mode;
> +	int ret;
> +	struct sca3300_data *data =3D iio_priv(indio_dev);
> +
> +	ret =3D sca3300_read_reg(data, SCA3300_REG_MODE, &mode);
> +	if (ret)
> +		return ret;
> +	return mode;
> +
> +}
> +
> +static int sca3300_set_op_mode(struct iio_dev *indio_dev,
> +		const struct iio_chan_spec *chan, unsigned int mode)
> +{
> +	struct sca3300_data *data =3D iio_priv(indio_dev);
> +
> +	return sca3300_write_reg(data, SCA3300_REG_MODE, mode);
> +}
> +
>  static const struct iio_info sca3300_info =3D {
>  	.read_raw =3D sca3300_read_raw,
>  	.write_raw =3D sca3300_write_raw,

