Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 7FD6951EA24
	for <lists+linux-kernel@lfdr.de>; Sat,  7 May 2022 22:37:12 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1446976AbiEGUkX (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 7 May 2022 16:40:23 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36540 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1386612AbiEGUkQ (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 7 May 2022 16:40:16 -0400
Received: from mail-ej1-x62c.google.com (mail-ej1-x62c.google.com [IPv6:2a00:1450:4864:20::62c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 5604D1401C;
        Sat,  7 May 2022 13:36:28 -0700 (PDT)
Received: by mail-ej1-x62c.google.com with SMTP id dk23so20146747ejb.8;
        Sat, 07 May 2022 13:36:28 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dGJC+Bs+gJ1awQTG1Kw29NfK1ye6F6x7CH4HnoOeRyo=;
        b=flHfAiE30/Hb40tkBXXoAM5C+a6d/l1KvyOO3mN8S/w4tR+hXKvqtZisa3kEEio3Jk
         U5dDGL9qyxS5V2hAbdKkfORSgAP4e6zXZQ1p0CK8y8+ThW6VX6Lx7V6Pn2h/OTRDgxa0
         gdGaXeMmLGT+lWEVRMB7sh9hNL57xgLIlzqXWzoiyp4hUXJcMGjN+Yq/9aFNnoMBz81w
         AyBsLCXc2LsX+yADSasqYFhe+VRCbbIaONvXeB1xU2WubpwD2QncnoMAkp9j9fHGduef
         RJC4ccXhYg5pyNXh/2ywFgw2zSLgd/owWfe/i9VogxnEh1hZWZ7aRs4TFCJWQ6/6xAIm
         R2vg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dGJC+Bs+gJ1awQTG1Kw29NfK1ye6F6x7CH4HnoOeRyo=;
        b=cgmEaHVZmIxnJ8D8oQ4V4Hm6r/WgIRmmwR7tRNVhvaoHMBjmyMSvfCibWUJDe+Jlf9
         zVvNoGRXMpPY0RlWJapO05aE0DkEla8WJ/T6WnIofqgp5oPVj2/v+tnJqtmACkIU9UXP
         01lqvH/Cb0skjtMZ4jjLfJ7D6QHf+bkX6XKuCpBqjs98JqsaPXpyHlB1/YArHhBT1XC5
         Sc33wEaAC0Zp175ZsY5oOuqOl/01I7Pa+KwFK1x1bK4AaK5A2oIUmAT0KBWS/si8QD7e
         6/8kORdEQqMjGBv2/uuUCZe2Nzdk4iCjXuJ5qZmZwwdaYyX72p4T42CL6gb4walRWqS3
         LyTw==
X-Gm-Message-State: AOAM531PEBJ6b1Ddg5l2jmC1wOT37teNNA6HO2NCnnHR8alPomCgyQTk
        18rNyCTQodrrnGAcZciYyTE=
X-Google-Smtp-Source: ABdhPJxMDTVQIWK2z2p/nOL15ScK/6xRLlF8wyhdKMIS59iMNoev6QTvFUuyKAJxJYAXlxnFkMt0qA==
X-Received: by 2002:a17:907:d29:b0:6f4:87d4:ecad with SMTP id gn41-20020a1709070d2900b006f487d4ecadmr8218690ejc.166.1651955786873;
        Sat, 07 May 2022 13:36:26 -0700 (PDT)
Received: from fedora.robimarko.hr (cpezg-94-253-144-244-cbl.xnet.hr. [94.253.144.244])
        by smtp.googlemail.com with ESMTPSA id eb20-20020a170907281400b006f4c557b7d2sm3283456ejc.203.2022.05.07.13.36.25
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sat, 07 May 2022 13:36:26 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v3 3/6] clk: qcom: Add IPQ8074 APSS clock controller
Date:   Sat,  7 May 2022 22:36:17 +0200
Message-Id: <20220507203620.399028-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220507203620.399028-1-robimarko@gmail.com>
References: <20220507203620.399028-1-robimarko@gmail.com>
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

IPQ8074 APSS clock controller provides the clock for the IPQ8074 CPU
cores, thus also providing support for CPU frequency scaling.

It looks like they are clocked by the XO and a custom APSS type PLL.

Co-developed-by: Ansuel Smith <ansuelsmth@gmail.com>
Signed-off-by: Ansuel Smith <ansuelsmth@gmail.com>
Signed-off-by: Robert Marko <robimarko@gmail.com>
---
Changes in v2:
* Convert to using parent-data instead of parent-names
---
 drivers/clk/qcom/Kconfig        |  11 +++
 drivers/clk/qcom/Makefile       |   1 +
 drivers/clk/qcom/apss-ipq8074.c | 170 ++++++++++++++++++++++++++++++++
 3 files changed, 182 insertions(+)
 create mode 100644 drivers/clk/qcom/apss-ipq8074.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 00fe5f066de5..9494eb74374a 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -134,6 +134,17 @@ config IPQ_APSS_6018
 	  Say Y if you want to support CPU frequency scaling on
 	  ipq based devices.
 
+config IPQ_APSS_8074
+	tristate "IPQ8074 APSS Clock Controller"
+	select IPQ_GCC_8074
+	depends on QCOM_APCS_IPC || COMPILE_TEST
+	help
+	  Support for APSS clock controller on IPQ8074 platforms. The
+	  APSS clock controller manages the Mux and enable block that feeds the
+	  CPUs.
+	  Say Y if you want to support CPU frequency scaling on
+	  IPQ8074 based devices.
+
 config IPQ_GCC_4019
 	tristate "IPQ4019 Global Clock Controller"
 	help
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 671cf5821af1..7b2da6dd570c 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -22,6 +22,7 @@ obj-$(CONFIG_APQ_MMCC_8084) += mmcc-apq8084.o
 obj-$(CONFIG_CLK_GFM_LPASS_SM8250) += lpass-gfm-sm8250.o
 obj-$(CONFIG_IPQ_APSS_PLL) += apss-ipq-pll.o
 obj-$(CONFIG_IPQ_APSS_6018) += apss-ipq6018.o
+obj-$(CONFIG_IPQ_APSS_8074) += apss-ipq8074.o
 obj-$(CONFIG_IPQ_GCC_4019) += gcc-ipq4019.o
 obj-$(CONFIG_IPQ_GCC_6018) += gcc-ipq6018.o
 obj-$(CONFIG_IPQ_GCC_806X) += gcc-ipq806x.o
diff --git a/drivers/clk/qcom/apss-ipq8074.c b/drivers/clk/qcom/apss-ipq8074.c
new file mode 100644
index 000000000000..38d03cd0ff76
--- /dev/null
+++ b/drivers/clk/qcom/apss-ipq8074.c
@@ -0,0 +1,170 @@
+// SPDX-License-Identifier: GPL-2.0
+/*
+ * Copyright (c) 2022, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,apss-ipq8074.h>
+
+#include "common.h"
+#include "clk-regmap.h"
+#include "clk-pll.h"
+#include "clk-rcg.h"
+#include "clk-branch.h"
+#include "clk-alpha-pll.h"
+#include "clk-regmap-divider.h"
+#include "clk-regmap-mux.h"
+
+#define F(f, s, h, m, n) { (f), (s), (2 * (h) - 1), (m), (n) }
+
+enum {
+	P_XO,
+	P_GPLL0,
+	P_GPLL2,
+	P_GPLL4,
+	P_APSS_PLL_EARLY,
+	P_APSS_PLL
+};
+
+static struct clk_alpha_pll apss_pll_early = {
+	.offset = 0x5000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_APSS],
+	.clkr = {
+		.enable_reg = 0x5000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "apss_pll_early",
+			.parent_data = &(const struct clk_parent_data) {
+				.fw_name = "xo", .name = "xo"
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_huayra_ops,
+		},
+	},
+};
+
+static struct clk_alpha_pll_postdiv apss_pll = {
+	.offset = 0x5000,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_APSS],
+	.width = 2,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "apss_pll",
+		.parent_hws = (const struct clk_hw *[]){
+			&apss_pll_early.clkr.hw },
+		.num_parents = 1,
+		.ops = &clk_alpha_pll_postdiv_ro_ops,
+	},
+};
+
+static const struct clk_parent_data parents_apcs_alias0_clk_src[] = {
+	{ .fw_name = "xo", .name = "xo" },
+	{ .fw_name = "gpll0", .name = "gpll0" },
+	{ .fw_name = "gpll2", .name = "gpll2" },
+	{ .fw_name = "gpll4", .name = "gpll4" },
+	{ .hw = &apss_pll.clkr.hw },
+	{ .hw = &apss_pll_early.clkr.hw },
+};
+
+static const struct parent_map parents_apcs_alias0_clk_src_map[] = {
+	{ P_XO, 0 },
+	{ P_GPLL0, 4 },
+	{ P_GPLL2, 2 },
+	{ P_GPLL4, 1 },
+	{ P_APSS_PLL, 3 },
+	{ P_APSS_PLL_EARLY, 5 },
+};
+
+struct freq_tbl ftbl_apcs_alias0_clk_src[] = {
+	F(19200000, P_XO, 1, 0, 0),
+	F(403200000, P_APSS_PLL_EARLY, 1, 0, 0),
+	F(806400000, P_APSS_PLL_EARLY, 1, 0, 0),
+	F(1017600000, P_APSS_PLL_EARLY, 1, 0, 0),
+	F(1382400000, P_APSS_PLL_EARLY, 1, 0, 0),
+	F(1651200000, P_APSS_PLL_EARLY, 1, 0, 0),
+	F(1843200000, P_APSS_PLL_EARLY, 1, 0, 0),
+	F(1920000000, P_APSS_PLL_EARLY, 1, 0, 0),
+	F(2208000000UL, P_APSS_PLL_EARLY, 1, 0, 0),
+	{ }
+};
+
+struct clk_rcg2 apcs_alias0_clk_src = {
+	.cmd_rcgr = 0x0050,
+	.freq_tbl = ftbl_apcs_alias0_clk_src,
+	.hid_width = 5,
+	.parent_map = parents_apcs_alias0_clk_src_map,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "apcs_alias0_clk_src",
+		.parent_data = parents_apcs_alias0_clk_src,
+		.num_parents = ARRAY_SIZE(parents_apcs_alias0_clk_src),
+		.ops = &clk_rcg2_ops,
+		.flags = CLK_SET_RATE_PARENT,
+	},
+};
+
+static struct clk_branch apcs_alias0_core_clk = {
+	.halt_reg = 0x0058,
+	.halt_bit = 31,
+	.clkr = {
+		.enable_reg = 0x0058,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "apcs_alias0_core_clk",
+			.parent_hws = (const struct clk_hw *[]){
+				&apcs_alias0_clk_src.clkr.hw },
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT |
+				CLK_IS_CRITICAL,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *apss_ipq8074_clks[] = {
+	[APSS_PLL_EARLY] = &apss_pll_early.clkr,
+	[APSS_PLL] = &apss_pll.clkr,
+	[APCS_ALIAS0_CLK_SRC] = &apcs_alias0_clk_src.clkr,
+	[APCS_ALIAS0_CORE_CLK] = &apcs_alias0_core_clk.clkr,
+};
+
+static const struct regmap_config apss_ipq8074_regmap_config = {
+	.reg_bits       = 32,
+	.reg_stride     = 4,
+	.val_bits       = 32,
+	.max_register   = 0x5ffc,
+	.fast_io	= true,
+};
+
+static const struct qcom_cc_desc apss_ipq8074_desc = {
+	.config = &apss_ipq8074_regmap_config,
+	.clks = apss_ipq8074_clks,
+	.num_clks = ARRAY_SIZE(apss_ipq8074_clks),
+};
+
+static int apss_ipq8074_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = dev_get_regmap(pdev->dev.parent, NULL);
+	if (!regmap)
+		return -ENODEV;
+
+	return qcom_cc_really_probe(pdev, &apss_ipq8074_desc, regmap);
+}
+
+static struct platform_driver apss_ipq8074_driver = {
+	.probe = apss_ipq8074_probe,
+	.driver = {
+		.name   = "qcom,apss-ipq8074-clk",
+	},
+};
+
+module_platform_driver(apss_ipq8074_driver);
+
+MODULE_DESCRIPTION("Qualcomm IPQ8074 APSS clock driver");
+MODULE_LICENSE("GPL");
-- 
2.35.1

