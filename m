Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ECDB357B626
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Jul 2022 14:11:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234814AbiGTMKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Jul 2022 08:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238637AbiGTMKf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Jul 2022 08:10:35 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5C52226AD8;
        Wed, 20 Jul 2022 05:10:31 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LnvfW2y2Jz4xG0;
        Wed, 20 Jul 2022 22:10:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658319027;
        bh=CrlbbzDClGegwMtLL/xWjFcxi7456Yb9TXrYiNSjdwk=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=ZXv+oUBVOMfzBYfPWAzkepdJn2mrirxd9tDPPejGkm1wo8g0SEFDlCBWatjzRbjpz
         LG7MooqQU0uY/edH/JZ2sO2H6K2u3KHkY+l0J2fX7PY8VdrkmfGzW86fOqKXQsFJE6
         kv5ZGX0Shw+xgIpur1aUac7pn8F9iN3fFhS1NBHBW5VkVIiknwR8U9FN6iEMOnwC1i
         wyE6tVv1d5PYLw4jeUKCPul/QZp8Hx0Mnis9h0SX3LwIA1hLcEKlyzdJ6v3oWR0oP4
         EjIVCcUelRhVlj0WdXZ/GVGnsTzwqi/7XYLkHh3B3eYaA4U6Zshri+lMneQdabUquN
         IFDiqUQxBlb5w==
Date:   Wed, 20 Jul 2022 22:10:23 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Jens Axboe <axboe@kernel.dk>
Cc:     Pavel Begunkov <asml.silence@gmail.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the block tree
Message-ID: <20220720221023.6ec3ef0e@canb.auug.org.au>
In-Reply-To: <20220720133306.5f708750@canb.auug.org.au>
References: <20220720133306.5f708750@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/+znOTWHMLCXSuHqWVWqzFnY";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/+znOTWHMLCXSuHqWVWqzFnY
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 20 Jul 2022 13:33:06 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> After merging the block tree, today's linux-next build (arm
> multi_v7_defconfig) produced this warning:
>=20
> io_uring/net.c: In function 'io_sendzc':
> io_uring/net.c:980:41: warning: cast from pointer to integer of different=
 size [-Wpointer-to-int-cast]
>   980 |                                         (u64)zc->buf, zc->len);
>       |                                         ^
>=20
> Introduced by commit
>=20
>   bb4019de9ea1 ("io_uring: sendzc with fixed buffers")

This become an error in my i386 defconfig build, so I applied the
following patch.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 20 Jul 2022 21:19:15 +1000
Subject: [PATCH] fix up for "io_uring: sendzc with fixed buffers"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 io_uring/net.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/io_uring/net.c b/io_uring/net.c
index 282401255ab4..903a0de689fb 100644
--- a/io_uring/net.c
+++ b/io_uring/net.c
@@ -977,7 +977,7 @@ int io_sendzc(struct io_kiocb *req, unsigned int issue_=
flags)
=20
 	if (zc->flags & IORING_RECVSEND_FIXED_BUF) {
 		ret =3D io_import_fixed(WRITE, &msg.msg_iter, req->imu,
-					(u64)zc->buf, zc->len);
+					(u64)(unsigned long)zc->buf, zc->len);
 		if (unlikely(ret))
 				return ret;
 	} else {
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/+znOTWHMLCXSuHqWVWqzFnY
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLX8K8ACgkQAVBC80lX
0GyNggf9H/Nxx6jT0i6WG06jJCU0ZsqjCx3aAzako1hJzEeENmBctQbDlKTBDBG9
wv0QtdrGuJZMqg+ZqhM9116bFfxSS5mDG0oakcvyUzR0KpKAPl8qaOPv+QOZ6OaP
gpiAV65xrY2osA2d1gPeEzoSMMF+JaFN9+PNUjlOLgfZEBc0IrSJ2XgrWdqHetYK
MZhlu4yoQx6CkM+tRj7vLOvKGxmxgHodHNjRLJg+zLY+Zz0x6Qb32XTY+dQMCh/1
paLDfTREdZd+HZ+7XUJkFghTAq+tspXAiwAeS1ZK8e7+tVKEYqX1pdcgH0xhtdf9
5tEpw//2zmpOiVAnV8fnuXpQPJbdmQ==
=u+Of
-----END PGP SIGNATURE-----

--Sig_/+znOTWHMLCXSuHqWVWqzFnY--
