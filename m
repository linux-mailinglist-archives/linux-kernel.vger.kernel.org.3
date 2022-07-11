Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A2A795702F0
	for <lists+linux-kernel@lfdr.de>; Mon, 11 Jul 2022 14:43:32 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231577AbiGKMn1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 11 Jul 2022 08:43:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42220 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231695AbiGKMnX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 11 Jul 2022 08:43:23 -0400
Received: from sender4-op-o14.zoho.com (sender4-op-o14.zoho.com [136.143.188.14])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 3C45D322
        for <linux-kernel@vger.kernel.org>; Mon, 11 Jul 2022 05:43:19 -0700 (PDT)
ARC-Seal: i=1; a=rsa-sha256; t=1657542486; cv=none; 
        d=zohomail.com; s=zohoarc; 
        b=B8RlRZ/5yroueJFXiAHVH1mlXjxtZ7t0XswTWYGnM/Dxh5l8JOPEIz7ljR5Aa/TxeNa5yyf1WxcCYlM3rx93ZqQl57gnx74SGa4SOtyBRP02qavN8jkdWkyyGHH72TAbBaf+pfMljGzPQgrIqVpo+NXuLD2Tjc6fOoSE9U7dCGs=
ARC-Message-Signature: i=1; a=rsa-sha256; c=relaxed/relaxed; d=zohomail.com; s=zohoarc; 
        t=1657542486; h=Content-Transfer-Encoding:Cc:Date:From:In-Reply-To:MIME-Version:Message-ID:References:Subject:To; 
        bh=HwXOig16pXGDeKv+H+OhTU1Ct215tHrAf79CKNQ+hsA=; 
        b=XDIgGV3ruxfy1J14mmroPkuFNkuGIoY59s1ss2+hyknDVpObonwV8hBOytDSw4tDH/TIrPGUYux2vhiXsLTDBbgXBPpMiky08KU1RsDr4jxZZbZUoOTnmYiLJ63l1OVnL+Sw5RvzEiAWo4bLog/fCCk0wHoiLKUZoEnE84uIWn0=
ARC-Authentication-Results: i=1; mx.zohomail.com;
        dkim=pass  header.i=linux.beauty;
        spf=pass  smtp.mailfrom=me@linux.beauty;
        dmarc=pass header.from=<me@linux.beauty>
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; t=1657542486;
        s=zmail; d=linux.beauty; i=me@linux.beauty;
        h=From:From:To:To:Cc:Cc:Subject:Subject:Date:Date:Message-Id:Message-Id:In-Reply-To:References:MIME-Version:Content-Transfer-Encoding:Reply-To;
        bh=HwXOig16pXGDeKv+H+OhTU1Ct215tHrAf79CKNQ+hsA=;
        b=WxEl023tQ+yaoo8T9DFz8cyUMyKNEWHQkkzgufuRjMofQV2193zfvzaOQBziHlnJ
        9jyi/fl9b4q/ZmeX1vu20uf9/qUcplHzHVveA2FRFqvL8APO4KHwfXE5qGTfFLc5cQ6
        gBmv8C1AYGxnE7VNsQWL8XbvWvE7pSmThk+EF7Ck=
Received: from sh-lchen.ambarella.net (180.169.129.130 [180.169.129.130]) by mx.zohomail.com
        with SMTPS id 1657542484599946.4016813577733; Mon, 11 Jul 2022 05:28:04 -0700 (PDT)
From:   Li Chen <me@linux.beauty>
To:     Catalin Marinas <catalin.marinas@arm.com>,
        Will Deacon <will@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Frank Rowand <frowand.list@gmail.com>,
        Andrew Morton <akpm@linux-foundation.org>
Cc:     Li Chen <lchen@ambarella.com>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-mm@kvack.org
Subject: [PATCH 1/4] of: add struct page support to rmem
Date:   Mon, 11 Jul 2022 20:24:51 +0800
Message-Id: <20220711122459.13773-2-me@linux.beauty>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220711122459.13773-1-me@linux.beauty>
References: <20220711122459.13773-1-me@linux.beauty>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-ZohoMailClient: External
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Li Chen <lchen@ambarella.com>

This commit add a new config OF_RESERVED_MEM_DIO_SUPPORT and
some utilities to enables consumers to build struct pages on rmem.

Signed-off-by: Li Chen <lchen@ambarella.com>
Change-Id: Iaba8874775c6d3a7096ac19575bb884db13351d1
---
 drivers/of/Kconfig              |   9 ++
 drivers/of/of_reserved_mem.c    | 218 +++++++++++++++++++++++++++++++-
 include/linux/of_reserved_mem.h |  11 ++
 3 files changed, 237 insertions(+), 1 deletion(-)

diff --git a/drivers/of/Kconfig b/drivers/of/Kconfig
index 80b5fd44ab1c..0297c03328d8 100644
--- a/drivers/of/Kconfig
+++ b/drivers/of/Kconfig
@@ -73,6 +73,15 @@ config OF_IRQ
 config OF_RESERVED_MEM
 	def_bool OF_EARLY_FLATTREE
 
+config OF_RESERVED_MEM_DIO_SUPPORT
+	bool "add Direct I/O support to reserved_mem"
+	depends on ZONE_DEVICE && ARCH_KEEP_MEMBLOCK
+	help
+	   By default, reserved memory don't get struct page support, which
+		 means you cannot do Direct I/O from this region. This config takes
+		 uses of ZONE_DEVICE and treats rmem as hotplug mem to get struct
+		 page and DIO support.
+
 config OF_RESOLVE
 	bool
 
diff --git a/drivers/of/of_reserved_mem.c b/drivers/of/of_reserved_mem.c
index 9da8835ba5a5..f4974da6df98 100644
--- a/drivers/of/of_reserved_mem.c
+++ b/drivers/of/of_reserved_mem.c
@@ -72,7 +72,6 @@ void __init fdt_reserved_mem_save_node(unsigned long node, const char *uname,
 	rmem->size = size;
 
 	reserved_mem_count++;
-	return;
 }
 
 /*
@@ -447,3 +446,220 @@ struct reserved_mem *of_reserved_mem_lookup(struct device_node *np)
 	return NULL;
 }
 EXPORT_SYMBOL_GPL(of_reserved_mem_lookup);
+
+/**
+ * get_reserved_mem_from_dev() - get reserved_mem from a device node
+ * @dev: device pointer
+ *
+ * This function look for reserved_mem from given device.
+ *
+ * Returns a reserved_mem pointer, or NULL on error.
+ */
+struct reserved_mem *get_reserved_mem_from_dev(struct device *dev)
+{
+	struct device_node *np = dev_of_node(dev);
+	struct device_node *rmem_np;
+	struct reserved_mem *rmem = NULL;
+
+	rmem_np = of_parse_phandle(np, "memory-region", 0);
+	if (!rmem_np) {
+		dev_err(dev, "failed to get memory region node\n");
+		return ERR_PTR(-ENODEV);
+	}
+
+	rmem = of_reserved_mem_lookup(rmem_np);
+	if (!rmem) {
+		dev_err(dev, "Failed to lookup reserved memory\n");
+		return ERR_PTR(EINVAL);
+	}
+	return rmem;
+}
+EXPORT_SYMBOL_GPL(get_reserved_mem_from_dev);
+
+#ifdef CONFIG_OF_RESERVED_MEM_DIO_SUPPORT
+
+static int reserved_mem_dio_in_region(unsigned long addr,
+				      unsigned long size,
+				      const struct reserved_mem *rmem)
+{
+	if ((rmem && (addr >= rmem->base) &&
+	    ((addr + size) <= (rmem->base + rmem->size))))
+		return 0;
+
+	return -EINVAL;
+}
+
+static int reserved_mem_dio_get_page(struct mm_struct *mm,
+				     unsigned long start,
+				     struct page **page,
+				     const struct reserved_mem *rmem)
+{
+	unsigned long vaddr = start & PAGE_MASK, pfn;
+	int ret = -EFAULT;
+	pgd_t *pgd;
+	pud_t *pud;
+	pmd_t *pmd;
+	pte_t *pte;
+	p4d_t *p4d;
+
+	pgd = pgd_offset(mm, vaddr);
+	if (pgd_none(*pgd))
+		return ret;
+
+	p4d = p4d_offset(pgd, vaddr);
+	if (p4d_none(*p4d))
+		return ret;
+
+	pud = pud_offset(p4d, vaddr);
+	if (pud_none(*pud))
+		return ret;
+
+	pmd = pmd_offset(pud, vaddr);
+	if (pmd_none(*pmd))
+		return ret;
+
+	pte = pte_offset_map(pmd, vaddr);
+	if (pte_none(*pte))
+		goto out;
+
+	pfn = pte_pfn(*pte);
+	if (!pfn_valid(pfn))
+		goto out;
+
+	if (likely(reserved_mem_dio_in_region(pfn << PAGE_SHIFT, PAGE_SIZE, rmem) <
+		   0))
+		goto out;
+
+	if (page) {
+		*page = pfn_to_page(pfn);
+		get_page(*page);
+	}
+
+	ret = 0;
+
+out:
+	pte_unmap(pte);
+	return ret;
+}
+
+static struct page *reserved_mem_dio_find_special_page(struct vm_area_struct *vma,
+						       unsigned long addr)
+{
+	struct page *page = NULL;
+
+	reserved_mem_dio_get_page(vma->vm_mm, addr, &page,
+				  (struct reserved_mem *)vma->vm_private_data);
+	return page;
+}
+
+static const struct vm_operations_struct rmem_dio_vmops = {
+	.find_special_page = reserved_mem_dio_find_special_page,
+};
+
+/**
+ * reserved_mem_dio_mmap() - mmap helper function to map given rmem to userspace
+ *					   with struct pages support
+ * @file: file pointing to address space structure to wait for
+ * @vma:  the vm area in which the mapping is added
+ * @rmem: reserved memory region from dts, which can be obtained from
+ *        get_reserved_mem_from_dev(dev)
+ *
+ * Returns: 0 on success or a negative error-code on failure.
+ */
+int reserved_mem_dio_mmap(struct file *file, struct vm_area_struct *vma, struct reserved_mem *rmem)
+{
+	int ret = 0;
+	unsigned long nr_pages;
+
+	if (!rmem) {
+		pr_err("%s: failed to get rmem from private data\n", __func__);
+		return -ENOMEM;
+	}
+	if (!rmem->pages) {
+		pr_err("%s: failed to get struct pages from reserved mem\n", __func__);
+		return -ENOMEM;
+	}
+
+	if (!rmem->nr_pages) {
+		pr_err("%s: error: rmem nr_pages is 0\n", __func__);
+		return -ENOMEM;
+	}
+
+	if (vma->vm_end - vma->vm_start > rmem->size)
+		return -EINVAL;
+
+	vma->vm_private_data = rmem;
+
+	/* duplicitate nr_pages in that vm_insert_pages can change nr_pages */
+	nr_pages = rmem->nr_pages;
+
+	/*
+	 * use vm_insert_pages instead of add remap_pfn_range variant
+	 * because vm_insert_pages will invoke rmap functions to inc _mapcount,
+	 * while latter don't do it. When unmap,
+	 * kernel will warn if page's _mapcount is <= -1.
+	 */
+	ret = vm_insert_pages(vma, vma->vm_start, rmem->pages, &nr_pages);
+	if (ret < 0)
+		pr_err("%s vm_insert_pages fail, error is %d\n", __func__, ret);
+
+	vma->vm_ops = &rmem_dio_vmops;
+
+	return ret;
+}
+EXPORT_SYMBOL_GPL(reserved_mem_dio_mmap);
+
+/**
+ * reserved_mem_memremap_pages() - build struct pages for reserved mem
+ * @dev: device pointer
+ * @rmem: reserved memory region from dts, which can be get by
+ *        get_reserved_mem_from_dev(dev)
+ *
+ * Returns: 0 on success or a negative error-code on failure.
+ */
+void *reserved_mem_memremap_pages(struct device *dev, struct reserved_mem *rmem)
+{
+	struct dev_pagemap *pgmap_rmem_dio;
+	void *vaddr;
+	struct page **pages;
+	int i;
+	unsigned long offset = 0;
+	struct page *page;
+
+	rmem->nr_pages = DIV_ROUND_UP(rmem->size, PAGE_SIZE);
+	pages = kvmalloc_array(rmem->nr_pages, sizeof(*pages), GFP_KERNEL);
+	if (!pages)
+		return ERR_PTR(-ENOMEM);
+
+	pgmap_rmem_dio = devm_kzalloc(dev, sizeof(*pgmap_rmem_dio), GFP_KERNEL);
+
+	pgmap_rmem_dio->range.start = rmem->base;
+	pgmap_rmem_dio->range.end = rmem->base + rmem->size - 1;
+	pgmap_rmem_dio->nr_range = 1;
+	pgmap_rmem_dio->type = MEMORY_DEVICE_GENERIC;
+
+	pr_debug("%s, will do devm_memremap_pages, start from %llx, to %llx\n",
+		 __func__, pgmap_rmem_dio->range.start, pgmap_rmem_dio->range.end);
+
+	vaddr = devm_memremap_pages(dev, pgmap_rmem_dio);
+
+	if (IS_ERR_OR_NULL(vaddr)) {
+		dev_err(dev, "%s %d: %ld", __func__, __LINE__, PTR_ERR(vaddr));
+		return vaddr;
+	}
+
+	rmem->pages = pages;
+
+	for (i = 0; i < rmem->nr_pages; offset += PAGE_SIZE) {
+		page = virt_to_page((unsigned long)vaddr + offset);
+		if (!page) {
+			pr_err("%s: virt_to_page fail\n", __func__);
+			return ERR_PTR(-ENOMEM);
+		}
+		pages[i++] = page;
+	}
+
+	return vaddr;
+}
+EXPORT_SYMBOL_GPL(reserved_mem_memremap_pages);
+#endif
diff --git a/include/linux/of_reserved_mem.h b/include/linux/of_reserved_mem.h
index 4de2a24cadc9..0aa1ef883060 100644
--- a/include/linux/of_reserved_mem.h
+++ b/include/linux/of_reserved_mem.h
@@ -16,6 +16,10 @@ struct reserved_mem {
 	phys_addr_t			base;
 	phys_addr_t			size;
 	void				*priv;
+#ifdef CONFIG_OF_RESERVED_MEM_DIO_SUPPORT
+	struct page                     **pages; /* point to array of struct pages of this region */
+	unsigned long                   nr_pages; /* number of struct page* */
+#endif
 };
 
 struct reserved_mem_ops {
@@ -81,4 +85,11 @@ static inline int of_reserved_mem_device_init(struct device *dev)
 	return of_reserved_mem_device_init_by_idx(dev, dev->of_node, 0);
 }
 
+struct reserved_mem *get_reserved_mem_from_dev(struct device *dev);
+
+#ifdef CONFIG_OF_RESERVED_MEM_DIO_SUPPORT
+int reserved_mem_dio_mmap(struct file *file, struct vm_area_struct *vma, struct reserved_mem *rmem);
+void *reserved_mem_memremap_pages(struct device *dev, struct reserved_mem *rmem);
+#endif
+
 #endif /* __OF_RESERVED_MEM_H */
-- 
2.25.1

