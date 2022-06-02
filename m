Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 285F553B4E7
	for <lists+linux-kernel@lfdr.de>; Thu,  2 Jun 2022 10:23:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232139AbiFBIXZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 2 Jun 2022 04:23:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232126AbiFBIXX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 2 Jun 2022 04:23:23 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A146C15FED
        for <linux-kernel@vger.kernel.org>; Thu,  2 Jun 2022 01:23:22 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nwg6u-0001YT-9J; Thu, 02 Jun 2022 10:23:16 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nwg6u-005zgh-Fz; Thu, 02 Jun 2022 10:23:15 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nwg6s-00DhT4-Cw; Thu, 02 Jun 2022 10:23:14 +0200
Date:   Thu, 2 Jun 2022 10:22:50 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Eddie James <eajames@linux.ibm.com>
Cc:     broonie@kernel.org, linux-spi@vger.kernel.org,
        linux-kernel@vger.kernel.org
Subject: Re: [PATCH 2/2] spi: core: Display return code when failing to
 transfer message
Message-ID: <20220602082250.s4llxsng4fecduhc@pengutronix.de>
References: <20220525165852.33167-1-eajames@linux.ibm.com>
 <20220525165852.33167-3-eajames@linux.ibm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="b6nldfoupl3pmrdy"
Content-Disposition: inline
In-Reply-To: <20220525165852.33167-3-eajames@linux.ibm.com>
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


--b6nldfoupl3pmrdy
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello,

On Wed, May 25, 2022 at 11:58:52AM -0500, Eddie James wrote:
> All the other calls to the controller driver display the error
> return code. The return code is helpful to understand what went
> wrong, so include it when failing to transfer one message.
>=20
> Signed-off-by: Eddie James <eajames@linux.ibm.com>
> ---
>  drivers/spi/spi.c | 3 ++-
>  1 file changed, 2 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/spi/spi.c b/drivers/spi/spi.c
> index 481edea77c62..ea09d1b42bf6 100644
> --- a/drivers/spi/spi.c
> +++ b/drivers/spi/spi.c
> @@ -1654,7 +1654,8 @@ static void __spi_pump_messages(struct spi_controll=
er *ctlr, bool in_kthread)
>  	ret =3D ctlr->transfer_one_message(ctlr, msg);
>  	if (ret) {
>  		dev_err(&ctlr->dev,
> -			"failed to transfer one message from queue\n");
> +			"failed to transfer one message from queue: %d\n",
> +			ret);

(I know it's too late, just stumbled over this commit in mainline by
chance. So maybe just a suggestion for the next similar change...)

A tad nicer would be to use %pe instead of %d that results in

	mydev mybus: failed to transfer one message from queue: -EIO

instead of

	mydev mybus: failed to transfer one message from queue: -5

and so is more descriptive. (Note you need ERR_PTR(ret) for %pe.)

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--b6nldfoupl3pmrdy
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmKYc1EACgkQwfwUeK3K
7AlvuQf/SW2QRJEmHhltTqXdJ0dLZ3pvlWA9CtOkNfO3QuJKbG0TablgBoHJptN4
hmxrdQeEM3ISXL2OlJ4wMf41i20G6TXVrcNGHduZ3sPP7AiiGIhG1ZbxC1aWJqo+
H86PLgo8C5MX1WcpayJoJBMnAI5TtkMB3ubeWU4eputBkfCO3udWYZbCGagaxt4K
4u5MoHo7I9q9TaVkVaKfeGR8k4vh4f9nrh2ZfEuIeb6CV6uBVm1LyAg7NMaWemE4
LkIDcotB0J60DnwEH8oDnDVdimwO3U3SPEjwbqjge22A2vch5tAi6TtRsG+q5T/V
sncY0W+KoLI3P7k94X+gGTCG/Y5dIg==
=xFn8
-----END PGP SIGNATURE-----

--b6nldfoupl3pmrdy--
