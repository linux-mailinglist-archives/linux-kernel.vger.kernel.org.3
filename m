Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5B9A250F983
	for <lists+linux-kernel@lfdr.de>; Tue, 26 Apr 2022 12:02:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348109AbiDZKCb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 26 Apr 2022 06:02:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42734 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1347923AbiDZKBi (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 26 Apr 2022 06:01:38 -0400
Received: from mailout2.samsung.com (mailout2.samsung.com [203.254.224.25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AB4D835DCE
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 02:20:31 -0700 (PDT)
Received: from epcas2p1.samsung.com (unknown [182.195.41.53])
        by mailout2.samsung.com (KnoxPortal) with ESMTP id 20220426092028epoutp023782370c3041dd89b6838a41743fcfb6~pZ8OjWv9B2734427344epoutp02u
        for <linux-kernel@vger.kernel.org>; Tue, 26 Apr 2022 09:20:28 +0000 (GMT)
DKIM-Filter: OpenDKIM Filter v2.11.0 mailout2.samsung.com 20220426092028epoutp023782370c3041dd89b6838a41743fcfb6~pZ8OjWv9B2734427344epoutp02u
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=samsung.com;
        s=mail20170921; t=1650964828;
        bh=ZNVwTkI0jqgxKhBqbwHfzrqudkVRk2e7rBsoOsg0dHQ=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=az7yKLxrCmhnoc6BtuBQdamdL/XT2pYwKV8QUkAd/RuGRUEJRW1nkpbMRA1d5yMyI
         uFvzCUio9FlB00LjqHhm9xUhPIOxiE8Yn3w0dO6R4NfGbHgNEhEiDFJmdjzCN+HlU6
         SVU/pbuypBOlqcwf4ybZVAY3TYJRgeR6B49bpzH4=
Received: from epsnrtp3.localdomain (unknown [182.195.42.164]) by
        epcas2p2.samsung.com (KnoxPortal) with ESMTP id
        20220426092027epcas2p220a87b91f4eab95417fb4ab5f4b7b021~pZ8OBYLIV2824728247epcas2p2I;
        Tue, 26 Apr 2022 09:20:27 +0000 (GMT)
Received: from epsmges2p1.samsung.com (unknown [182.195.36.89]) by
        epsnrtp3.localdomain (Postfix) with ESMTP id 4KnbvX39t8z4x9Q7; Tue, 26 Apr
        2022 09:20:24 +0000 (GMT)
Received: from epcas2p3.samsung.com ( [182.195.41.55]) by
        epsmges2p1.samsung.com (Symantec Messaging Gateway) with SMTP id
        C3.76.10069.859B7626; Tue, 26 Apr 2022 18:20:24 +0900 (KST)
Received: from epsmtrp1.samsung.com (unknown [182.195.40.13]) by
        epcas2p3.samsung.com (KnoxPortal) with ESMTPA id
        20220426092023epcas2p32946c087135ca4b7e63b03915060c55d~pZ8JpsKUv0586405864epcas2p3C;
        Tue, 26 Apr 2022 09:20:23 +0000 (GMT)
Received: from epsmgms1p1new.samsung.com (unknown [182.195.42.41]) by
        epsmtrp1.samsung.com (KnoxPortal) with ESMTP id
        20220426092023epsmtrp1e9a83ef21a393a779146bfef9765806d~pZ8Joxfec2050020500epsmtrp14;
        Tue, 26 Apr 2022 09:20:23 +0000 (GMT)
X-AuditID: b6c32a45-a8fff70000002755-0a-6267b958c4d5
Received: from epsmtip2.samsung.com ( [182.195.34.31]) by
        epsmgms1p1new.samsung.com (Symantec Messaging Gateway) with SMTP id
        CB.63.08853.659B7626; Tue, 26 Apr 2022 18:20:22 +0900 (KST)
Received: from ubuntu.dsn.sec.samsung.com (unknown [10.229.95.128]) by
        epsmtip2.samsung.com (KnoxPortal) with ESMTPA id
        20220426092022epsmtip21e6f7119d1113df7baf9b13033c35b73~pZ8JcPZsy2696726967epsmtip2C;
        Tue, 26 Apr 2022 09:20:22 +0000 (GMT)
From:   Daehwan Jung <dh10.jung@samsung.com>
To:     Mathias Nyman <mathias.nyman@intel.com>,
        Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     linux-usb@vger.kernel.org (open list:USB XHCI DRIVER),
        linux-kernel@vger.kernel.org (open list),
        Howard Yen <howardyen@google.com>,
        Jack Pham <jackp@codeaurora.org>,
        Puma Hsu <pumahsu@google.com>,
        "J . Avila" <elavila@google.com>,
        Daehwan Jung <dh10.jung@samsung.com>, sc.suh@samsung.com,
        Krzysztof Kozlowski <krzysztof.kozlowski@canonical.com>
Subject: [PATCH v4 5/5] usb: host: add xhci-exynos driver
Date:   Tue, 26 Apr 2022 18:18:48 +0900
Message-Id: <1650964728-175347-6-git-send-email-dh10.jung@samsung.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFvrBKsWRmVeSWpSXmKPExsWy7bCmuW7EzvQkgy+HxC3uLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2D93DbtH35ZVjB6fN8kFsEdl22SkJqakFimk5iXnp2TmpdsqeQfH
        O8ebmhkY6hpaWpgrKeQl5qbaKrn4BOi6ZeYAnaikUJaYUwoUCkgsLlbSt7Mpyi8tSVXIyC8u
        sVVKLUjJKTAv0CtOzC0uzUvXy0stsTI0MDAyBSpMyM7Yd+gDS8GBOYwV516dYGtg/NjE2MXI
        ySEhYCJx8dwDIJuLQ0hgB6PEyk+vWSGcT4wSz67vZIdwvjFKrDjXyQrTcu3jBBYQW0hgL6PE
        k2PyEEU/GCX+fX3F3MXIwcEmoCXxfSHYChGBOImlnZeYQGqYBZ4wSex4d4sJJCEsYCnRvnMD
        K0g9i4CqxI33GSBhXgE3idct25kgdslJ3DzXyQxicwq4S7zoWcQOEf/JLnH5US6E7SLR1niW
        GcIWlnh1fAtUjZTEy/42KLtYYtenVrAbJAQaGCUaH5yAajCWmPWsnRHkBmYBTYn1u/RBTAkB
        ZYkjt8BeZBbgk+g4/JcdIswr0dEmBNGoLDH98gRoiEhKHHx9Dmqgh8S3pxvZICEyi1GifcJD
        5gmMcrMQFixgZFzFKJZaUJybnlpsVGAIj7Hk/NxNjOAkqOW6g3Hy2w96hxiZOBgPMUpwMCuJ
        8E5VTUsS4k1JrKxKLcqPLyrNSS0+xGgKDLqJzFKiyfnANJxXEm9oYmlgYmZmaG5kamCuJM7r
        lbIhUUggPbEkNTs1tSC1CKaPiYNTqoHpgmtrs1R/s/JBpd0zrmR2/W5bLX7wiX2sdUrpvqQT
        R0zn5723m5my5/u8E3mbYnrk5/QGyPwo+uGi/YmhyHMpQ/yFxqDneQ8bg5JffFFbse3gYVZ3
        n2eyD3Z8qD5665CR6aWlCqereqr/c3+ZLtpZayk2bUaU1LmAeJvg6I/vp2yzDgqtmtm5fdPd
        9TsYjlRvyHjYpvXi9AyXXT98mu5a+ftorVkwlW1ng8vvP7te13+/xWzz7Vev3oeMDXVX+cRY
        Pk88uzX4k3jbjGsVO/bcsLJ6E/BLw93m0l6e6TGtP49eOzdn9s3QUIH5i2bnJV7U3vb0SXeD
        ZfIsvdWXyhlvLIvamJxjsqVyQvZ/W41fx5VYijMSDbWYi4oTAfFDTu4LBAAA
X-Brightmail-Tracker: H4sIAAAAAAAAA+NgFtrMLMWRmVeSWpSXmKPExsWy7bCSvG7YzvQkgxMvbSzuLJjGZPHkyCJ2
        i+bF69ksrv95z2jR/vwCm8XGtz+YLC7vmsNmsWhZK7NF86YprBYz1ypbdN29wejA7TGroZfN
        43JfL5PHgk2lHov3vGTy2D93DbtH35ZVjB6fN8kFsEdx2aSk5mSWpRbp2yVwZew79IGl4MAc
        xopzr06wNTB+bGLsYuTkkBAwkbj2cQJLFyMXh5DAbkaJef+3sEEkJCWWzr3BDmELS9xvOcIK
        UfSNUeLxhmlMXYwcHGwCWhLfF4INEhGIk1hxeQ8LiM0s8IZJ4uruJBBbWMBSon3nBlaQchYB
        VYkb7zNAwrwCbhKvW7YzQYyXk7h5rpMZxOYUcJd40bMIbK0QUM3kFdeZJjDyLWBkWMUomVpQ
        nJueW2xYYJiXWq5XnJhbXJqXrpecn7uJERyuWpo7GLev+qB3iJGJg/EQowQHs5II71TVtCQh
        3pTEyqrUovz4otKc1OJDjNIcLErivBe6TsYLCaQnlqRmp6YWpBbBZJk4OKUamMoTuZ6Vclk/
        PZ6xxEdKWOHpllXLjnyW3BAyLfjktpMBRfNSHukUXli9t+XoTIaZBUacTz4e6RbsPX5MVStS
        89Bh3snrO3+GbuSYfOP37kXZqzjMSjISFrAcrwzrFl8Q+mpjws0ZpxZ4qU37lXl77c83ejsk
        llitNZnnF/tgWgXfP/nXrXV79q6VLa8zsdx2Pj7g/BSNjdYznArLrHf+c26aejXdbOs9uykJ
        Kw/OD4yNNNPsUZiocV6rL/8/e+e5KeuO5Gk+Dt83r6NP/18Nz7zVfzyZuN4Z7dE8vdNjyYod
        N7OV/Q9vLnpqO1tS10c968qpfdoyFY0bTefzaq4UCj4fvfrnFW6XW3WnbpzS3WanxFKckWio
        xVxUnAgAnNy4MsYCAAA=
X-CMS-MailID: 20220426092023epcas2p32946c087135ca4b7e63b03915060c55d
X-Msg-Generator: CA
Content-Type: text/plain; charset="utf-8"
X-Sendblock-Type: AUTO_CONFIDENTIAL
CMS-TYPE: 102P
DLP-Filter: Pass
X-CFilter-Loop: Reflected
X-CMS-RootMailID: 20220426092023epcas2p32946c087135ca4b7e63b03915060c55d
References: <1650964728-175347-1-git-send-email-dh10.jung@samsung.com>
        <CGME20220426092023epcas2p32946c087135ca4b7e63b03915060c55d@epcas2p3.samsung.com>
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_PASS,SPF_PASS autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

This driver is for Samsung Exynos xhci host conroller. It uses xhci-plat
driver mainly and extends some functions by xhci hooks and overrides.

It supports USB Audio offload with Co-processor. It only cares DCBAA,
Device Context, Transfer Ring, Event Ring, and ERST. They are allocated
on specific address with xhci hooks. Co-processor could use them directly
without xhci driver after then.

Signed-off-by: Daehwan Jung <dh10.jung@samsung.com>
---
 drivers/usb/host/Kconfig       |   8 +
 drivers/usb/host/Makefile      |   1 +
 drivers/usb/host/xhci-exynos.c | 567 +++++++++++++++++++++++++++++++++
 drivers/usb/host/xhci-exynos.h |  50 +++
 4 files changed, 626 insertions(+)
 create mode 100644 drivers/usb/host/xhci-exynos.c
 create mode 100644 drivers/usb/host/xhci-exynos.h

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
index 000000000000..4f22f620d7e0
--- /dev/null
+++ b/drivers/usb/host/xhci-exynos.c
@@ -0,0 +1,567 @@
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
+#include "xhci-exynos.h"
+
+static const struct dev_pm_ops xhci_exynos_pm_ops;
+
+static struct xhci_vendor_ops ops;
+static void xhci_exynos_parse_endpoint(struct xhci_hcd *xhci, struct usb_device *udev,
+		struct usb_endpoint_descriptor *desc, struct xhci_container_ctx *ctx);
+static void xhci_exynos_free_event_ring(struct xhci_hcd *xhci);
+static struct xhci_ring *xhci_ring_alloc_uram(struct xhci_hcd *xhci,
+		unsigned int num_segs, unsigned int cycle_state,
+		enum xhci_ring_type type, unsigned int max_packet, gfp_t flags,
+		u32 endpoint_type);
+static void xhci_exynos_ring_free(struct xhci_hcd *xhci, struct xhci_ring *ring);
+static int xhci_exynos_alloc_event_ring(struct xhci_hcd *xhci, gfp_t flags);
+
+static int xhci_exynos_register_vendor_ops(struct xhci_vendor_ops *vendor_ops)
+{
+	return xhci_plat_register_vendor_ops(&ops);
+}
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
+	struct xhci_hcd *xhci;
+	int ret;
+
+	ret = xhci_address_device(hcd, udev);
+	xhci = hcd_to_xhci(hcd);
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
+	struct platform_device	*pdev;
+
+	pdev = to_platform_device(dev);
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
diff --git a/drivers/usb/host/xhci-exynos.h b/drivers/usb/host/xhci-exynos.h
new file mode 100644
index 000000000000..4428f8f3a5ff
--- /dev/null
+++ b/drivers/usb/host/xhci-exynos.h
@@ -0,0 +1,50 @@
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
+
+	unsigned long long	quirks;
+};
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

