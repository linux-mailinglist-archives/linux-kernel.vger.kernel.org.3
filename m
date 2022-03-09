Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5C7464D28AC
	for <lists+linux-kernel@lfdr.de>; Wed,  9 Mar 2022 07:05:06 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229838AbiCIGF7 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 9 Mar 2022 01:05:59 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:51804 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229509AbiCIGF7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 9 Mar 2022 01:05:59 -0500
Received: from fllv0015.ext.ti.com (fllv0015.ext.ti.com [198.47.19.141])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 123947C789;
        Tue,  8 Mar 2022 22:05:00 -0800 (PST)
Received: from lelv0265.itg.ti.com ([10.180.67.224])
        by fllv0015.ext.ti.com (8.15.2/8.15.2) with ESMTP id 22964ie1029513;
        Wed, 9 Mar 2022 00:04:44 -0600
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1646805884;
        bh=tFs5PFMWcC0txVuAfsKe7VrAX6diWqLbUfTm5GvmMME=;
        h=From:To:CC:Subject:Date;
        b=h54dv5iNtqQuaFAAI0Zfe/ukpi3/9ahSpim8Wjd2zTYX4CEylNbsOX7/l+EjYikL8
         tdaaetS8pc5I4pQZooinYPNn6FQtZCbsoi6s+a5M1PZU7slW+sqnMEXwUwrOOnueEf
         WeVTXBavaKUzWXXDT4wi1K6wN9H3mG17bWXxaNTU=
Received: from DFLE108.ent.ti.com (dfle108.ent.ti.com [10.64.6.29])
        by lelv0265.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 22964iqE037203
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Wed, 9 Mar 2022 00:04:44 -0600
Received: from DFLE110.ent.ti.com (10.64.6.31) by DFLE108.ent.ti.com
 (10.64.6.29) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Wed, 9
 Mar 2022 00:04:44 -0600
Received: from lelv0326.itg.ti.com (10.180.67.84) by DFLE110.ent.ti.com
 (10.64.6.31) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Wed, 9 Mar 2022 00:04:44 -0600
Received: from gsaswath-HP-ProBook-640-G5.dal.design.ti.com (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 22964eNu098487;
        Wed, 9 Mar 2022 00:04:41 -0600
From:   Aswath Govindraju <a-govindraju@ti.com>
CC:     Aswath Govindraju <a-govindraju@ti.com>,
        Kishon Vijay Abraham I <kishon@ti.com>,
        Vinod Koul <vkoul@kernel.org>,
        Wolfgang Grandegger <wg@grandegger.com>,
        Marc Kleine-Budde <mkl@pengutronix.de>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>,
        <linux-can@vger.kernel.org>
Subject: [PATCH v4] phy: phy-can-transceiver: Add support for setting mux
Date:   Wed, 9 Mar 2022 11:34:29 +0530
Message-ID: <20220309060429.26366-1-a-govindraju@ti.com>
X-Mailer: git-send-email 2.17.1
MIME-Version: 1.0
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_LOW,
        RCVD_IN_MSPIKE_H2,SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE
        autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

On some boards, for routing CAN signals from controller to transceiver,
muxes might need to be set. Therefore, add support for setting the mux by
reading the mux-states property from the device tree node.

Signed-off-by: Aswath Govindraju <a-govindraju@ti.com>
---

Changes since v3:
- Rebased on top of the linux-next head
- Dependencies are now merged in linux next.
  84564481bc45 (mux: Add support for reading mux state from consumer DT node)
- Dropped bindings patch from the series since it has been
  picked up from the earlier version
  https://lore.kernel.org/all/YieG22mgIzsL7TMn@robh.at.kernel.org/

Changes since v2:
- Fixed the bindings removing the description about
  the arguments in mux-states property

Changes since v1:
- Fixed the description for mux-states property in bindings
  file
- appended declaration of variable ret in the end

 drivers/phy/Kconfig               |  1 +
 drivers/phy/phy-can-transceiver.c | 24 +++++++++++++++++++++++-
 2 files changed, 24 insertions(+), 1 deletion(-)

diff --git a/drivers/phy/Kconfig b/drivers/phy/Kconfig
index 82b63e60c5a2..300b0f2b5f84 100644
--- a/drivers/phy/Kconfig
+++ b/drivers/phy/Kconfig
@@ -64,6 +64,7 @@ config USB_LGM_PHY
 config PHY_CAN_TRANSCEIVER
 	tristate "CAN transceiver PHY"
 	select GENERIC_PHY
+	select MULTIPLEXER
 	help
 	  This option enables support for CAN transceivers as a PHY. This
 	  driver provides function for putting the transceivers in various
diff --git a/drivers/phy/phy-can-transceiver.c b/drivers/phy/phy-can-transceiver.c
index 6f3fe37dee0e..95c6dbb52da7 100644
--- a/drivers/phy/phy-can-transceiver.c
+++ b/drivers/phy/phy-can-transceiver.c
@@ -10,6 +10,7 @@
 #include<linux/module.h>
 #include<linux/gpio.h>
 #include<linux/gpio/consumer.h>
+#include <linux/mux/consumer.h>
 
 struct can_transceiver_data {
 	u32 flags;
@@ -21,13 +22,22 @@ struct can_transceiver_phy {
 	struct phy *generic_phy;
 	struct gpio_desc *standby_gpio;
 	struct gpio_desc *enable_gpio;
+	struct mux_state *mux_state;
 };
 
 /* Power on function */
 static int can_transceiver_phy_power_on(struct phy *phy)
 {
 	struct can_transceiver_phy *can_transceiver_phy = phy_get_drvdata(phy);
-
+	int ret;
+
+	if (can_transceiver_phy->mux_state) {
+		ret = mux_state_select(can_transceiver_phy->mux_state);
+		if (ret) {
+			dev_err(&phy->dev, "Failed to select CAN mux: %d\n", ret);
+			return ret;
+		}
+	}
 	if (can_transceiver_phy->standby_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 0);
 	if (can_transceiver_phy->enable_gpio)
@@ -45,6 +55,8 @@ static int can_transceiver_phy_power_off(struct phy *phy)
 		gpiod_set_value_cansleep(can_transceiver_phy->standby_gpio, 1);
 	if (can_transceiver_phy->enable_gpio)
 		gpiod_set_value_cansleep(can_transceiver_phy->enable_gpio, 0);
+	if (can_transceiver_phy->mux_state)
+		mux_state_deselect(can_transceiver_phy->mux_state);
 
 	return 0;
 }
@@ -95,6 +107,16 @@ static int can_transceiver_phy_probe(struct platform_device *pdev)
 	match = of_match_node(can_transceiver_phy_ids, pdev->dev.of_node);
 	drvdata = match->data;
 
+	if (of_property_read_bool(dev->of_node, "mux-states")) {
+		struct mux_state *mux_state;
+
+		mux_state = devm_mux_state_get(dev, NULL);
+		if (IS_ERR(mux_state))
+			return dev_err_probe(&pdev->dev, PTR_ERR(mux_state),
+					     "failed to get mux\n");
+		can_transceiver_phy->mux_state = mux_state;
+	}
+
 	phy = devm_phy_create(dev, dev->of_node,
 			      &can_transceiver_phy_ops);
 	if (IS_ERR(phy)) {
-- 
2.17.1

