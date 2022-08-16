Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 66637595516
	for <lists+linux-kernel@lfdr.de>; Tue, 16 Aug 2022 10:26:30 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232951AbiHPI0Y (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 16 Aug 2022 04:26:24 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56142 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229779AbiHPIZa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 16 Aug 2022 04:25:30 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C1A77118C80;
        Mon, 15 Aug 2022 22:59:26 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 27G5x36g029614;
        Tue, 16 Aug 2022 00:59:03 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1660629543;
        bh=V5Ka5UXfv6A4IhWDBTifW60sQoNxzaXMBT9NUt0YenI=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=WIMlvFkZdBE/dUNN5FLUuOzIFP/j0ZcRWIPlN8STKoF9iZhZYIxHTnxC6bZI9xybn
         Jl/JCZAbDpFikFZq/EHkrZErfAyRxbmubqdw3PLviSNwaq6spBSMdoUBuX8R0HV/P3
         3Mo9CL2uyl8iqrht3qUhAH+xqYveRZFrqCXQeTcg=
Received: from DLEE107.ent.ti.com (dlee107.ent.ti.com [157.170.170.37])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 27G5x397014394
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 16 Aug 2022 00:59:03 -0500
Received: from DLEE101.ent.ti.com (157.170.170.31) by DLEE107.ent.ti.com
 (157.170.170.37) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6; Tue, 16
 Aug 2022 00:59:00 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DLEE101.ent.ti.com
 (157.170.170.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2507.6 via
 Frontend Transport; Tue, 16 Aug 2022 00:59:00 -0500
Received: from uda0492258.dhcp.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 27G5wm3e109354;
        Tue, 16 Aug 2022 00:58:57 -0500
From:   Siddharth Vadapalli <s-vadapalli@ti.com>
To:     <robh+dt@kernel.org>, <lee.jones@linaro.org>,
        <krzysztof.kozlowski+dt@linaro.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <dan.carpenter@oracle.com>,
        <grygorii.strashko@ti.com>, <rogerq@kernel.org>
CC:     <devicetree@vger.kernel.org>, <linux-kernel@vger.kernel.org>,
        <linux-phy@lists.infradead.org>, <s-vadapalli@ti.com>
Subject: [PATCH v2 2/2] phy: ti: gmii-sel: Add support for CPSW5G GMII SEL in J7200
Date:   Tue, 16 Aug 2022 11:28:48 +0530
Message-ID: <20220816055848.111482-3-s-vadapalli@ti.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220816055848.111482-1-s-vadapalli@ti.com>
References: <20220816055848.111482-1-s-vadapalli@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-4.4 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Each of the CPSW5G ports in J7200 support additional modes like QSGMII.
Add a new compatible for J7200 to support the additional modes.

In TI's J7200, each of the CPSW5G ethernet interfaces can act as a
QSGMII or QSGMII-SUB port. The QSGMII interface is responsible for
performing auto-negotiation between the MAC and the PHY while the rest of
the interfaces are designated as QSGMII-SUB interfaces, indicating that
they will not be taking part in the auto-negotiation process.

To indicate the interface which will serve as the main QSGMII interface,
add a property "ti,qsgmii-main-ports", whose value indicates the
port number of the interface which shall serve as the main QSGMII
interface. The rest of the interfaces are then assigned QSGMII-SUB mode by
default.

Signed-off-by: Siddharth Vadapalli <s-vadapalli@ti.com>
---
 drivers/phy/ti/phy-gmii-sel.c | 40 ++++++++++++++++++++++++++++++++---
 1 file changed, 37 insertions(+), 3 deletions(-)

diff --git a/drivers/phy/ti/phy-gmii-sel.c b/drivers/phy/ti/phy-gmii-sel.c
index d0ab69750c6b..270083606b14 100644
--- a/drivers/phy/ti/phy-gmii-sel.c
+++ b/drivers/phy/ti/phy-gmii-sel.c
@@ -22,6 +22,12 @@
 #define AM33XX_GMII_SEL_MODE_RMII	1
 #define AM33XX_GMII_SEL_MODE_RGMII	2
 
+/* J72xx SoC specific definitions for the CONTROL port */
+#define J72XX_GMII_SEL_MODE_QSGMII	4
+#define J72XX_GMII_SEL_MODE_QSGMII_SUB	6
+
+#define PHY_GMII_PORT(n)	BIT((n) - 1)
+
 enum {
 	PHY_GMII_SEL_PORT_MODE = 0,
 	PHY_GMII_SEL_RGMII_ID_MODE,
@@ -43,6 +49,7 @@ struct phy_gmii_sel_soc_data {
 	u32 features;
 	const struct reg_field (*regfields)[PHY_GMII_SEL_LAST];
 	bool use_of_data;
+	u64 extra_modes;
 };
 
 struct phy_gmii_sel_priv {
@@ -53,6 +60,7 @@ struct phy_gmii_sel_priv {
 	struct phy_gmii_sel_phy_priv *if_phys;
 	u32 num_ports;
 	u32 reg_offset;
+	u32 qsgmii_main_ports;
 };
 
 static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
@@ -88,10 +96,17 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
 		gmii_sel_mode = AM33XX_GMII_SEL_MODE_MII;
 		break;
 
+	case PHY_INTERFACE_MODE_QSGMII:
+		if (!(soc_data->extra_modes & BIT(PHY_INTERFACE_MODE_QSGMII)))
+			goto unsupported;
+		if (if_phy->priv->qsgmii_main_ports & BIT(if_phy->id - 1))
+			gmii_sel_mode = J72XX_GMII_SEL_MODE_QSGMII;
+		else
+			gmii_sel_mode = J72XX_GMII_SEL_MODE_QSGMII_SUB;
+		break;
+
 	default:
-		dev_warn(dev, "port%u: unsupported mode: \"%s\"\n",
-			 if_phy->id, phy_modes(submode));
-		return -EINVAL;
+		goto unsupported;
 	}
 
 	if_phy->phy_if_mode = submode;
@@ -123,6 +138,11 @@ static int phy_gmii_sel_mode(struct phy *phy, enum phy_mode mode, int submode)
 	}
 
 	return 0;
+
+unsupported:
+	dev_warn(dev, "port%u: unsupported mode: \"%s\"\n",
+		 if_phy->id, phy_modes(submode));
+	return -EINVAL;
 }
 
 static const
@@ -188,6 +208,13 @@ struct phy_gmii_sel_soc_data phy_gmii_sel_soc_am654 = {
 	.regfields = phy_gmii_sel_fields_am654,
 };
 
+static const
+struct phy_gmii_sel_soc_data phy_gmii_sel_cpsw5g_soc_j7200 = {
+	.use_of_data = true,
+	.regfields = phy_gmii_sel_fields_am654,
+	.extra_modes = BIT(PHY_INTERFACE_MODE_QSGMII),
+};
+
 static const struct of_device_id phy_gmii_sel_id_table[] = {
 	{
 		.compatible	= "ti,am3352-phy-gmii-sel",
@@ -209,6 +236,10 @@ static const struct of_device_id phy_gmii_sel_id_table[] = {
 		.compatible	= "ti,am654-phy-gmii-sel",
 		.data		= &phy_gmii_sel_soc_am654,
 	},
+	{
+		.compatible	= "ti,j7200-cpsw5g-phy-gmii-sel",
+		.data		= &phy_gmii_sel_cpsw5g_soc_j7200,
+	},
 	{}
 };
 MODULE_DEVICE_TABLE(of, phy_gmii_sel_id_table);
@@ -350,6 +381,7 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 	struct device_node *node = dev->of_node;
 	const struct of_device_id *of_id;
 	struct phy_gmii_sel_priv *priv;
+	u32 main_ports = 1;
 	int ret;
 
 	of_id = of_match_node(phy_gmii_sel_id_table, pdev->dev.of_node);
@@ -363,6 +395,8 @@ static int phy_gmii_sel_probe(struct platform_device *pdev)
 	priv->dev = &pdev->dev;
 	priv->soc_data = of_id->data;
 	priv->num_ports = priv->soc_data->num_ports;
+	of_property_read_u32_array(node, "ti,qsgmii-main-ports", &main_ports, 1);
+	priv->qsgmii_main_ports = PHY_GMII_PORT(main_ports);
 
 	priv->regmap = syscon_node_to_regmap(node->parent);
 	if (IS_ERR(priv->regmap)) {
-- 
2.25.1

