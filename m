Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0E2A85533AF
	for <lists+linux-kernel@lfdr.de>; Tue, 21 Jun 2022 15:37:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S233316AbiFUNeg (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Tue, 21 Jun 2022 09:34:36 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56544 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1351939AbiFUNdL (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Tue, 21 Jun 2022 09:33:11 -0400
Received: from baptiste.telenet-ops.be (baptiste.telenet-ops.be [IPv6:2a02:1800:120:4::f00:13])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7FC162AE26
        for <linux-kernel@vger.kernel.org>; Tue, 21 Jun 2022 06:30:30 -0700 (PDT)
Received: from ramsan.of.borg ([84.195.186.194])
        by baptiste.telenet-ops.be with bizsmtp
        id lpWF2700F4C55Sk01pWFgS; Tue, 21 Jun 2022 15:30:28 +0200
Received: from rox.of.borg ([192.168.97.57])
        by ramsan.of.borg with esmtps  (TLS1.3) tls TLS_ECDHE_RSA_WITH_AES_256_GCM_SHA384
        (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o3dxN-000BYK-Uo; Tue, 21 Jun 2022 15:30:13 +0200
Received: from geert by rox.of.borg with local (Exim 4.93)
        (envelope-from <geert@linux-m68k.org>)
        id 1o3dxN-006KTv-FK; Tue, 21 Jun 2022 15:30:13 +0200
From:   Geert Uytterhoeven <geert+renesas@glider.be>
To:     Liu Ying <victor.liu@nxp.com>,
        Andrzej Hajda <andrzej.hajda@intel.com>,
        Neil Armstrong <narmstrong@baylibre.com>,
        Robert Foss <robert.foss@linaro.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Shawn Guo <shawnguo@kernel.org>,
        Sascha Hauer <s.hauer@pengutronix.de>,
        Laurent Pinchart <Laurent.pinchart@ideasonboard.com>,
        Jonas Karlman <jonas@kwiboo.se>,
        Jernej Skrabec <jernej.skrabec@gmail.com>,
        Pengutronix Kernel Team <kernel@pengutronix.de>,
        Fabio Estevam <festevam@gmail.com>,
        NXP Linux Team <linux-imx@nxp.com>,
        Sakari Ailus <sakari.ailus@linux.intel.com>,
        Marek Vasut <marex@denx.de>
Cc:     dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org,
        Geert Uytterhoeven <geert+renesas@glider.be>
Subject: [PATCH] drm/bridge: imx: i.MX8 bridge drivers should depend on ARCH_MXC
Date:   Tue, 21 Jun 2022 15:30:11 +0200
Message-Id: <43645c9b5cd657664c1340d40133f2116c8cef43.1655818025.git.geert+renesas@glider.be>
X-Mailer: git-send-email 2.25.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-2.4 required=5.0 tests=BAYES_00,
        HEADER_FROM_DIFFERENT_DOMAINS,RCVD_IN_DNSWL_LOW,SPF_HELO_NONE,SPF_NONE,
        T_SCC_BODY_TEXT_LINE autolearn=ham autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

The various Freescale i.MX8MP display bridges are only present on
Freescale i.MX8 SoCs.  Hence add a dependency on ARCH_MXC, to prevent
asking the user about these drivers when configuring a kernel without
i.MX SoC support.

Fixes: e60c4354840b2fe8 ("drm/bridge: imx: Add LDB support for i.MX8qm")
Fixes: 3818715f62b42b5c ("drm/bridge: imx: Add LDB support for i.MX8qxp")
Fixes: 96988a526c97cfbe ("drm/bridge: imx: Add i.MX8qxp pixel link to DPI support")
Fixes: 1ec17c26bc06289d ("drm/bridge: imx: Add i.MX8qm/qxp display pixel link support")
Fixes: 93e163a9e0392aca ("drm/bridge: imx: Add i.MX8qm/qxp pixel combiner support")
Signed-off-by: Geert Uytterhoeven <geert+renesas@glider.be>
---
Probably the remaining i.MX bridge drivers in
drivers/gpu/drm/bridge/Kconfig (e.g. DRM_FSL_LDB) should be moved here,
too?
---
 drivers/gpu/drm/bridge/imx/Kconfig | 4 ++++
 1 file changed, 4 insertions(+)

diff --git a/drivers/gpu/drm/bridge/imx/Kconfig b/drivers/gpu/drm/bridge/imx/Kconfig
index 212a7b0e64fd8b5a..608f47f41bcd1c81 100644
--- a/drivers/gpu/drm/bridge/imx/Kconfig
+++ b/drivers/gpu/drm/bridge/imx/Kconfig
@@ -1,3 +1,5 @@
+if ARCH_MXC || COMPILE_TEST
+
 config DRM_IMX8QM_LDB
 	tristate "Freescale i.MX8QM LVDS display bridge"
 	depends on OF
@@ -41,3 +43,5 @@ config DRM_IMX8QXP_PIXEL_LINK_TO_DPI
 	help
 	  Choose this to enable pixel link to display pixel interface(PXL2DPI)
 	  found in Freescale i.MX8qxp processor.
+
+endif # ARCH_MXC || COMPILE_TEST
-- 
2.25.1

