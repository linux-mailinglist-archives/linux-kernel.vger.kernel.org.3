Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 627DE4E3764
	for <lists+linux-kernel@lfdr.de>; Tue, 22 Mar 2022 04:26:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236143AbiCVDY0 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 23:24:26 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49672 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236153AbiCVDYV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 23:24:21 -0400
Received: from smtpbguseast3.qq.com (smtpbguseast3.qq.com [54.243.244.52])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A5C7B2AC7A
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 20:22:50 -0700 (PDT)
X-QQ-mid: bizesmtp89t1647919356tyf1r1ad
Received: from localhost.localdomain ( [202.96.137.239])
        by bizesmtp.qq.com (ESMTP) with 
        id ; Tue, 22 Mar 2022 11:22:30 +0800 (CST)
X-QQ-SSF: 0140000000200090B000B00A0000000
X-QQ-FEAT: 1XdM7eWeVvJVLXq8EZ21hgD3YFVmsWHU0q9SvE6lxibK9gxbSs716ugzA/Ov1
        KehTLOgvyo2LKwCql3GjYo7yR5CTTW2i5YWGN++5TYNpln673SDXUCWkl8wFWVQ2uas/tpN
        qLZBoL/qwPZlSmjmkevQQjbEVFZmjTJyDOSAcm461Hbu0FdxEW6ZT4SPmyt1hKQWRWs3rZ/
        XYuxNAjXVOgue17dJIInZkmh5G/CPsA1R5+cTqmyJlN4qvB3K3+K6C8TKS81fADxputBnFc
        zkf7kvLF8mR8nlCAhFLFdBdk9gMJS5i/TtLa5r1k4WpabUNhUeV3bJvLbgrv2WM6Xn6dwIS
        updI3sFZy22HBaOp84F74iuVw9P4w==
X-QQ-GoodBg: 2
From:   Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
To:     akpm@linux-foundation.org
Cc:     willy@infradead.org, vbabka@suse.cz, william.kucharski@oracle.com,
        linux-kernel@vger.kernel.org, linux-mm@kvack.org,
        yejiajian2018@email.szu.edu.cn, hanshenghong2019@email.szu.edu.cn,
        caoyixuan2019@email.szu.edu.cn, zhaochongxi2019@email.szu.edu.cn,
        yuhongf@szu.edu.cn, Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
Subject: [PATCH 1/2] mm/page_owner.c: introduce vmalloc allocator for page_owner
Date:   Tue, 22 Mar 2022 11:22:24 +0800
Message-Id: <20220322032225.1402992-1-zhangyinan2019@email.szu.edu.cn>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-QQ-SENDSIZE: 520
Feedback-ID: bizesmtp:email.szu.edu.cn:qybgforeign:qybgforeign4
X-QQ-Bgrelay: 1
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

An application's memory consumption is high and keeps increasing,
then it is suspected of having memory leak. There are several
commonly used memory allocators: slab, cma, vmalloc, etc. The memory
leak identification can be speed up if page information allocated
by an individual allocator are analyzed individually. This patch
introduce vmalloc allocator for page_owner.

Following adjustments are made:
1) Add a member variable "allocator" to the page_owner struct.
And the value of "allocator" is predefined in a newly added string
array "allocator_name".
2) Add a function __set_page_owner_allocator() to record allocator
name in variable "allocator".
3) Add allocator name in the output of print_page_owner().

This work is coauthored by
	Shenghong Han
	Yixuan Cao
	Chongxi Zhao
	Jiajian Ye
	Yuhong Feng
	Yongqiang Liu

Signed-off-by: Yinan Zhang <zhangyinan2019@email.szu.edu.cn>
---
 include/linux/page_owner.h | 18 ++++++++++++++++++
 mm/page_owner.c            | 29 +++++++++++++++++++++++++++--
 2 files changed, 45 insertions(+), 2 deletions(-)

diff --git a/include/linux/page_owner.h b/include/linux/page_owner.h
index 119a0c9d2a8b..d559781dde67 100644
--- a/include/linux/page_owner.h
+++ b/include/linux/page_owner.h
@@ -11,6 +11,8 @@ extern struct page_ext_operations page_owner_ops;
 extern void __reset_page_owner(struct page *page, unsigned short order);
 extern void __set_page_owner(struct page *page,
 			unsigned short order, gfp_t gfp_mask);
+extern void __set_page_owner_allocator(struct page *page, unsigned short order,
+			unsigned short allocator);
 extern void __split_page_owner(struct page *page, unsigned int nr);
 extern void __folio_copy_owner(struct folio *newfolio, struct folio *old);
 extern void __set_page_owner_migrate_reason(struct page *page, int reason);
@@ -18,6 +20,11 @@ extern void __dump_page_owner(const struct page *page);
 extern void pagetypeinfo_showmixedcount_print(struct seq_file *m,
 					pg_data_t *pgdat, struct zone *zone);
 
+enum page_owner_allocator {
+	PAGE_OWNER_ALLOCATOR_UNKNOWN = 0,
+	PAGE_OWNER_ALLOCATOR_VMALLOC
+};
+
 static inline void reset_page_owner(struct page *page, unsigned short order)
 {
 	if (static_branch_unlikely(&page_owner_inited))
@@ -31,6 +38,13 @@ static inline void set_page_owner(struct page *page,
 		__set_page_owner(page, order, gfp_mask);
 }
 
+static inline void set_page_owner_allocator(struct page *page, unsigned short order,
+			unsigned short allocator)
+{
+	if (static_branch_unlikely(&page_owner_inited))
+		__set_page_owner_allocator(page, order, allocator);
+}
+
 static inline void split_page_owner(struct page *page, unsigned int nr)
 {
 	if (static_branch_unlikely(&page_owner_inited))
@@ -59,6 +73,10 @@ static inline void set_page_owner(struct page *page,
 			unsigned int order, gfp_t gfp_mask)
 {
 }
+static inline void set_page_owner_allocator(struct page *page, unsigned short order,
+			unsigned short allocator)
+{
+}
 static inline void split_page_owner(struct page *page,
 			unsigned short order)
 {
diff --git a/mm/page_owner.c b/mm/page_owner.c
index 0a9588506571..11bb805c61fd 100644
--- a/mm/page_owner.c
+++ b/mm/page_owner.c
@@ -32,6 +32,12 @@ struct page_owner {
 	char comm[TASK_COMM_LEN];
 	pid_t pid;
 	pid_t tgid;
+	unsigned short allocator;
+};
+
+const char * const allocator_name[] = {
+	"unknown",
+	"vmalloc",
 };
 
 static bool page_owner_enabled = false;
@@ -148,6 +154,7 @@ void __reset_page_owner(struct page *page, unsigned short order)
 		page_owner = get_page_owner(page_ext);
 		page_owner->free_handle = handle;
 		page_owner->free_ts_nsec = free_ts_nsec;
+		page_owner->allocator = PAGE_OWNER_ALLOCATOR_UNKNOWN;
 		page_ext = page_ext_next(page_ext);
 	}
 }
@@ -190,6 +197,22 @@ noinline void __set_page_owner(struct page *page, unsigned short order,
 	__set_page_owner_handle(page_ext, handle, order, gfp_mask);
 }
 
+void __set_page_owner_allocator(struct page *page, unsigned short order, unsigned short allocator)
+{
+	int i;
+	struct page_ext *page_ext;
+	struct page_owner *page_owner;
+
+	page_ext = lookup_page_ext(page);
+	if (unlikely(!page_ext))
+		return;
+	for (i = 0; i < (1 << order); i++) {
+		page_owner = get_page_owner(page_ext);
+		page_owner->allocator = allocator;
+		page_ext = page_ext_next(page_ext);
+	}
+}
+
 void __set_page_owner_migrate_reason(struct page *page, int reason)
 {
 	struct page_ext *page_ext = lookup_page_ext(page);
@@ -238,6 +261,7 @@ void __folio_copy_owner(struct folio *newfolio, struct folio *old)
 	new_page_owner->tgid = old_page_owner->tgid;
 	new_page_owner->ts_nsec = old_page_owner->ts_nsec;
 	new_page_owner->free_ts_nsec = old_page_owner->ts_nsec;
+	new_page_owner->allocator = old_page_owner->allocator;
 	strcpy(new_page_owner->comm, old_page_owner->comm);
 
 	/*
@@ -386,11 +410,12 @@ print_page_owner(char __user *buf, size_t count, unsigned long pfn,
 		return -ENOMEM;
 
 	ret = scnprintf(kbuf, count,
-			"Page allocated via order %u, mask %#x(%pGg), pid %d, tgid %d (%s), ts %llu ns, free_ts %llu ns\n",
+			"Page allocated via order %u, mask %#x(%pGg), pid %d, tgid %d (%s), ts %llu ns, free_ts %llu ns, allocator %s\n",
 			page_owner->order, page_owner->gfp_mask,
 			&page_owner->gfp_mask, page_owner->pid,
 			page_owner->tgid, page_owner->comm,
-			page_owner->ts_nsec, page_owner->free_ts_nsec);
+			page_owner->ts_nsec, page_owner->free_ts_nsec,
+			allocator_name[page_owner->allocator]);
 
 	/* Print information relevant to grouping pages by mobility */
 	pageblock_mt = get_pageblock_migratetype(page);
-- 
2.25.1



