Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 96311580F73
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Jul 2022 10:57:04 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232575AbiGZI5D (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Jul 2022 04:57:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229746AbiGZI5B (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Jul 2022 04:57:01 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D970F25CD;
        Tue, 26 Jul 2022 01:56:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LsW4S4lRPz4x1b;
        Tue, 26 Jul 2022 18:56:56 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658825817;
        bh=DS0npURn+YYFDmuMN9rMQueUGCuCQLBY6Ic5BRV10ok=;
        h=Date:From:To:Cc:Subject:From;
        b=fVc62ENTOJTCjPs2A0P5eqlaLLPtiylP8IWax6w1FKHNjfb9ziNgctqSWxio9j5ra
         1lyDyLndghyz2F+e6ncY4HP+2ahSQwdf0xecPPtf8YiT5+maEG1sSb/gz/u1VTZJRj
         txwfaennhaPh6SCiv4U3QNpKfXmhL/pmnjPhp0TauSPsavCewlejJ75m15E53qgcPc
         UiGq2Do61x5tJNq99HiAhfevKwnA4/GoSY7kCzvDssAvGSzy3YbmHuddvloSJqkc49
         GAw8cVSIeZdbqnmOSRbbgbE0qyUWjVjAA9DWqsqFRiUHLOvb/G8UszDz1Y5Tau/ifm
         yydAreQ+H6DDA==
Date:   Tue, 26 Jul 2022 18:56:52 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Yury Norov <yury.norov@gmail.com>, Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: linux-next: manual merge of the bitmap tree with the random tree
Message-ID: <20220726185652.2e9eda33@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/4=Sr_JJ0.9cX/e=AY=tdkhA";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/4=Sr_JJ0.9cX/e=AY=tdkhA
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the bitmap tree got a conflict in:

  arch/powerpc/include/asm/archrandom.h

between commits:

  9592eef7c16e ("random: remove CONFIG_ARCH_RANDOM")
  d349ab99eec7 ("random: handle archrandom with multiple longs")

from the random tree and commit:

  2f9905799751 ("powerpc: drop dependency on <asm/machdep.h> in archrandom.=
h")

from the bitmap tree.

I fixed it up (see bottom and also applied the following merge fix patch)
and can carry the fix as necessary. This is now fixed as far as linux-next
is concerned, but any non trivial conflicts should be mentioned to your
upstream maintainer when your tree is submitted for merging.  You may
also want to consider cooperating with the maintainer of the conflicting
tree to minimise any particularly complex conflicts.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Tue, 26 Jul 2022 18:47:56 +1000
Subject: [PATCH] fix up for "powerpc: drop dependency on <asm/machdep.h> in=
 archrandom.h"

interacting with "random: handle archrandom with multiple longs" and
"random: remove CONFIG_ARCH_RANDOM"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/powerpc/kernel/setup-common.c | 13 +++++--------
 1 file changed, 5 insertions(+), 8 deletions(-)

diff --git a/arch/powerpc/kernel/setup-common.c b/arch/powerpc/kernel/setup=
-common.c
index 194d09461767..409a0a763fe4 100644
--- a/arch/powerpc/kernel/setup-common.c
+++ b/arch/powerpc/kernel/setup-common.c
@@ -171,16 +171,13 @@ EXPORT_SYMBOL_GPL(machine_power_off);
 void (*pm_power_off)(void);
 EXPORT_SYMBOL_GPL(pm_power_off);
=20
-#ifdef CONFIG_ARCH_RANDOM
-bool __must_check arch_get_random_seed_long(unsigned long *v)
+size_t arch_get_random_seed_longs(unsigned long *v, size_t max_longs)
 {
-	if (ppc_md.get_random_seed)
-		return ppc_md.get_random_seed(v);
-
-	return false;
+	if (max_longs && ppc_md.get_random_seed && ppc_md.get_random_seed(v))
+		return 1;
+	return 0;
 }
-EXPORT_SYMBOL(arch_get_random_seed_long);
-#endif
+EXPORT_SYMBOL(arch_get_random_seed_longs);
=20
 void machine_halt(void)
 {
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

diff --cc arch/powerpc/include/asm/archrandom.h
index 0e365c5b2396,21def59ef1a6..c94c9d782533
--- a/arch/powerpc/include/asm/archrandom.h
+++ b/arch/powerpc/include/asm/archrandom.h
@@@ -2,19 -2,33 +2,12 @@@
  #ifndef _ASM_POWERPC_ARCHRANDOM_H
  #define _ASM_POWERPC_ARCHRANDOM_H
 =20
- #include <asm/machdep.h>
 -#ifdef CONFIG_ARCH_RANDOM
 -
 -bool __must_check arch_get_random_seed_long(unsigned long *v);
 -
 -static inline bool __must_check arch_get_random_long(unsigned long *v)
 -{
 -	return false;
 -}
--
 -static inline bool __must_check arch_get_random_int(unsigned int *v)
 +static inline size_t __must_check arch_get_random_longs(unsigned long *v,=
 size_t max_longs)
  {
 -	return false;
 +	return 0;
  }
 =20
- static inline size_t __must_check arch_get_random_seed_longs(unsigned lon=
g *v, size_t max_longs)
 -
 -static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
--{
- 	if (max_longs && ppc_md.get_random_seed && ppc_md.get_random_seed(v))
- 		return 1;
- 	return 0;
 -	unsigned long val;
 -	bool rc;
 -
 -	rc =3D arch_get_random_seed_long(&val);
 -	if (rc)
 -		*v =3D val;
 -
 -	return rc;
--}
 -#endif /* CONFIG_ARCH_RANDOM */
++size_t __must_check arch_get_random_seed_longs(unsigned long *v, size_t m=
ax_longs);
 =20
  #ifdef CONFIG_PPC_POWERNV
  int powernv_hwrng_present(void);


--Sig_/4=Sr_JJ0.9cX/e=AY=tdkhA
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLfrFUACgkQAVBC80lX
0Gz5Igf/eKFh2Dr702CM90pdWY1TDogx9VX211NhhFNLQfqWsqUbui7ImBc5qzl4
BMmlfExIjo95/afPpRD0sPG7jmL2mtvA28kp6mrYno9ZPKrUDjI/J7etPjHTQWGX
32uG7Zi9/o75XVn43cwS4+7/5UoYzXpJ9JGF6LJJpXsCcpUA2nHjo7pumefLMzjX
8k3sIGA0gPkFa07g/qnEv8tm/+IEEULDStBQdNxc4E+M3ErAlbFdAjHPWDejfQrh
hC+MssMB/rtMWKqWSNktmG6l7c4dXXeEYtRWm8hE8xT4wtlMXZyzngS2MyePqt5Z
p2I5rvVThRVjJPIESxfb4/m2fLuaAA==
=OKh7
-----END PGP SIGNATURE-----

--Sig_/4=Sr_JJ0.9cX/e=AY=tdkhA--
