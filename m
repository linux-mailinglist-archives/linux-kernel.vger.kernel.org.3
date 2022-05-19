Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9155452CE17
	for <lists+linux-kernel@lfdr.de>; Thu, 19 May 2022 10:20:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231497AbiESIS3 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 19 May 2022 04:18:29 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43470 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235299AbiESIRJ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 19 May 2022 04:17:09 -0400
Received: from szxga02-in.huawei.com (szxga02-in.huawei.com [45.249.212.188])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4F2E365D02
        for <linux-kernel@vger.kernel.org>; Thu, 19 May 2022 01:17:07 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga02-in.huawei.com (SkyGuard) with ESMTP id 4L3jLT64TGzQkJD;
        Thu, 19 May 2022 16:14:09 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 16:17:05 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Thu, 19 May 2022 16:17:04 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH v3 2/6] mm: ioremap: Use more sensibly name in ioremap_prot()
Date:   Thu, 19 May 2022 16:25:48 +0800
Message-ID: <20220519082552.117736-3-wangkefeng.wang@huawei.com>
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

Use more meaningful and sensibly naming phys_addr
instead addr in ioremap_prot().

Suggested-by: Andrew Morton <akpm@linux-foundation.org>
Reviewed-by: Anshuman Khandual <anshuman.khandual@arm.com>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/io.h |  2 +-
 mm/ioremap.c             | 12 ++++++------
 2 files changed, 7 insertions(+), 7 deletions(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ce93aaf69f8..e6ffa2519f08 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -964,7 +964,7 @@ static inline void iounmap(volatile void __iomem *addr)
 #elif defined(CONFIG_GENERIC_IOREMAP)
 #include <linux/pgtable.h>
 
-void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot);
 void iounmap(volatile void __iomem *addr);
 
 static inline void __iomem *ioremap(phys_addr_t addr, size_t size)
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 5fe598ecd9b7..1f9597fbcc07 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -11,20 +11,20 @@
 #include <linux/io.h>
 #include <linux/export.h>
 
-void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
+void __iomem *ioremap_prot(phys_addr_t phys_addr, size_t size, unsigned long prot)
 {
 	unsigned long offset, vaddr;
 	phys_addr_t last_addr;
 	struct vm_struct *area;
 
 	/* Disallow wrap-around or zero size */
-	last_addr = addr + size - 1;
-	if (!size || last_addr < addr)
+	last_addr = phys_addr + size - 1;
+	if (!size || last_addr < phys_addr)
 		return NULL;
 
 	/* Page-align mappings */
-	offset = addr & (~PAGE_MASK);
-	addr -= offset;
+	offset = phys_addr & (~PAGE_MASK);
+	phys_addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
 	area = get_vm_area_caller(size, VM_IOREMAP,
@@ -33,7 +33,7 @@ void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
 		return NULL;
 	vaddr = (unsigned long)area->addr;
 
-	if (ioremap_page_range(vaddr, vaddr + size, addr, __pgprot(prot))) {
+	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, __pgprot(prot))) {
 		free_vm_area(area);
 		return NULL;
 	}
-- 
2.35.3

