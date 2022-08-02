Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 79D6F5875C9
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235720AbiHBDE0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:04:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55154 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235415AbiHBDDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:03:52 -0400
Received: from out30-42.freemail.mail.aliyun.com (out30-42.freemail.mail.aliyun.com [115.124.30.42])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6096E1FCFA
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:03:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R201e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL9W-Nf_1659409426;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VL9W-Nf_1659409426)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 11:03:47 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, xiang@kernel.org
Subject: [PATCH RFC 5/9] cachefiles: mark content map on write to the backing file
Date:   Tue,  2 Aug 2022 11:03:38 +0800
Message-Id: <20220802030342.46302-6-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220802030342.46302-1-jefflexu@linux.alibaba.com>
References: <20220802030342.46302-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Mark the content map on completion of the write to the backing file.

The expansion of the content map (when the backing file is truncated to
a larger size), and the allocation of the content map (when the backing
file is a newly created tmpfile) is delayed to the point when the
content map needs to be marked. It shall be safe to allocate memory with
GFP_KERNEL inside the iocb.ki_complete() callback, since the callback is
scheduled by workqueue for DIRECT IO.

The content map is sized in granule of block size of backing filesystem,
so that the backing content map file can be easily punched hole if the
content map gets truncated or invalidated. Currently the content map is
sized in PAGE_SIZE unit, which shall be multiples times of the block
size of backing filesystem. Each bit of the content map indicates the
existence of 4KB data of the backing file, thus each (4K sized) chunk of
content map covers 128MB data of the backing file.

When expanding the content map, a new content map needs to be allocated.
A new offset inside the backing content map file also needs to be
allocated, with the old range starting from the old offset getting
punched hole. Currently the new offset is always allocated in an append
style, i.e. the previous hole will not be reused.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/content-map.c | 129 ++++++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h    |   2 +
 fs/cachefiles/io.c          |   3 +
 3 files changed, 134 insertions(+)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index 3432efdecbcf..877ff79e181b 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -1,8 +1,24 @@
 #include <linux/fs.h>
 #include <linux/namei.h>
 #include <linux/uio.h>
+#include <linux/falloc.h>
 #include "internal.h"
 
+/*
+ * Return the size of the content map in bytes.
+ *
+ * There's one bit per granule (CACHEFILES_GRAN_SIZE, i.e. 4K). We size it in
+ * terms of block size chunks (e.g. 4K), so that the map file can be punched
+ * hole when the content map is truncated or invalidated. In this case, each 4K
+ * chunk spans (4096 * BITS_PER_BYTE * CACHEFILES_GRAN_SIZE, i.e. 128M) of file
+ * space.
+ */
+static size_t cachefiles_map_size(loff_t i_size)
+{
+	i_size = round_up(i_size, PAGE_SIZE * BITS_PER_BYTE * CACHEFILES_GRAN_SIZE);
+	return i_size / BITS_PER_BYTE / CACHEFILES_GRAN_SIZE;
+}
+
 /*
  * Zero the unused tail.
  *
@@ -91,3 +107,116 @@ void cachefiles_save_content_map(struct cachefiles_object *object)
 	if (ret != object->content_map_size)
 		object->content_info = CACHEFILES_CONTENT_NO_DATA;
 }
+
+static loff_t cachefiles_expand_map_off(struct file *file, loff_t old_off,
+					size_t old_size, size_t new_size)
+{
+	struct inode *inode = file_inode(file);
+	loff_t new_off;
+	bool punch = false;
+
+	inode_lock(inode);
+	new_off = i_size_read(inode);
+	/*
+	 * Simply expand the old content map range if possible; or discard the
+	 * old content map range and create a new one.
+	 */
+	if (new_off == old_off + old_size) {
+		i_size_write(inode, old_off + new_size);
+		new_off = old_off;
+	} else {
+		i_size_write(inode, new_off + new_size);
+		punch = true;
+	}
+	inode_unlock(inode);
+
+	if (punch)
+		vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			      old_off, old_size);
+
+	return new_off;
+}
+
+/*
+ * Expand the content map to a larger file size.
+ */
+static void cachefiles_expand_content_map(struct cachefiles_object *object)
+{
+	struct file *file = object->volume->content_map[(u8)object->cookie->key_hash];
+	size_t size, zap_size;
+	void *map, *zap;
+	loff_t off;
+
+	size = cachefiles_map_size(object->cookie->object_size);
+	if (size <= object->content_map_size)
+		return;
+
+	map = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, get_order(size));
+	if (!map)
+		return;
+
+	write_lock_bh(&object->content_map_lock);
+	if (size > object->content_map_size) {
+		zap = object->content_map;
+		zap_size = object->content_map_size;
+		memcpy(map, zap, zap_size);
+		object->content_map = map;
+		object->content_map_size = size;
+
+		/* expand the content map file */
+		off = object->content_map_off;
+		if (off != CACHEFILES_CONTENT_MAP_OFF_INVAL)
+			object->content_map_off = cachefiles_expand_map_off(file,
+				off, zap_size, size);
+	} else {
+		zap = map;
+		zap_size = size;
+	}
+	write_unlock_bh(&object->content_map_lock);
+
+	free_pages((unsigned long)zap, get_order(zap_size));
+}
+
+void cachefiles_mark_content_map(struct cachefiles_object *object,
+				 loff_t start, loff_t len)
+{
+	pgoff_t granule;
+	loff_t end = start + len;
+
+	if (object->cookie->advice & FSCACHE_ADV_SINGLE_CHUNK) {
+		if (start == 0) {
+			object->content_info = CACHEFILES_CONTENT_SINGLE;
+			set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
+		}
+		return;
+	}
+
+	if (object->content_info == CACHEFILES_CONTENT_NO_DATA)
+		object->content_info = CACHEFILES_CONTENT_MAP;
+
+	/* TODO: set CACHEFILES_CONTENT_BACKFS_MAP accordingly */
+
+	if (object->content_info != CACHEFILES_CONTENT_MAP)
+		return;
+
+	read_lock_bh(&object->content_map_lock);
+	start = round_down(start, CACHEFILES_GRAN_SIZE);
+	do {
+		granule = start / CACHEFILES_GRAN_SIZE;
+		if (granule / BITS_PER_BYTE >= object->content_map_size) {
+			read_unlock_bh(&object->content_map_lock);
+			cachefiles_expand_content_map(object);
+			read_lock_bh(&object->content_map_lock);
+		}
+
+		if (WARN_ON(granule / BITS_PER_BYTE >= object->content_map_size))
+			break;
+
+		set_bit(granule, object->content_map);
+		start += CACHEFILES_GRAN_SIZE;
+	} while (start < end);
+
+	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
+	read_unlock_bh(&object->content_map_lock);
+}
+
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 1335ea5f4a5e..c252746c8f9b 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -181,6 +181,8 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
  */
 extern int cachefiles_load_content_map(struct cachefiles_object *object);
 extern void cachefiles_save_content_map(struct cachefiles_object *object);
+extern void cachefiles_mark_content_map(struct cachefiles_object *object,
+					loff_t start, loff_t len);
 
 /*
  * daemon.c
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index b513d9bf81f1..27171fac649e 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -264,6 +264,9 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 	__sb_writers_acquired(inode->i_sb, SB_FREEZE_WRITE);
 	__sb_end_write(inode->i_sb, SB_FREEZE_WRITE);
 
+	if (ret == ki->len)
+		cachefiles_mark_content_map(ki->object, ki->start, ki->len);
+
 	if (ret < 0)
 		trace_cachefiles_io_error(object, inode, ret,
 					  cachefiles_trace_write_error);
-- 
2.27.0

