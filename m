Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E4F075759F6
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 05:25:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241311AbiGODZp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 23:25:45 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229603AbiGODZn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 23:25:43 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 710B557E39;
        Thu, 14 Jul 2022 20:25:41 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LkcFC6twWz4xht;
        Fri, 15 Jul 2022 13:25:35 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657855537;
        bh=zuMVYtr24KQOywuHMyJ2ZlB0PFTljNIpW0wNNZUev7M=;
        h=Date:From:To:Cc:Subject:From;
        b=Ee5Beq2IG4YemgomvvZ8QJlx3og7+whl5GQJPg2jXfxf2EBowkeiruzHvAz/Fuo+N
         lhDD4c4huTTUZhiiEod0o4jxNKP6bwgjok2xVv5LI/w3k5vg+yl+Qej5Uwva7yVrob
         BMY1cDBycjpm7s2g0jCoGJeit1n0ShOfGIxJLSVgTREqP80wH7IbI2sJ+uMDxPyL3R
         6/MBTuNcYciQ2VM2e0MFwYFAUw/tUty5JmgC2tpf9NtwKoxVBxjXEdu0Wxxt0jJh5H
         sPzl1l7ojqxkWPG6cfkGTgAXGxetm/VgaD5ALR0qCwOLyZ01xLmQw1hFUlDCzuLVh3
         OlZ9p7dal+SlQ==
Date:   Fri, 15 Jul 2022 13:25:35 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, David Sterba <dsterba@suse.cz>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the btrfs tree
Message-ID: <20220715132535.36121f59@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/06wa+X+XD4N_bufeaPBd9y0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/06wa+X+XD4N_bufeaPBd9y0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got conflicts in:

  fs/btrfs/compression.c
  fs/btrfs/extent_io.c
  fs/btrfs/raid56.c

between commits:

  7c16aa15d58b ("btrfs: simplify the pending I/O counting in struct compres=
sed_bio")
  50d003d4254c ("btrfs: centralize setting REQ_META")
  9fab7af28df7 ("btrfs: raid56: use fixed stripe length everywhere")

from the btrfs tree and commit:

  bf9486d6dd23 ("fs/btrfs: Use the enum req_op and blk_opf_t types")

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

diff --cc fs/btrfs/compression.c
index b6fb8b0682ba,a82b9f17f476..000000000000
--- a/fs/btrfs/compression.c
+++ b/fs/btrfs/compression.c
@@@ -394,10 -514,10 +394,10 @@@ blk_status_t btrfs_submit_compressed_wr
  	struct compressed_bio *cb;
  	u64 cur_disk_bytenr =3D disk_start;
  	u64 next_stripe_start;
 -	blk_status_t ret;
  	int skip_sum =3D inode->flags & BTRFS_INODE_NODATASUM;
  	const bool use_append =3D btrfs_use_zone_append(inode, disk_start);
- 	const unsigned int bio_op =3D use_append ? REQ_OP_ZONE_APPEND : REQ_OP_W=
RITE;
+ 	const enum req_op bio_op =3D use_append ? REQ_OP_ZONE_APPEND : REQ_OP_WR=
ITE;
 +	blk_status_t ret =3D BLK_STS_OK;
 =20
  	ASSERT(IS_ALIGNED(start, fs_info->sectorsize) &&
  	       IS_ALIGNED(len, fs_info->sectorsize));
diff --cc fs/btrfs/extent_io.c
index db95de608ce3,60a20df353e7..000000000000
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@@ -4531,7 -4575,7 +4531,7 @@@ static int write_one_subpage_eb(struct=20
  {
  	struct btrfs_fs_info *fs_info =3D eb->fs_info;
  	struct page *page =3D eb->pages[0];
- 	unsigned int write_flags =3D wbc_to_write_flags(wbc);
 -	blk_opf_t write_flags =3D wbc_to_write_flags(wbc) | REQ_META;
++	blk_opf_t write_flags =3D wbc_to_write_flags(wbc);
  	bool no_dirty_ebs =3D false;
  	int ret;
 =20
@@@ -4576,7 -4620,7 +4576,7 @@@ static noinline_for_stack int write_one
  {
  	u64 disk_bytenr =3D eb->start;
  	int i, num_pages;
- 	unsigned int write_flags =3D wbc_to_write_flags(wbc);
 -	blk_opf_t write_flags =3D wbc_to_write_flags(wbc) | REQ_META;
++	blk_opf_t write_flags =3D wbc_to_write_flags(wbc);
  	int ret =3D 0;
 =20
  	prepare_eb_write(eb);
diff --cc fs/btrfs/raid56.c
index 1afe32d5ab01,c520412d1f86..000000000000
--- a/fs/btrfs/raid56.c
+++ b/fs/btrfs/raid56.c
@@@ -1018,7 -1135,8 +1018,7 @@@ static int rbio_add_io_sector(struct bt
  			      struct sector_ptr *sector,
  			      unsigned int stripe_nr,
  			      unsigned int sector_nr,
- 			      unsigned int opf)
 -			      unsigned long bio_max_len,
+ 			      enum req_op op)
  {
  	const u32 sectorsize =3D rbio->bioc->fs_info->sectorsize;
  	struct bio *last =3D bio_list->tail;
@@@ -1062,9 -1180,8 +1062,9 @@@
  	}
 =20
  	/* put a new bio on the list */
 -	bio =3D bio_alloc(stripe->dev->bdev, max(bio_max_len >> PAGE_SHIFT, 1UL),
 +	bio =3D bio_alloc(stripe->dev->bdev,
 +			max(BTRFS_STRIPE_LEN >> PAGE_SHIFT, 1),
- 			opf, GFP_NOFS);
+ 			op, GFP_NOFS);
  	bio->bi_iter.bi_sector =3D disk_start >> 9;
  	bio->bi_private =3D rbio;
 =20

--Sig_/06wa+X+XD4N_bufeaPBd9y0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLQ3i8ACgkQAVBC80lX
0Gyx7gf/Rgp6pi9OzfCbr7k7rT+GaOZJyLW7jW1juTYNZyFUAz+hTB8/VASHTOyd
mIStapRYSTW5+8vbSjRDRsC6cfcnf6FxxQl53xKtWcg1xgg/rR+i3us6IfGn+qOg
8WUcXlRwJ1sEa1KRCIgAyzxiWQJx+p0Oq9P1tUjv+7U1zpcRo/HQbBVjglie3RS8
aSdPeFt2L3tnCWu2P1hPQbGGvlYDzsUn9tkvnKZflu+tdU+TwzfYM+OhzEZJzQx8
Ai1JJzS+yuplk8xtXk2uoGAM9e3XVHDjgj0F6QIbmuiWg3rOtK82F8qfqcSUg02F
MIAmvFDly86QZRjNZ3s2wC2l70S/wQ==
=DWi1
-----END PGP SIGNATURE-----

--Sig_/06wa+X+XD4N_bufeaPBd9y0--
