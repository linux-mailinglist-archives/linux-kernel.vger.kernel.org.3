Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CA32E4CF27B
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 08:17:18 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235782AbiCGHSI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 02:18:08 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42438 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235759AbiCGHSG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 02:18:06 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9886260CC2
        for <linux-kernel@vger.kernel.org>; Sun,  6 Mar 2022 23:17:12 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nR7c0-0000b2-F2; Mon, 07 Mar 2022 08:16:56 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nR7bz-003AYQ-6s; Mon, 07 Mar 2022 08:16:54 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nR7bx-007VVp-Pt; Mon, 07 Mar 2022 08:16:53 +0100
Date:   Mon, 7 Mar 2022 08:16:53 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Stephen Rothwell <sfr@canb.auug.org.au>
Cc:     Alex Deucher <alexdeucher@gmail.com>,
        Mark Brown <broonie@kernel.org>,
        Maxime Ripard <maxime@cerno.tech>,
        Noralf =?utf-8?Q?Tr=C3=B8nnes?= <noralf@tronnes.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the amdgpu tree
Message-ID: <20220307071653.o347jhcu4oeb5mc3@pengutronix.de>
References: <20220307111342.105ce204@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nrvgrr32lc6wsnhe"
Content-Disposition: inline
In-Reply-To: <20220307111342.105ce204@canb.auug.org.au>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--nrvgrr32lc6wsnhe
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Stephen,

On Mon, Mar 07, 2022 at 11:13:42AM +1100, Stephen Rothwell wrote:
> After merging the amdgpu tree, today's linux-next build (x86_64
> allmodconfig) failed like this:
>=20
> drivers/gpu/drm/tiny/panel-mipi-dbi.c:391:19: error: initialization of 'v=
oid (*)(struct spi_device *)' from incompatible pointer type 'int (*)(struc=
t spi_device *)' [-Werror=3Dincompatible-pointer-types]
>   391 |         .remove =3D panel_mipi_dbi_spi_remove,
>       |                   ^~~~~~~~~~~~~~~~~~~~~~~~~
>=20
> Caused by commit
>=20
>   0e65e2e6abb0 ("drm/tiny: Add MIPI DBI compatible SPI driver")
>=20
> interacting with commit
>=20
>   a0386bba7093 ("spi: make remove callback a void function")
>=20
> from the spi trees.
>=20
> I have applied the following merge fix.
>=20
> From: Stephen Rothwell <sfr@canb.auug.org.au>
> Date: Mon, 7 Mar 2022 11:01:01 +1100
> Subject: [PATCH] fix up for "spi: make remove callback a void function"
>=20
> Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
> ---
>  drivers/gpu/drm/tiny/panel-mipi-dbi.c | 4 +---
>  1 file changed, 1 insertion(+), 3 deletions(-)
>=20
> diff --git a/drivers/gpu/drm/tiny/panel-mipi-dbi.c b/drivers/gpu/drm/tiny=
/panel-mipi-dbi.c
> index 7f8c6c51387f..c759ff9c2c87 100644
> --- a/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> +++ b/drivers/gpu/drm/tiny/panel-mipi-dbi.c
> @@ -336,14 +336,12 @@ static int panel_mipi_dbi_spi_probe(struct spi_devi=
ce *spi)
>  	return 0;
>  }
> =20
> -static int panel_mipi_dbi_spi_remove(struct spi_device *spi)
> +static void panel_mipi_dbi_spi_remove(struct spi_device *spi)
>  {
>  	struct drm_device *drm =3D spi_get_drvdata(spi);
> =20
>  	drm_dev_unplug(drm);
>  	drm_atomic_helper_shutdown(drm);
> -
> -	return 0;
>  }
> =20
>  static void panel_mipi_dbi_spi_shutdown(struct spi_device *spi)

Looks right, thanks
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nrvgrr32lc6wsnhe
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIlsWIACgkQwfwUeK3K
7AmXugf+IS3BWYnSbtvGqQHTIQK6N2dS67rvC7ktTVb3FyfVt1LNgfpM/IIrQuv/
SFpYiVkXogp7du/NonbwVHY6ZtRunRlw6ghY9PRun8usJovc698Nwic/69v2qjIh
bH8NihnA9Ar/QdiioOH5eO69LYnW1OCrelrMhV93G96eFWwwbucd6nAAvkn3sN/N
pKMfMEt3IhmpYmwZcCK3wsaylfPmVUAH6JnWhnx8gzwUeuWyucJN3D6afzS/sR1p
PQBo3aEVWk6fnEM2Vq382WEjO6RLMr4hFSON4AWAsBOBX9+HNblGRtZBSq8+SXuV
reP0Ow1/P3Onb+QF2mPYQYKEWSuzfg==
=EtK9
-----END PGP SIGNATURE-----

--nrvgrr32lc6wsnhe--
