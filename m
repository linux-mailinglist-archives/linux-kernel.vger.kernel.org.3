Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 06B574A7F2C
	for <lists+linux-kernel@lfdr.de>; Thu,  3 Feb 2022 06:50:51 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236607AbiBCFur (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 3 Feb 2022 00:50:47 -0500
Received: from fllv0016.ext.ti.com ([198.47.19.142]:51202 "EHLO
        fllv0016.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229954AbiBCFuq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 3 Feb 2022 00:50:46 -0500
Received: from fllv0035.itg.ti.com ([10.64.41.0])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 2135oJlc029849;
        Wed, 2 Feb 2022 23:50:19 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643867419;
        bh=sAF5ic9GnxONMiFzMd/9MsCvgWyl4xIwsqQQswxJBHc=;
        h=From:To:CC:Subject:Date;
        b=K6hFwam3vBQjlgGrA8Z1unmNRMDPd7qQftSKfBMbhCWId6BcKOeSVqeIukot2K4fc
         bbtnBOcIbWJARYcC7kUGQNiWAGOgHHx2oesrjFujaKWgZwiyaKW/Ymltj+p3JMmO5c
         DkUz2ZBFVQ/0q4AurI18rXhW4bjoNPicmPb5SjIE=
Received: from DLEE103.ent.ti.com (dlee103.ent.ti.com [157.170.170.33])
        by fllv0035.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 2135oJt9046082
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 2 Feb 2022 23:50:19 -0600
Received: from DLEE104.ent.ti.com (157.170.170.34) by DLEE103.ent.ti.com
 (157.170.170.33) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 2
 Feb 2022 23:50:19 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DLEE104.ent.ti.com
 (157.170.170.34) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 2 Feb 2022 23:50:19 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 2135oGkn004778;
        Wed, 2 Feb 2022 23:50:17 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v3] phy: cadence: Sierra: Add support for skipping configuration
Date:   Thu, 3 Feb 2022 11:20:10 +0530
Message-ID: <20220203055012.29323-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

In some cases, a single SerDes instance can be shared between two different
processors, each using a separate link. In these cases, the SerDes
configuration is done in an earlier boot stage. Therefore, add support to
skip reconfiguring, if it is was already configured beforehand.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
Reviewed-by: Dan Carpenter <dan.carpenter@oracle.com>
---

Changes since v2:
- Rebased the patch on top of phy-next branch.

Changes since v1:
- Removed redundant braces
- Corrected the logic for skipping multilink configuration
- Corrected the order in failure path

 drivers/phy/cadence/phy-cadence-sierra.c | 82 ++++++++++++++++--------
 1 file changed, 57 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index da24acd26666..2aa0905ee268 100644
--- a/drivers/phy/cadence/phy-cadence-sierra.c
+++ b/drivers/phy/cadence/phy-cadence-sierra.c
@@ -370,6 +370,7 @@ struct cdns_sierra_phy {
 	int nsubnodes;
 	u32 num_lanes;
 	bool autoconf;
+	int already_configured;
 	struct clk_onecell_data clk_data;
 	struct clk *output_clks[CDNS_SIERRA_OUTPUT_CLOCKS];
 };
@@ -517,7 +518,7 @@ static int cdns_sierra_phy_init(struct phy *gphy)
 	int i, j;
 
 	/* Initialise the PHY registers, unless auto configured */
-	if (phy->autoconf || phy->nsubnodes > 1)
+	if (phy->autoconf || phy->already_configured || phy->nsubnodes > 1)
 		return 0;
 
 	clk_set_rate(phy->input_clks[CMN_REFCLK_DIG_DIV], 25000000);
@@ -646,6 +647,18 @@ static const struct phy_ops ops = {
 	.owner		= THIS_MODULE,
 };
 
+static int cdns_sierra_noop_phy_on(struct phy *gphy)
+{
+	usleep_range(5000, 10000);
+
+	return 0;
+}
+
+static const struct phy_ops noop_ops = {
+	.power_on	= cdns_sierra_noop_phy_on,
+	.owner		= THIS_MODULE,
+};
+
 static u8 cdns_sierra_pll_mux_get_parent(struct clk_hw *hw)
 {
 	struct cdns_sierra_pll_mux *mux = to_cdns_sierra_pll_mux(hw);
@@ -1118,13 +1131,6 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 	struct clk *clk;
 	int ret;
 
-	clk = devm_clk_get_optional(dev, "phy_clk");
-	if (IS_ERR(clk)) {
-		dev_err(dev, "failed to get clock phy_clk\n");
-		return PTR_ERR(clk);
-	}
-	sp->input_clks[PHY_CLK] = clk;
-
 	clk = devm_clk_get_optional(dev, "cmn_refclk_dig_div");
 	if (IS_ERR(clk)) {
 		dev_err(dev, "cmn_refclk_dig_div clock not found\n");
@@ -1160,17 +1166,33 @@ static int cdns_sierra_phy_get_clocks(struct cdns_sierra_phy *sp,
 	return 0;
 }
 
-static int cdns_sierra_phy_enable_clocks(struct cdns_sierra_phy *sp)
+static int cdns_sierra_phy_clk(struct cdns_sierra_phy *sp)
 {
+	struct device *dev = sp->dev;
+	struct clk *clk;
 	int ret;
 
+	clk = devm_clk_get_optional(dev, "phy_clk");
+	if (IS_ERR(clk)) {
+		dev_err(dev, "failed to get clock phy_clk\n");
+		return PTR_ERR(clk);
+	}
+	sp->input_clks[PHY_CLK] = clk;
+
 	ret = clk_prepare_enable(sp->input_clks[PHY_CLK]);
 	if (ret)
 		return ret;
 
+	return 0;
+}
+
+static int cdns_sierra_phy_enable_clocks(struct cdns_sierra_phy *sp)
+{
+	int ret;
+
 	ret = clk_prepare_enable(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
 	if (ret)
-		goto err_pll_cmnlc;
+		return ret;
 
 	ret = clk_prepare_enable(sp->output_clks[CDNS_SIERRA_PLL_CMNLC1]);
 	if (ret)
@@ -1181,9 +1203,6 @@ static int cdns_sierra_phy_enable_clocks(struct cdns_sierra_phy *sp)
 err_pll_cmnlc1:
 	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
 
-err_pll_cmnlc:
-	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
-
 	return ret;
 }
 
@@ -1191,7 +1210,8 @@ static void cdns_sierra_phy_disable_clocks(struct cdns_sierra_phy *sp)
 {
 	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC1]);
 	clk_disable_unprepare(sp->output_clks[CDNS_SIERRA_PLL_CMNLC]);
-	clk_disable_unprepare(sp->input_clks[PHY_CLK]);
+	if (!sp->already_configured)
+		clk_disable_unprepare(sp->input_clks[PHY_CLK]);
 }
 
 static int cdns_sierra_phy_get_resets(struct cdns_sierra_phy *sp,
@@ -1382,22 +1402,30 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	if (ret)
 		return ret;
 
-	ret = cdns_sierra_phy_get_resets(sp, dev);
-	if (ret)
-		goto unregister_clk;
-
 	ret = cdns_sierra_phy_enable_clocks(sp);
 	if (ret)
 		goto unregister_clk;
 
-	/* Enable APB */
-	reset_control_deassert(sp->apb_rst);
+	regmap_field_read(sp->pma_cmn_ready, &sp->already_configured);
+
+	if (!sp->already_configured) {
+		ret = cdns_sierra_phy_clk(sp);
+		if (ret)
+			goto clk_disable;
+
+		ret = cdns_sierra_phy_get_resets(sp, dev);
+		if (ret)
+			goto clk_disable;
+
+		/* Enable APB */
+		reset_control_deassert(sp->apb_rst);
+	}
 
 	/* Check that PHY is present */
 	regmap_field_read(sp->macro_id_type, &id_value);
 	if  (sp->init_data->id_value != id_value) {
 		ret = -EINVAL;
-		goto clk_disable;
+		goto ctrl_assert;
 	}
 
 	sp->autoconf = of_property_read_bool(dn, "cdns,autoconf");
@@ -1430,8 +1458,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 		sp->num_lanes += sp->phys[node].num_lanes;
 
-		gphy = devm_phy_create(dev, child, &ops);
-
+		if (!sp->already_configured)
+			gphy = devm_phy_create(dev, child, &ops);
+		else
+			gphy = devm_phy_create(dev, child, &noop_ops);
 		if (IS_ERR(gphy)) {
 			ret = PTR_ERR(gphy);
 			goto put_child;
@@ -1450,7 +1480,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	}
 
 	/* If more than one subnode, configure the PHY as multilink */
-	if (!sp->autoconf && sp->nsubnodes > 1) {
+	if (!sp->already_configured && !sp->autoconf && sp->nsubnodes > 1) {
 		ret = cdns_sierra_phy_configure_multilink(sp);
 		if (ret)
 			goto put_child2;
@@ -1466,9 +1496,11 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	for (i = 0; i < node; i++)
 		reset_control_put(sp->phys[i].lnk_rst);
 	of_node_put(child);
+ctrl_assert:
+	if (!sp->already_configured)
+		reset_control_assert(sp->apb_rst);
 clk_disable:
 	cdns_sierra_phy_disable_clocks(sp);
-	reset_control_assert(sp->apb_rst);
 unregister_clk:
 	cdns_sierra_clk_unregister(sp);
 	return ret;
-- 
2.17.1

