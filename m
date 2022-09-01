Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65AEF5A962D
	for <lists+linux-kernel@lfdr.de>; Thu,  1 Sep 2022 14:01:53 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233209AbiIAMBm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 1 Sep 2022 08:01:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53582 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232415AbiIAMBH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 1 Sep 2022 08:01:07 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 0F91914D38
        for <linux-kernel@vger.kernel.org>; Thu,  1 Sep 2022 05:01:06 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MJKKt0LyrzlWdW;
        Thu,  1 Sep 2022 19:57:38 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Thu, 1 Sep
 2022 20:01:03 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>, <mike.kravetz@oracle.com>,
        <songmuchun@bytedance.com>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 06/10] hugetlb: pass NULL to kobj_to_hstate() if nid is unused
Date:   Thu, 1 Sep 2022 20:00:26 +0800
Message-ID: <20220901120030.63318-7-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220901120030.63318-1-linmiaohe@huawei.com>
References: <20220901120030.63318-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
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

We can pass NULL to kobj_to_hstate() directly when nid is unused to
simplify the code. No functional change intended.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Muchun Song <songmuchun@bytedance.com>
---
 mm/hugetlb.c | 6 ++----
 1 file changed, 2 insertions(+), 4 deletions(-)

diff --git a/mm/hugetlb.c b/mm/hugetlb.c
index d35381de90c3..bb65b7fdca25 100644
--- a/mm/hugetlb.c
+++ b/mm/hugetlb.c
@@ -3779,8 +3779,7 @@ HSTATE_ATTR_WO(demote);
 static ssize_t demote_size_show(struct kobject *kobj,
 					struct kobj_attribute *attr, char *buf)
 {
-	int nid;
-	struct hstate *h = kobj_to_hstate(kobj, &nid);
+	struct hstate *h = kobj_to_hstate(kobj, NULL);
 	unsigned long demote_size = (PAGE_SIZE << h->demote_order) / SZ_1K;
 
 	return sysfs_emit(buf, "%lukB\n", demote_size);
@@ -3793,7 +3792,6 @@ static ssize_t demote_size_store(struct kobject *kobj,
 	struct hstate *h, *demote_hstate;
 	unsigned long demote_size;
 	unsigned int demote_order;
-	int nid;
 
 	demote_size = (unsigned long)memparse(buf, NULL);
 
@@ -3805,7 +3803,7 @@ static ssize_t demote_size_store(struct kobject *kobj,
 		return -EINVAL;
 
 	/* demote order must be smaller than hstate order */
-	h = kobj_to_hstate(kobj, &nid);
+	h = kobj_to_hstate(kobj, NULL);
 	if (demote_order >= h->order)
 		return -EINVAL;
 
-- 
2.23.0

