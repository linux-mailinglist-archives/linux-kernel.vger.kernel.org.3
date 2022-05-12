Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79E275247D8
	for <lists+linux-kernel@lfdr.de>; Thu, 12 May 2022 10:27:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351429AbiELI1F (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 12 May 2022 04:27:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:44076 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237176AbiELI06 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 12 May 2022 04:26:58 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A0CEA70919;
        Thu, 12 May 2022 01:26:56 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KzPyM29mXz4xLR;
        Thu, 12 May 2022 18:26:51 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652344012;
        bh=ezYpyKBBhFLLjyJM6tczei2LbXIhmGczbMevqER6udk=;
        h=Date:From:To:Cc:Subject:From;
        b=Yj9sLx2JoQbXp2jFooa1LXS2Oxg1GytqJJHF2Wl0Sxo7C8ZptBYLkUY5Kqlzbp8HO
         KQ7Cz596VjQe3DxzsTCHFvFPRezBhS5vxMl6M1VXREadNkyhlm7TGKVIYFPoVQbtnN
         vGqxWWBq29bfTF+Tfe45YKrimibwJiiF6z0NgrO6p37IGts7A9h2uPJGK+rqE0/dDa
         RB5EeQczTNeqe4bL0r1dF3raPPuW7h/7WemKDvZ4rOb1DUUV0TJ7ZBOfx8ewLb5Xd7
         RYVgXXWBx6LWzIK6nvJhy4+nUMjSM5u6VCs0O3XA9uyjXwjz7qM565tKwsEgy/M4aa
         yVvvKrC7E5tjg==
Date:   Thu, 12 May 2022 18:26:50 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Ryusuke Konishi <konishi.ryusuke@gmail.com>,
        Yang Li <yang.lee@linux.alibaba.com>
Subject: linux-next: manual merge of the mm tree with the folio tree
Message-ID: <20220512182650.7d1a94c7@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/heYDsmh6dhCMvkcDGvlpdP9";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/heYDsmh6dhCMvkcDGvlpdP9
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  fs/nilfs2/inode.c

between commit:

  f132ab7d3ab0 ("fs: Convert mpage_readpage to mpage_read_folio")

from the folio tree and commit:

  e38ed506c42f ("nilfs2: Fix some kernel-doc comments")

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

diff --cc fs/nilfs2/inode.c
index 538ca5473b0d,6a00cf324cbd..000000000000
--- a/fs/nilfs2/inode.c
+++ b/fs/nilfs2/inode.c
@@@ -140,14 -140,14 +140,14 @@@ int nilfs_get_block(struct inode *inode
  }
 =20
  /**
 - * nilfs_readpage() - implement readpage() method of nilfs_aops {}
 + * nilfs_read_folio() - implement read_folio() method of nilfs_aops {}
   * address_space_operations.
-  * @file - file struct of the file to be read
-  * @folio - the folio to be read
+  * @file: file struct of the file to be read
 - * @page: the page to be read
++ * @folio: the folio to be read
   */
 -static int nilfs_readpage(struct file *file, struct page *page)
 +static int nilfs_read_folio(struct file *file, struct folio *folio)
  {
 -	return mpage_readpage(page, nilfs_get_block);
 +	return mpage_read_folio(folio, nilfs_get_block);
  }
 =20
  static void nilfs_readahead(struct readahead_control *rac)

--Sig_/heYDsmh6dhCMvkcDGvlpdP9
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ8xMoACgkQAVBC80lX
0Gx6hggAlCZKb3CYe0EHnxg/AYS/i/aRkfSDLt0dsos3/bIcyloVI5mUy4AQOzoK
xdX6N8AhkOAHtjwpq/2ZJMc349jaRjxdkptjWto6q4m351zCnxU5N+jZRc3BgElg
dkYPQj8OpS9l1ipktLqYAZLw+AXcZivyolnJzJ+9Q93wQM+ltjPRgGZC5E13pKeS
9l3EyEdxI3DexuNauyhgSlVgXJYRsifEjZKIb73RCTrQYgT0i9Tim5AVVzReowJh
mmJyl3Et4Mhfm1nXsmGyZKf9Q65vFbiBWswvYehyKppAYFgdfyJVDKFwuzuS3pCu
hOUj90rccGrbCftC107J8Qzfd3HSwA==
=7gtm
-----END PGP SIGNATURE-----

--Sig_/heYDsmh6dhCMvkcDGvlpdP9--
