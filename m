Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68F3152CE24
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:20:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235435AbiESISx (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:18:53 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43500 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235318AbiESIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:17:09 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F3DD65D03
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:17:08 -0700 (PDT)
Received: from dggpemm500020.china.huawei.com (unknown [172.30.72.56])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4L3jJB3WPwzCssb;
        Thu, 19 May 2022 16:12:10 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500020.china.huawei.com (7.185.36.49) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 16:17:06 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 16:17:05 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 4/6] mm: ioremap: Add arch_ioremap/iounmap()
Date:   Thu, 19 May 2022 16:25:50 +0800
Message-ID: <20220519082552.117736-5-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
References: <20220519082552.117736-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems705-chm.china.huawei.com (10.3.19.182) To
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

Add special hook for architecture to verify or setup addr, size
or prot when ioremap() or iounmap(), which will make the generic
ioremap more useful.

  arch_ioremap() return a pointer,
    - IS_ERR means return an error
    - NULL means continue to remap
    - a non-NULL, non-IS_ERR pointer is directly returned
  arch_iounmap() return a int value,
    - 0 means continue to vunmap
    - error code means skip vunmap and return directly

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/io.h | 24 ++++++++++++++++++++++++
 mm/ioremap.c             | 17 ++++++++++++++---
 2 files changed, 38 insertions(+), 3 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index e6ffa2519f08..b60f7151e1d6 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -964,6 +964,30 @@ static inline void iounmap(volatile void __iomem *addr)
 #elif defined(CONFIG_GENERIC_IOREMAP)
 #include <linux/pgtable.h>
 
+/*
+ * Arch code can implement the following two special hooks when using GENERIC_IOREMAP
+ * arch_ioremap() return a pointer,
+ *   - IS_ERR means return an error
+ *   - NULL means continue to remap
+ *   - a non-NULL, non-IS_ERR pointer is returned directly
+ * arch_iounmap() return a int,
+ *   - 0 means continue to vunmap
+ *   - error code means skip vunmap and return directly
+ */
+#ifndef arch_ioremap
+static inline void __iomem *arch_ioremap(phys_addr_t phys_addr, size_t size, unsigned long prot)
+{
+	return NULL;
+}
+#endif
+
+#ifndef arch_iounmap
+static inline int arch_iounmap(void __iomem *addr)
+{
+	return 0;
+}
+#endif
+
 void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
 void iounmap(volatile void __iomem *addr);
 
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 7cb9996b0c12..fac7f23b8c4b 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -16,6 +16,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
 	unsigned long offset, vaddr;
 	phys_addr_t last_addr;
 	struct vm_struct *area;
+	void __iomem *base;
 
 	/* Disallow wrap-around or zero size */
 	last_addr = phys_addr + size - 1;
@@ -27,8 +28,13 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
-	area = get_vm_area_caller(size, VM_IOREMAP,
-			__builtin_return_address(0));
+	base = arch_ioremap(phys_addr, size, prot);
+	if (IS_ERR(base))
+		return NULL;
+	else if (base)
+		return base;
+
+	area = get_vm_area_caller(size, VM_IOREMAP, __builtin_return_address(0));
 	if (!area)
 		return NULL;
 	vaddr = (unsigned long)area->addr;
@@ -45,6 +51,11 @@ EXPORT_SYMBOL(ioremap_prot);
 
 void iounmap(volatile void __iomem *addr)
 {
-	vunmap((void *)((unsigned long)addr & PAGE_MASK));
+	void __iomem *vaddr = (void __iomem *)((unsigned long)addr & PAGE_MASK);
+
+	if (arch_iounmap(vaddr))
+		return;
+
+	vunmap(vaddr);
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.35.3

