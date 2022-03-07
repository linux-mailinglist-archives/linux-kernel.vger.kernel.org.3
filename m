Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9F7684CF3D7
	for <lists+linux-kernel@lfdr.de>; Mon,  7 Mar 2022 09:41:53 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233418AbiCGImo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 7 Mar 2022 03:42:44 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232634AbiCGImm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 7 Mar 2022 03:42:42 -0500
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 998A541F8F
        for <linux-kernel@vger.kernel.org>; Mon,  7 Mar 2022 00:41:48 -0800 (PST)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nR8w4-00023P-OO; Mon, 07 Mar 2022 09:41:44 +0100
Received: from pengutronix.de (2a03-f580-87bc-d400-20c2-7538-e3cb-a3c4.ip6.dokom21.de [IPv6:2a03:f580:87bc:d400:20c2:7538:e3cb:a3c4])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E5F5043E30;
        Mon,  7 Mar 2022 08:41:42 +0000 (UTC)
Date:   Mon, 7 Mar 2022 09:41:42 +0100
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        kernel test robot <yujie.liu@intel.com>
Subject: Re: [PATCH] can: etas_es58x: initialize rx_event_msg before calling
 es58x_check_msg_len()
Message-ID: <20220307084142.orb2s3ip7ozsfffl@pengutronix.de>
References: <20220306101302.708783-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="vt44iibanw7nxqhd"
Content-Disposition: inline
In-Reply-To: <20220306101302.708783-1-mailhol.vincent@wanadoo.fr>
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


--vt44iibanw7nxqhd
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 06.03.2022 19:13:02, Vincent Mailhol wrote:
> Function es58x_fd_rx_event() invokes the es58x_check_msg_len() macro:
> | 	ret =3D es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len);
> While doing so, it deferences an uninitialized variable: *rx_event_msg.
>=20
> This is actually harmless because es58x_check_msg_len() only uses
> preprocessors macro (sizeof() and __stringify()) on
> *rx_event_msg. c.f. [1].
>=20
> Nonetheless, this pattern is confusing so the lines are reordered to
> make sure that rx_event_msg is correctly initialized.
>=20
> This patch also fixes a false positive warning reported by cppcheck:
>=20
> | cppcheck possible warnings: (new ones prefixed by >>, may not be real p=
roblems)
> |
> |     In file included from drivers/net/can/usb/etas_es58x/es58x_fd.c:
> |  >> drivers/net/can/usb/etas_es58x/es58x_fd.c:174:8: warning: Uninitial=
ized variable: rx_event_msg [uninitvar]
> |      ret =3D es58x_check_msg_len(es58x_dev->dev, *rx_event_msg, msg_len=
);
> |            ^
>=20
> [1] https://elixir.bootlin.com/linux/latest/source/drivers/net/can/usb/et=
as_es58x/es58x_core.h#L467
>=20
> Reported-by: kernel test robot <yujie.liu@intel.com>
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Applied to linux-can-next/testing, fixed some typos and removed the
Reported-by tag.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--vt44iibanw7nxqhd
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmIlxUQACgkQrX5LkNig
010FHwf7Bhiann1vepTxEO46Y2qEWDjT99W+AG4Wb+ML/JIwQfSmHWKqISVBiBjR
jA1PPpG4eLEFfCj36MRkaV3mNIzuQ+fO4QI3ReV/793wuV5l19jCdI+MeZViTmPh
D4iFwf/xd3/zseysK73f2v5TmWKwEgOaESYlH2WN0rymKd8pD95bxdXvFaICpLp9
H1s09I9X8fv8J8DMI6NqT9IBTYLN5G0sMS53zWDcmt1LABtpckOgSsGDSpnrGeik
UJI4xkKUqwmdLoc8YRI6OMr/yRZoFWiIvStETZPo5J0115QI5yjdP5eopcA3JykU
GJuQXXEv0dPUQEuUaRKjzH+1Iv1mcA==
=QH64
-----END PGP SIGNATURE-----

--vt44iibanw7nxqhd--
