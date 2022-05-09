Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 11A0751FDCF
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:15:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235343AbiEINSJ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:18:09 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41690 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235321AbiEINSD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:18:03 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 421352A805C
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:14:08 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.56])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4KxhSS5m4xzhZ2P;
        Mon,  9 May 2022 21:13:28 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 21:14:00 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 03/15] mm/swap: fold __swap_info_get() into its sole caller
Date:   Mon, 9 May 2022 21:14:04 +0800
Message-ID: <20220509131416.17553-4-linmiaohe@huawei.com>
X-Mailer: git-send-email 2.23.0
In-Reply-To: <20220509131416.17553-1-linmiaohe@huawei.com>
References: <20220509131416.17553-1-linmiaohe@huawei.com>
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

Fold __swap_info_get() into its sole caller to make code more clear.
Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swapfile.c | 24 ++++++------------------
 1 file changed, 6 insertions(+), 18 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index 05ca79e68d63..0aee6286d6a7 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -1123,7 +1123,7 @@ int get_swap_pages(int n_goal, swp_entry_t swp_entries[], int entry_size)
 	return n_ret;
 }
 
-static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
+static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
 {
 	struct swap_info_struct *p;
 	unsigned long offset;
@@ -1138,8 +1138,13 @@ static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
 	offset = swp_offset(entry);
 	if (offset >= p->max)
 		goto bad_offset;
+	if (data_race(!p->swap_map[swp_offset(entry)]))
+		goto bad_free;
 	return p;
 
+bad_free:
+	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
+	goto out;
 bad_offset:
 	pr_err("%s: %s%08lx\n", __func__, Bad_offset, entry.val);
 	goto out;
@@ -1152,23 +1157,6 @@ static struct swap_info_struct *__swap_info_get(swp_entry_t entry)
 	return NULL;
 }
 
-static struct swap_info_struct *_swap_info_get(swp_entry_t entry)
-{
-	struct swap_info_struct *p;
-
-	p = __swap_info_get(entry);
-	if (!p)
-		goto out;
-	if (data_race(!p->swap_map[swp_offset(entry)]))
-		goto bad_free;
-	return p;
-
-bad_free:
-	pr_err("%s: %s%08lx\n", __func__, Unused_offset, entry.val);
-out:
-	return NULL;
-}
-
 static struct swap_info_struct *swap_info_get_cont(swp_entry_t entry,
 					struct swap_info_struct *q)
 {
-- 
2.23.0

