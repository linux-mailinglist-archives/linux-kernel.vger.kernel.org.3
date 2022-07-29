Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80558584D13
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Jul 2022 10:02:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235234AbiG2IBx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Jul 2022 04:01:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42624 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235290AbiG2IBd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Jul 2022 04:01:33 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35AAE33344
        for <linux-kernel@vger.kernel.org>; Fri, 29 Jul 2022 01:01:31 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4LvKcR5KSkzWfh3;
        Fri, 29 Jul 2022 15:57:27 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Fri, 29 Jul
 2022 16:01:23 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <mike.kravetz@oracle.com>, <almasrymina@google.com>,
        <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        <linmiaohe@huawei.com>
Subject: [PATCH v2 5/5] hugetlb_cgroup: use helper for_each_hstate and hstate_index
Date:   Fri, 29 Jul 2022 16:01:06 +0800
Message-ID: <20220729080106.12752-6-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220729080106.12752-1-linmiaohe@huawei.com>
References: <20220729080106.12752-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
 canpemm500002.china.huawei.com (7.192.104.244)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Use helper for_each_hstate and hstate_index to iterate the hstate and get
the hstate index. Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Mina Almasry <almasrymina@google.com>
---
 mm/hugetlb_cgroup.c | 11 ++++-------
 1 file changed, 4 insertions(+), 7 deletions(-)

diff --git a/mm/hugetlb_cgroup.c b/mm/hugetlb_cgroup.c
index 2affccfe59f1..f61d132df52b 100644
--- a/mm/hugetlb_cgroup.c
+++ b/mm/hugetlb_cgroup.c
@@ -75,11 +75,11 @@ parent_hugetlb_cgroup(struct hugetlb_cgroup *h_cg)
 
 static inline bool hugetlb_cgroup_have_usage(struct hugetlb_cgroup *h_cg)
 {
-	int idx;
+	struct hstate *h;
 
-	for (idx = 0; idx < hugetlb_max_hstate; idx++) {
+	for_each_hstate(h) {
 		if (page_counter_read(
-				hugetlb_cgroup_counter_from_cgroup(h_cg, idx)))
+		    hugetlb_cgroup_counter_from_cgroup(h_cg, hstate_index(h))))
 			return true;
 	}
 	return false;
@@ -225,17 +225,14 @@ static void hugetlb_cgroup_css_offline(struct cgroup_subsys_state *css)
 	struct hugetlb_cgroup *h_cg = hugetlb_cgroup_from_css(css);
 	struct hstate *h;
 	struct page *page;
-	int idx;
 
 	do {
-		idx = 0;
 		for_each_hstate(h) {
 			spin_lock_irq(&hugetlb_lock);
 			list_for_each_entry(page, &h->hugepage_activelist, lru)
-				hugetlb_cgroup_move_parent(idx, h_cg, page);
+				hugetlb_cgroup_move_parent(hstate_index(h), h_cg, page);
 
 			spin_unlock_irq(&hugetlb_lock);
-			idx++;
 		}
 		cond_resched();
 	} while (hugetlb_cgroup_have_usage(h_cg));
-- 
2.23.0

