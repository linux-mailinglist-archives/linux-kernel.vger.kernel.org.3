Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C31CD5146A8
	for <lists+linux-kernel@lfdr.de>; Fri, 29 Apr 2022 12:22:09 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357618AbiD2KZE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 29 Apr 2022 06:25:04 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47860 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357377AbiD2KYv (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 29 Apr 2022 06:24:51 -0400
Received: from szxga03-in.huawei.com (szxga03-in.huawei.com [45.249.212.189])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 14E8766FA4
        for <linux-kernel@vger.kernel.org>; Fri, 29 Apr 2022 03:21:34 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga03-in.huawei.com (SkyGuard) with ESMTP id 4KqT1P4ZZzzCsLX;
        Fri, 29 Apr 2022 18:16:57 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 18:21:32 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Fri, 29 Apr 2022 18:21:31 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v2 3/5] mm: ioremap: Add arch_ioremap/iounmap()
Date:   Fri, 29 Apr 2022 18:32:23 +0800
Message-ID: <20220429103225.75121-4-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
References: <20220429103225.75121-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems704-chm.china.huawei.com (10.3.19.181) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add special hook for architecture to verify addr, size and prot
or setup when ioremap() or iounmap(), which will make the generic
ioremap more useful.

  arch_ioremap() return a 'void __iomem *',
    - IS_ERR means return an error
    - NULL means continue to remap
    - a non-NULL, non-IS_ERR pointer is directly returned
  arch_iounmap() return a int value,
    - 0 means continue to vunmap
    - error code means skip vunmap and return directly

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/io.h | 14 ++++++++++++++
 mm/ioremap.c             | 14 +++++++++++++-
 2 files changed, 27 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index e6ffa2519f08..f2f9aeedb5e8 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -964,6 +964,20 @@ static inline void iounmap(volatile void __iomem *addr)
 #elif defined(CONFIG_GENERIC_IOREMAP)
 #include <linux/pgtable.h>
 
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
index 7cb9996b0c12..de5a2e899e14 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -16,6 +16,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
 	unsigned long offset, vaddr;
 	phys_addr_t last_addr;
 	struct vm_struct *area;
+	void __iomem *base;
 
 	/* Disallow wrap-around or zero size */
 	last_addr = phys_addr + size - 1;
@@ -27,6 +28,12 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long pro
 	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
+	base = arch_ioremap(phys_addr, size, prot);
+	if (IS_ERR(base))
+		return NULL;
+	else if (base)
+		return base;
+
 	area = get_vm_area_caller(size, VM_IOREMAP,
 			__builtin_return_address(0));
 	if (!area)
@@ -45,6 +52,11 @@ EXPORT_SYMBOL(ioremap_prot);
 
 void iounmap(volatile void __iomem *addr)
 {
-	vunmap((void *)((unsigned long)addr & PAGE_MASK));
+	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
+
+	if (arch_iounmap(vaddr))
+		return;
+
+	vunmap(vaddr);
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.35.3

