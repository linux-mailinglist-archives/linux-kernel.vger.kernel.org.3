Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85D994CCF40
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 08:49:05 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238962AbiCDHts (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 02:49:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44496 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235758AbiCDHtp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 02:49:45 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC84070904
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 23:48:58 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nQ2gG-0006mM-9H; Fri, 04 Mar 2022 08:48:52 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nQ2gF-002ZDA-KG; Fri, 04 Mar 2022 08:48:50 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nQ2gE-006sEV-4C; Fri, 04 Mar 2022 08:48:50 +0100
Date:   Fri, 4 Mar 2022 08:48:46 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Sean Anderson <sean.anderson@seco.com>
Cc:     linux-pwm@vger.kernel.org, devicetree@vger.kernel.org,
        Thierry Reding <thierry.reding@gmail.com>,
        linux-kernel@vger.kernel.org, Lee Jones <lee.jones@linaro.org>,
        Mubin Usman Sayyed <MUBINUSM@xilinx.com>,
        linux-arm-kernel@lists.infradead.org, michal.simek@xilinx.com,
        Alvaro Gamez <alvaro.gamez@hazent.com>
Subject: Re: [PATCH v14 2/2] pwm: Add support for Xilinx AXI Timer
Message-ID: <20220304074846.bkzwn4c3voaxxqzu@pengutronix.de>
References: <20220303223544.2810594-1-sean.anderson@seco.com>
 <20220303223544.2810594-2-sean.anderson@seco.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p2h2j3kov6vozmcs"
Content-Disposition: inline
In-Reply-To: <20220303223544.2810594-2-sean.anderson@seco.com>
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


--p2h2j3kov6vozmcs
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Mar 03, 2022 at 05:35:43PM -0500, Sean Anderson wrote:
> This adds PWM support for Xilinx LogiCORE IP AXI soft timers commonly
> found on Xilinx FPGAs. At the moment clock control is very basic: we
> just enable the clock during probe and pin the frequency. In the future,
> someone could add support for disabling the clock when not in use.
>=20
> Some common code has been specially demarcated. While currently only
> used by the PWM driver, it is anticipated that it may be split off in
> the future to be used by the timer driver as well.
>=20
> This driver was written with reference to Xilinx DS764 for v1.03.a [1].
>=20
> [1] https://www.xilinx.com/support/documentation/ip_documentation/axi_tim=
er/v1_03_a/axi_timer_ds764.pdf
>=20
> Signed-off-by: Sean Anderson <sean.anderson@seco.com>
> Acked-by: Michal Simek <michal.simek@xilinx.com>

One little thing below. Not worth respinning for just that though, so:

Reviewed-by: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>

> +	/*
> +	 * 100% duty cycle results in constant low output. This may be (very)
> +	 * wrong if rate >=3D 1 GHz, so fix this if you have such hardware :)
> +	 */

In v13 I asked for s/>=3D 1GHz/> 1 GHz/. You seem to have missed, that
this contains two suggested changes. So there is s/>=3D/>/ left.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--p2h2j3kov6vozmcs
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmIhxFsACgkQwfwUeK3K
7AkAGggAgfyHW1Ixgq5HpEFxU/VPYVbIaB6tfSzia/O45pIYTLinozrOQE5YD9dn
/++33kt9jTX9M7dkV4sxLtFhgV1l3qVYaptN0TxGcwykyphzw6Q+FK28SdUegS1O
+HMlKJndbPwMp5ek+SoPzgXhkwsKg464tE0YwvLryt91/mJ6zwujhLC+R6VIh2lS
61/fNKMVGN5PgW8NrRS6ILHR/NChzhmo4rcoTf2Q0j3sMHJ1hexMoIMmDSTyz5MU
kpd3hPH8Wol4XUjfH12mJLEMlGbLhSxMMm1he2FquW+e2Z7gvvaEu43TJHbwUanu
SRvWTydNi7ItVmT2wZrS7HLuXJWtsA==
=KEN0
-----END PGP SIGNATURE-----

--p2h2j3kov6vozmcs--
