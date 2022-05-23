Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4D55307AD
	for <lists+linux-kernel@lfdr.de>; Mon, 23 May 2022 04:28:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352816AbiEWC2d (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 22 May 2022 22:28:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229554AbiEWC2b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 22 May 2022 22:28:31 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B9F4B37030;
        Sun, 22 May 2022 19:28:30 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L61Tm2BQkz4xD2;
        Mon, 23 May 2022 12:28:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653272909;
        bh=CW/KNHVRv9y2Qf0e43HwBMCQQe/fCfZUXivm71q6uC0=;
        h=Date:From:To:Cc:Subject:From;
        b=AEWXhbajj3Gjzds7bYgqOx4BpwL3W2VP6m8BEtoaoCwoF+ADRz7YQ9zTIPjXMkm+a
         9iQ9/+HH1cuHe9Izcsv9yo7O5A1PruFcHvCkC1BLDNwh5eY2sEc/RrLv9VbiACEpYh
         KKQVritvEa6Xw0yQtcbvrMvANn1wDALvoFqcif128IRWYmBMIUPeRORUd18Y6FPsPp
         0/LtqDDNYMCCiadvRMTCR/J0NPvDXNHAfbVos9Zj/OzXYghrqhmwZ4+y5StPO/YxQ1
         gD+DnQmRyRMlLBI0VB/WHijSnADG0mGD3NMFhGpCbkuQ0JFKnczBjSjfKVIXgcTkhp
         cwvi93ywZwiMw==
Date:   Mon, 23 May 2022 12:28:27 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Dylan Yudaken <dylany@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <20220523122827.657f2ab8@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/BWaq7T4Bp9FO_XHOmn6zcfF";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/BWaq7T4Bp9FO_XHOmn6zcfF
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/io_uring.c

between commit:

  4329490a78b6 ("io_uring_enter(): don't leave f.flags uninitialized")

from the vfs tree and commit:

  3e813c902672 ("io_uring: rework io_uring_enter to simplify return value")

from the block tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/io_uring.c
index 82a1eac73de7,fd47002e669d..000000000000
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@@ -10840,8 -12060,9 +12060,8 @@@ iopoll_locked
  out:
  	percpu_ref_put(&ctx->refs);
  out_fput:
 -	if (!(flags & IORING_ENTER_REGISTERED_RING))
 -		fdput(f);
 +	fdput(f);
- 	return submitted ? submitted : ret;
+ 	return ret;
  }
 =20
  #ifdef CONFIG_PROC_FS

--Sig_/BWaq7T4Bp9FO_XHOmn6zcfF
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKK8UsACgkQAVBC80lX
0Gx68Af+M/jeVemOYvTSkZn2s6s4uL5DSEeH6p44oqyFpaBD/8EdULoKNpDsWYKY
oTjv6X/PGrQr4X/TdgcUUfgYiwkhki/cj2ZNHOqjxBSxNvZoUoBZh+HIYMQr74+W
n8qqpLDh0LOtPRMxFgEK8zjNrekr9NibbuagFcZTPfQZXerrquEXNamW2oJnqySu
GwwkiDxGPu5F6yTK22+5QjggylVVq13npqlyD1tsfcYkqfQ6Nj9rcQvnHLPWpL0w
ZaVPlfih16eqPsbBHnR37+HtYvGNY5in/oARNBIUcwo1ES6Tt45LmZnAeEkUEWxB
nTIokkqEXbL3LelKDIfYiDYGgc0XMg==
=DY4O
-----END PGP SIGNATURE-----

--Sig_/BWaq7T4Bp9FO_XHOmn6zcfF--
