Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 54BF946BF8C
	for <lists+linux-kernel@lfdr.de>; Tue,  7 Dec 2021 16:36:43 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238981AbhLGPkC (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 7 Dec 2021 10:40:02 -0500
Received: from alexa-out.qualcomm.com ([129.46.98.28]:5375 "EHLO
        alexa-out.qualcomm.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238974AbhLGPj6 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 7 Dec 2021 10:39:58 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
  d=quicinc.com; i=@quicinc.com; q=dns/txt; s=qcdkim;
  t=1638891388; x=1670427388;
  h=from:to:cc:subject:date:message-id:in-reply-to:
   references:mime-version;
  bh=3SWil4REXsn2oRnFD7iOsvKKRbDHFXcbyCV+TA5krwo=;
  b=K0LfL0mur9f6LLIsw5QLWbtsW5qkMgtkcMhFItG+0szxTUY5F38p6Iwb
   s2nd4QSCDeapQ/cO2DzI/bAuT8ODx/q7Ykq7R/d5p1vCuYUbSN/NAbjHK
   XznnpLQ+svTTeDkS1ZK8/gwRY6MIYVkf7o5aFKLFU5rG5VAkns/ECRdQX
   0=;
Received: from ironmsg07-lv.qualcomm.com ([10.47.202.151])
  by alexa-out.qualcomm.com with ESMTP; 07 Dec 2021 07:36:28 -0800
X-QCInternal: smtphost
Received: from nasanex01c.na.qualcomm.com ([10.47.97.222])
  by ironmsg07-lv.qualcomm.com with ESMTP/TLS/ECDHE-RSA-AES256-GCM-SHA384; 07 Dec 2021 07:36:28 -0800
Received: from nalasex01a.na.qualcomm.com (10.47.209.196) by
 nasanex01c.na.qualcomm.com (10.47.97.222) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 07:36:27 -0800
Received: from hu-srivasam-hyd.qualcomm.com (10.80.80.8) by
 nalasex01a.na.qualcomm.com (10.47.209.196) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384) id
 15.2.922.19; Tue, 7 Dec 2021 07:36:21 -0800
From:   Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
To:     <agross@kernel.org>, <bjorn.andersson@linaro.org>,
        <lgirdwood@gmail.com>, <broonie@kernel.org>, <robh+dt@kernel.org>,
        <plai@codeaurora.org>, <bgoswami@codeaurora.org>, <perex@perex.cz>,
        <tiwai@suse.com>, <srinivas.kandagatla@linaro.org>,
        <rohitkr@codeaurora.org>, <linux-arm-msm@vger.kernel.org>,
        <alsa-devel@alsa-project.org>, <devicetree@vger.kernel.org>,
        <linux-kernel@vger.kernel.org>, <swboyd@chromium.org>,
        <judyhsiao@chromium.org>, Linus Walleij <linus.walleij@linaro.org>,
        <linux-gpio@vger.kernel.org>
CC:     Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>,
        "Venkata Prasad Potturu" <quic_potturu@quicinc.com>
Subject: [PATCH v5 4/5] pinctrl: qcom: Add SC7280 lpass pin configuration
Date:   Tue, 7 Dec 2021 21:05:38 +0530
Message-ID: <1638891339-21806-5-git-send-email-quic_srivasam@quicinc.com>
X-Mailer: git-send-email 2.7.4
In-Reply-To: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
References: <1638891339-21806-1-git-send-email-quic_srivasam@quicinc.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [10.80.80.8]
X-ClientProxiedBy: nasanex01a.na.qualcomm.com (10.52.223.231) To
 nalasex01a.na.qualcomm.com (10.47.209.196)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pin control support for SC7280 LPASS LPI.

Signed-off-by: Srinivasa Rao Mandadapu <quic_srivasam@quicinc.com>
Co-developed-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
Signed-off-by: Venkata Prasad Potturu <quic_potturu@quicinc.com>
---
 drivers/pinctrl/qcom/Kconfig                    |   8 ++
 drivers/pinctrl/qcom/Makefile                   |   1 +
 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c | 169 ++++++++++++++++++++++++
 3 files changed, 178 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index e750e10..6f5ee01 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -320,6 +320,14 @@ config PINCTRL_LPASS_LPI
 	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SoCs.
 
+config PINCTRL_SC7280_LPASS_LPI
+	tristate "Qualcomm Technologies Inc SC7280 LPASS LPI pin controller driver"
+	depends on PINCTRL_LPASS_LPI
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
+	  (Low Power Island) found on the Qualcomm Technologies Inc SC7280 platform.
+
 config PINCTRL_SM8250_LPASS_LPI
 	tristate "Qualcomm Technologies Inc SM8250 LPASS LPI pin controller driver"
 	depends on PINCTRL_LPASS_LPI
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 8bc877e..7d94cdb 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -37,4 +37,5 @@ obj-$(CONFIG_PINCTRL_SM8150) += pinctrl-sm8150.o
 obj-$(CONFIG_PINCTRL_SM8250) += pinctrl-sm8250.o
 obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
 obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
+obj-$(CONFIG_PINCTRL_SC7280_LPASS_LPI) += pinctrl-sc7280-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
new file mode 100644
index 0000000..94bec15
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sc7280-lpass-lpi.c
@@ -0,0 +1,169 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2020-2021, The Linux Foundation. All rights reserved.
+ * ALSA SoC platform-machine driver for QTi LPASS
+ */
+
+#include <linux/clk.h>
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
+static const unsigned int gpio0_pins[] = { 0 };
+static const unsigned int gpio1_pins[] = { 1 };
+static const unsigned int gpio2_pins[] = { 2 };
+static const unsigned int gpio3_pins[] = { 3 };
+static const unsigned int gpio4_pins[] = { 4 };
+static const unsigned int gpio5_pins[] = { 5 };
+static const unsigned int gpio6_pins[] = { 6 };
+static const unsigned int gpio7_pins[] = { 7 };
+static const unsigned int gpio8_pins[] = { 8 };
+static const unsigned int gpio9_pins[] = { 9 };
+static const unsigned int gpio10_pins[] = { 10 };
+static const unsigned int gpio11_pins[] = { 11 };
+static const unsigned int gpio12_pins[] = { 12 };
+static const unsigned int gpio13_pins[] = { 13 };
+static const unsigned int gpio14_pins[] = { 14 };
+
+/* sc7280 variant specific data */
+static const struct pinctrl_pin_desc sc7280_lpi_pins[] = {
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
+	PINCTRL_PIN(14, "gpio14"),
+};
+
+static const char * const swr_tx_clk_groups[] = { "gpio0" };
+static const char * const swr_tx_data_groups[] = { "gpio1", "gpio2", "gpio14" };
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
+static const char * const i2s2_data_groups[] = { "gpio12", "gpio13" };
+
+static const struct lpi_pingroup sc7280_groups[] = {
+	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
+	LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
+	LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
+	LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
+	LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
+	LPI_PINGROUP(5, 12, swr_rx_data, _, _, _),
+	LPI_PINGROUP(6, NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
+	LPI_PINGROUP(7, NO_SLEW, dmic1_data, i2s1_ws, _, _),
+	LPI_PINGROUP(8, NO_SLEW, dmic2_clk, i2s1_data, _, _),
+	LPI_PINGROUP(9, NO_SLEW, dmic2_data, i2s1_data, _, _),
+	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
+	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
+	LPI_PINGROUP(12, NO_SLEW, dmic3_clk, i2s2_data, _, _),
+	LPI_PINGROUP(13, NO_SLEW, dmic3_data, i2s2_data, _, _),
+	LPI_PINGROUP(14, 6, swr_tx_data, _, _, _),
+};
+
+static const struct lpi_function sc7280_functions[] = {
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
+static const struct lpi_pinctrl_variant_data sc7280_lpi_data = {
+	.pins = sc7280_lpi_pins,
+	.npins = ARRAY_SIZE(sc7280_lpi_pins),
+	.groups = sc7280_groups,
+	.ngroups = ARRAY_SIZE(sc7280_groups),
+	.functions = sc7280_functions,
+	.nfunctions = ARRAY_SIZE(sc7280_functions),
+};
+
+static const struct of_device_id lpi_pinctrl_of_match[] = {
+	{
+	       .compatible = "qcom,sc7280-lpass-lpi-pinctrl",
+	       .data = &sc7280_lpi_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
+
+static struct platform_driver lpi_pinctrl_driver = {
+	.driver = {
+		   .name = "qcom-sc7280-lpass-lpi-pinctrl",
+		   .of_match_table = lpi_pinctrl_of_match,
+	},
+	.probe = lpi_pinctrl_probe,
+	.remove = lpi_pinctrl_remove,
+};
+
+module_platform_driver(lpi_pinctrl_driver);
+MODULE_DESCRIPTION("QTI SC7280 LPI GPIO pin control driver");
+MODULE_LICENSE("GPL");
+
-- 
2.7.4

