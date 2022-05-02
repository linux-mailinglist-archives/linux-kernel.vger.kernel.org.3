Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4E840516B62
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 09:43:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358857AbiEBHrL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 03:47:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58828 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1350995AbiEBHrJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 03:47:09 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 202E72715D;
        Mon,  2 May 2022 00:43:38 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KsFT26MdJz4xXk;
        Mon,  2 May 2022 17:43:34 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651477416;
        bh=nxcY+wlkmUEFwHJpOpv1mcBXCb0BZLBH2dC8Mvqgl5U=;
        h=Date:From:To:Cc:Subject:From;
        b=X372vutKHx2ANNxVi4FFyKrBjYWazZy8UwGQR7xghPuDkPwHzzbxbcUSsCZClM6c1
         tBZy+34TcqoIBuacpadUO7PL8ev7DzVm7Trvzm5b4VdTZf5pepSwc0WcMA14AQ1+Dk
         iX7HiKzF6wJCYL3oHIV4s70dF7JzpSHXNCDRI+LtttBVuphbZ+2zo0OxtWd5VlSJmL
         ib3Y1fK/snCg4gQbVcfgfhW3HXdM42ywuJVWbh4voNGI0kB4DmSGj5+d4cmH13HL7i
         zYTj23KD66K7FZNGgFhvoPSyk7wpSPgMOxXC+H0Nbg+2QPpkt6iGleHr64mJfA4XxP
         q5DcfEUR3ZoCg==
Date:   Mon, 2 May 2022 17:43:33 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>
Cc:     Christoph Hellwig <hch@lst.de>, David Sterba <dsterba@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the btrfs tree
Message-ID: <20220502174305.1cbf7b40@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/jn1Ms63ppBkLEKtFyZNOA4W";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/jn1Ms63ppBkLEKtFyZNOA4W
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got conflicts in:

  fs/btrfs/ctree.h
  fs/btrfs/inode.c

between commit:

  a3e4d924b41d ("btrfs: move btrfs_readpage to extent_io.c")

from the btrfs tree and commit:

  5a912a9c68ac ("btrfs: Convert btrfs to read_folio")

from the folio tree.

I fixed it up (I used the conflicting parts of the above files from the
former and applied the below patch) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 2 May 2022 17:21:26 +1000
Subject: [PATCH] fix up for "btrfs: move btrfs_readpage to extent_io.c"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/btrfs/extent_io.c | 3 ++-
 fs/btrfs/extent_io.h | 2 +-
 2 files changed, 3 insertions(+), 2 deletions(-)

diff --git a/fs/btrfs/extent_io.c b/fs/btrfs/extent_io.c
index 5de09556b1c3..aa8905a0d63a 100644
--- a/fs/btrfs/extent_io.c
+++ b/fs/btrfs/extent_io.c
@@ -3792,8 +3792,9 @@ static int btrfs_do_readpage(struct page *page, struc=
t extent_map **em_cached,
 	return ret;
 }
=20
-int btrfs_readpage(struct file *file, struct page *page)
+int btrfs_read_folio(struct file *file, struct folio *folio)
 {
+	struct page *page =3D &folio->page;
 	struct btrfs_inode *inode =3D BTRFS_I(page->mapping->host);
 	u64 start =3D page_offset(page);
 	u64 end =3D start + PAGE_SIZE - 1;
diff --git a/fs/btrfs/extent_io.h b/fs/btrfs/extent_io.h
index 375a721c48eb..4a2205fd189a 100644
--- a/fs/btrfs/extent_io.h
+++ b/fs/btrfs/extent_io.h
@@ -166,7 +166,7 @@ typedef struct extent_map *(get_extent_t)(struct btrfs_=
inode *inode,
 int try_release_extent_mapping(struct page *page, gfp_t mask);
 int try_release_extent_buffer(struct page *page);
=20
-int btrfs_readpage(struct file *file, struct page *page);
+int btrfs_read_folio(struct file *file, struct folio *folio);
 int extent_write_full_page(struct page *page, struct writeback_control *wb=
c);
 int extent_write_locked_range(struct inode *inode, u64 start, u64 end);
 int extent_writepages(struct address_space *mapping,
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/jn1Ms63ppBkLEKtFyZNOA4W
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvi6YACgkQAVBC80lX
0GzL2Qf+JmpUJDiYOmb7QWDIaPWWF1+L0XINehDtxVS6WKRPzQn/v6Y3fCLedqxz
yAhRgMPY2fcI0I3oCnTLET6rIKgXF+bn6xA4hMHDjSerWKN0qYtFv2QpYs0oIymU
mkolecA410LZENlpe9KjlQ0yUaCKnQoey/qAyL3SWOFaQGoLcGSl92Q+2GCx7LR1
/bfmtLcViVDhEi2g245x8PkTz++krGdSTi51hMK03HzbXep8h9s4Qv5uspJSxoYd
gheEx+KTBbUjCUEqi7qT7jWrJdeXfgA+DflYtmrTAnI3rzSy+Ix2wkA90iM/FF+7
b7YYTjq5Ol9ZbB+hOxgKcXKx0lCVhg==
=HzLx
-----END PGP SIGNATURE-----

--Sig_/jn1Ms63ppBkLEKtFyZNOA4W--
