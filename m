Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2C03058244D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Jul 2022 12:29:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231253AbiG0K3T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 06:29:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34416 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230029AbiG0K3S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 06:29:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7E82E45F50;
        Wed, 27 Jul 2022 03:29:15 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lt94R5P4Vz4x1N;
        Wed, 27 Jul 2022 20:29:11 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658917751;
        bh=y0mDIaAdwH/vDgKzR7mY7MwjMAhpw5aISngiWWcdy10=;
        h=Date:From:To:Cc:Subject:From;
        b=LF+VWEt/0+yx7sSIlTltKnjbQT70dFT4i8Kzj0hDFQ5woC+F5FyziRLsd1Jjkgn/M
         vVLCyuLOYzn6DuyKoV2IjMvUsgFrgxlAueC+yVUKIFb6RcGBDX1Y0wUNsf3zX7GPIG
         1AVgGUoBzhbisWcyegcgvfJOOj3Iv7A07O3iysMlTiILTkFCAdLpRjixYWNtJ9Zqpv
         X8ytnr6zsVbn60UP6hTZ4C+3MYqyj8DcGjsARCdBVwh0lOuS4WoFVZwzlPwDZeXHOK
         +10ryuD4zJRkm3+B+7qNDj0dT8JGQ32Jq0eJU5vgnSOIuUry+tn02mC8pHvRgkZVVg
         4FWEc0BSc53hw==
Date:   Wed, 27 Jul 2022 20:29:10 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>
Cc:     Michael Ellerman <mpe@ellerman.id.au>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the bitmap tree
Message-ID: <20220727202910.0ecb9f01@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/NQb/483x3xMEQR6HCkd5Zcw";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/NQb/483x3xMEQR6HCkd5Zcw
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the bitmap tree, today's linux-next build (powerpc
ppc64_defconfig) failed like this:

ERROR: modpost: ".arch_get_random_seed_longs" [arch/powerpc/kvm/kvm-hv.ko] =
undefined!

Caused by commit

  c3aaaf9e2ada ("powerpc: drop dependency on <asm/machdep.h> in archrandom.=
h")

It seems that the EXPORT was needed.  I applied the following for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 27 Jul 2022 20:21:53 +1000
Subject: [PATCH] fixup for "powerpc: drop dependency on <asm/machdep.h> in
 archrandom.h"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/setup-common.c | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup=
-common.c
index 91f8982c61a0..463072ed40e8 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -177,6 +177,7 @@ size_t arch_get_random_seed_longs(unsigned long *v, siz=
e_t max_longs)
 		return 1;
 	return 0;
 }
+EXPORT_SYMBOL_GPL(arch_get_random_seed_longs);
=20
 void machine_halt(void)
 {
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/NQb/483x3xMEQR6HCkd5Zcw
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLhE3YACgkQAVBC80lX
0GzYSwf/cWT7hn7yOCRoZrN1aQ2uNySF23FAvkyh77fh9LPBiXqGOGDY+Gub8hF6
tcS9pTAQugeb2Nf2PtfKG79Ihf0O9rjYZuh2+tlVHVzM0+JG3v+ruLHvXbRDqUaB
VlUO2j+Re2L+Uh4mJmJaYwfwyS7FjuPtt/d2aDcjNgGl7JeaeLE1HjhacfdXxJYS
8OUkR+iJKzEXzgJfWOlUKyLYA0cJKCzEeZT4pLgWchMMwc6DIHqCvSA8oKVPu5dd
SK9MCTG6v0eb3SmmObjV7aaKDEIXxULZ1U0slU4kOR4GEcFOjTy97IxKmXU9cv4A
hBnack2TO902vcgA9LKk1Ewh8EkDcA==
=0ZAn
-----END PGP SIGNATURE-----

--Sig_/NQb/483x3xMEQR6HCkd5Zcw--
