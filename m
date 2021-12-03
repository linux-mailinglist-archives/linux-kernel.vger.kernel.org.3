Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5D4AA4679E9
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 16:01:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381646AbhLCPFR (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 10:05:17 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:32790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232199AbhLCPFQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 10:05:16 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32791C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 07:01:52 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1mtA4C-0002TT-Ua; Fri, 03 Dec 2021 16:01:41 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-4c70-bd43-38a4-642e.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:4c70:bd43:38a4:642e])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 355F36BBBA2;
        Fri,  3 Dec 2021 15:01:38 +0000 (UTC)
Date:   Fri, 3 Dec 2021 16:01:37 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Dan Carpenter <dan.carpenter@oracle.com>
Cc:     kbuild@lists.01.org,
        Stephane Grosjean <s.grosjean@peak-system.com>, lkp@intel.com,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: drivers/net/can/usb/peak_usb/pcan_usb.c:523
 pcan_usb_decode_error() error: we previously assumed 'cf' could be null (see
 line 503)
Message-ID: <20211203150137.xaelavizpjm7v5ir@pengutronix.de>
References: <202112021833.wABxM5UN-lkp@intel.com>
 <20211203145851.nrgmnu7c56w4vecy@pengutronix.de>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="eaqoalpqzs7tr7z2"
Content-Disposition: inline
In-Reply-To: <20211203145851.nrgmnu7c56w4vecy@pengutronix.de>
X-SA-Exim-Connect-IP: 2001:67c:670:201:5054:ff:fe8d:eefb
X-SA-Exim-Mail-From: mkl@pengutronix.de
X-SA-Exim-Scanned: No (on metis.ext.pengutronix.de); SAEximRunCond expanded to false
X-PTX-Original-Recipient: linux-kernel@vger.kernel.org
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org


--eaqoalpqzs7tr7z2
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 03.12.2021 15:58:52, Marc Kleine-Budde wrote:
> On 03.12.2021 17:09:55, Dan Carpenter wrote:
> > tree:   https://git.kernel.org/pub/scm/linux/kernel/git/torvalds/linux.=
git master
> > head:   58e1100fdc5990b0cc0d4beaf2562a92e621ac7d
> > commit: c11dcee758302702a83c6e85e4c4c3d9af42d2b3 can: peak_usb: pcan_us=
b_decode_error(): upgrade handling of bus state changes
> > config: x86_64-randconfig-m001-20211202 (https://download.01.org/0day-c=
i/archive/20211202/202112021833.wABxM5UN-lkp@intel.com/config)
> > compiler: gcc-9 (Debian 9.3.0-22) 9.3.0
> >=20
> > If you fix the issue, kindly add following tag as appropriate
> > Reported-by: kernel test robot <lkp@intel.com>
> > Reported-by: Dan Carpenter <dan.carpenter@oracle.com>
> >=20
> > smatch warnings:
> > drivers/net/can/usb/peak_usb/pcan_usb.c:523 pcan_usb_decode_error() err=
or: we previously assumed 'cf' could be null (see line 503)
> >=20
> > vim +/cf +523 drivers/net/can/usb/peak_usb/pcan_usb.c
> >=20
> > 46be265d338833 Stephane Grosjean 2012-03-02  450  static int pcan_usb_d=
ecode_error(struct pcan_usb_msg_context *mc, u8 n,
> > 46be265d338833 Stephane Grosjean 2012-03-02  451  				 u8 status_len)
> > 46be265d338833 Stephane Grosjean 2012-03-02  452  {
> > 46be265d338833 Stephane Grosjean 2012-03-02  453  	struct sk_buff *skb;
> > 46be265d338833 Stephane Grosjean 2012-03-02  454  	struct can_frame *cf;
> > c11dcee7583027 Stephane Grosjean 2021-07-15  455  	enum can_state new_s=
tate =3D CAN_STATE_ERROR_ACTIVE;
> > 46be265d338833 Stephane Grosjean 2012-03-02  456 =20
> > 46be265d338833 Stephane Grosjean 2012-03-02  457  	/* ignore this error=
 until 1st ts received */
> > 46be265d338833 Stephane Grosjean 2012-03-02  458  	if (n =3D=3D PCAN_US=
B_ERROR_QOVR)
> > 46be265d338833 Stephane Grosjean 2012-03-02  459  		if (!mc->pdev->time=
_ref.tick_count)
> > 46be265d338833 Stephane Grosjean 2012-03-02  460  			return 0;
> > 46be265d338833 Stephane Grosjean 2012-03-02  461 =20
> > c11dcee7583027 Stephane Grosjean 2021-07-15  462  	/* allocate an skb t=
o store the error frame */
> > c11dcee7583027 Stephane Grosjean 2021-07-15  463  	skb =3D alloc_can_er=
r_skb(mc->netdev, &cf);
>=20
> alloc_can_err_skb() ->
> alloc_canfd_skb()

Doh! It calls alloc_can_skb()

https://elixir.bootlin.com/linux/v5.15/source/drivers/net/can/dev/skb.c#L180

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--eaqoalpqzs7tr7z2
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEK3kIWJt9yTYMP3ehqclaivrt76kFAmGqMU4ACgkQqclaivrt
76m4Hgf/QGQcpnkuAvX73JirejUw2l9aH3v/wn+oR5uPijQUr+ScCf9i/0kuw3Iu
D5vLtTfUNqW+xJxo+AeWrdtTYMLD1KdN4I5VkmgsnO4sq45yvKRIB3fjQaeOfMY7
S9AJ/ry/HTddebS54Dh8iJlYhw880Qy4NaTYQ1LYKRry+RIx2Vge1Zlh7LAkiZTk
LjxSlu3PO7NkiUr5LpAPPhlxj1ZHBXyv20i1figZ5oJ62jCRcx4lZSYWxOAjpF7Y
msYFYJWiW9XuY9CWamRAsj3evyqsp69WyI4X+qrKpw6QLJ7cUCteCydYk5KEWaRi
ZJRLorFfBHwF6lCnng+VuLWval3DTA==
=2OpR
-----END PGP SIGNATURE-----

--eaqoalpqzs7tr7z2--
