Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AA28751F5A2
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 09:54:55 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236829AbiEIHyM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 03:54:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59790 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235877AbiEIHpE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 03:45:04 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 413361A055;
        Mon,  9 May 2022 00:41:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KxY4z6mFdz4xdK;
        Mon,  9 May 2022 17:41:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652082068;
        bh=i0aeTdQw+3JrPXHk8PlA8SvtwJ+ifxuMK43yX2iCLSQ=;
        h=Date:From:To:Cc:Subject:From;
        b=VAFmLUDaiqLp5Qsrmgm5VS629PvqFw5tpiWzQv8pgKhY7ql1tRLh2eWx9FML/WanV
         HxO8udSPblN+aSlj8QdXAw5ydeXAXHxuLHOJiPfvyK7Xt2NN1njefRZvQ7KHtrUdIr
         LqVqq/uv45cthYyZv4+Y6RA+HqJyIzMAYHyjoXDhcJ4Gm+vEl1kkm5UtqAsV94/iTK
         ynC9CpivVEe5b0kt428smcMEimLXctjvCj+kbhWo2u9Gp2PRBGV5dCURVGrJ4X7WPc
         wfTH9ojKQkLCZyCPn3dO1Q54KNgbnfNqxkElv5dFUTnsMZ0/qfSI34WFe/3GNUpZTv
         ZyfmNpg77bHuw==
Date:   Mon, 9 May 2022 17:41:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Jaegeuk Kim <jaegeuk@kernel.org>
Cc:     Daeho Jeong <daehojeong@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the f2fs tree
Message-ID: <20220509174106.323ac148@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/soev6gK5Yjbb8FVlyI=yQq/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/soev6gK5Yjbb8FVlyI=yQq/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  fs/f2fs/data.c

between commit:

  3d7ad9c30607 ("f2fs: change the current atomic write way")

from the f2fs tree and commit:

  bd5533ee6fb4 ("f2fs: Convert to release_folio")

from the folio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/f2fs/data.c
index 54a7a8ad994d,8f38c26bb16c..000000000000
--- a/fs/f2fs/data.c
+++ b/fs/f2fs/data.c
@@@ -3313,103 -3314,8 +3314,102 @@@ unlock_out
  	return err;
  }
 =20
 +static int __find_data_block(struct inode *inode, pgoff_t index,
 +				block_t *blk_addr)
 +{
 +	struct dnode_of_data dn;
 +	struct page *ipage;
 +	struct extent_info ei =3D {0, };
 +	int err =3D 0;
 +
 +	ipage =3D f2fs_get_node_page(F2FS_I_SB(inode), inode->i_ino);
 +	if (IS_ERR(ipage))
 +		return PTR_ERR(ipage);
 +
 +	set_new_dnode(&dn, inode, ipage, ipage, 0);
 +
 +	if (f2fs_lookup_extent_cache(inode, index, &ei)) {
 +		dn.data_blkaddr =3D ei.blk + index - ei.fofs;
 +	} else {
 +		/* hole case */
 +		err =3D f2fs_get_dnode_of_data(&dn, index, LOOKUP_NODE);
 +		if (err) {
 +			dn.data_blkaddr =3D NULL_ADDR;
 +			err =3D 0;
 +		}
 +	}
 +	*blk_addr =3D dn.data_blkaddr;
 +	f2fs_put_dnode(&dn);
 +	return err;
 +}
 +
 +static int __reserve_data_block(struct inode *inode, pgoff_t index,
 +				block_t *blk_addr, bool *node_changed)
 +{
 +	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
 +	struct dnode_of_data dn;
 +	struct page *ipage;
 +	int err =3D 0;
 +
 +	f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, true);
 +
 +	ipage =3D f2fs_get_node_page(sbi, inode->i_ino);
 +	if (IS_ERR(ipage)) {
 +		err =3D PTR_ERR(ipage);
 +		goto unlock_out;
 +	}
 +	set_new_dnode(&dn, inode, ipage, ipage, 0);
 +
 +	err =3D f2fs_get_block(&dn, index);
 +
 +	*blk_addr =3D dn.data_blkaddr;
 +	*node_changed =3D dn.node_changed;
 +	f2fs_put_dnode(&dn);
 +
 +unlock_out:
 +	f2fs_do_map_lock(sbi, F2FS_GET_BLOCK_PRE_AIO, false);
 +	return err;
 +}
 +
 +static int prepare_atomic_write_begin(struct f2fs_sb_info *sbi,
 +			struct page *page, loff_t pos, unsigned int len,
 +			block_t *blk_addr, bool *node_changed)
 +{
 +	struct inode *inode =3D page->mapping->host;
 +	struct inode *cow_inode =3D F2FS_I(inode)->cow_inode;
 +	pgoff_t index =3D page->index;
 +	int err =3D 0;
 +	block_t ori_blk_addr;
 +
 +	/* If pos is beyond the end of file, reserve a new block in COW inode */
 +	if ((pos & PAGE_MASK) >=3D i_size_read(inode))
 +		return __reserve_data_block(cow_inode, index, blk_addr,
 +					node_changed);
 +
 +	/* Look for the block in COW inode first */
 +	err =3D __find_data_block(cow_inode, index, blk_addr);
 +	if (err)
 +		return err;
 +	else if (*blk_addr !=3D NULL_ADDR)
 +		return 0;
 +
 +	/* Look for the block in the original inode */
 +	err =3D __find_data_block(inode, index, &ori_blk_addr);
 +	if (err)
 +		return err;
 +
 +	/* Finally, we should reserve a new block in COW inode for the update */
 +	err =3D __reserve_data_block(cow_inode, index, blk_addr, node_changed);
 +	if (err)
 +		return err;
 +
 +	if (ori_blk_addr !=3D NULL_ADDR)
 +		*blk_addr =3D ori_blk_addr;
 +	return 0;
 +}
 +
  static int f2fs_write_begin(struct file *file, struct address_space *mapp=
ing,
- 		loff_t pos, unsigned len, unsigned flags,
- 		struct page **pagep, void **fsdata)
+ 		loff_t pos, unsigned len, struct page **pagep, void **fsdata)
  {
  	struct inode *inode =3D mapping->host;
  	struct f2fs_sb_info *sbi =3D F2FS_I_SB(inode);
@@@ -3617,24 -3525,33 +3617,26 @@@ void f2fs_invalidate_folio(struct foli
  	folio_detach_private(folio);
  }
 =20
- int f2fs_release_page(struct page *page, gfp_t wait)
+ bool f2fs_release_folio(struct folio *folio, gfp_t wait)
  {
- 	/* If this is dirty page, keep PagePrivate */
- 	if (PageDirty(page))
- 		return 0;
+ 	struct f2fs_sb_info *sbi;
+=20
+ 	/* If this is dirty folio, keep private data */
+ 	if (folio_test_dirty(folio))
+ 		return false;
 =20
- 	if (test_opt(F2FS_P_SB(page), COMPRESS_CACHE)) {
- 		struct inode *inode =3D page->mapping->host;
 -	/* This is atomic written page, keep Private */
 -	if (page_private_atomic(&folio->page))
 -		return false;
 -
+ 	sbi =3D F2FS_M_SB(folio->mapping);
+ 	if (test_opt(sbi, COMPRESS_CACHE)) {
+ 		struct inode *inode =3D folio->mapping->host;
 =20
- 		if (inode->i_ino =3D=3D F2FS_COMPRESS_INO(F2FS_I_SB(inode)))
- 			clear_page_private_data(page);
+ 		if (inode->i_ino =3D=3D F2FS_COMPRESS_INO(sbi))
+ 			clear_page_private_data(&folio->page);
  	}
 =20
- 	clear_page_private_gcing(page);
+ 	clear_page_private_gcing(&folio->page);
 =20
- 	detach_page_private(page);
- 	set_page_private(page, 0);
- 	return 1;
+ 	folio_detach_private(folio);
+ 	return true;
  }
 =20
  static bool f2fs_dirty_data_folio(struct address_space *mapping,

--Sig_/soev6gK5Yjbb8FVlyI=yQq/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ4xZIACgkQAVBC80lX
0GzH4wf8CfB5UhGgK1r0d7qDhleUR0fDcn55O+7IuMrIXIZfdlprqTBQMnR/pdNg
JuM1PeDYrF1fHcH5mbwTMlv8GrBcGrM2pk50QQVAReCdsq12A6nX9YaWZ9wvmYUT
Cwpz1dvIZ3kPqHcXYFgexwMct2K77D9TjPIIQfWP6Q2495bMam6f/ujmgDFvvKWX
a4P44ozobnTFjb97dIhsoLAso6/Wv2Wr9VkzJ36LhfXZH2C224x/iiYI9Wdl+ziX
U4CdS9wI38XvhLNxj24qdUja5zEvOFS6MCfPEfwo2lNbUX1j0NIwdiOO0PQ44fXI
Rr9Thx+nyf5yg9mcg/oMITwDS1z3Iw==
=aTeQ
-----END PGP SIGNATURE-----

--Sig_/soev6gK5Yjbb8FVlyI=yQq/--
