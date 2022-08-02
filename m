Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E9FC05875C6
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235525AbiHBDDy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:03:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55134 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234389AbiHBDDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:03:51 -0400
Received: from out30-133.freemail.mail.aliyun.com (out30-133.freemail.mail.aliyun.com [115.124.30.133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B63ED1EAC6
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:03:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046051;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL9XpKv_1659409424;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VL9XpKv_1659409424)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 11:03:44 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, xiang@kernel.org
Subject: [PATCH RFC 2/9] cachefiles: add content map file helpers
Date:   Tue,  2 Aug 2022 11:03:35 +0800
Message-Id: <20220802030342.46302-3-jefflexu@linux.alibaba.com>
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

Besides the mapping mechanism provided by the backing fs, a self
maintained bitmap can be used to track if the corresponding file range
is cached by the backing file or not. In this case, a content map file
is used to permanentize the bitmap.

As the first step, add the helper functions for looking up and freeing
these content map files.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/internal.h |  4 ++
 fs/cachefiles/namei.c    | 88 ++++++++++++++++++++++++++++++++++++++++
 2 files changed, 92 insertions(+)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 6cba2c6de2f9..4c3ee6935811 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -270,6 +270,10 @@ extern struct dentry *cachefiles_get_directory(struct cachefiles_cache *cache,
 					       bool *_is_new);
 extern void cachefiles_put_directory(struct dentry *dir);
 
+int cachefiles_look_up_map(struct cachefiles_cache *cache,
+			   struct dentry *dir, struct file **pfile);
+void cachefiles_put_map(struct file *file);
+
 extern int cachefiles_cull(struct cachefiles_cache *cache, struct dentry *dir,
 			   char *filename);
 
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index facf2ebe464b..2948eea18ca2 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -231,6 +231,94 @@ void cachefiles_put_directory(struct dentry *dir)
 	}
 }
 
+/*
+ * Look up a content map file.
+ */
+int cachefiles_look_up_map(struct cachefiles_cache *cache,
+			   struct dentry *dir, struct file **pfile)
+{
+	struct dentry *dentry;
+	struct file *file;
+	struct path path;
+	char *name = "Map";
+	int ret;
+
+	inode_lock_nested(d_inode(dir), I_MUTEX_PARENT);
+retry:
+	ret = cachefiles_inject_read_error();
+	if (ret)
+		goto err_unlock_dir;
+
+	dentry = lookup_one_len(name, dir, strlen(name));
+	if (IS_ERR(dentry)) {
+		ret = PTR_ERR(dentry);
+		goto err_unlock_dir;
+	}
+
+	if (d_is_negative(dentry)) {
+		ret = cachefiles_has_space(cache, 1, 0,
+				cachefiles_has_space_for_create);
+		if (ret)
+			goto err_dput;
+
+		ret = vfs_create(&init_user_ns, d_inode(dir), dentry, S_IFREG, true);
+		if (ret)
+			goto err_dput;
+
+		if (unlikely(d_unhashed(dentry))) {
+			cachefiles_put_directory(dentry);
+			goto retry;
+		}
+		ASSERT(d_backing_inode(dentry));
+	}
+
+	inode_lock(d_inode(dentry));
+	inode_unlock(d_inode(dir));
+
+	if (!__cachefiles_mark_inode_in_use(NULL, dentry)) {
+		inode_unlock(d_inode(dentry));
+		dput(dentry);
+		return -EBUSY;
+	}
+
+	inode_unlock(d_inode(dentry));
+	ASSERT(d_backing_inode(dentry));
+
+	if (!d_is_reg(dentry)) {
+		pr_err("%pd is not a file\n", dentry);
+		cachefiles_put_directory(dentry);
+		return -EIO;
+	}
+
+	path.mnt = cache->mnt;
+	path.dentry = dentry;
+	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE,
+			d_backing_inode(dentry), cache->cache_cred);
+	if (IS_ERR(file))
+		cachefiles_put_directory(dentry);
+
+	*pfile = file;
+	dput(dentry);
+	return 0;
+
+err_dput:
+	dput(dentry);
+err_unlock_dir:
+	inode_unlock(d_inode(dir));
+	return ret;
+}
+
+/*
+ * Put a content map file.
+ */
+void cachefiles_put_map(struct file *file)
+{
+	if (file) {
+		cachefiles_do_unmark_inode_in_use(NULL, file->f_path.dentry);
+		fput(file);
+	}
+}
+
 /*
  * Remove a regular file from the cache.
  */
-- 
2.27.0

