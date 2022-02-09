Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E95844AF531
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Feb 2022 16:27:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235785AbiBIP0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Feb 2022 10:26:24 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43364 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235778AbiBIP0R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Feb 2022 10:26:17 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E7ED5C061355
        for <linux-kernel@vger.kernel.org>; Wed,  9 Feb 2022 07:26:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHorH-0002pa-8O; Wed, 09 Feb 2022 16:26:15 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHorF-00FX3B-A2; Wed, 09 Feb 2022 16:26:12 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHorD-00DMQZ-N3; Wed, 09 Feb 2022 16:26:11 +0100
Date:   Wed, 9 Feb 2022 16:26:09 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Qing Wang <wangqing@vivo.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>, linux-pwm@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: use div64_u64() instead of do_div()
Message-ID: <20220209152609.gqeivcehkuzgz3sk@pengutronix.de>
References: <1644395998-4397-1-git-send-email-wangqing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hakboj7n3cnu24o3"
Content-Disposition: inline
In-Reply-To: <1644395998-4397-1-git-send-email-wangqing@vivo.com>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--hakboj7n3cnu24o3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, Feb 09, 2022 at 12:39:58AM -0800, Qing Wang wrote:
> From: Wang Qing <wangqing@vivo.com>
>=20
> do_div() does a 64-by-32 division.
> When the divisor is u64, do_div() truncates it to 32 bits, this means it
> can test non-zero and be truncated to zero for division.
>=20
> fix do_div.cocci warning:
> do_div() does a 64-by-32 division, please consider using div64_u64 instea=
d.
>=20
> Signed-off-by: Wang Qing <wangqing@vivo.com>
> ---
>  drivers/pwm/pwm-berlin.c | 2 +-
>  1 file changed, 1 insertion(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-berlin.c b/drivers/pwm/pwm-berlin.c
> index e157273..15b10cb3
> --- a/drivers/pwm/pwm-berlin.c
> +++ b/drivers/pwm/pwm-berlin.c
> @@ -109,7 +109,7 @@ static int berlin_pwm_config(struct pwm_chip *chip, s=
truct pwm_device *pwm,
> =20
>  	period =3D cycles;
>  	cycles *=3D duty_ns;
> -	do_div(cycles, period_ns);
> +	div64_u64(cycles, period_ns);

This is wrong, div64_u64() has a different calling convention than do_div().

The issue however is real. Please add=20

Fixes: 30dffb42fcd4 ("pwm: berlin: Implement .apply() callback")

to your v2.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hakboj7n3cnu24o3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmID3Q4ACgkQwfwUeK3K
7AllnAf+O+1frxj5epv4nRAEt/Fq5cqM1lXqY1SLK9WFn7QzGqaDSdxFZX8HQJJB
1Ab3fUkZ3DCm9Wy4gEz7Hf5k43iiv+ZG5MvPKQgsoB2R40ru6RcOxftrdh2vYh5U
yhG8sklLkgM0U1Q2X65IMPXi8Vz4tB6FRK2pR+vrPl/Ae+loTkU337pN7ccCk5ur
IuIzZ4lkynjhX/1eU/ORevpZSvSp3HxyqBxFPx9oRSJ2J30gl2ElEWNYgnh+E8Vq
92RITLFwDGoZ1VYiZaGgFxI6vLSjGt1WxyCCMZv1vn+e4c4fw94328Vc2K/kzY5E
+S+u966W1vF4Z4ZTnt97oQUFJ01wPQ==
=Wd2L
-----END PGP SIGNATURE-----

--hakboj7n3cnu24o3--
