Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 54FC556B145
	for <lists+linux-kernel@lfdr.de>; Fri,  8 Jul 2022 06:13:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237001AbiGHEM6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 8 Jul 2022 00:12:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52840 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230230AbiGHEM4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 8 Jul 2022 00:12:56 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9D0CA74DF1;
        Thu,  7 Jul 2022 21:12:53 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LfKcx21kSz4xRC;
        Fri,  8 Jul 2022 14:12:49 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657253571;
        bh=fX2Jian+dbqZD4Xi7DB/wdjnbqHwKsZxYbiT10AEIp0=;
        h=Date:From:To:Cc:Subject:From;
        b=XyQI7NLOVt6P+WYM5Pakkd8XUv3Pl12Fj7AdKcheTa6RIgvvfSqdTjn5dOVScwJxm
         Ct58BDA0CyJFzcV6KW5qxGfl6ytCsSRVS4NUJYFE0kV8CfNF8xJLAzZrEu0IvCbvZf
         0i5YQq82XwZ4LZhN7ICKD+2/VAptH9e3izfWsnN4nJZbln0k8rp2I5dF7XFR+RFx3n
         ZSJSXZeI4KBmyDlmLdrxblQz15gxY4SZhqrwcG45gqwOEP238yBQOpDnIMCDNk6gt3
         Uf2SCmHvcbF6CbpGXhddUgAPxmNWH83Eh4aw+oLIL/m3hgHg4kdQfh9ahh5OtSPNXy
         kt7ce8TEUPcxQ==
Date:   Fri, 8 Jul 2022 14:12:46 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     "Paul E. McKenney" <paulmck@kernel.org>
Cc:     Frederic Weisbecker <frederic@kernel.org>,
        Huacai Chen <chenhuacai@kernel.org>,
        Huacai Chen <chenhuacai@loongson.cn>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>
Subject: linux-next: manual merge of the rcu tree with Linus' tree
Message-ID: <20220708141246.43111241@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/MrJwq6tgl.9IFjTw3EWcIVo";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/MrJwq6tgl.9IFjTw3EWcIVo
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the rcu tree got a conflict in:

  arch/loongarch/Kconfig

between commit:

  7fd6ef61a5d6 ("LoongArch: Drop these obsolete selects in Kconfig")

from Linus' tree and commit:

  24a9c54182b3 ("context_tracking: Split user tracking Kconfig")

from the rcu tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/loongarch/Kconfig
index 53a912befb62,130dc65f3c85..000000000000
--- a/arch/loongarch/Kconfig
+++ b/arch/loongarch/Kconfig
@@@ -75,7 -76,8 +75,7 @@@ config LOONGARC
  	select HAVE_ARCH_TRACEHOOK
  	select HAVE_ARCH_TRANSPARENT_HUGEPAGE
  	select HAVE_ASM_MODVERSIONS
- 	select HAVE_CONTEXT_TRACKING
+ 	select HAVE_CONTEXT_TRACKING_USER
 -	select HAVE_COPY_THREAD_TLS
  	select HAVE_DEBUG_STACKOVERFLOW
  	select HAVE_DMA_CONTIGUOUS
  	select HAVE_EXIT_THREAD

--Sig_/MrJwq6tgl.9IFjTw3EWcIVo
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLHrr4ACgkQAVBC80lX
0Gw24Af/TcuFP3cBucEwyeVefWX2brhTs1Ig8v/3XRcTrFftPwFswVyXjMLl24a0
hHjwwK+3WDKfwsRhqfHwVMcLgq4XGizFvPmK6inLMO20ddoCD5mOvpS78wTKPGkw
X0+Nkb+E6SP403QmxLYJeKQ2GTa9/iqBOvg/cAPCEiW/VGlIn+h94yMY/Zs5TJo5
VMvWsQ61b9sZPdy5mrDXKs8p+AeC+8JAPUvhxUGX0dtFN4P8NKPp67ydVaavnaYA
LqgyVXb4hSPBt8//7Hkd/IT3F3QPvCg7meup75i7MyZRdi56ojwy5iOiZehuKTXR
PgKGhaTsDxzP4R6OsQI+jSmY7ZMtFg==
=qjwJ
-----END PGP SIGNATURE-----

--Sig_/MrJwq6tgl.9IFjTw3EWcIVo--
