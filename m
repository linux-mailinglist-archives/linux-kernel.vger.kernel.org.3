Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C9C3A55738E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 09:07:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230112AbiFWHHA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 03:07:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230156AbiFWHGk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 03:06:40 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 629DA457BB
        for <linux-kernel@vger.kernel.org>; Thu, 23 Jun 2022 00:06:31 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1o4Gv1-0003oc-SC; Thu, 23 Jun 2022 09:06:23 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o4Guz-002Bz4-AY; Thu, 23 Jun 2022 09:06:22 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1o4Gv0-000aJj-4y; Thu, 23 Jun 2022 09:06:22 +0200
Date:   Thu, 23 Jun 2022 09:06:20 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Kunihiko Hayashi <hayashi.kunihiko@socionext.com>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH] clk: Fix referring to wrong pointer in devm_clk_release()
Message-ID: <20220623070620.ndhnxeiw4wtjgpjm@pengutronix.de>
References: <1655946142-1346-1-git-send-email-hayashi.kunihiko@socionext.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="jv3qenidbph7ovk4"
Content-Disposition: inline
In-Reply-To: <1655946142-1346-1-git-send-email-hayashi.kunihiko@socionext.com>
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


--jv3qenidbph7ovk4
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Thu, Jun 23, 2022 at 10:02:22AM +0900, Kunihiko Hayashi wrote:
> At bind phase, __devm_clk_get() calls devres_alloc() to allocate devres,
> and dr->data is treated as a variable "state".
>=20
> At unbind phase, release_nodes() calls devm_clk_release() specified by
> devres_alloc().
>=20
> The argument "res" of devm_clk_release() is dr->data, and this entity is
> "state", however in devm_clk_release(), "*res" is treated as "state",
> resulting in pointer inconsistency.
>=20
> Unbinding a driver caused a panic.
>=20
>     Unable to handle kernel execute from non-executable memory
>     at virtual address ffff000100236810
>     ...
>     pc : 0xffff000100236810
>     lr : devm_clk_release+0x6c/0x9c
>     ...
>     Call trace:
>      0xffff000100236810
>      release_nodes+0xb0/0x150
>      devres_release_all+0x94/0xf8
>      device_unbind_cleanup+0x20/0x70
>      device_release_driver_internal+0x114/0x1a0
>      device_driver_detach+0x20/0x30
>=20
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Fixes: abae8e57e49a ("clk: generalize devm_clk_get() a bit")
> Signed-off-by: Kunihiko Hayashi <hayashi.kunihiko@socionext.com>

This is already fixed in clk-next:

	https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/commit/?h=3D=
clk-next&id=3D8b3d743fc9e2542822826890b482afabf0e7522a

Thanks anyhow,
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--jv3qenidbph7ovk4
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmK0EOoACgkQwfwUeK3K
7AkjWwgAg4a0+xMiicHufojk42bdnz9tqwzBgqZbaMiftq3u8vfeTFJfZOfuyyik
9LgGHGu0qRDSWsCgW7p438rSqniQJfemDF7y8lomhap0azNXt8UGSTtFC99Xjh5m
Yiybiq05TOYvry1U0Dg7VH3ZrmUUDxfXH/XfS0ztLjCZRmSoQhJiO/cnY2t0WTWY
d/EES4gL87EPgSsrDg7BXUDOfHq5sIwrhRuK7sM4wWwnoGOT34EoTZzPD1A0ahPx
5DHoYF3cf7qDjKhlVf+42A99RD7lIQIwiMsdGi7AN67fRBtqYi7gNvzB+u5a3/jc
fNlecLC+DEjdJw152cED9uArIOl7ZQ==
=KX9w
-----END PGP SIGNATURE-----

--jv3qenidbph7ovk4--
