Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5333D547A6E
	for <lists+linux-kernel@lfdr.de>; Sun, 12 Jun 2022 15:56:07 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237251AbiFLNyk (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 12 Jun 2022 09:54:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50666 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237140AbiFLNyd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 12 Jun 2022 09:54:33 -0400
Received: from mailgw01.mediatek.com (unknown [60.244.123.138])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AD53D57113;
        Sun, 12 Jun 2022 06:54:25 -0700 (PDT)
X-UUID: 030e5c685a1846df9a527f0d078927d6-20220612
X-CID-P-RULE: Release_Ham
X-CID-O-INFO: VERSION:1.1.5,REQID:3364f3b1-4f30-411f-b598-31703acb6e50,OB:10,L
        OB:10,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Release_Ham
        ,ACTION:release,TS:100
X-CID-INFO: VERSION:1.1.5,REQID:3364f3b1-4f30-411f-b598-31703acb6e50,OB:10,LOB
        :10,IP:0,URL:5,TC:0,Content:-5,EDM:0,RT:0,SF:100,FILE:0,RULE:Spam_GS981B3D
        ,ACTION:quarantine,TS:100
X-CID-META: VersionHash:2a19b09,CLOUDID:ca8f96e7-1f03-4449-90ad-e6cb8f3d1399,C
        OID:b1b634de6ec6,Recheck:0,SF:28|17|19|48,TC:nil,Content:0,EDM:-3,IP:nil,U
        RL:1,File:nil,QS:0,BEC:nil
X-UUID: 030e5c685a1846df9a527f0d078927d6-20220612
Received: from mtkcas11.mediatek.inc [(172.21.101.40)] by mailgw01.mediatek.com
        (envelope-from <johnson.wang@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 1535220312; Sun, 12 Jun 2022 21:54:18 +0800
Received: from mtkmbs11n1.mediatek.inc (172.21.101.185) by
 mtkmbs11n1.mediatek.inc (172.21.101.185) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id 15.2.792.3;
 Sun, 12 Jun 2022 21:54:16 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by
 mtkmbs11n1.mediatek.inc (172.21.101.73) with Microsoft SMTP Server id
 15.2.792.3 via Frontend Transport; Sun, 12 Jun 2022 21:54:16 +0800
From:   Johnson Wang <johnson.wang@mediatek.com>
To:     <robh+dt@kernel.org>, <krzysztof.kozlowski+dt@linaro.org>,
        <mturquette@baylibre.com>, <sboyd@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-clk@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <Project_Global_Chrome_Upstream_Group@mediatek.com>,
        Johnson Wang <johnson.wang@mediatek.com>,
        Edward-JW Yang <edward-jw.yang@mediatek.com>
Subject: [RFC PATCH 2/2] clk: mediatek: Add frequency hopping support
Date:   Sun, 12 Jun 2022 21:54:14 +0800
Message-ID: <20220612135414.3003-3-johnson.wang@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20220612135414.3003-1-johnson.wang@mediatek.com>
References: <20220612135414.3003-1-johnson.wang@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_PASS,
        SPF_PASS,T_SCC_BODY_TEXT_LINE,UNPARSEABLE_RELAY autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add frequency hopping support and spread spectrum clocking
control for MT8186.

Signed-off-by: Edward-JW Yang <edward-jw.yang@mediatek.com>
Signed-off-by: Johnson Wang <johnson.wang@mediatek.com>
---
 drivers/clk/mediatek/Kconfig          |   8 +
 drivers/clk/mediatek/Makefile         |   2 +
 drivers/clk/mediatek/clk-fhctl-ap.c   | 347 ++++++++++++++++++++++++++
 drivers/clk/mediatek/clk-fhctl-pll.c  | 209 ++++++++++++++++
 drivers/clk/mediatek/clk-fhctl-pll.h  |  74 ++++++
 drivers/clk/mediatek/clk-fhctl-util.h |  24 ++
 drivers/clk/mediatek/clk-fhctl.c      | 191 ++++++++++++++
 drivers/clk/mediatek/clk-fhctl.h      |  45 ++++
 drivers/clk/mediatek/clk-pll.c        |   5 +-
 drivers/clk/mediatek/clk-pll.h        |   5 +
 10 files changed, 909 insertions(+), 1 deletion(-)
 create mode 100644 drivers/clk/mediatek/clk-fhctl-ap.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl-pll.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl-pll.h
 create mode 100644 drivers/clk/mediatek/clk-fhctl-util.h
 create mode 100644 drivers/clk/mediatek/clk-fhctl.c
 create mode 100644 drivers/clk/mediatek/clk-fhctl.h

diff --git a/drivers/clk/mediatek/Kconfig b/drivers/clk/mediatek/Kconfig
index d5936cfb3bee..fd887c537a91 100644
--- a/drivers/clk/mediatek/Kconfig
+++ b/drivers/clk/mediatek/Kconfig
@@ -622,4 +622,12 @@ config COMMON_CLK_MT8516_AUDSYS
 	help
 	  This driver supports MediaTek MT8516 audsys clocks.
 
+config COMMON_CLK_MTK_FREQ_HOPPING
+	tristate "MediaTek frequency hopping driver"
+	depends on ARCH_MEDIATEK || COMPILE_TEST
+	select COMMON_CLK_MEDIATEK
+	help
+	  This driver supports frequency hopping and spread spectrum clocking
+	  control for some MediaTek SoCs.
+
 endmenu
diff --git a/drivers/clk/mediatek/Makefile b/drivers/clk/mediatek/Makefile
index caf2ce93d666..3c0e9bd3978b 100644
--- a/drivers/clk/mediatek/Makefile
+++ b/drivers/clk/mediatek/Makefile
@@ -99,3 +99,5 @@ obj-$(CONFIG_COMMON_CLK_MT8195) += clk-mt8195-apmixedsys.o clk-mt8195-topckgen.o
 				   clk-mt8195-apusys_pll.o
 obj-$(CONFIG_COMMON_CLK_MT8516) += clk-mt8516.o
 obj-$(CONFIG_COMMON_CLK_MT8516_AUDSYS) += clk-mt8516-aud.o
+obj-$(CONFIG_COMMON_CLK_MTK_FREQ_HOPPING) += fhctl.o
+fhctl-objs += clk-fhctl.o clk-fhctl-ap.o clk-fhctl-pll.o
diff --git a/drivers/clk/mediatek/clk-fhctl-ap.c b/drivers/clk/mediatek/clk-fhctl-ap.c
new file mode 100644
index 000000000000..9e3226a9c1ca
--- /dev/null
+++ b/drivers/clk/mediatek/clk-fhctl-ap.c
@@ -0,0 +1,347 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/slab.h>
+#include "clk-fhctl.h"
+#include "clk-fhctl-pll.h"
+#include "clk-fhctl-util.h"
+
+#define FHCTL_TARGET FHCTL_AP
+
+#define PERCENT_TO_DDSLMT(dds, percent_m10) \
+	((((dds) * (percent_m10)) >> 5) / 100)
+
+struct fh_ap_match {
+	char *name;
+	struct fh_hdlr *hdlr;
+	int (*init)(struct pll_dts *array, struct fh_ap_match *match);
+};
+
+struct hdlr_data {
+	struct pll_dts *array;
+	struct fh_pll_domain *domain;
+	spinlock_t *lock;
+};
+
+static int fhctl_set_ssc_regs(struct fh_pll_regs *regs,
+			      struct fh_pll_data *data,
+			      int fh_id, int rate)
+{
+	unsigned int updnlmt_val;
+
+	if (rate > 0) {
+		fh_set_field(regs->reg_cfg, data->frddsx_en, 0);
+		fh_set_field(regs->reg_cfg, data->sfstrx_en, 0);
+		fh_set_field(regs->reg_cfg, data->fhctlx_en, 0);
+
+		/* Set the relative parameter registers (dt/df/upbnd/downbnd) */
+		fh_set_field(regs->reg_cfg, data->msk_frddsx_dys, data->df_val);
+		fh_set_field(regs->reg_cfg, data->msk_frddsx_dts, data->dt_val);
+
+		writel((readl(regs->reg_con_pcw) & data->dds_mask) |
+			data->tgl_org, regs->reg_dds);
+
+		/* Calculate UPDNLMT */
+		updnlmt_val = PERCENT_TO_DDSLMT((readl(regs->reg_dds) &
+						 data->dds_mask), rate) <<
+						 data->updnlmt_shft;
+
+		writel(updnlmt_val, regs->reg_updnlmt);
+
+		fh_set_field(regs->reg_hp_en, BIT(fh_id), 1);
+
+		/* Enable SSC */
+		fh_set_field(regs->reg_cfg, data->frddsx_en, 1);
+		/* Enable Hopping control */
+		fh_set_field(regs->reg_cfg, data->fhctlx_en, 1);
+
+	} else {
+		fh_set_field(regs->reg_cfg, data->frddsx_en, 0);
+		fh_set_field(regs->reg_cfg, data->sfstrx_en, 0);
+		fh_set_field(regs->reg_cfg, data->fhctlx_en, 0);
+
+		/* Switch to APMIXEDSYS control */
+		fh_set_field(regs->reg_hp_en, BIT(fh_id), 0);
+
+		/* Wait for DDS to be stable */
+		udelay(30);
+	}
+
+	return 0;
+}
+
+static int hopping_hw_flow(void *priv_data, char *domain_name, int fh_id,
+			   unsigned int new_dds, int postdiv)
+{
+	struct fh_pll_domain *domain;
+	struct fh_pll_regs *regs;
+	struct fh_pll_data *data;
+	unsigned int dds_mask;
+	unsigned int mon_dds = 0;
+	int ret = 0;
+	unsigned int con_pcw_tmp;
+	struct hdlr_data *d = (struct hdlr_data *)priv_data;
+	struct pll_dts *array = d->array;
+
+	domain = d->domain;
+	regs = &domain->regs[fh_id];
+	data = &domain->data[fh_id];
+	dds_mask = data->dds_mask;
+
+	if (array->ssc_rate)
+		fhctl_set_ssc_regs(regs, data, fh_id, 0);
+
+	writel((readl(regs->reg_con_pcw) & dds_mask) |
+		data->tgl_org, regs->reg_dds);
+
+	fh_set_field(regs->reg_cfg, data->sfstrx_en, 1);
+	fh_set_field(regs->reg_cfg, data->fhctlx_en, 1);
+	writel(data->slope0_value, regs->reg_slope0);
+	writel(data->slope1_value, regs->reg_slope1);
+
+	fh_set_field(regs->reg_hp_en, BIT(fh_id), 1);
+	writel((new_dds) | (data->dvfs_tri), regs->reg_dvfs);
+
+	/* Wait 1000 us until DDS stable */
+	ret = readl_poll_timeout_atomic(regs->reg_mon, mon_dds,
+				(mon_dds & dds_mask) == new_dds, 10, 1000);
+
+	con_pcw_tmp = readl(regs->reg_con_pcw) & (~dds_mask);
+	con_pcw_tmp = (con_pcw_tmp | (readl(regs->reg_mon) & dds_mask) |
+		       data->pcwchg);
+
+	writel(con_pcw_tmp, regs->reg_con_pcw);
+
+	fh_set_field(regs->reg_hp_en, BIT(fh_id), 0);
+
+	if (array->ssc_rate)
+		fhctl_set_ssc_regs(regs, data, fh_id, array->ssc_rate);
+
+	return ret;
+}
+
+static unsigned int __get_postdiv(struct fh_pll_regs *regs,
+				  struct fh_pll_data *data)
+{
+	unsigned int regval;
+
+	regval = (readl(regs->reg_con_postdiv) & data->postdiv_mask)
+		  >> data->postdiv_offset;
+
+	return data->postdiv_table[regval];
+}
+
+static void __set_postdiv(struct fh_pll_regs *regs, struct fh_pll_data *data,
+			  int postdiv)
+{
+	unsigned int regval, temp;
+
+	for (regval = 0 ; regval < data->postdiv_table_size ; regval++) {
+		if (data->postdiv_table[regval] > postdiv) {
+			regval--;
+			break;
+		}
+	}
+
+	temp = (readl(regs->reg_con_postdiv)) & ~(data->postdiv_mask);
+	temp |= regval << data->postdiv_offset;
+	writel(temp, regs->reg_con_postdiv);
+}
+
+static int fhctl_ap_hopping(void *priv_data, char *domain_name, int fh_id,
+			    unsigned int new_dds, int postdiv)
+{
+	struct fh_pll_domain *domain;
+	struct fh_pll_regs *regs;
+	struct fh_pll_data *data;
+	int ret = 0;
+	struct hdlr_data *d = (struct hdlr_data *)priv_data;
+	spinlock_t *lock = d->lock;
+	unsigned long flags = 0;
+	unsigned int pll_postdiv;
+
+	domain = d->domain;
+	regs = &domain->regs[fh_id];
+	data = &domain->data[fh_id];
+
+	if (postdiv > 0) {
+		pll_postdiv = __get_postdiv(regs, data);
+
+		if (postdiv > pll_postdiv)
+			__set_postdiv(regs, data, postdiv);
+	}
+
+	spin_lock_irqsave(lock, flags);
+
+	ret = hopping_hw_flow(priv_data, domain_name, fh_id, new_dds, postdiv);
+
+	spin_unlock_irqrestore(lock, flags);
+
+	if (postdiv > 0) {
+		if (postdiv < pll_postdiv)
+			__set_postdiv(regs, data, postdiv);
+	}
+
+	return ret;
+}
+
+static int fhctl_ap_ssc_enable(void *priv_data, char *domain_name,
+			       int fh_id, int rate)
+{
+	struct fh_pll_domain *domain;
+	struct fh_pll_regs *regs;
+	struct fh_pll_data *data;
+	struct hdlr_data *d = (struct hdlr_data *)priv_data;
+	spinlock_t *lock = d->lock;
+	struct pll_dts *array = d->array;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(lock, flags);
+
+	domain = d->domain;
+	regs = &domain->regs[fh_id];
+	data = &domain->data[fh_id];
+
+	fhctl_set_ssc_regs(regs, data, fh_id, rate);
+
+	array->ssc_rate = rate;
+
+	spin_unlock_irqrestore(lock, flags);
+
+	return 0;
+}
+
+static int fhctl_ap_ssc_disable(void *priv_data, char *domain_name, int fh_id)
+{
+	struct fh_pll_domain *domain;
+	struct fh_pll_regs *regs;
+	struct fh_pll_data *data;
+	struct hdlr_data *d = (struct hdlr_data *)priv_data;
+	spinlock_t *lock = d->lock;
+	struct pll_dts *array = d->array;
+	unsigned long flags = 0;
+
+	spin_lock_irqsave(lock, flags);
+
+	domain = d->domain;
+	regs = &domain->regs[fh_id];
+	data = &domain->data[fh_id];
+
+	fhctl_set_ssc_regs(regs, data, fh_id, 0);
+
+	array->ssc_rate = 0;
+
+	spin_unlock_irqrestore(lock, flags);
+
+	return 0;
+}
+
+static int fhctl_ap_hw_init(struct pll_dts *array, struct fh_ap_match *match)
+{
+	static DEFINE_SPINLOCK(lock);
+	struct hdlr_data *priv_data;
+	struct fh_hdlr *hdlr;
+	struct fh_pll_domain *domain;
+	int fh_id = array->fh_id;
+	struct fh_pll_regs *regs;
+	struct fh_pll_data *data;
+	int mask = BIT(fh_id);
+
+	priv_data = kzalloc(sizeof(*priv_data), GFP_KERNEL);
+	hdlr = kzalloc(sizeof(*hdlr), GFP_KERNEL);
+	init_fh_domain(array->domain, array->comp, array->fhctl_base,
+		       array->apmixed_base);
+
+	priv_data->array = array;
+	priv_data->lock = &lock;
+	priv_data->domain = get_fh_domain(array->domain);
+
+	/* do HW init */
+	domain = priv_data->domain;
+	regs = &domain->regs[fh_id];
+	data = &domain->data[fh_id];
+
+	fh_set_field(regs->reg_clk_con, mask, 1);
+	fh_set_field(regs->reg_rst_con, mask, 0);
+	fh_set_field(regs->reg_rst_con, mask, 1);
+	writel(0x0, regs->reg_cfg);
+	writel(0x0, regs->reg_updnlmt);
+	writel(0x0, regs->reg_dds);
+
+	/* hook to array */
+	hdlr->data = priv_data;
+	hdlr->ops = match->hdlr->ops;
+	/* hook hdlr to array is the last step */
+	mb();
+	array->hdlr = hdlr;
+
+	/* do SSC */
+	if (array->ssc_rate) {
+		struct fh_hdlr *hdlr = array->hdlr;
+
+		hdlr->ops->ssc_enable(hdlr->data, array->domain, array->fh_id,
+				      array->ssc_rate);
+	}
+
+	return 0;
+}
+
+static struct fh_operation fhctl_ap_ops = {
+	.hopping = fhctl_ap_hopping,
+	.ssc_enable = fhctl_ap_ssc_enable,
+	.ssc_disable = fhctl_ap_ssc_disable,
+};
+
+static struct fh_hdlr mt8186_hdlr = {
+	.ops = &fhctl_ap_ops,
+};
+
+static struct fh_ap_match mt8186_match = {
+	.name = "mediatek,mt8186-fhctl",
+	.hdlr = &mt8186_hdlr,
+	.init = &fhctl_ap_hw_init,
+};
+
+static struct fh_ap_match *matches[] = {
+	&mt8186_match,
+	NULL,
+};
+
+int fhctl_ap_init(struct pll_dts *array)
+{
+	int i;
+	int num_pll = array->num_pll;
+	struct fh_ap_match **match = matches;
+
+	/* find match by compatible */
+	for (i = 0; i < ARRAY_SIZE(matches); i++) {
+		char *comp = (*match)->name;
+		char *target = array->comp;
+
+		if (!strcmp(comp, target))
+			break;
+		match++;
+	}
+
+	if (*match == NULL)
+		return -1;
+
+	/* init flow for every pll */
+	for (i = 0; i < num_pll; i++, array++) {
+		char *method = array->method;
+
+		if (!strcmp(method, FHCTL_TARGET))
+			(*match)->init(array, *match);
+	}
+
+	return 0;
+}
diff --git a/drivers/clk/mediatek/clk-fhctl-pll.c b/drivers/clk/mediatek/clk-fhctl-pll.c
new file mode 100644
index 000000000000..b3ccbbd04e1b
--- /dev/null
+++ b/drivers/clk/mediatek/clk-fhctl-pll.c
@@ -0,0 +1,209 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include "clk-fhctl-pll.h"
+#include "clk-fhctl-util.h"
+
+#define REG_ADDR(base, x) ((void __iomem *)((unsigned long)base + (x)))
+
+struct fh_pll_match {
+	char *compatible;
+	struct fh_pll_domain **domain_list;
+};
+
+static int fhctl_pll_init(struct fh_pll_domain *d, void __iomem *fhctl_base,
+			  void __iomem *apmixed_base)
+{
+	struct fh_pll_data *data = d->data;
+	struct fh_pll_offset *offset = d->offset;
+	struct fh_pll_regs *regs = d->regs;
+
+	if (regs->reg_hp_en)
+		return 0;
+
+	while (data->dds_mask != 0) {
+		int regs_offset;
+
+		/* fhctl common part */
+		regs->reg_hp_en = REG_ADDR(fhctl_base, offset->offset_hp_en);
+		regs->reg_clk_con = REG_ADDR(fhctl_base,
+					     offset->offset_clk_con);
+		regs->reg_rst_con = REG_ADDR(fhctl_base,
+					     offset->offset_rst_con);
+		regs->reg_slope0 = REG_ADDR(fhctl_base, offset->offset_slope0);
+		regs->reg_slope1 = REG_ADDR(fhctl_base, offset->offset_slope1);
+
+		/* fhctl pll part */
+		regs_offset = offset->offset_fhctl + offset->offset_cfg;
+		regs->reg_cfg = REG_ADDR(fhctl_base, regs_offset);
+		regs->reg_updnlmt = REG_ADDR(regs->reg_cfg,
+					     offset->offset_updnlmt);
+		regs->reg_dds = REG_ADDR(regs->reg_cfg, offset->offset_dds);
+		regs->reg_dvfs = REG_ADDR(regs->reg_cfg, offset->offset_dvfs);
+		regs->reg_mon = REG_ADDR(regs->reg_cfg, offset->offset_mon);
+
+		/* apmixed part */
+		regs->reg_con_pcw = REG_ADDR(apmixed_base,
+					     offset->offset_con_pcw);
+		regs->reg_con_postdiv = REG_ADDR(apmixed_base,
+						 offset->offset_con_postdiv);
+
+		data++;
+		offset++;
+		regs++;
+	}
+
+	return 0;
+}
+
+static unsigned int __postdiv_pow_tbl[8] = {1, 2, 4, 8, 16, 1, 1, 1};
+#define POSTDIV_TABLE_SIZE (sizeof(__postdiv_pow_tbl)\
+	/sizeof(unsigned int))
+
+#define SIZE_8186_TOP (sizeof(mt8186_top_data)\
+	/sizeof(struct fh_pll_data))
+#define DATA_8186_TOP(_name) {						\
+		.name = _name,						\
+		.dds_mask = GENMASK(21, 0),				\
+		.postdiv_mask = GENMASK(26, 24),			\
+		.postdiv_offset = 24,					\
+		.postdiv_table = __postdiv_pow_tbl,			\
+		.postdiv_table_size = POSTDIV_TABLE_SIZE,		\
+		.slope0_value = 0x6003c97,				\
+		.slope1_value = 0x6003c97,				\
+		.sfstrx_en = BIT(2),					\
+		.frddsx_en = BIT(1),					\
+		.fhctlx_en = BIT(0),					\
+		.tgl_org = BIT(31),					\
+		.dvfs_tri = BIT(31),					\
+		.pcwchg = BIT(31),					\
+		.dt_val = 0x0,						\
+		.df_val = 0x9,						\
+		.updnlmt_shft = 16,					\
+		.msk_frddsx_dys = GENMASK(23, 20),			\
+		.msk_frddsx_dts = GENMASK(19, 16),			\
+	}
+#define OFFSET_8186_TOP(_fhctl, _con_pcw) {				\
+		.offset_fhctl = _fhctl,					\
+		.offset_con_pcw = _con_pcw,				\
+		.offset_con_postdiv = _con_pcw,				\
+		.offset_hp_en = 0x0,					\
+		.offset_clk_con = 0x8,					\
+		.offset_rst_con = 0xc,					\
+		.offset_slope0 = 0x10,					\
+		.offset_slope1 = 0x14,					\
+		.offset_cfg = 0x0,					\
+		.offset_updnlmt = 0x4,					\
+		.offset_dds = 0x8,					\
+		.offset_dvfs = 0xc,					\
+		.offset_mon = 0x10,					\
+	}
+static struct fh_pll_data mt8186_top_data[] = {
+	DATA_8186_TOP("armpll_ll"),
+	DATA_8186_TOP("armpll_bl"),
+	DATA_8186_TOP("ccipll"),
+	DATA_8186_TOP("mainpll"),
+	DATA_8186_TOP("mmpll"),
+	DATA_8186_TOP("tvdpll"),
+	DATA_8186_TOP("mpll"),
+	DATA_8186_TOP("adsppll"),
+	DATA_8186_TOP("mfgpll"),
+	DATA_8186_TOP("nnapll"),
+	DATA_8186_TOP("nna2pll"),
+	DATA_8186_TOP("msdcpll"),
+	DATA_8186_TOP("mempll"),
+	{}
+};
+static struct fh_pll_offset mt8186_top_offset[] = {
+	OFFSET_8186_TOP(0x003C, 0x0208),
+	OFFSET_8186_TOP(0x0050, 0x0218),
+	OFFSET_8186_TOP(0x0064, 0x0228),
+	OFFSET_8186_TOP(0x0078, 0x0248),
+	OFFSET_8186_TOP(0x008C, 0x0258),
+	OFFSET_8186_TOP(0x00A0, 0x0268),
+	OFFSET_8186_TOP(0x00B4, 0x0278),
+	OFFSET_8186_TOP(0x00C8, 0x0308),
+	OFFSET_8186_TOP(0x00DC, 0x0318),
+	OFFSET_8186_TOP(0x00F0, 0x0360),
+	OFFSET_8186_TOP(0x0104, 0x0370),
+	OFFSET_8186_TOP(0x0118, 0x0390),
+	OFFSET_8186_TOP(0x012c, 0xdeb1),
+	{}
+};
+static struct fh_pll_regs mt8186_top_regs[SIZE_8186_TOP];
+static struct fh_pll_domain mt8186_top = {
+	.name = "top",
+	.data = (struct fh_pll_data *)&mt8186_top_data,
+	.offset = (struct fh_pll_offset *)&mt8186_top_offset,
+	.regs = (struct fh_pll_regs *)&mt8186_top_regs,
+	.init = &fhctl_pll_init,
+};
+static struct fh_pll_domain *mt8186_domain[] = {
+	&mt8186_top,
+	NULL,
+};
+static struct fh_pll_match mt8186_match = {
+	.compatible = "mediatek,mt8186-fhctl",
+	.domain_list = (struct fh_pll_domain **)mt8186_domain,
+};
+
+static const struct fh_pll_match *matches[] = {
+	&mt8186_match,
+	NULL
+};
+
+
+static struct fh_pll_domain **get_list(char *comp)
+{
+	struct fh_pll_match **match;
+	static struct fh_pll_domain **list;
+	int i;
+
+	match = (struct fh_pll_match **)matches;
+
+	/* name used only if !list */
+	if (!list) {
+		for (i = 0; i < ARRAY_SIZE(matches); i++) {
+			if (!strcmp(comp, (*match)->compatible)) {
+				list = (*match)->domain_list;
+				break;
+			}
+			match++;
+		}
+	}
+	return list;
+}
+void init_fh_domain(const char *domain, char *comp, void __iomem *fhctl_base,
+		    void __iomem *apmixed_base)
+{
+	struct fh_pll_domain **list;
+
+	list = get_list(comp);
+
+	while (*list != NULL) {
+		if (!strcmp(domain, (*list)->name)) {
+			(*list)->init(*list, fhctl_base, apmixed_base);
+			return;
+		}
+		list++;
+	}
+}
+
+struct fh_pll_domain *get_fh_domain(const char *domain)
+{
+	struct fh_pll_domain **list;
+
+	list = get_list(NULL);
+
+	/* find instance */
+	while (*list != NULL) {
+		if (!strcmp(domain, (*list)->name))
+			return *list;
+		list++;
+	}
+	return NULL;
+}
diff --git a/drivers/clk/mediatek/clk-fhctl-pll.h b/drivers/clk/mediatek/clk-fhctl-pll.h
new file mode 100644
index 000000000000..7f0f7577f7a5
--- /dev/null
+++ b/drivers/clk/mediatek/clk-fhctl-pll.h
@@ -0,0 +1,74 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef __CLK_FHCTL_PLL_H
+#define __CLK_FHCTL_PLL_H
+#include <linux/types.h>
+#include <linux/bitops.h>
+#include <linux/iopoll.h>
+
+struct fh_pll_data {
+	char *name;
+	unsigned int dds_mask;
+	unsigned int postdiv_mask;
+	unsigned int postdiv_offset;
+	unsigned int *postdiv_table;
+	unsigned int postdiv_table_size;
+	unsigned int slope0_value;
+	unsigned int slope1_value;
+	unsigned int sfstrx_en;
+	unsigned int frddsx_en;
+	unsigned int fhctlx_en;
+	unsigned int tgl_org;
+	unsigned int dvfs_tri;
+	unsigned int pcwchg;
+	unsigned int dt_val;
+	unsigned int df_val;
+	unsigned int updnlmt_shft;
+	unsigned int msk_frddsx_dys;
+	unsigned int msk_frddsx_dts;
+};
+struct fh_pll_offset {
+	int offset_fhctl;
+	int offset_con_pcw;
+	int offset_con_postdiv;
+	int offset_hp_en;
+	int offset_clk_con;
+	int offset_rst_con;
+	int offset_slope0;
+	int offset_slope1;
+	int offset_cfg;
+	int offset_updnlmt;
+	int offset_dds;
+	int offset_dvfs;
+	int offset_mon;
+};
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
+	void __iomem *reg_con_pcw;
+	void __iomem *reg_con_postdiv;
+};
+struct fh_pll_domain {
+	char *name;
+	struct fh_pll_data *data;
+	struct fh_pll_offset *offset;
+	struct fh_pll_regs *regs;
+	int (*init)(struct fh_pll_domain *d, void __iomem *fhctl_base,
+		    void __iomem *apmixed_base);
+};
+extern struct fh_pll_domain *get_fh_domain(const char *name);
+extern void init_fh_domain(const char *domain_name, char *comp_name,
+			   void __iomem *fhctl_base,
+			   void __iomem *apmixed_base);
+#endif
diff --git a/drivers/clk/mediatek/clk-fhctl-util.h b/drivers/clk/mediatek/clk-fhctl-util.h
new file mode 100644
index 000000000000..824ed94b9f79
--- /dev/null
+++ b/drivers/clk/mediatek/clk-fhctl-util.h
@@ -0,0 +1,24 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2020 MediaTek Inc.
+ * Author: Yu-Chang Wang <Yu-Chang.Wang@mediatek.com>
+ */
+
+#ifndef __CLK_FHCTL_UTIL_H
+#define __CLK_FHCTL_UTIL_H
+
+#define fh_set_field(reg, field, val) \
+do { \
+	unsigned int tv = readl(reg); \
+	tv &= ~(field); \
+	tv |= ((val) << (ffs(field) - 1)); \
+	writel(tv, reg); \
+} while (0)
+
+#define fh_get_field(reg, field, val) \
+do { \
+	unsigned int tv = readl(reg); \
+	val = ((tv & (field)) >> (ffs(field) - 1)); \
+} while (0)
+
+#endif
diff --git a/drivers/clk/mediatek/clk-fhctl.c b/drivers/clk/mediatek/clk-fhctl.c
new file mode 100644
index 000000000000..606245f84d71
--- /dev/null
+++ b/drivers/clk/mediatek/clk-fhctl.c
@@ -0,0 +1,191 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#include <linux/device.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/string.h>
+#include <linux/list.h>
+#include <linux/spinlock.h>
+#include <linux/slab.h>
+#include "clk-fhctl.h"
+#include "clk-fhctl-util.h"
+#include "clk-mtk.h"
+
+static struct pll_dts *_array;
+
+bool mtk_clk_try_freq_hopping(const char *pll_name, unsigned long dds,
+			      int postdiv)
+{
+	int i;
+	struct fh_hdlr *hdlr = NULL;
+	struct pll_dts *array;
+	int num_pll;
+
+	if (_array == NULL)
+		return false;
+
+	array = _array;
+	num_pll = array->num_pll;
+
+	for (i = 0; i < num_pll; i++, array++) {
+		if (!strcmp(pll_name, array->pll_name)) {
+			hdlr = array->hdlr;
+			break;
+		}
+	}
+
+	if (hdlr && (array->perms & PERM_DRV_HOP)) {
+		hdlr->ops->hopping(hdlr->data, array->domain, array->fh_id,
+				   dds, postdiv);
+		return true;
+	}
+
+	return false;
+}
+EXPORT_SYMBOL_GPL(mtk_clk_try_freq_hopping);
+
+static struct pll_dts *parse_dt(struct platform_device *pdev)
+{
+	struct device_node *root, *map, *of_pll;
+	unsigned int num_pll = 0;
+	int iomap_idx = 0;
+	struct pll_dts *array;
+	int pll_idx = 0;
+	const struct of_device_id *match;
+
+	root = pdev->dev.of_node;
+	match = of_match_node(pdev->dev.driver->of_match_table, root);
+
+	/* iterate dts to get pll count */
+	for_each_child_of_node(root, map) {
+		for_each_child_of_node(map, of_pll) {
+			num_pll++;
+		}
+	}
+
+	array = kzalloc(sizeof(*array) * num_pll, GFP_KERNEL);
+
+	for_each_child_of_node(root, map) {
+		void __iomem *fhctl_base, *apmixed_base;
+		char *domain, *method;
+		int num = 0;
+
+		fhctl_base = of_iomap(root, iomap_idx++);
+		apmixed_base = of_iomap(root, iomap_idx++);
+		of_property_read_string(map, "domain", (const char **)&domain);
+		of_property_read_string(map, "method", (const char **)&method);
+
+		for_each_child_of_node(map, of_pll) {
+			int fh_id, perms, ssc_rate;
+
+			if (pll_idx >= num_pll) {
+				pll_idx++;
+				continue;
+			}
+
+			/* default for optional field */
+			perms = 0xffffffff;
+			ssc_rate = 0;
+
+			of_property_read_u32(of_pll, "fh-id", &fh_id);
+			of_property_read_u32(of_pll, "perms", &perms);
+			of_property_read_u32(of_pll, "ssc-rate", &ssc_rate);
+			array[pll_idx].num_pll = num_pll;
+			array[pll_idx].comp = (char *)match->compatible;
+			array[pll_idx].pll_name = (char *)of_pll->name;
+			array[pll_idx].fh_id = fh_id;
+			array[pll_idx].perms = perms;
+			array[pll_idx].ssc_rate = ssc_rate;
+			array[pll_idx].domain = domain;
+			array[pll_idx].method = method;
+			array[pll_idx].fhctl_base = fhctl_base;
+			array[pll_idx].apmixed_base = apmixed_base;
+			num++;
+			pll_idx++;
+		}
+	}
+
+	return array;
+}
+
+static int fh_plt_drv_probe(struct platform_device *pdev)
+{
+	int i, ret;
+	struct pll_dts *array;
+
+	/* convert dt to data */
+	array = parse_dt(pdev);
+
+	ret = fhctl_ap_init(array);
+	if (ret)
+		return -1;
+
+	/* make sure array is complete */
+	for (i = 0; i < array->num_pll; i++) {
+		struct fh_hdlr *hdlr = array[i].hdlr;
+
+		if (!hdlr) {
+			dev_err(&pdev->dev, "Failed to set %s hdlr\n",
+				array->pll_name);
+			return -1;
+		}
+	}
+
+	/* make sure init complete */
+	mb();
+	_array = array;
+
+	return 0;
+}
+
+static void fh_plt_drv_shutdown(struct platform_device *pdev)
+{
+	struct pll_dts *array = _array;
+	int num_pll = array->num_pll;
+	int i;
+
+	for (i = 0; i < num_pll; i++, array++) {
+		struct fh_hdlr *hdlr = array->hdlr;
+
+		if (array->ssc_rate)
+			hdlr->ops->ssc_disable(hdlr->data, array->domain,
+					       array->fh_id);
+	}
+}
+
+static const struct of_device_id fh_of_match[] = {
+	{ .compatible = "mediatek,mt8186-fhctl"},
+	{}
+};
+
+static struct platform_driver fhctl_driver = {
+	.probe = fh_plt_drv_probe,
+	.shutdown = fh_plt_drv_shutdown,
+	.driver = {
+		.name = "mtk-fhctl",
+		.owner = THIS_MODULE,
+		.of_match_table = fh_of_match,
+	},
+};
+
+static int __init fhctl_driver_init(void)
+{
+	return platform_driver_register(&fhctl_driver);
+}
+device_initcall_sync(fhctl_driver_init);
+
+static void __exit fhctl_driver_exit(void)
+{
+	platform_driver_unregister(&fhctl_driver);
+}
+module_exit(fhctl_driver_exit);
+
+MODULE_LICENSE("GPL");
+MODULE_DESCRIPTION("MediaTek FHCTL Driver");
+MODULE_AUTHOR("Kuan-Hsin Lee <kuan-hsin.lee@mediatek.com>");
diff --git a/drivers/clk/mediatek/clk-fhctl.h b/drivers/clk/mediatek/clk-fhctl.h
new file mode 100644
index 000000000000..b53a99d6cac7
--- /dev/null
+++ b/drivers/clk/mediatek/clk-fhctl.h
@@ -0,0 +1,45 @@
+/* SPDX-License-Identifier: GPL-2.0 */
+/*
+ * Copyright (c) 2022 MediaTek Inc.
+ */
+
+#ifndef __CLK_FHCTL_H
+#define __CLK_FHCTL_H
+
+struct fh_operation {
+	int (*hopping)(void *data, char *domain, int fh_id,
+		       unsigned int new_dds, int postdiv);
+	int (*ssc_enable)(void *data, char *domain, int fh_id, int rate);
+	int (*ssc_disable)(void *data, char *domain, int fh_id);
+};
+
+struct fh_hdlr {
+	void *data;
+	struct fh_operation *ops;
+};
+
+struct pll_dts {
+	char *comp;
+	int num_pll;
+	char *domain;
+	char *method;
+	char *pll_name;
+	int fh_id;
+	int perms;
+	int ssc_rate;
+	void __iomem *fhctl_base;
+	void __iomem *apmixed_base;
+	struct fh_hdlr *hdlr;
+};
+
+#define PERM_DRV_HOP BIT(0)
+#define PERM_DRV_SSC BIT(1)
+#define PERM_DBG_HOP BIT(2)
+#define PERM_DBG_SSC BIT(3)
+#define PERM_DBG_DUMP BIT(4)
+
+#define FHCTL_AP "fhctl-ap"
+
+extern int fhctl_ap_init(struct pll_dts *array);
+
+#endif
diff --git a/drivers/clk/mediatek/clk-pll.c b/drivers/clk/mediatek/clk-pll.c
index 54e6cfd29dfc..1acd21ca4b93 100644
--- a/drivers/clk/mediatek/clk-pll.c
+++ b/drivers/clk/mediatek/clk-pll.c
@@ -206,7 +206,10 @@ static int mtk_pll_set_rate(struct clk_hw *hw, unsigned long rate,
 	u32 postdiv;
 
 	mtk_pll_calc_values(pll, &pcw, &postdiv, rate, parent_rate);
-	mtk_pll_set_rate_regs(pll, pcw, postdiv);
+#ifdef CONFIG_COMMON_CLK_MTK_FREQ_HOPPING
+	if (!mtk_clk_try_freq_hopping(pll->data->name, pcw, postdiv))
+#endif
+		mtk_pll_set_rate_regs(pll, pcw, postdiv);
 
 	return 0;
 }
diff --git a/drivers/clk/mediatek/clk-pll.h b/drivers/clk/mediatek/clk-pll.h
index fe3199715688..e95f5f48f308 100644
--- a/drivers/clk/mediatek/clk-pll.h
+++ b/drivers/clk/mediatek/clk-pll.h
@@ -54,4 +54,9 @@ int mtk_clk_register_plls(struct device_node *node,
 void mtk_clk_unregister_plls(const struct mtk_pll_data *plls, int num_plls,
 			     struct clk_hw_onecell_data *clk_data);
 
+#ifdef CONFIG_COMMON_CLK_MTK_FREQ_HOPPING
+extern bool mtk_clk_try_freq_hopping(const char *pll_name, unsigned long dds,
+				     int postdiv);
+#endif
+
 #endif /* __DRV_CLK_MTK_PLL_H */
-- 
2.18.0

