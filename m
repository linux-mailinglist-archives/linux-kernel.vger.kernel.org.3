Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 84817517D3C
	for <lists+linux-kernel@lfdr.de>; Tue,  3 May 2022 08:15:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229677AbiECGS1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 3 May 2022 02:18:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229473AbiECGSW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 3 May 2022 02:18:22 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1E7A735DF5;
        Mon,  2 May 2022 23:14:48 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KsqS60S2bz4xXg;
        Tue,  3 May 2022 16:14:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1651558486;
        bh=pcjgFfuwYPGpDnkm+A7FAMuKB4tCK9AX1CrKqI6Bsag=;
        h=Date:From:To:Cc:Subject:From;
        b=LBFPXLryB1zzEdhTnzlxFOOltSPMG4acXFTScC7GsBveRiRm64Slip/6EDvGmIt/O
         /sjWHj2y5Y7XxzdfM5/TwYLFy+s8mlV4v4ncyOfKJ9VyIoU38FqybaHHTME3sWr0xE
         I3iAfIRWZiKKhAjFxX+ZpAY8bl+V5fkrkaf2v0DQv5Sur/yA+o29svQdPRXn0X9vJo
         lcqKUN1pffgyoAc2K2yqusdG8AbSsMuApG19YjP/BbXiRWqOg56Pvx4aR2ghynLmk0
         rt27umxD8ruqUJojXG300W6aWPp85PQHzcCTlWTtA0aVqXHE12nC6aHyTR8QKjNb6d
         kep1k3ZkxtROQ==
Date:   Tue, 3 May 2022 16:14:44 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        NeilBrown <neilb@suse.de>
Subject: linux-next: manual merge of the mm tree with the folio tree
Message-ID: <20220503161444.11003568@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/1gPwzsRHU=3JxRPXg2Xm+=i";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/1gPwzsRHU=3JxRPXg2Xm+=i
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  fs/nfs/file.c

between commit:

  9ac3e82e9ae2 ("nfs: Convert to release_folio")

from the folio tree and commit:

  e1736b007c43 ("VFS: Add FMODE_CAN_ODIRECT file flag")

from the mm tree.

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
index d764b3ce7905,bfb4b707b07e..000000000000
--- a/fs/nfs/file.c
+++ b/fs/nfs/file.c
@@@ -522,8 -537,7 +534,7 @@@ const struct address_space_operations n
  	.write_begin =3D nfs_write_begin,
  	.write_end =3D nfs_write_end,
  	.invalidate_folio =3D nfs_invalidate_folio,
 -	.releasepage =3D nfs_release_page,
 +	.release_folio =3D nfs_release_folio,
- 	.direct_IO =3D nfs_direct_IO,
  #ifdef CONFIG_MIGRATION
  	.migratepage =3D nfs_migrate_page,
  #endif

--Sig_/1gPwzsRHU=3JxRPXg2Xm+=i
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJwyFQACgkQAVBC80lX
0Gy23Qf+K2XunRfxW+J5XLeo0E7gvn1LHFWgspLBWoPRNof4X8Q5BECLqQgCLkQK
Jv/58QjSXPLmCliy5VAqao0mRhg1rWyzb7GIiSUZhvHjhaivpXjaFzWp4Rwz07VT
NrFkudt+fxt/8WF0LkgfTFkS8xLJE1jAva3zDYHrZJBD/BltHKCpCyPVG9QAozb3
vKrJ+4XnoluY3O2rLp6WjC2Ma7l0e8Ra0qXlvV5lWZVbhZepyNjeBQKoq1Va2JX6
zsXH8eV0c7QM5twiC3CMV5jJV4Vl3HWqjlpjkTywyfiFQol1iBhBrpG2BhWSDxuM
TMO5SSHzzySnkwVF58Y1dTmNr4GIMg==
=FOhL
-----END PGP SIGNATURE-----

--Sig_/1gPwzsRHU=3JxRPXg2Xm+=i--
