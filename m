Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 8D61655E495
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:39:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1343851AbiF1NbG (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 09:31:06 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:57784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345912AbiF1N35 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 09:29:57 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C15D62AE12
        for <linux-kernel@vger.kernel.org>; Tue, 28 Jun 2022 06:28:46 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.54])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4LXQQD4qlWz9skG;
        Tue, 28 Jun 2022 21:28:04 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Tue, 28 Jun
 2022 21:28:43 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <willy@infradead.org>, <zokeefe@google.com>,
        <songmuchun@bytedance.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 12/16] mm/huge_memory: minor cleanup for split_huge_pages_all
Date:   Tue, 28 Jun 2022 21:28:31 +0800
Message-ID: <20220628132835.8925-13-linmiaohe@huawei.com>
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

There is nothing to do if a zone doesn't have any pages managed by the
buddy allocator. So we should check managed_zone instead. Also if a thp
is found, there's no need to traverse the subpages again.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/huge_memory.c | 7 ++++++-
 1 file changed, 6 insertions(+), 1 deletion(-)

diff --git a/mm/huge_memory.c b/mm/huge_memory.c
index bded58ada414..5ea932beef22 100644
--- a/mm/huge_memory.c
+++ b/mm/huge_memory.c
@@ -2956,9 +2956,12 @@ static void split_huge_pages_all(void)
 	unsigned long total = 0, split = 0;
 
 	pr_debug("Split all THPs\n");
-	for_each_populated_zone(zone) {
+	for_each_zone(zone) {
+		if (!managed_zone(zone))
+			continue;
 		max_zone_pfn = zone_end_pfn(zone);
 		for (pfn = zone->zone_start_pfn; pfn < max_zone_pfn; pfn++) {
+			int nr_pages;
 			if (!pfn_valid(pfn))
 				continue;
 
@@ -2974,8 +2977,10 @@ static void split_huge_pages_all(void)
 
 			total++;
 			lock_page(page);
+			nr_pages = thp_nr_pages(page);
 			if (!split_huge_page(page))
 				split++;
+			pfn += nr_pages - 1;
 			unlock_page(page);
 next:
 			put_page(page);
-- 
2.23.0

