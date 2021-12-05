Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71A18468D8F
	for <lists+linux-kernel@lfdr.de>; Sun,  5 Dec 2021 23:08:02 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239695AbhLEWL0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 5 Dec 2021 17:11:26 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50506 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232884AbhLEWL0 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 5 Dec 2021 17:11:26 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 844D6C061714;
        Sun,  5 Dec 2021 14:07:58 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J6gfh2cgcz4xZ4;
        Mon,  6 Dec 2021 09:07:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638742077;
        bh=6h0wSDGsvmTCrdP8xvEBwqI2YJx6kc+Q7KRhnUKa8fY=;
        h=Date:From:To:Cc:Subject:From;
        b=S16q1b4G6MW1axyjzhoKDIKboBWDNthq9z5d8Nc4r+bVl+Khm4IX9xnEFlZSWtAcl
         gr2EXylpMQyOs5wMzZKukdOiLt63uPE4Ea5/ZXhkf0Mr+sKcBtO3FpIlrHjBnnvNEN
         CEpnNIOoOmTy6XSA3yRxo0ND6JzJv+sQrSfo7WXEER2Mjfz5qj1kTKoa4Tjp7CS8aU
         RfIL92UgEgCo0WfjNBxqTuJO73x21eH+eOPCOoRnFlHluKrmThjJKX3BP1xrOS4Uox
         NuwcFic+yxV1iSB+L+5hEaDdEg3nVjbhrCcmT+WW31l9gFBb5cGNjH6iGhEqVrxFWO
         Ge5bPt8JCjHRw==
Date:   Mon, 6 Dec 2021 09:07:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     David Howells <dhowells@redhat.com>,
        Christian Brauner <christian@brauner.io>
Cc:     Christian Brauner <christian.brauner@ubuntu.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the fscache tree with the pidfd tree
Message-ID: <20211206090755.3c6f6fe4@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/WVfD4oGjTTzDLtx2C9SFd9/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/WVfD4oGjTTzDLtx2C9SFd9/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the fscache tree got a conflict in:

  fs/cachefiles/bind.c

between commit:

  bb49e9e730c2 ("fs: add is_idmapped_mnt() helper")

from the pidfd tree and commit:

  d18c9010376b ("cachefiles: Delete the cachefiles driver pending rewrite")

from the fscache tree.

I fixed it up (the latter deleted the file, so I did that and then added
the following patch) and can carry the fix as necessary. This is now fixed
as far as linux-next is concerned, but any non trivial conflicts should
be mentioned to your upstream maintainer when your tree is submitted for
merging.  You may also want to consider cooperating with the maintainer
of the conflicting tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 6 Dec 2021 09:05:07 +1100
Subject: [PATCH] fix up for "fs: add is_idmapped_mnt() helper"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/cachefiles/cache.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/cachefiles/cache.c b/fs/cachefiles/cache.c
index 327cea71557f..e0aa8bf429b8 100644
--- a/fs/cachefiles/cache.c
+++ b/fs/cachefiles/cache.c
@@ -44,7 +44,7 @@ int cachefiles_add_cache(struct cachefiles_cache *cache)
 	root =3D path.dentry;
=20
 	ret =3D -EINVAL;
-	if (mnt_user_ns(path.mnt) !=3D &init_user_ns) {
+	if (is_idmapped_mnt(path.mnt)) {
 		pr_warn("File cache on idmapped mounts not supported");
 		goto error_unsupported;
 	}
--=20
2.33.0

--=20
Cheers,
Stephen Rothwell

--Sig_/WVfD4oGjTTzDLtx2C9SFd9/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGtODsACgkQAVBC80lX
0GyIBgf/SGTgJ4GWZbcqtcaU/T3lz2pozw8SpNki1sg5P3shIAEN76y9CKKkSFV5
tlNg4lJ6wjpVLuDfcv5Bp7+fkGoEGXR6k6C2NYII5ZIB3z2pzNJhpt6PW2vjupTi
fuwW48+DTebjBn5u5SePNxptWgYLTzQJWRXe7kmOrYgvLpTeQWjDoOWV4sRiL5oK
G/wEGgq2gJY50dWxGsDEMz/1cP5wausWaQYw3+KI8n25hj9blijDG7ULLzq00x7t
Jq+h0pBLgQ85zBLJB5btO3YSDowzAH4bDURVRFaw7IWDUrrnfFW35eygg4WQiTdI
YjffViN7B6piQ+Pp6Q5iRnzeRnlZZw==
=2mwl
-----END PGP SIGNATURE-----

--Sig_/WVfD4oGjTTzDLtx2C9SFd9/--
