Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7D58F5551EC
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 19:07:14 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1377051AbiFVRGv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 13:06:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42320 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1376941AbiFVRGf (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 13:06:35 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E9A23EF0B
        for <linux-kernel@vger.kernel.org>; Wed, 22 Jun 2022 10:06:33 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LSqWf3RNkzkWdH;
        Thu, 23 Jun 2022 01:05:18 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 23 Jun
 2022 01:06:30 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH 08/16] mm/huge_memory: use helper macro __ATTR_RW
Date:   Thu, 23 Jun 2022 01:06:19 +0800
Message-ID: <20220622170627.19786-9-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220622170627.19786-1-linmiaohe@huawei.com>
References: <20220622170627.19786-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

Use helper macro __ATTR_RW to define use_zero_page_attr, defrag_attr and
enabled_attr to make code more clear. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 7cfa003b1789..b42c8fa51e46 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -273,8 +273,8 @@ static ssize_t enabled_store(struct kobject *kobj,
 	}
 	return ret;
 }
-static struct kobj_attribute enabled_attr =
-	__ATTR(enabled, 0644, enabled_show, enabled_store);
+
+static struct kobj_attribute enabled_attr = __ATTR_RW(enabled);
 
 ssize_t single_hugepage_flag_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf,
@@ -363,8 +363,7 @@ static ssize_t defrag_store(struct kobject *kobj,
 
 	return count;
 }
-static struct kobj_attribute defrag_attr =
-	__ATTR(defrag, 0644, defrag_show, defrag_store);
+static struct kobj_attribute defrag_attr = __ATTR_RW(defrag);
 
 static ssize_t use_zero_page_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
@@ -378,8 +377,7 @@ static ssize_t use_zero_page_store(struct kobject *kobj,
 	return single_hugepage_flag_store(kobj, attr, buf, count,
 				 TRANSPARENT_HUGEPAGE_USE_ZERO_PAGE_FLAG);
 }
-static struct kobj_attribute use_zero_page_attr =
-	__ATTR(use_zero_page, 0644, use_zero_page_show, use_zero_page_store);
+static struct kobj_attribute use_zero_page_attr = __ATTR_RW(use_zero_page);
 
 static ssize_t hpage_pmd_size_show(struct kobject *kobj,
 				   struct kobj_attribute *attr, char *buf)
-- 
2.23.0

