Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AC0E85A8B68
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 04:28:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232731AbiIAC1v (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 22:27:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231863AbiIAC1s (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 22:27:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C6BB4136B16;
        Wed, 31 Aug 2022 19:27:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MJ4hF3pfqz4x2c;
        Thu,  1 Sep 2022 12:27:41 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1661999261;
        bh=FBxtmbKqj6TXD7iuqDZOeoh7vrmkblb7nRITq3ztMzo=;
        h=Date:From:To:Cc:Subject:From;
        b=lQGHyl2e/O9haF/1U7W9jgQrzN4BILSMXwech9a4UlYAiBOGahRnmN8DSQcRKA0cH
         Wj5/vk86or8ZlWCA/zEgXkJEWe3RXvAD+xqdq2XZShQEHMxazOdJD7lRdRfidKKScS
         /1aoAE7gG3jl95tG+ucemUWjzLyAn4ok1jYfPsRVStgQlCSWcuZ2+gC0fzugSKIvYQ
         ArZwJcypjXIyw72VK2Rw0SBVZB7PPT8SQbxedAKMTupHRLDukeBnr6++OMRF5a2yWB
         YNuBqdtmCevp0XO9+AwUhzcEjpw9Z06M3HfCiZe6GyvaBYhSAeTAp4WbVJxwtZQVnt
         8ZnShs7Jxap9g==
Date:   Thu, 1 Sep 2022 12:27:39 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Paul Moore <paul@paul-moore.com>
Cc:     Frederick Lawler <fred@cloudflare.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the security tree with Linus' tree
Message-ID: <20220901122739.6d1a54ef@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Y53GLRayyBTnjkPW3d=PS/0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Y53GLRayyBTnjkPW3d=PS/0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the security tree got a conflict in:

  security/selinux/include/classmap.h

between commit:

  f4d653dcaa4e ("selinux: implement the security_uring_cmd() LSM hook")

from Linus' tree and commit:

  ed5d44d42c95 ("selinux: Implement userns_create hook")

from the security tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc security/selinux/include/classmap.h
index 1c2f41ff4e55,0bff55bb9cde..000000000000
--- a/security/selinux/include/classmap.h
+++ b/security/selinux/include/classmap.h
@@@ -253,7 -253,9 +253,9 @@@ const struct security_class_mapping sec
  	{ "anon_inode",
  	  { COMMON_FILE_PERMS, NULL } },
  	{ "io_uring",
 -	  { "override_creds", "sqpoll", NULL } },
 +	  { "override_creds", "sqpoll", "cmd", NULL } },
+ 	{ "user_namespace",
+ 	  { "create", NULL } },
  	{ NULL }
    };
 =20

--Sig_/Y53GLRayyBTnjkPW3d=PS/0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMQGJsACgkQAVBC80lX
0GwzKgf6A8GuGNucvhy2hQ6/yXy2lMoasWgG/D7ugb9TNrJvt0CZvwnErymCeXjQ
KOiaYN9n5w1ZB7JkZveiixaz8nTAl4YLpiZmdTCHmv15eRBX/5u59kwqtBevD4/x
SNrIViYU19FCourm4TBEeNYWCa2QZ/GNTvUbxGbBci6MaegCuVLp9knlvqlAeGLJ
T3IJON+eYXQKM0PzapOsMjzdof3GzJuSeOl5Qo58bPSWYQ2pZ1HOdrnwhPyBkYwD
IIvzU6DBIRszWhtAjfYTZs8vKoncIzaryhSiKW6NbX2+4j1vuX/BgzbCeL3pQl7s
Hwei4rhHG3B42q3WCVs/OAHi0O4mfg==
=2n+a
-----END PGP SIGNATURE-----

--Sig_/Y53GLRayyBTnjkPW3d=PS/0--
