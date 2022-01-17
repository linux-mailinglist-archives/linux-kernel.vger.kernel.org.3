Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 75D0F49064C
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 11:56:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238789AbiAQK4O (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 05:56:14 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:57918 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiAQK4N (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 05:56:13 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 0964460FE8;
        Mon, 17 Jan 2022 10:56:12 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 0C0F6C36AE7;
        Mon, 17 Jan 2022 10:56:10 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1642416971;
        bh=WyPJvdRmUEPwRoLB14a6aObUcdcSgZBUxYOv6PmK66E=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=WOJ7Mq1g21hn5lAnuRXnhsSIsJe7Q5UD3AEdAhkk6F0ZFFampyGRfr0J6nI0YITWS
         TyTRUN59zdVVukOzE2m1aOnE5Yt36n27x3of1zmX1PBxiAcItWc0EZXuwBcAbY6ErW
         h5HKkIp4EuBiyokFdArbhOt0JZUiKy5XfInxgAOhAHjvtMX94anV8P99Xr+rQ5BZlz
         ZNdw9+ZF07ybL9svsVxBICN7pLrgz4ilGetxGvwVMEkF0ZbxYY8Ry4/uQXxXshpZwz
         osrsjQViITL7XNUg+QyMXorCJtUyPqRd2LjkCyoHKrC71MOrBnc0ig/2CXyS7W0+z1
         AsGYw3vFwHQ1g==
Date:   Mon, 17 Jan 2022 11:56:07 +0100
From:   Lorenzo Bianconi <lorenzo@kernel.org>
To:     Paul Cercueil <paul@crapouillou.net>
Cc:     Jonathan Cameron <jic23@kernel.org>,
        Lars-Peter Clausen <lars@metafoo.de>,
        linux-iio@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-kernel@vger.kernel.org,
        Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
Subject: Re: [PATCH 1/2] iio: imu: st_lsm6dsx: Limit requested watermark
 value to hwfifo size
Message-ID: <YeVLRzmUw/U9GRC3@lore-desk>
References: <20220117102512.31725-1-paul@crapouillou.net>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bP2/75p4uu4UIPkj"
Content-Disposition: inline
In-Reply-To: <20220117102512.31725-1-paul@crapouillou.net>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bP2/75p4uu4UIPkj
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

> Instead of returning an error if the watermark value is too high, which
> the core will silently ignore anyway, limit the value to the hardware
> FIFO size; a lower-than-requested value is still better than using the
> default, which is usually 1.
>=20

Acked-by: Lorenzo Bianconi <lorenzo@kernel.org>

> Cc: Lorenzo Bianconi <lorenzo.bianconi83@gmail.com>
> Signed-off-by: Paul Cercueil <paul@crapouillou.net>
> ---
>  drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c b/drivers/iio/i=
mu/st_lsm6dsx/st_lsm6dsx_core.c
> index 727b4b6ac696..5fd46bf1a11b 100644
> --- a/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> +++ b/drivers/iio/imu/st_lsm6dsx/st_lsm6dsx_core.c
> @@ -54,6 +54,7 @@
>  #include <linux/iio/sysfs.h>
>  #include <linux/interrupt.h>
>  #include <linux/irq.h>
> +#include <linux/minmax.h>
>  #include <linux/pm.h>
>  #include <linux/property.h>
>  #include <linux/regmap.h>
> @@ -1607,8 +1608,7 @@ int st_lsm6dsx_set_watermark(struct iio_dev *iio_de=
v, unsigned int val)
>  	struct st_lsm6dsx_hw *hw =3D sensor->hw;
>  	int err;
> =20
> -	if (val < 1 || val > hw->settings->fifo_ops.max_size)
> -		return -EINVAL;
> +	val =3D clamp_val(val, 1, hw->settings->fifo_ops.max_size);
> =20
>  	mutex_lock(&hw->conf_lock);
> =20
> --=20
> 2.34.1
>=20

--bP2/75p4uu4UIPkj
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iHUEABYKAB0WIQTquNwa3Txd3rGGn7Y6cBh0uS2trAUCYeVLRgAKCRA6cBh0uS2t
rM07AP4nFkyIdNtLaE6ZhYiaSwvF1FlkQJNl3Hsa7eTwNQwWSwD/e6jifcjD2e53
sQcPYAXSVQEW/aPuHbAoY8i8f/GO8Q4=
=Gqbr
-----END PGP SIGNATURE-----

--bP2/75p4uu4UIPkj--
