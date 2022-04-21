Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4CDCF5096F0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 07:43:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1384523AbiDUFqA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 01:46:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229489AbiDUFp6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 01:45:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2B1981274D;
        Wed, 20 Apr 2022 22:43:09 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KkRK759nCz4xL5;
        Thu, 21 Apr 2022 15:43:07 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1650519787;
        bh=A0d1oDkLx2i4u1iqO0IYJwRmbQ5WwdMj1yn4YX/QF/Q=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=eeHoRd2vMvt8qO47CbwGUHT+FBRb3D9anzwAiKz2Tp5gM1gCGDAgyNRjghqLjOy52
         0doNSWlZrW9YOUagJba6ksJtHxVE3mzfrGrjSOMQbVqridbLF/exE8r7DYjhA9KIzq
         idFHgabD7moKQffNtxbw8/soQFC06WIWoUNUB6R8AIRJjp5+erijAR7/4eXpYEjRbM
         u4RuA+SrOcPl1LEQSL2m2jfNAzVFOYRSAmSNJy6pe2s/Hd5cJJ4V3XZ3i9sM2EKFi1
         paZYZNJuzeKmrJ/PrOZEXzQsRMO3ks3JSFxJhKpdIAY1Zpsq73R533cUVBLH44ob/Z
         JWZspPbeqXFBQ==
Date:   Thu, 21 Apr 2022 15:43:06 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the block tree
Message-ID: <20220421154306.397748ac@canb.auug.org.au>
In-Reply-To: <20220421120203.2102b554@canb.auug.org.au>
References: <20220421120203.2102b554@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ZAzyDtB48JzoZhb4.NcG2fp";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ZAzyDtB48JzoZhb4.NcG2fp
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 21 Apr 2022 12:02:03 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> fs/io_uring.c: In function '__io_sqe_files_unregister':
> fs/io_uring.c:8992:13: warning: unused variable 'i' [-Wunused-variable]
>  8992 |         int i;
>       |             ^
>=20
> Introduced by commit
>=20
>   16b217ed7bb3 ("io_uring: store SCM state in io_fixed_file->file_ptr")

This become a build failure for i386 defconfig, so I added the
following patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 21 Apr 2022 15:34:32 +1000
Subject: [PATCH] fix up for "io_uring: store SCM state in
 io_fixed_file->file_ptr"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 fs/io_uring.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/fs/io_uring.c b/fs/io_uring.c
index 1f6004ba0463..9ace35873810 100644
--- a/fs/io_uring.c
+++ b/fs/io_uring.c
@@ -8989,9 +8989,9 @@ static void io_free_file_tables(struct io_file_table =
*table)
=20
 static void __io_sqe_files_unregister(struct io_ring_ctx *ctx)
 {
+#if !defined(IO_URING_SCM_ALL)
 	int i;
=20
-#if !defined(IO_URING_SCM_ALL)
 	for (i =3D 0; i < ctx->nr_user_files; i++) {
 		struct file *file =3D io_file_from_index(ctx, i);
=20
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/ZAzyDtB48JzoZhb4.NcG2fp
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJg7uoACgkQAVBC80lX
0Gwa9gf8DD6mAHO4H4aZuVCbiqBWCyhIE2FH5+qN81T05aWkag17R5OESmRKL0mx
qJjZ4erCdWQfQPngMWBXILKALRcnXtzrB56Ma04ocWO16EfKMJPjfrMbl0th+NtQ
DHDAyNPzUEe9iWOjeOPmNrq8e6IjgcDkRARtGlUo9Mp6gVI14ZW0g7ieTMPvSji6
Tsdbp/73eGQXoH5WuAEPAATY2Y2scD3gQgB3hNyMsAmFx3yugrYWKKuNr4GsfYmg
lWV4HDAWWnfC7Xr10UK3LS8aLG7//b1D6dALozAyKhmDruHYUWwCOWLgfMpyJjN5
Etvhv5vhdhH8e1uhDNy54nHDZeYUaw==
=Qhoa
-----END PGP SIGNATURE-----

--Sig_/ZAzyDtB48JzoZhb4.NcG2fp--
