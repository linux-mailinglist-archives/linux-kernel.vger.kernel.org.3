Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ED71A586D1E
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:42:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232918AbiHAOmo (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:42:44 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53266 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233192AbiHAOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id E3B4C3D5B7
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:41:39 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659364899;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=ptpjQvYrPBtNMmTt+fSGBKQ4r5nKNcyczY5FXLDon0A=;
        b=ZB7xuHVF3r2ceLCQ5jTngSXRWT0HB6OAiF33oZ0/dHsMFZ8WaWBhJz8IM9Pcn45WGmrhtc
        bJfdBMvc7J4kPgoYDA/Eqz/o1bD8lmMZ3nEFh8UAAnKz3xPh0F2lNCKKWAfLSaR9YXVKi5
        bxJjzT+/YJUPwLbwz8h/V/FB2INRWtk=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-630-TzC6v2iRMeKK-f73vIXnIw-1; Mon, 01 Aug 2022 10:41:35 -0400
X-MC-Unique: TzC6v2iRMeKK-f73vIXnIw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 1FFA23C30000;
        Mon,  1 Aug 2022 14:41:35 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 433A6141510F;
        Mon,  1 Aug 2022 14:41:29 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        Yoshinori Sato <ysato@users.sourceforge.jp>,
        Rich Felker <dalias@libc.org>, linux-sh@vger.kernel.org
Subject: [PATCH 10/11] sh: mm: Convert to GENERIC_IOREMAP
Date:   Mon,  1 Aug 2022 22:40:28 +0800
Message-Id: <20220801144029.57829-11-bhe@redhat.com>
In-Reply-To: <20220801144029.57829-1-bhe@redhat.com>
References: <20220801144029.57829-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hook ioremap_allowed() for sh's special operation when
ioremap(), then ioremap_cache() is converted to use ioremap_prot()
from GENERIC_IOREMAP.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Yoshinori Sato <ysato@users.sourceforge.jp>
Cc: Rich Felker <dalias@libc.org>
Cc: linux-sh@vger.kernel.org
---
 arch/sh/Kconfig          |  1 +
 arch/sh/include/asm/io.h | 47 +++++++++---------------------
 arch/sh/mm/ioremap.c     | 62 ++++++++--------------------------------
 3 files changed, 27 insertions(+), 83 deletions(-)

diff --git a/arch/sh/Kconfig b/arch/sh/Kconfig
index 5f220e903e5a..b63ad4698cf8 100644
--- a/arch/sh/Kconfig
+++ b/arch/sh/Kconfig
@@ -25,6 +25,7 @@ config SUPERH
 	select GENERIC_SCHED_CLOCK
 	select GENERIC_SMP_IDLE_THREAD
 	select GUP_GET_PTE_LOW_HIGH if X2TLB
+	select GENERIC_IOREMAP if MMU
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_KGDB
 	select HAVE_ARCH_SECCOMP_FILTER
diff --git a/arch/sh/include/asm/io.h b/arch/sh/include/asm/io.h
index fba90e670ed4..b2cba511a73b 100644
--- a/arch/sh/include/asm/io.h
+++ b/arch/sh/include/asm/io.h
@@ -242,45 +242,26 @@ unsigned long long poke_real_address_q(unsigned long long addr,
 #define phys_to_virt(address)	(__va(address))
 #endif
 
-#ifdef CONFIG_MMU
-void iounmap(void __iomem *addr);
-void __iomem *__ioremap_caller(phys_addr_t offset, unsigned long size,
-			       pgprot_t prot, void *caller);
-
-static inline void __iomem *ioremap(phys_addr_t offset, unsigned long size)
-{
-	return __ioremap_caller(offset, size, PAGE_KERNEL_NOCACHE,
-			__builtin_return_address(0));
-}
-
-static inline void __iomem *
-ioremap_cache(phys_addr_t offset, unsigned long size)
-{
-	return __ioremap_caller(offset, size, PAGE_KERNEL,
-			__builtin_return_address(0));
-}
-#define ioremap_cache ioremap_cache
+/*
+ * I/O memory mapping functions.
+ */
+void __iomem *
+ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
+#define ioremap_allowed ioremap_allowed
 
-#ifdef CONFIG_HAVE_IOREMAP_PROT
-static inline void __iomem *ioremap_prot(phys_addr_t offset, unsigned long size,
-		unsigned long flags)
-{
-	return __ioremap_caller(offset, size, __pgprot(flags),
-			__builtin_return_address(0));
-}
-#endif /* CONFIG_HAVE_IOREMAP_PROT */
+int iounmap_allowed(void *addr);
+#define iounmap_allowed iounmap_allowed
 
-#else /* CONFIG_MMU */
-static inline void __iomem *ioremap(phys_addr_t offset, size_t size)
-{
-	return (void __iomem *)(unsigned long)offset;
-}
+#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL_NOCACHE)
 
-static inline void iounmap(volatile void __iomem *addr) { }
-#endif /* CONFIG_MMU */
+#define ioremap_cache(addr, size)  \
+	ioremap_prot((addr), (size), pgprot_val(PAGE_KERNEL))
+#define ioremap_cache ioremap_cache
 
 #define ioremap_uc	ioremap
 
+#include <asm-generic/io.h>
+
 /*
  * Convert a physical pointer to a virtual kernel pointer for /dev/mem
  * access
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index 21342581144d..66637a6cc6f8 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -72,22 +72,13 @@ __ioremap_29bit(phys_addr_t offset, unsigned long size, pgprot_t prot)
 #define __ioremap_29bit(offset, size, prot)		NULL
 #endif /* CONFIG_29BIT */
 
-/*
- * Remap an arbitrary physical address space into the kernel virtual
- * address space. Needed when the kernel wants to access high addresses
- * directly.
- *
- * NOTE! We need to allow non-page-aligned mappings too: we will obviously
- * have to convert them into an offset in a page-aligned mapping, but the
- * caller shouldn't need to know that small detail.
- */
-void __iomem * __ref
-__ioremap_caller(phys_addr_t phys_addr, unsigned long size,
-		 pgprot_t pgprot, void *caller)
+void __iomem *
+ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	struct vm_struct *area;
-	unsigned long offset, last_addr, addr, orig_addr;
+	unsigned long last_addr, phys_addr = *paddr;
 	void __iomem *mapped;
+	pgprot_t pgprot = __pgprot(*prot_val);
+	int ret = -EINVAL;
 
 	mapped = __ioremap_trapped(phys_addr, size);
 	if (mapped)
@@ -100,7 +91,7 @@ __ioremap_caller(phys_addr_t phys_addr, unsigned long size,
 	/* Don't allow wraparound or zero size */
 	last_addr = phys_addr + size - 1;
 	if (!size || last_addr < phys_addr)
-		return NULL;
+		return IOMEM_ERR_PTR(ret);
 
 	/*
 	 * If we can't yet use the regular approach, go the fixmap route.
@@ -116,30 +107,8 @@ __ioremap_caller(phys_addr_t phys_addr, unsigned long size,
 	if (mapped && !IS_ERR(mapped))
 		return mapped;
 
-	/*
-	 * Mappings have to be page-aligned
-	 */
-	offset = phys_addr & ~PAGE_MASK;
-	phys_addr &= PAGE_MASK;
-	size = PAGE_ALIGN(last_addr+1) - phys_addr;
-
-	/*
-	 * Ok, go for it..
-	 */
-	area = get_vm_area_caller(size, VM_IOREMAP, caller);
-	if (!area)
-		return NULL;
-	area->phys_addr = phys_addr;
-	orig_addr = addr = (unsigned long)area->addr;
-
-	if (ioremap_page_range(addr, addr + size, phys_addr, pgprot)) {
-		vunmap((void *)orig_addr);
-		return NULL;
-	}
-
-	return (void __iomem *)(offset + (char *)orig_addr);
+	return NULL;
 }
-EXPORT_SYMBOL(__ioremap_caller);
 
 /*
  * Simple checks for non-translatable mappings.
@@ -158,7 +127,7 @@ static inline int iomapping_nontranslatable(unsigned long offset)
 	return 0;
 }
 
-void iounmap(void __iomem *addr)
+int iounmap_allowed(void __iomem *addr)
 {
 	unsigned long vaddr = (unsigned long __force)addr;
 	struct vm_struct *p;
@@ -167,26 +136,19 @@ void iounmap(void __iomem *addr)
 	 * Nothing to do if there is no translatable mapping.
 	 */
 	if (iomapping_nontranslatable(vaddr))
-		return;
+		return -EINVAL;
 
 	/*
 	 * There's no VMA if it's from an early fixed mapping.
 	 */
 	if (iounmap_fixed(addr) == 0)
-		return;
+		return -EINVAL;
 
 	/*
 	 * If the PMB handled it, there's nothing else to do.
 	 */
 	if (pmb_unmap(addr) == 0)
-		return;
+		return -EINVAL;
 
-	p = remove_vm_area((void *)(vaddr & PAGE_MASK));
-	if (!p) {
-		printk(KERN_ERR "%s: bad address %p\n", __func__, addr);
-		return;
-	}
-
-	kfree(p);
+	return 0;
 }
-EXPORT_SYMBOL(iounmap);
-- 
2.34.1

