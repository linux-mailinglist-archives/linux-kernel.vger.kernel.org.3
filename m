Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68A944E92DF
	for <lists+linux-kernel@lfdr.de>; Mon, 28 Mar 2022 12:57:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240411AbiC1K7B (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 28 Mar 2022 06:59:01 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59658 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240386AbiC1K67 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 28 Mar 2022 06:58:59 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DC5BF54FAD
        for <linux-kernel@vger.kernel.org>; Mon, 28 Mar 2022 03:57:18 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nYn3Z-0007p7-Ak; Mon, 28 Mar 2022 12:57:05 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nYn3S-003ZJS-Pa; Mon, 28 Mar 2022 12:57:01 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nYn3U-00CLH0-MM; Mon, 28 Mar 2022 12:57:00 +0200
Date:   Mon, 28 Mar 2022 12:56:59 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, krzk@kernel.org, linus.walleij@linaro.org,
        masneyb@onstation.org, sean.anderson@seco.com,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        ~postmarketos/upstreaming@lists.sr.ht, kernel@pengutronix.de
Subject: Re: [PATCH v6 2/2] pwm: Add clock based PWM output driver
Message-ID: <20220328105659.mg3pxbqynlufaq6z@pengutronix.de>
References: <20220220115030.23772-1-nikita@trvn.ru>
 <20220220115030.23772-3-nikita@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="zpe7c3j5delfyhju"
Content-Disposition: inline
In-Reply-To: <20220220115030.23772-3-nikita@trvn.ru>
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


--zpe7c3j5delfyhju
Content-Type: text/plain; charset=us-ascii
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

just a few minor things left to criticize, see below.

On Sun, Feb 20, 2022 at 04:50:30PM +0500, Nikita Travkin wrote:
> Some systems have clocks exposed to external devices. If the clock
> controller supports duty-cycle configuration, such clocks can be used as
> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
> similar way and an "opposite" driver already exists (clk-pwm). Add a
> driver that would enable pwm devices to be used via clk subsystem.
>=20
> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> --
>=20
> Changes in v2:
>  - Address Uwe's review comments:
>    - Round set clk rate up
>    - Add a description with limitations of the driver
>    - Disable and unprepare clock before removing pwmchip
> Changes in v3:
>  - Use 64bit version of div round up
>  - Address Uwe's review comments:
>    - Reword the limitations to avoid incorrect claims
>    - Move the clk_enabled flag assignment
>    - Drop unnecessary statements
> Changes in v5:
>  - add missed returns
> Changes in v6:
>  - Unprepare the clock on error
>  - Drop redundant limitations points
> ---
>  drivers/pwm/Kconfig   |  10 +++
>  drivers/pwm/Makefile  |   1 +
>  drivers/pwm/pwm-clk.c | 139 ++++++++++++++++++++++++++++++++++++++++++
>  3 files changed, 150 insertions(+)
>  create mode 100644 drivers/pwm/pwm-clk.c
>=20
> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> index 21e3b05a5153..daa2491a4054 100644
> --- a/drivers/pwm/Kconfig
> +++ b/drivers/pwm/Kconfig
> @@ -140,6 +140,16 @@ config PWM_BRCMSTB
>  	  To compile this driver as a module, choose M Here: the module
>  	  will be called pwm-brcmstb.c.
> =20
> +config PWM_CLK
> +	tristate "Clock based PWM support"
> +	depends on HAVE_CLK || COMPILE_TEST

Can you really compile this driver if HAVE_CLK isn't available?

> +	help
> +	  Generic PWM framework driver for outputs that can be
> +	  muxed to clocks.
> +
> +	  To compile this driver as a module, choose M here: the module
> +	  will be called pwm-clk.
> +
>  config PWM_CLPS711X
>  	tristate "CLPS711X PWM support"
>  	depends on ARCH_CLPS711X || COMPILE_TEST
> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> index 708840b7fba8..4a860103c470 100644
> --- a/drivers/pwm/Makefile
> +++ b/drivers/pwm/Makefile
> @@ -10,6 +10,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
>  obj-$(CONFIG_PWM_BERLIN)	+=3D pwm-berlin.o
>  obj-$(CONFIG_PWM_BRCMSTB)	+=3D pwm-brcmstb.o
> +obj-$(CONFIG_PWM_CLK)		+=3D pwm-clk.o
>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
>  obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
>  obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
> new file mode 100644
> index 000000000000..52c9923368cb
> --- /dev/null
> +++ b/drivers/pwm/pwm-clk.c
> @@ -0,0 +1,139 @@
> +// SPDX-License-Identifier: GPL-2.0
> +/*
> + * Clock based PWM controller
> + *
> + * Copyright (c) 2021 Nikita Travkin <nikita@trvn.ru>
> + *
> + * This is an "adapter" driver that allows PWM consumers to use
> + * system clocks with duty cycle control as PWM outputs.
> + *
> + * Limitations:
> + * - Due to the fact that exact behavior depends on the underlying
> + *   clock driver, various limitations are possible.
> + * - Underlying clock may not be able to give 0% or 100% duty cycle
> + *   (constant off or on), exact behavior will depend on the clock.
> + * - When the PWM is disabled, the clock will be disabled as well,
> + *   line state will depend on the clock.

 - The clk API doesn't expose the necessary calls to implement
   .get_state().

> + */
> +
> +#include <linux/kernel.h>
> +#include <linux/math64.h>
> +#include <linux/err.h>
> +#include <linux/module.h>
> +#include <linux/of.h>
> +#include <linux/platform_device.h>
> +#include <linux/clk.h>
> +#include <linux/pwm.h>
> +
> +struct pwm_clk_chip {
> +	struct pwm_chip chip;
> +	struct clk *clk;
> +	bool clk_enabled;
> +};
> +
> +#define to_pwm_clk_chip(_chip) container_of(_chip, struct pwm_clk_chip, =
chip)
> +
> +static int pwm_clk_apply(struct pwm_chip *pwm_chip, struct pwm_device *p=
wm,
> +			 const struct pwm_state *state)
> +{
> +	struct pwm_clk_chip *chip =3D to_pwm_clk_chip(pwm_chip);

I'd prefer this was not called chip, as this is how struct pwm_chip
variables are called usually. My suggestion is:

	chip -> pcchip
	pwm_chip -> chip

Best regards
Uwe

--zpe7c3j5delfyhju
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJBlHgACgkQwfwUeK3K
7AnV+wf/W/+AhU1gkXLv2Q0K4DimCQX+pTB0fUdT5XL0akpyUJXbjlJtaoOfHkXJ
iL5XCi4n54Om8cdfi9nRWKSt6HqbUXvjw4oEfHAKhF8TBC1NC3ltmcBxsnFgkeE9
gmnvsYEQTan8OTsx9Cp6rqe6/YFoTaf1Qt25amwlTGTUYNslNtkF6dNNNegjmhUW
7/uabQTTcwFIby2S7S+s7odPwp7VSmW7gHwNVFTVPKm5Cnkc1h9SGyvI1NJC0QMf
Y3986avTkBvJBuudVKvDZcQuC66DhWcEvfxWvEdCgBEOFElY32cUoaofAnyrDwBz
nSNOPCxKkzJwqWlcIr0sZsoAwbEYKQ==
=KQ6n
-----END PGP SIGNATURE-----

--zpe7c3j5delfyhju--
