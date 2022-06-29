Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 68D77560CB6
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:54:34 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231367AbiF2Wyb (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:54:31 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35962 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230452AbiF2WyH (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:54:07 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [IPv6:2001:4b7a:2000:18::169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 471553056D;
        Wed, 29 Jun 2022 15:53:52 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 0F1713F7F7;
        Thu, 30 Jun 2022 00:53:50 +0200 (CEST)
From:   Marijn Suijten <marijn.suijten@somainline.org>
To:     phone-devel@vger.kernel.org,
        Dmitry Baryshkov <dmitry.baryshkov@linaro.org>,
        Stephen Boyd <sboyd@kernel.org>
Cc:     ~postmarketos/upstreaming@lists.sr.ht,
        AngeloGioacchino Del Regno 
        <angelogioacchino.delregno@somainline.org>,
        Konrad Dybcio <konrad.dybcio@somainline.org>,
        Martin Botka <martin.botka@somainline.org>,
        Jami Kettunen <jami.kettunen@somainline.org>,
        Marijn Suijten <marijn.suijten@somainline.org>,
        Michael Turquette <mturquette@baylibre.com>,
        Rob Clark <robdclark@gmail.com>,
        Abhinav Kumar <quic_abhinavk@quicinc.com>,
        Sean Paul <sean@poorly.run>, David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rajeev Nandan <quic_rajeevny@quicinc.com>,
        Vladimir Lypak <vladimir.lypak@gmail.com>,
        Jonathan Marek <jonathan@marek.ca>, linux-clk@vger.kernel.org,
        linux-kernel@vger.kernel.org, linux-arm-msm@vger.kernel.org,
        dri-devel@lists.freedesktop.org, freedreno@lists.freedesktop.org
Subject: [PATCH v3 08/11] drm/msm/dsi_phy_28nm: Replace parent names with clk_hw pointers
Date:   Thu, 30 Jun 2022 00:53:28 +0200
Message-Id: <20220629225331.357308-9-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629225331.357308-1-marijn.suijten@somainline.org>
References: <20220629225331.357308-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

parent_hw pointers are easier to manage and cheaper to use than
repeatedly formatting the parent name and subsequently leaving the clk
framework to perform lookups based on that name.

Signed-off-by: Marijn Suijten <marijn.suijten@somainline.org>
Reviewed-by: Dmitry Baryshkov <dmitry.baryshkov@linaro.org>
---
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c | 50 ++++++++++------------
 1 file changed, 23 insertions(+), 27 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
index 7d3cabeca743..04411fefb808 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm.c
@@ -519,17 +519,17 @@ static int dsi_28nm_pll_restore_state(struct msm_dsi_phy *phy)
 
 static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **provided_clocks)
 {
-	char clk_name[32], parent1[32], parent2[32], vco_name[32];
+	char clk_name[32];
 	struct clk_init_data vco_init = {
 		.parent_data = &(const struct clk_parent_data) {
 			.fw_name = "ref", .name = "xo",
 		},
 		.num_parents = 1,
-		.name = vco_name,
+		.name = clk_name,
 		.flags = CLK_IGNORE_UNUSED,
 	};
 	struct device *dev = &pll_28nm->phy->pdev->dev;
-	struct clk_hw *hw;
+	struct clk_hw *hw, *analog_postdiv, *indirect_path_div2, *byte_mux;
 	int ret;
 
 	DBG("%d", pll_28nm->phy->id);
@@ -539,32 +539,30 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
 	else
 		vco_init.ops = &clk_ops_dsi_pll_28nm_vco_hpm;
 
-	snprintf(vco_name, sizeof(vco_name), "dsi%dvco_clk", pll_28nm->phy->id);
+	snprintf(clk_name, sizeof(clk_name), "dsi%dvco_clk", pll_28nm->phy->id);
 	pll_28nm->clk_hw.init = &vco_init;
 	ret = devm_clk_hw_register(dev, &pll_28nm->clk_hw);
 	if (ret)
 		return ret;
 
 	snprintf(clk_name, sizeof(clk_name), "dsi%danalog_postdiv_clk", pll_28nm->phy->id);
-	snprintf(parent1, sizeof(parent1), "dsi%dvco_clk", pll_28nm->phy->id);
-	hw = devm_clk_hw_register_divider(dev, clk_name, parent1,
-			CLK_SET_RATE_PARENT, pll_28nm->phy->pll_base +
+	analog_postdiv = devm_clk_hw_register_divider_parent_hw(dev, clk_name,
+			&pll_28nm->clk_hw, CLK_SET_RATE_PARENT,
+			pll_28nm->phy->pll_base +
 				REG_DSI_28nm_PHY_PLL_POSTDIV1_CFG,
 			0, 4, 0, NULL);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
+	if (IS_ERR(analog_postdiv))
+		return PTR_ERR(analog_postdiv);
 
 	snprintf(clk_name, sizeof(clk_name), "dsi%dindirect_path_div2_clk", pll_28nm->phy->id);
-	snprintf(parent1, sizeof(parent1), "dsi%danalog_postdiv_clk", pll_28nm->phy->id);
-	hw = devm_clk_hw_register_fixed_factor(dev, clk_name, parent1,
-			CLK_SET_RATE_PARENT, 1, 2);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
+	indirect_path_div2 = devm_clk_hw_register_fixed_factor_parent_hw(dev,
+			clk_name, analog_postdiv, CLK_SET_RATE_PARENT, 1, 2);
+	if (IS_ERR(indirect_path_div2))
+		return PTR_ERR(indirect_path_div2);
 
 	snprintf(clk_name, sizeof(clk_name), "dsi%dpll", pll_28nm->phy->id);
-	snprintf(parent1, sizeof(parent1), "dsi%dvco_clk", pll_28nm->phy->id);
-	hw = devm_clk_hw_register_divider(dev, clk_name, parent1, 0,
-			pll_28nm->phy->pll_base +
+	hw = devm_clk_hw_register_divider_parent_hw(dev, clk_name,
+			&pll_28nm->clk_hw, 0, pll_28nm->phy->pll_base +
 				REG_DSI_28nm_PHY_PLL_POSTDIV3_CFG,
 			0, 8, 0, NULL);
 	if (IS_ERR(hw))
@@ -572,20 +570,18 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
 	provided_clocks[DSI_PIXEL_PLL_CLK] = hw;
 
 	snprintf(clk_name, sizeof(clk_name), "dsi%dbyte_mux", pll_28nm->phy->id);
-	snprintf(parent1, sizeof(parent1), "dsi%dvco_clk", pll_28nm->phy->id);
-	snprintf(parent2, sizeof(parent2), "dsi%dindirect_path_div2_clk", pll_28nm->phy->id);
-	hw = devm_clk_hw_register_mux(dev, clk_name,
-			((const char *[]){
-				parent1, parent2,
+	byte_mux = devm_clk_hw_register_mux_parent_hws(dev, clk_name,
+			((const struct clk_hw *[]){
+				&pll_28nm->clk_hw,
+				indirect_path_div2,
 			}), 2, CLK_SET_RATE_PARENT, pll_28nm->phy->pll_base +
 				REG_DSI_28nm_PHY_PLL_VREG_CFG, 1, 1, 0, NULL);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
+	if (IS_ERR(byte_mux))
+		return PTR_ERR(byte_mux);
 
 	snprintf(clk_name, sizeof(clk_name), "dsi%dpllbyte", pll_28nm->phy->id);
-	snprintf(parent1, sizeof(parent1), "dsi%dbyte_mux", pll_28nm->phy->id);
-	hw = devm_clk_hw_register_fixed_factor(dev, clk_name, parent1,
-			CLK_SET_RATE_PARENT, 1, 4);
+	hw = devm_clk_hw_register_fixed_factor_parent_hw(dev, clk_name,
+			byte_mux, CLK_SET_RATE_PARENT, 1, 4);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
 	provided_clocks[DSI_BYTE_PLL_CLK] = hw;
-- 
2.37.0

