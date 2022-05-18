Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D50D52B953
	for <lists+linux-kernel@lfdr.de>; Wed, 18 May 2022 14:13:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235964AbiERL6h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 18 May 2022 07:58:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235953AbiERL6e (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 18 May 2022 07:58:34 -0400
Received: from metis.ext.pengutronix.de (metis.ext.pengutronix.de [IPv6:2001:67c:670:201:290:27ff:fe1d:cc33])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D6684A3D9
        for <linux-kernel@vger.kernel.org>; Wed, 18 May 2022 04:58:32 -0700 (PDT)
Received: from gallifrey.ext.pengutronix.de ([2001:67c:670:201:5054:ff:fe8d:eefb] helo=bjornoya.blackshift.org)
        by metis.ext.pengutronix.de with esmtps (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <mkl@pengutronix.de>)
        id 1nrIJr-0001Di-BI; Wed, 18 May 2022 13:58:23 +0200
Received: from pengutronix.de (unknown [IPv6:2a01:4f8:1c1c:29e9:22:41ff:fe00:1400])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (Client did not present a certificate)
        (Authenticated sender: mkl-all@blackshift.org)
        by smtp.blackshift.org (Postfix) with ESMTPSA id E451F8134B;
        Wed, 18 May 2022 11:58:20 +0000 (UTC)
Date:   Wed, 18 May 2022 13:58:20 +0200
From:   Marc Kleine-Budde <mkl@pengutronix.de>
To:     Vincent Mailhol <mailhol.vincent@wanadoo.fr>
Cc:     kernel test robot <lkp@intel.com>, llvm@lists.linux.dev,
        kbuild-all@lists.01.org, linux-kernel@vger.kernel.org,
        linux-can@vger.kernel.org
Subject: Re: [PATCH] can: mcp251xfd: silence clang's -Wunaligned-access
 warning
Message-ID: <20220518115820.qzvyrnwsb4wvayq2@pengutronix.de>
References: <20220518070517.q53bjzo6lbnq3f2i@pengutronix.de>
 <20220518114357.55452-1-mailhol.vincent@wanadoo.fr>
MIME-Version: 1.0
Content-Type: multipart/signed; micalg=pgp-sha512;
        protocol="application/pgp-signature"; boundary="57rj3wezavrbut5g"
Content-Disposition: inline
In-Reply-To: <20220518114357.55452-1-mailhol.vincent@wanadoo.fr>
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


--57rj3wezavrbut5g
Content-Type: text/plain; charset=utf-8
Content-Disposition: inline
Content-Transfer-Encoding: quoted-printable

On 18.05.2022 20:43:57, Vincent Mailhol wrote:
> clang emits a -Wunaligned-access warning on union
> mcp251xfd_tx_ojb_load_buf.
>=20
> The reason is that field hw_tx_obj (not declared as packed) is being
> packed right after a 16 bits field inside a packed struct:
>=20
> | union mcp251xfd_tx_obj_load_buf {
> | 	struct __packed {
> | 		struct mcp251xfd_buf_cmd cmd;
> | 		  /* ^ 16 bits fields */
> | 		struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
> | 		  /* ^ not declared as packed */
> | 	} nocrc;
> | 	struct __packed {
> | 		struct mcp251xfd_buf_cmd_crc cmd;
> | 		struct mcp251xfd_hw_tx_obj_raw hw_tx_obj;
> | 		__be16 crc;
> | 	} crc;
> | } ____cacheline_aligned;
>=20
> Starting from LLVM 14, having an unpacked struct nested in a packed
> struct triggers a warning. c.f. [1].
>=20
> This is a false positive because the field is always being accessed
> with the relevant put_unaligned_*() function. Adding __packed to the
> structure declaration silences the warning.
>=20
> [1] https://github.com/llvm/llvm-project/issues/55520
>=20
> Signed-off-by: Vincent Mailhol <mailhol.vincent@wanadoo.fr>

Thank! Applies to linux-can-next/testing.

regards,
Marc

--=20
Pengutronix e.K.                 | Marc Kleine-Budde           |
Embedded Linux                   | https://www.pengutronix.de  |
Vertretung West/Dortmund         | Phone: +49-231-2826-924     |
Amtsgericht Hildesheim, HRA 2686 | Fax:   +49-5121-206917-5555 |

--57rj3wezavrbut5g
Content-Type: application/pgp-signature; name="signature.asc"

-----BEGIN PGP SIGNATURE-----

iQEzBAABCgAdFiEEBsvAIBsPu6mG7thcrX5LkNig010FAmKE31kACgkQrX5LkNig
011t0ggAq8G16P8sCd0leKEHsfIg71a0qsHV2KuL4mFSOedd48EPrhnA0jsvaIF8
byxhVqb5H/VjWWQ6y4x3e0AGfj3h/3c7PZJL/P6K77Hq2frEkepTGtzLd7Lp/UWC
uXy2m+tC3C8Emd8z2mLw0sH6bdgkZ4vtQjEPy1oHWTxPcSp1LRnAwXt8iS+ReVhA
pp8J8k3ctN8KJdfisVRScLINFYa5dGDpbrFjLQCDkan+S1TubuqwgvIghP5V6Stb
ilB9OFEcDh8BSqiId9YhQsocIf3z6akzTfZWBA6Vd9vxl/1VkNbm09A9u0onIfBv
mQlJi8sA48p9WMrNmj9E6Ech2dnnVA==
=lBes
-----END PGP SIGNATURE-----

--57rj3wezavrbut5g--
