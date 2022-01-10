Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 35728489A50
	for <lists+linux-kernel@lfdr.de>; Mon, 10 Jan 2022 14:45:14 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233978AbiAJNpE (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 10 Jan 2022 08:45:04 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:39066 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S233468AbiAJNot (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 10 Jan 2022 08:44:49 -0500
X-UUID: 2bd42c30de3842d3b734c44c3d332270-20220110
X-UUID: 2bd42c30de3842d3b734c44c3d332270-20220110
Received: from mtkmbs10n2.mediatek.inc [(172.21.101.183)] by mailgw02.mediatek.com
        (envelope-from <chun-jie.chen@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 501186542; Mon, 10 Jan 2022 21:44:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by
 mtkmbs10n1.mediatek.inc (172.21.101.34) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_CBC_SHA384) id
 15.2.792.15; Mon, 10 Jan 2022 21:44:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Mon, 10 Jan 2022 21:44:42 +0800
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
Subject: [v1 07/16] clk: mediatek: Add MT8186 imp i2c wrapper clock support
Date:   Mon, 10 Jan 2022 21:44:07 +0800
Message-ID: <20220110134416.5191-8-chun-jie.chen@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
References: <20220110134416.5191-1-chun-jie.chen@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8186 imp i2c wrapper clock controllers which provide clock gate
control in i2c IP blocks.

Signed-off-by: Chun-Jie Chen <chun-jie.chen@mediatek.com>
---
 drivers/clk/mediatek/Makefile                 |  2 +-
 .../clk/mediatek/clk-mt8186-imp_iic_wrap.c    | 66 +++++++++++++++++++
 2 files changed, 67 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index b139acdff591..8f8240e4d8d0 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -68,7 +68,7 @@ obj-$(CONFIG_COMMON_CLK_MT8183_MMSYS) += clk-mt8183-mm.o
 obj-$(CONFIG_COMMON_CLK_MT8183_VDECSYS) += clk-mt8183-vdec.o
 obj-$(CONFIG_COMMON_CLK_MT8183_VENCSYS) += clk-mt8183-venc.o
 obj-$(CONFIG_COMMON_CLK_MT8186) += clk-mt8186-mcu.o clk-mt8186-topckgen.o clk-mt8186-infra_ao.o \
-				   clk-mt8186-apmixedsys.o
+				   clk-mt8186-apmixedsys.o clk-mt8186-imp_iic_wrap.o
 obj-$(CONFIG_COMMON_CLK_MT8192) += clk-mt8192.o
 obj-$(CONFIG_COMMON_CLK_MT8192_AUDSYS) += clk-mt8192-aud.o
 obj-$(CONFIG_COMMON_CLK_MT8192_CAMSYS) += clk-mt8192-cam.o
diff --git a/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
new file mode 100644
index 000000000000..18aee488df69
--- /dev/null
+++ b/drivers/clk/mediatek/clk-mt8186-imp_iic_wrap.c
@@ -0,0 +1,66 @@
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
+static const struct mtk_gate_regs imp_iic_wrap_cg_regs = {
+	.set_ofs = 0xe08,
+	.clr_ofs = 0xe04,
+	.sta_ofs = 0xe00,
+};
+
+#define GATE_IMP_IIC_WRAP(_id, _name, _parent, _shift)			\
+	GATE_MTK(_id, _name, _parent, &imp_iic_wrap_cg_regs, _shift, &mtk_clk_gate_ops_setclr)
+
+static const struct mtk_gate imp_iic_wrap_clks[] = {
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C0,
+		"imp_iic_wrap_ap_clock_i2c0", "infra_ao_i2c_ap", 0),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C1,
+		"imp_iic_wrap_ap_clock_i2c1", "infra_ao_i2c_ap", 1),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C2,
+		"imp_iic_wrap_ap_clock_i2c2", "infra_ao_i2c_ap", 2),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C3,
+		"imp_iic_wrap_ap_clock_i2c3", "infra_ao_i2c_ap", 3),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C4,
+		"imp_iic_wrap_ap_clock_i2c4", "infra_ao_i2c_ap", 4),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C5,
+		"imp_iic_wrap_ap_clock_i2c5", "infra_ao_i2c_ap", 5),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C6,
+		"imp_iic_wrap_ap_clock_i2c6", "infra_ao_i2c_ap", 6),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C7,
+		"imp_iic_wrap_ap_clock_i2c7", "infra_ao_i2c_ap", 7),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C8,
+		"imp_iic_wrap_ap_clock_i2c8", "infra_ao_i2c_ap", 8),
+	GATE_IMP_IIC_WRAP(CLK_IMP_IIC_WRAP_AP_CLOCK_I2C9,
+		"imp_iic_wrap_ap_clock_i2c9", "infra_ao_i2c_ap", 9),
+};
+
+static const struct mtk_clk_desc imp_iic_wrap_desc = {
+	.clks = imp_iic_wrap_clks,
+	.num_clks = ARRAY_SIZE(imp_iic_wrap_clks),
+};
+
+static const struct of_device_id of_match_clk_mt8186_imp_iic_wrap[] = {
+	{
+		.compatible = "mediatek,mt8186-imp_iic_wrap",
+		.data = &imp_iic_wrap_desc,
+	}, {
+		/* sentinel */
+	}
+};
+
+static struct platform_driver clk_mt8186_imp_iic_wrap_drv = {
+	.probe = mtk_clk_simple_probe,
+	.driver = {
+		.name = "clk-mt8186-imp_iic_wrap",
+		.of_match_table = of_match_clk_mt8186_imp_iic_wrap,
+	},
+};
+builtin_platform_driver(clk_mt8186_imp_iic_wrap_drv);
-- 
2.18.0

