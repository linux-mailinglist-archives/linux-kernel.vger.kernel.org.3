Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35AFE48895F
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 13:31:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235521AbiAIMbq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 9 Jan 2022 07:31:46 -0500
Received: from 82-65-109-163.subs.proxad.net ([82.65.109.163]:47828 "EHLO
        luna.linkmauve.fr" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233804AbiAIMbp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 9 Jan 2022 07:31:45 -0500
Received: by luna.linkmauve.fr (Postfix, from userid 1000)
        id 891F8F403B5; Sun,  9 Jan 2022 13:31:41 +0100 (CET)
Date:   Sun, 9 Jan 2022 13:31:41 +0100
From:   Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     Alessandro Zummo <a.zummo@towertech.it>,
        Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>,
        Alexandre Belloni <alexandre.belloni@bootlin.com>,
        Michael Ellerman <mpe@ellerman.id.au>,
        linux-rtc@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel-janitors@vger.kernel.org
Subject: Re: [PATCH] rtc: gamecube: Fix an IS_ERR() vs NULL check
Message-ID: <20220109123141.5hq5osei3v5ebbo2@luna>
Jabber-ID: linkmauve@linkmauve.fr
References: <20220107073340.GF22086@kili>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha256;
        protocol="application/pgp-signature"; boundary="ydtq75hapnv2bv4l"
Content-Disposition: inline
In-Reply-To: <20220107073340.GF22086@kili>
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ydtq75hapnv2bv4l
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Jan 07, 2022 at 10:33:40AM +0300, Dan Carpenter wrote:
> The devm_kzalloc() function returns NULL on error, it doesn't return
> error pointers.

Good catch, thanks!

Reviewed-by: Emmanuel Gil Peyrot <linkmauve@linkmauve.fr>

>=20
> Fixes: 86559400b3ef ("rtc: gamecube: Add a RTC driver for the GameCube, W=
ii and Wii U")
> Signed-off-by: Dan Carpenter <dan.carpenter@oracle.com>
> ---
>  drivers/rtc/rtc-gamecube.c | 4 ++--
>  1 file changed, 2 insertions(+), 2 deletions(-)
>=20
> diff --git a/drivers/rtc/rtc-gamecube.c b/drivers/rtc/rtc-gamecube.c
> index 98128746171e..f717b36f4738 100644
> --- a/drivers/rtc/rtc-gamecube.c
> +++ b/drivers/rtc/rtc-gamecube.c
> @@ -319,8 +319,8 @@ static int gamecube_rtc_probe(struct platform_device =
*pdev)
>  	int ret;
> =20
>  	d =3D devm_kzalloc(dev, sizeof(struct priv), GFP_KERNEL);
> -	if (IS_ERR(d))
> -		return PTR_ERR(d);
> +	if (!d)
> +		return -ENOMEM;
> =20
>  	d->iob =3D devm_platform_ioremap_resource(pdev, 0);
>  	if (IS_ERR(d->iob))
> --=20
> 2.20.1

--=20
Emmanuel Gil Peyrot

--ydtq75hapnv2bv4l
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCAAdFiEEjrVT1SzTln43kCLJOWgfYkb2LpAFAmHa1akACgkQOWgfYkb2
LpB9BQf/f342kBvI7hwKfQZlT5DyulLVbI/BRz5g+/DA30vRZz9J2ohwXm6Igjd4
JspkzZiBLqAKMynOJG/lYNtRnY0rrO5R6wnuoWZBgOZjLqZDEIUdYqi0VKwO14Nm
/Dv8BbFampCNdExakaNX7B0D/yAc1KpcI8PJINsKxzvbI2lz9eVppnLZ1oTus7EV
V13+eIgkgTILLEq71Q/VrSlTrPRjo6WLB6MU4kuDpaPXHH7W8lHLrdpxCzkRYN6U
ri/2dVP7h2AP2MkPJPdCHawXULyPGgzO2AoRVPgrZ3WN0TEmNHJx41TJZcrIlsBG
+IIgo/LECX0WGA7RMwivqIrlmrKkJA==
=F1gM
-----END PGP SIGNATURE-----

--ydtq75hapnv2bv4l--
