Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0AA2559A6F9
	for <lists+linux-kernel@lfdr.de>; Fri, 19 Aug 2022 22:23:01 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1351378AbiHSUNd (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 19 Aug 2022 16:13:33 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56528 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351270AbiHSUNX (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 19 Aug 2022 16:13:23 -0400
Received: from mail-lf1-x12b.google.com (mail-lf1-x12b.google.com [IPv6:2a00:1450:4864:20::12b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7AA6DB7E1;
        Fri, 19 Aug 2022 13:13:20 -0700 (PDT)
Received: by mail-lf1-x12b.google.com with SMTP id z25so7491573lfr.2;
        Fri, 19 Aug 2022 13:13:20 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=sA/5SNIhRoSyphETW+Biclz4z5RAa+oqr9k7oD4p968=;
        b=AdJFY3q3His6K0T/v2dILGzyXVT4boX8IsTEUA5cN3gmn4MiSX49CcReNBfqvPtQPF
         DRwJX54r5uJ88a6vuYE6qiB1VRuxesYEXBGaEQ9/k1wqmKxoUtOpZk/WeUpyh4/XeJ6R
         XdnGn3rAWo0KjiWsT6oBFRNzpkFO/BrWnp1wFOTdhflg7GeJ3I/7OF5TmtJXUrSP6Vdi
         5UGPkKB8ObnWNtiYXL0THPgVbLjST4MQvi00g7Z8V2Oo+2Ba20GvFMG0iQp+ql7L9qda
         /nMkOAZYXmnqOA1rZ/akBHndpzbmmeQNpt/2pdhJMuh3COfiAuLI1JFVzwj8hQPAvnrX
         PeeQ==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=sA/5SNIhRoSyphETW+Biclz4z5RAa+oqr9k7oD4p968=;
        b=hb0J6MX6eQAZh38wJ2RnPvcksuF/DxXy9R4Z4TWjS07MQlPs79WN52PbUHUmsscRwQ
         uYQ/jeE6ys3en3gQutcQeNpOXrIJes1vjFQn0N2H0uVLlO34EvrDyRqbc/5/613BG0hQ
         G8NV+kIEr7kjmuxsFYp0DfcQq7bYh3X674ZZZrWLKWIYtfMukS7mw4ZOtS8406R5+YBf
         hxPHtyrotKrtZBA+xC00mmS9Q/NIgz6M/fwf/VdfVohQzuGw32ARMVhJ1rSBrbTPnyiL
         TDEvGc1yFnaWYkKUjWgUFk4zo4vaQ2OZcqpfWXQc0N5AThlUZw6QkzBDDgWACnrzII9S
         i8Bg==
X-Gm-Message-State: ACgBeo0QcCTMg4l6wrROr0mGWZcB5FbLaYDMlW8OBpLL+b8kosJh1LII
        fRHSDXdGRa+RO4l3/bFylM8pLe7aTRw=
X-Google-Smtp-Source: AA6agR6tsZcEJtBD6fUa285H7PJzEF30xgcPAYN42F9VYtGJ7xaJJvCnm/PDEYrtKBAJqTBYoKRnjg==
X-Received: by 2002:a19:6410:0:b0:492:b645:75f2 with SMTP id y16-20020a196410000000b00492b64575f2mr2823524lfb.560.1660939998788;
        Fri, 19 Aug 2022 13:13:18 -0700 (PDT)
Received: from localhost.localdomain (admv234.neoplus.adsl.tpnet.pl. [79.185.51.234])
        by smtp.gmail.com with ESMTPSA id h25-20020ac250d9000000b004916f129729sm753895lfm.50.2022.08.19.13.13.17
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Fri, 19 Aug 2022 13:13:18 -0700 (PDT)
From:   Adam Skladowski <a39.skl@gmail.com>
Cc:     phone-devel@vger.kernel.org, ~postmarketos/upstreaming@lists.sr.ht,
        Adam Skladowski <a39.skl@gmail.com>,
        Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH v2 2/2] clk: qcom: Add display clock controller driver for SM6115
Date:   Fri, 19 Aug 2022 22:12:22 +0200
Message-Id: <20220819201231.23474-3-a39.skl@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220819201231.23474-1-a39.skl@gmail.com>
References: <20220819201231.23474-1-a39.skl@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_FROM,
        RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support for the display clock controller found in SM6115/SM4250
based devices. This clock controller feeds the Multimedia Display
SubSystem (MDSS).
This driver is based upon one submitted for QCM2290.

Signed-off-by: Adam Skladowski <a39.skl@gmail.com>
---
 drivers/clk/qcom/Kconfig         |   9 +
 drivers/clk/qcom/Makefile        |   1 +
 drivers/clk/qcom/dispcc-sm6115.c | 615 +++++++++++++++++++++++++++++++
 3 files changed, 625 insertions(+)
 create mode 100644 drivers/clk/qcom/dispcc-sm6115.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 1cf1ef70e347..852888a849ae 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -616,6 +616,15 @@ config SM_CAMCC_8450
 	  Support for the camera clock controller on SM8450 devices.
 	  Say Y if you want to support camera devices and camera functionality.
 
+config SM_DISPCC_6115
+	tristate "SM6115 Display Clock Controller"
+	depends on SM_GCC_6115
+	help
+	  Support for the display clock controller on Qualcomm Technologies, Inc
+	  SM6115/SM4250 devices.
+	  Say Y if you want to support display devices and functionality such as
+	  splash screen
+
 config SM_DISPCC_6125
 	tristate "SM6125 Display Clock Controller"
 	depends on SM_GCC_6125
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index fbcf04073f07..a732ccb3b912 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -90,6 +90,7 @@ obj-$(CONFIG_SDX_GCC_55) += gcc-sdx55.o
 obj-$(CONFIG_SDX_GCC_65) += gcc-sdx65.o
 obj-$(CONFIG_SM_CAMCC_8250) += camcc-sm8250.o
 obj-$(CONFIG_SM_CAMCC_8450) += camcc-sm8450.o
+obj-$(CONFIG_SM_DISPCC_6115) += dispcc-sm6115.o
 obj-$(CONFIG_SM_DISPCC_6125) += dispcc-sm6125.o
 obj-$(CONFIG_SM_DISPCC_6350) += dispcc-sm6350.o
 obj-$(CONFIG_SM_DISPCC_8250) += dispcc-sm8250.o
diff --git a/drivers/clk/qcom/dispcc-sm6115.c b/drivers/clk/qcom/dispcc-sm6115.c
new file mode 100644
index 000000000000..6a8994bfe9d0
--- /dev/null
+++ b/drivers/clk/qcom/dispcc-sm6115.c
@@ -0,0 +1,615 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Based on dispcc-qcm2290.c
+ * Copyright (c) 2020, The Linux Foundation. All rights reserved.
+ * Copyright (c) 2021, Linaro Ltd.
+ */
+
+#include <linux/err.h>
+#include <linux/kernel.h>
+#include <linux/module.h>
+#include <linux/of_device.h>
+#include <linux/of.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,sm6115-dispcc.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap.h"
+#include "clk-regmap-divider.h"
+#include "common.h"
+#include "gdsc.h"
+
+enum {
+	P_BI_TCXO,
+	P_DISP_CC_PLL0_OUT_MAIN,
+	P_DSI0_PHY_PLL_OUT_BYTECLK,
+	P_DSI0_PHY_PLL_OUT_DSICLK,
+	P_DSI1_PHY_PLL_OUT_DSICLK,
+	P_GPLL0_OUT_MAIN,
+	P_SLEEP_CLK,
+};
+
+static const struct pll_vco spark_vco[] = {
+	{ 500000000, 1000000000, 2 },
+};
+
+/* 768MHz configuration */
+static const struct alpha_pll_config disp_cc_pll0_config = {
+	.l = 0x28,
+	.alpha = 0x0,
+	.alpha_en_mask = BIT(24),
+	.vco_val = 0x2 << 20,
+	.vco_mask = GENMASK(21, 20),
+	.main_output_mask = BIT(0),
+	.config_ctl_val = 0x4001055B,
+};
+
+static struct clk_alpha_pll disp_cc_pll0 = {
+	.offset = 0x0,
+	.vco_table = spark_vco,
+	.num_vco = ARRAY_SIZE(spark_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_pll0",
+			.parent_data = &(const struct clk_parent_data){
+				.fw_name = "bi_tcxo",
+			},
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_ops,
+		},
+	},
+};
+
+static const struct clk_div_table post_div_table_disp_cc_pll0_out_main[] = {
+	{ 0x0, 1 },
+	{ }
+};
+static struct clk_alpha_pll_postdiv disp_cc_pll0_out_main = {
+	.offset = 0x0,
+	.post_div_shift = 8,
+	.post_div_table = post_div_table_disp_cc_pll0_out_main,
+	.num_post_div = ARRAY_SIZE(post_div_table_disp_cc_pll0_out_main),
+	.width = 4,
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_DEFAULT],
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_pll0_out_main",
+		.parent_names = (const char *[]){ "disp_cc_pll0" },
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_alpha_pll_postdiv_ops,
+	},
+};
+
+
+static const struct parent_map disp_cc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_DSI0_PHY_PLL_OUT_BYTECLK, 1 },
+};
+
+static const struct clk_parent_data disp_cc_parent_data_0[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .fw_name = "dsi0_phy_pll_out_byteclk" },
+};
+
+static const struct parent_map disp_cc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+};
+
+static const struct clk_parent_data disp_cc_parent_data_1[] = {
+	{ .fw_name = "bi_tcxo" },
+};
+
+static const struct parent_map disp_cc_parent_map_2[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPLL0_OUT_MAIN, 4 },
+};
+
+static const struct clk_parent_data disp_cc_parent_data_2[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .fw_name = "gcc_disp_gpll0_div_clk_src" },
+};
+
+static const struct parent_map disp_cc_parent_map_3[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_DISP_CC_PLL0_OUT_MAIN, 1 },
+	{ P_GPLL0_OUT_MAIN, 4 },
+};
+
+static const struct clk_parent_data disp_cc_parent_data_3[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .hw = &disp_cc_pll0_out_main.clkr.hw },
+	{ .fw_name = "gcc_disp_gpll0_clk_src" },
+};
+
+static const struct parent_map disp_cc_parent_map_4[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_DSI0_PHY_PLL_OUT_DSICLK, 1 },
+	{ P_DSI1_PHY_PLL_OUT_DSICLK, 2 },
+};
+
+static const struct clk_parent_data disp_cc_parent_data_4[] = {
+	{ .fw_name = "bi_tcxo" },
+	{ .fw_name = "dsi0_phy_pll_out_dsiclk" },
+	{ .fw_name = "dsi1_phy_pll_out_dsiclk" },
+};
+
+static const struct parent_map disp_cc_parent_map_5[] = {
+	{ P_SLEEP_CLK, 0 },
+};
+
+static const struct clk_parent_data disp_cc_parent_data_5[] = {
+	{ .fw_name = "sleep_clk" },
+};
+
+static struct clk_rcg2 disp_cc_mdss_byte0_clk_src = {
+	.cmd_rcgr = 0x20bc,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_0,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_byte0_clk_src",
+		.parent_data = disp_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
+		/* For set_rate and set_parent to succeed, parent(s) must be enabled */
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_byte2_ops,
+	},
+};
+
+static struct clk_regmap_div disp_cc_mdss_byte0_div_clk_src = {
+	.reg = 0x20d4,
+	.shift = 0,
+	.width = 2,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "disp_cc_mdss_byte0_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&disp_cc_mdss_byte0_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.ops = &clk_regmap_div_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_disp_cc_mdss_ahb_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(37500000, P_GPLL0_OUT_MAIN, 8, 0, 0),
+	F(75000000, P_GPLL0_OUT_MAIN, 4, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 disp_cc_mdss_ahb_clk_src = {
+	.cmd_rcgr = 0x2154,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_2,
+	.freq_tbl = ftbl_disp_cc_mdss_ahb_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_ahb_clk_src",
+		.parent_data = disp_cc_parent_data_2,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_2),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_disp_cc_mdss_esc0_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 disp_cc_mdss_esc0_clk_src = {
+	.cmd_rcgr = 0x20d8,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_0,
+	.freq_tbl = ftbl_disp_cc_mdss_esc0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_esc0_clk_src",
+		.parent_data = disp_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_0),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_disp_cc_mdss_mdp_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(192000000, P_DISP_CC_PLL0_OUT_MAIN, 4, 0, 0),
+	F(256000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(307200000, P_DISP_CC_PLL0_OUT_MAIN, 2.5, 0, 0),
+	F(384000000, P_DISP_CC_PLL0_OUT_MAIN, 2, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 disp_cc_mdss_mdp_clk_src = {
+	.cmd_rcgr = 0x2074,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_3,
+	.freq_tbl = ftbl_disp_cc_mdss_mdp_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_mdp_clk_src",
+		.parent_data = disp_cc_parent_data_3,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 disp_cc_mdss_pclk0_clk_src = {
+	.cmd_rcgr = 0x205c,
+	.mnd_width = 8,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_4,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_pclk0_clk_src",
+		.parent_data = disp_cc_parent_data_4,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_4),
+		/* For set_rate and set_parent to succeed, parent(s) must be enabled */
+		.flags = CLK_SET_RATE_PARENT | CLK_OPS_PARENT_ENABLE | CLK_GET_RATE_NOCACHE,
+		.ops = &clk_pixel_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_disp_cc_mdss_rot_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(192000000, P_DISP_CC_PLL0_OUT_MAIN, 4, 0, 0),
+	F(256000000, P_DISP_CC_PLL0_OUT_MAIN, 3, 0, 0),
+	F(307200000, P_DISP_CC_PLL0_OUT_MAIN, 2.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 disp_cc_mdss_rot_clk_src = {
+	.cmd_rcgr = 0x208c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_3,
+	.freq_tbl = ftbl_disp_cc_mdss_rot_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_rot_clk_src",
+		.parent_data = disp_cc_parent_data_3,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_3),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_rcg2 disp_cc_mdss_vsync_clk_src = {
+	.cmd_rcgr = 0x20a4,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_1,
+	.freq_tbl = ftbl_disp_cc_mdss_esc0_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_mdss_vsync_clk_src",
+		.parent_data = disp_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_1),
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_disp_cc_sleep_clk_src[] = {
+	F(32764, P_SLEEP_CLK, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 disp_cc_sleep_clk_src = {
+	.cmd_rcgr = 0x6050,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = disp_cc_parent_map_5,
+	.freq_tbl = ftbl_disp_cc_sleep_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "disp_cc_sleep_clk_src",
+		.parent_data = disp_cc_parent_data_5,
+		.num_parents = ARRAY_SIZE(disp_cc_parent_data_5),
+		.ops = &clk_rcg2_ops,
+	},
+};
+
+static struct clk_branch disp_cc_mdss_ahb_clk = {
+	.halt_reg = 0x2044,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2044,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&disp_cc_mdss_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_byte0_clk = {
+	.halt_reg = 0x2024,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2024,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_byte0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&disp_cc_mdss_byte0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_byte0_intf_clk = {
+	.halt_reg = 0x2028,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2028,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_byte0_intf_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&disp_cc_mdss_byte0_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_esc0_clk = {
+	.halt_reg = 0x202c,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x202c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_esc0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&disp_cc_mdss_esc0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_mdp_clk = {
+	.halt_reg = 0x2008,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2008,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_mdp_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&disp_cc_mdss_mdp_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_mdp_lut_clk = {
+	.halt_reg = 0x2018,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x2018,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_mdp_lut_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&disp_cc_mdss_mdp_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_non_gdsc_ahb_clk = {
+	.halt_reg = 0x4004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x4004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_non_gdsc_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&disp_cc_mdss_ahb_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_pclk0_clk = {
+	.halt_reg = 0x2004,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_pclk0_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&disp_cc_mdss_pclk0_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT | CLK_GET_RATE_NOCACHE,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_rot_clk = {
+	.halt_reg = 0x2010,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2010,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_rot_clk",
+			.parent_names = (const char *[]){
+				"disp_cc_mdss_rot_clk_src",
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_mdss_vsync_clk = {
+	.halt_reg = 0x2020,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x2020,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_mdss_vsync_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&disp_cc_mdss_vsync_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch disp_cc_sleep_clk = {
+	.halt_reg = 0x6068,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x6068,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "disp_cc_sleep_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&disp_cc_sleep_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct gdsc mdss_gdsc = {
+	.gdscr = 0x3000,
+	.pd = {
+		.name = "mdss_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = HW_CTRL,
+};
+
+static struct gdsc *disp_cc_sm6115_gdscs[] = {
+	[MDSS_GDSC] = &mdss_gdsc,
+};
+
+static struct clk_regmap *disp_cc_sm6115_clocks[] = {
+	[DISP_CC_PLL0] = &disp_cc_pll0.clkr,
+	[DISP_CC_PLL0_OUT_MAIN] = &disp_cc_pll0_out_main.clkr,
+	[DISP_CC_MDSS_AHB_CLK] = &disp_cc_mdss_ahb_clk.clkr,
+	[DISP_CC_MDSS_AHB_CLK_SRC] = &disp_cc_mdss_ahb_clk_src.clkr,
+	[DISP_CC_MDSS_BYTE0_CLK] = &disp_cc_mdss_byte0_clk.clkr,
+	[DISP_CC_MDSS_BYTE0_CLK_SRC] = &disp_cc_mdss_byte0_clk_src.clkr,
+	[DISP_CC_MDSS_BYTE0_DIV_CLK_SRC] = &disp_cc_mdss_byte0_div_clk_src.clkr,
+	[DISP_CC_MDSS_BYTE0_INTF_CLK] = &disp_cc_mdss_byte0_intf_clk.clkr,
+	[DISP_CC_MDSS_ESC0_CLK] = &disp_cc_mdss_esc0_clk.clkr,
+	[DISP_CC_MDSS_ESC0_CLK_SRC] = &disp_cc_mdss_esc0_clk_src.clkr,
+	[DISP_CC_MDSS_MDP_CLK] = &disp_cc_mdss_mdp_clk.clkr,
+	[DISP_CC_MDSS_MDP_CLK_SRC] = &disp_cc_mdss_mdp_clk_src.clkr,
+	[DISP_CC_MDSS_MDP_LUT_CLK] = &disp_cc_mdss_mdp_lut_clk.clkr,
+	[DISP_CC_MDSS_NON_GDSC_AHB_CLK] = &disp_cc_mdss_non_gdsc_ahb_clk.clkr,
+	[DISP_CC_MDSS_PCLK0_CLK] = &disp_cc_mdss_pclk0_clk.clkr,
+	[DISP_CC_MDSS_PCLK0_CLK_SRC] = &disp_cc_mdss_pclk0_clk_src.clkr,
+	[DISP_CC_MDSS_ROT_CLK] = &disp_cc_mdss_rot_clk.clkr,
+	[DISP_CC_MDSS_ROT_CLK_SRC] = &disp_cc_mdss_rot_clk_src.clkr,
+	[DISP_CC_MDSS_VSYNC_CLK] = &disp_cc_mdss_vsync_clk.clkr,
+	[DISP_CC_MDSS_VSYNC_CLK_SRC] = &disp_cc_mdss_vsync_clk_src.clkr,
+	[DISP_CC_SLEEP_CLK] = &disp_cc_sleep_clk.clkr,
+	[DISP_CC_SLEEP_CLK_SRC] = &disp_cc_sleep_clk_src.clkr,
+};
+
+static const struct regmap_config disp_cc_sm6115_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x10000,
+	.fast_io = true,
+};
+
+static const struct qcom_cc_desc disp_cc_sm6115_desc = {
+	.config = &disp_cc_sm6115_regmap_config,
+	.clks = disp_cc_sm6115_clocks,
+	.num_clks = ARRAY_SIZE(disp_cc_sm6115_clocks),
+	.gdscs = disp_cc_sm6115_gdscs,
+	.num_gdscs = ARRAY_SIZE(disp_cc_sm6115_gdscs),
+};
+
+static const struct of_device_id disp_cc_sm6115_match_table[] = {
+	{ .compatible = "qcom,sm6115-dispcc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, disp_cc_sm6115_match_table);
+
+static int disp_cc_sm6115_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+	int ret;
+
+	regmap = qcom_cc_map(pdev, &disp_cc_sm6115_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_alpha_pll_configure(&disp_cc_pll0, regmap, &disp_cc_pll0_config);
+
+	/* Keep DISP_CC_XO_CLK always-ON */
+	regmap_update_bits(regmap, 0x604c, BIT(0), BIT(0));
+
+	ret = qcom_cc_really_probe(pdev, &disp_cc_sm6115_desc, regmap);
+	if (ret) {
+		dev_err(&pdev->dev, "Failed to register DISP CC clocks\n");
+		return ret;
+	}
+
+	return ret;
+}
+
+static struct platform_driver disp_cc_sm6115_driver = {
+	.probe = disp_cc_sm6115_probe,
+	.driver = {
+		.name = "dispcc-sm6115",
+		.of_match_table = disp_cc_sm6115_match_table,
+	},
+};
+
+static int __init disp_cc_sm6115_init(void)
+{
+	return platform_driver_register(&disp_cc_sm6115_driver);
+}
+subsys_initcall(disp_cc_sm6115_init);
+
+static void __exit disp_cc_sm6115_exit(void)
+{
+	platform_driver_unregister(&disp_cc_sm6115_driver);
+}
+module_exit(disp_cc_sm6115_exit);
+
+MODULE_DESCRIPTION("QTI DISP_CC sm6115 Driver");
+MODULE_LICENSE("GPL v2");
-- 
2.25.1

