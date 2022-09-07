Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5EF35B000F
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:11:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229574AbiIGJL4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:11:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230129AbiIGJLv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:11:51 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9EFDCA7AAC
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:11:47 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oVr61-00045Q-UT; Wed, 07 Sep 2022 11:11:45 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oVr5z-004PHC-47; Wed, 07 Sep 2022 11:11:45 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oVr60-00GfdK-F4; Wed, 07 Sep 2022 11:11:44 +0200
Date:   Wed, 7 Sep 2022 11:11:44 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 2/9] pwm: lpss: Move exported symbols to PWM_LPSS
 namespace
Message-ID: <20220907091144.picr3byckxco7w6m@pengutronix.de>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
 <20220906195735.87361-2-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="nvqhqttaq7ibtbf3"
Content-Disposition: inline
In-Reply-To: <20220906195735.87361-2-andriy.shevchenko@linux.intel.com>
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


--nvqhqttaq7ibtbf3
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Andy,

On Tue, Sep 06, 2022 at 10:57:28PM +0300, Andy Shevchenko wrote:
> Avoid unnecessary pollution of the global symbol namespace by
> moving library functions in to a specific namespace and import
> that into the drivers that make use of the functions.
>=20
> For more info: https://lwn.net/Articles/760045/
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss-pci.c      | 1 +
>  drivers/pwm/pwm-lpss-platform.c | 1 +
>  drivers/pwm/pwm-lpss.c          | 2 +-
>  3 files changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
> index 75b778e839b3..9f2c666b95ec 100644
> --- a/drivers/pwm/pwm-lpss-pci.c
> +++ b/drivers/pwm/pwm-lpss-pci.c
> @@ -92,3 +92,4 @@ module_pci_driver(pwm_lpss_driver_pci);
> =20
>  MODULE_DESCRIPTION("PWM PCI driver for Intel LPSS");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(PWM_LPSS);
> diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platf=
orm.c
> index fcd80cca2f6d..96fde1b2b967 100644
> --- a/drivers/pwm/pwm-lpss-platform.c
> +++ b/drivers/pwm/pwm-lpss-platform.c
> @@ -87,4 +87,5 @@ module_platform_driver(pwm_lpss_driver_platform);
> =20
>  MODULE_DESCRIPTION("PWM platform driver for Intel LPSS");
>  MODULE_LICENSE("GPL v2");
> +MODULE_IMPORT_NS(PWM_LPSS);
>  MODULE_ALIAS("platform:pwm-lpss");

While it's not wrong to add the IMPORT_NS statement to each file, I'd
had added it to pwm-lpss.h. IMHO that makes sense as every includer of
that header needs that IMPORT_NS to actually use the symbols declared
there.

> diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
> index 36d4e83e6b79..a82a57eb2482 100644
> --- a/drivers/pwm/pwm-lpss.c
> +++ b/drivers/pwm/pwm-lpss.c
> @@ -250,7 +250,7 @@ struct pwm_lpss_chip *pwm_lpss_probe(struct device *d=
ev, struct resource *r,
> =20
>  	return lpwm;
>  }
> -EXPORT_SYMBOL_GPL(pwm_lpss_probe);
> +EXPORT_SYMBOL_NS_GPL(pwm_lpss_probe, PWM_LPSS);

There is something possible with more magic:

	#define DEFAULT_SYMBOL_NAMESPACE PWM_LPSS

which you only need once in pwm-lpss.c and then all exports use that
namespace. (And if you pick up my suggestion for patch 1 you also
benefit from that.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--nvqhqttaq7ibtbf3
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMYYE0ACgkQwfwUeK3K
7An7Twf+PI0WzSgVsZHz33UbHREzlbQ1QGhVUuCSH4nE8mwjD5YRpyu5pj4xYiD1
tQ50KiHtya9hYhKvyw2DUcVpNE9P1XQeOnTnD++KRDePWEV4ptepP9MFoke2kPI5
inW25J5TzT8IcBu3fwouFf4/RqHPrrLitu8Hw55tL3oCwlUsEQPaSTHnUEZRyoxa
MeiRhh8+j9kCK/ybZ8ujCzEssxAw9TEyS4VgVONPtazNhsKsbZB5lYTrPE86PBpw
fgybn6sezvhBJfyURZHCHGZwkg5vVaZj+c42zMe75dbaQDmUOvsBzTMvodpLsvsZ
CWsMKGnoUNIepiizC4HFkfq79HOarg==
=T8db
-----END PGP SIGNATURE-----

--nvqhqttaq7ibtbf3--
