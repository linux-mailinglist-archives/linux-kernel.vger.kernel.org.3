Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id D891C4E22E0
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Mar 2022 10:03:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345659AbiCUJD6 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 21 Mar 2022 05:03:58 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41570 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345604AbiCUJDm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 21 Mar 2022 05:03:42 -0400
Received: from mailout4.samsung.com (mailout4.samsung.com [203.254.224.34])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A664491541
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 02:02:12 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout4.samsung.com (KnoxPortal) with ESMTP id 20220321090211epoutp04419962b38f13690a3cb2e811f0c2e156~eWd_2LGlO2491924919epoutp04j
        for <linux-kernel@vger.kernel.org>; Mon, 21 Mar 2022 09:02:11 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout4.samsung.com 20220321090211epoutp04419962b38f13690a3cb2e811f0c2e156~eWd_2LGlO2491924919epoutp04j
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1647853331;
        bh=Y12NnJmI0Qq6xZu4BblXFh/Tz0cs/jb2DFHh+5RbQhc=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=CeJd9wSbA0NCM25JQEQdzAFkm1FRVhb/g9a/VvVjfpfXY50An/nKCszX/W0bx4AJt
         w6PnR7b9nAwfN38EMFxEkF/sqFGTXave7FClQzjAozJdLkvjAjiPNrusv18UubZqv8
         DJ1O57tjrzX32KDQ9RBM24d2lQZ4cfMy7L/OansM=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220321090210epcas2p48b9b43c3b23d86f55a5395be28938eb3~eWd_S9T3c0733307333epcas2p4N;
        Mon, 21 Mar 2022 09:02:10 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.92]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KMTC36xrsz4x9QQ; Mon, 21 Mar
        2022 09:02:07 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        2A.C7.33036.E0F38326; Mon, 21 Mar 2022 18:02:06 +0900 (KST)
Received: from epsmtrp2.samsung.com (unknown [182.195.40.14]) by
        epcas2p1.samsung.com (KnoxPortal) with ESMTPA id
        20220321090205epcas2p15ac16f281554b663062e0e31666defab~eWd6FyyYH1490814908epcas2p1D;
        Mon, 21 Mar 2022 09:02:05 +0000 (GMT)
Received: from epsmgms1p2.samsung.com (unknown [182.195.42.42]) by
        epsmtrp2.samsung.com (KnoxPortal) with ESMTP id
        20220321090205epsmtrp21d0988bcbabfe2f6ddc6818dd428839c~eWd6FAQXA0169601696epsmtrp2E;
        Mon, 21 Mar 2022 09:02:05 +0000 (GMT)
X-AuditID: b6c32a48-4fbff7000000810c-99-62383f0e6694
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p2.samsung.com (Symantec Messaging Gateway) with SMTP id
        53.F7.03370.D0F38326; Mon, 21 Mar 2022 18:02:05 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [12.36.155.120]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220321090205epsmtip289ba9c556ae55711b90ca4862350e8a0~eWd525YP61528315283epsmtip28;
        Mon, 21 Mar 2022 09:02:05 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com
Subject: [PATCH v3 4/4] usb: host: add xhci-exynos driver
Date:   Mon, 21 Mar 2022 17:59:54 +0900
Message-Id: <1647853194-62147-5-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFnrLKsWRmVeSWpSXmKPExsWy7bCmqS6fvUWSwfMmEYs7C6YxWTw5sojd
        onnxejaL63/eM1q0P7/AZnF51xw2i0XLWpktmjdNYbWYuVbZouvuDUYHLo/Lfb1MHgs2lXos
        3vOSyWP/3DXsHn1bVjF6fN4kF8AWlW2TkZqYklqkkJqXnJ+SmZduq+QdHO8cb2pmYKhraGlh
        rqSQl5ibaqvk4hOg65aZA3SYkkJZYk4pUCggsbhYSd/Opii/tCRVISO/uMRWKbUgJafAvECv
        ODG3uDQvXS8vtcTK0MDAyBSoMCE74/vD1cwFK94yVmz6fZ25gXHXUcYuRk4OCQETif//W9i7
        GLk4hAR2MEp0frzOAuF8YpS4sbQdKvOZUeLk242sMC3bjj1jB7GFBHYxStw5IAxh/2CU2Pkx
        rIuRg4NNQEvi+0KwDSICcRJLOy8xgcxhFljNJPH+40U2kISwgKXExZ9dLCD1LAKqEi2bPUDC
        vAKuEkeXbGOCWCUncfNcJzOIzSngJrH2ZiPYcRICL9klWvfeYIcocpFY9O0w1G3CEq+Ob4GK
        S0l8freXDcIultj1qZUJormBUaLxwQlmiISxxKxn7YwgRzALaEqs36UPYkoIKEscucUCUsEs
        wCfRcfgvO0SYV6KjTQiiUVli+uUJUFslJQ6+Pgc10ENi+rfjLJAQmckoceak6QRGuVkI8xcw
        Mq5iFEstKM5NTy02KjCBR1hyfu4mRnC60/LYwTj77Qe9Q4xMHIyHGCU4mJVEeBd/ME8S4k1J
        rKxKLcqPLyrNSS0+xGgKDLqJzFKiyfnAhJtXEm9oYmlgYmZmaG5kamCuJM7rlbIhUUggPbEk
        NTs1tSC1CKaPiYNTqoGJi1sxQ1rTTeznf/EF+ev69pqcWee7Iq7n7sItrE1sYnFS93bHutuk
        PTsbMENbPaOxv+q+6LkFC+PfaS/RXvJpo4yOkJP/B60bu+unb5tZsH5yZmGpoOtDwbjMiT7l
        HG62Hw6L89Vfkdc0zlnfzKHNXPW3W1LA/877uTb7VEznOx83uJaS2tBXfeCPFtcG1dj9S1eJ
        +m2r5NrCHbrY/MnD2bJ7T3x3n678xoLZ1aag2cnwo86RHH7h5VdeTeDimuJrebLCcUVRbNIc
        6dyqefv23+OQ3P1Rxuwey3v15M23peyq+5gPt1lx/9aNidvl4br9ddIrQ6a9CZI+fHuFNN3u
        1e74w/ZtKs+z/Gcs4UosxRmJhlrMRcWJANkkg1gABAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFlrBLMWRmVeSWpSXmKPExsWy7bCSvC6vvUWSwfNWI4s7C6YxWTw5sojd
        onnxejaL63/eM1q0P7/AZnF51xw2i0XLWpktmjdNYbWYuVbZouvuDUYHLo/Lfb1MHgs2lXos
        3vOSyWP/3DXsHn1bVjF6fN4kF8AWxWWTkpqTWZZapG+XwJXx/eFq5oIVbxkrNv2+ztzAuOso
        YxcjJ4eEgInEtmPP2EFsIYEdjBJndkpAxCUlls69wQ5hC0vcbznCClHzjVHi9QSfLkYODjYB
        LYnvC8HGiAjESay4vIeli5GLg1lgI5PEpAeXWEASwgKWEhd/drGA1LMIqEq0bPYACfMKuEoc
        XbKNCWK8nMTNc53MIDangJvE2puNLBCrXCW2TprBOoGRbwEjwypGydSC4tz03GLDAqO81HK9
        4sTc4tK8dL3k/NxNjODA1NLawbhn1Qe9Q4xMHIyHGCU4mJVEeBd/ME8S4k1JrKxKLcqPLyrN
        SS0+xCjNwaIkznuh62S8kEB6YklqdmpqQWoRTJaJg1OqgUkj3yToda7y9QU3LsQ5z+E6OedN
        rprGla6of1aerZ/Y9T+b3evYUfV87sPgK1re0kcnTpoeO/PKtelv2h+tTLt0sTni+h6jW9as
        34WTo7oZmthPZp9l52jY0v5yVeQ96YSGukmNnccqq1OYGW98vT5ls2DJ3WPxZk5HfUMU125s
        y3p5NjC6jSdIu0/0l/67+Y8exXxUnuyie3n1Gvkb617dUvDYkZLyUffVnz1Rhk+k7S8sn8A/
        /a/dhcrjopHzWfyU1j5rPbOygJtt91F+e0v5v9yha+RDl7y89e3W7zvqmz5PnPK+e98ticVb
        umWTLbbULpomN1GeO+N20lkN98tdFfuuzn0nuO3CtR23eTM/K7EUZyQaajEXFScCAMJxHBm7
        AgAA
X-CMS-MailID: 20220321090205epcas2p15ac16f281554b663062e0e31666defab
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220321090205epcas2p15ac16f281554b663062e0e31666defab
References: <1647853194-62147-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220321090205epcas2p15ac16f281554b663062e0e31666defab@epcas2p1.samsung.com>
X-Spam-Status: No, score=-5.6 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        RCVD_IN_MSPIKE_H3,RCVD_IN_MSPIKE_WL,SPF_HELO_PASS,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver supports USB Audio offload with Co-processor.
It only cares DCBAA, Device Context, Transfer Ring, Event Ring, and ERST.
They are allocated on specific address with xhci hooks.
Co-processor could use them directly without xhci driver after then.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/host/Kconfig       |   9 +
 drivers/usb/host/Makefile      |   1 +
 drivers/usb/host/xhci-exynos.c | 982 +++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-exynos.h |  63 +++
 4 files changed, 1055 insertions(+)
 create mode 100644 drivers/usb/host/xhci-exynos.c
 create mode 100644 drivers/usb/host/xhci-exynos.h

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 57ca5f97a3dc..850e6b71fac5 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -783,3 +783,12 @@ config USB_XEN_HCD
 	  by the Xen host (usually Dom0).
 	  Only needed if the kernel is running in a Xen guest and generic
 	  access to a USB device is needed.
+
+config USB_XHCI_EXYNOS
+	tristate "XHCI support for Samsung Exynos SoC Series"
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	help
+	  Enable support for the Samsung Exynos SOC's on-chip XHCI
+	  controller.
+
+	  If unsure, say N.
diff --git a/drivers/usb/host/Makefile b/drivers/usb/host/Makefile
index 2948983618fb..300f22b6eb1b 100644
--- a/drivers/usb/host/Makefile
+++ b/drivers/usb/host/Makefile
@@ -86,3 +86,4 @@ obj-$(CONFIG_USB_HCD_SSB)	+= ssb-hcd.o
 obj-$(CONFIG_USB_FOTG210_HCD)	+= fotg210-hcd.o
 obj-$(CONFIG_USB_MAX3421_HCD)	+= max3421-hcd.o
 obj-$(CONFIG_USB_XEN_HCD)	+= xen-hcd.o
+obj-$(CONFIG_USB_XHCI_EXYNOS)	+= xhci-exynos.o
diff --git a/drivers/usb/host/xhci-exynos.c b/drivers/usb/host/xhci-exynos.c
new file mode 100644
index 000000000000..19ee21f1d024
--- /dev/null
+++ b/drivers/usb/host/xhci-exynos.c
@@ -0,0 +1,982 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * xhci-exynos.c - xHCI host controller driver platform Bus Glue for Exynos.
+ *
+ * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.samsung.com
+ * Author: Daehwan Jung <dh10.jung@samsung.com>
+ *
+ * A lot of code borrowed from the Linux xHCI driver.
+ */
+#include <linux/clk.h>
+#include <linux/dma-mapping.h>
+#include <linux/module.h>
+#include <linux/pci.h>
+#include <linux/of.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/usb/phy.h>
+#include <linux/slab.h>
+#include <linux/acpi.h>
+#include <linux/usb/of.h>
+
+#include "xhci.h"
+#include "xhci-plat.h"
+#include "xhci-mvebu.h"
+#include "xhci-rcar.h"
+
+#include "xhci-exynos.h"
+
+static struct hc_driver __read_mostly xhci_exynos_hc_driver;
+
+static void xhci_exynos_free_event_ring(struct xhci_hcd *xhci);
+static struct xhci_ring *xhci_ring_alloc_uram(struct xhci_hcd *xhci,
+		unsigned int num_segs, unsigned int cycle_state,
+		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
+		u32 endpoint_type);
+static void xhci_exynos_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring);
+
+static struct xhci_plat_priv_overwrite xhci_plat_vendor_overwrite;
+
+static int xhci_exynos_setup(struct usb_hcd *hcd);
+static int xhci_exynos_start(struct usb_hcd *hcd);
+
+static void xhci_priv_exynos_start(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (priv->plat_start)
+		priv->plat_start(hcd);
+}
+
+static int xhci_priv_exynos_setup(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (!priv->plat_setup)
+		return 0;
+
+	return priv->plat_setup(hcd);
+}
+
+
+static int xhci_exynos_register_vendor_ops(struct xhci_vendor_ops *vendor_ops)
+{
+	if (vendor_ops == NULL)
+		return -EINVAL;
+
+	xhci_plat_vendor_overwrite.vendor_ops = vendor_ops;
+
+	return 0;
+}
+
+static int xhci_exynos_vendor_init(struct xhci_hcd *xhci)
+{
+	/* TODO */
+	return 0;
+}
+
+static void xhci_exynos_vendor_cleanup(struct xhci_hcd *xhci)
+{
+	xhci_exynos_free_event_ring(xhci);
+}
+
+static bool xhci_exynos_is_usb_offload_enabled(struct xhci_hcd *xhci,
+		struct xhci_virt_device *virt_dev, unsigned int ep_index)
+{
+	/* TODO */
+	return true;
+}
+
+static struct xhci_device_context_array *xhci_exynos_alloc_dcbaa(
+		struct xhci_hcd *xhci, gfp_t flags)
+{
+	int i;
+
+	xhci->dcbaa = ioremap(EXYNOS_URAM_DCBAA_ADDR,
+					sizeof(*xhci->dcbaa));
+	if (!xhci->dcbaa)
+		return NULL;
+	/* Clear DCBAA */
+	for (i = 0; i < MAX_HC_SLOTS; i++)
+		xhci->dcbaa->dev_context_ptrs[i] = 0x0;
+
+	xhci->dcbaa->dma = EXYNOS_URAM_DCBAA_ADDR;
+
+	return xhci->dcbaa;
+}
+
+static void xhci_exynos_free_dcbaa(struct xhci_hcd *xhci)
+{
+	iounmap(xhci->dcbaa);
+	xhci->dcbaa = NULL;
+}
+
+static struct xhci_ring *xhci_exynos_alloc_transfer_ring(struct xhci_hcd *xhci, u32 endpoint_type,
+			enum xhci_ring_type ring_type, unsigned int max_packet, gfp_t mem_flags)
+{
+	return xhci_ring_alloc_uram(xhci, 1, 1, ring_type, max_packet, mem_flags, endpoint_type);
+}
+
+static void xhci_exynos_free_transfer_ring(struct xhci_hcd *xhci, struct xhci_ring *ring,
+						unsigned int ep_index)
+{
+	xhci_exynos_ring_free(xhci, ring);
+}
+
+static void xhci_exynos_alloc_container_ctx(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx,
+						int type, gfp_t flags)
+{
+	/* Only first Device Context uses URAM */
+	int i;
+
+	ctx->bytes = ioremap(EXYNOS_URAM_DEVICE_CTX_ADDR, EXYNOS_URAM_CTX_SIZE);
+	if (!ctx->bytes)
+		return;
+
+	for (i = 0; i < EXYNOS_URAM_CTX_SIZE; i++)
+		ctx->bytes[i] = 0;
+
+	ctx->dma = EXYNOS_URAM_DEVICE_CTX_ADDR;
+}
+
+static void xhci_exynos_free_container_ctx(struct xhci_hcd *xhci, struct xhci_container_ctx *ctx)
+{
+	/* Ignore dma_pool_free if it is allocated from URAM */
+	if (ctx->dma != EXYNOS_URAM_DEVICE_CTX_ADDR)
+		dma_pool_free(xhci->device_pool, ctx->bytes, ctx->dma);
+}
+
+static int xhci_exynos_sync_dev_ctx(struct xhci_hcd *xhci, unsigned int slot_id)
+{
+	struct xhci_exynos_priv *priv = xhci_to_exynos_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->xhci_exynos;
+	struct xhci_virt_device *virt_dev;
+	struct xhci_slot_ctx *slot_ctx;
+
+	int i;
+	int last_ep;
+	int last_ep_ctx = 31;
+
+	virt_dev = xhci->devs[slot_id];
+	slot_ctx = xhci_get_slot_ctx(xhci, virt_dev->in_ctx);
+
+	last_ep = LAST_CTX_TO_EP_NUM(le32_to_cpu(slot_ctx->dev_info));
+
+	if (last_ep < 31)
+		last_ep_ctx = last_ep + 1;
+
+	for (i = 0; i < last_ep_ctx; ++i) {
+		unsigned int epaddr = xhci_get_endpoint_address(i);
+		struct xhci_ep_ctx *ep_ctx = xhci_get_ep_ctx(xhci, virt_dev->out_ctx, i);
+
+		if (epaddr == xhci_exynos->in_ep)
+			xhci_exynos->in_deq = ep_ctx->deq;
+		else if (epaddr == xhci_exynos->out_ep)
+			xhci_exynos->out_deq = ep_ctx->deq;
+	}
+
+	return 0;
+}
+static struct xhci_vendor_ops ops = {
+	.vendor_init = xhci_exynos_vendor_init,
+	.vendor_cleanup = xhci_exynos_vendor_cleanup,
+	.is_usb_offload_enabled = xhci_exynos_is_usb_offload_enabled,
+	.alloc_dcbaa = xhci_exynos_alloc_dcbaa,
+	.free_dcbaa = xhci_exynos_free_dcbaa,
+	.alloc_transfer_ring = xhci_exynos_alloc_transfer_ring,
+	.free_transfer_ring = xhci_exynos_free_transfer_ring,
+	.alloc_container_ctx = xhci_exynos_alloc_container_ctx,
+	.free_container_ctx = xhci_exynos_free_container_ctx,
+	.sync_dev_ctx = xhci_exynos_sync_dev_ctx,
+};
+
+static int xhci_exynos_wake_lock(struct xhci_hcd_exynos *xhci_exynos,
+				   int is_main_hcd, int is_lock)
+{
+	struct usb_hcd	*hcd = xhci_exynos->hcd;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	struct wakeup_source *main_wakelock, *shared_wakelock;
+
+	main_wakelock = xhci_exynos->main_wakelock;
+	shared_wakelock = xhci_exynos->shared_wakelock;
+
+	if (xhci->xhc_state & XHCI_STATE_REMOVING)
+		return -ESHUTDOWN;
+
+	if (is_lock) {
+		if (is_main_hcd)
+			__pm_stay_awake(main_wakelock);
+		else
+			__pm_stay_awake(shared_wakelock);
+	} else {
+		if (is_main_hcd)
+			__pm_relax(main_wakelock);
+		else
+			__pm_relax(shared_wakelock);
+	}
+
+	return 0;
+}
+
+static int xhci_exynos_bus_suspend(struct usb_hcd *hcd)
+{
+	struct xhci_exynos_priv *priv = hcd_to_xhci_exynos_priv(hcd);
+	struct xhci_hcd_exynos *xhci_exynos = priv->xhci_exynos;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+
+	int ret, main_hcd;
+
+	if (hcd == xhci->main_hcd)
+		main_hcd = 1;
+	else
+		main_hcd = 0;
+
+	ret = xhci_bus_suspend(hcd);
+	xhci_exynos_wake_lock(xhci_exynos, main_hcd, 0);
+
+	return ret;
+}
+
+static int xhci_exynos_bus_resume(struct usb_hcd *hcd)
+{
+	struct xhci_exynos_priv *priv = hcd_to_xhci_exynos_priv(hcd);
+	struct xhci_hcd_exynos *xhci_exynos = priv->xhci_exynos;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	int ret, main_hcd;
+
+	if (hcd == xhci->main_hcd)
+		main_hcd = 1;
+	else
+		main_hcd = 0;
+
+	ret = xhci_bus_resume(hcd);
+	xhci_exynos_wake_lock(xhci_exynos, main_hcd, 1);
+
+	return ret;
+}
+
+static int xhci_exynos_address_device(struct usb_hcd *hcd, struct usb_device *udev)
+{
+	struct xhci_hcd *xhci;
+	int ret;
+
+	ret = xhci_address_device(hcd, udev);
+	xhci = hcd_to_xhci(hcd);
+
+	return ret;
+}
+
+static void xhci_exynos_parse_endpoint(struct xhci_hcd *xhci, struct usb_device *udev,
+		struct usb_endpoint_descriptor *desc, struct xhci_container_ctx *ctx)
+{
+	struct xhci_exynos_priv *priv = xhci_to_exynos_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->xhci_exynos;
+	struct usb_endpoint_descriptor *d = desc;
+	unsigned int ep_index;
+	struct xhci_ep_ctx *ep_ctx;
+
+	ep_index = xhci_get_endpoint_index(d);
+	ep_ctx = xhci_get_ep_ctx(xhci, ctx, ep_index);
+
+	if ((d->bmAttributes & USB_ENDPOINT_XFERTYPE_MASK) ==
+				USB_ENDPOINT_XFER_ISOC) {
+		if (d->bEndpointAddress & USB_ENDPOINT_DIR_MASK)
+			xhci_exynos->in_ep = d->bEndpointAddress;
+		else
+			xhci_exynos->out_ep = d->bEndpointAddress;
+	}
+}
+
+static int xhci_exynos_add_endpoint(struct usb_hcd *hcd, struct usb_device *udev,
+		struct usb_host_endpoint *ep)
+{
+	int ret;
+	struct xhci_hcd *xhci;
+	struct xhci_virt_device *virt_dev;
+
+	ret = xhci_add_endpoint(hcd, udev, ep);
+
+	if (!ret && udev->slot_id) {
+		xhci = hcd_to_xhci(hcd);
+		virt_dev = xhci->devs[udev->slot_id];
+		xhci_exynos_parse_endpoint(xhci, udev, &ep->desc, virt_dev->out_ctx);
+	}
+
+	return ret;
+}
+static const struct xhci_driver_overrides xhci_exynos_overrides __initconst = {
+	.extra_priv_size = sizeof(struct xhci_plat_priv),
+	.reset = xhci_exynos_setup,
+	.start = xhci_exynos_start,
+	.add_endpoint = xhci_exynos_add_endpoint,
+	.address_device = xhci_exynos_address_device,
+	.bus_suspend = xhci_exynos_bus_suspend,
+	.bus_resume = xhci_exynos_bus_resume,
+};
+
+
+static void xhci_exynos_segment_free_skip(struct xhci_hcd *xhci, struct xhci_segment *seg)
+{
+	kfree(seg->bounce_buf);
+	kfree(seg);
+}
+
+static void xhci_exynos_free_segments_for_ring(struct xhci_hcd *xhci,
+				struct xhci_segment *first)
+{
+	struct xhci_segment *seg;
+
+	seg = first->next;
+
+	while (seg != first) {
+		struct xhci_segment *next = seg->next;
+
+		xhci_exynos_segment_free_skip(xhci, seg);
+		seg = next;
+	}
+	xhci_exynos_segment_free_skip(xhci, first);
+}
+
+static void xhci_exynos_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring)
+{
+	if (!ring)
+		return;
+
+	//trace_xhci_ring_free(ring);
+
+	if (ring->first_seg) {
+		if (ring->type == TYPE_STREAM)
+			xhci_remove_stream_mapping(ring);
+
+		xhci_exynos_free_segments_for_ring(xhci, ring->first_seg);
+	}
+
+	kfree(ring);
+}
+
+static void xhci_exynos_free_event_ring(struct xhci_hcd *xhci)
+{
+	struct xhci_exynos_priv *priv = xhci_to_exynos_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->xhci_exynos;
+
+	xhci_exynos_ring_free(xhci, xhci_exynos->event_ring_audio);
+}
+
+static void xhci_exynos_set_hc_event_deq_audio(struct xhci_hcd *xhci)
+{
+	struct xhci_exynos_priv *priv = xhci_to_exynos_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->xhci_exynos;
+
+	dma_addr_t deq;
+
+	deq = xhci_trb_virt_to_dma(xhci_exynos->event_ring_audio->deq_seg,
+			xhci_exynos->event_ring_audio->dequeue);
+}
+
+
+
+static int xhci_exynos_alloc_event_ring(struct xhci_hcd *xhci, gfp_t flags)
+{
+	struct xhci_exynos_priv *priv = xhci_to_exynos_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->xhci_exynos;
+
+	if (xhci_check_trb_in_td_math(xhci) < 0)
+		goto fail;
+
+	xhci_exynos->event_ring_audio = xhci_ring_alloc(xhci, ERST_NUM_SEGS, 1,
+						TYPE_EVENT, 0, flags);
+	/* Set the event ring dequeue address */
+	xhci_exynos_set_hc_event_deq_audio(xhci);
+
+	return 0;
+fail:
+	return -1;
+}
+
+static int xhci_alloc_segments_for_ring_uram(struct xhci_hcd *xhci,
+		struct xhci_segment **first, struct xhci_segment **last,
+		unsigned int num_segs, unsigned int cycle_state,
+		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
+		u32 endpoint_type)
+{
+	struct xhci_segment *prev;
+	bool chain_links = false;
+
+	while (num_segs > 0) {
+		struct xhci_segment *next = NULL;
+
+		if (!next) {
+			prev = *first;
+			while (prev) {
+				next = prev->next;
+				xhci_segment_free(xhci, prev);
+				prev = next;
+			}
+			return -ENOMEM;
+		}
+		xhci_link_segments(prev, next, type, chain_links);
+
+		prev = next;
+		num_segs--;
+	}
+	xhci_link_segments(prev, *first, type, chain_links);
+	*last = prev;
+
+	return 0;
+}
+
+static struct xhci_ring *xhci_ring_alloc_uram(struct xhci_hcd *xhci,
+		unsigned int num_segs, unsigned int cycle_state,
+		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
+		u32 endpoint_type)
+{
+	struct xhci_ring	*ring;
+	int ret;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+
+	ring = kzalloc_node(sizeof(*ring), flags, dev_to_node(dev));
+	if (!ring)
+		return NULL;
+
+	ring->num_segs = num_segs;
+	ring->bounce_buf_len = max_packet;
+	INIT_LIST_HEAD(&ring->td_list);
+	ring->type = type;
+	if (num_segs == 0)
+		return ring;
+
+	ret = xhci_alloc_segments_for_ring_uram(xhci, &ring->first_seg,
+			&ring->last_seg, num_segs, cycle_state, type,
+			max_packet, flags, endpoint_type);
+	if (ret)
+		goto fail;
+
+	/* Only event ring does not use link TRB */
+	if (type != TYPE_EVENT) {
+		/* See section 4.9.2.1 and 6.4.4.1 */
+		ring->last_seg->trbs[TRBS_PER_SEGMENT - 1].link.control |=
+			cpu_to_le32(LINK_TOGGLE);
+	}
+	xhci_initialize_ring_info(ring, cycle_state);
+	//trace_xhci_ring_alloc(ring);
+	return ring;
+
+fail:
+	kfree(ring);
+	return NULL;
+}
+
+static void xhci_exynos_usb_offload_enable_event_ring(struct xhci_hcd *xhci)
+{
+	struct xhci_exynos_priv *priv = xhci_to_exynos_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->xhci_exynos;
+
+	u32 temp;
+	u64 temp_64;
+
+	temp_64 = xhci_read_64(xhci, &xhci_exynos->ir_set_audio->erst_dequeue);
+	temp_64 &= ~ERST_PTR_MASK;
+	xhci_info(xhci,	"ERST2 deq = 64'h%0lx", (unsigned long) temp_64);
+
+	xhci_info(xhci, "// [USB Audio] Set the interrupt modulation register");
+	temp = readl(&xhci_exynos->ir_set_audio->irq_control);
+	temp &= ~ER_IRQ_INTERVAL_MASK;
+	/*
+	 * the increment interval is 8 times as much as that defined
+	 * in xHCI spec on MTK's controller
+	 */
+	temp |= (u32) ((xhci->quirks & XHCI_MTK_HOST) ? 20 : 160);
+	writel(temp, &xhci_exynos->ir_set_audio->irq_control);
+
+	temp = readl(&xhci_exynos->ir_set_audio->irq_pending);
+	xhci_info(xhci, "// [USB Audio] Enabling event ring interrupter %p by writing 0x%x to irq_pending",
+			xhci_exynos->ir_set_audio, (unsigned int) ER_IRQ_ENABLE(temp));
+	writel(ER_IRQ_ENABLE(temp), &xhci_exynos->ir_set_audio->irq_pending);
+}
+
+static int xhci_priv_init_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (!priv->init_quirk)
+		return 0;
+
+	return priv->init_quirk(hcd);
+}
+
+static int xhci_priv_suspend_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (!priv->suspend_quirk)
+		return 0;
+
+	return priv->suspend_quirk(hcd);
+}
+
+static int xhci_priv_resume_quirk(struct usb_hcd *hcd)
+{
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+
+	if (!priv->resume_quirk)
+		return 0;
+
+	return priv->resume_quirk(hcd);
+}
+
+static void xhci_exynos_quirks(struct device *dev, struct xhci_hcd *xhci)
+{
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+
+	/*
+	 * As of now platform drivers don't provide MSI support so we ensure
+	 * here that the generic code does not try to make a pci_dev from our
+	 * dev struct in order to setup MSI
+	 */
+	xhci->quirks |= XHCI_PLAT | priv->quirks;
+}
+
+/* called during probe() after chip reset completes */
+static int xhci_exynos_setup(struct usb_hcd *hcd)
+{
+	int ret;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+
+	ret = xhci_priv_init_quirk(hcd);
+	if (ret)
+		return ret;
+
+	ret = xhci_gen_setup(hcd, xhci_exynos_quirks);
+	xhci_exynos_alloc_event_ring(xhci, GFP_KERNEL);
+
+	return ret;
+}
+
+static int xhci_exynos_start(struct usb_hcd *hcd)
+{
+	struct xhci_hcd *xhci;
+	int ret;
+
+	xhci_priv_exynos_start(hcd);
+
+	ret = xhci_run(hcd);
+
+	xhci = hcd_to_xhci(hcd);
+	xhci_exynos_usb_offload_enable_event_ring(xhci);
+
+	return ret;
+}
+
+#ifdef CONFIG_OF
+static const struct xhci_plat_priv xhci_plat_marvell_armada = {
+	.init_quirk = xhci_mvebu_mbus_init_quirk,
+};
+
+static const struct xhci_plat_priv xhci_plat_marvell_armada3700 = {
+	.plat_setup = xhci_mvebu_a3700_plat_setup,
+	.init_quirk = xhci_mvebu_a3700_init_quirk,
+};
+
+static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen2 = {
+	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V1)
+};
+
+static const struct xhci_plat_priv xhci_plat_renesas_rcar_gen3 = {
+	SET_XHCI_PLAT_PRIV_FOR_RCAR(XHCI_RCAR_FIRMWARE_NAME_V3)
+};
+
+static const struct xhci_plat_priv xhci_plat_brcm = {
+	.quirks = XHCI_RESET_ON_RESUME,
+};
+
+static const struct of_device_id usb_xhci_of_match[] = {
+	{
+		.compatible = "generic-xhci",
+	}, {
+		.compatible = "xhci-platform",
+	},
+	{},
+};
+MODULE_DEVICE_TABLE(of, usb_xhci_of_match);
+#endif
+
+static int xhci_vendor_init(struct xhci_hcd *xhci)
+{
+	struct xhci_vendor_ops *ops = NULL;
+
+	if (xhci_plat_vendor_overwrite.vendor_ops)
+		ops = xhci->vendor_ops = xhci_plat_vendor_overwrite.vendor_ops;
+
+	if (ops && ops->vendor_init)
+		return ops->vendor_init(xhci);
+	return 0;
+}
+
+static void xhci_vendor_cleanup(struct xhci_hcd *xhci)
+{
+	struct xhci_vendor_ops *ops = xhci_vendor_get_ops(xhci);
+
+	if (ops && ops->vendor_cleanup)
+		ops->vendor_cleanup(xhci);
+
+	xhci->vendor_ops = NULL;
+}
+
+static int xhci_exynos_probe(struct platform_device *pdev)
+{
+	const struct xhci_plat_priv *priv_match;
+	const struct hc_driver	*driver;
+	struct device		*sysdev, *tmpdev;
+	struct xhci_hcd		*xhci;
+	struct resource         *res;
+	struct usb_hcd		*hcd;
+	int			ret;
+	int			irq;
+	struct xhci_plat_priv	*priv = NULL;
+
+
+	xhci_exynos_register_vendor_ops(&ops);
+
+	if (usb_disabled())
+		return -ENODEV;
+
+	driver = &xhci_exynos_hc_driver;
+
+	irq = platform_get_irq(pdev, 0);
+	if (irq < 0)
+		return irq;
+
+	/*
+	 * sysdev must point to a device that is known to the system firmware
+	 * or PCI hardware. We handle these three cases here:
+	 * 1. xhci_plat comes from firmware
+	 * 2. xhci_plat is child of a device from firmware (dwc3-plat)
+	 * 3. xhci_plat is grandchild of a pci device (dwc3-pci)
+	 */
+	for (sysdev = &pdev->dev; sysdev; sysdev = sysdev->parent) {
+		if (is_of_node(sysdev->fwnode) ||
+			is_acpi_device_node(sysdev->fwnode))
+			break;
+#ifdef CONFIG_PCI
+		else if (sysdev->bus == &pci_bus_type)
+			break;
+#endif
+	}
+
+	if (!sysdev)
+		sysdev = &pdev->dev;
+
+	/* Try to set 64-bit DMA first */
+	if (WARN_ON(!sysdev->dma_mask))
+		/* Platform did not initialize dma_mask */
+		ret = dma_coerce_mask_and_coherent(sysdev,
+						   DMA_BIT_MASK(64));
+	else
+		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(64));
+
+	/* If seting 64-bit DMA mask fails, fall back to 32-bit DMA mask */
+	if (ret) {
+		ret = dma_set_mask_and_coherent(sysdev, DMA_BIT_MASK(32));
+		if (ret)
+			return ret;
+	}
+
+	pm_runtime_set_active(&pdev->dev);
+	pm_runtime_enable(&pdev->dev);
+	pm_runtime_get_noresume(&pdev->dev);
+
+	hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
+			       dev_name(&pdev->dev), NULL);
+	if (!hcd) {
+		ret = -ENOMEM;
+		goto disable_runtime;
+	}
+
+	hcd->regs = devm_platform_get_and_ioremap_resource(pdev, 0, &res);
+	if (IS_ERR(hcd->regs)) {
+		ret = PTR_ERR(hcd->regs);
+		goto put_hcd;
+	}
+
+	hcd->rsrc_start = res->start;
+	hcd->rsrc_len = resource_size(res);
+
+	xhci = hcd_to_xhci(hcd);
+
+	/*
+	 * Not all platforms have clks so it is not an error if the
+	 * clock do not exist.
+	 */
+	xhci->reg_clk = devm_clk_get_optional(&pdev->dev, "reg");
+	if (IS_ERR(xhci->reg_clk)) {
+		ret = PTR_ERR(xhci->reg_clk);
+		goto put_hcd;
+	}
+
+	ret = clk_prepare_enable(xhci->reg_clk);
+	if (ret)
+		goto put_hcd;
+
+	xhci->clk = devm_clk_get_optional(&pdev->dev, NULL);
+	if (IS_ERR(xhci->clk)) {
+		ret = PTR_ERR(xhci->clk);
+		goto disable_reg_clk;
+	}
+
+	ret = clk_prepare_enable(xhci->clk);
+	if (ret)
+		goto disable_reg_clk;
+
+	if (pdev->dev.of_node)
+		priv_match = of_device_get_match_data(&pdev->dev);
+	else
+		priv_match = dev_get_platdata(&pdev->dev);
+
+	if (priv_match) {
+		priv = hcd_to_xhci_priv(hcd);
+		/* Just copy data for now */
+		*priv = *priv_match;
+	}
+
+	device_set_wakeup_capable(&pdev->dev, true);
+
+	xhci->main_hcd = hcd;
+	xhci->shared_hcd = __usb_create_hcd(driver, sysdev, &pdev->dev,
+			dev_name(&pdev->dev), hcd);
+	if (!xhci->shared_hcd) {
+		ret = -ENOMEM;
+		goto disable_clk;
+	}
+
+	/* imod_interval is the interrupt moderation value in nanoseconds. */
+	xhci->imod_interval = 40000;
+
+	/* Iterate over all parent nodes for finding quirks */
+	for (tmpdev = &pdev->dev; tmpdev; tmpdev = tmpdev->parent) {
+
+		if (device_property_read_bool(tmpdev, "usb2-lpm-disable"))
+			xhci->quirks |= XHCI_HW_LPM_DISABLE;
+
+		if (device_property_read_bool(tmpdev, "usb3-lpm-capable"))
+			xhci->quirks |= XHCI_LPM_SUPPORT;
+
+		if (device_property_read_bool(tmpdev, "quirk-broken-port-ped"))
+			xhci->quirks |= XHCI_BROKEN_PORT_PED;
+
+		device_property_read_u32(tmpdev, "imod-interval-ns",
+					 &xhci->imod_interval);
+	}
+
+	hcd->usb_phy = devm_usb_get_phy_by_phandle(sysdev, "usb-phy", 0);
+	if (IS_ERR(hcd->usb_phy)) {
+		ret = PTR_ERR(hcd->usb_phy);
+		if (ret == -EPROBE_DEFER)
+			goto put_usb3_hcd;
+		hcd->usb_phy = NULL;
+	} else {
+		ret = usb_phy_init(hcd->usb_phy);
+		if (ret)
+			goto put_usb3_hcd;
+	}
+
+	ret = xhci_vendor_init(xhci);
+	if (ret)
+		goto disable_usb_phy;
+
+	hcd->tpl_support = of_usb_host_tpl_support(sysdev->of_node);
+	xhci->shared_hcd->tpl_support = hcd->tpl_support;
+
+	if (priv) {
+		ret = xhci_priv_exynos_setup(hcd);
+		if (ret)
+			goto disable_usb_phy;
+	}
+
+	if ((xhci->quirks & XHCI_SKIP_PHY_INIT) || (priv && (priv->quirks & XHCI_SKIP_PHY_INIT)))
+		hcd->skip_phy_initialization = 1;
+
+	if (priv && (priv->quirks & XHCI_SG_TRB_CACHE_SIZE_QUIRK))
+		xhci->quirks |= XHCI_SG_TRB_CACHE_SIZE_QUIRK;
+
+	ret = usb_add_hcd(hcd, irq, IRQF_SHARED);
+	if (ret)
+		goto disable_usb_phy;
+
+	if (HCC_MAX_PSA(xhci->hcc_params) >= 4)
+		xhci->shared_hcd->can_do_streams = 1;
+
+	ret = usb_add_hcd(xhci->shared_hcd, irq, IRQF_SHARED);
+	if (ret)
+		goto dealloc_usb2_hcd;
+
+	device_enable_async_suspend(&pdev->dev);
+	pm_runtime_put_noidle(&pdev->dev);
+
+	/*
+	 * Prevent runtime pm from being on as default, users should enable
+	 * runtime pm using power/control in sysfs.
+	 */
+	pm_runtime_forbid(&pdev->dev);
+
+	return 0;
+
+
+dealloc_usb2_hcd:
+	usb_remove_hcd(hcd);
+
+disable_usb_phy:
+	usb_phy_shutdown(hcd->usb_phy);
+
+put_usb3_hcd:
+	usb_put_hcd(xhci->shared_hcd);
+
+disable_clk:
+	clk_disable_unprepare(xhci->clk);
+
+disable_reg_clk:
+	clk_disable_unprepare(xhci->reg_clk);
+
+put_hcd:
+	usb_put_hcd(hcd);
+
+disable_runtime:
+	pm_runtime_put_noidle(&pdev->dev);
+	pm_runtime_disable(&pdev->dev);
+
+	return ret;
+}
+
+static int xhci_exynos_remove(struct platform_device *dev)
+{
+	struct usb_hcd	*hcd = platform_get_drvdata(dev);
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	struct clk *clk = xhci->clk;
+	struct clk *reg_clk = xhci->reg_clk;
+	struct usb_hcd *shared_hcd = xhci->shared_hcd;
+
+	pm_runtime_get_sync(&dev->dev);
+	xhci->xhc_state |= XHCI_STATE_REMOVING;
+
+	usb_remove_hcd(shared_hcd);
+	xhci->shared_hcd = NULL;
+	usb_phy_shutdown(hcd->usb_phy);
+
+	usb_remove_hcd(hcd);
+
+	xhci_vendor_cleanup(xhci);
+
+	usb_put_hcd(shared_hcd);
+	clk_disable_unprepare(clk);
+	clk_disable_unprepare(reg_clk);
+	usb_put_hcd(hcd);
+
+	pm_runtime_disable(&dev->dev);
+	pm_runtime_put_noidle(&dev->dev);
+	pm_runtime_set_suspended(&dev->dev);
+
+	return 0;
+}
+
+static int __maybe_unused xhci_exynos_suspend(struct device *dev)
+{
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	int ret;
+
+	ret = xhci_priv_suspend_quirk(hcd);
+	if (ret)
+		return ret;
+	/*
+	 * xhci_suspend() needs `do_wakeup` to know whether host is allowed
+	 * to do wakeup during suspend.
+	 */
+	return xhci_suspend(xhci, device_may_wakeup(dev));
+}
+
+static int __maybe_unused xhci_exynos_resume(struct device *dev)
+{
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	int ret;
+
+	ret = xhci_priv_resume_quirk(hcd);
+	if (ret)
+		return ret;
+
+	ret = xhci_resume(xhci, 0);
+	if (ret)
+		return ret;
+
+	pm_runtime_disable(dev);
+	pm_runtime_set_active(dev);
+	pm_runtime_enable(dev);
+
+	return 0;
+}
+
+static int __maybe_unused xhci_exynos_runtime_suspend(struct device *dev)
+{
+	struct usb_hcd  *hcd = dev_get_drvdata(dev);
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+	int ret;
+
+	ret = xhci_priv_suspend_quirk(hcd);
+	if (ret)
+		return ret;
+
+	return xhci_suspend(xhci, true);
+}
+
+static int __maybe_unused xhci_exynos_runtime_resume(struct device *dev)
+{
+	struct usb_hcd  *hcd = dev_get_drvdata(dev);
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+
+	return xhci_resume(xhci, 0);
+}
+
+static const struct dev_pm_ops xhci_exynos_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(xhci_exynos_suspend, xhci_exynos_resume)
+
+	SET_RUNTIME_PM_OPS(xhci_exynos_runtime_suspend,
+			   xhci_exynos_runtime_resume,
+			   NULL)
+};
+
+#ifdef CONFIG_ACPI
+static const struct acpi_device_id usb_xhci_acpi_match[] = {
+	/* XHCI-compliant USB Controller */
+	{ "PNP0D10", },
+	{ }
+};
+MODULE_DEVICE_TABLE(acpi, usb_xhci_acpi_match);
+#endif
+
+static struct platform_driver usb_xhci_driver = {
+	.probe	= xhci_exynos_probe,
+	.remove	= xhci_exynos_remove,
+	.shutdown = usb_hcd_platform_shutdown,
+	.driver	= {
+		.name = "xhci-exynos",
+		.pm = &xhci_exynos_pm_ops,
+		.of_match_table = of_match_ptr(usb_xhci_of_match),
+		.acpi_match_table = ACPI_PTR(usb_xhci_acpi_match),
+	},
+};
+MODULE_ALIAS("platform:xhci-exynos");
+
+static int __init xhci_exynos_init(void)
+{
+	xhci_init_driver(&xhci_exynos_hc_driver, &xhci_exynos_overrides);
+	return platform_driver_register(&usb_xhci_driver);
+}
+module_init(xhci_exynos_init);
+
+static void __exit xhci_exynos_exit(void)
+{
+	platform_driver_unregister(&usb_xhci_driver);
+}
+module_exit(xhci_exynos_exit);
+
+MODULE_DESCRIPTION("xHCI Exynos Host Controller Driver");
+MODULE_LICENSE("GPL");
diff --git a/drivers/usb/host/xhci-exynos.h b/drivers/usb/host/xhci-exynos.h
new file mode 100644
index 000000000000..91860a3a1c7d
--- /dev/null
+++ b/drivers/usb/host/xhci-exynos.h
@@ -0,0 +1,63 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * xhci-exynos.h - xHCI host controller driver platform Bus Glue for Exynos.
+ *
+ * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.samsung.com
+ * Author: Daehwan Jung <dh10.jung@samsung.com>
+ *
+ * A lot of code borrowed from the Linux xHCI driver.
+ */
+
+#include "xhci.h"
+
+/* EXYNOS uram memory map */
+#define EXYNOS_URAM_ABOX_EVT_RING_ADDR	0x02a00000
+#define EXYNOS_URAM_ISOC_OUT_RING_ADDR	0x02a01000
+#define EXYNOS_URAM_ISOC_IN_RING_ADDR	0x02a02000
+#define EXYNOS_URAM_DEVICE_CTX_ADDR	0x02a03000
+#define EXYNOS_URAM_DCBAA_ADDR		0x02a03880
+#define EXYNOS_URAM_ABOX_ERST_SEG_ADDR	0x02a03C80
+#define EXYNOS_URAM_CTX_SIZE		2112
+
+struct xhci_hcd_exynos {
+	struct	xhci_intr_reg __iomem *ir_set_audio;
+
+	struct xhci_ring	*event_ring_audio;
+	struct xhci_erst	erst_audio;
+
+	struct device		*dev;
+	struct usb_hcd		*hcd;
+	struct usb_hcd		*shared_hcd;
+
+	struct wakeup_source *main_wakelock; /* Wakelock for HS HCD */
+	struct wakeup_source *shared_wakelock; /* Wakelock for SS HCD */
+
+	u32 in_ep;
+	u32 out_ep;
+	u32 in_deq;
+	u32 out_deq;
+};
+
+struct xhci_exynos_priv {
+	const char *firmware_name;
+	unsigned long long quirks;
+	struct xhci_vendor_data *vendor_data;
+	int (*plat_setup)(struct usb_hcd *);
+	void (*plat_start)(struct usb_hcd *);
+	int (*init_quirk)(struct usb_hcd *);
+	int (*suspend_quirk)(struct usb_hcd *);
+	int (*resume_quirk)(struct usb_hcd *);
+	struct xhci_hcd_exynos *xhci_exynos;
+};
+
+#define hcd_to_xhci_exynos_priv(h) ((struct xhci_exynos_priv *)hcd_to_xhci(h)->priv)
+#define xhci_to_exynos_priv(x) ((struct xhci_exynos_priv *)(x)->priv)
+
+int xhci_check_trb_in_td_math(struct xhci_hcd *xhci);
+void xhci_segment_free(struct xhci_hcd *xhci, struct xhci_segment *seg);
+void xhci_link_segments(struct xhci_segment *prev,
+		struct xhci_segment *next,
+		enum xhci_ring_type type, bool chain_links);
+void xhci_initialize_ring_info(struct xhci_ring *ring,
+					unsigned int cycle_state);
+void xhci_remove_stream_mapping(struct xhci_ring *ring);
-- 
2.31.1

