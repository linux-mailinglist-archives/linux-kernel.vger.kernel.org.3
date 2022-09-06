Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D8815ADCE4
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 03:30:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232444AbiIFBaU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 5 Sep 2022 21:30:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35128 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229619AbiIFBaS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 5 Sep 2022 21:30:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B6B8D4C601;
        Mon,  5 Sep 2022 18:30:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MM79f11SGz4xG6;
        Tue,  6 Sep 2022 11:30:14 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662427814;
        bh=OGm8FbMx/rVmQR6RSZSoIPcAE0Xg1UA0h2SDNoahiOI=;
        h=Date:From:To:Cc:Subject:From;
        b=RL5qxQa11wjwhrCNFJUGlJKE2c7bWLSD8VViQ+HhKled+DafuXXAD3RczEwb1YAsT
         Vq31JJ4N12n2ab6sAT4gtMANrUV4Vg6B0Q5Fa5skocGOasujghD5zYEa0KJl7bp43c
         Eb4TmGjdM0wVyK01kbmpAykjLmSCFM1zYm8pA4s5jmw5D2h5GInHncxfU5G+DjjcEM
         2dZ7BkJBdvTrhEYFR1dJzzflWexGAkiTD/krLOWF1nwUpP2M+TBDYfWvv56vgxBNh4
         jQurUG91nQbWbzsK2Z+m2hVEzmFaqyiw2Wa5ukPPfhC85ugdYXWLXjuKMkurv5E8p5
         tbAifAppBcHsg==
Date:   Tue, 6 Sep 2022 11:30:12 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Herbert Xu <herbert@gondor.apana.org.au>,
        Linux Crypto List <linux-crypto@vger.kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the crypto tree
Message-ID: <20220906113012.447fc7f4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BLImpwYhLV.gavsNcajwkZg";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BLImpwYhLV.gavsNcajwkZg
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the crypto tree, today's linux-next build (x86_64
allmodconfig) failed like this:

ERROR: modpost: "aspeed_register_hace_hash_algs" [drivers/crypto/aspeed/asp=
eed_crypto.ko] undefined!
ERROR: modpost: "aspeed_unregister_hace_crypto_algs" [drivers/crypto/aspeed=
/aspeed_crypto.ko] undefined!
ERROR: modpost: "aspeed_register_hace_crypto_algs" [drivers/crypto/aspeed/a=
speed_crypto.ko] undefined!
ERROR: modpost: "aspeed_unregister_hace_hash_algs" [drivers/crypto/aspeed/a=
speed_crypto.ko] undefined!

Exposed by commit

  31b39755e325 ("crypto: aspeed - Enable compile testing")

I have used the crypto tree from next-20220901 for today.

--=20
Cheers,
Stephen Rothwell

--Sig_/BLImpwYhLV.gavsNcajwkZg
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMWoqQACgkQAVBC80lX
0GwLVwf8CZG3HaGdmOv9YClgzsgMYuu2mOR8dPePl/zLiGl2AKs5KMmvniLhqe9g
CEmXzl2LuyuqUwoFGZTsIFd927f/iAP0m7ff25Zm1YeBkpO0gGiofeu4fDo2ayo5
cilKi3FO49r8abZjC9NAVFLQ6vBqblAY9R4kP36R2MFNPUON08FReKvR+Eh2Z6NK
BTdStOFIwP/gDtxM7eTll7lJccdOeqMaAmOHYW4oTkX4WuCM82tv/JShZMDIEjIo
ec46MVsEVPxbHneTfkba2GRIA3gLBHQXMLQwHgpHuqGmqzgvgXbp/9SciKrtgFD+
DDlUnFGzicDazOYXyYrTNpD5jaKR6Q==
=JXHU
-----END PGP SIGNATURE-----

--Sig_/BLImpwYhLV.gavsNcajwkZg--
