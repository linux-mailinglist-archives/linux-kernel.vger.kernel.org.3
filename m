Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5A2DA522E03
	for <lists+linux-kernel@lfdr.de>; Wed, 11 May 2022 10:15:43 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243384AbiEKIPi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 11 May 2022 04:15:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52418 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238624AbiEKIPg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 11 May 2022 04:15:36 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D9C4E529F;
        Wed, 11 May 2022 01:15:35 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Kynln0N2Kz4xVP;
        Wed, 11 May 2022 18:15:33 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652256933;
        bh=l3GxOLtbw73sYny9t7lVVxAHv0bWf/ZyhbFpCZbGXBk=;
        h=Date:From:To:Cc:Subject:From;
        b=RsXkWr6WzQK86RjgqjZZDhrCKhJdo+aRACVIXqRBx3GUDkr8AylOSuemmsscjqEvu
         o4RyELWTikZN1kwXsi4yKbtTDld/Jl0efDl23WBapJkFwzsuZUrtsykuafpAWhT7ZO
         pyq+JVY4dzWUr+dlKqPRvJHA0vw9tqi1jK5exCdNfdg+PNIB4mj4A4IAE7+k/3tNrx
         PB/U5pWuXMNbtz8OWBP1cvq7nrhBHVT3nMr6tcJSjTsQLJJUkPDjsDXokSsG2lnqVl
         Vrf+2KKIBlgt1ob5ZeXXUdAy97EvUwE72oZeo+rv4CoRTTh5vRWUyCr10swAcE+ya9
         66IsdmOQgOzpw==
Date:   Wed, 11 May 2022 18:15:31 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Baolin Wang <baolin.wang@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: build failure after merge of the mm tree
Message-ID: <20220511181531.7f27a5c1@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/J+y7q7vuvY==dwLKkKUlYze";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/J+y7q7vuvY==dwLKkKUlYze
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

After merging the mm tree, today's linux-next build (sparc64 defconfig)
failed like this:

In file included from include/linux/hugetlb.h:757,
                 from arch/sparc/mm/hugetlbpage.c:11:
arch/sparc/include/asm/hugetlb.h: In function 'huge_ptep_clear_flush':
arch/sparc/include/asm/hugetlb.h:27:1: error: no return statement in functi=
on returning non-void [-Werror=3Dreturn-type]
   27 | }
      | ^

(and many more)

Caused by commit

  083af99303b9 ("mm: change huge_ptep_clear_flush() to return the original =
pte")

I applied the following hack to make it build.

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 11 May 2022 18:10:56 +1000
Subject: [PATCH] fix up for "mm: change huge_ptep_clear_flush() to return t=
he original pte"

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 arch/sparc/include/asm/hugetlb.h | 1 +
 1 file changed, 1 insertion(+)

diff --git a/arch/sparc/include/asm/hugetlb.h b/arch/sparc/include/asm/huge=
tlb.h
index b50aa6f8f9ab..0a26cca24232 100644
--- a/arch/sparc/include/asm/hugetlb.h
+++ b/arch/sparc/include/asm/hugetlb.h
@@ -24,6 +24,7 @@ pte_t huge_ptep_get_and_clear(struct mm_struct *mm, unsig=
ned long addr,
 static inline pte_t huge_ptep_clear_flush(struct vm_area_struct *vma,
 					  unsigned long addr, pte_t *ptep)
 {
+	return *ptep;
 }
=20
 #define __HAVE_ARCH_HUGE_PTEP_SET_WRPROTECT
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/J+y7q7vuvY==dwLKkKUlYze
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ7cKMACgkQAVBC80lX
0Gym7wf/XNKVY2qjh09VsvjnYKVVrvGP58LiYynPpbjCuwAQrM/o4B/bQy+7jjxJ
daXgGe5PdGfGzdKhgshQmmm+x5JUyAMZmk7+/ldutnk0g77YJzZOHsRPMZVEAkgd
rqZxl2W+FOpV9wL9nlI4LZk0ek+bi1icyu1YIgXr+H+I5NmGCzGbCF4a6lJB6McO
/RycjMgPrNYp6XO6PDWq+IWEIbKX1yEkklveStv8FlTtoznRIDPx9cfTA4lKz/Nh
025VoADugEXKkLFO6P9Ubg3sOfPzqIDsoO5C+SML3vK67nsvgyk9WlulBpyRYbTr
CK/Vnh2H47WqAgeoIZSh3mMygtXYgQ==
=XfcZ
-----END PGP SIGNATURE-----

--Sig_/J+y7q7vuvY==dwLKkKUlYze--
