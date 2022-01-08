Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 93CCC4886E8
	for <lists+linux-kernel@lfdr.de>; Sun,  9 Jan 2022 00:25:15 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233555AbiAHXZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 8 Jan 2022 18:25:13 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55476 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229761AbiAHXZL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 8 Jan 2022 18:25:11 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3E2CC06173F
        for <linux-kernel@vger.kernel.org>; Sat,  8 Jan 2022 15:25:10 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1n6L59-0005ig-8E; Sun, 09 Jan 2022 00:25:07 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-6624-65e0-1d16-9a67.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:6624:65e0:1d16:9a67])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id ADD7C6D3BA2;
        Sat,  8 Jan 2022 23:25:04 +0000 (UTC)
Date:   Sun, 9 Jan 2022 00:25:03 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Brian Silverman <bsilver16384@gmail.com>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Jonathan Hunter <jonathanh@nvidia.com>,
        open list <linux-kernel@vger.kernel.org>,
        "open list:CAN NETWORK DRIVERS" <linux-can@vger.kernel.org>,
        "open list:TEGRA ARCHITECTURE SUPPORT" <linux-tegra@vger.kernel.org>
Subject: Re: [RFC PATCH] can: m_can: Add driver for M_CAN hardware in NVIDIA
 devices
Message-ID: <20220108232503.ecwf7f4uuo7s7eni@pengutronix.de>
References: <20220106002514.24589-1-brian.silverman@bluerivertech.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="j2owows65r7zjzcq"
Content-Disposition: inline
In-Reply-To: <20220106002514.24589-1-brian.silverman@bluerivertech.com>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--j2owows65r7zjzcq
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 05.01.2022 16:25:09, Brian Silverman wrote:
> It's a M_TTCAN with some NVIDIA-specific glue logic and clocks. The
> existing m_can driver works with it after handling the glue logic.
>=20
> The code is a combination of pieces from m_can_platform and NVIDIA's
> driver [1].
>=20
> [1] https://github.com/hartkopp/nvidia-t18x-can/blob/master/r32.2.1/nvidi=
a/drivers/net/can/mttcan/hal/m_ttcan.c
>=20
> Signed-off-by: Brian Silverman <brian.silverman@bluerivertech.com>

Thanks for your patch.

> ---
> I ran into bugs with the error handling in NVIDIA's m_ttcan driver, so I
> switched to m_can which has been much better. I'm looking for feedback
> on whether I should ensure rebasing hasn't broken anything, write up DT
> documentation, and submit this patch for real. The driver works great,
> but I've got some questions about submitting it.
>=20
> question: This has liberal copying of GPL code from NVIDIA's
> non-upstreamed m_ttcan driver. Is that OK?

The header in the driver says it's GPLv2:

| https://github.com/hartkopp/nvidia-t18x-can/blob/master/r32.2.1/nvidia/dr=
ivers/net/can/mttcan/hal/m_ttcan.c#L5

So it's OK. You should copy the original copyright notice to your glue
driver, though.

> corollary: I don't know what any of this glue logic does. I do know the
> device doesn't work without it. I can't find any documentation of what
> these addresses do.

hmmm ok

> question: There is some duplication between this and m_can_platform. It
> doesn't seem too bad to me, but is this the preferred way to do it or is
> there another alternative?

You might merge this driver to the generic platform driver.

> question: Do new DT bindings need to be in the YAML format, or is the
> .txt one OK?

YAML

Please fix the checkpatch warning found by:

| ./scripts/checkpatch.pl --file drivers/net/can/m_can/m_can_tegra.c

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--j2owows65r7zjzcq
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmHaHUwACgkQqclaivrt
76lrtwf/TBE40m671Kec7lv1AErSTYn7yLjVZkgZy8sHRUkiBzDfOvpFkRXfn4Yl
RFKlGuNl1bzSNH1FP2iEQu5G6HBzougiMCff1tjL/ou7fKoGfdPiR85QWGsXHUZZ
US1UXyMBBPWeFZeK9Fm9XmgOfDUaEvI9RDrHyUrul9T5DyKw3A1j4x43QOR++9VE
GzitPzB8oPWPnFyi/8iFwCfkg6+j8V7VX/UmwJyvkzZT8R99dWh4OUWuwKJjFkHa
PsOr7ToXgoKJTAOu3IMNyLrxu0tJSBEDGWTPmJ07bBJfyTLoyL4mHOAr89J4xPGG
O6UboqJB0B5WyE1+EMaoMLNhbzy+7g==
=BWAy
-----END PGP SIGNATURE-----

--j2owows65r7zjzcq--
