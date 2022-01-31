Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 64D754A4C65
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 17:47:48 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1379421AbiAaQro (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 11:47:44 -0500
Received: from relay10.mail.gandi.net ([217.70.178.230]:34483 "EHLO
        relay10.mail.gandi.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1380592AbiAaQrn (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 11:47:43 -0500
Received: (Authenticated sender: foss@0leil.net)
        by mail.gandi.net (Postfix) with ESMTPSA id 734F6240003;
        Mon, 31 Jan 2022 16:47:38 +0000 (UTC)
From:   quentin.schulz@theobroma-systems.com
Cc:     thierry.reding@gmail.com, sam@ravnborg.org, airlied@linux.ie,
        daniel@ffwll.ch, robh+dt@kernel.org,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org,
        Quentin Schulz <quentin.schulz@theobroma-systems.com>,
        Quentin Schulz <foss+kernel@0leil.net>
Subject: [PATCH 1/3] drm/panel: ltk050h3146w: add mipi_dsi_device.mode_flags to of_match_data
Date:   Mon, 31 Jan 2022 17:47:21 +0100
Message-Id: <20220131164723.714836-1-quentin.schulz@theobroma-systems.com>
X-Mailer: git-send-email 2.34.1
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
To:     unlisted-recipients:; (no To-header on input)
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Quentin Schulz <quentin.schulz@theobroma-systems.com>

To prepare for a new display to be supported by this driver which has a
slightly different set of DSI mode related flags, let's move the
currently hardcoded mode flags to the .data field of of_device_id
structure.

Cc: Quentin Schulz <foss+kernel@0leil.net>
Signed-off-by: Quentin Schulz <quentin.schulz@theobroma-systems.com>
---
 drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c | 8 ++++++--
 1 file changed, 6 insertions(+), 2 deletions(-)

diff --git a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
index a5a414920430..67eb474e28c6 100644
--- a/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
+++ b/drivers/gpu/drm/panel/panel-leadtek-ltk050h3146w.c
@@ -25,6 +25,7 @@ struct ltk050h3146w_cmd {
 
 struct ltk050h3146w;
 struct ltk050h3146w_desc {
+	const unsigned long mode_flags;
 	const struct drm_display_mode *mode;
 	int (*init)(struct ltk050h3146w *ctx);
 };
@@ -339,6 +340,8 @@ static const struct drm_display_mode ltk050h3146w_mode = {
 static const struct ltk050h3146w_desc ltk050h3146w_data = {
 	.mode = &ltk050h3146w_mode,
 	.init = ltk050h3146w_init_sequence,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+		MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET,
 };
 
 static int ltk050h3146w_a2_select_page(struct ltk050h3146w *ctx, int page)
@@ -433,6 +436,8 @@ static const struct drm_display_mode ltk050h3146w_a2_mode = {
 static const struct ltk050h3146w_desc ltk050h3146w_a2_data = {
 	.mode = &ltk050h3146w_a2_mode,
 	.init = ltk050h3146w_a2_init_sequence,
+	.mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
+		MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET,
 };
 
 static int ltk050h3146w_unprepare(struct drm_panel *panel)
@@ -592,8 +597,7 @@ static int ltk050h3146w_probe(struct mipi_dsi_device *dsi)
 
 	dsi->lanes = 4;
 	dsi->format = MIPI_DSI_FMT_RGB888;
-	dsi->mode_flags = MIPI_DSI_MODE_VIDEO | MIPI_DSI_MODE_VIDEO_BURST |
-			  MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_NO_EOT_PACKET;
+	dsi->mode_flags = ctx->panel_desc->mode_flags;
 
 	drm_panel_init(&ctx->panel, &dsi->dev, &ltk050h3146w_funcs,
 		       DRM_MODE_CONNECTOR_DSI);
-- 
2.34.1

