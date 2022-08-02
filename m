Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5187D5875CE
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:06:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235817AbiHBDEo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:04:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55490 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235603AbiHBDEE (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:04:04 -0400
Received: from out30-131.freemail.mail.aliyun.com (out30-131.freemail.mail.aliyun.com [115.124.30.131])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 34FDF1EC4D
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:03:53 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R191e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018046056;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL9W-Pi_1659409429;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VL9W-Pi_1659409429)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 11:03:49 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, xiang@kernel.org
Subject: [PATCH RFC 8/9] cachefiles: resize content map on resize
Date:   Tue,  2 Aug 2022 11:03:41 +0800
Message-Id: <20220802030342.46302-9-jefflexu@linux.alibaba.com>
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

Adjust the content map when we shorten a backing object. In this case,
only the unused tail of the content map after shortening gets zeroed,
while the size of the content map itself is not changed. Also the
corresponding range in the backing content map file is not changed.

Besides, the content map and the corresponding range in the backing
content map file are not touched when we expand a backing object. They
will be lazily expanded at runtime later.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/content-map.c | 23 +++++++++++++++++++++++
 fs/cachefiles/interface.c   |  1 +
 fs/cachefiles/internal.h    |  2 ++
 3 files changed, 26 insertions(+)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index b73a109844ca..360c59b06670 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -271,3 +271,26 @@ void cachefiles_invalidate_content_map(struct cachefiles_object *object)
 	}
 	write_unlock_bh(&object->content_map_lock);
 }
+
+/*
+ * Adjust the content map when we shorten a backing object.
+ */
+void cachefiles_shorten_content_map(struct cachefiles_object *object,
+				    loff_t new_size)
+{
+	if (object->content_info != CACHEFILES_CONTENT_MAP)
+		return;
+
+	read_lock_bh(&object->content_map_lock);
+	/*
+	 * Nothing needs to be done when content map has not been allocated yet.
+	 */
+	if (!object->content_map_size)
+		goto out;
+
+	if (cachefiles_map_size(new_size) <= object->content_map_size)
+		cachefiles_zero_content_map(object->content_map,
+				object->content_map_size, new_size);
+out:
+	read_unlock_bh(&object->content_map_lock);
+}
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index f87b9a665d85..76f70a9ebe50 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -290,6 +290,7 @@ static void cachefiles_resize_cookie(struct netfs_cache_resources *cres,
 		cachefiles_begin_secure(cache, &saved_cred);
 		cachefiles_shorten_object(object, file, new_size);
 		cachefiles_end_secure(cache, saved_cred);
+		cachefiles_shorten_content_map(object, new_size);
 		object->cookie->object_size = new_size;
 		return;
 	}
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index c674c4e42529..7747f99f00c1 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -188,6 +188,8 @@ extern loff_t cachefiles_find_next_granule(struct cachefiles_object *object,
 extern loff_t cachefiles_find_next_hole(struct cachefiles_object *object,
 					loff_t start);
 extern void cachefiles_invalidate_content_map(struct cachefiles_object *object);
+extern void cachefiles_shorten_content_map(struct cachefiles_object *object,
+					   loff_t new_size);
 
 /*
  * daemon.c
-- 
2.27.0

