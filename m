Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25D5F5A4CBC
	for <lists+linux-kernel@lfdr.de>; Mon, 29 Aug 2022 14:58:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S230517AbiH2M6P (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 29 Aug 2022 08:58:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54810 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230344AbiH2M4h (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 29 Aug 2022 08:56:37 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 51ED515816
        for <linux-kernel@vger.kernel.org>; Mon, 29 Aug 2022 05:48:37 -0700 (PDT)
Received: from dggpemm500022.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4MGVZ06szGzHnVy;
        Mon, 29 Aug 2022 20:46:48 +0800 (CST)
Received: from dggpemm100009.china.huawei.com (7.185.36.113) by
 dggpemm500022.china.huawei.com (7.185.36.162) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 29 Aug 2022 20:48:34 +0800
Received: from huawei.com (10.175.113.32) by dggpemm100009.china.huawei.com
 (7.185.36.113) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id 15.1.2375.24; Mon, 29 Aug
 2022 20:48:33 +0800
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
Subject: [PATCH -next v4 1/6] Revert "frontswap: remove support for multiple ops"
Date:   Mon, 29 Aug 2022 21:22:57 +0800
Message-ID: <20220829132302.3367054-2-liushixin2@huawei.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220829132302.3367054-1-liushixin2@huawei.com>
References: <20220829132302.3367054-1-liushixin2@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.32]
X-ClientProxiedBy: dggems702-chm.china.huawei.com (10.3.19.179) To
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

This reverts commit 1da0d94a3ec8c5f3793b7be8538b55e60ebeefe3.

If zswap initial failed or has not been initial, frontswap_ops will be
NULL. In such situation, swap device would enable failed with following
stack trace:

  Unable to handle kernel access to user memory outside uaccess routines at virtual address 0000000000000000
  Mem abort info:
    ESR = 0x0000000096000004
    EC = 0x25: DABT (current EL), IL = 32 bits
    SET = 0, FnV = 0
    EA = 0, S1PTW = 0
    FSC = 0x04: level 0 translation fault
  Data abort info:
    ISV = 0, ISS = 0x00000004
    CM = 0, WnR = 0
  user pgtable: 4k pages, 48-bit VAs, pgdp=00000020a4fab000
  [0000000000000000] pgd=0000000000000000, p4d=0000000000000000
  Internal error: Oops: 96000004 [#1] SMP
  Modules linked in: zram fsl_dpaa2_eth pcs_lynx phylink ahci_qoriq crct10dif_ce ghash_ce sbsa_gwdt fsl_mc_dpio nvme lm90 nvme_core at803x xhci_plat_hcd rtc_fsl_ftm_alarm xgmac_mdio ahci_platform i2c_imx ip6_tables ip_tables fuse
  Unloaded tainted modules: cppc_cpufreq():1
  CPU: 10 PID: 761 Comm: swapon Not tainted 6.0.0-rc2-00454-g22100432cf14 #1
  Hardware name: SolidRun Ltd. SolidRun CEX7 Platform, BIOS EDK II Jun 21 2022
  pstate: 00400005 (nzcv daif +PAN -UAO -TCO -DIT -SSBS BTYPE=--)
  pc : frontswap_init+0x38/0x60
  lr : __do_sys_swapon+0x8a8/0x9f4
  sp : ffff80000969bcf0
  x29: ffff80000969bcf0 x28: ffff37bee0d8fc00 x27: ffff80000a7f5000
  x26: fffffcdefb971e80 x25: ffffaba797453b90 x24: 0000000000000064
  x23: ffff37c1f209d1a8 x22: ffff37bee880e000 x21: ffffaba797748560
  x20: ffff37bee0d8fce4 x19: ffffaba797748488 x18: 0000000000000014
  x17: 0000000030ec029a x16: ffffaba795a479b0 x15: 0000000000000000
  x14: 0000000000000000 x13: 0000000000000030 x12: 0000000000000001
  x11: ffff37c63c0aba18 x10: 0000000000000000 x9 : ffffaba7956b8c88
  x8 : ffff80000969bcd0 x7 : 0000000000000000 x6 : 0000000000000000
  x5 : 0000000000000001 x4 : 0000000000000000 x3 : ffffaba79730f000
  x2 : ffff37bee0d8fc00 x1 : 0000000000000000 x0 : 0000000000000000
  Call trace:
  frontswap_init+0x38/0x60
  __do_sys_swapon+0x8a8/0x9f4
  __arm64_sys_swapon+0x28/0x3c
  invoke_syscall+0x78/0x100
  el0_svc_common.constprop.0+0xd4/0xf4
  do_el0_svc+0x38/0x4c
  el0_svc+0x34/0x10c
  el0t_64_sync_handler+0x11c/0x150
  el0t_64_sync+0x190/0x194
  Code: d000e283 910003fd f9006c41 f946d461 (f9400021)
  ---[ end trace 0000000000000000 ]---

Reported-by: Nathan Chancellor <nathan@kernel.org>
Signed-off-by: Liu Shixin <liushixin2@huawei.com>
---
 include/linux/frontswap.h |  3 ++-
 mm/frontswap.c            | 50 +++++++++++++++++++++++++++++----------
 mm/zswap.c                |  8 ++-----
 3 files changed, 42 insertions(+), 19 deletions(-)

diff --git a/include/linux/frontswap.h b/include/linux/frontswap.h
index a631bac12220..c5b2848d2240 100644
--- a/include/linux/frontswap.h
+++ b/include/linux/frontswap.h
@@ -13,9 +13,10 @@ struct frontswap_ops {
 	int (*load)(unsigned, pgoff_t, struct page *); /* load a page */
 	void (*invalidate_page)(unsigned, pgoff_t); /* page no longer needed */
 	void (*invalidate_area)(unsigned); /* swap type just swapoff'ed */
+	struct frontswap_ops *next; /* private pointer to next ops */
 };
 
-int frontswap_register_ops(const struct frontswap_ops *ops);
+extern void frontswap_register_ops(struct frontswap_ops *ops);
 
 extern void frontswap_init(unsigned type, unsigned long *map);
 extern int __frontswap_store(struct page *page);
diff --git a/mm/frontswap.c b/mm/frontswap.c
index 1a97610308cb..8d644f56a1d2 100644
--- a/mm/frontswap.c
+++ b/mm/frontswap.c
@@ -27,7 +27,10 @@ DEFINE_STATIC_KEY_FALSE(frontswap_enabled_key);
  * may be registered, but implementations can never deregister.  This
  * is a simple singly-linked list of all registered implementations.
  */
-static const struct frontswap_ops *frontswap_ops __read_mostly;
+static struct frontswap_ops *frontswap_ops __read_mostly;
+
+#define for_each_frontswap_ops(ops)		\
+	for ((ops) = frontswap_ops; (ops); (ops) = (ops)->next)
 
 #ifdef CONFIG_DEBUG_FS
 /*
@@ -94,14 +97,18 @@ static inline void inc_frontswap_invalidates(void) { }
 /*
  * Register operations for frontswap
  */
-int frontswap_register_ops(const struct frontswap_ops *ops)
+void frontswap_register_ops(struct frontswap_ops *ops)
 {
-	if (frontswap_ops)
-		return -EINVAL;
+	/*
+	 * Setting frontswap_ops must happen after the ops->init() calls
+	 * above; cmpxchg implies smp_mb() which will ensure the init is
+	 * complete at this point.
+	 */
+	do {
+		ops->next = frontswap_ops;
+	} while (cmpxchg(&frontswap_ops, ops->next, ops) != ops->next);
 
-	frontswap_ops = ops;
 	static_branch_inc(&frontswap_enabled_key);
-	return 0;
 }
 
 /*
@@ -110,6 +117,7 @@ int frontswap_register_ops(const struct frontswap_ops *ops)
 void frontswap_init(unsigned type, unsigned long *map)
 {
 	struct swap_info_struct *sis = swap_info[type];
+	struct frontswap_ops *ops;
 
 	VM_BUG_ON(sis == NULL);
 
@@ -125,7 +133,9 @@ void frontswap_init(unsigned type, unsigned long *map)
 	 * p->frontswap set to something valid to work properly.
 	 */
 	frontswap_map_set(sis, map);
-	frontswap_ops->init(type);
+
+	for_each_frontswap_ops(ops)
+		ops->init(type);
 }
 
 static bool __frontswap_test(struct swap_info_struct *sis,
@@ -164,6 +174,7 @@ int __frontswap_store(struct page *page)
 	int type = swp_type(entry);
 	struct swap_info_struct *sis = swap_info[type];
 	pgoff_t offset = swp_offset(entry);
+	struct frontswap_ops *ops;
 
 	VM_BUG_ON(!frontswap_ops);
 	VM_BUG_ON(!PageLocked(page));
@@ -177,10 +188,16 @@ int __frontswap_store(struct page *page)
 	 */
 	if (__frontswap_test(sis, offset)) {
 		__frontswap_clear(sis, offset);
-		frontswap_ops->invalidate_page(type, offset);
+		for_each_frontswap_ops(ops)
+			ops->invalidate_page(type, offset);
 	}
 
-	ret = frontswap_ops->store(type, offset, page);
+	/* Try to store in each implementation, until one succeeds. */
+	for_each_frontswap_ops(ops) {
+		ret = ops->store(type, offset, page);
+		if (!ret) /* successful store */
+			break;
+	}
 	if (ret == 0) {
 		__frontswap_set(sis, offset);
 		inc_frontswap_succ_stores();
@@ -203,6 +220,7 @@ int __frontswap_load(struct page *page)
 	int type = swp_type(entry);
 	struct swap_info_struct *sis = swap_info[type];
 	pgoff_t offset = swp_offset(entry);
+	struct frontswap_ops *ops;
 
 	VM_BUG_ON(!frontswap_ops);
 	VM_BUG_ON(!PageLocked(page));
@@ -212,7 +230,11 @@ int __frontswap_load(struct page *page)
 		return -1;
 
 	/* Try loading from each implementation, until one succeeds. */
-	ret = frontswap_ops->load(type, offset, page);
+	for_each_frontswap_ops(ops) {
+		ret = ops->load(type, offset, page);
+		if (!ret) /* successful load */
+			break;
+	}
 	if (ret == 0)
 		inc_frontswap_loads();
 	return ret;
@@ -225,6 +247,7 @@ int __frontswap_load(struct page *page)
 void __frontswap_invalidate_page(unsigned type, pgoff_t offset)
 {
 	struct swap_info_struct *sis = swap_info[type];
+	struct frontswap_ops *ops;
 
 	VM_BUG_ON(!frontswap_ops);
 	VM_BUG_ON(sis == NULL);
@@ -232,7 +255,8 @@ void __frontswap_invalidate_page(unsigned type, pgoff_t offset)
 	if (!__frontswap_test(sis, offset))
 		return;
 
-	frontswap_ops->invalidate_page(type, offset);
+	for_each_frontswap_ops(ops)
+		ops->invalidate_page(type, offset);
 	__frontswap_clear(sis, offset);
 	inc_frontswap_invalidates();
 }
@@ -244,6 +268,7 @@ void __frontswap_invalidate_page(unsigned type, pgoff_t offset)
 void __frontswap_invalidate_area(unsigned type)
 {
 	struct swap_info_struct *sis = swap_info[type];
+	struct frontswap_ops *ops;
 
 	VM_BUG_ON(!frontswap_ops);
 	VM_BUG_ON(sis == NULL);
@@ -251,7 +276,8 @@ void __frontswap_invalidate_area(unsigned type)
 	if (sis->frontswap_map == NULL)
 		return;
 
-	frontswap_ops->invalidate_area(type);
+	for_each_frontswap_ops(ops)
+		ops->invalidate_area(type);
 	atomic_set(&sis->frontswap_pages, 0);
 	bitmap_zero(sis->frontswap_map, sis->max);
 }
diff --git a/mm/zswap.c b/mm/zswap.c
index 2d48fd59cc7a..c22208df292a 100644
--- a/mm/zswap.c
+++ b/mm/zswap.c
@@ -1415,7 +1415,7 @@ static void zswap_frontswap_init(unsigned type)
 	zswap_trees[type] = tree;
 }
 
-static const struct frontswap_ops zswap_frontswap_ops = {
+static struct frontswap_ops zswap_frontswap_ops = {
 	.store = zswap_frontswap_store,
 	.load = zswap_frontswap_load,
 	.invalidate_page = zswap_frontswap_invalidate_page,
@@ -1512,15 +1512,11 @@ static int __init init_zswap(void)
 	if (!shrink_wq)
 		goto fallback_fail;
 
-	ret = frontswap_register_ops(&zswap_frontswap_ops);
-	if (ret)
-		goto destroy_wq;
+	frontswap_register_ops(&zswap_frontswap_ops);
 	if (zswap_debugfs_init())
 		pr_warn("debugfs initialization failed\n");
 	return 0;
 
-destroy_wq:
-	destroy_workqueue(shrink_wq);
 fallback_fail:
 	if (pool)
 		zswap_pool_destroy(pool);
-- 
2.25.1

