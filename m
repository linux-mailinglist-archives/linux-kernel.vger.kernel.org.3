Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id A7E9B50BE3D
	for <lists+linux-kernel@lfdr.de>; Fri, 22 Apr 2022 19:11:49 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1355199AbiDVROa (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 22 Apr 2022 13:14:30 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53428 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S242615AbiDVRMe (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 22 Apr 2022 13:12:34 -0400
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [46.235.227.227])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D4CBB92304;
        Fri, 22 Apr 2022 10:09:37 -0700 (PDT)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: sre)
        with ESMTPSA id 1764D1F468DD
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1650647375;
        bh=JyODDbAkozctO2YF4+4+8QrF0xaiP+MYadCgEeOgwr0=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=PiwXSCIeNFXJDbDuRsS0Znqr5Lz7z/o749sD4Fkr/ZuG3r3SBBZRwyTW6Ln/Ysw3h
         Jl26DLa6JJGIe7bzvRQkAozr9btvB5YUh6w3LYgjp3defiGILiMxU6ahTzrtmaqoDN
         u0HlzBCi25TFJckd/Kc5Pt0WoLuSThdD5i1W5PSyfKe1q+dXheyE/fpkmX9cqMVTRM
         cbZWyZcz/dG5JK9AhpC6bLChAF4GRFmhmLeAZWKEgzJ/BQ6cQrceUhjDCEqNIKc+o4
         4aP8LY1JNbUWGeUeewL30L0ziciOsHuL4eQ8CWbzZDIKJuU6leDuB6cD68ryibhyUX
         l1dEYWDgfrtbA==
Received: by jupiter.universe (Postfix, from userid 1000)
        id C902F4807F0; Fri, 22 Apr 2022 19:09:32 +0200 (CEST)
From:   Sebastian Reichel <sebastian.reichel@collabora.com>
To:     Heiko Stuebner <heiko@sntech.de>
Cc:     Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzk+dt@kernel.org>,
        Linus Walleij <linus.walleij@linaro.org>,
        Bartosz Golaszewski <brgl@bgdev.pl>,
        Adrian Hunter <adrian.hunter@intel.com>,
        Ulf Hansson <ulf.hansson@linaro.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Michael Turquette <mturquette@baylibre.com>,
        Stephen Boyd <sboyd@kernel.org>, linux-clk@vger.kernel.org,
        linux-mmc@vger.kernel.org, linux-gpio@vger.kernel.org,
        linux-arm-kernel@lists.infradead.org,
        linux-rockchip@lists.infradead.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org, kernel@lists.collabora.co.uk,
        Elaine Zhang <zhangqing@rock-chips.com>, kernel@collabora.com,
        Sebastian Reichel <sebastian.reichel@collabora.com>
Subject: [PATCHv1 04/19] clk: rockchip: clk-cpu: add mux setting for cpu change frequency
Date:   Fri, 22 Apr 2022 19:09:05 +0200
Message-Id: <20220422170920.401914-5-sebastian.reichel@collabora.com>
X-Mailer: git-send-email 2.35.1
In-Reply-To: <20220422170920.401914-1-sebastian.reichel@collabora.com>
References: <20220422170920.401914-1-sebastian.reichel@collabora.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.1 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,SPF_HELO_PASS,SPF_PASS,
        UNPARSEABLE_RELAY autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Elaine Zhang <zhangqing@rock-chips.com>

In order to improve the main frequency of CPU, the clock path of CPU is
simplified as follows:
                         |--\
                         |   \            |--\
 --apll--|\              |    \           |   \
         | |--apll_core--|     \          |    \
 --24M---|/              |mux1 |--[gate]--|mux2|---clk_core
                         |     /          |    /
 --gpll--|\              |    /    |------|   /
         | |--gpll_core--|   /     |      |--/
 --24M---|/              |--/      |
                                   |
 -------apll_directly--------------|

When the CPU requests high frequency, we want to use MUX2 select the
"apll_directly".
At low frequencies use MUX1 to select “apll_core" and then MUX2 to
select "apll_core_gate".

However, in this way, the CPU frequency conversion needs to be
in the following order:
1. MUX2 select to "apll_core_gate", MUX1 select "gpll_core"
2. Apll sets slow_mode, sets APLL parameters, locks APLL, and then APLL
sets normal_mode
3. MUX1 select "apll_core", MUX2 select "apll_directly"

So add pre_muxs and post_muxs to cover this special requirements.

Signed-off-by: Elaine Zhang <zhangqing@rock-chips.com>
[rebase]
Signed-off-by: Sebastian Reichel <sebastian.reichel@collabora.com>
---
 drivers/clk/rockchip/clk-cpu.c | 41 ++++++++++++++++++++++++++++++++++
 drivers/clk/rockchip/clk.h     |  2 ++
 2 files changed, 43 insertions(+)

diff --git a/drivers/clk/rockchip/clk-cpu.c b/drivers/clk/rockchip/clk-cpu.c
index 11aa2259b532..6ea7fba9f9e5 100644
--- a/drivers/clk/rockchip/clk-cpu.c
+++ b/drivers/clk/rockchip/clk-cpu.c
@@ -113,6 +113,42 @@ static void rockchip_cpuclk_set_dividers(struct rockchip_cpuclk *cpuclk,
 	}
 }
 
+static void rockchip_cpuclk_set_pre_muxs(struct rockchip_cpuclk *cpuclk,
+					 const struct rockchip_cpuclk_rate_table *rate)
+{
+	int i;
+
+	/* alternate parent is active now. set the pre_muxs */
+	for (i = 0; i < ARRAY_SIZE(rate->pre_muxs); i++) {
+		const struct rockchip_cpuclk_clksel *clksel = &rate->pre_muxs[i];
+
+		if (!clksel->reg)
+			break;
+
+		pr_debug("%s: setting reg 0x%x to 0x%x\n",
+			 __func__, clksel->reg, clksel->val);
+		writel(clksel->val, cpuclk->reg_base + clksel->reg);
+	}
+}
+
+static void rockchip_cpuclk_set_post_muxs(struct rockchip_cpuclk *cpuclk,
+					  const struct rockchip_cpuclk_rate_table *rate)
+{
+	int i;
+
+	/* alternate parent is active now. set the muxs */
+	for (i = 0; i < ARRAY_SIZE(rate->post_muxs); i++) {
+		const struct rockchip_cpuclk_clksel *clksel = &rate->post_muxs[i];
+
+		if (!clksel->reg)
+			break;
+
+		pr_debug("%s: setting reg 0x%x to 0x%x\n",
+			 __func__, clksel->reg, clksel->val);
+		writel(clksel->val, cpuclk->reg_base + clksel->reg);
+	}
+}
+
 static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
 					   struct clk_notifier_data *ndata)
 {
@@ -165,6 +201,9 @@ static int rockchip_cpuclk_pre_rate_change(struct rockchip_cpuclk *cpuclk,
 			       cpuclk->reg_base + reg_data->core_reg[i]);
 		}
 	}
+
+	rockchip_cpuclk_set_pre_muxs(cpuclk, rate);
+
 	/* select alternate parent */
 	if (reg_data->mux_core_reg)
 		writel(HIWORD_UPDATE(reg_data->mux_core_alt,
@@ -219,6 +258,8 @@ static int rockchip_cpuclk_post_rate_change(struct rockchip_cpuclk *cpuclk,
 				     reg_data->mux_core_shift),
 		       cpuclk->reg_base + reg_data->core_reg[0]);
 
+	rockchip_cpuclk_set_post_muxs(cpuclk, rate);
+
 	/* remove dividers */
 	for (i = 0; i < reg_data->num_cores; i++) {
 		writel(HIWORD_UPDATE(0, reg_data->div_core_mask[i],
diff --git a/drivers/clk/rockchip/clk.h b/drivers/clk/rockchip/clk.h
index bf7c8d082fde..2bd1863a7418 100644
--- a/drivers/clk/rockchip/clk.h
+++ b/drivers/clk/rockchip/clk.h
@@ -380,6 +380,8 @@ struct rockchip_cpuclk_clksel {
 struct rockchip_cpuclk_rate_table {
 	unsigned long prate;
 	struct rockchip_cpuclk_clksel divs[ROCKCHIP_CPUCLK_NUM_DIVIDERS];
+	struct rockchip_cpuclk_clksel pre_muxs[ROCKCHIP_CPUCLK_NUM_DIVIDERS];
+	struct rockchip_cpuclk_clksel post_muxs[ROCKCHIP_CPUCLK_NUM_DIVIDERS];
 };
 
 /**
-- 
2.35.1

