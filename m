Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4097A55E491
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:26 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240382AbiF1Nay (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:30:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57676 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345357AbiF1N35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:29:57 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6DB2E2A96D
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:28:44 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LXQNL5N8BzdZcX;
        Tue, 28 Jun 2022 21:26:26 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 21:28:41 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 08/16] mm/huge_memory: use helper macro __ATTR_RW
Date:   Tue, 28 Jun 2022 21:28:27 +0800
Message-ID: <20220628132835.8925-9-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220628132835.8925-1-linmiaohe@huawei.com>
References: <20220628132835.8925-1-linmiaohe@huawei.com>
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

Use helper macro __ATTR_RW to define use_zero_page_attr, defrag_attr and
enabled_attr to make code more clear. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/huge_memory.c | 10 ++++------
 1 file changed, 4 insertions(+), 6 deletions(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index 1cb51eb5a60c..7570e7681f95 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -276,8 +276,8 @@ static ssize_t enabled_store(struct kobject *kobj,
 	}
 	return ret;
 }
-static struct kobj_attribute enabled_attr =
-	__ATTR(enabled, 0644, enabled_show, enabled_store);
+
+static struct kobj_attribute enabled_attr = __ATTR_RW(enabled);
 
 ssize_t single_hugepage_flag_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf,
@@ -366,8 +366,7 @@ static ssize_t defrag_store(struct kobject *kobj,
 
 	return count;
 }
-static struct kobj_attribute defrag_attr =
-	__ATTR(defrag, 0644, defrag_show, defrag_store);
+static struct kobj_attribute defrag_attr = __ATTR_RW(defrag);
 
 static ssize_t use_zero_page_show(struct kobject *kobj,
 				  struct kobj_attribute *attr, char *buf)
@@ -381,8 +380,7 @@ static ssize_t use_zero_page_store(struct kobject *kobj,
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

