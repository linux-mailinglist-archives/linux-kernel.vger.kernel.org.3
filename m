Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D69758F6EF
	for <lists+linux-kernel@lfdr.de>; Thu, 11 Aug 2022 06:26:56 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233890AbiHKE0k (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 11 Aug 2022 00:26:40 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:59974 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S233825AbiHKE0Y (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 11 Aug 2022 00:26:24 -0400
Received: from mail-ot1-x330.google.com (mail-ot1-x330.google.com [IPv6:2607:f8b0:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C94A0193FF
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:26:21 -0700 (PDT)
Received: by mail-ot1-x330.google.com with SMTP id 53-20020a9d0838000000b006371d896343so2208173oty.10
        for <linux-kernel@vger.kernel.org>; Wed, 10 Aug 2022 21:26:21 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=linaro.org; s=google;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:from:to:cc;
        bh=igOA08Zpvjm92c6Qo51mdbeR4iAYbAKGWr7kyPz3lX4=;
        b=lyYbtGVl20SwrnrbQCdwU+xUb711M4JnNPaOpBorry2TBAXw+vx0uxGWM0MaCsItj4
         DKUJW6iBcq9KuzvR47nA5iVNlBBXTpW73Ube/YHl7dUSNEWoS4vzs1Ke/1NQpmxK1mKb
         zdllyOxMSrpCvlgZUBS+/H6xwabZXKDIzsjODK2Pun5AXltu7cJr+KX17673QPcKji/x
         yEDqbi6bwY8bVGNKkYw8Eh27UHOaRRHMIXxeYpXBg6XLwr4itFOK3atzH+gEk9vM277e
         uYjSQu/e09hZ3NI4MAWQk/3zq77Xre+FW+LYEXBOLMYmIsI9OQSEdlQuoPwQ9KY1mEuf
         xXCA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=content-transfer-encoding:mime-version:references:in-reply-to
         :message-id:date:subject:cc:to:from:x-gm-message-state:from:to:cc;
        bh=igOA08Zpvjm92c6Qo51mdbeR4iAYbAKGWr7kyPz3lX4=;
        b=WZ19pR5BU75e0Q2lH88C7Q2K0PPWJXSP0+GEwsu953AJG/yOd9lF6HOEiae5lBg29a
         owRe8/wtOQm11mynby7hO4A8aUC25EJ38gIrJxz4lwDq3a9tMladId5Dc4pedOWFZaI5
         vbfewOg+Ic7btL6k39NrwK/Z3Sf7nthNy+xLxbMzF40VfE3RtNNVh5RueBRtzlA2Zwyd
         VugR0a2GGIO3YGdIF1cWmqCNdv4mIYtwmT1vwwEN8BOgC/+QoBYoeFGFjlo3CR0AXOoX
         i9jsknuqgu2xGYwskJUU2yomBI9YuGGLA+qUI/UJmhblfRrN+YkB65LT1Yi0fnBGJCAQ
         NFJg==
X-Gm-Message-State: ACgBeo3d+co5NEg594XXGGU0+FoUKryfH5ZA/7ZDeK3DUKhQeVwDDEUP
        cpcGXGxskI1lTOeDFVUCh3L6+fJsiDj0Xg==
X-Google-Smtp-Source: AA6agR7o73NeditJTcuNW9003Vtl8m2hvbfCWjhllHd9a3kRFuUybUriluI0+4Lwwsk+U4+R+ZmwMQ==
X-Received: by 2002:a05:6830:6615:b0:616:d545:fa81 with SMTP id cp21-20020a056830661500b00616d545fa81mr11632553otb.129.1660191981060;
        Wed, 10 Aug 2022 21:26:21 -0700 (PDT)
Received: from ripper.. (104-57-184-186.lightspeed.austtx.sbcglobal.net. [104.57.184.186])
        by smtp.gmail.com with ESMTPSA id l17-20020a9d7351000000b006370c0e5be0sm1009517otk.48.2022.08.10.21.26.20
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 10 Aug 2022 21:26:20 -0700 (PDT)
From:   Bjorn Andersson <bjorn.andersson@linaro.org>
To:     Andy Gross <agross@kernel.org>,
        Bjorn Andersson <bjorn.andersson@linaro.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Stephen Boyd <sboyd@kernel.org>,
        Taniya Das <tdas@codeaurora.org>
Cc:     Michael Turquette <mturquette@baylibre.com>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        linux-arm-msm@vger.kernel.org, linux-clk@vger.kernel.org,
        devicetree@vger.kernel.org, linux-kernel@vger.kernel.org
Subject: [PATCH 2/2] clk: qcom: Add SC8280XP GPU clock controller
Date:   Wed, 10 Aug 2022 21:28:55 -0700
Message-Id: <20220811042855.3867774-3-bjorn.andersson@linaro.org>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220811042855.3867774-1-bjorn.andersson@linaro.org>
References: <20220811042855.3867774-1-bjorn.andersson@linaro.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add driver for the GPU clock controller in the Qualcomm SC8280XP
platform.

Signed-off-by: Bjorn Andersson <bjorn.andersson@linaro.org>
---
 drivers/clk/qcom/Kconfig          |   8 +
 drivers/clk/qcom/Makefile         |   1 +
 drivers/clk/qcom/gpucc-sc8280xp.c | 460 ++++++++++++++++++++++++++++++
 3 files changed, 469 insertions(+)
 create mode 100644 drivers/clk/qcom/gpucc-sc8280xp.c

diff --git a/drivers/clk/qcom/Kconfig b/drivers/clk/qcom/Kconfig
index 7ea5c2208a86..64a9cf245295 100644
--- a/drivers/clk/qcom/Kconfig
+++ b/drivers/clk/qcom/Kconfig
@@ -454,6 +454,14 @@ config SC_GPUCC_7280
 	  Say Y if you want to support graphics controller devices and
 	  functionality such as 3D graphics.
 
+config SC_GPUCC_8280XP
+	tristate "SC8280XP Graphics Clock Controller"
+	select SC_GCC_8280XP
+	help
+	  Support for the graphics clock controller on SC8280XP devices.
+	  Say Y if you want to support graphics controller devices and
+	  functionality such as 3D graphics.
+
 config SC_LPASSCC_7280
 	tristate "SC7280 Low Power Audio Subsystem (LPASS) Clock Controller"
 	select SC_GCC_7280
diff --git a/drivers/clk/qcom/Makefile b/drivers/clk/qcom/Makefile
index 4fd88ee7679b..6cdb05152548 100644
--- a/drivers/clk/qcom/Makefile
+++ b/drivers/clk/qcom/Makefile
@@ -72,6 +72,7 @@ obj-$(CONFIG_SC_GCC_8180X) += gcc-sc8180x.o
 obj-$(CONFIG_SC_GCC_8280XP) += gcc-sc8280xp.o
 obj-$(CONFIG_SC_GPUCC_7180) += gpucc-sc7180.o
 obj-$(CONFIG_SC_GPUCC_7280) += gpucc-sc7280.o
+obj-$(CONFIG_SC_GPUCC_8280XP) += gpucc-sc8280xp.o
 obj-$(CONFIG_SC_LPASSCC_7280) += lpasscc-sc7280.o
 obj-$(CONFIG_SC_LPASS_CORECC_7180) += lpasscorecc-sc7180.o
 obj-$(CONFIG_SC_LPASS_CORECC_7280) += lpasscorecc-sc7280.o lpassaudiocc-sc7280.o
diff --git a/drivers/clk/qcom/gpucc-sc8280xp.c b/drivers/clk/qcom/gpucc-sc8280xp.c
new file mode 100644
index 000000000000..555fd4ff58ab
--- /dev/null
+++ b/drivers/clk/qcom/gpucc-sc8280xp.c
@@ -0,0 +1,460 @@
+// SPDX-License-Identifier: GPL-2.0-only
+/*
+ * Copyright (c) 2021, The Linux Foundation. All rights reserved.
+ */
+
+#include <linux/clk-provider.h>
+#include <linux/module.h>
+#include <linux/platform_device.h>
+#include <linux/regmap.h>
+
+#include <dt-bindings/clock/qcom,gpucc-sc8280xp.h>
+
+#include "clk-alpha-pll.h"
+#include "clk-branch.h"
+#include "clk-rcg.h"
+#include "clk-regmap-divider.h"
+#include "common.h"
+#include "reset.h"
+#include "gdsc.h"
+
+/* Need to match the order of clocks in DT binding */
+enum {
+	DT_BI_TCXO,
+	DT_GCC_GPU_GPLL0_CLK_SRC,
+	DT_GCC_GPU_GPLL0_DIV_CLK_SRC,
+};
+
+enum {
+	P_BI_TCXO,
+	P_GCC_GPU_GPLL0_CLK_SRC,
+	P_GCC_GPU_GPLL0_DIV_CLK_SRC,
+	P_GPU_CC_PLL0_OUT_MAIN,
+	P_GPU_CC_PLL1_OUT_MAIN,
+};
+
+static const struct clk_parent_data parent_data_tcxo = { .index = DT_BI_TCXO };
+
+static const struct pll_vco lucid_5lpe_vco[] = {
+	{ 249600000, 1800000000, 0 },
+};
+
+static struct alpha_pll_config gpu_cc_pll0_config = {
+	.l = 0x1c,
+	.alpha = 0xa555,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002261,
+	.config_ctl_hi1_val = 0x2a9a699c,
+	.test_ctl_val = 0x00000000,
+	.test_ctl_hi_val = 0x00000000,
+	.test_ctl_hi1_val = 0x01800000,
+	.user_ctl_val = 0x00000000,
+	.user_ctl_hi_val = 0x00000805,
+	.user_ctl_hi1_val = 0x00000000,
+};
+
+static struct clk_alpha_pll gpu_cc_pll0 = {
+	.offset = 0x0,
+	.vco_table = lucid_5lpe_vco,
+	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_pll0",
+			.parent_data = &parent_data_tcxo,
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_5lpe_ops,
+		},
+	},
+};
+
+static struct alpha_pll_config gpu_cc_pll1_config = {
+	.l = 0x1A,
+	.alpha = 0xAAA,
+	.config_ctl_val = 0x20485699,
+	.config_ctl_hi_val = 0x00002261,
+	.config_ctl_hi1_val = 0x2A9A699C,
+	.test_ctl_val = 0x00000000,
+	.test_ctl_hi_val = 0x00000000,
+	.test_ctl_hi1_val = 0x01800000,
+	.user_ctl_val = 0x00000000,
+	.user_ctl_hi_val = 0x00000805,
+	.user_ctl_hi1_val = 0x00000000,
+};
+
+static struct clk_alpha_pll gpu_cc_pll1 = {
+	.offset = 0x100,
+	.vco_table = lucid_5lpe_vco,
+	.num_vco = ARRAY_SIZE(lucid_5lpe_vco),
+	.regs = clk_alpha_pll_regs[CLK_ALPHA_PLL_TYPE_LUCID],
+	.clkr = {
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_pll1",
+			.parent_data = &parent_data_tcxo,
+			.num_parents = 1,
+			.ops = &clk_alpha_pll_lucid_5lpe_ops,
+		},
+	},
+};
+
+static const struct parent_map gpu_cc_parent_map_0[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPU_CC_PLL0_OUT_MAIN, 1 },
+	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
+	{ P_GCC_GPU_GPLL0_CLK_SRC, 5 },
+	{ P_GCC_GPU_GPLL0_DIV_CLK_SRC, 6 },
+};
+
+static const struct clk_parent_data gpu_cc_parent_data_0[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gpu_cc_pll0.clkr.hw },
+	{ .hw = &gpu_cc_pll1.clkr.hw },
+	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
+	{ .index = DT_GCC_GPU_GPLL0_DIV_CLK_SRC },
+};
+
+static const struct parent_map gpu_cc_parent_map_1[] = {
+	{ P_BI_TCXO, 0 },
+	{ P_GPU_CC_PLL1_OUT_MAIN, 3 },
+	{ P_GCC_GPU_GPLL0_CLK_SRC, 5 },
+	{ P_GCC_GPU_GPLL0_DIV_CLK_SRC, 6 },
+};
+
+static const struct clk_parent_data gpu_cc_parent_data_1[] = {
+	{ .index = DT_BI_TCXO },
+	{ .hw = &gpu_cc_pll1.clkr.hw },
+	{ .index = DT_GCC_GPU_GPLL0_CLK_SRC },
+	{ .index = DT_GCC_GPU_GPLL0_DIV_CLK_SRC },
+};
+
+static const struct freq_tbl ftbl_gpu_cc_gmu_clk_src[] = {
+	F(19200000, P_BI_TCXO, 1, 0, 0),
+	F(200000000, P_GCC_GPU_GPLL0_DIV_CLK_SRC, 1.5, 0, 0),
+	F(500000000, P_GPU_CC_PLL1_OUT_MAIN, 1, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gpu_cc_gmu_clk_src = {
+	.cmd_rcgr = 0x1120,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gpu_cc_parent_map_0,
+	.freq_tbl = ftbl_gpu_cc_gmu_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpu_cc_gmu_clk_src",
+		.parent_data = gpu_cc_parent_data_0,
+		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_0),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static const struct freq_tbl ftbl_gpu_cc_hub_clk_src[] = {
+	F(200000000, P_GCC_GPU_GPLL0_CLK_SRC, 3, 0, 0),
+	F(300000000, P_GCC_GPU_GPLL0_CLK_SRC, 2, 0, 0),
+	F(400000000, P_GCC_GPU_GPLL0_CLK_SRC, 1.5, 0, 0),
+	{ }
+};
+
+static struct clk_rcg2 gpu_cc_hub_clk_src = {
+	.cmd_rcgr = 0x117c,
+	.mnd_width = 0,
+	.hid_width = 5,
+	.parent_map = gpu_cc_parent_map_1,
+	.freq_tbl = ftbl_gpu_cc_hub_clk_src,
+	.clkr.hw.init = &(struct clk_init_data){
+		.name = "gpu_cc_hub_clk_src",
+		.parent_data = gpu_cc_parent_data_1,
+		.num_parents = ARRAY_SIZE(gpu_cc_parent_data_1),
+		.ops = &clk_rcg2_shared_ops,
+	},
+};
+
+static struct clk_regmap_div gpu_cc_hub_ahb_div_clk_src = {
+	.reg = 0x11c0,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "gpu_cc_hub_ahb_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&gpu_cc_hub_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_regmap_div gpu_cc_hub_cx_int_div_clk_src = {
+	.reg = 0x11bc,
+	.shift = 0,
+	.width = 4,
+	.clkr.hw.init = &(struct clk_init_data) {
+		.name = "gpu_cc_hub_cx_int_div_clk_src",
+		.parent_hws = (const struct clk_hw*[]){
+			&gpu_cc_hub_clk_src.clkr.hw,
+		},
+		.num_parents = 1,
+		.flags = CLK_SET_RATE_PARENT,
+		.ops = &clk_regmap_div_ro_ops,
+	},
+};
+
+static struct clk_branch gpu_cc_ahb_clk = {
+	.halt_reg = 0x1078,
+	.halt_check = BRANCH_HALT_DELAY,
+	.clkr = {
+		.enable_reg = 0x1078,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_hub_ahb_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_crc_ahb_clk = {
+	.halt_reg = 0x107c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x107c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_crc_ahb_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_hub_ahb_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cx_gmu_clk = {
+	.halt_reg = 0x1098,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1098,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_cx_gmu_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_gmu_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cx_snoc_dvm_clk = {
+	.halt_reg = 0x108c,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x108c,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_cx_snoc_dvm_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_cxo_aon_clk = {
+	.halt_reg = 0x1004,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x1004,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_cxo_aon_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_gx_gmu_clk = {
+	.halt_reg = 0x1064,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1064,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_gx_gmu_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_gmu_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_hlos1_vote_gpu_smmu_clk = {
+	.halt_reg = 0x5000,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x5000,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_hlos1_vote_gpu_smmu_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_hub_aon_clk = {
+	.halt_reg = 0x1178,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1178,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_hub_aon_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_hub_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_hub_cx_int_clk = {
+	.halt_reg = 0x1204,
+	.halt_check = BRANCH_HALT,
+	.clkr = {
+		.enable_reg = 0x1204,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_hub_cx_int_clk",
+			.parent_hws = (const struct clk_hw*[]){
+				&gpu_cc_hub_cx_int_div_clk_src.clkr.hw,
+			},
+			.num_parents = 1,
+			.flags = CLK_SET_RATE_PARENT,
+			.ops = &clk_branch2_aon_ops,
+		},
+	},
+};
+
+static struct clk_branch gpu_cc_sleep_clk = {
+	.halt_reg = 0x1090,
+	.halt_check = BRANCH_HALT_VOTED,
+	.clkr = {
+		.enable_reg = 0x1090,
+		.enable_mask = BIT(0),
+		.hw.init = &(struct clk_init_data){
+			.name = "gpu_cc_sleep_clk",
+			.ops = &clk_branch2_ops,
+		},
+	},
+};
+
+static struct clk_regmap *gpu_cc_sc8280xp_clocks[] = {
+	[GPU_CC_AHB_CLK] = &gpu_cc_ahb_clk.clkr,
+	[GPU_CC_CRC_AHB_CLK] = &gpu_cc_crc_ahb_clk.clkr,
+	[GPU_CC_CX_GMU_CLK] = &gpu_cc_cx_gmu_clk.clkr,
+	[GPU_CC_CX_SNOC_DVM_CLK] = &gpu_cc_cx_snoc_dvm_clk.clkr,
+	[GPU_CC_CXO_AON_CLK] = &gpu_cc_cxo_aon_clk.clkr,
+	[GPU_CC_GMU_CLK_SRC] = &gpu_cc_gmu_clk_src.clkr,
+	[GPU_CC_GX_GMU_CLK] = &gpu_cc_gx_gmu_clk.clkr,
+	[GPU_CC_HLOS1_VOTE_GPU_SMMU_CLK] = &gpu_cc_hlos1_vote_gpu_smmu_clk.clkr,
+	[GPU_CC_HUB_AHB_DIV_CLK_SRC] = &gpu_cc_hub_ahb_div_clk_src.clkr,
+	[GPU_CC_HUB_AON_CLK] = &gpu_cc_hub_aon_clk.clkr,
+	[GPU_CC_HUB_CLK_SRC] = &gpu_cc_hub_clk_src.clkr,
+	[GPU_CC_HUB_CX_INT_CLK] = &gpu_cc_hub_cx_int_clk.clkr,
+	[GPU_CC_HUB_CX_INT_DIV_CLK_SRC] = &gpu_cc_hub_cx_int_div_clk_src.clkr,
+	[GPU_CC_PLL0] = &gpu_cc_pll0.clkr,
+	[GPU_CC_PLL1] = &gpu_cc_pll1.clkr,
+	[GPU_CC_SLEEP_CLK] = &gpu_cc_sleep_clk.clkr,
+};
+
+static struct gdsc cx_gdsc = {
+	.gdscr = 0x106c,
+	.gds_hw_ctrl = 0x1540,
+	.pd = {
+		.name = "cx_gdsc",
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = VOTABLE | RETAIN_FF_ENABLE,
+};
+
+static struct gdsc gx_gdsc = {
+	.gdscr = 0x100c,
+	.clamp_io_ctrl = 0x1508,
+	.pd = {
+		.name = "gx_gdsc",
+		.power_on = gdsc_gx_do_nothing_enable,
+	},
+	.pwrsts = PWRSTS_OFF_ON,
+	.flags = CLAMP_IO | RETAIN_FF_ENABLE,
+};
+
+static struct gdsc *gpu_cc_sc8280xp_gdscs[] = {
+	[GPU_CC_CX_GDSC] = &cx_gdsc,
+	[GPU_CC_GX_GDSC] = &gx_gdsc,
+};
+
+static const struct regmap_config gpu_cc_sc8280xp_regmap_config = {
+	.reg_bits = 32,
+	.reg_stride = 4,
+	.val_bits = 32,
+	.max_register = 0x8030,
+	.fast_io = true,
+};
+
+static struct qcom_cc_desc gpu_cc_sc8280xp_desc = {
+	.config = &gpu_cc_sc8280xp_regmap_config,
+	.clks = gpu_cc_sc8280xp_clocks,
+	.num_clks = ARRAY_SIZE(gpu_cc_sc8280xp_clocks),
+	.gdscs = gpu_cc_sc8280xp_gdscs,
+	.num_gdscs = ARRAY_SIZE(gpu_cc_sc8280xp_gdscs),
+};
+
+static int gpu_cc_sc8280xp_probe(struct platform_device *pdev)
+{
+	struct regmap *regmap;
+
+	regmap = qcom_cc_map(pdev, &gpu_cc_sc8280xp_desc);
+	if (IS_ERR(regmap))
+		return PTR_ERR(regmap);
+
+	clk_lucid_pll_configure(&gpu_cc_pll0, regmap, &gpu_cc_pll0_config);
+	clk_lucid_pll_configure(&gpu_cc_pll1, regmap, &gpu_cc_pll1_config);
+
+	/*
+	 * Keep the clocks always-ON
+	 * GPU_CC_CB_CLK, GPU_CC_CXO_CLK
+	 */
+	regmap_update_bits(regmap, 0x1170, BIT(0), BIT(0));
+	regmap_update_bits(regmap, 0x109c, BIT(0), BIT(0));
+
+	return qcom_cc_really_probe(pdev, &gpu_cc_sc8280xp_desc, regmap);
+}
+
+static const struct of_device_id gpu_cc_sc8280xp_match_table[] = {
+	{ .compatible = "qcom,sc8280xp-gpucc" },
+	{ }
+};
+MODULE_DEVICE_TABLE(of, gpu_cc_sc8280xp_match_table);
+
+static struct platform_driver gpu_cc_sc8280xp_driver = {
+	.probe = gpu_cc_sc8280xp_probe,
+	.driver = {
+		.name = "gpu_cc-sc8280xp",
+		.of_match_table = gpu_cc_sc8280xp_match_table,
+	},
+};
+module_platform_driver(gpu_cc_sc8280xp_driver);
+
+MODULE_DESCRIPTION("Qualcomm SC8280XP GPU clock controller");
+MODULE_LICENSE("GPL");
-- 
2.35.1

