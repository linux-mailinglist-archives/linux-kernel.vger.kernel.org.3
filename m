Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2CAEF58BA52
	for <lists+linux-kernel@lfdr.de>; Sun,  7 Aug 2022 10:57:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232871AbiHGI4T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 7 Aug 2022 04:56:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50870 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229503AbiHGI4R (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 7 Aug 2022 04:56:17 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5E21DE81
        for <linux-kernel@vger.kernel.org>; Sun,  7 Aug 2022 01:56:16 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKc4y-0002Nd-Ql; Sun, 07 Aug 2022 10:56:12 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKc4v-002G5U-7g; Sun, 07 Aug 2022 10:56:11 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1oKc4w-00A6Gz-EG; Sun, 07 Aug 2022 10:56:10 +0200
Date:   Sun, 7 Aug 2022 10:56:10 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Andy Shevchenko <andriy.shevchenko@linux.intel.com>
Cc:     linux-pwm@vger.kernel.org, linux-kernel@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>
Subject: Re: [PATCH v1 1/4] pwm: sysfs: Switch to DEFINE_SIMPLE_DEV_PM_OPS()
 and pm_sleep_ptr()
Message-ID: <20220807085610.ahbxorztafdkol53@pengutronix.de>
References: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="hynmiwk7rrgb43hf"
Content-Disposition: inline
In-Reply-To: <20220806212331.40086-1-andriy.shevchenko@linux.intel.com>
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


--hynmiwk7rrgb43hf
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Sun, Aug 07, 2022 at 12:23:28AM +0300, Andy Shevchenko wrote:
> Using these newer macros allows the compiler to remove the unused
> structure and functions when !CONFIG_PM_SLEEP + removes the need to
> mark pm functions __maybe_unused.

Tested on ARCH=3Darm allmodconfig: No change in the binary (as expected I
think). When disabling PM_SLEEP the resulting change of this patch looks
as follows:

	add/remove: 0/1 grow/shrink: 0/0 up/down: 0/-92 (-92)
	Function                                     old     new   delta
	pwm_class_pm_ops                              92       -     -92
	Total: Before=3D5213, After=3D5121, chg -1.76%

Looks like a quest to convert all SIMPLE_DEV_PM_OPS users to
DEFINE_SIMPLE_DEV_PM_OPS.

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--hynmiwk7rrgb43hf
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmLvficACgkQwfwUeK3K
7AmNkgf+KBu+wHLIyo5wgh9h1ygss6q8lC1vaCtAjPtLdDA21+URbTAssQdxthTB
TYqR3Z0JQpXkI3Jtpp0GxPEM5kJyP+F6gkXrxepgms06aY2l3FDzwTw8mym6DGGy
vYSFgg51ZiyeQB+vN/AErELHDZcyRScNbzab4p9vOrNF6hwePgu5UG8M3HLO0Fc0
75B01bj8HuXRauojTWwa2bvsKGrHgkbm3ar/ljl6DZ7XJTNtAwL0p46mXQcgI7cK
fDlmuJA2lbbCdqNGX0LpDe+K1i3nQwCZP8F+oZpLWlHShgoxAK+VtTgWu4Hfd5tw
4/3DUVGyOkkv8fLFXXyR4/fkWRRtdQ==
=YRXy
-----END PGP SIGNATURE-----

--hynmiwk7rrgb43hf--
