Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 1EE82560CBD
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:55:02 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231285AbiF2Wyj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:54:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36614 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231243AbiF2WyK (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:54:10 -0400
Received: from relay05.th.seeweb.it (relay05.th.seeweb.it [IPv6:2001:4b7a:2000:18::166])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id AA39338BED
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 15:53:54 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id A4AD13F796;
        Thu, 30 Jun 2022 00:53:51 +0200 (CEST)
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
Subject: [PATCH v3 09/11] drm/msm/dsi_phy_14nm: Replace parent names with clk_hw pointers
Date:   Thu, 30 Jun 2022 00:53:29 +0200
Message-Id: <20220629225331.357308-10-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629225331.357308-1-marijn.suijten@somainline.org>
References: <20220629225331.357308-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no
        version=3.4.6
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
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c | 40 ++++++++++------------
 1 file changed, 19 insertions(+), 21 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
index e10ba1b09b2f..1a855351654c 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_14nm.c
@@ -764,14 +764,14 @@ static int dsi_14nm_set_usecase(struct msm_dsi_phy *phy)
 
 static struct clk_hw *pll_14nm_postdiv_register(struct dsi_pll_14nm *pll_14nm,
 						const char *name,
-						const char *parent_name,
+						const struct clk_hw *parent_hw,
 						unsigned long flags,
 						u8 shift)
 {
 	struct dsi_pll_14nm_postdiv *pll_postdiv;
 	struct device *dev = &pll_14nm->phy->pdev->dev;
 	struct clk_init_data postdiv_init = {
-		.parent_names = (const char *[]) { parent_name },
+		.parent_hws = (const struct clk_hw *[]) { parent_hw },
 		.num_parents = 1,
 		.name = name,
 		.flags = flags,
@@ -800,23 +800,23 @@ static struct clk_hw *pll_14nm_postdiv_register(struct dsi_pll_14nm *pll_14nm,
 
 static int pll_14nm_register(struct dsi_pll_14nm *pll_14nm, struct clk_hw **provided_clocks)
 {
-	char clk_name[32], parent[32], vco_name[32];
+	char clk_name[32];
 	struct clk_init_data vco_init = {
 		.parent_data = &(const struct clk_parent_data) {
 			.fw_name = "ref",
 		},
 		.num_parents = 1,
-		.name = vco_name,
+		.name = clk_name,
 		.flags = CLK_IGNORE_UNUSED,
 		.ops = &clk_ops_dsi_pll_14nm_vco,
 	};
 	struct device *dev = &pll_14nm->phy->pdev->dev;
-	struct clk_hw *hw;
+	struct clk_hw *hw, *n1_postdiv, *n1_postdivby2;
 	int ret;
 
 	DBG("DSI%d", pll_14nm->phy->id);
 
-	snprintf(vco_name, sizeof(vco_name), "dsi%dvco_clk", pll_14nm->phy->id);
+	snprintf(clk_name, sizeof(clk_name), "dsi%dvco_clk", pll_14nm->phy->id);
 	pll_14nm->clk_hw.init = &vco_init;
 
 	ret = devm_clk_hw_register(dev, &pll_14nm->clk_hw);
@@ -824,48 +824,46 @@ static int pll_14nm_register(struct dsi_pll_14nm *pll_14nm, struct clk_hw **prov
 		return ret;
 
 	snprintf(clk_name, sizeof(clk_name), "dsi%dn1_postdiv_clk", pll_14nm->phy->id);
-	snprintf(parent, sizeof(parent), "dsi%dvco_clk", pll_14nm->phy->id);
 
 	/* N1 postdiv, bits 0-3 in REG_DSI_14nm_PHY_CMN_CLK_CFG0 */
-	hw = pll_14nm_postdiv_register(pll_14nm, clk_name, parent,
-				       CLK_SET_RATE_PARENT, 0);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
+	n1_postdiv = pll_14nm_postdiv_register(pll_14nm, clk_name,
+			&pll_14nm->clk_hw, CLK_SET_RATE_PARENT, 0);
+	if (IS_ERR(n1_postdiv))
+		return PTR_ERR(n1_postdiv);
 
 	snprintf(clk_name, sizeof(clk_name), "dsi%dpllbyte", pll_14nm->phy->id);
-	snprintf(parent, sizeof(parent), "dsi%dn1_postdiv_clk", pll_14nm->phy->id);
 
 	/* DSI Byte clock = VCO_CLK / N1 / 8 */
-	hw = devm_clk_hw_register_fixed_factor(dev, clk_name, parent,
-					       CLK_SET_RATE_PARENT, 1, 8);
+	hw = devm_clk_hw_register_fixed_factor_parent_hw(dev, clk_name,
+			n1_postdiv, CLK_SET_RATE_PARENT, 1, 8);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
 
 	provided_clocks[DSI_BYTE_PLL_CLK] = hw;
 
 	snprintf(clk_name, sizeof(clk_name), "dsi%dn1_postdivby2_clk", pll_14nm->phy->id);
-	snprintf(parent, sizeof(parent), "dsi%dn1_postdiv_clk", pll_14nm->phy->id);
 
 	/*
 	 * Skip the mux for now, force DSICLK_SEL to 1, Add a /2 divider
 	 * on the way. Don't let it set parent.
 	 */
-	hw = devm_clk_hw_register_fixed_factor(dev, clk_name, parent, 0, 1, 2);
-	if (IS_ERR(hw))
-		return PTR_ERR(hw);
+	n1_postdivby2 = devm_clk_hw_register_fixed_factor_parent_hw(dev,
+			clk_name, n1_postdiv, 0, 1, 2);
+	if (IS_ERR(n1_postdivby2))
+		return PTR_ERR(n1_postdivby2);
 
 	snprintf(clk_name, sizeof(clk_name), "dsi%dpll", pll_14nm->phy->id);
-	snprintf(parent, sizeof(parent), "dsi%dn1_postdivby2_clk", pll_14nm->phy->id);
 
 	/* DSI pixel clock = VCO_CLK / N1 / 2 / N2
 	 * This is the output of N2 post-divider, bits 4-7 in
 	 * REG_DSI_14nm_PHY_CMN_CLK_CFG0. Don't let it set parent.
 	 */
-	hw = pll_14nm_postdiv_register(pll_14nm, clk_name, parent, 0, 4);
+	hw = pll_14nm_postdiv_register(pll_14nm, clk_name, n1_postdivby2,
+			0, 4);
 	if (IS_ERR(hw))
 		return PTR_ERR(hw);
 
-	provided_clocks[DSI_PIXEL_PLL_CLK]	= hw;
+	provided_clocks[DSI_PIXEL_PLL_CLK] = hw;
 
 	return 0;
 }
-- 
2.37.0

