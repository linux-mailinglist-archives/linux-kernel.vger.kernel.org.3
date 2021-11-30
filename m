Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 6AF584630B5
	for <lists+linux-kernel@lfdr.de>; Tue, 30 Nov 2021 11:09:12 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240689AbhK3KMU (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 30 Nov 2021 05:12:20 -0500
Received: from esa.microchip.iphmx.com ([68.232.154.123]:34738 "EHLO
        esa.microchip.iphmx.com" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240681AbhK3KMT (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 30 Nov 2021 05:12:19 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=simple/simple;
  d=microchip.com; i=@microchip.com; q=dns/txt; s=mchp;
  t=1638266940; x=1669802940;
  h=from:to:cc:subject:date:message-id:mime-version:
   content-transfer-encoding;
  bh=2FwvvqSnok2ooh7zpbRusi+58zDEFAmIqlAKrOG2dMU=;
  b=j3z7hE4OBNrjc+PT3iTmMjFLj6wThqPXh5jQpKHh8BEF+mlHrbPItn+o
   6Uh6VNsQREibbrXXRpOS0GFmt0ieI12Y2gqtM0MQbaX/m8skGRWJsPyLD
   w8K1kjCW3rRY+CVtryZKxmCbhoe4V8NNXKxzLvhnjq1QhK5ePZU+G7rIs
   zUb2ENnsZir22bLdhOBR/tyi4pvbX8YLi3QH819nwM1HJZsF/972cJQMq
   zdCm22dAHUEVqdeiRIepI6irZANjQOUp0BIlzCFM1rHTAfH19pG3o5uvu
   JpWqVUxac19Lu2srKi976eHKh1yO1dwhcDvorYzJbwUCNMzLUgFRZeGZd
   g==;
IronPort-SDR: ANvmwIAupJDD9KB0LZfAifUmNYf8kTngsNeZLYi36quUPF4xN39ZIBXIuqO7FjbcahjJIe1Jf3
 CCqOwRkjssHFYhAl5moZc5HBAiaudDcBt2lDTsY2IwqZk6I8Blvp4EvCXa1kA4s53kCJleMh0/
 ad3cZysdsfvm4aM7nh+XR4C9i7xgsxN5TKs5m8eaUjPxT85v6j7z55jp4ni4XYxUhMqkSpOUah
 wvPkqa2OdRNmn9CWMOGEJSxcJUgAHxNYwtOa+X0PMAZZwpR7I1ldiSLcuny1W8rkFy4XZXzv/w
 RB7u/+SgVVNlYp9LuLI681Um
X-IronPort-AV: E=Sophos;i="5.87,275,1631602800"; 
   d="scan'208";a="138112841"
Received: from smtpout.microchip.com (HELO email.microchip.com) ([198.175.253.82])
  by esa4.microchip.iphmx.com with ESMTP/TLS/AES256-SHA256; 30 Nov 2021 03:08:59 -0700
Received: from chn-vm-ex01.mchp-main.com (10.10.85.143) by
 chn-vm-ex02.mchp-main.com (10.10.85.144) with Microsoft SMTP Server
 (version=TLS1_2, cipher=TLS_ECDHE_RSA_WITH_AES_128_GCM_SHA256) id
 15.1.2176.14; Tue, 30 Nov 2021 03:08:59 -0700
Received: from soft-dev3-1.microsemi.net (10.10.115.15) by
 chn-vm-ex01.mchp-main.com (10.10.85.143) with Microsoft SMTP Server id
 15.1.2176.14 via Frontend Transport; Tue, 30 Nov 2021 03:08:58 -0700
From:   Horatiu Vultur <horatiu.vultur@microchip.com>
To:     <kishon@ti.com>, <vkoul@kernel.org>, <linux@armlinux.org.uk>,
        <linux-phy@lists.infradead.org>, <linux-kernel@vger.kernel.org>
CC:     Horatiu Vultur <horatiu.vultur@microchip.com>
Subject: [PATCH] phy: lan966x: Extend lan966x to support multiple phy interfaces.
Date:   Tue, 30 Nov 2021 11:10:15 +0100
Message-ID: <20211130101015.164916-1-horatiu.vultur@microchip.com>
X-Mailer: git-send-email 2.33.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Currently the driver is supporting only the interfaces QSGMII, SGMII,
RGMII and GMII. This patch extend the supported interfaces with
1000BASE-X and 2500BASE-X.

Signed-off-by: Horatiu Vultur <horatiu.vultur@microchip.com>
---
 drivers/phy/microchip/lan966x_serdes.c | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/phy/microchip/lan966x_serdes.c b/drivers/phy/microchip/lan966x_serdes.c
index 262bb616b4bb..c0b80a176387 100644
--- a/drivers/phy/microchip/lan966x_serdes.c
+++ b/drivers/phy/microchip/lan966x_serdes.c
@@ -392,6 +392,10 @@ static int serdes_set_mode(struct phy *phy, enum phy_mode mode, int submode)
 	if (mode != PHY_MODE_ETHERNET)
 		return -EOPNOTSUPP;
 
+	if (submode == PHY_INTERFACE_MODE_1000BASEX ||
+	    submode == PHY_INTERFACE_MODE_2500BASEX)
+		submode = PHY_INTERFACE_MODE_SGMII;
+
 	for (i = 0; i < ARRAY_SIZE(lan966x_serdes_muxes); i++) {
 		if (macro->idx != lan966x_serdes_muxes[i].idx ||
 		    mode != lan966x_serdes_muxes[i].mode ||
-- 
2.33.0

