Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E1D87525C38
	for <lists+linux-kernel@lfdr.de>; Fri, 13 May 2022 09:19:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377774AbiEMHSv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 13 May 2022 03:18:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42116 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1377778AbiEMHSq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 13 May 2022 03:18:46 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 96D3B2878E2;
        Fri, 13 May 2022 00:18:44 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4L00PC5x3qz4xXn;
        Fri, 13 May 2022 17:18:39 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652426320;
        bh=Ry7ba0ogTE6yHlJj3l0xHb6hRYa9Yi7LeK2WldUvqjI=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=LMvGYq67D6ahXcnoUHOHm1PO12WuhH6R7N1fnv28ycEig7IUeUPkwL4gsbiAEPv55
         0BCk4caofxYiqno6As1KeRz8osntqfimRz5/9YpW4Nxv7Dr1xnwhTDM2dV4H+pfNaQ
         28TSac5dp+B3RYpKd2LleNuy7n8dn5hQsLt6qst6Y4MRodQlXqTceD2gVo1f5nygOx
         1FebmXFr6R2BSKZQZZdJe7xPpOkAxP3dYjV4ef+m5wjVUjxMsPXVyZ7dtLMwo5eh1I
         vnSnuRukd+UqqiWErJVzv8jYRn2MWJZUlR16gIdGLO55wuTv5NOj2Xy+fRzKSqCvsv
         Vk2AE4USvmbeQ==
Date:   Fri, 13 May 2022 17:18:38 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Catalin Marinas <catalin.marinas@arm.com>
Cc:     Andrew Morton <akpm@linux-foundation.org>,
        Will Deacon <will@kernel.org>,
        Anshuman Khandual <anshuman.khandual@arm.com>,
        Baolin Wang <baolin.wang@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build failure after merge of the mm tree
Message-ID: <20220513171838.627ccc86@canb.auug.org.au>
In-Reply-To: <YnzqffV7STYS24Yn@arm.com>
References: <20220512193855.4f6ce32f@canb.auug.org.au>
        <YnzqffV7STYS24Yn@arm.com>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/S6tyXvo/95AbDqwnih9JeJ8";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/S6tyXvo/95AbDqwnih9JeJ8
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi Catalin,

On Thu, 12 May 2022 12:07:41 +0100 Catalin Marinas <catalin.marinas@arm.com=
> wrote:
>
> Note that after the arm64 commit, get_clear_contig() no longer flushes
> the TLB. So maybe something like:
>=20
> diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
> index 30f5b76aabe9..9a999550df8e 100644
> --- a/arch/arm64/mm/hugetlbpage.c
> +++ b/arch/arm64/mm/hugetlbpage.c
> @@ -485,12 +485,15 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *=
vma,
>  {
>  	size_t pgsize;
>  	int ncontig;
> +	pte_t orig_pte;
>=20
>  	if (!pte_cont(READ_ONCE(*ptep)))
>  		return ptep_clear_flush(vma, addr, ptep);
>=20
>  	ncontig =3D find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
> -	return get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
> +	orig_pte =3D get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
> +	flush_tlb_range(vma, addr, addr + pgsize * ncontig);
> +	return orig_pte;
>  }
>=20
>  static int __init hugetlbpage_init(void)

I have modified my merge resolution patch to as in the above so it
looks like this now:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Fri, 13 May 2022 17:08:07 +1000
Subject: [PATCH] fixup for "mm: change huge_ptep_clear_flush() to return th=
e original pte"

It interacts with commit

  fb396bb459c1 ("arm64/hugetlb: Drop TLB flush from get_clear_flush()")

from the arm64 tree

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/arm64/mm/hugetlbpage.c | 5 ++++-
 1 file changed, 4 insertions(+), 1 deletion(-)

diff --git a/arch/arm64/mm/hugetlbpage.c b/arch/arm64/mm/hugetlbpage.c
index 5bdf913dedc7..10b4a19ed6a2 100644
--- a/arch/arm64/mm/hugetlbpage.c
+++ b/arch/arm64/mm/hugetlbpage.c
@@ -485,12 +485,15 @@ pte_t huge_ptep_clear_flush(struct vm_area_struct *vm=
a,
 {
 	size_t pgsize;
 	int ncontig;
+	pte_t orig_pte;
=20
 	if (!pte_cont(READ_ONCE(*ptep)))
 		return ptep_clear_flush(vma, addr, ptep);
=20
 	ncontig =3D find_num_contig(vma->vm_mm, addr, ptep, &pgsize);
-	return get_clear_flush(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	orig_pte =3D get_clear_contig(vma->vm_mm, addr, ptep, pgsize, ncontig);
+	flush_tlb_range(vma, addr, addr + pgsize * ncontig);
+	return orig_pte;
 }
=20
 static int __init hugetlbpage_init(void)
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/S6tyXvo/95AbDqwnih9JeJ8
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ+Bk4ACgkQAVBC80lX
0GxnEQgAnmB5YyNJxCEZkMLv9LEMvl/mtMzQAG9P53jT6S9/ghNP4Cs5Nu5WL3is
CZPmCdZe6kH7svVzjWxZeVykPaAvDmDFcGG8wCE/aZBIRrz7gFRGZVh+ewMSxhUf
PE2/WaBVTKCZbk/MmATYrTJN4/sepWyHqS7HNtfNjCwtLrdU2a4Xiogtxy78gmJe
BOLaH9qtKuonXrbVpLwpd0ulHZSqd3jF8fY8k8S0YJF1eM+rmjbGVMMqP7OBudre
AaE+hCIX/nTXltbJkyB1FZvqLqgws36enZiQNjWcrBsivbc259HyJPIHXDWJ1BaG
NHs2eiCsXVXoEthvnnBcwtaMgq454Q==
=xeD6
-----END PGP SIGNATURE-----

--Sig_/S6tyXvo/95AbDqwnih9JeJ8--
