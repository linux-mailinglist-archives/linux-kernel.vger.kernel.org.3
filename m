Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 070274FA863
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:27:15 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S242070AbiDIN1H (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:27:07 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39450 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242061AbiDIN0S (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:26:18 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4BC2B53E0;
        Sat,  9 Apr 2022 06:23:59 -0700 (PDT)
X-UUID: f5510e73775c46c2b6357dc100ee75e4-20220409
X-UUID: f5510e73775c46c2b6357dc100ee75e4-20220409
Received: from mtkexhb02.mediatek.inc [(172.21.101.103)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1811469888; Sat, 09 Apr 2022 21:23:54 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Sat, 9 Apr 2022 21:23:53 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Apr 2022 21:23:52 +0800
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
Subject: [PATCH v5 11/15] clk: mediatek: Add MT8186 vdecsys clock support
Date:   Sat, 9 Apr 2022 21:22:47 +0800
Message-ID: <20220409132251.31725-12-chun-jie.chen@mediatek.com>
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

Add MT8186 vdec clock controller which provide clock gate
control for video decoder.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/Makefile          |  2 +-
 drivers/clk/mediatek/clk-mt8186-vdec.c | 88 ++++++++++++++++++++++++++
 2 files changed, 89 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8186-vdec.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 09ede533bb4e..7b0238847881 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -74,7 +74,7 @@ obj-$(CONFIG_COMMON_CLK_MT8183_VENCSYS) += clk-mt8183-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt8186-infra_ao.o \
 				   clk-mt8186-apmixedsys.o clk-mt8186-imp_iic_wrap.o \
 				   clk-mt8186-mfg.o clk-mt8186-mm.o clk-mt8186-wpe.o \
-				   clk-mt8186-img.o
+				   clk-mt8186-img.o clk-mt8186-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8186-vdec.c b/drivers/clk/mediatek/clk-mt8186-vdec.c
new file mode 100644
index 000000000000..5ad7e1ae0bac
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8186-vdec.c
@@ -0,0 +1,88 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "clk-mtk.h"
+#include "clk-gate.h"
+
+#include <dt-bindings/clock/mt8186-clk.h>
+
+static const struct mtk_gate_regs vdec0_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x4,
+	.sta_ofs = 0x0,
+};
+
+static const struct mtk_gate_regs vdec1_cg_regs = {
+	.set_ofs = 0x190,
+	.clr_ofs = 0x190,
+	.sta_ofs = 0x190,
+};
+
+static const struct mtk_gate_regs vdec2_cg_regs = {
+	.set_ofs = 0x200,
+	.clr_ofs = 0x204,
+	.sta_ofs = 0x200,
+};
+
+static const struct mtk_gate_regs vdec3_cg_regs = {
+	.set_ofs = 0x8,
+	.clr_ofs = 0xc,
+	.sta_ofs = 0x8,
+};
+
+#define GATE_VDEC0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdec0_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+#define GATE_VDEC1(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdec1_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+#define GATE_VDEC2(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdec2_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+#define GATE_VDEC3(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &vdec3_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate vdec_clks[] = {
+	/* VDEC0 */
+	GATE_VDEC0(CLK_VDEC_CKEN, "vdec_cken", "top_vdec", 0),
+	GATE_VDEC0(CLK_VDEC_ACTIVE, "vdec_active", "top_vdec", 4),
+	GATE_VDEC0(CLK_VDEC_CKEN_ENG, "vdec_cken_eng", "top_vdec", 8),
+	/* VDEC1 */
+	GATE_VDEC1(CLK_VDEC_MINI_MDP_CKEN_CFG_RG, "vdec_mini_mdp_cken_cfg_rg", "top_vdec", 0),
+	/* VDEC2 */
+	GATE_VDEC2(CLK_VDEC_LAT_CKEN, "vdec_lat_cken", "top_vdec", 0),
+	GATE_VDEC2(CLK_VDEC_LAT_ACTIVE, "vdec_lat_active", "top_vdec", 4),
+	GATE_VDEC2(CLK_VDEC_LAT_CKEN_ENG, "vdec_lat_cken_eng", "top_vdec", 8),
+	/* VDEC3 */
+	GATE_VDEC3(CLK_VDEC_LARB1_CKEN, "vdec_larb1_cken", "top_vdec", 0),
+};
+
+static const struct mtk_clk_desc vdec_desc = {
+	.clks = vdec_clks,
+	.num_clks = ARRAY_SIZE(vdec_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8186_vdec[] = {
+	{
+		.compatible = "mediatek,mt8186-vdecsys",
+		.data = &vdec_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8186_vdec_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8186-vdec",
+		.of_match_table = of_match_clk_mt8186_vdec,
+	},
+};
+builtin_platform_driver(clk_mt8186_vdec_drv);
-- 
2.18.0

