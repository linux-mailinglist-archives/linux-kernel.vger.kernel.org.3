Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 659EF4D982E
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:53:33 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346890AbiCOJy3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:54:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60070 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346857AbiCOJyR (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:54:17 -0400
Received: from gandalf.ozlabs.org (mail.ozlabs.org [IPv6:2404:9400:2221:ea00::3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7B34EBED;
        Tue, 15 Mar 2022 02:53:02 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHpcX0jwhz4xRB;
        Tue, 15 Mar 2022 20:53:00 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647337981;
        bh=oXrKZHFPKEFYK64Or/Hu81ZPN5Pi5Yx/O8XNN8iQ1us=;
        h=Date:From:To:Cc:Subject:From;
        b=AOd3pjFYC5QO1JCRGxvsiDdugjt3b8gCg0PQaxR4tL0xBYgn1+YImbXmLmeM9kxpx
         RVD/eIrVesKZHEU7TeO4Ax7DXrGkLZBHNPGujjzOkdJpIyhBkF9E7xkBrkHjuS8Abk
         OtbcttJiguhmUglb/UNCTrpLvQObHPrNHUIBtSGABSe5TFTd0oauHIyw2IJNsG/VMQ
         9sdhWGwWmQ/8cwaoGvFaMDqXf7KSoNriYwg+1Ph0ZlRCXmIrS8hNSrUosnQqX3Ib5N
         Rtypr2NRA/EDUurONCLcL7X2yH/Oq7Ch1IVUXQLteg/k2V9S7dRas9NEVRKqD9BRow
         XbQb/rpB0G8xA==
Date:   Tue, 15 Mar 2022 20:52:59 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>,
        Richard Weinberger <richard@nod.at>
Cc:     Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Zhihao Cheng <chengzhihao1@huawei.com>
Subject: linux-next: manual merge of the folio tree with the ubifs-fixes
 tree
Message-ID: <20220315205259.71b4238a@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/.wP75LYaKDQTnOQ7mCg.KJi";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/.wP75LYaKDQTnOQ7mCg.KJi
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  fs/ubifs/file.c

between commit:

  3b67db8a6ca8 ("ubifs: Fix to add refcount once page is set private")

from the ubifs-fixes tree and commit:

  c337f2f4f746 ("ubifs: Convert from invalidatepage to invalidate_folio")

from the folio tree.

I fixed it up (I hope - see below) and can carry the fix as
necessary. This is now fixed as far as linux-next is concerned, but any
non trivial conflicts should be mentioned to your upstream maintainer
when your tree is submitted for merging.  You may also want to consider
cooperating with the maintainer of the conflicting tree to minimise any
particularly complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ubifs/file.c
index 6b45a037a047,8a9ffc2d4167..000000000000
--- a/fs/ubifs/file.c
+++ b/fs/ubifs/file.c
@@@ -1304,8 -1304,8 +1304,8 @@@ static void ubifs_invalidate_folio(stru
  		release_existing_page_budget(c);
 =20
  	atomic_long_dec(&c->dirty_pg_cnt);
- 	detach_page_private(page);
- 	ClearPageChecked(page);
 -	folio_clear_private(folio);
++	folio_detach_private(folio);
+ 	folio_clear_checked(folio);
  }
 =20
  int ubifs_fsync(struct file *file, loff_t start, loff_t end, int datasync)

--Sig_/.wP75LYaKDQTnOQ7mCg.KJi
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwYfsACgkQAVBC80lX
0Gwq/wf/WHT8NhSMG7gMJw8I4Js39P21jI4SVNqZjOErX1hAIk8h3OZlt4j3wJNw
GamvJU3tNCVkDSYNBSCOBoRDipPbBX0Wy7fCNuKHmvO5iORrAFEzd3Yfes5cJuPS
iKkoTG4cViwaNxy9Izs8OX8IIabMCjb+xgqyzDAJYfmiU02ilsQ7pK+fcfAJTFTT
GB1L1JtKIw0pf0O12Yzngqfe9gc9itOMmHIEOJdgZhmGyg/I0QHu3zMm+1vbsWHD
Phpek9H3jn4/8cakWp4lnRzGNFNrGiokY/u5ZOuQ2nwd2e6nRwIPeG03EFqYbPJj
CYY8Pm56jSdljASAxfG60VffxprY0A==
=1t4B
-----END PGP SIGNATURE-----

--Sig_/.wP75LYaKDQTnOQ7mCg.KJi--
