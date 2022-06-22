Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 660A5554253
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 07:38:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357078AbiFVFih (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 01:38:37 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40986 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1356662AbiFVFia (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 01:38:30 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8D8DC344D9;
        Tue, 21 Jun 2022 22:38:28 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LSXH62Jk3z4xDK;
        Wed, 22 Jun 2022 15:38:26 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655876307;
        bh=LUUwLjw7iuEoNxpjCe5cHtZx+w5EZfsgGyJeYltFNUE=;
        h=Date:From:To:Cc:Subject:From;
        b=SXrf7xvcna/Kw0IKBEsjfz+yr9QhQsdYcnEaAg2bONUoMm4TOqLEf/elpwZfJS43g
         kPPJBS/1vmIdNyDhjT6x8QsSdv+XOXnXOBkR75OaBUwtGfSdaw4SHvDlB66WmTKbDn
         LyZHwHitlR577zwExUQsHPy1tAWWbQiEFguWozX8PYdGKJsM7r3FxqRLgxjGJ5uygg
         fUw7QJ6BF/JRY89rtPmRe9hjc5wB82Wy+mUVW4MhANKeMr/+LqwMv/1pIfTq1j+M1q
         76NGdLsdBarH4oa+hKLOftW28wsD3VQkfRK//w3lg4osv7kt6NlK53oivfyAhyRx+m
         L4BxR8CzjXFxg==
Date:   Wed, 22 Jun 2022 15:38:15 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Muchun Song <songmuchun@bytedance.com>
Subject: linux-next: manual merge of the mm tree with the folio tree
Message-ID: <20220622153815.6f2e671a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Z8V.VCmlqsI_7xBtJg.29I/";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Z8V.VCmlqsI_7xBtJg.29I/
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  mm/vmscan.c

between commit:

  15077be8badc ("vmscan: Add check_move_unevictable_folios()")

from the folio tree and commits:

  cca700a8e695 ("mm: lru: use lruvec lock to serialize memcg changes")

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

diff --cc mm/vmscan.c
index 04f8671caad9,60335f974803..000000000000
--- a/mm/vmscan.c
+++ b/mm/vmscan.c
@@@ -4823,18 -4856,22 +4873,17 @@@ void check_move_unevictable_folios(stru
  	int pgrescued =3D 0;
  	int i;
 =20
 -	for (i =3D 0; i < pvec->nr; i++) {
 -		struct page *page =3D pvec->pages[i];
 -		struct folio *folio =3D page_folio(page);
 -		int nr_pages;
 -
 -		if (PageTransTail(page))
 -			continue;
 +	for (i =3D 0; i < fbatch->nr; i++) {
 +		struct folio *folio =3D fbatch->folios[i];
 +		int nr_pages =3D folio_nr_pages(folio);
 =20
 -		nr_pages =3D folio_nr_pages(folio);
  		pgscanned +=3D nr_pages;
 =20
- 		/* block memcg migration while the folio moves between lrus */
- 		if (!folio_test_clear_lru(folio))
+ 		lruvec =3D folio_lruvec_relock_irq(folio, lruvec);
+ 		if (!folio_test_lru(folio) || !folio_test_unevictable(folio))
  			continue;
 =20
- 		lruvec =3D folio_lruvec_relock_irq(folio, lruvec);
- 		if (folio_evictable(folio) && folio_test_unevictable(folio)) {
+ 		if (folio_evictable(folio)) {
  			lruvec_del_folio(lruvec, folio);
  			folio_clear_unevictable(folio);
  			lruvec_add_folio(lruvec, folio);

--Sig_/Z8V.VCmlqsI_7xBtJg.29I/
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKyqscACgkQAVBC80lX
0Gyifgf9FmDQt9lswhHTCBarL6quGI/frYph5f/EMGvdqm+zBOHjn0teCQ0qDUp2
QK0O7WUt8AtEFIrN3tsUgFX75b1qeAiAo94fZ7I0svwqeAStTFC1IU4DM1E/CJ30
iit4YAptt5XSgeeRLkS6VVfZM4B6GACO/04cqzBDH/jN/pXcrljAaoN/IRdPG5zA
Y+GEacPu3K5bhkVZDbEkl6DVqRlTUuPiV64KtVSSY3bCM1dQlJGgzGigKsIa6N5Q
yC435CIRls5SX/7JEfMfJg65+6dynAM+kZxE0hpogmaA4ewLBaAiGTjd+kbVHSbC
wj6Gr2KPrkjb79f40bCknKjs/A1ZvA==
=vlYP
-----END PGP SIGNATURE-----

--Sig_/Z8V.VCmlqsI_7xBtJg.29I/--
