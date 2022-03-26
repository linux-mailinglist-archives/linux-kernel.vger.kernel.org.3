Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 956CA4E83BE
	for <lists+linux-kernel@lfdr.de>; Sat, 26 Mar 2022 20:25:25 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S234723AbiCZT0A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 26 Mar 2022 15:26:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56062 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234583AbiCZTZk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 26 Mar 2022 15:25:40 -0400
Received: from ssl.serverraum.org (ssl.serverraum.org [IPv6:2a01:4f8:151:8464::1:2])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 87A1E34643;
        Sat, 26 Mar 2022 12:24:03 -0700 (PDT)
Received: from mwalle01.kontron.local. (unknown [213.135.10.150])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange ECDHE (P-384) server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by ssl.serverraum.org (Postfix) with ESMTPSA id 4D571223F6;
        Sat, 26 Mar 2022 20:24:01 +0100 (CET)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=walle.cc; s=mail2016061301;
        t=1648322641;
        h=from:from:reply-to:subject:subject:date:date:message-id:message-id:
         to:to:cc:cc:mime-version:mime-version:
         content-transfer-encoding:content-transfer-encoding:
         in-reply-to:in-reply-to:references:references;
        bh=zH7BwNLIaTwGstQX8hwskl+jZZCjaljSVyRBswGIXt0=;
        b=HqIANpTwYSHmLO1RL/GroKqvq6OdrKrLE1HCKB33kL0T3s662QgJdvT0xCWYsl6mLOg6H6
        B8FbUkQl7o6fDoPIqbPUmFpcy2050Bg/zGYFKlaWkGueCH5rOnWJswBdnPs47WG6P2//oH
        BQVF93DhrGj5DybrG/TT9Ph+N10y2JE=
From:   Michael Walle <michael@walle.cc>
To:     Jean Delvare <jdelvare@suse.com>,
        Guenter Roeck <linux@roeck-us.net>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>
Cc:     linux-hwmon@vger.kernel.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, Michael Walle <michael@walle.cc>
Subject: [PATCH v1 4/4] hwmon: add driver for the Microchip LAN966x SoC
Date:   Sat, 26 Mar 2022 20:23:47 +0100
Message-Id: <20220326192347.2940747-5-michael@walle.cc>
X-Mailer: git-send-email 2.30.2
In-Reply-To: <20220326192347.2940747-1-michael@walle.cc>
References: <20220326192347.2940747-1-michael@walle.cc>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the temperatur sensor and the fan controller on the
Microchip LAN966x SoC. Apparently, an Analog Bits PVT sensor is used
which can measure temperature and process voltages. But only a forumlae
for the temperature sensor is known. Additionally, the SoC support a fan
tacho input as well as a PWM signal to control the fan.

Signed-off-by: Michael Walle <michael@walle.cc>
---
 drivers/hwmon/Kconfig         |  12 ++
 drivers/hwmon/Makefile        |   1 +
 drivers/hwmon/lan966x-hwmon.c | 384 ++++++++++++++++++++++++++++++++++
 3 files changed, 397 insertions(+)
 create mode 100644 drivers/hwmon/lan966x-hwmon.c

diff --git a/drivers/hwmon/Kconfig b/drivers/hwmon/Kconfig
index 68a8a27ab3b7..4df8521a6f9d 100644
--- a/drivers/hwmon/Kconfig
+++ b/drivers/hwmon/Kconfig
@@ -814,6 +814,18 @@ config SENSORS_POWR1220
 	  This driver can also be built as a module. If so, the module
 	  will be called powr1220.
 
+config SENSORS_LAN966X
+	tristate "Microchip LAN966x Hardware Monitoring"
+	depends on SOC_LAN966 || COMPILE_TEST
+	depends on REGMAP
+	select POLYNOMIAL
+	help
+	  If you say yes here you get support for temperature monitoring
+	  on the Microchip LAN966x SoC.
+
+	  This driver can also be built as a module. If so, the module
+	  will be called lan966x-hwmon.
+
 config SENSORS_LINEAGE
 	tristate "Lineage Compact Power Line Power Entry Module"
 	depends on I2C
diff --git a/drivers/hwmon/Makefile b/drivers/hwmon/Makefile
index 8a03289e2aa4..51ca6956f8b7 100644
--- a/drivers/hwmon/Makefile
+++ b/drivers/hwmon/Makefile
@@ -100,6 +100,7 @@ obj-$(CONFIG_SENSORS_IT87)	+= it87.o
 obj-$(CONFIG_SENSORS_JC42)	+= jc42.o
 obj-$(CONFIG_SENSORS_K8TEMP)	+= k8temp.o
 obj-$(CONFIG_SENSORS_K10TEMP)	+= k10temp.o
+obj-$(CONFIG_SENSORS_LAN966X)	+= lan966x-hwmon.o
 obj-$(CONFIG_SENSORS_LINEAGE)	+= lineage-pem.o
 obj-$(CONFIG_SENSORS_LOCHNAGAR)	+= lochnagar-hwmon.o
 obj-$(CONFIG_SENSORS_LM63)	+= lm63.o
diff --git a/drivers/hwmon/lan966x-hwmon.c b/drivers/hwmon/lan966x-hwmon.c
new file mode 100644
index 000000000000..e53b47f501ef
--- /dev/null
+++ b/drivers/hwmon/lan966x-hwmon.c
@@ -0,0 +1,384 @@
+// SPDX-License-Identifier: GPL-2.0-only
+
+#include <linux/bitfield.h>
+#include <linux/clk.h>
+#include <linux/hwmon.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/mod_devicetable.h>
+#include <linux/platform_device.h>
+#include <linux/polynomial.h>
+#include <linux/regmap.h>
+
+/*
+ * The original translation formulae of the temperature (in degrees of Celsius)
+ * are as follows:
+ *
+ *   T = -3.4627e-11*(N^4) + 1.1023e-7*(N^3) + -1.9165e-4*(N^2) +
+ *       3.0604e-1*(N^1) + -5.6197e1
+ *
+ * where [-56.197, 136.402]C and N = [0, 1023].
+ *
+ * They must be accordingly altered to be suitable for the integer arithmetics.
+ * The technique is called 'factor redistribution', which just makes sure the
+ * multiplications and divisions are made so to have a result of the operations
+ * within the integer numbers limit. In addition we need to translate the
+ * formulae to accept millidegrees of Celsius. Here what it looks like after
+ * the alterations:
+ *
+ *   T = -34627e-12*(N^4) + 110230e-9*(N^3) + -191650e-6*(N^2) +
+ *       306040e-3*(N^1) + -56197
+ *
+ * where T = [-56197, 136402]mC and N = [0, 1023].
+ */
+
+static const struct polynomial poly_N_to_temp = {
+	.terms = {
+		{4,  -34627, 1000, 1},
+		{3,  110230, 1000, 1},
+		{2, -191650, 1000, 1},
+		{1,  306040, 1000, 1},
+		{0,  -56197,    1, 1}
+	}
+};
+
+#define PVT_SENSOR_CTRL		0x0 /* unused */
+#define PVT_SENSOR_CFG		0x4
+#define   SENSOR_CFG_CLK_CFG		GENMASK(27, 20)
+#define   SENSOR_CFG_TRIM_VAL		GENMASK(13, 9)
+#define   SENSOR_CFG_SAMPLE_ENA		BIT(8)
+#define   SENSOR_CFG_START_CAPTURE	BIT(7)
+#define   SENSOR_CFG_CONTINIOUS_MODE	BIT(6)
+#define   SENSOR_CFG_PSAMPLE_ENA	GENMASK(1, 0)
+#define PVT_SENSOR_STAT		0x8
+#define   SENSOR_STAT_DATA_VALID	BIT(10)
+#define   SENSOR_STAT_DATA		GENMASK(9, 0)
+
+#define FAN_CFG			0x0
+#define   FAN_CFG_DUTY_CYCLE		GENMASK(23, 16)
+#define   INV_POL			BIT(3)
+#define   GATE_ENA			BIT(2)
+#define   PWM_OPEN_COL_ENA		BIT(1)
+#define   FAN_STAT_CFG			BIT(0)
+#define FAN_PWM_FREQ		0x4
+#define   FAN_PWM_CYC_10US		GENMASK(25, 15)
+#define   FAN_PWM_FREQ_FREQ		GENMASK(14, 0)
+#define FAN_CNT			0xc
+#define   FAN_CNT_DATA			GENMASK(15, 0)
+
+struct lan966x_hwmon {
+	struct regmap *regmap_pvt;
+	struct regmap *regmap_fan;
+	struct clk *clk;
+};
+
+static int lan966x_hwmon_read_temp(struct device *dev, long *val)
+{
+	struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(hwmon->regmap_pvt, PVT_SENSOR_STAT, &data);
+	if (ret < 0)
+		return ret;
+
+	if (!(data & SENSOR_STAT_DATA_VALID))
+		return -EINVAL;
+
+	*val = polynomial_calc(&poly_N_to_temp,
+			       FIELD_GET(SENSOR_STAT_DATA, data));
+
+	return 0;
+}
+
+static int lan966x_hwmon_read_fan(struct device *dev, long *val)
+{
+	struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(hwmon->regmap_fan, FAN_CNT, &data);
+	if (ret < 0)
+		return ret;
+
+	/*
+	 * Data is given in pulses per second. According to the hwmon ABI we
+	 * have to assume two pulses per revolution.
+	 */
+	*val = FIELD_GET(FAN_CNT_DATA, data) * 60 / 2;
+
+	return 0;
+}
+
+static int lan966x_hwmon_read_pwm(struct device *dev, long *val)
+{
+	struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(hwmon->regmap_fan, FAN_CFG, &data);
+	if (ret < 0)
+		return ret;
+
+	*val = FIELD_GET(FAN_CFG_DUTY_CYCLE, data);
+
+	return 0;
+}
+
+static int lan966x_hwmon_read_pwm_freq(struct device *dev, long *val)
+{
+	struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
+	unsigned long rate = clk_get_rate(hwmon->clk);
+	unsigned int data;
+	int ret;
+
+	ret = regmap_read(hwmon->regmap_fan, FAN_PWM_FREQ, &data);
+	if (ret < 0)
+		return ret;
+
+	data = FIELD_GET(FAN_PWM_FREQ_FREQ, data);
+	*val = DIV_ROUND_CLOSEST(rate, 256);
+	*val = DIV_ROUND_CLOSEST(*val, data + 1);
+
+	return 0;
+}
+
+static int lan966x_hwmon_read(struct device *dev, enum hwmon_sensor_types type,
+			      u32 attr, int channel, long *val)
+{
+
+	switch (type) {
+	case hwmon_temp:
+		return lan966x_hwmon_read_temp(dev, val);
+	case hwmon_fan:
+		return lan966x_hwmon_read_fan(dev, val);
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			return lan966x_hwmon_read_pwm(dev, val);
+		case hwmon_pwm_freq:
+			return lan966x_hwmon_read_pwm_freq(dev, val);
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static int lan966x_hwmon_write_pwm(struct device *dev, long val)
+{
+	struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
+
+	if (val < 0 || val > 255)
+		return -EINVAL;
+
+	return regmap_update_bits(hwmon->regmap_fan, FAN_CFG,
+				  FAN_CFG_DUTY_CYCLE,
+				  FIELD_PREP(FAN_CFG_DUTY_CYCLE, val));
+}
+
+static int lan966x_hwmon_write_pwm_freq(struct device *dev, long val)
+{
+	struct lan966x_hwmon *hwmon = dev_get_drvdata(dev);
+	unsigned long rate = clk_get_rate(hwmon->clk);
+
+	val = DIV_ROUND_CLOSEST(rate, val);
+	val = DIV_ROUND_CLOSEST(val, 256) - 1;
+	val = clamp_val(val, 0, FAN_PWM_FREQ_FREQ);
+
+	return regmap_update_bits(hwmon->regmap_fan, FAN_PWM_FREQ,
+				  FAN_PWM_FREQ_FREQ,
+				  FIELD_PREP(FAN_PWM_FREQ_FREQ, val));
+}
+
+static int lan966x_hwmon_write(struct device *dev, enum hwmon_sensor_types type,
+			       u32 attr, int channel, long val)
+{
+	switch (type) {
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+			return lan966x_hwmon_write_pwm(dev, val);
+		case hwmon_pwm_freq:
+			return lan966x_hwmon_write_pwm_freq(dev, val);
+		default:
+			return -EOPNOTSUPP;
+		}
+	default:
+		return -EOPNOTSUPP;
+	}
+}
+
+static umode_t lan966x_hwmon_is_visible(const void *data,
+					enum hwmon_sensor_types type,
+					u32 attr, int channel)
+{
+	umode_t mode = 0;
+
+	switch (type) {
+	case hwmon_temp:
+		switch (attr) {
+		case hwmon_temp_input:
+			mode = 0444;
+			break;
+		default:
+			break;
+		}
+		break;
+	case hwmon_fan:
+		switch (attr) {
+		case hwmon_fan_input:
+			mode = 0444;
+			break;
+		default:
+			break;
+		}
+		break;
+	case hwmon_pwm:
+		switch (attr) {
+		case hwmon_pwm_input:
+		case hwmon_pwm_freq:
+			mode = 0644;
+			break;
+		default:
+			break;
+		}
+		break;
+	default:
+		break;
+	}
+
+	return mode;
+}
+
+
+static const struct hwmon_channel_info *lan966x_hwmon_info[] = {
+	HWMON_CHANNEL_INFO(chip, HWMON_C_REGISTER_TZ),
+	HWMON_CHANNEL_INFO(temp, HWMON_T_INPUT),
+	HWMON_CHANNEL_INFO(fan, HWMON_F_INPUT),
+	HWMON_CHANNEL_INFO(pwm, HWMON_PWM_INPUT | HWMON_PWM_FREQ),
+	NULL
+};
+
+static const struct hwmon_ops lan966x_hwmon_ops = {
+	.is_visible = lan966x_hwmon_is_visible,
+	.read = lan966x_hwmon_read,
+	.write = lan966x_hwmon_write,
+};
+
+static const struct hwmon_chip_info lan966x_hwmon_chip_info = {
+	.ops = &lan966x_hwmon_ops,
+	.info = lan966x_hwmon_info,
+};
+
+static int lan966x_hwmon_enable(struct lan966x_hwmon *hwmon)
+{
+	unsigned int mask = SENSOR_CFG_SAMPLE_ENA |
+			    SENSOR_CFG_START_CAPTURE |
+			    SENSOR_CFG_CONTINIOUS_MODE |
+			    SENSOR_CFG_PSAMPLE_ENA;
+	unsigned int val;
+
+	/* enable continuous mode */
+	val = SENSOR_CFG_SAMPLE_ENA | SENSOR_CFG_CONTINIOUS_MODE;
+
+	return regmap_update_bits(hwmon->regmap_pvt, PVT_SENSOR_CFG,
+				  mask, val);
+}
+
+static struct regmap *lan966x_init_regmap(struct platform_device *pdev,
+					  const char *name)
+{
+	struct regmap_config regmap_config = {
+		.reg_bits = 32,
+		.reg_stride = 4,
+		.val_bits = 32,
+	};
+	void __iomem *base;
+
+	base = devm_platform_ioremap_resource_byname(pdev, name);
+	if (IS_ERR(base))
+		return base;
+
+	regmap_config.name = name;
+
+	return devm_regmap_init_mmio(&pdev->dev, base, &regmap_config);
+}
+
+static void lan966x_clk_disable(void *data)
+{
+	struct lan966x_hwmon *hwmon = data;
+
+	clk_disable_unprepare(hwmon->clk);
+}
+
+static int lan966x_clk_enable(struct device *dev, struct lan966x_hwmon *hwmon)
+{
+	int ret;
+
+	ret = clk_prepare_enable(hwmon->clk);
+	if (ret)
+		return ret;
+
+	return devm_add_action_or_reset(dev, lan966x_clk_disable, hwmon);
+}
+
+static int lan966x_hwmon_probe(struct platform_device *pdev)
+{
+	struct device *dev = &pdev->dev;
+	struct lan966x_hwmon *hwmon;
+	struct device *hwmon_dev;
+	int ret;
+
+	hwmon = devm_kzalloc(dev, sizeof(*hwmon), GFP_KERNEL);
+	if (!hwmon)
+		return -ENOMEM;
+
+	hwmon->clk = devm_clk_get(dev, NULL);
+	if (IS_ERR(hwmon->clk))
+		return dev_err_probe(dev, PTR_ERR(hwmon->clk),
+				     "failed to get clock\n");
+
+	ret = lan966x_clk_enable(dev, hwmon);
+	if (ret)
+		return dev_err_probe(dev, ret, "failed to enable clock\n");
+
+	hwmon->regmap_pvt = lan966x_init_regmap(pdev, "pvt");
+	if (IS_ERR(hwmon->regmap_pvt))
+		return dev_err_probe(dev, PTR_ERR(hwmon->regmap_pvt),
+				     "failed to get regmap for PVT registers\n");
+
+	hwmon->regmap_fan = lan966x_init_regmap(pdev, "fan");
+	if (IS_ERR(hwmon->regmap_fan))
+		return dev_err_probe(dev, PTR_ERR(hwmon->regmap_fan),
+				     "failed to get regmap for fan registers\n");
+
+	hwmon_dev = devm_hwmon_device_register_with_info(&pdev->dev,
+				"lan966x_hwmon", hwmon,
+				&lan966x_hwmon_chip_info, NULL);
+	if (IS_ERR(hwmon_dev))
+		return dev_err_probe(dev, PTR_ERR(hwmon_dev),
+				     "failed to register hwmon device\n");
+
+	return lan966x_hwmon_enable(hwmon);
+}
+
+static const struct of_device_id lan966x_hwmon_of_match[] = {
+	{ .compatible = "microchip,lan9668-hwmon" },
+	{}
+};
+MODULE_DEVICE_TABLE(of, lan966x_hwmon_of_match);
+
+static struct platform_driver lan966x_hwmon_driver = {
+	.probe = lan966x_hwmon_probe,
+	.driver = {
+		.name = "lan966x-hwmon",
+		.of_match_table = lan966x_hwmon_of_match,
+	},
+};
+module_platform_driver(lan966x_hwmon_driver);
+
+MODULE_DESCRIPTION("LAN966x Hardware Monitoring Driver");
+MODULE_AUTHOR("Michael Walle <michael@walle.cc>");
+MODULE_LICENSE("GPL");
-- 
2.30.2

