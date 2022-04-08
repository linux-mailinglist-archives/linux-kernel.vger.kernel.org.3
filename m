Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97D634F928D
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Apr 2022 12:08:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229871AbiDHKKG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Apr 2022 06:10:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48916 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229565AbiDHKJ5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Apr 2022 06:09:57 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1B32235DEC
        for <linux-kernel@vger.kernel.org>; Fri,  8 Apr 2022 03:07:52 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nclWo-0001D7-OD; Fri, 08 Apr 2022 12:07:42 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nclWo-001mY5-FE; Fri, 08 Apr 2022 12:07:41 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nclWl-001wSJ-UN; Fri, 08 Apr 2022 12:07:39 +0200
Date:   Fri, 8 Apr 2022 12:07:21 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Wan Jiabing <wanjiabing@vivo.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Palmer Dabbelt <palmer@dabbelt.com>,
        Paul Walmsley <paul.walmsley@sifive.com>,
        linux-pwm@vger.kernel.org, linux-riscv@lists.infradead.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] pwm: sifive: simplify if-if to if-else
Message-ID: <20220408100721.rinvvgard3nr5wff@pengutronix.de>
References: <20220408083007.41538-1-wanjiabing@vivo.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5hmg2yezfbimyu7f"
Content-Disposition: inline
In-Reply-To: <20220408083007.41538-1-wanjiabing@vivo.com>
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


--5hmg2yezfbimyu7f
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Apr 08, 2022 at 04:30:07PM +0800, Wan Jiabing wrote:
> use if and else instead of if(A) and if (!A).
>=20
> Signed-off-by: Wan Jiabing <wanjiabing@vivo.com>
> ---
>  drivers/pwm/pwm-sifive.c | 5 ++---
>  1 file changed, 2 insertions(+), 3 deletions(-)
>=20
> diff --git a/drivers/pwm/pwm-sifive.c b/drivers/pwm/pwm-sifive.c
> index 253c4a17d255..e6d05a329002 100644
> --- a/drivers/pwm/pwm-sifive.c
> +++ b/drivers/pwm/pwm-sifive.c
> @@ -138,10 +138,9 @@ static int pwm_sifive_enable(struct pwm_chip *chip, =
bool enable)
>  			dev_err(ddata->chip.dev, "Enable clk failed\n");
>  			return ret;
>  		}
> -	}
> -
> -	if (!enable)
> +	} else {
>  		clk_disable(ddata->clk);
> +	}
> =20
>  	return 0;
>  }

The patch looks fine. I wonder if it would be sensible to clean up even
more: pwm_sifive_apply() is only a single caller of
pwm_sifive_enable(). If this is optimized to skip the duty_cycle and
period calculation for the state->enabled =3D false case and just disables
the clock this should still work.

Also I wonder if there is a clk mismatch issue in this driver: .probe
enables the clk and if the PWM is off (i.e. .get_state diagnoses that)
the clock will never be disabled while the driver is bound, will it?

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--5hmg2yezfbimyu7f
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJQCVcACgkQwfwUeK3K
7Al38Af7BAOq90kL/kjCqKlWjXccUKG6Dj3BDwGcg5UfGg/JRiJmYayalIAR2LIn
mKa9mxv/NmCLa9jl5uPCJ5WqvJnmYcdz4rL11wXGwlEY93YYn56FOG0U7MBo1ij9
NUdVK8np9+RnN2HYy3YWeiIwGnHFu4xoU9Iv1ahdfPGw+UAPiH2VSYCUkQguXjZ5
0Lf49mFIHiOBjyiWCHO2pV1k7JWAXLlbPbSthFLufhdQORrYkfqb6K+o8/LfgPtL
VswPzS7Hd/LNUzP3pHKF1tig1XNRMaTq1E+vkG4x680WLeVgCzWxeIjqeB+wZFar
8g21tTWYs3nI8bfyBzbE27vAwKI58w==
=xpSm
-----END PGP SIGNATURE-----

--5hmg2yezfbimyu7f--
