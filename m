Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 85E5B547190
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:23:05 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349860AbiFKDXA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:23:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236391AbiFKDW4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:22:56 -0400
Received: from p3plwbeout16-02.prod.phx3.secureserver.net (p3plsmtp16-02-2.prod.phx3.secureserver.net [173.201.193.56])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F35016C55A
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:22:55 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id zriAndxSIJglUzriBnMf5G; Fri, 10 Jun 2022 20:22:55 -0700
X-CMAE-Analysis: v=2.4 cv=cNIlDnSN c=1 sm=1 tr=0 ts=62a40a8f
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=JPEYwPQDsx4A:10 a=FXvPX3liAAAA:8 a=EtPFtR80rDWv2_rSRC0A:9
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  zriAndxSIJglU
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=localhost.localdomain)
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nzri9-0001TR-MA; Sat, 11 Jun 2022 04:22:54 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     willy@infradead.org, hsinyi@chromium.org,
        Xiongwei.Song@windriver.com, linux-mm@kvack.org,
        squashfs-devel@lists.sourceforge.net,
        Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 2/2] Squashfs: don't use intermediate buffer if pages missing
Date:   Sat, 11 Jun 2022 04:21:33 +0100
Message-Id: <20220611032133.5743-3-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220611032133.5743-1-phillip@squashfs.org.uk>
References: <20220611032133.5743-1-phillip@squashfs.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfJjfcaPyDqY2Ng4a+iygPSR1DwPaO1RK6VeUyxhCb8WpqYsoW6KorsH8HWVl5f/iu4PjpKIreT+vfVBrShm9/kVNNDKkQgldVHk9KnwBuvnl7OYkq7PA
 q086RClsnWxDYAjQarCXg1NOovOx1mmKxKEY5FCV/RDmJzduRg+Ff8QlkcsLcajhATC+lxexVO7PTojPJ4HOosZPfs9BEvZlkaM=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Now that the "page actor" can handle missing pages, we don't
have to fall back to using an intermediate buffer in
Squashfs_readpage_block() if all the pages necessary can't
be obtained.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/file_direct.c | 75 +++++++--------------------------------
 1 file changed, 12 insertions(+), 63 deletions(-)

diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index 5af5802f5626..be4b12d31e0c 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -18,9 +18,6 @@
 #include "squashfs.h"
 #include "page_actor.h"
 
-static int squashfs_read_cache(struct page *target_page, u64 block, int bsize,
-	int pages, struct page **page, int bytes);
-
 /* Read separately compressed datablock directly into page cache */
 int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	int expected)
@@ -33,7 +30,7 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	int mask = (1 << (msblk->block_log - PAGE_SHIFT)) - 1;
 	int start_index = target_page->index & ~mask;
 	int end_index = start_index | mask;
-	int i, n, pages, missing_pages, bytes, res = -ENOMEM;
+	int i, n, pages, bytes, res = -ENOMEM;
 	struct page **page;
 	struct squashfs_page_actor *actor;
 	void *pageaddr;
@@ -48,44 +45,29 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 		return res;
 
 	/* Try to grab all the pages covered by the Squashfs block */
-	for (missing_pages = 0, i = 0, n = start_index; i < pages; i++, n++) {
+	for (i = 0, n = start_index; n <= end_index; n++) {
 		page[i] = (n == target_page->index) ? target_page :
 			grab_cache_page_nowait(target_page->mapping, n);
 
-		if (page[i] == NULL) {
-			missing_pages++;
+		if (page[i] == NULL)
 			continue;
-		}
 
 		if (PageUptodate(page[i])) {
 			unlock_page(page[i]);
 			put_page(page[i]);
-			page[i] = NULL;
-			missing_pages++;
+			continue;
 		}
-	}
-
-	if (missing_pages) {
-		/*
-		 * Couldn't get one or more pages, this page has either
-		 * been VM reclaimed, but others are still in the page cache
-		 * and uptodate, or we're racing with another thread in
-		 * squashfs_readpage also trying to grab them.  Fall back to
-		 * using an intermediate buffer.
-		 */
-		res = squashfs_read_cache(target_page, block, bsize, pages,
-							page, expected);
-		if (res < 0)
-			goto mark_errored;
 
-		goto out;
+		i++;
 	}
 
+	pages = i;
+
 	/*
 	 * Create a "page actor" which will kmap and kunmap the
 	 * page cache pages appropriately within the decompressor
 	 */
-	actor = squashfs_page_actor_init_special(msblk, page, pages, 0);
+	actor = squashfs_page_actor_init_special(msblk, page, pages, expected);
 	if (actor == NULL)
 		goto out;
 
@@ -102,12 +84,12 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 		goto mark_errored;
 	}
 
-	/* Last page may have trailing bytes not filled */
+	/* Last page (if present) may have trailing bytes not filled */
 	bytes = res % PAGE_SIZE;
-	if (bytes) {
-		pageaddr = kmap_atomic(page[pages - 1]);
+	if (page[pages - 1]->index == end_index && bytes) {
+		pageaddr = kmap_local_page(page[pages - 1]);
 		memset(pageaddr + bytes, 0, PAGE_SIZE - bytes);
-		kunmap_atomic(pageaddr);
+		kunmap_local(pageaddr);
 	}
 
 	/* Mark pages as uptodate, unlock and release */
@@ -140,36 +122,3 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	kfree(page);
 	return res;
 }
-
-
-static int squashfs_read_cache(struct page *target_page, u64 block, int bsize,
-	int pages, struct page **page, int bytes)
-{
-	struct inode *i = target_page->mapping->host;
-	struct squashfs_cache_entry *buffer = squashfs_get_datablock(i->i_sb,
-						 block, bsize);
-	int res = buffer->error, n, offset = 0;
-
-	if (res) {
-		ERROR("Unable to read page, block %llx, size %x\n", block,
-			bsize);
-		goto out;
-	}
-
-	for (n = 0; n < pages && bytes > 0; n++,
-			bytes -= PAGE_SIZE, offset += PAGE_SIZE) {
-		int avail = min_t(int, bytes, PAGE_SIZE);
-
-		if (page[n] == NULL)
-			continue;
-
-		squashfs_fill_page(page[n], buffer, offset, avail);
-		unlock_page(page[n]);
-		if (page[n] != target_page)
-			put_page(page[n]);
-	}
-
-out:
-	squashfs_cache_put(buffer);
-	return res;
-}
-- 
2.34.1

