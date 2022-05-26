Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B0ABB5347B2
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 02:47:42 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241532AbiEZAr1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 25 May 2022 20:47:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35932 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345330AbiEZArP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 25 May 2022 20:47:15 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 42C3A65B6;
        Wed, 25 May 2022 17:46:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L7q576JFYz4xD7;
        Thu, 26 May 2022 10:46:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1653526012;
        bh=prRDMbc48ZhiOQbW7OeU9AvVQRnsu/2pVUDXu6O8GRo=;
        h=Date:From:To:Cc:Subject:From;
        b=CGmxWPoEAAV0A5GIyTONt7wgrP/PxU4543afU10SSfXrl7ko8qt6C1Z9Aq8IrxmJx
         ucBdWDlU1qdn425eAZJQeQGwu5036JgWQxu5adYfpAaTPXrLCCcU/Hyn13bhy3+aBe
         EDy2lPGoJ7mWi3E+YqkrW5Vw676wPuMn8b+4ML8xkIw42oPu7csis/u7VDbfPRXhgp
         jFYeQdNqF+ERBdy+AP2KdmuaMyxSWuoxW9dpFKADFkI2JPmHFbrOZLKalqZZnj3zgm
         la/wq+5HSadXIRE+UJ6FWLckLclEn5ZyyZBic8iPxEcv1P3DgLIbYRHNSV816f3n99
         AK1gW2vlRaCng==
Date:   Thu, 26 May 2022 10:46:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jeff Layton <jlayton@kernel.org>,
        Ilya Dryomov <idryomov@gmail.com>,
        David Howells <dhowells@redhat.com>
Cc:     Jakob Koschel <jakobkoschel@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the ceph tree with the fscache tree
Message-ID: <20220526104650.73fc943f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lVEfP7kHOadeEQiyB/kpruW";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lVEfP7kHOadeEQiyB/kpruW
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the ceph tree got a conflict in:

  fs/ceph/caps.c

between commit:

  713423282ae1 ("netfs: Fix gcc-12 warning by embedding vfs inode in netfs_=
i_context")

from the fscache tree and commit:

  3ffa9d6f991f ("ceph: replace usage of found with dedicated list iterator =
variable")

from the ceph tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ceph/caps.c
index a0467bca39fa,bf2e94005598..000000000000
--- a/fs/ceph/caps.c
+++ b/fs/ceph/caps.c
@@@ -3181,11 -3202,10 +3202,10 @@@ void ceph_put_cap_refs_no_check_caps(st
  void ceph_put_wrbuffer_cap_refs(struct ceph_inode_info *ci, int nr,
  				struct ceph_snap_context *snapc)
  {
 -	struct inode *inode =3D &ci->vfs_inode;
 +	struct inode *inode =3D &ci->netfs.inode;
- 	struct ceph_cap_snap *capsnap =3D NULL;
+ 	struct ceph_cap_snap *capsnap =3D NULL, *iter;
  	int put =3D 0;
  	bool last =3D false;
- 	bool found =3D false;
  	bool flush_snaps =3D false;
  	bool complete_capsnap =3D false;
 =20

--Sig_/lVEfP7kHOadeEQiyB/kpruW
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKOzfoACgkQAVBC80lX
0Gy+Twf9H1wwOql1ft1TnkVW/nFJVJEEwdskdwc5jrpx/q2gIjKsKH03RWZcbfyN
9FjEXKTvQsCuRdJSscHzEcxlcsBlYOgtQUp7vPTzFEWRfGehLRBDXTCTJdGQ1NVU
mHtbBpaD9xiYQXE96iIvyH00db/S2tdk5X71RlCTefT4/DIcipdbLu9u2NqjX5qK
jXCFzUU1wmKyNuDrM8oZBdRBWRAFZ9ncP35aRqslJWNioS1sUHfCoKI3NHi6STkH
W6Te1VGg1dyMNcNTmodHwWjoXdachcUoDyZMapTp//Gn27wzCgn92WAzC8KkDBcX
j1gyjAdWR45ElXREfMkwPXiZpRQ0LA==
=pAr8
-----END PGP SIGNATURE-----

--Sig_/lVEfP7kHOadeEQiyB/kpruW--
