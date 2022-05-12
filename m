Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8F6DE52493D
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 11:39:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352150AbiELJjI (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 05:39:08 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39046 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1352156AbiELJjC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 05:39:02 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4EE5022D60B;
        Thu, 12 May 2022 02:38:59 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KzRYY42h5z4xXh;
        Thu, 12 May 2022 19:38:57 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652348338;
        bh=50YAFojEM6P2L//wBmsLp7eoAHSvAd8EVnRo2/Klrak=;
        h=Date:From:To:Cc:Subject:From;
        b=WTmzphnpz8YcS+UUtX3bUihS8Oequ7N5CFze2m0/+3Ez5RtA4rV9qRzZJ5/cLmtpw
         A4RdwSBNsbLVQUFj7E5zCbMpzhnYAY/2t2kCWHJhGAXfl9LBVcjRW7RXgCOlrpydj9
         +J1Td6pPIctLK59fQtru5snRWTO3T6ALKIpXgUhrNZFg9E7pejjGG9oRScYq+etmRx
         TVmwoiG6Ap/7R08p3tysz1BNOT3F357lRrl1LaoRACYKt9xNFmmpqP6TaDS8ZCRFbt
         wgWRgkwuPuKjwL3PG283siCrmi+fRvP63olpE5PcaiUZNl3SePWQ+q8e+RzcPGHJ+W
         b4J8hdUdn1b1A==
Date:   Thu, 12 May 2022 19:38:55 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>
Cc:     Anshuman Khandual <anshuman.khandual@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20220512193855.4f6ce32f@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Vt0kgeqzVmM8HOsbxNhvVRO";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Vt0kgeqzVmM8HOsbxNhvVRO
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (arm64 defconfig)
failed like this:

arch/arm64/mm/hugetlbpage.c: In function 'huge_ptep_clear_flush':
arch/arm64/mm/hugetlbpage.c:493:16: error: implicit declaration of function=
 'get_clear_flush'; did you mean 'ptep_clear_flush'? [-Werror=3Dimplicit-fu=
nction-declaration]
  493 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncon=
tig);
      |                ^~~~~~~~~~~~~~~
      |                ptep_clear_flush
arch/arm64/mm/hugetlbpage.c:493:16: error: incompatible types when returnin=
g type 'int' but 'pte_t' was expected
  493 |         return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncon=
tig);
      |                ^~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~=
~~~~
arch/arm64/mm/hugetlbpage.c:494:1: error: control reaches end of non-void f=
unction [-Werror=3Dreturn-type]
  494 | }
      | ^

Caused by commit

  00df1f1a133b ("mm: change huge_ptep_clear_flush() to return the original =
pte")

interacting with commit

  fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")

I have applied the following merg fix patch for today.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Thu, 12 May 2022 19:33:11 +1000
Subject: [PATCH] fixup for "mm: change huge_ptep_clear_flush() to return th=
e original pte"

It interacts with commit

  fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")

from the arm64 tree

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm64/mm/hugetlbpage.c | 2 +-
 1 file changed, 1 insertion(+), 1 deletion(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 5bdf913dedc7..30f5b76aabe9 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -490,7 +490,7 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 		return ptep_clear_flush(vma, addr, ptep);
=20
 	ncontig =3D find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
-	return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	return get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
 }
=20
 static int __init hugetlbpage_init(void)
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/Vt0kgeqzVmM8HOsbxNhvVRO
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ81a8ACgkQAVBC80lX
0GzjMgf6AgRFefDeS1S3ZP0ouMb1S09btO6BDvfDpRwFbNPLiGTq9kR/LU7qF4Ej
k8okIJtlRwvaabwhkLCXrOVkf+M4Dzpv5ZS3Tmm/0UW0i/lvMqVKMn/rM7f7ZfZ1
2qQEVcNGSISXguePdeT78yzMrMLv1xLXYkSohmOQuac3ojUBbTPkHo984ubR4b07
du8Wirfd109Uz3ln1Vhukp+iMZZLqkNk2P9ZI+Z99CfdCTf4fFLIFdN/j446Afbz
a8o9yxd9ZFwYMNctGtN7ErHXwyaFNstTghSsUrk/phj76dSHjISoCH3SLsQ/6OG/
DL7Oj/BKyzZ2YzQlEoL5jvL8KO4+/g==
=C1S5
-----END PGP SIGNATURE-----

--Sig_/Vt0kgeqzVmM8HOsbxNhvVRO--
