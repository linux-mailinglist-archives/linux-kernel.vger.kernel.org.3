Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7CD9F4DD9E4
	for <lists+linux-kernel@lfdr.de>; Fri, 18 Mar 2022 13:42:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236376AbiCRMnN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 18 Mar 2022 08:43:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:38182 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236387AbiCRMmt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 18 Mar 2022 08:42:49 -0400
Received: from mail-sz.amlogic.com (mail-sz.amlogic.com [211.162.65.117])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4D4F92E35A0;
        Fri, 18 Mar 2022 05:41:30 -0700 (PDT)
Received: from droid11-sz.amlogic.com (10.28.8.21) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Fri, 18 Mar 2022
 20:41:29 +0800
From:   Liang Yang <liang.yang@amlogic.com>
To:     Miquel Raynal <miquel.raynal@bootlin.com>,
        <linux-mtd@lists.infradead.org>
CC:     Liang Yang <liang.yang@amlogic.com>,
        Rob Herring <robh+dt@kernel.org>,
        Richard Weinberger <richard@nod.at>,
        Vignesh Raghavendra <vigneshr@ti.com>,
        Jerome Brunet <jbrunet@baylibre.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Martin Blumenstingl <martin.blumenstingl@googlemail.com>,
        Kevin Hilman <khilman@baylibre.com>,
        Jianxin Pan <jianxin.pan@amlogic.com>,
        Victor Wan <victor.wan@amlogic.com>,
        XianWei Zhao <xianwei.zhao@amlogic.com>,
        Kelvin Zhang <kelvin.zhang@amlogic.com>,
        BiChao Zheng <bichao.zheng@amlogic.com>,
        YongHui Yu <yonghui.yu@amlogic.com>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-amlogic@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, <devicetree@vger.kernel.org>
Subject: [PATCH v3 1/2] mtd: rawnand: meson: discard the common MMC sub clock framework
Date:   Fri, 18 Mar 2022 20:41:19 +0800
Message-ID: <20220318124121.26117-2-liang.yang@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220318124121.26117-1-liang.yang@amlogic.com>
References: <20220318124121.26117-1-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.21]
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EMMC and NAND have the same clock control register named 'SD_EMMC_CLOCK' which is
defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is the divider and
bit6~7 is the mux for fix pll and xtal.A common MMC and NAND sub-clock has been
implemented and can be used by the eMMC and NAND controller (which are mutually
exclusive anyway). Let's use this new clock.

Signed-off-by: Liang Yang <liang.yang@amlogic.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 101 ++++++++++++++++--------------
 1 file changed, 53 insertions(+), 48 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index ac3be92872d0..257ffc8a41ab 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -10,6 +10,7 @@
 #include <linux/dma-mapping.h>
 #include <linux/interrupt.h>
 #include <linux/clk.h>
+#include <linux/clk-provider.h>
 #include <linux/mtd/rawnand.h>
 #include <linux/mtd/mtd.h>
 #include <linux/mfd/syscon.h>
@@ -19,6 +20,7 @@
 #include <linux/iopoll.h>
 #include <linux/of.h>
 #include <linux/of_device.h>
+#include <linux/of_address.h>
 #include <linux/sched/task_stack.h>
 
 #define NFC_REG_CMD		0x00
@@ -104,6 +106,9 @@
 
 #define PER_INFO_BYTE		8
 
+#define CLK_DIV_SHIFT		0
+#define CLK_DIV_WIDTH		6
+
 struct meson_nfc_nand_chip {
 	struct list_head node;
 	struct nand_chip nand;
@@ -151,15 +156,15 @@ struct meson_nfc {
 	struct nand_controller controller;
 	struct clk *core_clk;
 	struct clk *device_clk;
-	struct clk *phase_tx;
-	struct clk *phase_rx;
+	struct clk *nand_clk;
+	struct clk_divider nand_divider;
 
 	unsigned long clk_rate;
 	u32 bus_timing;
 
 	struct device *dev;
 	void __iomem *reg_base;
-	struct regmap *reg_clk;
+	void __iomem *sd_emmc_clock;
 	struct completion completion;
 	struct list_head chips;
 	const struct meson_nfc_data *data;
@@ -235,7 +240,7 @@ static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
 	nfc->timing.tbers_max = meson_chip->tbers_max;
 
 	if (nfc->clk_rate != meson_chip->clk_rate) {
-		ret = clk_set_rate(nfc->device_clk, meson_chip->clk_rate);
+		ret = clk_set_rate(nfc->nand_clk, meson_chip->clk_rate);
 		if (ret) {
 			dev_err(nfc->dev, "failed to set clock rate\n");
 			return;
@@ -406,7 +411,6 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
 	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
 		| nfc->param.chip_select | nfc->timing.tbers_max;
 	writel(cmd, nfc->reg_base + NFC_REG_CMD);
-
 	ret = wait_for_completion_timeout(&nfc->completion,
 					  msecs_to_jiffies(timeout_ms));
 	if (ret == 0)
@@ -985,9 +989,11 @@ static const struct mtd_ooblayout_ops meson_ooblayout_ops = {
 	.free = meson_ooblayout_free,
 };
 
+struct clk_parent_data nfc_divider_parent_data[1];
 static int meson_nfc_clk_init(struct meson_nfc *nfc)
 {
 	int ret;
+	struct clk_init_data init = {0};
 
 	/* request core clock */
 	nfc->core_clk = devm_clk_get(nfc->dev, "core");
@@ -1002,21 +1008,26 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
 		return PTR_ERR(nfc->device_clk);
 	}
 
-	nfc->phase_tx = devm_clk_get(nfc->dev, "tx");
-	if (IS_ERR(nfc->phase_tx)) {
-		dev_err(nfc->dev, "failed to get TX clk\n");
-		return PTR_ERR(nfc->phase_tx);
-	}
-
-	nfc->phase_rx = devm_clk_get(nfc->dev, "rx");
-	if (IS_ERR(nfc->phase_rx)) {
-		dev_err(nfc->dev, "failed to get RX clk\n");
-		return PTR_ERR(nfc->phase_rx);
-	}
+	init.name = devm_kstrdup(nfc->dev, "nfc#div", GFP_KERNEL);
+	init.ops = &clk_divider_ops;
+	nfc_divider_parent_data[0].fw_name = "device";
+	init.parent_data = nfc_divider_parent_data;
+	init.num_parents = 1;
+	nfc->nand_divider.reg = nfc->sd_emmc_clock;
+	nfc->nand_divider.shift = CLK_DIV_SHIFT;
+	nfc->nand_divider.width = CLK_DIV_WIDTH;
+	nfc->nand_divider.hw.init = &init;
+	nfc->nand_divider.flags = CLK_DIVIDER_ONE_BASED |
+				  CLK_DIVIDER_ROUND_CLOSEST |
+				  CLK_DIVIDER_ALLOW_ZERO;
+
+	nfc->nand_clk = devm_clk_register(nfc->dev, &nfc->nand_divider.hw);
+	if (IS_ERR(nfc->nand_clk))
+		return PTR_ERR(nfc->nand_clk);
 
 	/* init SD_EMMC_CLOCK to sane defaults w/min clock rate */
-	regmap_update_bits(nfc->reg_clk,
-			   0, CLK_SELECT_NAND, CLK_SELECT_NAND);
+	writel(CLK_SELECT_NAND | readl(nfc->sd_emmc_clock),
+	       nfc->sd_emmc_clock);
 
 	ret = clk_prepare_enable(nfc->core_clk);
 	if (ret) {
@@ -1030,29 +1041,21 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
 		goto err_device_clk;
 	}
 
-	ret = clk_prepare_enable(nfc->phase_tx);
-	if (ret) {
-		dev_err(nfc->dev, "failed to enable TX clock\n");
-		goto err_phase_tx;
-	}
-
-	ret = clk_prepare_enable(nfc->phase_rx);
+	ret = clk_prepare_enable(nfc->nand_clk);
 	if (ret) {
-		dev_err(nfc->dev, "failed to enable RX clock\n");
-		goto err_phase_rx;
+		dev_err(nfc->dev, "pre enable NFC divider fail\n");
+		goto err_nand_clk;
 	}
 
-	ret = clk_set_rate(nfc->device_clk, 24000000);
+	ret = clk_set_rate(nfc->nand_clk, 24000000);
 	if (ret)
-		goto err_disable_rx;
+		goto err_disable_clk;
 
 	return 0;
 
-err_disable_rx:
-	clk_disable_unprepare(nfc->phase_rx);
-err_phase_rx:
-	clk_disable_unprepare(nfc->phase_tx);
-err_phase_tx:
+err_disable_clk:
+	clk_disable_unprepare(nfc->nand_clk);
+err_nand_clk:
 	clk_disable_unprepare(nfc->device_clk);
 err_device_clk:
 	clk_disable_unprepare(nfc->core_clk);
@@ -1061,8 +1064,7 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
 
 static void meson_nfc_disable_clk(struct meson_nfc *nfc)
 {
-	clk_disable_unprepare(nfc->phase_rx);
-	clk_disable_unprepare(nfc->phase_tx);
+	clk_disable_unprepare(nfc->nand_clk);
 	clk_disable_unprepare(nfc->device_clk);
 	clk_disable_unprepare(nfc->core_clk);
 }
@@ -1373,9 +1375,10 @@ MODULE_DEVICE_TABLE(of, meson_nfc_id_table);
 static int meson_nfc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
+	struct device_node *node = dev->of_node;
 	struct meson_nfc *nfc;
-	struct resource *res;
-	int ret, irq;
+	struct resource res;
+	int ret, irq, i;
 
 	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
 	if (!nfc)
@@ -1388,21 +1391,23 @@ static int meson_nfc_probe(struct platform_device *pdev)
 	nand_controller_init(&nfc->controller);
 	INIT_LIST_HEAD(&nfc->chips);
 	init_completion(&nfc->completion);
-
 	nfc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nfc->reg_base = devm_ioremap_resource(dev, res);
+	i = of_property_match_string(node, "reg-names", "nfc");
+	if (of_address_to_resource(node, i, &res))
+		return -ENOENT;
+
+	nfc->reg_base = devm_ioremap_resource(dev, &res);
 	if (IS_ERR(nfc->reg_base))
 		return PTR_ERR(nfc->reg_base);
 
-	nfc->reg_clk =
-		syscon_regmap_lookup_by_phandle(dev->of_node,
-						"amlogic,mmc-syscon");
-	if (IS_ERR(nfc->reg_clk)) {
-		dev_err(dev, "Failed to lookup clock base\n");
-		return PTR_ERR(nfc->reg_clk);
-	}
+	i = of_property_match_string(node, "reg-names", "emmc");
+	if (of_address_to_resource(node, i, &res))
+		return -ENOENT;
+
+	nfc->sd_emmc_clock = devm_ioremap_resource(dev, &res);
+	if (IS_ERR(nfc->sd_emmc_clock))
+		return PTR_ERR(nfc->sd_emmc_clock);
 
 	irq = platform_get_irq(pdev, 0);
 	if (irq < 0)
-- 
2.34.1

