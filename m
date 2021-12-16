Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C458477212
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 13:43:31 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236885AbhLPMn3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 07:43:29 -0500
Received: from dfw.source.kernel.org ([139.178.84.217]:49038 "EHLO
        dfw.source.kernel.org" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236878AbhLPMn2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 07:43:28 -0500
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id D92FD61D91;
        Thu, 16 Dec 2021 12:43:27 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id A69A0C36AE3;
        Thu, 16 Dec 2021 12:43:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639658607;
        bh=T+/eGeLJ2ZTmFQV2tYX+uvVjjBJjduRCV4T8gY3fi88=;
        h=From:To:Cc:Subject:Date:From;
        b=l+6zahUnLZO+LXkM9aOyJBUgMtgR16TwB/iZBzUODMpsLaA8oZBnKWpIZg2Ic1rXe
         dJ1PeDnC6yD5rAElRjtzqQ5ohlQbmuVYFoOj0OkmO3AhledUXkBxx6RXdLj+heMkKu
         542uxKs2eRDQDTzFqL9gvrgLPmFZ81c2uhv8mEQNJrtxXQHENDGxkTVSXESYeDQ34U
         wNCzpuePtsGfldvHIup5mwIPtbluvRvvNxxy4d90YR/lEuSJIIp5xO2qU2AyA1NIJj
         7Z89W6hLUtiIblOecLY9Arw8nSuO1pgEtTjciwaeN2PnVzKm+MHVh8WIcfIJ/10DaQ
         f0gTLDxAI8NEA==
From:   broonie@kernel.org
To:     Steve French <smfrench@gmail.com>,
        CIFS <linux-cifs@vger.kernel.org>
Cc:     David Howells <dhowells@redhat.com>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Linux Next Mailing List <linux-next@vger.kernel.org>,
        Shyam Prasad N <sprasad@microsoft.com>,
        Steve French <stfrench@microsoft.com>
Subject: linux-next: manual merge of the cifs tree with the fscache tree
Date:   Thu, 16 Dec 2021 12:43:17 +0000
Message-Id: <20211216124317.4143405-1-broonie@kernel.org>
X-Mailer: git-send-email 2.30.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Hi all,

Today's linux-next merge of the cifs tree got a conflict in:

  fs/cifs/inode.c

between commit:

  830c476f5eb82 ("cifs: Support fscache indexing rewrite (untested)")

from the fscache tree and commit:

  68f87ec9c1ce3 ("cifs: ignore resource_id while getting fscache super cookie")

from the cifs tree.

I fixed it up (see below) and can carry the fix as necessary. This
is now fixed as far as linux-next is concerned, but any non trivial
conflicts should be mentioned to your upstream maintainer when your tree
is submitted for merging.  You may also want to consider cooperating
with the maintainer of the conflicting tree to minimise any particularly
complex conflicts.

diff --cc fs/cifs/inode.c
index dc2fe76450b96,279622e4eb1c2..0000000000000
--- a/fs/cifs/inode.c
+++ b/fs/cifs/inode.c
@@@ -1372,20 -1370,6 +1367,7 @@@ iget_no_retry
  		iget_failed(inode);
  		inode = ERR_PTR(rc);
  	}
 +
- 	if (!rc) {
- 		/*
- 		 * The cookie is initialized from volume info returned above.
- 		 * Inside cifs_fscache_get_super_cookie it checks
- 		 * that we do not get super cookie twice.
- 		 */
- 		rc = cifs_fscache_get_super_cookie(tcon);
- 		if (rc < 0) {
- 			iget_failed(inode);
- 			inode = ERR_PTR(rc);
- 		}
- 	}
- 
  out:
  	kfree(path);
  	free_xid(xid);
