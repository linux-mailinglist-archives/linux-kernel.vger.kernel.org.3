Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 65827527A0B
	for <lists+linux-kernel@lfdr.de>; Sun, 15 May 2022 22:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238780AbiEOUqD (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sun, 15 May 2022 16:46:03 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:41684 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236889AbiEOUpt (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sun, 15 May 2022 16:45:49 -0400
Received: from mail-ej1-x62b.google.com (mail-ej1-x62b.google.com [IPv6:2a00:1450:4864:20::62b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4A46D237E3;
        Sun, 15 May 2022 13:45:47 -0700 (PDT)
Received: by mail-ej1-x62b.google.com with SMTP id kq17so25236301ejb.4;
        Sun, 15 May 2022 13:45:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=z4yqHabd5CdFPeT9f5nmAl+CrDATY8pyW6w/Lrkuj98=;
        b=aUJ9KqHDVOOuDz2nB5BMgxSxCHgO2cIv9slCWZs7RR2TMTZDwImJ9dgidaL5Y6FVXH
         Bh2tDpCcGXfB/BQ2h+M67P7jr268sQ2EDEGP0wKmcA+8VIX49tiZP75fBlVmP5X+iHzc
         e8RlN33Mwp15eZlyn6aRwgff6yDk3C0njESgFNXj+sbk2v/71edLHGbeojiGe8i9zYho
         T5mEsYxu8/8cbXCLL0ZMtzs9B97lOErPGZAVfxDoKuqKGN7rr8XlsDNCyjk1tLsRlwZS
         wTQZ1XG2ea6tpc3j8HcLZaGT9FkzKLSTByoT2kkO6VOA8cYTE3RNTEGUo4Kj8pwrMaSd
         vEfg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=z4yqHabd5CdFPeT9f5nmAl+CrDATY8pyW6w/Lrkuj98=;
        b=bAdaW7V+z1maxc4vU+F20jRJhu/qvd8WJO8eHkf/Ro1t3eCVWjq954FxkZY9E+xZaL
         0fRWfA638VFHeuCT32CqvxqFmTVr9EOoZPn+kKBd26K4/or7hVRozP5nnRPq10tJpuyk
         3RsgV1luE3GAUtpTs0ACpzcSN97tzhGbsJAQXNNoIgPeBCY9Sz0Wia6R7bLVAdUj0kui
         5JajEl2HWlGhZj2EcEQIZ4ttOLkQfWDFcVA0HyrIr0V35wmx+CGL7pI4coDpiozBmgW3
         xaEURWSnUhjWmBVyHKcfWivOiYi/vIJ4AVod5nqLN1cr5BS2Re1Ba/q4C7iagomIZCK6
         JTsQ==
X-Gm-Message-State: AOAM532WvilDPusSvO/T5wnDKOVxBTqdjcUZghP8ZWaK5fnBkMbiC0OD
        pK6H51UyL33tuGCQpBABjEo=
X-Google-Smtp-Source: ABdhPJxtFM0rwoV6GkeSgdYjJllLtlFqhnW5QQ+C/jJUo3leaO6fNyR6TZecfRWm+VdNSOMI1m/eGQ==
X-Received: by 2002:a17:907:8a0e:b0:6f5:a48:e04e with SMTP id sc14-20020a1709078a0e00b006f50a48e04emr12640412ejc.228.1652647545611;
        Sun, 15 May 2022 13:45:45 -0700 (PDT)
Received: from fedora.robimarko.hr (dh207-98-105.xnet.hr. [88.207.98.105])
        by smtp.googlemail.com with ESMTPSA id i10-20020a50870a000000b0042617ba63cdsm4174156edb.87.2022.05.15.13.45.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 15 May 2022 13:45:45 -0700 (PDT)
From:   Robert Marko <robimarko@gmail.com>
To:     agross@kernel.org, bjorn.andersson@linaro.org,
        jassisinghbrar@gmail.com, robh+dt@kernel.org,
        krzysztof.kozlowski+dt@linaro.org, mturquette@baylibre.com,
        sboyd@kernel.org, linux-arm-msm@vger.kernel.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        linux-clk@vger.kernel.org
Cc:     Robert Marko <robimarko@gmail.com>,
        Ansuel Smith <ansuelsmth@gmail.com>
Subject: [PATCH v4 3/6] clk: qcom: Add IPQ8074 APSS clock controller
Date:   Sun, 15 May 2022 22:45:37 +0200
Message-Id: <20220515204540.477711-3-robimarko@gmail.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220515204540.477711-1-robimarko@gmail.com>
References: <20220515204540.477711-1-robimarko@gmail.com>
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
2.36.1

