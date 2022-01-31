Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 71BF14A4F41
	for <lists+linux-kernel@lfdr.de>; Mon, 31 Jan 2022 20:15:52 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1359324AbiAaTPt (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 31 Jan 2022 14:15:49 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:46988 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S230501AbiAaTPq (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 31 Jan 2022 14:15:46 -0500
Received: from bhuna.collabora.co.uk (bhuna.collabora.co.uk [IPv6:2a00:1098:0:82:1000:25:2eeb:e3e3])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8C5DDC061714
        for <linux-kernel@vger.kernel.org>; Mon, 31 Jan 2022 11:15:45 -0800 (PST)
Received: from [127.0.0.1] (localhost [127.0.0.1])
        (Authenticated sender: detlev)
        with ESMTPSA id 72D6E1F43762
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/simple; d=collabora.com;
        s=mail; t=1643656544;
        bh=i6NoQVTbHUwZf0ykWHZ3AvGskHzTGTNtrPr+Ww5Wn0U=;
        h=From:To:Cc:Subject:Date:From;
        b=om+tgMrCX/R+n21Wps8deYGtCbx09zhvvOcAvwUyvgxKNiv8ckczPc+69wGtiKoVJ
         fLPVDx7C95Fvqbdx/2dInP72R0d0d9S5jNZNkuAH3jWocUpI1c2t7cz2OXqG6lR7mc
         3EUfGZinbLF7T/ZoUmYjhSK9EYSjl3N/0vNGX+m2NktCC7+p2R1t8YgWtAzrR8F3n7
         qGbmENxodSMq0ymJxiwn1dKNtSte0yXtXEPDsibGZr229yCT9YFLSvv++Za2hdiOOx
         WBbSFzaUDAcCeKw6+/3Y6HjyScghs6DdS1y6GWJpIM384u4qPCt/NHLCB4NFvCOHig
         6xz8O5++87hwQ==
From:   Detlev Casanova <detlev.casanova@collabora.com>
To:     linux-kernel@vger.kernel.org
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Dave Stevenson <dave.stevenson@raspberrypi.com>,
        Detlev Casanova <detlev.casanova@collabora.com>
Subject: [PATCH] drm/panel-simple: Add a timing for the Raspberry Pi 7" panel
Date:   Mon, 31 Jan 2022 14:15:17 -0500
Message-Id: <20220131191517.30249-1-detlev.casanova@collabora.com>
X-Mailer: git-send-email 2.35.0
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

From: Dave Stevenson <dave.stevenson@raspberrypi.com>

The Raspberry Pi 7" 800x480 panel uses a Toshiba TC358762 DSI
to DPI bridge chip, so there is a requirement for the timings
to be specified for the end panel. Add such a definition.

Signed-off-by: Dave Stevenson <dave.stevenson@raspberrypi.com>
Signed-off-by: Detlev Casanova <detlev.casanova@collabora.com>
---
 drivers/gpu/drm/panel/panel-simple.c | 28 ++++++++++++++++++++++++++++
 1 file changed, 28 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 0c8786ebffd1..c4696626b75d 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -3013,6 +3013,31 @@ static const struct panel_desc qishenglong_gopher2b_lcd = {
 	.connector_type = DRM_MODE_CONNECTOR_DPI,
 };
 
+static const struct drm_display_mode raspberrypi_7inch_mode = {
+	.clock = 25979400 / 1000,
+	.hdisplay = 800,
+	.hsync_start = 800 + 2,
+	.hsync_end = 800 + 2 + 2,
+	.htotal = 800 + 2 + 2 + 46,
+	.vdisplay = 480,
+	.vsync_start = 480 + 7,
+	.vsync_end = 480 + 7 + 2,
+	.vtotal = 480 + 7 + 2 + 21,
+	.flags = DRM_MODE_FLAG_NVSYNC | DRM_MODE_FLAG_NHSYNC,
+};
+
+static const struct panel_desc raspberrypi_7inch = {
+	.modes = &raspberrypi_7inch_mode,
+	.num_modes = 1,
+	.bpc = 8,
+	.size = {
+		.width = 154,
+		.height = 86,
+	},
+	.bus_format = MEDIA_BUS_FMT_RGB888_1X24,
+	.connector_type = DRM_MODE_CONNECTOR_DSI,
+};
+
 static const struct display_timing rocktech_rk070er9427_timing = {
 	.pixelclock = { 26400000, 33300000, 46800000 },
 	.hactive = { 800, 800, 800 },
@@ -3958,6 +3983,9 @@ static const struct of_device_id platform_of_match[] = {
 	}, {
 		.compatible = "qishenglong,gopher2b-lcd",
 		.data = &qishenglong_gopher2b_lcd,
+	}, {
+		.compatible = "raspberrypi,7inch-dsi",
+		.data = &raspberrypi_7inch,
 	}, {
 		.compatible = "rocktech,rk070er9427",
 		.data = &rocktech_rk070er9427,
-- 
2.35.0

