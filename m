Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4BF5953FF18
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244004AbiFGMlP (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:41:15 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43934 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S243915AbiFGMky (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:40:54 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5973C7A
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:40:52 -0700 (PDT)
Received: from dggpemm500023.china.huawei.com (unknown [172.30.72.57])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LHVKM34FjzgYRy;
        Tue,  7 Jun 2022 20:39:03 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500023.china.huawei.com (7.185.36.83) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:40:51 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:40:50 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v5 4/6] mm: ioremap: Add ioremap/iounmap_allowed()
Date:   Tue, 7 Jun 2022 20:50:25 +0800
Message-ID: <20220607125027.44946-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
References: <20220607125027.44946-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems701-chm.china.huawei.com (10.3.19.178) To
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

  ioremap_allowed() return a bool,
    - true means continue to remap
    - false means skip remap and return directly
  iounmap_allowed() return a bool,
    - true means continue to vunmap
    - false code means skip vunmap and return directly

Meanwhile, only vunmap the address when it is in vmalloc area
as the generic ioremap only returns vmalloc addresses.

Acked-by: Andrew Morton <akpm@linux-foundation.org>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/io.h | 26 ++++++++++++++++++++++++++
 mm/ioremap.c             | 11 ++++++++++-
 2 files changed, 36 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index b76379628a02..db5b890eaff7 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -964,6 +964,32 @@ static inline void iounmap(volatile void __iomem *addr)
 #elif defined(CONFIG_GENERIC_IOREMAP)
 #include <linux/pgtable.h>
 
+/*
+ * Arch code can implement the following two hooks when using GENERIC_IOREMAP
+ * ioremap_allowed() return a bool,
+ *   - true means continue to remap
+ *   - false means skip remap and return directly
+ * iounmap_allowed() return a bool,
+ *   - true means continue to vunmap
+ *   - false means skip vunmap and return directly
+ */
+#ifndef ioremap_allowed
+#define ioremap_allowed ioremap_allowed
+static inline bool ioremap_allowed(phys_addr_t phys_addr, size_t size,
+				   unsigned long prot)
+{
+	return true;
+}
+#endif
+
+#ifndef iounmap_allowed
+#define iounmap_allowed iounmap_allowed
+static inline bool iounmap_allowed(void *addr)
+{
+	return true;
+}
+#endif
+
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 			   unsigned long prot);
 void iounmap(volatile void __iomem *addr);
diff --git a/mm/ioremap.c b/mm/ioremap.c
index e1d008e8f87f..8652426282cc 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -28,6 +28,9 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size,
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
+	if (!ioremap_allowed(phys_addr, size, prot))
+		return NULL;
+
 	area = get_vm_area_caller(size, VM_IOREMAP,
 			__builtin_return_address(0));
 	if (!area)
@@ -47,6 +50,12 @@ EXPORT_SYMBOL(ioremap_prot);
 
 void iounmap(volatile void __iomem *addr)
 {
-	vunmap((void *)((unsigned long)addr & PAGE_MASK));
+	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
+
+	if (!iounmap_allowed(vaddr))
+		return;
+
+	if (is_vmalloc_addr(vaddr))
+		vunmap(vaddr);
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.35.3

