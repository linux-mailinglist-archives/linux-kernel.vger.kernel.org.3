Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7003D586D1F
	for <lists+linux-kernel@lfdr.de>; Mon,  1 Aug 2022 16:42:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233111AbiHAOms (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 1 Aug 2022 10:42:48 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53238 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232881AbiHAOmG (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 1 Aug 2022 10:42:06 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.129.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id D42FE3D5AF
        for <linux-kernel@vger.kernel.org>; Mon,  1 Aug 2022 07:41:37 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1659364896;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=BBzCb2fiH7fH28l+Pr9dt4AWIkSmNoXCY2kDwl5mvZY=;
        b=T1ZLJ5X0eaEYCCFboXtT11mlqQQc64LBkZRWDxHvlzsNDSNed7tz11nWLwZxUcqAUu6Lmf
        7yD/KhmnYwWRKxEnXgsSu3eZdD6nGX8YV3ViTq2flyqgEguMyzeQsPU86MhEF5Fh4CLTPc
        3a4B9ba5rw693iGg7U6bHjtoYLvG8f4=
Received: from mimecast-mx02.redhat.com (mimecast-mx02.redhat.com
 [66.187.233.88]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-315-lTb-YXtxO6C8tkOzXucoeQ-1; Mon, 01 Aug 2022 10:41:30 -0400
X-MC-Unique: lTb-YXtxO6C8tkOzXucoeQ-1
Received: from smtp.corp.redhat.com (int-mx07.intmail.prod.int.rdu2.redhat.com [10.11.54.7])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 754BC806030;
        Mon,  1 Aug 2022 14:41:29 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-12-103.pek2.redhat.com [10.72.12.103])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 66F84141510F;
        Mon,  1 Aug 2022 14:41:23 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     linux-kernel@vger.kernel.org
Cc:     linux-mm@kvack.org, akpm@linux-foundation.org, hch@infradead.org,
        wangkefeng.wang@huawei.com, linux-arm-kernel@lists.infradead.org,
        Baoquan He <bhe@redhat.com>,
        Heiko Carstens <hca@linux.ibm.com>,
        Vasily Gorbik <gor@linux.ibm.com>,
        Alexander Gordeev <agordeev@linux.ibm.com>,
        Christian Borntraeger <borntraeger@linux.ibm.com>,
        Sven Schnelle <svens@linux.ibm.com>, linux-s390@vger.kernel.org
Subject: [PATCH 09/11] s390: mm: Convert to GENERIC_IOREMAP
Date:   Mon,  1 Aug 2022 22:40:27 +0800
Message-Id: <20220801144029.57829-10-bhe@redhat.com>
In-Reply-To: <20220801144029.57829-1-bhe@redhat.com>
References: <20220801144029.57829-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.85 on 10.11.54.7
X-Spam-Status: No, score=-3.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        SPF_HELO_NONE,SPF_NONE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add hooks ioremap_allowed() and iounmap_allowed() for s390's special
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
index 5a1a8dfda6f8..60ed181dfba5 100644
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
index e3882b012bfa..b0f823850ef1 100644
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
+ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long *prot_val);
+#define ioremap_allowed ioremap_allowed
+
+int iounmap_allowed(void *addr);
+#define iounmap_allowed iounmap_allowed
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
index bc980fd313d5..dcd17366a064 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -231,64 +231,20 @@ void __iowrite64_copy(void __iomem *to, const void *from, size_t count)
        zpci_memcpy_toio(to, from, count);
 }
 
-static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
+void __iomem *
+ioremap_allowed(phys_addr_t *paddr, size_t size, unsigned long *prot_val)
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
+int iounmap_allowed(void __iomem *addr)
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

