Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 296965875C5
	for <lists+linux-kernel@lfdr.de>; Tue,  2 Aug 2022 05:04:13 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235590AbiHBDED (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 23:04:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55136 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234448AbiHBDDv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 23:03:51 -0400
Received: from out199-6.us.a.mail.aliyun.com (out199-6.us.a.mail.aliyun.com [47.90.199.6])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8B8731DA4F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 20:03:47 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R161e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=ay29a033018045168;MF=jefflexu@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VL9XT-F_1659409423;
Received: from localhost(mailfrom:jefflexu@linux.alibaba.com fp:SMTPD_---0VL9XT-F_1659409423)
          by smtp.aliyun-inc.com;
          Tue, 02 Aug 2022 11:03:43 +0800
From:   Jingbo Xu <jefflexu@linux.alibaba.com>
To:     dhowells@redhat.com, linux-cachefs@redhat.com
Cc:     linux-kernel@vger.kernel.org, xiang@kernel.org
Subject: [PATCH RFC 1/9] cachefiles: improve FSCACHE_COOKIE_NO_DATA_TO_READ optimization
Date:   Tue,  2 Aug 2022 11:03:34 +0800
Message-Id: <20220802030342.46302-2-jefflexu@linux.alibaba.com>
X-Mailer: git-send-email 2.27.0
In-Reply-To: <20220802030342.46302-1-jefflexu@linux.alibaba.com>
References: <20220802030342.46302-1-jefflexu@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,SPF_HELO_NONE,SPF_PASS,UNPARSEABLE_RELAY,
        USER_IN_DEF_SPF_WL autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In the following introduced content map feature,
cachefiles_prepare_[read|write] can query if the requested range is
cached through either SEEK_[DATA|HOLE] llseek or a self maintained
bitmap according to object->content_info.

For already existing backing files, content_info can be derived from the
xattr of the backing file. While for newly created tmpfile, content_info
is initialized when the backing file is written for the first time. This
time sequence requires FSCACHE_COOKIE_NO_DATA_TO_READ optimization, so
that llseek will only be called after the first write, i.e. after
content_info has been initializaed.

This patch includes following changes:

1. Enable NO_DATA optimization in cachefiles_prepare_[read|write].

2. Clear FSCACHE_COOKIE_NO_DATA_TO_READ on first write to the backing
   file.

When working in non-on-demand mode, FSCACHE_COOKIE_NO_DATA_TO_READ is
cleared when a_ops->release_folio() called. While for on-demand mode,
there's a retry logic in cachefiles_prepare_read(), i.e. the requested
range will be checked for the second time after the on-demand read, thus
FSCACHE_COOKIE_NO_DATA_TO_READ needs to be cleared for on-demand mode
once write completes.

3. Improve the setting/clearing of FSCACHE_COOKIE_NO_DATA_TO_READ in
on-demand mode.

Since now we rely on NO_DATA optimization when the backing file is
actually tmpfile, the setting of FSCACHE_COOKIE_NO_DATA_TO_READ flag in
on-demand mode is delayed until the size of the backing file is acquired
when copen completes, so that FSCACHE_COOKIE_NO_DATA_TO_READ flag of
tmpfile can be retained.

Signed-off-by: Jingbo Xu <jefflexu@linux.alibaba.com>
---
 fs/cachefiles/io.c       | 20 +++++++++++++-------
 fs/cachefiles/ondemand.c |  5 +----
 fs/fscache/cookie.c      |  2 +-
 3 files changed, 15 insertions(+), 12 deletions(-)

diff --git a/fs/cachefiles/io.c b/fs/cachefiles/io.c
index 000a28f46e59..b513d9bf81f1 100644
--- a/fs/cachefiles/io.c
+++ b/fs/cachefiles/io.c
@@ -255,6 +255,7 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 {
 	struct cachefiles_kiocb *ki = container_of(iocb, struct cachefiles_kiocb, iocb);
 	struct cachefiles_object *object = ki->object;
+	struct fscache_cookie *cookie = object->cookie;
 	struct inode *inode = file_inode(ki->iocb.ki_filp);
 
 	_enter("%ld", ret);
@@ -269,6 +270,9 @@ static void cachefiles_write_complete(struct kiocb *iocb, long ret)
 
 	atomic_long_sub(ki->b_writing, &object->volume->cache->b_writing);
 	set_bit(FSCACHE_COOKIE_HAVE_DATA, &object->cookie->flags);
+	if (cookie->advice & FSCACHE_ADV_WANT_CACHE_SIZE &&
+	    test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
+		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 	if (ki->term_func)
 		ki->term_func(ki->term_func_priv, ret, ki->was_async);
 	cachefiles_put_kiocb(ki);
@@ -413,13 +417,6 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 		goto out_no_object;
 	}
 
-	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
-		__set_bit(NETFS_SREQ_COPY_TO_CACHE, &subreq->flags);
-		why = cachefiles_trace_read_no_data;
-		if (!test_bit(NETFS_SREQ_ONDEMAND, &subreq->flags))
-			goto out_no_object;
-	}
-
 	/* The object and the file may be being created in the background. */
 	if (!file) {
 		why = cachefiles_trace_read_no_file;
@@ -434,6 +431,11 @@ static enum netfs_io_source cachefiles_prepare_read(struct netfs_io_subrequest *
 	object = cachefiles_cres_object(cres);
 	cache = object->volume->cache;
 	cachefiles_begin_secure(cache, &saved_cred);
+
+	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags)) {
+		why = cachefiles_trace_read_no_data;
+		goto download_and_store;
+	}
 retry:
 	off = cachefiles_inject_read_error();
 	if (off == 0)
@@ -510,6 +512,7 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 			       bool no_space_allocated_yet)
 {
 	struct cachefiles_cache *cache = object->volume->cache;
+	struct fscache_cookie *cookie = object->cookie;
 	loff_t start = *_start, pos;
 	size_t len = *_len, down;
 	int ret;
@@ -526,6 +529,9 @@ int __cachefiles_prepare_write(struct cachefiles_object *object,
 	if (no_space_allocated_yet)
 		goto check_space;
 
+	if (test_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags))
+		goto check_space;
+
 	pos = cachefiles_inject_read_error();
 	if (pos == 0)
 		pos = vfs_llseek(file, *_start, SEEK_DATA);
diff --git a/fs/cachefiles/ondemand.c b/fs/cachefiles/ondemand.c
index 1fee702d5529..a317857e2dfd 100644
--- a/fs/cachefiles/ondemand.c
+++ b/fs/cachefiles/ondemand.c
@@ -166,12 +166,9 @@ int cachefiles_ondemand_copen(struct cachefiles_cache *cache, char *args)
 
 	cookie = req->object->cookie;
 	cookie->object_size = size;
-	if (size)
-		clear_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
-	else
+	if (size == 0)
 		set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 	trace_cachefiles_ondemand_copen(req->object, id, size);
-
 out:
 	complete(&req->done);
 	return ret;
diff --git a/fs/fscache/cookie.c b/fs/fscache/cookie.c
index 74920826d8f6..49c269c078eb 100644
--- a/fs/fscache/cookie.c
+++ b/fs/fscache/cookie.c
@@ -340,7 +340,7 @@ static struct fscache_cookie *fscache_alloc_cookie(
 	cookie->key_len		= index_key_len;
 	cookie->aux_len		= aux_data_len;
 	cookie->object_size	= object_size;
-	if (object_size == 0)
+	if (object_size == 0 && !(advice & FSCACHE_ADV_WANT_CACHE_SIZE))
 		__set_bit(FSCACHE_COOKIE_NO_DATA_TO_READ, &cookie->flags);
 
 	if (fscache_set_key(cookie, index_key, index_key_len) < 0)
-- 
2.27.0

