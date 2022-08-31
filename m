Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EDC105A7DE5
	for <lists+linux-kernel@lfdr.de>; Wed, 31 Aug 2022 14:49:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231442AbiHaMtV (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 31 Aug 2022 08:49:21 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53060 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231411AbiHaMtF (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 31 Aug 2022 08:49:05 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 63C0495E6F;
        Wed, 31 Aug 2022 05:49:00 -0700 (PDT)
X-UUID: 59a288ed26774c679e222b2e4ba78ac7-20220831
DKIM-Signature: v=1; a=rsa-sha256; q=dns/txt; c=relaxed/relaxed; d=mediatek.com; s=dk;
        h=Content-Type:MIME-Version:References:In-Reply-To:Message-ID:Date:Subject:CC:To:From; bh=9hwZ5lokIYKOlXJxV8Ro2SwVnjuNQzTSxW79IdGZ/zI=;
        b=IZYLpmpyZZ6n2ogx6ETo+TUSFtg7Y4aj0nl1V0C40Si6yA/O49421kFGwiMWSLVcM8ECYJ6/J7FFz4BsuOcfwhMWxwQX60vh1MsH4iq80MXU+FfxLrrug6WxGufnM6QRoYziVOOs11cMlX1oH9fxocKyLZEgDiA2JrM6naSx6Bg=;
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.10,REQID:778c9595-0d21-4c3e-bcbd-77190ace3919,OB:0,L
        OB:20,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Rele
        ase_Ham,ACTION:release,TS:70
X-CID-INFO: VERSION:1.1.10,REQID:778c9595-0d21-4c3e-bcbd-77190ace3919,OB:0,LOB
        :20,IP:0,URL:0,TC:0,Content:-25,EDM:0,RT:0,SF:95,FILE:0,BULK:0,RULE:Spam_G
        S981B3D,ACTION:quarantine,TS:70
X-CID-META: VersionHash:84eae18,CLOUDID:da6832d0-20bd-4e5e-ace8-00692b7ab380,C
        OID:9ac40243fccf,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:11|1,File:nil,Bulk:nil,QS:nil,BEC:nil,COL:0
X-UUID: 59a288ed26774c679e222b2e4ba78ac7-20220831
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 825050367; Wed, 31 Aug 2022 20:48:53 +0800
Received: from mtkmbs11n2.mediatek.inc (172.21.101.187) by
 mtkmbs11n2.mediatek.inc (172.21.101.187) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.792.15; Wed, 31 Aug 2022 20:48:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n2.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.15 via Frontend Transport; Wed, 31 Aug 2022 20:48:52 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <angelogioacchino.delregno@collabora.com>, <sboyd@kernel.org>
CC:     <linux-clk@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
Subject: [PATCH 3/4] clk: mediatek: Add new clock driver to handle FHCTL hardware
Date:   Wed, 31 Aug 2022 20:48:49 +0800
Message-ID: <20220831124850.7748-4-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220831124850.7748-1-johnson.wang@mediatek.com>
References: <20220831124850.7748-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-2.0 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_MSPIKE_H2,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY,URIBL_CSS
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To implement frequency hopping and spread spectrum clocking
function, we introduce new clock type and APIs to handle
FHCTL hardware.

Co-developed-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
---
 drivers/clk/mediatek/Makefile    |   2 +-
 drivers/clk/mediatek/clk-fhctl.c | 258 +++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-fhctl.h |  27 +++
 drivers/clk/mediatek/clk-pllfh.c | 271 +++++++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-pllfh.h |  81 +++++++++
 5 files changed, 638 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-fhctl.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl.h
 create mode 100644 drivers/clk/mediatek/clk-pllfh.c
 create mode 100644 drivers/clk/mediatek/clk-pllfh.h

diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index caf2ce93d666..0e674a55e51e 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -1,5 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o
+obj-$(CONFIG_COMMON_CLK_MEDIATEK) += clk-mtk.o clk-pll.o clk-gate.o clk-apmixed.o clk-cpumux.o reset.o clk-mux.o clk-fhctl.o clk-pllfh.o
 
 obj-$(CONFIG_COMMON_CLK_MT6765) += clk-mt6765.o
 obj-$(CONFIG_COMMON_CLK_MT6765_AUDIOSYS) += clk-mt6765-audio.o
diff --git a/drivers/clk/mediatek/clk-fhctl.c b/drivers/clk/mediatek/clk-fhctl.c
new file mode 100644
index 000000000000..69bd4ce2bc72
--- /dev/null
+++ b/drivers/clk/mediatek/clk-fhctl.c
@@ -0,0 +1,258 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Edward-JW Yang <edward-jw.yang@mediatek.com>
+ */
+
+#include <linux/iopoll.h>
+
+#include "clk-mtk.h"
+#include "clk-pllfh.h"
+#include "clk-fhctl.h"
+
+#define PERCENT_TO_DDSLMT(dds, percent_m10) \
+	((((dds) * (percent_m10)) >> 5) / 100)
+
+static const struct fhctl_offset fhctl_offset = {
+	.offset_hp_en = 0x0,
+	.offset_clk_con = 0x8,
+	.offset_rst_con = 0xc,
+	.offset_slope0 = 0x10,
+	.offset_slope1 = 0x14,
+	.offset_cfg = 0x0,
+	.offset_updnlmt = 0x4,
+	.offset_dds = 0x8,
+	.offset_dvfs = 0xc,
+	.offset_mon = 0x10,
+};
+
+const struct fhctl_offset *fhctl_get_offset_table(void)
+{
+	return &fhctl_offset;
+}
+
+static void dump_hw(struct mtk_clk_pll *pll, struct fh_pll_regs *regs,
+		    const struct fh_pll_data *data)
+{
+	pr_info("hp_en<%x>,clk_con<%x>,slope0<%x>,slope1<%x>\n",
+		readl(regs->reg_hp_en), readl(regs->reg_clk_con),
+		readl(regs->reg_slope0), readl(regs->reg_slope1));
+	pr_info("cfg<%x>,lmt<%x>,dds<%x>,dvfs<%x>,mon<%x>\n",
+		readl(regs->reg_cfg), readl(regs->reg_updnlmt),
+		readl(regs->reg_dds), readl(regs->reg_dvfs),
+		readl(regs->reg_mon));
+	pr_info("pcw<%x>\n", readl(pll->pcw_addr));
+}
+
+static int fhctl_set_ssc_regs(struct mtk_clk_pll *pll, struct fh_pll_regs *regs,
+			      const struct fh_pll_data *data, u32 rate)
+{
+	u32 updnlmt_val, r;
+
+	writel((readl(regs->reg_cfg) & ~(data->frddsx_en)), regs->reg_cfg);
+	writel((readl(regs->reg_cfg) & ~(data->sfstrx_en)), regs->reg_cfg);
+	writel((readl(regs->reg_cfg) & ~(data->fhctlx_en)), regs->reg_cfg);
+
+	if (rate > 0) {
+		/* Set the relative parameter registers (dt/df/upbnd/downbnd) */
+		r = readl(regs->reg_cfg);
+		r &= ~(data->msk_frddsx_dys);
+		r |= (data->df_val << (ffs(data->msk_frddsx_dys) - 1));
+		writel(r, regs->reg_cfg);
+
+		r = readl(regs->reg_cfg);
+		r &= ~(data->msk_frddsx_dts);
+		r |= (data->dt_val << (ffs(data->msk_frddsx_dts) - 1));
+		writel(r, regs->reg_cfg);
+
+		writel((readl(pll->pcw_addr) & data->dds_mask) | data->tgl_org,
+			regs->reg_dds);
+
+		/* Calculate UPDNLMT */
+		updnlmt_val = PERCENT_TO_DDSLMT((readl(regs->reg_dds) &
+						 data->dds_mask), rate) <<
+						 data->updnlmt_shft;
+
+		writel(updnlmt_val, regs->reg_updnlmt);
+		writel(readl(regs->reg_hp_en) | BIT(data->fh_id),
+		       regs->reg_hp_en);
+		/* Enable SSC */
+		writel(readl(regs->reg_cfg) | data->frddsx_en, regs->reg_cfg);
+		/* Enable Hopping control */
+		writel(readl(regs->reg_cfg) | data->fhctlx_en, regs->reg_cfg);
+
+	} else {
+		/* Switch to APMIXEDSYS control */
+		writel(readl(regs->reg_hp_en) & ~BIT(data->fh_id),
+		       regs->reg_hp_en);
+		/* Wait for DDS to be stable */
+		udelay(30);
+	}
+
+	return 0;
+}
+
+static int hopping_hw_flow(struct mtk_clk_pll *pll, struct fh_pll_regs *regs,
+			   const struct fh_pll_data *data,
+			   struct fh_pll_state *state, unsigned int new_dds)
+{
+	u32 dds_mask = data->dds_mask;
+	u32 mon_dds = 0;
+	u32 con_pcw_tmp;
+	int ret;
+
+	if (state->ssc_rate)
+		fhctl_set_ssc_regs(pll, regs, data, 0);
+
+	writel((readl(pll->pcw_addr) & dds_mask) | data->tgl_org,
+		regs->reg_dds);
+
+	writel(readl(regs->reg_cfg) | data->sfstrx_en, regs->reg_cfg);
+	writel(readl(regs->reg_cfg) | data->fhctlx_en, regs->reg_cfg);
+	writel(data->slope0_value, regs->reg_slope0);
+	writel(data->slope1_value, regs->reg_slope1);
+
+	writel(readl(regs->reg_hp_en) | BIT(data->fh_id), regs->reg_hp_en);
+	writel((new_dds) | (data->dvfs_tri), regs->reg_dvfs);
+
+	/* Wait 1000 us until DDS stable */
+	ret = readl_poll_timeout_atomic(regs->reg_mon, mon_dds,
+				       (mon_dds & dds_mask) == new_dds,
+					10, 1000);
+	if (ret) {
+		pr_warn("%s: FHCTL hopping timeout\n", pll->data->name);
+		dump_hw(pll, regs, data);
+	}
+
+	con_pcw_tmp = readl(pll->pcw_addr) & (~dds_mask);
+	con_pcw_tmp = (con_pcw_tmp | (readl(regs->reg_mon) & dds_mask) |
+		       data->pcwchg);
+
+	writel(con_pcw_tmp, pll->pcw_addr);
+	writel(readl(regs->reg_hp_en) & ~BIT(data->fh_id), regs->reg_hp_en);
+
+	if (state->ssc_rate)
+		fhctl_set_ssc_regs(pll, regs, data, state->ssc_rate);
+
+	return ret;
+}
+
+static unsigned int __get_postdiv(struct mtk_clk_pll *pll,
+				  struct fh_pll_regs *regs,
+				  const struct fh_pll_data *fh_data)
+{
+	unsigned int regval;
+
+	regval = readl(pll->pd_addr) >> pll->data->pd_shift;
+	regval &= POSTDIV_MASK;
+
+	return (1 << regval);
+}
+
+static void __set_postdiv(struct mtk_clk_pll *pll, struct fh_pll_regs *regs,
+			  const struct fh_pll_data *data, int postdiv)
+{
+	unsigned int regval;
+
+	regval = readl(pll->pd_addr);
+	regval &= ~(POSTDIV_MASK << pll->data->pd_shift);
+	regval |= (ffs(postdiv) - 1) << pll->data->pd_shift;
+	writel(regval, pll->pd_addr);
+}
+
+static int fhctl_hopping(struct mtk_fh *fh, unsigned int new_dds, int postdiv)
+{
+	const struct fh_pll_data *data = &fh->pllfh_data->data;
+	struct fh_pll_state *state = &fh->pllfh_data->state;
+	struct fh_pll_regs *regs = &fh->regs;
+	struct mtk_clk_pll *pll = &fh->clk_pll;
+	spinlock_t *lock = fh->lock;
+	unsigned int pll_postdiv;
+	unsigned long flags = 0;
+	int ret;
+
+	if (postdiv > 0) {
+		pll_postdiv = __get_postdiv(pll, regs, data);
+
+		if (postdiv > pll_postdiv)
+			__set_postdiv(pll, regs, data, postdiv);
+	}
+
+	spin_lock_irqsave(lock, flags);
+
+	ret = hopping_hw_flow(pll, regs, data, state, new_dds);
+
+	spin_unlock_irqrestore(lock, flags);
+
+	if (postdiv > 0) {
+		if (postdiv < pll_postdiv)
+			__set_postdiv(pll, regs, data, postdiv);
+	}
+
+	return ret;
+}
+
+static int __fhctl_ssc_enable(struct mtk_fh *fh, u32 rate)
+{
+	const struct fh_pll_data *data = &fh->pllfh_data->data;
+	struct fh_pll_state *state = &fh->pllfh_data->state;
+	struct fh_pll_regs *regs = &fh->regs;
+	struct mtk_clk_pll *pll = &fh->clk_pll;
+	spinlock_t *lock = fh->lock;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(lock, flags);
+
+	fhctl_set_ssc_regs(pll, regs, data, rate);
+	state->ssc_rate = rate;
+
+	spin_unlock_irqrestore(lock, flags);
+
+	return 0;
+}
+
+static int fhctl_ssc_enable(struct mtk_fh *fh, u32 rate)
+{
+	return __fhctl_ssc_enable(fh, rate);
+}
+
+static int fhctl_ssc_disable(struct mtk_fh *fh)
+{
+	return __fhctl_ssc_enable(fh, 0);
+}
+
+static const struct fh_operation fhctl_ops = {
+	.hopping = fhctl_hopping,
+	.ssc_enable = fhctl_ssc_enable,
+	.ssc_disable = fhctl_ssc_disable,
+};
+
+const struct fh_operation *fhctl_get_ops(void)
+{
+	return &fhctl_ops;
+}
+
+void fhctl_hw_init(struct mtk_fh *fh)
+{
+	const struct fh_pll_data data = fh->pllfh_data->data;
+	struct fh_pll_state state = fh->pllfh_data->state;
+	struct fh_pll_regs regs = fh->regs;
+	u32 val;
+
+	/* initial hw register */
+	val = readl(regs.reg_clk_con) | BIT(data.fh_id);
+	writel(val, regs.reg_clk_con);
+
+	val = readl(regs.reg_rst_con) & ~BIT(data.fh_id);
+	writel(val, regs.reg_rst_con);
+	val = readl(regs.reg_rst_con) | BIT(data.fh_id);
+	writel(val, regs.reg_rst_con);
+
+	writel(0x0, regs.reg_cfg);
+	writel(0x0, regs.reg_updnlmt);
+	writel(0x0, regs.reg_dds);
+
+	/* enable ssc if needed */
+	if (state.ssc_rate)
+		fh->ops->ssc_enable(fh, state.ssc_rate);
+}
diff --git a/drivers/clk/mediatek/clk-fhctl.h b/drivers/clk/mediatek/clk-fhctl.h
new file mode 100644
index 000000000000..3cd4921c39e9
--- /dev/null
+++ b/drivers/clk/mediatek/clk-fhctl.h
@@ -0,0 +1,27 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Edward-JW Yang <edward-jw.yang@mediatek.com>
+ */
+
+#ifndef __CLK_FHCTL_H
+#define __CLK_FHCTL_H
+
+
+struct fhctl_offset {
+	u32 offset_hp_en;
+	u32 offset_clk_con;
+	u32 offset_rst_con;
+	u32 offset_slope0;
+	u32 offset_slope1;
+	u32 offset_cfg;
+	u32 offset_updnlmt;
+	u32 offset_dds;
+	u32 offset_dvfs;
+	u32 offset_mon;
+};
+const struct fhctl_offset *fhctl_get_offset_table(void);
+const struct fh_operation *fhctl_get_ops(void);
+void fhctl_hw_init(struct mtk_fh *fh);
+
+#endif
diff --git a/drivers/clk/mediatek/clk-pllfh.c b/drivers/clk/mediatek/clk-pllfh.c
new file mode 100644
index 000000000000..71b35323b526
--- /dev/null
+++ b/drivers/clk/mediatek/clk-pllfh.c
@@ -0,0 +1,271 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Edward-JW Yang <edward-jw.yang@mediatek.com>
+ */
+
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/io.h>
+#include <linux/slab.h>
+#include <linux/clkdev.h>
+#include <linux/delay.h>
+
+#include "clk-mtk.h"
+#include "clk-pllfh.h"
+#include "clk-fhctl.h"
+
+static DEFINE_SPINLOCK(pllfh_lock);
+
+inline struct mtk_fh *to_mtk_fh(struct clk_hw *hw)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+
+	return container_of(pll, struct mtk_fh, clk_pll);
+}
+
+static int mtk_fhctl_set_rate(struct clk_hw *hw, unsigned long rate,
+			      unsigned long parent_rate)
+{
+	struct mtk_clk_pll *pll = to_mtk_clk_pll(hw);
+	struct mtk_fh *fh = to_mtk_fh(hw);
+	u32 pcw = 0;
+	u32 postdiv;
+
+	mtk_pll_calc_values(pll, &pcw, &postdiv, rate, parent_rate);
+	fh->ops->hopping(fh, pcw, postdiv);
+
+	return 0;
+}
+
+static const struct clk_ops mtk_pllfh_ops = {
+	.is_prepared	= mtk_pll_is_prepared,
+	.prepare	= mtk_pll_prepare,
+	.unprepare	= mtk_pll_unprepare,
+	.recalc_rate	= mtk_pll_recalc_rate,
+	.round_rate	= mtk_pll_round_rate,
+	.set_rate	= mtk_fhctl_set_rate,
+};
+
+static struct mtk_pllfh_data *get_pllfh_by_id(struct mtk_pllfh_data *pllfhs,
+					      int num_fhs, int pll_id)
+{
+	int i;
+
+	for (i = 0; i < num_fhs; i++)
+		if (pllfhs[i].data.pll_id == pll_id)
+			return &pllfhs[i];
+
+	return NULL;
+}
+
+void fhctl_parse_dt(struct mtk_pllfh_data *pllfhs, int num_fhs)
+{
+	void __iomem *base;
+	struct device_node *node;
+	const u8 *compatible_node = "mediatek,fhctl";
+	u32 tmp = 0;
+	u32 num_cells, pll_id, ssc_rate;
+	int offset, i;
+
+	node = of_find_compatible_node(NULL, NULL, compatible_node);
+	if (!node) {
+		pr_err("cannot find \"%s\"\n", compatible_node);
+		return;
+	}
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s(): ioremap failed\n", __func__);
+		return;
+	}
+
+	if (!of_get_property(node, "mediatek,hopping-ssc-percents", &tmp)) {
+		pr_err("%s(): failed get property\n", __func__);
+		return;
+	}
+
+	num_cells = tmp / (sizeof(u32) * 2);
+
+	for (i = 0; i < num_cells; i++) {
+		struct mtk_pllfh_data *pllfh;
+
+		offset = i * 2;
+		of_property_read_u32_index(node,
+					   "mediatek,hopping-ssc-percents",
+					   offset, &pll_id);
+		of_property_read_u32_index(node,
+					   "mediatek,hopping-ssc-percents",
+					   offset + 1, &ssc_rate);
+		pllfh = get_pllfh_by_id(pllfhs, num_fhs, pll_id);
+		if (!pllfh)
+			continue;
+
+		pllfh->state.fh_enable = 1;
+		pllfh->state.ssc_rate = ssc_rate;
+		pllfh->state.base = base;
+	}
+}
+
+static void pllfh_init(struct mtk_fh *fh, struct mtk_pllfh_data *pllfh_data)
+{
+	struct fh_pll_regs *regs = &fh->regs;
+	const struct fhctl_offset *offset;
+	void __iomem *base = pllfh_data->state.base;
+	void __iomem *fhx_base = base + pllfh_data->data.fhx_offset;
+
+	offset = fhctl_get_offset_table();
+
+	regs->reg_hp_en = base + offset->offset_hp_en;
+	regs->reg_clk_con = base + offset->offset_clk_con;
+	regs->reg_rst_con = base + offset->offset_rst_con;
+	regs->reg_slope0 = base + offset->offset_slope0;
+	regs->reg_slope1 = base + offset->offset_slope1;
+
+	regs->reg_cfg = fhx_base + offset->offset_cfg;
+	regs->reg_updnlmt = fhx_base + offset->offset_updnlmt;
+	regs->reg_dds = fhx_base + offset->offset_dds;
+	regs->reg_dvfs = fhx_base + offset->offset_dvfs;
+	regs->reg_mon = fhx_base + offset->offset_mon;
+
+	fh->pllfh_data = pllfh_data;
+	fh->lock = &pllfh_lock;
+
+	fh->ops = fhctl_get_ops();
+}
+
+static bool fhctl_is_supported_and_enabled(const struct mtk_pllfh_data *pllfh)
+{
+	return pllfh && (pllfh->state.fh_enable == 1);
+}
+
+static struct clk_hw *
+mtk_clk_register_pllfh(const struct mtk_pll_data *pll_data,
+		       struct mtk_pllfh_data *pllfh_data, void __iomem *base)
+{
+	struct clk_hw *hw;
+	struct mtk_fh *fh;
+
+	fh = kzalloc(sizeof(*fh), GFP_KERNEL);
+	if (!fh)
+		return ERR_PTR(-ENOMEM);
+
+	pllfh_init(fh, pllfh_data);
+
+	hw = mtk_clk_register_pll_ops(&fh->clk_pll, pll_data, base,
+				      &mtk_pllfh_ops);
+
+	if (IS_ERR(hw))
+		kfree(fh);
+	else
+		fhctl_hw_init(fh);
+
+	return hw;
+}
+
+static void mtk_clk_unregister_pllfh(struct clk_hw *hw)
+{
+	struct mtk_fh *fh;
+
+	if (!hw)
+		return;
+
+	fh = to_mtk_fh(hw);
+
+	clk_hw_unregister(hw);
+	kfree(fh);
+}
+
+int mtk_clk_register_pllfhs(struct device_node *node,
+			    const struct mtk_pll_data *plls, int num_plls,
+			    struct mtk_pllfh_data *pllfhs, int num_fhs,
+			    struct clk_hw_onecell_data *clk_data)
+{
+	void __iomem *base;
+	int i;
+	struct clk_hw *hw;
+
+	base = of_iomap(node, 0);
+	if (!base) {
+		pr_err("%s(): ioremap failed\n", __func__);
+		return -EINVAL;
+	}
+
+	for (i = 0; i < num_plls; i++) {
+		const struct mtk_pll_data *pll = &plls[i];
+		struct mtk_pllfh_data *pllfh;
+
+		pllfh = get_pllfh_by_id(pllfhs, num_fhs, pll->id);
+
+		if (fhctl_is_supported_and_enabled(pllfh))
+			hw = mtk_clk_register_pllfh(pll, pllfh, base);
+		else
+			hw = mtk_clk_register_pll(pll, base);
+
+		if (IS_ERR(hw)) {
+			pr_err("Failed to register clk %s: %pe\n", pll->name,
+			       hw);
+			goto err;
+		}
+
+		clk_data->hws[pll->id] = hw;
+	}
+
+	return 0;
+
+err:
+	while (--i >= 0) {
+		const struct mtk_pll_data *pll = &plls[i];
+		struct mtk_pllfh_data *pllfh;
+
+		pllfh = get_pllfh_by_id(pllfhs, num_fhs, pll->id);
+
+		if (fhctl_is_supported_and_enabled(pllfh))
+			mtk_clk_unregister_pllfh(clk_data->hws[pll->id]);
+		else
+			mtk_clk_unregister_pll(clk_data->hws[pll->id]);
+
+		clk_data->hws[pll->id] = ERR_PTR(-ENOENT);
+	}
+
+	iounmap(base);
+
+	return PTR_ERR(hw);
+}
+
+void mtk_clk_unregister_pllfhs(const struct mtk_pll_data *plls, int num_plls,
+			       struct mtk_pllfh_data *pllfhs, int num_fhs,
+			       struct clk_hw_onecell_data *clk_data)
+{
+	void __iomem *base = NULL, *fhctl_base = NULL;
+	int i;
+
+	if (!clk_data)
+		return;
+
+	for (i = num_plls; i > 0; i--) {
+		const struct mtk_pll_data *pll = &plls[i - 1];
+		struct mtk_pllfh_data *pllfh;
+
+		if (IS_ERR_OR_NULL(clk_data->hws[pll->id]))
+			continue;
+
+		pllfh = get_pllfh_by_id(pllfhs, num_fhs, pll->id);
+
+		if (fhctl_is_supported_and_enabled(pllfh)) {
+			fhctl_base = pllfh->state.base;
+			mtk_clk_unregister_pllfh(clk_data->hws[pll->id]);
+		} else {
+			base = mtk_clk_pll_get_base(clk_data->hws[pll->id],
+						    pll);
+			mtk_clk_unregister_pll(clk_data->hws[pll->id]);
+		}
+
+		clk_data->hws[pll->id] = ERR_PTR(-ENOENT);
+	}
+
+	if (fhctl_base)
+		iounmap(fhctl_base);
+
+	iounmap(base);
+}
diff --git a/drivers/clk/mediatek/clk-pllfh.h b/drivers/clk/mediatek/clk-pllfh.h
new file mode 100644
index 000000000000..d9f7c8527548
--- /dev/null
+++ b/drivers/clk/mediatek/clk-pllfh.h
@@ -0,0 +1,81 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ * Author: Edward-JW Yang <edward-jw.yang@mediatek.com>
+ */
+
+#ifndef __DRV_CLKFH_H
+#define __DRV_CLKFH_H
+
+#include "clk-pll.h"
+
+struct fh_pll_state {
+	u32 fh_enable;
+	u32 ssc_rate;
+	void __iomem *base;
+};
+
+struct fh_pll_data {
+	int pll_id;
+	int fh_id;
+	u32 fhx_offset;
+	u32 dds_mask;
+	u32 slope0_value;
+	u32 slope1_value;
+	u32 sfstrx_en;
+	u32 frddsx_en;
+	u32 fhctlx_en;
+	u32 tgl_org;
+	u32 dvfs_tri;
+	u32 pcwchg;
+	u32 dt_val;
+	u32 df_val;
+	u32 updnlmt_shft;
+	u32 msk_frddsx_dys;
+	u32 msk_frddsx_dts;
+};
+
+struct mtk_pllfh_data {
+	struct fh_pll_state state;
+	const struct fh_pll_data data;
+};
+
+struct fh_pll_regs {
+	void __iomem *reg_hp_en;
+	void __iomem *reg_clk_con;
+	void __iomem *reg_rst_con;
+	void __iomem *reg_slope0;
+	void __iomem *reg_slope1;
+	void __iomem *reg_cfg;
+	void __iomem *reg_updnlmt;
+	void __iomem *reg_dds;
+	void __iomem *reg_dvfs;
+	void __iomem *reg_mon;
+};
+
+struct mtk_fh {
+	struct mtk_clk_pll clk_pll;
+	struct fh_pll_regs regs;
+	struct mtk_pllfh_data *pllfh_data;
+	const struct fh_operation *ops;
+	spinlock_t *lock;
+};
+
+struct fh_operation {
+	int (*hopping)(struct mtk_fh *fh, unsigned int new_dds, int postdiv);
+	int (*ssc_enable)(struct mtk_fh *fh, u32 rate);
+	int (*ssc_disable)(struct mtk_fh *fh);
+};
+
+int mtk_clk_register_pllfhs(struct device_node *node,
+			    const struct mtk_pll_data *plls, int num_plls,
+			    struct mtk_pllfh_data *pllfhs, int num_pllfhs,
+			    struct clk_hw_onecell_data *clk_data);
+
+void mtk_clk_unregister_pllfhs(const struct mtk_pll_data *plls, int num_plls,
+			       struct mtk_pllfh_data *pllfhs, int num_fhs,
+			       struct clk_hw_onecell_data *clk_data);
+
+void fhctl_parse_dt(struct mtk_pllfh_data *pllfhs, int num_pllfhs);
+
+#endif /* __DRV_CLKFH_H */
-- 
2.18.0

