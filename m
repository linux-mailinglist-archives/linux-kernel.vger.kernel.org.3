Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 03CA7547192
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 05:23:18 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1349907AbiFKDXF (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Jun 2022 23:23:05 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40670 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348434AbiFKDW5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Jun 2022 23:22:57 -0400
Received: from p3plwbeout27-05.prod.phx3.secureserver.net (p3plsmtp27-05-2.prod.phx3.secureserver.net [216.69.139.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 22E1B6C0FD
        for <linux-kernel@vger.kernel.org>; Fri, 10 Jun 2022 20:22:54 -0700 (PDT)
Received: from mailex.mailcore.me ([94.136.40.142])
        by :WBEOUT: with ESMTP
        id zri9nQCFBAU9fzriAnzxNw; Fri, 10 Jun 2022 20:22:54 -0700
X-CMAE-Analysis: v=2.4 cv=WeTJ12tX c=1 sm=1 tr=0 ts=62a40a8e
 a=s1hRAmXuQnGNrIj+3lWWVA==:117 a=84ok6UeoqCVsigPHarzEiQ==:17
 a=ggZhUymU-5wA:10 a=JPEYwPQDsx4A:10 a=FXvPX3liAAAA:8 a=v4aROKBdHILR9-7NOdAA:9
 a=UObqyxdv-6Yh2QiB9mM_:22
X-SECURESERVER-ACCT: phillip@squashfs.org.uk  
X-SID:  zri9nQCFBAU9f
Received: from 82-69-79-175.dsl.in-addr.zen.co.uk ([82.69.79.175] helo=localhost.localdomain)
        by smtp02.mailcore.me with esmtpa (Exim 4.94.2)
        (envelope-from <phillip@squashfs.org.uk>)
        id 1nzri8-0001TR-C9; Sat, 11 Jun 2022 04:22:53 +0100
From:   Phillip Lougher <phillip@squashfs.org.uk>
To:     linux-kernel@vger.kernel.org, akpm@linux-foundation.org
Cc:     willy@infradead.org, hsinyi@chromium.org,
        Xiongwei.Song@windriver.com, linux-mm@kvack.org,
        squashfs-devel@lists.sourceforge.net,
        Phillip Lougher <phillip@squashfs.org.uk>
Subject: [PATCH 1/2] Squashfs: extend "page actor" to handle missing pages
Date:   Sat, 11 Jun 2022 04:21:32 +0100
Message-Id: <20220611032133.5743-2-phillip@squashfs.org.uk>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220611032133.5743-1-phillip@squashfs.org.uk>
References: <20220611032133.5743-1-phillip@squashfs.org.uk>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Mailcore-Auth: 439999529
X-Mailcore-Domain: 1394945
X-123-reg-Authenticated:  phillip@squashfs.org.uk  
X-Originating-IP: 82.69.79.175
X-CMAE-Envelope: MS4xfM3JTBUUmTwmaQTfuJo+NUjFPduhGg84mOIWq2AthQsH21cU98UPz1ucnb4+m/pk4n97V2GN83NSFPq/XtvBWjIS3xRch4bZq0b+4pInW4mplvAeMCNX
 LBJrbtTcFOHv2GUNuZ2UlwteKAPBtXkxqCIJHTdOzEmgDU8Dbe3n0qIgFDKNjinY78ZKGRobYTJscAqUmYjz61B/18riiI7o8Io=
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This patch extends the "page actor" code to handle missing
pages.

Previously if the full set of pages needed to decompress a Squashfs
datablock was unavailable, this would cause decompression to
fail on the missing pages.

In this case direct decompression into the page cache could
not be achieved and the code would fall back to using the older
intermediate buffer method.

With this patch, direct decompression into the page cache
can be achieved with missing pages.

For "multi-shot" decompressors (zlib, xz, zstd), the page actor
will allocate a temporary buffer which is passed to the
decompressor, and then freed by the page actor.

For "single shot" decompressors (lz4, lzo) which decompress into a
contiguous "bounce buffer", and which is then copied into the page
cache, it would be pointless to allocate a temporary buffer,
memcpy into it, and then free it.  For these decompressors
-ENOMEM is returned, which signifies that the memcpy for that
page should be skipped.

This also happens if the data block is uncompressed.

Signed-off-by: Phillip Lougher <phillip@squashfs.org.uk>
---
 fs/squashfs/block.c        | 10 ++++---
 fs/squashfs/decompressor.h |  1 +
 fs/squashfs/file_direct.c  | 21 ++++++++-------
 fs/squashfs/lz4_wrapper.c  |  7 +++--
 fs/squashfs/lzo_wrapper.c  |  7 +++--
 fs/squashfs/page_actor.c   | 55 ++++++++++++++++++++++++++++++++------
 fs/squashfs/page_actor.h   | 21 ++++++++++++---
 fs/squashfs/xz_wrapper.c   | 11 +++++++-
 fs/squashfs/zlib_wrapper.c | 12 ++++++++-
 fs/squashfs/zstd_wrapper.c | 12 ++++++++-
 10 files changed, 126 insertions(+), 31 deletions(-)

diff --git a/fs/squashfs/block.c b/fs/squashfs/block.c
index 622c844f6d11..acbb0dc80f89 100644
--- a/fs/squashfs/block.c
+++ b/fs/squashfs/block.c
@@ -34,12 +34,15 @@ static int copy_bio_to_actor(struct bio *bio,
 			     struct squashfs_page_actor *actor,
 			     int offset, int req_length)
 {
-	void *actor_addr = squashfs_first_page(actor);
+	void *actor_addr;
 	struct bvec_iter_all iter_all = {};
 	struct bio_vec *bvec = bvec_init_iter_all(&iter_all);
 	int copied_bytes = 0;
 	int actor_offset = 0;
 
+	squashfs_actor_nobuff(actor);
+	actor_addr = squashfs_first_page(actor);
+
 	if (WARN_ON_ONCE(!bio_next_segment(bio, &iter_all)))
 		return 0;
 
@@ -49,8 +52,9 @@ static int copy_bio_to_actor(struct bio *bio,
 
 		bytes_to_copy = min_t(int, bytes_to_copy,
 				      req_length - copied_bytes);
-		memcpy(actor_addr + actor_offset, bvec_virt(bvec) + offset,
-		       bytes_to_copy);
+		if (!IS_ERR(actor_addr))
+			memcpy(actor_addr + actor_offset, bvec_virt(bvec) +
+					offset, bytes_to_copy);
 
 		actor_offset += bytes_to_copy;
 		copied_bytes += bytes_to_copy;
diff --git a/fs/squashfs/decompressor.h b/fs/squashfs/decompressor.h
index 1b9ccfd0aa51..19ab60834389 100644
--- a/fs/squashfs/decompressor.h
+++ b/fs/squashfs/decompressor.h
@@ -20,6 +20,7 @@ struct squashfs_decompressor {
 		struct bio *, int, int, struct squashfs_page_actor *);
 	int	id;
 	char	*name;
+	int	alloc_buffer;
 	int	supported;
 };
 
diff --git a/fs/squashfs/file_direct.c b/fs/squashfs/file_direct.c
index a4894cc59447..5af5802f5626 100644
--- a/fs/squashfs/file_direct.c
+++ b/fs/squashfs/file_direct.c
@@ -47,14 +47,6 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	if (page == NULL)
 		return res;
 
-	/*
-	 * Create a "page actor" which will kmap and kunmap the
-	 * page cache pages appropriately within the decompressor
-	 */
-	actor = squashfs_page_actor_init_special(page, pages, 0);
-	if (actor == NULL)
-		goto out;
-
 	/* Try to grab all the pages covered by the Squashfs block */
 	for (missing_pages = 0, i = 0, n = start_index; i < pages; i++, n++) {
 		page[i] = (n == target_page->index) ? target_page :
@@ -89,8 +81,19 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 		goto out;
 	}
 
+	/*
+	 * Create a "page actor" which will kmap and kunmap the
+	 * page cache pages appropriately within the decompressor
+	 */
+	actor = squashfs_page_actor_init_special(msblk, page, pages, 0);
+	if (actor == NULL)
+		goto out;
+
 	/* Decompress directly into the page cache buffers */
 	res = squashfs_read_data(inode->i_sb, block, bsize, NULL, actor);
+
+	kfree(actor);
+
 	if (res < 0)
 		goto mark_errored;
 
@@ -116,7 +119,6 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 			put_page(page[i]);
 	}
 
-	kfree(actor);
 	kfree(page);
 
 	return 0;
@@ -135,7 +137,6 @@ int squashfs_readpage_block(struct page *target_page, u64 block, int bsize,
 	}
 
 out:
-	kfree(actor);
 	kfree(page);
 	return res;
 }
diff --git a/fs/squashfs/lz4_wrapper.c b/fs/squashfs/lz4_wrapper.c
index b685b6238316..49797729f143 100644
--- a/fs/squashfs/lz4_wrapper.c
+++ b/fs/squashfs/lz4_wrapper.c
@@ -119,10 +119,12 @@ static int lz4_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	buff = stream->output;
 	while (data) {
 		if (bytes <= PAGE_SIZE) {
-			memcpy(data, buff, bytes);
+			if (!IS_ERR(data))
+				memcpy(data, buff, bytes);
 			break;
 		}
-		memcpy(data, buff, PAGE_SIZE);
+		if (!IS_ERR(data))
+			memcpy(data, buff, PAGE_SIZE);
 		buff += PAGE_SIZE;
 		bytes -= PAGE_SIZE;
 		data = squashfs_next_page(output);
@@ -139,5 +141,6 @@ const struct squashfs_decompressor squashfs_lz4_comp_ops = {
 	.decompress = lz4_uncompress,
 	.id = LZ4_COMPRESSION,
 	.name = "lz4",
+	.alloc_buffer = 0,
 	.supported = 1
 };
diff --git a/fs/squashfs/lzo_wrapper.c b/fs/squashfs/lzo_wrapper.c
index cb510a631968..d216aeefa865 100644
--- a/fs/squashfs/lzo_wrapper.c
+++ b/fs/squashfs/lzo_wrapper.c
@@ -93,10 +93,12 @@ static int lzo_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	buff = stream->output;
 	while (data) {
 		if (bytes <= PAGE_SIZE) {
-			memcpy(data, buff, bytes);
+			if (!IS_ERR(data))
+				memcpy(data, buff, bytes);
 			break;
 		} else {
-			memcpy(data, buff, PAGE_SIZE);
+			if (!IS_ERR(data))
+				memcpy(data, buff, PAGE_SIZE);
 			buff += PAGE_SIZE;
 			bytes -= PAGE_SIZE;
 			data = squashfs_next_page(output);
@@ -116,5 +118,6 @@ const struct squashfs_decompressor squashfs_lzo_comp_ops = {
 	.decompress = lzo_uncompress,
 	.id = LZO_COMPRESSION,
 	.name = "lzo",
+	.alloc_buffer = 0,
 	.supported = 1
 };
diff --git a/fs/squashfs/page_actor.c b/fs/squashfs/page_actor.c
index 520d323a99ce..b23b780d8f42 100644
--- a/fs/squashfs/page_actor.c
+++ b/fs/squashfs/page_actor.c
@@ -7,6 +7,8 @@
 #include <linux/kernel.h>
 #include <linux/slab.h>
 #include <linux/pagemap.h>
+#include "squashfs_fs_sb.h"
+#include "decompressor.h"
 #include "page_actor.h"
 
 /*
@@ -57,29 +59,62 @@ struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
 }
 
 /* Implementation of page_actor for decompressing directly into page cache. */
+static void *handle_next_page(struct squashfs_page_actor *actor)
+{
+	int max_pages = (actor->length + PAGE_SIZE - 1) >> PAGE_SHIFT;
+
+	if (actor->returned_pages == max_pages)
+		return NULL;
+
+	if ((actor->next_page == actor->pages) ||
+			(actor->next_index != actor->page[actor->next_page]->index)) {
+		if (actor->alloc_buffer) {
+			void *tmp_buffer = kmalloc(PAGE_SIZE, GFP_KERNEL);
+
+			if (tmp_buffer) {
+				actor->tmp_buffer = tmp_buffer;
+				actor->next_index++;
+				actor->returned_pages++;
+				return tmp_buffer;
+			}
+		}
+
+		actor->next_index++;
+		actor->returned_pages++;
+		return ERR_PTR(-ENOMEM);
+	}
+
+	actor->next_index++;
+	actor->returned_pages++;
+	return actor->pageaddr = kmap_local_page(actor->page[actor->next_page++]);
+}
+
 static void *direct_first_page(struct squashfs_page_actor *actor)
 {
-	actor->next_page = 1;
-	return actor->pageaddr = kmap_atomic(actor->page[0]);
+	return handle_next_page(actor);
 }
 
 static void *direct_next_page(struct squashfs_page_actor *actor)
 {
 	if (actor->pageaddr)
-		kunmap_atomic(actor->pageaddr);
+		kunmap_local(actor->pageaddr);
+
+	kfree(actor->tmp_buffer);
+	actor->pageaddr = actor->tmp_buffer = NULL;
 
-	return actor->pageaddr = actor->next_page == actor->pages ? NULL :
-		kmap_atomic(actor->page[actor->next_page++]);
+	return handle_next_page(actor);
 }
 
 static void direct_finish_page(struct squashfs_page_actor *actor)
 {
 	if (actor->pageaddr)
-		kunmap_atomic(actor->pageaddr);
+		kunmap_local(actor->pageaddr);
+
+	kfree(actor->tmp_buffer);
 }
 
-struct squashfs_page_actor *squashfs_page_actor_init_special(struct page **page,
-	int pages, int length)
+struct squashfs_page_actor *squashfs_page_actor_init_special(struct squashfs_sb_info *msblk,
+	struct page **page, int pages, int length)
 {
 	struct squashfs_page_actor *actor = kmalloc(sizeof(*actor), GFP_KERNEL);
 
@@ -90,7 +125,11 @@ struct squashfs_page_actor *squashfs_page_actor_init_special(struct page **page,
 	actor->page = page;
 	actor->pages = pages;
 	actor->next_page = 0;
+	actor->returned_pages = 0;
+	actor->next_index = page[0]->index & ~((1 << (msblk->block_log - PAGE_SHIFT)) - 1);
 	actor->pageaddr = NULL;
+	actor->tmp_buffer = NULL;
+	actor->alloc_buffer = msblk->decompressor->alloc_buffer;
 	actor->squashfs_first_page = direct_first_page;
 	actor->squashfs_next_page = direct_next_page;
 	actor->squashfs_finish_page = direct_finish_page;
diff --git a/fs/squashfs/page_actor.h b/fs/squashfs/page_actor.h
index 2e3073ace009..37523c54256f 100644
--- a/fs/squashfs/page_actor.h
+++ b/fs/squashfs/page_actor.h
@@ -45,6 +45,11 @@ static inline void squashfs_finish_page(struct squashfs_page_actor *actor)
 {
 	/* empty */
 }
+
+static inline void squashfs_actor_nobuff(struct squashfs_page_actor *actor)
+{
+	/* empty */
+}
 #else
 struct squashfs_page_actor {
 	union {
@@ -52,17 +57,23 @@ struct squashfs_page_actor {
 		struct page	**page;
 	};
 	void	*pageaddr;
+	void	*tmp_buffer;
 	void    *(*squashfs_first_page)(struct squashfs_page_actor *);
 	void    *(*squashfs_next_page)(struct squashfs_page_actor *);
 	void    (*squashfs_finish_page)(struct squashfs_page_actor *);
 	int	pages;
 	int	length;
 	int	next_page;
+	int	alloc_buffer;
+	int	returned_pages;
+	pgoff_t	next_index;
 };
 
-extern struct squashfs_page_actor *squashfs_page_actor_init(void **, int, int);
-extern struct squashfs_page_actor *squashfs_page_actor_init_special(struct page
-							 **, int, int);
+extern struct squashfs_page_actor *squashfs_page_actor_init(void **buffer,
+				int pages, int length);
+extern struct squashfs_page_actor *squashfs_page_actor_init_special(
+				struct squashfs_sb_info *msblk,
+				struct page **page, int pages, int length);
 static inline void *squashfs_first_page(struct squashfs_page_actor *actor)
 {
 	return actor->squashfs_first_page(actor);
@@ -75,5 +86,9 @@ static inline void squashfs_finish_page(struct squashfs_page_actor *actor)
 {
 	actor->squashfs_finish_page(actor);
 }
+static inline void squashfs_actor_nobuff(struct squashfs_page_actor *actor)
+{
+	actor->alloc_buffer = 0;
+}
 #endif
 #endif
diff --git a/fs/squashfs/xz_wrapper.c b/fs/squashfs/xz_wrapper.c
index 68f6d09bb3a2..6c49481a2f8c 100644
--- a/fs/squashfs/xz_wrapper.c
+++ b/fs/squashfs/xz_wrapper.c
@@ -131,6 +131,10 @@ static int squashfs_xz_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	stream->buf.out_pos = 0;
 	stream->buf.out_size = PAGE_SIZE;
 	stream->buf.out = squashfs_first_page(output);
+	if (IS_ERR(stream->buf.out)) {
+		error = PTR_ERR(stream->buf.out);
+		goto finish;
+	}
 
 	for (;;) {
 		enum xz_ret xz_err;
@@ -156,7 +160,10 @@ static int squashfs_xz_uncompress(struct squashfs_sb_info *msblk, void *strm,
 
 		if (stream->buf.out_pos == stream->buf.out_size) {
 			stream->buf.out = squashfs_next_page(output);
-			if (stream->buf.out != NULL) {
+			if (IS_ERR(stream->buf.out)) {
+				error = PTR_ERR(stream->buf.out);
+				break;
+			} else if (stream->buf.out != NULL) {
 				stream->buf.out_pos = 0;
 				total += PAGE_SIZE;
 			}
@@ -171,6 +178,7 @@ static int squashfs_xz_uncompress(struct squashfs_sb_info *msblk, void *strm,
 		}
 	}
 
+finish:
 	squashfs_finish_page(output);
 
 	return error ? error : total + stream->buf.out_pos;
@@ -183,5 +191,6 @@ const struct squashfs_decompressor squashfs_xz_comp_ops = {
 	.decompress = squashfs_xz_uncompress,
 	.id = XZ_COMPRESSION,
 	.name = "xz",
+	.alloc_buffer = 1,
 	.supported = 1
 };
diff --git a/fs/squashfs/zlib_wrapper.c b/fs/squashfs/zlib_wrapper.c
index a20e9042146b..cbb7afe7bc46 100644
--- a/fs/squashfs/zlib_wrapper.c
+++ b/fs/squashfs/zlib_wrapper.c
@@ -62,6 +62,11 @@ static int zlib_uncompress(struct squashfs_sb_info *msblk, void *strm,
 	stream->next_out = squashfs_first_page(output);
 	stream->avail_in = 0;
 
+	if (IS_ERR(stream->next_out)) {
+		error = PTR_ERR(stream->next_out);
+		goto finish;
+	}
+
 	for (;;) {
 		int zlib_err;
 
@@ -85,7 +90,10 @@ static int zlib_uncompress(struct squashfs_sb_info *msblk, void *strm,
 
 		if (stream->avail_out == 0) {
 			stream->next_out = squashfs_next_page(output);
-			if (stream->next_out != NULL)
+			if (IS_ERR(stream->next_out)) {
+				error = PTR_ERR(stream->next_out);
+				break;
+			} else if (stream->next_out != NULL)
 				stream->avail_out = PAGE_SIZE;
 		}
 
@@ -107,6 +115,7 @@ static int zlib_uncompress(struct squashfs_sb_info *msblk, void *strm,
 		}
 	}
 
+finish:
 	squashfs_finish_page(output);
 
 	if (!error)
@@ -122,6 +131,7 @@ const struct squashfs_decompressor squashfs_zlib_comp_ops = {
 	.decompress = zlib_uncompress,
 	.id = ZLIB_COMPRESSION,
 	.name = "zlib",
+	.alloc_buffer = 1,
 	.supported = 1
 };
 
diff --git a/fs/squashfs/zstd_wrapper.c b/fs/squashfs/zstd_wrapper.c
index c40445dbf38c..0e407c4d8b3b 100644
--- a/fs/squashfs/zstd_wrapper.c
+++ b/fs/squashfs/zstd_wrapper.c
@@ -80,6 +80,10 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 
 	out_buf.size = PAGE_SIZE;
 	out_buf.dst = squashfs_first_page(output);
+	if (IS_ERR(out_buf.dst)) {
+		error = PTR_ERR(out_buf.dst);
+		goto finish;
+	}
 
 	for (;;) {
 		size_t zstd_err;
@@ -104,7 +108,10 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 
 		if (out_buf.pos == out_buf.size) {
 			out_buf.dst = squashfs_next_page(output);
-			if (out_buf.dst == NULL) {
+			if (IS_ERR(out_buf.dst)) {
+				error = PTR_ERR(out_buf.dst);
+				break;
+			} else if (out_buf.dst == NULL) {
 				/* Shouldn't run out of pages
 				 * before stream is done.
 				 */
@@ -129,6 +136,8 @@ static int zstd_uncompress(struct squashfs_sb_info *msblk, void *strm,
 		}
 	}
 
+finish:
+
 	squashfs_finish_page(output);
 
 	return error ? error : total_out;
@@ -140,5 +149,6 @@ const struct squashfs_decompressor squashfs_zstd_comp_ops = {
 	.decompress = zstd_uncompress,
 	.id = ZSTD_COMPRESSION,
 	.name = "zstd",
+	.alloc_buffer = 1,
 	.supported = 1
 };
-- 
2.34.1

