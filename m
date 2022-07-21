Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9CBD57C833
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 11:55:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232762AbiGUJzU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 05:55:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53522 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232582AbiGUJzS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 05:55:18 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id ACC9225EA6;
        Thu, 21 Jul 2022 02:55:16 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LpSby3PtPz4xFy;
        Thu, 21 Jul 2022 19:55:10 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658397310;
        bh=KYojhQKQTwCcF2T7SoTSUYzFgZzQxy+uKu3TuySFYfs=;
        h=Date:From:To:Cc:Subject:From;
        b=n+bgNF5ZFXcWcrl4FYrPSs5pVmiUwgY+XJAJgTwlf//w3d96jNOy4uOwwajDQiBGe
         HyuNc88qOtB5wpCA+Z5xwpJ053X4txQ85Am1Ow17rVfry2wPEhNfmcIoCye2HTmsfD
         +2vUElv1LeI8N9yks8zWft7JLysRPM80ydrCMd3tcn7ryqZUgnKRHt+7GFcz7iMVny
         00LGGFXN2qVfh43jsHoo72yOB0njQ7xTqEU3+rSUisgV16D25AttEn3N9UmogS7wwU
         gVs/O+MvxPhFZMwxgT4fey3S9hgbXQaPnaXE403k6+OI6S+bdXi/XQ1pnx/oukIvvr
         fY2dv25XWqFFQ==
Date:   Thu, 21 Jul 2022 19:55:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Zach O'Keefe <zokeefe@google.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Michael Ellerman <mpe@ellerman.id.au>
Subject: linux-next: build warning after merge of the mm tree
Message-ID: <20220721195508.15f1e07a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/3DBC.JRnzAsYpTNZ=6rFzL0";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/3DBC.JRnzAsYpTNZ=6rFzL0
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (powerpc
ppc64_defconfig) produced this warning:

In file included from arch/powerpc/include/asm/book3s/64/mmu-hash.h:20,
                 from arch/powerpc/include/asm/book3s/64/mmu.h:32,
                 from arch/powerpc/include/asm/mmu.h:393,
                 from arch/powerpc/include/asm/lppaca.h:46,
                 from arch/powerpc/include/asm/paca.h:18,
                 from arch/powerpc/include/asm/current.h:13,
                 from include/linux/thread_info.h:23,
                 from include/asm-generic/preempt.h:5,
                 from ./arch/powerpc/include/generated/asm/preempt.h:1,
                 from include/linux/preempt.h:78,
                 from include/linux/spinlock.h:55,
                 from include/linux/mmzone.h:8,
                 from include/linux/gfp.h:7,
                 from include/linux/mm.h:7,
                 from mm/khugepaged.c:4:
arch/powerpc/include/asm/book3s/64/pgtable.h:190:25: warning: "__pte_index_=
size" is not defined, evaluates to 0 [-Wundef]
  190 | #define PTE_INDEX_SIZE  __pte_index_size
      |                         ^~~~~~~~~~~~~~~~
arch/powerpc/include/asm/book3s/64/pgtable.h:241:39: note: in expansion of =
macro 'PTE_INDEX_SIZE'
  241 | #define PMD_SHIFT       (PAGE_SHIFT + PTE_INDEX_SIZE)
      |                                       ^~~~~~~~~~~~~~
include/linux/huge_mm.h:109:25: note: in expansion of macro 'PMD_SHIFT'
  109 | #define HPAGE_PMD_SHIFT PMD_SHIFT
      |                         ^~~~~~~~~
include/linux/huge_mm.h:105:26: note: in expansion of macro 'HPAGE_PMD_SHIF=
T'
  105 | #define HPAGE_PMD_ORDER (HPAGE_PMD_SHIFT-PAGE_SHIFT)
      |                          ^~~~~~~~~~~~~~~
mm/khugepaged.c:95:5: note: in expansion of macro 'HPAGE_PMD_ORDER'
   95 | #if HPAGE_PMD_ORDER < 16
      |     ^~~~~~~~~~~~~~~

Introduced by commit

  adcc4e193b6b ("mm/khugepaged: use minimal bits to store num page < HPAGE_=
PMD_NR")

So HPAGE_PMD_ORDER is not a constant on ppc64 ...

I applied this hack for today (which makes it build without warning and
puts things more or less back as they were for ppo64).

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 21 Jul 2022 19:49:40 +1000
Subject: [PATCH] fix up for "mm/khugepaged: use minimal bits to store num p=
age < HPAGE_PMD_NR"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/khugepaged.c | 4 +++-
 1 file changed, 3 insertions(+), 1 deletion(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 28cb8429dad4..d8e388106322 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -92,7 +92,9 @@ struct collapse_control {
 	bool is_khugepaged;
=20
 	/* Num pages scanned per node */
-#if HPAGE_PMD_ORDER < 16
+#if defined(CONFIG_PPC64)
+	u32 node_load[MAX_NUMNODES];
+#elif HPAGE_PMD_ORDER < 16
 	u16 node_load[MAX_NUMNODES];
 #else
 	u32 node_load[MAX_NUMNODES];
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/3DBC.JRnzAsYpTNZ=6rFzL0
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLZIn0ACgkQAVBC80lX
0GySLAf8CMkjn8HhKwYM/PVsKI9tR98l7+NMQHww2AjzsU05aJUgSegKl/ngB7gm
kCSItJrrRjw4LB4zdTUxB199rayaVMtkDgLvX9ei0853vDzpZMqlXfpSRDdYUGCL
+YsrvmSIE7j2zq14vQmdsdkivPq6E5TG+umC0k2UMUHC+ScVeTKMnq0/VnEBQTNs
98iQI8k6ZZUGvATlXxYcHASPMCQKnxF4Y69XxEJNjEp5zeNz1GLaU3r7AFewCETe
NRKa2aBeoFWFEMyGbUMuReSTdQ9CO2s9/q+dvhyhW/NRAS+sin11aGAFRIJsd/pZ
R7wwfmKnWQ7SibczwUU4MVU3GwOXJQ==
=m03K
-----END PGP SIGNATURE-----

--Sig_/3DBC.JRnzAsYpTNZ=6rFzL0--
