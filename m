Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4D7FE5A36EB
	for <lists+linux-kernel@lfdr.de>; Sat, 27 Aug 2022 12:14:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234348AbiH0KMN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 27 Aug 2022 06:12:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48574 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235565AbiH0KMB (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 27 Aug 2022 06:12:01 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 344472714C
        for <linux-kernel@vger.kernel.org>; Sat, 27 Aug 2022 03:11:56 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.53])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4MFC7B0rL5zYcvD;
        Sat, 27 Aug 2022 18:07:34 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Sat, 27 Aug 2022 18:11:40 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Sat, 27 Aug
 2022 18:11:40 +0800
From:   Liu Shixin <liushixin2@huawei.com>
To:     Seth Jennings <sjenning@redhat.com>,
        Dan Streetman <ddstreet@ieee.org>,
        Vitaly Wool <vitaly.wool@konsulko.com>,
        Andrew Morton <akpm@linux-foundation.org>,
        Nathan Chancellor <nathan@kernel.org>,
        "Christoph Hellwig" <hch@lst.de>
CC:     <linux-mm@kvack.org>, <linux-kernel@vger.kernel.org>,
        Liu Shixin <liushixin2@huawei.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH -next v3 2/5] frontswap: invoke ops->init for online swap device in frontswap_register_ops
Date:   Sat, 27 Aug 2022 18:45:57 +0800
Message-ID: <20220827104600.1813214-3-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220827104600.1813214-1-liushixin2@huawei.com>
References: <20220827104600.1813214-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
 dggpemm100009.china.huawei.com (7.185.36.113)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Since we are supported to delay zswap initializaton, we need to invoke
ops->init for the swap device which is already online when register
backend.

This patch is a revert of f328c1d16e4c ("frontswap: simplify frontswap_register_ops")
and 633423a09cb5 ("mm: mark swap_lock and swap_active_head static")

Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 include/linux/swapfile.h |  2 ++
 mm/frontswap.c           | 47 ++++++++++++++++++++++++++++++++++++++++
 mm/swapfile.c            |  4 ++--
 3 files changed, 51 insertions(+), 2 deletions(-)

diff --git a/include/linux/swapfile.h b/include/linux/swapfile.h
index 2fbcc9afd814..75fc069594a5 100644
--- a/include/linux/swapfile.h
+++ b/include/linux/swapfile.h
@@ -6,6 +6,8 @@
  * these were static in swapfile.c but frontswap.c needs them and we don't
  * want to expose them to the dozens of source files that include swap.h
  */
+extern spinlock_t swap_lock;
+extern struct plist_head swap_active_head;
 extern struct swap_info_struct *swap_info[];
 extern unsigned long generic_max_swapfile_size(void);
 /* Maximum swapfile size supported for the arch (not inclusive). */
diff --git a/mm/frontswap.c b/mm/frontswap.c
index 620f95af81dd..449e6f499b88 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -96,11 +96,58 @@ static inline void inc_frontswap_invalidates(void) { }
  */
 int frontswap_register_ops(const struct frontswap_ops *ops)
 {
+	DECLARE_BITMAP(a, MAX_SWAPFILES);
+	DECLARE_BITMAP(b, MAX_SWAPFILES);
+	struct swap_info_struct *si;
+	unsigned int i;
+
 	if (frontswap_ops)
 		return -EINVAL;
 
+	bitmap_zero(a, MAX_SWAPFILES);
+	bitmap_zero(b, MAX_SWAPFILES);
+
+	spin_lock(&swap_lock);
+	plist_for_each_entry(si, &swap_active_head, list) {
+		if (!WARN_ON(!si->frontswap_map))
+			__set_bit(si->type, a);
+	}
+	spin_unlock(&swap_lock);
+
+	/* the new ops needs to know the currently active swap devices */
+	for_each_set_bit(i, a, MAX_SWAPFILES) {
+		pr_err("init frontswap_ops\n");
+		ops->init(i);
+	}
+
 	frontswap_ops = ops;
 	static_branch_inc(&frontswap_enabled_key);
+
+	spin_lock(&swap_lock);
+	plist_for_each_entry(si, &swap_active_head, list) {
+		if (si->frontswap_map)
+			__set_bit(si->type, b);
+	}
+	spin_unlock(&swap_lock);
+
+	/*
+	 * On the very unlikely chance that a swap device was added or
+	 * removed between setting the "a" list bits and the ops init
+	 * calls, we re-check and do init or invalidate for any changed
+	 * bits.
+	 */
+	if (unlikely(!bitmap_equal(a, b, MAX_SWAPFILES))) {
+		for (i = 0; i < MAX_SWAPFILES; i++) {
+			if (!test_bit(i, a) && test_bit(i, b)) {
+				pr_err("init frontswap_ops re\n");
+				ops->init(i);
+			} else if (test_bit(i, a) && !test_bit(i, b)) {
+				pr_err("inval frontswap_ops re\n");
+				ops->invalidate_area(i);
+			}
+		}
+	}
+
 	return 0;
 }
 
diff --git a/mm/swapfile.c b/mm/swapfile.c
index 469d9af86be2..d383b282f269 100644
--- a/mm/swapfile.c
+++ b/mm/swapfile.c
@@ -51,7 +51,7 @@ static bool swap_count_continued(struct swap_info_struct *, pgoff_t,
 				 unsigned char);
 static void free_swap_count_continuations(struct swap_info_struct *);
 
-static DEFINE_SPINLOCK(swap_lock);
+DEFINE_SPINLOCK(swap_lock);
 static unsigned int nr_swapfiles;
 atomic_long_t nr_swap_pages;
 /*
@@ -77,7 +77,7 @@ static const char Unused_offset[] = "Unused swap offset entry ";
  * all active swap_info_structs
  * protected with swap_lock, and ordered by priority.
  */
-static PLIST_HEAD(swap_active_head);
+PLIST_HEAD(swap_active_head);
 
 /*
  * all available (active, not full) swap_info_structs
-- 
2.25.1

