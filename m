Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 87C74574EFA
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Jul 2022 15:21:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S239816AbiGNNVo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Jul 2022 09:21:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47382 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S239751AbiGNNVK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Jul 2022 09:21:10 -0400
Received: from out30-45.freemail.mail.aliyun.com (out30-45.freemail.mail.aliyun.com [115.124.30.45])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 767CC5E307
        for <linux-kernel@vger.kernel.org>; Thu, 14 Jul 2022 06:21:09 -0700 (PDT)
X-Alimail-AntiSpam: AC=PASS;BC=-1|-1;BR=01201311R171e4;CH=green;DM=||false|;DS=||;FP=0|-1|-1|-1|0|-1|-1|-1;HT=e01e04400;MF=hsiangkao@linux.alibaba.com;NM=1;PH=DS;RN=4;SR=0;TI=SMTPD_---0VJJkPHv_1657804865;
Received: from e18g06460.et15sqa.tbsite.net(mailfrom:hsiangkao@linux.alibaba.com fp:SMTPD_---0VJJkPHv_1657804865)
          by smtp.aliyun-inc.com;
          Thu, 14 Jul 2022 21:21:06 +0800
From:   Gao Xiang <hsiangkao@linux.alibaba.com>
To:     linux-erofs@lists.ozlabs.org, Chao Yu <chao@kernel.org>
Cc:     LKML <linux-kernel@vger.kernel.org>,
        Gao Xiang <hsiangkao@linux.alibaba.com>
Subject: [PATCH 05/16] erofs: drop the old pagevec approach
Date:   Thu, 14 Jul 2022 21:20:40 +0800
Message-Id: <20220714132051.46012-6-hsiangkao@linux.alibaba.com>
X-Mailer: git-send-email 2.24.4
In-Reply-To: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
References: <20220714132051.46012-1-hsiangkao@linux.alibaba.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-9.9 required=5.0 tests=BAYES_00,
        ENV_AND_HDR_SPF_MATCH,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,USER_IN_DEF_SPF_WL
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the old pagevec approach but keep z_erofs_page_type for now.
It will be reworked in the following commits as well.

Also rename Z_EROFS_NR_INLINE_PAGEVECS as Z_EROFS_INLINE_BVECS with
the new value 2 since it's actually enough to bootstrap.

Signed-off-by: Gao Xiang <hsiangkao@linux.alibaba.com>
---
 fs/erofs/zdata.c |  17 +++--
 fs/erofs/zdata.h |   9 +--
 fs/erofs/zpvec.h | 159 -----------------------------------------------
 3 files changed, 16 insertions(+), 169 deletions(-)
 delete mode 100644 fs/erofs/zpvec.h

diff --git a/fs/erofs/zdata.c b/fs/erofs/zdata.c
index f52c54058f31..e96704db106e 100644
--- a/fs/erofs/zdata.c
+++ b/fs/erofs/zdata.c
@@ -27,6 +27,17 @@ static struct z_erofs_pcluster_slab pcluster_pool[] __read_mostly = {
 	_PCLP(Z_EROFS_PCLUSTER_MAX_PAGES)
 };
 
+/* page type in pagevec for decompress subsystem */
+enum z_erofs_page_type {
+	/* including Z_EROFS_VLE_PAGE_TAIL_EXCLUSIVE */
+	Z_EROFS_PAGE_TYPE_EXCLUSIVE,
+
+	Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED,
+
+	Z_EROFS_VLE_PAGE_TYPE_HEAD,
+	Z_EROFS_VLE_PAGE_TYPE_MAX
+};
+
 struct z_erofs_bvec_iter {
 	struct page *bvpage;
 	struct z_erofs_bvset *bvset;
@@ -273,7 +284,6 @@ struct z_erofs_decompress_frontend {
 	struct inode *const inode;
 	struct erofs_map_blocks map;
 	struct z_erofs_bvec_iter biter;
-	struct z_erofs_pagevec_ctor vector;
 
 	struct page *candidate_bvpage;
 	struct z_erofs_pcluster *pcl, *tailpcl;
@@ -636,7 +646,7 @@ static int z_erofs_collector_begin(struct z_erofs_decompress_frontend *fe)
 		return ret;
 	}
 	z_erofs_bvec_iter_begin(&fe->biter, &fe->pcl->bvset,
-				Z_EROFS_NR_INLINE_PAGEVECS, fe->pcl->vcnt);
+				Z_EROFS_INLINE_BVECS, fe->pcl->vcnt);
 	/* since file-backed online pages are traversed in reverse order */
 	fe->icpage_ptr = fe->pcl->compressed_pages +
 			z_erofs_pclusterpages(fe->pcl);
@@ -871,8 +881,7 @@ static int z_erofs_parse_out_bvecs(struct z_erofs_pcluster *pcl,
 	struct page *old_bvpage;
 	int i, err = 0;
 
-	z_erofs_bvec_iter_begin(&biter, &pcl->bvset,
-				Z_EROFS_NR_INLINE_PAGEVECS, 0);
+	z_erofs_bvec_iter_begin(&biter, &pcl->bvset, Z_EROFS_INLINE_BVECS, 0);
 	for (i = 0; i < pcl->vcnt; ++i) {
 		struct z_erofs_bvec bvec;
 		unsigned int pagenr;
diff --git a/fs/erofs/zdata.h b/fs/erofs/zdata.h
index d03e333e4fde..a755c5a44d87 100644
--- a/fs/erofs/zdata.h
+++ b/fs/erofs/zdata.h
@@ -7,10 +7,10 @@
 #define __EROFS_FS_ZDATA_H
 
 #include "internal.h"
-#include "zpvec.h"
+#include "tagptr.h"
 
 #define Z_EROFS_PCLUSTER_MAX_PAGES	(Z_EROFS_PCLUSTER_MAX_SIZE / PAGE_SIZE)
-#define Z_EROFS_NR_INLINE_PAGEVECS      3
+#define Z_EROFS_INLINE_BVECS		2
 
 #define Z_EROFS_PCLUSTER_FULL_LENGTH    0x00000001
 #define Z_EROFS_PCLUSTER_LENGTH_BIT     1
@@ -34,7 +34,7 @@ struct name { \
 	struct z_erofs_bvec bvec[total]; \
 };
 __Z_EROFS_BVSET(z_erofs_bvset,)
-__Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_NR_INLINE_PAGEVECS)
+__Z_EROFS_BVSET(z_erofs_bvset_inline, Z_EROFS_INLINE_BVECS)
 
 /*
  * Structure fields follow one of the following exclusion rules.
@@ -69,9 +69,6 @@ struct z_erofs_pcluster {
 	unsigned short nr_pages;
 
 	union {
-		/* L: inline a certain number of pagevecs for bootstrap */
-		erofs_vtptr_t pagevec[Z_EROFS_NR_INLINE_PAGEVECS];
-
 		/* L: inline a certain number of bvec for bootstrap */
 		struct z_erofs_bvset_inline bvset;
 
diff --git a/fs/erofs/zpvec.h b/fs/erofs/zpvec.h
deleted file mode 100644
index b05464f4a808..000000000000
--- a/fs/erofs/zpvec.h
+++ /dev/null
@@ -1,159 +0,0 @@
-/* SPDX-License-Identifier: GPL-2.0-only */
-/*
- * Copyright (C) 2018 HUAWEI, Inc.
- *             https://www.huawei.com/
- */
-#ifndef __EROFS_FS_ZPVEC_H
-#define __EROFS_FS_ZPVEC_H
-
-#include "tagptr.h"
-
-/* page type in pagevec for decompress subsystem */
-enum z_erofs_page_type {
-	/* including Z_EROFS_VLE_PAGE_TAIL_EXCLUSIVE */
-	Z_EROFS_PAGE_TYPE_EXCLUSIVE,
-
-	Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED,
-
-	Z_EROFS_VLE_PAGE_TYPE_HEAD,
-	Z_EROFS_VLE_PAGE_TYPE_MAX
-};
-
-extern void __compiletime_error("Z_EROFS_PAGE_TYPE_EXCLUSIVE != 0")
-	__bad_page_type_exclusive(void);
-
-/* pagevec tagged pointer */
-typedef tagptr2_t	erofs_vtptr_t;
-
-/* pagevec collector */
-struct z_erofs_pagevec_ctor {
-	struct page *curr, *next;
-	erofs_vtptr_t *pages;
-
-	unsigned int nr, index;
-};
-
-static inline void z_erofs_pagevec_ctor_exit(struct z_erofs_pagevec_ctor *ctor,
-					     bool atomic)
-{
-	if (!ctor->curr)
-		return;
-
-	if (atomic)
-		kunmap_atomic(ctor->pages);
-	else
-		kunmap(ctor->curr);
-}
-
-static inline struct page *
-z_erofs_pagevec_ctor_next_page(struct z_erofs_pagevec_ctor *ctor,
-			       unsigned int nr)
-{
-	unsigned int index;
-
-	/* keep away from occupied pages */
-	if (ctor->next)
-		return ctor->next;
-
-	for (index = 0; index < nr; ++index) {
-		const erofs_vtptr_t t = ctor->pages[index];
-		const unsigned int tags = tagptr_unfold_tags(t);
-
-		if (tags == Z_EROFS_PAGE_TYPE_EXCLUSIVE)
-			return tagptr_unfold_ptr(t);
-	}
-	DBG_BUGON(nr >= ctor->nr);
-	return NULL;
-}
-
-static inline void
-z_erofs_pagevec_ctor_pagedown(struct z_erofs_pagevec_ctor *ctor,
-			      bool atomic)
-{
-	struct page *next = z_erofs_pagevec_ctor_next_page(ctor, ctor->nr);
-
-	z_erofs_pagevec_ctor_exit(ctor, atomic);
-
-	ctor->curr = next;
-	ctor->next = NULL;
-	ctor->pages = atomic ?
-		kmap_atomic(ctor->curr) : kmap(ctor->curr);
-
-	ctor->nr = PAGE_SIZE / sizeof(struct page *);
-	ctor->index = 0;
-}
-
-static inline void z_erofs_pagevec_ctor_init(struct z_erofs_pagevec_ctor *ctor,
-					     unsigned int nr,
-					     erofs_vtptr_t *pages,
-					     unsigned int i)
-{
-	ctor->nr = nr;
-	ctor->curr = ctor->next = NULL;
-	ctor->pages = pages;
-
-	if (i >= nr) {
-		i -= nr;
-		z_erofs_pagevec_ctor_pagedown(ctor, false);
-		while (i > ctor->nr) {
-			i -= ctor->nr;
-			z_erofs_pagevec_ctor_pagedown(ctor, false);
-		}
-	}
-	ctor->next = z_erofs_pagevec_ctor_next_page(ctor, i);
-	ctor->index = i;
-}
-
-static inline bool z_erofs_pagevec_enqueue(struct z_erofs_pagevec_ctor *ctor,
-					   struct page *page,
-					   enum z_erofs_page_type type,
-					   bool pvec_safereuse)
-{
-	if (!ctor->next) {
-		/* some pages cannot be reused as pvec safely without I/O */
-		if (type == Z_EROFS_PAGE_TYPE_EXCLUSIVE && !pvec_safereuse)
-			type = Z_EROFS_VLE_PAGE_TYPE_TAIL_SHARED;
-
-		if (type != Z_EROFS_PAGE_TYPE_EXCLUSIVE &&
-		    ctor->index + 1 == ctor->nr)
-			return false;
-	}
-
-	if (ctor->index >= ctor->nr)
-		z_erofs_pagevec_ctor_pagedown(ctor, false);
-
-	/* exclusive page type must be 0 */
-	if (Z_EROFS_PAGE_TYPE_EXCLUSIVE != (uintptr_t)NULL)
-		__bad_page_type_exclusive();
-
-	/* should remind that collector->next never equal to 1, 2 */
-	if (type == (uintptr_t)ctor->next) {
-		ctor->next = page;
-	}
-	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, page, type);
-	return true;
-}
-
-static inline struct page *
-z_erofs_pagevec_dequeue(struct z_erofs_pagevec_ctor *ctor,
-			enum z_erofs_page_type *type)
-{
-	erofs_vtptr_t t;
-
-	if (ctor->index >= ctor->nr) {
-		DBG_BUGON(!ctor->next);
-		z_erofs_pagevec_ctor_pagedown(ctor, true);
-	}
-
-	t = ctor->pages[ctor->index];
-
-	*type = tagptr_unfold_tags(t);
-
-	/* should remind that collector->next never equal to 1, 2 */
-	if (*type == (uintptr_t)ctor->next)
-		ctor->next = tagptr_unfold_ptr(t);
-
-	ctor->pages[ctor->index++] = tagptr_fold(erofs_vtptr_t, NULL, 0);
-	return tagptr_unfold_ptr(t);
-}
-#endif
-- 
2.24.4

