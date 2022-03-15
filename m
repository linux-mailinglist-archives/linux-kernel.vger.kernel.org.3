Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 47A4A4D9797
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:25:23 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346577AbiCOJ0b (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:26:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34930 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234965AbiCOJ03 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:26:29 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4196A36304;
        Tue, 15 Mar 2022 02:25:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHp0T5Tjpz4xLQ;
        Tue, 15 Mar 2022 20:25:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647336314;
        bh=Wu+7TfAaSDKRwJwjYIaFsAceHlmyGB/5bNH79Q68ULs=;
        h=Date:From:To:Cc:Subject:From;
        b=EUycp2F5aFTTtz0qrmE6qRRR/+NPFLuecBCqUOfMNTmwwX0N/OVs92sz+7nzPAfXO
         TDjeVBMhUlPrEb34CpU6+yqoGj/9zTfBZ6/oUSIA9GomxySNWviQHGmzEyBvd3RMVA
         e7+paDGMDlVltaEWHhBhUv0o/G98230rEx3gQyz5Uv/EtHw0owg4xpr1uN2s8vSPwD
         NT+aYbD/WzwLi/LD2JGBj9nbosIx4pgf4qZZEKM4xz0Xuw/Hxf8w0BlfjkVQgMi/YL
         nWv5YuhoqJID9jEVF44WvfgRfB6bE3gnd5F74Dhhtxw9a3NxBKZYS/29zN7e9II4DF
         vQP8Pgnra8RDw==
Date:   Tue, 15 Mar 2022 20:25:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        David Howells <dhowells@redhat.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the fscache tree
Message-ID: <20220315202512.62f54300@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ma3xAUNqD46t78qRuSO1dPh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ma3xAUNqD46t78qRuSO1dPh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  fs/9p/vfs_addr.c

between commit:

  0c31679cf2c0 ("netfs: Add a netfs inode context")

from the fscache tree and commit:

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

diff --cc fs/9p/vfs_addr.c
index ed06f3c34e98,76956c9d2af9..000000000000
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@@ -353,9 -370,9 +336,9 @@@ static bool v9fs_dirty_folio(struct add
  #endif
 =20
  const struct address_space_operations v9fs_addr_operations =3D {
 -	.readpage =3D v9fs_vfs_readpage,
 -	.readahead =3D v9fs_vfs_readahead,
 +	.readpage =3D netfs_readpage,
 +	.readahead =3D netfs_readahead,
- 	.set_page_dirty =3D v9fs_set_page_dirty,
+ 	.dirty_folio =3D v9fs_dirty_folio,
  	.writepage =3D v9fs_vfs_writepage,
  	.write_begin =3D v9fs_write_begin,
  	.write_end =3D v9fs_write_end,

--Sig_/ma3xAUNqD46t78qRuSO1dPh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwW3kACgkQAVBC80lX
0Gw3+wgAnuhLnQcEl5iPOuNEmAS4QP9WjsOoadxs1vBgVxcyHHzLQLjXDhhHxwNC
V1kj/z5uQfFToxiZW+J+TJCeyK5GHHB2/SEQLImxDQpJDynWP339tLpadw55OOIx
hHvlahzEaiefOfu+KabiDysNmhAiSTq6E3oU8oBXthmWq4WpUQ8OVx4hMG05eOLa
oNq3aQVpEq01l5LjWfuft3XCEiruahYT+f1JTraNpn8O/UsZrDF1VLgH/6N2bnwc
EqPL5GXGg+LSGy0tn6D3Xa1+bM6IIEcKZgdRNeXKjZlmhApREtjrplUS4TGJKTzI
B+GYT8WpsoiYYoG7gi/5pSEyQDqXHQ==
=GAOj
-----END PGP SIGNATURE-----

--Sig_/ma3xAUNqD46t78qRuSO1dPh--
