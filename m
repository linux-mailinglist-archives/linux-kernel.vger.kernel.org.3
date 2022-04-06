Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id EBB4B4F5DF2
	for <lists+linux-kernel@lfdr.de>; Wed,  6 Apr 2022 14:45:48 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229943AbiDFMpM (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 6 Apr 2022 08:45:12 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:56654 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S231772AbiDFMoW (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 6 Apr 2022 08:44:22 -0400
X-Greylist: delayed 347 seconds by postgrey-1.37 at lindbergh.monkeyblade.net; Wed, 06 Apr 2022 01:46:10 PDT
Received: from inva021.nxp.com (inva021.nxp.com [92.121.34.21])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74F7744A4C7
        for <linux-kernel@vger.kernel.org>; Wed,  6 Apr 2022 01:46:09 -0700 (PDT)
Received: from inva021.nxp.com (localhost [127.0.0.1])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 05802201FAA;
        Wed,  6 Apr 2022 10:40:17 +0200 (CEST)
Received: from aprdc01srsp001v.ap-rdc01.nxp.com (aprdc01srsp001v.ap-rdc01.nxp.com [165.114.16.16])
        by inva021.eu-rdc02.nxp.com (Postfix) with ESMTP id 69486201E9B;
        Wed,  6 Apr 2022 10:40:16 +0200 (CEST)
Received: from localhost.localdomain (mega.ap.freescale.net [10.192.208.232])
        by aprdc01srsp001v.ap-rdc01.nxp.com (Postfix) with ESMTP id 4E5FA183AC8A;
        Wed,  6 Apr 2022 16:40:14 +0800 (+08)
From:   Sandor.yu@nxp.com
To:     dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        andrzej.hajda@intel.com, narmstrong@baylibre.com,
        robert.foss@linaro.org, Laurent.pinchart@ideasonboard.com,
        jonas@kwiboo.se, jernej.skrabec@gmail.com
Cc:     Sandor.yu@nxp.com, shengjiu.wang@nxp.com, cai.huoqing@linux.dev,
        maxime@cerno.tech, harry.wentland@amd.com,
        hverkuil-cisco@xs4all.nl, amuel@sholland.org
Subject: [PATCH v1 4/5] drm: bridge: dw_hdmi: add reset function for PHY GEN1
Date:   Wed,  6 Apr 2022 16:48:36 +0800
Message-Id: <800262112191a720639ba321be18f0926d4e1d2a.1649230434.git.Sandor.yu@nxp.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <cover.1649230434.git.Sandor.yu@nxp.com>
References: <cover.1649230434.git.Sandor.yu@nxp.com>
In-Reply-To: <cover.1649230434.git.Sandor.yu@nxp.com>
References: <cover.1649230434.git.Sandor.yu@nxp.com>
X-Virus-Scanned: ClamAV using ClamSMTP
X-Spam-Status: No, score=-4.2 required=5.0 tests=BAYES_00,RCVD_IN_DNSWL_MED,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Sandor Yu <Sandor.yu@nxp.com>

PHY reset register(MC_PHYRSTZ) active high reset control for PHY GEN2,
and active low reset control for PHY GEN1.

Rename function dw_hdmi_phy_reset to dw_hdmi_phy_gen2_reset.
Add dw_hdmi_phy_gen1_reset function for PHY GEN1.

Signed-off-by: Sandor Yu <Sandor.yu@nxp.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 14 +++++++++++---
 drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c    |  2 +-
 include/drm/bridge/dw_hdmi.h              |  4 +++-
 3 files changed, 15 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index c7b11582529e..c6e701acd416 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -1365,13 +1365,21 @@ static void dw_hdmi_phy_sel_interface_control(struct dw_hdmi *hdmi, u8 enable)
 			 HDMI_PHY_CONF0_SELDIPIF_MASK);
 }
 
-void dw_hdmi_phy_reset(struct dw_hdmi *hdmi)
+void dw_hdmi_phy_gen1_reset(struct dw_hdmi *hdmi)
+{
+	/* PHY reset. The reset signal is active low on Gen1 PHYs. */
+	hdmi_writeb(hdmi, 0, HDMI_MC_PHYRSTZ);
+	hdmi_writeb(hdmi, HDMI_MC_PHYRSTZ_PHYRSTZ, HDMI_MC_PHYRSTZ);
+}
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen1_reset);
+
+void dw_hdmi_phy_gen2_reset(struct dw_hdmi *hdmi)
 {
 	/* PHY reset. The reset signal is active high on Gen2 PHYs. */
 	hdmi_writeb(hdmi, HDMI_MC_PHYRSTZ_PHYRSTZ, HDMI_MC_PHYRSTZ);
 	hdmi_writeb(hdmi, 0, HDMI_MC_PHYRSTZ);
 }
-EXPORT_SYMBOL_GPL(dw_hdmi_phy_reset);
+EXPORT_SYMBOL_GPL(dw_hdmi_phy_gen2_reset);
 
 void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address)
 {
@@ -1525,7 +1533,7 @@ static int hdmi_phy_configure(struct dw_hdmi *hdmi,
 	if (phy->has_svsret)
 		dw_hdmi_phy_enable_svsret(hdmi, 1);
 
-	dw_hdmi_phy_reset(hdmi);
+	dw_hdmi_phy_gen2_reset(hdmi);
 
 	hdmi_writeb(hdmi, HDMI_MC_HEACPHY_RST_ASSERT, HDMI_MC_HEACPHY_RST);
 
diff --git a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
index 5e2b0175df36..2860e6bff8b7 100644
--- a/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
+++ b/drivers/gpu/drm/sun4i/sun8i_hdmi_phy.c
@@ -135,7 +135,7 @@ static int sun8i_hdmi_phy_config_a83t(struct dw_hdmi *hdmi,
 	dw_hdmi_phy_gen2_txpwron(hdmi, 0);
 	dw_hdmi_phy_gen2_pddq(hdmi, 1);
 
-	dw_hdmi_phy_reset(hdmi);
+	dw_hdmi_phy_gen2_reset(hdmi);
 
 	dw_hdmi_phy_gen2_pddq(hdmi, 0);
 
diff --git a/include/drm/bridge/dw_hdmi.h b/include/drm/bridge/dw_hdmi.h
index 2a1f85f9a8a3..70082f80a8c8 100644
--- a/include/drm/bridge/dw_hdmi.h
+++ b/include/drm/bridge/dw_hdmi.h
@@ -187,9 +187,11 @@ void dw_hdmi_phy_i2c_set_addr(struct dw_hdmi *hdmi, u8 address);
 void dw_hdmi_phy_i2c_write(struct dw_hdmi *hdmi, unsigned short data,
 			   unsigned char addr);
 
+void dw_hdmi_phy_gen1_reset(struct dw_hdmi *hdmi);
+
 void dw_hdmi_phy_gen2_pddq(struct dw_hdmi *hdmi, u8 enable);
 void dw_hdmi_phy_gen2_txpwron(struct dw_hdmi *hdmi, u8 enable);
-void dw_hdmi_phy_reset(struct dw_hdmi *hdmi);
+void dw_hdmi_phy_gen2_reset(struct dw_hdmi *hdmi);
 
 enum drm_connector_status dw_hdmi_phy_read_hpd(struct dw_hdmi *hdmi,
 					       void *data);
-- 
2.25.1

