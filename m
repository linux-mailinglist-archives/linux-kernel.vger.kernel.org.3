Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 36DF1557C10
	for <lists+linux-kernel@lfdr.de>; Thu, 23 Jun 2022 14:56:24 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S232051AbiFWM4A (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 23 Jun 2022 08:56:00 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40678 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231942AbiFWMz4 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 23 Jun 2022 08:55:56 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 35F7A49FA8;
        Thu, 23 Jun 2022 05:55:54 -0700 (PDT)
Received: from fllv0034.itg.ti.com ([10.64.40.246])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 25NCtdCg120641;
        Thu, 23 Jun 2022 07:55:39 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1655988939;
        bh=qRX5ulrjpRrc4s5hWh/KXX+XTVfrzioD8WfNo0Ky2aE=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=JXGIVoyRb7C4Gv4yW2chmB3m9bAQ9CdlohI4sES8roZYilP4kB+N5lGQ+bV+Fwp59
         TaOmIizn73+FO52jVRnpwEd5dO3ChKEr6AMyVKVXwAms3uG8kgg+gGdfVQ4ZolU3O2
         iTJZkIhaX9MxBqNDV/xdh8F92Dtz6EakfomG2ofo=
Received: from DFLE105.ent.ti.com (dfle105.ent.ti.com [10.64.6.26])
        by fllv0034.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 25NCtdMU091336
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Thu, 23 Jun 2022 07:55:39 -0500
Received: from DFLE104.ent.ti.com (10.64.6.25) by DFLE105.ent.ti.com
 (10.64.6.26) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Thu, 23
 Jun 2022 07:55:39 -0500
Received: from fllv0039.itg.ti.com (10.64.41.19) by DFLE104.ent.ti.com
 (10.64.6.25) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Thu, 23 Jun 2022 07:55:39 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by fllv0039.itg.ti.com (8.15.2/8.15.2) with ESMTP id 25NCtc6X122511;
        Thu, 23 Jun 2022 07:55:38 -0500
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
Subject: [PATCH v4 3/3] phy: cdns-dphy: Add support for DPHY TX on J721e
Date:   Thu, 23 Jun 2022 18:24:33 +0530
Message-ID: <20220623125433.18467-4-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220623125433.18467-1-r-ravikumar@ti.com>
References: <20220623125433.18467-1-r-ravikumar@ti.com>
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
 drivers/phy/cadence/cdns-dphy.c | 61 +++++++++++++++++++++++++++++++++
 1 file changed, 61 insertions(+)

diff --git a/drivers/phy/cadence/cdns-dphy.c b/drivers/phy/cadence/cdns-dphy.c
index 14f951013b4f..3dfdfb33cd0a 100644
--- a/drivers/phy/cadence/cdns-dphy.c
+++ b/drivers/phy/cadence/cdns-dphy.c
@@ -7,6 +7,7 @@
 #include <linux/bitops.h>
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
@@ -210,6 +224,46 @@ static void cdns_dphy_ref_set_psm_div(struct cdns_dphy *dphy, u8 div)
 	       dphy->regs + DPHY_PSM_CFG);
 }
 
+static unsigned long cdns_dphy_j721e_get_wakeup_time_ns(struct cdns_dphy *dphy)
+{
+	/* Minimum wakeup time as per MIPI D-PHY spec v1.2 */
+	return 1000000;
+}
+
+static void cdns_dphy_j721e_set_pll_cfg(struct cdns_dphy *dphy,
+					const struct cdns_dphy_cfg *cfg)
+{
+	u32 status;
+
+	/*
+	 * set the PWM and PLL Byteclk divider settings to recommended values
+	 * which is same as that of in ref ops
+	 */
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
+
 /*
  * This is the reference implementation of DPHY hooks. Specific integration of
  * this IP may have to re-implement some of them depending on how they decided
@@ -221,6 +275,12 @@ static const struct cdns_dphy_ops ref_dphy_ops = {
 	.set_psm_div = cdns_dphy_ref_set_psm_div,
 };
 
+static const struct cdns_dphy_ops j721e_dphy_ops = {
+	.get_wakeup_time_ns = cdns_dphy_j721e_get_wakeup_time_ns,
+	.set_pll_cfg = cdns_dphy_j721e_set_pll_cfg,
+	.set_psm_div = cdns_dphy_j721e_set_psm_div,
+};
+
 static int cdns_dphy_config_from_opts(struct phy *phy,
 				      struct phy_configure_opts_mipi_dphy *opts,
 				      struct cdns_dphy_cfg *cfg)
@@ -408,6 +468,7 @@ static int cdns_dphy_remove(struct platform_device *pdev)
 
 static const struct of_device_id cdns_dphy_of_match[] = {
 	{ .compatible = "cdns,dphy", .data = &ref_dphy_ops },
+	{ .compatible = "ti,j721e-dphy", .data = &j721e_dphy_ops },
 	{ /* sentinel */ },
 };
 MODULE_DEVICE_TABLE(of, cdns_dphy_of_match);
-- 
2.36.1

