Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0AA51D180
	for <lists+linux-kernel@lfdr.de>; Fri,  6 May 2022 08:35:41 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378744AbiEFGiA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 6 May 2022 02:38:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60072 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1358106AbiEFGhn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 6 May 2022 02:37:43 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id F3BA765D33
        for <linux-kernel@vger.kernel.org>; Thu,  5 May 2022 23:33:47 -0700 (PDT)
Received: from epcas2p3.samsung.com (unknown [182.195.41.55])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220506063346epoutp022f3ca07173761a2d4cd8257a143f7215~scHiAhl1C1003810038epoutp02x
        for <linux-kernel@vger.kernel.org>; Fri,  6 May 2022 06:33:46 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220506063346epoutp022f3ca07173761a2d4cd8257a143f7215~scHiAhl1C1003810038epoutp02x
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1651818826;
        bh=IfKz3nJK9FEY9WTuvkeyNuhF9Ub+U+rwuEUUzi69DBI=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=rdRxILAep4y+PjQJPUL0uAtImGTMQq6jkcG864Evkr6ujy4i+eVTST8K00N12cbbU
         IBJ3WQpXQcXdO7Nd6Y5XGK85y364HvpAgYkrkizABzg4rmFpL9JHcHGrccvha+MAgb
         4yDOOcXnAtlMg/Bn89VtVoaWBcolZz0O6xoTpeAg=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTP id
        20220506063345epcas2p45807103f833246ef4d846b54bf182a0c~scHhY5WUS0959509595epcas2p4L;
        Fri,  6 May 2022 06:33:45 +0000 (GMT)
Received: from epsmges2p4.samsung.com (unknown [182.195.36.98]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KvgkY44chz4x9Q2; Fri,  6 May
        2022 06:33:41 +0000 (GMT)
Received: from epcas2p1.samsung.com ( [182.195.41.53]) by
        epsmges2p4.samsung.com (Symantec Messaging Gateway) with SMTP id
        A8.23.09694.441C4726; Fri,  6 May 2022 15:33:40 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p4.samsung.com (KnoxPortal) with ESMTPA id
        20220506063339epcas2p41de479fb6b2d11012a45ac50ccc19a26~scHcI4J7A2345123451epcas2p4M;
        Fri,  6 May 2022 06:33:39 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220506063339epsmtrp159bcdd0d7e5c4f9b10d3dddf8da1f49b~scHcHljTF3174331743epsmtrp1W;
        Fri,  6 May 2022 06:33:39 +0000 (GMT)
X-AuditID: b6c32a48-47fff700000025de-c5-6274c144479d
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        9A.55.11276.341C4726; Fri,  6 May 2022 15:33:39 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220506063339epsmtip209f996e40c2376b1bf5072f3515c9140~scHb3i5hD0420504205epsmtip2h;
        Fri,  6 May 2022 06:33:39 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Felipe Balbi <balbi@kernel.org>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski@linaro.org>,
        Alim Akhtar <alim.akhtar@samsung.com>,
        Mathias Nyman <mathias.nyman@intel.com>,
        Lukas Bulwahn <lukas.bulwahn@gmail.com>,
        Tony Lindgren <tony@atomide.com>,
        Juergen Gross <jgross@suse.com>, Arnd Bergmann <arnd@arndb.de>,
        Matthias Kaehlcke <mka@chromium.org>
Cc:     linux-kernel@vger.kernel.org (open list),
        linux-usb@vger.kernel.org (open list:DESIGNWARE USB3 DRD IP DRIVER),
        linux-arm-kernel@lists.infradead.org (moderated list:ARM/SAMSUNG S3C,
        S5P AND EXYNOS ARM ARCHITECTURES),
        linux-samsung-soc@vger.kernel.org (open list:ARM/SAMSUNG S3C, S5P AND
        EXYNOS ARM ARCHITECTURES), sc.suh@samsung.com,
        taehyun.cho@samsung.com, jh0801.jung@samsung.com,
        eomji.oh@samsung.com, Daehwan Jung <dh10.jung@samsung.com>
Subject: [PATCH RFC v5 5/6] usb: host: add xhci-exynos driver
Date:   Fri,  6 May 2022 15:31:18 +0900
Message-Id: <1651818679-10594-6-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA0VTfVAUZRz23V1uF4drtjvUVyqCVUto7riDO1jwzpwRrx1sHKaanOoPWrkN
        GI6763bRcpwBkg9lFPBQgRMJRdRBCDsJiPiQQw8JQQJFKZhIjIEIJ4/4yKLiuLP+e34fz+/5
        fbwvgUq+EQUQKUaBsxhZAyVaizV2hahlsZ3CPsXAbSk9XtEoopetTpx25j7C6dHK0wj97aVz
        CH24ql5El4+E02M/LWF028xXOG2fGPahh1rKRXTpnXaEPn8xB6Wzb+Zh9GH7SR967uoEoPPH
        HgDa2rmO7rgbt0PK/PnUCpiFeSvGnMn8DmO+to3hTFXrNMLYa46KmNHhVhHTcbYWZ65dyGAK
        GmoAU99wD2Pm7IHxfu+napI5Vs9ZgjhjokmfYkzSUrvfTtiZoI5UKGXKaDqKCjKyaZyWin0z
        XqZLMaxMSAXtZw3pK654luepsO0aiyld4IKSTbygpTiz3mCOMst5No1PNybJjZwQo1QowtUr
        iR+mJp9YzsbNtzvAJzbHHZ9MMHEW5ANfApIqaJ+dRfLBWkJCNgPYXHbaa7gAdOVeRD3GAoDF
        9y8gzyjjFVcwT6ANwPqxbm/WEoDZxQN4PiAIERkKF88Bt9+fLEFhT+1xkdtAyR4UDrWex92l
        pKQWXi58tIoxcgv8rKB3VUJM7oKuxjofj1wgHOk/irqxL6mDg6caVqtCcoCAv/cXeceIhf/8
        2od7sBT+0t3gxQFwujDXi3nY4spBPORMALPGb6GeQAS0TeYBd9soGQLrW8LcEJKb4I3vMXcG
        Sj4Hj3Qt4x63GB7JlXiIm2DJUJG3zY2wc6bfW5CBTY673g2VATh/rAspAoG2/wUqAagB6zkz
        n5bE8eFm1X9XSzSl2cHqKw5lmsGZ2d/kDoAQwAEggVL+YqlN2CcR69lPD3IWU4Il3cDxDqBe
        Wd4JNGBdomnlGxiFBKUqWqGKjFRGhasVUdQGcZz+Kishk1iBS+U4M2d5xkMI34BMJNMc0cq3
        V/9RWiibvMHQ5W0/Oqdl3T5TuuEnGeSUPC/H/yB0aYPvO1Dr/Ehab3Ven0pTHB28vrrpeK+z
        rOdeSbwfPgpyBks+2Eodalcd2hm6IA+RrKn84frlHcV+ilL2+cmS7Q+bpPpJ2XuxCN8oF16d
        31bFxO1W/5UsdulibunigpyqvuBXKnblvaNnFzUbXtvi/9LG3r+V+j1Cv5l5+OXT2oVT+FsV
        B36OGEzQvLBtr/xxzXz0lWsG7KMvsgae3HyxM/Kxqp95d/FB8Jpj4VEaTvfGlHr/1PjH6Vlb
        65iJA9fnMmLrnK9/ToS1zLRie2sEpndJOxdSELPHtrni5VEK45NZZShq4dl/ASB6DXNOBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrELMWRmVeSWpSXmKPExsWy7bCSvK7zwZIkg3W79CwezNvGZvF30jF2
        i2NtT9gt7iyYxmRxavlCJovmxevZLObcNLK4+/AHi8Xe11vZLTY9vsZqcXnXHDaLGef3MVks
        WtbKbNFytJ3FonnTFFaLzxseM1p03b3BaDHpoKjF/iteDsIev39NYvT49nUSi8fshossHjtn
        3WX3WLznJZPHplWdbB53ru1h89g/dw27x+Yl9R59W1YxeqzfcpXF4/MmuQCeKC6blNSczLLU
        In27BK6MiX9b2AvO7GesmHXoPGsD4+O5jF2MnBwSAiYSD+atZgGxhQR2M0qsb86EiEtKLJ17
        gx3CFpa433KEFaLmG6PEshPpXYwcHGwCWhLfF4KNERGYyyyxdWtRFyMXB7PAWWaJP09Xs4Ek
        hAVsJVb0PwGbwyKgKtHUd5oJxOYVcJX4tG0tK8R8OYmb5zqZQWxOATeJS1O3MELscpVY+Oc7
        8wRGvgWMDKsYJVMLinPTc4sNCwzzUsv1ihNzi0vz0vWS83M3MYKjRUtzB+P2VR/0DjEycTAe
        YpTgYFYS4RWeVZIkxJuSWFmVWpQfX1Sak1p8iFGag0VJnPdC18l4IYH0xJLU7NTUgtQimCwT
        B6dUA9MUIz6Lj6UVC2QNWU+9XJV6zb5WIPahkq/1ec6ju6/MXF9THGJpXHFyQ7c63+uAx1JT
        O+ZWFGjv0LnxPDNE5lzgIe6vBTGfjG4ETfx13bXAK1vW7EWu1p91Ga/XviutXFHNuN+eoXGm
        Y4k8G2vJlVddmWda1y/b+6YtWyXbPKt2V1XGSp9z/oUGk/NDTrCtl/r3mWVNBceS/MXXtvy+
        Hy/ZzrXmyF7V+Gk3/r07EfThbEz/hnVbrSpcc375ud6//7pDv/P69+WC5cddPt25ZJYglc/V
        f7P7qH7rjuqgpyG9a1ijnUtqsief9E+eW7zjyAdjK+E20xuOvQwfvarfnnIy8Z+jNUlnnzm/
        1cxJC5VYijMSDbWYi4oTASLvPKQFAwAA
X-CMS-MailID: 20220506063339epcas2p41de479fb6b2d11012a45ac50ccc19a26
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220506063339epcas2p41de479fb6b2d11012a45ac50ccc19a26
References: <1651818679-10594-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220506063339epcas2p41de479fb6b2d11012a45ac50ccc19a26@epcas2p4.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is for Samsung Exynos xHCI host conroller. It works based on
xhci platform driver and extends functions by xhci hooks and overrides.
Vendor ops(xhci hooks) should be mapped before probing driver.
It overrides functions of hc driver on vendor init.

It supports USB Audio offload with Co-processor. It only cares DCBAA,
Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
on specific address with xhci hooks. Co-processor could use them directly
without xhci driver after then.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/host/Kconfig       |   8 +
 drivers/usb/host/Makefile      |   1 +
 drivers/usb/host/xhci-exynos.c | 775 +++++++++++++++++++++++++++++++++
 3 files changed, 784 insertions(+)
 create mode 100644 drivers/usb/host/xhci-exynos.c

diff --git a/drivers/usb/host/Kconfig b/drivers/usb/host/Kconfig
index 682b3d2da623..ccafcd9b4212 100644
--- a/drivers/usb/host/Kconfig
+++ b/drivers/usb/host/Kconfig
@@ -104,6 +104,14 @@ config USB_XHCI_TEGRA
 	  Say 'Y' to enable the support for the xHCI host controller
 	  found in NVIDIA Tegra124 and later SoCs.
 
+config USB_XHCI_EXYNOS
+	tristate "xHCI support for Samsung Exynos SoC Series"
+	depends on USB_XHCI_PLATFORM
+	depends on ARCH_EXYNOS || COMPILE_TEST
+	help
+	  Say 'Y' to enable the support for the xHCI host controller
+	  found in Samsung Exynos SoCs.
+
 endif # USB_XHCI_HCD
 
 config USB_EHCI_BRCMSTB
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
index 000000000000..5318a51ac5ee
--- /dev/null
+++ b/drivers/usb/host/xhci-exynos.c
@@ -0,0 +1,775 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * xhci-exynos.c - xHCI host controller driver platform Bus Glue for Exynos.
+ *
+ * Copyright (C) 2022 Samsung Electronics Incorporated - http://www.samsung.com
+ * Author: Daehwan Jung <dh10.jung@samsung.com>
+ *
+ * A lot of code borrowed from the Linux xHCI driver.
+ */
+#include <linux/pci.h>
+#include <linux/platform_device.h>
+
+#include "xhci.h"
+#include "xhci-plat.h"
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
+int xhci_exynos_register_vendor_ops(void);
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
+
+	/* This flag is used to check first allocation for URAM */
+	bool			exynos_uram_ctx_alloc;
+	bool			exynos_uram_isoc_out_alloc;
+	bool			exynos_uram_isoc_in_alloc;
+
+	unsigned long long	quirks;
+};
+
+static const struct dev_pm_ops xhci_exynos_pm_ops;
+
+static struct xhci_vendor_ops ops;
+static void xhci_exynos_parse_endpoint(struct xhci_hcd *xhci, struct usb_device *udev,
+		struct usb_endpoint_descriptor *desc, struct xhci_container_ctx *ctx);
+static void xhci_exynos_free_event_ring(struct xhci_hcd *xhci);
+static struct xhci_segment *xhci_segment_alloc_uram_ep(struct xhci_hcd *xhci,
+					       unsigned int cycle_state,
+					       unsigned int max_packet,
+					       gfp_t flags, int seg_num,
+					       u32 endpoint_type);
+static struct xhci_ring *xhci_ring_alloc_uram(struct xhci_hcd *xhci,
+		unsigned int num_segs, unsigned int cycle_state,
+		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
+		u32 endpoint_type);
+static void xhci_exynos_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring);
+static int xhci_exynos_alloc_event_ring(struct xhci_hcd *xhci, gfp_t flags);
+
+int xhci_exynos_register_vendor_ops(void)
+{
+	return xhci_plat_register_vendor_ops(&ops);
+}
+EXPORT_SYMBOL_GPL(xhci_exynos_register_vendor_ops);
+
+static void xhci_exynos_quirks(struct device *dev, struct xhci_hcd *xhci)
+{
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
+
+	xhci->quirks |= XHCI_PLAT | xhci_exynos->quirks;
+}
+
+/* called during probe() after chip reset completes */
+static int xhci_exynos_setup(struct usb_hcd *hcd)
+{
+	int ret;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+
+	ret = xhci_gen_setup(hcd, xhci_exynos_quirks);
+	xhci_exynos_alloc_event_ring(xhci, GFP_KERNEL);
+
+	return ret;
+}
+
+static void xhci_exynos_usb_offload_enable_event_ring(struct xhci_hcd *xhci)
+{
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
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
+	temp |= (u32)160;
+	writel(temp, &xhci_exynos->ir_set_audio->irq_control);
+
+	temp = readl(&xhci_exynos->ir_set_audio->irq_pending);
+	xhci_info(xhci, "// [USB Audio] Enabling event ring interrupter %p by writing 0x%x to irq_pending",
+			xhci_exynos->ir_set_audio, (unsigned int) ER_IRQ_ENABLE(temp));
+	writel(ER_IRQ_ENABLE(temp), &xhci_exynos->ir_set_audio->irq_pending);
+}
+
+static int xhci_exynos_start(struct usb_hcd *hcd)
+{
+	struct xhci_hcd *xhci;
+	int ret;
+
+	ret = xhci_run(hcd);
+
+	xhci = hcd_to_xhci(hcd);
+	xhci_exynos_usb_offload_enable_event_ring(xhci);
+
+	return ret;
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
+
+static int xhci_exynos_address_device(struct usb_hcd *hcd, struct usb_device *udev)
+{
+	int ret;
+
+	ret = xhci_address_device(hcd, udev);
+
+	/* TODO: store and pass hw info to Co-Processor here*/
+
+	return ret;
+}
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
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+
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
+	struct xhci_plat_priv *priv = hcd_to_xhci_priv(hcd);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
+	struct xhci_hcd *xhci = hcd_to_xhci(hcd);
+
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
+const struct xhci_driver_overrides xhci_exynos_overrides = {
+	.reset = xhci_exynos_setup,
+	.start = xhci_exynos_start,
+	.add_endpoint = xhci_exynos_add_endpoint,
+	.address_device = xhci_exynos_address_device,
+	.bus_suspend = xhci_exynos_bus_suspend,
+	.bus_resume = xhci_exynos_bus_resume,
+};
+
+static int xhci_exynos_vendor_init(struct xhci_hcd *xhci, struct device *dev)
+{
+	struct usb_hcd		*hcd;
+	struct xhci_hcd_exynos	*xhci_exynos;
+	struct xhci_plat_priv *priv;
+	struct wakeup_source	*main_wakelock, *shared_wakelock;
+
+	xhci_plat_override_driver(&xhci_exynos_overrides);
+	dev->driver->pm = &xhci_exynos_pm_ops;
+
+	main_wakelock = wakeup_source_register(dev, dev_name(dev));
+	__pm_stay_awake(main_wakelock);
+
+	/* Initialization shared wakelock for SS HCD */
+	shared_wakelock = wakeup_source_register(dev, dev_name(dev));
+	__pm_stay_awake(shared_wakelock);
+
+	hcd = xhci->main_hcd;
+
+	priv = hcd_to_xhci_priv(hcd);
+	xhci_exynos = priv->vendor_priv;
+	xhci_exynos->dev = dev;
+	xhci_exynos->main_wakelock = main_wakelock;
+	xhci_exynos->shared_wakelock = shared_wakelock;
+
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
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
+	/* If URAM is not allocated, it try to allocate from URAM */
+	if (xhci_exynos->exynos_uram_isoc_out_alloc == 0 && endpoint_type == ISOC_OUT_EP) {
+		xhci_exynos->exynos_uram_isoc_out_alloc = 1;
+		return xhci_ring_alloc_uram(xhci, 1, 1, ring_type, max_packet, mem_flags,
+						endpoint_type);
+	} else if (xhci_exynos->exynos_uram_isoc_in_alloc == 0 && endpoint_type == ISOC_IN_EP) {
+		xhci_exynos->exynos_uram_isoc_in_alloc = 1;
+		return xhci_ring_alloc_uram(xhci, 1, 1, ring_type, max_packet, mem_flags,
+						endpoint_type);
+	} else
+		return xhci_ring_alloc(xhci, 2, 1, ring_type, max_packet, mem_flags);
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
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
+
+	if (type != XHCI_CTX_TYPE_INPUT && xhci_exynos->exynos_uram_ctx_alloc == 0) {
+		/* Only first Device Context uses URAM */
+		int i;
+
+		ctx->bytes = ioremap(EXYNOS_URAM_DEVICE_CTX_ADDR, EXYNOS_URAM_CTX_SIZE);
+		if (!ctx->bytes)
+			return;
+
+		for (i = 0; i < EXYNOS_URAM_CTX_SIZE; i++)
+			ctx->bytes[i] = 0;
+
+		ctx->dma = EXYNOS_URAM_DEVICE_CTX_ADDR;
+
+		xhci_exynos->exynos_uram_ctx_alloc = 1;
+	} else {
+		ctx->bytes = dma_pool_zalloc(xhci->device_pool, flags, &ctx->dma);
+		if (!ctx->bytes)
+			return;
+	}
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
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
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
+
+static void xhci_exynos_parse_endpoint(struct xhci_hcd *xhci, struct usb_device *udev,
+		struct usb_endpoint_descriptor *desc, struct xhci_container_ctx *ctx)
+{
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
+	struct usb_endpoint_descriptor *d = desc;
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
+static void xhci_exynos_segment_free_skip(struct xhci_hcd *xhci, struct xhci_segment *seg)
+{
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
+
+	if (seg->trbs) {
+		/* Check URAM address for memory free */
+		if (seg->dma == EXYNOS_URAM_ABOX_EVT_RING_ADDR) {
+			iounmap(seg->trbs);
+		} else if (seg->dma == EXYNOS_URAM_ISOC_OUT_RING_ADDR) {
+			xhci_exynos->exynos_uram_isoc_out_alloc = 0;
+			iounmap(seg->trbs);
+		} else if (seg->dma == EXYNOS_URAM_ISOC_IN_RING_ADDR) {
+			xhci_exynos->exynos_uram_isoc_in_alloc = 0;
+			iounmap(seg->trbs);
+		} else
+			dma_pool_free(xhci->segment_pool, seg->trbs, seg->dma);
+
+		seg->trbs = NULL;
+	}
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
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
+
+	xhci_exynos_ring_free(xhci, xhci_exynos->event_ring_audio);
+}
+
+static void xhci_exynos_set_hc_event_deq_audio(struct xhci_hcd *xhci)
+{
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
+
+	u64 temp;
+	dma_addr_t deq;
+
+	deq = xhci_trb_virt_to_dma(xhci_exynos->event_ring_audio->deq_seg,
+			xhci_exynos->event_ring_audio->dequeue);
+	if (deq == 0 && !in_interrupt())
+		xhci_warn(xhci, "WARN something wrong with SW event ring "
+				"dequeue ptr.\n");
+	/* Update HC event ring dequeue pointer */
+	temp = xhci_read_64(xhci, &xhci_exynos->ir_set_audio->erst_dequeue);
+	temp &= ERST_PTR_MASK;
+	/* Don't clear the EHB bit (which is RW1C) because
+	 * there might be more events to service.
+	 */
+	temp &= ~ERST_EHB;
+	xhci_info(xhci,	"//[%s] Write event ring dequeue pointer = 0x%llx, "
+			"preserving EHB bit", __func__,
+			((u64) deq & (u64) ~ERST_PTR_MASK) | temp);
+	xhci_write_64(xhci, ((u64) deq & (u64) ~ERST_PTR_MASK) | temp,
+			&xhci_exynos->ir_set_audio->erst_dequeue);
+
+}
+
+
+
+static int xhci_exynos_alloc_event_ring(struct xhci_hcd *xhci, gfp_t flags)
+{
+	struct xhci_plat_priv *priv = xhci_to_priv(xhci);
+	struct xhci_hcd_exynos *xhci_exynos = priv->vendor_priv;
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
+static struct xhci_segment *xhci_segment_alloc_uram(struct xhci_hcd *xhci,
+					       unsigned int cycle_state,
+					       unsigned int max_packet,
+					       gfp_t flags)
+{
+	struct xhci_segment *seg;
+	dma_addr_t	dma;
+	int		i;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+
+	seg = kzalloc_node(sizeof(*seg), flags, dev_to_node(dev));
+	if (!seg)
+		return NULL;
+
+	seg->trbs = ioremap(EXYNOS_URAM_ABOX_EVT_RING_ADDR, TRB_SEGMENT_SIZE);
+	if (!seg->trbs)
+		return NULL;
+
+	dma = EXYNOS_URAM_ABOX_EVT_RING_ADDR;
+
+	if (max_packet) {
+		seg->bounce_buf = kzalloc_node(max_packet, flags,
+					dev_to_node(dev));
+		if (!seg->bounce_buf) {
+			dma_pool_free(xhci->segment_pool, seg->trbs, dma);
+			kfree(seg);
+			return NULL;
+		}
+	}
+	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs */
+	if (cycle_state == 0) {
+		for (i = 0; i < TRBS_PER_SEGMENT; i++)
+			seg->trbs[i].link.control |= cpu_to_le32(TRB_CYCLE);
+	}
+	seg->dma = dma;
+	seg->next = NULL;
+
+	return seg;
+}
+
+static struct xhci_segment *xhci_segment_alloc_uram_ep(struct xhci_hcd *xhci,
+					       unsigned int cycle_state,
+					       unsigned int max_packet,
+					       gfp_t flags, int seg_num,
+					       u32 endpoint_type)
+{
+	struct xhci_segment *seg;
+	dma_addr_t	dma;
+	int		i;
+	struct device *dev = xhci_to_hcd(xhci)->self.sysdev;
+
+	seg = kzalloc_node(sizeof(*seg), flags, dev_to_node(dev));
+	if (!seg)
+		return NULL;
+
+	if (seg_num != 0) {
+		/* Support just one segment */
+		xhci_err(xhci, "%s : Unexpected SEG NUMBER!\n", __func__);
+		return NULL;
+	}
+
+	if (endpoint_type == ISOC_OUT_EP) {
+		seg->trbs = ioremap(EXYNOS_URAM_ISOC_OUT_RING_ADDR,
+							TRB_SEGMENT_SIZE);
+		if (!seg->trbs)
+			return NULL;
+
+		dma = EXYNOS_URAM_ISOC_OUT_RING_ADDR;
+	} else if (endpoint_type == ISOC_IN_EP) {
+		seg->trbs = ioremap(EXYNOS_URAM_ISOC_IN_RING_ADDR,
+							TRB_SEGMENT_SIZE);
+		if (!seg->trbs)
+			return NULL;
+
+		dma = EXYNOS_URAM_ISOC_IN_RING_ADDR;
+	} else {
+		xhci_err(xhci, "%s : Unexpected EP Type!\n", __func__);
+		return NULL;
+	}
+
+	for (i = 0; i < 256; i++) {
+		seg->trbs[i].link.segment_ptr = 0;
+		seg->trbs[i].link.intr_target = 0;
+		seg->trbs[i].link.control = 0;
+	}
+
+
+	if (max_packet) {
+		seg->bounce_buf = kzalloc_node(max_packet, flags,
+					dev_to_node(dev));
+		if (!seg->bounce_buf) {
+			dma_pool_free(xhci->segment_pool, seg->trbs, dma);
+			kfree(seg);
+			return NULL;
+		}
+	}
+	/* If the cycle state is 0, set the cycle bit to 1 for all the TRBs */
+	if (cycle_state == 0) {
+		for (i = 0; i < TRBS_PER_SEGMENT; i++)
+			seg->trbs[i].link.control |= cpu_to_le32(TRB_CYCLE);
+	}
+	seg->dma = dma;
+	seg->next = NULL;
+
+	return seg;
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
+	if (type == TYPE_ISOC) {
+		prev = xhci_segment_alloc_uram_ep(xhci, cycle_state,
+							max_packet, flags, 0,
+							endpoint_type);
+	} else if (type == TYPE_EVENT) {
+		prev = xhci_segment_alloc_uram(xhci, cycle_state, max_packet, flags);
+	} else {
+		xhci_err(xhci, "Unexpected TYPE for URAM allocation!\n");
+		return -ENOMEM;
+	}
+
+	if (!prev)
+		return -ENOMEM;
+	num_segs--;
+
+	*first = prev;
+	while (num_segs > 0) {
+		struct xhci_segment *next = NULL;
+
+		if (type == TYPE_ISOC) {
+			prev = xhci_segment_alloc_uram_ep(xhci, cycle_state,
+							max_packet, flags, 1,
+							endpoint_type);
+		} else if (type == TYPE_EVENT) {
+			next = xhci_segment_alloc_uram(xhci, cycle_state,
+							max_packet, flags);
+		} else {
+			xhci_err(xhci, "Unexpected TYPE for URAM alloc(multi)!\n");
+			return -ENOMEM;
+		}
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
+
+	return ring;
+
+fail:
+	kfree(ring);
+	return NULL;
+}
+
+static int xhci_exynos_suspend(struct device *dev)
+{
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+
+	/* TODO: AP sleep scenario*/
+
+	return xhci_suspend(xhci, device_may_wakeup(dev));
+}
+
+static int xhci_exynos_resume(struct device *dev)
+{
+	struct usb_hcd	*hcd = dev_get_drvdata(dev);
+	struct xhci_hcd	*xhci = hcd_to_xhci(hcd);
+	int ret;
+
+	/* TODO: AP resume scenario*/
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
+static const struct dev_pm_ops xhci_exynos_pm_ops = {
+	SET_SYSTEM_SLEEP_PM_OPS(xhci_exynos_suspend, xhci_exynos_resume)
+};
+
+MODULE_DESCRIPTION("xHCI Exynos Host Controller Driver");
+MODULE_LICENSE("GPL");
-- 
2.31.1

