Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 058625875CD
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235840AbiHBDEx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:04:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55488 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231985AbiHBDEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:04:04 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 09D042C12D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:03:52 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R151e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL9PAYh_1659409430;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VL9PAYh_1659409430)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 11:03:50 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, xiang@kernel.org
Subject: [PATCH RFC 9/9] cachefiles: cull content map file on cull
Date:   Tue,  2 Aug 2022 11:03:42 +0800
Message-Id: <20220802030342.46302-10-jefflexu@linux.alibaba.com>
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

Also hole punch the backing content map file when the backing object
gets culled.

When cacehfilesd is going to cull a whole directory, the whole
directory will be moved to the graveyard and then cacehfilesd itself
will remove all files under the directory one by one. Since each
sub-directory under one volume maintains one backing content map file,
cacehfilesd already works well with this bitmap-based mechanism and
doesn't need any refactoring.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/content-map.c | 37 +++++++++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h    |  4 ++++
 fs/cachefiles/namei.c       |  4 ++++
 fs/cachefiles/xattr.c       | 17 +++++++++++++++++
 4 files changed, 62 insertions(+)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index 360c59b06670..5584a0182df9 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -294,3 +294,40 @@ void cachefiles_shorten_content_map(struct cachefiles_object *object,
 out:
 	read_unlock_bh(&object->content_map_lock);
 }
+
+int cachefiles_cull_content_map(struct cachefiles_cache *cache,
+				struct dentry *dir, struct dentry *victim)
+{
+	struct dentry *map;
+	struct file *map_file;
+	size_t content_map_size = 0;
+	loff_t content_map_off = 0;
+	struct path path;
+	int ret;
+
+	if (!d_is_reg(victim))
+		return 0;
+
+	ret = cachefiles_get_content_info(victim, &content_map_size, &content_map_off);
+	if (ret || !content_map_size)
+		return ret;
+
+	map = lookup_positive_unlocked("Map", dir, strlen("Map"));
+	if (IS_ERR(map))
+		return PTR_ERR(map);
+
+	path.mnt = cache->mnt;
+	path.dentry = map;
+	map_file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE,
+			d_backing_inode(map), cache->cache_cred);
+	if (IS_ERR(map_file)) {
+		dput(map);
+		return PTR_ERR(map_file);
+	}
+
+	ret = vfs_fallocate(map_file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+			      content_map_off, content_map_size);
+
+	fput(map_file);
+	return ret;
+}
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 7747f99f00c1..9c36631ee051 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -190,6 +190,8 @@ extern loff_t cachefiles_find_next_hole(struct cachefiles_object *object,
 extern void cachefiles_invalidate_content_map(struct cachefiles_object *object);
 extern void cachefiles_shorten_content_map(struct cachefiles_object *object,
 					   loff_t new_size);
+extern int cachefiles_cull_content_map(struct cachefiles_cache *cache,
+				struct dentry *dir, struct dentry *victim);
 
 /*
  * daemon.c
@@ -384,6 +386,8 @@ extern int cachefiles_remove_object_xattr(struct cachefiles_cache *cache,
 extern void cachefiles_prepare_to_write(struct fscache_cookie *cookie);
 extern bool cachefiles_set_volume_xattr(struct cachefiles_volume *volume);
 extern int cachefiles_check_volume_xattr(struct cachefiles_volume *volume);
+extern int cachefiles_get_content_info(struct dentry *dentry,
+		size_t *content_map_size, loff_t *content_map_off);
 
 /*
  * Error handling
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index f5e1ec1d9445..79c759468ab3 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -923,6 +923,10 @@ int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 	if (ret < 0)
 		goto error_unlock;
 
+	ret = cachefiles_cull_content_map(cache, dir, victim);
+	if (ret < 0)
+		goto error;
+
 	ret = cachefiles_bury_object(cache, NULL, dir, victim,
 				     FSCACHE_OBJECT_WAS_CULLED);
 	if (ret < 0)
diff --git a/fs/cachefiles/xattr.c b/fs/cachefiles/xattr.c
index 05ac6b70787a..b7091c8e4262 100644
--- a/fs/cachefiles/xattr.c
+++ b/fs/cachefiles/xattr.c
@@ -283,3 +283,20 @@ int cachefiles_check_volume_xattr(struct cachefiles_volume *volume)
 	_leave(" = %d", ret);
 	return ret;
 }
+
+int cachefiles_get_content_info(struct dentry *dentry, size_t *content_map_size,
+				loff_t *content_map_off)
+{
+	struct cachefiles_xattr buf;
+	ssize_t xlen, tlen = sizeof(buf);
+
+	xlen = vfs_getxattr(&init_user_ns, dentry, cachefiles_xattr_cache, &buf, tlen);
+	if (xlen != tlen)
+		return -ESTALE;
+
+	if (buf.content == CACHEFILES_CONTENT_MAP) {
+		*content_map_off = be64_to_cpu(buf.content_map_off);
+		*content_map_size = be64_to_cpu(buf.content_map_size);
+	}
+	return 0;
+}
-- 
2.27.0

