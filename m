Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 406C84CA592
	for <lists+linux-kernel@lfdr.de>; Wed,  2 Mar 2022 14:04:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242098AbiCBNF0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 2 Mar 2022 08:05:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40502 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242088AbiCBNFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 2 Mar 2022 08:05:21 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7D68FC4289
        for <linux-kernel@vger.kernel.org>; Wed,  2 Mar 2022 05:04:31 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nPOeY-0004N5-BG; Wed, 02 Mar 2022 14:04:26 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-5c51-3418-45e9-21d0.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:5c51:3418:45e9:21d0])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 5F06B40CC0;
        Wed,  2 Mar 2022 13:04:23 +0000 (UTC)
Date:   Wed, 2 Mar 2022 14:04:23 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent MAILHOL <mailhol.vincent@wanadoo.fr>
Cc:     kernel test robot <yujie.liu@intel.com>, kbuild-all@lists.01.org,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Arunachalam Santhanam <Arunachalam.Santhanam@in.bosch.com>,
        linux-can <linux-can@vger.kernel.org>
Subject: Re: drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning:
 Uninitialized variable: rx_event_msg [uninitvar]
Message-ID: <20220302130423.ddd2ulldffpo5lb2@pengutronix.de>
References: <202203021333.mMJpWPzx-lkp@intel.com>
 <5f13b914-e309-49ee-4f98-c81780c478b9@intel.com>
 <20220302103219.kvpfhc6qz42t3pvv@pengutronix.de>
 <CAMZ6Rq+HR=j2mD97etTgSapOix96P=pK70bTr9HeJu2Mjkn3+g@mail.gmail.com>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="56xh6vvo7owhvdci"
Content-Disposition: inline
In-Reply-To: <CAMZ6Rq+HR=j2mD97etTgSapOix96P=pK70bTr9HeJu2Mjkn3+g@mail.gmail.com>
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


--56xh6vvo7owhvdci
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 02.03.2022 21:49:27, Vincent MAILHOL wrote:
> > I think it's possible to assign rx_event_msg before the
> > es58x_check_msg_len().
>=20
> Yes, I will do so. Even if this is a false positive, this pattern
> can be misleading. e.g. during a code review, this does indeed
> look incorrect at first glance.
>=20
> Also, doing such change would be consistent with was is done in
> other functions:
> https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/etas_e=
s58x/es58x_fd.c#L210
>=20
> This not being a bug fix, is it fine to send it to net-next?

ACK

> Or do you see a need to backport this?

Don't think so.

> > I think (hope?) the compiler will not optimize
> > anything away. :)
>=20
> With a function call and a return statement, the compiler would
> need to be severely defective to try to optimize this away :)

I was thinking of this:

| void *foo =3D bar->baz;
|=20
| if (!bar)
|         return;
|=20
| printf("%p", foo);

There were/are compilers that optimize the bar NULL pointer check away,
because bar has already been de-referenced.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--56xh6vvo7owhvdci
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIfa1QACgkQrX5LkNig
0123Qgf/RpK66S6/00nnYIK17FjG95rGgcEjTFYWj2ir4Ovuaw3GujZW1y0abN82
TnG3X6EFnNHYVbf3U7KGYku+YJ/OvD5wsNY9/Cuvl1fK+ttCb89nO4CxeEmFarI9
xErdeT656hGzVi3saAQEHSaE/JHedk2F61P8ncwm63z5U9r9nKN63bwqi/2S2j+s
cJbv3LXbmUR473wZVgyZBXEC3JDM9KJ+PHo1g6RskySTtC6l1dx5La0gs8v72kqi
X74fvgcJBXkCR/xppPhl1Iu7EwHt1xdZUI9YnPdeCF0EBa2ODK4jRGBJPolpj00i
IadoT7WOi5iyhJmh1oNvZ1t4aWrbqQ==
=wr6A
-----END PGP SIGNATURE-----

--56xh6vvo7owhvdci--
