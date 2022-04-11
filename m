Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8C9724FB8DB
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Apr 2022 12:02:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1344985AbiDKKEj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Apr 2022 06:04:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55230 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238825AbiDKKEd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Apr 2022 06:04:33 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AA9D40E73
        for <linux-kernel@vger.kernel.org>; Mon, 11 Apr 2022 03:02:20 -0700 (PDT)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndqs3-0001VG-FJ; Mon, 11 Apr 2022 12:02:07 +0200
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndqs3-002MQB-9j; Mon, 11 Apr 2022 12:02:05 +0200
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1ndqs1-002ZTf-2q; Mon, 11 Apr 2022 12:02:05 +0200
Date:   Mon, 11 Apr 2022 12:02:02 +0200
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Tony Lindgren <tony@atomide.com>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Andy Shevchenko <andriy.shevchenko@intel.com>,
        Jiri Slaby <jirislaby@kernel.org>,
        Johan Hovold <johan@kernel.org>,
        Sebastian Andrzej Siewior <bigeasy@linutronix.de>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        linux-serial@vger.kernel.org, linux-omap@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>,
        "Matwey V. Kornilov" <matwey@sai.msu.ru>
Subject: Re: [PATCH 2/2] serial: 8250: Fix runtime PM for start_tx() for
 empty buffer
Message-ID: <20220411100202.5mzcogksfzk4hlk6@pengutronix.de>
References: <20220411094805.45696-1-tony@atomide.com>
 <20220411094805.45696-2-tony@atomide.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="mog63zosfq7sgn7x"
Content-Disposition: inline
In-Reply-To: <20220411094805.45696-2-tony@atomide.com>
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


--mog63zosfq7sgn7x
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Mon, Apr 11, 2022 at 12:48:05PM +0300, Tony Lindgren wrote:
> Commit 932d596378b0 ("serial: 8250: Return early in .start_tx() if there
> are no chars to send") caused a regression where the drivers implementing
> runtime PM stopped idling.
>=20
> We need to call serial8250_rpm_put_tx() on early exit, it normally gets
> called later on at __stop_tx().
>=20
> Fixes: 932d596378b0 ("serial: 8250: Return early in .start_tx() if there =
are no chars to send")
> Cc: Steffen Trumtrar <s.trumtrar@pengutronix.de>
> Cc: Uwe Kleine-K=F6nig <u.kleine-koenig@pengutronix.de>
> Signed-off-by: Tony Lindgren <tony@atomide.com>
> ---
>  drivers/tty/serial/8250/8250_port.c | 4 +++-
>  1 file changed, 3 insertions(+), 1 deletion(-)
>=20
> diff --git a/drivers/tty/serial/8250/8250_port.c b/drivers/tty/serial/825=
0/8250_port.c
> --- a/drivers/tty/serial/8250/8250_port.c
> +++ b/drivers/tty/serial/8250/8250_port.c
> @@ -1677,8 +1677,10 @@ static void serial8250_start_tx(struct uart_port *=
port)
> =20
>  	serial8250_rpm_get_tx(up);
> =20
> -	if (!port->x_char && uart_circ_empty(&port->state->xmit))
> +	if (!port->x_char && uart_circ_empty(&port->state->xmit)) {
> +		serial8250_rpm_put_tx(up);
>  		return;
> +	}

Assuming you don't need serial8250_rpm_get_tx() to check the condition,
it would be easier to move the early return before the call to
serial8250_rpm_get_tx().

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--mog63zosfq7sgn7x
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmJT/JcACgkQwfwUeK3K
7AmWNgf+IEwsufAbM3FLCmMNkfpzUsHgYf7rkVnWWCEQMp6Gp1L6uaZtqT0bYI+5
wUukJuaYFU1PVp+oy8JB/ZduyFrp/e4qOnPJ9hl2tJg0J6pZ21PH2tO/RYRjbrIT
h7srAdGQSX/e/u4R/TWRTuakJdwUBJHMpEO6KbXLC4xwpsUNtQeZjdsHUbalsoZg
SvtjbdFrzeQU05ZF/an8fIgRl5/4LTnauf3YRPR2CBHwuElpuWIUqwR4E4kd7HFc
OvVnpyGSb5fZ2k9Xvjla/CwW4I+e0At7T8Y4na0Jy6vKO/PhzcdIx2SDPvngYL5E
ikIrMVTSxTA5IWNHOfJcUvAEqpKxgw==
=/HZe
-----END PGP SIGNATURE-----

--mog63zosfq7sgn7x--
