Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6181B51172D
	for <lists+linux-kernel@lfdr.de>; Wed, 27 Apr 2022 14:46:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233391AbiD0MFi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Apr 2022 08:05:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45156 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233435AbiD0MFc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Apr 2022 08:05:32 -0400
Received: from szxga08-in.huawei.com (szxga08-in.huawei.com [45.249.212.255])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B2B4D3B2BD
        for <linux-kernel@vger.kernel.org>; Wed, 27 Apr 2022 05:02:20 -0700 (PDT)
Received: from dggpemm500024.china.huawei.com (unknown [172.30.72.57])
        by szxga08-in.huawei.com (SkyGuard) with ESMTP id 4KpHQr4cVVz1JBqV;
        Wed, 27 Apr 2022 20:01:24 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500024.china.huawei.com (7.185.36.203) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 20:02:18 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Wed, 27 Apr 2022 20:02:18 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Andrew Morton <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, Kefeng Wang <wangkefeng.wang@huawei.com>
Subject: [PATCH 2/4] mm: ioremap: Add arch_ioremap/iounmap_check()
Date:   Wed, 27 Apr 2022 20:14:11 +0800
Message-ID: <20220427121413.168468-3-wangkefeng.wang@huawei.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
References: <20220427121413.168468-1-wangkefeng.wang@huawei.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.175.113.25]
X-ClientProxiedBy: dggems706-chm.china.huawei.com (10.3.19.183) To
 dggpemm500001.china.huawei.com (7.185.36.107)
X-CFilter-Loop: Reflected
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add special check hook for architecture to verify addr, size
or prot when ioremap() or iounmap(), which will make the generic
ioremap more useful.

Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 include/asm-generic/io.h |  3 +++
 mm/ioremap.c             | 20 +++++++++++++++++++-
 2 files changed, 22 insertions(+), 1 deletion(-)

diff --git a/include/asm-generic/io.h b/include/asm-generic/io.h
index 7ce93aaf69f8..26924fded7c3 100644
--- a/include/asm-generic/io.h
+++ b/include/asm-generic/io.h
@@ -964,6 +964,9 @@ static inline void iounmap(volatile void __iomem *addr)
 #elif defined(CONFIG_GENERIC_IOREMAP)
 #include <linux/pgtable.h>
 
+bool arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot);
+bool arch_iounmap_check(void __iomem *addr);
+
 void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
 void iounmap(volatile void __iomem *addr);
 
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 522ef899c35f..d1117005dcc7 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -11,6 +11,16 @@
 #include <linux/io.h>
 #include <linux/export.h>
 
+bool __weak arch_ioremap_check(phys_addr_t addr, size_t size, unsigned long prot)
+{
+	return true;
+}
+
+bool __weak arch_iounmap_check(void __iomem *addr)
+{
+	return true;
+}
+
 void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
 {
 	unsigned long offset, vaddr;
@@ -27,6 +37,9 @@ void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
 	addr -= offset;
 	size = PAGE_ALIGN(size + offset);
 
+	if (!arch_ioremap_check(addr, size, prot))
+		return NULL;
+
 	area = get_vm_area_caller(size, VM_IOREMAP,
 			__builtin_return_address(0));
 	if (!area)
@@ -45,6 +58,11 @@ EXPORT_SYMBOL(ioremap_prot);
 
 void iounmap(volatile void __iomem *addr)
 {
-	vunmap((void *)((unsigned long)addr & PAGE_MASK));
+	void *vaddr = (void *)((unsigned long)addr & PAGE_MASK);
+
+	if (!arch_iounmap_check(vaddr))
+		return;
+
+	vunmap(vaddr);
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.26.2

