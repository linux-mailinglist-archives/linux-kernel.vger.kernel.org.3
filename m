Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B7C6A550B25
	for <lists+linux-kernel@lfdr.de>; Sun, 19 Jun 2022 16:18:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232087AbiFSOSN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 10:18:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54644 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229447AbiFSOSK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 10:18:10 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7A2452635;
        Sun, 19 Jun 2022 07:18:09 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 171C460F61;
        Sun, 19 Jun 2022 14:18:09 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id EA72AC34114;
        Sun, 19 Jun 2022 14:18:06 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1655648288;
        bh=m0J4H+mG6jDWlaC62PywH35uXmKJtmGHeOSShrPjBiE=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=pYQ2xPcyrIjVRdaQPCb4PCqqJ9XqOmXUpA3hCZUTzpYEI5hq/Osu+vdTEUP3ggRQZ
         ru1z16PnKsOPDPcwVjbF5fB1g/dlynShf3dSK8g4nrHXOB2It/pWB1MmsurEXPIQHD
         zhiOGApzzX95VjMi62LaG6UfqUc2lBYauP13FQcqIFhT3lr458vzY85dGNzt7BVJA7
         2cJ23ND/w5wPTkzFpxdPU7BcK0nF7ewQXpTv5h3VF2xFvcv25NPsL+wsuluDpnStJg
         5U7Zy0sgiUKGFdjOWRIhBCPDkc6AtPpibEktTz8T9gw4cSxwS5odYTftaJXKIMedvV
         4ByORBrXUpCjA==
Date:   Sun, 19 Jun 2022 15:27:26 +0100
From:   Jonathan Cameron <jic23@kernel.org>
To:     Quentin Schulz <foss+kernel@0leil.net>
Cc:     lars@metafoo.de, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: Re: [PATCH] iio: accel: mxc4005: report orientation of
 accelerometer
Message-ID: <20220619152726.030f8e27@jic23-huawei>
In-Reply-To: <20220615110240.684744-1-foss+kernel@0leil.net>
References: <20220615110240.684744-1-foss+kernel@0leil.net>
X-Mailer: Claws Mail 4.1.0 (GTK 3.24.34; x86_64-pc-linux-gnu)
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

On Wed, 15 Jun 2022 13:02:40 +0200
Quentin Schulz <foss+kernel@0leil.net> wrote:

> From: Quentin Schulz <quentin.schulz@theobroma-systems.com>
>=20
Hi Quentin,

Interesting / horribly ill defined little feature ;)

> The accelerometer can report precise values for x, y and z accelerations
> but it can also simply report its orientation on XY plane and Z axis.
>=20
> Since the orientation of the device may be enough information for
> userspace and allows to avoid expensive fusion algorithms, let's add
> support for it.
>=20
> The orientation register stores a 2b value for XY plane orientation:
> between 225=C2=B0 and 315=C2=B0, returns 0, between 315=C2=B0 and 45=C2=
=B0, 1, between 45=C2=B0
> and 135=C2=B0, 2 and between 135=C2=B0 and 225=C2=B0, 3. We "round" those=
 to 270=C2=B0,
> 0=C2=B0, 90=C2=B0 and 180=C2=B0 degrees.

Wow. The datasheet description of this very confusing...
One key thing is we need to be careful of is that tilt (x/y is
not always available - but rather shows the last, and probably
now garbage, value)
>=20
> For Z axis, the register bit returns 0 if facing the user, 1 otherwise,
> which the driver translates to 0=C2=B0 and 180=C2=B0 respectively.

I assume facing up vs facing down?  User might be lying on their
back in which case this description doesn't work.  The datasheet
also talks about the case where g lies near the XY plane and hence
the z axis is horizontal.


>=20
> Those values are proper if the accelerometer is mounted such that the
> XYZ axes are as follows when the device is facing the user in portrait
> mode (respecting the right-hand rule):
>=20
>      y
>      ^
>      |
>      |
>      |
>      +----------> x
>     /
>    /
>   /
>  L
> z
>=20
> Since this information is very basic, imprecise (only 4 values for XY
> plane and 2 for Z axis) and can be extrapolated from the actual,
> precise, x, y and z acceleration values, it is not made available
> through buffers.
>=20
> A change in XY plane or Z axis orientation can also trigger an interrupt
> but this feature is not added in this commit.
>=20
> Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
> ---
>  drivers/iio/accel/mxc4005.c | 39 +++++++++++++++++++++++++++++++++++++
>  1 file changed, 39 insertions(+)
>=20
> diff --git a/drivers/iio/accel/mxc4005.c b/drivers/iio/accel/mxc4005.c
> index b3afbf064915..61f24058d239 100644
> --- a/drivers/iio/accel/mxc4005.c
> +++ b/drivers/iio/accel/mxc4005.c
> @@ -20,6 +20,11 @@
>  #define MXC4005_IRQ_NAME		"mxc4005_event"
>  #define MXC4005_REGMAP_NAME		"mxc4005_regmap"
> =20
> +#define MXC4005_REG_TILT_ORIENT		0x01
> +#define MXC4005_REG_TILT_ORIENT_Z_MASK		BIT(6)

I think you need to deal with BIT(7) as well.

> +#define MXC4005_REG_TILT_ORIENT_XY_MASK		GENMASK(5, 4)
> +#define MXC4005_REG_TILT_ORIENT_XY_SHIFT	4

Don't define the shift, you can use FIELD_GET(MASK, val)

> +
>  #define MXC4005_REG_XOUT_UPPER		0x03
>  #define MXC4005_REG_XOUT_LOWER		0x04
>  #define MXC4005_REG_YOUT_UPPER		0x05
> @@ -96,6 +101,7 @@ static const struct attribute_group mxc4005_attrs_grou=
p =3D {
>  static bool mxc4005_is_readable_reg(struct device *dev, unsigned int reg)
>  {
>  	switch (reg) {
> +	case MXC4005_REG_TILT_ORIENT:
>  	case MXC4005_REG_XOUT_UPPER:
>  	case MXC4005_REG_XOUT_LOWER:
>  	case MXC4005_REG_YOUT_UPPER:
> @@ -214,6 +220,28 @@ static int mxc4005_read_raw(struct iio_dev *indio_de=
v,
>  	int ret;
> =20
>  	switch (mask) {
> +	case IIO_CHAN_INFO_PROCESSED:
> +		switch (chan->type) {
> +		case IIO_ROT:
> +			ret =3D regmap_read(data->regmap, chan->address, val);
> +			if (ret < 0) {
> +				dev_err(data->dev, "failed to read rotation\n");
> +				return ret;
> +			}
> +
> +			if (chan->channel2 =3D=3D IIO_MOD_X_AND_Y) {
> +				*val &=3D MXC4005_REG_TILT_ORIENT_XY_MASK;
> +				*val >>=3D MXC4005_REG_TILT_ORIENT_XY_SHIFT;
FIELD_GET()

> +				/* 00 =3D 270=C2=B0; 01 =3D 0=C2=B0; 10 =3D 90=C2=B0; 11 =3D 180=C2=
=B0 */
> +				*val =3D (360 + (*val - 1) * 90) % 360;

In event of tilt not being set (BIT (7)) I think you should return an error
code here.  -EBUSY perhaps? To reflect the fact we don't have valid data.

> +			} else {
> +				*val &=3D MXC4005_REG_TILT_ORIENT_Z_MASK;
> +				*val =3D *val ? 180 : 0;
Documentation for this is really confusing, as it refers to a circumstance
when it can be assumed to be horizontal, but then doesn't define it.

It might be a simple as tilt being set and thus indicating significant
acceleration due to gravity in the xy plane.
However, the Z orientation is still updated in that case...

> +			}
> +			return IIO_VAL_INT;
> +		default:
> +			return -EINVAL;
> +		}
>  	case IIO_CHAN_INFO_RAW:
>  		switch (chan->type) {
>  		case IIO_ACCEL:
> @@ -287,11 +315,22 @@ static const unsigned long mxc4005_scan_masks[] =3D=
 {
>  	},							\
>  }
> =20
> +#define MXC4005_CHANNEL_ORIENTATION(_axis) {			\
> +	.type =3D IIO_ROT,					\

Hmm.  Should this be rotation or inclination (so referenced
to gravity).  Inclination is not particularly tightly defined but the
point is that it is relative to gravity - kind of a special case of
rot.

For the adis16209 we handled inclination and rotation.  I think rotation
in that device corresponds to XY here. (though it's oddly defined for
X axis, whereas I'm fairly sure it should be Z - as rotation 'about'
z axis). The Z one here should I think be an inclination because it's not
about any particular axis.

We also have angle to confuse matters. In that case intent was 'between'
two things. Arguably all the uses of rot are as well, just that one of those
things is gravity or magnetic north.  With hindsight I think we could have
gotten away with one of them, but hard to tidy up now.

In conclusion, what you have here I think is best described as
IIO_ROT about Z axis (the XY one)
and IIO_INCL for the Z axis (the Z one).

> +	.modified =3D 1,						\
> +	.channel2 =3D IIO_MOD_##_axis,				\
> +	.address =3D MXC4005_REG_TILT_ORIENT,			\
> +	.info_mask_separate =3D BIT(IIO_CHAN_INFO_PROCESSED),	\
> +	.scan_index =3D -1,					\
> +}
> +
>  static const struct iio_chan_spec mxc4005_channels[] =3D {
>  	MXC4005_CHANNEL(X, MXC4005_REG_XOUT_UPPER),
>  	MXC4005_CHANNEL(Y, MXC4005_REG_YOUT_UPPER),
>  	MXC4005_CHANNEL(Z, MXC4005_REG_ZOUT_UPPER),
>  	IIO_CHAN_SOFT_TIMESTAMP(3),
> +	MXC4005_CHANNEL_ORIENTATION(X_AND_Y),
> +	MXC4005_CHANNEL_ORIENTATION(Z),
>  };
> =20
>  static irqreturn_t mxc4005_trigger_handler(int irq, void *private)

