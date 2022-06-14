Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6A17C54A799
	for <lists+linux-kernel@lfdr.de>; Tue, 14 Jun 2022 05:39:50 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239592AbiFNDjs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 13 Jun 2022 23:39:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36850 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231129AbiFNDjp (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 13 Jun 2022 23:39:45 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A941336142;
        Mon, 13 Jun 2022 20:39:43 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4LMZ1p0hzZz4xXD;
        Tue, 14 Jun 2022 13:39:42 +1000 (AEST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1655177982;
        bh=Hh+ePkStsIe1gE+KS8pLxfwNpOq01BuDHt5bQtIqf1I=;
        h=Date:From:To:Cc:Subject:From;
        b=VBmVLOmgXl15fg+eNw1kt/K9JjK8Ie4gNUILK8ZFTJK8KTECZUPfZLv/1MxQn+jez
         kjSah5G1iwQjVolO6koYlZdO01CNsevbC7ZY6RTPNEoChDigO2yi5Ald/1uL4GD6kw
         5+lGOr4qswxLr/mfsF9PZmZbSBRQu+r7Donw87Lyv6lVw709rwc6FawlsTMfsCDd7T
         ePJY5ebhGV0YiHI+zX7Og8NDJkFUN2t6k7pfLLGwbSMCNtGRk8tr1BDtoJ9fDMDoC5
         Ck9Z/ruMy/K5lTtqp66f0oXIvKded8O4VFXa5UWpI8r0E0vgQFWdr51WAPL8O11/qr
         dgGGDAcxm/N4w==
Date:   Tue, 14 Jun 2022 13:39:37 +1000
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linus Torvalds <torvalds@linux-foundation.org>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with Linus' tree
Message-ID: <20220614133937.35e152fe@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/ARCMLk2Uxbi2M_JJOicfXYh";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/ARCMLk2Uxbi2M_JJOicfXYh
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  include/linux/netfs.h

between commit:

  e81fb4198e27 ("netfs: Further cleanups after struct netfs_inode wrapper i=
ntroduced")

from Linus' tree and commit:

  0463e729a56d ("netfs: Remove extern from function prototypes")

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

diff --cc include/linux/netfs.h
index 097cdd644665,065163d50688..000000000000
--- a/include/linux/netfs.h
+++ b/include/linux/netfs.h
@@@ -276,19 -275,17 +276,18 @@@ struct netfs_cache_ops=20
  };
 =20
  struct readahead_control;
- extern void netfs_readahead(struct readahead_control *);
+ void netfs_readahead(struct readahead_control *);
  int netfs_read_folio(struct file *, struct folio *);
- extern int netfs_write_begin(struct netfs_inode *,
- 			     struct file *, struct address_space *,
- 			     loff_t, unsigned int, struct folio **,
- 			     void **);
-=20
- extern void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t=
, bool);
- extern void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
- 				 enum netfs_sreq_ref_trace what);
- extern void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
- 				 bool was_async, enum netfs_sreq_ref_trace what);
- extern void netfs_stats_show(struct seq_file *);
 -int netfs_write_begin(struct file *, struct address_space *, loff_t pos,
 -		      unsigned int len, struct folio **, void **fsdata);
++int netfs_write_begin(struct netfs_inode *, struct file *,
++		      struct address_space *, loff_t pos, unsigned int len,
++		      struct folio **, void **fsdata);
+=20
+ void netfs_subreq_terminated(struct netfs_io_subrequest *, ssize_t, bool);
+ void netfs_get_subrequest(struct netfs_io_subrequest *subreq,
+ 			  enum netfs_sreq_ref_trace what);
+ void netfs_put_subrequest(struct netfs_io_subrequest *subreq,
+ 			  bool was_async, enum netfs_sreq_ref_trace what);
+ void netfs_stats_show(struct seq_file *);
 =20
  /**
   * netfs_inode - Get the netfs inode context from the inode

--Sig_/ARCMLk2Uxbi2M_JJOicfXYh
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmKoAvoACgkQAVBC80lX
0GyLWggAl6qPxkJg+VxlBjcs4yHvMxHv0VYHkY6AaWR2E4wA7ops7wopuDwolpE0
5e8czu/AjtFjfHju1kXIRwHBXtdc+bx93nLEwrYKBeXEbQe2cWbov8XMh+TSXZxb
seAQ8cbOCIiP7iQKfgryH33RDuBVP+nGMqhDEcyV5wUSTJkTmwfEUDmt9HyMjoHI
xHLFFDsnrvq5XDia0HWujGTgJ2INIbnfTmhgEYz3aztCuUbRRw+QQhD6AK1JZ6ln
2uE63ftdVE0EbC58F2dXuH1NzwFY1YmvCUKKt0OlNNeSfaY8WQlXhblSXoRnUbY6
XZdIT/8ZdsyUkfnsSfCXc1CNQJUhtA==
=4OW5
-----END PGP SIGNATURE-----

--Sig_/ARCMLk2Uxbi2M_JJOicfXYh--
