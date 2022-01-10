Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 34E32489A6B
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:45:59 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233565AbiAJNpv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:45:51 -0500
Received: from mailgw01.mediatek.com ([60.244.123.138]:39352 "EHLO
        mailgw01.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233509AbiAJNpH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:45:07 -0500
X-UUID: f278a12d25074cfb88960f47bcce5c7d-20220110
X-UUID: f278a12d25074cfb88960f47bcce5c7d-20220110
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1449189877; Mon, 10 Jan 2022 21:45:03 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n2.mediatek.inc (172.21.101.183) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id 15.2.792.3;
 Mon, 10 Jan 2022 21:45:02 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 21:45:02 +0800
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
Subject: [v1 15/16] clk: mediatek: Add MT8186 mdpsys clock support
Date:   Mon, 10 Jan 2022 21:44:15 +0800
Message-ID: <20220110134416.5191-16-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
References: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8186 mdpsys clock controller which provides clock gate
control in Multimedia Data Path.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Makefile         |  2 +-
 drivers/clk/mediatek/clk-mt8186-mdp.c | 79 +++++++++++++++++++++++++++
 2 files changed, 80 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8186-mdp.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 9190e17602eb..7320df02356c 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -71,7 +71,7 @@ obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt
 				   clk-mt8186-apmixedsys.o clk-mt8186-imp_iic_wrap.o \
 				   clk-mt8186-mfg.o clk-mt8186-mm.o clk-mt8186-wpe.o \
 				   clk-mt8186-img.o clk-mt8186-vdec.o clk-mt8186-venc.o \
-				   clk-mt8186-cam.o
+				   clk-mt8186-cam.o clk-mt8186-mdp.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8186-mdp.c b/drivers/clk/mediatek/clk-mt8186-mdp.c
new file mode 100644
index 000000000000..62f2f23c284b
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8186-mdp.c
@@ -0,0 +1,79 @@
+// SPDX-License-Identifier: GPL-2.0-only
+//
+// Copyright (c) 2022 MediaTek Inc.
+// Author: Chun-Jie Chen <chun-jie.chen@mediatek.com>
+
+#include "clk-gate.h"
+#include "clk-mtk.h"
+
+#include <dt-bindings/clock/mt8186-clk.h>
+#include <linux/clk-provider.h>
+#include <linux/platform_device.h>
+
+static const struct mtk_gate_regs mdp0_cg_regs = {
+	.set_ofs = 0x104,
+	.clr_ofs = 0x108,
+	.sta_ofs = 0x100,
+};
+
+static const struct mtk_gate_regs mdp2_cg_regs = {
+	.set_ofs = 0x124,
+	.clr_ofs = 0x128,
+	.sta_ofs = 0x120,
+};
+
+#define GATE_MDP0(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mdp0_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+#define GATE_MDP2(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &mdp2_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate mdp_clks[] = {
+	/* MDP0 */
+	GATE_MDP0(CLK_MDP_RDMA0, "mdp_rdma0", "top_mdp", 0),
+	GATE_MDP0(CLK_MDP_TDSHP0, "mdp_tdshp0", "top_mdp", 1),
+	GATE_MDP0(CLK_MDP_IMG_DL_ASYNC0, "mdp_img_dl_async0", "top_mdp", 2),
+	GATE_MDP0(CLK_MDP_IMG_DL_ASYNC1, "mdp_img_dl_async1", "top_mdp", 3),
+	GATE_MDP0(CLK_MDP_DISP_RDMA, "mdp_disp_rdma", "top_mdp", 4),
+	GATE_MDP0(CLK_MDP_HMS, "mdp_hms", "top_mdp", 5),
+	GATE_MDP0(CLK_MDP_SMI0, "mdp_smi0", "top_mdp", 6),
+	GATE_MDP0(CLK_MDP_APB_BUS, "mdp_apb_bus", "top_mdp", 7),
+	GATE_MDP0(CLK_MDP_WROT0, "mdp_wrot0", "top_mdp", 8),
+	GATE_MDP0(CLK_MDP_RSZ0, "mdp_rsz0", "top_mdp", 9),
+	GATE_MDP0(CLK_MDP_HDR0, "mdp_hdr0", "top_mdp", 10),
+	GATE_MDP0(CLK_MDP_MUTEX0, "mdp_mutex0", "top_mdp", 11),
+	GATE_MDP0(CLK_MDP_WROT1, "mdp_wrot1", "top_mdp", 12),
+	GATE_MDP0(CLK_MDP_RSZ1, "mdp_rsz1", "top_mdp", 13),
+	GATE_MDP0(CLK_MDP_FAKE_ENG0, "mdp_fake_eng0", "top_mdp", 14),
+	GATE_MDP0(CLK_MDP_AAL0, "mdp_aal0", "top_mdp", 15),
+	GATE_MDP0(CLK_MDP_DISP_WDMA, "mdp_disp_wdma", "top_mdp", 16),
+	GATE_MDP0(CLK_MDP_COLOR, "mdp_color", "top_mdp", 17),
+	GATE_MDP0(CLK_MDP_IMG_DL_ASYNC2, "mdp_img_dl_async2", "top_mdp", 18),
+	/* MDP2 */
+	GATE_MDP2(CLK_MDP_IMG_DL_RELAY0_ASYNC0, "mdp_img_dl_rel0_as0", "top_mdp", 0),
+	GATE_MDP2(CLK_MDP_IMG_DL_RELAY1_ASYNC1, "mdp_img_dl_rel1_as1", "top_mdp", 8),
+	GATE_MDP2(CLK_MDP_IMG_DL_RELAY2_ASYNC2, "mdp_img_dl_rel2_as2", "top_mdp", 24),
+};
+
+static const struct mtk_clk_desc mdp_desc = {
+	.clks = mdp_clks,
+	.num_clks = ARRAY_SIZE(mdp_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8186_mdp[] = {
+	{
+		.compatible = "mediatek,mt8186-mdpsys",
+		.data = &mdp_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8186_mdp_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8186-mdp",
+		.of_match_table = of_match_clk_mt8186_mdp,
+	},
+};
+builtin_platform_driver(clk_mt8186_mdp_drv);
-- 
2.18.0

