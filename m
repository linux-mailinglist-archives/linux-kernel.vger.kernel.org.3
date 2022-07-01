Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 99520562E15
	for <lists+linux-kernel@lfdr.de>; Fri,  1 Jul 2022 10:26:45 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236307AbiGAIZK (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 1 Jul 2022 04:25:10 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48854 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236196AbiGAIYu (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 1 Jul 2022 04:24:50 -0400
Received: from mail.nfschina.com (unknown [IPv6:2400:dd01:100f:2:72e2:84ff:fe10:5f45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id AA3AE7393B;
        Fri,  1 Jul 2022 01:22:59 -0700 (PDT)
Received: from localhost (unknown [127.0.0.1])
        by mail.nfschina.com (Postfix) with ESMTP id 6545B1E80D93;
        Fri,  1 Jul 2022 16:21:29 +0800 (CST)
X-Virus-Scanned: amavisd-new at test.com
Received: from mail.nfschina.com ([127.0.0.1])
        by localhost (mail.nfschina.com [127.0.0.1]) (amavisd-new, port 10024)
        with ESMTP id 4KTjlSqAWO5c; Fri,  1 Jul 2022 16:21:26 +0800 (CST)
Received: from localhost.localdomain (unknown [112.65.12.78])
        (Authenticated sender: jiaming@nfschina.com)
        by mail.nfschina.com (Postfix) with ESMTPA id BF5971E80D92;
        Fri,  1 Jul 2022 16:21:24 +0800 (CST)
From:   Zhang Jiaming <jiaming@nfschina.com>
To:     xiubli@redhat.com, idryomov@gmail.com, jlayton@kernel.org
Cc:     ceph-devel@vger.kernel.org, linux-kernel@vger.kernel.org,
        liqiong@nfschina.com, renyu@nfschina.com,
        Zhang Jiaming <jiaming@nfschina.com>
Subject: [PATCH] netfs: Fix typo
Date:   Fri,  1 Jul 2022 16:22:50 +0800
Message-Id: <20220701082250.14935-1-jiaming@nfschina.com>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.1 required=5.0 tests=BAYES_00,RDNS_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=no
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

There is a typo (writeable) in comments and dout information.
Fix it.

Signed-off-by: Zhang Jiaming <jiaming@nfschina.com>
---
 fs/ceph/addr.c | 14 +++++++-------
 1 file changed, 7 insertions(+), 7 deletions(-)

diff --git a/fs/ceph/addr.c b/fs/ceph/addr.c
index 6dee88815491..083c5b6cae9e 100644
--- a/fs/ceph/addr.c
+++ b/fs/ceph/addr.c
@@ -565,7 +565,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 
 	dout("writepage %p idx %lu\n", page, page->index);
 
-	/* verify this is a writeable snap context */
+	/* verify this is a writable snap context */
 	snapc = page_snap_context(page);
 	if (!snapc) {
 		dout("writepage %p page %p not dirty?\n", inode, page);
@@ -573,7 +573,7 @@ static int writepage_nounlock(struct page *page, struct writeback_control *wbc)
 	}
 	oldest = get_oldest_context(inode, &ceph_wbc, snapc);
 	if (snapc->seq > oldest->seq) {
-		dout("writepage %p page %p snapc %p not writeable - noop\n",
+		dout("writepage %p page %p snapc %p not writable - noop\n",
 		     inode, page, snapc);
 		/* we should only noop if called by kswapd */
 		WARN_ON(!(current->flags & PF_MEMALLOC));
@@ -860,7 +860,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 	} else if (!ceph_wbc.head_snapc) {
 		/* Do not respect wbc->range_{start,end}. Dirty pages
 		 * in that range can be associated with newer snapc.
-		 * They are not writeable until we write all dirty pages
+		 * They are not writable until we write all dirty pages
 		 * associated with 'snapc' get written */
 		if (index > 0)
 			should_loop = true;
@@ -1219,7 +1219,7 @@ static int ceph_writepages_start(struct address_space *mapping,
 
 
 /*
- * See if a given @snapc is either writeable, or already written.
+ * See if a given @snapc is either writable, or already written.
  */
 static int context_is_writeable_or_written(struct inode *inode,
 					   struct ceph_snap_context *snapc)
@@ -1265,18 +1265,18 @@ ceph_find_incompatible(struct page *page)
 
 		/*
 		 * this page is already dirty in another (older) snap
-		 * context!  is it writeable now?
+		 * context!  is it writable now?
 		 */
 		oldest = get_oldest_context(inode, NULL, NULL);
 		if (snapc->seq > oldest->seq) {
-			/* not writeable -- return it for the caller to deal with */
+			/* not writable -- return it for the caller to deal with */
 			ceph_put_snap_context(oldest);
 			dout(" page %p snapc %p not current or oldest\n", page, snapc);
 			return ceph_get_snap_context(snapc);
 		}
 		ceph_put_snap_context(oldest);
 
-		/* yay, writeable, do it now (without dropping page lock) */
+		/* yay, writable, do it now (without dropping page lock) */
 		dout(" page %p snapc %p not current, but oldest\n", page, snapc);
 		if (clear_page_dirty_for_io(page)) {
 			int r = writepage_nounlock(page, NULL);
-- 
2.25.1

