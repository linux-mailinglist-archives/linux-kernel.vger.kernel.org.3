Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36D9D4B80A3
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Feb 2022 07:26:58 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229797AbiBPGUE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Feb 2022 01:20:04 -0500
Received: from gmail-smtp-in.l.google.com ([23.128.96.19]:36150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229519AbiBPGUA (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Feb 2022 01:20:00 -0500
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C42C41ACF3F;
        Tue, 15 Feb 2022 22:19:46 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4Jz78s5FjLz4xdl;
        Wed, 16 Feb 2022 17:19:41 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1644992383;
        bh=kaDHcbr3dh0VX0PRp5MNXgUvb4nHiUrlwz3mKEZw29I=;
        h=Date:From:To:Cc:Subject:From;
        b=jkunBFrpK2Bx+KlQpZdGesJ1bk0FTIRx+K+PZfZ8Pzjk3eR/yYDA+WBDimRfROZAr
         TNfhsqYWcJb+qa3C06Fw+IQiClN9vf5JdNvRGf4nu6VJamcJusKPXE2Mw2ORkt5Fwt
         UgqV0/+PUVvSjv1AVe3YgJTdOqBHzVbe7kAX8kM2lAkKDbh94+Srj/bPTnSTfcQQg2
         oKunX0eFCe0D63otRDs0dcXmhlMjj5W7GslOGYxzwqAgg1s6r0slfZ4f8ZGHAIlFqT
         BeFxjOfN/VJD/iIf0qbKTvlKUOOl83lSpJpFaqORX98JqT6xiHbFvMUs+IOtNySyU6
         c3lRKyFQa9lQQ==
Date:   Wed, 16 Feb 2022 17:15:12 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>
Cc:     Alex Sierra <alex.sierra@amd.com>,
        Alistair Popple <apopple@nvidia.com>,
        Christoph Hellwig <hch@lst.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the akpm-current tree with the folio
 tree
Message-ID: <20220216171512.60243a76@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/uSgS2W4KQ.ZDWmANhAS1Td.";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/uSgS2W4KQ.ZDWmANhAS1Td.
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/gup.c

between commit:

  024d57c2766e ("mm/gup: Convert check_and_migrate_movable_pages() to use a=
 folio")

from the folio tree and commits:

  d4dddc8ac982 ("mm: refactor check_and_migrate_movable_pages")
  2bba8945c42e ("mm/gup: fail get_user_pages for LONGTERM dev coherent type=
")
  de09ea3e8f88 ("mm/gup: migrate device coherent pages when pinning instead=
 of failing")

from the akpm-current tree.

I fixed it up (I think - see below) and can carry the fix as necessary.
This is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/gup.c
index 57bf69ac8ab4,4ab43b4fc9bc..000000000000
--- a/mm/gup.c
+++ b/mm/gup.c
@@@ -1783,50 -1844,84 +1786,85 @@@ static long check_and_migrate_movable_p
  					    struct page **pages,
  					    unsigned int gup_flags)
  {
- 	unsigned long i;
- 	unsigned long isolation_error_count =3D 0;
- 	bool drain_allow =3D true;
+ 	unsigned long isolation_error_count =3D 0, i;
 -	struct page *prev_head =3D NULL;
++	struct folio *prev_folio =3D NULL;
  	LIST_HEAD(movable_page_list);
- 	long ret =3D 0;
- 	struct folio *folio, *prev_folio =3D NULL;
- 	struct migration_target_control mtc =3D {
- 		.nid =3D NUMA_NO_NODE,
- 		.gfp_mask =3D GFP_USER | __GFP_NOWARN,
- 	};
+ 	bool drain_allow =3D true;
+ 	int ret =3D 0;
 =20
  	for (i =3D 0; i < nr_pages; i++) {
- 		folio =3D page_folio(pages[i]);
 -		struct page *head =3D compound_head(pages[i]);
++		struct folio *folio =3D page_folio(pages[i]);
+=20
 -		if (head =3D=3D prev_head)
 +		if (folio =3D=3D prev_folio)
  			continue;
 -		prev_head =3D head;
 +		prev_folio =3D folio;
+=20
  		/*
- 		 * If we get a movable page, since we are going to be pinning
- 		 * these entries, try to move them out if possible.
+ 		 * Device private pages will get faulted in during gup so it
+ 		 * shouldn't be possible to see one here.
  		 */
- 		if (!is_pinnable_page(&folio->page)) {
- 			if (folio_test_hugetlb(folio)) {
- 				if (!isolate_huge_page(&folio->page,
- 							&movable_page_list))
- 					isolation_error_count++;
- 			} else {
- 				if (!folio_test_lru(folio) && drain_allow) {
- 					lru_add_drain_all();
- 					drain_allow =3D false;
- 				}
 -		if (WARN_ON_ONCE(is_device_private_page(head))) {
++		if (WARN_ON_ONCE(is_device_private_page(&folio->page))) {
+ 			ret =3D -EFAULT;
+ 			goto unpin_pages;
+ 		}
 =20
- 				if (folio_isolate_lru(folio)) {
- 					isolation_error_count++;
- 					continue;
- 				}
- 				list_add_tail(&folio->lru, &movable_page_list);
- 				node_stat_mod_folio(folio,
- 						    NR_ISOLATED_ANON +
- 						    folio_is_file_lru(folio),
- 						    folio_nr_pages(folio));
+ 		/*
+ 		 * Device coherent pages are managed by a driver and should not
+ 		 * be pinned indefinitely as it prevents the driver moving the
+ 		 * page. So when trying to pin with FOLL_LONGTERM instead try
+ 		 * to migrate the page out of device memory.
+ 		 */
 -		if (is_device_coherent_page(head)) {
 -			WARN_ON_ONCE(PageCompound(head));
++		if (is_device_coherent_page(&folio->page)) {
++			WARN_ON_ONCE(PageCompound(&folio->page));
+=20
+ 			/*
+ 			 * Migration will fail if the page is pinned, so convert
+ 			 * the pin on the source page to a normal reference.
+ 			 */
+ 			if (gup_flags & FOLL_PIN) {
 -				get_page(head);
 -				unpin_user_page(head);
++				get_page(&folio->page);
++				unpin_user_page(&folio->page);
  			}
+=20
 -			pages[i] =3D migrate_device_page(head, gup_flags);
++			pages[i] =3D migrate_device_page(&folio->page, gup_flags);
+ 			if (!pages[i]) {
+ 				ret =3D -EBUSY;
+ 				goto unpin_pages;
+ 			}
+ 			continue;
  		}
+=20
 -		if (is_pinnable_page(head))
++		if (is_pinnable_page(&folio->page))
+ 			continue;
+=20
+ 		/*
+ 		 * Try to move out any movable page before pinning the range.
+ 		 */
 -		if (PageHuge(head)) {
 -			if (!isolate_huge_page(head, &movable_page_list))
++		if (folio_test_hugetlb(folio)) {
++			if (!isolate_huge_page(&folio->page,
++					       &movable_page_list))
+ 				isolation_error_count++;
+ 			continue;
+ 		}
+=20
 -		if (!PageLRU(head) && drain_allow) {
++		if (!folio_test_lru(folio) && drain_allow) {
+ 			lru_add_drain_all();
+ 			drain_allow =3D false;
+ 		}
+=20
 -		if (isolate_lru_page(head)) {
++		if (folio_isolate_lru(folio)) {
+ 			isolation_error_count++;
+ 			continue;
+ 		}
 -		list_add_tail(&head->lru, &movable_page_list);
 -		mod_node_page_state(page_pgdat(head),
 -				    NR_ISOLATED_ANON + page_is_file_lru(head),
 -				    thp_nr_pages(head));
++		list_add_tail(&folio->lru, &movable_page_list);
++		node_stat_mod_folio(folio,
++				    NR_ISOLATED_ANON + folio_is_file_lru(folio),
++				    folio_nr_pages(folio));
  	}
 =20
+ 	if (!list_empty(&movable_page_list) || isolation_error_count)
+ 		goto unpin_pages;
+=20
  	/*
  	 * If list is empty, and no isolation errors, means that all pages are
  	 * in the correct zone.

--Sig_/uSgS2W4KQ.ZDWmANhAS1Td.
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIMlnAACgkQAVBC80lX
0GyBaAf/YBepAUjDQtFdyo27jiIcVZQa2g4QO6XQFFOkHrxCxkj4RQUjyS+JDUTN
B1Z5AKSG9k6sQzWgYG6HQdeOw8vlgvzZ0esxe9ctZrpxLCyA6fWQ/whg2D3UJf/2
eBujJcZnsebPiDWFnkp2dtnZdMVSvjxGkVSG7H8RDhb+mshKHzZ8GVfRFKQeaAeA
0XDUhw0edDEbD2USMqhuvZQkmDy7DAiICJM0Zzf9bOwLZJHofKG/rvd6JM4alURY
zsbjQXtw5J576fj3JkUVlzi9+WMDpeeAF17oviBmO3XA9/2p/XUujKmoEzZ/Qze0
10+Ti45Ivq+nP8P3aMJ9jS0K3a1Oew==
=8XgI
-----END PGP SIGNATURE-----

--Sig_/uSgS2W4KQ.ZDWmANhAS1Td.--
