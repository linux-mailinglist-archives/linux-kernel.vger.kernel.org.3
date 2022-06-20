Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4EA69550F18
	for <lists+linux-kernel@lfdr.de>; Mon, 20 Jun 2022 05:53:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238079AbiFTDxv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 19 Jun 2022 23:53:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42234 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231237AbiFTDxs (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 19 Jun 2022 23:53:48 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 229BFBE2E;
        Sun, 19 Jun 2022 20:53:47 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LRG3D64V6z4xXj;
        Mon, 20 Jun 2022 13:53:44 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655697225;
        bh=157GQDrY1KVl7TcujMT7k2WMX8cvZBlGubIwKBZm018=;
        h=Date:From:To:Cc:Subject:From;
        b=VwQv+k/0xPMkbPvtjZwEa4Cha3TLUtzAIRehfTHQujCiNkwA5aNrJCOzj7tvjWDkm
         UESYFCgw7lk3a4QAxjUDw5ZELydPwkQTYxIdqwuEIGAbytmxqFR7qlF0JT1KPNU1po
         HXwQvVTZ+sf/NfczF9kgzQS9Sm5/s2oDsLQfgFAnhOAUS8hXIAKr0aC/ssFEYY3qGy
         UUWYk7NsGqO0zc3hdEmFS54pbEGFUuj8RAO2JkL1X8aZNmpPF/LvJL7VEBi4I2//TR
         Qf86tPtMZwclZFHdX3xVhQfXHyv8sPNUCTTZaTwv8PCaoGU/n/Z6uOLt2MNZoi4xSq
         MQgu6jSm2nvLQ==
Date:   Mon, 20 Jun 2022 13:53:43 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Andrew Morton <akpm@linux-foundation.org>,
        Matthew Wilcox <willy@infradead.org>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the mm tree with the folio tree
Message-ID: <20220620135343.52f96bee@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/Ny926Ybvw2czoxn3dpkVEUT";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/Ny926Ybvw2czoxn3dpkVEUT
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the mm tree got a conflict in:

  include/linux/pagevec.h

between commit:

  132a550f50c4 ("filemap: Remove find_get_pages_range() and associated func=
tions")

from the folio tree and commit:

  229d98bdddcb ("mm/swap: make __pagevec_lru_add static")

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

diff --cc include/linux/pagevec.h
index 6649154a2115,b0e3540f3a4c..000000000000
--- a/include/linux/pagevec.h
+++ b/include/linux/pagevec.h
@@@ -26,7 -26,16 +26,6 @@@ struct pagevec=20
  };
 =20
  void __pagevec_release(struct pagevec *pvec);
- void __pagevec_lru_add(struct pagevec *pvec);
 -unsigned pagevec_lookup_range(struct pagevec *pvec,
 -			      struct address_space *mapping,
 -			      pgoff_t *start, pgoff_t end);
 -static inline unsigned pagevec_lookup(struct pagevec *pvec,
 -				      struct address_space *mapping,
 -				      pgoff_t *start)
 -{
 -	return pagevec_lookup_range(pvec, mapping, start, (pgoff_t)-1);
 -}
 -
  unsigned pagevec_lookup_range_tag(struct pagevec *pvec,
  		struct address_space *mapping, pgoff_t *index, pgoff_t end,
  		xa_mark_t tag);

--Sig_/Ny926Ybvw2czoxn3dpkVEUT
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKv70cACgkQAVBC80lX
0Gx/7wf9GVy9uyNjInEII05/0v1OnT77jS/8HAVLFdnA4B5r/wiL8XU/omjsRu85
qEHnrHWnKjsz1jf007GBcJSUSU5AlWtieSxWFK8JUT6Bg+l1EvJrqr5xMumOHZpX
x313jT48eTgTOVz+RnNew6sbqhkK/P98Iiu+ecRS99eBJgw55HkTsloyyjLTGyd9
PE2n+83XTorCe+CHIsxaejqJioxQcgQaJKFELkFHA7Rp215XGZqShX65v42pnRNk
G9xWWonsmJRkQBQiI8j/YL51sLNyZKzzSkfWimUqUzSCZW+VRk0HsF25nfzdAJyN
cexFREQyP8DAOTuNvkB7TMdHeFYvmQ==
=aqM4
-----END PGP SIGNATURE-----

--Sig_/Ny926Ybvw2czoxn3dpkVEUT--
