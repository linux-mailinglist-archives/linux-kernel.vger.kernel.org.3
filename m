Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9E5A1586D19
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:42:25 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233116AbiHAOmU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:42:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53396 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233038AbiHAOld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:41:33 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 739863DF0F
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:41:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659364883;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=lrcGo2VjlmbeUcV8YVny+PT0CCF9ywqcopB5qQcKwTQ=;
        b=Upr4JRsPGGyF1ZJdr7ECacKfPh9uuaZsgsM1lhk4SARof8wz6b81BGkddEs8ItxzebwgH3
        P10Py98vj4QSJFVVIrRk590I931aziQwEqfmbY1hSGIpteDJRgTm7xoWi4DuBMyzzuSc9q
        p/R6fvbn8rKJKfIEE7b9H8LkcsnNHhs=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-562-n4sgo9WMP_y0ca4olRObJw-1; Mon, 01 Aug 2022 10:41:17 -0400
X-MC-Unique: n4sgo9WMP_y0ca4olRObJw-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 4EDAB18E6C5E;
        Mon,  1 Aug 2022 14:41:17 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 24ED1141510F;
        Mon,  1 Aug 2022 14:41:11 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>, Jonas Bonn <jonas@southpole.se>,
        Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>,
        Stafford Horne <shorne@gmail.com>,
        openrisc@lists.librecores.org
Subject: [PATCH 07/11] openrisc: mm: Convert to GENERIC_IOREMAP
Date:   Mon,  1 Aug 2022 22:40:25 +0800
Message-Id: <20220801144029.57829-8-bhe@redhat.com>
In-Reply-To: <20220801144029.57829-1-bhe@redhat.com>
References: <20220801144029.57829-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-2.7 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks ioremap_allowed() and iounmap_allowed() for operisc's special
operation when ioremap() and iounmap.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Jonas Bonn <jonas@southpole.se>
Cc: Stefan Kristiansson <stefan.kristiansson@saunalahti.fi>
Cc: Stafford Horne <shorne@gmail.com>
Cc: openrisc@lists.librecores.org
---
 arch/openrisc/Kconfig          |  1 +
 arch/openrisc/include/asm/io.h | 16 ++++++++---
 arch/openrisc/mm/ioremap.c     | 49 +++++++++++-----------------------
 3 files changed, 28 insertions(+), 38 deletions(-)

diff --git a/arch/openrisc/Kconfig b/arch/openrisc/Kconfig
index e814df4c483c..77505f2a2767 100644
--- a/arch/openrisc/Kconfig
+++ b/arch/openrisc/Kconfig
@@ -21,6 +21,7 @@ config OPENRISC
 	select GENERIC_IRQ_PROBE
 	select GENERIC_IRQ_SHOW
 	select GENERIC_IOMAP
+	select GENERIC_IOREMAP
 	select GENERIC_CPU_DEVICES
 	select HAVE_UID16
 	select GENERIC_ATOMIC64
diff --git a/arch/openrisc/include/asm/io.h b/arch/openrisc/include/asm/io.h
index c298061c70a7..8948df501464 100644
--- a/arch/openrisc/include/asm/io.h
+++ b/arch/openrisc/include/asm/io.h
@@ -15,6 +15,8 @@
 #define __ASM_OPENRISC_IO_H
 
 #include <linux/types.h>
+#include <asm/pgtable.h>
+#include <asm/pgalloc.h>
 
 /*
  * PCI: can we really do 0 here if we have no port IO?
@@ -27,11 +29,17 @@
 #define PIO_OFFSET		0
 #define PIO_MASK		0
 
-#define ioremap ioremap
-void __iomem *ioremap(phys_addr_t offset, unsigned long size);
+/*
+ * I/O memory mapping functions.
+ */
+void __iomem *
+ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
+#define ioremap_allowed ioremap_allowed
+
+int iounmap_allowed(void *addr);
+#define iounmap_allowed iounmap_allowed
 
-#define iounmap iounmap
-extern void iounmap(void __iomem *addr);
+#define _PAGE_IOREMAP (pgprot_val(PAGE_KERNEL) | _PAGE_CI)
 
 #include <asm-generic/io.h>
 
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index daae13a76743..d30b6cc65548 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -24,26 +24,18 @@ extern int mem_init_done;
 
 static unsigned int fixmaps_used __initdata;
 
-/*
- * Remap an arbitrary physical address space into the kernel virtual
- * address space. Needed when the kernel wants to access high addresses
- * directly.
- *
- * NOTE! We need to allow non-page-aligned mappings too: we will obviously
- * have to convert them into an offset in a page-aligned mapping, but the
- * caller shouldn't need to know that small detail.
- */
-void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
+void __iomem *
+ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
 	phys_addr_t p;
 	unsigned long v;
 	unsigned long offset, last_addr;
-	struct vm_struct *area = NULL;
+	int ret = -EINVAL;
 
 	/* Don't allow wraparound or zero size */
 	last_addr = addr + size - 1;
 	if (!size || last_addr < addr)
-		return NULL;
+		return IOMEM_ERR_PTR(ret);
 
 	/*
 	 * Mappings have to be page-aligned
@@ -52,32 +44,24 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
 	p = addr & PAGE_MASK;
 	size = PAGE_ALIGN(last_addr + 1) - p;
 
-	if (likely(mem_init_done)) {
-		area = get_vm_area(size, VM_IOREMAP);
-		if (!area)
-			return NULL;
-		v = (unsigned long)area->addr;
-	} else {
+	if (unlikely(!mem_init_done)) {
 		if ((fixmaps_used + (size >> PAGE_SHIFT)) > FIX_N_IOREMAPS)
-			return NULL;
+			return IOMEM_ERR_PTR(ret);
 		v = fix_to_virt(FIX_IOREMAP_BEGIN + fixmaps_used);
 		fixmaps_used += (size >> PAGE_SHIFT);
-	}
 
-	if (ioremap_page_range(v, v + size, p,
-			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
-		if (likely(mem_init_done))
-			vfree(area->addr);
-		else
+		if (ioremap_page_range(v, v + size, p, __pgprot(*prot_val))) {
 			fixmaps_used -= (size >> PAGE_SHIFT);
-		return NULL;
+			return IOMEM_ERR_PTR(ret);
+		}
+
+		return (void __iomem *)(offset + (char *)v);
 	}
 
-	return (void __iomem *)(offset + (char *)v);
+	return NULL;
 }
-EXPORT_SYMBOL(ioremap);
 
-void iounmap(void __iomem *addr)
+int iounmap_allowed(void __iomem *addr)
 {
 	/* If the page is from the fixmap pool then we just clear out
 	 * the fixmap mapping.
@@ -97,13 +81,10 @@ void iounmap(void __iomem *addr)
 		 *   ii) invalid accesses to the freed areas aren't made
 		 */
 		flush_tlb_all();
-		return;
+		return -EINVAL;
 	}
-
-	return vfree((void *)(PAGE_MASK & (unsigned long)addr));
+	return 0;
 }
-EXPORT_SYMBOL(iounmap);
-
 /**
  * OK, this one's a bit tricky... ioremap can get called before memory is
  * initialized (early serial console does this) and will want to alloc a page
-- 
2.34.1

