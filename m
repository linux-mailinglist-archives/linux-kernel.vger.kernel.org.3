Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id D1B7A4716DF
	for <lists+linux-kernel@lfdr.de>; Sat, 11 Dec 2021 22:45:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S231495AbhLKVpl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Sat, 11 Dec 2021 16:45:41 -0500
Received: from esa.microchip.iphmx.com ([68.232.153.233]:57484 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231319AbhLKVpk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Sat, 11 Dec 2021 16:45:40 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1639259142; x=1670795142;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=kPEOxlRJTHMuHZKyDDPAt3/GOzpvpZEMvEMb59PqfX4=;
  b=ko/2LossjFmUG3QrQMnjlSZUoiDhmFqDVRTS9VFEvfJndxEwLHQjCCYD
   crYqb8ZNqwNLz5Wa90+9ndDzjvC92DHE/pvImn2JLBuHGMcK0bo6IdsOc
   bE3c9axYv4glLXmdSd95/gGeZydrFIhK2tkpFv4MvfIvfRn7o0JiwSuuQ
   m0I7Gm6/HlWvigQ7dveoD58cq9y4IHbcu8GMZXTmgBL7I7VcLRtglkfok
   pkn72VxxbEoulhaihRpJwyGH7+mHSryfC0t4aUQ4gLqx0hdBuilhDh9U9
   yfsbEcQJ40KHdynC0hMCZc7YTMCFcG1J6Wd5TZOVLhdVIG3ZAd2lOElgt
   A==;
IronPort-SDR: Iq/GQflWI2WFGi7l4IFzHQCasMOinRa6l6YAAZNDoUkcsoxL6iBCh1Ih6Qr8sflGMy7xa8We7M
 XWUClBFBdyNedL+38z1tZYbMVxciv0DBPpfQNZn73WJo5pKw2DYsENN8wiq61cas9+WInK8KBk
 O16JaVpi/kns7dREtuDyfphn5XSmnn2f4jl6Vk4TGjCB8VAn019UOuv4aeIBhi+8bBecgdaceP
 I1oi/Kb/ccyDAcLeFqL2n1usxXUkWDCDMOA3kCT/PhOJV3lSfArwPD4V/JnML2aOGiniok+shi
 2JXH8bsqEZzM7O/DakRcF1pd
X-IronPort-AV: E=Sophos;i="5.88,199,1635231600"; 
   d="scan'208";a="146345647"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa5.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 11 Dec 2021 14:45:41 -0700
Received: from chn-vm-ex02.mchp-main.com (10.10.87.72) by
 chn-vm-ex02.mchp-main.com (10.10.87.72) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2375.17; Sat, 11 Dec 2021 14:45:39 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server id
 15.1.2375.17 via Frontend Transport; Sat, 11 Dec 2021 14:45:38 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     <kishon@ti.com>, <vkoul@kernel.org>, <linux@armlinux.org.uk>,
        "Horatiu Vultur" <horatiu.vultur@microchip.com>
Subject: [PATCH] phy: lan966x: Remove set_speed function
Date:   Sat, 11 Dec 2021 22:47:17 +0100
Message-ID: <20211211214717.1284306-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Remove the set_speed function and allow the driver to figure out the
speed at which needs to configure the serdes based on the interface type.

Fixes: 305524902a0045 ("phy: Add lan966x ethernet serdes PHY driver")
Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/phy/microchip/lan966x_serdes.c | 17 +++++------------
 1 file changed, 5 insertions(+), 12 deletions(-)

diff --git a/drivers/phy/microchip/lan966x_serdes.c b/drivers/phy/microchip/lan966x_serdes.c
index c0b80a176387..e86a879b92b5 100644
--- a/drivers/phy/microchip/lan966x_serdes.c
+++ b/drivers/phy/microchip/lan966x_serdes.c
@@ -392,6 +392,11 @@ static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
+	if (submode == PHY_INTERFACE_MODE_2500BASEX)
+		macro->speed = SPEED_2500;
+	else
+		macro->speed = SPEED_1000;
+
 	if (submode == PHY_INTERFACE_MODE_1000BASEX ||
 	    submode == PHY_INTERFACE_MODE_2500BASEX)
 		submode = PHY_INTERFACE_MODE_SGMII;
@@ -427,19 +432,8 @@ static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	return -EINVAL;
 }
 
-static int serdes_set_speed(struct phy *phy, int speed)
-{
-	struct serdes_macro *macro = phy_get_drvdata(phy);
-
-	macro->speed = speed;
-
-	return lan966x_sd6g40_setup(macro, macro->idx - (CU_MAX + 1),
-				    macro->mode);
-}
-
 static const struct phy_ops serdes_ops = {
 	.set_mode	= serdes_set_mode,
-	.set_speed	= serdes_set_speed,
 	.owner		= THIS_MODULE,
 };
 
@@ -482,7 +476,6 @@ static int serdes_phy_create(struct serdes_ctrl *ctrl, u8 idx, struct phy **phy)
 
 	macro->idx = idx;
 	macro->ctrl = ctrl;
-	macro->speed = SPEED_1000;
 	macro->port = -1;
 
 	phy_set_drvdata(*phy, macro);
-- 
2.33.0

