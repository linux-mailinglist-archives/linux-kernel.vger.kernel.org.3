Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 411C9528043
	for <lists+linux-kernel@lfdr.de>; Mon, 16 May 2022 10:55:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233500AbiEPIy4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 16 May 2022 04:54:56 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39162 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242081AbiEPIxn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 16 May 2022 04:53:43 -0400
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6C57313FA1;
        Mon, 16 May 2022 01:53:34 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
         s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=QhmFm5x8eXWshJW5s2KSpUl/2VnAiPuQLb7xfj61KYo=; b=pTr671ML7JqfGzqWay29nNNcTI
        5pHHnwtL8rEqweyAYjfvsdmJbEv0rk0a8vzp7/0KkfLxn+NTGfhyhFl4814Mja5jh/0VAedMT/zEJ
        iBI52cy5ftLg7QVjPPuYMHPItj8w/C78ZrV7kWnX1Bu8s6y41kGPFnNAKzDIBDpq2UxpyNdDVZEv6
        T/wQQ4+85g6bekebGUlxB0XJrlRFEGtPQoJ0fMO91rp5vDA8lPgZf3baB9pivOyTEUqhqCA0mZX3N
        gZiWnpFvDlhiYPlYShMZJkoYBgMBYwW+WPB1xR6IeSvwZNGvteaNOnNzUhDtlIzCXyF0cNz66ytUF
        0C9NfWTQ==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa (TLS1.3:ECDHE_RSA_AES_256_GCM_SHA384:256)
        (Exim 4.92)
        (envelope-from <cyndis@kapsi.fi>)
        id 1nqWTe-0005fd-K6; Mon, 16 May 2022 11:53:18 +0300
From:   cyndis@kapsi.fi
To:     thierry.reding@gmail.com, jonathanh@nvidia.com, joro@8bytes.org,
        will@kernel.org, robin.murphy@arm.com, robh+dt@kernel.org,
        krzysztof.kozlowski@canonical.com
Cc:     linux-tegra@vger.kernel.org, dri-devel@lists.freedesktop.org,
        iommu@lists.linux-foundation.org, linux-kernel@vger.kernel.org,
        devicetree@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        Mikko Perttunen <mperttunen@nvidia.com>
Subject: [PATCH v5 2/9] gpu: host1x: Add context bus
Date:   Mon, 16 May 2022 11:52:51 +0300
Message-Id: <20220516085258.1227691-3-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220516085258.1227691-1-cyndis@kapsi.fi>
References: <20220516085258.1227691-1-cyndis@kapsi.fi>
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
2.36.1

