Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 9B5D94BD378
	for <lists+linux-kernel@lfdr.de>; Mon, 21 Feb 2022 03:09:30 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S245434AbiBUCAQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 20 Feb 2022 21:00:16 -0500
Received: from mxb-00190b01.gslb.pphosted.com ([23.128.96.19]:47316 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S245584AbiBUB7y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 20 Feb 2022 20:59:54 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id B45E751E61;
        Sun, 20 Feb 2022 17:59:28 -0800 (PST)
X-UUID: 1d2cd2ea0c4e4c9aad47264dc73299a6-20220221
X-UUID: 1d2cd2ea0c4e4c9aad47264dc73299a6-20220221
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1883541788; Mon, 21 Feb 2022 09:59:25 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 21 Feb 2022 09:59:23 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 21 Feb 2022 09:59:23 +0800
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
Subject: [PATCH v2 12/15] clk: mediatek: Add MT8186 vencsys clock support
Date:   Mon, 21 Feb 2022 09:52:55 +0800
Message-ID: <20220221015258.913-13-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220221015258.913-1-chun-jie.chen@mediatek.com>
References: <20220221015258.913-1-chun-jie.chen@mediatek.com>
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

Add MT8186 vencsys clock controller which provide clock gate
control for video encoder.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Makefile          |  2 +-
 drivers/clk/mediatek/clk-mt8186-venc.c | 51 ++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8186-venc.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index 7b0238847881..28aefad8042e 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -74,7 +74,7 @@ obj-$(CONFIG_COMMON_CLK_MT8183_VENCSYS) += clk-mt8183-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt8186-infra_ao.o \
 				   clk-mt8186-apmixedsys.o clk-mt8186-imp_iic_wrap.o \
 				   clk-mt8186-mfg.o clk-mt8186-mm.o clk-mt8186-wpe.o \
-				   clk-mt8186-img.o clk-mt8186-vdec.o
+				   clk-mt8186-img.o clk-mt8186-vdec.o clk-mt8186-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8186-venc.c b/drivers/clk/mediatek/clk-mt8186-venc.c
new file mode 100644
index 000000000000..2ae9bcfb35de
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8186-venc.c
@@ -0,0 +1,51 @@
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
+static const struct mtk_gate_regs venc_cg_regs = {
+	.set_ofs = 0x4,
+	.clr_ofs = 0x8,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_VENC(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &venc_cg_regs, _shift, &mtk_clk_gate_ops_setclr_inv)
+
+static const struct mtk_gate venc_clks[] = {
+	GATE_VENC(CLK_VENC_CKE0_LARB, "venc_cke0_larb", "top_venc", 0),
+	GATE_VENC(CLK_VENC_CKE1_VENC, "venc_cke1_venc", "top_venc", 4),
+	GATE_VENC(CLK_VENC_CKE2_JPGENC, "venc_cke2_jpgenc", "top_venc", 8),
+	GATE_VENC(CLK_VENC_CKE5_GALS, "venc_cke5_gals", "top_venc", 28),
+};
+
+static const struct mtk_clk_desc venc_desc = {
+	.clks = venc_clks,
+	.num_clks = ARRAY_SIZE(venc_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8186_venc[] = {
+	{
+		.compatible = "mediatek,mt8186-vencsys",
+		.data = &venc_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8186_venc_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8186-venc",
+		.of_match_table = of_match_clk_mt8186_venc,
+	},
+};
+builtin_platform_driver(clk_mt8186_venc_drv);
-- 
2.18.0

