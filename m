Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id EB86F49DD16
	for <lists+linux-kernel@lfdr.de>; Thu, 27 Jan 2022 09:57:42 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S238078AbiA0I5c (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 27 Jan 2022 03:57:32 -0500
Received: from lelv0143.ext.ti.com ([198.47.23.248]:58166 "EHLO
        lelv0143.ext.ti.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S238063AbiA0I5b (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 27 Jan 2022 03:57:31 -0500
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0143.ext.ti.com (8.15.2/8.15.2) with ESMTP id 20R8v6tA067443;
        Thu, 27 Jan 2022 02:57:06 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1643273826;
        bh=7UGkZLlsCbU6/7eRk2sQKQKDQzdA+OHIOBNXAlW3FuQ=;
        h=From:To:CC:Subject:Date;
        b=E+HN7iuvG7KJHSntdZBahrsZQ4h/eUofRe5g3dwqCFl+B8s+WJjdkAaPXeBJdLUFy
         S2cgQoz1bA3q5K5wuqrdxpIWapAnrEcRTg5Je9pMlBEeknL7oo9V02DM5czsf2OgfQ
         Q+SZajr/kC/C/8RxZVh20FEOWrlgm2YqGMw8ygCI=
Received: from DFLE114.ent.ti.com (dfle114.ent.ti.com [10.64.6.35])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 20R8v6Nv047367
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 27 Jan 2022 02:57:06 -0600
Received: from DFLE109.ent.ti.com (10.64.6.30) by DFLE114.ent.ti.com
 (10.64.6.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 27
 Jan 2022 02:57:05 -0600
Received: from lelv0327.itg.ti.com (10.180.67.183) by DFLE109.ent.ti.com
 (10.64.6.30) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 27 Jan 2022 02:57:05 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0327.itg.ti.com (8.15.2/8.15.2) with ESMTP id 20R8v2OO014712;
        Thu, 27 Jan 2022 02:57:03 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        Swapnil Jakhade <sjakhade@cadence.com>,
        Dan Carpenter <dan.carpenter@oracle.com>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
Subject: [PATCH] phy: cadence: Sierra: Add support for skipping configuration
Date:   Thu, 27 Jan 2022 14:26:58 +0530
Message-ID: <20220127085700.10333-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Skip the phy configuration if the required configurations were done in an
earlier boot stage.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---
 drivers/phy/cadence/phy-cadence-sierra.c | 73 +++++++++++++++++-------
 1 file changed, 51 insertions(+), 22 deletions(-)

diff --git a/drivers/phy/cadence/phy-cadence-sierra.c b/drivers/phy/cadence/phy-cadence-sierra.c
index e265647e29a2..d4197524ee8d 100644
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
 
@@ -1382,16 +1401,24 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
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
+	if (!(sp->already_configured)) {
+		ret = cdns_sierra_phy_clk(sp);
+		if (ret)
+			goto unregister_clk;
+
+		ret = cdns_sierra_phy_get_resets(sp, dev);
+		if (ret)
+			goto unregister_clk;
+
+		/* Enable APB */
+		reset_control_deassert(sp->apb_rst);
+	}
 
 	/* Check that PHY is present */
 	regmap_field_read(sp->macro_id_type, &id_value);
@@ -1433,8 +1460,10 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 
 		sp->num_lanes += sp->phys[node].num_lanes;
 
-		gphy = devm_phy_create(dev, child, &ops);
-
+		if (!(sp->already_configured))
+			gphy = devm_phy_create(dev, child, &ops);
+		else
+			gphy = devm_phy_create(dev, child, &noop_ops);
 		if (IS_ERR(gphy)) {
 			ret = PTR_ERR(gphy);
 			of_node_put(child);
@@ -1455,7 +1484,7 @@ static int cdns_sierra_phy_probe(struct platform_device *pdev)
 	}
 
 	/* If more than one subnode, configure the PHY as multilink */
-	if (!sp->autoconf && sp->nsubnodes > 1) {
+	if (!(sp->already_configured && sp->autoconf) && sp->nsubnodes > 1) {
 		ret = cdns_sierra_phy_configure_multilink(sp);
 		if (ret)
 			goto put_control;
-- 
2.17.1

