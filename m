Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EB6454ECFC5
	for <lists+linux-kernel@lfdr.de>; Thu, 31 Mar 2022 00:44:47 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351672AbiC3WqS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 30 Mar 2022 18:46:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43226 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348450AbiC3WqP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 30 Mar 2022 18:46:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AAB3A1DA76;
        Wed, 30 Mar 2022 15:44:27 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KTM1k00krz4xLb;
        Thu, 31 Mar 2022 09:44:25 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1648680266;
        bh=uLjHaRxkBn1qxDblevEbhS+TDICmU2vAOGQ8Dk0eQyA=;
        h=Date:From:To:Cc:Subject:From;
        b=uANzCGtR6adPUADw8dtQ5Ur08WegwHWuqGe3jUU3plo8ohgSNRHuwxj8MPfxHgMgD
         lR2UIF+NFLh2lN/a2bZfxkNxztR68BgDFqVI5UZgFrZhRpPC9aFghSju2jj8nq/siv
         ph8sgth/pzihfBOyXRGV6pF+/kttnlKxJn+YD/9o7fpKoj30upBcyKVLA07ZWsAuG1
         SQvo0kJCzXx2RnHa03NKKjdUbL9Kvxl6ZOL/OLAIeqhWlt29dzoJfTZ5vMq4ywcGGX
         xaVbFe8c+HgKvinIfWaLfSwhWYj53KAGn6o6Zz1rff51zfvs2MFXFuU6jiZ2KmWEmw
         +v9uWYzgCGi6w==
Date:   Thu, 31 Mar 2022 09:44:25 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Alasdair G Kergon <agk@redhat.com>,
        Mike Snitzer <snitzer@kernel.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the device-mapper tree with the block
 tree
Message-ID: <20220331094425.0a9e0b92@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DIMab.JdLpTZ7F+_9Ityuf+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DIMab.JdLpTZ7F+_9Ityuf+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the device-mapper tree got a conflict in:

  include/linux/bio.h

between commit:

  57c47b42f454 ("block: turn bio_kmalloc into a simple kmalloc wrapper")

from the block tree and commit:

  135eaaabd22a ("block: allow using the per-cpu bio cache from bio_alloc_bi=
oset")

from the device-mapper tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc include/linux/bio.h
index ab77473c855b,8c42b67c41c7..000000000000
--- a/include/linux/bio.h
+++ b/include/linux/bio.h
@@@ -405,9 -408,7 +405,7 @@@ extern int bioset_init_from_src(struct=20
  struct bio *bio_alloc_bioset(struct block_device *bdev, unsigned short nr=
_vecs,
  			     unsigned int opf, gfp_t gfp_mask,
  			     struct bio_set *bs);
- struct bio *bio_alloc_kiocb(struct kiocb *kiocb, struct block_device *bde=
v,
- 		unsigned short nr_vecs, unsigned int opf, struct bio_set *bs);
 -struct bio *bio_kmalloc(gfp_t gfp_mask, unsigned short nr_iovecs);
 +struct bio *bio_kmalloc(unsigned short nr_vecs, gfp_t gfp_mask);
  extern void bio_put(struct bio *);
 =20
  struct bio *bio_alloc_clone(struct block_device *bdev, struct bio *bio_sr=
c,

--Sig_/DIMab.JdLpTZ7F+_9Ityuf+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJE3UkACgkQAVBC80lX
0GyLdggAnCkO8cnQ/IbCPnb6/asbOIgQVCobJYXvEYdyICsEm9MJzbwxwSI5vUFd
K1ox01BCJbWP3OSTBEZXYBo68mC7C3aTCWqe5x+UNSb2S99Xcw9WKERXZ4ScX576
4Ow1eeGJH5FWRSgPjr12iFFpg4hoL0tmu6ncYFzjYtVN1WcMJ/IItJYmWcL/JGgf
JnTVSs43Wj0cHNAXa/ZAN+Etmgza7wDygMEm6Ht+wWY/tJX+TLERgGFqrFj8TOSs
hNVtBtRu1uispgVzyBN1OUnrVfsurW6vO4d8WyIfSPP3hxiGr2OxqZBvhmq+CRX1
YtFyQAYZGyOWREwJpx7UJ1hc3pDItQ==
=CB3+
-----END PGP SIGNATURE-----

--Sig_/DIMab.JdLpTZ7F+_9Ityuf+--
