Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 33D49583702
	for <lists+linux-kernel@lfdr.de>; Thu, 28 Jul 2022 04:37:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S237709AbiG1ChQ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 27 Jul 2022 22:37:16 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:35950 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S237484AbiG1ChO (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 27 Jul 2022 22:37:14 -0400
Received: from mail-pl1-x635.google.com (mail-pl1-x635.google.com [IPv6:2607:f8b0:4864:20::635])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 6E0345A882;
        Wed, 27 Jul 2022 19:37:13 -0700 (PDT)
Received: by mail-pl1-x635.google.com with SMTP id o3so608291ple.5;
        Wed, 27 Jul 2022 19:37:13 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=WWJy9+afMOxe1MZB5oRxnjQxTPoeievVL1sbDLfuPV0=;
        b=pOyAFXu90jk0bpAM11JpbkyEMZRdu4xkF3iG3n3RgH6DlEK1ZHAMOlpBrC1NYkOmtb
         gPzCNnYF3FsfP5OEDz8QtTXQHtZLwvz+Q2eTbRk/4rf43dtlZQb8CSEt9xvkbArju3Nw
         OmGxlUwkYhTSKL26skNxHa7o6B8MEWDRIroKv1xdRldGogI6wrOPm2FaN76wp9Ig8g6t
         p8EGUCfuXXs0VNNWZsjtUTlbmcZik6bvdEcMJpnqU4AObOmALxQYuWUo8iBxrBJAY0bC
         BIaNSfUbMFa8T62UrlphdL8NIruYVJz2w6lmaaF3XRbQvuaifkUU0deAFbuacrJUPDsr
         dGQA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=WWJy9+afMOxe1MZB5oRxnjQxTPoeievVL1sbDLfuPV0=;
        b=fwjAPXeNRJU8Te5BGijkcXSe0FFgJm7LG6N4YyY/mpK3wJ/DofQo1yAU+/oGHZRx/D
         vAGc00wSMK6Sp5itwOFCJoSNOvs5Z7vYSR51as/YFbTWkrosZTrwwcddDsV07vtoQ8vo
         MwJMU28JIFJtoOpwCO7M4yw1uqul3IqAHY+w/QpGz/+VZs1K79bFY/453zJxJuuJUEZE
         PQto9FzzNdKZbQtVTbdvL+kKylPUdpsYzfjPFOIgWpJVxVFhRcVKMDSPObuuPVdBud2d
         9XvWEKEqmtIRlVw4EgyaRYYzYqIaydTePHMykAHg/hkWXIzCjTSD1DfwzrPi2Lr8N5Ps
         7T+g==
X-Gm-Message-State: AJIora84WSs0WFYjqRymSy5iUN/yP1fzVVECYHl/jkVZ7SC9LfkYZu5o
        E7HO1Y7MpzRoACQznBJ4wmA=
X-Google-Smtp-Source: AGRyM1s1A0Ig2mi+uzk2O/Nf9rPZWHq0oqbFeIXqxKPdxWEdLdSMLMF5Zhda4ntChv6oCY7m+Toj/g==
X-Received: by 2002:a17:90b:1c0a:b0:1f3:1848:591c with SMTP id oc10-20020a17090b1c0a00b001f31848591cmr3021484pjb.24.1658975832739;
        Wed, 27 Jul 2022 19:37:12 -0700 (PDT)
Received: from localhost.localdomain ([112.0.190.165])
        by smtp.gmail.com with ESMTPSA id v12-20020aa799cc000000b00528c149fe97sm14631311pfi.89.2022.07.27.19.37.04
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 27 Jul 2022 19:37:12 -0700 (PDT)
From:   Molly Sophia <mollysophia379@gmail.com>
To:     Sumit Semwal <sumit.semwal@linaro.org>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Rob Herring <robh+dt@kernel.org>,
        Krzysztof Kozlowski <krzysztof.kozlowski+dt@linaro.org>,
        dri-devel@lists.freedesktop.org, devicetree@vger.kernel.org,
        linux-kernel@vger.kernel.org
Cc:     ~postmarketos/upstreaming@lists.sr.ht, phone-devel@vger.kernel.org,
        Molly Sophia <mollysophia379@gmail.com>
Subject: [PATCH v4 2/2] drm: panel: Add novatek nt35596s panel driver
Date:   Thu, 28 Jul 2022 10:35:55 +0800
Message-Id: <20220728023555.8952-3-mollysophia379@gmail.com>
X-Mailer: git-send-email 2.37.1
In-Reply-To: <20220728023555.8952-1-mollysophia379@gmail.com>
References: <20220728023555.8952-1-mollysophia379@gmail.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-1.8 required=5.0 tests=BAYES_00,DKIM_SIGNED,
        DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,FREEMAIL_ENVFROM_END_DIGIT,
        FREEMAIL_FROM,RCVD_IN_DNSWL_NONE,SPF_HELO_NONE,SPF_PASS autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

Novatek NT35596s is a generic DSI IC that drives command and video mode
panels. Add the driver for it. Currently add support for the LCD panel
from JDI connected with this IC, as found on Xiaomi Mi Mix2s phones.

Changes in v4:
- No change.

Changes in v3:
- Embed the support into existing driver (panel-novatek-nt36672a), as
  these two IC are similar with different initialization commands.

Signed-off-by: Molly Sophia <mollysophia379@gmail.com>
---
 drivers/gpu/drm/panel/Kconfig                 |   7 +-
 .../gpu/drm/panel/panel-novatek-nt36672a.c    | 246 ++++++++++++++++--
 2 files changed, 234 insertions(+), 19 deletions(-)

diff --git a/drivers/gpu/drm/panel/Kconfig b/drivers/gpu/drm/panel/Kconfig
index 38799effd00a..ecc1b9aa6a1c 100644
--- a/drivers/gpu/drm/panel/Kconfig
+++ b/drivers/gpu/drm/panel/Kconfig
@@ -328,14 +328,15 @@ config DRM_PANEL_NOVATEK_NT35950
 	  mobile phones.
 
 config DRM_PANEL_NOVATEK_NT36672A
-	tristate "Novatek NT36672A DSI panel"
+	tristate "Novatek NT36672A/NT35596S DSI panel"
 	depends on OF
 	depends on DRM_MIPI_DSI
 	depends on BACKLIGHT_CLASS_DEVICE
 	help
 	  Say Y here if you want to enable support for the panels built
-	  around the Novatek NT36672A display controller, such as some
-	  Tianma panels used in a few Xiaomi Poco F1 mobile phones.
+	  around the Novatek NT36672A or NT35596S display controller, such
+	  as some Tianma panels used in a few Xiaomi Poco F1 mobile phones
+	  or the JDI panels used in Xiaomi Mi Mix2S mobile phones.
 
 config DRM_PANEL_NOVATEK_NT39016
 	tristate "Novatek NT39016 RGB/SPI panel"
diff --git a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
index 231f371901e8..fcdde538d847 100644
--- a/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
+++ b/drivers/gpu/drm/panel/panel-novatek-nt36672a.c
@@ -3,13 +3,15 @@
  * Copyright (C) 2020 Linaro Ltd
  * Author: Sumit Semwal <sumit.semwal@linaro.org>
  *
- * This driver is for the DSI interface to panels using the NT36672A display driver IC
+ * Copyright (C) 2022 Molly Sophia <mollysophia379@gmail.com>
+ *
+ * This driver is for the DSI interface to panels using the NT36672A/NT35596S display driver IC
  * from Novatek.
  * Currently supported are the Tianma FHD+ panels found in some Xiaomi phones, including
- * some variants of the Poco F1 phone.
+ * some variants of the Poco F1 phone, and the JDI FHD+ panels found in Xiaomi Mi Mix2S phones.
  *
- * Panels using the Novatek NT37762A IC should add appropriate configuration per-panel and
- * use this driver.
+ * Panels using the Novatek NT37762A or NT35596S IC should add appropriate configuration
+ * per-panel and use this driver.
  */
 
 #include <linux/delay.h>
@@ -123,12 +125,14 @@ static int nt36672a_panel_unprepare(struct drm_panel *panel)
 	if (!pinfo->prepared)
 		return 0;
 
-	/* send off cmds */
-	ret = nt36672a_send_cmds(panel, pinfo->desc->off_cmds,
-				 pinfo->desc->num_off_cmds);
+	if (pinfo->desc->num_off_cmds != 0) {
+		/* send off cmds if present */
+		ret = nt36672a_send_cmds(panel, pinfo->desc->off_cmds,
+					pinfo->desc->num_off_cmds);
 
-	if (ret < 0)
-		dev_err(panel->dev, "failed to send DCS off cmds: %d\n", ret);
+		if (ret < 0)
+			dev_err(panel->dev, "failed to send DCS off cmds: %d\n", ret);
+	}
 
 	ret = mipi_dsi_dcs_set_display_off(pinfo->link);
 	if (ret < 0)
@@ -211,13 +215,15 @@ static int nt36672a_panel_prepare(struct drm_panel *panel)
 		goto poweroff;
 	}
 
-	/* Send rest of the init cmds */
-	err = nt36672a_send_cmds(panel, pinfo->desc->on_cmds_2,
-				 pinfo->desc->num_on_cmds_2);
+	if (pinfo->desc->num_on_cmds_2 != 0) {
+		/* Send rest of the init cmds if present */
+		err = nt36672a_send_cmds(panel, pinfo->desc->on_cmds_2,
+					pinfo->desc->num_on_cmds_2);
 
-	if (err < 0) {
-		dev_err(panel->dev, "failed to send DCS Init 2nd Code: %d\n", err);
-		goto poweroff;
+		if (err < 0) {
+			dev_err(panel->dev, "failed to send DCS Init 2nd Code: %d\n", err);
+			goto poweroff;
+		}
 	}
 
 	msleep(120);
@@ -601,6 +607,212 @@ static const struct nt36672a_panel_desc tianma_fhd_video_panel_desc = {
 	.num_off_cmds = ARRAY_SIZE(tianma_fhd_video_off_cmds),
 };
 
+static const struct nt36672a_panel_cmd jdi_nt35596s_video_on_cmds[] = {
+	{ .data = { 0xff, 0x24 } },
+	{ .data = { 0x9d, 0x34 } },
+	{ .data = { 0xfb, 0x01 } },
+	{ .data = { 0xc4, 0x25 } },
+	{ .data = { 0xd1, 0x08 } },
+	{ .data = { 0xd2, 0x84 } },
+	{ .data = { 0xff, 0x26 } },
+	{ .data = { 0xfb, 0x01 } },
+	{ .data = { 0x03, 0x1c } },
+	{ .data = { 0x3b, 0x08 } },
+	{ .data = { 0x6b, 0x08 } },
+	{ .data = { 0x97, 0x08 } },
+	{ .data = { 0xc5, 0x08 } },
+	{ .data = { 0xfb, 0x01 } },
+	{ .data = { 0xff, 0x23 } },
+	{ .data = { 0xfb, 0x01 } },
+	{ .data = { 0x01, 0x84 } },
+	{ .data = { 0x05, 0x2d } },
+	{ .data = { 0x06, 0x00 } },
+	{ .data = { 0x33, 0x07 } },
+	{ .data = { 0x21, 0xee } },
+	{ .data = { 0x22, 0xed } },
+	{ .data = { 0x23, 0xea } },
+	{ .data = { 0x24, 0xe8 } },
+	{ .data = { 0x25, 0xe5 } },
+	{ .data = { 0x26, 0xe2 } },
+	{ .data = { 0x27, 0xde } },
+	{ .data = { 0x28, 0xbb } },
+	{ .data = { 0x29, 0x87 } },
+	{ .data = { 0x2a, 0x77 } },
+	{ .data = { 0x32, 0x0c } },
+	{ .data = { 0x13, 0x3f } },
+	{ .data = { 0x14, 0x34 } },
+	{ .data = { 0x15, 0x2a } },
+	{ .data = { 0x16, 0x25 } },
+	{ .data = { 0x17, 0x9d } },
+	{ .data = { 0x18, 0x9a } },
+	{ .data = { 0x19, 0x97 } },
+	{ .data = { 0x1a, 0x94 } },
+	{ .data = { 0x1b, 0x91 } },
+	{ .data = { 0x1c, 0x8e } },
+	{ .data = { 0x1d, 0x8b } },
+	{ .data = { 0x1e, 0x89 } },
+	{ .data = { 0x1f, 0x86 } },
+	{ .data = { 0x20, 0x83 } },
+	{ .data = { 0xff, 0x22 } },
+	{ .data = { 0x00, 0x0a } },
+	{ .data = { 0x01, 0x43 } },
+	{ .data = { 0x02, 0x5b } },
+	{ .data = { 0x03, 0x6a } },
+	{ .data = { 0x04, 0x7a } },
+	{ .data = { 0x05, 0x82 } },
+	{ .data = { 0x06, 0x85 } },
+	{ .data = { 0x07, 0x80 } },
+	{ .data = { 0x08, 0x7c } },
+	{ .data = { 0x09, 0x7c } },
+	{ .data = { 0x0a, 0x74 } },
+	{ .data = { 0x0b, 0x71 } },
+	{ .data = { 0x0c, 0x6e } },
+	{ .data = { 0x0d, 0x68 } },
+	{ .data = { 0x0e, 0x65 } },
+	{ .data = { 0x0f, 0x5c } },
+	{ .data = { 0x10, 0x32 } },
+	{ .data = { 0x11, 0x18 } },
+	{ .data = { 0x12, 0x00 } },
+	{ .data = { 0x13, 0x00 } },
+	{ .data = { 0x1a, 0x00 } },
+	{ .data = { 0x1b, 0x00 } },
+	{ .data = { 0x1c, 0x00 } },
+	{ .data = { 0x1d, 0x00 } },
+	{ .data = { 0x1e, 0x00 } },
+	{ .data = { 0x1f, 0x00 } },
+	{ .data = { 0x20, 0x00 } },
+	{ .data = { 0x21, 0x00 } },
+	{ .data = { 0x22, 0x00 } },
+	{ .data = { 0x23, 0x00 } },
+	{ .data = { 0x24, 0x00 } },
+	{ .data = { 0x25, 0x00 } },
+	{ .data = { 0x26, 0x00 } },
+	{ .data = { 0x27, 0x00 } },
+	{ .data = { 0x28, 0x00 } },
+	{ .data = { 0x29, 0x00 } },
+	{ .data = { 0x2a, 0x00 } },
+	{ .data = { 0x2b, 0x00 } },
+	{ .data = { 0x2f, 0x00 } },
+	{ .data = { 0x30, 0x00 } },
+	{ .data = { 0x31, 0x00 } },
+	{ .data = { 0x32, 0x0c } },
+	{ .data = { 0x33, 0x0c } },
+	{ .data = { 0x34, 0x0c } },
+	{ .data = { 0x35, 0x0b } },
+	{ .data = { 0x36, 0x09 } },
+	{ .data = { 0x37, 0x09 } },
+	{ .data = { 0x38, 0x08 } },
+	{ .data = { 0x39, 0x05 } },
+	{ .data = { 0x3a, 0x03 } },
+	{ .data = { 0x3b, 0x00 } },
+	{ .data = { 0x3f, 0x00 } },
+	{ .data = { 0x40, 0x00 } },
+	{ .data = { 0x41, 0x00 } },
+	{ .data = { 0x42, 0x00 } },
+	{ .data = { 0x43, 0x00 } },
+	{ .data = { 0x44, 0x00 } },
+	{ .data = { 0x45, 0x00 } },
+	{ .data = { 0x46, 0x00 } },
+	{ .data = { 0x47, 0x00 } },
+	{ .data = { 0x48, 0x00 } },
+	{ .data = { 0x49, 0x03 } },
+	{ .data = { 0x4a, 0x06 } },
+	{ .data = { 0x4b, 0x07 } },
+	{ .data = { 0x4c, 0x07 } },
+	{ .data = { 0x53, 0x01 } },
+	{ .data = { 0x54, 0x01 } },
+	{ .data = { 0x55, 0x89 } },
+	{ .data = { 0x56, 0x00 } },
+	{ .data = { 0x58, 0x00 } },
+	{ .data = { 0x68, 0x00 } },
+	{ .data = { 0x84, 0xff } },
+	{ .data = { 0x85, 0xff } },
+	{ .data = { 0x86, 0x03 } },
+	{ .data = { 0x87, 0x00 } },
+	{ .data = { 0x88, 0x00 } },
+	{ .data = { 0xa2, 0x20 } },
+	{ .data = { 0xa9, 0x01 } },
+	{ .data = { 0xaa, 0x12 } },
+	{ .data = { 0xab, 0x13 } },
+	{ .data = { 0xac, 0x0a } },
+	{ .data = { 0xad, 0x74 } },
+	{ .data = { 0xaf, 0x33 } },
+	{ .data = { 0xb0, 0x03 } },
+	{ .data = { 0xb1, 0x14 } },
+	{ .data = { 0xb2, 0x42 } },
+	{ .data = { 0xb3, 0x40 } },
+	{ .data = { 0xb4, 0xa5 } },
+	{ .data = { 0xb6, 0x44 } },
+	{ .data = { 0xb7, 0x04 } },
+	{ .data = { 0xb8, 0x14 } },
+	{ .data = { 0xb9, 0x42 } },
+	{ .data = { 0xba, 0x40 } },
+	{ .data = { 0xbb, 0xa5 } },
+	{ .data = { 0xbd, 0x44 } },
+	{ .data = { 0xbe, 0x04 } },
+	{ .data = { 0xbf, 0x00 } },
+	{ .data = { 0xc0, 0x75 } },
+	{ .data = { 0xc1, 0x6a } },
+	{ .data = { 0xc2, 0xa5 } },
+	{ .data = { 0xc4, 0x22 } },
+	{ .data = { 0xc5, 0x02 } },
+	{ .data = { 0xc6, 0x00 } },
+	{ .data = { 0xc7, 0x95 } },
+	{ .data = { 0xc8, 0x8a } },
+	{ .data = { 0xc9, 0xa5 } },
+	{ .data = { 0xcb, 0x22 } },
+	{ .data = { 0xcc, 0x02 } },
+	{ .data = { 0xcd, 0x00 } },
+	{ .data = { 0xce, 0xb5 } },
+	{ .data = { 0xcf, 0xaa } },
+	{ .data = { 0xd0, 0xa5 } },
+	{ .data = { 0xd2, 0x22 } },
+	{ .data = { 0xd3, 0x02 } },
+	{ .data = { 0xfb, 0x01 } },
+	{ .data = { 0xff, 0x10 } },
+	{ .data = { 0x26, 0x02 } },
+	{ .data = { 0x35, 0x00 } },
+	{ .data = { 0x51, 0xff } },
+	{ .data = { 0x53, 0x24 } },
+	{ .data = { 0x55, 0x00 } },
+	{ .data = { 0xb0, 0x00 } },
+};
+
+static const struct drm_display_mode jdi_nt35596s_video_panel_mode = {
+	.clock = (1080 + 16 + 28 + 40) * (2160 + 7 + 4 + 24) * 60 / 1000,
+
+	.hdisplay = 1080,
+	.hsync_start = 1080 + 16,
+	.hsync_end = 1080 + 16 + 28,
+	.htotal = 1080 + 16 + 28 + 40,
+
+	.vdisplay = 2160,
+	.vsync_start = 2160 + 7,
+	.vsync_end = 2160 + 7 + 4,
+	.vtotal = 2160 + 7 + 4 + 24,
+
+	.type = DRM_MODE_TYPE_DRIVER | DRM_MODE_TYPE_PREFERRED,
+};
+
+static const struct nt36672a_panel_desc jdi_nt35596s_video_panel_desc = {
+	.display_mode = &jdi_nt35596s_video_panel_mode,
+
+	.width_mm = 68,
+	.height_mm = 136,
+
+	.mode_flags = MIPI_DSI_MODE_LPM | MIPI_DSI_MODE_VIDEO |
+		      MIPI_DSI_MODE_VIDEO_HSE | MIPI_DSI_CLOCK_NON_CONTINUOUS |
+		      MIPI_DSI_MODE_VIDEO_BURST,
+	.format = MIPI_DSI_FMT_RGB888,
+	.lanes = 4,
+	.on_cmds_1 = jdi_nt35596s_video_on_cmds,
+	.num_on_cmds_1 = ARRAY_SIZE(jdi_nt35596s_video_on_cmds),
+	.on_cmds_2 = NULL,
+	.num_on_cmds_2 = 0,
+	.off_cmds = NULL,
+	.num_off_cmds = 0,
+};
+
 static int nt36672a_panel_add(struct nt36672a_panel *pinfo)
 {
 	struct device *dev = &pinfo->link->dev;
@@ -697,6 +909,7 @@ static void nt36672a_panel_shutdown(struct mipi_dsi_device *dsi)
 
 static const struct of_device_id tianma_fhd_video_of_match[] = {
 	{ .compatible = "tianma,fhd-video", .data = &tianma_fhd_video_panel_desc },
+	{ .compatible = "jdi,fhd-nt35596s", .data = &jdi_nt35596s_video_panel_desc },
 	{ },
 };
 MODULE_DEVICE_TABLE(of, tianma_fhd_video_of_match);
@@ -713,5 +926,6 @@ static struct mipi_dsi_driver nt36672a_panel_driver = {
 module_mipi_dsi_driver(nt36672a_panel_driver);
 
 MODULE_AUTHOR("Sumit Semwal <sumit.semwal@linaro.org>");
-MODULE_DESCRIPTION("NOVATEK NT36672A based MIPI-DSI LCD panel driver");
+MODULE_AUTHOR("Molly Sophia <mollysophia379@gmail.com>");
+MODULE_DESCRIPTION("NOVATEK NT36672A/NT35596S based MIPI-DSI LCD panel driver");
 MODULE_LICENSE("GPL");
-- 
2.37.1

