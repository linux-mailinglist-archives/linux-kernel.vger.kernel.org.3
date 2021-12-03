Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D61A5467285
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 08:23:00 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378844AbhLCH0W (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 02:26:22 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40120 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378803AbhLCH0V (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 02:26:21 -0500
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [IPv6:2404:9400:2:0:216:3eff:fee2:21ea])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E1DEEC06174A;
        Thu,  2 Dec 2021 23:22:57 -0800 (PST)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4J546S2kbmz4xR9;
        Fri,  3 Dec 2021 18:22:56 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1638516176;
        bh=0fQh2JFLE8KUQBXTDiLGqyuo6BspFwMlmE9VNq4wgx8=;
        h=Date:From:To:Cc:Subject:From;
        b=jvhzde6HotZHJ/CHr6KOQPfWGVwKtuw00kZs9WBhZwCd/1h3G4aLlhW2MxHXJjofg
         ZwJYMQ6CRHzKGHN3sasE/He1iUd9wvaDBfwN50NJlF5aBo4xhPoPJKDP+K3m/TcV9t
         9F4cpsRz29TLL8snXjJj9UmIfBsaOtu1tbOdhRui9SJtR5hbEj4duuzOsXxOF8/LeK
         mykuz+7D0pZdrezOIwQ+/cUaxlBFIfPUHPpYo7idExlrXNLeqyHu2SQKzYpHlRR1rC
         Moyiyug8tC5tD16JSLVCAxeL0eL4JAGUflw29vHtGGVDXmszWtAKZjgiuM5D/7oq8U
         nnBPKGGlNLk6g==
Date:   Fri, 3 Dec 2021 18:22:55 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Vlastimil Babka <vbabka@suse.cz>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        "Matthew Wilcox (Oracle)" <willy@infradead.org>,
        Minchan Kim <minchan@kernel.org>
Subject: linux-next: manual merge of the akpm-current tree with the slab
 tree
Message-ID: <20211203182255.3800a09a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/6WoDhAv/5yHNT=T+xTuaqKf";
 protocol="application/pgp-signature"; micalg=pgp-sha256
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/6WoDhAv/5yHNT=T+xTuaqKf
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the akpm-current tree got a conflict in:

  mm/zsmalloc.c

between commit:

  5718b5cdd6e5 ("zsmalloc: Stop using slab fields in struct page")

from the slab tree and commit:

  efcc1718fe08 ("zsmalloc: move huge compressed obj from page to zspage")

from the akpm-current tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc mm/zsmalloc.c
index 0d3b65939016,7e03cc9363bb..000000000000
--- a/mm/zsmalloc.c
+++ b/mm/zsmalloc.c
@@@ -824,10 -820,12 +820,12 @@@ static struct zspage *get_zspage(struc
 =20
  static struct page *get_next_page(struct page *page)
  {
- 	if (unlikely(PageHugeObject(page)))
+ 	struct zspage *zspage =3D get_zspage(page);
+=20
+ 	if (unlikely(ZsHugePage(zspage)))
  		return NULL;
 =20
 -	return page->freelist;
 +	return (struct page *)page->index;
  }
 =20
  /**
@@@ -900,8 -893,7 +893,7 @@@ static void reset_page(struct page *pag
  	ClearPagePrivate(page);
  	set_page_private(page, 0);
  	page_mapcount_reset(page);
- 	ClearPageHugeObject(page);
 -	page->freelist =3D NULL;
 +	page->index =3D 0;
  }
 =20
  static int trylock_zspage(struct zspage *zspage)
@@@ -1042,9 -1039,9 +1039,9 @@@ static void create_page_chain(struct si
  			SetPagePrivate(page);
  			if (unlikely(class->objs_per_zspage =3D=3D 1 &&
  					class->pages_per_zspage =3D=3D 1))
- 				SetPageHugeObject(page);
+ 				SetZsHugePage(zspage);
  		} else {
 -			prev_page->freelist =3D page;
 +			prev_page->index =3D (unsigned long)page;
  		}
  		prev_page =3D page;
  	}

--Sig_/6WoDhAv/5yHNT=T+xTuaqKf
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmGpxc8ACgkQAVBC80lX
0GxkZAf/ZtPJUn3XFIiONH6j+tPiKmrS3F+dTvSrKM/wcNlm9niy0367+HF3N4bB
JHh3FmTIUzX51I//WVpm1h9LykZs+4eSTd8E7K3Qqk3waUvyzTL00nDiMzyjfCsv
6IzIFzdliEfymwAhJq4iXvx4Bnk6oCOIHybb6m3U1gvc8pacrXOZzSoZHRVRL5wW
U09VnBZb0JTTJB2nxGmY41rwuy6Gsm+7kabDAtLMHoftRVYrzS5QEXxbLSZrxcLu
eR7E4e6yqWYX99xvOmJ556wIsdRf/6LeropE+nEy5Hf00Hkgq7OAbY32Hok7/pBw
aqwrdBqVKQ2sMvPSwMvbvP0NHzas2A==
=YlK6
-----END PGP SIGNATURE-----

--Sig_/6WoDhAv/5yHNT=T+xTuaqKf--
