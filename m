Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6D0335AED10
	for <lists+linux-kernel@lfdr.de>; Tue,  6 Sep 2022 16:30:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241812AbiIFOQc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 6 Sep 2022 10:16:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50530 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S241544AbiIFONh (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 6 Sep 2022 10:13:37 -0400
X-Greylist: delayed 1118 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Tue, 06 Sep 2022 06:47:59 PDT
Received: from mail.kapsi.fi (mail.kapsi.fi [IPv6:2001:67c:1be8::25])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B182888DD4;
        Tue,  6 Sep 2022 06:47:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=kapsi.fi;
        s=20161220; h=Content-Transfer-Encoding:MIME-Version:References:In-Reply-To:
        Message-Id:Date:Subject:Cc:To:From:Sender:Reply-To:Content-Type:Content-ID:
        Content-Description:Resent-Date:Resent-From:Resent-Sender:Resent-To:Resent-Cc
        :Resent-Message-ID:List-Id:List-Help:List-Unsubscribe:List-Subscribe:
        List-Post:List-Owner:List-Archive;
        bh=oQqM+pClrZfQCqMiQgtSnptBcoYj79KgVRq3HWP8sUE=; b=Ew6NQ4YAS5/XU6N+2TljeDjLVC
        nJkkzrlXnwv2wAcqUgRknuIrjLYNFpbV2wA2xrFdPuzSXcNMEnt1D9mBAX5Av+Lziq1BqE5unIuS7
        d9KJ6RhveHspmXi6HiRMV2MfMLOV8gdYEaCZXMG0Z5m6qBevNl2n9sGeFk7d+r7GQ7rTsbWxtwjmx
        EjoqreCqQTMtNVrF+mOKMuHCK6VgfNtQH7Wey0bxqRFmMv1u2ZOZt9moTfu/YKGFE28OVz8ixrcCD
        dbrBjU4xaKIzWfsgu3FPxQbde1fnxpk8k1HczvhtsBqduVLNr9dke5/hS/OkXew4I4DpU3wtC7Zif
        hyH6D3Pw==;
Received: from 91-158-25-70.elisa-laajakaista.fi ([91.158.25.70] helo=toshino.localdomain)
        by mail.kapsi.fi with esmtpsa  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.94.2)
        (envelope-from <cyndis@kapsi.fi>)
        id 1oVYdY-008sZV-VP; Tue, 06 Sep 2022 16:29:09 +0300
From:   Mikko Perttunen <cyndis@kapsi.fi>
To:     Thierry Reding <thierry.reding@gmail.com>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        Jonathan Hunter <jonathanh@nvidia.com>
Cc:     Mikko Perttunen <mperttunen@nvidia.com>,
        Ashish Mhetre <amhetre@nvidia.com>,
        Sameer Pujar <spujar@nvidia.com>,
        dri-devel@lists.freedesktop.org, linux-tegra@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 7/8] drm/tegra: Add code for booting RISC-V based engines
Date:   Tue,  6 Sep 2022 16:28:22 +0300
Message-Id: <20220906132823.2390953-8-cyndis@kapsi.fi>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220906132823.2390953-1-cyndis@kapsi.fi>
References: <20220906132823.2390953-1-cyndis@kapsi.fi>
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

Add helper code for booting RISC-V based engines where firmware is
located in a carveout.

Signed-off-by: Mikko Perttunen <mperttunen@nvidia.com>
---
 drivers/gpu/drm/tegra/Makefile |   3 +-
 drivers/gpu/drm/tegra/riscv.c  | 106 +++++++++++++++++++++++++++++++++
 drivers/gpu/drm/tegra/riscv.h  |  30 ++++++++++
 3 files changed, 138 insertions(+), 1 deletion(-)
 create mode 100644 drivers/gpu/drm/tegra/riscv.c
 create mode 100644 drivers/gpu/drm/tegra/riscv.h

diff --git a/drivers/gpu/drm/tegra/Makefile b/drivers/gpu/drm/tegra/Makefile
index df6cc986aeba..bb0d2c144b55 100644
--- a/drivers/gpu/drm/tegra/Makefile
+++ b/drivers/gpu/drm/tegra/Makefile
@@ -24,7 +24,8 @@ tegra-drm-y := \
 	gr3d.o \
 	falcon.o \
 	vic.o \
-	nvdec.o
+	nvdec.o \
+	riscv.o
 
 tegra-drm-y += trace.o
 
diff --git a/drivers/gpu/drm/tegra/riscv.c b/drivers/gpu/drm/tegra/riscv.c
new file mode 100644
index 000000000000..6580416408f8
--- /dev/null
+++ b/drivers/gpu/drm/tegra/riscv.c
@@ -0,0 +1,106 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022, NVIDIA Corporation.
+ */
+
+#include <linux/dev_printk.h>
+#include <linux/device.h>
+#include <linux/iopoll.h>
+#include <linux/of.h>
+
+#include "riscv.h"
+
+#define RISCV_CPUCTL					0x4388
+#define RISCV_CPUCTL_STARTCPU_TRUE			(1 << 0)
+#define RISCV_BR_RETCODE				0x465c
+#define RISCV_BR_RETCODE_RESULT_V(x)			((x) & 0x3)
+#define RISCV_BR_RETCODE_RESULT_PASS_V			3
+#define RISCV_BCR_CTRL					0x4668
+#define RISCV_BCR_CTRL_CORE_SELECT_RISCV		(1 << 4)
+#define RISCV_BCR_DMACFG				0x466c
+#define RISCV_BCR_DMACFG_TARGET_LOCAL_FB		(0 << 0)
+#define RISCV_BCR_DMACFG_LOCK_LOCKED			(1 << 31)
+#define RISCV_BCR_DMAADDR_PKCPARAM_LO			0x4670
+#define RISCV_BCR_DMAADDR_PKCPARAM_HI			0x4674
+#define RISCV_BCR_DMAADDR_FMCCODE_LO			0x4678
+#define RISCV_BCR_DMAADDR_FMCCODE_HI			0x467c
+#define RISCV_BCR_DMAADDR_FMCDATA_LO			0x4680
+#define RISCV_BCR_DMAADDR_FMCDATA_HI			0x4684
+#define RISCV_BCR_DMACFG_SEC				0x4694
+#define RISCV_BCR_DMACFG_SEC_GSCID(v)			((v) << 16)
+
+static void riscv_writel(struct tegra_drm_riscv *riscv, u32 value, u32 offset)
+{
+	writel(value, riscv->regs + offset);
+}
+
+int tegra_drm_riscv_read_descriptors(struct tegra_drm_riscv *riscv)
+{
+	struct tegra_drm_riscv_descriptor *bl = &riscv->bl_desc;
+	struct tegra_drm_riscv_descriptor *os = &riscv->os_desc;
+	const struct device_node *np = riscv->dev->of_node;
+	int err;
+
+#define READ_PROP(name, location) \
+	err = of_property_read_u32(np, name, location); \
+	if (err) { \
+		dev_err(riscv->dev, "failed to read " name ": %d\n", err); \
+		return err; \
+	}
+
+	READ_PROP("nvidia,bl-manifest-offset", &bl->manifest_offset);
+	READ_PROP("nvidia,bl-code-offset", &bl->code_offset);
+	READ_PROP("nvidia,bl-data-offset", &bl->data_offset);
+	READ_PROP("nvidia,os-manifest-offset", &os->manifest_offset);
+	READ_PROP("nvidia,os-code-offset", &os->code_offset);
+	READ_PROP("nvidia,os-data-offset", &os->data_offset);
+#undef READ_PROP
+
+	if (bl->manifest_offset == 0 && bl->code_offset == 0 &&
+	    bl->data_offset == 0 && os->manifest_offset == 0 &&
+	    os->code_offset == 0 && os->data_offset == 0) {
+		dev_err(riscv->dev, "descriptors not available\n");
+		return -EINVAL;
+	}
+
+	return 0;
+}
+
+int tegra_drm_riscv_boot_bootrom(struct tegra_drm_riscv *riscv, phys_addr_t image_address,
+				 u32 gscid, const struct tegra_drm_riscv_descriptor *desc)
+{
+	phys_addr_t addr;
+	int err;
+	u32 val;
+
+	riscv_writel(riscv, RISCV_BCR_CTRL_CORE_SELECT_RISCV, RISCV_BCR_CTRL);
+
+	addr = image_address + desc->manifest_offset;
+	riscv_writel(riscv, lower_32_bits(addr >> 8), RISCV_BCR_DMAADDR_PKCPARAM_LO);
+	riscv_writel(riscv, upper_32_bits(addr >> 8), RISCV_BCR_DMAADDR_PKCPARAM_HI);
+
+	addr = image_address + desc->code_offset;
+	riscv_writel(riscv, lower_32_bits(addr >> 8), RISCV_BCR_DMAADDR_FMCCODE_LO);
+	riscv_writel(riscv, upper_32_bits(addr >> 8), RISCV_BCR_DMAADDR_FMCCODE_HI);
+
+	addr = image_address + desc->data_offset;
+	riscv_writel(riscv, lower_32_bits(addr >> 8), RISCV_BCR_DMAADDR_FMCDATA_LO);
+	riscv_writel(riscv, upper_32_bits(addr >> 8), RISCV_BCR_DMAADDR_FMCDATA_HI);
+
+	riscv_writel(riscv, RISCV_BCR_DMACFG_SEC_GSCID(gscid), RISCV_BCR_DMACFG_SEC);
+	riscv_writel(riscv,
+		RISCV_BCR_DMACFG_TARGET_LOCAL_FB | RISCV_BCR_DMACFG_LOCK_LOCKED, RISCV_BCR_DMACFG);
+
+	riscv_writel(riscv, RISCV_CPUCTL_STARTCPU_TRUE, RISCV_CPUCTL);
+
+	err = readl_poll_timeout(
+		riscv->regs + RISCV_BR_RETCODE, val,
+		RISCV_BR_RETCODE_RESULT_V(val) == RISCV_BR_RETCODE_RESULT_PASS_V,
+		10, 100000);
+	if (err) {
+		dev_err(riscv->dev, "error during bootrom execution. BR_RETCODE=%d\n", val);
+		return err;
+	}
+
+	return 0;
+}
diff --git a/drivers/gpu/drm/tegra/riscv.h b/drivers/gpu/drm/tegra/riscv.h
new file mode 100644
index 000000000000..bbeb2db078b6
--- /dev/null
+++ b/drivers/gpu/drm/tegra/riscv.h
@@ -0,0 +1,30 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022, NVIDIA Corporation.
+ */
+
+#ifndef DRM_TEGRA_RISCV_H
+#define DRM_TEGRA_RISCV_H
+
+struct tegra_drm_riscv_descriptor {
+	u32 manifest_offset;
+	u32 code_offset;
+	u32 code_size;
+	u32 data_offset;
+	u32 data_size;
+};
+
+struct tegra_drm_riscv {
+	/* User initializes */
+	struct device *dev;
+	void __iomem *regs;
+
+	struct tegra_drm_riscv_descriptor bl_desc;
+	struct tegra_drm_riscv_descriptor os_desc;
+};
+
+int tegra_drm_riscv_read_descriptors(struct tegra_drm_riscv *riscv);
+int tegra_drm_riscv_boot_bootrom(struct tegra_drm_riscv *riscv, phys_addr_t image_address,
+				 u32 gscid, const struct tegra_drm_riscv_descriptor *desc);
+
+#endif
-- 
2.37.0

