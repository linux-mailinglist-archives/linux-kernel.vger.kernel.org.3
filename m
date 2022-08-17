Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 97522596DAA
	for <lists+linux-kernel@lfdr.de>; Wed, 17 Aug 2022 13:41:17 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235533AbiHQLiT (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 17 Aug 2022 07:38:19 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:50762 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S234827AbiHQLiL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 17 Aug 2022 07:38:11 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id EAE1E26F4
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:38:06 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id j7so15899838wrh.3
        for <linux-kernel@vger.kernel.org>; Wed, 17 Aug 2022 04:38:06 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=0EH8YWXVhTja6VpUXkV3+tSqJXohPTyBO2pCckBiRnA=;
        b=j3ucv4IlOnbdlv5QvfFr7NgjFQTjKeljhfrll9mBpjVLf+y9XNg0vToAbriMATNlal
         EuNbv5NKR0Q5ehWueMmJIRLcU6zXwBFTxxVfGyBPVHz1P7At2CDCWGLdXzfo0CZRb576
         6Xmf2LURWXwhhq8tezcUO6jxCHAumVz+f0BheryjMWeHfOrbOq+sN/tq/+Jrwp9CoET6
         rijdzwJ2AGtW0wRwXp02UK+97y1P4MpTnINwtHWmwtvEuNmrQi0m4F8pOmfl+bS7bk8n
         8EAlb7aSDd2KThJB7r0OozbXtw0ZAOGWxQXz4OY94ugj/PdpNAcYhi4EeMFCKDyT6123
         gADw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=0EH8YWXVhTja6VpUXkV3+tSqJXohPTyBO2pCckBiRnA=;
        b=O7ft1ENZWPid5WzvYtIMxWjBXwYMwtochQLvChPE63JkJcrU8lT58G7KEs2oF6he3R
         TOmxF4TsWUNw6u2yVxbgCGPvE4XFRLpL1lD6t7r8F79hfbR1Vr22rU9wPDS2gQWiBjD0
         3Z9/5jbdB0K86PTNXU6yywGAxnslbIhc0JZUGuUCKDiN+h7nbC7bRRNZDsOzZfl29ynf
         Kk7BT32yfhsL0M/keIv5owh0tApxasCeWCzyxmSGP/xRBKuHmT1ONWGyUvpeBpVdQOgE
         b6mEZ87nBjcEZDWNCpOX7RsZ6kM+5gKZdjWVVfT8CkHBH1tDesjfcgMLVyIAO09kFL66
         gf0A==
X-Gm-Message-State: ACgBeo3Kk2Wb6L6JK5KH2NiSSRbiUf7JT8gUz1MHOvJtuVAGLxFhss7Q
        55h8WAlCeoPhW8s/0AV+v9X2KQ==
X-Google-Smtp-Source: AA6agR41nCU+sGw6C1d8P+K1U+mKfsQzicUUuM7grpqr1YBpzx0pOtMuFIK5hxMuMWIOCNGQ8Tvuvw==
X-Received: by 2002:a5d:6f1a:0:b0:225:11d5:f39 with SMTP id ay26-20020a5d6f1a000000b0022511d50f39mr5150634wrb.41.1660736285434;
        Wed, 17 Aug 2022 04:38:05 -0700 (PDT)
Received: from srini-hackbox.lan (cpc90716-aztw32-2-0-cust825.18-1.cable.virginm.net. [86.26.103.58])
        by smtp.gmail.com with ESMTPSA id m30-20020a05600c3b1e00b003a5ad7f6de2sm2004220wms.15.2022.08.17.04.38.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 17 Aug 2022 04:38:04 -0700 (PDT)
From:   Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        linus.walleij@linaro.org
Cc:     konrad.dybcio@somainline.org, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, srinivas.kandagatla@linaro.org,
        linux-arm-msm@vger.kernel.org, linux-gpio@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] pinctrl: qcom: Add sc8280xp lpass lpi pinctrl driver
Date:   Wed, 17 Aug 2022 12:37:47 +0100
Message-Id: <20220817113747.9111-3-srinivas.kandagatla@linaro.org>
X-Mailer: git-send-email 2.21.0
In-Reply-To: <20220817113747.9111-1-srinivas.kandagatla@linaro.org>
References: <20220817113747.9111-1-srinivas.kandagatla@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE,URIBL_BLOCKED
        autolearn=unavailable autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add pinctrl driver to support pin configuration for LPASS
(Low Power Audio SubSystem) LPI (Low Power Island) pinctrl
on SC8280XP.

This IP is an additional pin control block for Audio Pins on top the
existing SoC Top level pin-controller.

Hardware setup looks like:

    TLMM GPIO[189 - 207] --> LPASS LPI GPIO [0 - 18]

This pin controller has some similarities compared to Top level
msm SoC Pin controller like 'each pin belongs to a single group'
and so on. However this one is intended to control only audio
pins in particular, which can not be configured/touched by the
Top level SoC pin controller except setting them as gpios.
Apart from this, slew rate is also available in this block for
certain pins which are connected to SLIMbus or SoundWire Bus.

Signed-off-by: Srinivas Kandagatla <srinivas.kandagatla@linaro.org>
---
 drivers/pinctrl/qcom/Kconfig                  |   9 +
 drivers/pinctrl/qcom/Makefile                 |   1 +
 .../pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c | 207 ++++++++++++++++++
 3 files changed, 217 insertions(+)
 create mode 100644 drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c

diff --git a/drivers/pinctrl/qcom/Kconfig b/drivers/pinctrl/qcom/Kconfig
index 35e59f940ddb..2961b5eb8e10 100644
--- a/drivers/pinctrl/qcom/Kconfig
+++ b/drivers/pinctrl/qcom/Kconfig
@@ -399,6 +399,15 @@ config PINCTRL_SM8450_LPASS_LPI
 	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
 	  (Low Power Island) found on the Qualcomm Technologies Inc SM8450 platform.
 
+config PINCTRL_SC8280XP_LPASS_LPI
+	tristate "Qualcomm Technologies Inc SC8280XP LPASS LPI pin controller driver"
+	depends on GPIOLIB
+	depends on PINCTRL_LPASS_LPI
+	help
+	  This is the pinctrl, pinmux, pinconf and gpiolib driver for the
+	  Qualcomm Technologies Inc LPASS (Low Power Audio SubSystem) LPI
+	  (Low Power Island) found on the Qualcomm Technologies Inc SC8280XP platform.
+
 config PINCTRL_LPASS_LPI
 	tristate "Qualcomm Technologies Inc LPASS LPI pin controller driver"
 	select PINMUX
diff --git a/drivers/pinctrl/qcom/Makefile b/drivers/pinctrl/qcom/Makefile
index 06e4cddbca68..8269a1db8794 100644
--- a/drivers/pinctrl/qcom/Makefile
+++ b/drivers/pinctrl/qcom/Makefile
@@ -46,4 +46,5 @@ obj-$(CONFIG_PINCTRL_SM8250_LPASS_LPI) += pinctrl-sm8250-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_SM8350) += pinctrl-sm8350.o
 obj-$(CONFIG_PINCTRL_SM8450) += pinctrl-sm8450.o
 obj-$(CONFIG_PINCTRL_SM8450_LPASS_LPI) += pinctrl-sm8450-lpass-lpi.o
+obj-$(CONFIG_PINCTRL_SC8280XP_LPASS_LPI) += pinctrl-sc8280xp-lpass-lpi.o
 obj-$(CONFIG_PINCTRL_LPASS_LPI) += pinctrl-lpass-lpi.o
diff --git a/drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c b/drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c
new file mode 100644
index 000000000000..4b9c0beac32e
--- /dev/null
+++ b/drivers/pinctrl/qcom/pinctrl-sc8280xp-lpass-lpi.c
@@ -0,0 +1,207 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2022 Linaro Ltd.
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
+	LPI_MUX_dmic4_clk,
+	LPI_MUX_dmic4_data,
+	LPI_MUX_i2s1_clk,
+	LPI_MUX_i2s1_data,
+	LPI_MUX_i2s1_ws,
+	LPI_MUX_i2s2_clk,
+	LPI_MUX_i2s2_data,
+	LPI_MUX_i2s2_ws,
+	LPI_MUX_i2s3_clk,
+	LPI_MUX_i2s3_data,
+	LPI_MUX_i2s3_ws,
+	LPI_MUX_qua_mi2s_data,
+	LPI_MUX_qua_mi2s_sclk,
+	LPI_MUX_qua_mi2s_ws,
+	LPI_MUX_swr_rx_clk,
+	LPI_MUX_swr_rx_data,
+	LPI_MUX_swr_tx_clk,
+	LPI_MUX_swr_tx_data,
+	LPI_MUX_wsa_swr_clk,
+	LPI_MUX_wsa_swr_data,
+	LPI_MUX_wsa2_swr_clk,
+	LPI_MUX_wsa2_swr_data,
+	LPI_MUX_ext_mclk1_a,
+	LPI_MUX_ext_mclk1_b,
+	LPI_MUX_ext_mclk1_c,
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
+static int gpio14_pins[] = { 14 };
+static int gpio15_pins[] = { 15 };
+static int gpio16_pins[] = { 16 };
+static int gpio17_pins[] = { 17 };
+static int gpio18_pins[] = { 18 };
+
+static const struct pinctrl_pin_desc sc8280xp_lpi_pins[] = {
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
+	PINCTRL_PIN(15, "gpio15"),
+	PINCTRL_PIN(16, "gpio16"),
+	PINCTRL_PIN(17, "gpio17"),
+	PINCTRL_PIN(18, "gpio18"),
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
+static const char * const dmic4_clk_groups[] = { "gpio17" };
+static const char * const dmic4_data_groups[] = { "gpio18" };
+static const char * const i2s2_clk_groups[] = { "gpio10" };
+static const char * const i2s2_ws_groups[] = { "gpio11" };
+static const char * const dmic3_clk_groups[] = { "gpio12" };
+static const char * const dmic3_data_groups[] = { "gpio13" };
+static const char * const qua_mi2s_sclk_groups[] = { "gpio0" };
+static const char * const qua_mi2s_ws_groups[] = { "gpio1" };
+static const char * const qua_mi2s_data_groups[] = { "gpio2", "gpio3", "gpio4", "gpio5" };
+static const char * const i2s1_clk_groups[] = { "gpio6" };
+static const char * const i2s1_ws_groups[] = { "gpio7" };
+static const char * const i2s1_data_groups[] = { "gpio8", "gpio9" };
+static const char * const wsa_swr_clk_groups[] = { "gpio10" };
+static const char * const wsa_swr_data_groups[] = { "gpio11" };
+static const char * const wsa2_swr_clk_groups[] = { "gpio15" };
+static const char * const wsa2_swr_data_groups[] = { "gpio16" };
+static const char * const i2s2_data_groups[] = { "gpio15", "gpio16" };
+static const char * const i2s3_clk_groups[] = { "gpio12"};
+static const char * const i2s3_ws_groups[] = { "gpio13"};
+static const char * const i2s3_data_groups[] = { "gpio17", "gpio18"};
+static const char * const ext_mclk1_c_groups[] = { "gpio5" };
+static const char * const ext_mclk1_b_groups[] = { "gpio9" };
+static const char * const ext_mclk1_a_groups[] = { "gpio13" };
+
+static const struct lpi_pingroup sc8280xp_groups[] = {
+	LPI_PINGROUP(0, 0, swr_tx_clk, qua_mi2s_sclk, _, _),
+	LPI_PINGROUP(1, 2, swr_tx_data, qua_mi2s_ws, _, _),
+	LPI_PINGROUP(2, 4, swr_tx_data, qua_mi2s_data, _, _),
+	LPI_PINGROUP(3, 8, swr_rx_clk, qua_mi2s_data, _, _),
+	LPI_PINGROUP(4, 10, swr_rx_data, qua_mi2s_data, _, _),
+	LPI_PINGROUP(5, 12, swr_rx_data, ext_mclk1_c, qua_mi2s_data, _),
+	LPI_PINGROUP(6, LPI_NO_SLEW, dmic1_clk, i2s1_clk, _,  _),
+	LPI_PINGROUP(7, LPI_NO_SLEW, dmic1_data, i2s1_ws, _, _),
+	LPI_PINGROUP(8, LPI_NO_SLEW, dmic2_clk, i2s1_data, _, _),
+	LPI_PINGROUP(9, LPI_NO_SLEW, dmic2_data, i2s1_data, ext_mclk1_b, _),
+	LPI_PINGROUP(10, 16, i2s2_clk, wsa_swr_clk, _, _),
+	LPI_PINGROUP(11, 18, i2s2_ws, wsa_swr_data, _, _),
+	LPI_PINGROUP(12, LPI_NO_SLEW, dmic3_clk, i2s3_clk, _, _),
+	LPI_PINGROUP(13, LPI_NO_SLEW, dmic3_data, i2s3_ws, ext_mclk1_a, _),
+	LPI_PINGROUP(14, 6, swr_tx_data, _, _, _),
+	LPI_PINGROUP(15, 20, i2s2_data, wsa2_swr_clk, _, _),
+	LPI_PINGROUP(16, 22, i2s2_data, wsa2_swr_data, _, _),
+	LPI_PINGROUP(17, LPI_NO_SLEW, dmic4_clk, i2s3_data, _, _),
+	LPI_PINGROUP(18, LPI_NO_SLEW, dmic4_data, i2s3_data, _, _),
+};
+
+static const struct lpi_function sc8280xp_functions[] = {
+	LPI_FUNCTION(dmic1_clk),
+	LPI_FUNCTION(dmic1_data),
+	LPI_FUNCTION(dmic2_clk),
+	LPI_FUNCTION(dmic2_data),
+	LPI_FUNCTION(dmic3_clk),
+	LPI_FUNCTION(dmic3_data),
+	LPI_FUNCTION(dmic4_clk),
+	LPI_FUNCTION(dmic4_data),
+	LPI_FUNCTION(i2s1_clk),
+	LPI_FUNCTION(i2s1_data),
+	LPI_FUNCTION(i2s1_ws),
+	LPI_FUNCTION(i2s2_clk),
+	LPI_FUNCTION(i2s2_data),
+	LPI_FUNCTION(i2s2_ws),
+	LPI_FUNCTION(i2s3_clk),
+	LPI_FUNCTION(i2s3_data),
+	LPI_FUNCTION(i2s3_ws),
+	LPI_FUNCTION(qua_mi2s_data),
+	LPI_FUNCTION(qua_mi2s_sclk),
+	LPI_FUNCTION(qua_mi2s_ws),
+	LPI_FUNCTION(swr_rx_clk),
+	LPI_FUNCTION(swr_rx_data),
+	LPI_FUNCTION(swr_tx_clk),
+	LPI_FUNCTION(swr_tx_data),
+	LPI_FUNCTION(wsa_swr_clk),
+	LPI_FUNCTION(wsa_swr_data),
+	LPI_FUNCTION(wsa2_swr_clk),
+	LPI_FUNCTION(wsa2_swr_data),
+	LPI_FUNCTION(ext_mclk1_a),
+	LPI_FUNCTION(ext_mclk1_b),
+	LPI_FUNCTION(ext_mclk1_c),
+};
+
+static const struct lpi_pinctrl_variant_data sc8280xp_lpi_data = {
+	.pins = sc8280xp_lpi_pins,
+	.npins = ARRAY_SIZE(sc8280xp_lpi_pins),
+	.groups = sc8280xp_groups,
+	.ngroups = ARRAY_SIZE(sc8280xp_groups),
+	.functions = sc8280xp_functions,
+	.nfunctions = ARRAY_SIZE(sc8280xp_functions),
+};
+
+static const struct of_device_id lpi_pinctrl_of_match[] = {
+	{
+	       .compatible = "qcom,sc8280xp-lpass-lpi-pinctrl",
+	       .data = &sc8280xp_lpi_data,
+	},
+	{ }
+};
+MODULE_DEVICE_TABLE(of, lpi_pinctrl_of_match);
+
+static struct platform_driver lpi_pinctrl_driver = {
+	.driver = {
+		   .name = "qcom-sc8280xp-lpass-lpi-pinctrl",
+		   .of_match_table = lpi_pinctrl_of_match,
+	},
+	.probe = lpi_pinctrl_probe,
+	.remove = lpi_pinctrl_remove,
+};
+
+module_platform_driver(lpi_pinctrl_driver);
+MODULE_DESCRIPTION("QTI SC8280XP LPI GPIO pin control driver");
+MODULE_LICENSE("GPL");
-- 
2.21.0

