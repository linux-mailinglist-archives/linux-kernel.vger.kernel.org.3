Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B1D485AFFD5
	for <lists+linux-kernel@lfdr.de>; Wed,  7 Sep 2022 11:04:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230255AbiIGJET (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 7 Sep 2022 05:04:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33278 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229996AbiIGJEQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 7 Sep 2022 05:04:16 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E2549AF480
        for <linux-kernel@vger.kernel.org>; Wed,  7 Sep 2022 02:04:15 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oVqyk-0002uB-EQ; Wed, 07 Sep 2022 11:04:14 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oVqyh-004PGT-O8; Wed, 07 Sep 2022 11:04:13 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oVqyi-00GfDc-RP; Wed, 07 Sep 2022 11:04:12 +0200
Date:   Wed, 7 Sep 2022 11:04:12 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-kernel@vger.kernel.org, linux-pwm@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 1/9] pwm: lpss: Deduplicate board info data structures
Message-ID: <20220907090412.kqvbmgfgeb4toz5n@pengutronix.de>
References: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="scqcxlngs5jspysc"
Content-Disposition: inline
In-Reply-To: <20220906195735.87361-1-andriy.shevchenko@linux.intel.com>
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


--scqcxlngs5jspysc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Tue, Sep 06, 2022 at 10:57:27PM +0300, Andy Shevchenko wrote:
> With help of __maybe_unused, that allows to avoid compilation warnings,
> move the board info structures from the C files to the common header
> and hence deduplicate configuration data.
>=20
> Signed-off-by: Andy Shevchenko <andriy.shevchenko@linux.intel.com>
> ---
>  drivers/pwm/pwm-lpss-pci.c      | 29 -----------------------------
>  drivers/pwm/pwm-lpss-platform.c | 23 -----------------------
>  drivers/pwm/pwm-lpss.h          | 30 ++++++++++++++++++++++++++++++

Given that both the pci driver and the platform driver alread depend on
pwm-lpss.o, I'd prefer something like the patch below to really
deduplicate the data.

One thing to note is that the two pwm_lpss_bsw_info are not identical. I
didn't check how that is relevant. Did you check that?

Best regards
Uwe

diff --git a/drivers/pwm/pwm-lpss-pci.c b/drivers/pwm/pwm-lpss-pci.c
index c893ec3d2fb4..75b778e839b3 100644
--- a/drivers/pwm/pwm-lpss-pci.c
+++ b/drivers/pwm/pwm-lpss-pci.c
@@ -14,35 +14,6 @@
=20
 #include "pwm-lpss.h"
=20
-/* BayTrail */
-static const struct pwm_lpss_boardinfo pwm_lpss_byt_info =3D {
-	.clk_rate =3D 25000000,
-	.npwm =3D 1,
-	.base_unit_bits =3D 16,
-};
-
-/* Braswell */
-static const struct pwm_lpss_boardinfo pwm_lpss_bsw_info =3D {
-	.clk_rate =3D 19200000,
-	.npwm =3D 1,
-	.base_unit_bits =3D 16,
-};
-
-/* Broxton */
-static const struct pwm_lpss_boardinfo pwm_lpss_bxt_info =3D {
-	.clk_rate =3D 19200000,
-	.npwm =3D 4,
-	.base_unit_bits =3D 22,
-	.bypass =3D true,
-};
-
-/* Tangier */
-static const struct pwm_lpss_boardinfo pwm_lpss_tng_info =3D {
-	.clk_rate =3D 19200000,
-	.npwm =3D 4,
-	.base_unit_bits =3D 22,
-};
-
 static int pwm_lpss_probe_pci(struct pci_dev *pdev,
 			      const struct pci_device_id *id)
 {
diff --git a/drivers/pwm/pwm-lpss-platform.c b/drivers/pwm/pwm-lpss-platfor=
m.c
index 928570430cef..834423c34f48 100644
--- a/drivers/pwm/pwm-lpss-platform.c
+++ b/drivers/pwm/pwm-lpss-platform.c
@@ -15,28 +15,6 @@
=20
 #include "pwm-lpss.h"
=20
-/* BayTrail */
-static const struct pwm_lpss_boardinfo pwm_lpss_byt_info =3D {
-	.clk_rate =3D 25000000,
-	.npwm =3D 1,
-	.base_unit_bits =3D 16,
-};
-
-/* Braswell */
-static const struct pwm_lpss_boardinfo pwm_lpss_bsw_info =3D {
-	.clk_rate =3D 19200000,
-	.npwm =3D 1,
-	.base_unit_bits =3D 16,
-	.other_devices_aml_touches_pwm_regs =3D true,
-};
-
-/* Broxton */
-static const struct pwm_lpss_boardinfo pwm_lpss_bxt_info =3D {
-	.clk_rate =3D 19200000,
-	.npwm =3D 4,
-	.base_unit_bits =3D 22,
-	.bypass =3D true,
-};
=20
 static int pwm_lpss_probe_platform(struct platform_device *pdev)
 {
diff --git a/drivers/pwm/pwm-lpss.c b/drivers/pwm/pwm-lpss.c
index 36d4e83e6b79..e8b16b67bfd4 100644
--- a/drivers/pwm/pwm-lpss.c
+++ b/drivers/pwm/pwm-lpss.c
@@ -29,6 +29,39 @@
 /* Size of each PWM register space if multiple */
 #define PWM_SIZE			0x400
=20
+/* BayTrail */
+const struct pwm_lpss_boardinfo pwm_lpss_byt_info =3D {
+	.clk_rate =3D 25000000,
+	.npwm =3D 1,
+	.base_unit_bits =3D 16,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_byt_info);
+
+/* Braswell */
+const struct pwm_lpss_boardinfo pwm_lpss_bsw_info =3D {
+	.clk_rate =3D 19200000,
+	.npwm =3D 1,
+	.base_unit_bits =3D 16,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_bsw_info);
+
+/* Broxton */
+const struct pwm_lpss_boardinfo pwm_lpss_bxt_info =3D {
+	.clk_rate =3D 19200000,
+	.npwm =3D 4,
+	.base_unit_bits =3D 22,
+	.bypass =3D true,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_bxt_info);
+
+/* Tangier */
+const struct pwm_lpss_boardinfo pwm_lpss_tng_info =3D {
+	.clk_rate =3D 19200000,
+	.npwm =3D 4,
+	.base_unit_bits =3D 22,
+};
+EXPORT_SYMBOL_GPL(pwm_lpss_tng_info);
+
 static inline struct pwm_lpss_chip *to_lpwm(struct pwm_chip *chip)
 {
 	return container_of(chip, struct pwm_lpss_chip, chip);
diff --git a/drivers/pwm/pwm-lpss.h b/drivers/pwm/pwm-lpss.h
index 8b3476f25e06..918d2f177109 100644
--- a/drivers/pwm/pwm-lpss.h
+++ b/drivers/pwm/pwm-lpss.h
@@ -33,6 +33,11 @@ struct pwm_lpss_boardinfo {
 	bool other_devices_aml_touches_pwm_regs;
 };
=20
+extern const struct pwm_lpss_boardinfo pwm_lpss_tng_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_bxt_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_bsw_info;
+extern const struct pwm_lpss_boardinfo pwm_lpss_byt_info;
+
 struct pwm_lpss_chip *pwm_lpss_probe(struct device *dev, struct resource *=
r,
 				     const struct pwm_lpss_boardinfo *info);
=20

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--scqcxlngs5jspysc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmMYXokACgkQwfwUeK3K
7AnUAggAgAeeWAWu/LmXJf/jBBobK0LmrjQtLRhHxMwo5TwkbqSLFSCBo0FRE5yW
SsqRB+eDvqPleo+qjA5RlXVnlPyi/nMw0NYyIepbZVT9gLcTvM4vwcz8YPxverCs
kZD41KdNh8t+CUgtGhfbXyyIkuFqbxe01D0nRIYyem/DdL12gKhQxqXypv09l53q
++KpWaejfKb3r11q0aafg9f51e8JBHNEaxBCSdlRGvlmRHIQ5afCbLwaytbRxN3u
GJOFZ4FXpKpSux8MRa+zwETxLKQn3YZ83MOvC3bBK7AyR8tqGkrAkmf5lAzvq9BE
o4Obg1PL6gKZLWw9k1m8rtEzi9fW6Q==
=KFjG
-----END PGP SIGNATURE-----

--scqcxlngs5jspysc--
