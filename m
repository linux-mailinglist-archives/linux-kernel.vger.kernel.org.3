Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6ACD5577F10
	for <lists+linux-kernel@lfdr.de>; Mon, 18 Jul 2022 11:53:57 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiGRJxx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 18 Jul 2022 05:53:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44064 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234316AbiGRJxv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 18 Jul 2022 05:53:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0C41BD94;
        Mon, 18 Jul 2022 02:53:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lmcjg6JpWz4xQt;
        Mon, 18 Jul 2022 19:53:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658138024;
        bh=sEBU+YVJDngFZCMwdXHtPnov93faAmqDyFwiYTVRLRE=;
        h=Date:From:To:Cc:Subject:From;
        b=rRlN0K14GUP5fkIZadeeiTrQiaXwinzLkOeyDL75UC/FbJTFvDFI7ohuyMqJP5j5g
         5uVp5qFpGIuQmG+0NtxAXgrE+o+I7+br8bFm8V84amaSXaCtajA9yBYJQv25FzyMye
         9OypfMa0hBNSx38BZJw+zc24iXc3Tyq+5TlDSyq2jtYLl7ePHV2kmiWd3TrcDke7vo
         hrXiiprw50GRi/Mo66/DdwFBAtjdjVtdZEOlbeqlgOiTMm/WUztp3xD0xUIY+DUwwT
         1DrON4MRp7ZAhxgFTrSf3ebL7HbLRd7e+qsvvDBHCWqrTnJA/yq9X1tSsa34czWYgF
         CLe3lEAFc/RMQ==
Date:   Mon, 18 Jul 2022 19:53:42 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Herbert Xu <herbert@gondor.apana.org.au>
Cc:     Linux Crypto List <linux-crypto@vger.kernel.org>,
        Eric Biggers <ebiggers@google.com>,
        "Liam R. Howlett" <Liam.Howlett@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: linux-next: manual merge of the mm tree with the crypto tree
Message-ID: <20220718195342.6817be63@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3dIelKPkHS5xUiwgZD92y.y";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3dIelKPkHS5xUiwgZD92y.y
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  lib/Makefile

between commit:

  463f74089ff9 ("crypto: lib - move lib/sha1.c into lib/crypto/")

from the crypto tree and commit:

  058c2f0f755f ("Maple Tree: add new data structure")

from the mm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc lib/Makefile
index 17e48da223e2,dd5cf8f36eaa..000000000000
--- a/lib/Makefile
+++ b/lib/Makefile
@@@ -29,7 -29,8 +29,7 @@@ endi
 =20
  lib-y :=3D ctype.o string.o vsprintf.o cmdline.o \
  	 rbtree.o radix-tree.o timerqueue.o xarray.o \
- 	 idr.o extable.o irq_regs.o argv_split.o \
 -	 maple_tree.o idr.o extable.o \
 -	 sha1.o irq_regs.o argv_split.o \
++	 maple_tree.o idr.o extable.o irq_regs.o argv_split.o \
  	 flex_proportions.o ratelimit.o show_mem.o \
  	 is_single_threaded.o plist.o decompress.o kobject_uevent.o \
  	 earlycpio.o seq_buf.o siphash.o dec_and_lock.o \

--Sig_/3dIelKPkHS5xUiwgZD92y.y
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLVLaYACgkQAVBC80lX
0Gy0wggAl3wAxCAwQaRF54Vp+HXtz1qFXyo6zGw2hSZJGFcYwZTpmIwD3HDKtgk9
/EO5/Z36eDC2fvgmeGdtiymrrSESuLNlSvnCV3jDiPr+Z3FjuIMMiUBvE4DSgSp9
gDcWY0j0YiJnLMW8r4eBF3AVA4XdMf9tTJBeO8mSJPioZjtdJhx08RWwxaUKuNhT
YDXseJl/QqLD+Don3+iCbfj0W7FbjfdaWt+M1jVWWdgyvgLcvy+9IByBsyx87llH
AGi5YF84C38Ay4kw/icv67YghOfP/XSU1c9Pkc6DdONVdLYZdNVB+4uh8bNfDdRe
wlbBY8PVzaYMcdopSCfmGYAzjTremw==
=zees
-----END PGP SIGNATURE-----

--Sig_/3dIelKPkHS5xUiwgZD92y.y--
