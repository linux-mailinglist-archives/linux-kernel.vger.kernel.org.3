Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AF7324D9800
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:46:11 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346822AbiCOJrJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:47:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49952 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346841AbiCOJrC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:47:02 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C4D94EF7F;
        Tue, 15 Mar 2022 02:45:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHpS55BRVz4xvk;
        Tue, 15 Mar 2022 20:45:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647337542;
        bh=B2q16DxJf4qus0TFrzh8qkvr3VyKVQHScRe8pQas1tQ=;
        h=Date:From:To:Cc:Subject:From;
        b=MpCpoT4U4EweSP2qmN9y2m2ydK3xHZU7zjDlDk+oDIX+ayJxTqgutRek0eG3PClPB
         0BPXgBvfKv3urq2BQkP2BsymGIvQQQ8ZdNF/Fh8yUAY6Y9sJrye34MwAXSHXdIvtQ1
         QwMiIgmX2MOa9nDApXCZZXHCt4cmMY2W6m+/a9fi/VKuSz2Om1nXSf6SGgv567r2Rb
         OlomYCiGA5HGuVRFmUtBPzy4diu0eBdqlWdLDVtIkYTBdyI///DEpmwEPM1HMb7p+N
         kC2U4HmeYIxa+X61o38ljQLZMv1XZhGlU0qiwG55CoMyfwROfNpxJYf0umaKpI6xKO
         dC/Ap6L0eI5VA==
Date:   Tue, 15 Mar 2022 20:45:40 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Trond Myklebust <trondmy@gmail.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Trond Myklebust <trond.myklebust@hammerspace.com>
Subject: linux-next: manual merge of the folio tree with the nfs tree
Message-ID: <20220315204540.4f9f6b66@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/L.30S/tm16ei2/Xmo.j67IE";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/L.30S/tm16ei2/Xmo.j67IE
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  fs/nfs/file.c

between commit:

  8786fde8421c ("Convert NFS from readpages to readahead")

from the nfs tree and commit:

  821405cf3ebb ("fs: Convert trivial uses of __set_page_dirty_nobuffers to =
filemap_dirty_folio")

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

diff --cc fs/nfs/file.c
index 81c80548a5c6,2df2a5392737..000000000000
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@@ -518,8 -514,8 +518,8 @@@ static void nfs_swap_deactivate(struct=20
 =20
  const struct address_space_operations nfs_file_aops =3D {
  	.readpage =3D nfs_readpage,
 -	.readpages =3D nfs_readpages,
 +	.readahead =3D nfs_readahead,
- 	.set_page_dirty =3D __set_page_dirty_nobuffers,
+ 	.dirty_folio =3D filemap_dirty_folio,
  	.writepage =3D nfs_writepage,
  	.writepages =3D nfs_writepages,
  	.write_begin =3D nfs_write_begin,

--Sig_/L.30S/tm16ei2/Xmo.j67IE
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwYEQACgkQAVBC80lX
0GwDNwf/cDTM2EEwg17YpJFU+i5AW0bvv12QQeu8RFOLjANVUsGxUbzYqeO5JwVn
8ZNE/7LOLrnT17McVjzVqx4UlcaWubtMo1uqVhoJyiT67A0PyQ6rEGJKIU78VX2F
4mmXeWRgoweODr7tCr8HfJSyM+6Gx16TU+G++D70EjbjzR3+k+ISq3huevlGUPgd
NuA4DXHK2ZXOQux+hH38l0Ag7TgZxXjNXC5AL+VncnRc7wgM8xZqGpmfoziSab6w
uhuM2ltkxeAqAhe6k2qv0vAnVi7/7rAsLXn2iL+xxjfyTIbZzbyMX5fbounJcA0Q
uwSNHwp7k8+bFgQDVYADaB2P9Xdx6w==
=kTIg
-----END PGP SIGNATURE-----

--Sig_/L.30S/tm16ei2/Xmo.j67IE--
