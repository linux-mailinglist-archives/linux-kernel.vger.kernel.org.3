Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 98B8A57DC6C
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Jul 2022 10:34:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234557AbiGVIdw (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Jul 2022 04:33:52 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231807AbiGVIdv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Jul 2022 04:33:51 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 04D619E7B4;
        Fri, 22 Jul 2022 01:33:49 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Lq2lZ4pWxz4xGH;
        Fri, 22 Jul 2022 18:33:46 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658478827;
        bh=IyG7dSfjrl1EPq7fQM6zZQvWx17IOdwCaYAHQhcJAiw=;
        h=Date:From:To:Cc:Subject:From;
        b=ZQP67sb3S/VAKw1UcHTnI0rwoR0UIiuGQU0D6cqKYV5RlSPrPbjmeNf1p7hj8fDrn
         yu6zndjcRlDwhNDmO/P8pNY+tP4EbfW3J6/guV3xOIJ6WqoyI+EQxcjqeb4yXe6rp8
         Na6dr/J6geewzMAWMjrnCQHLG7GS7npRG/91gN9OcEpWjoMg2E3F7iQfWflEiVoRM8
         oBJUae+HTOykLtJmXBfT1Cp1OV4E5BZDnFYd83lqMHX5dY7JhF0d48NZF93mFI0oR4
         uP9MUA80iOE486jikx/71YL8kLHKlZjaNddPewuaqSQoas1QhgsstIInL1DkPpbCLf
         P4w6NET+v0o3A==
Date:   Fri, 22 Jul 2022 18:33:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Theodore Ts'o <tytso@mit.edu>,
        "Jason A. Donenfeld" <Jason@zx2c4.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@de.ibm.com>
Cc:     Alexander Gordeev <agordeev@linux.ibm.com>,
        Harald Freudenberger <freude@linux.ibm.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the random tree with the s390-fixes
 tree
Message-ID: <20220722183343.229ecc7d@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/nf5.=8YEHSUUcyLXvBWeQ/a";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/nf5.=8YEHSUUcyLXvBWeQ/a
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the random tree got a conflict in:

  arch/s390/include/asm/archrandom.h

between commit:

  918e75f77af7 ("s390/archrandom: prevent CPACF trng invocations in interru=
pt context")

from the s390-fixes tree and commit:

  2b85d0d98f18 ("random: handle archrandom with multiple longs")

from the random tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/s390/include/asm/archrandom.h
index 4120c428dc37,cf5e000df0a1..000000000000
--- a/arch/s390/include/asm/archrandom.h
+++ b/arch/s390/include/asm/archrandom.h
@@@ -11,47 -11,26 +11,28 @@@
  #ifndef _ASM_S390_ARCHRANDOM_H
  #define _ASM_S390_ARCHRANDOM_H
 =20
- #ifdef CONFIG_ARCH_RANDOM
-=20
  #include <linux/static_key.h>
 +#include <linux/preempt.h>
  #include <linux/atomic.h>
  #include <asm/cpacf.h>
 =20
  DECLARE_STATIC_KEY_FALSE(s390_arch_random_available);
  extern atomic64_t s390_arch_random_counter;
 =20
- static inline bool __must_check arch_get_random_long(unsigned long *v)
- {
- 	return false;
- }
-=20
- static inline bool __must_check arch_get_random_int(unsigned int *v)
- {
- 	return false;
- }
-=20
- static inline bool __must_check arch_get_random_seed_long(unsigned long *=
v)
+ static inline size_t __must_check arch_get_random_longs(unsigned long *v,=
 size_t max_longs)
  {
- 	if (static_branch_likely(&s390_arch_random_available) &&
- 	    in_task()) {
- 		cpacf_trng(NULL, 0, (u8 *)v, sizeof(*v));
- 		atomic64_add(sizeof(*v), &s390_arch_random_counter);
- 		return true;
- 	}
- 	return false;
+ 	return 0;
  }
 =20
- static inline bool __must_check arch_get_random_seed_int(unsigned int *v)
+ static inline size_t __must_check arch_get_random_seed_longs(unsigned lon=
g *v, size_t max_longs)
  {
 -	if (static_branch_likely(&s390_arch_random_available)) {
 +	if (static_branch_likely(&s390_arch_random_available) &&
 +	    in_task()) {
- 		cpacf_trng(NULL, 0, (u8 *)v, sizeof(*v));
- 		atomic64_add(sizeof(*v), &s390_arch_random_counter);
- 		return true;
+ 		cpacf_trng(NULL, 0, (u8 *)v, max_longs * sizeof(*v));
+ 		atomic64_add(max_longs * sizeof(*v), &s390_arch_random_counter);
+ 		return max_longs;
  	}
- 	return false;
+ 	return 0;
  }
 =20
- #endif /* CONFIG_ARCH_RANDOM */
  #endif /* _ASM_S390_ARCHRANDOM_H */

--Sig_/nf5.=8YEHSUUcyLXvBWeQ/a
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLaYOcACgkQAVBC80lX
0GzzjQf/e3qQPO7VZhqNMbjPrss5j9n8p0pVDioTI1Vh6/79ooIrdzk3accqiJAd
jZQQBwhDatQGPG8LYk/jO4yMlGL7ouSGYRbrirS1fMsHG7T6uS0ksWgbja4TPiGq
VevxGraoJcz5TnFvWTlQIUNZz1dVVAEF4Q7TzGmw7qX3z5q1WvzsHrnopJO0Eq5k
iR5OIY4BDMq9/bFm/F+gBo8pe6pBeg63To+zv537O2Tr+2fCUPHy8nXnOUte4Jrk
ZBui/xLHfJqly0wKntrRSFBBEHSF6dcRlaMEtU7H2Mz04h8buV1SfgypTmLH1Eyf
UAfAmLdBiQW/gATcny/Hu6rOwGf87Q==
=bkuT
-----END PGP SIGNATURE-----

--Sig_/nf5.=8YEHSUUcyLXvBWeQ/a--
