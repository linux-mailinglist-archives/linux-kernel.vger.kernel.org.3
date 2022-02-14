Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DDAB74B5218
	for <lists+linux-kernel@lfdr.de>; Mon, 14 Feb 2022 14:49:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354626AbiBNNtE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 14 Feb 2022 08:49:04 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60274 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354609AbiBNNtD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 14 Feb 2022 08:49:03 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5F4C0496BE
        for <linux-kernel@vger.kernel.org>; Mon, 14 Feb 2022 05:48:55 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJbim-0005aS-7f; Mon, 14 Feb 2022 14:48:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJbil-00GYdt-SZ; Mon, 14 Feb 2022 14:48:51 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nJbik-0038Ma-HE; Mon, 14 Feb 2022 14:48:50 +0100
Date:   Mon, 14 Feb 2022 14:48:50 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org,
        matthias.bgg@gmail.com, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, kernel@collabora.com
Subject: Re: [PATCH 1/2] pwm: pwm-mediatek: Simplify error handling with
 dev_err_probe()
Message-ID: <20220214134850.aqmd7wjxjsjyuwz7@pengutronix.de>
References: <20220214113038.79130-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="6nlrjmjngwerlej6"
Content-Disposition: inline
In-Reply-To: <20220214113038.79130-1-angelogioacchino.delregno@collabora.com>
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


--6nlrjmjngwerlej6
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Feb 14, 2022 at 12:30:37PM +0100, AngeloGioacchino Del Regno wrote:
> Use dev_err_probe() to simplify handling errors in pwm_mediatek_probe().
>=20
> Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@coll=
abora.com>
> ---
>  drivers/pwm/pwm-mediatek.c | 30 +++++++++++-------------------
>  1 file changed, 11 insertions(+), 19 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-mediatek.c b/drivers/pwm/pwm-mediatek.c
> index 0d4dd80e9f07..c7d5ca09a684 100644
> --- a/drivers/pwm/pwm-mediatek.c
> +++ b/drivers/pwm/pwm-mediatek.c
> @@ -227,18 +227,14 @@ static int pwm_mediatek_probe(struct platform_devic=
e *pdev)
>  		return -ENOMEM;
> =20
>  	pc->clk_top =3D devm_clk_get(&pdev->dev, "top");
> -	if (IS_ERR(pc->clk_top)) {
> -		dev_err(&pdev->dev, "clock: top fail: %ld\n",
> -			PTR_ERR(pc->clk_top));
> -		return PTR_ERR(pc->clk_top);
> -	}
> +	if (IS_ERR(pc->clk_top))
> +		return dev_err_probe(&pdev->dev, PTR_ERR(pc->clk_top),
> +				     "clock: top failed\n");

The change looks straight forward. I wonder if we should improve the
error message on this occasion. E.g.

	"Failed to get top clock\n"

? Ditto below.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--6nlrjmjngwerlej6
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIKXb8ACgkQwfwUeK3K
7Aliqwf/XuM5oenKJm6jXphWn2Qtm3C59pE9WKUd6icfLW3luXqPk/EmMDSVH8SP
t2zQLHAjrm5IyFhyBzG/1z3/fkU8zCW8XyzxDWnuq95Djn0tE4WS8K1sfcnkz1r4
icA07XD2y3MQ04KtcO0v+GovSJkwDGoAA1zCFi/7o5GeMIdmdeOCBvK8wlLH1dgW
tOqYCH2CRGueyxg7VjUoiJT1F1o/gI1tA7dNI4r47xfYkqWYazR2oTl0vLoBUw9M
m4QLYq8FGN5xq6JfWcXeJgUQw9Y9G/9+yraFi761ZSR9YThR3qFR4hRX/JneVBp4
J8oPUKwWfDi7zmRSLS7NUVorW1ZWWw==
=qf+h
-----END PGP SIGNATURE-----

--6nlrjmjngwerlej6--
