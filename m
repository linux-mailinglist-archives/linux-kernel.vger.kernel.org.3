Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id A7B72493CB6
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:12:45 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355593AbiASPLw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:11:52 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54864 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1355580AbiASPLu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:11:50 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D5977C061574
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 07:11:49 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nACcl-0001fG-4U; Wed, 19 Jan 2022 16:11:47 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nACck-00BCfP-E9; Wed, 19 Jan 2022 16:11:45 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nACcj-0006Jz-As; Wed, 19 Jan 2022 16:11:45 +0100
Date:   Wed, 19 Jan 2022 16:11:45 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Harald Seiler <hws@denx.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: imx: Add fast path when rs485 delays are 0
Message-ID: <20220119151145.zft47rzebnabiej2@pengutronix.de>
References: <20220119145204.238767-1-hws@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="crht6kysa5gyjzqm"
Content-Disposition: inline
In-Reply-To: <20220119145204.238767-1-hws@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--crht6kysa5gyjzqm
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 19, 2022 at 03:52:03PM +0100, Harald Seiler wrote:
> Right now, even when `delay_rts_before_send` and `delay_rts_after_send`
> are 0, the hrtimer is triggered (with timeout 0) which can introduce a
> few 100us of additional overhead on slower i.MX platforms.
>=20
> Implement a fast path when the delays are 0, where the RTS signal is
> toggled immediately instead of going through an hrtimer.  This fast path
> behaves identical to the code before delay support was implemented.
>=20
> Signed-off-by: Harald Seiler <hws@denx.de>
> ---
>  drivers/tty/serial/imx.c | 18 ++++++++++++++----
>  1 file changed, 14 insertions(+), 4 deletions(-)
>=20
> diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> index df8a0c8b8b29..67bbbb69229d 100644
> --- a/drivers/tty/serial/imx.c
> +++ b/drivers/tty/serial/imx.c
> @@ -455,9 +455,14 @@ static void imx_uart_stop_tx(struct uart_port *port)
>  	if (port->rs485.flags & SER_RS485_ENABLED) {
>  		if (sport->tx_state =3D=3D SEND) {
>  			sport->tx_state =3D WAIT_AFTER_SEND;
> -			start_hrtimer_ms(&sport->trigger_stop_tx,
> +
> +			if (port->rs485.delay_rts_after_send > 0) {
> +				start_hrtimer_ms(&sport->trigger_stop_tx,
>  					 port->rs485.delay_rts_after_send);
> -			return;
> +				return;
> +			}
> +
> +			/* continue without any delay */

Is it right to keep the assignment sport->tx_state =3D WAIT_AFTER_SEND ?

>  		}
> =20
>  		if (sport->tx_state =3D=3D WAIT_AFTER_RTS ||
> @@ -698,9 +703,14 @@ static void imx_uart_start_tx(struct uart_port *port)
>  				imx_uart_stop_rx(port);
> =20
>  			sport->tx_state =3D WAIT_AFTER_RTS;
> -			start_hrtimer_ms(&sport->trigger_start_tx,
> +
> +			if (port->rs485.delay_rts_before_send > 0) {
> +				start_hrtimer_ms(&sport->trigger_start_tx,
>  					 port->rs485.delay_rts_before_send);
> -			return;
> +				return;
> +			}
> +
> +			/* continue without any delay */

Here similar question here about sport->tx_state =3D WAIT_AFTER_RTS;

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--crht6kysa5gyjzqm
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHoKi4ACgkQwfwUeK3K
7AkxHwf/ZLUsqC8FSuTk1mpDAsAeFlYV4Q+KaPUaQStofSEGdfVfttFyEXCybbvA
Y7CDhHsS6GDbseJ5Kw4vDSwgGfJcoiy7Z1D/odYNy+Fp8FLuyjqaJyXH1xFqIgd2
YmeDC2B8FzA+E9o6tTewX9wW2rJ0zGJLL55kI9yjcNqmxwjcPLe1G+qlwVO6Navu
hqCiGX1KeeeAGDQ07dxbCsJQpfFDHz1Xu8OW2tTrrUDaScsQnLatXnh1ZMEB/JPs
+LOIksHoLrjnRhH9jlytbr7vflOiAmTebmeHYSzX8IJfyBIFb1RVOiJNiHhDWAHy
PgQ4Ndr6K/r4qk80uoPRnkaSdqkB4w==
=AyeY
-----END PGP SIGNATURE-----

--crht6kysa5gyjzqm--
