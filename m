Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 72113547597
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 16:21:10 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234987AbiFKOVE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 10:21:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56336 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230379AbiFKOVB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 10:21:01 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4903226C0
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 07:21:01 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1o01yy-0002Mo-Ig; Sat, 11 Jun 2022 16:20:56 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 4CD9792E59;
        Sat, 11 Jun 2022 14:20:55 +0000 (UTC)
Date:   Sat, 11 Jun 2022 16:20:54 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Max Staudt <max@enpas.org>
Cc:     Vincent Mailhol <vincent.mailhol@gmail.com>,
        Wolfgang Grandegger <wg@grandegger.com>,
        linux-can@vger.kernel.org,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Oliver Neukum <oneukum@suse.com>, linux-kernel@vger.kernel.org
Subject: Re: [PATCH v7] can, tty: can327 CAN/ldisc driver for ELM327 based
 OBD-II adapters
Message-ID: <20220611142054.qdn6if6tpw4j3ztq@pengutronix.de>
References: <20220602213544.68273-1-max@enpas.org>
 <CAMZ6RqLLn3tE6kPd+yyHURsbBU_jVKN=u4=YvhZVyAf_NyRqCQ@mail.gmail.com>
 <20220611151551.5024f51e.max@enpas.org>
 <20220611133608.3zdfb3nnl5445kr7@pengutronix.de>
 <20220611161713.5303549d.max@enpas.org>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="p6gkmby2djvklmw2"
Content-Disposition: inline
In-Reply-To: <20220611161713.5303549d.max@enpas.org>
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


--p6gkmby2djvklmw2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 11.06.2022 16:17:13, Max Staudt wrote:
> On Sat, 11 Jun 2022 15:36:08 +0200
> Marc Kleine-Budde <mkl@pengutronix.de> wrote:
>=20
> > What about this change?
> >=20
> > diff --git a/drivers/net/can/dev/netlink.c
> > b/drivers/net/can/dev/netlink.c index 7633d98e3912..667ddd28fcdc
> > 100644 --- a/drivers/net/can/dev/netlink.c
> > +++ b/drivers/net/can/dev/netlink.c
> > @@ -176,7 +176,8 @@ static int can_changelink(struct net_device *dev,
> > struct nlattr *tb[],
> >                  * directly via do_set_bitrate(). Bail out if neither
> >                  * is given.
> >                  */
> > -               if (!priv->bittiming_const && !priv->do_set_bittiming)
> > +               if (!priv->bittiming_const && !priv->do_set_bittiming
> > &&
> > +                   !priv->bitrate_const)
> >                         return -EOPNOTSUPP;
> > =20
> >                 memcpy(&bt, nla_data(data[IFLA_CAN_BITTIMING]),
> > sizeof(bt));
> >=20
> > If it works I'll make a patch and apply it to net-next/master so that
> > you can base your series on this.
>=20
> Yes, it seems to work fine, since the dummy function is empty, and it's
> only ever used in this same function, and the pointer is guarded as
> Vincent mentioned. So if a no-op do_set_bittiming() is okay, then not
> having it at all is also okay.

Having a no-op do_set_bittiming() just to make can_changelink() happy is
not intended. :D

> Yes, I'd appreciate you patching this, and I'll rebase upon it :)

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--p6gkmby2djvklmw2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKkpMQACgkQrX5LkNig
0138AAgAss00uGJ7iR7grrxcSEMAzajBxZeFb4iM2ce4gEtDmUbJzciFHekhgq3f
PV/0Pm5+sxKXli1SiD9YWhqZqmxXMV3L7VbafPMh1bw64mPaoLdqm4C3smlNraPd
EmOZ5K0jKrfkxKkuCu9GU0aY4RKY1TAPHWgP5RMAlwuFXMcHtP2mh7R8paGpnaRP
pgIMZ+oi+MKI6yLq4jyPskQYOxMlUEZYfavbvwKp0kehQre3DlVHNN2OEPlqz4EM
XSfGoIlwmHorYwMA4ZKZ7fc3jw3/ojHTd/uYuqwFgkfSVsiLl+p94D1b3HYkZ98+
g0rpnBcmDlWtFlyytKvChGYZ8NDyjw==
=PnUB
-----END PGP SIGNATURE-----

--p6gkmby2djvklmw2--
