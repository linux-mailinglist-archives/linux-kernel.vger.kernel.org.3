Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 9AC66493E3B
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 17:21:38 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355926AbiASQVd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 11:21:33 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42972 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1353702AbiASQVb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:21:31 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DDC29C06161C
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 08:21:30 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nADiC-0001lS-Jy; Wed, 19 Jan 2022 17:21:28 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nADi8-00BD7u-GS; Wed, 19 Jan 2022 17:21:23 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nADi7-00036L-2R; Wed, 19 Jan 2022 17:21:23 +0100
Date:   Wed, 19 Jan 2022 17:21:22 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Harald Seiler <hws@denx.de>
Cc:     Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-serial@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Fabio Estevam <festevam@gmail.com>,
        Shawn Guo <shawnguo@kernel.org>,
        Jiri Slaby <jirislaby@kernel.org>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: imx: Add fast path when rs485 delays are 0
Message-ID: <20220119162122.jmnz2hxid76p4hli@pengutronix.de>
References: <20220119145204.238767-1-hws@denx.de>
 <20220119151145.zft47rzebnabiej2@pengutronix.de>
 <0df5d9ea2081f5d798f80297efb973f542dae183.camel@denx.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="3lbu7jtqhrttkbqc"
Content-Disposition: inline
In-Reply-To: <0df5d9ea2081f5d798f80297efb973f542dae183.camel@denx.de>
X-SA-Exim-Connect-IP: 2a0a:edc0:0:c01:1d::a2
X-SA-Exim-Mail-From: ukl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--3lbu7jtqhrttkbqc
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On Wed, Jan 19, 2022 at 04:20:12PM +0100, Harald Seiler wrote:
> Hi,
>=20
> On Wed, 2022-01-19 at 16:11 +0100, Uwe Kleine-K=F6nig wrote:
> > On Wed, Jan 19, 2022 at 03:52:03PM +0100, Harald Seiler wrote:
> > > Right now, even when `delay_rts_before_send` and `delay_rts_after_sen=
d`
> > > are 0, the hrtimer is triggered (with timeout 0) which can introduce a
> > > few 100us of additional overhead on slower i.MX platforms.
> > >=20
> > > Implement a fast path when the delays are 0, where the RTS signal is
> > > toggled immediately instead of going through an hrtimer.  This fast p=
ath
> > > behaves identical to the code before delay support was implemented.
> > >=20
> > > Signed-off-by: Harald Seiler <hws@denx.de>
> > > ---
> > >  drivers/tty/serial/imx.c | 18 ++++++++++++++----
> > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > >=20
> > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > index df8a0c8b8b29..67bbbb69229d 100644
> > > --- a/drivers/tty/serial/imx.c
> > > +++ b/drivers/tty/serial/imx.c
> > > @@ -455,9 +455,14 @@ static void imx_uart_stop_tx(struct uart_port *p=
ort)
> > >  	if (port->rs485.flags & SER_RS485_ENABLED) {
> > >  		if (sport->tx_state =3D=3D SEND) {
> > >  			sport->tx_state =3D WAIT_AFTER_SEND;
> > > -			start_hrtimer_ms(&sport->trigger_stop_tx,
> > > +
> > > +			if (port->rs485.delay_rts_after_send > 0) {
> > > +				start_hrtimer_ms(&sport->trigger_stop_tx,
> > >  					 port->rs485.delay_rts_after_send);
> > > -			return;
> > > +				return;
> > > +			}
> > > +
> > > +			/* continue without any delay */
> >=20
> > Is it right to keep the assignment sport->tx_state =3D WAIT_AFTER_SEND ?
>=20
> I am keeping the assignment intentionally, to fall into the
> if(state =3D=3D WAIT_AFTER_RTS) below (which then sets the state to OFF).
> I originally had the code structured like this:
>=20
> 	if (port->rs485.delay_rts_after_send > 0) {
> 		sport->tx_state =3D WAIT_AFTER_SEND;
> 		start_hrtimer_ms(&sport->trigger_stop_tx,
> 			 port->rs485.delay_rts_after_send);
> 		return;
> 	} else {
> 		/* continue without any delay */
> 		sport->tx_state =3D WAIT_AFTER_SEND;
> 	}
>=20
> This is functionally identical, but maybe a bit more explicit.
>=20
> Not sure what is more clear to read?

I didn't oppose to the readability thing. With your patch you skip
starting the stop_tx timer and that would usually care for calling
imx_uart_stop_tx and setting sport->tx_state =3D OFF. This doesn't happen
with your patch any more.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--3lbu7jtqhrttkbqc
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmHoOoAACgkQwfwUeK3K
7AlRAQgAgfdo/UnYSZL26GHCspaug9m4lKSf6QFlvEcKT5YXmO7pBNwvXZ7hX2aY
GacleYsn5gUSEjQeNnUKFd7JafMsdtNnd2gFNe3FAguhWW3perUcuSPiZO9xtu5b
HzQ9tEqmsNcumY1gvA0lwAOAc61XgHmxSsOW6twR/A/ldYYi0Q9iqUU0bGKsPWTI
Q+Buv+xjgbXUNYUV8NVbfbsNVvw4v6ou+8DdPH2GUoN3K8/pwmqJZ50pfXMdCrQT
d0iCMQ2bCnCWRzbvHLrTZ5yj59bgpBscZC27G5/zMJEKELufWbubOLpJhaIL+Xm6
ygFBeDtGvYTLy9esxdUY2Bh2wUEszA==
=WNP1
-----END PGP SIGNATURE-----

--3lbu7jtqhrttkbqc--
