Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 88EA151FDD7
	for <lists+linux-kernel@lfdr.de>; Mon,  9 May 2022 15:15:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235499AbiEINTE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 9 May 2022 09:19:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42408 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235327AbiEINSH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 9 May 2022 09:18:07 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id DAD8B2A9740
        for <linux-kernel@vger.kernel.org>; Mon,  9 May 2022 06:14:13 -0700 (PDT)
Received: from canpemm500002.china.huawei.com (unknown [172.30.72.55])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4KxhSn52LjzhZ1P;
        Mon,  9 May 2022 21:13:45 +0800 (CST)
Received: from huawei.com (10.175.124.27) by canpemm500002.china.huawei.com
 (7.192.104.244) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 9 May
 2022 21:14:06 +0800
From:   Miaohe Lin <linmiaohe@huawei.com>
To:     <akpm@linux-foundation.org>
CC:     <willy@infradead.org>, <vbabka@suse.cz>, <dhowells@redhat.com>,
        <neilb@suse.de>, <apopple@nvidia.com>, <david@redhat.com>,
        <surenb@google.com>, <peterx@redhat.com>,
        <naoya.horiguchi@nec.com>, <linux-mm@kvack.org>,
        <linux-kernel@vger.kernel.org>, <linmiaohe@huawei.com>
Subject: [PATCH 11/15] mm/swap: add helper swap_offset_available()
Date:   Mon, 9 May 2022 21:14:12 +0800
Message-ID: <20220509131416.17553-12-linmiaohe@huawei.com>
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

Add helper swap_offset_available() to remove some duplicated codes.
Minor readability improvement.

Signed-off-by: Miaohe Lin <linmiaohe@huawei.com>
---
 mm/swapfile.c | 33 +++++++++++++++++----------------
 1 file changed, 17 insertions(+), 16 deletions(-)

diff --git a/mm/swapfile.c b/mm/swapfile.c
index c90298a0561a..d5d3e2d03d28 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -776,6 +776,21 @@ static void set_cluster_next(struct swap_info_struct *si, unsigned long next)
 	this_cpu_write(*si->cluster_next_cpu, next);
 }
 
+static inline bool swap_offset_available(struct swap_info_struct *si, unsigned long offset)
+{
+	if (data_race(!si->swap_map[offset])) {
+		spin_lock(&si->lock);
+		return true;
+	}
+
+	if (vm_swap_full() && READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
+		spin_lock(&si->lock);
+		return true;
+	}
+
+	return false;
+}
+
 static int scan_swap_map_slots(struct swap_info_struct *si,
 			       unsigned char usage, int nr,
 			       swp_entry_t slots[])
@@ -953,15 +968,8 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 scan:
 	spin_unlock(&si->lock);
 	while (++offset <= READ_ONCE(si->highest_bit)) {
-		if (data_race(!si->swap_map[offset])) {
-			spin_lock(&si->lock);
+		if (swap_offset_available(si, offset))
 			goto checks;
-		}
-		if (vm_swap_full() &&
-		    READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
-			spin_lock(&si->lock);
-			goto checks;
-		}
 		if (unlikely(--latency_ration < 0)) {
 			cond_resched();
 			latency_ration = LATENCY_LIMIT;
@@ -970,15 +978,8 @@ static int scan_swap_map_slots(struct swap_info_struct *si,
 	}
 	offset = si->lowest_bit;
 	while (offset < scan_base) {
-		if (data_race(!si->swap_map[offset])) {
-			spin_lock(&si->lock);
+		if (swap_offset_available(si, offset))
 			goto checks;
-		}
-		if (vm_swap_full() &&
-		    READ_ONCE(si->swap_map[offset]) == SWAP_HAS_CACHE) {
-			spin_lock(&si->lock);
-			goto checks;
-		}
 		if (unlikely(--latency_ration < 0)) {
 			cond_resched();
 			latency_ration = LATENCY_LIMIT;
-- 
2.23.0

