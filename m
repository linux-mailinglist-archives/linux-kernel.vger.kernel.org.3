Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 290C5575E5C
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 11:20:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229481AbiGOJUF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 05:20:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38970 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiGOJUD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 05:20:03 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99DD15F98A;
        Fri, 15 Jul 2022 02:20:01 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lkm666Rpfz4xXj;
        Fri, 15 Jul 2022 19:19:58 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657876800;
        bh=DwsFSwXzYbJyvmexY1lfoxg4soPoIZNKP9oPL8Oe2QY=;
        h=Date:From:To:Cc:Subject:From;
        b=gBShlSqETpygiIuVsnRryAut+u+r2jFwlZsidRp1h6kGPJz7br4Q+RCHNkDe3J5Mg
         gtgEQUbU1PaUV1kdVqwTxObIEAXKNTfwU4u2gMvS5oyELj1FWkGYr5udtBqihgr9Eb
         Ic4tRK6EQMNA4jLJ02OicYMUSwC/bFGr2X7gObaGQRq1MXCBMAO4u3HVANyNCsEkDM
         gzZnk00F60QJlTZTtwWNuEflqOgWaV1NtQgGWOQtNuRwep5tmpjuEvdlgv9TSeEtbH
         ySFoL9IqgdBy+fTs86inehjfe5pV+G9KkS/0EmyyQXWWN0+TD7ajfC/pxrawPEIPPS
         KocG9Z914KLKQ==
Date:   Fri, 15 Jul 2022 19:19:57 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>, Jens Axboe <axboe@kernel.dk>
Cc:     Bart Van Assche <bvanassche@acm.org>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the block tree
Message-ID: <20220715191957.63d3d644@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/syXU_ujpZLgbG6j3cSzLV1C";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/syXU_ujpZLgbG6j3cSzLV1C
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  fs/buffer.c

between commit:

  1420c4a549bf ("fs/buffer: Combine two submit_bh() and ll_rw_block() argum=
ents")

from the block tree and commit:

  215e71b6ee7a ("fs: remove the nobh helpers")

from the folio tree.

I fixed it up (the latter removed some code that was updated by the
former) and can carry the fix as necessary. This is now fixed as far as
linux-next is concerned, but any non trivial conflicts should be mentioned
to your upstream maintainer when your tree is submitted for merging.
You may also want to consider cooperating with the maintainer of the
conflicting tree to minimise any particularly complex conflicts.

BTW: the latter commit missed a reference to nobh_write_begin in
Documentation/filesystems/porting.rst.

--=20
Cheers,
Stephen Rothwell

--Sig_/syXU_ujpZLgbG6j3cSzLV1C
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLRMT4ACgkQAVBC80lX
0GyJWwgAlFtRgC8ZcJ2X7QhKClWh6NaYM7tz5HZ1lPX3ewo0KzlD6gvZ5MkIjSYl
iP9eImd8LQ++tjUvD70kmO+GgBexom7c7oNWqE5svki0TYxLt7qufOk/QRuw9qU4
z3TPbPM99dKW7PUIxp309RlhmjaF+UsgL/IJSdB6ZwtJcd9gJBaEfVRWDbGWsff0
40IK6zaCbeSca1qIBvXdd/SyxGDO4kJVZi7G87qUQccxCDlZdGrYoZqu9YyPH2fH
pvrKnWkqO9VJwt8oPAtJUshMhBqoRcxm0lKwPYZIt3vJtVy669RMzDDuI334x4Gp
pMkj73mTx/qfLqTGQG/NBxvOL/1ddA==
=Eg9H
-----END PGP SIGNATURE-----

--Sig_/syXU_ujpZLgbG6j3cSzLV1C--
