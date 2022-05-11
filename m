Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 44FEB522A08
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 04:51:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238604AbiEKCtx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 22:49:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39188 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243921AbiEKCmp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 22:42:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5B4CC4B1DA;
        Tue, 10 May 2022 19:42:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KyfMd67QZz4xXk;
        Wed, 11 May 2022 12:42:37 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652236959;
        bh=7U8d2nd8kvxYZMwA9b1E2WYw3yF7FQaI+m4Vctsp3PA=;
        h=Date:From:To:Cc:Subject:From;
        b=e+u55ALlgkiV6lxArCQbr8iF9+xpqCvKUxLUUhrthRnY7CzGSJB4r4Ty4MDYgCr2j
         sHYysaqgggY7qZA9KAF9XliS9B95kvfdxThk4yijiWKhd5R1pP/BWBropiqQ7GLS7C
         8KuIxKqykBVcvWCp0ytnDq+Cj/21cQF3TDRWAfa+yHGTeVyBwJPwau+RuP6qP08ThP
         /bpw9xSGw4+EIgJP+JMlPSqaoTxvj1mG0MeXDHc8G6l9/D+b5VnWoBu20Vgk6MFxXP
         eFP+Lp4kTRFYFPiul4inpviM/32eDdez5KJlDDYYfPbnlNXjD/8LevZc8GC36bq/eL
         vr2v7bdFNNKbg==
Date:   Wed, 11 May 2022 12:42:36 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Ulf Hansson <ulf.hansson@linaro.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Vincent Whitchurch <vincent.whitchurch@axis.com>
Subject: linux-next: manual merge of the mmc tree with the block tree
Message-ID: <20220511124236.75288a29@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/AY/TGiAsgSBewv4H9F3onqL";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/AY/TGiAsgSBewv4H9F3onqL
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mmc tree got a conflict in:

  drivers/mmc/core/queue.c

between commit:

  44abff2c0b97 ("block: decouple REQ_OP_SECURE_ERASE from REQ_OP_DISCARD")

from the block tree and commit:

  f7b6fc327327 ("mmc: core: Support zeroout using TRIM for eMMC")

from the mmc tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc drivers/mmc/core/queue.c
index a3d446005571,bbe2ea829ea7..000000000000
--- a/drivers/mmc/core/queue.c
+++ b/drivers/mmc/core/queue.c
@@@ -189,7 -190,9 +189,9 @@@ static void mmc_queue_setup_discard(str
  	if (card->pref_erase > max_discard)
  		q->limits.discard_granularity =3D SECTOR_SIZE;
  	if (mmc_can_secure_erase_trim(card))
 -		blk_queue_flag_set(QUEUE_FLAG_SECERASE, q);
 +		blk_queue_max_secure_erase_sectors(q, max_discard);
+ 	if (mmc_can_trim(card) && card->erased_byte =3D=3D 0)
+ 		blk_queue_max_write_zeroes_sectors(q, max_discard);
  }
 =20
  static unsigned short mmc_get_max_segments(struct mmc_host *host)

--Sig_/AY/TGiAsgSBewv4H9F3onqL
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ7IpwACgkQAVBC80lX
0GwQWwf/SNdvQF0rujCDPnAd0Bz2LV3mr0YZAdr83mXexUdu0zHw13o/fGnJfa2m
x8n7mI3+IZ8ME6Kp1Q/t6ljk6fwyIaPnEnMKAFAW1i6rsh3d62auR/+hb44ELW7g
+xa2QHzYb+Nybu3iHDeDE+nG199nliruGa7RCnm22qvnn7Mxbx4dJQJjVwz/vP5Q
XcGH5RRnPvz9l+/esC8LF2M4wR61LecUi1yzJtuXDdMCt1SZBcHp25bzZfEZderI
cJqcoqzGabIGyU8m9KmH/20gHnQ26TWEyA+9symosqyALzpzBTOjW/FK6WESeXji
EvaIe3r/Bp/hJoi7fbluRe56Ne0F3A==
=EF25
-----END PGP SIGNATURE-----

--Sig_/AY/TGiAsgSBewv4H9F3onqL--
