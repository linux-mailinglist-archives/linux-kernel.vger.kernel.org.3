Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 87576493CDD
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 16:20:22 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355669AbiASPUV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 10:20:21 -0500
Received: from phobos.denx.de ([85.214.62.61]:33902 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S238769AbiASPUT (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 10:20:19 -0500
Received: from maia.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: hws@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id CE92980F9E;
        Wed, 19 Jan 2022 16:20:17 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1642605618;
        bh=7B4oNDkbh8GhEvlk0UqgZzjj2/33cChE0+LE0LwNNao=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=X6JUIFsxNwkyCqWvt65PoMmKKlthEQ0aRnVyteLgctpsmfDtov98ilzjvEj/UlnPS
         GCK+9G2wKkYWw8rmeX4AsholAExyE1MbeDQV/vn5gEpg/5fg1mK+8K98Y7vildwX5l
         eKC9RH14qgwfe5PVvMvlXcgHOGorYQ9ndrQAua1HEjeEW6mjkzpPSBJl49Uz1qyduW
         yamv8o8txFBoty5dmuqi1uCA3VhBBxkHR1mq9uRhKVBrBOE5oaHu42wmUHKmWp0Yud
         WYoBSTY0NQ+JVKX7XHLXhtw0dKQq0I4ZIKXojofrnH12qw3gkI39nDs8ea3R8stdwL
         K3P9P/BlBEc4Q==
Message-ID: <0df5d9ea2081f5d798f80297efb973f542dae183.camel@denx.de>
Subject: Re: [PATCH] tty: serial: imx: Add fast path when rs485 delays are 0
From:   Harald Seiler <hws@denx.de>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
Cc:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Fabio Estevam <festevam@gmail.com>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        linux-serial@vger.kernel.org, Jiri Slaby <jirislaby@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        linux-kernel@vger.kernel.org, NXP Linux Team <linux-imx@nxp.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Shawn Guo <shawnguo@kernel.org>,
        linux-arm-kernel@lists.infradead.org
Date:   Wed, 19 Jan 2022 16:20:12 +0100
In-Reply-To: <20220119151145.zft47rzebnabiej2@pengutronix.de>
References: <20220119145204.238767-1-hws@denx.de>
         <20220119151145.zft47rzebnabiej2@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-Ije/lCSSUJW1kFgl5Yjm"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-Ije/lCSSUJW1kFgl5Yjm
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2022-01-19 at 16:11 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Jan 19, 2022 at 03:52:03PM +0100, Harald Seiler wrote:
> > Right now, even when `delay_rts_before_send` and `delay_rts_after_send`
> > are 0, the hrtimer is triggered (with timeout 0) which can introduce a
> > few 100us of additional overhead on slower i.MX platforms.
> >=20
> > Implement a fast path when the delays are 0, where the RTS signal is
> > toggled immediately instead of going through an hrtimer.  This fast pat=
h
> > behaves identical to the code before delay support was implemented.
> >=20
> > Signed-off-by: Harald Seiler <hws@denx.de>
> > ---
> >  drivers/tty/serial/imx.c | 18 ++++++++++++++----
> >  1 file changed, 14 insertions(+), 4 deletions(-)
> >=20
> > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > index df8a0c8b8b29..67bbbb69229d 100644
> > --- a/drivers/tty/serial/imx.c
> > +++ b/drivers/tty/serial/imx.c
> > @@ -455,9 +455,14 @@ static void imx_uart_stop_tx(struct uart_port *por=
t)
> >  	if (port->rs485.flags & SER_RS485_ENABLED) {
> >  		if (sport->tx_state =3D=3D SEND) {
> >  			sport->tx_state =3D WAIT_AFTER_SEND;
> > -			start_hrtimer_ms(&sport->trigger_stop_tx,
> > +
> > +			if (port->rs485.delay_rts_after_send > 0) {
> > +				start_hrtimer_ms(&sport->trigger_stop_tx,
> >  					 port->rs485.delay_rts_after_send);
> > -			return;
> > +				return;
> > +			}
> > +
> > +			/* continue without any delay */
>=20
> Is it right to keep the assignment sport->tx_state =3D WAIT_AFTER_SEND ?

I am keeping the assignment intentionally, to fall into the
if(state =3D=3D WAIT_AFTER_RTS) below (which then sets the state to OFF).
I originally had the code structured like this:

	if (port->rs485.delay_rts_after_send > 0) {
		sport->tx_state =3D WAIT_AFTER_SEND;
		start_hrtimer_ms(&sport->trigger_stop_tx,
			 port->rs485.delay_rts_after_send);
		return;
	} else {
		/* continue without any delay */
		sport->tx_state =3D WAIT_AFTER_SEND;
	}

This is functionally identical, but maybe a bit more explicit.

Not sure what is more clear to read?

> >  		}
> > =20
> >  		if (sport->tx_state =3D=3D WAIT_AFTER_RTS ||
> > @@ -698,9 +703,14 @@ static void imx_uart_start_tx(struct uart_port *po=
rt)
> >  				imx_uart_stop_rx(port);
> > =20
> >  			sport->tx_state =3D WAIT_AFTER_RTS;
> > -			start_hrtimer_ms(&sport->trigger_start_tx,
> > +
> > +			if (port->rs485.delay_rts_before_send > 0) {
> > +				start_hrtimer_ms(&sport->trigger_start_tx,
> >  					 port->rs485.delay_rts_before_send);
> > -			return;
> > +				return;
> > +			}
> > +
> > +			/* continue without any delay */
>=20
> Here similar question here about sport->tx_state =3D WAIT_AFTER_RTS;

Same as above, but with WAIT_AFTER_RTS of course...

--=20
Harald

--=-Ije/lCSSUJW1kFgl5Yjm
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJABAABCAAqFiEETcH23ThHylbMjihC+a//80/kShkFAmHoLCwMHGh3c0BkZW54
LmRlAAoJEPmv//NP5EoZlaQP/18hVpxOfVIAdWcKZTKiXGzS4KtLUzu9YRES2HmE
LcjVZJFe1wa77reft5ceHWCWnKCSmDKihMvquvnHjtdWVqwqxdRvEXp14c3P1zhs
lim9dYDzLqm8/lU3LOU/JIjIozcPk149Xsq4Ja4me8shyaQ3zWwhzI50YxBhh6VU
/zRyslnrSFQGjqj6SYW2sqnSvzXw7+rVYGQoTBe1qVDdia1EbgCS76KQTmwidEPn
wIaT9NjqSJPAJyGVv65XGb85MwI5Zb7O4Zb/9gLJZTAgTNhhEirograVyW1+wVW4
78ualeLnhNIp7f2M6ZH5sfdSus8TIeNkUYN915z524vx1Z8chSE5IE12FqtTSaoZ
oO2Tv2Tr5MWi207jhDX8Go/JVzeHfceSgRlIlHY58GSV6y73eHa3oq7n0ig/3FZq
oYPz+cV1T5/1iahMZiFKaGr3i8lgTgU6NE0J71X4oEwurFAWli04dPvrnjoK8rZn
L3VRi7ZY+eT6jlqoS542aQj3/HokQ5gM5kJU2b4JDQDqnjXilpp1ZfN6JcUh0s29
u2//AK9ATTaKAlnrRqsWMtHC9FkVXSH2QnrQrQQa3CGa6VtcEF1onBcCS80553WF
YlycYWnz1t2KDMZ9PNOzI8+oSrI+s2dHHgAqJez9J4i07eb+gSwVCIIkpxGDVOA+
oJFT
=U071
-----END PGP SIGNATURE-----

--=-Ije/lCSSUJW1kFgl5Yjm--
