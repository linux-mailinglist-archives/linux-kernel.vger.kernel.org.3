Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D922D47077F
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:38:07 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S241625AbhLJRlj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:41:39 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:33584 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S241557AbhLJRld (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:41:33 -0500
X-UUID: d5c6992135e744048f94af3ea3afd25f-20211211
X-UUID: d5c6992135e744048f94af3ea3afd25f-20211211
Received: from mtkcas10.mediatek.inc [(172.21.101.39)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-SHA384 256/256)
        with ESMTP id 384329904; Sat, 11 Dec 2021 01:37:54 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n1.mediatek.inc (172.21.101.16) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:37:53 +0800
Received: from mtkcas10.mediatek.inc (172.21.101.39) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 01:37:52 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas10.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:37:52 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>
CC:     <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>, "Flora Fu" <flora.fu@mediatek.com>,
        Yong Wu <yong.wu@mediatek.com>, JB Tsai <jb.tsai@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH 3/6] soc: mediatek: apu: Add MT8195 apu power domain
Date:   Sat, 11 Dec 2021 01:37:40 +0800
Message-ID: <20211210173743.30906-4-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210173743.30906-1-flora.fu@mediatek.com>
References: <20211210173743.30906-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add MT8195 apu power domain settings.
The clock and pll controller shall be accessed
through SMC call and the power domain shall be enable
before access MT8195 APU.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 drivers/soc/mediatek/apusys/mtk-apu-pm.c | 124 +++++++++++++++++++++++
 1 file changed, 124 insertions(+)

diff --git a/drivers/soc/mediatek/apusys/mtk-apu-pm.c b/drivers/soc/mediatek/apusys/mtk-apu-pm.c
index 10dd30052c46..7be5acb75d78 100644
--- a/drivers/soc/mediatek/apusys/mtk-apu-pm.c
+++ b/drivers/soc/mediatek/apusys/mtk-apu-pm.c
@@ -3,6 +3,7 @@
  * Copyright (c) 2021 MediaTek Inc.
  */
 
+#include <linux/arm-smccc.h>
 #include <linux/clk.h>
 #include <linux/clk-provider.h>
 #include <linux/init.h>
@@ -18,9 +19,12 @@
 #include <linux/pm_domain.h>
 #include <linux/regmap.h>
 #include <linux/regulator/consumer.h>
+#include <linux/soc/mediatek/mtk_sip_svc.h>
 
 #define APU_PD_IPUIF_HW_CG		BIT(0)
 #define APU_PD_RPC_AUTO_BUCK		BIT(1)
+#define APU_PD_ACC			BIT(2)
+#define APU_PD_SEC_PWR			BIT(3)
 #define APU_PD_CAPS(_pd, _x)		((_pd)->data->caps & (_x))
 
 #define MTK_POLL_DELAY_US		10
@@ -44,6 +48,11 @@ static const struct reg_sequence mt8192_rpc_sw_type[] = {
 	{ MT8192_RPC_SW_TYPE(6), 0x3 },
 };
 
+#define MTK_SIP_APUPWR_BUS_PROT_CG_ON		0x02U
+#define MTK_SIP_APUPWR_BULK_PLL			0x03U
+#define MTK_SIP_APUPWR_ACC_INIT_ALL		0x04U
+#define MTK_SIP_APUPWR_ACC_TOP			0x05U
+
 struct apu_top_domain {
 	u32 spm_ext_buck_iso;
 	u32 spm_ext_buck_iso_mask;
@@ -81,6 +90,23 @@ static struct apu_top_domain mt8192_top_reg = {
 	.num_rpc_sw = ARRAY_SIZE(mt8192_rpc_sw_type),
 };
 
+static struct apu_top_domain mt8195_top_reg = {
+	.spm_ext_buck_iso = 0x3EC,
+	.spm_ext_buck_iso_mask = 0x21,
+	.spm_cross_wake_m01 = 0x670,
+	.wake_apu = BIT(0),
+	.spm_other_pwr = 0x198,
+	.pwr_status = BIT(4),
+	.conn_clr = 0x8,
+	.conn1_clr = 0x8,
+	.vcore_clr = 0x8,
+	.rpc_top_con = 0x0,
+	.rpc_top_con_init_mask = 0x9E,
+	.rpc_top_sel = 0x4,
+	.rpc_top_intf_pwr_rdy = 0x44,
+	.pwr_rdy = BIT(0),
+};
+
 struct apusys {
 	struct device *dev;
 	struct regmap *scpsys;
@@ -125,6 +151,7 @@ static int apu_top_init_hw(struct apu_domain *pd)
 {
 	struct apusys *apusys = pd->apusys;
 	int ret;
+	struct arm_smccc_res res;
 
 	if (APU_PD_CAPS(pd, APU_PD_IPUIF_HW_CG)) {
 		ret = clk_prepare_enable(pd->clk_top_conn);
@@ -148,6 +175,15 @@ static int apu_top_init_hw(struct apu_domain *pd)
 			}
 		}
 	} else {
+		if (APU_PD_CAPS(pd, APU_PD_SEC_PWR)) {
+			arm_smccc_smc(MTK_SIP_APUSYS_CONTROL, MTK_SIP_APUPWR_BULK_PLL,
+				      1, 0, 0, 0, 0, 0, &res);
+			ret = res.a0;
+			if (ret) {
+				dev_err(apusys->dev, "apu pll smc fail: %lu\n", res.a0);
+				goto err_clk;
+			}
+		}
 		ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
 		if (ret)
 			goto err_clk;
@@ -181,6 +217,18 @@ static int apu_top_init_hw(struct apu_domain *pd)
 			goto err_clk;
 	}
 
+	if (APU_PD_CAPS(pd, APU_PD_SEC_PWR)) {
+		if (APU_PD_CAPS(pd, APU_PD_ACC)) {
+			arm_smccc_smc(MTK_SIP_APUSYS_CONTROL, MTK_SIP_APUPWR_ACC_INIT_ALL,
+				      0, 0, 0, 0, 0, 0, &res);
+			ret = res.a0;
+			if (ret) {
+				dev_err(apusys->dev, "apu acc init all fail: %lu\n", res.a0);
+				goto err_clk;
+			}
+		}
+	}
+
 	if (APU_PD_CAPS(pd, APU_PD_IPUIF_HW_CG)) {
 		clk_disable_unprepare(pd->clk_top_conn);
 		ret = clk_set_parent(pd->clk_top_ipu_if, pd->clk_off);
@@ -189,6 +237,9 @@ static int apu_top_init_hw(struct apu_domain *pd)
 			goto err_clk;
 		}
 	} else {
+		if (APU_PD_CAPS(pd, APU_PD_SEC_PWR))
+			arm_smccc_smc(MTK_SIP_APUSYS_CONTROL, MTK_SIP_APUPWR_BULK_PLL,
+				      0, 0, 0, 0, 0, 0, &res);
 		clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 	}
 
@@ -199,6 +250,9 @@ static int apu_top_init_hw(struct apu_domain *pd)
 		clk_disable_unprepare(pd->clk_top_conn);
 		clk_disable_unprepare(pd->clk_top_ipu_if);
 	} else {
+		if (APU_PD_CAPS(pd, APU_PD_SEC_PWR))
+			arm_smccc_smc(MTK_SIP_APUSYS_CONTROL, MTK_SIP_APUPWR_BULK_PLL,
+				      0, 0, 0, 0, 0, 0, &res);
 		clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 	}
 
@@ -214,16 +268,31 @@ static const struct apu_domain_data apu_domain_data_mt8192[] = {
 	}
 };
 
+static const struct apu_domain_data apu_domain_data_mt8195[] = {
+	{
+		.domain_idx = 0,
+		.name = "apu-top",
+		.caps = APU_PD_RPC_AUTO_BUCK | APU_PD_ACC | APU_PD_SEC_PWR,
+		.topd = &mt8195_top_reg,
+	}
+};
+
 static const struct apu_pm_data mt8192_apu_pm_data = {
 	.domains_data = apu_domain_data_mt8192,
 	.num_domains = ARRAY_SIZE(apu_domain_data_mt8192),
 };
 
+static const struct apu_pm_data mt8195_apu_pm_data = {
+	.domains_data = apu_domain_data_mt8195,
+	.num_domains = ARRAY_SIZE(apu_domain_data_mt8195),
+};
+
 static int apu_top_power_on(struct generic_pm_domain *genpd)
 {
 	struct apu_domain *pd = to_apu_domain(genpd);
 	struct apusys *apusys = pd->apusys;
 	int ret, tmp;
+	struct arm_smccc_res res;
 
 	if (apusys->vsram_supply) {
 		ret = regulator_enable(apusys->vsram_supply);
@@ -269,6 +338,25 @@ static int apu_top_power_on(struct generic_pm_domain *genpd)
 			}
 		}
 	} else {
+		if (APU_PD_CAPS(pd, APU_PD_SEC_PWR)) {
+			arm_smccc_smc(MTK_SIP_APUSYS_CONTROL, MTK_SIP_APUPWR_BULK_PLL,
+				      1, 0, 0, 0, 0, 0, &res);
+			ret = res.a0;
+			if (ret) {
+				dev_err(apusys->dev, "apu pll smc fail: %lu\n", res.a0);
+				goto err_clk;
+			}
+
+			if (APU_PD_CAPS(pd, APU_PD_ACC)) {
+				arm_smccc_smc(MTK_SIP_APUSYS_CONTROL, MTK_SIP_APUPWR_ACC_TOP,
+					      1, 0, 0, 0, 0, 0, &res);
+				ret = res.a0;
+				if (ret) {
+					dev_err(apusys->dev, "apu acc top smc fail: %lu\n", res.a0);
+					goto err_clk;
+				}
+			}
+		}
 		ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
 		if (ret)
 			goto err_clk;
@@ -301,6 +389,15 @@ static int apu_top_power_on(struct generic_pm_domain *genpd)
 		goto err_clk;
 	}
 
+	if (APU_PD_CAPS(pd, APU_PD_SEC_PWR)) {
+		arm_smccc_smc(MTK_SIP_APUSYS_CONTROL, MTK_SIP_APUPWR_BUS_PROT_CG_ON,
+			      0, 0, 0, 0, 0, 0, &res);
+		if (res.a0) {
+			dev_err(apusys->dev, "apu bus_prot smc fail: %lu\n", res.a0);
+			goto err_clk;
+		}
+	}
+
 	if (apusys->vcore) {
 		ret = regmap_write(apusys->vcore,
 				   pd->data->topd->vcore_clr, CG_CLR);
@@ -329,6 +426,9 @@ static int apu_top_power_on(struct generic_pm_domain *genpd)
 		clk_disable_unprepare(pd->clk_top_conn);
 		clk_disable_unprepare(pd->clk_top_ipu_if);
 	} else {
+		if (APU_PD_CAPS(pd, APU_PD_SEC_PWR))
+			arm_smccc_smc(MTK_SIP_APUSYS_CONTROL, MTK_SIP_APUPWR_BULK_PLL,
+				      0, 0, 0, 0, 0, 0, &res);
 		clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 	}
 	if (pd->domain_supply)
@@ -345,6 +445,7 @@ static int apu_top_power_off(struct generic_pm_domain *genpd)
 	struct apu_domain *pd = to_apu_domain(genpd);
 	struct apusys *apusys = pd->apusys;
 	int ret, tmp;
+	struct arm_smccc_res res;
 
 	if (apusys->vcore) {
 		ret = regmap_write(apusys->vcore,
@@ -405,6 +506,25 @@ static int apu_top_power_off(struct generic_pm_domain *genpd)
 			return ret;
 		}
 	} else {
+		if (APU_PD_CAPS(pd, APU_PD_SEC_PWR)) {
+			if (APU_PD_CAPS(pd, APU_PD_ACC)) {
+				arm_smccc_smc(MTK_SIP_APUSYS_CONTROL, MTK_SIP_APUPWR_ACC_TOP,
+					      0, 0, 0, 0, 0, 0, &res);
+				ret = res.a0;
+				if (ret) {
+					dev_err(apusys->dev, "apu acc top smc fail: %lu\n", res.a0);
+					return ret;
+				}
+			}
+
+			arm_smccc_smc(MTK_SIP_APUSYS_CONTROL, MTK_SIP_APUPWR_BULK_PLL,
+				      0, 0, 0, 0, 0, 0, &res);
+			ret = res.a0;
+			if (ret) {
+				dev_err(apusys->dev, "apu pll smc fail: %lu\n", res.a0);
+				return ret;
+			}
+		}
 		clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
 	}
 
@@ -610,6 +730,10 @@ static const struct of_device_id apu_pm_of_match[] = {
 		.compatible = "mediatek,mt8192-apu-pm",
 		.data = &mt8192_apu_pm_data,
 	},
+	{
+		.compatible = "mediatek,mt8195-apu-pm",
+		.data = &mt8195_apu_pm_data,
+	},
 	{ }
 };
 
-- 
2.18.0

