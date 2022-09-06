Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (unknown [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0EEB65AE3B8
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 11:02:39 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239402AbiIFJBz (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 05:01:55 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:33352 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233089AbiIFJBs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 05:01:48 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0FF6E45044;
        Tue,  6 Sep 2022 02:01:46 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4MMKBb1MBsz4x1T;
        Tue,  6 Sep 2022 19:01:43 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1662454904;
        bh=iI2eBQeHX1Eqpqtj1syy0uYEcdBPTnaFFBp24yMDkxw=;
        h=Date:From:To:Cc:Subject:From;
        b=EtmfPgzuXB2jstB/KEGx9WHSljd1sMh3rEp9dTcmt+MVCvyzIjVzPr+LZjCmHyygV
         nf6pigK+4Ke81ikJOoOy3x36QWBezuiDAJdNM9mBdum51Ban+DgTkQ7xrmwdfIKpmj
         YW02BnULVzOgPJPgc4Ps+5+Fz0RTudeWL+GfTV8ERSjGxdoeyX/GAuHSCHONHIO+QZ
         ifVXMxP+vvAu/0FptNxeymz8rFXkJJXRLuVdFikpbNo1KvLYIbPr3M9Afveecxd3sa
         4/Kgyb5C20lCrMBpe1V2wyaKgbRGbhRD1/oq2fElsxhUADIRkLG4HAuicbQx9Jwaai
         MYXEpvBw5XbxA==
Date:   Tue, 6 Sep 2022 19:01:41 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Rolf Eike Beer <eb@emlix.com>,
        Steven Price <steven.price@arm.com>
Subject: linux-next: manual merge of the mm tree with Linus' tree
Message-ID: <20220906190141.028ea19a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/kg6XIbV3ufFgDa2yrs7qfxv";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_LOW,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/kg6XIbV3ufFgDa2yrs7qfxv
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  mm/pagewalk.c

between commit:

  8782fb61cc84 ("mm: pagewalk: Fix race between unmap and page walker")

from Linus' tree and commits:

  fa02fb928200 ("mm: pagewalk: make error checks more obvious")
  66c217081bd0 ("mm: pagewalk: allow walk_page_range_novma() without mm")

from the mm tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/pagewalk.c
index fa7a3d21a751,418717eec09e..000000000000
--- a/mm/pagewalk.c
+++ b/mm/pagewalk.c
@@@ -108,13 -104,16 +104,16 @@@ static int walk_pmd_range(pud_t *pud, u
 =20
  	pmd =3D pmd_offset(pud, addr);
  	do {
- again:
+ 		int err;
+=20
+  again:
  		next =3D pmd_addr_end(addr, end);
 -		if (pmd_none(*pmd) || (!walk->vma && !walk->no_vma)) {
 +		if (pmd_none(*pmd)) {
- 			if (ops->pte_hole)
+ 			if (ops->pte_hole) {
  				err =3D ops->pte_hole(addr, next, depth, walk);
- 			if (err)
- 				break;
+ 				if (err)
+ 					return err;
+ 			}
  			continue;
  		}
 =20
@@@ -169,13 -168,16 +168,16 @@@ static int walk_pud_range(p4d_t *p4d, u
 =20
  	pud =3D pud_offset(p4d, addr);
  	do {
+ 		int err;
+=20
   again:
  		next =3D pud_addr_end(addr, end);
 -		if (pud_none(*pud) || (!walk->vma && !walk->no_vma)) {
 +		if (pud_none(*pud)) {
- 			if (ops->pte_hole)
+ 			if (ops->pte_hole) {
  				err =3D ops->pte_hole(addr, next, depth, walk);
- 			if (err)
- 				break;
+ 				if (err)
+ 					return err;
+ 			}
  			continue;
  		}
 =20
@@@ -447,20 -456,17 +456,21 @@@ int walk_page_range(struct mm_struct *m
 =20
  	vma =3D find_vma(walk.mm, start);
  	do {
+ 		int err;
+=20
+ 		walk.vma =3D vma;
  		if (!vma) { /* after the last vma */
- 			walk.vma =3D NULL;
  			next =3D end;
 +			if (ops->pte_hole)
 +				err =3D ops->pte_hole(start, next, -1, &walk);
  		} else if (start < vma->vm_start) { /* outside vma */
  			walk.vma =3D NULL;
  			next =3D min(end, vma->vm_start);
 +			if (ops->pte_hole)
 +				err =3D ops->pte_hole(start, next, -1, &walk);
  		} else { /* inside vma */
- 			walk.vma =3D vma;
  			next =3D min(end, vma->vm_end);
- 			vma =3D vma->vm_next;
+ 			vma =3D find_vma(mm, vma->vm_end);
 =20
  			err =3D walk_page_test(start, next, &walk);
  			if (err > 0) {
@@@ -472,17 -478,26 +482,24 @@@
  				continue;
  			}
  			if (err < 0)
- 				break;
+ 				return err;
 -		}
 -		if (walk.vma || walk.ops->pte_hole) {
  			err =3D __walk_page_range(start, next, &walk);
+ 			if (err)
+ 				return err;
  		}
- 		if (err)
- 			break;
  	} while (start =3D next, start < end);
- 	return err;
+ 	return 0;
  }
 =20
- /*
+ /**
+  * walk_page_range_novma - walk a range of pagetables not backed by a vma
+  * @mm:		mm_struct representing the target process of page table walk
+  * @start:	start address of the virtual address range
+  * @end:	end address of the virtual address range
+  * @ops:	operation to call during the walk
+  * @pgd:	pgd to walk if different from mm->pgd
+  * @private:	private data for callbacks' usage
+  *
   * Similar to walk_page_range() but can walk any page tables even if they=
 are
   * not backed by VMAs. Because 'unusual' entries may be walked this funct=
ion
   * will also not lock the PTEs for the pte_entry() callback. This is usef=
ul for
@@@ -501,10 -518,11 +520,11 @@@ int walk_page_range_novma(struct mm_str
  		.no_vma		=3D true
  	};
 =20
- 	if (start >=3D end || !walk.mm)
+ 	if (start >=3D end || (!walk.mm && !walk.pgd))
  		return -EINVAL;
 =20
- 	mmap_assert_write_locked(walk.mm);
+ 	if (walk.mm)
 -		mmap_assert_locked(walk.mm);
++		mmap_assert_write_locked(walk.mm);
 =20
  	return walk_pgd_range(start, end, &walk);
  }

--Sig_/kg6XIbV3ufFgDa2yrs7qfxv
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmMXDHUACgkQAVBC80lX
0GwGLAgAk6oj6Wx6VpMwQRHHxiRD4cfu8kvx8dmiP7JM0Im0s5F8lvX479WuY04B
J5avBEhDbfXevmZpLN+TvU62Kr5UpJxcs2uso4CAAfFI9H6a+Se23vmEhJEu06aY
imnQEPbSRgbOgYfbmsAi7vup5G4BVfdJImvJJCon5+X2U8oaq/Pc8H40dhC67bB8
vSx11gMsgy+bOVwBeoSBnIvvkm4PUsG5yg1yyw6z4R+1CSzSl8CPk9RjWAVN0L89
wilG/0CoxH0pdoWnwl+30ZahOwLMIehyTf/nh7ykZIIm1GCu1G0J1QKFipc9iIP9
4mQ0L7HFSNdEncbPlWbiLzFVL3yBFg==
=6QMP
-----END PGP SIGNATURE-----

--Sig_/kg6XIbV3ufFgDa2yrs7qfxv--
