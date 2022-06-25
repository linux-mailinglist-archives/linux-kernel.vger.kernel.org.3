Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 3F00155A872
	for <lists+linux-kernel@lfdr.de>; Sat, 25 Jun 2022 11:34:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232554AbiFYJ2e (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 25 Jun 2022 05:28:34 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59724 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232515AbiFYJ2Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 25 Jun 2022 05:28:24 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D17B9DEBF
        for <linux-kernel@vger.kernel.org>; Sat, 25 Jun 2022 02:28:23 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.53])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LVTCY3TJdzkWZJ;
        Sat, 25 Jun 2022 17:27:05 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 25 Jun
 2022 17:28:20 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <shy828301@gmail.com>, <zokeefe@google.com>, <aarcange@redhat.com>,
        <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH v2 4/7] mm/khugepaged: minor cleanup for collapse_file
Date:   Sat, 25 Jun 2022 17:28:13 +0800
Message-ID: <20220625092816.4856-5-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220625092816.4856-1-linmiaohe@huawei.com>
References: <20220625092816.4856-1-linmiaohe@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.124.27]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

nr_none is always 0 for non-shmem case because the page can be read from
the backend store. So when nr_none ! = 0, it must be in is_shmem case.
Also only adjust the nrpages and uncharge shmem when nr_none != 0 to save
cpu cycles.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
Reviewed-by: Zach O'Keefe <zokeefe@google.com>
---
 mm/khugepaged.c | 10 +++++-----
 1 file changed, 5 insertions(+), 5 deletions(-)

diff --git a/mm/khugepaged.c b/mm/khugepaged.c
index a36d9746c321..47514f2fabb9 100644
--- a/mm/khugepaged.c
+++ b/mm/khugepaged.c
@@ -1852,8 +1852,8 @@ static void collapse_file(struct mm_struct *mm,
 
 	if (nr_none) {
 		__mod_lruvec_page_state(new_page, NR_FILE_PAGES, nr_none);
-		if (is_shmem)
-			__mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
+		/* nr_none is always 0 for non-shmem. */
+		__mod_lruvec_page_state(new_page, NR_SHMEM, nr_none);
 	}
 
 	/* Join all the small entries into a single multi-index entry */
@@ -1917,10 +1917,10 @@ static void collapse_file(struct mm_struct *mm,
 
 		/* Something went wrong: roll back page cache changes */
 		xas_lock_irq(&xas);
-		mapping->nrpages -= nr_none;
-
-		if (is_shmem)
+		if (nr_none) {
+			mapping->nrpages -= nr_none;
 			shmem_uncharge(mapping->host, nr_none);
+		}
 
 		xas_set(&xas, start);
 		xas_for_each(&xas, page, end - 1) {
-- 
2.23.0

