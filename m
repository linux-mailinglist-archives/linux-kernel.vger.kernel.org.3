Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E152583E8D
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 14:20:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236053AbiG1MUi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 28 Jul 2022 08:20:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56284 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236445AbiG1MUJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 28 Jul 2022 08:20:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2CF9AE74
        for <linux-kernel@vger.kernel.org>; Thu, 28 Jul 2022 05:20:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LtqSZ6Bncz9sv0;
        Thu, 28 Jul 2022 20:18:54 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 28 Jul
 2022 20:20:05 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <almasrymina@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 4/6] hugetlb_cgroup: remove unneeded return value
Date:   Thu, 28 Jul 2022 20:19:47 +0800
Message-ID: <20220728121949.20985-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220728121949.20985-1-linmiaohe@huawei.com>
References: <20220728121949.20985-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems703-chm.china.huawei.com (10.3.19.180) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The return value of set_hugetlb_cgroup and set_hugetlb_cgroup_rsvd are
always ignored. Remove them to clean up the code.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 include/linux/hugetlb_cgroup.h | 19 ++++++++-----------
 1 file changed, 8 insertions(+), 11 deletions(-)

diff --git a/include/linux/hugetlb_cgroup.h b/include/linux/hugetlb_cgroup.h
index 379344828e78..630cd255d0cf 100644
--- a/include/linux/hugetlb_cgroup.h
+++ b/include/linux/hugetlb_cgroup.h
@@ -90,32 +90,31 @@ hugetlb_cgroup_from_page_rsvd(struct page *page)
 	return __hugetlb_cgroup_from_page(page, true);
 }
 
-static inline int __set_hugetlb_cgroup(struct page *page,
+static inline void __set_hugetlb_cgroup(struct page *page,
 				       struct hugetlb_cgroup *h_cg, bool rsvd)
 {
 	VM_BUG_ON_PAGE(!PageHuge(page), page);
 
 	if (compound_order(page) < HUGETLB_CGROUP_MIN_ORDER)
-		return -1;
+		return;
 	if (rsvd)
 		set_page_private(page + SUBPAGE_INDEX_CGROUP_RSVD,
 				 (unsigned long)h_cg);
 	else
 		set_page_private(page + SUBPAGE_INDEX_CGROUP,
 				 (unsigned long)h_cg);
-	return 0;
 }
 
-static inline int set_hugetlb_cgroup(struct page *page,
+static inline void set_hugetlb_cgroup(struct page *page,
 				     struct hugetlb_cgroup *h_cg)
 {
-	return __set_hugetlb_cgroup(page, h_cg, false);
+	__set_hugetlb_cgroup(page, h_cg, false);
 }
 
-static inline int set_hugetlb_cgroup_rsvd(struct page *page,
+static inline void set_hugetlb_cgroup_rsvd(struct page *page,
 					  struct hugetlb_cgroup *h_cg)
 {
-	return __set_hugetlb_cgroup(page, h_cg, true);
+	__set_hugetlb_cgroup(page, h_cg, true);
 }
 
 static inline bool hugetlb_cgroup_disabled(void)
@@ -199,16 +198,14 @@ hugetlb_cgroup_from_page_rsvd(struct page *page)
 	return NULL;
 }
 
-static inline int set_hugetlb_cgroup(struct page *page,
+static inline void set_hugetlb_cgroup(struct page *page,
 				     struct hugetlb_cgroup *h_cg)
 {
-	return 0;
 }
 
-static inline int set_hugetlb_cgroup_rsvd(struct page *page,
+static inline void set_hugetlb_cgroup_rsvd(struct page *page,
 					  struct hugetlb_cgroup *h_cg)
 {
-	return 0;
 }
 
 static inline bool hugetlb_cgroup_disabled(void)
-- 
2.23.0

