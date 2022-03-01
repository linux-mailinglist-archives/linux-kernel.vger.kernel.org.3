Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 48DC94C901A
	for <lists+linux-kernel@lfdr.de>; Tue,  1 Mar 2022 17:16:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236144AbiCAQQq (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 1 Mar 2022 11:16:46 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42092 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233033AbiCAQQS (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 1 Mar 2022 11:16:18 -0500
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 2C0BE91370;
        Tue,  1 Mar 2022 08:15:34 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=6sRdRmuArPB9M+DZhEXPrB8b5Pq6lEbN63VVfh3955E=; b=hghlNdvKgM7ALxY2nJrCubp8BI
        XPNh06HpEJya/ZJJK4ZhiiqygiGORv5OIM5sLeb8wEZlMUUJtmoP17eV3WW2ZFqPn3kA8+WBKzz4M
        +koy7DKYiq6WlfWT6zMJ4t3h1dM2M0rzlLpJLd7iskKEw8P5rAWyAfLR9IlcMRr3fgFN4FtybcHkh
        P0I3h3d6kY4YKr8iITrY9D+DcfXwmgH0/Wh31pJV3MBG8CqxDosDy08yB1nC7ZZY4UXxdW3gUGZDe
        pnDBPIFHftenPECJFbOVvgcpe2HeLj92e06W7eqWthuyaQAcxZ/yETzOOj0ovGMaYtnU2HEB/iANK
        7BhbbcNw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.2:ECDHE_RSA_AES_128_GCM_SHA256:128)
        (Exim 4.89)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nP59q-0003Z8-LR; Tue, 01 Mar 2022 18:15:26 +0200
From:   cyndis@kapsi.fi
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v4 2/9] gpu: host1x: Add context bus
Date:   Tue,  1 Mar 2022 18:14:48 +0200
Message-Id: <20220301161455.4037062-3-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.35.0
In-Reply-To: <20220301161455.4037062-1-cyndis@kapsi.fi>
References: <20220301161455.4037062-1-cyndis@kapsi.fi>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-SA-Exim-Connect-IP: 91.158.25.70
X-SA-Exim-Mail-From: cyndis@kapsi.fi
X-SA-Exim-Scanned: No (on mail.kapsi.fi); SAEximRunCond expanded to false
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Mikko Perttunen <mperttunen@nvidia.com>

The context bus is a "dummy" bus that contains struct devices that
correspond to IOMMU contexts assigned through Host1x to processes.

Even when host1x itself is built as a module, the bus is registered
in built-in code so that the built-in ARM SMMU driver is able to
reference it.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
v4:
* Export bus as GPL
---
 drivers/gpu/Makefile               |  3 +--
 drivers/gpu/host1x/Kconfig         |  5 +++++
 drivers/gpu/host1x/Makefile        |  1 +
 drivers/gpu/host1x/context_bus.c   | 31 ++++++++++++++++++++++++++++++
 include/linux/host1x_context_bus.h | 15 +++++++++++++++
 5 files changed, 53 insertions(+), 2 deletions(-)
 create mode 100644 drivers/gpu/host1x/context_bus.c
 create mode 100644 include/linux/host1x_context_bus.h

diff --git a/drivers/gpu/Makefile b/drivers/gpu/Makefile
index 835c88318cec..8997f0096545 100644
--- a/drivers/gpu/Makefile
+++ b/drivers/gpu/Makefile
@@ -2,7 +2,6 @@
 # drm/tegra depends on host1x, so if both drivers are built-in care must be
 # taken to initialize them in the correct order. Link order is the only way
 # to ensure this currently.
-obj-$(CONFIG_TEGRA_HOST1X)	+= host1x/
-obj-y			+= drm/ vga/
+obj-y			+= host1x/ drm/ vga/
 obj-$(CONFIG_IMX_IPUV3_CORE)	+= ipu-v3/
 obj-$(CONFIG_TRACE_GPU_MEM)		+= trace/
diff --git a/drivers/gpu/host1x/Kconfig b/drivers/gpu/host1x/Kconfig
index 6815b4db17c1..1861a8180d3f 100644
--- a/drivers/gpu/host1x/Kconfig
+++ b/drivers/gpu/host1x/Kconfig
@@ -1,8 +1,13 @@
 # SPDX-License-Identifier: GPL-2.0-only
+
+config TEGRA_HOST1X_CONTEXT_BUS
+	bool
+
 config TEGRA_HOST1X
 	tristate "NVIDIA Tegra host1x driver"
 	depends on ARCH_TEGRA || (ARM && COMPILE_TEST)
 	select DMA_SHARED_BUFFER
+	select TEGRA_HOST1X_CONTEXT_BUS
 	select IOMMU_IOVA
 	help
 	  Driver for the NVIDIA Tegra host1x hardware.
diff --git a/drivers/gpu/host1x/Makefile b/drivers/gpu/host1x/Makefile
index d2b6f7de0498..c891a3e33844 100644
--- a/drivers/gpu/host1x/Makefile
+++ b/drivers/gpu/host1x/Makefile
@@ -18,3 +18,4 @@ host1x-y = \
 	hw/host1x07.o
 
 obj-$(CONFIG_TEGRA_HOST1X) += host1x.o
+obj-$(CONFIG_TEGRA_HOST1X_CONTEXT_BUS) += context_bus.o
diff --git a/drivers/gpu/host1x/context_bus.c b/drivers/gpu/host1x/context_bus.c
new file mode 100644
index 000000000000..b0d35b2bbe89
--- /dev/null
+++ b/drivers/gpu/host1x/context_bus.c
@@ -0,0 +1,31 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, NVIDIA Corporation.
+ */
+
+#include <linux/device.h>
+#include <linux/of.h>
+
+struct bus_type host1x_context_device_bus_type = {
+	.name = "host1x-context",
+};
+EXPORT_SYMBOL_GPL(host1x_context_device_bus_type);
+
+static int __init host1x_context_device_bus_init(void)
+{
+	int err;
+
+	if (!of_machine_is_compatible("nvidia,tegra186") &&
+	    !of_machine_is_compatible("nvidia,tegra194") &&
+	    !of_machine_is_compatible("nvidia,tegra234"))
+		return 0;
+
+	err = bus_register(&host1x_context_device_bus_type);
+	if (err < 0) {
+		pr_err("bus type registration failed: %d\n", err);
+		return err;
+	}
+
+	return 0;
+}
+postcore_initcall(host1x_context_device_bus_init);
diff --git a/include/linux/host1x_context_bus.h b/include/linux/host1x_context_bus.h
new file mode 100644
index 000000000000..72462737a6db
--- /dev/null
+++ b/include/linux/host1x_context_bus.h
@@ -0,0 +1,15 @@
+/* SPDX-License-Identifier: GPL-2.0-or-later */
+/*
+ * Copyright (c) 2021, NVIDIA Corporation. All rights reserved.
+ */
+
+#ifndef __LINUX_HOST1X_CONTEXT_BUS_H
+#define __LINUX_HOST1X_CONTEXT_BUS_H
+
+#include <linux/device.h>
+
+#ifdef CONFIG_TEGRA_HOST1X_CONTEXT_BUS
+extern struct bus_type host1x_context_device_bus_type;
+#endif
+
+#endif
-- 
2.35.0

