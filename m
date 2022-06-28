Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5D28455D7DB
	for <lists+linux-kernel@lfdr.de>; Tue, 28 Jun 2022 15:19:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1345605AbiF1MXj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 28 Jun 2022 08:23:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:53082 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1345638AbiF1MXb (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 28 Jun 2022 08:23:31 -0400
Received: from dfw.source.kernel.org (dfw.source.kernel.org [139.178.84.217])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id D01FE1D335;
        Tue, 28 Jun 2022 05:23:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by dfw.source.kernel.org (Postfix) with ESMTPS id 5F4D261474;
        Tue, 28 Jun 2022 12:23:29 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 657A5C341CC;
        Tue, 28 Jun 2022 12:23:26 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1656419008;
        bh=P7SAAWwCSzVlv2T9lWvUXnEH8devzfc90nldG8hymZU=;
        h=From:To:Cc:Subject:Date:In-Reply-To:References:From;
        b=ggl+R4ju6XZHFHZ0r+RjFHmBt3UGrTgx6aD9lYF3HVGfajARwqUF6blJDFx3twM71
         Cg2ohyndHYbRv8ldihz0kEmV7CFiHCBiXW2bBMM4OYY5T8obPbImjHyfHERnSWOJ4H
         pLQ6hxUPsgCNxiyjf2ux+Zl3ssZY5ydzmOao6cM4dVCeg6F7gIIc5ZE2suFyrDqUe3
         Z/L/3doCKxVguNRv7+Jj2hAOX2UkIemNlM6J+8bD5fNSHqq4oolJA99RZjM2ELH0Ps
         kvyfH5Bb4fWq/PEsZaf2UYEgK59R5ahKnniAZpScBCVOGHp5QtWCNZ2MlkUJ//L+OK
         j9AMpHceAp0zQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     vigneshr@ti.com, t-patil@ti.com, sjakhade@cadence.com,
        s-vadapalli@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, devicetree@vger.kernel.org,
        Roger Quadros <rogerq@kernel.org>
Subject: [PATCH 6/7] phy: ti: phy-j721e-wiz: add support for j7200-wiz-10g
Date:   Tue, 28 Jun 2022 15:22:54 +0300
Message-Id: <20220628122255.24265-7-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220628122255.24265-1-rogerq@kernel.org>
References: <20220628122255.24265-1-rogerq@kernel.org>
X-Spam-Status: No, score=-7.5 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

j7200-wiz-10g supports 2 reference clocks. However, the
control bits for these clocks is in a separate register that
sits in the System Control register space. Handle that register.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
---
 drivers/phy/ti/phy-j721e-wiz.c | 138 ++++++++++++++++++++++++++++++---
 1 file changed, 129 insertions(+), 9 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index 77accea6ec2f..cc2ab5152f07 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -15,6 +15,7 @@
 #include <linux/gpio/consumer.h>
 #include <linux/io.h>
 #include <linux/module.h>
+#include <linux/mfd/syscon.h>
 #include <linux/mux/consumer.h>
 #include <linux/of_address.h>
 #include <linux/of_platform.h>
@@ -23,6 +24,10 @@
 #include <linux/regmap.h>
 #include <linux/reset-controller.h>
 
+/* SCM offsets */
+#define SERDES_SUP_CTRL		0x4400
+
+/* SERDES offsets */
 #define WIZ_SERDES_CTRL		0x404
 #define WIZ_SERDES_TOP_CTRL	0x408
 #define WIZ_SERDES_RST		0x40c
@@ -85,6 +90,18 @@ static const struct reg_field pma_cmn_refclk_dig_div =
 					REG_FIELD(WIZ_SERDES_TOP_CTRL, 26, 27);
 static const struct reg_field pma_cmn_refclk1_dig_div =
 					REG_FIELD(WIZ_SERDES_TOP_CTRL, 24, 25);
+
+static const struct reg_field sup_pll0_refclk_mux_sel =
+					REG_FIELD(SERDES_SUP_CTRL, 0, 1);
+static const struct reg_field sup_pll1_refclk_mux_sel =
+					REG_FIELD(SERDES_SUP_CTRL, 2, 3);
+static const struct reg_field sup_pma_cmn_refclk1_int_mode =
+					REG_FIELD(SERDES_SUP_CTRL, 4, 5);
+static const struct reg_field sup_refclk_dig_sel_10g =
+					REG_FIELD(SERDES_SUP_CTRL, 6, 7);
+static const struct reg_field sup_legacy_clk_override =
+					REG_FIELD(SERDES_SUP_CTRL, 8, 8);
+
 static const char * const output_clk_names[] = {
 	[TI_WIZ_PLL0_REFCLK] = "pll0-refclk",
 	[TI_WIZ_PLL1_REFCLK] = "pll1-refclk",
@@ -248,6 +265,27 @@ static const struct wiz_clk_mux_sel clk_mux_sel_10g[] = {
 	},
 };
 
+static const struct wiz_clk_mux_sel clk_mux_sel_10g_2_refclk[] = {
+	{
+		.num_parents = 3,
+		.parents = { WIZ_CORE_REFCLK, WIZ_CORE_REFCLK1, WIZ_EXT_REFCLK },
+		.table = { 2, 3, 0 },
+		.node_name = "pll0-refclk",
+	},
+	{
+		.num_parents = 3,
+		.parents = { WIZ_CORE_REFCLK, WIZ_CORE_REFCLK1, WIZ_EXT_REFCLK },
+		.table = { 2, 3, 0 },
+		.node_name = "pll1-refclk",
+	},
+	{
+		.num_parents = 3,
+		.parents = { WIZ_CORE_REFCLK, WIZ_CORE_REFCLK1, WIZ_EXT_REFCLK },
+		.table = { 2, 3, 0 },
+		.node_name = "refclk-dig",
+	},
+};
+
 static const struct clk_div_table clk_div_table[] = {
 	{ .val = 0, .div = 1, },
 	{ .val = 1, .div = 2, },
@@ -269,14 +307,18 @@ static const struct wiz_clk_div_sel clk_div_sel[] = {
 
 enum wiz_type {
 	J721E_WIZ_16G,
-	J721E_WIZ_10G,
+	J721E_WIZ_10G,	/* Also for J7200 SR1.0 */
 	AM64_WIZ_10G,
+	J7200_WIZ_10G,  /* J7200 SR2.0 */
 };
 
 struct wiz_data {
 	enum wiz_type type;
+	const struct reg_field *pll0_refclk_mux_sel;
+	const struct reg_field *pll1_refclk_mux_sel;
 	const struct reg_field *refclk_dig_sel;
 	const struct reg_field *pma_cmn_refclk1_dig_div;
+	const struct reg_field *pma_cmn_refclk1_int_mode;
 	const struct wiz_clk_mux_sel *clk_mux_sel;
 	unsigned int clk_div_sel_num;
 };
@@ -286,6 +328,7 @@ struct wiz_data {
 
 struct wiz {
 	struct regmap		*regmap;
+	struct regmap		*scm_regmap;
 	enum wiz_type		type;
 	const struct wiz_clk_mux_sel *clk_mux_sel;
 	const struct wiz_clk_div_sel *clk_div_sel;
@@ -304,12 +347,14 @@ struct wiz {
 	struct regmap_field	*p0_rxfclk_sel[WIZ_MAX_LANES];
 	struct regmap_field	*p0_refclk_sel[WIZ_MAX_LANES];
 	struct regmap_field	*pma_cmn_refclk_int_mode;
+	struct regmap_field	*pma_cmn_refclk1_int_mode;
 	struct regmap_field	*pma_cmn_refclk_mode;
 	struct regmap_field	*pma_cmn_refclk_dig_div;
 	struct regmap_field	*pma_cmn_refclk1_dig_div;
 	struct regmap_field	*mux_sel_field[WIZ_MUX_NUM_CLOCKS];
 	struct regmap_field	*div_sel_field[WIZ_DIV_NUM_CLOCKS_16G];
 	struct regmap_field	*typec_ln10_swap;
+	struct regmap_field	*sup_legacy_clk_override;
 
 	struct device		*dev;
 	u32			num_lanes;
@@ -448,6 +493,7 @@ static int wiz_init(struct wiz *wiz)
 static int wiz_regfield_init(struct wiz *wiz)
 {
 	struct regmap *regmap = wiz->regmap;
+	struct regmap *scm_regmap = wiz->regmap; /* updated later to scm_regmap if applicable */
 	int num_lanes = wiz->num_lanes;
 	struct device *dev = wiz->dev;
 	const struct wiz_data *data = wiz->data;
@@ -497,27 +543,46 @@ static int wiz_regfield_init(struct wiz *wiz)
 		}
 	}
 
+	if (wiz->scm_regmap) {
+		scm_regmap = wiz->scm_regmap;
+		wiz->sup_legacy_clk_override =
+			devm_regmap_field_alloc(dev, scm_regmap, sup_legacy_clk_override);
+		if (IS_ERR(wiz->sup_legacy_clk_override)) {
+			dev_err(dev, "SUP_LEGACY_CLK_OVERRIDE reg field init failed\n");
+			return PTR_ERR(wiz->sup_legacy_clk_override);
+		}
+	}
+
 	wiz->mux_sel_field[PLL0_REFCLK] =
-		devm_regmap_field_alloc(dev, regmap, pll0_refclk_mux_sel);
+		devm_regmap_field_alloc(dev, scm_regmap, *data->pll0_refclk_mux_sel);
 	if (IS_ERR(wiz->mux_sel_field[PLL0_REFCLK])) {
 		dev_err(dev, "PLL0_REFCLK_SEL reg field init failed\n");
 		return PTR_ERR(wiz->mux_sel_field[PLL0_REFCLK]);
 	}
 
 	wiz->mux_sel_field[PLL1_REFCLK] =
-		devm_regmap_field_alloc(dev, regmap, pll1_refclk_mux_sel);
+		devm_regmap_field_alloc(dev, scm_regmap, *data->pll1_refclk_mux_sel);
 	if (IS_ERR(wiz->mux_sel_field[PLL1_REFCLK])) {
 		dev_err(dev, "PLL1_REFCLK_SEL reg field init failed\n");
 		return PTR_ERR(wiz->mux_sel_field[PLL1_REFCLK]);
 	}
 
-	wiz->mux_sel_field[REFCLK_DIG] = devm_regmap_field_alloc(dev, regmap,
+	wiz->mux_sel_field[REFCLK_DIG] = devm_regmap_field_alloc(dev, scm_regmap,
 								 *data->refclk_dig_sel);
 	if (IS_ERR(wiz->mux_sel_field[REFCLK_DIG])) {
 		dev_err(dev, "REFCLK_DIG_SEL reg field init failed\n");
 		return PTR_ERR(wiz->mux_sel_field[REFCLK_DIG]);
 	}
 
+	if (data->pma_cmn_refclk1_int_mode) {
+		wiz->pma_cmn_refclk1_int_mode =
+			devm_regmap_field_alloc(dev, scm_regmap, *data->pma_cmn_refclk1_int_mode);
+		if (IS_ERR(wiz->pma_cmn_refclk1_int_mode)) {
+			dev_err(dev, "PMA_CMN_REFCLK1_INT_MODE reg field init failed\n");
+			return PTR_ERR(wiz->pma_cmn_refclk1_int_mode);
+		}
+	}
+
 	for (i = 0; i < num_lanes; i++) {
 		wiz->p_enable[i] = devm_regmap_field_alloc(dev, regmap,
 							   p_enable[i]);
@@ -906,9 +971,13 @@ static void wiz_clock_cleanup(struct wiz *wiz, struct device_node *node)
 	struct device_node *clk_node;
 	int i;
 
-	if (wiz->type == AM64_WIZ_10G) {
+	switch (wiz->type) {
+	case AM64_WIZ_10G:
+	case J7200_WIZ_10G:
 		of_clk_del_provider(dev->of_node);
 		return;
+	default:
+		break;
 	}
 
 	for (i = 0; i < WIZ_MUX_NUM_CLOCKS; i++) {
@@ -935,9 +1004,6 @@ static int wiz_clock_register(struct wiz *wiz)
 	int ret;
 	int i;
 
-	if (wiz->type != AM64_WIZ_10G)
-		return 0;
-
 	clk_index = TI_WIZ_PLL0_REFCLK;
 	for (i = 0; i < WIZ_MUX_NUM_CLOCKS; i++, clk_index++) {
 		ret = wiz_mux_clk_register(wiz, wiz->mux_sel_field[i], &clk_mux_sel[i], clk_index);
@@ -987,6 +1053,22 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 	else
 		regmap_field_write(wiz->pma_cmn_refclk_int_mode, 0x3);
 
+	if (wiz->data->pma_cmn_refclk1_int_mode) {
+		clk = devm_clk_get(dev, "core_ref1_clk");
+		if (IS_ERR(clk)) {
+			dev_err(dev, "core_ref1_clk clock not found\n");
+			ret = PTR_ERR(clk);
+			return ret;
+		}
+		wiz->input_clks[WIZ_CORE_REFCLK1] = clk;
+
+		rate = clk_get_rate(clk);
+		if (rate >= 100000000)
+			regmap_field_write(wiz->pma_cmn_refclk1_int_mode, 0x1);
+		else
+			regmap_field_write(wiz->pma_cmn_refclk1_int_mode, 0x3);
+	}
+
 	clk = devm_clk_get(dev, "ext_ref_clk");
 	if (IS_ERR(clk)) {
 		dev_err(dev, "ext_ref_clk clock not found\n");
@@ -1001,11 +1083,15 @@ static int wiz_clock_init(struct wiz *wiz, struct device_node *node)
 	else
 		regmap_field_write(wiz->pma_cmn_refclk_mode, 0x2);
 
-	if (wiz->type == AM64_WIZ_10G) {
+	switch (wiz->type) {
+	case AM64_WIZ_10G:
+	case J7200_WIZ_10G:
 		ret = wiz_clock_register(wiz);
 		if (ret)
 			dev_err(dev, "Failed to register wiz clocks\n");
 		return ret;
+	default:
+		break;
 	}
 
 	for (i = 0; i < WIZ_MUX_NUM_CLOCKS; i++) {
@@ -1081,6 +1167,7 @@ static int wiz_phy_fullrt_div(struct wiz *wiz, int lane)
 			return regmap_field_write(wiz->p0_fullrt_div[lane], 0x1);
 		break;
 	case J721E_WIZ_10G:
+	case J7200_WIZ_10G:
 		if (wiz->lane_phy_type[lane] == PHY_TYPE_SGMII)
 			return regmap_field_write(wiz->p0_fullrt_div[lane], 0x2);
 		break;
@@ -1139,6 +1226,8 @@ static const struct regmap_config wiz_regmap_config = {
 
 static struct wiz_data j721e_16g_data = {
 	.type = J721E_WIZ_16G,
+	.pll0_refclk_mux_sel = &pll0_refclk_mux_sel,
+	.pll1_refclk_mux_sel = &pll1_refclk_mux_sel,
 	.refclk_dig_sel = &refclk_dig_sel_16g,
 	.pma_cmn_refclk1_dig_div = &pma_cmn_refclk1_dig_div,
 	.clk_mux_sel = clk_mux_sel_16g,
@@ -1147,6 +1236,8 @@ static struct wiz_data j721e_16g_data = {
 
 static struct wiz_data j721e_10g_data = {
 	.type = J721E_WIZ_10G,
+	.pll0_refclk_mux_sel = &pll0_refclk_mux_sel,
+	.pll1_refclk_mux_sel = &pll1_refclk_mux_sel,
 	.refclk_dig_sel = &refclk_dig_sel_10g,
 	.clk_mux_sel = clk_mux_sel_10g,
 	.clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_10G,
@@ -1154,11 +1245,23 @@ static struct wiz_data j721e_10g_data = {
 
 static struct wiz_data am64_10g_data = {
 	.type = AM64_WIZ_10G,
+	.pll0_refclk_mux_sel = &pll0_refclk_mux_sel,
+	.pll1_refclk_mux_sel = &pll1_refclk_mux_sel,
 	.refclk_dig_sel = &refclk_dig_sel_10g,
 	.clk_mux_sel = clk_mux_sel_10g,
 	.clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_10G,
 };
 
+static struct wiz_data j7200_pg2_10g_data = {
+	.type = J7200_WIZ_10G,
+	.pll0_refclk_mux_sel = &sup_pll0_refclk_mux_sel,
+	.pll1_refclk_mux_sel = &sup_pll1_refclk_mux_sel,
+	.refclk_dig_sel = &sup_refclk_dig_sel_10g,
+	.pma_cmn_refclk1_int_mode = &sup_pma_cmn_refclk1_int_mode,
+	.clk_mux_sel = clk_mux_sel_10g_2_refclk,
+	.clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_10G,
+};
+
 static const struct of_device_id wiz_id_table[] = {
 	{
 		.compatible = "ti,j721e-wiz-16g", .data = &j721e_16g_data,
@@ -1169,6 +1272,9 @@ static const struct of_device_id wiz_id_table[] = {
 	{
 		.compatible = "ti,am64-wiz-10g", .data = &am64_10g_data,
 	},
+	{
+		.compatible = "ti,j7200-wiz-10g", .data = &j7200_pg2_10g_data,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, wiz_id_table);
@@ -1266,6 +1372,16 @@ static int wiz_probe(struct platform_device *pdev)
 		goto err_addr_to_resource;
 	}
 
+	wiz->scm_regmap = syscon_regmap_lookup_by_phandle(node, "ti,scm");
+	if (IS_ERR(wiz->scm_regmap)) {
+		if (wiz->type == J7200_WIZ_10G) {
+			dev_err(dev, "Couldn't get ti,scm regmap\n");
+			return -ENODEV;
+		}
+
+		wiz->scm_regmap = NULL;
+	}
+
 	ret = of_property_read_u32(node, "num-lanes", &num_lanes);
 	if (ret) {
 		dev_err(dev, "Failed to read num-lanes property\n");
@@ -1327,6 +1443,10 @@ static int wiz_probe(struct platform_device *pdev)
 		goto err_addr_to_resource;
 	}
 
+	/* Enable supplemental Control override if available */
+	if (wiz->scm_regmap)
+		regmap_field_write(wiz->sup_legacy_clk_override, 1);
+
 	phy_reset_dev = &wiz->wiz_phy_reset_dev;
 	phy_reset_dev->dev = dev;
 	phy_reset_dev->ops = &wiz_phy_reset_ops,
-- 
2.17.1

