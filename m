Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 07809547301
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Jun 2022 10:49:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232182AbiFKIr7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Jun 2022 04:47:59 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231663AbiFKIre (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Jun 2022 04:47:34 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A37FD3193F
        for <linux-kernel@vger.kernel.org>; Sat, 11 Jun 2022 01:47:32 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LKry96R2JzgYDL;
        Sat, 11 Jun 2022 16:45:37 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 11 Jun
 2022 16:47:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <aarcange@redhat.com>, <willy@infradead.org>, <vbabka@suse.cz>,
        <dhowells@redhat.com>, <neilb@suse.de>, <apopple@nvidia.com>,
        <david@redhat.com>, <surenb@google.com>, <peterx@redhat.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 5/7] mm/khugepaged: use helper macro __ATTR_RW
Date:   Sat, 11 Jun 2022 16:47:29 +0800
Message-ID: <20220611084731.55155-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220611084731.55155-1-linmiaohe@huawei.com>
References: <20220611084731.55155-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper macro __ATTR_RW to define the khugepaged attributes. Minor
readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/khugepaged.c | 37 +++++++++++++++----------------------
 1 file changed, 15 insertions(+), 22 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index 8e6fad7c7bd9..142e26e4bdbf 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -147,8 +147,7 @@ static ssize_t scan_sleep_millisecs_store(struct kobject *kobj,
 	return count;
 }
 static struct kobj_attribute scan_sleep_millisecs_attr =
-	__ATTR(scan_sleep_millisecs, 0644, scan_sleep_millisecs_show,
-	       scan_sleep_millisecs_store);
+	__ATTR_RW(scan_sleep_millisecs);
 
 static ssize_t alloc_sleep_millisecs_show(struct kobject *kobj,
 					  struct kobj_attribute *attr,
@@ -175,8 +174,7 @@ static ssize_t alloc_sleep_millisecs_store(struct kobject *kobj,
 	return count;
 }
 static struct kobj_attribute alloc_sleep_millisecs_attr =
-	__ATTR(alloc_sleep_millisecs, 0644, alloc_sleep_millisecs_show,
-	       alloc_sleep_millisecs_store);
+	__ATTR_RW(alloc_sleep_millisecs);
 
 static ssize_t pages_to_scan_show(struct kobject *kobj,
 				  struct kobj_attribute *attr,
@@ -200,8 +198,7 @@ static ssize_t pages_to_scan_store(struct kobject *kobj,
 	return count;
 }
 static struct kobj_attribute pages_to_scan_attr =
-	__ATTR(pages_to_scan, 0644, pages_to_scan_show,
-	       pages_to_scan_store);
+	__ATTR_RW(pages_to_scan);
 
 static ssize_t pages_collapsed_show(struct kobject *kobj,
 				    struct kobj_attribute *attr,
@@ -221,13 +218,13 @@ static ssize_t full_scans_show(struct kobject *kobj,
 static struct kobj_attribute full_scans_attr =
 	__ATTR_RO(full_scans);
 
-static ssize_t khugepaged_defrag_show(struct kobject *kobj,
+static ssize_t defrag_show(struct kobject *kobj,
 				      struct kobj_attribute *attr, char *buf)
 {
 	return single_hugepage_flag_show(kobj, attr, buf,
 					 TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
 }
-static ssize_t khugepaged_defrag_store(struct kobject *kobj,
+static ssize_t defrag_store(struct kobject *kobj,
 				       struct kobj_attribute *attr,
 				       const char *buf, size_t count)
 {
@@ -235,8 +232,7 @@ static ssize_t khugepaged_defrag_store(struct kobject *kobj,
 				 TRANSPARENT_HUGEPAGE_DEFRAG_KHUGEPAGED_FLAG);
 }
 static struct kobj_attribute khugepaged_defrag_attr =
-	__ATTR(defrag, 0644, khugepaged_defrag_show,
-	       khugepaged_defrag_store);
+	__ATTR_RW(defrag);
 
 /*
  * max_ptes_none controls if khugepaged should collapse hugepages over
@@ -246,13 +242,13 @@ static struct kobj_attribute khugepaged_defrag_attr =
  * runs. Increasing max_ptes_none will instead potentially reduce the
  * free memory in the system during the khugepaged scan.
  */
-static ssize_t khugepaged_max_ptes_none_show(struct kobject *kobj,
+static ssize_t max_ptes_none_show(struct kobject *kobj,
 					     struct kobj_attribute *attr,
 					     char *buf)
 {
 	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_none);
 }
-static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
+static ssize_t max_ptes_none_store(struct kobject *kobj,
 					      struct kobj_attribute *attr,
 					      const char *buf, size_t count)
 {
@@ -268,17 +264,16 @@ static ssize_t khugepaged_max_ptes_none_store(struct kobject *kobj,
 	return count;
 }
 static struct kobj_attribute khugepaged_max_ptes_none_attr =
-	__ATTR(max_ptes_none, 0644, khugepaged_max_ptes_none_show,
-	       khugepaged_max_ptes_none_store);
+	__ATTR_RW(max_ptes_none);
 
-static ssize_t khugepaged_max_ptes_swap_show(struct kobject *kobj,
+static ssize_t max_ptes_swap_show(struct kobject *kobj,
 					     struct kobj_attribute *attr,
 					     char *buf)
 {
 	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_swap);
 }
 
-static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
+static ssize_t max_ptes_swap_store(struct kobject *kobj,
 					      struct kobj_attribute *attr,
 					      const char *buf, size_t count)
 {
@@ -295,17 +290,16 @@ static ssize_t khugepaged_max_ptes_swap_store(struct kobject *kobj,
 }
 
 static struct kobj_attribute khugepaged_max_ptes_swap_attr =
-	__ATTR(max_ptes_swap, 0644, khugepaged_max_ptes_swap_show,
-	       khugepaged_max_ptes_swap_store);
+	__ATTR_RW(max_ptes_swap);
 
-static ssize_t khugepaged_max_ptes_shared_show(struct kobject *kobj,
+static ssize_t max_ptes_shared_show(struct kobject *kobj,
 					       struct kobj_attribute *attr,
 					       char *buf)
 {
 	return sysfs_emit(buf, "%u\n", khugepaged_max_ptes_shared);
 }
 
-static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
+static ssize_t max_ptes_shared_store(struct kobject *kobj,
 					      struct kobj_attribute *attr,
 					      const char *buf, size_t count)
 {
@@ -322,8 +316,7 @@ static ssize_t khugepaged_max_ptes_shared_store(struct kobject *kobj,
 }
 
 static struct kobj_attribute khugepaged_max_ptes_shared_attr =
-	__ATTR(max_ptes_shared, 0644, khugepaged_max_ptes_shared_show,
-	       khugepaged_max_ptes_shared_store);
+	__ATTR_RW(max_ptes_shared);
 
 static struct attribute *khugepaged_attr[] = {
 	&khugepaged_defrag_attr.attr,
-- 
2.23.0

