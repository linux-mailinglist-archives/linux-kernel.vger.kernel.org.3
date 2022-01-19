Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 41201493EB4
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 18:00:37 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1356272AbiASRAB (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 12:00:01 -0500
Received: from phobos.denx.de ([85.214.62.61]:44402 "EHLO phobos.denx.de"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S1356260AbiASQ77 (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 11:59:59 -0500
Received: from maia.denx.de (p578adb1c.dip0.t-ipconnect.de [87.138.219.28])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits))
        (No client certificate requested)
        (Authenticated sender: hws@denx.de)
        by phobos.denx.de (Postfix) with ESMTPSA id 17CEE82EC6;
        Wed, 19 Jan 2022 17:59:57 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=denx.de;
        s=phobos-20191101; t=1642611597;
        bh=/q+C3VbPC2VOWrVKiNrpD0R+9cNfKtav/yLgdEaX7U4=;
        h=Subject:From:To:Cc:Date:In-Reply-To:References:From;
        b=k/KMLQYqen8DVj6+TYKZ7qK9nye5lpi6qIzv41WEjKmfqlqfbZYGYgK8bX7LbKRyO
         eg6RLHjvfLQTewftVyI+H89hoRrKXkumYWEORhbvkd1ldATArZoOYeDlyt29DymR1P
         x6bQ5y1MLQqJmR2SDPkhEGtvVrBYX8q94dPymPQSaTuPshGXMfBo/3RSeCS8yimW2g
         0dYXeO+PS3TyoIz5inXk5c+0W7Cy2Ddy9hAkkxgmnt5ze/Ey/0XvGHYFDPn25W/otE
         3n2oNR0JZDwSjVaeRKUL9KeZGOTenu5BefiJE0ZnGKjbgSOiB473aAzATdt+qN693p
         gsVNi13/xE3zA==
Message-ID: <5cab27cab5a39ef5e19992bc54e57c3f6106dafe.camel@denx.de>
Subject: Re: [PATCH] tty: serial: imx: Add fast path when rs485 delays are 0
From:   Harald Seiler <hws@denx.de>
To:     Uwe =?ISO-8859-1?Q?Kleine-K=F6nig?= 
        <u.kleine-koenig@pengutronix.de>
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
Date:   Wed, 19 Jan 2022 17:59:46 +0100
In-Reply-To: <20220119162122.jmnz2hxid76p4hli@pengutronix.de>
References: <20220119145204.238767-1-hws@denx.de>
         <20220119151145.zft47rzebnabiej2@pengutronix.de>
         <0df5d9ea2081f5d798f80297efb973f542dae183.camel@denx.de>
         <20220119162122.jmnz2hxid76p4hli@pengutronix.de>
Content-Type: multipart/signed; micalg="pgp-sha256";
        protocol="application/pgp-signature"; boundary="=-ieYHdIC+xbiO+zbMAih0"
User-Agent: Evolution 3.42.2 (3.42.2-1.fc35) 
MIME-Version: 1.0
X-Virus-Scanned: clamav-milter 0.103.2 at phobos.denx.de
X-Virus-Status: Clean
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--=-ieYHdIC+xbiO+zbMAih0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: quoted-printable

Hi,

On Wed, 2022-01-19 at 17:21 +0100, Uwe Kleine-K=C3=B6nig wrote:
> On Wed, Jan 19, 2022 at 04:20:12PM +0100, Harald Seiler wrote:
> > Hi,
> >=20
> > On Wed, 2022-01-19 at 16:11 +0100, Uwe Kleine-K=C3=B6nig wrote:
> > > On Wed, Jan 19, 2022 at 03:52:03PM +0100, Harald Seiler wrote:
> > > > Right now, even when `delay_rts_before_send` and `delay_rts_after_s=
end`
> > > > are 0, the hrtimer is triggered (with timeout 0) which can introduc=
e a
> > > > few 100us of additional overhead on slower i.MX platforms.
> > > >=20
> > > > Implement a fast path when the delays are 0, where the RTS signal i=
s
> > > > toggled immediately instead of going through an hrtimer.  This fast=
 path
> > > > behaves identical to the code before delay support was implemented.
> > > >=20
> > > > Signed-off-by: Harald Seiler <hws@denx.de>
> > > > ---
> > > >  drivers/tty/serial/imx.c | 18 ++++++++++++++----
> > > >  1 file changed, 14 insertions(+), 4 deletions(-)
> > > >=20
> > > > diff --git a/drivers/tty/serial/imx.c b/drivers/tty/serial/imx.c
> > > > index df8a0c8b8b29..67bbbb69229d 100644
> > > > --- a/drivers/tty/serial/imx.c
> > > > +++ b/drivers/tty/serial/imx.c
> > > > @@ -455,9 +455,14 @@ static void imx_uart_stop_tx(struct uart_port =
*port)
> > > >  	if (port->rs485.flags & SER_RS485_ENABLED) {
> > > >  		if (sport->tx_state =3D=3D SEND) {
> > > >  			sport->tx_state =3D WAIT_AFTER_SEND;
> > > > -			start_hrtimer_ms(&sport->trigger_stop_tx,
> > > > +
> > > > +			if (port->rs485.delay_rts_after_send > 0) {
> > > > +				start_hrtimer_ms(&sport->trigger_stop_tx,
> > > >  					 port->rs485.delay_rts_after_send);
> > > > -			return;
> > > > +				return;
> > > > +			}
> > > > +
> > > > +			/* continue without any delay */
> > >=20
> > > Is it right to keep the assignment sport->tx_state =3D WAIT_AFTER_SEN=
D ?
> >=20
> > I am keeping the assignment intentionally, to fall into the
> > if(state =3D=3D WAIT_AFTER_RTS) below (which then sets the state to OFF=
).
> > I originally had the code structured like this:
> >=20
> > 	if (port->rs485.delay_rts_after_send > 0) {
> > 		sport->tx_state =3D WAIT_AFTER_SEND;
> > 		start_hrtimer_ms(&sport->trigger_stop_tx,
> > 			 port->rs485.delay_rts_after_send);
> > 		return;
> > 	} else {
> > 		/* continue without any delay */
> > 		sport->tx_state =3D WAIT_AFTER_SEND;
> > 	}
> >=20
> > This is functionally identical, but maybe a bit more explicit.
> >=20
> > Not sure what is more clear to read?
>=20
> I didn't oppose to the readability thing. With your patch you skip
> starting the stop_tx timer and that would usually care for calling
> imx_uart_stop_tx and setting sport->tx_state =3D OFF. This doesn't happen
> with your patch any more.

Not starting the timer is the entire point of the patch - instead, the
code which would run inside the timer callback now runs immediately. To
do this, I set the tx_state to WAIT_AFTER_SEND and _don't_ do the early
return which leads into the if(tx_state =3D=3D WAIT_AFTER_SEND) below.  Thi=
s
is the code-path which normally runs later in the hrtimer callback.

I suppose it would have been good to provide more context lines in the
patch... Here is the relevant bit (in the changed version now):

	if (sport->tx_state =3D=3D SEND) {
		sport->tx_state =3D WAIT_AFTER_SEND;

		if (port->rs485.delay_rts_after_send > 0) {
			start_hrtimer_ms(&sport->trigger_stop_tx,
				 port->rs485.delay_rts_after_send);
			return;
		}

		/* continue without any delay */
	}

	if (sport->tx_state =3D=3D WAIT_AFTER_RTS ||
	    sport->tx_state =3D=3D WAIT_AFTER_SEND) {
		/* ... actual rts toggling ... */

		sport->tx_state =3D OFF;
	}

Regards,
--=20
Harald

--=-ieYHdIC+xbiO+zbMAih0
Content-Type: application/pgp-signature; name="signature.asc"
Content-Description: This is a digitally signed message part
Content-Transfer-Encoding: 7bit

-----BEGIN PGP SIGNATURE-----

iQJABAABCAAqFiEETcH23ThHylbMjihC+a//80/kShkFAmHoQ4IMHGh3c0BkZW54
LmRlAAoJEPmv//NP5EoZmuUP+gLQMGJc/hi0X7lwgrR9sAEetnN9xA9+4Cl+VjVZ
6Pc61pYYAQbt8VDuBMcnEQzg4Vrx6h8c7Am4PTzZaIF6eLnZDgOcLaas72ZS/n0M
1NFM5VA+oIsBdYmMMNwxAOlKHFGE8L/C8cjmvi3B0bIZQKlNSdIYyPLWVOS/vKMq
RWqk6iwK2azg5eqLtzcigY6by6dtCB8xw68w9Z2jL9CkqJ9o9X0pTWSLOkP93YHB
htpESUbQ4LkJgNgVUcjUlPuVlNxFAQfiSauy5Ki41GkzpAKQSly9MrmytHtSBAv9
wZtyFxTzLdtP1+1CP4RZg17TNHO/eqblzqSkawR0Rd1fwqZpvSbb06ksa1T3IdD6
js3rjT2SMiyKnYwhH/uhXmlH5J5wCjn8zEJLb3f9ujsim+rhYIJ8fzw8aC4kTZNQ
r0+XJGaWrLucseJnQGY4+W6doJWjEHm8M7jmxpxYqYiOGwbv1zzhVXosGXYIFlWZ
567nBY3Fm1JUfQ36i07bwZHbYWCFJfgJie6LqSqIzmtVw8mmA02nT253Bz1yEEIH
qL4/lTZNlN4qFYHubRiXlPwQHgVSyNxvBniJ9VFQVGcd3HNTYlZCgP9YXENqG8mx
CqPmGnVQeMmNF09zNE7B3lqT+dn2pHyuRhn/yq6CqsU7Idn1JybJuDDFlIir/CBh
AjAc
=jiny
-----END PGP SIGNATURE-----

--=-ieYHdIC+xbiO+zbMAih0--
