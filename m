Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6E0B6501C39
	for <lists+linux-kernel@lfdr.de>; Thu, 14 Apr 2022 21:53:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345986AbiDNTyi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 14 Apr 2022 15:54:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:43074 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234846AbiDNTyh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 14 Apr 2022 15:54:37 -0400
Received: from mail.zytor.com (terminus.zytor.com [198.137.202.136])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 30983DA0A9
        for <linux-kernel@vger.kernel.org>; Thu, 14 Apr 2022 12:52:11 -0700 (PDT)
Received: from [IPv6:::1] ([IPv6:2607:fb90:7391:dbf4:ac39:3cd7:6899:402e])
        (authenticated bits=0)
        by mail.zytor.com (8.17.1/8.15.2) with ESMTPSA id 23EJp85B2752024
        (version=TLSv1.3 cipher=TLS_AES_128_GCM_SHA256 bits=128 verify=NO);
        Thu, 14 Apr 2022 12:51:11 -0700
DKIM-Filter: OpenDKIM Filter v2.11.0 mail.zytor.com 23EJp85B2752024
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=zytor.com;
        s=2022040301; t=1649965875;
        bh=/BfbkVBNXXWXvD67lDcz7ZEDHdrIeL3N3o3RiijcK/8=;
        h=Date:From:To:CC:Subject:In-Reply-To:References:From;
        b=Ih1N5WnNg/CUOzYCRiUlmBCjhBc//rksM7yddZRMTFGF8Uocg3oC42OfEA2rSuBaQ
         L5Dme8+oj2fdSEdk/CxJMQPZs/zYnFik3LdwTHGYDohHpZXX6qcFFcvZCs/PB4FMFc
         XmSuFGQW3BgjOHVQbPknw0P2yjwJQXRqaPXHHq0GGsuvwlPEG9YTwI76DZS0zVMXk/
         QlK9c5QdQFKsH5aY9qCbqxzlwred9ckWKCSZJFXav5KgFgy7zjduOSo9pwYkttwNJr
         3LnCQBPB8SFFclqvnQZTPvwAfiwTz3r8s87Q4F+gUiNy4I9rsT68Xuq4xGFjAbzhXv
         kUBJUiDoikUTA==
Date:   Thu, 14 Apr 2022 12:43:33 -0700
From:   "H. Peter Anvin" <hpa@zytor.com>
To:     Oleksandr Tyshchenko <olekstysh@gmail.com>,
        xen-devel@lists.xenproject.org, x86@kernel.org,
        linux-kernel@vger.kernel.org
CC:     Juergen Gross <jgross@suse.com>,
        Dave Hansen <dave.hansen@linux.intel.com>,
        Andy Lutomirski <luto@kernel.org>,
        Peter Zijlstra <peterz@infradead.org>,
        Thomas Gleixner <tglx@linutronix.de>,
        Ingo Molnar <mingo@redhat.com>, Borislav Petkov <bp@alien8.de>,
        Boris Ostrovsky <boris.ostrovsky@oracle.com>,
        Stefano Stabellini <sstabellini@kernel.org>,
        Julien Grall <julien@xen.org>,
        Oleksandr Tyshchenko <oleksandr_tyshchenko@epam.com>
Subject: =?US-ASCII?Q?Re=3A_=5BRFC_PATCH_2/6=5D_virtio=3A_add_optio?= =?US-ASCII?Q?n_to_restrict_memory_access_under_Xen?=
User-Agent: K-9 Mail for Android
In-Reply-To: <1649963973-22879-3-git-send-email-olekstysh@gmail.com>
References: <1649963973-22879-1-git-send-email-olekstysh@gmail.com> <1649963973-22879-3-git-send-email-olekstysh@gmail.com>
Message-ID: <5A795507-715D-494B-B56B-B12E5BE348A4@zytor.com>
MIME-Version: 1.0
Content-Type: text/plain;
 charset=utf-8
Content-Transfer-Encoding: quoted-printable
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On April 14, 2022 12:19:29 PM PDT, Oleksandr Tyshchenko <olekstysh@gmail=2E=
com> wrote:
>From: Juergen Gross <jgross@suse=2Ecom>
>
>In order to support virtio in Xen guests add a config option enabling
>the user to specify whether in all Xen guests virtio should be able to
>access memory via Xen grant mappings only on the host side=2E
>
>This applies to fully virtualized guests only, as for paravirtualized
>guests this is mandatory=2E
>
>This requires to switch arch_has_restricted_virtio_memory_access()
>from a pure stub to a real function on x86 systems (Arm systems are
>not covered by now)=2E
>
>Add the needed functionality by providing a special set of DMA ops
>handling the needed grant operations for the I/O pages=2E
>
>Signed-off-by: Juergen Gross <jgross@suse=2Ecom>
>---
> arch/x86/mm/init=2Ec        |  15 ++++
> arch/x86/mm/mem_encrypt=2Ec |   5 --
> arch/x86/xen/Kconfig      |   9 +++
> drivers/xen/Kconfig       |  20 ++++++
> drivers/xen/Makefile      |   1 +
> drivers/xen/xen-virtio=2Ec  | 177 ++++++++++++++++++++++++++++++++++++++=
++++++++
> include/xen/xen-ops=2Eh     |   8 +++
> 7 files changed, 230 insertions(+), 5 deletions(-)
> create mode 100644 drivers/xen/xen-virtio=2Ec
>
>diff --git a/arch/x86/mm/init=2Ec b/arch/x86/mm/init=2Ec
>index d8cfce2=2E=2E526a3b2 100644
>--- a/arch/x86/mm/init=2Ec
>+++ b/arch/x86/mm/init=2Ec
>@@ -8,6 +8,8 @@
> #include <linux/kmemleak=2Eh>
> #include <linux/sched/task=2Eh>
>=20
>+#include <xen/xen=2Eh>
>+
> #include <asm/set_memory=2Eh>
> #include <asm/e820/api=2Eh>
> #include <asm/init=2Eh>
>@@ -1065,3 +1067,16 @@ unsigned long max_swapfile_size(void)
> 	return pages;
> }
> #endif
>+
>+#ifdef CONFIG_ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>+int arch_has_restricted_virtio_memory_access(void)
>+{
>+	if (IS_ENABLED(CONFIG_XEN_PV_VIRTIO) && xen_pv_domain())
>+		return 1;
>+	if (IS_ENABLED(CONFIG_XEN_HVM_VIRTIO_GRANT) && xen_hvm_domain())
>+		return 1;
>+
>+	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
>+}
>+EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
>+#endif
>diff --git a/arch/x86/mm/mem_encrypt=2Ec b/arch/x86/mm/mem_encrypt=2Ec
>index 50d2099=2E=2Edda020f 100644
>--- a/arch/x86/mm/mem_encrypt=2Ec
>+++ b/arch/x86/mm/mem_encrypt=2Ec
>@@ -77,8 +77,3 @@ void __init mem_encrypt_init(void)
> 	print_mem_encrypt_feature_info();
> }
>=20
>-int arch_has_restricted_virtio_memory_access(void)
>-{
>-	return cc_platform_has(CC_ATTR_GUEST_MEM_ENCRYPT);
>-}
>-EXPORT_SYMBOL_GPL(arch_has_restricted_virtio_memory_access);
>diff --git a/arch/x86/xen/Kconfig b/arch/x86/xen/Kconfig
>index 85246dd=2E=2Edffdffd 100644
>--- a/arch/x86/xen/Kconfig
>+++ b/arch/x86/xen/Kconfig
>@@ -92,3 +92,12 @@ config XEN_DOM0
> 	select X86_X2APIC if XEN_PVH && X86_64
> 	help
> 	  Support running as a Xen Dom0 guest=2E
>+
>+config XEN_PV_VIRTIO
>+	bool "Xen virtio support for PV guests"
>+	depends on XEN_VIRTIO && XEN_PV
>+	default y
>+	help
>+	  Support virtio for running as a paravirtualized guest=2E This will
>+	  need support on the backend side (qemu or kernel, depending on the
>+	  virtio device types used)=2E
>diff --git a/drivers/xen/Kconfig b/drivers/xen/Kconfig
>index 120d32f=2E=2Efc61f7a 100644
>--- a/drivers/xen/Kconfig
>+++ b/drivers/xen/Kconfig
>@@ -335,4 +335,24 @@ config XEN_UNPOPULATED_ALLOC
> 	  having to balloon out RAM regions in order to obtain physical memory
> 	  space to create such mappings=2E
>=20
>+config XEN_VIRTIO
>+	bool "Xen virtio support"
>+	default n
>+	depends on VIRTIO && DMA_OPS
>+	select ARCH_HAS_RESTRICTED_VIRTIO_MEMORY_ACCESS
>+	help
>+	  Enable virtio support for running as Xen guest=2E Depending on the
>+	  guest type this will require special support on the backend side
>+	  (qemu or kernel, depending on the virtio device types used)=2E
>+
>+config XEN_HVM_VIRTIO_GRANT
>+	bool "Require virtio for fully virtualized guests to use grant mappings=
"
>+	depends on XEN_VIRTIO && X86_64
>+	default y
>+	help
>+	  Require virtio for fully virtualized guests to use grant mappings=2E
>+	  This will avoid the need to give the backend the right to map all
>+	  of the guest memory=2E This will need support on the backend side
>+	  (qemu or kernel, depending on the virtio device types used)=2E
>+
> endmenu
>diff --git a/drivers/xen/Makefile b/drivers/xen/Makefile
>index 5aae66e=2E=2E767009c 100644
>--- a/drivers/xen/Makefile
>+++ b/drivers/xen/Makefile
>@@ -39,3 +39,4 @@ xen-gntalloc-y				:=3D gntalloc=2Eo
> xen-privcmd-y				:=3D privcmd=2Eo privcmd-buf=2Eo
> obj-$(CONFIG_XEN_FRONT_PGDIR_SHBUF)	+=3D xen-front-pgdir-shbuf=2Eo
> obj-$(CONFIG_XEN_UNPOPULATED_ALLOC)	+=3D unpopulated-alloc=2Eo
>+obj-$(CONFIG_XEN_VIRTIO)		+=3D xen-virtio=2Eo
>diff --git a/drivers/xen/xen-virtio=2Ec b/drivers/xen/xen-virtio=2Ec
>new file mode 100644
>index 00000000=2E=2Ecfd5eda
>--- /dev/null
>+++ b/drivers/xen/xen-virtio=2Ec
>@@ -0,0 +1,177 @@
>+// SPDX-License-Identifier: GPL-2=2E0-only
>+/***********************************************************************=
*******
>+ * Xen virtio driver - enables using virtio devices in Xen guests=2E
>+ *
>+ * Copyright (c) 2021, Juergen Gross <jgross@suse=2Ecom>
>+ */
>+
>+#include <linux/module=2Eh>
>+#include <linux/dma-map-ops=2Eh>
>+#include <linux/pci=2Eh>
>+#include <linux/pfn=2Eh>
>+#include <linux/virtio_config=2Eh>
>+#include <xen/xen=2Eh>
>+#include <xen/grant_table=2Eh>
>+
>+#define XEN_GRANT_ADDR_OFF	0x8000000000000000ULL
>+
>+static inline dma_addr_t grant_to_dma(grant_ref_t grant)
>+{
>+	return XEN_GRANT_ADDR_OFF | ((dma_addr_t)grant << PAGE_SHIFT);
>+}
>+
>+static inline grant_ref_t dma_to_grant(dma_addr_t dma)
>+{
>+	return (grant_ref_t)((dma & ~XEN_GRANT_ADDR_OFF) >> PAGE_SHIFT);
>+}
>+
>+/*
>+ * DMA ops for Xen virtio frontends=2E
>+ *
>+ * Used to act as a kind of software IOMMU for Xen guests by using grant=
s as
>+ * DMA addresses=2E
>+ * Such a DMA address is formed by using the grant reference as a frame
>+ * number and setting the highest address bit (this bit is for the backe=
nd
>+ * to be able to distinguish it from e=2Eg=2E a mmio address)=2E
>+ *
>+ * Note that for now we hard wire dom0 to be the backend domain=2E In or=
der to
>+ * support any domain as backend we'd need to add a way to communicate t=
he
>+ * domid of this backend, e=2Eg=2E via Xenstore or via the PCI-device's =
config
>+ * space=2E
>+ */
>+static void *xen_virtio_dma_alloc(struct device *dev, size_t size,
>+				  dma_addr_t *dma_handle, gfp_t gfp,
>+				  unsigned long attrs)
>+{
>+	unsigned int n_pages =3D PFN_UP(size);
>+	unsigned int i;
>+	unsigned long pfn;
>+	grant_ref_t grant;
>+	void *ret;
>+
>+	ret =3D (void *)__get_free_pages(gfp, get_order(size));
>+	if (!ret)
>+		return NULL;
>+
>+	pfn =3D virt_to_pfn(ret);
>+
>+	if (gnttab_alloc_grant_reference_seq(n_pages, &grant)) {
>+		free_pages((unsigned long)ret, get_order(size));
>+		return NULL;
>+	}
>+
>+	for (i =3D 0; i < n_pages; i++) {
>+		gnttab_grant_foreign_access_ref(grant + i, 0,
>+						pfn_to_gfn(pfn + i), 0);
>+	}
>+
>+	*dma_handle =3D grant_to_dma(grant);
>+
>+	return ret;
>+}
>+
>+static void xen_virtio_dma_free(struct device *dev, size_t size, void *v=
addr,
>+				dma_addr_t dma_handle, unsigned long attrs)
>+{
>+	unsigned int n_pages =3D PFN_UP(size);
>+	unsigned int i;
>+	grant_ref_t grant;
>+
>+	grant =3D dma_to_grant(dma_handle);
>+
>+	for (i =3D 0; i < n_pages; i++)
>+		gnttab_end_foreign_access_ref(grant + i);
>+
>+	gnttab_free_grant_reference_seq(grant, n_pages);
>+
>+	free_pages((unsigned long)vaddr, get_order(size));
>+}
>+
>+static struct page *xen_virtio_dma_alloc_pages(struct device *dev, size_=
t size,
>+					       dma_addr_t *dma_handle,
>+					       enum dma_data_direction dir,
>+					       gfp_t gfp)
>+{
>+	WARN_ONCE(1, "xen_virtio_dma_alloc_pages size %ld\n", size);
>+	return NULL;
>+}
>+
>+static void xen_virtio_dma_free_pages(struct device *dev, size_t size,
>+				      struct page *vaddr, dma_addr_t dma_handle,
>+				      enum dma_data_direction dir)
>+{
>+	WARN_ONCE(1, "xen_virtio_dma_free_pages size %ld\n", size);
>+}
>+
>+static dma_addr_t xen_virtio_dma_map_page(struct device *dev, struct pag=
e *page,
>+					  unsigned long offset, size_t size,
>+					  enum dma_data_direction dir,
>+					  unsigned long attrs)
>+{
>+	grant_ref_t grant;
>+
>+	if (gnttab_alloc_grant_references(1, &grant))
>+		return 0;
>+
>+	gnttab_grant_foreign_access_ref(grant, 0, xen_page_to_gfn(page),
>+					dir =3D=3D DMA_TO_DEVICE);
>+
>+	return grant_to_dma(grant) + offset;
>+}
>+
>+static void xen_virtio_dma_unmap_page(struct device *dev, dma_addr_t dma=
_handle,
>+				      size_t size, enum dma_data_direction dir,
>+				      unsigned long attrs)
>+{
>+	grant_ref_t grant;
>+
>+	grant =3D dma_to_grant(dma_handle);
>+
>+	gnttab_end_foreign_access_ref(grant);
>+
>+	gnttab_free_grant_reference(grant);
>+}
>+
>+static int xen_virtio_dma_map_sg(struct device *dev, struct scatterlist =
*sg,
>+				 int nents, enum dma_data_direction dir,
>+				 unsigned long attrs)
>+{
>+	WARN_ONCE(1, "xen_virtio_dma_map_sg nents %d\n", nents);
>+	return -EINVAL;
>+}
>+
>+static void xen_virtio_dma_unmap_sg(struct device *dev, struct scatterli=
st *sg,
>+				    int nents, enum dma_data_direction dir,
>+				    unsigned long attrs)
>+{
>+	WARN_ONCE(1, "xen_virtio_dma_unmap_sg nents %d\n", nents);
>+}
>+
>+static int xen_virtio_dma_dma_supported(struct device *dev, u64 mask)
>+{
>+	return 1;
>+}
>+
>+static const struct dma_map_ops xen_virtio_dma_ops =3D {
>+	=2Ealloc =3D xen_virtio_dma_alloc,
>+	=2Efree =3D xen_virtio_dma_free,
>+	=2Ealloc_pages =3D xen_virtio_dma_alloc_pages,
>+	=2Efree_pages =3D xen_virtio_dma_free_pages,
>+	=2Emmap =3D dma_common_mmap,
>+	=2Eget_sgtable =3D dma_common_get_sgtable,
>+	=2Emap_page =3D xen_virtio_dma_map_page,
>+	=2Eunmap_page =3D xen_virtio_dma_unmap_page,
>+	=2Emap_sg =3D xen_virtio_dma_map_sg,
>+	=2Eunmap_sg =3D xen_virtio_dma_unmap_sg,
>+	=2Edma_supported =3D xen_virtio_dma_dma_supported,
>+};
>+
>+void xen_virtio_setup_dma_ops(struct device *dev)
>+{
>+	dev->dma_ops =3D &xen_virtio_dma_ops;
>+}
>+EXPORT_SYMBOL_GPL(xen_virtio_setup_dma_ops);
>+
>+MODULE_DESCRIPTION("Xen virtio support driver");
>+MODULE_AUTHOR("Juergen Gross <jgross@suse=2Ecom>");
>+MODULE_LICENSE("GPL");
>diff --git a/include/xen/xen-ops=2Eh b/include/xen/xen-ops=2Eh
>index a3584a3=2E=2Eae3c1bc 100644
>--- a/include/xen/xen-ops=2Eh
>+++ b/include/xen/xen-ops=2Eh
>@@ -221,4 +221,12 @@ static inline void xen_preemptible_hcall_end(void) {=
 }
>=20
> #endif /* CONFIG_XEN_PV && !CONFIG_PREEMPTION */
>=20
>+#ifdef CONFIG_XEN_VIRTIO
>+void xen_virtio_setup_dma_ops(struct device *dev);
>+#else
>+static inline void xen_virtio_setup_dma_ops(struct device *dev)
>+{
>+}
>+#endif /* CONFIG_XEN_VIRTIO */
>+
> #endif /* INCLUDE_XEN_OPS_H */

Can you please encapsulate the Xen part of the test in some Xen-specific f=
ile?
