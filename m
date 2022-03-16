Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 298CD4DB5E0
	for <lists+linux-kernel@lfdr.de>; Wed, 16 Mar 2022 17:18:28 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1357462AbiCPQTc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 16 Mar 2022 12:19:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53192 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1357449AbiCPQT3 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 16 Mar 2022 12:19:29 -0400
Received: from alexa-out.qualcomm.com (alexa-out.qualcomm.com [129.46.98.28])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5CE68DEB6;
        Wed, 16 Mar 2022 09:18:14 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1647447494; x=1678983494;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=5UF/XoAmRmv22QEVmjXfmuQ7axIKjEK2Va1TKp8Zwpo=;
  b=lfWH895Et9lXH0okVC0SML9Lqn7Y6aT3UUqf4IZnDmt2K+kGUyNzw1j3
   eFomvf08Jc7HzydxUacwuLQNOmDjQkhDW/Pk5VuEtQ7JDIdag+TcRbiE6
   V1HY6hLF4s6EKCIDcjc2HcED7svkp5HXVrJQD7ZN5b07rUeQoQFn+YBpE
   c=;
Received: from ironmsg-lv-alpha.qualcomm.com ([10.47.202.13])
  by alexa-out.qualcomm.com with ESMTP; 16 Mar 2022 09:18:14 -0700
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg-lv-alpha.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 16 Mar 2022 09:18:13 -0700
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 09:18:12 -0700
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.986.22; Wed, 16 Mar 2022 09:18:06 -0700
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <quic_plai@quicinc.com>, <bgoswami@codeaurora.org>,
        <perex@perex.cz>, <tiwai@suse.com>,
        <srinivas.kandagatla@linaro.org>, <rohitkr@codeaurora.org>,
        <linux-arm-msm@vger.kernel.org>, <alsa-devel@alsa-project.org>,
        <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <swboyd@chromium.org>, <judyhsiao@chromium.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v12 5/7] pinctrl: qcom: Extract chip specific LPASS LPI code
Date:   Wed, 16 Mar 2022 21:47:04 +0530
Message-ID: <1647447426-23425-6-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1647447426-23425-1-git-send-email-quic_srivasam@quicinc.com>
References: <1647447426-23425-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01b.na.qualcomm.com (10.46.141.250) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Extract the chip specific SM8250 data from the LPASS LPI pinctrl driver
to allow reusing the common code in the addition of subsequent
platforms.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 drivers/pinctrl/qcom/Kconfig                    |   9 +
 drivers/pinctrl/qcom/Makefile                   |   1 +
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.c        | 233 +-----------------------
 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h        |  85 +++++++++
 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c | 164 +++++++++++++++++
 5 files changed, 264 insertions(+), 228 deletions(-)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 31c4aa6..486a1b5 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -329,6 +329,15 @@ config PINCTRL_SM8250
 	  Qualcomm Technologies Inc TLMM block found on the Qualcomm
 	  Technologies Inc SM8250 platform.
 
+config PINCTRL_SM8250_LPASS_LPI
+	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
+	depends on GPIOLIB
+	depends on PINCTRL_LPASS_LPI
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
+	  (Low Power Island) found on the Qualcomm Technologies Inc SM8250 platform.
+
 config PINCTRL_SM8350
 	tristate "Qualcomm Technologies Inc SM8350 pin controller driver"
 	depends on PINCTRL_MSM
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 709882f..39650d6 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -38,6 +38,7 @@ obj-$(CONFIG_PINCTRL_SM6350) += pinctrl-sm6350.o
 obj-$(CONFIG_PINCTRL_SDX65) += pinctrl-sdx65.o
 obj-$(CONFIG_PINCTRL_SM8150) += pinctrl-sm8150.o
 obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
+obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
 obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
 obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
index 3228c45..717e937 100644
--- a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.c
@@ -4,91 +4,15 @@
  * Copyright (c) 2020 Linaro Ltd.
  */
 
-#include <linux/bitops.h>
-#include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/gpio/driver.h>
-#include <linux/io.h>
 #include <linux/module.h>
 #include <linux/of_device.h>
-#include <linux/of.h>
 #include <linux/pinctrl/pinconf-generic.h>
 #include <linux/pinctrl/pinconf.h>
 #include <linux/pinctrl/pinmux.h>
-#include <linux/platform_device.h>
-#include <linux/slab.h>
-#include <linux/types.h>
-#include "../core.h"
 #include "../pinctrl-utils.h"
-
-#define LPI_SLEW_RATE_CTL_REG		0xa000
-#define LPI_TLMM_REG_OFFSET		0x1000
-#define LPI_SLEW_RATE_MAX		0x03
-#define LPI_SLEW_BITS_SIZE		0x02
-#define LPI_SLEW_RATE_MASK		GENMASK(1, 0)
-#define LPI_GPIO_CFG_REG		0x00
-#define LPI_GPIO_PULL_MASK		GENMASK(1, 0)
-#define LPI_GPIO_FUNCTION_MASK		GENMASK(5, 2)
-#define LPI_GPIO_OUT_STRENGTH_MASK	GENMASK(8, 6)
-#define LPI_GPIO_OE_MASK		BIT(9)
-#define LPI_GPIO_VALUE_REG		0x04
-#define LPI_GPIO_VALUE_IN_MASK		BIT(0)
-#define LPI_GPIO_VALUE_OUT_MASK		BIT(1)
-
-#define LPI_GPIO_BIAS_DISABLE		0x0
-#define LPI_GPIO_PULL_DOWN		0x1
-#define LPI_GPIO_KEEPER			0x2
-#define LPI_GPIO_PULL_UP		0x3
-#define LPI_GPIO_DS_TO_VAL(v)		(v / 2 - 1)
-#define LPI_NO_SLEW				-1
-
-#define LPI_FUNCTION(fname)			                \
-	[LPI_MUX_##fname] = {		                \
-		.name = #fname,				\
-		.groups = fname##_groups,               \
-		.ngroups = ARRAY_SIZE(fname##_groups),	\
-	}
-
-#define LPI_PINGROUP(id, soff, f1, f2, f3, f4)		\
-	{						\
-		.group.name = "gpio" #id,			\
-		.group.pins = gpio##id##_pins,		\
-		.pin = id,				\
-		.slew_offset = soff,			\
-		.group.num_pins = ARRAY_SIZE(gpio##id##_pins),	\
-		.funcs = (int[]){			\
-			LPI_MUX_gpio,			\
-			LPI_MUX_##f1,			\
-			LPI_MUX_##f2,			\
-			LPI_MUX_##f3,			\
-			LPI_MUX_##f4,			\
-		},					\
-		.nfuncs = 5,				\
-	}
-
-struct lpi_pingroup {
-	struct group_desc group;
-	unsigned int pin;
-	/* Bit offset in slew register for SoundWire pins only */
-	int slew_offset;
-	unsigned int *funcs;
-	unsigned int nfuncs;
-};
-
-struct lpi_function {
-	const char *name;
-	const char * const *groups;
-	unsigned int ngroups;
-};
-
-struct lpi_pinctrl_variant_data {
-	const struct pinctrl_pin_desc *pins;
-	int npins;
-	const struct lpi_pingroup *groups;
-	int ngroups;
-	const struct lpi_function *functions;
-	int nfunctions;
-};
+#include "pinctrl-lpass-lpi.h"
 
 #define MAX_LPI_NUM_CLKS	2
 
@@ -104,136 +28,6 @@ struct lpi_pinctrl {
 	const struct lpi_pinctrl_variant_data *data;
 };
 
-/* sm8250 variant specific data */
-static const struct pinctrl_pin_desc sm8250_lpi_pins[] = {
-	PINCTRL_PIN(0, "gpio0"),
-	PINCTRL_PIN(1, "gpio1"),
-	PINCTRL_PIN(2, "gpio2"),
-	PINCTRL_PIN(3, "gpio3"),
-	PINCTRL_PIN(4, "gpio4"),
-	PINCTRL_PIN(5, "gpio5"),
-	PINCTRL_PIN(6, "gpio6"),
-	PINCTRL_PIN(7, "gpio7"),
-	PINCTRL_PIN(8, "gpio8"),
-	PINCTRL_PIN(9, "gpio9"),
-	PINCTRL_PIN(10, "gpio10"),
-	PINCTRL_PIN(11, "gpio11"),
-	PINCTRL_PIN(12, "gpio12"),
-	PINCTRL_PIN(13, "gpio13"),
-};
-
-enum sm8250_lpi_functions {
-	LPI_MUX_dmic1_clk,
-	LPI_MUX_dmic1_data,
-	LPI_MUX_dmic2_clk,
-	LPI_MUX_dmic2_data,
-	LPI_MUX_dmic3_clk,
-	LPI_MUX_dmic3_data,
-	LPI_MUX_i2s1_clk,
-	LPI_MUX_i2s1_data,
-	LPI_MUX_i2s1_ws,
-	LPI_MUX_i2s2_clk,
-	LPI_MUX_i2s2_data,
-	LPI_MUX_i2s2_ws,
-	LPI_MUX_qua_mi2s_data,
-	LPI_MUX_qua_mi2s_sclk,
-	LPI_MUX_qua_mi2s_ws,
-	LPI_MUX_swr_rx_clk,
-	LPI_MUX_swr_rx_data,
-	LPI_MUX_swr_tx_clk,
-	LPI_MUX_swr_tx_data,
-	LPI_MUX_wsa_swr_clk,
-	LPI_MUX_wsa_swr_data,
-	LPI_MUX_gpio,
-	LPI_MUX__,
-};
-
-static int gpio0_pins[] = { 0 };
-static int gpio1_pins[] = { 1 };
-static int gpio2_pins[] = { 2 };
-static int gpio3_pins[] = { 3 };
-static int gpio4_pins[] = { 4 };
-static int gpio5_pins[] = { 5 };
-static int gpio6_pins[] = { 6 };
-static int gpio7_pins[] = { 7 };
-static int gpio8_pins[] = { 8 };
-static int gpio9_pins[] = { 9 };
-static int gpio10_pins[] = { 10 };
-static int gpio11_pins[] = { 11 };
-static int gpio12_pins[] = { 12 };
-static int gpio13_pins[] = { 13 };
-static const char * const swr_tx_clk_groups[] = { "gpio0" };
-static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
-static const char * const swr_rx_clk_groups[] = { "gpio3" };
-static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5" };
-static const char * const dmic1_clk_groups[] = { "gpio6" };
-static const char * const dmic1_data_groups[] = { "gpio7" };
-static const char * const dmic2_clk_groups[] = { "gpio8" };
-static const char * const dmic2_data_groups[] = { "gpio9" };
-static const char * const i2s2_clk_groups[] = { "gpio10" };
-static const char * const i2s2_ws_groups[] = { "gpio11" };
-static const char * const dmic3_clk_groups[] = { "gpio12" };
-static const char * const dmic3_data_groups[] = { "gpio13" };
-static const char * const qua_mi2s_sclk_groups[] = { "gpio0" };
-static const char * const qua_mi2s_ws_groups[] = { "gpio1" };
-static const char * const qua_mi2s_data_groups[] = { "gpio2", "gpio3", "gpio4" };
-static const char * const i2s1_clk_groups[] = { "gpio6" };
-static const char * const i2s1_ws_groups[] = { "gpio7" };
-static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
-static const char * const wsa_swr_clk_groups[] = { "gpio10" };
-static const char * const wsa_swr_data_groups[] = { "gpio11" };
-static const char * const i2s2_data_groups[] = { "gpio12", "gpio12" };
-
-static const struct lpi_pingroup sm8250_groups[] = {
-	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
-	LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
-	LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
-	LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
-	LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
-	LPI_PINGROUP(5, 12, swr_tx_data, swr_rx_data, _, _),
-	LPI_PINGROUP(6, LPI_NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
-	LPI_PINGROUP(7, LPI_NO_SLEW, dmic1_data, i2s1_ws, _, _),
-	LPI_PINGROUP(8, LPI_NO_SLEW, dmic2_clk, i2s1_data, _, _),
-	LPI_PINGROUP(9, LPI_NO_SLEW, dmic2_data, i2s1_data, _, _),
-	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
-	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
-	LPI_PINGROUP(12, LPI_NO_SLEW, dmic3_clk, i2s2_data, _, _),
-	LPI_PINGROUP(13, LPI_NO_SLEW, dmic3_data, i2s2_data, _, _),
-};
-
-static const struct lpi_function sm8250_functions[] = {
-	LPI_FUNCTION(dmic1_clk),
-	LPI_FUNCTION(dmic1_data),
-	LPI_FUNCTION(dmic2_clk),
-	LPI_FUNCTION(dmic2_data),
-	LPI_FUNCTION(dmic3_clk),
-	LPI_FUNCTION(dmic3_data),
-	LPI_FUNCTION(i2s1_clk),
-	LPI_FUNCTION(i2s1_data),
-	LPI_FUNCTION(i2s1_ws),
-	LPI_FUNCTION(i2s2_clk),
-	LPI_FUNCTION(i2s2_data),
-	LPI_FUNCTION(i2s2_ws),
-	LPI_FUNCTION(qua_mi2s_data),
-	LPI_FUNCTION(qua_mi2s_sclk),
-	LPI_FUNCTION(qua_mi2s_ws),
-	LPI_FUNCTION(swr_rx_clk),
-	LPI_FUNCTION(swr_rx_data),
-	LPI_FUNCTION(swr_tx_clk),
-	LPI_FUNCTION(swr_tx_data),
-	LPI_FUNCTION(wsa_swr_clk),
-	LPI_FUNCTION(wsa_swr_data),
-};
-
-static struct lpi_pinctrl_variant_data sm8250_lpi_data = {
-	.pins = sm8250_lpi_pins,
-	.npins = ARRAY_SIZE(sm8250_lpi_pins),
-	.groups = sm8250_groups,
-	.ngroups = ARRAY_SIZE(sm8250_groups),
-	.functions = sm8250_functions,
-	.nfunctions = ARRAY_SIZE(sm8250_functions),
-};
-
 static int lpi_gpio_read(struct lpi_pinctrl *state, unsigned int pin,
 			 unsigned int addr)
 {
@@ -574,7 +368,7 @@ static int lpi_build_pin_desc_groups(struct lpi_pinctrl *pctrl)
 	return ret;
 }
 
-static int lpi_pinctrl_probe(struct platform_device *pdev)
+int lpi_pinctrl_probe(struct platform_device *pdev)
 {
 	const struct lpi_pinctrl_variant_data *data;
 	struct device *dev = &pdev->dev;
@@ -657,8 +451,9 @@ static int lpi_pinctrl_probe(struct platform_device *pdev)
 
 	return ret;
 }
+EXPORT_SYMBOL_GPL(lpi_pinctrl_probe);
 
-static int lpi_pinctrl_remove(struct platform_device *pdev)
+int lpi_pinctrl_remove(struct platform_device *pdev)
 {
 	struct lpi_pinctrl *pctrl = platform_get_drvdata(pdev);
 	int i;
@@ -671,25 +466,7 @@ static int lpi_pinctrl_remove(struct platform_device *pdev)
 
 	return 0;
 }
+EXPORT_SYMBOL_GPL(lpi_pinctrl_remove);
 
-static const struct of_device_id lpi_pinctrl_of_match[] = {
-	{
-	       .compatible = "qcom,sm8250-lpass-lpi-pinctrl",
-	       .data = &sm8250_lpi_data,
-	},
-	{ }
-};
-MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
-
-static struct platform_driver lpi_pinctrl_driver = {
-	.driver = {
-		   .name = "qcom-lpass-lpi-pinctrl",
-		   .of_match_table = lpi_pinctrl_of_match,
-	},
-	.probe = lpi_pinctrl_probe,
-	.remove = lpi_pinctrl_remove,
-};
-
-module_platform_driver(lpi_pinctrl_driver);
 MODULE_DESCRIPTION("QTI LPI GPIO pin control driver");
 MODULE_LICENSE("GPL");
diff --git a/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
new file mode 100644
index 0000000..afbac2a
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-lpass-lpi.h
@@ -0,0 +1,85 @@
+/* SPDX-License-Identifier: GPL-2.0-only */
+/*
+ * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2020 Linaro Ltd.
+ */
+#ifndef __PINCTRL_LPASS_LPI_H__
+#define __PINCTRL_LPASS_LPI_H__
+
+#include <linux/bitops.h>
+#include <linux/bitfield.h>
+#include "../core.h"
+
+#define LPI_SLEW_RATE_CTL_REG	0xa000
+#define LPI_TLMM_REG_OFFSET		0x1000
+#define LPI_SLEW_RATE_MAX		0x03
+#define LPI_SLEW_BITS_SIZE		0x02
+#define LPI_SLEW_RATE_MASK		GENMASK(1, 0)
+#define LPI_GPIO_CFG_REG		0x00
+#define LPI_GPIO_PULL_MASK		GENMASK(1, 0)
+#define LPI_GPIO_FUNCTION_MASK		GENMASK(5, 2)
+#define LPI_GPIO_OUT_STRENGTH_MASK	GENMASK(8, 6)
+#define LPI_GPIO_OE_MASK		BIT(9)
+#define LPI_GPIO_VALUE_REG		0x04
+#define LPI_GPIO_VALUE_IN_MASK		BIT(0)
+#define LPI_GPIO_VALUE_OUT_MASK		BIT(1)
+
+#define LPI_GPIO_BIAS_DISABLE		0x0
+#define LPI_GPIO_PULL_DOWN		0x1
+#define LPI_GPIO_KEEPER			0x2
+#define LPI_GPIO_PULL_UP		0x3
+#define LPI_GPIO_DS_TO_VAL(v)		(v / 2 - 1)
+#define LPI_NO_SLEW				-1
+
+#define LPI_FUNCTION(fname)			                \
+	[LPI_MUX_##fname] = {		                \
+		.name = #fname,				\
+		.groups = fname##_groups,               \
+		.ngroups = ARRAY_SIZE(fname##_groups),	\
+	}
+
+#define LPI_PINGROUP(id, soff, f1, f2, f3, f4)		\
+	{						\
+		.group.name = "gpio" #id,			\
+		.group.pins = gpio##id##_pins,		\
+		.pin = id,				\
+		.slew_offset = soff,			\
+		.group.num_pins = ARRAY_SIZE(gpio##id##_pins),	\
+		.funcs = (int[]){			\
+			LPI_MUX_gpio,			\
+			LPI_MUX_##f1,			\
+			LPI_MUX_##f2,			\
+			LPI_MUX_##f3,			\
+			LPI_MUX_##f4,			\
+		},					\
+		.nfuncs = 5,				\
+	}
+
+struct lpi_pingroup {
+	struct group_desc group;
+	unsigned int pin;
+	/* Bit offset in slew register for SoundWire pins only */
+	int slew_offset;
+	unsigned int *funcs;
+	unsigned int nfuncs;
+};
+
+struct lpi_function {
+	const char *name;
+	const char * const *groups;
+	unsigned int ngroups;
+};
+
+struct lpi_pinctrl_variant_data {
+	const struct pinctrl_pin_desc *pins;
+	int npins;
+	const struct lpi_pingroup *groups;
+	int ngroups;
+	const struct lpi_function *functions;
+	int nfunctions;
+};
+
+int lpi_pinctrl_probe(struct platform_device *pdev);
+int lpi_pinctrl_remove(struct platform_device *pdev);
+
+#endif /*__PINCTRL_LPASS_LPI_H__*/
diff --git a/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
new file mode 100644
index 0000000..8c95d0f
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sm8250-lpass-lpi.c
@@ -0,0 +1,164 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2016-2019, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2020 Linaro Ltd.
+ */
+
+#include <linux/gpio/driver.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+
+#include "pinctrl-lpass-lpi.h"
+
+enum lpass_lpi_functions {
+	LPI_MUX_dmic1_clk,
+	LPI_MUX_dmic1_data,
+	LPI_MUX_dmic2_clk,
+	LPI_MUX_dmic2_data,
+	LPI_MUX_dmic3_clk,
+	LPI_MUX_dmic3_data,
+	LPI_MUX_i2s1_clk,
+	LPI_MUX_i2s1_data,
+	LPI_MUX_i2s1_ws,
+	LPI_MUX_i2s2_clk,
+	LPI_MUX_i2s2_data,
+	LPI_MUX_i2s2_ws,
+	LPI_MUX_qua_mi2s_data,
+	LPI_MUX_qua_mi2s_sclk,
+	LPI_MUX_qua_mi2s_ws,
+	LPI_MUX_swr_rx_clk,
+	LPI_MUX_swr_rx_data,
+	LPI_MUX_swr_tx_clk,
+	LPI_MUX_swr_tx_data,
+	LPI_MUX_wsa_swr_clk,
+	LPI_MUX_wsa_swr_data,
+	LPI_MUX_gpio,
+	LPI_MUX__,
+};
+
+static int gpio0_pins[] = { 0 };
+static int gpio1_pins[] = { 1 };
+static int gpio2_pins[] = { 2 };
+static int gpio3_pins[] = { 3 };
+static int gpio4_pins[] = { 4 };
+static int gpio5_pins[] = { 5 };
+static int gpio6_pins[] = { 6 };
+static int gpio7_pins[] = { 7 };
+static int gpio8_pins[] = { 8 };
+static int gpio9_pins[] = { 9 };
+static int gpio10_pins[] = { 10 };
+static int gpio11_pins[] = { 11 };
+static int gpio12_pins[] = { 12 };
+static int gpio13_pins[] = { 13 };
+
+/* sm8250 variant specific data */
+static const struct pinctrl_pin_desc sm8250_lpi_pins[] = {
+	PINCTRL_PIN(0, "gpio0"),
+	PINCTRL_PIN(1, "gpio1"),
+	PINCTRL_PIN(2, "gpio2"),
+	PINCTRL_PIN(3, "gpio3"),
+	PINCTRL_PIN(4, "gpio4"),
+	PINCTRL_PIN(5, "gpio5"),
+	PINCTRL_PIN(6, "gpio6"),
+	PINCTRL_PIN(7, "gpio7"),
+	PINCTRL_PIN(8, "gpio8"),
+	PINCTRL_PIN(9, "gpio9"),
+	PINCTRL_PIN(10, "gpio10"),
+	PINCTRL_PIN(11, "gpio11"),
+	PINCTRL_PIN(12, "gpio12"),
+	PINCTRL_PIN(13, "gpio13"),
+};
+
+static const char * const swr_tx_clk_groups[] = { "gpio0" };
+static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio5" };
+static const char * const swr_rx_clk_groups[] = { "gpio3" };
+static const char * const swr_rx_data_groups[] = { "gpio4", "gpio5" };
+static const char * const dmic1_clk_groups[] = { "gpio6" };
+static const char * const dmic1_data_groups[] = { "gpio7" };
+static const char * const dmic2_clk_groups[] = { "gpio8" };
+static const char * const dmic2_data_groups[] = { "gpio9" };
+static const char * const i2s2_clk_groups[] = { "gpio10" };
+static const char * const i2s2_ws_groups[] = { "gpio11" };
+static const char * const dmic3_clk_groups[] = { "gpio12" };
+static const char * const dmic3_data_groups[] = { "gpio13" };
+static const char * const qua_mi2s_sclk_groups[] = { "gpio0" };
+static const char * const qua_mi2s_ws_groups[] = { "gpio1" };
+static const char * const qua_mi2s_data_groups[] = { "gpio2", "gpio3", "gpio4" };
+static const char * const i2s1_clk_groups[] = { "gpio6" };
+static const char * const i2s1_ws_groups[] = { "gpio7" };
+static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
+static const char * const wsa_swr_clk_groups[] = { "gpio10" };
+static const char * const wsa_swr_data_groups[] = { "gpio11" };
+static const char * const i2s2_data_groups[] = { "gpio12", "gpio12" };
+
+static const struct lpi_pingroup sm8250_groups[] = {
+	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
+	LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
+	LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
+	LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
+	LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
+	LPI_PINGROUP(5, 12, swr_tx_data, swr_rx_data, _, _),
+	LPI_PINGROUP(6, LPI_NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
+	LPI_PINGROUP(7, LPI_NO_SLEW, dmic1_data, i2s1_ws, _, _),
+	LPI_PINGROUP(8, LPI_NO_SLEW, dmic2_clk, i2s1_data, _, _),
+	LPI_PINGROUP(9, LPI_NO_SLEW, dmic2_data, i2s1_data, _, _),
+	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
+	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
+	LPI_PINGROUP(12, LPI_NO_SLEW, dmic3_clk, i2s2_data, _, _),
+	LPI_PINGROUP(13, LPI_NO_SLEW, dmic3_data, i2s2_data, _, _),
+};
+
+static const struct lpi_function sm8250_functions[] = {
+	LPI_FUNCTION(dmic1_clk),
+	LPI_FUNCTION(dmic1_data),
+	LPI_FUNCTION(dmic2_clk),
+	LPI_FUNCTION(dmic2_data),
+	LPI_FUNCTION(dmic3_clk),
+	LPI_FUNCTION(dmic3_data),
+	LPI_FUNCTION(i2s1_clk),
+	LPI_FUNCTION(i2s1_data),
+	LPI_FUNCTION(i2s1_ws),
+	LPI_FUNCTION(i2s2_clk),
+	LPI_FUNCTION(i2s2_data),
+	LPI_FUNCTION(i2s2_ws),
+	LPI_FUNCTION(qua_mi2s_data),
+	LPI_FUNCTION(qua_mi2s_sclk),
+	LPI_FUNCTION(qua_mi2s_ws),
+	LPI_FUNCTION(swr_rx_clk),
+	LPI_FUNCTION(swr_rx_data),
+	LPI_FUNCTION(swr_tx_clk),
+	LPI_FUNCTION(swr_tx_data),
+	LPI_FUNCTION(wsa_swr_clk),
+	LPI_FUNCTION(wsa_swr_data),
+};
+
+static const struct lpi_pinctrl_variant_data sm8250_lpi_data = {
+	.pins = sm8250_lpi_pins,
+	.npins = ARRAY_SIZE(sm8250_lpi_pins),
+	.groups = sm8250_groups,
+	.ngroups = ARRAY_SIZE(sm8250_groups),
+	.functions = sm8250_functions,
+	.nfunctions = ARRAY_SIZE(sm8250_functions),
+};
+
+static const struct of_device_id lpi_pinctrl_of_match[] = {
+	{
+	       .compatible = "qcom,sm8250-lpass-lpi-pinctrl",
+	       .data = &sm8250_lpi_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
+
+static struct platform_driver lpi_pinctrl_driver = {
+	.driver = {
+		   .name = "qcom-sm8250-lpass-lpi-pinctrl",
+		   .of_match_table = lpi_pinctrl_of_match,
+	},
+	.probe = lpi_pinctrl_probe,
+	.remove = lpi_pinctrl_remove,
+};
+
+module_platform_driver(lpi_pinctrl_driver);
+MODULE_DESCRIPTION("QTI SM8250 LPI GPIO pin control driver");
+MODULE_LICENSE("GPL");
-- 
2.7.4

