Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 4C13447069C
	for <lists+linux-kernel@lfdr.de>; Fri, 10 Dec 2021 18:01:54 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S244330AbhLJRFY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 10 Dec 2021 12:05:24 -0500
Received: from mailgw02.mediatek.com ([210.61.82.184]:49714 "EHLO
        mailgw02.mediatek.com" rhost-flags-OK-FAIL-OK-FAIL) by vger.kernel.org
        with ESMTP id S244296AbhLJRFV (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 10 Dec 2021 12:05:21 -0500
X-UUID: 0da35f02de9048c58683c957805230dc-20211211
X-UUID: 0da35f02de9048c58683c957805230dc-20211211
Received: from mtkmbs10n1.mediatek.inc [(172.21.101.34)] by mailgw02.mediatek.com
        (envelope-from <flora.fu@mediatek.com>)
        (Generic MTA with TLSv1.2 ECDHE-RSA-AES256-GCM-SHA384 256/256)
        with ESMTP id 1325260277; Sat, 11 Dec 2021 01:01:44 +0800
Received: from mtkexhb01.mediatek.inc (172.21.101.102) by
 mtkmbs07n2.mediatek.inc (172.21.101.141) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Sat, 11 Dec 2021 01:01:43 +0800
Received: from mtkcas11.mediatek.inc (172.21.101.40) by mtkexhb01.mediatek.inc
 (172.21.101.102) with Microsoft SMTP Server (TLS) id 15.0.1497.2; Sat, 11 Dec
 2021 01:01:42 +0800
Received: from mtksdccf07.mediatek.inc (172.21.84.99) by mtkcas11.mediatek.inc
 (172.21.101.73) with Microsoft SMTP Server id 15.0.1497.2 via Frontend
 Transport; Sat, 11 Dec 2021 01:01:42 +0800
From:   Flora Fu <flora.fu@mediatek.com>
To:     Matthias Brugger <matthias.bgg@gmail.com>,
        Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
CC:     <linux-kernel@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-mediatek@lists.infradead.org>,
        Flora Fu <flora.fu@mediatek.com>,
        "Yong Wu" <yong.wu@mediatek.com>, JB Tsai <jb.tsai@mediatek.com>,
        Pi-Cheng Chen <pi-cheng.chen@mediatek.com>,
        Chun-Jie Chen <chun-jie.chen@mediatek.com>
Subject: [PATCH v4 5/8] soc: mediatek: apu: Add apusys and add apu power domain driver
Date:   Sat, 11 Dec 2021 01:01:10 +0800
Message-ID: <20211210170113.30063-6-flora.fu@mediatek.com>
X-Mailer: git-send-email 2.18.0
In-Reply-To: <20211210170113.30063-1-flora.fu@mediatek.com>
References: <20211210170113.30063-1-flora.fu@mediatek.com>
MIME-Version: 1.0
Content-Type: text/plain
X-MTK:  N
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add the apusys in soc.
Add driver for apu power domains.
APU power domain shall be enabled before accessing the
internal sub modules.

Signed-off-by: Flora Fu <flora.fu@mediatek.com>

---
 drivers/soc/mediatek/Kconfig             |  12 +
 drivers/soc/mediatek/Makefile            |   1 +
 drivers/soc/mediatek/apusys/Kconfig      |  14 +
 drivers/soc/mediatek/apusys/Makefile     |   2 +
 drivers/soc/mediatek/apusys/mtk-apu-pm.c | 727 +++++++++++++++++++++++
 5 files changed, 756 insertions(+)
 create mode 100644 drivers/soc/mediatek/apusys/Kconfig
 create mode 100644 drivers/soc/mediatek/apusys/Makefile
 create mode 100644 drivers/soc/mediatek/apusys/mtk-apu-pm.c

diff --git a/drivers/soc/mediatek/Kconfig b/drivers/soc/mediatek/Kconfig
index fdd8bc08569e..47f003ba2e28 100644
--- a/drivers/soc/mediatek/Kconfig
+++ b/drivers/soc/mediatek/Kconfig
@@ -5,6 +5,18 @@
 menu "MediaTek SoC drivers"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
 
+config MTK_APUSYS
+	bool "MediaTek APUSYS Support"
+	select REGMAP
+	help
+	  Say yes here to add support for the MediaTek AI Processing Unit
+	  Subsystem (APUSYS).
+	  The APUSYS is a proprietary hardware in SoC to support AI
+	  operations. The drivers can be enabled individually within this menu.
+	  If unsure, say N.
+
+source "drivers/soc/mediatek/apusys/Kconfig"
+
 config MTK_CMDQ
 	tristate "MediaTek CMDQ Support"
 	depends on ARCH_MEDIATEK || COMPILE_TEST
diff --git a/drivers/soc/mediatek/Makefile b/drivers/soc/mediatek/Makefile
index 90270f8114ed..e46e7a3c21e7 100644
--- a/drivers/soc/mediatek/Makefile
+++ b/drivers/soc/mediatek/Makefile
@@ -1,4 +1,5 @@
 # SPDX-License-Identifier: GPL-2.0-only
+obj-$(CONFIG_MTK_APUSYS) += apusys/
 obj-$(CONFIG_MTK_CMDQ) += mtk-cmdq-helper.o
 obj-$(CONFIG_MTK_DEVAPC) += mtk-devapc.o
 obj-$(CONFIG_MTK_INFRACFG) += mtk-infracfg.o
diff --git a/drivers/soc/mediatek/apusys/Kconfig b/drivers/soc/mediatek/apusys/Kconfig
new file mode 100644
index 000000000000..332e323e02ae
--- /dev/null
+++ b/drivers/soc/mediatek/apusys/Kconfig
@@ -0,0 +1,14 @@
+# SPDX-License-Identifier: GPL-2.0-only
+if MTK_APUSYS
+
+config MTK_APU_PM
+	tristate "MediaTek APU power management support"
+	select REGMAP
+	select PM_GENERIC_DOMAINS if PM
+	help
+	  Say yes here to add support for power management control
+	  to MediaTek AI Processing Unit Subsystem (APUSYS).
+	  APU power domain shall be enabled before accessing the
+	  internal sub modules.
+
+endif # MTK_APUSYS
diff --git a/drivers/soc/mediatek/apusys/Makefile b/drivers/soc/mediatek/apusys/Makefile
new file mode 100644
index 000000000000..8821c0f0b7b7
--- /dev/null
+++ b/drivers/soc/mediatek/apusys/Makefile
@@ -0,0 +1,2 @@
+# SPDX-License-Identifier: GPL-2.0
+obj-$(CONFIG_MTK_APU_PM) += mtk-apu-pm.o
diff --git a/drivers/soc/mediatek/apusys/mtk-apu-pm.c b/drivers/soc/mediatek/apusys/mtk-apu-pm.c
new file mode 100644
index 000000000000..10dd30052c46
--- /dev/null
+++ b/drivers/soc/mediatek/apusys/mtk-apu-pm.c
@@ -0,0 +1,727 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021 MediaTek Inc.
+ */
+
+#include <linux/clk.h>
+#include <linux/clk-provider.h>
+#include <linux/init.h>
+#include <linux/io.h>
+#include <linux/iopoll.h>
+#include <linux/mfd/syscon.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/of_address.h>
+#include <linux/of_clk.h>
+#include <linux/of_device.h>
+#include <linux/platform_device.h>
+#include <linux/pm_domain.h>
+#include <linux/regmap.h>
+#include <linux/regulator/consumer.h>
+
+#define APU_PD_IPUIF_HW_CG		BIT(0)
+#define APU_PD_RPC_AUTO_BUCK		BIT(1)
+#define APU_PD_CAPS(_pd, _x)		((_pd)->data->caps & (_x))
+
+#define MTK_POLL_DELAY_US		10
+#define MTK_POLL_TIMEOUT		USEC_PER_SEC
+
+/* rpc_top_con*/
+#define SLEEP_REQ		BIT(0)
+#define APU_BUCK_ELS_EN		BIT(3)
+
+/*conn_clr, conn1_clr, vcore_clr */
+#define CG_CLR	(0xFFFFFFFF)
+
+/* mt8192 rpc_sw_type (0..7) */
+#define MT8192_RPC_SW_TYPE(x)	(0x200 + ((x) * 0x10))
+
+/* rpc_sw_type*/
+static const struct reg_sequence mt8192_rpc_sw_type[] = {
+	{ MT8192_RPC_SW_TYPE(0), 0xFF },
+	{ MT8192_RPC_SW_TYPE(2), 0x7 },
+	{ MT8192_RPC_SW_TYPE(3), 0x7 },
+	{ MT8192_RPC_SW_TYPE(6), 0x3 },
+};
+
+struct apu_top_domain {
+	u32 spm_ext_buck_iso;
+	u32 spm_ext_buck_iso_mask;
+	u32 spm_cross_wake_m01;
+	u32 wake_apu;
+	u32 spm_other_pwr;
+	u32 pwr_status;
+	u32 conn_clr;
+	u32 conn1_clr;
+	u32 vcore_clr;
+	u32 rpc_top_con;
+	u32 rpc_top_con_init_mask;
+	u32 rpc_top_sel;
+	u32 rpc_top_intf_pwr_rdy;
+	u32 pwr_rdy;
+	const struct reg_sequence *rpc_sw_type;
+	int num_rpc_sw;
+};
+
+static struct apu_top_domain mt8192_top_reg = {
+	.spm_ext_buck_iso = 0x39C,
+	.spm_ext_buck_iso_mask = 0x21,
+	.spm_cross_wake_m01 = 0x670,
+	.wake_apu = BIT(0),
+	.spm_other_pwr = 0x178,
+	.pwr_status = BIT(5),
+	.conn_clr = 0x8,
+	.vcore_clr = 0x8,
+	.rpc_top_con = 0x0,
+	.rpc_top_con_init_mask = 0x49E,
+	.rpc_top_sel = 0x4,
+	.rpc_top_intf_pwr_rdy = 0x44,
+	.pwr_rdy = BIT(0),
+	.rpc_sw_type = mt8192_rpc_sw_type,
+	.num_rpc_sw = ARRAY_SIZE(mt8192_rpc_sw_type),
+};
+
+struct apusys {
+	struct device *dev;
+	struct regmap *scpsys;
+	struct regmap *conn;
+	struct regmap *conn1;
+	struct regmap *vcore;
+	struct regmap *rpc;
+	struct regulator *vsram_supply;
+	const struct apu_pm_data *data;
+	struct genpd_onecell_data pd_data;
+	struct generic_pm_domain *domains[];
+};
+
+struct apu_domain {
+	struct generic_pm_domain genpd;
+	const struct apu_domain_data *data;
+	struct apusys *apusys;
+	struct regulator *domain_supply;
+	int num_clks;
+	struct clk_bulk_data *clks;
+	struct clk *clk_top_conn;
+	struct clk *clk_top_ipu_if;
+	struct clk *clk_off;
+	struct clk *clk_on_def;
+};
+
+struct apu_domain_data {
+	int domain_idx;
+	char *name;
+	struct apu_top_domain *topd;
+	u8 caps;
+};
+
+struct apu_pm_data {
+	const struct apu_domain_data *domains_data;
+	int num_domains;
+};
+
+#define to_apu_domain(gpd) container_of(gpd, struct apu_domain, genpd)
+
+static int apu_top_init_hw(struct apu_domain *pd)
+{
+	struct apusys *apusys = pd->apusys;
+	int ret;
+
+	if (APU_PD_CAPS(pd, APU_PD_IPUIF_HW_CG)) {
+		ret = clk_prepare_enable(pd->clk_top_conn);
+		if (ret) {
+			dev_err(apusys->dev, "Failed enable top_conn clk\n");
+			return ret;
+		}
+
+		ret = clk_set_parent(pd->clk_top_ipu_if, pd->clk_on_def);
+		if (ret) {
+			dev_err(apusys->dev, "Failed set ipu_if mux\n");
+			goto err_clk;
+		}
+
+		/* The ipu_if clock is gating by HW. Only enable once. */
+		if (!__clk_is_enabled(pd->clk_top_ipu_if)) {
+			ret = clk_prepare_enable(pd->clk_top_ipu_if);
+			if (ret) {
+				dev_err(apusys->dev, "Failed enable ipu_if\n");
+				goto err_clk;
+			}
+		}
+	} else {
+		ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
+		if (ret)
+			goto err_clk;
+	}
+
+	/*
+	 * set memory type to PD or sleep group
+	 * sw_type register for each memory group, set to PD mode default
+	 */
+	if (pd->data->topd->num_rpc_sw) {
+		ret = regmap_register_patch(apusys->rpc,
+					    pd->data->topd->rpc_sw_type,
+					    pd->data->topd->num_rpc_sw);
+		if (ret) {
+			dev_err(apusys->dev, "Failed to rpc patch: %d\n", ret);
+			goto err_clk;
+		}
+	}
+
+	/* mask RPC IRQ and bypass WFI */
+	ret = regmap_set_bits(apusys->rpc, pd->data->topd->rpc_top_sel,
+			      pd->data->topd->rpc_top_con_init_mask);
+	if (ret)
+		goto err_clk;
+
+	if (APU_PD_CAPS(pd, APU_PD_RPC_AUTO_BUCK)) {
+		ret = regmap_set_bits(apusys->rpc,
+				      pd->data->topd->rpc_top_con,
+				      APU_BUCK_ELS_EN);
+		if (ret)
+			goto err_clk;
+	}
+
+	if (APU_PD_CAPS(pd, APU_PD_IPUIF_HW_CG)) {
+		clk_disable_unprepare(pd->clk_top_conn);
+		ret = clk_set_parent(pd->clk_top_ipu_if, pd->clk_off);
+		if (ret) {
+			dev_err(apusys->dev, "Failed set ipu_if rate\n");
+			goto err_clk;
+		}
+	} else {
+		clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+	}
+
+	return 0;
+
+err_clk:
+	if (APU_PD_CAPS(pd, APU_PD_IPUIF_HW_CG)) {
+		clk_disable_unprepare(pd->clk_top_conn);
+		clk_disable_unprepare(pd->clk_top_ipu_if);
+	} else {
+		clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+	}
+
+	return ret;
+}
+
+static const struct apu_domain_data apu_domain_data_mt8192[] = {
+	{
+		.domain_idx = 0,
+		.name = "apu-top",
+		.caps = APU_PD_IPUIF_HW_CG,
+		.topd = &mt8192_top_reg,
+	}
+};
+
+static const struct apu_pm_data mt8192_apu_pm_data = {
+	.domains_data = apu_domain_data_mt8192,
+	.num_domains = ARRAY_SIZE(apu_domain_data_mt8192),
+};
+
+static int apu_top_power_on(struct generic_pm_domain *genpd)
+{
+	struct apu_domain *pd = to_apu_domain(genpd);
+	struct apusys *apusys = pd->apusys;
+	int ret, tmp;
+
+	if (apusys->vsram_supply) {
+		ret = regulator_enable(apusys->vsram_supply);
+		if (ret)
+			return ret;
+	}
+
+	if (pd->domain_supply) {
+		ret = regulator_enable(pd->domain_supply);
+		if (ret)
+			goto err_regulator;
+	}
+
+	ret = regmap_clear_bits(apusys->scpsys,
+				pd->data->topd->spm_ext_buck_iso,
+				pd->data->topd->spm_ext_buck_iso_mask);
+	if (ret)
+		goto err_regulator;
+
+	ret = regmap_set_bits(apusys->rpc, pd->data->topd->rpc_top_sel,
+			      pd->data->topd->rpc_top_con_init_mask);
+	if (ret)
+		goto err_regulator;
+
+	if (APU_PD_CAPS(pd, APU_PD_IPUIF_HW_CG)) {
+		ret = clk_prepare_enable(pd->clk_top_conn);
+		if (ret) {
+			dev_err(apusys->dev, "Failed enable top_conn clk\n");
+			goto err_clk;
+		}
+
+		ret = clk_set_parent(pd->clk_top_ipu_if, pd->clk_on_def);
+		if (ret) {
+			dev_err(apusys->dev, "Failed set ipu_if mux\n");
+			goto err_clk;
+		}
+
+		if (!__clk_is_enabled(pd->clk_top_ipu_if)) {
+			ret = clk_prepare_enable(pd->clk_top_ipu_if);
+			if (ret) {
+				dev_err(apusys->dev, "Failed enable ipu_if\n");
+				goto err_clk;
+			}
+		}
+	} else {
+		ret = clk_bulk_prepare_enable(pd->num_clks, pd->clks);
+		if (ret)
+			goto err_clk;
+	}
+
+	ret = regmap_set_bits(apusys->scpsys,
+			      pd->data->topd->spm_cross_wake_m01,
+			      pd->data->topd->wake_apu);
+	if (ret)
+		goto err_clk;
+
+	ret = regmap_read_poll_timeout(apusys->scpsys,
+				       pd->data->topd->spm_other_pwr,
+				       tmp,
+				       (tmp & pd->data->topd->pwr_status) ==
+				       pd->data->topd->pwr_status,
+				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(apusys->dev, "apu top on wait SPM PWR_ACK != 0\n");
+		goto err_clk;
+	}
+
+	ret = regmap_read_poll_timeout(apusys->rpc,
+				       pd->data->topd->rpc_top_intf_pwr_rdy,
+				       tmp, (tmp & pd->data->topd->pwr_rdy) ==
+				       pd->data->topd->pwr_rdy,
+				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(apusys->dev, "apu top on wait RPC PWR_RDY != 0\n");
+		goto err_clk;
+	}
+
+	if (apusys->vcore) {
+		ret = regmap_write(apusys->vcore,
+				   pd->data->topd->vcore_clr, CG_CLR);
+		if (ret)
+			goto err_clk;
+	}
+
+	if (apusys->conn) {
+		ret = regmap_write(apusys->conn,
+				   pd->data->topd->conn_clr, CG_CLR);
+		if (ret)
+			goto err_clk;
+	}
+
+	if (apusys->conn1) {
+		ret = regmap_write(apusys->conn1,
+				   pd->data->topd->conn1_clr, CG_CLR);
+		if (ret)
+			goto err_clk;
+	}
+
+	return 0;
+
+err_clk:
+	if (APU_PD_CAPS(pd, APU_PD_IPUIF_HW_CG)) {
+		clk_disable_unprepare(pd->clk_top_conn);
+		clk_disable_unprepare(pd->clk_top_ipu_if);
+	} else {
+		clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+	}
+	if (pd->domain_supply)
+		ret = regulator_disable(pd->domain_supply);
+err_regulator:
+	if (apusys->vsram_supply)
+		ret = regulator_disable(apusys->vsram_supply);
+
+	return ret;
+}
+
+static int apu_top_power_off(struct generic_pm_domain *genpd)
+{
+	struct apu_domain *pd = to_apu_domain(genpd);
+	struct apusys *apusys = pd->apusys;
+	int ret, tmp;
+
+	if (apusys->vcore) {
+		ret = regmap_write(apusys->vcore,
+				   pd->data->topd->vcore_clr, CG_CLR);
+		if (ret)
+			return ret;
+	}
+
+	if (apusys->conn) {
+		ret = regmap_write(apusys->conn,
+				   pd->data->topd->conn_clr, CG_CLR);
+		if (ret)
+			return ret;
+	}
+
+	if (apusys->conn1) {
+		ret = regmap_write(apusys->conn1,
+				   pd->data->topd->conn1_clr, CG_CLR);
+		if (ret)
+			return ret;
+	}
+
+	ret = regmap_clear_bits(apusys->scpsys,
+				pd->data->topd->spm_cross_wake_m01,
+				pd->data->topd->wake_apu);
+	if (ret)
+		return ret;
+
+	ret = regmap_set_bits(apusys->rpc,
+			      pd->data->topd->rpc_top_con, SLEEP_REQ);
+	if (ret)
+		return ret;
+
+	ret = regmap_read_poll_timeout(apusys->rpc,
+				       pd->data->topd->rpc_top_intf_pwr_rdy,
+				       tmp,
+				       (tmp & pd->data->topd->pwr_rdy) == 0x0,
+				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(apusys->dev, "apu top off wait RPC PWR_RDY != 0\n");
+		return ret;
+	}
+
+	ret = regmap_read_poll_timeout(apusys->scpsys,
+				       pd->data->topd->spm_other_pwr, tmp,
+				       (tmp & pd->data->topd->pwr_status) == 0x0,
+				       MTK_POLL_DELAY_US, MTK_POLL_TIMEOUT);
+	if (ret) {
+		dev_err(apusys->dev, "apu top off wait SPM PWR_ACK != 0\n");
+		return ret;
+	}
+
+	if (APU_PD_CAPS(pd, APU_PD_IPUIF_HW_CG)) {
+		clk_disable_unprepare(pd->clk_top_conn);
+		ret = clk_set_parent(pd->clk_top_ipu_if, pd->clk_off);
+		if (ret) {
+			dev_err(apusys->dev, "Failed set ipu_if rate\n");
+			return ret;
+		}
+	} else {
+		clk_bulk_disable_unprepare(pd->num_clks, pd->clks);
+	}
+
+	ret = regmap_set_bits(apusys->scpsys,
+			      pd->data->topd->spm_ext_buck_iso,
+			      pd->data->topd->spm_ext_buck_iso_mask);
+	if (ret)
+		return ret;
+
+	if (apusys->vsram_supply) {
+		ret = regulator_disable(apusys->vsram_supply);
+		if (ret)
+			return ret;
+	}
+
+	if (pd->domain_supply) {
+		ret = regulator_disable(pd->domain_supply);
+		if (ret)
+			return ret;
+	}
+
+	return 0;
+}
+
+static struct generic_pm_domain *apu_add_one_domain(struct apusys *apusys,
+						    struct device_node *node)
+{
+	const struct apu_domain_data *domain_data;
+	struct apu_domain *pd;
+	int ret;
+	u32 id;
+	int i;
+	struct clk *clk;
+
+	ret = of_property_read_u32(node, "reg", &id);
+	if (ret) {
+		dev_dbg(apusys->dev, "%pOF: invalid reg: %d\n", node, ret);
+		return ERR_PTR(ret);
+	}
+
+	if (id >= apusys->data->num_domains) {
+		dev_dbg(apusys->dev, "%pOF: invalid id %d\n", node, id);
+		return ERR_PTR(-EINVAL);
+	}
+
+	domain_data = &apusys->data->domains_data[id];
+
+	pd = devm_kzalloc(apusys->dev, sizeof(*pd), GFP_KERNEL);
+	if (!pd)
+		return ERR_PTR(-ENOMEM);
+
+	pd->data   = domain_data;
+	pd->apusys = apusys;
+
+	pd->domain_supply = devm_regulator_get_optional(apusys->dev, "domain");
+	if (IS_ERR(pd->domain_supply)) {
+		ret = PTR_ERR(pd->domain_supply);
+		if (ret != -EPROBE_DEFER) {
+			dev_dbg(apusys->dev, "domain_supply fail, ret=%d", ret);
+			apusys->vsram_supply = NULL;
+		}
+		return ERR_PTR(ret);
+	}
+
+	/*
+	 * For HW using ipu_if, the clock is switched to 26M
+	 * when power down top domain and switch to default clock rate
+	 * before power on.
+	 */
+	if (APU_PD_CAPS(pd, APU_PD_IPUIF_HW_CG)) {
+		pd->clk_top_conn = of_clk_get_by_name(node, "clk_top_conn");
+		if (IS_ERR(pd->clk_top_conn)) {
+			dev_err(apusys->dev, "Fail to get clk_top_conn clock\n");
+			ret = PTR_ERR(pd->clk_top_conn);
+			goto err_put_clocks;
+		}
+
+		pd->clk_top_ipu_if = of_clk_get_by_name(node, "clk_top_ipu_if");
+		if (IS_ERR(pd->clk_top_ipu_if)) {
+			dev_err(apusys->dev, "Fail to get clk_top_ipu_if clock\n");
+			ret = PTR_ERR(pd->clk_top_ipu_if);
+			goto err_put_clocks;
+		}
+
+		pd->clk_off = of_clk_get_by_name(node, "clk_off");
+		if (IS_ERR(pd->clk_off)) {
+			dev_err(apusys->dev, "Fail to get clk_off clock\n");
+			ret = PTR_ERR(pd->clk_off);
+			goto err_put_clocks;
+		}
+
+		pd->clk_on_def = of_clk_get_by_name(node, "clk_on_default");
+		if (IS_ERR(pd->clk_on_def)) {
+			dev_err(apusys->dev, "Fail to get clk_on_default clock\n");
+			ret = PTR_ERR(pd->clk_on_def);
+			goto err_put_clocks;
+		}
+	} else {
+		pd->num_clks = of_clk_get_parent_count(node);
+		if (pd->num_clks > 0) {
+			pd->clks = devm_kcalloc(apusys->dev, pd->num_clks,
+						sizeof(*pd->clks), GFP_KERNEL);
+			if (!pd->clks)
+				return ERR_PTR(-ENOMEM);
+		}
+
+		for (i = 0; i < pd->num_clks; i++) {
+			clk = of_clk_get(node, i);
+			if (IS_ERR(clk)) {
+				ret = PTR_ERR(clk);
+				dev_dbg(apusys->dev,
+					"%pOF: failed to get clk at index %d: %d\n",
+					node, i, ret);
+				goto err_put_clocks;
+			}
+			pd->clks[i].clk = clk;
+		}
+	}
+
+	if (apusys->domains[id]) {
+		ret = -EEXIST;
+		dev_err(apusys->dev, "domain id %d already exists\n", id);
+		goto err_put_clocks;
+	}
+
+	/* set rpc hw init status */
+	ret = apu_top_init_hw(pd);
+	if (ret) {
+		dev_err(apusys->dev, "top init fail ret = %d\n", ret);
+		goto err_put_clocks;
+	}
+
+	if (!pd->data->name)
+		pd->genpd.name = node->name;
+	else
+		pd->genpd.name = pd->data->name;
+	pd->genpd.power_off = apu_top_power_off;
+	pd->genpd.power_on = apu_top_power_on;
+
+	ret = pm_genpd_init(&pd->genpd, NULL, true);
+	if (ret) {
+		dev_err(apusys->dev, "init power domain fail\n");
+		goto err_put_clocks;
+	}
+
+	apusys->domains[id] = &pd->genpd;
+
+	return apusys->pd_data.domains[id];
+
+err_put_clocks:
+	if (APU_PD_CAPS(pd, APU_PD_IPUIF_HW_CG)) {
+		clk_put(pd->clk_top_conn);
+		clk_put(pd->clk_top_ipu_if);
+		clk_put(pd->clk_off);
+		clk_put(pd->clk_on_def);
+	} else {
+		clk_bulk_put(pd->num_clks, pd->clks);
+	}
+	return ERR_PTR(ret);
+}
+
+static void apu_remove_one_domain(struct apu_domain *pd)
+{
+	int ret;
+
+	/*
+	 * We're in the error cleanup already, so we only complain,
+	 * but won't emit another error on top of the original one.
+	 */
+	ret = pm_genpd_remove(&pd->genpd);
+	if (ret)
+		dev_dbg(pd->apusys->dev,
+			"Remove domain '%s' : %d - state may be inconsistent\n",
+			pd->genpd.name, ret);
+
+	if (APU_PD_CAPS(pd, APU_PD_IPUIF_HW_CG)) {
+		clk_put(pd->clk_top_conn);
+		clk_put(pd->clk_top_ipu_if);
+		clk_put(pd->clk_off);
+		clk_put(pd->clk_on_def);
+	} else {
+		clk_bulk_put(pd->num_clks, pd->clks);
+	}
+}
+
+static void apu_domain_cleanup(struct apusys *apusys)
+{
+	struct generic_pm_domain *genpd;
+	struct apu_domain *pd;
+	int i;
+
+	for (i = apusys->pd_data.num_domains - 1; i >= 0; i--) {
+		genpd = apusys->pd_data.domains[i];
+		if (genpd) {
+			pd = to_apu_domain(genpd);
+			apu_remove_one_domain(pd);
+		}
+	}
+}
+
+static const struct of_device_id apu_pm_of_match[] = {
+	{
+		.compatible = "mediatek,mt8192-apu-pm",
+		.data = &mt8192_apu_pm_data,
+	},
+	{ }
+};
+
+static int apu_pm_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct device_node *np = dev->of_node;
+	const struct apu_pm_data *data;
+	struct device_node *node;
+	struct apusys *apusys;
+	int ret;
+
+	data = of_device_get_match_data(&pdev->dev);
+	if (!data) {
+		dev_dbg(dev, "no power domain data\n");
+		return -EINVAL;
+	}
+
+	apusys = devm_kzalloc(dev,
+			      struct_size(apusys, domains, data->num_domains),
+			      GFP_KERNEL);
+	if (!apusys)
+		return -ENOMEM;
+
+	platform_set_drvdata(pdev, apusys);
+	apusys->dev = dev;
+	apusys->data = data;
+	apusys->pd_data.domains = apusys->domains;
+	apusys->pd_data.num_domains = data->num_domains;
+
+	apusys->vsram_supply = devm_regulator_get_optional(dev, "vsram");
+	if (IS_ERR(apusys->vsram_supply)) {
+		ret = PTR_ERR(apusys->vsram_supply);
+		if (ret != -EPROBE_DEFER) {
+			dev_err(dev, "vsram_supply fail, ret=%d", ret);
+			apusys->vsram_supply = NULL;
+		}
+		return ret;
+	}
+
+	/* rpc */
+	apusys->rpc = syscon_node_to_regmap(np);
+	if (IS_ERR(apusys->rpc)) {
+		dev_err(dev, "Unable to get rpc\n");
+		return PTR_ERR(apusys->rpc);
+	}
+
+	/* scpsys */
+	apusys->scpsys = syscon_regmap_lookup_by_phandle(np, "mediatek,scpsys");
+	if (IS_ERR(apusys->scpsys)) {
+		dev_err(dev, "Unable to get scpsys\n");
+		return PTR_ERR(apusys->scpsys);
+	}
+
+	/* apusys conn */
+	apusys->conn = syscon_regmap_lookup_by_phandle_optional(np, "mediatek,apu-conn");
+	if (IS_ERR(apusys->conn))
+		dev_dbg(dev, "No optional phandle apu-conn\n");
+
+	/* apusys conn1 */
+	apusys->conn1 = syscon_regmap_lookup_by_phandle_optional(np, "mediatek,apu-conn1");
+	if (IS_ERR(apusys->conn1))
+		dev_dbg(dev, "No optional phandle apu-conn1\n");
+
+	/* apusys vcore */
+	apusys->vcore = syscon_regmap_lookup_by_phandle_optional(np, "mediatek,apu-vcore");
+	if (IS_ERR(apusys->vcore))
+		dev_dbg(dev, "No optional phandle apu-vcore\n");
+
+	for_each_available_child_of_node(np, node) {
+		struct generic_pm_domain *domain;
+
+		domain = apu_add_one_domain(apusys, node);
+		if (IS_ERR(domain)) {
+			ret = PTR_ERR(domain);
+			of_node_put(node);
+			goto err_cleanup_domains;
+		}
+	}
+
+	ret = of_genpd_add_provider_onecell(np, &apusys->pd_data);
+	if (ret) {
+		dev_dbg(dev, "failed to add provider: %d\n", ret);
+		goto err_cleanup_domains;
+	}
+
+	return 0;
+
+err_cleanup_domains:
+	apu_domain_cleanup(apusys);
+	return ret;
+}
+
+static int apu_pm_remove(struct platform_device *pdev)
+{
+	struct apusys *apusys = platform_get_drvdata(pdev);
+
+	of_genpd_del_provider(pdev->dev.of_node);
+	apu_domain_cleanup(apusys);
+
+	return 0;
+}
+
+static struct platform_driver apu_pm_driver = {
+	.probe = apu_pm_probe,
+	.remove = apu_pm_remove,
+	.driver = {
+		.name = "mtk-apu-pm",
+		.suppress_bind_attrs = true,
+		.of_match_table = apu_pm_of_match,
+	},
+};
+module_platform_driver(apu_pm_driver);
+MODULE_DESCRIPTION("APU Power Domain Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.18.0

