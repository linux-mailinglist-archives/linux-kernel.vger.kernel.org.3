Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E7004AD76D
	for <lists+linux-kernel@lfdr.de>; Tue,  8 Feb 2022 12:35:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352777AbiBHLek (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 8 Feb 2022 06:34:40 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37884 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233747AbiBHLMW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 8 Feb 2022 06:12:22 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2AB8FC03FEC0
        for <linux-kernel@vger.kernel.org>; Tue,  8 Feb 2022 03:12:19 -0800 (PST)
Received: from drehscheibe.grey.stw.pengutronix.de ([2a0a:edc0:0:c01:1d::a2])
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHOPo-0003m2-J3; Tue, 08 Feb 2022 12:12:08 +0100
Received: from [2a0a:edc0:0:900:1d::77] (helo=ptz.office.stw.pengutronix.de)
        by drehscheibe.grey.stw.pengutronix.de with esmtp (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHOPo-00FHrC-0B; Tue, 08 Feb 2022 12:12:07 +0100
Received: from ukl by ptz.office.stw.pengutronix.de with local (Exim 4.94.2)
        (envelope-from <ukl@pengutronix.de>)
        id 1nHOPm-00BpnB-FQ; Tue, 08 Feb 2022 12:12:06 +0100
Date:   Tue, 8 Feb 2022 12:12:03 +0100
From:   Uwe =?utf-8?Q?Kleine-K=C3=B6nig?= <u.kleine-koenig@pengutronix.de>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     Harald Seiler <hws@denx.de>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Jiri Slaby <jirislaby@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        linux-serial@vger.kernel.org, Fabio Estevam <festevam@gmail.com>,
        linux-arm-kernel@lists.infradead.org
Subject: Re: [PATCH] tty: serial: imx: Add fast path when rs485 delays are 0
Message-ID: <20220208111203.qi6fpo2l6um6znkz@pengutronix.de>
References: <20220119145204.238767-1-hws@denx.de>
 <20220119151145.zft47rzebnabiej2@pengutronix.de>
 <0df5d9ea2081f5d798f80297efb973f542dae183.camel@denx.de>
 <20220119162122.jmnz2hxid76p4hli@pengutronix.de>
 <5cab27cab5a39ef5e19992bc54e57c3f6106dafe.camel@denx.de>
 <YgJADKxWfOZroS35@kroah.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="cofqnvm6jpalvn3e"
Content-Disposition: inline
In-Reply-To: <YgJADKxWfOZroS35@kroah.com>
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


--cofqnvm6jpalvn3e
Content-Type: text/plain; charset=iso-8859-1
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

Hello Greg,

On Tue, Feb 08, 2022 at 11:03:56AM +0100, Greg Kroah-Hartman wrote:
> On Wed, Jan 19, 2022 at 05:59:46PM +0100, Harald Seiler wrote:
> > On Wed, 2022-01-19 at 17:21 +0100, Uwe Kleine-K=F6nig wrote:
> > > On Wed, Jan 19, 2022 at 04:20:12PM +0100, Harald Seiler wrote:
> > > > Hi,
> > > >=20
> > > > On Wed, 2022-01-19 at 16:11 +0100, Uwe Kleine-K=F6nig wrote:
> > > > > On Wed, Jan 19, 2022 at 03:52:03PM +0100, Harald Seiler wrote:
> > > > > > Right now, even when `delay_rts_before_send` and `delay_rts_aft=
er_send`
> > > > > > are 0, the hrtimer is triggered (with timeout 0) which can intr=
oduce a
> > > > > > few 100us of additional overhead on slower i.MX platforms.
> > > > > >=20
> > > > > > Implement a fast path when the delays are 0, where the RTS sign=
al is
> > > > > > toggled immediately instead of going through an hrtimer.  This =
fast path
> > > > > > behaves identical to the code before delay support was implemen=
ted.
> > > > > >=20
> > > > > > Signed-off-by: Harald Seiler <hws@denx.de>
> > > > > > ---
> > > > > >  drivers/tty/serial/imx.c | 18 ++++++++++++++----
> > > > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > > > >=20
> > > > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > > > index df8a0c8b8b29..67bbbb69229d 100644
> > > > > > --- a/drivers/tty/serial/imx.c
> > > > > > +++ b/drivers/tty/serial/imx.c
> > > > > > @@ -455,9 +455,14 @@ static void imx_uart_stop_tx(struct uart_p=
ort *port)
> > > > > >  	if (port->rs485.flags & SER_RS485_ENABLED) {
> > > > > >  		if (sport->tx_state =3D=3D SEND) {
> > > > > >  			sport->tx_state =3D WAIT_AFTER_SEND;
> > > > > > -			start_hrtimer_ms(&sport->trigger_stop_tx,
> > > > > > +
> > > > > > +			if (port->rs485.delay_rts_after_send > 0) {
> > > > > > +				start_hrtimer_ms(&sport->trigger_stop_tx,
> > > > > >  					 port->rs485.delay_rts_after_send);
> > > > > > -			return;
> > > > > > +				return;
> > > > > > +			}
> > > > > > +
> > > > > > +			/* continue without any delay */
> > > > >=20
> > > > > Is it right to keep the assignment sport->tx_state =3D WAIT_AFTER=
_SEND ?
> > > >=20
> > > > I am keeping the assignment intentionally, to fall into the
> > > > if(state =3D=3D WAIT_AFTER_RTS) below (which then sets the state to=
 OFF).
> > > > I originally had the code structured like this:
> > > >=20
> > > > 	if (port->rs485.delay_rts_after_send > 0) {
> > > > 		sport->tx_state =3D WAIT_AFTER_SEND;
> > > > 		start_hrtimer_ms(&sport->trigger_stop_tx,
> > > > 			 port->rs485.delay_rts_after_send);
> > > > 		return;
> > > > 	} else {
> > > > 		/* continue without any delay */
> > > > 		sport->tx_state =3D WAIT_AFTER_SEND;
> > > > 	}
> > > >=20
> > > > This is functionally identical, but maybe a bit more explicit.
> > > >=20
> > > > Not sure what is more clear to read?
> > >=20
> > > I didn't oppose to the readability thing. With your patch you skip
> > > starting the stop_tx timer and that would usually care for calling
> > > imx_uart_stop_tx and setting sport->tx_state =3D OFF. This doesn't ha=
ppen
> > > with your patch any more.
> >=20
> > Not starting the timer is the entire point of the patch - instead, the
> > code which would run inside the timer callback now runs immediately. To
> > do this, I set the tx_state to WAIT_AFTER_SEND and _don't_ do the early
> > return which leads into the if(tx_state =3D=3D WAIT_AFTER_SEND) below. =
 This
> > is the code-path which normally runs later in the hrtimer callback.
> >=20
> > I suppose it would have been good to provide more context lines in the
> > patch... Here is the relevant bit (in the changed version now):
> >=20
> > 	if (sport->tx_state =3D=3D SEND) {
> > 		sport->tx_state =3D WAIT_AFTER_SEND;
> >=20
> > 		if (port->rs485.delay_rts_after_send > 0) {
> > 			start_hrtimer_ms(&sport->trigger_stop_tx,
> > 				 port->rs485.delay_rts_after_send);
> > 			return;
> > 		}
> >=20
> > 		/* continue without any delay */
> > 	}
> >=20
> > 	if (sport->tx_state =3D=3D WAIT_AFTER_RTS ||
> > 	    sport->tx_state =3D=3D WAIT_AFTER_SEND) {
> > 		/* ... actual rts toggling ... */
> >=20
> > 		sport->tx_state =3D OFF;
> > 	}
> >=20
>=20
> Uwe, any thoughts about if this patch should be taken or not?

I will take a deeper look later today and tell you my thoughts.

Best regards
Uwe

--=20
Pengutronix e.K.                           | Uwe Kleine-K=F6nig            |
Industrial Linux Solutions                 | https://www.pengutronix.de/ |

--cofqnvm6jpalvn3e
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEfnIqFpAYrP8+dKQLwfwUeK3K7AkFAmICUAAACgkQwfwUeK3K
7AkCVggAiaCfK44uF1z68o5GGrLoOxmCBoUtRqyKPMZpAfss1DpikhesyhQfors+
HsNakAxm+vUb7LX5ABOQpOQ8RCE8RaHN/y/NP0adsItH3ncycnUUZF/hQ2p1CE0F
8GNSjkgorw6KI+49JoSLIZS2f662FMRJHHpkZopdbg5cTHajB/uyLhbmeavrvI5h
8oN+P4hiDLb28frPesEw+qDkm2mh8sVdv+mvsiY78ILd6EDf/f2JCe35s1MLNd45
rITAcLeUkQEEWKZnlR2h3wfaznBl8lm2FkVDqelhhuld0+EJIL9ZVb0zLTebV6Sx
I8/3kveSia/OPuLzIa4Sy8BM6Mm/gw==
=xTHA
-----END PGP SIGNATURE-----

--cofqnvm6jpalvn3e--
