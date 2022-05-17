Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 24983529C2B
	for <lists+linux-kernel@lfdr.de>; Tue, 17 May 2022 10:19:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242950AbiEQISQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 17 May 2022 04:18:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243198AbiEQISE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 17 May 2022 04:18:04 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2519E49911;
        Tue, 17 May 2022 01:17:45 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L2TWR2YKSz4xXk;
        Tue, 17 May 2022 18:17:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652775460;
        bh=572SuXd7v4FRWek+kcJo9wkb5oH+FJnOllGT7clrH8g=;
        h=Date:From:To:Cc:Subject:From;
        b=S537oM7FIdlQhaKxoFDpQwJXehRPgBgifW16Xqr72nv4PfhwYl4Oiejovec8Qax7Y
         6m+bRkqy8O2VLJHCT7XX10FW+tzFON1B4xGyVyALDIYGYTR4dxQr8t8iWNKi5dqeuM
         Fyzgf0wmWBe72mD8jaW5YsxgHRb5M0U4PoBkGdMK+bi/MwrorCb0eyEigu5UM8Q9bk
         moVpRfB7JCEuwL3phTFv9JfSaKGnvb4BPkBv0MZgDDfLSuyrbn9sNDBJmJZP4rgNFj
         86PRzDfypm1LWuMdHadWiVaduHqOmJmfU/DZExfZi8G1ThAKtEnzTHLRXpn1pvndbM
         YnqHE06EnuqTw==
Date:   Tue, 17 May 2022 18:17:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Helge Deller <deller@gmx.de>
Cc:     Parisc List <linux-parisc@vger.kernel.org>,
        John David Anglin <dave.anglin@bell.net>,
        "Liam R. Howlett" <Liam.Howlett@Oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Subject: linux-next: manual merge of the mm tree with the parisc-hd tree
Message-ID: <20220517181737.102eec7a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/GEXnIpNlGZWHBpaVRHcF8xa";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/GEXnIpNlGZWHBpaVRHcF8xa
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  arch/parisc/kernel/cache.c

between commit:

  2d30c4586e69 ("parisc: Rewrite cache flush code for PA8800/PA8900")

from the parisc-hd tree and commit:

  25ba0672baad ("parisc: remove mmap linked list from cache handling")

from the mm tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc arch/parisc/kernel/cache.c
index 0fd04073d4b6,ab7c789541bf..000000000000
--- a/arch/parisc/kernel/cache.c
+++ b/arch/parisc/kernel/cache.c
@@@ -654,51 -559,50 +654,56 @@@ static void flush_cache_pages(struct vm
  			}
  		}
  	}
 -	return ptep;
  }
 =20
 -static void flush_cache_pages(struct vm_area_struct *vma, struct mm_struc=
t *mm,
 -			      unsigned long start, unsigned long end)
 +static inline unsigned long mm_total_size(struct mm_struct *mm)
  {
 -	unsigned long addr, pfn;
 -	pte_t *ptep;
 +	struct vm_area_struct *vma;
 +	unsigned long usize =3D 0;
++	VMA_ITERATOR(vmi, mm, 0);
 =20
- 	for (vma =3D mm->mmap; vma && usize < parisc_cache_flush_threshold; vma =
=3D vma->vm_next)
 -	for (addr =3D start; addr < end; addr +=3D PAGE_SIZE) {
 -		ptep =3D get_ptep(mm->pgd, addr);
 -		if (ptep) {
 -			pfn =3D pte_pfn(*ptep);
 -			flush_cache_page(vma, addr, pfn);
 -		}
++	for_each_vma(vmi, vma) {
++		if (usize >=3D parisc_cache_flush_threshold)
++			break;
 +		usize +=3D vma->vm_end - vma->vm_start;
+ 	}
 +	return usize;
  }
 =20
  void flush_cache_mm(struct mm_struct *mm)
  {
  	struct vm_area_struct *vma;
+ 	VMA_ITERATOR(vmi, mm, 0);
 =20
 -	/* Flushing the whole cache on each cpu takes forever on
 -	   rp3440, etc.  So, avoid it if the mm isn't too big.  */
 -	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
 -	    mm_total_size(mm) >=3D parisc_cache_flush_threshold) {
 -		if (mm->context.space_id)
 -			flush_tlb_all();
 +	/*
 +	 * Flushing the whole cache on each cpu takes forever on
 +	 * rp3440, etc. So, avoid it if the mm isn't too big.
 +	 *
 +	 * Note that we must flush the entire cache on machines
 +	 * with aliasing caches to prevent random segmentation
 +	 * faults.
 +	 */
 +	if (!parisc_requires_coherency()
 +	    ||  mm_total_size(mm) >=3D parisc_cache_flush_threshold) {
 +		if (WARN_ON(IS_ENABLED(CONFIG_SMP) && arch_irqs_disabled()))
 +			return;
 +		flush_tlb_all();
  		flush_cache_all();
  		return;
  	}
 =20
 +	/* Flush mm */
- 	for (vma =3D mm->mmap; vma; vma =3D vma->vm_next)
+ 	for_each_vma(vmi, vma)
 -		flush_cache_pages(vma, mm, vma->vm_start, vma->vm_end);
 +		flush_cache_pages(vma, vma->vm_start, vma->vm_end);
  }
 =20
 -void flush_cache_range(struct vm_area_struct *vma,
 -		unsigned long start, unsigned long end)
 +void flush_cache_range(struct vm_area_struct *vma, unsigned long start, u=
nsigned long end)
  {
 -	if ((!IS_ENABLED(CONFIG_SMP) || !arch_irqs_disabled()) &&
 -	    end - start >=3D parisc_cache_flush_threshold) {
 -		if (vma->vm_mm->context.space_id)
 -			flush_tlb_range(vma, start, end);
 +	if (!parisc_requires_coherency()
 +	    || end - start >=3D parisc_cache_flush_threshold) {
 +		if (WARN_ON(IS_ENABLED(CONFIG_SMP) && arch_irqs_disabled()))
 +			return;
 +		flush_tlb_range(vma, start, end);
  		flush_cache_all();
  		return;
  	}

--Sig_/GEXnIpNlGZWHBpaVRHcF8xa
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKDWiEACgkQAVBC80lX
0GyrLQf9GVM3Bv1aHnYRjNLCxQPO/wRAYJocfdnxj0DHUsq2Xs/qjw1/w4Jjb1fP
5vd0ekpd21+A3uzAi0rmwNbQ3BIwDEHJE3MWt5/LPRGXmu9x7bCJ1FVjGqR+kqxl
/EunM7S7wOOf6Yf7sSSx5dpX6YUpyBTW6FMLGUCnu8jv5SUdvJXltKc1aHPrAy4V
kuOP/7/CqhMk4hgENZPayjLYZ82nGuO2LKdbqkQZJM0cCBcvLJ4F2OK5y/yldNK+
wz49aGGKrFAAx/aS1mYOxAOnVLO92ttj6Eo4QiMN3IMSvJTE6FFFgTElfRlpUiIF
aqDI4mui8rgJSGnDOAT8SY3Dy0FI0A==
=q2H8
-----END PGP SIGNATURE-----

--Sig_/GEXnIpNlGZWHBpaVRHcF8xa--
