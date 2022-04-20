Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 292BD507ECE
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 04:31:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1358935AbiDTCdy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 19 Apr 2022 22:33:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57882 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348564AbiDTCdw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 19 Apr 2022 22:33:52 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 312321275B;
        Tue, 19 Apr 2022 19:31:07 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kjl604cmfz4xPw;
        Wed, 20 Apr 2022 12:31:04 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650421865;
        bh=DfqXzl0sPhTJzPg2q8U2567VFNyq66obR8axj9VQxQA=;
        h=Date:From:To:Cc:Subject:From;
        b=G93g5VKcdprpPDC+dmYDTosLyJsV2uK7/HqifhL8JUiW/VtIwRrDk+E+C5BokhX01
         LQlwguVYoE3qK7TzHaPnHesBSdUjtxYfD1cOvmbiRrGFiaM198fvcICvMUTUo7N+AN
         /t1W/cLxQ7hLeHTJtrL4Fdvr5i51KZmz2tDCK2mIjbzsuKN6SEj+gnspDGVUw/NOJ1
         FiFZZD4YY4kMi6wSTbHfvOcHdva7Eohn7BhoqVSwANP7QlAXErKCx52zxVPKVX2kRn
         8ka3lY8vlB01w1H/JxiWZnVLpGC1CEnyCP5s8Q4mYXfiqw1nYx2L9L2hiD9RiFcP13
         xJzEq0/uVwxkA==
Date:   Wed, 20 Apr 2022 12:31:02 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Christian Brauner <brauner@kernel.org>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Stefan Roesch <shr@fb.com>
Subject: linux-next: manual merge of the block tree with Linus' tree
Message-ID: <20220420123102.17ffe114@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S.xQ_Q3wU_OJVLZ6fVb3KB9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S.xQ_Q3wU_OJVLZ6fVb3KB9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the block tree got a conflict in:

  fs/xattr.c

between commit:

  705191b03d50 ("fs: fix acl translation")

from Linus' tree and commits:

  f8b398dcacfe ("fs: split off setxattr_copy and do_setxattr function from =
setxattr")
  8997d04977f5 ("fs: split off do_getxattr from getxattr")

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

diff --cc fs/xattr.c
index 998045165916,0b9f296a7071..000000000000
--- a/fs/xattr.c
+++ b/fs/xattr.c
@@@ -557,26 -556,60 +556,61 @@@ int setxattr_copy(const char __user *na
  	if (error < 0)
  		return error;
 =20
- 	if (size) {
- 		if (size > XATTR_SIZE_MAX)
+ 	error =3D 0;
+ 	if (ctx->size) {
+ 		if (ctx->size > XATTR_SIZE_MAX)
  			return -E2BIG;
- 		kvalue =3D kvmalloc(size, GFP_KERNEL);
- 		if (!kvalue)
- 			return -ENOMEM;
- 		if (copy_from_user(kvalue, value, size)) {
- 			error =3D -EFAULT;
- 			goto out;
+=20
+ 		ctx->kvalue =3D vmemdup_user(ctx->cvalue, ctx->size);
+ 		if (IS_ERR(ctx->kvalue)) {
+ 			error =3D PTR_ERR(ctx->kvalue);
+ 			ctx->kvalue =3D NULL;
  		}
- 		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) =3D=3D 0) ||
- 		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) =3D=3D 0))
- 			posix_acl_fix_xattr_from_user(mnt_userns, d_inode(d),
- 						      kvalue, size);
  	}
 =20
- 	error =3D vfs_setxattr(mnt_userns, d, kname, kvalue, size, flags);
- out:
- 	kvfree(kvalue);
+ 	return error;
+ }
+=20
+ static void setxattr_convert(struct user_namespace *mnt_userns,
 -			struct xattr_ctx *ctx)
++			struct dentry *d, struct xattr_ctx *ctx)
+ {
+ 	if (ctx->size &&
+ 		((strcmp(ctx->kname->name, XATTR_NAME_POSIX_ACL_ACCESS) =3D=3D 0) ||
+ 		(strcmp(ctx->kname->name, XATTR_NAME_POSIX_ACL_DEFAULT) =3D=3D 0)))
 -		posix_acl_fix_xattr_from_user(mnt_userns, ctx->kvalue, ctx->size);
++		posix_acl_fix_xattr_from_user(mnt_userns, d_inode(d),
++					      ctx->kvalue, ctx->size);
+ }
+=20
+ int do_setxattr(struct user_namespace *mnt_userns, struct dentry *dentry,
+ 		struct xattr_ctx *ctx)
+ {
 -	setxattr_convert(mnt_userns, ctx);
++	setxattr_convert(mnt_userns, dentry, ctx);
+ 	return vfs_setxattr(mnt_userns, dentry, ctx->kname->name,
+ 			ctx->kvalue, ctx->size, ctx->flags);
+ }
+=20
+ static long
+ setxattr(struct user_namespace *mnt_userns, struct dentry *d,
+ 	const char __user *name, const void __user *value, size_t size,
+ 	int flags)
+ {
+ 	struct xattr_name kname;
+ 	struct xattr_ctx ctx =3D {
+ 		.cvalue   =3D value,
+ 		.kvalue   =3D NULL,
+ 		.size     =3D size,
+ 		.kname    =3D &kname,
+ 		.flags    =3D flags,
+ 	};
+ 	int error;
 =20
+ 	error =3D setxattr_copy(name, &ctx);
+ 	if (error)
+ 		return error;
+=20
+ 	error =3D do_setxattr(mnt_userns, d, &ctx);
+=20
+ 	kvfree(ctx.kvalue);
  	return error;
  }
 =20
@@@ -668,11 -694,10 +695,11 @@@ do_getxattr(struct user_namespace *mnt_
  	if (error > 0) {
  		if ((strcmp(kname, XATTR_NAME_POSIX_ACL_ACCESS) =3D=3D 0) ||
  		    (strcmp(kname, XATTR_NAME_POSIX_ACL_DEFAULT) =3D=3D 0))
 -			posix_acl_fix_xattr_to_user(mnt_userns, ctx->kvalue, error);
 +			posix_acl_fix_xattr_to_user(mnt_userns, d_inode(d),
- 						    kvalue, error);
- 		if (size && copy_to_user(value, kvalue, error))
++						    ctx->kvalue, error);
+ 		if (ctx->size && copy_to_user(ctx->value, ctx->kvalue, error))
  			error =3D -EFAULT;
- 	} else if (error =3D=3D -ERANGE && size >=3D XATTR_SIZE_MAX) {
+ 	} else if (error =3D=3D -ERANGE && ctx->size >=3D XATTR_SIZE_MAX) {
  		/* The file system tried to returned a value bigger
  		   than XATTR_SIZE_MAX bytes. Not possible. */
  		error =3D -E2BIG;

--Sig_/S.xQ_Q3wU_OJVLZ6fVb3KB9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJfcGYACgkQAVBC80lX
0GyM7wf9HIdZUFjzzkOSPSJ8/+HZa7iinGU4r4fW+y9iZ7c8R+kAi1MQizYk5fa0
Hzu4T37qawaAEKP/xmqpNKA71eTOygHgAxVEEiNiXRc0DEN2XfoIOddhQ19N7Glw
/evignRdcFonGNlTG+qwSQzQsZSr92xEafas0obk7cw5fCmtV2Vw/QdPeH5zMXzf
CVaCDY+TsYQaESqrRx0EZrBmChrDK++1AtD9YR0zTaFVCxbms6yERGle8X4cguZ5
MrI3bAWkEsyt/bMnkPYqdyXI1Ufau5iZyy3hsU/0yVBF3WRjrB25QaGe3kPTpVBv
E2qATCcK+9NmBOHGjvSmylvydsIGOQ==
=r6dH
-----END PGP SIGNATURE-----

--Sig_/S.xQ_Q3wU_OJVLZ6fVb3KB9--
