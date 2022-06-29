Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 25435560CA5
	for <lists+linux-kernel@lfdr.de>; Thu, 30 Jun 2022 00:54:29 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229522AbiF2WyY (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 29 Jun 2022 18:54:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:36122 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231168AbiF2Wxz (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 29 Jun 2022 18:53:55 -0400
Received: from relay08.th.seeweb.it (relay08.th.seeweb.it [5.144.164.169])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id BF4DF25C57
        for <linux-kernel@vger.kernel.org>; Wed, 29 Jun 2022 15:53:50 -0700 (PDT)
Received: from Marijn-Arch-PC.localdomain (94-209-165-62.cable.dynamic.v4.ziggo.nl [94.209.165.62])
        (using TLSv1.3 with cipher TLS_AES_256_GCM_SHA384 (256/256 bits)
         key-exchange X25519 server-signature RSA-PSS (2048 bits) server-digest SHA256)
        (No client certificate requested)
        by m-r2.th.seeweb.it (Postfix) with ESMTPSA id 6B18A3F762;
        Thu, 30 Jun 2022 00:53:48 +0200 (CEST)
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
Subject: [PATCH v3 07/11] drm/msm/dsi_phy_28nm_8960: Replace parent names with clk_hw pointers
Date:   Thu, 30 Jun 2022 00:53:27 +0200
Message-Id: <20220629225331.357308-8-marijn.suijten@somainline.org>
X-Mailer: git-send-email 2.37.0
In-Reply-To: <20220629225331.357308-1-marijn.suijten@somainline.org>
References: <20220629225331.357308-1-marijn.suijten@somainline.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
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
 drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c | 15 ++++++++-------
 1 file changed, 8 insertions(+), 7 deletions(-)

diff --git a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
index 3deb306f4cc4..69c1b2d8333c 100644
--- a/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
+++ b/drivers/gpu/drm/msm/dsi/phy/dsi_phy_28nm_8960.c
@@ -383,7 +383,7 @@ static int dsi_28nm_pll_restore_state(struct msm_dsi_phy *phy)
 
 static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **provided_clocks)
 {
-	char clk_name[32], parent_name[32], vco_name[32];
+	char clk_name[32];
 	struct clk_init_data vco_init = {
 		.parent_data = &(const struct clk_parent_data) {
 			.fw_name = "ref",
@@ -404,8 +404,8 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
 	if (!bytediv)
 		return -ENOMEM;
 
-	snprintf(vco_name, sizeof(vco_name), "dsi%dvco_clk", pll_28nm->phy->id);
-	vco_init.name = vco_name;
+	snprintf(clk_name, sizeof(clk_name), "dsi%dvco_clk", pll_28nm->phy->id);
+	vco_init.name = clk_name;
 
 	pll_28nm->clk_hw.init = &vco_init;
 
@@ -417,13 +417,14 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
 	bytediv->hw.init = &bytediv_init;
 	bytediv->reg = pll_28nm->phy->pll_base + REG_DSI_28nm_8960_PHY_PLL_CTRL_9;
 
-	snprintf(parent_name, sizeof(parent_name), "dsi%dvco_clk", pll_28nm->phy->id);
 	snprintf(clk_name, sizeof(clk_name), "dsi%dpllbyte", pll_28nm->phy->id + 1);
 
 	bytediv_init.name = clk_name;
 	bytediv_init.ops = &clk_bytediv_ops;
 	bytediv_init.flags = CLK_SET_RATE_PARENT;
-	bytediv_init.parent_names = (const char * const *) &parent_name;
+	bytediv_init.parent_hws = (const struct clk_hw*[]){
+		&pll_28nm->clk_hw,
+	};
 	bytediv_init.num_parents = 1;
 
 	/* DIV2 */
@@ -434,8 +435,8 @@ static int pll_28nm_register(struct dsi_pll_28nm *pll_28nm, struct clk_hw **prov
 
 	snprintf(clk_name, sizeof(clk_name), "dsi%dpll", pll_28nm->phy->id + 1);
 	/* DIV3 */
-	hw = devm_clk_hw_register_divider(dev, clk_name, parent_name, 0,
-			pll_28nm->phy->pll_base +
+	hw = devm_clk_hw_register_divider_parent_hw(dev, clk_name,
+			&pll_28nm->clk_hw, 0, pll_28nm->phy->pll_base +
 				REG_DSI_28nm_8960_PHY_PLL_CTRL_10,
 			0, 8, 0, NULL);
 	if (IS_ERR(hw))
-- 
2.37.0

