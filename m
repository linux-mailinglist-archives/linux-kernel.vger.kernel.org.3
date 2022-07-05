Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 775DA566D64
	for <lists+linux-kernel@lfdr.de>; Tue,  5 Jul 2022 14:24:35 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237288AbiGEMXL (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 5 Jul 2022 08:23:11 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35532 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236012AbiGEMP7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 5 Jul 2022 08:15:59 -0400
Received: from lelv0142.ext.ti.com (lelv0142.ext.ti.com [198.47.23.249])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 16F9F1B7B9;
        Tue,  5 Jul 2022 05:11:55 -0700 (PDT)
Received: from lelv0266.itg.ti.com ([10.180.67.225])
        by lelv0142.ext.ti.com (8.15.2/8.15.2) with ESMTP id 265CBXV6048829;
        Tue, 5 Jul 2022 07:11:33 -0500
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed; d=ti.com;
        s=ti-com-17Q1; t=1657023093;
        bh=nlB1w+i7QT4hulVQci7NeKDsS6OG13fU0TgYxnWSh0s=;
        h=From:To:CC:Subject:Date:In-Reply-To:References;
        b=Nil2GTedYOqT48LoGl29NE6lR9dbFU3eno/XZmarwnPvGObdEyCw6vj0Fun8mIE7m
         UHW2iLuUa9eCQp4jSeBAp41wu18zyn46FajMdrVD5emSgoJPmWM/pAKY1ut2Y3xOqc
         2DlJBzeLP1y2saxq4i5AYd6eOiF/iJZKyQFF6xtc=
Received: from DLEE110.ent.ti.com (dlee110.ent.ti.com [157.170.170.21])
        by lelv0266.itg.ti.com (8.15.2/8.15.2) with ESMTPS id 265CBXYf083983
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=FAIL);
        Tue, 5 Jul 2022 07:11:33 -0500
Received: from DLEE106.ent.ti.com (157.170.170.36) by DLEE110.ent.ti.com
 (157.170.170.21) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14; Tue, 5
 Jul 2022 07:11:33 -0500
Received: from lelv0326.itg.ti.com (10.180.67.84) by DLEE106.ent.ti.com
 (157.170.170.36) with Microsoft SMTP Server (version=TLS1_2,
 cipher=TLS_ECDHE_RSA_WITH_AES_128_CBC_SHA256_P256) id 15.1.2308.14 via
 Frontend Transport; Tue, 5 Jul 2022 07:11:32 -0500
Received: from localhost (ileax41-snat.itg.ti.com [10.172.224.153])
        by lelv0326.itg.ti.com (8.15.2/8.15.2) with ESMTP id 265CBVhj023381;
        Tue, 5 Jul 2022 07:11:32 -0500
From:   Rahul T R <r-ravikumar@ti.com>
To:     <dri-devel@lists.freedesktop.org>, <robh+dt@kernel.org>,
        <krzysztof.kozlowski+dt@linaro.org>
CC:     <andrzej.hajda@intel.com>, <narmstrong@baylibre.com>,
        <robert.foss@linaro.org>, <jonas@kwiboo.se>,
        <jernej.skrabec@gmail.com>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <p.zabel@pengutronix.de>, <tomi.valkeinen@ideasonboard.com>,
        <laurent.pinchart@ideasonboard.com>,
        <linux-kernel@vger.kernel.org>, <jpawar@cadence.com>,
        <sjakhade@cadence.com>, <mparab@cadence.com>, <a-bhatia1@ti.com>,
        <devicetree@vger.kernel.org>, <vigneshr@ti.com>,
        <lee.jones@linaro.org>, Rahul T R <r-ravikumar@ti.com>
Subject: [PATCH v4 3/5] drm/bridge: cdns-dsi: Move to drm/bridge/cadence
Date:   Tue, 5 Jul 2022 17:41:14 +0530
Message-ID: <20220705121116.24121-4-r-ravikumar@ti.com>
X-Mailer: git-send-email 2.36.1
In-Reply-To: <20220705121116.24121-1-r-ravikumar@ti.com>
References: <20220705121116.24121-1-r-ravikumar@ti.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Content-Type: text/plain
X-EXCLAIMER-MD-CONFIG: e1e8a2fd-e40a-4ac6-ac9b-f7e9cc9ee180
X-Spam-Status: No, score=-5.1 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Move the cadence dsi bridge under drm/bridge/cadence
directory, to prepare for adding j721e wrapper
support

Signed-off-by: Rahul T R <r-ravikumar@ti.com>
---
 drivers/gpu/drm/bridge/Kconfig                       | 11 -----------
 drivers/gpu/drm/bridge/Makefile                      |  1 -
 drivers/gpu/drm/bridge/cadence/Kconfig               | 12 ++++++++++++
 drivers/gpu/drm/bridge/cadence/Makefile              |  2 ++
 .../bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c}   |  0
 5 files changed, 14 insertions(+), 12 deletions(-)
 rename drivers/gpu/drm/bridge/{cdns-dsi.c => cadence/cdns-dsi-core.c} (100%)

diff --git a/drivers/gpu/drm/bridge/Kconfig b/drivers/gpu/drm/bridge/Kconfig
index 57946d80b02d..8b2226f72b24 100644
--- a/drivers/gpu/drm/bridge/Kconfig
+++ b/drivers/gpu/drm/bridge/Kconfig
@@ -15,17 +15,6 @@ config DRM_PANEL_BRIDGE
 menu "Display Interface Bridges"
 	depends on DRM && DRM_BRIDGE
 
-config DRM_CDNS_DSI
-	tristate "Cadence DPI/DSI bridge"
-	select DRM_KMS_HELPER
-	select DRM_MIPI_DSI
-	select DRM_PANEL_BRIDGE
-	select GENERIC_PHY_MIPI_DPHY
-	depends on OF
-	help
-	  Support Cadence DPI to DSI bridge. This is an internal
-	  bridge and is meant to be directly embedded in a SoC.
-
 config DRM_CHIPONE_ICN6211
 	tristate "Chipone ICN6211 MIPI-DSI/RGB Converter bridge"
 	depends on OF
diff --git a/drivers/gpu/drm/bridge/Makefile b/drivers/gpu/drm/bridge/Makefile
index 1884803c6860..52f6e8b4a821 100644
--- a/drivers/gpu/drm/bridge/Makefile
+++ b/drivers/gpu/drm/bridge/Makefile
@@ -1,5 +1,4 @@
 # SPDX-License-Identifier: GPL-2.0
-obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
 obj-$(CONFIG_DRM_CHIPONE_ICN6211) += chipone-icn6211.o
 obj-$(CONFIG_DRM_CHRONTEL_CH7033) += chrontel-ch7033.o
 obj-$(CONFIG_DRM_CROS_EC_ANX7688) += cros-ec-anx7688.o
diff --git a/drivers/gpu/drm/bridge/cadence/Kconfig b/drivers/gpu/drm/bridge/cadence/Kconfig
index 1d06182bea71..e4d3415df2a0 100644
--- a/drivers/gpu/drm/bridge/cadence/Kconfig
+++ b/drivers/gpu/drm/bridge/cadence/Kconfig
@@ -25,3 +25,15 @@ config DRM_CDNS_MHDP8546_J721E
 	  initializes the J721E Display Port and sets up the
 	  clock and data muxes.
 endif
+
+config DRM_CDNS_DSI
+	tristate "Cadence DPI/DSI bridge"
+	select DRM_KMS_HELPER
+	select DRM_MIPI_DSI
+	select DRM_PANEL_BRIDGE
+	select GENERIC_PHY_MIPI_DPHY
+	depends on OF
+	help
+	  Support Cadence DPI to DSI bridge. This is an internal
+	  bridge and is meant to be directly embedded in a SoC.
+
diff --git a/drivers/gpu/drm/bridge/cadence/Makefile b/drivers/gpu/drm/bridge/cadence/Makefile
index 4d2db8df1bc6..e3d8e9a40784 100644
--- a/drivers/gpu/drm/bridge/cadence/Makefile
+++ b/drivers/gpu/drm/bridge/cadence/Makefile
@@ -2,3 +2,5 @@
 obj-$(CONFIG_DRM_CDNS_MHDP8546) += cdns-mhdp8546.o
 cdns-mhdp8546-y := cdns-mhdp8546-core.o cdns-mhdp8546-hdcp.o
 cdns-mhdp8546-$(CONFIG_DRM_CDNS_MHDP8546_J721E) += cdns-mhdp8546-j721e.o
+obj-$(CONFIG_DRM_CDNS_DSI) += cdns-dsi.o
+cdns-dsi-y := cdns-dsi-core.o
diff --git a/drivers/gpu/drm/bridge/cdns-dsi.c b/drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
similarity index 100%
rename from drivers/gpu/drm/bridge/cdns-dsi.c
rename to drivers/gpu/drm/bridge/cadence/cdns-dsi-core.c
-- 
2.36.1

