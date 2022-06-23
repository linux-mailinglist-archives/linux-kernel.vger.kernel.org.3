Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1522255797E
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:00:44 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231801AbiFWL7T (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 07:59:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:42908 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231667AbiFWL62 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 07:58:28 -0400
Received: from mail-pf1-x436.google.com (mail-pf1-x436.google.com [IPv6:2607:f8b0:4864:20::436])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 20044E018;
        Thu, 23 Jun 2022 04:58:00 -0700 (PDT)
Received: by mail-pf1-x436.google.com with SMTP id a15so11696789pfv.13;
        Thu, 23 Jun 2022 04:58:00 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=oioMX87ktK/RqUr7ZaT6eLp6MRtIdbKZ8zVhx3WgdzA=;
        b=SuJkM+K6oOkl+VW7BXbB2Cd4fje2to1DoONWB5rkIrRmYiWv9sMW9k8Dy1Xh81N3kM
         cF7eXKTKY60/c08Udqgq4jHe414uiE9nl+u5z7IoTrf9O3qGXXUwEguvwnaywlZSnl7N
         ErcYKvVvPv0AZpDo1bwEdAWG8POtC9OaqbFjqfku2fZoK1zMrT70uqf1FF2rseWbsbzQ
         g5N4cFg4PINGSRRTJGv/hVUrcDT+rsneUre913GlvwnvJ3XKR0BszJnGCw8McA5+4lt9
         jtRbQfatAVvb9JZ0fnzjux5D6+GtdQ3DaxWhaM2L9PIE+QGmkeYAWmaiP6+4H23WJFvm
         tIiA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=oioMX87ktK/RqUr7ZaT6eLp6MRtIdbKZ8zVhx3WgdzA=;
        b=LLPO+6GwM8LVxYdOKvyJpgRtmTv/ekOKFcssDSIQ+DTOeTIefJxQRfzyrH5fKEheOi
         3xCg25Sw8z/8Ico9Wb6Ap4yz7LhJtj3PcN2Jhinmz6Qk1qLaoQEuKlZZ7VqnRAafbsuD
         BbG4gaSD5Oj1sQc3iQosQMnfwff0c0kKArbda6kGbRLk5qLpQJXkqdPfbacA1c+9ad5e
         FiV4kUL6YPgUA6gVZ4uUl/3rM9cVonkRs/Tu540tWl1SMs3OeiJixNBpzqWJBwug/+hW
         AEwF/0Wwfm8TquXsQ3u3hDKW57lL5PhYoAl+qzoDKnIubJONuiZDW5qIFuuuIHRHCGj+
         fp8g==
X-Gm-Message-State: AJIora8R9pMbcAZChhigEi/0os9cNa81Yqznmiiax1PyDUynOIU9WX4w
        cwrdwsfEBSlh8HkFaWRhpaw=
X-Google-Smtp-Source: AGRyM1sB/xcUINi2sdn81Sl5uxJHv2hz52zRIYWFPvzR++L3PLn6gW6RGWUS6ln58BJRgo7coCRuGg==
X-Received: by 2002:a63:3444:0:b0:40c:f416:3dfd with SMTP id b65-20020a633444000000b0040cf4163dfdmr7172015pga.614.1655985480019;
        Thu, 23 Jun 2022 04:58:00 -0700 (PDT)
Received: from RD-3580-24288.rt.l (111-71-94-93.emome-ip.hinet.net. [111.71.94.93])
        by smtp.gmail.com with ESMTPSA id t6-20020a63b246000000b003fbfe88be17sm15016516pgo.24.2022.06.23.04.57.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 23 Jun 2022 04:57:59 -0700 (PDT)
From:   ChiaEn Wu <peterwu.pub@gmail.com>
To:     lee.jones@linaro.org, daniel.thompson@linaro.org,
        jingoohan1@gmail.com, pavel@ucw.cz, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, matthias.bgg@gmail.com,
        sre@kernel.org, chunfeng.yun@mediatek.com,
        gregkh@linuxfoundation.org, jic23@kernel.org, lars@metafoo.de,
        lgirdwood@gmail.com, broonie@kernel.org, linux@roeck-us.net,
        heikki.krogerus@linux.intel.com, deller@gmx.de
Cc:     chiaen_wu@richtek.com, alice_chen@richtek.com,
        cy_huang@richtek.com, dri-devel@lists.freedesktop.org,
        linux-leds@vger.kernel.org, devicetree@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-mediatek@lists.infradead.org, linux-kernel@vger.kernel.org,
        linux-pm@vger.kernel.org, linux-usb@vger.kernel.org,
        linux-iio@vger.kernel.org, linux-fbdev@vger.kernel.org,
        szunichen@gmail.com
Subject: [PATCH v3 09/14] regulator: mt6370: Add mt6370 DisplayBias and VibLDO support
Date:   Thu, 23 Jun 2022 19:56:26 +0800
Message-Id: <20220623115631.22209-10-peterwu.pub@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220623115631.22209-1-peterwu.pub@gmail.com>
References: <20220623115631.22209-1-peterwu.pub@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: ChiYuan Huang <cy_huang@richtek.com>

Add mt6370 DisplayBias and VibLDO support.

Signed-off-by: ChiYuan Huang <cy_huang@richtek.com>
---

v3
- Refine Kconfig help text
---
 drivers/regulator/Kconfig            |   8 +
 drivers/regulator/Makefile           |   1 +
 drivers/regulator/mt6370-regulator.c | 388 +++++++++++++++++++++++++++++++++++
 3 files changed, 397 insertions(+)
 create mode 100644 drivers/regulator/mt6370-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index cbe0f96..736f654a 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -804,6 +804,14 @@ config REGULATOR_MT6360
 	  2-channel buck with Thermal Shutdown and Overload Protection
 	  6-channel High PSRR and Low Dropout LDO.
 
+config REGULATOR_MT6370
+	tristate "MT6370 SubPMIC Regulator"
+	depends on MFD_MT6370
+	help
+	  Say Y here to enable MT6370 regulator support.
+	  This driver supports the control for DisplayBias voltages and one
+	  general purpose LDO which is commonly used to drive the vibrator.
+
 config REGULATOR_MT6380
 	tristate "MediaTek MT6380 PMIC"
 	depends on MTK_PMIC_WRAP
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 8d3ee8b..f1cbff2 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -97,6 +97,7 @@ obj-$(CONFIG_REGULATOR_MT6323)	+= mt6323-regulator.o
 obj-$(CONFIG_REGULATOR_MT6358)	+= mt6358-regulator.o
 obj-$(CONFIG_REGULATOR_MT6359)	+= mt6359-regulator.o
 obj-$(CONFIG_REGULATOR_MT6360) += mt6360-regulator.o
+obj-$(CONFIG_REGULATOR_MT6370) += mt6370-regulator.o
 obj-$(CONFIG_REGULATOR_MT6380)	+= mt6380-regulator.o
 obj-$(CONFIG_REGULATOR_MT6397)	+= mt6397-regulator.o
 obj-$(CONFIG_REGULATOR_MTK_DVFSRC) += mtk-dvfsrc-regulator.o
diff --git a/drivers/regulator/mt6370-regulator.c b/drivers/regulator/mt6370-regulator.c
new file mode 100644
index 0000000..bc356b4
--- /dev/null
+++ b/drivers/regulator/mt6370-regulator.c
@@ -0,0 +1,388 @@
+// SPDX-License-Identifier: GPL-2.0+
+
+#include <linux/bits.h>
+#include <linux/gpio/consumer.h>
+#include <linux/interrupt.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+
+enum {
+	MT6370_IDX_DSVBOOST = 0,
+	MT6370_IDX_DSVPOS,
+	MT6370_IDX_DSVNEG,
+	MT6370_IDX_VIBLDO,
+	MT6370_MAX_IDX
+};
+
+#define MT6370_REG_LDO_CFG	0x180
+#define MT6370_REG_LDO_VOUT	0x181
+#define MT6370_REG_DB_CTRL1	0x1B0
+#define MT6370_REG_DB_CTRL2	0x1B1
+#define MT6370_REG_DB_VBST	0x1B2
+#define MT6370_REG_DB_VPOS	0x1B3
+#define MT6370_REG_DB_VNEG	0x1B4
+#define MT6370_REG_LDO_STAT	0x1DC
+#define MT6370_REG_DB_STAT	0x1DF
+
+#define MT6370_LDOOMS_MASK	BIT(7)
+#define MT6370_LDOEN_MASK	BIT(7)
+#define MT6370_LDOVOUT_MASK	GENMASK(3, 0)
+#define MT6370_DBPERD_MASK	(BIT(7) | BIT(4))
+#define MT6370_DBEXTEN_MASK	BIT(0)
+#define MT6370_DBVPOSEN_MASK	BIT(6)
+#define MT6370_DBVPOSDISG_MASK	BIT(5)
+#define MT6370_DBVNEGEN_MASK	BIT(3)
+#define MT6370_DBVNEGDISG_MASK	BIT(2)
+#define MT6370_DBALLON_MASK	(MT6370_DBVPOSEN_MASK | MT6370_DBVNEGEN_MASK)
+#define MT6370_DBSLEW_MASK	GENMASK(7, 6)
+#define MT6370_DBVOUT_MASK	GENMASK(5, 0)
+#define MT6370_LDOOC_EVT_MASK	BIT(7)
+#define MT6370_POSSCP_EVT_MASK	BIT(7)
+#define MT6370_NEGSCP_EVT_MASK	BIT(6)
+#define MT6370_BSTOCP_EVT_MASK	BIT(5)
+#define MT6370_POSOCP_EVT_MASK	BIT(4)
+#define MT6370_NEGOCP_EVT_MASK	BIT(3)
+
+#define MT6370_LDO_MINUV	1600000
+#define MT6370_LDO_STPUV	200000
+#define MT6370_LDO_N_VOLT	13
+#define MT6370_DBVBOOST_MINUV	4000000
+#define MT6370_DBVBOOST_STPUV	50000
+#define MT6370_DBVBOOST_N_VOLT	45
+#define MT6370_DBVOUT_MINUV	4000000
+#define MT6370_DBVOUT_STPUV	50000
+#define MT6370_DBVOUT_N_VOLT	41
+
+struct mt6370_priv {
+	struct device *dev;
+	struct regmap *regmap;
+	struct regulator_dev *rdev[MT6370_MAX_IDX];
+	bool use_external_ctrl;
+};
+
+static const unsigned int mt6370_vpos_ramp_tbl[] = { 8540, 5840, 4830, 3000 };
+static const unsigned int mt6370_vneg_ramp_tbl[] = { 10090, 6310, 5050, 3150 };
+
+static int mt6370_get_error_flags(struct regulator_dev *rdev,
+				  unsigned int *flags)
+{
+	struct regmap *regmap = rdev_get_regmap(rdev);
+	unsigned int stat_reg, stat, rpt_flags = 0;
+	int rid = rdev_get_id(rdev), ret;
+
+	if (rid == MT6370_IDX_VIBLDO)
+		stat_reg = MT6370_REG_LDO_STAT;
+	else
+		stat_reg = MT6370_REG_DB_STAT;
+
+	ret = regmap_read(regmap, stat_reg, &stat);
+	if (ret)
+		return ret;
+
+	switch (rid) {
+	case MT6370_IDX_DSVBOOST:
+		if (stat & MT6370_BSTOCP_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_OVER_CURRENT;
+		break;
+	case MT6370_IDX_DSVPOS:
+		if (stat & MT6370_POSSCP_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_UNDER_VOLTAGE;
+
+		if (stat & MT6370_POSOCP_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_OVER_CURRENT;
+		break;
+	case MT6370_IDX_DSVNEG:
+		if (stat & MT6370_NEGSCP_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_UNDER_VOLTAGE;
+
+		if (stat & MT6370_NEGOCP_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_OVER_CURRENT;
+		break;
+	default:
+		if (stat & MT6370_LDOOC_EVT_MASK)
+			rpt_flags |= REGULATOR_ERROR_OVER_CURRENT;
+		break;
+	}
+
+	*flags = rpt_flags;
+	return 0;
+}
+
+static const struct regulator_ops mt6370_dbvboost_ops = {
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.get_bypass = regulator_get_bypass_regmap,
+	.set_bypass = regulator_set_bypass_regmap,
+	.get_error_flags = mt6370_get_error_flags,
+};
+
+static const struct regulator_ops mt6370_dbvout_ops = {
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.is_enabled = regulator_is_enabled_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.set_ramp_delay = regulator_set_ramp_delay_regmap,
+	.get_error_flags = mt6370_get_error_flags,
+};
+
+static const struct regulator_ops mt6370_ldo_ops = {
+	.get_voltage_sel = regulator_get_voltage_sel_regmap,
+	.set_voltage_sel = regulator_set_voltage_sel_regmap,
+	.list_voltage = regulator_list_voltage_linear,
+	.is_enabled = regulator_is_enabled_regmap,
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.set_active_discharge = regulator_set_active_discharge_regmap,
+	.get_error_flags = mt6370_get_error_flags,
+};
+
+static int mt6370_of_parse_cb(struct device_node *np,
+			      const struct regulator_desc *desc,
+			      struct regulator_config *config)
+{
+	struct mt6370_priv *priv = config->driver_data;
+	struct gpio_desc *enable_gpio;
+	int ret;
+
+	enable_gpio = gpiod_get_from_of_node(np, "enable", 0, GPIOD_OUT_HIGH |
+					     GPIOD_FLAGS_BIT_NONEXCLUSIVE,
+					     desc->name);
+	if (IS_ERR(enable_gpio)) {
+		config->ena_gpiod = NULL;
+		return 0;
+	}
+
+	/*
+	 * RG control by default
+	 * Only if all are using external pin, change all by external control
+	 */
+	if (priv->use_external_ctrl) {
+		ret = regmap_update_bits(priv->regmap, MT6370_REG_DB_CTRL1,
+					 MT6370_DBEXTEN_MASK,
+					 MT6370_DBEXTEN_MASK);
+		if (ret)
+			return ret;
+	}
+
+	config->ena_gpiod = enable_gpio;
+	priv->use_external_ctrl = true;
+	return 0;
+}
+
+static const struct regulator_desc mt6370_regulator_descs[] = {
+	{
+		.name = "mt6370-dsv-vbst",
+		.of_match = of_match_ptr("dsvbst"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = MT6370_IDX_DSVBOOST,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.ops = &mt6370_dbvboost_ops,
+		.min_uV = MT6370_DBVBOOST_MINUV,
+		.uV_step = MT6370_DBVBOOST_STPUV,
+		.n_voltages = MT6370_DBVBOOST_N_VOLT,
+		.vsel_reg = MT6370_REG_DB_VBST,
+		.vsel_mask = MT6370_DBVOUT_MASK,
+		.bypass_reg = MT6370_REG_DB_CTRL1,
+		.bypass_mask = MT6370_DBPERD_MASK,
+		.bypass_val_on = MT6370_DBPERD_MASK,
+	},
+	{
+		.name = "mt6370-dsv-vpos",
+		.of_match = of_match_ptr("dsvpos"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = MT6370_IDX_DSVPOS,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.of_parse_cb = mt6370_of_parse_cb,
+		.ops = &mt6370_dbvout_ops,
+		.min_uV = MT6370_DBVOUT_MINUV,
+		.uV_step = MT6370_DBVOUT_STPUV,
+		.n_voltages = MT6370_DBVOUT_N_VOLT,
+		.vsel_reg = MT6370_REG_DB_VPOS,
+		.vsel_mask = MT6370_DBVOUT_MASK,
+		.enable_reg = MT6370_REG_DB_CTRL2,
+		.enable_mask = MT6370_DBVPOSEN_MASK,
+		.ramp_reg = MT6370_REG_DB_VPOS,
+		.ramp_mask = MT6370_DBSLEW_MASK,
+		.ramp_delay_table = mt6370_vpos_ramp_tbl,
+		.n_ramp_values = ARRAY_SIZE(mt6370_vpos_ramp_tbl),
+		.active_discharge_reg = MT6370_REG_DB_CTRL2,
+		.active_discharge_mask = MT6370_DBVPOSDISG_MASK,
+		.active_discharge_on = MT6370_DBVPOSDISG_MASK,
+	},
+	{
+		.name = "mt6370-dsv-vneg",
+		.of_match = of_match_ptr("dsvneg"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = MT6370_IDX_DSVNEG,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.of_parse_cb = mt6370_of_parse_cb,
+		.ops = &mt6370_dbvout_ops,
+		.min_uV = MT6370_DBVOUT_MINUV,
+		.uV_step = MT6370_DBVOUT_STPUV,
+		.n_voltages = MT6370_DBVOUT_N_VOLT,
+		.vsel_reg = MT6370_REG_DB_VNEG,
+		.vsel_mask = MT6370_DBVOUT_MASK,
+		.enable_reg = MT6370_REG_DB_CTRL2,
+		.enable_mask = MT6370_DBVNEGEN_MASK,
+		.ramp_reg = MT6370_REG_DB_VNEG,
+		.ramp_mask = MT6370_DBSLEW_MASK,
+		.ramp_delay_table = mt6370_vneg_ramp_tbl,
+		.n_ramp_values = ARRAY_SIZE(mt6370_vneg_ramp_tbl),
+		.active_discharge_reg = MT6370_REG_DB_CTRL2,
+		.active_discharge_mask = MT6370_DBVNEGDISG_MASK,
+		.active_discharge_on = MT6370_DBVNEGDISG_MASK,
+	},
+	{
+		.name = "mt6370-vib-ldo",
+		.of_match = of_match_ptr("vibldo"),
+		.regulators_node = of_match_ptr("regulators"),
+		.id = MT6370_IDX_VIBLDO,
+		.type = REGULATOR_VOLTAGE,
+		.owner = THIS_MODULE,
+		.ops = &mt6370_ldo_ops,
+		.min_uV = MT6370_LDO_MINUV,
+		.uV_step = MT6370_LDO_STPUV,
+		.n_voltages = MT6370_LDO_N_VOLT,
+		.vsel_reg = MT6370_REG_LDO_VOUT,
+		.vsel_mask = MT6370_LDOVOUT_MASK,
+		.enable_reg = MT6370_REG_LDO_VOUT,
+		.enable_mask = MT6370_LDOEN_MASK,
+		.active_discharge_reg = MT6370_REG_LDO_CFG,
+		.active_discharge_mask = MT6370_LDOOMS_MASK,
+		.active_discharge_on = MT6370_LDOOMS_MASK,
+	}
+};
+
+static irqreturn_t mt6370_scp_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_UNDER_VOLTAGE,
+				      NULL);
+	return IRQ_HANDLED;
+}
+
+static irqreturn_t mt6370_ocp_handler(int irq, void *data)
+{
+	struct regulator_dev *rdev = data;
+
+	regulator_notifier_call_chain(rdev, REGULATOR_EVENT_OVER_CURRENT, NULL);
+	return IRQ_HANDLED;
+}
+
+static int mt6370_regulator_irq_register(struct mt6370_priv *priv)
+{
+	struct platform_device *pdev = to_platform_device(priv->dev);
+	static const struct {
+		const char *name;
+		int rid;
+		irq_handler_t handler;
+	} mt6370_irqs[] = {
+		{ "db_vpos_scp", MT6370_IDX_DSVPOS, mt6370_scp_handler },
+		{ "db_vneg_scp", MT6370_IDX_DSVNEG, mt6370_scp_handler },
+		{ "db_vbst_ocp", MT6370_IDX_DSVBOOST, mt6370_ocp_handler },
+		{ "db_vpos_ocp", MT6370_IDX_DSVPOS,  mt6370_ocp_handler },
+		{ "db_vneg_ocp", MT6370_IDX_DSVNEG, mt6370_ocp_handler },
+		{ "ldo_oc", MT6370_IDX_VIBLDO, mt6370_ocp_handler }
+	};
+	struct regulator_dev *rdev;
+	int i, irq, ret;
+
+	for (i = 0; i < ARRAY_SIZE(mt6370_irqs); i++) {
+		irq = platform_get_irq_byname(pdev, mt6370_irqs[i].name);
+
+		rdev = priv->rdev[mt6370_irqs[i].rid];
+
+		ret = devm_request_threaded_irq(priv->dev, irq, NULL,
+						mt6370_irqs[i].handler, 0,
+						mt6370_irqs[i].name, rdev);
+		if (ret) {
+			dev_err(priv->dev,
+				"Failed to register (%d) interrupt\n", i);
+			return ret;
+		}
+	}
+
+	return 0;
+}
+
+static int mt6370_regualtor_register(struct mt6370_priv *priv)
+{
+	struct regulator_dev *rdev;
+	struct regulator_config cfg = {};
+	struct device *parent = priv->dev->parent;
+	int i;
+
+	cfg.dev = parent;
+	cfg.driver_data = priv;
+
+	for (i = 0; i < MT6370_MAX_IDX; i++) {
+		rdev = devm_regulator_register(priv->dev,
+					       mt6370_regulator_descs + i,
+					       &cfg);
+		if (IS_ERR(rdev)) {
+			dev_err(priv->dev,
+				"Failed to register (%d) regulator\n", i);
+			return PTR_ERR(rdev);
+		}
+
+		priv->rdev[i] = rdev;
+	}
+
+	return 0;
+}
+
+static int mt6370_regulator_probe(struct platform_device *pdev)
+{
+	struct mt6370_priv *priv;
+	int ret;
+
+	priv = devm_kzalloc(&pdev->dev, sizeof(*priv), GFP_KERNEL);
+	if (!priv)
+		return -ENOMEM;
+
+	priv->dev = &pdev->dev;
+
+	priv->regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!priv->regmap) {
+		dev_err(&pdev->dev, "Failed to init regmap\n");
+		return -ENODEV;
+	}
+
+	ret = mt6370_regualtor_register(priv);
+	if (ret)
+		return ret;
+
+	return mt6370_regulator_irq_register(priv);
+}
+
+static const struct platform_device_id mt6370_devid_table[] = {
+	{ "mt6370-regulator", 0},
+	{}
+};
+MODULE_DEVICE_TABLE(platform, mt6370_devid_table);
+
+static struct platform_driver mt6370_regulator_driver = {
+	.driver = {
+		.name = "mt6370-regulator",
+	},
+	.id_table = mt6370_devid_table,
+	.probe = mt6370_regulator_probe,
+};
+module_platform_driver(mt6370_regulator_driver);
+
+MODULE_AUTHOR("ChiYuan Huang <cy_huang@richtek.com>");
+MODULE_DESCRIPTION("Mediatek MT6370 Regulator Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.7.4

