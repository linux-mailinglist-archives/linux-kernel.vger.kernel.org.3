Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7B91C4D97DC
	for <lists+linux-kernel@lfdr.de>; Tue, 15 Mar 2022 10:40:20 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346703AbiCOJl0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 15 Mar 2022 05:41:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233221AbiCOJlX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 15 Mar 2022 05:41:23 -0400
Received: from gandalf.ozlabs.org (gandalf.ozlabs.org [150.107.74.76])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C96D84ECFF;
        Tue, 15 Mar 2022 02:40:10 -0700 (PDT)
Received: from authenticated.ozlabs.org (localhost [127.0.0.1])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-256) server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        by mail.ozlabs.org (Postfix) with ESMTPSA id 4KHpKh4GfCz4xLQ;
        Tue, 15 Mar 2022 20:40:08 +1100 (AEDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=canb.auug.org.au;
        s=201702; t=1647337209;
        bh=+W7q2MrZPwI4JUFKKW5+cHmHOtdaZBaq4G59lSvj7Ak=;
        h=Date:From:To:Cc:Subject:From;
        b=TsVIs/uuO088y47w/sYf4HFTyDIV3nIy/epSQecJsPHTLDUX6p9eMoZXBHAuNDycO
         xuzzbmdPhpfSBG2V3gryun6a+OFrB4+ivraqvMJKe08djW7/8h9e+m5YE0n0Bj7L87
         ouEGER9Xcbd9o3thQnqjTF1kdT8TXsccQ5x6U2ZDiOPL3N32z+RgMUc/vCEx978VJX
         mKiGfBnxqMg2O9kxZUvVovneksgNxZZoAfsLceRdZ2ReMIao3BJtt/DfkK/2NNFMvt
         +AG27srJEPBgmnqw/fgyVDBDM09UKKr2ouvP97hx98ypmgjiqoi0dKuOy/Cunme6K+
         Ume+hCGtWlZvQ==
Date:   Tue, 15 Mar 2022 20:40:07 +1100
From:   Stephen Rothwell <sfr@canb.auug.org.au>
To:     Matthew Wilcox <willy@infradead.org>, Theodore Ts'o <tytso@mit.edu>
Cc:     Jan Kara <jack@suse.cz>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>
Subject: linux-next: manual merge of the folio tree with the ext4 tree
Message-ID: <20220315204007.05ad4817@canb.auug.org.au>
MIME-Version: 1.0
Content-Type: multipart/signed; boundary="Sig_/73g1OV73vFjk/_BE4rBQFdx";
 protocol="application/pgp-signature"; micalg=pgp-sha256
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

--Sig_/73g1OV73vFjk/_BE4rBQFdx
Content-Type: text/plain; charset=US-ASCII
Content-Transfer-Encoding: quoted-printable

Hi all,

Today's linux-next merge of the folio tree got a conflict in:

  fs/ext4/inode.c

between commit:

  2bb8dd401a4f ("ext4: warn when dirtying page w/o buffers in data=3Djourna=
l mode")

from the ext4 tree and commit:

  821405cf3ebb ("fs: Convert trivial uses of __set_page_dirty_nobuffers to =
filemap_dirty_folio")

from the folio tree.

I didn't know how to complete this fix up ans so just commented out the
new WARN_ON().

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

--=20
Cheers,
Stephen Rothwell

diff --cc fs/ext4/inode.c
index 3d0ca48d20c8,436efd31cc27..000000000000
--- a/fs/ext4/inode.c
+++ b/fs/ext4/inode.c
@@@ -3573,31 -3541,30 +3573,32 @@@ const struct iomap_ops ext4_iomap_repor
  };
 =20
  /*
-  * Whenever the page is being dirtied, corresponding buffers should alrea=
dy be
 - * Folios can be marked dirty completely asynchronously from ext4's
 - * journalling activity.  By filemap_sync_pte(), try_to_unmap_one(), etc.
 - * We cannot do much here because ->dirty_folio may be called with the
 - * page table lock held.  The folio is not necessarily locked.
++ * Whenever the folio is being dirtied, corresponding buffers should alre=
ady be
 + * attached to the transaction (we take care of this in ext4_page_mkwrite=
() and
 + * ext4_write_begin()). However we cannot move buffers to dirty transacti=
on
-  * lists here because ->set_page_dirty is called under VFS locks and the =
page
++ * lists here because ->dirty_folio is called under VFS locks and the fol=
io
 + * is not necessarily locked.
   *
-  * We cannot just dirty the page and leave attached buffers clean, becaus=
e the
+  * We cannot just dirty the folio and leave attached buffers clean, becau=
se the
   * buffers' dirty state is "definitive".  We cannot just set the buffers =
dirty
   * or jbddirty because all the journalling code will explode.
   *
-  * So what we do is to mark the page "pending dirty" and next time writep=
age
+  * So what we do is to mark the folio "pending dirty" and next time write=
page
   * is called, propagate that into the buffers appropriately.
   */
- static int ext4_journalled_set_page_dirty(struct page *page)
+ static bool ext4_journalled_dirty_folio(struct address_space *mapping,
+ 		struct folio *folio)
  {
- 	WARN_ON_ONCE(!page_has_buffers(page));
- 	SetPageChecked(page);
- 	return __set_page_dirty_nobuffers(page);
++/*	WARN_ON_ONCE(!page_has_buffers(page)); */
+ 	folio_set_checked(folio);
+ 	return filemap_dirty_folio(mapping, folio);
  }
 =20
- static int ext4_set_page_dirty(struct page *page)
+ static bool ext4_dirty_folio(struct address_space *mapping, struct folio =
*folio)
  {
- 	WARN_ON_ONCE(!PageLocked(page) && !PageDirty(page));
- 	WARN_ON_ONCE(!page_has_buffers(page));
- 	return __set_page_dirty_buffers(page);
+ 	WARN_ON_ONCE(!folio_test_locked(folio) && !folio_test_dirty(folio));
+ 	WARN_ON_ONCE(!folio_buffers(folio));
+ 	return block_dirty_folio(mapping, folio);
  }
 =20
  static int ext4_iomap_swap_activate(struct swap_info_struct *sis,

--Sig_/73g1OV73vFjk/_BE4rBQFdx
Content-Type: application/pgp-signature
Content-Description: OpenPGP digital signature

-----BEGIN PGP SIGNATURE-----

iQEzBAEBCAAdFiEENIC96giZ81tWdLgKAVBC80lX0GwFAmIwXvcACgkQAVBC80lX
0GyiVgf/Wm79pLAeGzGaH3YG60NjrGjCFkMwL24tW2HbBe2gVRm4g/F4niVymkvv
1QZMG7fnX7B+K10YTw98G97bgjl+ghKnnAxb0E4aq26slrRsJ6hrm21dSHDJy7Wr
TP8uLpcd4QnZ11YBy35SHXS2ccB4wwgDhrKw9KHTY3/9qVEHg4E9MAn2tVBT7PTt
vElRkDcg590/Rh4u/3la9j9NwXxJKSE8mDT0f0eRMmzbIRyyaQas7DECQd1dfsyc
mduw/PLuDF7Ppbk+Win45stZnrai90rMdl4pkIuVLRGc6FUY0R2JEiAUSKKcdzhm
C3VfK131cnssBFS0sN8PD05JmI70YQ==
=r9HF
-----END PGP SIGNATURE-----

--Sig_/73g1OV73vFjk/_BE4rBQFdx--
