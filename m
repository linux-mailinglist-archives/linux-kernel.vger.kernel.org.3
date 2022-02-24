Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250E34C3312
	for <lists+linux-kernel@lfdr.de>; Thu, 24 Feb 2022 18:04:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231986AbiBXREC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 24 Feb 2022 12:04:02 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53018 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232403AbiBXRDK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 24 Feb 2022 12:03:10 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 657341CBAB7
        for <linux-kernel@vger.kernel.org>; Thu, 24 Feb 2022 09:00:15 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nNHSx-0002ML-Er; Thu, 24 Feb 2022 17:59:43 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nNHSv-00139d-Ma; Thu, 24 Feb 2022 17:59:40 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nNHSt-005Go7-SU; Thu, 24 Feb 2022 17:59:39 +0100
Date:   Thu, 24 Feb 2022 17:59:39 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Bjorn Andersson <bjorn.andersson@linaro.org>
Cc:     Pavel Machek <pavel@ucw.cz>,
        Thierry Reding <thierry.reding@gmail.com>,
        Lee Jones <lee.jones@linaro.org>,
        Rob Herring <robh+dt@kernel.org>,
        Jonathan Corbet <corbet@lwn.net>, linux-leds@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org,
        linux-doc@vger.kernel.org, linux-pwm@vger.kernel.org,
        linux-arm-msm@vger.kernel.org, Luca Weiss <luca@z3ntu.xyz>,
        Doug Anderson <dianders@chromium.org>
Subject: Re: [PATCH v13 2/2] leds: Add driver for Qualcomm LPG
Message-ID: <20220224165939.4275x7mzp7qpl2kj@pengutronix.de>
References: <20220218183116.2261770-1-bjorn.andersson@linaro.org>
 <20220218183116.2261770-2-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vypeaeqkhphwiwzw"
Content-Disposition: inline
In-Reply-To: <20220218183116.2261770-2-bjorn.andersson@linaro.org>
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


--vypeaeqkhphwiwzw
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Fri, Feb 18, 2022 at 10:31:16AM -0800, Bjorn Andersson wrote:
> The Light Pulse Generator (LPG) is a PWM-block found in a wide range of
> PMICs from Qualcomm. These PMICs typically comes with 1-8 LPG instances,
> with their output being routed to various other components, such as
> current sinks or GPIOs.
>=20
> Each LPG instance can operate on fixed parameters or based on a shared
> lookup-table, altering the duty cycle over time. This provides the means
> for hardware assisted transitions of LED brightness.
>=20
> A typical use case for the fixed parameter mode is to drive a PWM
> backlight control signal, the driver therefor allows each LPG instance
> to be exposed to the kernel either through the LED framework or the PWM
> framework.
>=20
> A typical use case for the LED configuration is to drive RGB LEDs in
> smartphones etc, for which the driver supports multiple channels to be
> ganged up to a MULTICOLOR LED. In this configuration the pattern
> generators will be synchronized, to allow for multi-color patterns.
>=20
> The idea of modelling this as a LED driver ontop of a PWM driver was
> considered, but setting the properties related to patterns does not fit
> in the PWM API. Similarly the idea of just duplicating the lower bits in
> a PWM and LED driver separately was considered, but this would not allow
> the PWM channels and LEDs to be configured on a per-board basis. The
> driver implements the more complex LED interface, and provides a PWM
> interface on the side of that, in the same driver.
>=20
> Tested-by: Luca Weiss <luca@z3ntu.xyz>
> Tested-by: Doug Anderson <dianders@chromium.org>
> Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
> ---
> Changes since v12:
> - Initialize ret in lpg_pwm_apply()
>=20
> Changes since v11:
> - Extended commit message to cover decision to put pwm_chip in the LED dr=
iver
> - Added Documentation, in particular for the hw_pattern format
> - Added a lock to synchronize requests from LED and PWM frameworks
> - Turned out that the 9bit selector differs per channel in some PMICs, so
>   replaced bitmask in lpg_data with lookup based on QPNP SUBTYPE
> - Fixed kerneldoc for the struct device pointer in struct lpg
> - Rewrote conditional in lut_free() to make it easier to read
> - Corrected and deduplicated max_period expression in lpg_calc_freq()
> - Extended nom/dom to numerator/denominator in lpg_calc_freq()
> - Replaced 1 << 9 with LPG_RESOLUTION in one more place in lpg_calc_freq()
> - Use FIELD_PREP() in lpg_apply_freq() as masks was introduced for readin=
g the
>   same in get_state()
> - Cleaned up the pattern format, to allow specifying both low and high pa=
use
>   with and without pingpong mode.
> - Only update frequency and pwm_value if PWM channel is enabled in lpg_pw=
m_apply
> - Make lpg_pwm_get_state() read the hardware state, in order to pick up e=
=2Eg.
>   bootloader backlight configuration
> - Use devm_bitmap_zalloc() to allocate the lut_bitmap
> - Use dev_err_probe() in lpg_probe()
> - Extended Kconfig help text to mention module name and satisfy checkpatch
>=20
>  Documentation/leds/leds-qcom-lpg.rst |   76 ++
>  drivers/leds/Kconfig                 |    3 +
>  drivers/leds/Makefile                |    3 +
>  drivers/leds/rgb/Kconfig             |   18 +
>  drivers/leds/rgb/Makefile            |    3 +
>  drivers/leds/rgb/leds-qcom-lpg.c     | 1401 ++++++++++++++++++++++++++
>  6 files changed, 1504 insertions(+)
>  create mode 100644 Documentation/leds/leds-qcom-lpg.rst
>  create mode 100644 drivers/leds/rgb/Kconfig
>  create mode 100644 drivers/leds/rgb/Makefile
>  create mode 100644 drivers/leds/rgb/leds-qcom-lpg.c
>=20
> diff --git a/Documentation/leds/leds-qcom-lpg.rst b/Documentation/leds/le=
ds-qcom-lpg.rst
> new file mode 100644
> index 000000000000..d4825a289888
> --- /dev/null
> +++ b/Documentation/leds/leds-qcom-lpg.rst
> @@ -0,0 +1,76 @@
> +.. SPDX-License-Identifier: GPL-2.0
> +
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +Kernel driver for Qualcomm LPG
> +=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=3D=
=3D=3D=3D=3D=3D=3D
> +
> +Description
> +-----------
> +
> +The Qualcomm LPG can be found in a variety of Qualcomm PMICs and consist=
s of a
> +number of PWM channels, a programmable pattern lookup table and a RGB LED
> +current sink.
> +
> +To facilitate the various use cases, the LPG channels can be exposed as
> +individual LEDs, grouped together as RGB LEDs or otherwise be accessed a=
s PWM
> +channels. The output of each PWM channel is routed to other hardware
> +blocks, such as the RGB current sink, GPIO pins etc.
> +
> +The each PWM channel can operate with a period between 27us and 384 seco=
nds and
> +has a 9 bit resolution of the duty cycle.
> +
> +In order to provide support for status notifications with the CPU subsys=
tem in
> +deeper idle states the LPG provides pattern support. This consists of a =
shared
> +lookup table of brightness values and per channel properties to select t=
he
> +range within the table to use, the rate and if the pattern should repeat.
> +
> +The pattern for a channel can be programmed using the "pattern" trigger,=
 using
> +the hw_pattern attribute.
> +
> +/sys/class/leds/<led>/hw_pattern
> +--------------------------------
> +
> +Specify a hardware pattern for a Qualcomm LPG LED.
> +
> +The pattern is a series of brightness and hold-time pairs, with the hold=
-time
> +expressed in milliseconds. The hold time is a property of the pattern an=
d must
> +therefor be identical for each element in the pattern (except for the pa=
uses
> +described below).
> +
> +Simple pattern::
> +
> +    "255 500 0 500"
> +
> +        ^
> +        |
> +    255 +----+    +----+
> +	|    |    |    |      ...
> +      0 |    +----+    +----
> +        +---------------------->
> +	0    5   10   15     time (100ms)

you're mixing tabs and spaces here, I suggest to use spaces only. Not
sure you want to respin for that.

(I didn't look into the rest of the driver, but assume it's fine.)

Best regards
Uwe


--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--vypeaeqkhphwiwzw
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIXuXcACgkQwfwUeK3K
7Ams5wf+MyshgmoyVbFd/VtoEJNG+8bLx/KFx6APd8Kl+8oj/EFWOfBDYU9GDKLw
EsQrVAoJ0gQg/K6hMTUAsN/gwhInmrb4aDHy3Ot1GWBNMoTXiADdF84G6X9avKoF
Qii16MnMTN95w6CbsDf41DIwjWv+RgIISVztXKjFBWvuL8EaLeMVgcpEIKw/j7JH
/0BBSbAZmY0039nhyPeVSJhW8IAX0eAhlwN4pTHvbXZ99P5TIFSuOZu9mEROr2FV
1VbQfq1KRCbxCpKwPiLyKKBsmVHve6nSH6EDOycwu+twmgAiJMk8u4wKpysRClFw
eKlrJ+QUoNrzwBxmbDphCRvapeddng==
=X7KB
-----END PGP SIGNATURE-----

--vypeaeqkhphwiwzw--
