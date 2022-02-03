Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BA3944A80EE
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 10:05:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349687AbiBCJFV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 04:05:21 -0500
Received: from metis.ext.pengutronix.de ([85.220.165.71]:52513 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231674AbiBCJFT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 04:05:19 -0500
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFXz7-0001Ju-OT; Thu, 03 Feb 2022 10:00:57 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFXz7-00EEKb-Kr; Thu, 03 Feb 2022 10:00:56 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nFXz6-005FX4-3S; Thu, 03 Feb 2022 10:00:56 +0100
Date:   Thu, 3 Feb 2022 10:00:53 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     William Breathitt Gray <vilhelm.gray@gmail.com>
Cc:     jic23@kernel.org, linux-iio@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] counter: Set counter device name
Message-ID: <20220203090053.oki5ts4c2gdpi2c6@pengutronix.de>
References: <20220203073459.90093-1-vilhelm.gray@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jh4osnqu6wmxh7l3"
Content-Disposition: inline
In-Reply-To: <20220203073459.90093-1-vilhelm.gray@gmail.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--jh4osnqu6wmxh7l3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Thu, Feb 03, 2022 at 04:34:59PM +0900, William Breathitt Gray wrote:
> Naming the counter device provides a convenient way to identify it in
> devres_log events and similar situations. This patch names the counter
> device by combining the prefix "counter" with the counter device's
> unique ID.
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: William Breathitt Gray <vilhelm.gray@gmail.com>
> ---
>  drivers/counter/counter-core.c | 12 +++++++++++-
>  1 file changed, 11 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/counter/counter-core.c b/drivers/counter/counter-cor=
e.c
> index 7e0957eea094..2ebd9adf0bd2 100644
> --- a/drivers/counter/counter-core.c
> +++ b/drivers/counter/counter-core.c
> @@ -22,6 +22,8 @@
>  #include "counter-chrdev.h"
>  #include "counter-sysfs.h"
> =20
> +#define COUNTER_NAME	"counter"
> +
>  /* Provides a unique ID for each counter device */
>  static DEFINE_IDA(counter_ida);
> =20
> @@ -104,6 +106,10 @@ struct counter_device *counter_alloc(size_t sizeof_p=
riv)
>  		goto err_ida_alloc;
>  	dev->id =3D err;
> =20
> +	err =3D dev_set_name(dev, COUNTER_NAME "%d", dev->id);
> +	if (err)
> +		goto err_dev_set_name;
> +
>  	mutex_init(&counter->ops_exist_lock);
>  	dev->type =3D &counter_device_type;
>  	dev->bus =3D &counter_bus_type;
> @@ -119,6 +125,9 @@ struct counter_device *counter_alloc(size_t sizeof_pr=
iv)
> =20
>  err_chrdev_add:
> =20
> +	kfree(dev_name(dev));
> +err_dev_set_name:
> +

I think this is wrong as kobject_cleanup frees the name.

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jh4osnqu6wmxh7l3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmH7mcIACgkQwfwUeK3K
7AlJzQf/cNuK0rtB1iKYAnzDVPvJyIJGTVT0IzvU7inl9odpeyTyYpPmlxPHpWm3
Sm6uypswc05jVj1Tk5TSzFgHUAfA1bh3V7KXFJ7co+X3KS7T/k+KZt0+wstsnVFw
lcnw+0s2ACwSPWW1tsUTnQo3UojaYBfqU/5nNN1OPoAM2BI9xZE5ghftnQqurQRm
34fjYo5xWZbrpzHvOUblwpq/BZ8O8YPg+nzo5AFyw6nSdT+Do2PUxTvZhJV7i1xX
O2rPFIxYWjxvx+I0xZfi1l7/Z2Ou1RP6oMJjmA+xhvWXlqLkM56y7a/q3fEqQDjt
9kW/x1DL5ibLqTtdItY39Yg/Op2PDQ==
=ALNc
-----END PGP SIGNATURE-----

--jh4osnqu6wmxh7l3--
