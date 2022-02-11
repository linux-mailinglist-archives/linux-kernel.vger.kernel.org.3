Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E9E74B2E27
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Feb 2022 21:06:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242126AbiBKUEL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Feb 2022 15:04:11 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48758 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230391AbiBKUEK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Feb 2022 15:04:10 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8CDD2CE5;
        Fri, 11 Feb 2022 12:04:08 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 22CF41F47303
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1644609847;
        bh=Lhlo5FXvEuuu9+EoZdyyuUPUSsCVcqSG3ADgLywoNP4=;
        h=Date:From:To:Cc:Subject:References:In-Reply-To:From;
        b=k1+2lSQK+NA1OpHB//GQxUR/M8hwjby7c4CMsvK1Vr1jqe8uw5Ses8LLW0nwqfC1a
         daOqTa+QQw2DpkkiYKTJaG7ykCCylSiYrrn218fszvKCFWCgVOAeQ+AKBUplnGaGaF
         n8DJsIWBjSr3v32WTfnFNJLIcw4pIS0Ey/4ELVv6u27qa7Sg16VICk37bzReS+ZQXr
         FtcrWp7Dp09NCi7R3wjMD9H59dG1y0CYlqwUDeEFVCJ60kQmcVJT8oxuFUKIYZCMxM
         geWPX0EwlfgNunfpUfN+zigxy6V7JA92fnKjpLtLPYekDoMwUEV7tAw92sGc8ec6bO
         fnQNbcWnmBkrA==
Received: by mercury (Postfix, from userid 1000)
        id 5AF351060908; Fri, 11 Feb 2022 21:04:04 +0100 (CET)
Date:   Fri, 11 Feb 2022 21:04:04 +0100
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Miaoqian Lin <linmq006@gmail.com>
Cc:     linux-pm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Linus Walleij <linus.walleij@linaro.org>
Subject: Re: [PATCH] power: supply: ab8500: Fix memory leak in
 ab8500_fg_sysfs_init
Message-ID: <20220211200404.ywlfdj2pybtnmezp@mercury.elektranox.org>
References: <20220124131346.12571-1-linmq006@gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="bqtyul25znt7zyce"
Content-Disposition: inline
In-Reply-To: <20220124131346.12571-1-linmq006@gmail.com>
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--bqtyul25znt7zyce
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

[+cc Linus Walleij]

Hi,

On Mon, Jan 24, 2022 at 01:13:46PM +0000, Miaoqian Lin wrote:
> kobject_init_and_add() takes reference even when it fails.
> According to the doc of kobject_init_and_add()=EF=BC=9A
>=20
>    If this function returns an error, kobject_put() must be called to
>    properly clean up the memory associated with the object.
>=20
> Fix memory leak by calling kobject_put().
>=20
> Fixes: 8c0984e5a753 ("power: move power supply drivers to power/supply")
> Signed-off-by: Miaoqian Lin <linmq006@gmail.com>
> ---

Thanks, queued power-supply's for-next branch.

Linus, if I'm not mistaken the custom sysfs ABI (i.e. everything related
to ab8500_fg_sysfs_init() can just be removed since the same thing is
already exposed standardized via POWER_SUPPLY_PROP_CHARGE_FULL and
POWER_SUPPLY_PROP_CHARGE_NOW?

-- Sebastian

>  drivers/power/supply/ab8500_fg.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/power/supply/ab8500_fg.c b/drivers/power/supply/ab85=
00_fg.c
> index 05fe9724ba50..57799a8079d4 100644
> --- a/drivers/power/supply/ab8500_fg.c
> +++ b/drivers/power/supply/ab8500_fg.c
> @@ -2545,8 +2545,10 @@ static int ab8500_fg_sysfs_init(struct ab8500_fg *=
di)
>  	ret =3D kobject_init_and_add(&di->fg_kobject,
>  		&ab8500_fg_ktype,
>  		NULL, "battery");
> -	if (ret < 0)
> +	if (ret < 0) {
> +		kobject_put(&di->fg_kobject);
>  		dev_err(di->dev, "failed to create sysfs entry\n");
> +	}
> =20
>  	return ret;
>  }
> --=20
> 2.17.1
>=20

--bqtyul25znt7zyce
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQIzBAABCgAdFiEE72YNB0Y/i3JqeVQT2O7X88g7+poFAmIGwSkACgkQ2O7X88g7
+ppLShAAgoQkT+RXXt/mq+KUBF+YKmT3HoOdXD09rPwj1OdjSALvDF4Lg1Gc2gDE
GsbtG5U7TszoZ7IP9VKqFC57BO361Qm2RH/oQe9vKIUbpoIAUM9JuZKdSlKF2K21
8N17zJ9kBGrafwdkNTEWOLymedBQswealg3l1epxxRUY2Q2qv9v820MkCtEUJVPB
9eX4O237rz0/nGKp7VHo0dBWgEilt8NWq6KE8qqIdotW22srMnc+XNO3p/8nRggl
KQ30ZJlEzHr0fLGuilBIlwea1NaBNydxOqoxtD7BIWyMFXICRlVHll+X4Qi/cJyZ
FgW3qOmPMSNPvSBVgJHu920Q1xDEq3wHDcCIsnGae8v3sTWmZRrsPGVeExiGLaCR
b9wE58gLR8FPoyQI8Gl67lMu1S2DhJnd27l2CeZCt5Mi9fokZ/9H0FCaMnqEQFLW
Y/ED8rjVOw0At4vKwSmJKIw3K+xbM7HpYtaPvU7Bm3BzD8/Jb35Rh45FfUEkX0wU
WyosCfbOtVB5gd0nyNB853chzWKN5epIdZaT19zDxE3DLid/S1qK7k8kVQKMoFg6
lcg2Oep/wOvs14oXQ4vDKzN/F+qqA26uIRfA6zeNO/dOIwTvZO28JkwHFsj1vO9g
6HxITI69P9yWJ65Ih2TcjnOazkb1lcgHL6v6rliPPxIpMARzn84=
=z8nJ
-----END PGP SIGNATURE-----

--bqtyul25znt7zyce--
