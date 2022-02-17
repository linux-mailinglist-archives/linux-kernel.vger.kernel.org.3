Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BB0A04B9AC2
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 09:19:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237422AbiBQITS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 03:19:18 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:60942 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233511AbiBQITR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 03:19:17 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 902D2297224;
        Thu, 17 Feb 2022 00:18:59 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jznm16x88z4xcP;
        Thu, 17 Feb 2022 19:18:57 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645085938;
        bh=Fyh7aAfZ1lTzQTkQu8PTg9zUMgikfruHpxm625AB0bw=;
        h=Date:From:To:Cc:Subject:From;
        b=BZlDVaCuCI45NtpObVbboO+ctget+NL+BVPPn5ee5qWgMKTYNg1AZqTHO94QJ3E9i
         0xH/sD8iyKn9rCDOxGwNgaucaW/LMi70+I9BA4ba/ljDAVzfLBbudYiMx+I0M6dpp2
         odbk9fAS4TH1gF8tGChSAszH61Ls9D0xM8loUuaY87cYYEMFSn3gm4FM0JeDfVdpUa
         N13O8W6Ac7wVXJ3YQrA5hhPIBaA4clNilSw33ttciqGSvTqcfXwdydZJTbolzOprbH
         lRYnUxC+0PPUDUe+g14YEafJa0AscKHnpWS8cEKIrVjZpxuRt187z1v1UClyXWhOTa
         NTWcKZAnSRX/A==
Date:   Thu, 17 Feb 2022 19:18:57 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liam Howlett <liam.howlett@oracle.com>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the maple tree
Message-ID: <20220217191857.6d9917c2@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.Q8Rsdru+JA2=7H=wcAc9Tu";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.Q8Rsdru+JA2=7H=wcAc9Tu
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the maple tree, today's linux-next build (arm64 defconfig)
failed like this:

arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_phdrs':
arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no member =
named 'mmap'
   13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_ne=
xt)      \
      |                                   ^~
arch/arm64/kernel/elfcore.c:69:9: note: in expansion of macro 'for_each_mte=
_vma'
   69 |         for_each_mte_vma(current, vma)
      |         ^~~~~~~~~~~~~~~~
arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has no me=
mber named 'vm_next'
   13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_ne=
xt)      \
      |                                                         ^~
arch/arm64/kernel/elfcore.c:69:9: note: in expansion of macro 'for_each_mte=
_vma'
   69 |         for_each_mte_vma(current, vma)
      |         ^~~~~~~~~~~~~~~~
arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_phdrs':
arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no member =
named 'mmap'
   13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_ne=
xt)      \
      |                                   ^~
arch/arm64/kernel/elfcore.c:79:9: note: in expansion of macro 'for_each_mte=
_vma'
   79 |         for_each_mte_vma(current, vma) {
      |         ^~~~~~~~~~~~~~~~
arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has no me=
mber named 'vm_next'
   13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_ne=
xt)      \
      |                                                         ^~
arch/arm64/kernel/elfcore.c:79:9: note: in expansion of macro 'for_each_mte=
_vma'
   79 |         for_each_mte_vma(current, vma) {
      |         ^~~~~~~~~~~~~~~~
arch/arm64/kernel/elfcore.c: In function 'elf_core_extra_data_size':
arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no member =
named 'mmap'
   13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_ne=
xt)      \
      |                                   ^~
arch/arm64/kernel/elfcore.c:104:9: note: in expansion of macro 'for_each_mt=
e_vma'
  104 |         for_each_mte_vma(current, vma)
      |         ^~~~~~~~~~~~~~~~
arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has no me=
mber named 'vm_next'
   13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_ne=
xt)      \
      |                                                         ^~
arch/arm64/kernel/elfcore.c:104:9: note: in expansion of macro 'for_each_mt=
e_vma'
  104 |         for_each_mte_vma(current, vma)
      |         ^~~~~~~~~~~~~~~~
arch/arm64/kernel/elfcore.c: In function 'elf_core_write_extra_data':
arch/arm64/kernel/elfcore.c:13:35: error: 'struct mm_struct' has no member =
named 'mmap'
   13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_ne=
xt)      \
      |                                   ^~
arch/arm64/kernel/elfcore.c:114:9: note: in expansion of macro 'for_each_mt=
e_vma'
  114 |         for_each_mte_vma(current, vma) {
      |         ^~~~~~~~~~~~~~~~
arch/arm64/kernel/elfcore.c:13:57: error: 'struct vm_area_struct' has no me=
mber named 'vm_next'
   13 |                 for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_ne=
xt)      \
      |                                                         ^~
arch/arm64/kernel/elfcore.c:114:9: note: in expansion of macro 'for_each_mt=
e_vma'
  114 |         for_each_mte_vma(current, vma) {
      |         ^~~~~~~~~~~~~~~~

Caused by commit

  b09e8361a4c3 ("mm: Remove the vma linked list")

interacting with commit

  6dd8b1a0b6cb ("arm64: mte: Dump the MTE tags in the core file")

from the arm64 tree.

I have applied the following merge fix patch for today:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 17 Feb 2022 19:12:41 +1100
Subject: [PATCH] fix up for "arm64: mte: Dump the MTE tags in the core file"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm64/kernel/elfcore.c | 16 ++++++++++------
 1 file changed, 10 insertions(+), 6 deletions(-)

diff --git a/arch/arm64/kernel/elfcore.c b/arch/arm64/kernel/elfcore.c
index 3455ee4acc04..35f99088825e 100644
--- a/arch/arm64/kernel/elfcore.c
+++ b/arch/arm64/kernel/elfcore.c
@@ -8,9 +8,9 @@
 #include <asm/cpufeature.h>
 #include <asm/mte.h>
=20
-#define for_each_mte_vma(tsk, vma)					\
+#define for_each_mte_vma(mas, vma)					\
 	if (system_supports_mte())					\
-		for (vma =3D tsk->mm->mmap; vma; vma =3D vma->vm_next)	\
+		mas_for_each(&mas, vma, ULONG_MAX)			\
 			if (vma->vm_flags & VM_MTE)
=20
 static unsigned long mte_vma_tag_dump_size(struct vm_area_struct *vma)
@@ -64,9 +64,10 @@ static int mte_dump_tag_range(struct coredump_params *cp=
rm,
 Elf_Half elf_core_extra_phdrs(void)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	int vma_count =3D 0;
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(mas, vma)
 		vma_count++;
=20
 	return vma_count;
@@ -75,8 +76,9 @@ Elf_Half elf_core_extra_phdrs(void)
 int elf_core_write_extra_phdrs(struct coredump_params *cprm, loff_t offset)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(mas, vma) {
 		struct elf_phdr phdr;
=20
 		phdr.p_type =3D PT_ARM_MEMTAG_MTE;
@@ -99,9 +101,10 @@ int elf_core_write_extra_phdrs(struct coredump_params *=
cprm, loff_t offset)
 size_t elf_core_extra_data_size(void)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
 	size_t data_size =3D 0;
=20
-	for_each_mte_vma(current, vma)
+	for_each_mte_vma(mas, vma)
 		data_size +=3D mte_vma_tag_dump_size(vma);
=20
 	return data_size;
@@ -110,8 +113,9 @@ size_t elf_core_extra_data_size(void)
 int elf_core_write_extra_data(struct coredump_params *cprm)
 {
 	struct vm_area_struct *vma;
+	MA_STATE(mas, &current->mm->mm_mt, 0, 0);
=20
-	for_each_mte_vma(current, vma) {
+	for_each_mte_vma(mas, vma) {
 		if (vma->vm_flags & VM_DONTDUMP)
 			continue;
=20
--=20
2.34.1

--=20
Cheers,
Stephen Rothwell

--Sig_/.Q8Rsdru+JA2=7H=wcAc9Tu
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIOBPEACgkQAVBC80lX
0GxwsQf+J/2fVv/71tNA9MTfBC3LxeVx8rez/sW8o6VOVm+xgT4z5xJ27kHa++NH
tsNqXh3X5Fh4uXdDL0F+2aF7E7pveTU/YoCHsOTs3Rf4PUImynrTeBHBMXjq2qba
O+bOtlZraaRGxo6h3USAhAQCRUyoLd7yCna7jGKOX+GM+1X2Ba0oajfvdo2hoi1R
4T1NdIUhzYeZF6SxXKVg5C5TpUk1E1e3onE8ZaG3g5dhONCGKFqSReBtWUE9SsJY
MEUcTklpShX1JL55ig47m44osA0Z4KVsojGQNMuIZy8L56oCaoASCT9Ln5vmHI/L
YCE44lPE6aLAGFmazSYMaIx0Fop5dw==
=eoKF
-----END PGP SIGNATURE-----

--Sig_/.Q8Rsdru+JA2=7H=wcAc9Tu--
