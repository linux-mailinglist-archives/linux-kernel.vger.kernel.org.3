Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 843A353E319
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:55:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231378AbiFFHjA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 03:39:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53006 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231368AbiFFHin (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 03:38:43 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D251DDEFA
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 00:38:40 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.54])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LGlg76WWFzgYqd;
        Mon,  6 Jun 2022 15:36:51 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 15:38:38 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Mon, 6 Jun 2022 15:38:37 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v4 4/6] mm: ioremap: Add ioremap/iounmap_allowed()
Date:   Mon, 6 Jun 2022 15:48:13 +0800
Message-ID: <20220606074815.139265-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220606074815.139265-1-wangkefeng.wang@huawei.com>
References: <20220606074815.139265-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add special hook for architecture to verify addr, size or prot
when ioremap() or iounmap(), which will make the generic ioremap
more useful.

  ioremap_allowed() return an int,
    - NULL means continue to remap
    - error code means skip remap and return directly
  iounmap_allowed() return an int,
    - 0 means continue to vunmap
    - error code means skip vunmap and return directly

Acked-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/io.h | 25 +++++++++++++++++++++++++
 mm/ioremap.c             | 13 ++++++++++---
 2 files changed, 35 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index e6ffa2519f08..9429387a3e65 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -964,6 +964,31 @@ static inline void iounmap(volatile void __iomem *addr)
 #elif defined(CONFIG_GENERIC_IOREMAP)
 #include <linux/pgtable.h>
 
+/*
+ * Arch code can implement the following two special hooks when using GENERIC_IOREMAP
+ * ioremap_allowed() return an int,
+ *   - 0 means continue to remap
+ *   - error code means skip remap and return directly
+ * iounmap_allowed() return an int,
+ *   - 0 means continue to vunmap
+ *   - error code means skip vunmap and return directly
+ */
+#ifndef ioremap_allowed
+#define ioremap_allowed ioremap_allowed
+static inline int ioremap_allowed(phys_addr_t phys_addr, size_t size, unsigned long prot)
+{
+	return 0;
+}
+#endif
+
+#ifndef iounmap_allowed
+#define iounmap_allowed iounmap_allowed
+static inline int iounmap_allowed(void __iomem *addr)
+{
+	return 0;
+}
+#endif
+
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
 void iounmap(volatile void __iomem *addr);
 
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 7cb9996b0c12..196c93c0beb8 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -27,8 +27,10 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
-	area = get_vm_area_caller(size, VM_IOREMAP,
-			__builtin_return_address(0));
+	if (ioremap_allowed(phys_addr, size, prot))
+		return NULL;
+
+	area = get_vm_area_caller(size, VM_IOREMAP, __builtin_return_address(0));
 	if (!area)
 		return NULL;
 	vaddr = (unsigned long)area->addr;
@@ -45,6 +47,11 @@ EXPORT_SYMBOL(ioremap_prot);
 
 void iounmap(volatile void __iomem *addr)
 {
-	vunmap((void *)((unsigned long)addr & PAGE_MASK));
+	void __iomem *vaddr = (void __iomem *)((unsigned long)addr & PAGE_MASK);
+
+	if (iounmap_allowed(vaddr))
+		return;
+
+	vunmap((void __force *)vaddr);
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.35.3

