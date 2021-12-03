Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 30CA1467DA2
	for <lists+linux-kernel@lfdr.de>; Fri,  3 Dec 2021 19:58:26 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242291AbhLCTBs (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 3 Dec 2021 14:01:48 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232031AbhLCTBr (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 3 Dec 2021 14:01:47 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 118F8C061751
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 10:58:22 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 287A162C8C
        for <linux-kernel@vger.kernel.org>; Fri,  3 Dec 2021 18:58:22 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id ACBB6C53FAD;
        Fri,  3 Dec 2021 18:58:19 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1638557901;
        bh=3f/h2EgdTQ3pBq+ISkyXCIN+i2CCECjmkpTjC7FXDQI=;
        h=From:To:Cc:Subject:Date:From;
        b=gR9Vb7m7yJVfWpxyNkdq+aDVBLOUz5MKE6MGmvNDXKsV6MCrEQk3WP+lunnOTRwHy
         X/nbY+F/xJGsy440Uq9Axgz3a29YiU4y6qGJb+82d76oTm3sZq2X2t34onAB/64I39
         EM7CajBMasWQpdjIT/MyNwq1iDnIEaov1bVMMA+mFn8pctmetzJBfGMb6HGuNuUjvQ
         FMZC2i6/ucyBUp4zR/GcNQmx31EcKfZD8iUfGUPtonJaTy49kpv9RcBSIHUqS3OJFe
         wjPQi3KJohdzALvQTKYMk+K9UihYn8f6zcbzTsESxgQ9nH/j1lzm5z5lqbXV8K+FGK
         CmR517097ePow==
From:   Arnd Bergmann <arnd@kernel.org>
To:     David Howells <dhowells@redhat.com>
Cc:     Arnd Bergmann <arnd@arndb.de>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>,
        Jeff Layton <jlayton@kernel.org>,
        v9fs-developer@lists.sourceforge.net, linux-kernel@vger.kernel.org
Subject: [PATCH] 9p: fix unused-variable warning
Date:   Fri,  3 Dec 2021 19:58:06 +0100
Message-Id: <20211203185816.796637-1-arnd@kernel.org>
X-Mailer: git-send-email 2.29.2
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Arnd Bergmann <arnd@arndb.de>

The folio changes added a variable that is sometimes unused:

fs/9p/vfs_addr.c: In function 'v9fs_release_page':
fs/9p/vfs_addr.c:140:23: error: unused variable 'inode' [-Werror=unused-variable]
  140 |         struct inode *inode = folio_inode(folio);
      |                       ^~~~~

Make this clearer to the compiler by replacing the #ifdef
with an equivalent if(IS_ENABLED()) check.

Fixes: 78525c74d9e7 ("netfs, 9p, afs, ceph: Use folios")
Signed-off-by: Arnd Bergmann <arnd@arndb.de>
---
 fs/9p/vfs_addr.c | 7 +++++--
 1 file changed, 5 insertions(+), 2 deletions(-)

diff --git a/fs/9p/vfs_addr.c b/fs/9p/vfs_addr.c
index 1279970e9157..82ac2ceff06e 100644
--- a/fs/9p/vfs_addr.c
+++ b/fs/9p/vfs_addr.c
@@ -141,14 +141,17 @@ static int v9fs_release_page(struct page *page, gfp_t gfp)
 
 	if (folio_test_private(folio))
 		return 0;
-#ifdef CONFIG_9P_FSCACHE
+
+	if (!IS_ENABLED(CONFIG_9P_FSCACHE))
+		return 1;
+
 	if (folio_test_fscache(folio)) {
 		if (!(gfp & __GFP_DIRECT_RECLAIM) || !(gfp & __GFP_FS))
 			return 0;
 		folio_wait_fscache(folio);
 	}
 	fscache_note_page_release(v9fs_inode_cookie(V9FS_I(inode)));
-#endif
+
 	return 1;
 }
 
-- 
2.29.2

