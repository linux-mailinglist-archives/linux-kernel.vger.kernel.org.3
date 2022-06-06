Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D266553E370
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 10:56:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232272AbiFFImy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 04:42:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47604 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232466AbiFFIjy (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 04:39:54 -0400
Received: from us-smtp-delivery-124.mimecast.com (us-smtp-delivery-124.mimecast.com [170.10.133.124])
        by lindbergh.monkeyblade.net (Postfix) with ESMTP id 22D3E33A08
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 01:39:49 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=redhat.com;
        s=mimecast20190719; t=1654504788;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:content-type:content-type:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=Lgvrbh++WOp1KQLk4oDBt9jAtgoYpeb1xnF+1mygpOY=;
        b=dRpSiWnhn12eFTsx2+YQA4QxNgIFCnmlAvC841pHfeIn+4VG6OmifSf1x1JpvT5m+4Pors
        X1i7RF0PNn7FonOConUYiHJMm5s+6KaDUM5iIT84WXylvSAfbkRFYqxM5kuVsX/anSGC6K
        JCVkxAeL6wZkty3Uv8fZhTuF40Lght8=
Received: from mimecast-mx02.redhat.com (mx3-rdu2.redhat.com
 [66.187.233.73]) by relay.mimecast.com with ESMTP with STARTTLS
 (version=TLSv1.2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 us-mta-256--FfxoeOxNRiqcadZwOcuWg-1; Mon, 06 Jun 2022 04:39:45 -0400
X-MC-Unique: -FfxoeOxNRiqcadZwOcuWg-1
Received: from smtp.corp.redhat.com (int-mx03.intmail.prod.int.rdu2.redhat.com [10.11.54.3])
        (using TLSv1.2 with cipher AECDH-AES256-SHA (256/256 bits))
        (No client certificate requested)
        by mimecast-mx02.redhat.com (Postfix) with ESMTPS id 229DF1C16B47;
        Mon,  6 Jun 2022 08:39:45 +0000 (UTC)
Received: from MiWiFi-R3L-srv.redhat.com (ovpn-14-4.pek2.redhat.com [10.72.14.4])
        by smtp.corp.redhat.com (Postfix) with ESMTP id 41F811121319;
        Mon,  6 Jun 2022 08:39:41 +0000 (UTC)
From:   Baoquan He <bhe@redhat.com>
To:     akpm@linux-foundation.org
Cc:     npiggin@gmail.com, urezki@gmail.com, linux-mm@kvack.org,
        linux-kernel@vger.kernel.org, Baoquan He <bhe@redhat.com>
Subject: [PATCH 5/5] mm: ioremap: rename ioremap_page_range() to ioremap_range()
Date:   Mon,  6 Jun 2022 16:39:09 +0800
Message-Id: <20220606083909.363350-6-bhe@redhat.com>
In-Reply-To: <20220606083909.363350-1-bhe@redhat.com>
References: <20220606083909.363350-1-bhe@redhat.com>
MIME-Version: 1.0
Content-type: text/plain
Content-Transfer-Encoding: 8bit
X-Scanned-By: MIMEDefang 2.78 on 10.11.54.3
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_NONE,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Because the current ioremap_page_range() only maps IO address to kernel
virtual address, no struct page pointer passed in or page handling related.
So rename it here.

The renaming is done with below command:
sed -i "s/ioremap_page_range/ioremap_range/g" `git grep -l ioremap_page_range`

Signed-off-by: Baoquan He <bhe@redhat.com>
---
 Documentation/ia64/aliasing.rst  | 2 +-
 arch/alpha/kernel/proto.h        | 2 +-
 arch/arc/mm/ioremap.c            | 2 +-
 arch/arm/mm/ioremap.c            | 6 +++---
 arch/arm64/mm/ioremap.c          | 2 +-
 arch/hexagon/mm/ioremap.c        | 2 +-
 arch/ia64/mm/ioremap.c           | 2 +-
 arch/mips/loongson64/init.c      | 2 +-
 arch/mips/mm/ioremap.c           | 2 +-
 arch/openrisc/mm/ioremap.c       | 2 +-
 arch/parisc/mm/ioremap.c         | 2 +-
 arch/powerpc/kernel/isa-bridge.c | 2 +-
 arch/powerpc/kernel/pci_64.c     | 2 +-
 arch/powerpc/mm/ioremap.c        | 2 +-
 arch/s390/pci/pci.c              | 2 +-
 arch/sh/kernel/cpu/sh4/sq.c      | 2 +-
 arch/sh/mm/ioremap.c             | 2 +-
 arch/x86/mm/ioremap.c            | 2 +-
 arch/xtensa/mm/ioremap.c         | 2 +-
 drivers/pci/pci.c                | 2 +-
 include/linux/io.h               | 4 ++--
 mm/ioremap.c                     | 2 +-
 mm/vmalloc.c                     | 2 +-
 23 files changed, 26 insertions(+), 26 deletions(-)

diff --git a/Documentation/ia64/aliasing.rst b/Documentation/ia64/aliasing.rst
index a08b36aba015..1736be3e9820 100644
--- a/Documentation/ia64/aliasing.rst
+++ b/Documentation/ia64/aliasing.rst
@@ -165,7 +165,7 @@ ioremap()
 
 	If the granule contains non-WB memory, but we can cover the
 	region safely with kernel page table mappings, we can use
-	ioremap_page_range() as most other architectures do.
+	ioremap_range() as most other architectures do.
 
 	Failing all of the above, we have to fall back to a UC mapping.
 
diff --git a/arch/alpha/kernel/proto.h b/arch/alpha/kernel/proto.h
index 5816a31c1b38..7a1aad5f7777 100644
--- a/arch/alpha/kernel/proto.h
+++ b/arch/alpha/kernel/proto.h
@@ -187,7 +187,7 @@ __alpha_remap_area_pages(unsigned long address, unsigned long phys_addr,
 
 	prot = __pgprot(_PAGE_VALID | _PAGE_ASM | _PAGE_KRE
 			| _PAGE_KWE | flags);
-	return ioremap_page_range(address, address + size, phys_addr, prot);
+	return ioremap_range(address, address + size, phys_addr, prot);
 }
 
 /* irq.c */
diff --git a/arch/arc/mm/ioremap.c b/arch/arc/mm/ioremap.c
index 0ee75aca6e10..1b9d6ba7e46a 100644
--- a/arch/arc/mm/ioremap.c
+++ b/arch/arc/mm/ioremap.c
@@ -85,7 +85,7 @@ void __iomem *ioremap_prot(phys_addr_t paddr, unsigned long size,
 		return NULL;
 	area->phys_addr = paddr;
 	vaddr = (unsigned long)area->addr;
-	if (ioremap_page_range(vaddr, vaddr + size, paddr, prot)) {
+	if (ioremap_range(vaddr, vaddr + size, paddr, prot)) {
 		vunmap((void __force *)vaddr);
 		return NULL;
 	}
diff --git a/arch/arm/mm/ioremap.c b/arch/arm/mm/ioremap.c
index 576c0e6c92fc..6c942409f188 100644
--- a/arch/arm/mm/ioremap.c
+++ b/arch/arm/mm/ioremap.c
@@ -110,7 +110,7 @@ void __init add_static_vm_early(struct static_vm *svm)
 int ioremap_page(unsigned long virt, unsigned long phys,
 		 const struct mem_type *mtype)
 {
-	return ioremap_page_range(virt, virt + PAGE_SIZE, phys,
+	return ioremap_range(virt, virt + PAGE_SIZE, phys,
 				  __pgprot(mtype->prot_pte));
 }
 EXPORT_SYMBOL(ioremap_page);
@@ -312,7 +312,7 @@ static void __iomem * __arm_ioremap_pfn_caller(unsigned long pfn,
 		err = remap_area_sections(addr, pfn, size, type);
 	} else
 #endif
-		err = ioremap_page_range(addr, addr + size, paddr,
+		err = ioremap_range(addr, addr + size, paddr,
 					 __pgprot(type->prot_pte));
 
 	if (err) {
@@ -473,7 +473,7 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 	if (res->end > IO_SPACE_LIMIT)
 		return -EINVAL;
 
-	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
+	return ioremap_range(vaddr, vaddr + resource_size(res), phys_addr,
 				  __pgprot(get_mem_type(pci_ioremap_mem_type)->prot_pte));
 }
 EXPORT_SYMBOL(pci_remap_iospace);
diff --git a/arch/arm64/mm/ioremap.c b/arch/arm64/mm/ioremap.c
index b21f91cd830d..573621e7b173 100644
--- a/arch/arm64/mm/ioremap.c
+++ b/arch/arm64/mm/ioremap.c
@@ -52,7 +52,7 @@ static void __iomem *__ioremap_caller(phys_addr_t phys_addr, size_t size,
 	addr = (unsigned long)area->addr;
 	area->phys_addr = phys_addr;
 
-	err = ioremap_page_range(addr, addr + size, phys_addr, prot);
+	err = ioremap_range(addr, addr + size, phys_addr, prot);
 	if (err) {
 		vunmap((void *)addr);
 		return NULL;
diff --git a/arch/hexagon/mm/ioremap.c b/arch/hexagon/mm/ioremap.c
index 255c5b1ee1a7..90a6cd75d1e1 100644
--- a/arch/hexagon/mm/ioremap.c
+++ b/arch/hexagon/mm/ioremap.c
@@ -30,7 +30,7 @@ void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 	area = get_vm_area(size, VM_IOREMAP);
 	addr = (unsigned long)area->addr;
 
-	if (ioremap_page_range(addr, addr+size, phys_addr, prot)) {
+	if (ioremap_range(addr, addr+size, phys_addr, prot)) {
 		vunmap((void *)addr);
 		return NULL;
 	}
diff --git a/arch/ia64/mm/ioremap.c b/arch/ia64/mm/ioremap.c
index 55fd3eb753ff..ef2e52591247 100644
--- a/arch/ia64/mm/ioremap.c
+++ b/arch/ia64/mm/ioremap.c
@@ -86,7 +86,7 @@ ioremap (unsigned long phys_addr, unsigned long size)
 
 		area->phys_addr = phys_addr;
 		addr = (void __iomem *) area->addr;
-		if (ioremap_page_range((unsigned long) addr,
+		if (ioremap_range((unsigned long) addr,
 				(unsigned long) addr + size, phys_addr, prot)) {
 			vunmap((void __force *) addr);
 			return NULL;
diff --git a/arch/mips/loongson64/init.c b/arch/mips/loongson64/init.c
index ee8de1735b7c..53f148522663 100644
--- a/arch/mips/loongson64/init.c
+++ b/arch/mips/loongson64/init.c
@@ -162,7 +162,7 @@ static int __init add_legacy_isa_io(struct fwnode_handle *fwnode, resource_size_
 
 	vaddr = PCI_IOBASE + range->io_start;
 
-	ioremap_page_range(vaddr, vaddr + size, hw_start, pgprot_device(PAGE_KERNEL));
+	ioremap_range(vaddr, vaddr + size, hw_start, pgprot_device(PAGE_KERNEL));
 
 	return 0;
 }
diff --git a/arch/mips/mm/ioremap.c b/arch/mips/mm/ioremap.c
index b6dad2fd5575..b1cfeee648a5 100644
--- a/arch/mips/mm/ioremap.c
+++ b/arch/mips/mm/ioremap.c
@@ -101,7 +101,7 @@ void __iomem *ioremap_prot(phys_addr_t phys_addr, unsigned long size,
 	vaddr = (unsigned long)area->addr;
 
 	flags |= _PAGE_GLOBAL | _PAGE_PRESENT | __READABLE | __WRITEABLE;
-	if (ioremap_page_range(vaddr, vaddr + size, phys_addr,
+	if (ioremap_range(vaddr, vaddr + size, phys_addr,
 			__pgprot(flags))) {
 		free_vm_area(area);
 		return NULL;
diff --git a/arch/openrisc/mm/ioremap.c b/arch/openrisc/mm/ioremap.c
index daae13a76743..f5dc775f5715 100644
--- a/arch/openrisc/mm/ioremap.c
+++ b/arch/openrisc/mm/ioremap.c
@@ -64,7 +64,7 @@ void __iomem *__ref ioremap(phys_addr_t addr, unsigned long size)
 		fixmaps_used += (size >> PAGE_SHIFT);
 	}
 
-	if (ioremap_page_range(v, v + size, p,
+	if (ioremap_range(v, v + size, p,
 			__pgprot(pgprot_val(PAGE_KERNEL) | _PAGE_CI))) {
 		if (likely(mem_init_done))
 			vfree(area->addr);
diff --git a/arch/parisc/mm/ioremap.c b/arch/parisc/mm/ioremap.c
index 345ff0b66499..74c940a70b82 100644
--- a/arch/parisc/mm/ioremap.c
+++ b/arch/parisc/mm/ioremap.c
@@ -80,7 +80,7 @@ void __iomem *ioremap(unsigned long phys_addr, unsigned long size)
 		return NULL;
 
 	addr = (void __iomem *) area->addr;
-	if (ioremap_page_range((unsigned long)addr, (unsigned long)addr + size,
+	if (ioremap_range((unsigned long)addr, (unsigned long)addr + size,
 			       phys_addr, pgprot)) {
 		vunmap(addr);
 		return NULL;
diff --git a/arch/powerpc/kernel/isa-bridge.c b/arch/powerpc/kernel/isa-bridge.c
index dc746611ebc0..0eb13278a96e 100644
--- a/arch/powerpc/kernel/isa-bridge.c
+++ b/arch/powerpc/kernel/isa-bridge.c
@@ -46,7 +46,7 @@ static void remap_isa_base(phys_addr_t pa, unsigned long size)
 	WARN_ON_ONCE(size & ~PAGE_MASK);
 
 	if (slab_is_available()) {
-		if (ioremap_page_range(ISA_IO_BASE, ISA_IO_BASE + size, pa,
+		if (ioremap_range(ISA_IO_BASE, ISA_IO_BASE + size, pa,
 				pgprot_noncached(PAGE_KERNEL)))
 			vunmap_range(ISA_IO_BASE, ISA_IO_BASE + size);
 	} else {
diff --git a/arch/powerpc/kernel/pci_64.c b/arch/powerpc/kernel/pci_64.c
index 19b03ddf5631..7adee5cc58a4 100644
--- a/arch/powerpc/kernel/pci_64.c
+++ b/arch/powerpc/kernel/pci_64.c
@@ -138,7 +138,7 @@ void __iomem *ioremap_phb(phys_addr_t paddr, unsigned long size)
 		return NULL;
 
 	addr = (unsigned long)area->addr;
-	if (ioremap_page_range(addr, addr + size, paddr,
+	if (ioremap_range(addr, addr + size, paddr,
 			pgprot_noncached(PAGE_KERNEL))) {
 		vunmap_range(addr, addr + size);
 		return NULL;
diff --git a/arch/powerpc/mm/ioremap.c b/arch/powerpc/mm/ioremap.c
index 4f12504fb405..0cac4e5c8a8f 100644
--- a/arch/powerpc/mm/ioremap.c
+++ b/arch/powerpc/mm/ioremap.c
@@ -89,7 +89,7 @@ void __iomem *do_ioremap(phys_addr_t pa, phys_addr_t offset, unsigned long size,
 	area->phys_addr = pa;
 	va = (unsigned long)area->addr;
 
-	ret = ioremap_page_range(va, va + size, pa, prot);
+	ret = ioremap_range(va, va + size, pa, prot);
 	if (!ret)
 		return (void __iomem *)area->addr + offset;
 
diff --git a/arch/s390/pci/pci.c b/arch/s390/pci/pci.c
index bc980fd313d5..f0568be4ac4b 100644
--- a/arch/s390/pci/pci.c
+++ b/arch/s390/pci/pci.c
@@ -252,7 +252,7 @@ static void __iomem *__ioremap(phys_addr_t addr, size_t size, pgprot_t prot)
 		return NULL;
 
 	vaddr = (unsigned long) area->addr;
-	if (ioremap_page_range(vaddr, vaddr + size, addr, prot)) {
+	if (ioremap_range(vaddr, vaddr + size, addr, prot)) {
 		free_vm_area(area);
 		return NULL;
 	}
diff --git a/arch/sh/kernel/cpu/sh4/sq.c b/arch/sh/kernel/cpu/sh4/sq.c
index a76b94e41e91..a85f0c05e9d6 100644
--- a/arch/sh/kernel/cpu/sh4/sq.c
+++ b/arch/sh/kernel/cpu/sh4/sq.c
@@ -110,7 +110,7 @@ static int __sq_remap(struct sq_mapping *map, pgprot_t prot)
 
 	vma->phys_addr = map->addr;
 
-	if (ioremap_page_range((unsigned long)vma->addr,
+	if (ioremap_range((unsigned long)vma->addr,
 			       (unsigned long)vma->addr + map->size,
 			       vma->phys_addr, prot)) {
 		vunmap(vma->addr);
diff --git a/arch/sh/mm/ioremap.c b/arch/sh/mm/ioremap.c
index 21342581144d..60a582e5b4f3 100644
--- a/arch/sh/mm/ioremap.c
+++ b/arch/sh/mm/ioremap.c
@@ -132,7 +132,7 @@ __ioremap_caller(phys_addr_t phys_addr, unsigned long size,
 	area->phys_addr = phys_addr;
 	orig_addr = addr = (unsigned long)area->addr;
 
-	if (ioremap_page_range(addr, addr + size, phys_addr, pgprot)) {
+	if (ioremap_range(addr, addr + size, phys_addr, pgprot)) {
 		vunmap((void *)orig_addr);
 		return NULL;
 	}
diff --git a/arch/x86/mm/ioremap.c b/arch/x86/mm/ioremap.c
index 1ad0228f8ceb..0c245f4eaa60 100644
--- a/arch/x86/mm/ioremap.c
+++ b/arch/x86/mm/ioremap.c
@@ -286,7 +286,7 @@ __ioremap_caller(resource_size_t phys_addr, unsigned long size,
 	if (memtype_kernel_map_sync(phys_addr, size, pcm))
 		goto err_free_area;
 
-	if (ioremap_page_range(vaddr, vaddr + size, phys_addr, prot))
+	if (ioremap_range(vaddr, vaddr + size, phys_addr, prot))
 		goto err_free_area;
 
 	ret_addr = (void __iomem *) (vaddr + offset);
diff --git a/arch/xtensa/mm/ioremap.c b/arch/xtensa/mm/ioremap.c
index a400188c16b9..8e914a16c04f 100644
--- a/arch/xtensa/mm/ioremap.c
+++ b/arch/xtensa/mm/ioremap.c
@@ -33,7 +33,7 @@ static void __iomem *xtensa_ioremap(unsigned long paddr, unsigned long size,
 	vaddr = (unsigned long)area->addr;
 	area->phys_addr = paddr;
 
-	err = ioremap_page_range(vaddr, vaddr + size, paddr, prot);
+	err = ioremap_range(vaddr, vaddr + size, paddr, prot);
 
 	if (err) {
 		vunmap((void *)vaddr);
diff --git a/drivers/pci/pci.c b/drivers/pci/pci.c
index cfaf40a540a8..d77219be295d 100644
--- a/drivers/pci/pci.c
+++ b/drivers/pci/pci.c
@@ -4234,7 +4234,7 @@ int pci_remap_iospace(const struct resource *res, phys_addr_t phys_addr)
 	if (res->end > IO_SPACE_LIMIT)
 		return -EINVAL;
 
-	return ioremap_page_range(vaddr, vaddr + resource_size(res), phys_addr,
+	return ioremap_range(vaddr, vaddr + resource_size(res), phys_addr,
 				  pgprot_device(PAGE_KERNEL));
 #else
 	/*
diff --git a/include/linux/io.h b/include/linux/io.h
index 5fc800390fe4..80974fa37d53 100644
--- a/include/linux/io.h
+++ b/include/linux/io.h
@@ -21,10 +21,10 @@ void __ioread32_copy(void *to, const void __iomem *from, size_t count);
 void __iowrite64_copy(void __iomem *to, const void *from, size_t count);
 
 #ifdef CONFIG_MMU
-int ioremap_page_range(unsigned long addr, unsigned long end,
+int ioremap_range(unsigned long addr, unsigned long end,
 		       phys_addr_t phys_addr, pgprot_t prot);
 #else
-static inline int ioremap_page_range(unsigned long addr, unsigned long end,
+static inline int ioremap_range(unsigned long addr, unsigned long end,
 				     phys_addr_t phys_addr, pgprot_t prot)
 {
 	return 0;
diff --git a/mm/ioremap.c b/mm/ioremap.c
index 5fe598ecd9b7..d08b30db332b 100644
--- a/mm/ioremap.c
+++ b/mm/ioremap.c
@@ -33,7 +33,7 @@ void __iomem *ioremap_prot(phys_addr_t addr, size_t size, unsigned long prot)
 		return NULL;
 	vaddr = (unsigned long)area->addr;
 
-	if (ioremap_page_range(vaddr, vaddr + size, addr, __pgprot(prot))) {
+	if (ioremap_range(vaddr, vaddr + size, addr, __pgprot(prot))) {
 		free_vm_area(area);
 		return NULL;
 	}
diff --git a/mm/vmalloc.c b/mm/vmalloc.c
index 860ed9986775..32a18ae16bf5 100644
--- a/mm/vmalloc.c
+++ b/mm/vmalloc.c
@@ -312,7 +312,7 @@ static int vmap_range_noflush(unsigned long addr, unsigned long end,
 	return err;
 }
 
-int ioremap_page_range(unsigned long addr, unsigned long end,
+int ioremap_range(unsigned long addr, unsigned long end,
 		phys_addr_t phys_addr, pgprot_t prot)
 {
 	int err;
-- 
2.34.1

