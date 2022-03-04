Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 250E04CCDCC
	for <lists+linux-kernel@lfdr.de>; Fri,  4 Mar 2022 07:33:13 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237087AbiCDGdt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Fri, 4 Mar 2022 01:33:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:34620 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S232484AbiCDGdm (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Fri, 4 Mar 2022 01:33:42 -0500
Received: from twspam01.aspeedtech.com (twspam01.aspeedtech.com [211.20.114.71])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 965F82A277
        for <linux-kernel@vger.kernel.org>; Thu,  3 Mar 2022 22:32:52 -0800 (PST)
Received: from mail.aspeedtech.com ([192.168.0.24])
        by twspam01.aspeedtech.com with ESMTP id 2246MIZl041905;
        Fri, 4 Mar 2022 14:22:18 +0800 (GMT-8)
        (envelope-from tommy_huang@aspeedtech.com)
Received: from tommy0527-VirtualBox.aspeedtech.com (192.168.2.141) by
 TWMBX02.aspeed.com (192.168.0.24) with Microsoft SMTP Server (TLS) id
 15.0.1497.2; Fri, 4 Mar 2022 14:31:44 +0800
From:   Tommy Haung <tommy_huang@aspeedtech.com>
To:     <joel@jms.id.au>, <airlied@linux.ie>, <daniel@ffwll.ch>,
        <robh+dt@kernel.org>, <andrew@aj.id.au>,
        <linux-aspeed@lists.ozlabs.org>, <dri-devel@lists.freedesktop.org>,
        <devicetree@vger.kernel.org>,
        <linux-arm-kernel@lists.infradead.org>,
        <linux-kernel@vger.kernel.org>
CC:     <BMC-SW@aspeedtech.com>
Subject: [PATCH v1 1/2] drm/aspeed: Add gfx flags and clock selection for AST2600
Date:   Fri, 4 Mar 2022 14:31:36 +0800
Message-ID: <20220304063137.12970-2-tommy_huang@aspeedtech.com>
X-Mailer: git-send-email 2.17.1
In-Reply-To: <20220304063137.12970-1-tommy_huang@aspeedtech.com>
References: <20220304063137.12970-1-tommy_huang@aspeedtech.com>
MIME-Version: 1.0
Content-Type: text/plain
X-Originating-IP: [192.168.2.141]
X-ClientProxiedBy: TWMBX02.aspeed.com (192.168.0.24) To TWMBX02.aspeed.com
 (192.168.0.24)
X-DNSRBL: 
X-MAIL: twspam01.aspeedtech.com 2246MIZl041905
X-Spam-Status: No, score=-1.9 required=5.0 tests=BAYES_00,SPF_HELO_NONE,
        SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=unavailable autolearn_force=no
        version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Add clock selection code for AST2600. At AST2600 user could
select more than one dispaly timing. Add gfx flags for future
usage.

Signed-off-by: Tommy Haung <tommy_huang@aspeedtech.com>
---
 drivers/gpu/drm/aspeed/aspeed_gfx.h      | 11 +++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c | 14 ++++++++++++++
 drivers/gpu/drm/aspeed/aspeed_gfx_drv.c  |  4 ++++
 3 files changed, 29 insertions(+)

diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx.h b/drivers/gpu/drm/aspeed/aspeed_gfx.h
index 4e6a442c3886..eb4c267cde5e 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx.h
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx.h
@@ -16,6 +16,7 @@ struct aspeed_gfx {
 	u32				vga_scratch_reg;
 	u32				throd_val;
 	u32				scan_line_max;
+	u32				flags;
 
 	struct drm_simple_display_pipe	pipe;
 	struct drm_connector		connector;
@@ -106,3 +107,13 @@ int aspeed_gfx_create_output(struct drm_device *drm);
 /* CRT_THROD */
 #define CRT_THROD_LOW(x)		(x)
 #define CRT_THROD_HIGH(x)		((x) << 8)
+
+/* SCU control */
+#define SCU_G6_CLK_COURCE		0x300
+
+/* GFX FLAGS */
+#define CLK_MASK			BIT(0)
+#define CLK_G6				BIT(0)
+
+#define G6_CLK_MASK			(BIT(8) | BIT(9) | BIT(10))
+#define G6_USB_40_CLK			BIT(9)
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
index 827e62c1daba..a24fab22eac4 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_crtc.c
@@ -77,6 +77,18 @@ static void aspeed_gfx_disable_controller(struct aspeed_gfx *priv)
 	regmap_update_bits(priv->scu, priv->dac_reg, BIT(16), 0);
 }
 
+static void aspeed_gfx_set_clk(struct aspeed_gfx *priv)
+{
+	switch (priv->flags & CLK_MASK) {
+	case CLK_G6:
+		regmap_update_bits(priv->scu, SCU_G6_CLK_COURCE, G6_CLK_MASK, 0x0);
+		regmap_update_bits(priv->scu, SCU_G6_CLK_COURCE, G6_CLK_MASK, G6_USB_40_CLK);
+		break;
+	default:
+		break;
+	}
+}
+
 static void aspeed_gfx_crtc_mode_set_nofb(struct aspeed_gfx *priv)
 {
 	struct drm_display_mode *m = &priv->pipe.crtc.state->adjusted_mode;
@@ -87,6 +99,8 @@ static void aspeed_gfx_crtc_mode_set_nofb(struct aspeed_gfx *priv)
 	if (err)
 		return;
 
+	aspeed_gfx_set_clk(priv);
+
 #if 0
 	/* TODO: we have only been able to test with the 40MHz USB clock. The
 	 * clock is fixed, so we cannot adjust it here. */
diff --git a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
index d10246b1d1c2..af56ffdccc65 100644
--- a/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
+++ b/drivers/gpu/drm/aspeed/aspeed_gfx_drv.c
@@ -64,6 +64,7 @@ struct aspeed_gfx_config {
 	u32 vga_scratch_reg;	/* VGA scratch register in SCU */
 	u32 throd_val;		/* Default Threshold Seting */
 	u32 scan_line_max;	/* Max memory size of one scan line */
+	u32 gfx_flags;	/* Flags for gfx chip caps */
 };
 
 static const struct aspeed_gfx_config ast2400_config = {
@@ -72,6 +73,7 @@ static const struct aspeed_gfx_config ast2400_config = {
 	.vga_scratch_reg = 0x50,
 	.throd_val = CRT_THROD_LOW(0x1e) | CRT_THROD_HIGH(0x12),
 	.scan_line_max = 64,
+	.gfx_flags = 0,
 };
 
 static const struct aspeed_gfx_config ast2500_config = {
@@ -80,6 +82,7 @@ static const struct aspeed_gfx_config ast2500_config = {
 	.vga_scratch_reg = 0x50,
 	.throd_val = CRT_THROD_LOW(0x24) | CRT_THROD_HIGH(0x3c),
 	.scan_line_max = 128,
+	.gfx_flags = 0,
 };
 
 static const struct aspeed_gfx_config ast2600_config = {
@@ -88,6 +91,7 @@ static const struct aspeed_gfx_config ast2600_config = {
 	.vga_scratch_reg = 0x50,
 	.throd_val = CRT_THROD_LOW(0x50) | CRT_THROD_HIGH(0x70),
 	.scan_line_max = 128,
+	.gfx_flags = CLK_G6,
 };
 
 static const struct of_device_id aspeed_gfx_match[] = {
-- 
2.17.1

