Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 80BCA566E7D
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:40:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236823AbiGEMjd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:39:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:39744 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236435AbiGEMb5 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:31:57 -0400
Received: from mail-ed1-x530.google.com (mail-ed1-x530.google.com [IPv6:2a00:1450:4864:20::530])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id A98A232A
        for <linux-kernel@vger.kernel.org>; Tue,  5 Jul 2022 05:23:22 -0700 (PDT)
Received: by mail-ed1-x530.google.com with SMTP id r18so15022872edb.9
        for <linux-kernel@vger.kernel.org>; Tue, 05 Jul 2022 05:23:22 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=9elements.com; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=3F9xpbq62aSrKwzcZK51uE9OwB87Q0jmlWESB6hGbf0=;
        b=XGz8bRHLK7mvVG67VbGI3AuX8JtvBEcBFIxUR5oIberVE6dhPEdVgEtZjiNrzaCdLl
         2aj5lAnQTuGRFQvVNBlB21aI3XQAo6IAbkjtJA8uYtBk0XcUUf5dBomrLcJzdEGeVQoL
         /wJpbLW0KoHXOFXcW4XUt0n50yzBqLt1lXaqbl51NX2cAKNNHkSBK6byPfExcwOo1LAF
         qiAcRi+sDnI2errP41vnKATstTnbNmf1QUI9F2N7WjO+ygFaEr88BQNA2g0XK29HpL92
         iVXgTncr5IhGrg7ZWhowhJkKKm4r2luadDqQuOgvKSyUshNyf96BDXN6QItQuj+dX843
         Af2w==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=3F9xpbq62aSrKwzcZK51uE9OwB87Q0jmlWESB6hGbf0=;
        b=ZvbVVV/PvPdy9sP0kZhjjpKekUXIhek3u6EigO3RMCtKdKalROEgG1G0LLqtTrJInf
         HFSkhST/d1zgsHoulTPD7Ho1wlVGLaYsoBGtYXbsgGohBfnzAaWI9iNm/Y+tot9C1cP2
         rNx7S13wifutNsy+RqtrWU7xeSTd+CjfLlgFQmDh/BlZ37gM0gD1neSPGAVVbUofWtx7
         HKsLYRXRHOqB2JPl+rSfHqNNjqKmREpRc8HTTCaHmaGqQUIroXBo+wzqDcNu2GCvFeTI
         uhzz8zfR3W1Tlr6nIvRb0WMiFpf3DNuAM+cz/Q7/DE/V6e/TAtGQGy+lIR0qRAJkSk+B
         HpsA==
X-Gm-Message-State: AJIora87wVEjKHw385YMyYDqSx4JXMyyyQvsObI0cJ3X6sEMgrn1K1Ap
        ef8FePLlV/ruqTNsZC5n07gx5vp/K2ZRacLe
X-Google-Smtp-Source: AGRyM1u8EEQhYMKVqWVywCeFmUvSZLPZHs+6At8sybB1IAGZLA4USez5dwNLypp4jfY1U3cgvFiaBw==
X-Received: by 2002:a05:6402:35c5:b0:437:140d:5cb3 with SMTP id z5-20020a05640235c500b00437140d5cb3mr45587594edc.72.1657023800807;
        Tue, 05 Jul 2022 05:23:20 -0700 (PDT)
Received: from stroh80.sec.9e.network (ip-078-094-000-051.um19.pools.vodafone-ip.de. [78.94.0.51])
        by smtp.gmail.com with ESMTPSA id f15-20020a1709062c4f00b007081282cbd8sm15764758ejh.76.2022.07.05.05.23.19
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Tue, 05 Jul 2022 05:23:20 -0700 (PDT)
From:   Naresh Solanki <naresh.solanki@9elements.com>
X-Google-Original-From: Naresh Solanki <Naresh.Solanki@9elements.com>
To:     linux-kernel@vger.kernel.org, Liam Girdwood <lgirdwood@gmail.com>,
        Mark Brown <broonie@kernel.org>
Cc:     Patrick Rudolph <patrick.rudolph@9elements.com>,
        Marcello Sylvester Bauer <sylv@sylv.io>,
        Naresh Solanki <Naresh.Solanki@9elements.com>
Subject: [PATCH 3/5] regulator: max597x: Add support for max597x regulator
Date:   Tue,  5 Jul 2022 14:22:41 +0200
Message-Id: <20220705122244.472894-4-Naresh.Solanki@9elements.com>
X-Mailer: git-send-email 2.35.3
In-Reply-To: <20220705122244.472894-2-Naresh.Solanki@9elements.com>
References: <20220705122244.472894-2-Naresh.Solanki@9elements.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Patrick Rudolph <patrick.rudolph@9elements.com>

max597x is hot swap controller.
This regulator driver controls the same & also configures fault
protection features supported by the chip.

Signed-off-by: Patrick Rudolph <patrick.rudolph@9elements.com>
Signed-off-by: Marcello Sylvester Bauer <sylv@sylv.io>
Signed-off-by: Naresh Solanki <Naresh.Solanki@9elements.com>
---
 drivers/regulator/Kconfig             |  10 +
 drivers/regulator/Makefile            |   1 +
 drivers/regulator/max597x-regulator.c | 506 ++++++++++++++++++++++++++
 3 files changed, 517 insertions(+)
 create mode 100644 drivers/regulator/max597x-regulator.c

diff --git a/drivers/regulator/Kconfig b/drivers/regulator/Kconfig
index cbe0f96ca342..775d87a5d59d 100644
--- a/drivers/regulator/Kconfig
+++ b/drivers/regulator/Kconfig
@@ -546,6 +546,16 @@ config REGULATOR_MAX1586
 	  regulator via I2C bus. The provided regulator is suitable
 	  for PXA27x chips to control VCC_CORE and VCC_USIM voltages.
 
+config REGULATOR_MAX597X
+	tristate "Maxim 597x power switch and monitor"
+	depends on I2C
+	depends on OF
+	select MFD_MAX597X
+	help
+	  This driver controls a Maxim 5970/5978 switch via I2C bus.
+	  The MAX5970/5978 is a smart switch with no output regulation, but
+	  fault protection and voltage and current monitoring capabilities.
+
 config REGULATOR_MAX77620
 	tristate "Maxim 77620/MAX20024 voltage regulator"
 	depends on MFD_MAX77620 || COMPILE_TEST
diff --git a/drivers/regulator/Makefile b/drivers/regulator/Makefile
index 8d3ee8b6d41d..4a8a42998561 100644
--- a/drivers/regulator/Makefile
+++ b/drivers/regulator/Makefile
@@ -67,6 +67,7 @@ obj-$(CONFIG_REGULATOR_LTC3589) += ltc3589.o
 obj-$(CONFIG_REGULATOR_LTC3676) += ltc3676.o
 obj-$(CONFIG_REGULATOR_MAX14577) += max14577-regulator.o
 obj-$(CONFIG_REGULATOR_MAX1586) += max1586.o
+obj-$(CONFIG_REGULATOR_MAX597X) += max597x-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77620) += max77620-regulator.o
 obj-$(CONFIG_REGULATOR_MAX77650) += max77650-regulator.o
 obj-$(CONFIG_REGULATOR_MAX8649)	+= max8649.o
diff --git a/drivers/regulator/max597x-regulator.c b/drivers/regulator/max597x-regulator.c
new file mode 100644
index 000000000000..f95acd1c5e3a
--- /dev/null
+++ b/drivers/regulator/max597x-regulator.c
@@ -0,0 +1,506 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Device driver for regulators in MAX5970 and MAX5978 IC
+ *
+ * Copyright (c) 2022 9elements GmbH
+ *
+ * Author: Patrick Rudolph <patrick.rudolph@9elements.com>
+ */
+
+#include <linux/bitops.h>
+#include <linux/device.h>
+#include <linux/err.h>
+#include <linux/module.h>
+#include <linux/io.h>
+#include <linux/of.h>
+#include <linux/i2c.h>
+#include <linux/regmap.h>
+#include <linux/regulator/driver.h>
+#include <linux/regulator/machine.h>
+#include <linux/regulator/of_regulator.h>
+#include <linux/version.h>
+#include <linux/platform_device.h>
+
+#include <linux/mfd/max597x.h>
+
+struct max597x_regulator {
+	int num_switches, mon_rng, irng, shunt_micro_ohms, lim_uA;
+	struct regmap *regmap;
+};
+
+enum max597x_regulator_id {
+	MAX597X_SW0,
+	MAX597X_SW1,
+};
+
+static int max597x_uvp_ovp_check_mode(struct regulator_dev *rdev, int severity)
+{
+	int ret, reg;
+
+	/* Status1 register contains the soft strap values sampled at POR */
+	ret = regmap_read(rdev->regmap, MAX5970_REG_STATUS1, &reg);
+	if (ret)
+		return ret;
+
+	/* Check soft straps match requested mode */
+	if (severity == REGULATOR_SEVERITY_PROT) {
+		if (STATUS1_PROT(reg) != STATUS1_PROT_SHUTDOWN)
+			return -EOPNOTSUPP;
+
+		return 0;
+	}
+	if (STATUS1_PROT(reg) == STATUS1_PROT_SHUTDOWN)
+		return -EOPNOTSUPP;
+
+	return 0;
+}
+
+static int max597x_set_vp(struct regulator_dev *rdev, int lim_uV, int severity,
+			  bool enable, bool overvoltage)
+{
+	int off_h, off_l, reg, ret;
+	struct max597x_regulator *data = rdev_get_drvdata(rdev);
+	int channel = rdev_get_id(rdev);
+
+	if (overvoltage) {
+		if (severity == REGULATOR_SEVERITY_WARN) {
+			off_h = MAX5970_REG_CH_OV_WARN_H(channel);
+			off_l = MAX5970_REG_CH_OV_WARN_L(channel);
+		} else {
+			off_h = MAX5970_REG_CH_OV_CRIT_H(channel);
+			off_l = MAX5970_REG_CH_OV_CRIT_L(channel);
+		}
+	} else {
+		if (severity == REGULATOR_SEVERITY_WARN) {
+			off_h = MAX5970_REG_CH_UV_WARN_H(channel);
+			off_l = MAX5970_REG_CH_UV_WARN_L(channel);
+		} else {
+			off_h = MAX5970_REG_CH_UV_CRIT_H(channel);
+			off_l = MAX5970_REG_CH_UV_CRIT_L(channel);
+		}
+	}
+
+	if (enable)
+		/* reg = ADC_MASK * (lim_uV / 1000000) / (data->mon_rng / 1000000) */
+		reg = ADC_MASK * lim_uV / data->mon_rng;
+	else
+		reg = 0;
+
+	ret = regmap_write(rdev->regmap, off_h, MAX5970_VAL2REG_H(reg));
+	if (ret)
+		return ret;
+
+	ret = regmap_write(rdev->regmap, off_l, MAX5970_VAL2REG_L(reg));
+	if (ret)
+		return ret;
+
+	return 0;
+}
+
+static int max597x_set_uvp(struct regulator_dev *rdev, int lim_uV, int severity,
+			   bool enable)
+{
+	int ret;
+
+	/*
+	 * MAX5970 has enable control as a special value in limit reg. Can't
+	 * set limit but keep feature disabled or enable W/O given limit.
+	 */
+	if ((lim_uV && !enable) || (!lim_uV && enable))
+		return -EINVAL;
+
+	ret = max597x_uvp_ovp_check_mode(rdev, severity);
+	if (ret)
+		return ret;
+
+	return max597x_set_vp(rdev, lim_uV, severity, enable, false);
+}
+
+static int max597x_set_ovp(struct regulator_dev *rdev, int lim_uV, int severity,
+			   bool enable)
+{
+	int ret;
+
+	/*
+	 * MAX5970 has enable control as a special value in limit reg. Can't
+	 * set limit but keep feature disabled or enable W/O given limit.
+	 */
+	if ((lim_uV && !enable) || (!lim_uV && enable))
+		return -EINVAL;
+
+	ret = max597x_uvp_ovp_check_mode(rdev, severity);
+	if (ret)
+		return ret;
+
+	return max597x_set_vp(rdev, lim_uV, severity, enable, true);
+}
+
+static int max597x_set_ocp(struct regulator_dev *rdev, int lim_uA,
+			   int severity, bool enable)
+{
+	int ret, val, reg;
+	unsigned int vthst, vthfst;
+
+	struct max597x_regulator *data = rdev_get_drvdata(rdev);
+	int rdev_id = rdev_get_id(rdev);
+	/*
+	 * MAX5970 doesn't has enable control for ocp.
+	 * If limit is specified but enable is not set then hold the value in
+	 * variable & later use it when ocp needs to be enabled.
+	 */
+	if (lim_uA != 0 && lim_uA != data->lim_uA)
+		data->lim_uA = lim_uA;
+
+	if (severity != REGULATOR_SEVERITY_PROT)
+		return -EINVAL;
+
+	if (enable) {
+
+		/* Calc Vtrip threshold in uV. */
+		vthst =
+		    div_u64(mul_u32_u32(data->shunt_micro_ohms, data->lim_uA),
+			    1000000);
+
+		/*
+		 * As recommended in datasheed, add 20% margin to avoid
+		 * spurious event & passive component tolerance.
+		 */
+		vthst = div_u64(mul_u32_u32(vthst, 120), 100);
+
+		/* Calc fast Vtrip threshold in uV */
+		vthfst = vthst * (MAX5970_FAST2SLOW_RATIO / 100);
+
+		if (vthfst > data->irng) {
+			dev_err(&rdev->dev, "Current limit out of range\n");
+			return -EINVAL;
+		}
+		/* Fast trip threshold to be programmed */
+		val = div_u64(mul_u32_u32(0xFF, vthfst), data->irng);
+	} else
+		/*
+		 * Since there is no option to disable ocp, set limit to max
+		 * value
+		 */
+		val = 0xFF;
+
+	reg = MAX5970_REG_DAC_FAST(rdev_id);
+	ret = regmap_write(rdev->regmap, reg, val);
+
+	return ret;
+}
+
+static int max597x_get_status(struct regulator_dev *rdev)
+{
+	int val, ret;
+
+	ret = regmap_read(rdev->regmap, MAX5970_REG_STATUS3, &val);
+	if (ret)
+		return REGULATOR_FAILED_RETRY;
+
+	if (val & MAX5970_STATUS3_ALERT)
+		return REGULATOR_STATUS_ERROR;
+
+	ret = regulator_is_enabled_regmap(rdev);
+	if (ret < 0)
+		return ret;
+
+	if (ret)
+		return REGULATOR_STATUS_ON;
+
+	return REGULATOR_STATUS_OFF;
+}
+
+static const struct regulator_ops max597x_switch_ops = {
+	.enable = regulator_enable_regmap,
+	.disable = regulator_disable_regmap,
+	.is_enabled = regulator_is_enabled_regmap,
+	.get_status = max597x_get_status,
+	.set_over_voltage_protection = max597x_set_ovp,
+	.set_under_voltage_protection = max597x_set_uvp,
+	.set_over_current_protection = max597x_set_ocp,
+};
+
+static int max597x_dt_parse(struct device_node *np,
+			    const struct regulator_desc *desc,
+			    struct regulator_config *cfg)
+{
+	struct max597x_regulator *data = cfg->driver_data;
+	int ret = 0;
+
+	ret =
+	    of_property_read_u32(np, "shunt-resistor-micro-ohms",
+				 &data->shunt_micro_ohms);
+	if (ret < 0)
+		dev_err(cfg->dev,
+			"property 'shunt-resistor-micro-ohms' not found, err %d\n",
+			ret);
+	return ret;
+
+}
+
+#define MAX597X_SWITCH(_ID, _ereg, _chan, _supply) {     \
+	.name            = #_ID,                         \
+	.of_match        = of_match_ptr(#_ID),           \
+	.ops             = &max597x_switch_ops,          \
+	.regulators_node = of_match_ptr("regulators"),   \
+	.type            = REGULATOR_VOLTAGE,            \
+	.id              = MAX597X_##_ID,                \
+	.owner           = THIS_MODULE,                  \
+	.supply_name     = _supply,                      \
+	.enable_reg      = _ereg,                        \
+	.enable_mask     = CHXEN((_chan)),               \
+	.of_parse_cb	 = max597x_dt_parse,		 \
+}
+
+static const struct regulator_desc regulators[] = {
+	MAX597X_SWITCH(SW0, MAX5970_REG_CHXEN, 0, "vss1"),
+	MAX597X_SWITCH(SW1, MAX5970_REG_CHXEN, 1, "vss2"),
+};
+
+static int max597x_regmap_read_clear(struct regmap *map, unsigned int reg,
+				     unsigned int *val)
+{
+	int ret;
+
+	ret = regmap_read(map, reg, val);
+	if (ret)
+		return ret;
+
+	if (*val)
+		return regmap_write(map, reg, *val);
+
+	return 0;
+}
+
+static int max597x_irq_handler(int irq, struct regulator_irq_data *rid,
+			       unsigned long *dev_mask)
+{
+	struct regulator_err_state *stat;
+	struct max597x_regulator *d = (struct max597x_regulator *)rid->data;
+	int val, ret, i;
+
+	ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT0, &val);
+	if (ret)
+		return REGULATOR_FAILED_RETRY;
+
+	*dev_mask = 0;
+	for (i = 0; i < d->num_switches; i++) {
+		stat = &rid->states[i];
+		stat->notifs = 0;
+		stat->errors = 0;
+	}
+
+	for (i = 0; i < d->num_switches; i++) {
+		stat = &rid->states[i];
+
+		if (val & UV_STATUS_CRIT(i)) {
+			*dev_mask |= 1 << i;
+			stat->notifs |= REGULATOR_EVENT_UNDER_VOLTAGE;
+			stat->errors |= REGULATOR_ERROR_UNDER_VOLTAGE;
+		} else if (val & UV_STATUS_WARN(i)) {
+			*dev_mask |= 1 << i;
+			stat->notifs |= REGULATOR_EVENT_UNDER_VOLTAGE_WARN;
+			stat->errors |= REGULATOR_ERROR_UNDER_VOLTAGE_WARN;
+		}
+	}
+
+	ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT1, &val);
+	if (ret)
+		return REGULATOR_FAILED_RETRY;
+
+	for (i = 0; i < d->num_switches; i++) {
+		stat = &rid->states[i];
+
+		if (val & OV_STATUS_CRIT(i)) {
+			*dev_mask |= 1 << i;
+			stat->notifs |= REGULATOR_EVENT_REGULATION_OUT;
+			stat->errors |= REGULATOR_ERROR_REGULATION_OUT;
+		} else if (val & OV_STATUS_WARN(i)) {
+			*dev_mask |= 1 << i;
+			stat->notifs |= REGULATOR_EVENT_OVER_VOLTAGE_WARN;
+			stat->errors |= REGULATOR_ERROR_OVER_VOLTAGE_WARN;
+		}
+	}
+
+	ret = max597x_regmap_read_clear(d->regmap, MAX5970_REG_FAULT2, &val);
+	if (ret)
+		return REGULATOR_FAILED_RETRY;
+
+	for (i = 0; i < d->num_switches; i++) {
+		stat = &rid->states[i];
+
+		if (val & OC_STATUS_WARN(i)) {
+			*dev_mask |= 1 << i;
+			stat->notifs |= REGULATOR_EVENT_OVER_CURRENT_WARN;
+			stat->errors |= REGULATOR_ERROR_OVER_CURRENT_WARN;
+		}
+	}
+
+	ret = regmap_read(d->regmap, MAX5970_REG_STATUS0, &val);
+	if (ret)
+		return REGULATOR_FAILED_RETRY;
+
+	for (i = 0; i < d->num_switches; i++) {
+		stat = &rid->states[i];
+
+		if ((val & MAX5970_CB_IFAULTF(i))
+		    || (val & MAX5970_CB_IFAULTS(i))) {
+			*dev_mask |= 1 << i;
+			stat->notifs |=
+			    REGULATOR_EVENT_OVER_CURRENT |
+			    REGULATOR_EVENT_DISABLE;
+			stat->errors |=
+			    REGULATOR_ERROR_OVER_CURRENT | REGULATOR_ERROR_FAIL;
+
+			/* Clear the sub-IRQ status */
+			regulator_disable_regmap(stat->rdev);
+		}
+	}
+	return 0;
+}
+
+static const struct regmap_config max597x_regmap_config = {
+	.reg_bits = 8,
+	.val_bits = 8,
+	.max_register = MAX_REGISTERS,
+};
+
+static int max597x_adc_range(struct regmap *regmap, const int ch,
+			     u32 *irng, u32 *mon_rng)
+{
+	unsigned int reg;
+	int ret;
+
+	/* Decode current ADC range */
+	ret = regmap_read(regmap, MAX5970_REG_STATUS2, &reg);
+	if (ret)
+		return ret;
+	switch (MAX5970_IRNG(reg, ch)) {
+	case 0:
+		*irng = 100000;	/* 100 mV */
+		break;
+	case 1:
+		*irng = 50000;	/* 50 mV */
+		break;
+	case 2:
+		*irng = 25000;	/* 25 mV */
+		break;
+	default:
+		return -EINVAL;
+	}
+
+	/* Decode current voltage monitor range */
+	ret = regmap_read(regmap, MAX5970_REG_MON_RANGE, &reg);
+	if (ret)
+		return ret;
+
+	*mon_rng = MAX5970_MON_MAX_RANGE_UV >> MAX5970_MON(reg, ch);
+
+	return 0;
+}
+
+static int max597x_setup_irq(struct device *dev,
+			     int irq,
+			     struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES],
+			     int num_switches, struct max597x_regulator *data)
+{
+	struct regulator_irq_desc max597x_notif = {
+		.name = "max597x-irq",
+		.map_event = max597x_irq_handler,
+		.data = data,
+	};
+	int errs = REGULATOR_ERROR_UNDER_VOLTAGE |
+	    REGULATOR_ERROR_UNDER_VOLTAGE_WARN |
+	    REGULATOR_ERROR_OVER_VOLTAGE_WARN |
+	    REGULATOR_ERROR_REGULATION_OUT |
+	    REGULATOR_ERROR_OVER_CURRENT |
+	    REGULATOR_ERROR_OVER_CURRENT_WARN | REGULATOR_ERROR_FAIL;
+	void *irq_helper;
+
+	/* Register notifiers - can fail if IRQ is not given */
+	irq_helper = devm_regulator_irq_helper(dev, &max597x_notif,
+					       irq, 0, errs, NULL,
+					       &rdevs[0], num_switches);
+	if (IS_ERR(irq_helper)) {
+		if (PTR_ERR(irq_helper) == -EPROBE_DEFER)
+			return -EPROBE_DEFER;
+
+		dev_warn(dev, "IRQ disabled %pe\n", irq_helper);
+	}
+
+	return 0;
+}
+
+static int max597x_regulator_probe(struct platform_device *pdev)
+{
+
+
+	struct max597x_data *max597x = dev_get_drvdata(pdev->dev.parent);
+	struct max597x_regulator *data;
+
+	struct regulator_config config = { };
+	struct regulator_dev *rdev;
+	struct regulator_dev *rdevs[MAX5970_NUM_SWITCHES];
+	int num_switches = max597x->num_switches;
+	int ret, i;
+
+	for (i = 0; i < num_switches; i++) {
+		data =
+		    devm_kzalloc(max597x->dev, sizeof(struct max597x_regulator),
+				 GFP_KERNEL);
+		if (!data)
+			return -ENOMEM;
+
+		data->num_switches = num_switches;
+		data->regmap = max597x->regmap;
+
+		if (ret < 0)
+			return ret;
+
+		ret = max597x_adc_range(data->regmap, i, &max597x->irng[i], &max597x->mon_rng[i]);
+		if (ret < 0)
+			return ret;
+
+		data->irng = max597x->irng[i];
+		data->mon_rng = max597x->mon_rng[i];
+
+		config.dev = max597x->dev;
+		config.driver_data = (void *)data;
+		config.regmap = data->regmap;
+		rdev = devm_regulator_register(max597x->dev,
+					       &regulators[i], &config);
+		if (IS_ERR(rdev)) {
+			dev_err(max597x->dev, "failed to register regulator %s\n",
+				regulators[i].name);
+			return PTR_ERR(rdev);
+		}
+		rdevs[i] = rdev;
+		max597x->shunt_micro_ohms[i] = data->shunt_micro_ohms;
+	}
+
+	if (max597x->irq) {
+		ret =
+		    max597x_setup_irq(max597x->dev, max597x->irq, rdevs, num_switches,
+				      data);
+		if (ret) {
+			dev_err(max597x->dev, "IRQ setup failed");
+			return ret;
+		}
+	}
+
+	return ret;
+}
+
+static struct platform_driver max597x_regulator_driver = {
+	.driver = {
+		.name = "max597x-regulator",
+	},
+	.probe = max597x_regulator_probe,
+};
+
+module_platform_driver(max597x_regulator_driver);
+
+
+MODULE_AUTHOR("Patrick Rudolph <patrick.rudolph@9elements.com>");
+MODULE_DESCRIPTION("MAX5970_hot-swap controller driver");
+MODULE_LICENSE("GPL v2");
-- 
2.35.3

