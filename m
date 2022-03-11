Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id B5D594D60F4
	for <lists+linux-kernel@lfdr.de>; Fri, 11 Mar 2022 12:45:09 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1348431AbiCKLpA (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 11 Mar 2022 06:45:00 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:49576 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1348387AbiCKLob (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 11 Mar 2022 06:44:31 -0500
Received: from mailgw02.mediatek.com (unknown [210.61.82.184])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BEBD5F70EB;
        Fri, 11 Mar 2022 03:43:18 -0800 (PST)
X-UUID: ce8a455ecc9d44f1885df25b71cdf366-20220311
X-UUID: ce8a455ecc9d44f1885df25b71cdf366-20220311
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 288753037; Fri, 11 Mar 2022 19:43:14 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Fri, 11 Mar 2022 19:43:13 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Fri, 11 Mar 2022 19:43:13 +0800
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
Subject: [PATCH v3 09/15] clk: mediatek: Add MT8186 wpesys clock support
Date:   Fri, 11 Mar 2022 19:42:23 +0800
Message-ID: <20220311114229.32504-10-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220311114229.32504-1-chun-jie.chen@mediatek.com>
References: <20220311114229.32504-1-chun-jie.chen@mediatek.com>
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

Add MT8186 wpesys clock controllers which provide clock gate
control in Wrapping Engine.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/clk/mediatek/Makefile         |  2 +-
 drivers/clk/mediatek/clk-mt8186-wpe.c | 51 +++++++++++++++++++++++++++
 2 files changed, 52 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8186-wpe.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index d0daef003b87..cb1087737007 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -73,7 +73,7 @@ obj-$(CONFIG_COMMON_CLK_MT8183_VDECSYS) += clk-mt8183-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8183_VENCSYS) += clk-mt8183-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt8186-infra_ao.o \
 				   clk-mt8186-apmixedsys.o clk-mt8186-imp_iic_wrap.o \
-				   clk-mt8186-mfg.o clk-mt8186-mm.o
+				   clk-mt8186-mfg.o clk-mt8186-mm.o clk-mt8186-wpe.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8186-wpe.c b/drivers/clk/mediatek/clk-mt8186-wpe.c
new file mode 100644
index 000000000000..8c16c53ba808
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8186-wpe.c
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
+static const struct mtk_gate_regs wpe_cg_regs = {
+	.set_ofs = 0x0,
+	.clr_ofs = 0x0,
+	.sta_ofs = 0x0,
+};
+
+#define GATE_WPE(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &wpe_cg_regs, _shift, &mtk_clk_gate_ops_no_setclr_inv)
+
+static const struct mtk_gate wpe_clks[] = {
+	GATE_WPE(CLK_WPE_CK_EN, "wpe", "top_wpe", 17),
+	GATE_WPE(CLK_WPE_SMI_LARB8_CK_EN, "wpe_smi_larb8", "top_wpe", 19),
+	GATE_WPE(CLK_WPE_SYS_EVENT_TX_CK_EN, "wpe_sys_event_tx", "top_wpe", 20),
+	GATE_WPE(CLK_WPE_SMI_LARB8_PCLK_EN, "wpe_smi_larb8_p_en", "top_wpe", 25),
+};
+
+static const struct mtk_clk_desc wpe_desc = {
+	.clks = wpe_clks,
+	.num_clks = ARRAY_SIZE(wpe_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8186_wpe[] = {
+	{
+		.compatible = "mediatek,mt8186-wpesys",
+		.data = &wpe_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8186_wpe_drv = {
+	.probe = mtk_clk_simple_probe,
+	.remove = mtk_clk_simple_remove,
+	.driver = {
+		.name = "clk-mt8186-wpe",
+		.of_match_table = of_match_clk_mt8186_wpe,
+	},
+};
+builtin_platform_driver(clk_mt8186_wpe_drv);
-- 
2.18.0

