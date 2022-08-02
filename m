Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 155D85875CA
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235684AbiHBDEV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:04:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55150 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235400AbiHBDDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:03:52 -0400
Received: from out30-130.freemail.mail.aliyun.com (out30-130.freemail.mail.aliyun.com [115.124.30.130])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EBC3A1EC4D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:03:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL9W-MZ_1659409424;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VL9W-MZ_1659409424)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 11:03:45 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, xiang@kernel.org
Subject: [PATCH RFC 3/9] cachefiles: allocate per-subdir content map files
Date:   Tue,  2 Aug 2022 11:03:36 +0800
Message-Id: <20220802030342.46302-4-jefflexu@linux.alibaba.com>
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

Allocate one content map file for each sub-directory under one volume,
so that the cacehfilesd only needs to remove the whole sub-directory
(including the content map file and backing files in the sub-directory)
as usual when it's going to cull the whole sub-directory or volume.

The content map file will be shared among all backing files under this
same sub-directory.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/internal.h |  1 +
 fs/cachefiles/namei.c    |  2 +-
 fs/cachefiles/volume.c   | 14 ++++++++++++--
 3 files changed, 14 insertions(+), 3 deletions(-)

diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 4c3ee6935811..06bde4e0e4f5 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -42,6 +42,7 @@ struct cachefiles_volume {
 	struct fscache_volume		*vcookie;	/* The netfs's representation */
 	struct dentry			*dentry;	/* The volume dentry */
 	struct dentry			*fanout[256];	/* Fanout subdirs */
+	struct file                     *content_map[256]; /* Content map files */
 };
 
 /*
diff --git a/fs/cachefiles/namei.c b/fs/cachefiles/namei.c
index 2948eea18ca2..d2d5feea64e8 100644
--- a/fs/cachefiles/namei.c
+++ b/fs/cachefiles/namei.c
@@ -292,7 +292,7 @@ int cachefiles_look_up_map(struct cachefiles_cache *cache,
 
 	path.mnt = cache->mnt;
 	path.dentry = dentry;
-	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE,
+	file = open_with_fake_path(&path, O_RDWR | O_LARGEFILE | O_DSYNC,
 			d_backing_inode(dentry), cache->cache_cred);
 	if (IS_ERR(file))
 		cachefiles_put_directory(dentry);
diff --git a/fs/cachefiles/volume.c b/fs/cachefiles/volume.c
index 89df0ba8ba5e..4decc91a8886 100644
--- a/fs/cachefiles/volume.c
+++ b/fs/cachefiles/volume.c
@@ -20,6 +20,7 @@ void cachefiles_acquire_volume(struct fscache_volume *vcookie)
 	struct cachefiles_cache *cache = vcookie->cache->cache_priv;
 	const struct cred *saved_cred;
 	struct dentry *vdentry, *fan;
+	struct file *map;
 	size_t len;
 	char *name;
 	bool is_new = false;
@@ -73,6 +74,11 @@ void cachefiles_acquire_volume(struct fscache_volume *vcookie)
 		if (IS_ERR(fan))
 			goto error_fan;
 		volume->fanout[i] = fan;
+
+		ret = cachefiles_look_up_map(cache, fan, &map);
+		if (ret)
+			goto error_fan;
+		volume->content_map[i] = map;
 	}
 
 	cachefiles_end_secure(cache, saved_cred);
@@ -91,8 +97,10 @@ void cachefiles_acquire_volume(struct fscache_volume *vcookie)
 	return;
 
 error_fan:
-	for (i = 0; i < 256; i++)
+	for (i = 0; i < 256; i++) {
 		cachefiles_put_directory(volume->fanout[i]);
+		cachefiles_put_map(volume->content_map[i]);
+	}
 error_dir:
 	cachefiles_put_directory(volume->dentry);
 error_name:
@@ -113,8 +121,10 @@ static void __cachefiles_free_volume(struct cachefiles_volume *volume)
 
 	volume->vcookie->cache_priv = NULL;
 
-	for (i = 0; i < 256; i++)
+	for (i = 0; i < 256; i++) {
 		cachefiles_put_directory(volume->fanout[i]);
+		cachefiles_put_map(volume->content_map[i]);
+	}
 	cachefiles_put_directory(volume->dentry);
 	kfree(volume);
 }
-- 
2.27.0

