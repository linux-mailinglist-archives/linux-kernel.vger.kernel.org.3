Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D892D58BAA6
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 13:23:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233206AbiHGLXm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 07:23:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52206 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231282AbiHGLXk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 07:23:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D6662B7FC
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 04:23:39 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKeNa-0006Yh-P9; Sun, 07 Aug 2022 13:23:34 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKeNX-002HmP-7G; Sun, 07 Aug 2022 13:23:33 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKeNY-00A8KA-O6; Sun, 07 Aug 2022 13:23:32 +0200
Date:   Sun, 7 Aug 2022 13:23:32 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 4/4] pwm: sysfs: Utilize an array for polarity strings
Message-ID: <20220807112332.ku5c447ou22f364w@pengutronix.de>
References: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
 <20220806212331.40086-4-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ufc46rnrxz5yzjdy"
Content-Disposition: inline
In-Reply-To: <20220806212331.40086-4-andriy.shevchenko@linux.intel.com>
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


--ufc46rnrxz5yzjdy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Sun, Aug 07, 2022 at 12:23:31AM +0300, Andy Shevchenko wrote:
> Code is smaller and looks nicer if we combine polarity strings into an ar=
ray.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/sysfs.c | 32 ++++++++++++--------------------
>  1 file changed, 12 insertions(+), 20 deletions(-)
>=20
> diff --git a/drivers/pwm/sysfs.c b/drivers/pwm/sysfs.c
> index 767c4b19afb1..1bbc5286b7c6 100644
> --- a/drivers/pwm/sysfs.c
> +++ b/drivers/pwm/sysfs.c
> @@ -151,27 +151,23 @@ static ssize_t enable_store(struct device *child,
>  	return ret ? : size;
>  }
> =20
> +static const char * const polarity_strings[] =3D {

I like having function and variable prefixes, so I'd prefer this to be
called pwm_polarity_strings[]. (Side note: The device show and store
callbacks obviously don't have a prefix either because DEVICE_ATTR_RW et
al force the functions to be called "${name}_show" and "${name}_store".
I considered already a few times to introduce something like

	#define __ATTR_NS_RW_MODE(_name, _ns,_mode) {                           \
		.attr   =3D { .name =3D __stringify(_name),                         \
			    .mode =3D VERIFY_OCTAL_PERMISSIONS(_mode) },          \
		.show   =3D _ns ## _ ## _name ## _show,                           \
		.store  =3D _ns ## _ ## _name ## _store,                          \
	}

	#define DEVICE_ATTR_NS_RW(_name, _ns) \
		struct device_attribute _ns ## _dev_attr_ ## _name =3D __ATTR_NS_RW_MODE(=
_name, _ns, 0600)

To allow the functions to have a name space. Never came around to do
that though.)

> +	[PWM_POLARITY_NORMAL]	=3D "normal",
> +	[PWM_POLARITY_INVERSED]	=3D "inversed",

I slightly prefer to not align the =3D in such definitions. Using a single
plain space before =3D is already used in the definiton of pwm_class in
the same file.

Otherwise the patch looks fine.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--ufc46rnrxz5yzjdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLvoLEACgkQwfwUeK3K
7AklEAf/Vo801CPG+QKQ1kvDz9xnKZg0qJyG5ltbIS00e8Sh5YfdvP5/XBOO/zII
Ml0WjMT4hJzWAM3L14R2ngr9JMz2eFR1284c/XMJfZKUKvq5L6gV8lI8n85h+o/9
cC2sts/YfAaG3FdjpDpaUA3x7YUlsl6Ubp13LN72xBm8TENezG9FZcs2NVBdHGYg
qZhickB30W5dVtszev0psOtQcw9m/eadEYWDCLKgDZoxPph6piePc8MriGh3xLDN
NpVyA+8BNvkgJ/vdgENWQF9QD+5KmomnbJqHJYI8ySejiNAdQ3/h9XqbSaqAX3X5
tF5XJWJkPG1SBfRUY6VyZ+Mzo9u1Fg==
=92eN
-----END PGP SIGNATURE-----

--ufc46rnrxz5yzjdy--
