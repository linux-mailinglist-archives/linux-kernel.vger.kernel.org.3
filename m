Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5E91149F859
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 12:33:01 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236690AbiA1Lc4 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 06:32:56 -0500
Received: from mail-sz.amlogic.com ([211.162.65.117]:19633 "EHLO
        mail-sz.amlogic.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S235979AbiA1Lcm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 06:32:42 -0500
Received: from droid11-sz.amlogic.com (10.28.8.21) by mail-sz.amlogic.com
 (10.28.11.5) with Microsoft SMTP Server id 15.1.2176.2; Fri, 28 Jan 2022
 19:32:41 +0800
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
Subject: [PATCH v2 1/2] mtd: rawnand: meson: discard the common MMC sub clock framework
Date:   Fri, 28 Jan 2022 19:32:36 +0800
Message-ID: <20220128113237.39996-2-liang.yang@amlogic.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220128113237.39996-1-liang.yang@amlogic.com>
References: <20220128113237.39996-1-liang.yang@amlogic.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 7BIT
Content-Type:   text/plain; charset=US-ASCII
X-Originating-IP: [10.28.8.21]
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

EMMC and NAND has the same clock control register named 'SD_EMMC_CLOCK' which is
defined in EMMC port internally. bit0~5 of 'SD_EMMC_CLOCK' is the divider and
bit6~7 is the mux for fix pll and xtal.
Previously a common MMC sub clock framework is implemented and shared by EMMC and
NAND, but that is coupling the EMMC and NAND, although EMMC and NAND is mutually
exclusive.

Change-Id: Ibeb4c7ff886f5886aac4d6c664d7bbd1b1bcb997
Signed-off-by: Liang Yang <liang.yang@amlogic.com>
---
 drivers/mtd/nand/raw/meson_nand.c | 161 +++++++++++++++++-------------
 1 file changed, 89 insertions(+), 72 deletions(-)

diff --git a/drivers/mtd/nand/raw/meson_nand.c b/drivers/mtd/nand/raw/meson_nand.c
index ac3be92872d0..f6a3d5c2ea1c 100644
--- a/drivers/mtd/nand/raw/meson_nand.c
+++ b/drivers/mtd/nand/raw/meson_nand.c
@@ -2,7 +2,7 @@
 /*
  * Amlogic Meson Nand Flash Controller Driver
  *
- * Copyright (c) 2018 Amlogic, inc.
+ * Copyright (c) 2018-2021 Amlogic, inc.
  * Author: Liang Yang <liang.yang@amlogic.com>
  */
 
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
@@ -151,15 +156,17 @@ struct meson_nfc {
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
-	void __iomem *reg_base;
-	struct regmap *reg_clk;
+	struct {
+		void __iomem *reg_base;
+		void __iomem *sd_emmc_clock;
+	} res;
 	struct completion completion;
 	struct list_head chips;
 	const struct meson_nfc_data *data;
@@ -244,8 +251,8 @@ static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
 	}
 	if (nfc->bus_timing != meson_chip->bus_timing) {
 		value = (NFC_CLK_CYCLE - 1) | (meson_chip->bus_timing << 5);
-		writel(value, nfc->reg_base + NFC_REG_CFG);
-		writel((1 << 31), nfc->reg_base + NFC_REG_CMD);
+		writel(value, nfc->res.reg_base + NFC_REG_CFG);
+		writel((1 << 31), nfc->res.reg_base + NFC_REG_CMD);
 		nfc->bus_timing =  meson_chip->bus_timing;
 	}
 }
@@ -253,13 +260,13 @@ static void meson_nfc_select_chip(struct nand_chip *nand, int chip)
 static void meson_nfc_cmd_idle(struct meson_nfc *nfc, u32 time)
 {
 	writel(nfc->param.chip_select | NFC_CMD_IDLE | (time & 0x3ff),
-	       nfc->reg_base + NFC_REG_CMD);
+	       nfc->res.reg_base + NFC_REG_CMD);
 }
 
 static void meson_nfc_cmd_seed(struct meson_nfc *nfc, u32 seed)
 {
 	writel(NFC_CMD_SEED | (0xc2 + (seed & 0x7fff)),
-	       nfc->reg_base + NFC_REG_CMD);
+	       nfc->res.reg_base + NFC_REG_CMD);
 }
 
 static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
@@ -276,7 +283,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
 	if (raw) {
 		len = mtd->writesize + mtd->oobsize;
 		cmd = (len & GENMASK(5, 0)) | scrambler | DMA_DIR(dir);
-		writel(cmd, nfc->reg_base + NFC_REG_CMD);
+		writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 		return;
 	}
 
@@ -285,7 +292,7 @@ static void meson_nfc_cmd_access(struct nand_chip *nand, int raw, bool dir,
 	cmd = CMDRWGEN(DMA_DIR(dir), scrambler, bch,
 		       NFC_CMD_SHORTMODE_DISABLE, pagesize, pages);
 
-	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+	writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 }
 
 static void meson_nfc_drain_cmd(struct meson_nfc *nfc)
@@ -312,7 +319,7 @@ static int meson_nfc_wait_cmd_finish(struct meson_nfc *nfc,
 	int ret;
 
 	/* wait cmd fifo is empty */
-	ret = readl_relaxed_poll_timeout(nfc->reg_base + NFC_REG_CMD, cmd_size,
+	ret = readl_relaxed_poll_timeout(nfc->res.reg_base + NFC_REG_CMD, cmd_size,
 					 !NFC_CMD_GET_SIZE(cmd_size),
 					 10, timeout_ms * 1000);
 	if (ret)
@@ -396,16 +403,16 @@ static int meson_nfc_queue_rb(struct meson_nfc *nfc, int timeout_ms)
 	meson_nfc_drain_cmd(nfc);
 	meson_nfc_wait_cmd_finish(nfc, CMD_FIFO_EMPTY_TIMEOUT);
 
-	cfg = readl(nfc->reg_base + NFC_REG_CFG);
+	cfg = readl(nfc->res.reg_base + NFC_REG_CFG);
 	cfg |= NFC_RB_IRQ_EN;
-	writel(cfg, nfc->reg_base + NFC_REG_CFG);
+	writel(cfg, nfc->res.reg_base + NFC_REG_CFG);
 
 	reinit_completion(&nfc->completion);
 
 	/* use the max erase time as the maximum clock for waiting R/B */
 	cmd = NFC_CMD_RB | NFC_CMD_RB_INT
 		| nfc->param.chip_select | nfc->timing.tbers_max;
-	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+	writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 
 	ret = wait_for_completion_timeout(&nfc->completion,
 					  msecs_to_jiffies(timeout_ms));
@@ -485,10 +492,10 @@ static int meson_nfc_dma_buffer_setup(struct nand_chip *nand, void *databuf,
 		return ret;
 	}
 	cmd = GENCMDDADDRL(NFC_CMD_ADL, nfc->daddr);
-	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+	writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 
 	cmd = GENCMDDADDRH(NFC_CMD_ADH, nfc->daddr);
-	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+	writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 
 	if (infobuf) {
 		nfc->iaddr = dma_map_single(nfc->dev, infobuf, infolen, dir);
@@ -500,10 +507,10 @@ static int meson_nfc_dma_buffer_setup(struct nand_chip *nand, void *databuf,
 			return ret;
 		}
 		cmd = GENCMDIADDRL(NFC_CMD_AIL, nfc->iaddr);
-		writel(cmd, nfc->reg_base + NFC_REG_CMD);
+		writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 
 		cmd = GENCMDIADDRH(NFC_CMD_AIH, nfc->iaddr);
-		writel(cmd, nfc->reg_base + NFC_REG_CMD);
+		writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 	}
 
 	return ret;
@@ -537,7 +544,7 @@ static int meson_nfc_read_buf(struct nand_chip *nand, u8 *buf, int len)
 		goto out;
 
 	cmd = NFC_CMD_N2M | (len & GENMASK(5, 0));
-	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+	writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 
 	meson_nfc_drain_cmd(nfc);
 	meson_nfc_wait_cmd_finish(nfc, 1000);
@@ -561,7 +568,7 @@ static int meson_nfc_write_buf(struct nand_chip *nand, u8 *buf, int len)
 		return ret;
 
 	cmd = NFC_CMD_M2N | (len & GENMASK(5, 0));
-	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+	writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 
 	meson_nfc_drain_cmd(nfc);
 	meson_nfc_wait_cmd_finish(nfc, 1000);
@@ -610,11 +617,11 @@ static int meson_nfc_rw_cmd_prepare_and_execute(struct nand_chip *nand,
 
 	for (i = 0; i < cmd_num; i++)
 		writel_relaxed(nfc->cmdfifo.cmd[i],
-			       nfc->reg_base + NFC_REG_CMD);
+			       nfc->res.reg_base + NFC_REG_CMD);
 
 	if (in) {
 		nfc->cmdfifo.rw.cmd1 = cs | NFC_CMD_CLE | NAND_CMD_READSTART;
-		writel(nfc->cmdfifo.rw.cmd1, nfc->reg_base + NFC_REG_CMD);
+		writel(nfc->cmdfifo.rw.cmd1, nfc->res.reg_base + NFC_REG_CMD);
 		meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tR_max));
 	} else {
 		meson_nfc_cmd_idle(nfc, nfc->timing.tadl);
@@ -660,7 +667,7 @@ static int meson_nfc_write_page_sub(struct nand_chip *nand,
 	}
 
 	cmd = nfc->param.chip_select | NFC_CMD_CLE | NAND_CMD_PAGEPROG;
-	writel(cmd, nfc->reg_base + NFC_REG_CMD);
+	writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 	meson_nfc_queue_rb(nfc, PSEC_TO_MSEC(sdr->tPROG_max));
 
 	meson_nfc_dma_buffer_release(nand, data_len, info_len, DMA_TO_DEVICE);
@@ -912,7 +919,7 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
 		case NAND_OP_CMD_INSTR:
 			cmd = nfc->param.chip_select | NFC_CMD_CLE;
 			cmd |= instr->ctx.cmd.opcode & 0xff;
-			writel(cmd, nfc->reg_base + NFC_REG_CMD);
+			writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 			meson_nfc_cmd_idle(nfc, delay_idle);
 			break;
 
@@ -920,7 +927,7 @@ static int meson_nfc_exec_op(struct nand_chip *nand,
 			for (i = 0; i < instr->ctx.addr.naddrs; i++) {
 				cmd = nfc->param.chip_select | NFC_CMD_ALE;
 				cmd |= instr->ctx.addr.addrs[i] & 0xff;
-				writel(cmd, nfc->reg_base + NFC_REG_CMD);
+				writel(cmd, nfc->res.reg_base + NFC_REG_CMD);
 			}
 			meson_nfc_cmd_idle(nfc, delay_idle);
 			break;
@@ -988,6 +995,8 @@ static const struct mtd_ooblayout_ops meson_ooblayout_ops = {
 static int meson_nfc_clk_init(struct meson_nfc *nfc)
 {
 	int ret;
+	struct clk_init_data init = {0};
+	struct clk_parent_data nfc_divider_parent_data[1];
 
 	/* request core clock */
 	nfc->core_clk = devm_clk_get(nfc->dev, "core");
@@ -1002,21 +1011,26 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
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
+	nfc_divider_parent_data[0].fw_name = __clk_get_name(nfc->device_clk);
+	init.parent_data = nfc_divider_parent_data;
+	init.num_parents = 1;
+	nfc->nand_divider.reg = nfc->res.sd_emmc_clock;
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
+	writel(CLK_SELECT_NAND | readl(nfc->res.sd_emmc_clock),
+	       nfc->res.sd_emmc_clock);
 
 	ret = clk_prepare_enable(nfc->core_clk);
 	if (ret) {
@@ -1030,29 +1044,21 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
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
 
 	ret = clk_set_rate(nfc->device_clk, 24000000);
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
@@ -1061,8 +1067,7 @@ static int meson_nfc_clk_init(struct meson_nfc *nfc)
 
 static void meson_nfc_disable_clk(struct meson_nfc *nfc)
 {
-	clk_disable_unprepare(nfc->phase_rx);
-	clk_disable_unprepare(nfc->phase_tx);
+	clk_disable_unprepare(nfc->nand_clk);
 	clk_disable_unprepare(nfc->device_clk);
 	clk_disable_unprepare(nfc->core_clk);
 }
@@ -1339,12 +1344,12 @@ static irqreturn_t meson_nfc_irq(int irq, void *id)
 	struct meson_nfc *nfc = id;
 	u32 cfg;
 
-	cfg = readl(nfc->reg_base + NFC_REG_CFG);
+	cfg = readl(nfc->res.reg_base + NFC_REG_CFG);
 	if (!(cfg & NFC_RB_IRQ_EN))
 		return IRQ_NONE;
 
 	cfg &= ~(NFC_RB_IRQ_EN);
-	writel(cfg, nfc->reg_base + NFC_REG_CFG);
+	writel(cfg, nfc->res.reg_base + NFC_REG_CFG);
 
 	complete(&nfc->completion);
 	return IRQ_HANDLED;
@@ -1370,11 +1375,31 @@ static const struct of_device_id meson_nfc_id_table[] = {
 };
 MODULE_DEVICE_TABLE(of, meson_nfc_id_table);
 
+static int meson_nfc_reg_resource(struct device *dev, struct meson_nfc *nfc)
+{
+	struct resource res;
+	void __iomem *base[2];
+	struct device_node *node = dev->of_node;
+	int i;
+
+	for (i = 0; i < 2; i++) {
+		if (of_address_to_resource(node, i, &res))
+			return -ENOENT;
+
+		base[i] = devm_ioremap_resource(dev, &res);
+		if (IS_ERR(base))
+			return PTR_ERR(base);
+	}
+	nfc->res.reg_base = base[0];
+	nfc->res.sd_emmc_clock = base[1];
+
+	return 0;
+}
+
 static int meson_nfc_probe(struct platform_device *pdev)
 {
 	struct device *dev = &pdev->dev;
 	struct meson_nfc *nfc;
-	struct resource *res;
 	int ret, irq;
 
 	nfc = devm_kzalloc(dev, sizeof(*nfc), GFP_KERNEL);
@@ -1388,20 +1413,12 @@ static int meson_nfc_probe(struct platform_device *pdev)
 	nand_controller_init(&nfc->controller);
 	INIT_LIST_HEAD(&nfc->chips);
 	init_completion(&nfc->completion);
-
 	nfc->dev = dev;
 
-	res = platform_get_resource(pdev, IORESOURCE_MEM, 0);
-	nfc->reg_base = devm_ioremap_resource(dev, res);
-	if (IS_ERR(nfc->reg_base))
-		return PTR_ERR(nfc->reg_base);
-
-	nfc->reg_clk =
-		syscon_regmap_lookup_by_phandle(dev->of_node,
-						"amlogic,mmc-syscon");
-	if (IS_ERR(nfc->reg_clk)) {
-		dev_err(dev, "Failed to lookup clock base\n");
-		return PTR_ERR(nfc->reg_clk);
+	ret = meson_nfc_reg_resource(dev, nfc);
+	if (ret) {
+		dev_err(dev, "Failed to get reg resource\n");
+		return ret;
 	}
 
 	irq = platform_get_irq(pdev, 0);
@@ -1414,7 +1431,7 @@ static int meson_nfc_probe(struct platform_device *pdev)
 		return ret;
 	}
 
-	writel(0, nfc->reg_base + NFC_REG_CFG);
+	writel(0, nfc->res.reg_base + NFC_REG_CFG);
 	ret = devm_request_irq(dev, irq, meson_nfc_irq, 0, dev_name(dev), nfc);
 	if (ret) {
 		dev_err(dev, "failed to request NFC IRQ\n");
-- 
2.34.1

