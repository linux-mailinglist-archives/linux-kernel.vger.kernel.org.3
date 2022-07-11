Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E5FA56D395
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 05:57:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229518AbiGKD52 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 10 Jul 2022 23:57:28 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48844 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229450AbiGKD51 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 10 Jul 2022 23:57:27 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B30013D7D;
        Sun, 10 Jul 2022 20:57:25 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lh97h65L5z4xXj;
        Mon, 11 Jul 2022 13:57:20 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657511841;
        bh=KQskN7D/ihsHkEXuOZsuXy3rdzCZRnA8KSvLRAza8kQ=;
        h=Date:From:To:Cc:Subject:From;
        b=DAWMzWS8Bc6WNREdH9ogYwHnsj/qqMCYI7hGUKW+TpT1euzwMBd4zPLyMSbLQfX6G
         CJxyRlByo9HPKNKLbuvQlNkKZV8ohhIDcmd7gIVtnXu3Hu1iwx2Z8cLpFdvSkNn0bk
         5T97pG5fGEem0IrfQaIAjTuz3kxTzVvmiox6tcCMPNVcVq3GI0BcEoaTt5jG3a6eAw
         jh/Njq29pV/W9hPwq5yaxeqJY0qFxUUWPAYptiyTbToCf5eZJMe7JWnVWWSAXwSgIi
         utkzUikRXrKZ4BsE2spbq2JUiUnrMA9cd1Fu9uQtvsz5AKIN9qdMkeIwvMiaD+usyD
         Ix16Ve2VxN9SQ==
Date:   Mon, 11 Jul 2022 13:57:19 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>, Al Viro <viro@zeniv.linux.org.uk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the block tree with the vfs tree
Message-ID: <20220711135719.06f94e4c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/DBlix48vEa_Z7n+nCsoCSLt";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/DBlix48vEa_Z7n+nCsoCSLt
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/io_uring.c

between commit:

  164f4064ca81 ("keep iocb_flags() result cached in struct file")

from the vfs tree and commits:

  239b2db7c7ca ("io_uring: move to separate directory")
  9d6c15adf84b ("io_uring: move read/write related opcodes to its own file")

from the block tree.

I fixed it up (I deleted the file and adde the following merge fix patch)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 11 Jul 2022 13:47:50 +1000
Subject: [PATCH] fixup for "keep iocb_flags() result cached in struct file"

interacting with "io_uring: move to separate directory" and
"io_uring: move read/write related opcodes to its own file".

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 io_uring/rw.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/rw.c b/io_uring/rw.c
index ca0d3a72364a..bc10b8c7cc86 100644
--- a/io_uring/rw.c
+++ b/io_uring/rw.c
@@ -666,7 +666,7 @@ static int io_rw_init_file(struct io_kiocb *req, fmode_=
t mode)
 	if (!io_req_ffs_set(req))
 		req->flags |=3D io_file_get_flags(file) << REQ_F_SUPPORT_NOWAIT_BIT;
=20
-	kiocb->ki_flags =3D iocb_flags(file);
+	kiocb->ki_flags =3D file->f_iocb_flags;
 	ret =3D kiocb_set_rw_flags(kiocb, rw->flags);
 	if (unlikely(ret))
 		return ret;
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/DBlix48vEa_Z7n+nCsoCSLt
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLLn6AACgkQAVBC80lX
0Gz7xAgAiDigFGGHAxyRBxvD3Gf2yEZHDSoc3rX811auXammIOLD7qG9omN872gq
7FdfPQovD/+YK/+E4j204kb5CQCQDGG5W1UV+cgSSLD82FbO+alIyLhymYmhXhn+
fSq5Eza96D6bynDPaBQHi/6UpKWHHuWQR0SL2Pih+rbrprOtwKKU6B8gWsjaqPPz
mw5ff/H7hCe+qlnU3Zjhtoii0fb1zzFHqXj+kibqpfoB/mMKff8TAEqx38WPSH0R
WP1DGH+7fN9xyxfPKNVsMlfz7S+P8T35Zkwb9i/KHjc9x8mXwAklq6PCm8Iz2iYI
Qy38JbflckPSgIt2ULblo/XhStuHSw==
=NF/I
-----END PGP SIGNATURE-----

--Sig_/DBlix48vEa_Z7n+nCsoCSLt--
