Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 52481516BA6
	for <lists+linux-kernel@lfdr.de>; Mon,  2 May 2022 10:04:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1383605AbiEBIH7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 2 May 2022 04:07:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51200 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233357AbiEBIH5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 2 May 2022 04:07:57 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 67E9E37A9E;
        Mon,  2 May 2022 01:04:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KsFx641x8z4x7Y;
        Mon,  2 May 2022 18:04:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651478667;
        bh=AlKYgOI+es/EpKkfFdJ/AxpxreKRAHEWfgntPF/V9j8=;
        h=Date:From:To:Cc:Subject:From;
        b=TbAEob4ktIYddDMwS7uzfRJILYgVdZ9CrtmR/77ag/wgTRFL9wiXFwSIHjduwUnIc
         0O0LDQPT6BpG51OukVBoKn9jOq14G9+l0bOi0ftxcMr7CPaJ5hb50pK4FQvxNNhRe8
         FaN6Z8FNjgBAfpbIMtf3Hi+0untYO1sj9yfufDJXMPRQcohyeL7api2HCljPnOXXvb
         vKwwdUNfm+OfDj8MWb3LFRr38ENPe1nnqpZKc1Re8gF0O8ShaGYmhjxlT4pMoPTK/r
         1Y1pdlyC1uwNvglVRxY4Bb8QfQ6PxNpSGwynPCm2xe9ZY90FKL49uhwgxf1nyCP83u
         yWjzLCa6aZPgQ==
Date:   Mon, 2 May 2022 18:04:25 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Jeffle Xu <jefflexu@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the folio tree
Message-ID: <20220502180425.7305c335@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/aILqJDFCeVw.QWbKJYPtk/K";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/aILqJDFCeVw.QWbKJYPtk/K
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the folio tree, today's linux-next build (x86_64
allmodconfig) failed like this:

fs/erofs/fscache.c:255:10: error: 'const struct address_space_operations' h=
as no member named 'readpage'
  255 |         .readpage =3D erofs_fscache_meta_readpage,
      |          ^~~~~~~~
fs/erofs/fscache.c:255:21: error: initialization of 'int (*)(struct page *,=
 struct writeback_control *)' from incompatible pointer type 'int (*)(struc=
t file *, struct page *)' [-Werror=3Dincompatible-pointer-types]
  255 |         .readpage =3D erofs_fscache_meta_readpage,
      |                     ^~~~~~~~~~~~~~~~~~~~~~~~~~~
fs/erofs/fscache.c:255:21: note: (near initialization for 'erofs_fscache_me=
ta_aops.writepage')
fs/erofs/fscache.c:259:10: error: 'const struct address_space_operations' h=
as no member named 'readpage'
  259 |         .readpage =3D erofs_fscache_readpage,
      |          ^~~~~~~~
fs/erofs/fscache.c:259:21: error: initialization of 'int (*)(struct page *,=
 struct writeback_control *)' from incompatible pointer type 'int (*)(struc=
t file *, struct page *)' [-Werror=3Dincompatible-pointer-types]
  259 |         .readpage =3D erofs_fscache_readpage,
      |                     ^~~~~~~~~~~~~~~~~~~~~~
fs/erofs/fscache.c:259:21: note: (near initialization for 'erofs_fscache_ac=
cess_aops.writepage')

Caused by commit

  00da6d4b7219 ("mm,fs: Remove stray references to ->readpage")

interacting with commits

  60aa7e805f00 ("erofs: implement fscache-based metadata read")
  e472f468adbe ("erofs: implement fscache-based data read for non-inline la=
yout")

from the erofs tree.

I have applied the following merge fix patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 2 May 2022 17:57:39 +1000
Subject: [PATCH] fixup for "mm,fs: Remove stray references to ->readpage"

interacting with commits

  60aa7e805f00 ("erofs: implement fscache-based metadata read")
  e472f468adbe ("erofs: implement fscache-based data read for non-inline la=
yout")

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/erofs/fscache.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/fs/erofs/fscache.c b/fs/erofs/fscache.c
index a402d8f0a063..1bb2d0fc19c8 100644
--- a/fs/erofs/fscache.c
+++ b/fs/erofs/fscache.c
@@ -59,10 +59,9 @@ static int erofs_fscache_read_folios(struct fscache_cook=
ie *cookie,
 	return ret;
 }
=20
-static int erofs_fscache_meta_readpage(struct file *data, struct page *pag=
e)
+static int erofs_fscache_meta_read_folio(struct file *data, struct folio *=
folio)
 {
 	int ret;
-	struct folio *folio =3D page_folio(page);
 	struct super_block *sb =3D folio_mapping(folio)->host->i_sb;
 	struct erofs_map_dev mdev =3D {
 		.m_deviceid =3D 0,
@@ -110,9 +109,8 @@ static int erofs_fscache_readpage_inline(struct folio *=
folio,
 	return 0;
 }
=20
-static int erofs_fscache_readpage(struct file *file, struct page *page)
+static int erofs_fscache_read_folio(struct file *file, struct folio *folio)
 {
-	struct folio *folio =3D page_folio(page);
 	struct inode *inode =3D folio_mapping(folio)->host;
 	struct super_block *sb =3D inode->i_sb;
 	struct erofs_map_blocks map;
@@ -252,11 +250,11 @@ static void erofs_fscache_readahead(struct readahead_=
control *rac)
 }
=20
 static const struct address_space_operations erofs_fscache_meta_aops =3D {
-	.readpage =3D erofs_fscache_meta_readpage,
+	.read_folio =3D erofs_fscache_meta_read_folio,
 };
=20
 const struct address_space_operations erofs_fscache_access_aops =3D {
-	.readpage =3D erofs_fscache_readpage,
+	.read_folio =3D erofs_fscache_read_folio,
 	.readahead =3D erofs_fscache_readahead,
 };
=20
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/aILqJDFCeVw.QWbKJYPtk/K
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJvkIkACgkQAVBC80lX
0GzACgf/a6pKIsy2qA2M/IHl2rYJ/zahTNsXgWDJ1yFXBJIkKSb+A55iyo0kQZQg
Z8/ctAYCcfvsHgFeFpfcTxA74DKaGdqHRTr6Zjp77BuYuCtP0NHTbdMVDatU1XoQ
9WmmU5NEya4gQtMOf3zlV4cWxCoPG3KllgWzOaYF71cee9YeJhE114/S1vnlxyai
NFjjJA1gUeD0xajUZJdZ/ZVCRHL+VSgolON6nuS+GzN58XoAQjXXLBNYQxZY94mD
J0U+Smakk0is6I+dRvL6shG1M425jCQD8sHNCtr4KZYXJwfTx/RrusrWqyptihHF
WKoKXbOJ6CdjRojfPciponq4wLU99A==
=V2VD
-----END PGP SIGNATURE-----

--Sig_/aILqJDFCeVw.QWbKJYPtk/K--
