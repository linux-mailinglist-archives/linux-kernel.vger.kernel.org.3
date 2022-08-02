Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2D8E35875C8
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:06:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234325AbiHBDEc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:04:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55152 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231518AbiHBDDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:03:52 -0400
Received: from out30-132.freemail.mail.aliyun.com (out30-132.freemail.mail.aliyun.com [115.124.30.132])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 99E511EEF2
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:03:48 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R121e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045170;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL9XT0G_1659409425;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VL9XT0G_1659409425)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 11:03:46 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, xiang@kernel.org
Subject: [PATCH RFC 4/9] cachefiles: alloc/load/save content map
Date:   Tue,  2 Aug 2022 11:03:37 +0800
Message-Id: <20220802030342.46302-5-jefflexu@linux.alibaba.com>
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

Besides the SEEK_[DATA|HOLE] llseek mechanism provided by the backing
filesystem, this patch set is going to introduce a bitmap based
mechanism, in which a self-maintained bitmap is used to track if the
file range has been cached by the backing file.

The bitmap is permanentized to the corresponding backing content map
file. Since all backing files under one sub-directory share one backing
content map file, the offset of the content map in the backing content
map file is stored in the xattr for each backing file. Besides, the size
of the content map is also stored in the xattr of the backing file. As
shown in the following patches, the content map size stored in the
xattr can be smaller or larger than the actual size of the backing file.

In the lookup phase, for the case when the backing file already exists,
the content map is loaded from the backing content map file. If the
backing file doesn't exist, i.e. a new tmpfile is created as the backing
file, the content map will not be initialized at this point. Instead, it
will be expanded at runtime later.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/Makefile      |  3 +-
 fs/cachefiles/content-map.c | 93 +++++++++++++++++++++++++++++++++++++
 fs/cachefiles/interface.c   |  8 +++-
 fs/cachefiles/internal.h    | 13 ++++++
 fs/cachefiles/namei.c       |  4 ++
 fs/cachefiles/xattr.c       |  9 ++++
 6 files changed, 128 insertions(+), 2 deletions(-)
 create mode 100644 fs/cachefiles/content-map.c

diff --git a/fs/cachefiles/Makefile b/fs/cachefiles/Makefile
index c37a7a9af10b..59cd26cd7700 100644
--- a/fs/cachefiles/Makefile
+++ b/fs/cachefiles/Makefile
@@ -13,7 +13,8 @@ cachefiles-y := \
 	namei.o \
 	security.o \
 	volume.o \
-	xattr.o
+	xattr.o \
+	content-map.o
 
 cachefiles-$(CONFIG_CACHEFILES_ERROR_INJECTION) += error_inject.o
 cachefiles-$(CONFIG_CACHEFILES_ONDEMAND) += ondemand.o
diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
new file mode 100644
index 000000000000..3432efdecbcf
--- /dev/null
+++ b/fs/cachefiles/content-map.c
@@ -0,0 +1,93 @@
+#include <linux/fs.h>
+#include <linux/namei.h>
+#include <linux/uio.h>
+#include "internal.h"
+
+/*
+ * Zero the unused tail.
+ *
+ * @i_size indicates the size of the backing object.
+ */
+static void cachefiles_zero_content_map(void *map, size_t content_map_size,
+					size_t i_size)
+{
+	unsigned long granules_needed = DIV_ROUND_UP(i_size, CACHEFILES_GRAN_SIZE);
+	unsigned long bytes_needed = BITS_TO_BYTES(granules_needed);
+	unsigned long byte_end = min_t(unsigned long, bytes_needed, content_map_size);
+	int i;
+
+	if (bytes_needed < content_map_size)
+		memset(map + bytes_needed, 0, content_map_size - bytes_needed);
+
+	for (i = granules_needed; i < byte_end * BITS_PER_BYTE; i++)
+		clear_bit(i, map);
+}
+
+/*
+ * Load the content map from the backing map file.
+ */
+int cachefiles_load_content_map(struct cachefiles_object *object)
+{
+	struct file *file = object->volume->content_map[(u8)object->cookie->key_hash];
+	loff_t off = object->content_map_off;
+	size_t size = object->content_map_size;
+	void *map;
+	int ret;
+
+	if (object->content_info != CACHEFILES_CONTENT_MAP)
+		return 0;
+
+	map = (void *)__get_free_pages(GFP_KERNEL | __GFP_ZERO, get_order(size));
+	if (!map)
+		return -ENOMEM;
+
+	ret = kernel_read(file, map, size, &off);
+	if (ret != size) {
+		free_pages((unsigned long)map, get_order(size));
+		return ret < 0 ? ret : -EIO;
+	}
+
+	/*
+	 * Zero the unused tail. Later when expanding the content map, the
+	 * content map itself may keep the same size while i_size of the backing
+	 * object is increased. In this case, the original content map is reused
+	 * and part of the original unused tail is used now. Be noted that
+	 * content_map_size stored in xattr may be smaller or larger than the
+	 * actual size of the backing object.
+	 */
+	cachefiles_zero_content_map(map, size, object->cookie->object_size);
+
+	object->content_map = map;
+	return 0;
+}
+
+/*
+ * Save the content map to the backing map file.
+ */
+void cachefiles_save_content_map(struct cachefiles_object *object)
+{
+	struct file *file = object->volume->content_map[(u8)object->cookie->key_hash];
+	loff_t off;
+	int ret;
+
+	if (object->content_info != CACHEFILES_CONTENT_MAP ||
+	    !object->content_map_size)
+		return;
+
+	/* allocate space from content map file */
+	off = object->content_map_off;
+	if (off == CACHEFILES_CONTENT_MAP_OFF_INVAL) {
+		struct inode *inode = file_inode(file);
+
+		inode_lock(inode);
+		off = i_size_read(inode);
+		i_size_write(inode, off + object->content_map_size);
+		inode_unlock(inode);
+
+		object->content_map_off = off;
+	}
+
+	ret = kernel_write(file, object->content_map, object->content_map_size, &off);
+	if (ret != object->content_map_size)
+		object->content_info = CACHEFILES_CONTENT_NO_DATA;
+}
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index a69073a1d3f0..4cfbdc87b635 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -38,6 +38,8 @@ struct cachefiles_object *cachefiles_alloc_object(struct fscache_cookie *cookie)
 	object->volume = volume;
 	object->debug_id = atomic_inc_return(&cachefiles_object_debug_id);
 	object->cookie = fscache_get_cookie(cookie, fscache_cookie_get_attach_object);
+	object->content_map_off = CACHEFILES_CONTENT_MAP_OFF_INVAL;
+	rwlock_init(&object->content_map_lock);
 
 	fscache_count_object(vcookie->cache);
 	trace_cachefiles_ref(object->debug_id, cookie->debug_id, 1,
@@ -88,6 +90,8 @@ void cachefiles_put_object(struct cachefiles_object *object,
 		ASSERTCMP(object->file, ==, NULL);
 
 		kfree(object->d_name);
+		free_pages((unsigned long)object->content_map,
+			   get_order(object->content_map_size));
 
 		cache = object->volume->cache->cache;
 		fscache_put_cookie(object->cookie, fscache_cookie_put_object);
@@ -309,8 +313,10 @@ static void cachefiles_commit_object(struct cachefiles_object *object,
 		update = true;
 	if (test_and_clear_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags))
 		update = true;
-	if (update)
+	if (update) {
+		cachefiles_save_content_map(object);
 		cachefiles_set_object_xattr(object);
+	}
 
 	if (test_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags))
 		cachefiles_commit_tmpfile(cache, object);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 06bde4e0e4f5..1335ea5f4a5e 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -19,6 +19,7 @@
 #include <linux/cachefiles.h>
 
 #define CACHEFILES_DIO_BLOCK_SIZE 4096
+#define CACHEFILES_GRAN_SIZE 4096	/* one bit represents 4K */
 
 struct cachefiles_cache;
 struct cachefiles_object;
@@ -30,6 +31,7 @@ enum cachefiles_content {
 	CACHEFILES_CONTENT_ALL		= 2, /* Content is all present, no map */
 	CACHEFILES_CONTENT_BACKFS_MAP	= 3, /* Content is piecemeal, mapped through backing fs */
 	CACHEFILES_CONTENT_DIRTY	= 4, /* Content is dirty (only seen on disk) */
+	CACHEFILES_CONTENT_MAP		= 5, /* Content is piecemeal, map in use */
 	nr__cachefiles_content
 };
 
@@ -59,6 +61,11 @@ struct cachefiles_object {
 	refcount_t			ref;
 	u8				d_name_len;	/* Length of filename */
 	enum cachefiles_content		content_info:8;	/* Info about content presence */
+	rwlock_t			content_map_lock;
+	void				*content_map;
+	size_t				content_map_size; /* size of content map in bytes */
+	loff_t				content_map_off;  /* offset in the backing content map file */
+#define CACHEFILES_CONTENT_MAP_OFF_INVAL	-1
 	unsigned long			flags;
 #define CACHEFILES_OBJECT_USING_TMPFILE	0		/* Have an unlinked tmpfile */
 #ifdef CONFIG_CACHEFILES_ONDEMAND
@@ -169,6 +176,12 @@ extern int cachefiles_has_space(struct cachefiles_cache *cache,
 				unsigned fnr, unsigned bnr,
 				enum cachefiles_has_space_for reason);
 
+/*
+ * content-map.c
+ */
+extern int cachefiles_load_content_map(struct cachefiles_object *object);
+extern void cachefiles_save_content_map(struct cachefiles_object *object);
+
 /*
  * daemon.c
  */
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index d2d5feea64e8..f5e1ec1d9445 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -690,6 +690,10 @@ static bool cachefiles_open_file(struct cachefiles_object *object,
 	if (ret < 0)
 		goto check_failed;
 
+	ret = cachefiles_load_content_map(object);
+	if (ret < 0)
+		goto check_failed;
+
 	object->file = file;
 
 	/* Always update the atime on an object we've just looked up (this is
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 00b087c14995..05ac6b70787a 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -20,6 +20,8 @@
 struct cachefiles_xattr {
 	__be64	object_size;	/* Actual size of the object */
 	__be64	zero_point;	/* Size after which server has no data not written by us */
+	__be64	content_map_off;/* Offset inside the content map file */
+	__be64	content_map_size;/* Size of the content map */
 	__u8	type;		/* Type of object */
 	__u8	content;	/* Content presence (enum cachefiles_content) */
 	__u8	data[];		/* netfs coherency data */
@@ -58,6 +60,8 @@ int cachefiles_set_object_xattr(struct cachefiles_object *object)
 	buf->zero_point		= 0;
 	buf->type		= CACHEFILES_COOKIE_TYPE_DATA;
 	buf->content		= object->content_info;
+	buf->content_map_off	= cpu_to_be64(object->content_map_off);
+	buf->content_map_size	= cpu_to_be64(object->content_map_size);
 	if (test_bit(FSCACHE_COOKIE_LOCAL_WRITE, &object->cookie->flags))
 		buf->content	= CACHEFILES_CONTENT_DIRTY;
 	if (len > 0)
@@ -129,6 +133,11 @@ int cachefiles_check_auxdata(struct cachefiles_object *object, struct file *file
 		pr_warn("Dirty object in cache\n");
 		why = cachefiles_coherency_check_dirty;
 	} else {
+		object->content_info = buf->content;
+		if (object->content_info == CACHEFILES_CONTENT_MAP) {
+			object->content_map_off = be64_to_cpu(buf->content_map_off);
+			object->content_map_size = be64_to_cpu(buf->content_map_size);
+		}
 		why = cachefiles_coherency_check_ok;
 		ret = 0;
 	}
-- 
2.27.0

