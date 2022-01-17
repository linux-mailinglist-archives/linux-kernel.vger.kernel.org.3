Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5B89F4910D9
	for <lists+linux-kernel@lfdr.de>; Mon, 17 Jan 2022 21:05:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243069AbiAQUFP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 17 Jan 2022 15:05:15 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59144 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242976AbiAQUFO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 17 Jan 2022 15:05:14 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 33E2AC06173E
        for <linux-kernel@vger.kernel.org>; Mon, 17 Jan 2022 12:05:14 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9YFT-0001Jt-03; Mon, 17 Jan 2022 21:05:03 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9YFP-00AsTd-45; Mon, 17 Jan 2022 21:04:58 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1n9YFN-0003Uv-PR; Mon, 17 Jan 2022 21:04:57 +0100
Date:   Mon, 17 Jan 2022 21:04:54 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Nikita Travkin <nikita@trvn.ru>
Cc:     thierry.reding@gmail.com, lee.jones@linaro.org, robh+dt@kernel.org,
        sboyd@kernel.org, linus.walleij@linaro.org, masneyb@onstation.org,
        linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht
Subject: Re: [PATCH v2 2/2] pwm: Add clock based PWM output driver
Message-ID: <20220117200454.ksd65ljmrje63sqg@pengutronix.de>
References: <20211213150335.51888-1-nikita@trvn.ru>
 <20211213150335.51888-3-nikita@trvn.ru>
 <20220117155817.4bu2zwpjijtwlfvi@pengutronix.de>
 <b3add53c417506044a8e13c4bbf84ced@trvn.ru>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="w2isnweh5r7hwpux"
Content-Disposition: inline
In-Reply-To: <b3add53c417506044a8e13c4bbf84ced@trvn.ru>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--w2isnweh5r7hwpux
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Jan 17, 2022 at 11:04:31PM +0500, Nikita Travkin wrote:
> Hi,
>=20
> Uwe Kleine-K=C3=B6nig =D0=BF=D0=B8=D1=81=D0=B0=D0=BB(=D0=B0) 17.01.2022 2=
0:58:
> > Hello,
> >=20
> > On Mon, Dec 13, 2021 at 08:03:35PM +0500, Nikita Travkin wrote:
> >> Some systems have clocks exposed to external devices. If the clock
> >> controller supports duty-cycle configuration, such clocks can be used =
as
> >> pwm outputs. In fact PWM and CLK subsystems are interfaced with in a
> >> similar way and an "opposite" driver already exists (clk-pwm). Add a
> >> driver that would enable pwm devices to be used via clk subsystem.
> >>
> >> Signed-off-by: Nikita Travkin <nikita@trvn.ru>
> >> --
> >>
> >> Changes in v2:
> >>  - Address Uwe's review comments:
> >>    - Round set clk rate up
> >>    - Add a description with limitations of the driver
> >>    - Disable and unprepare clock before removing pwmchip
> >> ---
> >>  drivers/pwm/Kconfig   |  10 +++
> >>  drivers/pwm/Makefile  |   1 +
> >>  drivers/pwm/pwm-clk.c | 143 ++++++++++++++++++++++++++++++++++++++++++
> >>  3 files changed, 154 insertions(+)
> >>  create mode 100644 drivers/pwm/pwm-clk.c
> >>
> >> diff --git a/drivers/pwm/Kconfig b/drivers/pwm/Kconfig
> >> index 21e3b05a5153..daa2491a4054 100644
> >> --- a/drivers/pwm/Kconfig
> >> +++ b/drivers/pwm/Kconfig
> >> @@ -140,6 +140,16 @@ config PWM_BRCMSTB
> >>  	  To compile this driver as a module, choose M Here: the module
> >>  	  will be called pwm-brcmstb.c.
> >>
> >> +config PWM_CLK
> >> +	tristate "Clock based PWM support"
> >> +	depends on HAVE_CLK || COMPILE_TEST
> >> +	help
> >> +	  Generic PWM framework driver for outputs that can be
> >> +	  muxed to clocks.
> >> +
> >> +	  To compile this driver as a module, choose M here: the module
> >> +	  will be called pwm-clk.
> >> +
> >>  config PWM_CLPS711X
> >>  	tristate "CLPS711X PWM support"
> >>  	depends on ARCH_CLPS711X || COMPILE_TEST
> >> diff --git a/drivers/pwm/Makefile b/drivers/pwm/Makefile
> >> index 708840b7fba8..4a860103c470 100644
> >> --- a/drivers/pwm/Makefile
> >> +++ b/drivers/pwm/Makefile
> >> @@ -10,6 +10,7 @@ obj-$(CONFIG_PWM_BCM_KONA)	+=3D pwm-bcm-kona.o
> >>  obj-$(CONFIG_PWM_BCM2835)	+=3D pwm-bcm2835.o
> >>  obj-$(CONFIG_PWM_BERLIN)	+=3D pwm-berlin.o
> >>  obj-$(CONFIG_PWM_BRCMSTB)	+=3D pwm-brcmstb.o
> >> +obj-$(CONFIG_PWM_CLK)		+=3D pwm-clk.o
> >>  obj-$(CONFIG_PWM_CLPS711X)	+=3D pwm-clps711x.o
> >>  obj-$(CONFIG_PWM_CRC)		+=3D pwm-crc.o
> >>  obj-$(CONFIG_PWM_CROS_EC)	+=3D pwm-cros-ec.o
> >> diff --git a/drivers/pwm/pwm-clk.c b/drivers/pwm/pwm-clk.c
> >> new file mode 100644
> >> index 000000000000..55fd320b9c19
> >> --- /dev/null
> >> +++ b/drivers/pwm/pwm-clk.c
> >> @@ -0,0 +1,143 @@
> >> +// SPDX-License-Identifier: GPL-2.0
> >> +/*
> >> + * Clock based PWM controller
> >> + *
> >> + * Copyright (c) 2021 Nikita Travkin <nikita@trvn.ru>
> >> + *
> >> + * This is an "adapter" driver that allows PWM consumers to use
> >> + * system clocks with duty cycle control as PWM outputs.
> >> + *
> >> + * Limitations:
> >> + * - There is no way to atomically set both clock rate and
> >> + *   duty-cycle so glitches are possible when new pwm state
> >> + *   is applied.
> >> + * - Period depends on the underlying clock driver and,
> >> + *   in general, not guaranteed.
> >> + * - Underlying clock may not be able to give 100%
> >> + *   duty cycle (constant on) and only set the closest
> >> + *   possible duty cycle. (e.g. 99.9%)
> >=20
> > What about 0%?
>=20
> You're right, this is also a problematic case that I should've
> mentioned here. In fact I *did* have problems with zero written
> into the duty cycle register of my clock. I decided that it
> should be solved by the hardware driver so I sent a patch
> with a zero check there. (As otherwise there might be a clock
> that would properly support 0% and 100% cycles so making the
> write like this impossible is not a job of this driver I think)
>=20
> >=20
> >  - Periods are not completed on changes in general.
>=20
> I suppose I should reword the limitation, dropping
> the reference to impossible atomic operations and
> just state that glitches are inevitable.
>=20
> >  - Behaviour on disable depends on the underlaying clk, don't assume it
> >    to provide the inactive level.
> >=20
>=20
> Hm, now thinking of it, I'm not sure if the clock line
> was set to logic 0 or was left floating (which is what I assume
> you mean by the undefined behavior here) on the clock I was
> debugging this on with an oscilloscope. (nor am I sure
> if I even can make such a conclusion by looking at that...)
>=20
> Do you think that this should be just documented in the
> limitations? Like:
>=20
>   - Underlying clock may not be able to give 0% or 100%
>     duty cycle (constant off or on) and only set the
>     closest possible duty cycle. (e.g. 0.1% or 99.9%)

I would not bet on this. Maybe in such a case clk_set_duty_cycle might
also fail. The clk API isn't (TTBOMK) well-defined enough to make
promises like that.

>   - When the PWM is disabled, the clock will be disabled
>     as well. User should take care of properly pulling=20
>     the line down in case the disabled clock leaves it
>     floating.

This isn't universally true. I'd expect that just freezing (i.e. driving
either high or low depending on the state when the clk was stopped) is a
very usual behaviour. So a pull isn't always a good idea.

I would just keep that unspecified.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=C3=B6nig         =
   |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--w2isnweh5r7hwpux
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHly+MACgkQwfwUeK3K
7Akgigf/af6bEdagOkor/9KNqYkDZBuK3/FgGZihYr2i+hPcBAYXIKUdSbD8yR6t
MX+1RjcwAqzX2DcxtbPwMfeCGMAYefd+58tY2zUp6JvpT14HfH0YziiI78Evp4CG
SGBb1AmvjZY8ZW4yvj68UycOI4S5gnjZcHYdU6+/9C+igpSOv0AhWqPdQiHflCU1
yvoZy3KSo0S3Q6h+Hgan67ZX/JSL1M8SGHUvZ8AJfSsfwSFdBRiuahVX2BFosB1L
MdCPtyXGa7WZoAOz3e6Mwmk/zpBNMvzFz7c87Jr9dRRiy/8mfzxclAj5Fldfer8K
R59DfxwBnYvCt1fJPlk6JdQO0JXdPg==
=L6NG
-----END PGP SIGNATURE-----

--w2isnweh5r7hwpux--
