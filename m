Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 95B6A5980CA
	for <lists+linux-kernel@lfdr.de>; Thu, 18 Aug 2022 11:27:31 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234581AbiHRJ0j (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 18 Aug 2022 05:26:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32794 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235211AbiHRJ0b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 18 Aug 2022 05:26:31 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 48FFFB0B35
        for <linux-kernel@vger.kernel.org>; Thu, 18 Aug 2022 02:26:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oObnC-00069T-EB; Thu, 18 Aug 2022 11:26:22 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oObn9-000U8E-ER; Thu, 18 Aug 2022 11:26:19 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oObn8-00CV21-Oe; Thu, 18 Aug 2022 11:26:18 +0200
Date:   Thu, 18 Aug 2022 11:26:18 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     zhaoxiao <zhaoxiao@uniontech.com>
Cc:     thierry.reding@gmail.com, heiko@sntech.de,
        linux-pwm@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v2] pwm: rockchip: Convert to use dev_err_probe()
Message-ID: <20220818092618.ek6sg64jgamfl4lm@pengutronix.de>
References: <20220818075503.18442-1-zhaoxiao@uniontech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ylelyo52mqncwfjb"
Content-Disposition: inline
In-Reply-To: <20220818075503.18442-1-zhaoxiao@uniontech.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--ylelyo52mqncwfjb
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Aug 18, 2022 at 03:55:03PM +0800, zhaoxiao wrote:
> It's fine to call dev_err_probe() in ->probe() when error code is known.
> Convert the driver to use dev_err_probe().
>=20
> Signed-off-by: zhaoxiao <zhaoxiao@uniontech.com>

Is zhaoxiao your real name, or is that a nickname/pseudonym? If the
latter please use your real name here. See
Documentation/process/submitting-patches.rst for the justification.

> ---
>  v2: remove the %d in the message.
>=20
>  drivers/pwm/pwm-rockchip.c | 10 +++-------
>  1 file changed, 3 insertions(+), 7 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-rockchip.c b/drivers/pwm/pwm-rockchip.c
> index f3647b317152..c6e088c1a6bf 100644
> --- a/drivers/pwm/pwm-rockchip.c
> +++ b/drivers/pwm/pwm-rockchip.c
> @@ -330,16 +330,12 @@ static int rockchip_pwm_probe(struct platform_devic=
e *pdev)
> =20
>  	if (IS_ERR(pc->pclk)) {
>  		ret =3D PTR_ERR(pc->pclk);
> -		if (ret !=3D -EPROBE_DEFER)
> -			dev_err(&pdev->dev, "Can't get APB clk: %d\n", ret);
> -		return ret;
> +		return dev_err_probe(&pdev->dev, ret, "Can't get APB clk\n");
>  	}

This could be further simplified (as pointed out in the (implicit) v1)
to:

	if (IS_ERR(pc->pclk))
		return dev_err_probe(&pdev->dev, PTR_ERR(pc->pclk), "Can't get APB clk\n"=
);

but I wouldn't insist on that one as it's somewhat subjective if you
like it better on two lines.

> =20
>  	ret =3D clk_prepare_enable(pc->clk);
> -	if (ret) {
> -		dev_err(&pdev->dev, "Can't prepare enable PWM clk: %d\n", ret);
> -		return ret;
> -	}
> +	if (ret)
> +		dev_err_probe(&pdev->dev, ret, "Can't prepare enable PWM clk\n");
> =20
>  	ret =3D clk_prepare_enable(pc->pclk);
>  	if (ret) {

The context here continues with:

 		dev_err(&pdev->dev, "Can't prepare enable APB clk: %d\n", ret);

this could benefit from dev_err_probe(), too.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ylelyo52mqncwfjb
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmL+BbgACgkQwfwUeK3K
7AnXdwf/SCKYwxVa9X/EZUJNYZ4JoZxEd2KIaLTp4u56HOd8yRi93jqzyfpW/D8p
AwpxXtYWaOpjqkD91McFcMU38v+TrauCMk3Jwh6kVrdNJgYUizgficNC7dvdIGib
T/xiQk8jT4183khhOnDYCuExvpkCsjpET4UVIKGH/5RyaCnIVz78hETzjO+JdRd+
+qTJZ0FCLkNSqdiER2bTJzBQggZYHmgaeXMXfXwrEOHXLvgC3UZFoT3/uLGtbYfg
zQYmoZvs4viRjs03i6TQo6xHLNJ/4En8CJeqd6g7jgv21TcUna47xb4+WjCbAmZz
vuocyj4JmgbRB+SRhIMClmvZP8x1kg==
=gOtP
-----END PGP SIGNATURE-----

--ylelyo52mqncwfjb--
