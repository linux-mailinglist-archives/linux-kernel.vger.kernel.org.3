Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D8A51477C34
	for <lists+linux-kernel@lfdr.de>; Thu, 16 Dec 2021 20:08:24 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240874AbhLPTIU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 16 Dec 2021 14:08:20 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54362 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231410AbhLPTIP (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 16 Dec 2021 14:08:15 -0500
Received: from dfw.source.kernel.org (dfw.source.kernel.org [IPv6:2604:1380:4641:c500::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 429DAC061574
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 11:08:15 -0800 (PST)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id BA5C761F51
        for <linux-kernel@vger.kernel.org>; Thu, 16 Dec 2021 19:08:14 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 5D343C36AE8;
        Thu, 16 Dec 2021 19:08:14 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1639681694;
        bh=TXByNG5bVJxbbmq5kHD/+vWnm1K9KH4oCNRD0NyrMXY=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=YLf1AUhs842zCj3iVpj2tzVSswWKHqQJqqC0PnImo7fGI4EpKc/VoATax3R8+mNaR
         kZu+W0AtbpfWuC+yxjzZS+y38yJucTIjlauot08MZhpOx67OQRpkbIlgrKxws/Z1kV
         KqbFfj9VZlASRAxXHaEBHhZ5KibiLtIlwzG2YK2qaiuUDgswiLstsihsnDsi6cHxLs
         mvtfLys0UFD+xX8Jk6tJAEbzk3NWWWw9AgfFEb/VbxNpf2Zy3YxT0bjPNg5HzkmNy7
         WpV2nGsfcAMq0i9H0oJBF8/rEb3lV7Z3FGDMi64HX+x/lZcdVplUADhRjHNrDznT13
         ptYKFynrlSrBg==
From:   Stephen Boyd <sboyd@kernel.org>
To:     Greg Kroah-Hartman <gregkh@linuxfoundation.org>
Cc:     James Lo <james.lo@mediatek.com>, linux-kernel@vger.kernel.org,
        Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
Subject: [PATCH 4/6] spmi: mediatek: Add support for MT6873/8192
Date:   Thu, 16 Dec 2021 11:08:10 -0800
Message-Id: <20211216190812.1574801-5-sboyd@kernel.org>
X-Mailer: git-send-email 2.34.1.173.g76aa8bc2d0-goog
In-Reply-To: <20211216190812.1574801-1-sboyd@kernel.org>
References: <20211216190812.1574801-1-sboyd@kernel.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: James Lo <james.lo@mediatek.com>

Add spmi support for MT6873/8192.
Refine indent in spmi-mtk-pmif.c.

Signed-off-by: James Lo <james.lo@mediatek.com>
Signed-off-by: Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>
Acked-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
Link: https://lore.kernel.org/r/20211119034613.32489-4-james.lo@mediatek.com
Signed-off-by: Stephen Boyd <sboyd@kernel.org>
---
 drivers/spmi/Kconfig         |  11 +
 drivers/spmi/Makefile        |   1 +
 drivers/spmi/spmi-mtk-pmif.c | 454 +++++++++++++++++++++++++++++++++++
 3 files changed, 466 insertions(+)
 create mode 100644 drivers/spmi/spmi-mtk-pmif.c

diff --git a/drivers/spmi/Kconfig b/drivers/spmi/Kconfig
index 2874b6c26028..737802046314 100644
--- a/drivers/spmi/Kconfig
+++ b/drivers/spmi/Kconfig
@@ -34,4 +34,15 @@ config SPMI_MSM_PMIC_ARB
 	  This is required for communicating with Qualcomm PMICs and
 	  other devices that have the SPMI interface.
 
+config SPMI_MTK_PMIF
+	tristate "Mediatek SPMI Controller (PMIC Arbiter)"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	help
+	  If you say yes to this option, support will be included for the
+	  built-in SPMI PMIC Arbiter interface on Mediatek family
+	  processors.
+
+	  This is required for communicating with Mediatek PMICs and
+	  other devices that have the SPMI interface.
+
 endif
diff --git a/drivers/spmi/Makefile b/drivers/spmi/Makefile
index 6e092e6f290c..9d974424c8c1 100644
--- a/drivers/spmi/Makefile
+++ b/drivers/spmi/Makefile
@@ -6,3 +6,4 @@ obj-$(CONFIG_SPMI)	+= spmi.o
 
 obj-$(CONFIG_SPMI_HISI3670)	+= hisi-spmi-controller.o
 obj-$(CONFIG_SPMI_MSM_PMIC_ARB)	+= spmi-pmic-arb.o
+obj-$(CONFIG_SPMI_MTK_PMIF)	+= spmi-mtk-pmif.o
diff --git a/drivers/spmi/spmi-mtk-pmif.c b/drivers/spmi/spmi-mtk-pmif.c
new file mode 100644
index 000000000000..f6644104088d
--- /dev/null
+++ b/drivers/spmi/spmi-mtk-pmif.c
@@ -0,0 +1,454 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2021 MediaTek Inc.
+
+#include <linux/clk.h>
+#include <linux/iopoll.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/property.h>
+#include <linux/spmi.h>
+
+#define SWINF_IDLE	0x00
+#define SWINF_WFVLDCLR	0x06
+
+#define GET_SWINF(x)	(((x) >> 1) & 0x7)
+
+#define PMIF_CMD_REG_0		0
+#define PMIF_CMD_REG		1
+#define PMIF_CMD_EXT_REG	2
+#define PMIF_CMD_EXT_REG_LONG	3
+
+#define PMIF_DELAY_US   10
+#define PMIF_TIMEOUT_US (10 * 1000)
+
+#define PMIF_CHAN_OFFSET 0x5
+
+#define PMIF_MAX_CLKS	3
+
+#define SPMI_OP_ST_BUSY 1
+
+struct ch_reg {
+	u32 ch_sta;
+	u32 wdata;
+	u32 rdata;
+	u32 ch_send;
+	u32 ch_rdy;
+};
+
+struct pmif_data {
+	const u32	*regs;
+	const u32	*spmimst_regs;
+	u32	soc_chan;
+};
+
+struct pmif {
+	void __iomem	*base;
+	void __iomem	*spmimst_base;
+	struct ch_reg	chan;
+	struct clk_bulk_data clks[PMIF_MAX_CLKS];
+	size_t nclks;
+	const struct pmif_data *data;
+};
+
+static const char * const pmif_clock_names[] = {
+	"pmif_sys_ck", "pmif_tmr_ck", "spmimst_clk_mux",
+};
+
+enum pmif_regs {
+	PMIF_INIT_DONE,
+	PMIF_INF_EN,
+	PMIF_ARB_EN,
+	PMIF_CMDISSUE_EN,
+	PMIF_TIMER_CTRL,
+	PMIF_SPI_MODE_CTRL,
+	PMIF_IRQ_EVENT_EN_0,
+	PMIF_IRQ_FLAG_0,
+	PMIF_IRQ_CLR_0,
+	PMIF_IRQ_EVENT_EN_1,
+	PMIF_IRQ_FLAG_1,
+	PMIF_IRQ_CLR_1,
+	PMIF_IRQ_EVENT_EN_2,
+	PMIF_IRQ_FLAG_2,
+	PMIF_IRQ_CLR_2,
+	PMIF_IRQ_EVENT_EN_3,
+	PMIF_IRQ_FLAG_3,
+	PMIF_IRQ_CLR_3,
+	PMIF_IRQ_EVENT_EN_4,
+	PMIF_IRQ_FLAG_4,
+	PMIF_IRQ_CLR_4,
+	PMIF_WDT_EVENT_EN_0,
+	PMIF_WDT_FLAG_0,
+	PMIF_WDT_EVENT_EN_1,
+	PMIF_WDT_FLAG_1,
+	PMIF_SWINF_0_STA,
+	PMIF_SWINF_0_WDATA_31_0,
+	PMIF_SWINF_0_RDATA_31_0,
+	PMIF_SWINF_0_ACC,
+	PMIF_SWINF_0_VLD_CLR,
+	PMIF_SWINF_1_STA,
+	PMIF_SWINF_1_WDATA_31_0,
+	PMIF_SWINF_1_RDATA_31_0,
+	PMIF_SWINF_1_ACC,
+	PMIF_SWINF_1_VLD_CLR,
+	PMIF_SWINF_2_STA,
+	PMIF_SWINF_2_WDATA_31_0,
+	PMIF_SWINF_2_RDATA_31_0,
+	PMIF_SWINF_2_ACC,
+	PMIF_SWINF_2_VLD_CLR,
+	PMIF_SWINF_3_STA,
+	PMIF_SWINF_3_WDATA_31_0,
+	PMIF_SWINF_3_RDATA_31_0,
+	PMIF_SWINF_3_ACC,
+	PMIF_SWINF_3_VLD_CLR,
+};
+
+static const u32 mt6873_regs[] = {
+	[PMIF_INIT_DONE] = 0x0000,
+	[PMIF_INF_EN] = 0x0024,
+	[PMIF_ARB_EN] = 0x0150,
+	[PMIF_CMDISSUE_EN] = 0x03B4,
+	[PMIF_TIMER_CTRL] = 0x03E0,
+	[PMIF_SPI_MODE_CTRL] = 0x0400,
+	[PMIF_IRQ_EVENT_EN_0] = 0x0418,
+	[PMIF_IRQ_FLAG_0] = 0x0420,
+	[PMIF_IRQ_CLR_0] = 0x0424,
+	[PMIF_IRQ_EVENT_EN_1] = 0x0428,
+	[PMIF_IRQ_FLAG_1] = 0x0430,
+	[PMIF_IRQ_CLR_1] = 0x0434,
+	[PMIF_IRQ_EVENT_EN_2] = 0x0438,
+	[PMIF_IRQ_FLAG_2] = 0x0440,
+	[PMIF_IRQ_CLR_2] = 0x0444,
+	[PMIF_IRQ_EVENT_EN_3] = 0x0448,
+	[PMIF_IRQ_FLAG_3] = 0x0450,
+	[PMIF_IRQ_CLR_3] = 0x0454,
+	[PMIF_IRQ_EVENT_EN_4] = 0x0458,
+	[PMIF_IRQ_FLAG_4] = 0x0460,
+	[PMIF_IRQ_CLR_4] = 0x0464,
+	[PMIF_WDT_EVENT_EN_0] = 0x046C,
+	[PMIF_WDT_FLAG_0] = 0x0470,
+	[PMIF_WDT_EVENT_EN_1] = 0x0474,
+	[PMIF_WDT_FLAG_1] = 0x0478,
+	[PMIF_SWINF_0_ACC] = 0x0C00,
+	[PMIF_SWINF_0_WDATA_31_0] = 0x0C04,
+	[PMIF_SWINF_0_RDATA_31_0] = 0x0C14,
+	[PMIF_SWINF_0_VLD_CLR] = 0x0C24,
+	[PMIF_SWINF_0_STA] = 0x0C28,
+	[PMIF_SWINF_1_ACC] = 0x0C40,
+	[PMIF_SWINF_1_WDATA_31_0] = 0x0C44,
+	[PMIF_SWINF_1_RDATA_31_0] = 0x0C54,
+	[PMIF_SWINF_1_VLD_CLR] = 0x0C64,
+	[PMIF_SWINF_1_STA] = 0x0C68,
+	[PMIF_SWINF_2_ACC] = 0x0C80,
+	[PMIF_SWINF_2_WDATA_31_0] = 0x0C84,
+	[PMIF_SWINF_2_RDATA_31_0] = 0x0C94,
+	[PMIF_SWINF_2_VLD_CLR] = 0x0CA4,
+	[PMIF_SWINF_2_STA] = 0x0CA8,
+	[PMIF_SWINF_3_ACC] = 0x0CC0,
+	[PMIF_SWINF_3_WDATA_31_0] = 0x0CC4,
+	[PMIF_SWINF_3_RDATA_31_0] = 0x0CD4,
+	[PMIF_SWINF_3_VLD_CLR] = 0x0CE4,
+	[PMIF_SWINF_3_STA] = 0x0CE8,
+};
+
+enum spmi_regs {
+	SPMI_OP_ST_CTRL,
+	SPMI_GRP_ID_EN,
+	SPMI_OP_ST_STA,
+	SPMI_MST_SAMPL,
+	SPMI_MST_REQ_EN,
+	SPMI_REC_CTRL,
+	SPMI_REC0,
+	SPMI_REC1,
+	SPMI_REC2,
+	SPMI_REC3,
+	SPMI_REC4,
+	SPMI_MST_DBG,
+};
+
+static const u32 mt6873_spmi_regs[] = {
+	[SPMI_OP_ST_CTRL] = 0x0000,
+	[SPMI_GRP_ID_EN] = 0x0004,
+	[SPMI_OP_ST_STA] = 0x0008,
+	[SPMI_MST_SAMPL] = 0x000c,
+	[SPMI_MST_REQ_EN] = 0x0010,
+	[SPMI_REC_CTRL] = 0x0040,
+	[SPMI_REC0] = 0x0044,
+	[SPMI_REC1] = 0x0048,
+	[SPMI_REC2] = 0x004c,
+	[SPMI_REC3] = 0x0050,
+	[SPMI_REC4] = 0x0054,
+	[SPMI_MST_DBG] = 0x00fc,
+};
+
+static u32 pmif_readl(struct pmif *arb, enum pmif_regs reg)
+{
+	return readl(arb->base + arb->data->regs[reg]);
+}
+
+static void pmif_writel(struct pmif *arb, u32 val, enum pmif_regs reg)
+{
+	writel(val, arb->base + arb->data->regs[reg]);
+}
+
+static void mtk_spmi_writel(struct pmif *arb, u32 val, enum spmi_regs reg)
+{
+	writel(val, arb->spmimst_base + arb->data->spmimst_regs[reg]);
+}
+
+static bool pmif_is_fsm_vldclr(struct pmif *arb)
+{
+	u32 reg_rdata;
+
+	reg_rdata = pmif_readl(arb, arb->chan.ch_sta);
+
+	return GET_SWINF(reg_rdata) == SWINF_WFVLDCLR;
+}
+
+static int pmif_arb_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid)
+{
+	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
+	u32 rdata, cmd;
+	int ret;
+
+	/* Check the opcode */
+	if (opc < SPMI_CMD_RESET || opc > SPMI_CMD_WAKEUP)
+		return -EINVAL;
+
+	cmd = opc - SPMI_CMD_RESET;
+
+	mtk_spmi_writel(arb, (cmd << 0x4) | sid, SPMI_OP_ST_CTRL);
+	ret = readl_poll_timeout_atomic(arb->spmimst_base + arb->data->spmimst_regs[SPMI_OP_ST_STA],
+					rdata, (rdata & SPMI_OP_ST_BUSY) == SPMI_OP_ST_BUSY,
+					PMIF_DELAY_US, PMIF_TIMEOUT_US);
+	if (ret < 0)
+		dev_err(&ctrl->dev, "timeout, err = %d\n", ret);
+
+	return ret;
+}
+
+static int pmif_spmi_read_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+			      u16 addr, u8 *buf, size_t len)
+{
+	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
+	struct ch_reg *inf_reg;
+	int ret;
+	u32 data, cmd;
+
+	/* Check for argument validation. */
+	if (sid & ~0xf) {
+		dev_err(&ctrl->dev, "exceed the max slv id\n");
+		return -EINVAL;
+	}
+
+	if (len > 4) {
+		dev_err(&ctrl->dev, "pmif supports 1..4 bytes per trans, but:%zu requested", len);
+
+		return -EINVAL;
+	}
+
+	if (opc >= 0x60 && opc <= 0x7f)
+		opc = PMIF_CMD_REG;
+	else if ((opc >= 0x20 && opc <= 0x2f) || (opc >= 0x38 && opc <= 0x3f))
+		opc = PMIF_CMD_EXT_REG_LONG;
+	else
+		return -EINVAL;
+
+	/* Wait for Software Interface FSM state to be IDLE. */
+	inf_reg = &arb->chan;
+	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
+					data, GET_SWINF(data) == SWINF_IDLE,
+					PMIF_DELAY_US, PMIF_TIMEOUT_US);
+	if (ret < 0) {
+		/* set channel ready if the data has transferred */
+		if (pmif_is_fsm_vldclr(arb))
+			pmif_writel(arb, 1, inf_reg->ch_rdy);
+		dev_err(&ctrl->dev, "failed to wait for SWINF_IDLE\n");
+		return ret;
+	}
+
+	/* Send the command. */
+	cmd = (opc << 30) | (sid << 24) | ((len - 1) << 16) | addr;
+	pmif_writel(arb, cmd, inf_reg->ch_send);
+
+	/*
+	 * Wait for Software Interface FSM state to be WFVLDCLR,
+	 * read the data and clear the valid flag.
+	 */
+	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
+					data, GET_SWINF(data) == SWINF_WFVLDCLR,
+					PMIF_DELAY_US, PMIF_TIMEOUT_US);
+	if (ret < 0) {
+		dev_err(&ctrl->dev, "failed to wait for SWINF_WFVLDCLR\n");
+		return ret;
+	}
+
+	data = pmif_readl(arb, inf_reg->rdata);
+	memcpy(buf, &data, len);
+	pmif_writel(arb, 1, inf_reg->ch_rdy);
+
+	return 0;
+}
+
+static int pmif_spmi_write_cmd(struct spmi_controller *ctrl, u8 opc, u8 sid,
+			       u16 addr, const u8 *buf, size_t len)
+{
+	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
+	struct ch_reg *inf_reg;
+	int ret;
+	u32 data, cmd;
+
+	if (len > 4) {
+		dev_err(&ctrl->dev, "pmif supports 1..4 bytes per trans, but:%zu requested", len);
+
+		return -EINVAL;
+	}
+
+	/* Check the opcode */
+	if (opc >= 0x40 && opc <= 0x5F)
+		opc = PMIF_CMD_REG;
+	else if ((opc <= 0xF) || (opc >= 0x30 && opc <= 0x37))
+		opc = PMIF_CMD_EXT_REG_LONG;
+	else if (opc >= 0x80)
+		opc = PMIF_CMD_REG_0;
+	else
+		return -EINVAL;
+
+	/* Wait for Software Interface FSM state to be IDLE. */
+	inf_reg = &arb->chan;
+	ret = readl_poll_timeout_atomic(arb->base + arb->data->regs[inf_reg->ch_sta],
+					data, GET_SWINF(data) == SWINF_IDLE,
+					PMIF_DELAY_US, PMIF_TIMEOUT_US);
+	if (ret < 0) {
+		/* set channel ready if the data has transferred */
+		if (pmif_is_fsm_vldclr(arb))
+			pmif_writel(arb, 1, inf_reg->ch_rdy);
+		dev_err(&ctrl->dev, "failed to wait for SWINF_IDLE\n");
+		return ret;
+	}
+
+	/* Set the write data. */
+	memcpy(&data, buf, len);
+	pmif_writel(arb, data, inf_reg->wdata);
+
+	/* Send the command. */
+	cmd = (opc << 30) | BIT(29) | (sid << 24) | ((len - 1) << 16) | addr;
+	pmif_writel(arb, cmd, inf_reg->ch_send);
+
+	return 0;
+}
+
+static const struct pmif_data mt6873_pmif_arb = {
+	.regs = mt6873_regs,
+	.spmimst_regs = mt6873_spmi_regs,
+	.soc_chan = 2,
+};
+
+static int mtk_spmi_probe(struct platform_device *pdev)
+{
+	struct pmif *arb;
+	struct spmi_controller *ctrl;
+	int err, i;
+	u32 chan_offset;
+
+	ctrl = spmi_controller_alloc(&pdev->dev, sizeof(*arb));
+	if (!ctrl)
+		return -ENOMEM;
+
+	arb = spmi_controller_get_drvdata(ctrl);
+	arb->data = device_get_match_data(&pdev->dev);
+	if (!arb->data) {
+		err = -EINVAL;
+		dev_err(&pdev->dev, "Cannot get drv_data\n");
+		goto err_put_ctrl;
+	}
+
+	arb->base = devm_platform_ioremap_resource_byname(pdev, "pmif");
+	if (IS_ERR(arb->base)) {
+		err = PTR_ERR(arb->base);
+		goto err_put_ctrl;
+	}
+
+	arb->spmimst_base = devm_platform_ioremap_resource_byname(pdev, "spmimst");
+	if (IS_ERR(arb->spmimst_base)) {
+		err = PTR_ERR(arb->spmimst_base);
+		goto err_put_ctrl;
+	}
+
+	arb->nclks = ARRAY_SIZE(pmif_clock_names);
+	for (i = 0; i < arb->nclks; i++)
+		arb->clks[i].id = pmif_clock_names[i];
+
+	err = devm_clk_bulk_get(&pdev->dev, arb->nclks, arb->clks);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to get clocks: %d\n", err);
+		goto err_put_ctrl;
+	}
+
+	err = clk_bulk_prepare_enable(arb->nclks, arb->clks);
+	if (err) {
+		dev_err(&pdev->dev, "Failed to enable clocks: %d\n", err);
+		goto err_put_ctrl;
+	}
+
+	ctrl->cmd = pmif_arb_cmd;
+	ctrl->read_cmd = pmif_spmi_read_cmd;
+	ctrl->write_cmd = pmif_spmi_write_cmd;
+
+	chan_offset = PMIF_CHAN_OFFSET * arb->data->soc_chan;
+	arb->chan.ch_sta = PMIF_SWINF_0_STA + chan_offset;
+	arb->chan.wdata = PMIF_SWINF_0_WDATA_31_0 + chan_offset;
+	arb->chan.rdata = PMIF_SWINF_0_RDATA_31_0 + chan_offset;
+	arb->chan.ch_send = PMIF_SWINF_0_ACC + chan_offset;
+	arb->chan.ch_rdy = PMIF_SWINF_0_VLD_CLR + chan_offset;
+
+	platform_set_drvdata(pdev, ctrl);
+
+	err = spmi_controller_add(ctrl);
+	if (err)
+		goto err_domain_remove;
+
+	return 0;
+
+err_domain_remove:
+	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
+err_put_ctrl:
+	spmi_controller_put(ctrl);
+	return err;
+}
+
+static int mtk_spmi_remove(struct platform_device *pdev)
+{
+	struct spmi_controller *ctrl = platform_get_drvdata(pdev);
+	struct pmif *arb = spmi_controller_get_drvdata(ctrl);
+
+	clk_bulk_disable_unprepare(arb->nclks, arb->clks);
+	spmi_controller_remove(ctrl);
+	spmi_controller_put(ctrl);
+	return 0;
+}
+
+static const struct of_device_id mtk_spmi_match_table[] = {
+	{
+		.compatible = "mediatek,mt6873-spmi",
+		.data = &mt6873_pmif_arb,
+	}, {
+		/* sentinel */
+	},
+};
+MODULE_DEVICE_TABLE(of, mtk_spmi_match_table);
+
+static struct platform_driver mtk_spmi_driver = {
+	.driver		= {
+		.name	= "spmi-mtk",
+		.of_match_table = of_match_ptr(mtk_spmi_match_table),
+	},
+	.probe		= mtk_spmi_probe,
+	.remove		= mtk_spmi_remove,
+};
+module_platform_driver(mtk_spmi_driver);
+
+MODULE_AUTHOR("Hsin-Hsiung Wang <hsin-hsiung.wang@mediatek.com>");
+MODULE_DESCRIPTION("MediaTek SPMI Driver");
+MODULE_LICENSE("GPL");
-- 
https://git.kernel.org/pub/scm/linux/kernel/git/clk/linux.git/
https://git.kernel.org/pub/scm/linux/kernel/git/sboyd/spmi.git

