Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id ACB9C4FA871
	for <lists+linux-kernel@lfdr.de>; Sat,  9 Apr 2022 15:27:19 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240164AbiDIN3M (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 9 Apr 2022 09:29:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40426 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242031AbiDIN0a (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 9 Apr 2022 09:26:30 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E5671C1CA6;
        Sat,  9 Apr 2022 06:24:08 -0700 (PDT)
X-UUID: 73704c264fdd4ea7a7597aaa0df1f2b2-20220409
X-UUID: 73704c264fdd4ea7a7597aaa0df1f2b2-20220409
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw01.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1000773465; Sat, 09 Apr 2022 21:24:05 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Sat, 9 Apr 2022 21:24:04 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 9 Apr 2022 21:24:04 +0800
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
Subject: [PATCH v5 15/15] clk: mediatek: Add MT8186 ipesys clock support
Date:   Sat, 9 Apr 2022 21:22:51 +0800
Message-ID: <20220409132251.31725-16-chun-jie.chen@mediatek.com>
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

Add MT8186 ipesys clock controller which provides clock gate
control for Image Process Engine.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Reviewed-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Reviewed-by: Miles Chen <miles.chen@mediatek.com>
---
 drivers/clk/mediatek/Makefile         |  2 +-
 drivers/clk/mediatek/clk-mt8186-ipe.c | 55 +++++++++++++++++++++++++++
 2 files changed, 56 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8186-ipe.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 6902da61e150..caf2ce93d666 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -75,7 +75,7 @@ obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt
 				   clk-mt8186-apmixedsys.o clk-mt8186-imp_iic_wrap.o \
 				   clk-mt8186-mfg.o clk-mt8186-mm.o clk-mt8186-wpe.o \
 				   clk-mt8186-img.o clk-mt8186-vdec.o clk-mt8186-venc.o \
-				   clk-mt8186-cam.o clk-mt8186-mdp.o
+				   clk-mt8186-cam.o clk-mt8186-mdp.o clk-mt8186-ipe.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8186-ipe.c b/drivers/clk/mediatek/clk-mt8186-ipe.c
new file mode 100644
index 000000000000..8fca148effa6
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8186-ipe.c
@@ -0,0 +1,55 @@
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
+static const struct mtk_gate_regs ipe_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_IPE(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &ipe_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate ipe_clks[] = {
+	GATE_IPE(CLK_IPE_LARB19, "ipe_larb19", "top_ipe", 0),
+	GATE_IPE(CLK_IPE_LARB20, "ipe_larb20", "top_ipe", 1),
+	GATE_IPE(CLK_IPE_SMI_SUBCOM, "ipe_smi_subcom", "top_ipe", 2),
+	GATE_IPE(CLK_IPE_FD, "ipe_fd", "top_ipe", 3),
+	GATE_IPE(CLK_IPE_FE, "ipe_fe", "top_ipe", 4),
+	GATE_IPE(CLK_IPE_RSC, "ipe_rsc", "top_ipe", 5),
+	GATE_IPE(CLK_IPE_DPE, "ipe_dpe", "top_ipe", 6),
+	GATE_IPE(CLK_IPE_GALS_IPE, "ipe_gals_ipe", "top_img1", 8),
+};
+
+static const struct mtk_clk_desc ipe_desc = {
+	.clks = ipe_clks,
+	.num_clks = ARRAY_SIZE(ipe_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8186_ipe[] = {
+	{
+		.compatible = "mediatek,mt8186-ipesys",
+		.data = &ipe_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8186_ipe_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8186-ipe",
+		.of_match_table = of_match_clk_mt8186_ipe,
+	},
+};
+builtin_platform_driver(clk_mt8186_ipe_drv);
-- 
2.18.0

