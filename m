Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7C6C95264FA
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 16:44:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1381243AbiEMOoE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 10:44:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54778 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1382845AbiEMOnS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 10:43:18 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AC9E72127A
        for <linux-kernel@vger.kernel.org>; Fri, 13 May 2022 07:42:34 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1npWUy-00006s-Jy; Fri, 13 May 2022 16:42:32 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id 2CB777DB54;
        Fri, 13 May 2022 14:42:31 +0000 (UTC)
Date:   Fri, 13 May 2022 16:42:30 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     linux-can@vger.kernel.org, linux-kernel@vger.kernel.org,
        Max Staudt <max@enpas.org>
Subject: Re: [PATCH 0/2] can: drop tx skb if the device is in listen only mode
Message-ID: <20220513144230.upuirv4ufebxvfbq@pengutronix.de>
References: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="gqifvyadwdcbjat7"
Content-Disposition: inline
In-Reply-To: <20220513142355.250389-1-mailhol.vincent@wanadoo.fr>
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


--gqifvyadwdcbjat7
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 13.05.2022 23:23:53, Vincent Mailhol wrote:
> In listen only mode, tx CAN frames can still reach the driver if
> injected via the packet socket. This series add a check toward
> CAN_CTRLMODE_LISTENONLY in can_dropped_invalid_skb() to discard such
> skb. The first patch does some preparation work and migrates
> can_dropped_invalid_skb() from skb.h to dev.h. The second and last
> patch is the actual change.

Thanks for your quick patch!

What about moving the function to a .c file? The
can_dropped_invalid_skb() grew a lot over the years, since it was added
to the header as a static inline function.

Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--gqifvyadwdcbjat7
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmJ+blQACgkQrX5LkNig
012Bigf+OBMnCULTQxKU9B8Mkb6CCPhadQ7XNbJ+RbQVPcOSTdDHr1dK3PslcrGE
dBtCKgNBXwKAPNyv6Xkv7WgcDcXXlHbik92UexT3q3dm8By1DtymBQ3SoK+jZ6Aa
CANx8blpS7Pv+GFqS3gl4F/1s9/Uoq6k5oLEhp/ZCbfSuJD9VaQxgMzDFWWU0SRC
eWoB790kCRAS7SqPUyfuPM1NCrvCSMKVoU0slhCiz2GS78sTWzxVJ4x05K5GqUTt
yd0+zimmi/LFZ75ou2UqWtzbXtxav/35+N3lOotJMLCDkddyYHd15dOB0T2qULPk
rCDvBHYOsHzQqXHssnoBmkFoYC55pQ==
=PMY2
-----END PGP SIGNATURE-----

--gqifvyadwdcbjat7--
