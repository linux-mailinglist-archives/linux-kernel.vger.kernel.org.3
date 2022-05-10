Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DD0FB520FD5
	for <lists+linux-kernel@lfdr.de>; Tue, 10 May 2022 10:39:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238099AbiEJInO (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 10 May 2022 04:43:14 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236464AbiEJInL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 10 May 2022 04:43:11 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0D8772631E0;
        Tue, 10 May 2022 01:39:12 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KyBKV0njmz4ySc;
        Tue, 10 May 2022 18:39:09 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1652171951;
        bh=7LR72tovo0ogawpq2JyC0EYhYgvgWno6oZIg1I1iyxk=;
        h=Date:From:To:Cc:Subject:From;
        b=cIfSs0ETusNLIbTX2lseoXuYKePdr2kpAFCvTg24RNuZDIE1jbpfzGqBGjwM7aF9m
         5NhYsMHOz7+6/lkjoo8A4ZraH7yfuvex2PC32mVQWdMmRmreIsBa+R0eQM6YqHxPwY
         Xnk8INFaz68jB7i1A8phoDWqAM42RVSdQefWE3uaGGQb4lUPqoElOm4YWs8L/Z0UV6
         nlbwfoD5/kJz0WaphxI7uct1iQXgBCTmHJiioIGyIrfknBwQqU7vsWWwOWlSAcYrCL
         kW22jNdbATh49ivj4P9kFkeFAcq/9E6HoZZIYGbUBsER1Qg7oRq1F5upA5zKdlcJmc
         XguB5sCxEE2jg==
Date:   Tue, 10 May 2022 18:39:08 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        David Sterba <dsterba@suse.cz>
Cc:     David Sterba <dsterba@suse.com>, Filipe Manana <fdmanana@suse.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the btrfs tree
Message-ID: <20220510183908.7571cb73@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/=7FizyL.aR57VoR.BZIAaDh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE,
        URIBL_BLOCKED autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/=7FizyL.aR57VoR.BZIAaDh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  fs/btrfs/send.c

between commit:

  d1a1a97304b4 ("btrfs: send: keep the current inode open while processing =
it")

from the btrfs tree and commit:

  2ebdd1df3166 ("mm/readahead: Convert page_cache_async_readahead to take a=
 folio")

from the folio tree.

I fixed it up (I think - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/btrfs/send.c
index 8e8e4ab59930,8985d115559d..000000000000
--- a/fs/btrfs/send.c
+++ b/fs/btrfs/send.c
@@@ -4905,13 -4984,14 +4905,14 @@@ static int put_file_data(struct send_ct
  			}
  		}
 =20
 -		if (PageReadahead(page)) {
 -			page_cache_async_readahead(inode->i_mapping, &sctx->ra,
 -						NULL, page_folio(page), index,
 -						last_index + 1 - index);
 -		}
 +		if (PageReadahead(page))
 +			page_cache_async_readahead(sctx->cur_inode->i_mapping,
- 						   &sctx->ra, NULL, page, index,
++						   &sctx->ra, NULL,
++						   page_folio(page), index,
 +						   last_index + 1 - index);
 =20
  		if (!PageUptodate(page)) {
- 			btrfs_readpage(NULL, page);
+ 			btrfs_read_folio(NULL, page_folio(page));
  			lock_page(page);
  			if (!PageUptodate(page)) {
  				unlock_page(page);

--Sig_/=7FizyL.aR57VoR.BZIAaDh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmJ6JKwACgkQAVBC80lX
0GykKAf/XrJEgp/mrvADJxmkpWwQUY0gmFEdMhuXUk/wniZgdPBSBxFG49Zzfpo5
JIrhc/pfGSuVG7OAzJzb2CRf3Ctf2Wp/6YS9F78l95D3s1OrBS3RagdF+Z8zANce
C3lO62+PQAcqCRaLPOgomdIJ5LsfMRBXL45KhSMm9lvf/g+WVJK/RclLpJjJy/Qq
flpYwqgEA/zubFbrOR4b+qdJpwWSsKOAqwFLmOxoLpANm6NEl7xfQgoS4Jj2ARBp
DUsdZeAio5EzpXQi6EzYVcIaL5AES1Pc/TbHzE739WG1uKIZ5QfcKDpgQUS8gAky
DQqUxElr57BQOLI9K00z8ZaUluXKSw==
=FjUp
-----END PGP SIGNATURE-----

--Sig_/=7FizyL.aR57VoR.BZIAaDh--
