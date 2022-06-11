Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97E1B5474D9
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 15:38:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233129AbiFKNiD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 09:38:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51568 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233682AbiFKNiA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 09:38:00 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 05A75BE7
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 06:37:58 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o01JK-0003pU-1R; Sat, 11 Jun 2022 15:37:54 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E6A6792DBD;
        Sat, 11 Jun 2022 13:36:08 +0000 (UTC)
Date:   Sat, 11 Jun 2022 15:36:08 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220611133608.3zdfb3nnl5445kr7@pengutronix.de>
References: <20220602213544.68273-1-max@enpas.org>
 <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
 <20220611151551.5024f51e.max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="5edtfo4qnqqn26om"
Content-Disposition: inline
In-Reply-To: <20220611151551.5024f51e.max@enpas.org>
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


--5edtfo4qnqqn26om
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.06.2022 15:15:51, Max Staudt wrote:
> @Marc, Wolfgang - one SocketCAN design question about bitrate setting at
> the end. I'd appreciate your opinion on my dummy do_set_bittiming().

[...]

> > > +/* Dummy needed to use bitrate_const */
> > > +static int can327_do_set_bittiming(struct net_device *netdev)
> > > +{
> > > +       return 0;
> > > +} =20
> >=20
> > Is this dummy function really needed? If think that access to
> > can_priv::do_set_bittiming is always garded. Setting it to NULL should
> > be OK. c.f.:
> > https://elixir.bootlin.com/linux/latest/source/drivers/net/can/dev/netl=
ink.c#L198
>=20
> drivers/net/can/dev/netlink.c - can_changelink():
>=20
> 	/* Calculate bittiming parameters based on
> 	 * bittiming_const if set, otherwise pass bitrate
> 	 * directly via do_set_bitrate(). Bail out if neither
> 	 * is given.
> 	 */
> 	if (!priv->bittiming_const && !priv->do_set_bittiming)
> 		return -EOPNOTSUPP;
>=20
> can327 has neither of these two, so I provide a dummy for one.
>=20
> What should I do instead?

What about this change?

diff --git a/drivers/net/can/dev/netlink.c b/drivers/net/can/dev/netlink.c
index 7633d98e3912..667ddd28fcdc 100644
--- a/drivers/net/can/dev/netlink.c
+++ b/drivers/net/can/dev/netlink.c
@@ -176,7 +176,8 @@ static int can_changelink(struct net_device *dev, struc=
t nlattr *tb[],
                 * directly via do_set_bitrate(). Bail out if neither
                 * is given.
                 */
-               if (!priv->bittiming_const && !priv->do_set_bittiming)
+               if (!priv->bittiming_const && !priv->do_set_bittiming &&
+                   !priv->bitrate_const)
                        return -EOPNOTSUPP;
=20
                memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]), sizeof(bt));

If it works I'll make a patch and apply it to net-next/master so that
you can base your series on this.

> While at it, a comment in elm327_init mentioned bittiming_const - that
> was from the pre-bitrate_const (< v4.11) times, and I've now updated it
> to mention bitrate_const instead.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--5edtfo4qnqqn26om
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKkmkUACgkQrX5LkNig
011eDgf7BAiZK/sQ02v4VkaRbtTc7AzHRodPZZJGQMfwJTPwsix2ExBYkUpVwXeZ
QTKUcIK2cVWiojidYmWXeuS7uHu62y9smz2PwjZuUg1etbeRxfG3V/o9am3DOLnv
mHFeaTMxVLij01BW6GI4vVqbvW9m9uyZmF/I3pKZJVNFZ+X2VX2I2knKHyuFV2oD
e59UOlIvSytJ7xEZn9dU4xSRgtMUX9yxBHe//M8Zq6DaRldf8jZ0fzJMzZcdbjg+
Kd04UgB8Yo33P9n4eDz9HEpkdgoJKBkb7Bq+PGw/DXA9vP0YUcCYYS4zevRqKbo0
u+sIue7VyQj54MuSJEo7xkU2ukKWJQ==
=lJBy
-----END PGP SIGNATURE-----

--5edtfo4qnqqn26om--
