Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EF1E052E575
	for <lists+linux-kernel@lfdr.de>; Fri, 20 May 2022 08:57:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346109AbiETG5K (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 20 May 2022 02:57:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55442 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235886AbiETG5F (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 20 May 2022 02:57:05 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 45C5566AEA;
        Thu, 19 May 2022 23:57:04 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L4Hb23dQhz4xD9;
        Fri, 20 May 2022 16:57:02 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653029822;
        bh=3qcC0zxa4JNcBZM2KoM0PUrp8oT7ymNUmD1Kh8x2BLE=;
        h=Date:From:To:Cc:Subject:From;
        b=mF5G2mI9LN/6goV1xEUdlwdttZuZYp7qiCAR5xLBbEVqryX0rm3YGAmOk33Pt1E8M
         VANVjdea+1WsIU6hDoc1Xsj/0eoYM2/e78Zh3YLLungYPf9PXy36XaSHKQKLn/t5f3
         8sb7xnaSkTXhVpv+oEQmIq+RtM5aMWivrQE/ttYxv2IaGhBit4cQizElTpkwEtZDz4
         jmRtDcw5Oe8o0xulE4UB5VOxacJOGj9NKoij8bjqmuTJCsHfyy2VBJ15GJB0Bg8Zwz
         zHXzi9ac8mcYl+vB2jffIH/c0WQHm10OLmFCwrSpgv7d+jddQ98Uz8RhCj/zUA+cUk
         n6D78eZmZAcBQ==
Date:   Fri, 20 May 2022 16:57:01 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jarkko Sakkinen <jarkko@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Ahmad Fatoum <a.fatoum@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Meenakshi Aggarwal <meenakshi.aggarwal@nxp.com>,
        Steffen Trumtrar <s.trumtrar@pengutronix.de>
Subject: linux-next: manual merge of the tpmdd tree with the crypto tree
Message-ID: <20220520165701.14224ddb@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/s55XKUIBqpxB_cDnrpn6i.n";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/s55XKUIBqpxB_cDnrpn6i.n
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the tpmdd tree got a conflict in:

  drivers/crypto/caam/Kconfig

between commit:

  0aa6ac7795ca ("crypto: caam/rng - Add support for PRNG")

from the crypto tree and commit:

  5e785783ddb0 ("crypto: caam - add in-kernel interface for blob generator")

from the tpmdd tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/crypto/caam/Kconfig
index 0aa52b612a01,ea9f8b1ae981..000000000000
--- a/drivers/crypto/caam/Kconfig
+++ b/drivers/crypto/caam/Kconfig
@@@ -151,14 -151,9 +151,17 @@@ config CRYPTO_DEV_FSL_CAAM_RNG_AP
  	  Selecting this will register the SEC4 hardware rng to
  	  the hw_random API for supplying the kernel entropy pool.
 =20
 +config CRYPTO_DEV_FSL_CAAM_PRNG_API
 +	bool "Register Pseudo random number generation implementation with Crypt=
o API"
 +	default y
 +	select CRYPTO_RNG
 +	help
 +	  Selecting this will register the SEC hardware prng to
 +	  the Crypto API.
 +
+ config CRYPTO_DEV_FSL_CAAM_BLOB_GEN
+ 	bool
+=20
  endif # CRYPTO_DEV_FSL_CAAM_JR
 =20
  endif # CRYPTO_DEV_FSL_CAAM

--Sig_/s55XKUIBqpxB_cDnrpn6i.n
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKHO70ACgkQAVBC80lX
0GzSxgf6Ariy3P688k9jklxHAKIMrNYfg3624IP+CH6Hfiw4iZmdZpTmDVL/L8b8
M4XcFAfmXDDhuh6CT7lqTGSFquYKGiMFea0TIElNGj1xHORTbGX8X2dyjvfVV/PZ
lg74e6QBcYDjLhEFX4mNpM+3htDr629uUqC+dJe/uzY32gUFWwuYvFDlLX48VjpS
3H9ENxxZ/ma+/Q6SNwTj4Xlh4teeahEqNB/lcT2qGYhk86Vp0oAK5OUnL9dOd+B4
qoTZ7SmF8mVaXfsY/nyMceoMP6XUwAex8FoOiHghhNi+YE5cFz0s+VvQlWxY9BzA
KBlyBZUrBs5rDOkoioCYauTZvvlKSg==
=j1fH
-----END PGP SIGNATURE-----

--Sig_/s55XKUIBqpxB_cDnrpn6i.n--
