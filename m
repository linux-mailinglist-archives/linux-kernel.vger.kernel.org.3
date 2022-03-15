Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 588EE4D97AA
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:31:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346623AbiCOJcd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:32:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48878 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S244353AbiCOJcb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:32:31 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1128D4ECCC;
        Tue, 15 Mar 2022 02:31:18 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHp7P58N5z4xNm;
        Tue, 15 Mar 2022 20:31:13 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647336676;
        bh=nMU9jrGSvbigdoyqQvgfktQ0ZN+1Bv9BixnK+MzkewY=;
        h=Date:From:To:Cc:Subject:From;
        b=abq96raPbem8Sql29ZOP5HdVjLIguzoQQLdi/psLuLK828JPhygHn0On62KKWbrvg
         HbEiTtb0W8znkrf8jVXqxjpcmjjC6FKftj/bns5FX4TAiane2cPfrmLtztkyBR/95h
         fjnxbwdzB3P4saF/WCF00fWV0bQyXoYaVIFtLAEINPOsTtlT4XDjtMKUifQ+QKuSfY
         bM4OXw0B0MUtqqDIhfzXg74a+nKDVTOjUz9sDmR3wROxwFqHCUEhyh+5L7D1lajJtA
         eqAob2N/3DinFiA0VlimmEjZ5V02gjsM1yMrxY7LNMUPlatVqDqU2VV3s83BNjisZL
         pDmCZ39Juuaqg==
Date:   Tue, 15 Mar 2022 20:31:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>, Gao Xiang <xiang@kernel.org>
Cc:     Gao Xiang <hsiangkao@linux.alibaba.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the erofs tree
Message-ID: <20220315203112.03f6120c@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/8TvW=Ep3q0FYicWp5oUaKff";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/8TvW=Ep3q0FYicWp5oUaKff
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  fs/erofs/super.c

between commit:

  ab6bfa6e1e22 ("erofs: refine managed inode stuffs")

from the erofs tree and commit:

  8c5b1ba024af ("erofs: Convert from invalidatepage to invalidate_folio")

from the folio tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/erofs/super.c
index e178100c162a,a64c422f6763..000000000000
--- a/fs/erofs/super.c
+++ b/fs/erofs/super.c
@@@ -532,24 -535,18 +532,23 @@@ static int erofs_managed_cache_releasep
  	return ret;
  }
 =20
 +/*
 + * It will be called only on inode eviction. In case that there are still=
 some
 + * decompression requests in progress, wait with rescheduling for a bit h=
ere.
 + * We could introduce an extra locking instead but it seems unnecessary.
 + */
- static void erofs_managed_cache_invalidatepage(struct page *page,
- 					       unsigned int offset,
- 					       unsigned int length)
+ static void erofs_managed_cache_invalidate_folio(struct folio *folio,
+ 					       size_t offset, size_t length)
  {
- 	const unsigned int stop =3D length + offset;
+ 	const size_t stop =3D length + offset;
 =20
- 	DBG_BUGON(!PageLocked(page));
+ 	DBG_BUGON(!folio_test_locked(folio));
 =20
  	/* Check for potential overflow in debug mode */
- 	DBG_BUGON(stop > PAGE_SIZE || stop < length);
+ 	DBG_BUGON(stop > folio_size(folio) || stop < length);
 =20
- 	if (offset =3D=3D 0 && stop =3D=3D PAGE_SIZE)
- 		while (!erofs_managed_cache_releasepage(page, GFP_NOFS))
+ 	if (offset =3D=3D 0 && stop =3D=3D folio_size(folio))
+ 		while (!erofs_managed_cache_releasepage(&folio->page, GFP_NOFS))
  			cond_resched();
  }
 =20

--Sig_/8TvW=Ep3q0FYicWp5oUaKff
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwXOAACgkQAVBC80lX
0GyavQgApdlRqmDQPKHTmYvvnVpaeBZEDQfjZXDJFVtnieJr1vws9bf/O6EGzMWC
DZxRQcrQk4K7ymcIoWJQL3fHqrL0cRaCbyrh17VljPt/HgkbiAJ3jZTK/HpbQAVC
03vH33lvFWEpfFYpaP8ZW5fbttFzamOJFS8IdwKZUbFCJA45P0zTtKhdaJsOF1uh
+xZFORYHzd81Uy49OM6IgPxwhpcAeyArvJ18mSx/eTb1bZ/90YC/79d4XqxSTTiJ
2g3PKPBFNvxX2njqnsDya7yghnueZX4+3D874L5CjvLce/opvzYoiqb3klfyyLMl
EVsJow0f2ePc0DZmi9q3SJkQG/h8zg==
=O6m0
-----END PGP SIGNATURE-----

--Sig_/8TvW=Ep3q0FYicWp5oUaKff--
