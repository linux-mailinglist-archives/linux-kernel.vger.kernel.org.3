Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D80EB4B9874
	for <lists+linux-kernel@lfdr.de>; Thu, 17 Feb 2022 06:53:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234522AbiBQFwp (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 17 Feb 2022 00:52:45 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:48440 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229831AbiBQFwj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 17 Feb 2022 00:52:39 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0B3A81CFDA;
        Wed, 16 Feb 2022 21:52:26 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4JzkVw4LpDz4xZ2;
        Thu, 17 Feb 2022 16:52:24 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1645077144;
        bh=pYqR6MZOlwSVLHFEQwNKC03gUA+C9Ql2XFR3NjHECGc=;
        h=Date:From:To:Cc:Subject:From;
        b=a+uc7txYQa0BMIK7Mb7B07yS1LYgz8KNggtkYnT1hYJsFyhAkZq9akGuwBLop8Za9
         PVbeRCiftRoSXVjXmP+SUSJ3Pw6QVxcCarQC8aCbZt9mTals+z4Scoo0BnXUI7sfL6
         rKROvAY3ve2ygmD8j/DqfnBkJeugBwHlJMLy3AsSp4GY4FOD3y2hi3EzHrsElEittT
         bZzMiOTKQQ6plOB+KPy4etlE6Swx0jk7eZNU7f/j/THWRJoYhxiMxw7q+nzlp6D03w
         TuONgT0R4bxzUO+3yN0Y62eX4qOFG3QRZQm4JjMqOI+RGGrLorE1RRo7CWD5JhOCNn
         nQ9zqyJ6dy1gA==
Date:   Thu, 17 Feb 2022 16:52:23 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Liam Howlett <liam.howlett@oracle.com>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the maple tree with the folio tree
Message-ID: <20220217165223.6313b475@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ROit3T/DQjpbnLjwG_wOyrr";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ROit3T/DQjpbnLjwG_wOyrr
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the maple tree got a conflict in:

  mm/internal.h

between commit:

  a02f3052febe ("mm: Turn page_anon_vma() into folio_anon_vma()")

from the folio tree and commits:

  93a635efa606 ("mm: Start tracking VMAs with maple tree")
  b09e8361a4c3 ("mm: Remove the vma linked list")

from the maple tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/internal.h
index f0e4dfac0264,2d3ede05cd7b..000000000000
--- a/mm/internal.h
+++ b/mm/internal.h
@@@ -67,12 -66,17 +67,13 @@@ static inline void wake_throttle_isolat
  vm_fault_t do_swap_page(struct vm_fault *vmf);
  void folio_rotate_reclaimable(struct folio *folio);
  bool __folio_end_writeback(struct folio *folio);
 +void deactivate_file_folio(struct folio *folio);
 =20
- void free_pgtables(struct mmu_gather *tlb, struct vm_area_struct *start_v=
ma,
- 		unsigned long floor, unsigned long ceiling);
+ void free_pgtables(struct mmu_gather *tlb, struct maple_tree *mt,
+ 		   struct vm_area_struct *start_vma, unsigned long floor,
+ 		   unsigned long ceiling);
  void pmd_install(struct mm_struct *mm, pmd_t *pmd, pgtable_t *pte);
 =20
 -static inline bool can_madv_lru_vma(struct vm_area_struct *vma)
 -{
 -	return !(vma->vm_flags & (VM_LOCKED|VM_HUGETLB|VM_PFNMAP));
 -}
 -
  struct zap_details;
  void unmap_page_range(struct mmu_gather *tlb,
  			     struct vm_area_struct *vma,
@@@ -388,12 -387,76 +389,78 @@@ static inline bool is_data_mapping(vm_f
  	return (flags & (VM_WRITE | VM_SHARED | VM_STACK)) =3D=3D VM_WRITE;
  }
 =20
- /* mm/util.c */
- void __vma_link_list(struct mm_struct *mm, struct vm_area_struct *vma,
- 		struct vm_area_struct *prev);
- void __vma_unlink_list(struct mm_struct *mm, struct vm_area_struct *vma);
+ /* Maple tree operations using VMAs */
+ /*
+  * vma_mas_store() - Store a VMA in the maple tree.
+  * @vma: The vm_area_struct
+  * @mas: The maple state
+  *
+  * Efficient way to store a VMA in the maple tree when the @mas has alrea=
dy
+  * walked to the correct location.
+  *
+  * Note: the end address is inclusive in the maple tree.
+  */
+ static inline int vma_mas_store(struct vm_area_struct *vma, struct ma_sta=
te *mas)
+ {
+ #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
+ 	/* Make sure no VMAs are about to be lost. */
+ 	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
+ 	struct vm_area_struct *vma_mas;
+ 	int count =3D 0;
+=20
+ 	mas_for_each(&test, vma_mas, vma->vm_end - 1) {
+ 		/* Rule out vma_expand */
+ 		if ((vma->vm_start !=3D vma_mas->vm_start) &&
+ 		    (vma->vm_end !=3D vma_mas->vm_end))
+ 			count++;
+ 	}
+=20
+ 	/* vma adjust may overwrite a partial entry or remove one */
+ 	BUG_ON(count > 1);
+=20
+ 	BUG_ON(mas->min > vma->vm_start);
+ 	BUG_ON(mas->index > vma->vm_start);
+ #endif
+ 	mas->index =3D vma->vm_start;
+ 	mas->last =3D vma->vm_end - 1;
+ 	return mas_store_gfp(mas, vma, GFP_KERNEL);
+ }
+=20
+ /*
+  * vma_mas_remove() - Remove a VMA from the maple tree.
+  * @vma: The vm_area_struct
+  * @mas: The maple state
+  *
+  * Efficient way to remove a VMA from the maple tree when the @mas has al=
ready
+  * been established and points to the correct location.
+  * Note: the end address is inclusive in the maple tree.
+  */
+ static inline int vma_mas_remove(struct vm_area_struct *vma, struct ma_st=
ate *mas)
+ {
+ 	int ret;
+=20
+ #ifdef CONFIG_DEBUG_VM_MAPLE_TREE
+ 	/* Make sure no VMAs are about to be lost. */
+ 	MA_STATE(test, mas->tree, vma->vm_start, vma->vm_end - 1);
+ 	struct vm_area_struct *vma_mas;
+ 	int count =3D 0;
+=20
+ 	mas_for_each(&test, vma_mas, vma->vm_end - 1)
+ 		count++;
+=20
+ 	BUG_ON(count !=3D 1);
+=20
+ 	BUG_ON(mas->min > vma->vm_start);
+ 	BUG_ON(mas->min > mas->index);
+ #endif
+ 	mas->index =3D vma->vm_start;
+ 	mas->last =3D vma->vm_end - 1;
+ 	ret =3D mas_store_gfp(mas, NULL, GFP_KERNEL);
+ 	return ret;
+ }
+=20
 +struct anon_vma *folio_anon_vma(struct folio *folio);
 +
  #ifdef CONFIG_MMU
  void unmap_mapping_folio(struct folio *folio);
  extern long populate_vma_page_range(struct vm_area_struct *vma,

--Sig_/ROit3T/DQjpbnLjwG_wOyrr
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIN4pcACgkQAVBC80lX
0Gytqwf/f85ixpn20VV84DIf5nvUnwxtisHxuxOtvONTKVP64aKQSf8WOK9wwijf
ehe3wgMO+Mku8WrWSsFykgXbwrKlODHnpdoWjz6nbKIC75QvJdZVuY4iMFj45iWy
fj2lav6Ffo3IRZTXYVGvJIXp7u9KVrJuCJLTtpBwNO2QRorF70KTWl12B5zGYkXO
6k6mJMqHoK4l5C2r6kl6GCWgekfUEa2+9Hjuu8ryq5+H42g5A/oKCi9rexDL9dHh
QQbg4iJbvF12bob7BU9u3No0iA7yCT+wQdPAnOBctBBJVG8H++5oou7x/3Dd5uCm
+txYSPRu/nICoIdDSYXJEQhTJVID8Q==
=/O6k
-----END PGP SIGNATURE-----

--Sig_/ROit3T/DQjpbnLjwG_wOyrr--
