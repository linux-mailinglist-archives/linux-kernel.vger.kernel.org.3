Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 5A4354A4C6B
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:47:56 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1380612AbiAaQry (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:47:54 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:42233 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380600AbiAaQrx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:47:53 -0500
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 30D2F240008;
        Mon, 31 Jan 2022 16:47:41 +0000 (UTC)
From:   quentin.schulz@theobroma-systems.com
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Klaus Goger <klaus.goger@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>
Subject: [PATCH 2/3] drm/panel: ltk050h3146w: add support for Leadtek LTK050H3148W-CTA6 variant
Date:   Mon, 31 Jan 2022 17:47:22 +0100
Message-Id: <20220131164723.714836-2-quentin.schulz@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
In-Reply-To: <20220131164723.714836-1-quentin.schulz@theobroma-systems.com>
References: <20220131164723.714836-1-quentin.schulz@theobroma-systems.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Klaus Goger <klaus.goger@theobroma-systems.com>

The LTK050H3148W-CTA6 is a 5.0" 720x1280 DSI display, whose driving
controller is a Himax HX8394-F, slightly different from LTK050H3146W by
its init sequence, mode details and mode flags.

Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Klaus Goger <klaus.goger@theobroma-systems.com>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 .../drm/panel/panel-leadtek-ltk050h3146w.c    | 87 +++++++++++++++++++
 1 file changed, 87 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index 67eb474e28c6..3be815c3be68 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -253,6 +253,89 @@ struct ltk050h3146w *panel_to_ltk050h3146w(struct drm_panel *panel)
 			return ret;					\
 	} while (0)
 
+static int ltk050h3148w_init_sequence(struct ltk050h3146w *ctx)
+{
+	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
+	int ret;
+
+	/*
+	 * Init sequence was supplied by the panel vendor without much
+	 * documentation.
+	 */
+	dsi_dcs_write_seq(dsi, 0xb9, 0xff, 0x83, 0x94);
+	dsi_dcs_write_seq(dsi, 0xb1, 0x50, 0x15, 0x75, 0x09, 0x32, 0x44, 0x71,
+			  0x31, 0x55, 0x2f);
+	dsi_dcs_write_seq(dsi, 0xba, 0x63, 0x03, 0x68, 0x6b, 0xb2, 0xc0);
+	dsi_dcs_write_seq(dsi, 0xd2, 0x88);
+	dsi_dcs_write_seq(dsi, 0xb2, 0x00, 0x80, 0x64, 0x10, 0x07);
+	dsi_dcs_write_seq(dsi, 0xb4, 0x05, 0x70, 0x05, 0x70, 0x01, 0x70, 0x01,
+			  0x0c, 0x86, 0x75, 0x00, 0x3f, 0x01, 0x74, 0x01, 0x74,
+			  0x01, 0x74, 0x01, 0x0c, 0x86);
+	dsi_dcs_write_seq(dsi, 0xd3, 0x00, 0x00, 0x07, 0x07, 0x40, 0x1e, 0x08,
+			  0x00, 0x32, 0x10, 0x08, 0x00, 0x08, 0x54, 0x15, 0x10,
+			  0x05, 0x04, 0x02, 0x12, 0x10, 0x05, 0x07, 0x33, 0x34,
+			  0x0c, 0x0c, 0x37, 0x10, 0x07, 0x17, 0x11, 0x40);
+	dsi_dcs_write_seq(dsi, 0xd5, 0x19, 0x19, 0x18, 0x18, 0x1b, 0x1b, 0x1a,
+			  0x1a, 0x04, 0x05, 0x06, 0x07, 0x00, 0x01, 0x02, 0x03,
+			  0x20, 0x21, 0x18, 0x18, 0x22, 0x23, 0x18, 0x18, 0x18,
+			  0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			  0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			  0x18);
+	 dsi_dcs_write_seq(dsi, 0xd6, 0x18, 0x18, 0x19, 0x19, 0x1b, 0x1b, 0x1a,
+			   0x1a, 0x03, 0x02, 0x01, 0x00, 0x07, 0x06, 0x05, 0x04,
+			   0x23, 0x22, 0x18, 0x18, 0x21, 0x20, 0x18, 0x18, 0x18,
+			   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			   0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18, 0x18,
+			   0x18);
+	dsi_dcs_write_seq(dsi, 0xe0, 0x00, 0x03, 0x09, 0x11, 0x11, 0x14, 0x18,
+			  0x16, 0x2e, 0x3d, 0x4d, 0x4d, 0x58, 0x6c, 0x72, 0x78,
+			  0x88, 0x8b, 0x86, 0xa4, 0xb2, 0x58, 0x55, 0x59, 0x5b,
+			  0x5d, 0x60, 0x64, 0x7f, 0x00, 0x03, 0x09, 0x0f, 0x11,
+			  0x14, 0x18, 0x16, 0x2e, 0x3d, 0x4d, 0x4d, 0x58, 0x6d,
+			  0x73, 0x78, 0x88, 0x8b, 0x87, 0xa5, 0xb2, 0x58, 0x55,
+			  0x58, 0x5b, 0x5d, 0x61, 0x65, 0x7f);
+	dsi_dcs_write_seq(dsi, 0xcc, 0x0b);
+	dsi_dcs_write_seq(dsi, 0xc0, 0x1f, 0x31);
+	dsi_dcs_write_seq(dsi, 0xb6, 0xc4, 0xc4);
+	dsi_dcs_write_seq(dsi, 0xbd, 0x01);
+	dsi_dcs_write_seq(dsi, 0xb1, 0x00);
+	dsi_dcs_write_seq(dsi, 0xbd, 0x00);
+	dsi_dcs_write_seq(dsi, 0xc6, 0xef);
+	dsi_dcs_write_seq(dsi, 0xd4, 0x02);
+	dsi_dcs_write_seq(dsi, 0x11);
+	dsi_dcs_write_seq(dsi, 0x29);
+
+	ret = mipi_dsi_dcs_set_tear_on(dsi, 1);
+	if (ret < 0) {
+		dev_err(ctx->dev, "failed to set tear on: %d\n", ret);
+		return ret;
+	}
+
+	msleep(60);
+
+	return 0;
+}
+
+static const struct drm_display_mode ltk050h3148w_mode = {
+	.hdisplay	= 720,
+	.hsync_start	= 720 + 12,
+	.hsync_end	= 720 + 12 + 6,
+	.htotal		= 720 + 12 + 6 + 24,
+	.vdisplay	= 1280,
+	.vsync_start	= 1280 + 9,
+	.vsync_end	= 1280 + 9 + 2,
+	.vtotal		= 1280 + 9 + 2 + 16,
+	.clock		= 59756,
+	.width_mm	= 62,
+	.height_mm	= 110,
+};
+
+static const struct ltk050h3146w_desc ltk050h3148w_data = {
+	.mode = &ltk050h3148w_mode,
+	.init = ltk050h3148w_init_sequence,
+	.mode_flags = MIPI_DSI_MODE_VIDEO_SYNC_PULSE,
+};
+
 static int ltk050h3146w_init_sequence(struct ltk050h3146w *ctx)
 {
 	struct mipi_dsi_device *dsi = to_mipi_dsi_device(ctx->dev);
@@ -657,6 +740,10 @@ static const struct of_device_id ltk050h3146w_of_match[] = {
 		.compatible = "leadtek,ltk050h3146w-a2",
 		.data = &ltk050h3146w_a2_data,
 	},
+	{
+		.compatible = "leadtek,ltk050h3148w",
+		.data = &ltk050h3148w_data,
+	},
 	{ /* sentinel */ }
 };
 MODULE_DEVICE_TABLE(of, ltk050h3146w_of_match);
-- 
2.34.1

