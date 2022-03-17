Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9C154DCFB1
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Mar 2022 21:55:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229958AbiCQU5J (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Mar 2022 16:57:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58590 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229934AbiCQU5J (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Mar 2022 16:57:09 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D47B513DB43
        for <linux-kernel@vger.kernel.org>; Thu, 17 Mar 2022 13:55:51 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nUx9s-0001M1-HO; Thu, 17 Mar 2022 21:55:44 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-45d5-ab38-4e18-d873.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:45d5:ab38:4e18:d873])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 55CE14D743;
        Thu, 17 Mar 2022 20:55:43 +0000 (UTC)
Date:   Thu, 17 Mar 2022 21:55:42 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Wolfgang Grandegger <wg@grandegger.com>, linux-can@vger.kernel.org,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Jiri Slaby <jslaby@suse.com>
Subject: Re: [PATCH v3] can, tty: elmcan CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220317205542.2re5x73gqys5fl2n@pengutronix.de>
References: <20220307214303.1822590-1-max@enpas.org>
 <20220314215843.xxf6rdxxfwb255s4@pengutronix.de>
 <20220317211822.7d74b49c.max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="ggvj54df27ylfkyv"
Content-Disposition: inline
In-Reply-To: <20220317211822.7d74b49c.max@enpas.org>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
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


--ggvj54df27ylfkyv
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 17.03.2022 21:18:22, Max Staudt wrote:
> > > +/* Bits in elm->cmds_todo */
> > > +enum ELM_TODO { =20
> >         ^^^^^^^^
> > small caps please, and Vincent alreadt commented on the name.
>=20
> Small caps? Sorry, that's not possible in plain ASCII.
> You probably mean something else, but I'm not sure what?

I meant to say lowercase, sorry for the confusion.

[...]

> > > +	/* Regular parsing */
> > > +	switch (elm->state) {
> > > +	case ELM_RECEIVING:
> > > +		if (elm327_parse_frame(elm, len)) {
> > > +			/* Parse an error line. */
> > > +			elm327_parse_error(elm, len);
> > > +
> > > +			/* Start afresh. */
> > > +			elm327_kick_into_cmd_mode(elm);
> > > +		}
> > > +		break;
> > > +	default:
> > > +		break;
> > > +	}
> > > +}
> > > +
> > > +/* Assumes elm->lock taken. */
> > > +static void elm327_handle_prompt(struct elmcan *elm)
> > > +{
> > > +	struct can_frame *frame =3D &elm->can_frame;
> > > +	char local_txbuf[20]; =20
> >=20
> > How can you be sure, that the local_txbuf is large enough?
>=20
> It's filled in this very same function, with sprintf() or a strcpy()
> from one of the short strings in elm327_init_script (see next quote
> below). I've calculated the maximum length that can occur out of all
> these possibilities in the current code, and set that as the length of
> local_txbuf.

You can use something like "local_txbuf[sizeof("ATZ;ATDT0815;ATH")]"
with the longest ATZ command you can produce here.

> > > +	/* Reconfigure ELM327 step by step as indicated by
> > > elm->cmds_todo */
> > > +	if (test_bit(TODO_INIT, &elm->cmds_todo)) {
> > > +		strcpy(local_txbuf, *elm->next_init_cmd); =20
> >=20
> > strncpy()
>=20
> For this, there would have to be an entry in elm327_init_script that is
> longer than sizeof(local_txbuf) - 1. I highly doubt there ever will be,
> and even if someone does come up with one (maybe a huge new command in a
> future ELM327 revision), then strncpy would silently cut off the end and
> induce unexpected failure. Most importantly, this failure would be
> silent - the driver doesn't check the ELM's responses by design!
>=20
> I suggest an assert here. How about something like this?
>=20
> 	if (strlen(*elm->next_init_cmd) < sizeof(local_txbuf))
> 		strcpy(local_txbuf, *elm->next_init_cmd);
> 	else
> 		WARN_ONCE(...)
>
> If elm327_init_script contains an item longer than this buffer, then
> the buffer size needs to be increased. Simple programming error IMHO.
> I'd also add a comment to state this, next to elm327_init_script.
>=20
> What do you think?

You can use BUILD_BUG_ON() (see linux/build_bug.h) inside your C
function to make a compile time check, or static_assert() outside of C
functions.

> > > +	} else if (test_and_clear_bit(TODO_SILENT_MONITOR,
> > > &elm->cmds_todo)) {
> > > +		sprintf(local_txbuf, "ATCSM%i\r",
> > > +			!(!(elm->can.ctrlmode &
> > > CAN_CTRLMODE_LISTENONLY))); =20
> >=20
> > snprintf()
>=20
> See above. This size is predictable, and used to size local_txbuf.
>=20
> Thinking about it, since this size is easily predictable, the compiler
> could also do it, and that would turn snprintf() into a compile time
> check.
>=20
> Unfortunately I couldn't make GCC shout at me for giving snprintf() too
> small a buffer to fit all possible expansions of this format string. Is
> this even possible?

In user space, I've seen warnings like that, not sure about the kernel.

> > > +static int elmcan_netdev_open(struct net_device *dev)
> > > +{
> > > +	struct elmcan *elm =3D netdev_priv(dev);
> > > +	int err;
> > > +
> > > +	spin_lock_bh(&elm->lock);
> > > +	if (elm->hw_failure) {
> > > +		netdev_err(elm->dev, "Refusing to open interface
> > > after a hardware fault has been detected.\n");
> > > +		spin_unlock_bh(&elm->lock);
> > > +		return -EIO;
> > > +	} =20
> >=20
> > How to recover from this error?
>=20
> The user can detach and reattach the ldisc as often as desired.
>=20
> There is currently no intention to recover automatically. Once
> elm->hw_failure is set, something really weird must have happened such
> as unexpected characters on the UART. Since these devices are usually a
> PIC right next to a UART-USB bridge chip, which is why I deem this
> indicative of hardware too faulty to be trusted in any way.
>=20
> Regular "expected" errors are parsed and dealt with by sending error
> frames in elm327_parse_error(). These do not trigger hw_failure.

Ok, in other drivers I usually do a full reset during an ifdown/ifup
cycle....at least for non hot plug-able devices.

> > > +	elm->txbuf =3D kmalloc(ELM327_SIZE_TXBUF, GFP_KERNEL); =20
> >=20
> > Why do you allocate an extra buffer?
>=20
> If I remember correctly, I was told that this is preferred because
> drivers can DMA out of the aligned buffer. I didn't question that. I
> can simply allocate a buffer as part of struct elmcan if you prefer.

You can force proper alignment with marking the memory as
____cacheline_aligned. Extra bonus for checking (and optimizing)
structure packing with the "pahole" tool.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--ggvj54df27ylfkyv
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIzoEsACgkQrX5LkNig
012lqAf/Q72TeHYSVq1zAC8Fm7vG5aDOCz8WTJ9RVHMhNIuamFIriPLpRnc6h4OO
yEBb+ysLUmjh2EaUlaQlW+p/7JsKy59tyiCDmberN4pcx5PlGBywSxD+UEZn5JxT
bmCeCWcOKHAsiQ9AhSVlclfPZgX0q0yOEDXu63Nvsdirlpe5JPmEadKOypN3tX85
QmSt1N4LMUN37KV315DSI0QAtuo9476XdtkosOhNMz1KenGQcqCMi1/46c5+Q6Dn
ZHEAOUOgTov+gJ7PmZeA1R4qyq6onDnaAF/bIGJjhs4/0mA8u2NaTZ4bwvcDE5V/
eoCdLwrt/hmhrFmpKwRv9pfaqxRp1Q==
=oHJR
-----END PGP SIGNATURE-----

--ggvj54df27ylfkyv--
