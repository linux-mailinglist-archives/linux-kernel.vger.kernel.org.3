Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 2B5AF5684D3
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Jul 2022 12:11:54 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232589AbiGFKKS (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Jul 2022 06:10:18 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46452 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232633AbiGFKJt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Jul 2022 06:09:49 -0400
Received: from madras.collabora.co.uk (madras.collabora.co.uk [46.235.227.172])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 588C265F7;
        Wed,  6 Jul 2022 03:09:36 -0700 (PDT)
Received: from IcarusMOD.eternityproject.eu (2-237-20-237.ip236.fastwebnet.it [2.237.20.237])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (4096 bits) server-digest SHA256)
        (No client certificate requested)
        (Authenticated sender: kholk11)
        by madras.collabora.co.uk (Postfix) with ESMTPSA id 893AB66019AC;
        Wed,  6 Jul 2022 11:09:34 +0100 (BST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1657102175;
        bh=YuT8H/23PS7Vi3+aSrk4FLGl+snqzs3WJf4TzboWH/w=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=olLx/vhrb+ywUT3gMSRKje/YJZAHwtVGUCpn6s5U37dq3YQ1bzEfTOK12rtvBDIEz
         IXs4wjoCW7EtL+/cg1vXj6PgJ21T49IzKJuooG+DuPKD+4pklVd0T82Kf4qP3oH39t
         mwpafYcAubnfyiC1B85qeaOmhhtU41Xas01ge4NqOVLrq87Hn8+wF6XuX00tog0B/y
         B0sIuNInR6kWmQ4Uy8VJ5bnWG9rsE9eA5aXN/3mDV3+pBo67whAM0AQNDFQ+UKyX6K
         ystkgXF7q//N+Z9xUHGwcOZQ4AfvaTM3wlSb3Zj7vxgq+uAa4lRX6nrlUd84bCQEll
         ZilVvus1sCfag==
From:   AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@collabora.com>
To:     lgirdwood@gmail.com
Cc:     broonie@kernel.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        angelogioacchino.delregno@collabora.com,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org
Subject: [PATCH v3 RESEND 2/4] regulator: Add driver for MT6331 PMIC regulators
Date:   Wed,  6 Jul 2022 12:09:10 +0200
Message-Id: <20220706100912.200698-3-angelogioacchino.delregno@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220706100912.200698-1-angelogioacchino.delregno@collabora.com>
References: <20220706100912.200698-1-angelogioacchino.delregno@collabora.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_NONE,SPF_PASS,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add a driver for the regulators found in the MT6331 PMIC.
This PMIC features six buck and 21 Low DropOut (LDO) regulators.

Signed-off-by: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
---
 drivers/regulator/Kconfig                  |   9 +
 drivers/regulator/Makefile                 |   1 +
 drivers/regulator/mt6331-regulator.c       | 507 +++++++++++++++++++++
 include/linux/regulator/mt6331-regulator.h |  46 ++
 4 files changed, 563 insertions(+)
 create mode 100644 drivers/regulator/mt6331-regulator.c
 create mode 100644 include/linux/regulator/mt6331-regulator.h

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index cbe0f96ca342..dfb52b093c6f 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -777,6 +777,15 @@ config REGULATOR_MT6323
 	  This driver supports the control of different power rails of device
 	  through regulator interface.
 
+config REGULATOR_MT6331
+	tristate "MediaTek MT6331 PMIC"
+	depends on MFD_MT6397
+	help
+	  Say y here to select this option to enable the power regulator of
+	  MediaTek MT6331 PMIC.
+	  This driver supports the control of different power rails of device
+	  through regulator interface
+
 config REGULATOR_MT6358
 	tristate "MediaTek MT6358 PMIC"
 	depends on MFD_MT6397
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 8d3ee8b6d41d..3799e2673825 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -94,6 +94,7 @@ obj-$(CONFIG_REGULATOR_MPQ7920) += mpq7920.o
 obj-$(CONFIG_REGULATOR_MT6311) += mt6311-regulator.o
 obj-$(CONFIG_REGULATOR_MT6315) += mt6315-regulator.o
 obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
+obj-$(CONFIG_REGULATOR_MT6331)	+= mt6331-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
 obj-$(CONFIG_REGULATOR_MT6359)	+= mt6359-regulator.o
 obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
diff --git a/drivers/regulator/mt6331-regulator.c b/drivers/regulator/mt6331-regulator.c
new file mode 100644
index 000000000000..56be9a3a84ab
--- /dev/null
+++ b/drivers/regulator/mt6331-regulator.c
@@ -0,0 +1,507 @@
+// SPDX-License-Identifier: GPL-2.0
+//
+// Copyright (c) 2022 Collabora Ltd.
+// Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+//
+// Based on mt6323-regulator.c,
+//     Copyright (c) 2016 MediaTek Inc.
+//
+
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/mfd/mt6397/core.h>
+#include <linux/mfd/mt6331/registers.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/mt6331-regulator.h>
+#include <linux/regulator/of_regulator.h>
+
+#define MT6331_LDO_MODE_NORMAL	0
+#define MT6331_LDO_MODE_LP	1
+
+/*
+ * MT6331 regulators information
+ *
+ * @desc: standard fields of regulator description.
+ * @qi: Mask for query enable signal status of regulators
+ * @vselon_reg: Register sections for hardware control mode of bucks
+ * @vselctrl_reg: Register for controlling the buck control mode.
+ * @vselctrl_mask: Mask for query buck's voltage control mode.
+ * @status_reg: Register for regulator enable status where qi unavailable
+ * @status_mask: Mask for querying regulator enable status
+ */
+struct mt6331_regulator_info {
+	struct regulator_desc desc;
+	u32 qi;
+	u32 vselon_reg;
+	u32 vselctrl_reg;
+	u32 vselctrl_mask;
+	u32 modeset_reg;
+	u32 modeset_mask;
+	u32 status_reg;
+	u32 status_mask;
+};
+
+#define MT6331_BUCK(match, vreg, min, max, step, volt_ranges, enreg,	\
+		vosel, vosel_mask, voselon, vosel_ctrl)			\
+[MT6331_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6331_volt_range_ops,				\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6331_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = (max - min)/step + 1,			\
+		.linear_ranges = volt_ranges,				\
+		.n_linear_ranges = ARRAY_SIZE(volt_ranges),		\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(0),					\
+	},								\
+	.qi = BIT(13),							\
+	.vselon_reg = voselon,						\
+	.vselctrl_reg = vosel_ctrl,					\
+	.vselctrl_mask = BIT(1),					\
+	.status_mask = 0,						\
+}
+
+#define MT6331_LDO_AO(match, vreg, ldo_volt_table, vosel, vosel_mask)	\
+[MT6331_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6331_volt_table_ao_ops,			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6331_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = ARRAY_SIZE(ldo_volt_table),		\
+		.volt_table = ldo_volt_table,				\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+	},								\
+}
+
+#define MT6331_LDO_S(match, vreg, ldo_volt_table, enreg, enbit, vosel,	\
+		     vosel_mask, _modeset_reg, _modeset_mask,		\
+		     _status_reg, _status_mask)				\
+[MT6331_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = &mt6331_volt_table_no_qi_ops,			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6331_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = ARRAY_SIZE(ldo_volt_table),		\
+		.volt_table = ldo_volt_table,				\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+	},								\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+	.status_reg = _status_reg,					\
+	.status_mask = _status_mask,					\
+}
+
+#define MT6331_LDO(match, vreg, ldo_volt_table, enreg, enbit, vosel,	\
+		   vosel_mask, _modeset_reg, _modeset_mask)		\
+[MT6331_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = (_modeset_reg ?					\
+			&mt6331_volt_table_ops :			\
+			&mt6331_volt_table_no_ms_ops),			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6331_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = ARRAY_SIZE(ldo_volt_table),		\
+		.volt_table = ldo_volt_table,				\
+		.vsel_reg = vosel,					\
+		.vsel_mask = vosel_mask,				\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+	},								\
+	.qi = BIT(15),							\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+}
+
+#define MT6331_REG_FIXED(match, vreg, enreg, enbit, qibit, volt,	\
+			 _modeset_reg, _modeset_mask)			\
+[MT6331_ID_##vreg] = {							\
+	.desc = {							\
+		.name = #vreg,						\
+		.of_match = of_match_ptr(match),			\
+		.ops = (_modeset_reg ?					\
+			&mt6331_volt_fixed_ops :			\
+			&mt6331_volt_fixed_no_ms_ops),			\
+		.type = REGULATOR_VOLTAGE,				\
+		.id = MT6331_ID_##vreg,					\
+		.owner = THIS_MODULE,					\
+		.n_voltages = 1,					\
+		.enable_reg = enreg,					\
+		.enable_mask = BIT(enbit),				\
+		.min_uV = volt,						\
+	},								\
+	.qi = BIT(qibit),						\
+	.modeset_reg = _modeset_reg,					\
+	.modeset_mask = _modeset_mask,					\
+}
+
+static const struct linear_range buck_volt_range[] = {
+	REGULATOR_LINEAR_RANGE(700000, 0, 0x7f, 6250),
+};
+
+static const unsigned int ldo_volt_table1[] = {
+	2800000, 3000000, 0, 3200000
+};
+
+static const unsigned int ldo_volt_table2[] = {
+	1500000, 1800000, 2500000, 2800000,
+};
+
+static const unsigned int ldo_volt_table3[] = {
+	1200000, 1300000, 1500000, 1800000, 2000000, 2800000, 3000000, 3300000,
+};
+
+static const unsigned int ldo_volt_table4[] = {
+	0, 0, 1700000, 1800000, 1860000, 2760000, 3000000, 3100000,
+};
+
+static const unsigned int ldo_volt_table5[] = {
+	1800000, 3300000, 1800000, 3300000,
+};
+
+static const unsigned int ldo_volt_table6[] = {
+	3000000, 3300000,
+};
+
+static const unsigned int ldo_volt_table7[] = {
+	1200000, 1600000, 1700000, 1800000, 1900000, 2000000, 2100000, 2200000,
+};
+
+static const unsigned int ldo_volt_table8[] = {
+	900000, 1000000, 1100000, 1220000, 1300000, 1500000, 1500000, 1500000,
+};
+
+static const unsigned int ldo_volt_table9[] = {
+	1000000, 1050000, 1100000, 1150000, 1200000, 1250000, 1300000, 1300000,
+};
+
+static const unsigned int ldo_volt_table10[] = {
+	1200000, 1300000, 1500000, 1800000,
+};
+
+static const unsigned int ldo_volt_table11[] = {
+	1200000, 1300000, 1400000, 1500000, 1600000, 1700000, 1800000, 1800000,
+};
+
+static int mt6331_get_status(struct regulator_dev *rdev)
+{
+	struct mt6331_regulator_info *info = rdev_get_drvdata(rdev);
+	u32 regval;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, info->desc.enable_reg, &regval);
+	if (ret != 0) {
+		dev_err(&rdev->dev, "Failed to get enable reg: %d\n", ret);
+		return ret;
+	}
+
+	return (regval & info->qi) ? REGULATOR_STATUS_ON : REGULATOR_STATUS_OFF;
+}
+
+static int mt6331_ldo_set_mode(struct regulator_dev *rdev, unsigned int mode)
+{
+	struct mt6331_regulator_info *info = rdev_get_drvdata(rdev);
+	int val;
+
+	switch (mode) {
+	case REGULATOR_MODE_STANDBY:
+		val = MT6331_LDO_MODE_LP;
+		break;
+	case REGULATOR_MODE_NORMAL:
+		val = MT6331_LDO_MODE_NORMAL;
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	val <<= ffs(info->modeset_mask) - 1;
+
+	return regmap_update_bits(rdev->regmap, info->modeset_reg,
+				  info->modeset_mask, val);
+}
+
+static unsigned int mt6331_ldo_get_mode(struct regulator_dev *rdev)
+{
+	struct mt6331_regulator_info *info = rdev_get_drvdata(rdev);
+	unsigned int val;
+	int ret;
+
+	ret = regmap_read(rdev->regmap, info->modeset_reg, &val);
+	if (ret < 0)
+		return ret;
+
+	val &= info->modeset_mask;
+	val >>= ffs(info->modeset_mask) - 1;
+
+	return (val & BIT(0)) ? REGULATOR_MODE_STANDBY : REGULATOR_MODE_NORMAL;
+}
+
+static const struct regulator_ops mt6331_volt_range_ops = {
+	.list_voltage = regulator_list_voltage_linear_range,
+	.map_voltage = regulator_map_voltage_linear_range,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6331_get_status,
+};
+
+static const struct regulator_ops mt6331_volt_table_no_ms_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6331_get_status,
+};
+
+static const struct regulator_ops mt6331_volt_table_no_qi_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.set_mode = mt6331_ldo_set_mode,
+	.get_mode = mt6331_ldo_get_mode,
+};
+
+static const struct regulator_ops mt6331_volt_table_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6331_get_status,
+	.set_mode = mt6331_ldo_set_mode,
+	.get_mode = mt6331_ldo_get_mode,
+};
+
+static const struct regulator_ops mt6331_volt_table_ao_ops = {
+	.list_voltage = regulator_list_voltage_table,
+	.map_voltage = regulator_map_voltage_iterate,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_time_sel = regulator_set_voltage_time_sel,
+};
+
+static const struct regulator_ops mt6331_volt_fixed_no_ms_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6331_get_status,
+};
+
+static const struct regulator_ops mt6331_volt_fixed_ops = {
+	.list_voltage = regulator_list_voltage_linear,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = mt6331_get_status,
+	.set_mode = mt6331_ldo_set_mode,
+	.get_mode = mt6331_ldo_get_mode,
+};
+
+/* The array is indexed by id(MT6331_ID_XXX) */
+static struct mt6331_regulator_info mt6331_regulators[] = {
+	MT6331_BUCK("buck-vdvfs11", VDVFS11, 700000, 1493750, 6250,
+		    buck_volt_range, MT6331_VDVFS11_CON9,
+		    MT6331_VDVFS11_CON11, GENMASK(6, 0),
+		    MT6331_VDVFS11_CON12, MT6331_VDVFS11_CON7),
+	MT6331_BUCK("buck-vdvfs12", VDVFS12, 700000, 1493750, 6250,
+		    buck_volt_range, MT6331_VDVFS12_CON9,
+		    MT6331_VDVFS12_CON11, GENMASK(6, 0),
+		    MT6331_VDVFS12_CON12, MT6331_VDVFS12_CON7),
+	MT6331_BUCK("buck-vdvfs13", VDVFS13, 700000, 1493750, 6250,
+		    buck_volt_range, MT6331_VDVFS13_CON9,
+		    MT6331_VDVFS13_CON11, GENMASK(6, 0),
+		    MT6331_VDVFS13_CON12, MT6331_VDVFS13_CON7),
+	MT6331_BUCK("buck-vdvfs14", VDVFS14, 700000, 1493750, 6250,
+		    buck_volt_range, MT6331_VDVFS14_CON9,
+		    MT6331_VDVFS14_CON11, GENMASK(6, 0),
+		    MT6331_VDVFS14_CON12, MT6331_VDVFS14_CON7),
+	MT6331_BUCK("buck-vcore2", VCORE2, 700000, 1493750, 6250,
+		    buck_volt_range, MT6331_VCORE2_CON9,
+		    MT6331_VCORE2_CON11, GENMASK(6, 0),
+		    MT6331_VCORE2_CON12, MT6331_VCORE2_CON7),
+	MT6331_REG_FIXED("buck-vio18", VIO18, MT6331_VIO18_CON9, 0, 13, 1800000, 0, 0),
+	MT6331_REG_FIXED("ldo-vrtc", VRTC, MT6331_DIGLDO_CON11, 8, 15, 2800000, 0, 0),
+	MT6331_REG_FIXED("ldo-vtcxo1", VTCXO1, MT6331_ANALDO_CON1, 10, 15, 2800000,
+			 MT6331_ANALDO_CON1, GENMASK(1, 0)),
+	MT6331_REG_FIXED("ldo-vtcxo2", VTCXO2, MT6331_ANALDO_CON2, 10, 15, 2800000,
+			 MT6331_ANALDO_CON2, GENMASK(1, 0)),
+	MT6331_REG_FIXED("ldo-vsram", VSRAM_DVFS1, MT6331_SYSLDO_CON4, 10, 15, 1012500,
+			 MT6331_SYSLDO_CON4, GENMASK(1, 0)),
+	MT6331_REG_FIXED("ldo-vio28", VIO28, MT6331_DIGLDO_CON1, 10, 15, 2800000,
+			 MT6331_DIGLDO_CON1, GENMASK(1, 0)),
+	MT6331_LDO("ldo-avdd32aud", AVDD32_AUD, ldo_volt_table1, MT6331_ANALDO_CON3, 10,
+		   MT6331_ANALDO_CON10, GENMASK(6, 5), MT6331_ANALDO_CON3, GENMASK(1, 0)),
+	MT6331_LDO("ldo-vauxa32", VAUXA32, ldo_volt_table1, MT6331_ANALDO_CON4, 10,
+		   MT6331_ANALDO_CON6, GENMASK(6, 5), MT6331_ANALDO_CON4, GENMASK(1, 0)),
+	MT6331_LDO("ldo-vemc33", VEMC33, ldo_volt_table6, MT6331_DIGLDO_CON5, 10,
+		   MT6331_DIGLDO_CON17, BIT(6), MT6331_DIGLDO_CON5, GENMASK(1, 0)),
+	MT6331_LDO("ldo-vibr", VIBR, ldo_volt_table3, MT6331_DIGLDO_CON12, 10,
+		   MT6331_DIGLDO_CON20, GENMASK(6, 4), MT6331_DIGLDO_CON12, GENMASK(1, 0)),
+	MT6331_LDO("ldo-vmc", VMC, ldo_volt_table5, MT6331_DIGLDO_CON3, 10,
+		   MT6331_DIGLDO_CON15, GENMASK(5, 4), MT6331_DIGLDO_CON3, GENMASK(1, 0)),
+	MT6331_LDO("ldo-vmch", VMCH, ldo_volt_table6, MT6331_DIGLDO_CON4, 10,
+		   MT6331_DIGLDO_CON16, BIT(6), MT6331_DIGLDO_CON4, GENMASK(1, 0)),
+	MT6331_LDO("ldo-vmipi", VMIPI, ldo_volt_table3, MT6331_SYSLDO_CON5, 10,
+		   MT6331_SYSLDO_CON13, GENMASK(5, 3), MT6331_SYSLDO_CON5, GENMASK(1, 0)),
+	MT6331_LDO("ldo-vsim1", VSIM1, ldo_volt_table4, MT6331_DIGLDO_CON8, 10,
+		   MT6331_DIGLDO_CON21, GENMASK(6, 4), MT6331_DIGLDO_CON8, GENMASK(1, 0)),
+	MT6331_LDO("ldo-vsim2", VSIM2, ldo_volt_table4, MT6331_DIGLDO_CON9, 10,
+		   MT6331_DIGLDO_CON22, GENMASK(6, 4), MT6331_DIGLDO_CON9, GENMASK(1, 0)),
+	MT6331_LDO("ldo-vusb10", VUSB10, ldo_volt_table9, MT6331_SYSLDO_CON2, 10,
+		   MT6331_SYSLDO_CON10, GENMASK(5, 3), MT6331_SYSLDO_CON2, GENMASK(1, 0)),
+	MT6331_LDO("ldo-vcama", VCAMA, ldo_volt_table2, MT6331_ANALDO_CON5, 15,
+		   MT6331_ANALDO_CON9, GENMASK(5, 4), 0, 0),
+	MT6331_LDO_S("ldo-vcamaf", VCAM_AF, ldo_volt_table3, MT6331_DIGLDO_CON2, 10,
+		     MT6331_DIGLDO_CON14, GENMASK(6, 4), MT6331_DIGLDO_CON2, GENMASK(1, 0),
+		     MT6331_EN_STATUS1, BIT(0)),
+	MT6331_LDO_S("ldo-vcamd", VCAMD, ldo_volt_table8, MT6331_SYSLDO_CON1, 15,
+		     MT6331_SYSLDO_CON9, GENMASK(6, 4), MT6331_SYSLDO_CON1, GENMASK(1, 0),
+		     MT6331_EN_STATUS1, BIT(11)),
+	MT6331_LDO_S("ldo-vcamio", VCAM_IO,  ldo_volt_table10, MT6331_SYSLDO_CON3, 10,
+		     MT6331_SYSLDO_CON11, GENMASK(4, 3), MT6331_SYSLDO_CON3, GENMASK(1, 0),
+		     MT6331_EN_STATUS1, BIT(13)),
+	MT6331_LDO_S("ldo-vgp1", VGP1, ldo_volt_table3, MT6331_DIGLDO_CON6, 10,
+		     MT6331_DIGLDO_CON19, GENMASK(6, 4), MT6331_DIGLDO_CON6, GENMASK(1, 0),
+		     MT6331_EN_STATUS1, BIT(4)),
+	MT6331_LDO_S("ldo-vgp2", VGP2, ldo_volt_table10, MT6331_SYSLDO_CON6, 10,
+		     MT6331_SYSLDO_CON14, GENMASK(4, 3), MT6331_SYSLDO_CON6, GENMASK(1, 0),
+		     MT6331_EN_STATUS1, BIT(15)),
+	MT6331_LDO_S("ldo-vgp3", VGP3, ldo_volt_table10, MT6331_SYSLDO_CON7, 10,
+		     MT6331_SYSLDO_CON15, GENMASK(4, 3), MT6331_SYSLDO_CON7, GENMASK(1, 0),
+		     MT6331_EN_STATUS2, BIT(0)),
+	MT6331_LDO_S("ldo-vgp4", VGP4, ldo_volt_table7, MT6331_DIGLDO_CON7, 10,
+		     MT6331_DIGLDO_CON18, GENMASK(6, 4), MT6331_DIGLDO_CON7, GENMASK(1, 0),
+		     MT6331_EN_STATUS1, BIT(5)),
+	MT6331_LDO_AO("ldo-vdig18", VDIG18, ldo_volt_table11,
+		      MT6331_DIGLDO_CON28, GENMASK(14, 12)),
+};
+
+static int mt6331_set_buck_vosel_reg(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6331 = dev_get_drvdata(pdev->dev.parent);
+	int i;
+	u32 regval;
+
+	for (i = 0; i < MT6331_ID_VREG_MAX; i++) {
+		if (mt6331_regulators[i].vselctrl_reg) {
+			if (regmap_read(mt6331->regmap,
+				mt6331_regulators[i].vselctrl_reg,
+				&regval) < 0) {
+				dev_err(&pdev->dev,
+					"Failed to read buck ctrl\n");
+				return -EIO;
+			}
+
+			if (regval & mt6331_regulators[i].vselctrl_mask) {
+				mt6331_regulators[i].desc.vsel_reg =
+				mt6331_regulators[i].vselon_reg;
+			}
+		}
+	}
+
+	return 0;
+}
+
+static int mt6331_regulator_probe(struct platform_device *pdev)
+{
+	struct mt6397_chip *mt6331 = dev_get_drvdata(pdev->dev.parent);
+	struct regulator_config config = {};
+	struct regulator_dev *rdev;
+	int i;
+	u32 reg_value;
+
+	/* Query buck controller to select activated voltage register part */
+	if (mt6331_set_buck_vosel_reg(pdev))
+		return -EIO;
+
+	/* Read PMIC chip revision to update constraints and voltage table */
+	if (regmap_read(mt6331->regmap, MT6331_HWCID, &reg_value) < 0) {
+		dev_err(&pdev->dev, "Failed to read Chip ID\n");
+		return -EIO;
+	}
+	reg_value &= GENMASK(7, 0);
+
+	dev_info(&pdev->dev, "Chip ID = 0x%x\n", reg_value);
+
+	/*
+	 * ChipID 0x10 is "MT6331 E1", has a different voltage table and
+	 * it's currently not supported in this driver. Upon detection of
+	 * this ID, refuse to register the regulators, as we will wrongly
+	 * interpret the VSEL for this revision, potentially overvolting
+	 * some device.
+	 */
+	if (reg_value == 0x10) {
+		dev_err(&pdev->dev, "Chip version not supported. Bailing out.\n");
+		return -EINVAL;
+	}
+
+	for (i = 0; i < MT6331_ID_VREG_MAX; i++) {
+		config.dev = &pdev->dev;
+		config.driver_data = &mt6331_regulators[i];
+		config.regmap = mt6331->regmap;
+		rdev = devm_regulator_register(&pdev->dev,
+				&mt6331_regulators[i].desc, &config);
+		if (IS_ERR(rdev)) {
+			dev_err(&pdev->dev, "failed to register %s\n",
+				mt6331_regulators[i].desc.name);
+			return PTR_ERR(rdev);
+		}
+	}
+	return 0;
+}
+
+static const struct platform_device_id mt6331_platform_ids[] = {
+	{"mt6331-regulator", 0},
+	{ /* sentinel */ },
+};
+MODULE_DEVICE_TABLE(platform, mt6331_platform_ids);
+
+static struct platform_driver mt6331_regulator_driver = {
+	.driver = {
+		.name = "mt6331-regulator",
+	},
+	.probe = mt6331_regulator_probe,
+	.id_table = mt6331_platform_ids,
+};
+
+module_platform_driver(mt6331_regulator_driver);
+
+MODULE_AUTHOR("AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>");
+MODULE_DESCRIPTION("Regulator Driver for MediaTek MT6331 PMIC");
+MODULE_LICENSE("GPL");
diff --git a/include/linux/regulator/mt6331-regulator.h b/include/linux/regulator/mt6331-regulator.h
new file mode 100644
index 000000000000..2801a9879c14
--- /dev/null
+++ b/include/linux/regulator/mt6331-regulator.h
@@ -0,0 +1,46 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2022 Collabora Ltd.
+ * Author: AngeloGioacchino Del Regno <angelogioacchino.delregno@collabora.com>
+ */
+
+#ifndef __LINUX_REGULATOR_MT6331_H
+#define __LINUX_REGULATOR_MT6331_H
+
+enum {
+	/* BUCK */
+	MT6331_ID_VDVFS11 = 0,
+	MT6331_ID_VDVFS12,
+	MT6331_ID_VDVFS13,
+	MT6331_ID_VDVFS14,
+	MT6331_ID_VCORE2,
+	MT6331_ID_VIO18,
+	/* LDO */
+	MT6331_ID_VTCXO1,
+	MT6331_ID_VTCXO2,
+	MT6331_ID_AVDD32_AUD,
+	MT6331_ID_VAUXA32,
+	MT6331_ID_VCAMA,
+	MT6331_ID_VIO28,
+	MT6331_ID_VCAM_AF,
+	MT6331_ID_VMC,
+	MT6331_ID_VMCH,
+	MT6331_ID_VEMC33,
+	MT6331_ID_VGP1,
+	MT6331_ID_VSIM1,
+	MT6331_ID_VSIM2,
+	MT6331_ID_VMIPI,
+	MT6331_ID_VIBR,
+	MT6331_ID_VGP4,
+	MT6331_ID_VCAMD,
+	MT6331_ID_VUSB10,
+	MT6331_ID_VCAM_IO,
+	MT6331_ID_VSRAM_DVFS1,
+	MT6331_ID_VGP2,
+	MT6331_ID_VGP3,
+	MT6331_ID_VRTC,
+	MT6331_ID_VDIG18,
+	MT6331_ID_VREG_MAX
+};
+
+#endif /* __LINUX_REGULATOR_MT6331_H */
-- 
2.35.1

