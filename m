Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id E2A5A478C42
	for <lists+linux-kernel@lfdr.de>; Fri, 17 Dec 2021 14:25:40 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232789AbhLQNZi (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 17 Dec 2021 08:25:38 -0500
Received: from inva021.nxp.com ([92.121.34.21]:34604 "EHLO inva021.nxp.com"
        rhost-flags-OK-OK-OK-OK) by vger.kernel.org with ESMTP
        id S230037AbhLQNZi (ORCPT <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 17 Dec 2021 08:25:38 -0500
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 8A2E8201CAD;
        Fri, 17 Dec 2021 14:25:36 +0100 (CET)
Received: from inva024.eu-rdc02.nxp.com (inva024.eu-rdc02.nxp.com [134.27.226.22])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 7D896201CA9;
        Fri, 17 Dec 2021 14:25:36 +0100 (CET)
Received: from fsr-ub1664-175.ea.freescale.net (fsr-ub1664-175.ea.freescale.net [10.171.82.40])
        by inva024.eu-rdc02.nxp.com (Postfix) with ESMTP id 62D4F202DB;
        Fri, 17 Dec 2021 14:25:35 +0100 (CET)
From:   Abel Vesa <abel.vesa@nxp.com>
To:     Mike Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>
Cc:     NXP Linux Team <linux-imx@nxp.com>, linux-clk@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Linux Kernel Mailing List <linux-kernel@vger.kernel.org>,
        Jacky Bai <ping.bai@nxp.com>, Abel Vesa <abel.vesa@nxp.com>
Subject: [PATCH v2] clk: imx: Add imx8dxl clk driver
Date:   Fri, 17 Dec 2021 15:25:33 +0200
Message-Id: <1639747533-9778-1-git-send-email-abel.vesa@nxp.com>
X-Mailer: git-send-email 2.7.4
X-Virus-Scanned: ClamAV using ClamSMTP
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Jacky Bai <ping.bai@nxp.com>

Add files for imx8dxl clk driver which is based on imx8qxp clock driver.

Signed-off-by: Jacky Bai <ping.bai@nxp.com>
Signed-off-by: Abel Vesa <abel.vesa@nxp.com>
---

Changes since v1:
 * Moved the dxl compatible and rsrc table to be sorted alphabetically.

 drivers/clk/imx/Makefile           |  3 +-
 drivers/clk/imx/clk-imx8dxl-rsrc.c | 66 ++++++++++++++++++++++++++++++
 drivers/clk/imx/clk-imx8qxp.c      |  1 +
 drivers/clk/imx/clk-scu.h          |  1 +
 4 files changed, 70 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/imx/clk-imx8dxl-rsrc.c

diff --git a/drivers/clk/imx/Makefile b/drivers/clk/imx/Makefile
index b5e040026dfb..f8a44c4ca94a 100644
--- a/drivers/clk/imx/Makefile
+++ b/drivers/clk/imx/Makefile
@@ -28,7 +28,8 @@ obj-$(CONFIG_CLK_IMX8MQ) += clk-imx8mq.o
 
 obj-$(CONFIG_MXC_CLK_SCU) += clk-imx-scu.o clk-imx-lpcg-scu.o
 clk-imx-scu-$(CONFIG_CLK_IMX8QXP) += clk-scu.o clk-imx8qxp.o \
-				     clk-imx8qxp-rsrc.o clk-imx8qm-rsrc.o
+				     clk-imx8qxp-rsrc.o clk-imx8qm-rsrc.o \
+				     clk-imx8dxl-rsrc.o
 clk-imx-lpcg-scu-$(CONFIG_CLK_IMX8QXP) += clk-lpcg-scu.o clk-imx8qxp-lpcg.o
 
 obj-$(CONFIG_CLK_IMX8ULP) += clk-imx8ulp.o
diff --git a/drivers/clk/imx/clk-imx8dxl-rsrc.c b/drivers/clk/imx/clk-imx8dxl-rsrc.c
new file mode 100644
index 000000000000..69b7aa34fff5
--- /dev/null
+++ b/drivers/clk/imx/clk-imx8dxl-rsrc.c
@@ -0,0 +1,66 @@
+// SPDX-License-Identifier: GPL-2.0+
+/*
+ * Copyright 2019~2020 NXP
+ */
+
+#include <dt-bindings/firmware/imx/rsrc.h>
+
+#include "clk-scu.h"
+
+/* Keep sorted in the ascending order */
+static u32 imx8dxl_clk_scu_rsrc_table[] = {
+	IMX_SC_R_SPI_0,
+	IMX_SC_R_SPI_1,
+	IMX_SC_R_SPI_2,
+	IMX_SC_R_SPI_3,
+	IMX_SC_R_UART_0,
+	IMX_SC_R_UART_1,
+	IMX_SC_R_UART_2,
+	IMX_SC_R_UART_3,
+	IMX_SC_R_I2C_0,
+	IMX_SC_R_I2C_1,
+	IMX_SC_R_I2C_2,
+	IMX_SC_R_I2C_3,
+	IMX_SC_R_ADC_0,
+	IMX_SC_R_FTM_0,
+	IMX_SC_R_FTM_1,
+	IMX_SC_R_CAN_0,
+	IMX_SC_R_LCD_0,
+	IMX_SC_R_LCD_0_PWM_0,
+	IMX_SC_R_PWM_0,
+	IMX_SC_R_PWM_1,
+	IMX_SC_R_PWM_2,
+	IMX_SC_R_PWM_3,
+	IMX_SC_R_PWM_4,
+	IMX_SC_R_PWM_5,
+	IMX_SC_R_PWM_6,
+	IMX_SC_R_PWM_7,
+	IMX_SC_R_GPT_0,
+	IMX_SC_R_GPT_1,
+	IMX_SC_R_GPT_2,
+	IMX_SC_R_GPT_3,
+	IMX_SC_R_GPT_4,
+	IMX_SC_R_FSPI_0,
+	IMX_SC_R_FSPI_1,
+	IMX_SC_R_SDHC_0,
+	IMX_SC_R_SDHC_1,
+	IMX_SC_R_SDHC_2,
+	IMX_SC_R_ENET_0,
+	IMX_SC_R_ENET_1,
+	IMX_SC_R_MLB_0,
+	IMX_SC_R_USB_1,
+	IMX_SC_R_NAND,
+	IMX_SC_R_M4_0_I2C,
+	IMX_SC_R_M4_0_UART,
+	IMX_SC_R_ELCDIF_PLL,
+	IMX_SC_R_AUDIO_PLL_0,
+	IMX_SC_R_AUDIO_PLL_1,
+	IMX_SC_R_AUDIO_CLK_0,
+	IMX_SC_R_AUDIO_CLK_1,
+	IMX_SC_R_A35
+};
+
+const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8dxl = {
+	.rsrc = imx8dxl_clk_scu_rsrc_table,
+	.num = ARRAY_SIZE(imx8dxl_clk_scu_rsrc_table),
+};
diff --git a/drivers/clk/imx/clk-imx8qxp.c b/drivers/clk/imx/clk-imx8qxp.c
index 40a2efb1329b..546a3703bfeb 100644
--- a/drivers/clk/imx/clk-imx8qxp.c
+++ b/drivers/clk/imx/clk-imx8qxp.c
@@ -295,6 +295,7 @@ static int imx8qxp_clk_probe(struct platform_device *pdev)
 
 static const struct of_device_id imx8qxp_match[] = {
 	{ .compatible = "fsl,scu-clk", },
+	{ .compatible = "fsl,imx8dxl-clk", &imx_clk_scu_rsrc_imx8dxl, },
 	{ .compatible = "fsl,imx8qxp-clk", &imx_clk_scu_rsrc_imx8qxp, },
 	{ .compatible = "fsl,imx8qm-clk", &imx_clk_scu_rsrc_imx8qm, },
 	{ /* sentinel */ }
diff --git a/drivers/clk/imx/clk-scu.h b/drivers/clk/imx/clk-scu.h
index 22156e93b85d..af7b697f51ca 100644
--- a/drivers/clk/imx/clk-scu.h
+++ b/drivers/clk/imx/clk-scu.h
@@ -21,6 +21,7 @@ struct imx_clk_scu_rsrc_table {
 
 extern struct list_head imx_scu_clks[];
 extern const struct dev_pm_ops imx_clk_lpcg_scu_pm_ops;
+extern const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8dxl;
 extern const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8qxp;
 extern const struct imx_clk_scu_rsrc_table imx_clk_scu_rsrc_imx8qm;
 
-- 
2.31.1

