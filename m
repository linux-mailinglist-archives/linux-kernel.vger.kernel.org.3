Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 894C656D238
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 02:34:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229657AbiGKAeZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 20:34:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39730 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229477AbiGKAeY (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 20:34:24 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EC3DD63DF;
        Sun, 10 Jul 2022 17:34:22 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lh4dN5LR1z4xXj;
        Mon, 11 Jul 2022 10:34:16 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657499657;
        bh=g8nUc2vrjLqbAhzxUgKGnKRtz0OKsUg950t4UTQmsp4=;
        h=Date:From:To:Cc:Subject:From;
        b=Z301i0/uikn8CUgfH2+bDfOykMRhmBiNMYC4C2pUSWpUYPURaNWM9ZId7Bjf64x/v
         IbMqKXMSd/ndx9Iq9KKxNMXm1umw0U1BUT1oy4S1f2N1pNXguO5pQrY2r+i3Oq+hUX
         ftQWNcdDbQSV227VRd5mjbEGyWY6Kg3Hwa/5DJsew+kNcTHEuqz8PaVbRU7ZeANSfK
         ZjZfNHkFz7wS9VE89c5HO/3UkPaDtKajShDpJ6xti9tiRnXe3S2U22PPQ1h7WeWB2l
         /8G2yQ8FASqIR5SzqVxbTh6NiUVXoaxDoMwyQj/fxyUCoWucBNa/X+UkWCwrGzpDMJ
         Ob+Em63tZ/XMg==
Date:   Mon, 11 Jul 2022 10:34:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Al Viro <viro@ZenIV.linux.org.uk>, David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the vfs tree with the btrfs tree
Message-ID: <20220711103415.41685daa@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/86LkagoEDZiU+_Nw13S3VCn";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/86LkagoEDZiU+_Nw13S3VCn
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the vfs tree got a conflict in:

  fs/btrfs/file.c

between commit:

  c8223467948b ("btrfs: don't fallback to buffered IO for NOWAIT direct IO =
writes")

from the btrfs tree and commit:

  eacdf4eaca63 ("btrfs: use IOMAP_DIO_NOSYNC")

from the vfs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/file.c
index 1876072dee9d,30e6aef9739f..000000000000
--- a/fs/btrfs/file.c
+++ b/fs/btrfs/file.c
@@@ -1846,36 -1846,8 +1846,35 @@@ static ssize_t check_direct_IO(struct b
  	return 0;
  }
 =20
 +static size_t dio_fault_in_size(const struct kiocb *iocb,
 +				const struct iov_iter *iov,
 +				size_t prev_left)
 +{
 +	const size_t left =3D iov_iter_count(iov);
 +	size_t size =3D PAGE_SIZE;
 +
 +	/*
 +	 * If there's no progress since the last time we had to fault in pages,
 +	 * then we fault in at most 1 page. Faulting in more than that may
 +	 * result in making very slow progress or falling back to buffered IO,
 +	 * because by the time we retry the DIO operation some of the first
 +	 * remaining pages may have been evicted in order to fault in other pages
 +	 * that follow them. That can happen when we are under memory pressure a=
nd
 +	 * the iov represents a large buffer.
 +	 */
 +	if (left !=3D prev_left) {
 +		int dirty_tresh =3D current->nr_dirtied_pause - current->nr_dirtied;
 +
 +		size =3D max(dirty_tresh, 8) << PAGE_SHIFT;
 +		size =3D min_t(size_t, SZ_1M, size);
 +	}
 +	size -=3D offset_in_page(iocb->ki_pos);
 +
 +	return min(left, size);
 +}
 +
  static ssize_t btrfs_direct_write(struct kiocb *iocb, struct iov_iter *fr=
om)
  {
- 	const bool is_sync_write =3D (iocb->ki_flags & IOCB_DSYNC);
  	struct file *file =3D iocb->ki_filp;
  	struct inode *inode =3D file_inode(file);
  	struct btrfs_fs_info *fs_info =3D btrfs_sb(inode->i_sb);
@@@ -1993,17 -1954,7 +1983,10 @@@ again
 =20
  	btrfs_inode_unlock(inode, ilock_flags);
 =20
- 	/*
- 	 * Add back IOCB_DSYNC. Our caller, btrfs_file_write_iter(), will do
- 	 * the fsync (call generic_write_sync()).
- 	 */
- 	if (is_sync_write)
- 		iocb->ki_flags |=3D IOCB_DSYNC;
-=20
 -	/* If 'err' is -ENOTBLK then it means we must fallback to buffered IO. */
 +	/*
 +	 * If 'err' is -ENOTBLK or we have not written all data, then it means
 +	 * we must fallback to buffered IO.
 +	 */
  	if ((err < 0 && err !=3D -ENOTBLK) || !iov_iter_count(from))
  		goto out;
 =20

--Sig_/86LkagoEDZiU+_Nw13S3VCn
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLLcAcACgkQAVBC80lX
0GxRqgf9FugW9YMDrncdybNoM9hXJeIedTisKZ+dPtY+2Kg30BmnV4wglx0l5nnN
UjO4AJr6GVccZZj10tQJ1CW8J2U18zQxf8IK74L8qio4U71agBe7vA1V9S7gRk3g
J56WSEEuVKpxLCkZ0EjS9fCDovf3b0LdEm7IbRTkMUM/Obs84Vo5wTN1ujVQEAnh
BmGgF9Lh7U+OJyc/l6dG8NPD1XdiXEpuw76SaThwcb/VmeMb8wssRSsyNfVvR107
+l9xKJDILvP6gRxbthGrL8qkU+bVtOzKr1LQYAbuNR7WFS86DP0lPQWvcr45Rnvx
NSkuBqesnHILyYs2CyQiytQ6WEEzNQ==
=I9Ev
-----END PGP SIGNATURE-----

--Sig_/86LkagoEDZiU+_Nw13S3VCn--
