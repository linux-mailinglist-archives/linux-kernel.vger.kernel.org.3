Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9795D53FF19
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Jun 2022 14:42:00 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S243942AbiFGMk6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Jun 2022 08:40:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43910 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242910AbiFGMkx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Jun 2022 08:40:53 -0400
Received: from szxga01-in.huawei.com (szxga01-in.huawei.com [45.249.212.187])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6A9B3C2D
        for <linux-kernel@vger.kernel.org>; Tue,  7 Jun 2022 05:40:51 -0700 (PDT)
Received: from dggpemm500021.china.huawei.com (unknown [172.30.72.56])
        by szxga01-in.huawei.com (SkyGuard) with ESMTP id 4LHVLJ5gTSzjXC9;
        Tue,  7 Jun 2022 20:39:52 +0800 (CST)
Received: from dggpemm500001.china.huawei.com (7.185.36.107) by
 dggpemm500021.china.huawei.com (7.185.36.109) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:40:49 +0800
Received: from localhost.localdomain.localdomain (10.175.113.25) by
 dggpemm500001.china.huawei.com (7.185.36.107) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.24; Tue, 7 Jun 2022 20:40:48 +0800
From:   Kefeng Wang <wangkefeng.wang@huawei.com>
To:     <catalin.marinas@arm.com>, <will@kernel.org>,
        <akpm@linux-foundation.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <linux-mm@kvack.org>, <hch@infradead.org>, <arnd@arndb.de>,
        <anshuman.khandual@arm.com>,
        Kefeng Wang <wangkefeng.wang@huawei.com>,
        Russell King <linux@armlinux.org.uk>,
        Christoph Hellwig <hch@lst.de>
Subject: [PATCH v5 1/6] ARM: mm: kill unused runtime hook arch_iounmap()
Date:   Tue, 7 Jun 2022 20:50:22 +0800
Message-ID: <20220607125027.44946-2-wangkefeng.wang@huawei.com>
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

Since the following commits,

v5.4
  commit 59d3ae9a5bf6 ("ARM: remove Intel iop33x and iop13xx support")
v5.11
  commit 3e3f354bc383 ("ARM: remove ebsa110 platform")

The runtime hook arch_iounmap() on ARM is useless, kill arch_iounmap()
and __iounmap().

Cc: Russell King <linux@armlinux.org.uk>
Reviewed-by: Christoph Hellwig <hch@lst.de>
Reviewed-by: Arnd Bergmann <arnd@arndb.de>
Signed-off-by: Kefeng Wang <wangkefeng.wang@huawei.com>
---
 arch/arm/include/asm/io.h | 4 +---
 arch/arm/mm/ioremap.c     | 9 +--------
 arch/arm/mm/nommu.c       | 9 +--------
 3 files changed, 3 insertions(+), 19 deletions(-)

diff --git a/arch/arm/include/asm/io.h b/arch/arm/include/asm/io.h
index eba7cbc93b86..7fcdc785366c 100644
--- a/arch/arm/include/asm/io.h
+++ b/arch/arm/include/asm/io.h
@@ -139,11 +139,9 @@ extern void __iomem *__arm_ioremap_caller(phys_addr_t, size_t, unsigned int,
 extern void __iomem *__arm_ioremap_pfn(unsigned long, unsigned long, size_t, unsigned int);
 extern void __iomem *__arm_ioremap_exec(phys_addr_t, size_t, bool cached);
 void __arm_iomem_set_ro(void __iomem *ptr, size_t size);
-extern void __iounmap(volatile void __iomem *addr);
 
 extern void __iomem * (*arch_ioremap_caller)(phys_addr_t, size_t,
 	unsigned int, void *);
-extern void (*arch_iounmap)(volatile void __iomem *);
 
 /*
  * Bad read/write accesses...
@@ -380,7 +378,7 @@ void __iomem *ioremap_wc(resource_size_t res_cookie, size_t size);
 #define ioremap_wc ioremap_wc
 #define ioremap_wt ioremap_wc
 
-void iounmap(volatile void __iomem *iomem_cookie);
+void iounmap(volatile void __iomem *io_addr);
 #define iounmap iounmap
 
 void *arch_memremap_wb(phys_addr_t phys_addr, size_t size);
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 576c0e6c92fc..2129070065c3 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -418,7 +418,7 @@ void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
 						   __builtin_return_address(0));
 }
 
-void __iounmap(volatile void __iomem *io_addr)
+void iounmap(volatile void __iomem *io_addr)
 {
 	void *addr = (void *)(PAGE_MASK & (unsigned long)io_addr);
 	struct static_vm *svm;
@@ -446,13 +446,6 @@ void __iounmap(volatile void __iomem *io_addr)
 
 	vunmap(addr);
 }
-
-void (*arch_iounmap)(volatile void __iomem *) = __iounmap;
-
-void iounmap(volatile void __iomem *cookie)
-{
-	arch_iounmap(cookie);
-}
 EXPORT_SYMBOL(iounmap);
 
 #if defined(CONFIG_PCI) || IS_ENABLED(CONFIG_PCMCIA)
diff --git a/arch/arm/mm/nommu.c b/arch/arm/mm/nommu.c
index 2658f52903da..c42debaded95 100644
--- a/arch/arm/mm/nommu.c
+++ b/arch/arm/mm/nommu.c
@@ -230,14 +230,7 @@ void *arch_memremap_wb(phys_addr_t phys_addr, size_t size)
 	return (void *)phys_addr;
 }
 
-void __iounmap(volatile void __iomem *addr)
-{
-}
-EXPORT_SYMBOL(__iounmap);
-
-void (*arch_iounmap)(volatile void __iomem *);
-
-void iounmap(volatile void __iomem *addr)
+void iounmap(volatile void __iomem *io_addr)
 {
 }
 EXPORT_SYMBOL(iounmap);
-- 
2.35.3

