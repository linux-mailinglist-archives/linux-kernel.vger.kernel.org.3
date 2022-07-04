Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A5418564B40
	for <lists+linux-kernel@lfdr.de>; Mon,  4 Jul 2022 03:44:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233009AbiGDBm7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 3 Jul 2022 21:42:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:58750 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232935AbiGDBmy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 3 Jul 2022 21:42:54 -0400
Received: from mail-qk1-x72a.google.com (mail-qk1-x72a.google.com [IPv6:2607:f8b0:4864:20::72a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 01EA46437
        for <linux-kernel@vger.kernel.org>; Sun,  3 Jul 2022 18:42:53 -0700 (PDT)
Received: by mail-qk1-x72a.google.com with SMTP id b24so5925905qkn.4
        for <linux-kernel@vger.kernel.org>; Sun, 03 Jul 2022 18:42:52 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=nS5uamsou0zUk5LgoTgLo0LF42b+KXux6Lknz0BOHs0=;
        b=luEURQNMwiOBULIg7zLXzx9UL1Eib0iIs2tI1Xj/ZDp9bTd2+2/Qk2x9UMesprDHtG
         sdpejqrpCv0Da8MF+CBU2G57xlK8OmGTP2ucHlU9Cz7W5JrTzfOUQ3FL6xTqZKoBZhu1
         rC52t0bcnx4tYgRq7QuHvNCjKrdC14Y97JRj5+XQO9FCYfRQQf3etX3PPFQIhzJhTkCr
         o263uGPmqqEI+eWjGlcGXMWRsDv2GuHr9pXrWVhw/ZzznRKkwn/enhkhBXRNPjena69v
         zHKA0JB+jcTo0G6WM8sVfUk7oom8Fwh0xCfLW6+F3IrGyIWHZb2PBV10XNvd/hoTwMZu
         5gPg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=nS5uamsou0zUk5LgoTgLo0LF42b+KXux6Lknz0BOHs0=;
        b=qQ0ovrE3pFfketB2E7eblwxDAGlM7j8IGJTeoVjJV4jFSSHMCDKO4C6XiEoaI7cXQh
         KrNiihTTWcJ4CMyVaObJOA5s2VyvICV+aIR5nguJ9DzQwetfoNw2Rw/rfxk375f4wcMR
         MPmo3gXgBlKilpZXqDqYD7CoZN3eC/ZbKqyHNE0acMnRGumTm4XsHNoTbVwrS32HEz6d
         7OS+6YQnCN02vlbOZe7eeFsAkKHinxSTjjDtd/J3UpAX1vrP8iON7qnWENsV1TJWM4Pd
         lmipdLONQoHkRwqMcIWjfc3TrUMwlPJMMVGD1sfskCJWC9W+29ZD7vh8ucTRnDuEr4zo
         DEWg==
X-Gm-Message-State: AJIora/WFpV32JLeSx+p3Tu3F0gcVlpv30pYOFxTMHLmNXdO3orNtOtH
        3dU+1TPOWU+h6pMsEbNIpgityLHwBhDy9sI=
X-Google-Smtp-Source: AGRyM1sEF+JETUblxucmbIMaLu0KUEt7eKYGBudlJhcfZB4kRcwcLgW+mBaRy+NaWqWUOc8ZHok7hg==
X-Received: by 2002:a05:620a:4256:b0:6ab:54c4:cf9 with SMTP id w22-20020a05620a425600b006ab54c40cf9mr18334257qko.234.1656898971669;
        Sun, 03 Jul 2022 18:42:51 -0700 (PDT)
Received: from localhost (c-73-219-103-14.hsd1.vt.comcast.net. [73.219.103.14])
        by smtp.gmail.com with ESMTPSA id f6-20020a05622a104600b0031d283f4c4dsm9824198qte.60.2022.07.03.18.42.50
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 03 Jul 2022 18:42:50 -0700 (PDT)
From:   Kent Overstreet <kent.overstreet@gmail.com>
To:     linux-kernel@vger.kernel.org
Cc:     v9fs-developer@lists.sourceforge.net,
        Kent Overstreet <kent.overstreet@gmail.com>,
        Eric Van Hensbergen <ericvh@gmail.com>,
        Latchesar Ionkov <lucho@ionkov.net>,
        Dominique Martinet <asmadeus@codewreck.org>
Subject: [PATCH 3/3] 9p: Add mempools for RPCs
Date:   Sun,  3 Jul 2022 21:42:43 -0400
Message-Id: <20220704014243.153050-3-kent.overstreet@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220704014243.153050-1-kent.overstreet@gmail.com>
References: <20220704010945.C230AC341C7@smtp.kernel.org>
 <20220704014243.153050-1-kent.overstreet@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Signed-off-by: Kent Overstreet <kent.overstreet@gmail.com>
Cc: Eric Van Hensbergen <ericvh@gmail.com>
Cc: Latchesar Ionkov <lucho@ionkov.net>
Cc: Dominique Martinet <asmadeus@codewreck.org>
---
 include/net/9p/9p.h     |  6 ++++-
 include/net/9p/client.h |  5 +++-
 net/9p/client.c         | 58 ++++++++++++++++++++++++++++++-----------
 net/9p/trans_rdma.c     |  2 +-
 4 files changed, 53 insertions(+), 18 deletions(-)

diff --git a/include/net/9p/9p.h b/include/net/9p/9p.h
index 24a509f559..c0d59b53c1 100644
--- a/include/net/9p/9p.h
+++ b/include/net/9p/9p.h
@@ -539,12 +539,16 @@ struct p9_rstatfs {
 struct p9_fcall {
 	u32 size;
 	u8 id;
+	enum p9_fcall_alloc {
+		P9_FCALL_KMEM_CACHE,
+		P9_FCALL_KMALLOC,
+		P9_FCALL_MEMPOOL,
+	} allocated;
 	u16 tag;
 
 	size_t offset;
 	size_t capacity;
 
-	struct kmem_cache *cache;
 	u8 *sdata;
 };
 
diff --git a/include/net/9p/client.h b/include/net/9p/client.h
index cb78e0e333..6517ca36bf 100644
--- a/include/net/9p/client.h
+++ b/include/net/9p/client.h
@@ -9,6 +9,7 @@
 #ifndef NET_9P_CLIENT_H
 #define NET_9P_CLIENT_H
 
+#include <linux/mempool.h>
 #include <linux/utsname.h>
 #include <linux/idr.h>
 
@@ -106,6 +107,7 @@ struct p9_client {
 	enum p9_trans_status status;
 	void *trans;
 	struct kmem_cache *fcall_cache;
+	mempool_t pools[2];
 
 	union {
 		struct {
@@ -222,7 +224,8 @@ int p9_client_mkdir_dotl(struct p9_fid *fid, const char *name, int mode,
 				kgid_t gid, struct p9_qid *qid);
 int p9_client_lock_dotl(struct p9_fid *fid, struct p9_flock *flock, u8 *status);
 int p9_client_getlock_dotl(struct p9_fid *fid, struct p9_getlock *fl);
-void p9_fcall_fini(struct p9_fcall *fc);
+void p9_fcall_fini(struct p9_client *c, struct p9_fcall *fc,
+		   int fc_idx);
 struct p9_req_t *p9_tag_lookup(struct p9_client *c, u16 tag);
 
 static inline void p9_req_get(struct p9_req_t *r)
diff --git a/net/9p/client.c b/net/9p/client.c
index a36a40137c..82061c49cb 100644
--- a/net/9p/client.c
+++ b/net/9p/client.c
@@ -219,22 +219,34 @@ static int parse_opts(char *opts, struct p9_client *clnt)
 }
 
 static int p9_fcall_init(struct p9_client *c, struct p9_fcall *fc,
-			 int alloc_msize)
+			 int fc_idx, unsigned alloc_msize)
 {
+	WARN(alloc_msize > c->msize, "alloc_mize %u client msize %u",
+	     alloc_msize, c->msize);
+
 	if (likely(c->fcall_cache) && alloc_msize == c->msize) {
 		fc->sdata = kmem_cache_alloc(c->fcall_cache, GFP_NOFS);
-		fc->cache = c->fcall_cache;
+		fc->allocated = P9_FCALL_KMEM_CACHE;
 	} else {
 		fc->sdata = kmalloc(alloc_msize, GFP_NOFS);
-		fc->cache = NULL;
+		fc->allocated = P9_FCALL_KMALLOC;
 	}
-	if (!fc->sdata)
+
+	if (!fc->sdata >> alloc_msize > c->msize)
 		return -ENOMEM;
+
+	if (!fc->sdata) {
+		fc->sdata = mempool_alloc(&c->pools[fc_idx], GFP_NOFS);
+		fc->allocated = P9_FCALL_MEMPOOL;
+		alloc_msize = c->msize;
+	}
+
 	fc->capacity = alloc_msize;
 	return 0;
 }
 
-void p9_fcall_fini(struct p9_fcall *fc)
+void p9_fcall_fini(struct p9_client *c, struct p9_fcall *fc,
+		   int fc_idx)
 {
 	/* sdata can be NULL for interrupted requests in trans_rdma,
 	 * and kmem_cache_free does not do NULL-check for us
@@ -242,10 +254,17 @@ void p9_fcall_fini(struct p9_fcall *fc)
 	if (unlikely(!fc->sdata))
 		return;
 
-	if (fc->cache)
-		kmem_cache_free(fc->cache, fc->sdata);
-	else
+	switch (fc->allocated) {
+	case P9_FCALL_KMEM_CACHE:
+		kmem_cache_free(c->fcall_cache, fc->sdata);
+		break;
+	case P9_FCALL_KMALLOC:
 		kfree(fc->sdata);
+		break;
+	case P9_FCALL_MEMPOOL:
+		mempool_free(fc->sdata, &c->pools[fc_idx]);
+		break;
+	}
 }
 EXPORT_SYMBOL(p9_fcall_fini);
 
@@ -270,9 +289,9 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 	if (!req)
 		return ERR_PTR(-ENOMEM);
 
-	if (p9_fcall_init(c, &req->tc, alloc_msize))
+	if (p9_fcall_init(c, &req->tc, 0, alloc_msize))
 		goto free_req;
-	if (p9_fcall_init(c, &req->rc, alloc_msize))
+	if (p9_fcall_init(c, &req->rc, 1, alloc_msize))
 		goto free;
 
 	p9pdu_reset(&req->tc);
@@ -310,8 +329,8 @@ p9_tag_alloc(struct p9_client *c, int8_t type, unsigned int max_size)
 	return req;
 
 free:
-	p9_fcall_fini(&req->tc);
-	p9_fcall_fini(&req->rc);
+	p9_fcall_fini(c, &req->tc, 0);
+	p9_fcall_fini(c, &req->rc, 1);
 free_req:
 	kmem_cache_free(p9_req_cache, req);
 	return ERR_PTR(-ENOMEM);
@@ -373,8 +392,8 @@ static int p9_tag_remove(struct p9_client *c, struct p9_req_t *r)
 int p9_req_put(struct p9_client *c, struct p9_req_t *r)
 {
 	if (refcount_dec_and_test(&r->refcount)) {
-		p9_fcall_fini(&r->tc);
-		p9_fcall_fini(&r->rc);
+		p9_fcall_fini(c, &r->tc, 0);
+		p9_fcall_fini(c, &r->rc, 1);
 		kmem_cache_free(p9_req_cache, r);
 		return 1;
 	}
@@ -999,7 +1018,7 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 	char *client_id;
 
 	err = 0;
-	clnt = kmalloc(sizeof(*clnt), GFP_KERNEL);
+	clnt = kzalloc(sizeof(*clnt), GFP_KERNEL);
 	if (!clnt)
 		return ERR_PTR(-ENOMEM);
 
@@ -1063,6 +1082,11 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 					   clnt->msize - (P9_HDRSZ + 4),
 					   NULL);
 
+	err =   mempool_init_kmalloc_pool(&clnt->pools[0], 4, clnt->msize) ?:
+		mempool_init_kmalloc_pool(&clnt->pools[1], 4, clnt->msize);
+	if (err)
+		goto close_trans;
+
 	return clnt;
 
 close_trans:
@@ -1070,6 +1094,8 @@ struct p9_client *p9_client_create(const char *dev_name, char *options)
 put_trans:
 	v9fs_put_trans(clnt->trans_mod);
 free_client:
+	mempool_exit(&clnt->pools[1]);
+	mempool_exit(&clnt->pools[0]);
 	kfree(clnt);
 	return ERR_PTR(err);
 }
@@ -1094,6 +1120,8 @@ void p9_client_destroy(struct p9_client *clnt)
 
 	p9_tag_cleanup(clnt);
 
+	mempool_exit(&clnt->pools[1]);
+	mempool_exit(&clnt->pools[0]);
 	kmem_cache_destroy(clnt->fcall_cache);
 	kfree(clnt);
 }
diff --git a/net/9p/trans_rdma.c b/net/9p/trans_rdma.c
index d817d37452..99d878d70d 100644
--- a/net/9p/trans_rdma.c
+++ b/net/9p/trans_rdma.c
@@ -431,7 +431,7 @@ static int rdma_request(struct p9_client *client, struct p9_req_t *req)
 	if (unlikely(atomic_read(&rdma->excess_rc) > 0)) {
 		if ((atomic_sub_return(1, &rdma->excess_rc) >= 0)) {
 			/* Got one! */
-			p9_fcall_fini(&req->rc);
+			p9_fcall_fini(client, &req->rc, 1);
 			req->rc.sdata = NULL;
 			goto dont_need_post_recv;
 		} else {
-- 
2.36.1

