Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id AD8755875CC
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235816AbiHBDEi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:04:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55222 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235520AbiHBDDy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:03:54 -0400
Received: from out30-54.freemail.mail.aliyun.com (out30-54.freemail.mail.aliyun.com [115.124.30.54])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B46E81DA4F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:03:51 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R791e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL9XpO._1659409428;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VL9XpO._1659409428)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 11:03:48 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, xiang@kernel.org
Subject: [PATCH RFC 7/9] cachefiles: free content map on invalidate
Date:   Tue,  2 Aug 2022 11:03:40 +0800
Message-Id: <20220802030342.46302-8-jefflexu@linux.alibaba.com>
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

Free the content map when the cached file is invalidated. Also hole
punch the backing content map file if any.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/content-map.c | 21 +++++++++++++++++++++
 fs/cachefiles/interface.c   |  1 +
 fs/cachefiles/internal.h    |  1 +
 3 files changed, 23 insertions(+)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index 949ec5d9e4c9..b73a109844ca 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -250,3 +250,24 @@ loff_t cachefiles_find_next_hole(struct cachefiles_object *object,
 	return min_t(loff_t, result * CACHEFILES_GRAN_SIZE,
 			     object->cookie->object_size);
 }
+
+void cachefiles_invalidate_content_map(struct cachefiles_object *object)
+{
+	struct file *file = object->volume->content_map[(u8)object->cookie->key_hash];
+
+	if (object->content_info != CACHEFILES_CONTENT_MAP)
+		return;
+
+	write_lock_bh(&object->content_map_lock);
+	free_pages((unsigned long)object->content_map,
+		   get_order(object->content_map_size));
+	object->content_map = NULL;
+	object->content_map_size = 0;
+
+	if (object->content_map_off != CACHEFILES_CONTENT_MAP_OFF_INVAL) {
+		vfs_fallocate(file, FALLOC_FL_PUNCH_HOLE | FALLOC_FL_KEEP_SIZE,
+				object->content_map_off, object->content_map_size);
+		object->content_map_off = CACHEFILES_CONTENT_MAP_OFF_INVAL;
+	}
+	write_unlock_bh(&object->content_map_lock);
+}
diff --git a/fs/cachefiles/interface.c b/fs/cachefiles/interface.c
index 4cfbdc87b635..f87b9a665d85 100644
--- a/fs/cachefiles/interface.c
+++ b/fs/cachefiles/interface.c
@@ -409,6 +409,7 @@ static bool cachefiles_invalidate_cookie(struct fscache_cookie *cookie)
 
 	old_file = object->file;
 	object->file = new_file;
+	cachefiles_invalidate_content_map(object);
 	object->content_info = CACHEFILES_CONTENT_NO_DATA;
 	set_bit(CACHEFILES_OBJECT_USING_TMPFILE, &object->flags);
 	set_bit(FSCACHE_COOKIE_NEEDS_UPDATE, &object->cookie->flags);
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index 506700809a6d..c674c4e42529 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -187,6 +187,7 @@ extern loff_t cachefiles_find_next_granule(struct cachefiles_object *object,
 					   loff_t start);
 extern loff_t cachefiles_find_next_hole(struct cachefiles_object *object,
 					loff_t start);
+extern void cachefiles_invalidate_content_map(struct cachefiles_object *object);
 
 /*
  * daemon.c
-- 
2.27.0

