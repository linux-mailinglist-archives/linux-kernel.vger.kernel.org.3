Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 18AB957C944
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Jul 2022 12:45:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232674AbiGUKpZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Jul 2022 06:45:25 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43664 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230104AbiGUKpX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Jul 2022 06:45:23 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3309515A0E;
        Thu, 21 Jul 2022 03:45:20 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LpTjp309Vz4x1V;
        Thu, 21 Jul 2022 20:45:18 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1658400318;
        bh=XQfutRJTkxr0ARLfUh8ULmq6MYnQ2FxmuQIhzaEuqOA=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=Pb7Hs+JUD8C0mnjUlUgiGI6MwPGWXM3Gr3s8IOY57R2mH6qfGCVAyhCb7aLwlm7rF
         KiiJ3UBjbnu58ff+bthgld6QAs/QXpCqO/D1p6LMXxjkDZJj+b8uO1kT/E75yaqPuz
         YwyVr1kGvr77Yvu5+rs5ED0zcOaunf0KNfGx8H5GWr+f25a08XB/jt2SJGGjqsz/wN
         K5HMsxPbKltW/CqEugkpCqm1foDQqdw/kSEifjK9uc30FmCFzebKsevWdEmPJZgnvo
         dvMCYOgkezWB2fLEg449D8sj2TkstpTQwUWc941BOleQmB0+LctzHQBfVIdPk8cR5z
         OglMQA8epWkzA==
Date:   Thu, 21 Jul 2022 20:45:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Ard Biesheuvel <ardb@kernel.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Peter Collingbourne <pcc@google.com>
Subject: Re: linux-next: manual merge of the arm64 tree with the arm64-fixes
 tree
Message-ID: <20220721204517.53bab2a3@canb.auug.org.au>
In-Reply-To: <20220721094512.5419f75f@canb.auug.org.au>
References: <20220721094512.5419f75f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/iDsKAxl9Bdy0e8_vbt4Lrh+";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/iDsKAxl9Bdy0e8_vbt4Lrh+
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Thu, 21 Jul 2022 09:45:12 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>
> Today's linux-next merge of the arm64 tree got a conflict in:
>=20
>   arch/arm64/kernel/head.S
>=20
> between commit:
>=20
>   f7b4c3b82e7d ("arm64: set UXN on swapper page tables")
>=20
> from the arm64-fixes tree and commits:
>=20
>   e42ade29e3bc ("arm64: head: split off idmap creation code")
>   c3cee924bd85 ("arm64: head: cover entire kernel image in initial ID map=
")
>=20
> from the arm64 tree.
>=20
> I didn't know if the change from the former was still needed after the
> changes in the latter, so I left it out for now.

OK, so my arm64 defconfig build produced these errors:

arch/arm64/kernel/head.S: Assembler messages:
arch/arm64/kernel/head.S:334: Error: immediate cannot be moved by a single =
instruction
arch/arm64/kernel/head.S:343: Error: immediate cannot be moved by a single =
instruction
arch/arm64/kernel/head.S:354: Error: immediate cannot be moved by a single =
instruction
arch/arm64/kernel/head.S:379: Error: immediate cannot be moved by a single =
instruction
arch/arm64/mm/proc.S:296: Error: immediate cannot be moved by a single inst=
ruction

So I tried this patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 21 Jul 2022 20:21:36 +1000
Subject: [PATCH] fixup for "arm64: set UXN on swapper page tables"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm64/kernel/head.S | 8 ++++----
 arch/arm64/mm/proc.S     | 2 +-
 2 files changed, 5 insertions(+), 5 deletions(-)

diff --git a/arch/arm64/kernel/head.S b/arch/arm64/kernel/head.S
index cefe6a73ee54..aa7c58689f68 100644
--- a/arch/arm64/kernel/head.S
+++ b/arch/arm64/kernel/head.S
@@ -331,7 +331,7 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	adrp	x0, init_idmap_pg_dir
 	adrp	x3, _text
 	adrp	x6, _end + MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE
-	mov	x7, SWAPPER_RX_MMUFLAGS
+	mov_q	x7, SWAPPER_RX_MMUFLAGS
=20
 	map_memory x0, x1, x3, x6, x7, x3, IDMAP_PGD_ORDER, x10, x11, x12, x13, x=
14, EXTRA_SHIFT
=20
@@ -340,7 +340,7 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	adrp	x2, init_pg_dir
 	adrp	x3, init_pg_end
 	bic	x4, x2, #SWAPPER_BLOCK_SIZE - 1
-	mov	x5, SWAPPER_RW_MMUFLAGS
+	mov_q	x5, SWAPPER_RW_MMUFLAGS
 	mov	x6, #SWAPPER_BLOCK_SHIFT
 	bl	remap_region
=20
@@ -351,7 +351,7 @@ SYM_FUNC_START_LOCAL(create_idmap)
 	bfi	x22, x21, #0, #SWAPPER_BLOCK_SHIFT		// remapped FDT address
 	add	x3, x2, #MAX_FDT_SIZE + SWAPPER_BLOCK_SIZE
 	bic	x4, x21, #SWAPPER_BLOCK_SIZE - 1
-	mov	x5, SWAPPER_RW_MMUFLAGS
+	mov_q	x5, SWAPPER_RW_MMUFLAGS
 	mov	x6, #SWAPPER_BLOCK_SHIFT
 	bl	remap_region
=20
@@ -376,7 +376,7 @@ SYM_FUNC_START_LOCAL(create_kernel_mapping)
 	adrp	x3, _text			// runtime __pa(_text)
 	sub	x6, x6, x3			// _end - _text
 	add	x6, x6, x5			// runtime __va(_end)
-	mov	x7, SWAPPER_RW_MMUFLAGS
+	mov_q	x7, SWAPPER_RW_MMUFLAGS
=20
 	map_memory x0, x1, x5, x6, x7, x3, (VA_BITS - PGDIR_SHIFT), x10, x11, x12=
, x13, x14
=20
diff --git a/arch/arm64/mm/proc.S b/arch/arm64/mm/proc.S
index 7837a69524c5..b4fe8e6e85cb 100644
--- a/arch/arm64/mm/proc.S
+++ b/arch/arm64/mm/proc.S
@@ -293,7 +293,7 @@ SYM_FUNC_START(idmap_kpti_install_ng_mappings)
 	isb
=20
 	mov	temp_pte, x5
-	mov	pte_flags, #KPTI_NG_PTE_FLAGS
+	mov_q	pte_flags, #KPTI_NG_PTE_FLAGS
=20
 	/* Everybody is enjoying the idmap, so we can rewrite swapper. */
 	/* PGD */
--=20
2.35.1

Which mostly worked, but produced this:

arch/arm64/mm/proc.S: Assembler messages:
arch/arm64/mm/proc.S:296: Error: bad expression
arch/arm64/mm/proc.S:296: Error: found '(', expected: ')'
arch/arm64/mm/proc.S:296: Error: found '(', expected: ')'
arch/arm64/mm/proc.S:296: Error: found '(', expected: ')'
arch/arm64/mm/proc.S:296: Error: junk at end of line, first unrecognized ch=
aracter is `('
arch/arm64/mm/proc.S:296: Error: bad expression
arch/arm64/mm/proc.S:296: Error: found '(', expected: ')'
arch/arm64/mm/proc.S:296: Error: found '(', expected: ')'
arch/arm64/mm/proc.S:296: Error: found '(', expected: ')'
arch/arm64/mm/proc.S:296: Error: junk at end of line, first unrecognized ch=
aracter is `('
arch/arm64/mm/proc.S:296: Error: bad expression at operand 2 -- `movz pte_f=
lags,:abs_g3:#(((0)<<2)|((3<<0)|(1<<10)|(3<<8)|(1<<54)))'
arch/arm64/mm/proc.S:296: Error: bad expression at operand 2 -- `movk pte_f=
lags,:abs_g2_nc:#(((0)<<2)|((3<<0)|(1<<10)|(3<<8)|(1<<54)))'
arch/arm64/mm/proc.S:296: Error: bad expression at operand 2 -- `movk pte_f=
lags,:abs_g1_nc:#(((0)<<2)|((3<<0)|(1<<10)|(3<<8)|(1<<54)))'
arch/arm64/mm/proc.S:296: Error: bad expression at operand 2 -- `movk pte_f=
lags,:abs_g0_nc:#(((0)<<2)|((3<<0)|(1<<10)|(3<<8)|(1<<54)))'

So I gave up and left arm64 broken for today :-(
--=20
Cheers,
Stephen Rothwell

--Sig_/iDsKAxl9Bdy0e8_vbt4Lrh+
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmLZLj0ACgkQAVBC80lX
0Gwbkwf+OibdDxkFIpJESPQm7UaZQogW2BzBebaS/zNqYOnfDXf3O6apMyDNT3CB
8/hOtQQw61qsOUtDo2Xqo+3uZ9fnS74ZgSZJfqc/9NQFzZLYTFGETD1srlntiFK2
84vif99q920iFirgPElnGGIJu3ZC63avmroQX2ZuSEJrT+L/JQ/aZ2jNLfEkJO0n
g5eV8gTZaROO765P9zDP1jksZw4EqZFJt+0DToRlmjVT9Jxqdv1YaUwSCemL57Rn
Kc90JWVQugFI80l/0JbvwHC0b39Kjh5CyDQwkKd9X0S6vIbAkV/U6D7r2XjOp+gi
JpUnUHEOTCppNLOpIOoH5ueOMAmLzQ==
=upJ2
-----END PGP SIGNATURE-----

--Sig_/iDsKAxl9Bdy0e8_vbt4Lrh+--
