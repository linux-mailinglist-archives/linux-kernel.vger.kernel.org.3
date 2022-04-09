Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 6C98D4FA858
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:27:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242135AbiDIN1U (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:27:20 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39348 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242077AbiDIN0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:26:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id CA9BF9D4F7;
        Sat,  9 Apr 2022 06:24:05 -0700 (PDT)
X-UUID: 073be7468da74c2a95337a7aef327579-20220409
X-UUID: 073be7468da74c2a95337a7aef327579-20220409
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1680444954; Sat, 09 Apr 2022 21:24:00 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 9 Apr 2022 21:23:59 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Apr 2022 21:23:58 +0800
From:   Chun-Jie Chen <chun-jie.chen@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Nicolas Boichat <drinkcat@chromium.org>,
        Rob Herring <robh+dt@kernel.org>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>,
        <linux-mediatek@lists.infradead.org>, <linux-clk@vger.kernel.org>,
        <devicetree@vger.kernel.org>, <srv_heupstream@mediatek.com>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH v5 13/15] clk: mediatek: Add MT8186 camsys clock support
Date:   Sat, 9 Apr 2022 21:22:49 +0800
Message-ID: <20220409132251.31725-14-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220409132251.31725-1-chun-jie.chen@mediatek.com>
References: <20220409132251.31725-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8186 camsys clock controllers which provide clock gate
control for camera IP blocks.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/Makefile         |  3 +-
 drivers/clk/mediatek/clk-mt8186-cam.c | 90 +++++++++++++++++++++++++++
 2 files changed, 92 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8186-cam.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 28aefad8042e..3ad27f94eeef 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -74,7 +74,8 @@ obj-$(CONFIG_COMMON_CLK_MT8183_VENCSYS) += clk-mt8183-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt8186-infra_ao.o \
 				   clk-mt8186-apmixedsys.o clk-mt8186-imp_iic_wrap.o \
 				   clk-mt8186-mfg.o clk-mt8186-mm.o clk-mt8186-wpe.o \
-				   clk-mt8186-img.o clk-mt8186-vdec.o clk-mt8186-venc.o
+				   clk-mt8186-img.o clk-mt8186-vdec.o clk-mt8186-venc.o \
+				   clk-mt8186-cam.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8186-cam.c b/drivers/clk/mediatek/clk-mt8186-cam.c
new file mode 100644
index 000000000000..9ec345a2ce66
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8186-cam.c
@@ -0,0 +1,90 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+#include <dt-bindings/clock/mt8186-clk.h>
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
+#define GATE_CAM(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &cam_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate cam_clks[] = {
+	GATE_CAM(CLK_CAM_LARB13, "cam_larb13", "top_cam", 0),
+	GATE_CAM(CLK_CAM_DFP_VAD, "cam_dfp_vad", "top_cam", 1),
+	GATE_CAM(CLK_CAM_LARB14, "cam_larb14", "top_cam", 2),
+	GATE_CAM(CLK_CAM, "cam", "top_cam", 6),
+	GATE_CAM(CLK_CAMTG, "camtg", "top_cam", 7),
+	GATE_CAM(CLK_CAM_SENINF, "cam_seninf", "top_cam", 8),
+	GATE_CAM(CLK_CAMSV1, "camsv1", "top_cam", 10),
+	GATE_CAM(CLK_CAMSV2, "camsv2", "top_cam", 11),
+	GATE_CAM(CLK_CAMSV3, "camsv3", "top_cam", 12),
+	GATE_CAM(CLK_CAM_CCU0, "cam_ccu0", "top_cam", 13),
+	GATE_CAM(CLK_CAM_CCU1, "cam_ccu1", "top_cam", 14),
+	GATE_CAM(CLK_CAM_MRAW0, "cam_mraw0", "top_cam", 15),
+	GATE_CAM(CLK_CAM_FAKE_ENG, "cam_fake_eng", "top_cam", 17),
+	GATE_CAM(CLK_CAM_CCU_GALS, "cam_ccu_gals", "top_cam", 18),
+	GATE_CAM(CLK_CAM2MM_GALS, "cam2mm_gals", "top_cam", 19),
+};
+
+static const struct mtk_gate cam_rawa_clks[] = {
+	GATE_CAM(CLK_CAM_RAWA_LARBX_RAWA, "cam_rawa_larbx_rawa", "top_cam", 0),
+	GATE_CAM(CLK_CAM_RAWA, "cam_rawa", "top_cam", 1),
+	GATE_CAM(CLK_CAM_RAWA_CAMTG_RAWA, "cam_rawa_camtg_rawa", "top_cam", 2),
+};
+
+static const struct mtk_gate cam_rawb_clks[] = {
+	GATE_CAM(CLK_CAM_RAWB_LARBX_RAWB, "cam_rawb_larbx_rawb", "top_cam", 0),
+	GATE_CAM(CLK_CAM_RAWB, "cam_rawb", "top_cam", 1),
+	GATE_CAM(CLK_CAM_RAWB_CAMTG_RAWB, "cam_rawb_camtg_rawb", "top_cam", 2),
+};
+
+static const struct mtk_clk_desc cam_desc = {
+	.clks = cam_clks,
+	.num_clks = ARRAY_SIZE(cam_clks),
+};
+
+static const struct mtk_clk_desc cam_rawa_desc = {
+	.clks = cam_rawa_clks,
+	.num_clks = ARRAY_SIZE(cam_rawa_clks),
+};
+
+static const struct mtk_clk_desc cam_rawb_desc = {
+	.clks = cam_rawb_clks,
+	.num_clks = ARRAY_SIZE(cam_rawb_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8186_cam[] = {
+	{
+		.compatible = "mediatek,mt8186-camsys",
+		.data = &cam_desc,
+	}, {
+		.compatible = "mediatek,mt8186-camsys_rawa",
+		.data = &cam_rawa_desc,
+	}, {
+		.compatible = "mediatek,mt8186-camsys_rawb",
+		.data = &cam_rawb_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8186_cam_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8186-cam",
+		.of_match_table = of_match_clk_mt8186_cam,
+	},
+};
+builtin_platform_driver(clk_mt8186_cam_drv);
-- 
2.18.0

