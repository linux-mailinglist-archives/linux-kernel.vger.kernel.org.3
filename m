Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2DC5D554446
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1352130AbiFVHLf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:11:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47716 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232097AbiFVHLd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:11:33 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 626A036B6D;
        Wed, 22 Jun 2022 00:11:32 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LSZLS3mP6z4xYD;
        Wed, 22 Jun 2022 17:11:28 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655881888;
        bh=C+XLyUJ+FVz7Fk/fEFlMlBGYk8u2KjFmr+Uy6ezbShU=;
        h=Date:From:To:Cc:Subject:In-Reply-To:References:From;
        b=OHIxUiNDzWOafELFL0RZZ80G9St9kMJ/6pq6c5QcEzNlQ/YlP/YIAmfuoDu4vjD04
         4/8PNP5NPb504cMJ0DevGyHEX4BK59URY5p1E4iU1ZSdot3BNc2DF4hGzJRIcRGOSH
         gRCoA9hevp+00uhunRFXpFrfLgLyJ3YDgdcsQxS+qSMN5MgmKqayul9iCim+QBsxHS
         D3a9uOyaf2mRyHvoSJBJWWe81vleG213yGRdq4iS84ozJk7kxMlz0WAvS2ZEH8OHu0
         PKseZSGB1uEK98MaBn/MhuN79di0RAHHCLO1ZSMx9IiEthxw9T3RRe7CKMxYmIg1wk
         VGGnqbdkTgf5g==
Date:   Wed, 22 Jun 2022 17:11:17 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>
Cc:     Mike Kravetz <mike.kravetz@oracle.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: Re: linux-next: build warning after merge of the mm tree
Message-ID: <20220622171117.70850960@canb.auug.org.au>
In-Reply-To: <20220622155408.3ba2a9b7@canb.auug.org.au>
References: <20220622155408.3ba2a9b7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/lvTGmMDyENx41tvhX22XQf4";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,RCVD_IN_DNSWL_NONE,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/lvTGmMDyENx41tvhX22XQf4
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

On Wed, 22 Jun 2022 15:54:08 +1000 Stephen Rothwell <sfr@canb.auug.org.au> =
wrote:
>=20
> After merging the mm tree, today's linux-next build (powerpc
> ppc64_defconfig) produced this warning:
>=20
> mm/hugetlb.c: In function 'hugetlb_mask_last_page':
> mm/hugetlb.c:6908:23: warning: unused variable 'hp_size' [-Wunused-variab=
le]
>  6908 |         unsigned long hp_size =3D huge_page_size(h);
>       |                       ^~~~~~~
>=20
> Introduced by commit
>=20
>   76005bedbc32 ("hugetlb: do not update address in huge_pmd_unshare")

This became a build failure in my powerpc allyesconfig build, so I
applied this patch:

From: Stephen Rothwell <sfr@canb.auug.org.au>
Date: Wed, 22 Jun 2022 17:04:46 +1000
Subject: [PATCH] hugetlb: fix an unused variable warning/error

Signed-off-by: Stephen Rothwell <sfr@canb.auug.org.au>
---
 mm/hugetlb.c | 4 +---
 1 file changed, 1 insertion(+), 3 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index 2e4a92cebd9c..f338640fbe4a 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -6905,10 +6905,8 @@ unsigned long hugetlb_mask_last_page(struct hstate *=
h)
 /* See description above.  Architectures can provide their own version. */
 __weak unsigned long hugetlb_mask_last_page(struct hstate *h)
 {
-	unsigned long hp_size =3D huge_page_size(h);
-
 #ifdef CONFIG_ARCH_WANT_HUGE_PMD_SHARE
-	if (hp_size =3D=3D PMD_SIZE)
+	if (huge_page_size(h) =3D=3D PMD_SIZE)
 		return PUD_SIZE - PMD_SIZE;
 #endif
 	return 0UL;
--=20
2.35.1

--=20
Cheers,
Stephen Rothwell

--Sig_/lvTGmMDyENx41tvhX22XQf4
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKywJUACgkQAVBC80lX
0GwS1Qf/esEO3TgNLz3D51kpLVpgRbNTNjXwu5Wl3eRcHDvTrAIs16PIwlARQVy0
USr1r3F37po9ttEGQq/5YSZztE91m7fK1E+07cYTEg3NQc1tKJcuv8UnzZSNqM0d
/ALTzfiFDHX9Xk3e2CsomsrWOAxrfiDWBcRKEoigScT/psQQ2UZlx3PZmYHmljBx
dKd5UJHJztyW/1s7WlOFLND0eDDQJuGR9RUjgO8xKSWgYU8t1vq8InAdWtGd7+OP
kXyG6aCOCYTq7jh90eaEJoxCQvwHlmgEUBBXBgJDvTkobcR4qxPyfc9+bIrMSjoH
BcociPWjNFZwUJgB+vD+9d0gu/tUdA==
=ykRD
-----END PGP SIGNATURE-----

--Sig_/lvTGmMDyENx41tvhX22XQf4--
