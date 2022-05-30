Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0A1EF5388A6
	for <lists+linux-kernel@lfdr.de>; Mon, 30 May 2022 23:46:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242280AbiE3VpL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 30 May 2022 17:45:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:60748 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242191AbiE3VpF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 30 May 2022 17:45:05 -0400
Received: from mail-wr1-x430.google.com (mail-wr1-x430.google.com [IPv6:2a00:1450:4864:20::430])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BE4152BB06
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:44:59 -0700 (PDT)
Received: by mail-wr1-x430.google.com with SMTP id q7so5260238wrg.5
        for <linux-kernel@vger.kernel.org>; Mon, 30 May 2022 14:44:59 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qKOTNFdZO2bOaOpT02gEE9juOWtiDjVqwv61wNvgZI4=;
        b=J/1Fwan5Ku7P0Jppe3gOMnsFMFi1J1D+p0OrwrLoF9P8HRd6msB4Q2SpmYt/FRb/kS
         bzCCfl/i0mpsVJWEdDHL0qEeSd8VK0JBAvUuhAUJrm8TAtZW2lw7cor/F3ulo0vwHB4W
         fSCBu+oBH3L5FoJGkpuFszRkBotr4OH9kxjfHlTQjub5X6O0aTrDeiRBCFM/8cj+l4I7
         k64O0sIoJxfEpoP3BzNQ458njx1Z3H69g/ob07WaYqICIyiLdwS700PPmIC1Cokw7mTl
         7qSVhcfn7NiCaIP/nZoyff1QD3VWEMtrSuwiOBX+4EPh15xkbRFpFzPl7S0UGG0aOCY2
         qAKw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qKOTNFdZO2bOaOpT02gEE9juOWtiDjVqwv61wNvgZI4=;
        b=ZHy9i8oI2pcbfeRnU+Wmyu4vwSXRY3I801DE8HXL39Wm3ZWo2HvcYCf2uSXvOc0SuA
         Q0JLlhE8OZwDokwmPJSHJnxTJmoHBmzTFVinfk/1TZvHIVB0yRdMit9Iby5Y8cQM6+QY
         n1KVI2KBqKFXzgHUksbpkyGCejO7EuvicB2nXhANPDc8Rwmu2acKlN/7enH209c+ybX3
         T6ERWFP2ICwTgR5LSAcZq8uv5OZiBftfTB2Cc2wIPeyjAX4qkZAfJxk/PvjJDAjMxRpa
         hvkejV32cYmLSv3SJoQfzYXrtzhmiNpa3Ud47SH2S5ZhqDnE4hh6spQVzYaRjDym7Mr6
         SZiA==
X-Gm-Message-State: AOAM533DJQHk5NNfJf+FEVoOT6PKm1H6x+TFJDqDdUt6qN1JacNz2tt8
        InF2LIWUL9r3c65Q8Acz4Kk0QA==
X-Google-Smtp-Source: ABdhPJym/8OIMtEAhg6ZTad0fMtJKVHV9OSC1pfdmdEvhCj1Lo9q1w6pqaygmukXzgw9PcheKdXmPw==
X-Received: by 2002:adf:ed41:0:b0:210:20a5:26c2 with SMTP id u1-20020adfed41000000b0021020a526c2mr13357034wro.603.1653947097946;
        Mon, 30 May 2022 14:44:57 -0700 (PDT)
Received: from localhost.localdomain ([88.160.162.107])
        by smtp.gmail.com with ESMTPSA id l1-20020a5d6d81000000b0020e63ab5d78sm9847729wrs.26.2022.05.30.14.44.56
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 30 May 2022 14:44:57 -0700 (PDT)
From:   Fabien Parent <fparent@baylibre.com>
To:     Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Matthias Brugger <matthias.bgg@gmail.com>
Cc:     Fabien Parent <fparent@baylibre.com>, linux-kernel@vger.kernel.org,
        linux-clk@vger.kernel.org, linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v2 2/2] clk: mediatek: add driver for MT8365 SoC
Date:   Mon, 30 May 2022 23:44:33 +0200
Message-Id: <20220530214434.1012889-2-fparent@baylibre.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220530214434.1012889-1-fparent@baylibre.com>
References: <20220530214434.1012889-1-fparent@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock drivers for MT8365 SoC.

Signed-off-by: Fabien Parent <fparent@baylibre.com>
---
v2: rename header file (dt-bindings/clock/mediatek,mt8365-clk.h)

 drivers/clk/mediatek/Kconfig           |   50 +
 drivers/clk/mediatek/Makefile          |    7 +
 drivers/clk/mediatek/clk-mt8365-apu.c  |   54 ++
 drivers/clk/mediatek/clk-mt8365-cam.c  |   56 ++
 drivers/clk/mediatek/clk-mt8365-mfg.c  |   62 ++
 drivers/clk/mediatek/clk-mt8365-mm.c   |   95 ++
 drivers/clk/mediatek/clk-mt8365-vdec.c |   62 ++
 drivers/clk/mediatek/clk-mt8365-venc.c |   51 +
 drivers/clk/mediatek/clk-mt8365.c      | 1197 ++++++++++++++++++++++++
 9 files changed, 1634 insertions(+)
 create mode 100644 drivers/clk/mediatek/clk-mt8365-apu.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-cam.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-mfg.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-mm.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-vdec.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365-venc.c
 create mode 100644 drivers/clk/mediatek/clk-mt8365.c

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index d5936cfb3bee..f2ae987485f8 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -608,6 +608,56 @@ config COMMON_CLK_MT8195
         help
           This driver supports MediaTek MT8195 clocks.
 
+config COMMON_CLK_MT8365
+	bool "Clock driver for MediaTek MT8365"
+	depends on (ARCH_MEDIATEK && ARM64) || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	default ARCH_MEDIATEK && ARM64
+	help
+	  This driver supports MediaTek MT8365 basic clocks.
+
+config COMMON_CLK_MT8365_APU
+	bool "Clock driver for MediaTek MT8365 apu"
+	depends on COMMON_CLK_MT8365
+	default COMMON_CLK_MT8365
+	help
+	  This driver supports MediaTek MT8365 apu clocks.
+
+config COMMON_CLK_MT8365_CAM
+	bool "Clock driver for MediaTek MT8365 cam"
+	depends on COMMON_CLK_MT8365
+	default COMMON_CLK_MT8365
+	help
+	  This driver supports MediaTek MT8365 cam clocks.
+
+config COMMON_CLK_MT8365_MFG
+	bool "Clock driver for MediaTek MT8365 mfg"
+	depends on COMMON_CLK_MT8365
+	default COMMON_CLK_MT8365
+	help
+	  This driver supports MediaTek MT8365 mfg clocks.
+
+config COMMON_CLK_MT8365_MMSYS
+	bool "Clock driver for MediaTek MT8365 mmsys"
+	depends on COMMON_CLK_MT8365
+	default COMMON_CLK_MT8365
+	help
+	  This driver supports MediaTek MT8365 mmsys clocks.
+
+config COMMON_CLK_MT8365_VDEC
+	bool "Clock driver for MediaTek MT8365 vdec"
+	depends on COMMON_CLK_MT8365
+	default COMMON_CLK_MT8365
+	help
+	  This driver supports MediaTek MT8365 vdec clocks.
+
+config COMMON_CLK_MT8365_VENC
+	bool "Clock driver for MediaTek MT8365 venc"
+	depends on COMMON_CLK_MT8365
+	default COMMON_CLK_MT8365
+	help
+	  This driver supports MediaTek MT8365 venc clocks.
+
 config COMMON_CLK_MT8516
 	bool "Clock driver for MediaTek MT8516"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index caf2ce93d666..0321609b197f 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -97,5 +97,12 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
 				   clk-mt8195-venc.o clk-mt8195-vpp0.o clk-mt8195-vpp1.o \
 				   clk-mt8195-wpe.o clk-mt8195-imp_iic_wrap.o \
 				   clk-mt8195-apusys_pll.o
+obj-$(CONFIG_COMMON_CLK_MT8365) += clk-mt8365.o
+obj-$(CONFIG_COMMON_CLK_MT8365_APU) += clk-mt8365-apu.o
+obj-$(CONFIG_COMMON_CLK_MT8365_CAM) += clk-mt8365-cam.o
+obj-$(CONFIG_COMMON_CLK_MT8365_MFG) += clk-mt8365-mfg.o
+obj-$(CONFIG_COMMON_CLK_MT8365_MMSYS) += clk-mt8365-mm.o
+obj-$(CONFIG_COMMON_CLK_MT8365_VDEC) += clk-mt8365-vdec.o
+obj-$(CONFIG_COMMON_CLK_MT8365_VENC) += clk-mt8365-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
diff --git a/drivers/clk/mediatek/clk-mt8365-apu.c b/drivers/clk/mediatek/clk-mt8365-apu.c
new file mode 100644
index 000000000000..318cdf379fc2
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8365-apu.c
@@ -0,0 +1,54 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <dt-bindings/clock/mediatek,mt8365-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs apu_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_APU(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &apu_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate apu_clks[] = {
+	GATE_APU(CLK_APU_AHB, "apu_ahb", "ifr_apu_axi", 5),
+	GATE_APU(CLK_APU_EDMA, "apu_edma", "apu_sel", 4),
+	GATE_APU(CLK_APU_IF_CK, "apu_if_ck", "apu_if_sel", 3),
+	GATE_APU(CLK_APU_JTAG, "apu_jtag", "clk26m_ck", 2),
+	GATE_APU(CLK_APU_AXI, "apu_axi", "apu_sel", 1),
+	GATE_APU(CLK_APU_IPU_CK, "apu_ck", "apu_sel", 0),
+};
+
+static const struct mtk_clk_desc apu_desc = {
+	.clks = apu_clks,
+	.num_clks = ARRAY_SIZE(apu_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8365_apu[] = {
+	{
+		.compatible = "mediatek,mt8365-apu",
+		.data = &apu_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8365_apu_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8365-apu",
+		.of_match_table = of_match_clk_mt8365_apu,
+	},
+};
+builtin_platform_driver(clk_mt8365_apu_drv);
diff --git a/drivers/clk/mediatek/clk-mt8365-cam.c b/drivers/clk/mediatek/clk-mt8365-cam.c
new file mode 100644
index 000000000000..f9cae3ab6f8d
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8365-cam.c
@@ -0,0 +1,56 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <dt-bindings/clock/mediatek,mt8365-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs cam_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_CAM(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &cam_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate cam_clks[] = {
+	GATE_CAM(CLK_CAM_LARB2, "cam_larb2", "mm_sel", 0),
+	GATE_CAM(CLK_CAM, "cam", "mm_sel", 6),
+	GATE_CAM(CLK_CAMTG, "camtg", "mm_sel", 7),
+	GATE_CAM(CLK_CAM_SENIF, "cam_senif", "mm_sel", 8),
+	GATE_CAM(CLK_CAMSV0, "camsv0", "mm_sel", 9),
+	GATE_CAM(CLK_CAMSV1, "camsv1", "mm_sel", 10),
+	GATE_CAM(CLK_CAM_FDVT, "cam_fdvt", "mm_sel", 11),
+	GATE_CAM(CLK_CAM_WPE, "cam_wpe", "mm_sel", 12),
+};
+
+static const struct mtk_clk_desc cam_desc = {
+	.clks = cam_clks,
+	.num_clks = ARRAY_SIZE(cam_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8365_cam[] = {
+	{
+		.compatible = "mediatek,mt8365-imgsys",
+		.data = &cam_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8365_cam_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8365-cam",
+		.of_match_table = of_match_clk_mt8365_cam,
+	},
+};
+builtin_platform_driver(clk_mt8365_cam_drv);
diff --git a/drivers/clk/mediatek/clk-mt8365-mfg.c b/drivers/clk/mediatek/clk-mt8365-mfg.c
new file mode 100644
index 000000000000..52f6be3286ce
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8365-mfg.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <dt-bindings/clock/mediatek,mt8365-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs mfg0_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs mfg1_cg_regs = {
+	.set_ofs = 0x280,
+	.clr_ofs = 0x280,
+	.sta_ofs = 0x280,
+};
+
+#define GATE_MFG0(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &mfg0_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_setclr)
+
+#define GATE_MFG1(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &mfg1_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate mfg_clks[] = {
+	/* MFG0 */
+	GATE_MFG0(CLK_MFG_BG3D, "mfg_bg3d", "mfg_sel", 0),
+	/* MFG1 */
+	GATE_MFG1(CLK_MFG_MBIST_DIAG, "mfg_mbist_diag", "mbist_diag_sel", 24),
+};
+
+static const struct mtk_clk_desc mfg_desc = {
+	.clks = mfg_clks,
+	.num_clks = ARRAY_SIZE(mfg_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8365_mfg[] = {
+	{
+		.compatible = "mediatek,mt8365-mfgcfg",
+		.data = &mfg_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8365_mfg_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8365-mfg",
+		.of_match_table = of_match_clk_mt8365_mfg,
+	},
+};
+builtin_platform_driver(clk_mt8365_mfg_drv);
diff --git a/drivers/clk/mediatek/clk-mt8365-mm.c b/drivers/clk/mediatek/clk-mt8365-mm.c
new file mode 100644
index 000000000000..83d3a27ece6c
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8365-mm.c
@@ -0,0 +1,95 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ * Copyright (c) 2022 BayLibre, SAS
+ */
+
+#include <dt-bindings/clock/mediatek,mt8365-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs mm0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mm1_cg_regs = {
+	.set_ofs = 0x114,
+	.clr_ofs = 0x118,
+	.sta_ofs = 0x110,
+};
+
+#define GATE_MM0(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &mm0_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_setclr)
+
+#define GATE_MM1(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &mm1_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate mm_clks[] = {
+	/* MM0 */
+	GATE_MM0(CLK_MM_MM_MDP_RDMA0, "mm_mdp_rdma0", "mm_sel", 0),
+	GATE_MM0(CLK_MM_MM_MDP_CCORR0, "mm_mdp_ccorr0", "mm_sel", 1),
+	GATE_MM0(CLK_MM_MM_MDP_RSZ0, "mm_mdp_rsz0", "mm_sel", 2),
+	GATE_MM0(CLK_MM_MM_MDP_RSZ1, "mm_mdp_rsz1", "mm_sel", 3),
+	GATE_MM0(CLK_MM_MM_MDP_TDSHP0, "mm_mdp_tdshp0", "mm_sel", 4),
+	GATE_MM0(CLK_MM_MM_MDP_WROT0, "mm_mdp_wrot0", "mm_sel", 5),
+	GATE_MM0(CLK_MM_MM_MDP_WDMA0, "mm_mdp_wdma0", "mm_sel", 6),
+	GATE_MM0(CLK_MM_MM_DISP_OVL0, "mm_disp_ovl0", "mm_sel", 7),
+	GATE_MM0(CLK_MM_MM_DISP_OVL0_2L, "mm_disp_ovl0_2l", "mm_sel", 8),
+	GATE_MM0(CLK_MM_MM_DISP_RSZ0, "mm_disp_rsz0", "mm_sel", 9),
+	GATE_MM0(CLK_MM_MM_DISP_RDMA0, "mm_disp_rdma0", "mm_sel", 10),
+	GATE_MM0(CLK_MM_MM_DISP_WDMA0, "mm_disp_wdma0", "mm_sel", 11),
+	GATE_MM0(CLK_MM_MM_DISP_COLOR0, "mm_disp_color0", "mm_sel", 12),
+	GATE_MM0(CLK_MM_MM_DISP_CCORR0, "mm_disp_ccorr0", "mm_sel", 13),
+	GATE_MM0(CLK_MM_MM_DISP_AAL0, "mm_disp_aal0", "mm_sel", 14),
+	GATE_MM0(CLK_MM_MM_DISP_GAMMA0, "mm_disp_gamma0", "mm_sel", 15),
+	GATE_MM0(CLK_MM_MM_DISP_DITHER0, "mm_disp_dither0", "mm_sel", 16),
+	GATE_MM0(CLK_MM_MM_DSI0, "mm_dsi0", "mm_sel", 17),
+	GATE_MM0(CLK_MM_MM_DISP_RDMA1, "mm_disp_rdma1", "mm_sel", 18),
+	GATE_MM0(CLK_MM_MM_MDP_RDMA1, "mm_mdp_rdma1", "mm_sel", 19),
+	GATE_MM0(CLK_MM_DPI0_DPI0, "mm_dpi0_dpi0", "vpll_dpix", 20),
+	GATE_MM0(CLK_MM_MM_FAKE, "mm_fake", "mm_sel", 21),
+	GATE_MM0(CLK_MM_MM_SMI_COMMON, "mm_smi_common", "mm_sel", 22),
+	GATE_MM0(CLK_MM_MM_SMI_LARB0, "mm_smi_larb0", "mm_sel", 23),
+	GATE_MM0(CLK_MM_MM_SMI_COMM0, "mm_smi_comm0", "mm_sel", 24),
+	GATE_MM0(CLK_MM_MM_SMI_COMM1, "mm_smi_comm1", "mm_sel", 25),
+	GATE_MM0(CLK_MM_MM_CAM_MDP, "mm_cam_mdp", "mm_sel", 26),
+	GATE_MM0(CLK_MM_MM_SMI_IMG, "mm_smi_img", "mm_sel", 27),
+	GATE_MM0(CLK_MM_MM_SMI_CAM, "mm_smi_cam", "mm_sel", 28),
+	GATE_MM0(CLK_MM_IMG_IMG_DL_RELAY, "mm_dl_relay", "mm_sel", 29),
+	GATE_MM0(CLK_MM_IMG_IMG_DL_ASYNC_TOP, "mm_dl_async_top", "mm_sel", 30),
+	GATE_MM0(CLK_MM_DSI0_DIG_DSI, "mm_dsi0_dig_dsi", "dsi0_lntc_dsick", 31),
+	/* MM1 */
+	GATE_MM1(CLK_MM_26M_HRTWT, "mm_f26m_hrtwt", "clk26m_ck", 0),
+	GATE_MM1(CLK_MM_MM_DPI0, "mm_dpi0", "mm_sel", 1),
+	GATE_MM1(CLK_MM_LVDSTX_PXL, "mm_flvdstx_pxl", "vpll_dpix", 2),
+	GATE_MM1(CLK_MM_LVDSTX_CTS, "mm_flvdstx_cts", "lvdstx_dig_cts", 3),
+};
+
+static int clk_mt8365_mm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->parent->of_node;
+	struct clk_hw_onecell_data *clk_data;
+
+	clk_data = mtk_alloc_clk_data(CLK_MM_NR_CLK);
+
+	mtk_clk_register_gates(node, mm_clks, ARRAY_SIZE(mm_clks),
+			clk_data);
+
+	return of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+}
+
+static struct platform_driver clk_mt8365_mm_drv = {
+	.probe = clk_mt8365_mm_probe,
+	.driver = {
+		.name = "clk-mt8365-mm",
+	},
+};
+builtin_platform_driver(clk_mt8365_mm_drv);
diff --git a/drivers/clk/mediatek/clk-mt8365-vdec.c b/drivers/clk/mediatek/clk-mt8365-vdec.c
new file mode 100644
index 000000000000..852210b26e76
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8365-vdec.c
@@ -0,0 +1,62 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <dt-bindings/clock/mediatek,mt8365-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs vdec0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs vdec1_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x8,
+};
+
+#define GATE_VDEC0(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_setclr_inv)
+
+#define GATE_VDEC1(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate vdec_clks[] = {
+	/* VDEC0 */
+	GATE_VDEC0(CLK_VDEC_VDEC, "vdec_fvdec_ck", "mm_sel", 0),
+	/* VDEC1 */
+	GATE_VDEC1(CLK_VDEC_LARB1, "vdec_flarb1_ck", "mm_sel", 0),
+};
+
+static const struct mtk_clk_desc vdec_desc = {
+	.clks = vdec_clks,
+	.num_clks = ARRAY_SIZE(vdec_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8365_vdec[] = {
+	{
+		.compatible = "mediatek,mt8365-vdecsys",
+		.data = &vdec_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8365_vdec_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8365-vdec",
+		.of_match_table = of_match_clk_mt8365_vdec,
+	},
+};
+builtin_platform_driver(clk_mt8365_vdec_drv);
diff --git a/drivers/clk/mediatek/clk-mt8365-venc.c b/drivers/clk/mediatek/clk-mt8365-venc.c
new file mode 100644
index 000000000000..60a82ecaca14
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8365-venc.c
@@ -0,0 +1,51 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <dt-bindings/clock/mediatek,mt8365-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+static const struct mtk_gate_regs venc_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_VENC(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate venc_clks[] = {
+	/* VENC */
+	GATE_VENC(CLK_VENC, "venc_fvenc_ck", "mm_sel", 4),
+	GATE_VENC(CLK_VENC_JPGENC, "venc_jpgenc_ck", "mm_sel", 8),
+};
+
+static const struct mtk_clk_desc venc_desc = {
+	.clks = venc_clks,
+	.num_clks = ARRAY_SIZE(venc_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8365_venc[] = {
+	{
+		.compatible = "mediatek,mt8365-vencsys",
+		.data = &venc_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8365_venc_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8365-venc",
+		.of_match_table = of_match_clk_mt8365_venc,
+	},
+};
+builtin_platform_driver(clk_mt8365_venc_drv);
diff --git a/drivers/clk/mediatek/clk-mt8365.c b/drivers/clk/mediatek/clk-mt8365.c
new file mode 100644
index 000000000000..6fb8c7cb29d9
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8365.c
@@ -0,0 +1,1197 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (C) 2022 MediaTek Inc.
+ */
+
+#include <dt-bindings/clock/mediatek,mt8365-clk.h>
+#include <linux/clk.h>
+#include <linux/delay.h>
+#include <linux/mfd/syscon.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/slab.h>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+#include "clk-mux.h"
+#include "clk-pll.h"
+
+static DEFINE_SPINLOCK(mt8365_clk_lock);
+
+static const struct mtk_fixed_clk top_fixed_clks[] = {
+	FIXED_CLK(CLK_TOP_CLK_NULL, "clk_null", NULL, 0),
+	FIXED_CLK(CLK_TOP_I2S0_BCK, "i2s0_bck", "clk_null", 26000000),
+	FIXED_CLK(CLK_TOP_DSI0_LNTC_DSICK, "dsi0_lntc_dsick", "clk26m",
+		  75000000),
+	FIXED_CLK(CLK_TOP_VPLL_DPIX, "vpll_dpix", "clk26m", 75000000),
+	FIXED_CLK(CLK_TOP_LVDSTX_CLKDIG_CTS, "lvdstx_dig_cts", "clk26m",
+		  52500000),
+};
+
+static const struct mtk_gate_regs pll_cg_regs = {
+	.set_ofs = 0x204,
+	.clr_ofs = 0x204,
+	.sta_ofs = 0x204,
+};
+
+#define GATE_APMIXED(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &pll_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_no_setclr_inv)
+
+static const struct mtk_gate pll_clks[] = {
+	/* PLL */
+	GATE_APMIXED(CLK_APMIXED_UNIV_EN, "univ_en", "univpll2", 0),
+	GATE_APMIXED(CLK_APMIXED_USB20_EN, "usb20_en", "univ_en", 1),
+};
+
+static const struct mtk_fixed_factor top_divs[] = {
+	FACTOR(CLK_TOP_SYS_26M_D2, "sys_26m_d2", "clk26m", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL_D2, "syspll_d2", "mainpll", 1, 2),
+	FACTOR(CLK_TOP_SYSPLL1_D2, "syspll1_d2", "mainpll", 1, 4),
+	FACTOR(CLK_TOP_SYSPLL1_D4, "syspll1_d4", "mainpll", 1, 8),
+	FACTOR(CLK_TOP_SYSPLL1_D8, "syspll1_d8", "mainpll", 1, 16),
+	FACTOR(CLK_TOP_SYSPLL1_D16, "syspll1_d16", "mainpll", 1, 32),
+	FACTOR(CLK_TOP_SYSPLL_D3, "syspll_d3", "mainpll", 1, 3),
+	FACTOR(CLK_TOP_SYSPLL2_D2, "syspll2_d2", "mainpll", 1, 6),
+	FACTOR(CLK_TOP_SYSPLL2_D4, "syspll2_d4", "mainpll", 1, 12),
+	FACTOR(CLK_TOP_SYSPLL2_D8, "syspll2_d8", "mainpll", 1, 24),
+	FACTOR(CLK_TOP_SYSPLL_D5, "syspll_d5", "mainpll", 1, 5),
+	FACTOR(CLK_TOP_SYSPLL3_D2, "syspll3_d2", "mainpll", 1, 10),
+	FACTOR(CLK_TOP_SYSPLL3_D4, "syspll3_d4", "mainpll", 1, 20),
+	FACTOR(CLK_TOP_SYSPLL_D7, "syspll_d7", "mainpll", 1, 7),
+	FACTOR(CLK_TOP_SYSPLL4_D2, "syspll4_d2", "mainpll", 1, 14),
+	FACTOR(CLK_TOP_SYSPLL4_D4, "syspll4_d4", "mainpll", 1, 28),
+	FACTOR(CLK_TOP_UNIVPLL, "univpll", "univ_en", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL_D2, "univpll_d2", "univpll", 1, 2),
+	FACTOR(CLK_TOP_UNIVPLL1_D2, "univpll1_d2", "univpll", 1, 4),
+	FACTOR(CLK_TOP_UNIVPLL1_D4, "univpll1_d4", "univpll", 1, 8),
+	FACTOR(CLK_TOP_UNIVPLL_D3, "univpll_d3", "univpll", 1, 3),
+	FACTOR(CLK_TOP_UNIVPLL2_D2, "univpll2_d2", "univpll", 1, 6),
+	FACTOR(CLK_TOP_UNIVPLL2_D4, "univpll2_d4", "univpll", 1, 12),
+	FACTOR(CLK_TOP_UNIVPLL2_D8, "univpll2_d8", "univpll", 1, 24),
+	FACTOR(CLK_TOP_UNIVPLL2_D32, "univpll2_d32", "univpll", 1, 96),
+	FACTOR(CLK_TOP_UNIVPLL_D5, "univpll_d5", "univpll", 1, 5),
+	FACTOR(CLK_TOP_UNIVPLL3_D2, "univpll3_d2", "univpll", 1, 10),
+	FACTOR(CLK_TOP_UNIVPLL3_D4, "univpll3_d4", "univpll", 1, 20),
+	FACTOR(CLK_TOP_MMPLL, "mmpll_ck", "mmpll", 1, 1),
+	FACTOR(CLK_TOP_MMPLL_D2, "mmpll_d2", "mmpll", 1, 2),
+	FACTOR(CLK_TOP_MFGPLL, "mfgpll_ck", "mfgpll", 1, 1),
+	FACTOR(CLK_TOP_LVDSPLL_D2, "lvdspll_d2", "lvdspll", 1, 2),
+	FACTOR(CLK_TOP_LVDSPLL_D4, "lvdspll_d4", "lvdspll", 1, 4),
+	FACTOR(CLK_TOP_LVDSPLL_D8, "lvdspll_d8", "lvdspll", 1, 8),
+	FACTOR(CLK_TOP_LVDSPLL_D16, "lvdspll_d16", "lvdspll", 1, 16),
+	FACTOR(CLK_TOP_USB20_192M, "usb20_192m_ck", "usb20_en", 1, 13),
+	FACTOR(CLK_TOP_USB20_192M_D4, "usb20_192m_d4", "usb20_192m_ck", 1, 4),
+	FACTOR(CLK_TOP_USB20_192M_D8, "usb20_192m_d8", "usb20_192m_ck", 1, 8),
+	FACTOR(CLK_TOP_USB20_192M_D16, "usb20_192m_d16", "usb20_192m_ck",
+	       1, 16),
+	FACTOR(CLK_TOP_USB20_192M_D32, "usb20_192m_d32", "usb20_192m_ck",
+	       1, 32),
+	FACTOR(CLK_TOP_APLL1, "apll1_ck", "apll1", 1, 1),
+	FACTOR(CLK_TOP_APLL1_D2, "apll1_d2", "apll1_ck", 1, 2),
+	FACTOR(CLK_TOP_APLL1_D4, "apll1_d4", "apll1_ck", 1, 4),
+	FACTOR(CLK_TOP_APLL1_D8, "apll1_d8", "apll1_ck", 1, 8),
+	FACTOR(CLK_TOP_APLL2, "apll2_ck", "apll2", 1, 1),
+	FACTOR(CLK_TOP_APLL2_D2, "apll2_d2", "apll2_ck", 1, 2),
+	FACTOR(CLK_TOP_APLL2_D4, "apll2_d4", "apll2_ck", 1, 4),
+	FACTOR(CLK_TOP_APLL2_D8, "apll2_d8", "apll2_ck", 1, 8),
+	FACTOR(CLK_TOP_CLK26M, "clk26m_ck", "clk26m", 1, 1),
+	FACTOR(CLK_TOP_MSDCPLL, "msdcpll_ck", "msdcpll", 1, 1),
+	FACTOR(CLK_TOP_MSDCPLL_D2, "msdcpll_d2", "msdcpll", 1, 2),
+	FACTOR(CLK_TOP_DSPPLL, "dsppll_ck", "dsppll", 1, 1),
+	FACTOR(CLK_TOP_DSPPLL_D2, "dsppll_d2", "dsppll", 1, 2),
+	FACTOR(CLK_TOP_DSPPLL_D4, "dsppll_d4", "dsppll", 1, 4),
+	FACTOR(CLK_TOP_DSPPLL_D8, "dsppll_d8", "dsppll", 1, 8),
+	FACTOR(CLK_TOP_APUPLL, "apupll_ck", "apupll", 1, 1),
+	FACTOR(CLK_TOP_CLK26M_D52, "clk26m_d52", "clk26m", 1, 52),
+};
+
+static const char * const axi_parents[] = {
+	"clk26m_ck",
+	"syspll_d7",
+	"syspll1_d4",
+	"syspll3_d2"
+};
+
+static const char * const mem_parents[] = {
+	"clk26m_ck",
+	"mmpll_ck",
+	"syspll_d3",
+	"syspll1_d2"
+};
+
+static const char * const mm_parents[] = {
+	"clk26m_ck",
+	"mmpll_ck",
+	"syspll1_d2",
+	"syspll_d5",
+	"syspll1_d4",
+	"univpll_d5",
+	"univpll1_d2",
+	"mmpll_d2"
+};
+
+static const char * const scp_parents[] = {
+	"clk26m_ck",
+	"syspll4_d2",
+	"univpll2_d2",
+	"syspll1_d2",
+	"univpll1_d2",
+	"syspll_d3",
+	"univpll_d3"
+};
+
+static const char * const mfg_parents[] = {
+	"clk26m_ck",
+	"mfgpll_ck",
+	"syspll_d3",
+	"univpll_d3"
+};
+
+static const char * const atb_parents[] = {
+	"clk26m_ck",
+	"syspll1_d4",
+	"syspll1_d2"
+};
+
+static const char * const camtg_parents[] = {
+	"clk26m_ck",
+	"usb20_192m_d8",
+	"univpll2_d8",
+	"usb20_192m_d4",
+	"univpll2_d32",
+	"usb20_192m_d16",
+	"usb20_192m_d32"
+};
+
+static const char * const uart_parents[] = {
+	"clk26m_ck",
+	"univpll2_d8"
+};
+
+static const char * const spi_parents[] = {
+	"clk26m_ck",
+	"univpll2_d2",
+	"univpll2_d4",
+	"univpll2_d8"
+};
+
+static const char * const msdc50_0_hc_parents[] = {
+	"clk26m_ck",
+	"syspll1_d2",
+	"univpll1_d4",
+	"syspll2_d2"
+};
+
+static const char * const msdc50_0_parents[] = {
+	"clk26m_ck",
+	"msdcpll_ck",
+	"univpll1_d2",
+	"syspll1_d2",
+	"univpll_d5",
+	"syspll2_d2",
+	"univpll1_d4",
+	"syspll4_d2"
+};
+
+static const char * const msdc50_2_parents[] = {
+	"clk26m_ck",
+	"msdcpll_ck",
+	"univpll_d3",
+	"univpll1_d2",
+	"syspll1_d2",
+	"univpll2_d2",
+	"syspll2_d2",
+	"univpll1_d4"
+};
+
+static const char * const msdc30_1_parents[] = {
+	"clk26m_ck",
+	"msdcpll_d2",
+	"univpll2_d2",
+	"syspll2_d2",
+	"univpll1_d4",
+	"syspll1_d4",
+	"syspll2_d4",
+	"univpll2_d8"
+};
+
+static const char * const audio_parents[] = {
+	"clk26m_ck",
+	"syspll3_d4",
+	"syspll4_d4",
+	"syspll1_d16"
+};
+
+static const char * const aud_intbus_parents[] = {
+	"clk26m_ck",
+	"syspll1_d4",
+	"syspll4_d2"
+};
+
+static const char * const aud_1_parents[] = {
+	"clk26m_ck",
+	"apll1_ck"
+};
+
+static const char * const aud_2_parents[] = {
+	"clk26m_ck",
+	"apll2_ck"
+};
+
+static const char * const aud_engen1_parents[] = {
+	"clk26m_ck",
+	"apll1_d2",
+	"apll1_d4",
+	"apll1_d8"
+};
+
+static const char * const aud_engen2_parents[] = {
+	"clk26m_ck",
+	"apll2_d2",
+	"apll2_d4",
+	"apll2_d8"
+};
+
+static const char * const aud_spdif_parents[] = {
+	"clk26m_ck",
+	"univpll_d2"
+};
+
+static const char * const disp_pwm_parents[] = {
+	"clk26m_ck",
+	"univpll2_d4"
+};
+
+static const char * const dxcc_parents[] = {
+	"clk26m_ck",
+	"syspll1_d2",
+	"syspll1_d4",
+	"syspll1_d8"
+};
+
+static const char * const ssusb_sys_parents[] = {
+	"clk26m_ck",
+	"univpll3_d4",
+	"univpll2_d4",
+	"univpll3_d2"
+};
+
+static const char * const spm_parents[] = {
+	"clk26m_ck",
+	"syspll1_d8"
+};
+
+static const char * const i2c_parents[] = {
+	"clk26m_ck",
+	"univpll3_d4",
+	"univpll3_d2",
+	"syspll1_d8",
+	"syspll2_d8"
+};
+
+static const char * const pwm_parents[] = {
+	"clk26m_ck",
+	"univpll3_d4",
+	"syspll1_d8"
+};
+
+static const char * const senif_parents[] = {
+	"clk26m_ck",
+	"univpll1_d4",
+	"univpll1_d2",
+	"univpll2_d2"
+};
+
+static const char * const aes_fde_parents[] = {
+	"clk26m_ck",
+	"msdcpll_ck",
+	"univpll_d3",
+	"univpll2_d2",
+	"univpll1_d2",
+	"syspll1_d2"
+};
+
+static const char * const dpi0_parents[] = {
+	"clk26m_ck",
+	"lvdspll_d2",
+	"lvdspll_d4",
+	"lvdspll_d8",
+	"lvdspll_d16"
+};
+
+static const char * const dsp_parents[] = {
+	"clk26m_ck",
+	"sys_26m_d2",
+	"dsppll_ck",
+	"dsppll_d2",
+	"dsppll_d4",
+	"dsppll_d8"
+};
+
+static const char * const nfi2x_parents[] = {
+	"clk26m_ck",
+	"syspll2_d2",
+	"syspll_d7",
+	"syspll_d3",
+	"syspll2_d4",
+	"msdcpll_d2",
+	"univpll1_d2",
+	"univpll_d5"
+};
+
+static const char * const nfiecc_parents[] = {
+	"clk26m_ck",
+	"syspll4_d2",
+	"univpll2_d4",
+	"syspll_d7",
+	"univpll1_d2",
+	"syspll1_d2",
+	"univpll2_d2",
+	"syspll_d5"
+};
+
+static const char * const ecc_parents[] = {
+	"clk26m_ck",
+	"univpll2_d2",
+	"univpll1_d2",
+	"univpll_d3",
+	"syspll_d2"
+};
+
+static const char * const eth_parents[] = {
+	"clk26m_ck",
+	"univpll2_d8",
+	"syspll4_d4",
+	"syspll1_d8",
+	"syspll4_d2"
+};
+
+static const char * const gcpu_parents[] = {
+	"clk26m_ck",
+	"univpll_d3",
+	"univpll2_d2",
+	"syspll_d3",
+	"syspll2_d2"
+};
+
+static const char * const gcpu_cpm_parents[] = {
+	"clk26m_ck",
+	"univpll2_d2",
+	"syspll2_d2"
+};
+
+static const char * const apu_parents[] = {
+	"clk26m_ck",
+	"univpll_d2",
+	"apupll_ck",
+	"mmpll_ck",
+	"syspll_d3",
+	"univpll1_d2",
+	"syspll1_d2",
+	"syspll1_d4"
+};
+
+static const char * const mbist_diag_parents[] = {
+	"clk26m_ck",
+	"syspll4_d4",
+	"univpll2_d8"
+};
+
+static const char * const apll_i2s0_parents[] = {
+	"aud_1_sel",
+	"aud_2_sel"
+};
+
+static struct mtk_composite top_misc_muxes[] = {
+	/* CLK_CFG_11 */
+	MUX_GATE(CLK_TOP_MBIST_DIAG_SEL, "mbist_diag_sel", mbist_diag_parents,
+		0x0ec, 0, 2, 7),
+	/* CLK_AUDDIV_0 */
+	MUX(CLK_TOP_APLL_I2S0_SEL, "apll_i2s0_sel", apll_i2s0_parents,
+		 0x320, 11, 1),
+	MUX(CLK_TOP_APLL_I2S1_SEL, "apll_i2s1_sel", apll_i2s0_parents,
+		 0x320, 12, 1),
+	MUX(CLK_TOP_APLL_I2S2_SEL, "apll_i2s2_sel", apll_i2s0_parents,
+		 0x320, 13, 1),
+	MUX(CLK_TOP_APLL_I2S3_SEL, "apll_i2s3_sel", apll_i2s0_parents,
+		 0x320, 14, 1),
+	MUX(CLK_TOP_APLL_TDMOUT_SEL, "apll_tdmout_sel", apll_i2s0_parents,
+		 0x320, 15, 1),
+	MUX(CLK_TOP_APLL_TDMIN_SEL, "apll_tdmin_sel", apll_i2s0_parents,
+		 0x320, 16, 1),
+	MUX(CLK_TOP_APLL_SPDIF_SEL, "apll_spdif_sel", apll_i2s0_parents,
+		 0x320, 17, 1),
+};
+
+#define MT8365_MUX_CLR_SET_UPD(_id, _name, _parents, _mux_ofs, _mux_set_ofs,	\
+			_mux_clr_ofs, _shift, _width, _gate,		\
+			_upd_ofs, _upd)				\
+		MUX_GATE_CLR_SET_UPD_FLAGS(_id, _name, _parents, _mux_ofs,	\
+			_mux_set_ofs, _mux_clr_ofs, _shift, _width,	\
+			_gate, _upd_ofs, _upd, CLK_SET_RATE_PARENT)
+
+#define CLK_CFG_UPDATE 0x004
+#define CLK_CFG_UPDATE1 0x008
+
+static const struct mtk_mux top_muxes[] = {
+	/* CLK_CFG_0 */
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_AXI_SEL, "axi_sel", axi_parents,
+		0x040, 0x044, 0x048, 0, 2, 7,
+		CLK_CFG_UPDATE, 0, CLK_IS_CRITICAL),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_MEM_SEL, "mem_sel", mem_parents,
+		0x040, 0x044, 0x048, 8, 2, 15, CLK_CFG_UPDATE, 1),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_MM_SEL, "mm_sel", mm_parents,
+		0x040, 0x044, 0x048, 16, 3, 23, CLK_CFG_UPDATE, 2),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_SCP_SEL, "scp_sel", scp_parents,
+		0x040, 0x044, 0x048, 24, 3, 31, CLK_CFG_UPDATE, 3),
+	/* CLK_CFG_1 */
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_MFG_SEL, "mfg_sel", mfg_parents,
+		0x050, 0x054, 0x058, 0, 2, 7, CLK_CFG_UPDATE, 4),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_ATB_SEL, "atb_sel", atb_parents,
+		0x050, 0x054, 0x058, 8, 2, 15, CLK_CFG_UPDATE, 5),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_CAMTG_SEL, "camtg_sel", camtg_parents,
+		0x050, 0x054, 0x058, 16, 3, 23, CLK_CFG_UPDATE, 6),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_CAMTG1_SEL, "camtg1_sel", camtg_parents,
+		0x050, 0x054, 0x058, 24, 3, 31, CLK_CFG_UPDATE, 7),
+	/* CLK_CFG_2 */
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_UART_SEL, "uart_sel", uart_parents,
+		0x060, 0x064, 0x068, 0, 1, 7, CLK_CFG_UPDATE, 8),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_SPI_SEL, "spi_sel", spi_parents,
+		0x060, 0x064, 0x068, 8, 2, 15, CLK_CFG_UPDATE, 9),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_MSDC50_0_HC_SEL, "msdc50_0_hc_sel",
+		msdc50_0_hc_parents, 0x060, 0x064, 0x068, 16, 2, 23,
+		CLK_CFG_UPDATE, 10),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_MSDC2_2_HC_SEL, "msdc2_2_hc_sel",
+		msdc50_0_hc_parents, 0x060, 0x064, 0x068, 24, 2, 31,
+		CLK_CFG_UPDATE, 11),
+	/* CLK_CFG_3 */
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_MSDC50_0_SEL, "msdc50_0_sel",
+		msdc50_0_parents, 0x070, 0x074, 0x078, 0, 3, 7,
+		CLK_CFG_UPDATE, 12),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_MSDC50_2_SEL, "msdc50_2_sel",
+		msdc50_2_parents, 0x070, 0x074, 0x078, 8, 3, 15,
+		CLK_CFG_UPDATE, 13),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_MSDC30_1_SEL, "msdc30_1_sel",
+		msdc30_1_parents, 0x070, 0x074, 0x078, 16, 3, 23,
+		CLK_CFG_UPDATE, 14),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_AUDIO_SEL, "audio_sel", audio_parents,
+		0x070, 0x074, 0x078, 24, 2, 31, CLK_CFG_UPDATE, 15),
+	/* CLK_CFG_4 */
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_AUD_INTBUS_SEL, "aud_intbus_sel",
+		aud_intbus_parents, 0x080, 0x084, 0x088, 0, 2, 7,
+		CLK_CFG_UPDATE, 16),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_AUD_1_SEL, "aud_1_sel", aud_1_parents,
+		0x080, 0x084, 0x088, 8, 1, 15, CLK_CFG_UPDATE, 17),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_AUD_2_SEL, "aud_2_sel", aud_2_parents,
+		0x080, 0x084, 0x088, 16, 1, 23, CLK_CFG_UPDATE, 18),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_AUD_ENGEN1_SEL, "aud_engen1_sel",
+		aud_engen1_parents, 0x080, 0x084, 0x088, 24, 2, 31,
+		CLK_CFG_UPDATE, 19),
+	/* CLK_CFG_5 */
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_AUD_ENGEN2_SEL, "aud_engen2_sel",
+		aud_engen2_parents, 0x090, 0x094, 0x098, 0, 2, 7,
+		CLK_CFG_UPDATE, 20),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_AUD_SPDIF_SEL, "aud_spdif_sel",
+		aud_spdif_parents, 0x090, 0x094, 0x098, 8, 1, 15,
+		CLK_CFG_UPDATE, 21),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_DISP_PWM_SEL, "disp_pwm_sel", disp_pwm_parents,
+		0x090, 0x094, 0x098, 16, 2, 23, CLK_CFG_UPDATE, 22),
+	/* CLK_CFG_6 */
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_DXCC_SEL, "dxcc_sel", dxcc_parents,
+		0x0a0, 0x0a4, 0x0a8, 0, 2, 7,
+		CLK_CFG_UPDATE, 24, CLK_IS_CRITICAL),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_SSUSB_SYS_SEL, "ssusb_sys_sel",
+		ssusb_sys_parents, 0x0a0, 0x0a4, 0x0a8, 8, 2, 15,
+		CLK_CFG_UPDATE, 25),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_SSUSB_XHCI_SEL, "ssusb_xhci_sel",
+		ssusb_sys_parents, 0x0a0, 0x0a4, 0x0a8, 16, 2, 23,
+		CLK_CFG_UPDATE, 26),
+	MUX_GATE_CLR_SET_UPD_FLAGS(CLK_TOP_SPM_SEL, "spm_sel", spm_parents,
+		0x0a0, 0x0a4, 0x0a8, 24, 1, 31,
+		CLK_CFG_UPDATE, 27, CLK_IS_CRITICAL),
+	/* CLK_CFG_7 */
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_I2C_SEL, "i2c_sel", i2c_parents,
+		0x0b0, 0x0b4, 0x0b8, 0, 3, 7, CLK_CFG_UPDATE, 28),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_PWM_SEL, "pwm_sel", pwm_parents,
+		0x0b0, 0x0b4, 0x0b8, 8, 2, 15, CLK_CFG_UPDATE, 29),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_SENIF_SEL, "senif_sel", senif_parents,
+		0x0b0, 0x0b4, 0x0b8, 16, 2, 23, CLK_CFG_UPDATE, 30),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_AES_FDE_SEL, "aes_fde_sel", aes_fde_parents,
+		0x0b0, 0x0b4, 0x0b8, 24, 3, 31, CLK_CFG_UPDATE, 31),
+	/* CLK_CFG_8 */
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_CAMTM_SEL, "camtm_sel", senif_parents,
+		0x0c0, 0x0c4, 0x0c8, 0, 2, 7, CLK_CFG_UPDATE1, 0),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_DPI0_SEL, "dpi0_sel", dpi0_parents,
+		0x0c0, 0x0c4, 0x0c8, 8, 3, 15, CLK_CFG_UPDATE1, 1),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_DPI1_SEL, "dpi1_sel", dpi0_parents,
+		0x0c0, 0x0c4, 0x0c8, 16, 3, 23, CLK_CFG_UPDATE1, 2),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_DSP_SEL, "dsp_sel", dsp_parents,
+		0x0c0, 0x0c4, 0x0c8, 24, 3, 31, CLK_CFG_UPDATE1, 3),
+	/* CLK_CFG_9 */
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_NFI2X_SEL, "nfi2x_sel", nfi2x_parents,
+		0x0d0, 0x0d4, 0x0d8, 0, 3, 7, CLK_CFG_UPDATE1, 4),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_NFIECC_SEL, "nfiecc_sel", nfiecc_parents,
+		0x0d0, 0x0d4, 0x0d8, 8, 3, 15, CLK_CFG_UPDATE1, 5),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_ECC_SEL, "ecc_sel", ecc_parents,
+		0x0d0, 0x0d4, 0x0d8, 16, 3, 23, CLK_CFG_UPDATE1, 6),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_ETH_SEL, "eth_sel", eth_parents,
+		0x0d0, 0x0d4, 0x0d8, 24, 3, 31, CLK_CFG_UPDATE1, 7),
+	/* CLK_CFG_10 */
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_GCPU_SEL, "gcpu_sel", gcpu_parents,
+		0x0e0, 0x0e4, 0x0e8, 0, 3, 7, CLK_CFG_UPDATE1, 8),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_GCPU_CPM_SEL, "gcpu_cpm_sel", gcpu_cpm_parents,
+		0x0e0, 0x0e4, 0x0e8, 8, 2, 15, CLK_CFG_UPDATE1, 9),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_APU_SEL, "apu_sel", apu_parents,
+		0x0e0, 0x0e4, 0x0e8, 16, 3, 23, CLK_CFG_UPDATE1, 10),
+	MT8365_MUX_CLR_SET_UPD(CLK_TOP_APU_IF_SEL, "apu_if_sel", apu_parents,
+		0x0e0, 0x0e4, 0x0e8, 24, 3, 31, CLK_CFG_UPDATE1, 11),
+};
+
+static const char * const mcu_bus_parents[] = {
+	"clk26m_ck",
+	"armpll",
+	"mainpll",
+	"univpll_d2"
+};
+
+static struct mtk_composite mcu_muxes[] = {
+	/* bus_pll_divider_cfg */
+	MUX_GATE_FLAGS(CLK_MCU_BUS_SEL, "mcu_bus_sel", mcu_bus_parents, 0x7C0,
+		9, 2, -1, CLK_SET_RATE_PARENT | CLK_IS_CRITICAL),
+};
+
+#define DIV_ADJ_F(_id, _name, _parent, _reg, _shift, _width, _flags) {	\
+		.id = _id,					\
+		.name = _name,					\
+		.parent_name = _parent,				\
+		.div_reg = _reg,				\
+		.div_shift = _shift,				\
+		.div_width = _width,				\
+		.clk_divider_flags = _flags,			\
+}
+
+static const struct mtk_clk_divider top_adj_divs[] = {
+	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV0, "apll12_ck_div0", "apll_i2s0_sel",
+		0x324, 0, 8, CLK_DIVIDER_ROUND_CLOSEST),
+	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV1, "apll12_ck_div1", "apll_i2s1_sel",
+		0x324, 8, 8, CLK_DIVIDER_ROUND_CLOSEST),
+	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV2, "apll12_ck_div2", "apll_i2s2_sel",
+		0x324, 16, 8, CLK_DIVIDER_ROUND_CLOSEST),
+	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV3, "apll12_ck_div3", "apll_i2s3_sel",
+		0x324, 24, 8, CLK_DIVIDER_ROUND_CLOSEST),
+	DIV_ADJ_F(CLK_TOP_APLL12_CK_DIV6, "apll12_ck_div6", "apll_spdif_sel",
+		0x32c, 0, 8, CLK_DIVIDER_ROUND_CLOSEST),
+};
+
+static const struct mtk_gate_regs top0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs top1_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x104,
+	.sta_ofs = 0x104,
+};
+
+static const struct mtk_gate_regs top2_cg_regs = {
+	.set_ofs = 0x320,
+	.clr_ofs = 0x320,
+	.sta_ofs = 0x320,
+};
+
+#define GATE_TOP0(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &top0_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_no_setclr)
+
+#define GATE_TOP0_I(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &top0_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_TOP1(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_no_setclr)
+
+#define GATE_TOP1_I(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &top1_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_TOP2(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &top2_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_no_setclr)
+
+static const struct mtk_gate top_clks[] = {
+	/* TOP0 */
+	GATE_TOP0(CLK_TOP_CONN_32K, "conn_32k", "clk32k", 10),
+	GATE_TOP0(CLK_TOP_CONN_26M, "conn_26m", "clk26m_ck", 11),
+	GATE_TOP0(CLK_TOP_DSP_32K, "dsp_32k", "clk32k", 16),
+	GATE_TOP0(CLK_TOP_DSP_26M, "dsp_26m", "clk26m_ck", 17),
+	/* TOP1 */
+	GATE_TOP1_I(CLK_TOP_USB20_48M_EN, "usb20_48m_en", "usb20_192m_d4", 8),
+	GATE_TOP1_I(CLK_TOP_UNIVPLL_48M_EN, "univpll_48m_en", "usb20_192m_d4",
+		    9),
+	GATE_TOP1_I(CLK_TOP_LVDSTX_CLKDIG_EN, "lvdstx_dig_en", "lvdstx_dig_cts",
+		    20),
+	GATE_TOP1_I(CLK_TOP_VPLL_DPIX_EN, "vpll_dpix_en", "vpll_dpix", 21),
+	GATE_TOP1_I(CLK_TOP_SSUSB_TOP_CK_EN, "ssusb_top_ck_en", "clk_null", 22),
+	GATE_TOP1_I(CLK_TOP_SSUSB_PHY_CK_EN, "ssusb_phy_ck_en", "clk_null", 23),
+	/* TOP2 */
+	GATE_TOP2(CLK_TOP_AUD_I2S0_M, "aud_i2s0_m_ck", "apll12_ck_div0", 0),
+	GATE_TOP2(CLK_TOP_AUD_I2S1_M, "aud_i2s1_m_ck", "apll12_ck_div1", 1),
+	GATE_TOP2(CLK_TOP_AUD_I2S2_M, "aud_i2s2_m_ck", "apll12_ck_div2", 2),
+	GATE_TOP2(CLK_TOP_AUD_I2S3_M, "aud_i2s3_m_ck", "apll12_ck_div3", 3),
+	GATE_TOP2(CLK_TOP_AUD_TDMOUT_M, "aud_tdmout_m_ck", "apll12_ck_div4", 4),
+	GATE_TOP2(CLK_TOP_AUD_TDMOUT_B, "aud_tdmout_b_ck", "apll12_ck_div4b",
+		  5),
+	GATE_TOP2(CLK_TOP_AUD_TDMIN_M, "aud_tdmin_m_ck", "apll12_ck_div5", 6),
+	GATE_TOP2(CLK_TOP_AUD_TDMIN_B, "aud_tdmin_b_ck", "apll12_ck_div5b", 7),
+	GATE_TOP2(CLK_TOP_AUD_SPDIF_M, "aud_spdif_m_ck", "apll12_ck_div6", 8),
+
+};
+
+static const struct mtk_gate_regs ifr0_cg_regs = {
+	.set_ofs = 0x200,
+	.clr_ofs = 0x200,
+	.sta_ofs = 0x200,
+};
+
+static const struct mtk_gate_regs ifr1_cg_regs = {
+	.set_ofs = 0x74,
+	.clr_ofs = 0x74,
+	.sta_ofs = 0x74,
+};
+
+static const struct mtk_gate_regs ifr2_cg_regs = {
+	.set_ofs = 0x80,
+	.clr_ofs = 0x84,
+	.sta_ofs = 0x90,
+};
+
+static const struct mtk_gate_regs ifr3_cg_regs = {
+	.set_ofs = 0x88,
+	.clr_ofs = 0x8c,
+	.sta_ofs = 0x94,
+};
+
+static const struct mtk_gate_regs ifr4_cg_regs = {
+	.set_ofs = 0xa4,
+	.clr_ofs = 0xa8,
+	.sta_ofs = 0xac,
+};
+
+static const struct mtk_gate_regs ifr5_cg_regs = {
+	.set_ofs = 0xc0,
+	.clr_ofs = 0xc4,
+	.sta_ofs = 0xc8,
+};
+
+static const struct mtk_gate_regs ifr6_cg_regs = {
+	.set_ofs = 0xd0,
+	.clr_ofs = 0xd4,
+	.sta_ofs = 0xd8,
+};
+
+#define GATE_IFR0(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifr0_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr_inv,	\
+	}
+
+#define GATE_IFR1(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifr1_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_no_setclr,	\
+	}
+
+#define GATE_IFR2(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifr2_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_IFR3(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifr3_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_IFR4(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifr4_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_IFR5(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifr5_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+#define GATE_IFR6(_id, _name, _parent, _shift) {	\
+		.id = _id,				\
+		.name = _name,				\
+		.parent_name = _parent,			\
+		.regs = &ifr6_cg_regs,			\
+		.shift = _shift,			\
+		.ops = &mtk_clk_gate_ops_setclr,	\
+	}
+
+static const struct mtk_gate ifr_clks[] = {
+	/* IFR2 */
+	GATE_IFR2(CLK_IFR_PMIC_TMR, "ifr_pmic_tmr", "clk26m_ck", 0),
+	GATE_IFR2(CLK_IFR_PMIC_AP, "ifr_pmic_ap", "clk26m_ck", 1),
+	GATE_IFR2(CLK_IFR_PMIC_MD, "ifr_pmic_md", "clk26m_ck", 2),
+	GATE_IFR2(CLK_IFR_PMIC_CONN, "ifr_pmic_conn", "clk26m_ck", 3),
+	GATE_IFR2(CLK_IFR_ICUSB, "ifr_icusb", "axi_sel", 8),
+	GATE_IFR2(CLK_IFR_GCE, "ifr_gce", "axi_sel", 9),
+	GATE_IFR2(CLK_IFR_THERM, "ifr_therm", "axi_sel", 10),
+	GATE_IFR2(CLK_IFR_PWM_HCLK, "ifr_pwm_hclk", "axi_sel", 15),
+	GATE_IFR2(CLK_IFR_PWM1, "ifr_pwm1", "pwm_sel", 16),
+	GATE_IFR2(CLK_IFR_PWM2, "ifr_pwm2", "pwm_sel", 17),
+	GATE_IFR2(CLK_IFR_PWM3, "ifr_pwm3", "pwm_sel", 18),
+	GATE_IFR2(CLK_IFR_PWM4, "ifr_pwm4", "pwm_sel", 19),
+	GATE_IFR2(CLK_IFR_PWM5, "ifr_pwm5", "pwm_sel", 20),
+	GATE_IFR2(CLK_IFR_PWM, "ifr_pwm", "pwm_sel", 21),
+	GATE_IFR2(CLK_IFR_UART0, "ifr_uart0", "uart_sel", 22),
+	GATE_IFR2(CLK_IFR_UART1, "ifr_uart1", "uart_sel", 23),
+	GATE_IFR2(CLK_IFR_UART2, "ifr_uart2", "uart_sel", 24),
+	GATE_IFR2(CLK_IFR_DSP_UART, "ifr_dsp_uart", "uart_sel", 26),
+	GATE_IFR2(CLK_IFR_GCE_26M, "ifr_gce_26m", "clk26m_ck", 27),
+	GATE_IFR2(CLK_IFR_CQ_DMA_FPC, "ifr_cq_dma_fpc", "axi_sel", 28),
+	GATE_IFR2(CLK_IFR_BTIF, "ifr_btif", "axi_sel", 31),
+	/* IFR3 */
+	GATE_IFR3(CLK_IFR_SPI0, "ifr_spi0", "spi_sel", 1),
+	GATE_IFR3(CLK_IFR_MSDC0_HCLK, "ifr_msdc0", "msdc50_0_hc_sel", 2),
+	GATE_IFR3(CLK_IFR_MSDC2_HCLK, "ifr_msdc2", "msdc2_2_hc_sel", 3),
+	GATE_IFR3(CLK_IFR_MSDC1_HCLK, "ifr_msdc1", "axi_sel", 4),
+	GATE_IFR3(CLK_IFR_DVFSRC, "ifr_dvfsrc", "clk26m_ck", 7),
+	GATE_IFR3(CLK_IFR_GCPU, "ifr_gcpu", "axi_sel", 8),
+	GATE_IFR3(CLK_IFR_TRNG, "ifr_trng", "axi_sel", 9),
+	GATE_IFR3(CLK_IFR_AUXADC, "ifr_auxadc", "clk26m_ck", 10),
+	GATE_IFR3(CLK_IFR_AUXADC_MD, "ifr_auxadc_md", "clk26m_ck", 14),
+	GATE_IFR3(CLK_IFR_AP_DMA, "ifr_ap_dma", "axi_sel", 18),
+	GATE_IFR3(CLK_IFR_DEBUGSYS, "ifr_debugsys", "axi_sel", 24),
+	GATE_IFR3(CLK_IFR_AUDIO, "ifr_audio", "axi_sel", 25),
+	/* IFR4 */
+	GATE_IFR4(CLK_IFR_PWM_FBCLK6, "ifr_pwm_fbclk6", "pwm_sel", 0),
+	GATE_IFR4(CLK_IFR_DISP_PWM, "ifr_disp_pwm", "disp_pwm_sel", 2),
+	GATE_IFR4(CLK_IFR_AUD_26M_BK, "ifr_aud_26m_bk", "clk26m_ck", 4),
+	GATE_IFR4(CLK_IFR_CQ_DMA, "ifr_cq_dma", "axi_sel", 27),
+	/* IFR5 */
+	GATE_IFR5(CLK_IFR_MSDC0_SF, "ifr_msdc0_sf", "msdc50_0_sel", 0),
+	GATE_IFR5(CLK_IFR_MSDC1_SF, "ifr_msdc1_sf", "msdc50_0_sel", 1),
+	GATE_IFR5(CLK_IFR_MSDC2_SF, "ifr_msdc2_sf", "msdc50_0_sel", 2),
+	GATE_IFR5(CLK_IFR_AP_MSDC0, "ifr_ap_msdc0", "msdc50_0_sel", 7),
+	GATE_IFR5(CLK_IFR_MD_MSDC0, "ifr_md_msdc0", "msdc50_0_sel", 8),
+	GATE_IFR5(CLK_IFR_MSDC0_SRC, "ifr_msdc0_src", "msdc50_0_sel", 9),
+	GATE_IFR5(CLK_IFR_MSDC1_SRC, "ifr_msdc1_src", "msdc30_1_sel", 10),
+	GATE_IFR5(CLK_IFR_MSDC2_SRC, "ifr_msdc2_src", "msdc50_2_sel", 11),
+	GATE_IFR5(CLK_IFR_PWRAP_TMR, "ifr_pwrap_tmr", "clk26m_ck", 12),
+	GATE_IFR5(CLK_IFR_PWRAP_SPI, "ifr_pwrap_spi", "clk26m_ck", 13),
+	GATE_IFR5(CLK_IFR_PWRAP_SYS, "ifr_pwrap_sys", "clk26m_ck", 14),
+	GATE_IFR5(CLK_IFR_IRRX_26M, "ifr_irrx_26m", "clk26m_ck", 22),
+	GATE_IFR5(CLK_IFR_IRRX_32K, "ifr_irrx_32k", "clk32k", 23),
+	GATE_IFR5(CLK_IFR_I2C0_AXI, "ifr_i2c0_axi", "i2c_sel", 24),
+	GATE_IFR5(CLK_IFR_I2C1_AXI, "ifr_i2c1_axi", "i2c_sel", 25),
+	GATE_IFR5(CLK_IFR_I2C2_AXI, "ifr_i2c2_axi", "i2c_sel", 26),
+	GATE_IFR5(CLK_IFR_I2C3_AXI, "ifr_i2c3_axi", "i2c_sel", 27),
+	GATE_IFR5(CLK_IFR_NIC_AXI, "ifr_nic_axi", "axi_sel", 28),
+	GATE_IFR5(CLK_IFR_NIC_SLV_AXI, "ifr_nic_slv_axi", "axi_sel", 29),
+	GATE_IFR5(CLK_IFR_APU_AXI, "ifr_apu_axi", "axi_sel", 30),
+	/* IFR6 */
+	GATE_IFR6(CLK_IFR_NFIECC, "ifr_nfiecc", "nfiecc_sel", 0),
+	GATE_IFR6(CLK_IFR_NFI1X_BK, "ifr_nfi1x_bk", "nfi2x_sel", 1),
+	GATE_IFR6(CLK_IFR_NFIECC_BK, "ifr_nfiecc_bk", "nfi2x_sel", 2),
+	GATE_IFR6(CLK_IFR_NFI_BK, "ifr_nfi_bk", "axi_sel", 3),
+	GATE_IFR6(CLK_IFR_MSDC2_AP_BK, "ifr_msdc2_ap_bk", "axi_sel", 4),
+	GATE_IFR6(CLK_IFR_MSDC2_MD_BK, "ifr_msdc2_md_bk", "axi_sel", 5),
+	GATE_IFR6(CLK_IFR_MSDC2_BK, "ifr_msdc2_bk", "axi_sel", 6),
+	GATE_IFR6(CLK_IFR_SUSB_133_BK, "ifr_susb_133_bk", "axi_sel", 7),
+	GATE_IFR6(CLK_IFR_SUSB_66_BK, "ifr_susb_66_bk", "axi_sel", 8),
+	GATE_IFR6(CLK_IFR_SSUSB_SYS, "ifr_ssusb_sys", "ssusb_sys_sel", 9),
+	GATE_IFR6(CLK_IFR_SSUSB_REF, "ifr_ssusb_ref", "ssusb_sys_sel", 10),
+	GATE_IFR6(CLK_IFR_SSUSB_XHCI, "ifr_ssusb_xhci", "ssusb_xhci_sel", 11),
+};
+
+static const struct mtk_gate_regs peri_cg_regs = {
+	.set_ofs = 0x20c,
+	.clr_ofs = 0x20c,
+	.sta_ofs = 0x20c,
+};
+
+#define GATE_PERI(_id, _name, _parent, _shift) \
+		GATE_MTK(_id, _name, _parent, &peri_cg_regs, _shift, \
+			 &mtk_clk_gate_ops_no_setclr_inv)
+
+static const struct mtk_gate peri_clks[] = {
+	GATE_PERI(CLK_PERIAXI, "periaxi", "axi_sel", 31),
+};
+
+#define MT8365_PLL_FMAX		(3800UL * MHZ)
+#define MT8365_PLL_FMIN		(1500UL * MHZ)
+#define CON0_MT8365_RST_BAR	BIT(23)
+
+#define PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
+		_pd_reg, _pd_shift, _tuner_reg, _tuner_en_reg,		\
+		_tuner_en_bit,	_pcw_reg, _pcw_shift, _div_table,	\
+		_rst_bar_mask, _pcw_chg_reg) {				\
+		.id = _id,						\
+		.name = _name,						\
+		.reg = _reg,						\
+		.pwr_reg = _pwr_reg,					\
+		.en_mask = _en_mask,					\
+		.flags = _flags,					\
+		.rst_bar_mask = _rst_bar_mask,				\
+		.fmax = MT8365_PLL_FMAX,				\
+		.fmin = MT8365_PLL_FMIN,				\
+		.pcwbits = _pcwbits,					\
+		.pcwibits = 8,						\
+		.pd_reg = _pd_reg,					\
+		.pd_shift = _pd_shift,					\
+		.tuner_reg = _tuner_reg,				\
+		.tuner_en_reg = _tuner_en_reg,				\
+		.tuner_en_bit = _tuner_en_bit,				\
+		.pcw_reg = _pcw_reg,					\
+		.pcw_shift = _pcw_shift,				\
+		.pcw_chg_reg = _pcw_chg_reg,				\
+		.div_table = _div_table,				\
+	}
+
+#define PLL(_id, _name, _reg, _pwr_reg, _en_mask, _flags, _pcwbits,	\
+			_pd_reg, _pd_shift, _tuner_reg,			\
+			_tuner_en_reg, _tuner_en_bit, _pcw_reg,		\
+			_pcw_shift, _rst_bar_mask, _pcw_chg_reg)	\
+		PLL_B(_id, _name, _reg, _pwr_reg, _en_mask, _flags,	\
+			_pcwbits, _pd_reg, _pd_shift,			\
+			_tuner_reg, _tuner_en_reg, _tuner_en_bit,	\
+			_pcw_reg, _pcw_shift, NULL, _rst_bar_mask,	\
+			_pcw_chg_reg)					\
+
+static const struct mtk_pll_div_table armpll_div_table[] = {
+	{ .div = 0, .freq = MT8365_PLL_FMAX },
+	{ .div = 1, .freq = 1500 * MHZ },
+	{ .div = 2, .freq = 750 * MHZ },
+	{ .div = 3, .freq = 375 * MHZ },
+	{ .div = 4, .freq = 182500000 },
+	{ } /* sentinel */
+};
+static const struct mtk_pll_div_table mfgpll_div_table[] = {
+	{ .div = 0, .freq = MT8365_PLL_FMAX },
+	{ .div = 1, .freq = 1600 * MHZ },
+	{ .div = 2, .freq = 800 * MHZ },
+	{ .div = 3, .freq = 400 * MHZ },
+	{ .div = 4, .freq = 200 * MHZ },
+	{ } /* sentinel */
+};
+
+static const struct mtk_pll_div_table dsppll_div_table[] = {
+	{ .div = 0, .freq = MT8365_PLL_FMAX },
+	{ .div = 1, .freq = 1600 * MHZ },
+	{ .div = 2, .freq = 600 * MHZ },
+	{ .div = 3, .freq = 400 * MHZ },
+	{ .div = 4, .freq = 200 * MHZ },
+	{ } /* sentinel */
+};
+
+static const struct mtk_pll_data plls[] = {
+	PLL_B(CLK_APMIXED_ARMPLL, "armpll", 0x030C, 0x0318, 0x00000001, PLL_AO, 22,
+	    0x0310, 24, 0, 0, 0, 0x0310, 0, armpll_div_table, 0, 0),
+	PLL(CLK_APMIXED_MAINPLL, "mainpll", 0x0228, 0x0234, 0xFF000001,
+	    HAVE_RST_BAR, 22, 0x022C, 24, 0, 0, 0, 0x022C, 0,
+	    CON0_MT8365_RST_BAR, 0),
+	PLL(CLK_APMIXED_UNIVPLL, "univpll2", 0x0208, 0x0214, 0xFF000001,
+	    HAVE_RST_BAR, 22, 0x020C, 24, 0, 0, 0, 0x020C, 0,
+	    CON0_MT8365_RST_BAR, 0),
+	PLL_B(CLK_APMIXED_MFGPLL, "mfgpll", 0x0218, 0x0224, 0x00000001, 0, 22,
+	      0x021C, 24, 0, 0, 0, 0x021C, 0, mfgpll_div_table, 0, 0),
+	PLL(CLK_APMIXED_MSDCPLL, "msdcpll", 0x0350, 0x035C, 0x00000001, 0, 22,
+		0x0354, 24, 0, 0, 0, 0x0354, 0, 0, 0),
+	PLL(CLK_APMIXED_MMPLL, "mmpll", 0x0330, 0x033C, 0x00000001, 0, 22,
+	      0x0334, 24, 0, 0, 0, 0x0334, 0, 0, 0),
+	PLL(CLK_APMIXED_APLL1, "apll1", 0x031C, 0x032C, 0x00000001, 0, 32,
+	      0x0320, 24, 0x0040, 0x000C, 0, 0x0324, 0, 0, 0x0320),
+	PLL(CLK_APMIXED_APLL2, "apll2", 0x0360, 0x0370, 0x00000001, 0, 32,
+	    0x0364, 24, 0x004C, 0x000C, 5, 0x0368, 0, 0, 0x0364),
+	PLL(CLK_APMIXED_LVDSPLL, "lvdspll", 0x0374, 0x0380, 0x00000001, 0, 22,
+	      0x0378, 24, 0, 0, 0, 0x0378, 0, 0, 0),
+	PLL_B(CLK_APMIXED_DSPPLL, "dsppll", 0x0390, 0x039C, 0x00000001, 0, 22,
+	    0x0394, 24, 0, 0, 0, 0x0394, 0, dsppll_div_table, 0, 0),
+	PLL(CLK_APMIXED_APUPLL, "apupll", 0x03A0, 0x03AC, 0x00000001, 0, 22,
+	    0x03A4, 24, 0, 0, 0, 0x03A4, 0, 0, 0),
+};
+
+static int clk_mt8365_apmixed_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int ret;
+
+	clk_data = mtk_alloc_clk_data(CLK_APMIXED_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	ret = mtk_clk_register_gates(node, pll_clks, ARRAY_SIZE(pll_clks),
+				     clk_data);
+	if (ret)
+		goto free_clk_data;
+
+	ret = mtk_clk_register_plls(node, plls, ARRAY_SIZE(plls), clk_data);
+	if (ret)
+		goto unregister_gates;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		goto unregister_plls;
+
+	return 0;
+
+unregister_plls:
+	mtk_clk_unregister_plls(plls, ARRAY_SIZE(plls), clk_data);
+unregister_gates:
+	mtk_clk_unregister_gates(pll_clks, ARRAY_SIZE(pll_clks), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+
+	return ret;
+}
+
+static int clk_mt8365_top_probe(struct platform_device *pdev)
+{
+	void __iomem *base;
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = mtk_alloc_clk_data(CLK_TOP_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	ret = mtk_clk_register_fixed_clks(top_fixed_clks,
+					  ARRAY_SIZE(top_fixed_clks), clk_data);
+	if (ret)
+		goto free_clk_data;
+
+	ret = mtk_clk_register_factors(top_divs, ARRAY_SIZE(top_divs),
+				       clk_data);
+	if (ret)
+		goto unregister_fixed_clks;
+
+	ret = mtk_clk_register_muxes(top_muxes, ARRAY_SIZE(top_muxes), node,
+				     &mt8365_clk_lock, clk_data);
+	if (ret)
+		goto unregister_factors;
+
+	ret = mtk_clk_register_composites(top_misc_muxes,
+					  ARRAY_SIZE(top_misc_muxes), base,
+					  &mt8365_clk_lock, clk_data);
+	if (ret)
+		goto unregister_muxes;
+
+	ret = mtk_clk_register_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
+					base, &mt8365_clk_lock, clk_data);
+	if (ret)
+		goto unregister_composites;
+
+	ret = mtk_clk_register_gates(node, top_clks, ARRAY_SIZE(top_clks),
+				     clk_data);
+	if (ret)
+		goto unregister_dividers;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		goto unregister_gates;
+
+	return 0;
+
+unregister_gates:
+	mtk_clk_unregister_gates(top_clks, ARRAY_SIZE(top_clks), clk_data);
+unregister_dividers:
+	mtk_clk_unregister_dividers(top_adj_divs, ARRAY_SIZE(top_adj_divs),
+				    clk_data);
+unregister_composites:
+	mtk_clk_unregister_composites(top_misc_muxes,
+				      ARRAY_SIZE(top_misc_muxes), clk_data);
+unregister_muxes:
+	mtk_clk_unregister_muxes(top_muxes, ARRAY_SIZE(top_muxes), clk_data);
+unregister_factors:
+	mtk_clk_unregister_factors(top_divs, ARRAY_SIZE(top_divs), clk_data);
+unregister_fixed_clks:
+	mtk_clk_unregister_fixed_clks(top_fixed_clks,
+				      ARRAY_SIZE(top_fixed_clks), clk_data);
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+
+	return ret;
+}
+
+static int clk_mt8365_infra_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int ret;
+
+	clk_data = mtk_alloc_clk_data(CLK_IFR_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	ret = mtk_clk_register_gates(node, ifr_clks, ARRAY_SIZE(ifr_clks),
+				     clk_data);
+	if (ret)
+		goto free_clk_data;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		goto unregister_gates;
+
+	return 0;
+
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+unregister_gates:
+	mtk_clk_unregister_gates(ifr_clks, ARRAY_SIZE(ifr_clks), clk_data);
+
+	return ret;
+}
+
+static int clk_mt8365_peri_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	int ret;
+
+	clk_data = mtk_alloc_clk_data(CLK_PERI_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	ret = mtk_clk_register_gates(node, peri_clks, ARRAY_SIZE(peri_clks),
+				     clk_data);
+	if (ret)
+		goto free_clk_data;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		goto unregister_gates;
+
+	return 0;
+
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+unregister_gates:
+	mtk_clk_unregister_gates(peri_clks, ARRAY_SIZE(peri_clks), clk_data);
+
+	return ret;
+}
+
+static int clk_mt8365_mcu_probe(struct platform_device *pdev)
+{
+	struct clk_hw_onecell_data *clk_data;
+	struct device_node *node = pdev->dev.of_node;
+	void __iomem *base;
+	int ret;
+
+	base = devm_platform_ioremap_resource(pdev, 0);
+	if (IS_ERR(base))
+		return PTR_ERR(base);
+
+	clk_data = mtk_alloc_clk_data(CLK_MCU_NR_CLK);
+	if (!clk_data)
+		return -ENOMEM;
+
+	ret = mtk_clk_register_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes),
+					  base, &mt8365_clk_lock, clk_data);
+	if (ret)
+		goto free_clk_data;
+
+	ret = of_clk_add_hw_provider(node, of_clk_hw_onecell_get, clk_data);
+	if (ret)
+		goto unregister_composites;
+
+	return 0;
+
+free_clk_data:
+	mtk_free_clk_data(clk_data);
+unregister_composites:
+	mtk_clk_unregister_composites(mcu_muxes, ARRAY_SIZE(mcu_muxes),
+				      clk_data);
+
+	return ret;
+}
+
+static const struct of_device_id of_match_clk_mt8365[] = {
+	{
+		.compatible = "mediatek,mt8365-apmixedsys",
+		.data = clk_mt8365_apmixed_probe,
+	}, {
+		.compatible = "mediatek,mt8365-topckgen",
+		.data = clk_mt8365_top_probe,
+	}, {
+		.compatible = "mediatek,mt8365-infracfg",
+		.data = clk_mt8365_infra_probe,
+	}, {
+		.compatible = "mediatek,mt8365-pericfg",
+		.data = clk_mt8365_peri_probe,
+	}, {
+		.compatible = "mediatek,mt8365-mcucfg",
+		.data = clk_mt8365_mcu_probe,
+	}, {
+		/* sentinel */
+	}
+};
+
+static int clk_mt8365_probe(struct platform_device *pdev)
+{
+	int (*clk_probe)(struct platform_device *pdev);
+	int ret;
+
+	clk_probe = of_device_get_match_data(&pdev->dev);
+	if (!clk_probe)
+		return -EINVAL;
+
+	ret = clk_probe(pdev);
+	if (ret)
+		dev_err(&pdev->dev,
+			"%s: could not register clock provider: %d\n",
+			pdev->name, ret);
+
+	return ret;
+}
+
+static struct platform_driver clk_mt8365_drv = {
+	.probe = clk_mt8365_probe,
+	.driver = {
+		.name = "clk-mt8365",
+		.of_match_table = of_match_clk_mt8365,
+	},
+};
+
+static int __init clk_mt8365_init(void)
+{
+	return platform_driver_register(&clk_mt8365_drv);
+}
+arch_initcall(clk_mt8365_init);
-- 
2.36.1

