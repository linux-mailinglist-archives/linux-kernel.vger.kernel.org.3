Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C225C586D1A
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:42:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233161AbiHAOm1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:42:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53948 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233150AbiHAOli (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:41:38 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 7026C3D5A4
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:41:29 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659364888;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=7btrmOvCwxUbWnRbGW9HAB+h/F7WiYkudy0+tZC07Ew=;
        b=S9JxWfIpQHyf8vK+wBBA59vU1M11NWXQ3YON/SQk/w1o01dqZy5zaRs8g7qkqa2+UEMCsW
        mhg6/T8yg0xvPfSWsUxEbbtAqMpY+eZFjmiG5EZJlDPlaBKt+FV0FsjBi7cB6J0cKD77cT
        SLG+k22wWjZOBLhR5uXv+AjBdG3gW8M=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-518-mR9E7DbFOuOXnfVfrRdWoA-1; Mon, 01 Aug 2022 10:41:23 -0400
X-MC-Unique: mR9E7DbFOuOXnfVfrRdWoA-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id B253780602A;
        Mon,  1 Aug 2022 14:41:22 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 1B528141510F;
        Mon,  1 Aug 2022 14:41:17 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>,
        Helge Deller <deller@gmx.de>, linux-parisc@vger.kernel.org
Subject: [PATCH 08/11] parisc: mm: Convert to GENERIC_IOREMAP
Date:   Mon,  1 Aug 2022 22:40:26 +0800
Message-Id: <20220801144029.57829-9-bhe@redhat.com>
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

Add hook ioremap_allowed() for parisc's special operation when
ioremap(), then ioremap_[wc|uc]() are converted to use ioremap_prot()
from GENERIC_IOREMAP.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: "James E.J. Bottomley" <James.Bottomley@HansenPartnership.com>
Cc: Helge Deller <deller@gmx.de>
Cc: linux-parisc@vger.kernel.org
---
 arch/parisc/include/asm/io.h | 16 ++++++---
 arch/parisc/mm/ioremap.c     | 66 ++++--------------------------------
 2 files changed, 18 insertions(+), 64 deletions(-)

diff --git a/arch/parisc/include/asm/io.h b/arch/parisc/include/asm/io.h
index 837ddddbac6a..4183f05ca1c4 100644
--- a/arch/parisc/include/asm/io.h
+++ b/arch/parisc/include/asm/io.h
@@ -125,13 +125,19 @@ static inline void gsc_writeq(unsigned long long val, unsigned long addr)
 }
 
 /*
- * The standard PCI ioremap interfaces
+ * I/O memory mapping functions.
  */
-void __iomem *ioremap(unsigned long offset, unsigned long size);
-#define ioremap_wc			ioremap
-#define ioremap_uc			ioremap
+void __iomem *
+ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long prot);
+#define ioremap_allowed ioremap_allowed
 
-extern void iounmap(const volatile void __iomem *addr);
+#define _PAGE_IOREMAP (_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY | \
+		       _PAGE_ACCESSED | _PAGE_NO_CACHE)
+
+#define ioremap_wc(addr, size)  \
+	ioremap_prot((addr), (size), _PAGE_IOREMAP)
+#define ioremap_uc(addr, size)  \
+	ioremap_prot((addr), (size), _PAGE_IOREMAP)
 
 static inline unsigned char __raw_readb(const volatile void __iomem *addr)
 {
diff --git a/arch/parisc/mm/ioremap.c b/arch/parisc/mm/ioremap.c
index 345ff0b66499..1a6f928e8339 100644
--- a/arch/parisc/mm/ioremap.c
+++ b/arch/parisc/mm/ioremap.c
@@ -13,38 +13,20 @@
 #include <linux/io.h>
 #include <linux/mm.h>
 
-/*
- * Generic mapping function (not visible outside):
- */
-
-/*
- * Remap an arbitrary physical address space into the kernel virtual
- * address space.
- *
- * NOTE! We need to allow non-page-aligned mappings too: we will obviously
- * have to convert them into an offset in a page-aligned mapping, but the
- * caller shouldn't need to know that small detail.
- */
-void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
+void __iomem *
+ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	void __iomem *addr;
-	struct vm_struct *area;
-	unsigned long offset, last_addr;
-	pgprot_t pgprot;
+	phys_addr_t phys_addr = *paddr;
+	int ret = -EINVAL;
 
 #ifdef CONFIG_EISA
 	unsigned long end = phys_addr + size - 1;
 	/* Support EISA addresses */
 	if ((phys_addr >= 0x00080000 && end < 0x000fffff) ||
 	    (phys_addr >= 0x00500000 && end < 0x03bfffff))
-		phys_addr |= F_EXTEND(0xfc000000);
+		*paddr = phys_addr |= F_EXTEND(0xfc000000);
 #endif
 
-	/* Don't allow wraparound or zero size */
-	last_addr = phys_addr + size - 1;
-	if (!size || last_addr < phys_addr)
-		return NULL;
-
 	/*
 	 * Don't allow anybody to remap normal RAM that we're using..
 	 */
@@ -58,43 +40,9 @@ void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 		for (page = virt_to_page(t_addr); 
 		     page <= virt_to_page(t_end); page++) {
 			if(!PageReserved(page))
-				return NULL;
+				return IOMEM_ERR_PTR(ret);
 		}
 	}
 
-	pgprot = __pgprot(_PAGE_PRESENT | _PAGE_RW | _PAGE_DIRTY |
-			  _PAGE_ACCESSED | _PAGE_NO_CACHE);
-
-	/*
-	 * Mappings have to be page-aligned
-	 */
-	offset = phys_addr & ~PAGE_MASK;
-	phys_addr &= PAGE_MASK;
-	size = PAGE_ALIGN(last_addr + 1) - phys_addr;
-
-	/*
-	 * Ok, go for it..
-	 */
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-
-	addr = (void __iomem *) area->addr;
-	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
-			       phys_addr, pgprot)) {
-		vunmap(addr);
-		return NULL;
-	}
-
-	return (void __iomem *) (offset + (char __iomem *)addr);
-}
-EXPORT_SYMBOL(ioremap);
-
-void iounmap(const volatile void __iomem *io_addr)
-{
-	unsigned long addr = (unsigned long)io_addr & PAGE_MASK;
-
-	if (is_vmalloc_addr((void *)addr))
-		vunmap((void *)addr);
+	return NULL;
 }
-EXPORT_SYMBOL(iounmap);
-- 
2.34.1

