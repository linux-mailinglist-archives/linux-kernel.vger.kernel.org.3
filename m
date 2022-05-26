Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00297534A6D
	for <lists+linux-kernel@lfdr.de>; Thu, 26 May 2022 08:41:46 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346103AbiEZGli (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 26 May 2022 02:41:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51460 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1344030AbiEZGlc (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 26 May 2022 02:41:32 -0400
Received: from ams.source.kernel.org (ams.source.kernel.org [IPv6:2604:1380:4601:e00::1])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C5AA3D44
        for <linux-kernel@vger.kernel.org>; Wed, 25 May 2022 23:41:29 -0700 (PDT)
Received: from smtp.kernel.org (relay.kernel.org [52.25.139.140])
        (using TLSv1.2 with cipher ECDHE-RSA-AES256-GCM-SHA384 (256/256 bits))
        (No client certificate requested)
        by ams.source.kernel.org (Postfix) with ESMTPS id 3C844B81F15
        for <linux-kernel@vger.kernel.org>; Thu, 26 May 2022 06:41:28 +0000 (UTC)
Received: by smtp.kernel.org (Postfix) with ESMTPSA id 48603C385A9;
        Thu, 26 May 2022 06:41:25 +0000 (UTC)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=kernel.org;
        s=k20201202; t=1653547286;
        bh=UFXxXVSGz2kuuymoVMkv4OB9NQvHB0/vURPiyo2i+gM=;
        h=From:To:Cc:Subject:Date:From;
        b=Tdk+JVRsqIsoQR6Iurw/wu/tGV5G1CD3We4BqjlyVlwhh5120FOOlsD8PcXiLaYtM
         ZT5v6A/bWPaAoXm7U0cC7BQIlfiwsgcVfQChQp1qOOXU/q3rmyv/KId4F2IrWTkkJ4
         8sj1xbMI8PpF5nwxi1pVZtQtmfQBPMT7+iAVFuug3miBG/75wT4Fc2akSinM4IDfjO
         9U81s5I1dmDqRFitQqOf6dmScxds9zYm4QJbwV6u2iAbzveUugioYjavR5fqTpovjd
         M1ww24CMeqLdi2FMsbC5rbWDCZ4w36KOJAo0OPgf/8sDbluN3yLDG0KtiyloIrmJVH
         vqSp2p0VxXZqQ==
From:   Roger Quadros <rogerq@kernel.org>
To:     kishon@ti.com, vkoul@kernel.org
Cc:     mranostay@ti.com, linux-phy@lists.infradead.org,
        linux-kernel@vger.kernel.org, Roger Quadros <rogerq@kernel.org>
Subject: [PATCH] phy: ti: phy-j721e-wiz: use OF data for device specific data
Date:   Thu, 26 May 2022 09:41:21 +0300
Message-Id: <20220526064121.27625-1-rogerq@kernel.org>
X-Mailer: git-send-email 2.17.1
X-Spam-Status: No, score=-7.8 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_HI,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move device specific data into OF data structure so it
is easier to maintain and we can get rid of if statements.

Signed-off-by: Roger Quadros <rogerq@kernel.org>
Reviewed-by: Matt Ranostay <mranostay@ti.com>
---
 drivers/phy/ti/phy-j721e-wiz.c | 75 ++++++++++++++++++++++------------
 1 file changed, 50 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/ti/phy-j721e-wiz.c b/drivers/phy/ti/phy-j721e-wiz.c
index da546c35d1d5..70bac931f99a 100644
--- a/drivers/phy/ti/phy-j721e-wiz.c
+++ b/drivers/phy/ti/phy-j721e-wiz.c
@@ -253,6 +253,14 @@ enum wiz_type {
 	AM64_WIZ_10G,
 };
 
+struct wiz_data {
+	enum wiz_type type;
+	const struct reg_field *refclk_dig_sel;
+	const struct reg_field *pma_cmn_refclk1_dig_div;
+	const struct wiz_clk_mux_sel *clk_mux_sel;
+	unsigned int clk_div_sel_num;
+};
+
 #define WIZ_TYPEC_DIR_DEBOUNCE_MIN	100	/* ms */
 #define WIZ_TYPEC_DIR_DEBOUNCE_MAX	1000
 
@@ -290,6 +298,7 @@ struct wiz {
 	struct clk		*input_clks[WIZ_MAX_INPUT_CLOCKS];
 	struct clk		*output_clks[WIZ_MAX_OUTPUT_CLOCKS];
 	struct clk_onecell_data	clk_data;
+	const struct wiz_data	*data;
 };
 
 static int wiz_reset(struct wiz *wiz)
@@ -409,6 +418,7 @@ static int wiz_regfield_init(struct wiz *wiz)
 	struct regmap *regmap = wiz->regmap;
 	int num_lanes = wiz->num_lanes;
 	struct device *dev = wiz->dev;
+	const struct wiz_data *data = wiz->data;
 	int i;
 
 	wiz->por_en = devm_regmap_field_alloc(dev, regmap, por_en);
@@ -445,10 +455,10 @@ static int wiz_regfield_init(struct wiz *wiz)
 		return PTR_ERR(wiz->div_sel_field[CMN_REFCLK_DIG_DIV]);
 	}
 
-	if (wiz->type == J721E_WIZ_16G) {
+	if (data->pma_cmn_refclk1_dig_div) {
 		wiz->div_sel_field[CMN_REFCLK1_DIG_DIV] =
 			devm_regmap_field_alloc(dev, regmap,
-						pma_cmn_refclk1_dig_div);
+						*data->pma_cmn_refclk1_dig_div);
 		if (IS_ERR(wiz->div_sel_field[CMN_REFCLK1_DIG_DIV])) {
 			dev_err(dev, "PMA_CMN_REFCLK1_DIG_DIV reg field init failed\n");
 			return PTR_ERR(wiz->div_sel_field[CMN_REFCLK1_DIG_DIV]);
@@ -469,15 +479,8 @@ static int wiz_regfield_init(struct wiz *wiz)
 		return PTR_ERR(wiz->mux_sel_field[PLL1_REFCLK]);
 	}
 
-	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
-		wiz->mux_sel_field[REFCLK_DIG] =
-			devm_regmap_field_alloc(dev, regmap,
-						refclk_dig_sel_10g);
-	else
-		wiz->mux_sel_field[REFCLK_DIG] =
-			devm_regmap_field_alloc(dev, regmap,
-						refclk_dig_sel_16g);
-
+	wiz->mux_sel_field[REFCLK_DIG] = devm_regmap_field_alloc(dev, regmap,
+								 *data->refclk_dig_sel);
 	if (IS_ERR(wiz->mux_sel_field[REFCLK_DIG])) {
 		dev_err(dev, "REFCLK_DIG_SEL reg field init failed\n");
 		return PTR_ERR(wiz->mux_sel_field[REFCLK_DIG]);
@@ -1078,15 +1081,37 @@ static const struct regmap_config wiz_regmap_config = {
 	.fast_io = true,
 };
 
+static struct wiz_data j721e_16g_data = {
+	.type = J721E_WIZ_16G,
+	.refclk_dig_sel = &refclk_dig_sel_16g,
+	.pma_cmn_refclk1_dig_div = &pma_cmn_refclk1_dig_div,
+	.clk_mux_sel = clk_mux_sel_16g,
+	.clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_16G,
+};
+
+static struct wiz_data j721e_10g_data = {
+	.type = J721E_WIZ_10G,
+	.refclk_dig_sel = &refclk_dig_sel_10g,
+	.clk_mux_sel = clk_mux_sel_10g,
+	.clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_10G,
+};
+
+static struct wiz_data am64_10g_data = {
+	.type = AM64_WIZ_10G,
+	.refclk_dig_sel = &refclk_dig_sel_10g,
+	.clk_mux_sel = clk_mux_sel_10g,
+	.clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_10G,
+};
+
 static const struct of_device_id wiz_id_table[] = {
 	{
-		.compatible = "ti,j721e-wiz-16g", .data = (void *)J721E_WIZ_16G
+		.compatible = "ti,j721e-wiz-16g", .data = &j721e_16g_data,
 	},
 	{
-		.compatible = "ti,j721e-wiz-10g", .data = (void *)J721E_WIZ_10G
+		.compatible = "ti,j721e-wiz-10g", .data = &j721e_10g_data,
 	},
 	{
-		.compatible = "ti,am64-wiz-10g", .data = (void *)AM64_WIZ_10G
+		.compatible = "ti,am64-wiz-10g", .data = &am64_10g_data,
 	},
 	{}
 };
@@ -1145,12 +1170,20 @@ static int wiz_probe(struct platform_device *pdev)
 	struct wiz *wiz;
 	int ret, val, i;
 	u32 num_lanes;
+	const struct wiz_data *data;
 
 	wiz = devm_kzalloc(dev, sizeof(*wiz), GFP_KERNEL);
 	if (!wiz)
 		return -ENOMEM;
 
-	wiz->type = (enum wiz_type)of_device_get_match_data(dev);
+	data = of_device_get_match_data(dev);
+	if (!data) {
+		dev_err(dev, "NULL device data\n");
+		return -EINVAL;
+	}
+
+	wiz->data = data;
+	wiz->type = data->type;
 
 	child_node = of_get_child_by_name(node, "serdes");
 	if (!child_node) {
@@ -1226,17 +1259,9 @@ static int wiz_probe(struct platform_device *pdev)
 	wiz->dev = dev;
 	wiz->regmap = regmap;
 	wiz->num_lanes = num_lanes;
-	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
-		wiz->clk_mux_sel = clk_mux_sel_10g;
-	else
-		wiz->clk_mux_sel = clk_mux_sel_16g;
-
+	wiz->clk_mux_sel = data->clk_mux_sel;
 	wiz->clk_div_sel = clk_div_sel;
-
-	if (wiz->type == J721E_WIZ_10G || wiz->type == AM64_WIZ_10G)
-		wiz->clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_10G;
-	else
-		wiz->clk_div_sel_num = WIZ_DIV_NUM_CLOCKS_16G;
+	wiz->clk_div_sel_num = data->clk_div_sel_num;
 
 	platform_set_drvdata(pdev, wiz);
 
-- 
2.17.1

