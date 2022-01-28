Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1F68B49F44E
	for <lists+linux-kernel@lfdr.de>; Fri, 28 Jan 2022 08:27:16 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1346756AbiA1H1N (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 28 Jan 2022 02:27:13 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:35618 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1346666AbiA1H1M (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 28 Jan 2022 02:27:12 -0500
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20S7QuPB020634;
        Fri, 28 Jan 2022 01:26:56 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643354816;
        bh=dN+CEUUtbl5d4ZOKmjdlZ5dy3pMK59MIQvO+Co4HQ98=;
        h=From:To:CC:Subject:Date;
        b=iLSXCzOqTZkH84s2U9kch1WNamGturJQdhrnKXCsaEqaYfBoJrYp4egVwxFfwcWC5
         SZSCI94+8C/cCEwja1mTRIVJCG1DyqtDFDm+LhhfeqIhS5rXNr0xF7g79a4B8Cm16g
         qgHcKklynIHjvxbR9f11asQeGygdjUjrlvIsyDH8=
Received: from DFLE109.ent.ti.com (dfle109.ent.ti.com [10.64.6.30])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20S7Quin092588
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Fri, 28 Jan 2022 01:26:56 -0600
Received: from DFLE108.ent.ti.com (10.64.6.29) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Fri, 28
 Jan 2022 01:26:55 -0600
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Fri, 28 Jan 2022 01:26:55 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20S7QrOT011924;
        Fri, 28 Jan 2022 01:26:53 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH v2] phy: cadence: Sierra: Add support for skipping configuration
Date:   Fri, 28 Jan 2022 12:56:41 +0530
Message-ID: <20220128072642.29188-1-a-govindraju@ti.com>
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
---

Changes since v1:
- Removed redundant braces
- Corrected the logic for skipping multilink configuration
- Corrected the order in failure path

 drivers/phy/cadence/phy-cadence-sierra.c | 82 ++++++++++++++++--------
 1 file changed, 57 insertions(+), 25 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index e265647e29a2..6b917f7bddbe 100644
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
@@ -1433,8 +1461,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 		sp->num_lanes += sp->phys[node].num_lanes;
 
-		gphy = devm_phy_create(dev, child, &ops);
-
+		if (!sp->already_configured)
+			gphy = devm_phy_create(dev, child, &ops);
+		else
+			gphy = devm_phy_create(dev, child, &noop_ops);
 		if (IS_ERR(gphy)) {
 			ret = PTR_ERR(gphy);
 			of_node_put(child);
@@ -1455,7 +1485,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	}
 
 	/* If more than one subnode, configure the PHY as multilink */
-	if (!sp->autoconf && sp->nsubnodes > 1) {
+	if (!sp->already_configured && !sp->autoconf && sp->nsubnodes > 1) {
 		ret = cdns_sierra_phy_configure_multilink(sp);
 		if (ret)
 			goto put_control;
@@ -1473,9 +1503,11 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 put_control:
 	while (--node >= 0)
 		reset_control_put(sp->phys[node].lnk_rst);
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

