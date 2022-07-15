Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A0DD05761C2
	for <lists+linux-kernel@lfdr.de>; Fri, 15 Jul 2022 14:34:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233069AbiGOMeL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 15 Jul 2022 08:34:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48332 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234250AbiGOMdz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 15 Jul 2022 08:33:55 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 100AE13CF5;
        Fri, 15 Jul 2022 05:33:54 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LkrPr2PlXz4xXj;
        Fri, 15 Jul 2022 22:33:52 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1657888432;
        bh=4lUg+65kneLGl7gYSIshGHUepuaNzX+XMZkKnDR7tT4=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=qL27tNYTbuy6rpBcH48cwqvXTbf6YuW89b+ZKQhLh6x1P0tzqJMGYuF2rBKnV+y0S
         g3hr3UKj2hYci7bd6bYXB9inHMNz8MzUvAulZbM5TO2XwqaxPc72DCpMVhftfH5sLX
         Q5m/FC7eeEzSjRh8udzaH9eP9usStbqKR7hxLoZXJZ1eXR2w80DD1Rho2WLy0FDRcz
         e+wDYC0xHFXC0+XzARWADnh7dj+39gpToqsU1lqG6gXPLsuXb4QPKSnM6P/gxEIyse
         /vzNhdkrHiWs88keA4Xc6W1X+Y+u3VAMYxdE8ssJkEr10ZUgikOo6KhdRfjfs8vgVZ
         08MrtVZX5o2SA==
Date:   Fri, 15 Jul 2022 22:33:51 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Dylan Yudaken <dylany@fb.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the block tree
Message-ID: <20220715223351.2e8c856e@canb.auug.org.au>
In-Reply-To: <20220715135232.74b81bec@canb.auug.org.au>
References: <20220715135232.74b81bec@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lBfOV4Gxbf1czM/GxNJwJhc";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lBfOV4Gxbf1czM/GxNJwJhc
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Fri, 15 Jul 2022 13:52:32 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> In file included from include/linux/slab.h:16,
>                  from io_uring/net.c:5:
> io_uring/net.c: In function 'io_recvmsg_multishot_overflow':
> include/linux/overflow.h:67:22: warning: comparison of distinct pointer t=
ypes lacks a cast
>    67 |         (void) (&__a =3D=3D &__b);                  \
>       |                      ^~
> io_uring/net.c:332:13: note: in expansion of macro 'check_add_overflow'
>   332 |         if (check_add_overflow(sizeof(struct io_uring_recvmsg_out=
),
>       |             ^~~~~~~~~~~~~~~~~~
> include/linux/overflow.h:68:22: warning: comparison of distinct pointer t=
ypes lacks a cast
>    68 |         (void) (&__a =3D=3D __d);                   \
>       |                      ^~
> io_uring/net.c:332:13: note: in expansion of macro 'check_add_overflow'
>   332 |         if (check_add_overflow(sizeof(struct io_uring_recvmsg_out=
),
>       |             ^~~~~~~~~~~~~~~~~~
> include/linux/overflow.h:67:22: warning: comparison of distinct pointer t=
ypes lacks a cast
>    67 |         (void) (&__a =3D=3D &__b);                  \
>       |                      ^~
> io_uring/net.c:335:13: note: in expansion of macro 'check_add_overflow'
>   335 |         if (check_add_overflow(hdr, iomsg->controllen, &hdr))
>       |             ^~~~~~~~~~~~~~~~~~
>=20
> Introduced by commit
>=20
>   a8b38c4ce724 ("io_uring: support multishot in recvmsg")

This became a build failure in my i386 defconfig build.  So I have
applied the following (probably not correct) patch that makes it build.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 15 Jul 2022 21:55:32 +1000
Subject: [PATCH] fix up for "io_uring: support multishot in recvmsg"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 io_uring/net.c | 4 ++--
 1 file changed, 2 insertions(+), 2 deletions(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 616d5f04cc74..187822e18dd6 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -329,10 +329,10 @@ static bool io_recvmsg_multishot_overflow(struct io_a=
sync_msghdr *iomsg)
 {
 	unsigned long hdr;
=20
-	if (check_add_overflow(sizeof(struct io_uring_recvmsg_out),
+	if (check_add_overflow((unsigned long)sizeof(struct io_uring_recvmsg_out),
 			       (unsigned long)iomsg->namelen, &hdr))
 		return true;
-	if (check_add_overflow(hdr, iomsg->controllen, &hdr))
+	if (check_add_overflow(hdr, (unsigned long)iomsg->controllen, &hdr))
 		return true;
 	if (hdr > INT_MAX)
 		return true;
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/lBfOV4Gxbf1czM/GxNJwJhc
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLRXq8ACgkQAVBC80lX
0GzTOAgAopI7rp2ln4TRvOS2Bw/kot8mIvaSyqzVVCRjLdbWjbHOC4+BwEjwCFXC
vzBCkRaV5+/bfJ5Z3QTjfMQXGwsHWRrPHvnNDIoxLpDbc/Ap1hR+P//5m8HRFbkz
jSeHzvh7/zhIzWG8PUPxXOFSG7okqx+qMz1dZe/LAN4W0KRMd8WyfubUI/X4KVL7
VB+pPLBVUpEqt21X0FI6mZ+FYPekrjedFHDkCYxVgRPNpTWRYsbeIAH+RQpT7fzF
yJUHlQNUBBsHUfzvVT65jj2f/kpO8rIPZ8lPsz/xc/PKuB+6N/49L++bgPFgBgJr
o63y8APBYIgoMaoNx5Wm6VGZkBnB8A==
=zv9s
-----END PGP SIGNATURE-----

--Sig_/lBfOV4Gxbf1czM/GxNJwJhc--
