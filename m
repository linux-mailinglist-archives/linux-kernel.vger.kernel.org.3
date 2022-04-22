Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id F360950BD9A
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 18:51:58 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1449912AbiDVQyl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 12:54:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1444743AbiDVQyT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 12:54:19 -0400
Received: from mail-lf1-x133.google.com (mail-lf1-x133.google.com [IPv6:2a00:1450:4864:20::133])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE3655F8E1
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:51:24 -0700 (PDT)
Received: by mail-lf1-x133.google.com with SMTP id y32so15294044lfa.6
        for <linux-kernel@vger.kernel.org>; Fri, 22 Apr 2022 09:51:24 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=o6f6b9Ed2EOTSIl43sWJ1e4CyXkESkrVfEWzvoot9Wk=;
        b=mAUA9xma+eay/TnfhAP6yaN1yv/vOdxInTPx3XbLjEy67v+x1BSm6nrFpg3Cj2/Dun
         JDvJobIjZFNimuCmWOJGHF2Le3njiIeAjD0jp8RVAlb/iCh309R96+lQzF2+nuZKgkRo
         1FI1ChP7jLX3bOf7kgAEAud9NHv6fDGSG+IC/DNbDJzeHAH1za4wBtv5HDezvWv4L78w
         Q0fxrK8rqC6zcO7os3J4orGrGe2ijTtjKZWKjd19vxXdpKlIlXZV9VX1aTikdRNH5PqF
         NA1+MdqActyKZ9hxk5RzK2Hv61ZFl+PWOsltfbV4YX7aMBHEo3Ftue6aABERdx8ACvKS
         HL9Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=o6f6b9Ed2EOTSIl43sWJ1e4CyXkESkrVfEWzvoot9Wk=;
        b=v/Qp7HCxw+00wBuY19dNGP+pdygLdXnUsyGWVrE6P9s03V73MvVlBrM9STM8EbYj+Q
         Ag3ZeCgKL3UisTMBdenvpZQ7Q7XZr+fMrWnnKUOFhAJYhEY9D2MBkCFYjogVta4ijkR/
         SNFiEdvB0brKs/XIEfQuDKRPIjFnunyM8Kbi9xwuVQfeJervPRWniLBA4zLdnbjRjEeR
         fitHaYwnH8JwBVgyKnhpM+q14Cp66fuJoBx9xogqrGDvNtvqIUF/E6BR1jemKtAYmmUC
         3EySPR3PtzWtU9b/TWqFH0k/0zcYE1LT3DPgLLg26yCYmBEo6KdEtv0dz/c/AqavzjRE
         F6gw==
X-Gm-Message-State: AOAM5303bIB0mXvqS0lOCJq5obFtmfnXp/DkcoKnsIfCn5+UyJ2LSgLu
        RuvTdbbxqO04hdUDeBaH80I=
X-Google-Smtp-Source: ABdhPJxUulQza4XzwHS+vn+t0JcKH1tSxdalQ0Xh720bOQBE/5H0dXKzgQ/JULuYgnjvPsZUQgNOsg==
X-Received: by 2002:a05:6512:2385:b0:470:6e19:7ec8 with SMTP id c5-20020a056512238500b004706e197ec8mr3580179lfv.303.1650646282914;
        Fri, 22 Apr 2022 09:51:22 -0700 (PDT)
Received: from otyshchenko.router ([212.22.223.21])
        by smtp.gmail.com with ESMTPSA id n2-20020a056512310200b0046e2f507a3asm279742lfb.167.2022.04.22.09.51.21
        (version=TLS1_2 cipher=ECDHE-ECDSA-AES128-GCM-SHA256 bits=128/128);
        Fri, 22 Apr 2022 09:51:22 -0700 (PDT)
From:   Oleksandr Tyshchenko <olekstysh@gmail.com>
To:     xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-kernel@lists.infradead.org
Cc:     Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        "H. Peter Anvin" <hpa@zytor.com>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>,
        "Michael S. Tsirkin" <mst@redhat.com>,
        Christoph Hellwig <hch@infradead.org>
Subject: [PATCH V1 3/6] xen/virtio: Add option to restrict memory access under Xen
Date:   Fri, 22 Apr 2022 19:51:00 +0300
Message-Id: <1650646263-22047-4-git-send-email-olekstysh@gmail.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
References: <1650646263-22047-1-git-send-email-olekstysh@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Juergen Gross <jgross@suse.com>

Introduce Xen grant DMA-mapping layer which contains special DMA-mapping
routines for providing grant references as DMA addresses to be used by
frontends (e.g. virtio) in Xen guests.

In order to support virtio in Xen guests add a config option XEN_VIRTIO
enabling the user to specify whether in all Xen guests virtio should
be able to access memory via Xen grant mappings only on the host side.

As this also requires providing arch_has_restricted_virtio_memory_access
implementation, switch from a pure stub to a real function on Arm
and combine with existing implementation for the SEV guests on x86.

Add the needed functionality by providing a special set of DMA ops
handling the needed grant operations for the I/O pages.

Signed-off-by: Juergen Gross <jgross@suse.com>
Signed-off-by: Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
---
Changes RFC -> V1:
   - squash with almost all changes from commit (except handling "xen,dev-domid"
     property):
     "[PATCH 4/6] virtio: Various updates to xen-virtio DMA ops layer"
   - update commit subject/description and comments in code
   - leave only single Kconfig option XEN_VIRTIO and remove architectural
     dependencies
   - introduce common xen_has_restricted_virtio_memory_access() in xen.h
     and update arch_has_restricted_virtio_memory_access() for both
     Arm and x86 to call new helper
   - use (1ULL << 63) instead of 0x8000000000000000ULL for XEN_GRANT_ADDR_OFF
   - implement xen_virtio_dma_map(unmap)_sg() using example in swiotlb-xen.c
   - optimize padding by moving "broken" field in struct xen_virtio_data
   - remove unneeded per-device spinlock
   - remove the inclusion of virtio_config.h
   - remane everything according to the new naming scheme:
     s/virtio/grant_dma
   - add new hidden config option XEN_GRANT_DMA_OPS
---
 arch/arm/xen/enlighten.c    |   8 ++
 arch/x86/mm/init.c          |  11 ++
 arch/x86/mm/mem_encrypt.c   |   5 -
 drivers/xen/Kconfig         |  15 +++
 drivers/xen/Makefile        |   1 +
 drivers/xen/grant-dma-ops.c | 317 ++++++++++++++++++++++++++++++++++++++++++++
 include/xen/xen-ops.h       |   8 ++
 include/xen/xen.h           |   5 +
 8 files changed, 365 insertions(+), 5 deletions(-)
 create mode 100644 drivers/xen/grant-dma-ops.c

diff --git a/arch/arm/xen/enlighten.c b/arch/arm/xen/enlighten.c
index ec5b082..49af493 100644
--- a/arch/arm/xen/enlighten.c
+++ b/arch/arm/xen/enlighten.c
@@ -409,6 +409,14 @@ int __init arch_xen_unpopulated_init(struct resource **res)
 }
 #endif
 
+#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+int arch_has_restricted_virtio_memory_access(void)
+{
+	return xen_has_restricted_virtio_memory_access();
+}
+EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
+#endif
+
 static void __init xen_dt_guest_init(void)
 {
 	struct device_node *xen_node;
diff --git a/arch/x86/mm/init.c b/arch/x86/mm/init.c
index d8cfce2..fe84a3e 100644
--- a/arch/x86/mm/init.c
+++ b/arch/x86/mm/init.c
@@ -8,6 +8,8 @@
 #include <linux/kmemleak.h>
 #include <linux/sched/task.h>
 
+#include <xen/xen.h>
+
 #include <asm/set_memory.h>
 #include <asm/e820/api.h>
 #include <asm/init.h>
@@ -1065,3 +1067,12 @@ unsigned long max_swapfile_size(void)
 	return pages;
 }
 #endif
+
+#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+int arch_has_restricted_virtio_memory_access(void)
+{
+	return (xen_has_restricted_virtio_memory_access() ||
+			cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT));
+}
+EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
+#endif
diff --git a/arch/x86/mm/mem_encrypt.c b/arch/x86/mm/mem_encrypt.c
index 50d2099..dda020f 100644
--- a/arch/x86/mm/mem_encrypt.c
+++ b/arch/x86/mm/mem_encrypt.c
@@ -77,8 +77,3 @@ void __init mem_encrypt_init(void)
 	print_mem_encrypt_feature_info();
 }
 
-int arch_has_restricted_virtio_memory_access(void)
-{
-	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
-}
-EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
index 120d32f..b95581f 100644
--- a/drivers/xen/Kconfig
+++ b/drivers/xen/Kconfig
@@ -335,4 +335,19 @@ config XEN_UNPOPULATED_ALLOC
 	  having to balloon out RAM regions in order to obtain physical memory
 	  space to create such mappings.
 
+config XEN_GRANT_DMA_OPS
+	bool
+	select DMA_OPS
+
+config XEN_VIRTIO
+	bool "Xen virtio support"
+	default n
+	depends on VIRTIO
+	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
+	select XEN_GRANT_DMA_OPS
+	help
+	  Enable virtio support for running as Xen guest. Depending on the
+	  guest type this will require special support on the backend side
+	  (qemu or kernel, depending on the virtio device types used).
+
 endmenu
diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
index 5aae66e..1a23cb0 100644
--- a/drivers/xen/Makefile
+++ b/drivers/xen/Makefile
@@ -39,3 +39,4 @@ xen-gntalloc-y				:= gntalloc.o
 xen-privcmd-y				:= privcmd.o privcmd-buf.o
 obj-$(CONFIG_XEN_FRONT_PGDIR_SHBUF)	+= xen-front-pgdir-shbuf.o
 obj-$(CONFIG_XEN_UNPOPULATED_ALLOC)	+= unpopulated-alloc.o
+obj-$(CONFIG_XEN_GRANT_DMA_OPS)		+= grant-dma-ops.o
diff --git a/drivers/xen/grant-dma-ops.c b/drivers/xen/grant-dma-ops.c
new file mode 100644
index 00000000..0e69aa8
--- /dev/null
+++ b/drivers/xen/grant-dma-ops.c
@@ -0,0 +1,317 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/******************************************************************************
+ * Xen grant DMA-mapping layer - contains special DMA-mapping routines
+ * for providing grant references as DMA addresses to be used by frontends
+ * (e.g. virtio) in Xen guests
+ *
+ * Copyright (c) 2021, Juergen Gross <jgross@suse.com>
+ */
+
+#include <linux/module.h>
+#include <linux/dma-map-ops.h>
+#include <linux/of.h>
+#include <linux/pci.h>
+#include <linux/pfn.h>
+#include <xen/xen.h>
+#include <xen/grant_table.h>
+
+struct xen_grant_dma_data {
+	/* The ID of backend domain */
+	domid_t dev_domid;
+	/* Is device behaving sane? */
+	bool broken;
+	struct device *dev;
+	struct list_head list;
+};
+
+static LIST_HEAD(xen_grant_dma_devices);
+static DEFINE_SPINLOCK(xen_grant_dma_lock);
+
+#define XEN_GRANT_DMA_ADDR_OFF	(1ULL << 63)
+
+static inline dma_addr_t grant_to_dma(grant_ref_t grant)
+{
+	return XEN_GRANT_DMA_ADDR_OFF | ((dma_addr_t)grant << PAGE_SHIFT);
+}
+
+static inline grant_ref_t dma_to_grant(dma_addr_t dma)
+{
+	return (grant_ref_t)((dma & ~XEN_GRANT_DMA_ADDR_OFF) >> PAGE_SHIFT);
+}
+
+static struct xen_grant_dma_data *find_xen_grant_dma_data(struct device *dev)
+{
+	struct xen_grant_dma_data *data = NULL;
+	bool found = false;
+
+	spin_lock(&xen_grant_dma_lock);
+
+	list_for_each_entry(data, &xen_grant_dma_devices, list) {
+		if (data->dev == dev) {
+			found = true;
+			break;
+		}
+	}
+
+	spin_unlock(&xen_grant_dma_lock);
+
+	return found ? data : NULL;
+}
+
+/*
+ * DMA ops for Xen frontends (e.g. virtio).
+ *
+ * Used to act as a kind of software IOMMU for Xen guests by using grants as
+ * DMA addresses.
+ * Such a DMA address is formed by using the grant reference as a frame
+ * number and setting the highest address bit (this bit is for the backend
+ * to be able to distinguish it from e.g. a mmio address).
+ *
+ * Note that for now we hard wire dom0 to be the backend domain. In order
+ * to support any domain as backend we'd need to add a way to communicate
+ * the domid of this backend, e.g. via Xenstore, via the PCI-device's
+ * config space or DT/ACPI.
+ */
+static void *xen_grant_dma_alloc(struct device *dev, size_t size,
+				 dma_addr_t *dma_handle, gfp_t gfp,
+				 unsigned long attrs)
+{
+	struct xen_grant_dma_data *data;
+	unsigned int i, n_pages = PFN_UP(size);
+	unsigned long pfn;
+	grant_ref_t grant;
+	void *ret;
+
+	data = find_xen_grant_dma_data(dev);
+	if (!data)
+		return NULL;
+
+	if (unlikely(data->broken))
+		return NULL;
+
+	ret = alloc_pages_exact(n_pages * PAGE_SIZE, gfp);
+	if (!ret)
+		return NULL;
+
+	pfn = virt_to_pfn(ret);
+
+	if (gnttab_alloc_grant_reference_seq(n_pages, &grant)) {
+		free_pages_exact(ret, n_pages * PAGE_SIZE);
+		return NULL;
+	}
+
+	for (i = 0; i < n_pages; i++) {
+		gnttab_grant_foreign_access_ref(grant + i, data->dev_domid,
+				pfn_to_gfn(pfn + i), 0);
+	}
+
+	*dma_handle = grant_to_dma(grant);
+
+	return ret;
+}
+
+static void xen_grant_dma_free(struct device *dev, size_t size, void *vaddr,
+			       dma_addr_t dma_handle, unsigned long attrs)
+{
+	struct xen_grant_dma_data *data;
+	unsigned int i, n_pages = PFN_UP(size);
+	grant_ref_t grant;
+
+	data = find_xen_grant_dma_data(dev);
+	if (!data)
+		return;
+
+	if (unlikely(data->broken))
+		return;
+
+	grant = dma_to_grant(dma_handle);
+
+	for (i = 0; i < n_pages; i++) {
+		if (unlikely(!gnttab_end_foreign_access_ref(grant + i))) {
+			dev_alert(dev, "Grant still in use by backend domain, disabled for further use\n");
+			data->broken = true;
+			return;
+		}
+	}
+
+	gnttab_free_grant_reference_seq(grant, n_pages);
+
+	free_pages_exact(vaddr, n_pages * PAGE_SIZE);
+}
+
+static struct page *xen_grant_dma_alloc_pages(struct device *dev, size_t size,
+					      dma_addr_t *dma_handle,
+					      enum dma_data_direction dir,
+					      gfp_t gfp)
+{
+	WARN_ONCE(1, "xen_grant_dma_alloc_pages size %zu\n", size);
+	return NULL;
+}
+
+static void xen_grant_dma_free_pages(struct device *dev, size_t size,
+				     struct page *vaddr, dma_addr_t dma_handle,
+				     enum dma_data_direction dir)
+{
+	WARN_ONCE(1, "xen_grant_dma_free_pages size %zu\n", size);
+}
+
+static dma_addr_t xen_grant_dma_map_page(struct device *dev, struct page *page,
+					 unsigned long offset, size_t size,
+					 enum dma_data_direction dir,
+					 unsigned long attrs)
+{
+	struct xen_grant_dma_data *data;
+	unsigned int i, n_pages = PFN_UP(size);
+	grant_ref_t grant;
+	dma_addr_t dma_handle;
+
+	BUG_ON(dir == DMA_NONE);
+
+	data = find_xen_grant_dma_data(dev);
+	if (!data)
+		return DMA_MAPPING_ERROR;
+
+	if (unlikely(data->broken))
+		return DMA_MAPPING_ERROR;
+
+	if (gnttab_alloc_grant_reference_seq(n_pages, &grant))
+		return DMA_MAPPING_ERROR;
+
+	for (i = 0; i < n_pages; i++) {
+		gnttab_grant_foreign_access_ref(grant + i, data->dev_domid,
+				xen_page_to_gfn(page) + i, dir == DMA_TO_DEVICE);
+	}
+
+	dma_handle = grant_to_dma(grant) + offset;
+
+	return dma_handle;
+}
+
+static void xen_grant_dma_unmap_page(struct device *dev, dma_addr_t dma_handle,
+				     size_t size, enum dma_data_direction dir,
+				     unsigned long attrs)
+{
+	struct xen_grant_dma_data *data;
+	unsigned int i, n_pages = PFN_UP(size);
+	grant_ref_t grant;
+
+	BUG_ON(dir == DMA_NONE);
+
+	data = find_xen_grant_dma_data(dev);
+	if (!data)
+		return;
+
+	if (unlikely(data->broken))
+		return;
+
+	grant = dma_to_grant(dma_handle);
+
+	for (i = 0; i < n_pages; i++) {
+		if (unlikely(!gnttab_end_foreign_access_ref(grant + i))) {
+			dev_alert(dev, "Grant still in use by backend domain, disabled for further use\n");
+			data->broken = true;
+			return;
+		}
+	}
+
+	gnttab_free_grant_reference_seq(grant, n_pages);
+}
+
+static void xen_grant_dma_unmap_sg(struct device *dev, struct scatterlist *sg,
+				   int nents, enum dma_data_direction dir,
+				   unsigned long attrs)
+{
+	struct scatterlist *s;
+	unsigned int i;
+
+	BUG_ON(dir == DMA_NONE);
+
+	for_each_sg(sg, s, nents, i)
+		xen_grant_dma_unmap_page(dev, s->dma_address, sg_dma_len(s), dir,
+				attrs);
+}
+
+static int xen_grant_dma_map_sg(struct device *dev, struct scatterlist *sg,
+				int nents, enum dma_data_direction dir,
+				unsigned long attrs)
+{
+	struct scatterlist *s;
+	unsigned int i;
+
+	BUG_ON(dir == DMA_NONE);
+
+	for_each_sg(sg, s, nents, i) {
+		s->dma_address = xen_grant_dma_map_page(dev, sg_page(s), s->offset,
+				s->length, dir, attrs);
+		if (s->dma_address == DMA_MAPPING_ERROR)
+			goto out;
+
+		sg_dma_len(s) = s->length;
+	}
+
+	return nents;
+
+out:
+	xen_grant_dma_unmap_sg(dev, sg, i, dir, attrs | DMA_ATTR_SKIP_CPU_SYNC);
+	sg_dma_len(sg) = 0;
+
+	return -EIO;
+}
+
+static int xen_grant_dma_supported(struct device *dev, u64 mask)
+{
+	return mask == DMA_BIT_MASK(64);
+}
+
+static const struct dma_map_ops xen_grant_dma_ops = {
+	.alloc = xen_grant_dma_alloc,
+	.free = xen_grant_dma_free,
+	.alloc_pages = xen_grant_dma_alloc_pages,
+	.free_pages = xen_grant_dma_free_pages,
+	.mmap = dma_common_mmap,
+	.get_sgtable = dma_common_get_sgtable,
+	.map_page = xen_grant_dma_map_page,
+	.unmap_page = xen_grant_dma_unmap_page,
+	.map_sg = xen_grant_dma_map_sg,
+	.unmap_sg = xen_grant_dma_unmap_sg,
+	.dma_supported = xen_grant_dma_supported,
+};
+
+void xen_grant_setup_dma_ops(struct device *dev)
+{
+	struct xen_grant_dma_data *data;
+	uint32_t dev_domid;
+
+	data = find_xen_grant_dma_data(dev);
+	if (data) {
+		dev_err(dev, "Xen grant DMA data is already created\n");
+		return;
+	}
+
+	/* XXX The dom0 is hardcoded as the backend domain for now */
+	dev_domid = 0;
+
+	data = devm_kzalloc(dev, sizeof(*data), GFP_KERNEL);
+	if (!data) {
+		dev_err(dev, "Сannot allocate Xen grant DMA data\n");
+		goto err;
+	}
+	data->dev_domid = dev_domid;
+	data->dev = dev;
+
+	spin_lock(&xen_grant_dma_lock);
+	list_add(&data->list, &xen_grant_dma_devices);
+	spin_unlock(&xen_grant_dma_lock);
+
+	dev->dma_ops = &xen_grant_dma_ops;
+
+	return;
+
+err:
+	dev_err(dev, "Сannot set up Xen grant DMA ops, retain platform DMA ops\n");
+}
+EXPORT_SYMBOL_GPL(xen_grant_setup_dma_ops);
+
+MODULE_DESCRIPTION("Xen grant DMA-mapping layer");
+MODULE_AUTHOR("Juergen Gross <jgross@suse.com>");
+MODULE_LICENSE("GPL");
diff --git a/include/xen/xen-ops.h b/include/xen/xen-ops.h
index a3584a3..4f9fad5 100644
--- a/include/xen/xen-ops.h
+++ b/include/xen/xen-ops.h
@@ -221,4 +221,12 @@ static inline void xen_preemptible_hcall_end(void) { }
 
 #endif /* CONFIG_XEN_PV && !CONFIG_PREEMPTION */
 
+#ifdef CONFIG_XEN_GRANT_DMA_OPS
+void xen_grant_setup_dma_ops(struct device *dev);
+#else
+static inline void xen_grant_setup_dma_ops(struct device *dev)
+{
+}
+#endif /* CONFIG_XEN_GRANT_DMA_OPS */
+
 #endif /* INCLUDE_XEN_OPS_H */
diff --git a/include/xen/xen.h b/include/xen/xen.h
index a99bab8..fe6e6bb 100644
--- a/include/xen/xen.h
+++ b/include/xen/xen.h
@@ -52,6 +52,11 @@ bool xen_biovec_phys_mergeable(const struct bio_vec *vec1,
 extern u64 xen_saved_max_mem_size;
 #endif
 
+static inline int xen_has_restricted_virtio_memory_access(void)
+{
+	return IS_ENABLED(CONFIG_XEN_VIRTIO) && xen_domain();
+}
+
 #ifdef CONFIG_XEN_UNPOPULATED_ALLOC
 int xen_alloc_unpopulated_pages(unsigned int nr_pages, struct page **pages);
 void xen_free_unpopulated_pages(unsigned int nr_pages, struct page **pages);
-- 
2.7.4

