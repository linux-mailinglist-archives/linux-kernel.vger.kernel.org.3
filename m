Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0043F55447E
	for <lists+linux-kernel@lfdr.de>; Wed, 22 Jun 2022 10:11:37 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354798AbiFVHyL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 22 Jun 2022 03:54:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:55444 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354664AbiFVHyC (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 22 Jun 2022 03:54:02 -0400
Received: from fllv0016.ext.ti.com (fllv0016.ext.ti.com [198.47.19.142])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8E5022ED48;
        Wed, 22 Jun 2022 00:54:00 -0700 (PDT)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0016.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25M7rpCv118541;
        Wed, 22 Jun 2022 02:53:51 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655884431;
        bh=GvUWGW+CRXLlzhLVZPxUC/CefQDg5opdasl7/TisyHk=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=dT+GLRjszOUBlu0SeZaEdzAPP5D6Y0sSiLUErOmUyZovVWpKetEqTIQCbjssQtK3s
         84ucRCE2MsIx16gSPeTlV0y+oV68l2iAw47wgzmsDYpyvwxht66DsrF1GFHN/fmd9S
         CLO/uCydX6vTJt8XKvlufX+nolSrL9lHvNaL86l8=
Received: from DLEE105.ent.ti.com (dlee105.ent.ti.com [157.170.170.35])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25M7rpPH021644
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 22 Jun 2022 02:53:51 -0500
Received: from DLEE113.ent.ti.com (157.170.170.24) by DLEE105.ent.ti.com
 (157.170.170.35) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 22
 Jun 2022 02:53:51 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE113.ent.ti.com
 (157.170.170.24) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 22 Jun 2022 02:53:51 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25M7rnUi022348;
        Wed, 22 Jun 2022 02:53:50 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <linux-phy@lists.infradead.org>, <kishon@ti.com>,
        <vkoul@kernel.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <p.yadav@ti.com>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v2 3/3] phy: cdns-dphy: Add support for DPHY TX on J721e
Date:   Wed, 22 Jun 2022 13:23:40 +0530
Message-ID: <20220622075340.16915-4-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220622075340.16915-1-r-ravikumar@ti.com>
References: <20220622075340.16915-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.0 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add support new compatible for dphy-tx on j721e
and implement dphy ops required.

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 drivers/phy/cadence/Kconfig     | 10 ++++++
 drivers/phy/cadence/cdns-dphy.c | 62 +++++++++++++++++++++++++++++++++
 2 files changed, 72 insertions(+)

diff --git a/drivers/phy/cadence/Kconfig b/drivers/phy/cadence/Kconfig
index 1adde2d99ae7..18024ac6d511 100644
--- a/drivers/phy/cadence/Kconfig
+++ b/drivers/phy/cadence/Kconfig
@@ -22,6 +22,16 @@ config PHY_CADENCE_DPHY
 	  system. If M is selected, the module will be called
 	  cdns-dphy.
 
+if PHY_CADENCE_DPHY
+
+config PHY_CADENCE_DPHY_J721E
+	depends on ARCH_K3 || COMPILE_TEST
+	bool "J721E DPHY TX Wiz support"
+	default y
+	help
+	  Support J721E Cadence DPHY TX Wiz configuration.
+endif
+
 config PHY_CADENCE_DPHY_RX
 	tristate "Cadence D-PHY Rx Support"
 	depends on HAS_IOMEM && OF
diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index ddfa524d8ce7..cba8221eb193 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -7,6 +7,7 @@
 #include <linux/bitfield.h>
 #include <linux/clk.h>
 #include <linux/io.h>
+#include <linux/iopoll.h>
 #include <linux/module.h>
 #include <linux/of_address.h>
 #include <linux/of_device.h>
@@ -18,6 +19,7 @@
 
 #define REG_WAKEUP_TIME_NS		800
 #define DPHY_PLL_RATE_HZ		108000000
+#define POLL_TIMEOUT_US			1000
 
 /* DPHY registers */
 #define DPHY_PMA_CMN(reg)		(reg)
@@ -62,6 +64,18 @@
 #define DSI_NULL_FRAME_OVERHEAD		6
 #define DSI_EOT_PKT_SIZE		4
 
+#define DPHY_TX_J721E_WIZ_PLL_CTRL	0xF04
+#define DPHY_TX_J721E_WIZ_STATUS	0xF08
+#define DPHY_TX_J721E_WIZ_RST_CTRL	0xF0C
+#define DPHY_TX_J721E_WIZ_PSM_FREQ	0xF10
+
+#define DPHY_TX_J721E_WIZ_IPDIV		GENMASK(4, 0)
+#define DPHY_TX_J721E_WIZ_OPDIV		GENMASK(13, 8)
+#define DPHY_TX_J721E_WIZ_FBDIV		GENMASK(25, 16)
+#define DPHY_TX_J721E_WIZ_LANE_RSTB	BIT(31)
+#define DPHY_TX_WIZ_PLL_LOCK		BIT(31)
+#define DPHY_TX_WIZ_O_CMN_READY		BIT(31)
+
 struct cdns_dphy_cfg {
 	u8 pll_ipdiv;
 	u8 pll_opdiv;
@@ -220,6 +234,43 @@ static void cdns_dphy_ref_set_psm_div(struct cdns_dphy *dphy, u8 div)
 	       dphy->regs + DPHY_PSM_CFG);
 }
 
+#ifdef CONFIG_PHY_CADENCE_DPHY_J721E
+static unsigned long cdns_dphy_j721e_get_wakeup_time_ns(struct cdns_dphy *dphy)
+{
+	return 1000000;
+}
+
+static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
+					const struct cdns_dphy_cfg *cfg)
+{
+	u32 status;
+
+	writel(DPHY_CMN_PWM_HIGH(6) | DPHY_CMN_PWM_LOW(0x101) |
+	       DPHY_CMN_PWM_DIV(0x8),
+	       dphy->regs + DPHY_CMN_PWM);
+
+	writel((FIELD_PREP(DPHY_TX_J721E_WIZ_IPDIV, cfg->pll_ipdiv) |
+		FIELD_PREP(DPHY_TX_J721E_WIZ_OPDIV, cfg->pll_opdiv) |
+		FIELD_PREP(DPHY_TX_J721E_WIZ_FBDIV, cfg->pll_fbdiv)),
+		dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL);
+
+	writel(DPHY_TX_J721E_WIZ_LANE_RSTB,
+	       dphy->regs + DPHY_TX_J721E_WIZ_RST_CTRL);
+
+	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_PLL_CTRL, status,
+			   (status & DPHY_TX_WIZ_PLL_LOCK), 0, POLL_TIMEOUT_US);
+
+	readl_poll_timeout(dphy->regs + DPHY_TX_J721E_WIZ_STATUS, status,
+			   (status & DPHY_TX_WIZ_O_CMN_READY), 0,
+			   POLL_TIMEOUT_US);
+}
+
+static void cdns_dphy_j721e_set_psm_div(struct cdns_dphy *dphy, u8 div)
+{
+	writel(div, dphy->regs + DPHY_TX_J721E_WIZ_PSM_FREQ);
+}
+#endif /* !CONFIG_PHY_CADENCE_DPHY_J721E */
+
 /*
  * This is the reference implementation of DPHY hooks. Specific integration of
  * this IP may have to re-implement some of them depending on how they decided
@@ -231,6 +282,14 @@ static const struct cdns_dphy_ops ref_dphy_ops = {
 	.set_psm_div = cdns_dphy_ref_set_psm_div,
 };
 
+#ifdef CONFIG_PHY_CADENCE_DPHY_J721E
+static const struct cdns_dphy_ops j721e_dphy_ops = {
+	.get_wakeup_time_ns = cdns_dphy_j721e_get_wakeup_time_ns,
+	.set_pll_cfg = cdns_dphy_j721e_set_pll_cfg,
+	.set_psm_div = cdns_dphy_j721e_set_psm_div,
+};
+#endif /* !CONFIG_PHY_CADENCE_DPHY_J721E */
+
 static int cdns_dphy_config_from_opts(struct phy *phy,
 				      struct phy_configure_opts_mipi_dphy *opts,
 				      struct cdns_dphy_cfg *cfg)
@@ -420,6 +479,9 @@ static int cdns_dphy_remove(struct platform_device *pdev)
 
 static const struct of_device_id cdns_dphy_of_match[] = {
 	{ .compatible = "cdns,dphy", .data = &ref_dphy_ops },
+#ifdef CONFIG_PHY_CADENCE_DPHY_J721E
+	{ .compatible = "ti,j721e-dphy", .data = &j721e_dphy_ops },
+#endif /* !CONFIG_PHY_CADENCE_DPHY_J721E */
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, cdns_dphy_of_match);
-- 
2.36.1

