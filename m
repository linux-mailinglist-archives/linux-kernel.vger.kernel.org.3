Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id DEBA959AA23
	for <lists+linux-kernel@lfdr.de>; Sat, 20 Aug 2022 02:37:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245257AbiHTAci (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 20:32:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:37344 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245187AbiHTAc2 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 20:32:28 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 47E1BEF9E3
        for <linux-kernel@vger.kernel.org>; Fri, 19 Aug 2022 17:32:27 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1660955546;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=5SHN8uljMwgOES67u9nTa1xL6WhEjv8MuhsMkmhS9fE=;
        b=hV/pu67XAiIaqfQKERM1PT+xke3238CeYqayN9Qni9a2tDvhmmHDvgy3HOKP4NrUPeC3mU
        AW3KdeVPefeEsH0pHLKqtM3/Zy9h7gdi9NmiEdL0PPyJM0HudcM2uXpRpsgOjDSNPF07JG
        5RKjgc5qd5WujIwPQal/f4hYFIha5sk=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-608-hpYxoUSSMG6Qw-fSYp5coA-1; Fri, 19 Aug 2022 20:32:22 -0400
X-MC-Unique: hpYxoUSSMG6Qw-fSYp5coA-1
Received: from smtp.corp.redhat.com (int-mx02.intmail.prod.int.rdu2.redhat.com [10.11.54.2])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 37F51185A79C;
        Sat, 20 Aug 2022 00:32:22 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-17.pek2.redhat.com [10.72.12.17])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 14E644010E3C;
        Sat, 20 Aug 2022 00:32:15 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        agordeev@linux.ibm.com, wangkefeng.wang@huawei.com,
        linux-arm-kernel@lists.infradead.org, Baoquan He <bhe@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH v2 09/11] s390: mm: Convert to GENERIC_IOREMAP
Date:   Sat, 20 Aug 2022 08:31:23 +0800
Message-Id: <20220820003125.353570-10-bhe@redhat.com>
In-Reply-To: <20220820003125.353570-1-bhe@redhat.com>
References: <20220820003125.353570-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.84 on 10.11.54.2
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks arch_ioremap() and arch_iounmap() for s390's special
operation when ioremap() and iounmap(), then ioremap_[wc|wt]() are
converted to use ioremap_prot() from GENERIC_IOREMAP.

Signed-off-by: Baoquan He <bhe@redhat.com>
Cc: Heiko Carstens <hca@linux.ibm.com>
Cc: Vasily Gorbik <gor@linux.ibm.com>
Cc: Alexander Gordeev <agordeev@linux.ibm.com>
Cc: Christian Borntraeger <borntraeger@linux.ibm.com>
Cc: Sven Schnelle <svens@linux.ibm.com>
Cc: linux-s390@vger.kernel.org
---
 arch/s390/Kconfig          |  1 +
 arch/s390/include/asm/io.h | 26 +++++++++++------
 arch/s390/pci/pci.c        | 60 +++++---------------------------------
 3 files changed, 26 insertions(+), 61 deletions(-)

diff --git a/arch/s390/Kconfig b/arch/s390/Kconfig
index 318fce77601d..c59e1b25f59d 100644
--- a/arch/s390/Kconfig
+++ b/arch/s390/Kconfig
@@ -135,6 +135,7 @@ config S390
 	select GENERIC_SMP_IDLE_THREAD
 	select GENERIC_TIME_VSYSCALL
 	select GENERIC_VDSO_TIME_NS
+	select GENERIC_IOREMAP
 	select HAVE_ALIGNED_STRUCT_PAGE if SLUB
 	select HAVE_ARCH_AUDITSYSCALL
 	select HAVE_ARCH_JUMP_LABEL
diff --git a/arch/s390/include/asm/io.h b/arch/s390/include/asm/io.h
index e3882b012bfa..f837e20b7bbd 100644
--- a/arch/s390/include/asm/io.h
+++ b/arch/s390/include/asm/io.h
@@ -22,11 +22,23 @@ void unxlate_dev_mem_ptr(phys_addr_t phys, void *addr);
 
 #define IO_SPACE_LIMIT 0
 
-void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot);
-void __iomem *ioremap(phys_addr_t addr, size_t size);
-void __iomem *ioremap_wc(phys_addr_t addr, size_t size);
-void __iomem *ioremap_wt(phys_addr_t addr, size_t size);
-void iounmap(volatile void __iomem *addr);
+
+/*
+ * I/O memory mapping functions.
+ */
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
+#define arch_ioremap arch_ioremap
+
+int arch_iounmap(void __iomem *addr);
+#define arch_iounmap arch_iounmap
+
+#define _PAGE_IOREMAP pgprot_val(PAGE_KERNEL)
+
+#define ioremap_wc(addr, size)  \
+	ioremap_prot((addr), (size), pgprot_val(pgprot_writecombine(PAGE_KERNEL)))
+#define ioremap_wt(addr, size)  \
+	ioremap_prot((addr), (size), pgprot_val(pgprot_writethrough(PAGE_KERNEL)))
 
 static inline void __iomem *ioport_map(unsigned long port, unsigned int nr)
 {
@@ -51,10 +63,6 @@ static inline void ioport_unmap(void __iomem *p)
 #define pci_iomap_wc pci_iomap_wc
 #define pci_iomap_wc_range pci_iomap_wc_range
 
-#define ioremap ioremap
-#define ioremap_wt ioremap_wt
-#define ioremap_wc ioremap_wc
-
 #define memcpy_fromio(dst, src, count)	zpci_memcpy_fromio(dst, src, count)
 #define memcpy_toio(dst, src, count)	zpci_memcpy_toio(dst, src, count)
 #define memset_io(dst, val, count)	zpci_memset_io(dst, val, count)
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index 73cdc5539384..984cad9cd5a1 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -244,64 +244,20 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
        zpci_memcpy_toio(to, from, count);
 }
 
-static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
+void __iomem *
+arch_ioremap(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
 {
-	unsigned long offset, vaddr;
-	struct vm_struct *area;
-	phys_addr_t last_addr;
-
-	last_addr = addr + size - 1;
-	if (!size || last_addr < addr)
-		return NULL;
-
 	if (!static_branch_unlikely(&have_mio))
-		return (void __iomem *) addr;
-
-	offset = addr & ~PAGE_MASK;
-	addr &= PAGE_MASK;
-	size = PAGE_ALIGN(size + offset);
-	area = get_vm_area(size, VM_IOREMAP);
-	if (!area)
-		return NULL;
-
-	vaddr = (unsigned long) area->addr;
-	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
-		free_vm_area(area);
-		return NULL;
-	}
-	return (void __iomem *) ((unsigned long) area->addr + offset);
-}
-
-void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
-{
-	return __ioremap(addr, size, __pgprot(prot));
+		return (void __iomem *) *paddr;
+	return NULL;
 }
-EXPORT_SYMBOL(ioremap_prot);
 
-void __iomem *ioremap(phys_addr_t addr, size_t size)
+int arch_iounmap(void __iomem *addr)
 {
-	return __ioremap(addr, size, PAGE_KERNEL);
-}
-EXPORT_SYMBOL(ioremap);
-
-void __iomem *ioremap_wc(phys_addr_t addr, size_t size)
-{
-	return __ioremap(addr, size, pgprot_writecombine(PAGE_KERNEL));
-}
-EXPORT_SYMBOL(ioremap_wc);
-
-void __iomem *ioremap_wt(phys_addr_t addr, size_t size)
-{
-	return __ioremap(addr, size, pgprot_writethrough(PAGE_KERNEL));
-}
-EXPORT_SYMBOL(ioremap_wt);
-
-void iounmap(volatile void __iomem *addr)
-{
-	if (static_branch_likely(&have_mio))
-		vunmap((__force void *) ((unsigned long) addr & PAGE_MASK));
+	if (!static_branch_likely(&have_mio))
+		return -EINVAL;
+	return 0;
 }
-EXPORT_SYMBOL(iounmap);
 
 /* Create a virtual mapping cookie for a PCI BAR */
 static void __iomem *pci_iomap_range_fh(struct pci_dev *pdev, int bar,
-- 
2.34.1

