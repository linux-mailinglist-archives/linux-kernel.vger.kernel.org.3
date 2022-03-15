Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E8B714D97A1
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:28:29 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244353AbiCOJ3h (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:29:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39376 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346418AbiCOJ3c (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:29:32 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 9306411A1F;
        Tue, 15 Mar 2022 02:28:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHp4110VRz4xRB;
        Tue, 15 Mar 2022 20:28:17 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647336497;
        bh=+rJ1UzgQsoRa4v3Bq6tUo8NVLZIk9QK3BkpnPEiSMjQ=;
        h=Date:From:To:Cc:Subject:From;
        b=bi7OP//5JuGUGfsd0U3BsTW9OFpkYDwSXr8XdDEiHfK1ixK96LeNFkAQCqRee87nv
         l+/niVqloVbBstvmUxfiyWuZurVPEPbYiI+HitbMldN4XMOoGOgsXNkxR8luem+Vvj
         R1mlliRx9rKb5p7nHKunvG+mK9TxImJQvH/PQzjTY2vjMeDkm5HGm6eWYOwa4hYwzQ
         enrzHetPD1hN+AyemshGH5FiejiGaiqGEwpXVCXBv4WJ4HL8A1x/wRcwtc0MArcbXX
         exORCjHgdI6VlfDt4A896spwBJfFbr+TRKlwP84m14WFM7rGgnYm+TlEwLP6aWyp4P
         yifQWW4eqqlsg==
Date:   Tue, 15 Mar 2022 20:28:16 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the fscache tree
Message-ID: <20220315202816.7ff33386@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4tnivnC+rkxVrBOHa=wa3Sm";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4tnivnC+rkxVrBOHa=wa3Sm
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  fs/afs/file.c

between commit:

  0c31679cf2c0 ("netfs: Add a netfs inode context")

from the fscache tree and commits:

  7d165ab9d0a0 ("afs: Convert from launder_page to launder_folio")
  09f7fc259e5d ("fscache: Convert fscache_set_page_dirty() to fscache_dirty=
_folio()")

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

diff --cc fs/afs/file.c
index 2b68b2070248,0f9fdb284a20..000000000000
--- a/fs/afs/file.c
+++ b/fs/afs/file.c
@@@ -19,11 -19,13 +19,11 @@@
  #include "internal.h"
 =20
  static int afs_file_mmap(struct file *file, struct vm_area_struct *vma);
 -static int afs_readpage(struct file *file, struct page *page);
  static int afs_symlink_readpage(struct file *file, struct page *page);
- static void afs_invalidatepage(struct page *page, unsigned int offset,
- 			       unsigned int length);
+ static void afs_invalidate_folio(struct folio *folio, size_t offset,
+ 			       size_t length);
  static int afs_releasepage(struct page *page, gfp_t gfp_flags);
 =20
 -static void afs_readahead(struct readahead_control *ractl);
  static ssize_t afs_file_read_iter(struct kiocb *iocb, struct iov_iter *it=
er);
  static void afs_vm_open(struct vm_area_struct *area);
  static void afs_vm_close(struct vm_area_struct *area);
@@@ -50,12 -52,12 +50,12 @@@ const struct inode_operations afs_file_
  };
 =20
  const struct address_space_operations afs_file_aops =3D {
 -	.readpage	=3D afs_readpage,
 -	.readahead	=3D afs_readahead,
 +	.readpage	=3D netfs_readpage,
 +	.readahead	=3D netfs_readahead,
- 	.set_page_dirty	=3D afs_set_page_dirty,
- 	.launder_page	=3D afs_launder_page,
+ 	.dirty_folio	=3D afs_dirty_folio,
+ 	.launder_folio	=3D afs_launder_folio,
  	.releasepage	=3D afs_releasepage,
- 	.invalidatepage	=3D afs_invalidatepage,
+ 	.invalidate_folio =3D afs_invalidate_folio,
  	.write_begin	=3D afs_write_begin,
  	.write_end	=3D afs_write_end,
  	.writepage	=3D afs_writepage,

--Sig_/4tnivnC+rkxVrBOHa=wa3Sm
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwXDAACgkQAVBC80lX
0GyZPAf/RX3ajMjmvSDIdbVikubdCleVQfBx6Kj4JQVe93oUeccPmrlu82Mpl0BR
cfHPU/IqJFYi+bWI8BrnI2AnA4Tu9vPV6L8ZMAihYsWPygL6hibE3+3MgTU2d7Zr
LFzZcsTBWmD9ztChSTvBO5qWvibs3WWLSV3IrsJvBh56Etuf12wc/KRq+o9l8Ke3
D9J7jh0i5/RdhBKRl8mEtI5+cYlMjj0pLIYveo3N5ALMmf1trzMs8DGqEk4ZqCCT
d+qJWjomUFp6JYJhk+RAQWhHxiX1k2hN2OZLGTjCIJ8u0zZBx5hwQe7MH59CywUL
fSc4wRL2M9/xcqDeIzz/Fu/Ppgmo9Q==
=6I/A
-----END PGP SIGNATURE-----

--Sig_/4tnivnC+rkxVrBOHa=wa3Sm--
