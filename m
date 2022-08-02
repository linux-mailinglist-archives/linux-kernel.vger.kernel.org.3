Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 614E45875CB
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:06:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235022AbiHBDEM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:04:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235233AbiHBDDw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:03:52 -0400
Received: from out30-57.freemail.mail.aliyun.com (out30-57.freemail.mail.aliyun.com [115.124.30.57])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6FB30201AD
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:03:50 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL9XT1b_1659409427;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VL9XT1b_1659409427)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 11:03:48 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, xiang@kernel.org
Subject: [PATCH RFC 6/9] cachefiles: check content map on read/write
Date:   Tue,  2 Aug 2022 11:03:39 +0800
Message-Id: <20220802030342.46302-7-jefflexu@linux.alibaba.com>
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

cachefiles_find_next_granule()/cachefiles_find_next_hole() are used to
check if the requested range has been cached or not. The return value of
these two functions imitates that of SEEK_[DATA|HOLE], so that the
existing codes can be resued as much as possible.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/content-map.c | 30 ++++++++++++++++++++++++++++++
 fs/cachefiles/internal.h    |  4 ++++
 fs/cachefiles/io.c          | 36 +++++++++++++++++++++++++++++++-----
 3 files changed, 65 insertions(+), 5 deletions(-)

diff --git a/fs/cachefiles/content-map.c b/fs/cachefiles/content-map.c
index 877ff79e181b..949ec5d9e4c9 100644
--- a/fs/cachefiles/content-map.c
+++ b/fs/cachefiles/content-map.c
@@ -220,3 +220,33 @@ void cachefiles_mark_content_map(struct cachefiles_object *object,
 	read_unlock_bh(&object->content_map_lock);
 }
 
+loff_t cachefiles_find_next_granule(struct cachefiles_object *object,
+				    loff_t start)
+{
+	unsigned long size, granule = start / CACHEFILES_GRAN_SIZE;
+	loff_t result;
+
+	read_lock_bh(&object->content_map_lock);
+	size = object->content_map_size * BITS_PER_BYTE;
+	result = find_next_bit(object->content_map, size, granule);
+	read_unlock_bh(&object->content_map_lock);
+
+	if (result == size)
+		return -ENXIO;
+	return result * CACHEFILES_GRAN_SIZE;
+}
+
+loff_t cachefiles_find_next_hole(struct cachefiles_object *object,
+				 loff_t start)
+{
+	unsigned long size, granule = start / CACHEFILES_GRAN_SIZE;
+	loff_t result;
+
+	read_lock_bh(&object->content_map_lock);
+	size = object->content_map_size * BITS_PER_BYTE;
+	result = find_next_zero_bit(object->content_map, size, granule);
+	read_unlock_bh(&object->content_map_lock);
+
+	return min_t(loff_t, result * CACHEFILES_GRAN_SIZE,
+			     object->cookie->object_size);
+}
diff --git a/fs/cachefiles/internal.h b/fs/cachefiles/internal.h
index c252746c8f9b..506700809a6d 100644
--- a/fs/cachefiles/internal.h
+++ b/fs/cachefiles/internal.h
@@ -183,6 +183,10 @@ extern int cachefiles_load_content_map(struct cachefiles_object *object);
 extern void cachefiles_save_content_map(struct cachefiles_object *object);
 extern void cachefiles_mark_content_map(struct cachefiles_object *object,
 					loff_t start, loff_t len);
+extern loff_t cachefiles_find_next_granule(struct cachefiles_object *object,
+					   loff_t start);
+extern loff_t cachefiles_find_next_hole(struct cachefiles_object *object,
+					loff_t start);
 
 /*
  * daemon.c
diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 27171fac649e..5c7c84cdafea 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -30,6 +30,32 @@ struct cachefiles_kiocb {
 	u64			b_writing;
 };
 
+static loff_t cachefiles_seek_data(struct cachefiles_object *object,
+		struct file *file, loff_t start)
+{
+	switch (object->content_info) {
+	case CACHEFILES_CONTENT_MAP:
+		return cachefiles_find_next_granule(object, start);
+	case CACHEFILES_CONTENT_BACKFS_MAP:
+		return vfs_llseek(file, start, SEEK_DATA);
+	default:
+		return -EINVAL;
+	}
+}
+
+static loff_t cachefiles_seek_hole(struct cachefiles_object *object,
+		struct file *file, loff_t start)
+{
+	switch (object->content_info) {
+	case CACHEFILES_CONTENT_MAP:
+		return cachefiles_find_next_hole(object, start);
+	case CACHEFILES_CONTENT_BACKFS_MAP:
+		return vfs_llseek(file, start, SEEK_HOLE);
+	default:
+		return -EINVAL;
+	}
+}
+
 static inline void cachefiles_put_kiocb(struct cachefiles_kiocb *ki)
 {
 	if (refcount_dec_and_test(&ki->ki_refcnt)) {
@@ -103,7 +129,7 @@ static int cachefiles_read(struct netfs_cache_resources *cres,
 
 		off2 = cachefiles_inject_read_error();
 		if (off2 == 0)
-			off2 = vfs_llseek(file, off, SEEK_DATA);
+			off2 = cachefiles_seek_data(object, file, off);
 		if (off2 < 0 && off2 >= (loff_t)-MAX_ERRNO && off2 != -ENXIO) {
 			skipped = 0;
 			ret = off2;
@@ -442,7 +468,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 retry:
 	off = cachefiles_inject_read_error();
 	if (off == 0)
-		off = vfs_llseek(file, subreq->start, SEEK_DATA);
+		off = cachefiles_seek_data(object, file, subreq->start);
 	if (off < 0 && off >= (loff_t)-MAX_ERRNO) {
 		if (off == (loff_t)-ENXIO) {
 			why = cachefiles_trace_read_seek_nxio;
@@ -468,7 +494,7 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 
 	to = cachefiles_inject_read_error();
 	if (to == 0)
-		to = vfs_llseek(file, subreq->start, SEEK_HOLE);
+		to = cachefiles_seek_hole(object, file, subreq->start);
 	if (to < 0 && to >= (loff_t)-MAX_ERRNO) {
 		trace_cachefiles_io_error(object, file_inode(file), to,
 					  cachefiles_trace_seek_error);
@@ -537,7 +563,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 
 	pos = cachefiles_inject_read_error();
 	if (pos == 0)
-		pos = vfs_llseek(file, *_start, SEEK_DATA);
+		pos = cachefiles_seek_data(object, file, *_start);
 	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
 		if (pos == -ENXIO)
 			goto check_space; /* Unallocated tail */
@@ -558,7 +584,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 
 	pos = cachefiles_inject_read_error();
 	if (pos == 0)
-		pos = vfs_llseek(file, *_start, SEEK_HOLE);
+		pos = cachefiles_seek_hole(object, file, *_start);
 	if (pos < 0 && pos >= (loff_t)-MAX_ERRNO) {
 		trace_cachefiles_io_error(object, file_inode(file), pos,
 					  cachefiles_trace_seek_error);
-- 
2.27.0

