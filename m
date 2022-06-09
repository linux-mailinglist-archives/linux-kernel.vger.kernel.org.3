Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C86B25442CF
	for <lists+linux-kernel@lfdr.de>; Thu,  9 Jun 2022 07:02:38 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237707AbiFIFCe (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 9 Jun 2022 01:02:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37300 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230510AbiFIFCd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 9 Jun 2022 01:02:33 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C4B8B21911F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 22:02:31 -0700 (PDT)
Received: from dggemv711-chm.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LJX3X0KhszgYbh;
        Thu,  9 Jun 2022 13:00:40 +0800 (CST)
Received: from kwepemm600012.china.huawei.com (7.193.23.74) by
 dggemv711-chm.china.huawei.com (10.1.198.66) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 13:02:30 +0800
Received: from ubuntu1804.huawei.com (10.67.175.29) by
 kwepemm600012.china.huawei.com (7.193.23.74) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 9 Jun 2022 13:02:29 +0800
From:   Guan Jing <guanjing6@huawei.com>
To:     <naoya.horiguchi@nec.com>, <linmiaohe@huawei.com>,
        <akpm@linux-foundation.org>
CC:     <djwong@kernel.org>, <dan.j.williams@intel.com>,
        <ruansy.fnst@fujitsu.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, Guan Jing <guanjing6@huawei.com>
Subject: [PATCH -next] =?UTF-8?q?mm=EF=BC=9Afix=20build=20error=20of=20def?= =?UTF-8?q?ined=20but=20not=20used?=
Date:   Thu, 9 Jun 2022 13:00:28 +0800
Message-ID: <20220609050028.28645-1-guanjing6@huawei.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain; charset="UTF-8"
Content-Transfer-Encoding: 8bit
X-Originating-IP: [10.67.175.29]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 kwepemm600012.china.huawei.com (7.193.23.74)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

If CONFIG_HUGETLB_PAGE is not set and CONFIG_FS_DAX=y.
Use command "make ARCH=arm64 CROSS_COMPILE=aarch64-linux-gnu-" to
build, will fail:

mm/memory-failure.c:568:13: error: ‘collect_procs_fsdax’ defined
but not used [-Werror=unused-function]
	static void collect_procs_fsdax(struct page *page,
             ^~~~~~~~~~~~~~~~~~~
cc1: all warnings being treated as errors
make[1]: *** [mm/memory-failure.o] Error 1
make[1]: *** Waiting for unfinished jobs....
make: *** [mm] Error 2
make: *** Waiting for unfinished jobs....

so extending "#ifdef CONFIG_HUGETLB_PAG" to cover
collect_procs_fsdax() would be a simple resolution.

Reported-by: Hulk Robot <hulkci@huawei.com>
Fixes: 143ac5cd7289 ("mm: introduce mf_dax_kill_procs() for fsdax case")
Signed-off-by: Guan Jing <guanjing6@huawei.com>
---
 mm/memory-failure.c | 56 ++++++++++++++++++++++-----------------------
 1 file changed, 28 insertions(+), 28 deletions(-)

diff --git a/mm/memory-failure.c b/mm/memory-failure.c
index 545f402c4890..952f117e4584 100644
--- a/mm/memory-failure.c
+++ b/mm/memory-failure.c
@@ -561,34 +561,6 @@ static void collect_procs_file(struct page *page, struct list_head *to_kill,
 	i_mmap_unlock_read(mapping);
 }
 
-#ifdef CONFIG_FS_DAX
-/*
- * Collect processes when the error hit a fsdax page.
- */
-static void collect_procs_fsdax(struct page *page,
-		struct address_space *mapping, pgoff_t pgoff,
-		struct list_head *to_kill)
-{
-	struct vm_area_struct *vma;
-	struct task_struct *tsk;
-
-	i_mmap_lock_read(mapping);
-	read_lock(&tasklist_lock);
-	for_each_process(tsk) {
-		struct task_struct *t = task_early_kill(tsk, true);
-
-		if (!t)
-			continue;
-		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
-			if (vma->vm_mm == t->mm)
-				add_to_kill(t, page, pgoff, vma, to_kill);
-		}
-	}
-	read_unlock(&tasklist_lock);
-	i_mmap_unlock_read(mapping);
-}
-#endif /* CONFIG_FS_DAX */
-
 /*
  * Collect the processes who have the corrupted page mapped to kill.
  */
@@ -1540,6 +1512,34 @@ static int try_to_split_thp_page(struct page *page, const char *msg)
 }
 
 #ifdef CONFIG_HUGETLB_PAGE
+#ifdef CONFIG_FS_DAX
+/*
+ * Collect processes when the error hit a fsdax page.
+ */
+static void collect_procs_fsdax(struct page *page,
+		struct address_space *mapping, pgoff_t pgoff,
+		struct list_head *to_kill)
+{
+	struct vm_area_struct *vma;
+	struct task_struct *tsk;
+
+	i_mmap_lock_read(mapping);
+	read_lock(&tasklist_lock);
+	for_each_process(tsk) {
+		struct task_struct *t = task_early_kill(tsk, true);
+
+		if (!t)
+			continue;
+		vma_interval_tree_foreach(vma, &mapping->i_mmap, pgoff, pgoff) {
+			if (vma->vm_mm == t->mm)
+				add_to_kill(t, page, pgoff, vma, to_kill);
+		}
+	}
+	read_unlock(&tasklist_lock);
+	i_mmap_unlock_read(mapping);
+}
+#endif /* CONFIG_FS_DAX */
+
 /*
  * Called from hugetlb code with hugetlb_lock held.
  *
-- 
2.17.1

