Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 59FC4528093
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 11:11:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235042AbiEPJKn (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 05:10:43 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40710 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242305AbiEPJKS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 05:10:18 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BFF9723178;
        Mon, 16 May 2022 02:10:08 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L1tkQ6Knjz4xZ0;
        Mon, 16 May 2022 19:10:06 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652692207;
        bh=DE35ySMP0h4XzaWOeWC9ZcHADrXaFN46xR7GkH4tTiA=;
        h=Date:From:To:Cc:Subject:From;
        b=d6vjt/XMZmAcyI5cW0QHscu6FxjLSFwCkbYgAhHPm03toEzetdtSIji4oRKeQd47X
         AV+QZzmmE/ut1MhJyMGhsgcs8vz5YuCwHiWwzirrywvTpq3hy4Er9orb+i17M6c5zx
         +URgVcDdbqIx/zoRdeebmCtgagbtiwPWka2q2ooz+S0uKNXCkKuQ5lDFdO0OV2VsFi
         v53emveoAOfUiF+lHN2QDujQ4fO6tw/WP5OFmsGOBPTCimmJZZFIXQATV78dgXER4k
         K2vkr5m/RcrLn27sbsZvN9M9nSC+Il9gRdj871D5LHkGceRjPfMsjD5a9wdnd4MJwB
         pTvlQcn9kRqaQ==
Date:   Mon, 16 May 2022 19:10:05 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Dan Williams <dan.j.williams@intel.com>
Cc:     Jane Chu <jane.chu@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the nvdimm tree
Message-ID: <20220516191005.27cee43c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/_RWmJ4HHf+Ym.ll_NWl4rSk";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/_RWmJ4HHf+Ym.ll_NWl4rSk
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the nvdimm tree, today's linux-next build (i386 defconfig)
failed like this:

In file included from include/linux/bits.h:6,
                 from include/linux/bitops.h:6,
                 from include/linux/kernel.h:22,
                 from arch/x86/include/asm/percpu.h:27,
                 from arch/x86/include/asm/preempt.h:6,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:55,
                 from include/linux/wait.h:9,
                 from include/linux/wait_bit.h:8,
                 from include/linux/fs.h:6,
                 from include/linux/highmem.h:5,
                 from arch/x86/mm/pat/set_memory.c:6:
arch/x86/mm/pat/set_memory.c: In function 'set_mce_nospec':
include/vdso/bits.h:7:40: error: left shift count >=3D width of type [-Werr=
or=3Dshift-count-overflow]
    7 | #define BIT(nr)                 (UL(1) << (nr))
      |                                        ^~
arch/x86/mm/pat/set_memory.c:1941:59: note: in expansion of macro 'BIT'
 1941 |         decoy_addr =3D (pfn << PAGE_SHIFT) + (PAGE_OFFSET ^ BIT(63)=
);
      |                                                           ^~~

Caused by commit

  39702cf7885c ("x86/mce: relocate set{clear}_mce_nospec() functions")

I applied the following patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Mon, 16 May 2022 19:00:54 +1000
Subject: [PATCH] fix up for "x86/mce: relocate set{clear}_mce_nospec() func=
tions"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/x86/mm/pat/set_memory.c | 2 ++
 1 file changed, 2 insertions(+)

diff --git a/arch/x86/mm/pat/set_memory.c b/arch/x86/mm/pat/set_memory.c
index 59d9efb4257c..9200e619d8b7 100644
--- a/arch/x86/mm/pat/set_memory.c
+++ b/arch/x86/mm/pat/set_memory.c
@@ -1914,6 +1914,7 @@ int set_memory_wb(unsigned long addr, int numpages)
 }
 EXPORT_SYMBOL(set_memory_wb);
=20
+#ifdef CONFIG_X86_64
 /* Prevent speculative access to a page by marking it not-present */
 int set_mce_nospec(unsigned long pfn)
 {
@@ -1959,6 +1960,7 @@ int clear_mce_nospec(unsigned long pfn)
 	return set_memory_present(&addr, 1);
 }
 EXPORT_SYMBOL_GPL(clear_mce_nospec);
+#endif
=20
 int set_memory_x(unsigned long addr, int numpages)
 {
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/_RWmJ4HHf+Ym.ll_NWl4rSk
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKCFO0ACgkQAVBC80lX
0GzJjwf/cqb58N0ICl+hQmJRkPG6qO+2rr9z18FuZUlE8PENverKuiyg7R5vnnTj
CiUCxItgEVkjwld4dKk+uI6YkWTAkoPQQMEbhP2XCogCAJowGerBQBGsOgfB+MgJ
1sTOWxhxgbBpHCwa8EQuGUx/iGFNIlwlrdkiHiLoTgQdyJ3UNVGasFOKhWujjwVf
rQfo37bO1KRYS6No5saDq2+FPMG5vxendJzjiGkVA9b1DfjimWDyjNLVEpRVsQof
4aKwX+mp+zMo3gr2FmgZGSd+ZlZAGHb/Bxgw86FNYnEYxP3043mMSa+6QmQu63/9
6QZXxlTp/vrM3NYDtGi2KfZ8OOZzsw==
=RZ9Q
-----END PGP SIGNATURE-----

--Sig_/_RWmJ4HHf+Ym.ll_NWl4rSk--
