Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from vger.kernel.org (vger.kernel.org [23.128.96.18])
	by mail.lfdr.de (Postfix) with ESMTP id 1E969493A8F
	for <lists+linux-kernel@lfdr.de>; Wed, 19 Jan 2022 13:37:46 +0100 (CET)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1354472AbiASMhZ (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 19 Jan 2022 07:37:25 -0500
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:47562 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1354710AbiASMhD (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 19 Jan 2022 07:37:03 -0500
Received: from mail-wm1-x330.google.com (mail-wm1-x330.google.com [IPv6:2a00:1450:4864:20::330])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id C65EFC061772
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:37:02 -0800 (PST)
Received: by mail-wm1-x330.google.com with SMTP id az27-20020a05600c601b00b0034d2956eb04so5643280wmb.5
        for <linux-kernel@vger.kernel.org>; Wed, 19 Jan 2022 04:37:02 -0800 (PST)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=baylibre-com.20210112.gappssmtp.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=FtbatZGWzmTr6DnUVWu1NqWNgW9rriYHmmB6wzthA20=;
        b=JWxcBFQmrMmIDILvkvK/SS+Im4XPo9L8Pl9DcWHi+Ri46hejUeOEpiLOVw05+gb7qk
         dHg2xvMjH0rRfpwkkEegTwwO6uZfcwrnLaM4ZAe/YoI77sWKGk6KrWehxJVSj66e37V9
         WCjrol0IzevLXB/WO3ynOjoIc5dynwkqs9Vu0k+5SyLJMMznOGJY5VHcqGR036cMGgSr
         Sm8mLoB00qBO6YXXawH7vCdi5AEYtTrIEE3Y9m3+FMSSvcIgeh/lA27bFy8M07LcBeyN
         sLvnHrTNXpf7mcWFczWIou7JbnHEKJyYlfp2Bc21zNoieIcHpKqu+bBE1592XrxWLerz
         8fxg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=FtbatZGWzmTr6DnUVWu1NqWNgW9rriYHmmB6wzthA20=;
        b=WX5hf6uzV/jWywe0zkd/w1R9AYd08hFfAXBjaSkqFxrSkG4KPVO5a3e4+j2S6oRtAN
         8mvBXKO1BYFp9dHGXnGaOD6nVD6ImVq/CQgV4C/xFxYCMjlsB0nFcit1NZ+yrkk0vV3b
         v7h+SMi677vv45y6vXyo34dGZN6y0sOWBUFX5UB/nVYpfPaehA3BkGMMPjXxhUzqI89Z
         DN6y0hqcmRW/Laoc8OBpeibBgVvGrbSDXkd3XTav/4rdmCsOshD4iuxm1+ejdGTQViKD
         gdnb/dw8mUGeWAtbFEurRa9K7aneowZ4/yS1l+Ox1V3A4q2uO2BkSmBltA6tycnNPU3m
         CbZQ==
X-Gm-Message-State: AOAM53094vRM7JiB7b8g6+xKjTmFUCcggqSNyy+l4asHHcWqtQLN7KGj
        Wkq5yN8L1W3Q2BFwQqJxMEve/w==
X-Google-Smtp-Source: ABdhPJxGHOe4mirdaI0EnQU54OW7tOqwZqmf5efIF3TQMf5fjYwGXAICSWDLcUt1DvJKIdU68iVj5g==
X-Received: by 2002:a05:6000:10c1:: with SMTP id b1mr28467840wrx.226.1642595821323;
        Wed, 19 Jan 2022 04:37:01 -0800 (PST)
Received: from localhost.localdomain ([2001:861:44c0:66c0:d394:97d0:bc02:3846])
        by smtp.gmail.com with ESMTPSA id bh13sm2610327wmb.33.2022.01.19.04.37.00
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 19 Jan 2022 04:37:00 -0800 (PST)
From:   Neil Armstrong <narmstrong@baylibre.com>
To:     robert.foss@linaro.org
Cc:     Laurent.pinchart@ideasonboard.com, jonas@kwiboo.se,
        jernej.skrabec@gmail.com, dri-devel@lists.freedesktop.org,
        linux-kernel@vger.kernel.org,
        Neil Armstrong <narmstrong@baylibre.com>
Subject: [PATCH 2/2] drm/bridge: dw-hdmi: filter out YUV output formats when DVI
Date:   Wed, 19 Jan 2022 13:36:56 +0100
Message-Id: <20220119123656.1456355-2-narmstrong@baylibre.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220119123656.1456355-1-narmstrong@baylibre.com>
References: <20220119123656.1456355-1-narmstrong@baylibre.com>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

When the display is not an HDMI sink, only the RGB output format is
valid. Thus stop returning YUV output formats when sink is not HDMI.

Fixes: 6c3c719936da ("drm/bridge: synopsys: dw-hdmi: add bus format negociation")
Signed-off-by: Neil Armstrong <narmstrong@baylibre.com>
---
 drivers/gpu/drm/bridge/synopsys/dw-hdmi.c | 17 +++++++++--------
 1 file changed, 9 insertions(+), 8 deletions(-)

diff --git a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
index 56021f20d396..03057d335158 100644
--- a/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
+++ b/drivers/gpu/drm/bridge/synopsys/dw-hdmi.c
@@ -2538,6 +2538,7 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 	struct drm_connector *conn = conn_state->connector;
 	struct drm_display_info *info = &conn->display_info;
 	struct drm_display_mode *mode = &crtc_state->mode;
+	struct dw_hdmi *hdmi = bridge->driver_private;
 	u8 max_bpc = conn_state->max_requested_bpc;
 	bool is_hdmi2_sink = info->hdmi.scdc.supported ||
 			     (info->color_formats & DRM_COLOR_FORMAT_YCRCB420);
@@ -2564,7 +2565,7 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 	 * If the current mode enforces 4:2:0, force the output but format
 	 * to 4:2:0 and do not add the YUV422/444/RGB formats
 	 */
-	if (conn->ycbcr_420_allowed &&
+	if (hdmi->sink_is_hdmi && conn->ycbcr_420_allowed &&
 	    (drm_mode_is_420_only(info, mode) ||
 	     (is_hdmi2_sink && drm_mode_is_420_also(info, mode)))) {
 
@@ -2595,36 +2596,36 @@ static u32 *dw_hdmi_bridge_atomic_get_output_bus_fmts(struct drm_bridge *bridge,
 	 */
 
 	if (max_bpc >= 16 && info->bpc == 16) {
-		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+		if (hdmi->sink_is_hdmi && info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
 			output_fmts[i++] = MEDIA_BUS_FMT_YUV16_1X48;
 
 		output_fmts[i++] = MEDIA_BUS_FMT_RGB161616_1X48;
 	}
 
 	if (max_bpc >= 12 && info->bpc >= 12) {
-		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+		if (hdmi->sink_is_hdmi && info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
 			output_fmts[i++] = MEDIA_BUS_FMT_UYVY12_1X24;
 
-		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+		if (hdmi->sink_is_hdmi && info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
 			output_fmts[i++] = MEDIA_BUS_FMT_YUV12_1X36;
 
 		output_fmts[i++] = MEDIA_BUS_FMT_RGB121212_1X36;
 	}
 
 	if (max_bpc >= 10 && info->bpc >= 10) {
-		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+		if (hdmi->sink_is_hdmi && info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
 			output_fmts[i++] = MEDIA_BUS_FMT_UYVY10_1X20;
 
-		if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+		if (hdmi->sink_is_hdmi && info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
 			output_fmts[i++] = MEDIA_BUS_FMT_YUV10_1X30;
 
 		output_fmts[i++] = MEDIA_BUS_FMT_RGB101010_1X30;
 	}
 
-	if (info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
+	if (hdmi->sink_is_hdmi && info->color_formats & DRM_COLOR_FORMAT_YCRCB422)
 		output_fmts[i++] = MEDIA_BUS_FMT_UYVY8_1X16;
 
-	if (info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
+	if (hdmi->sink_is_hdmi && info->color_formats & DRM_COLOR_FORMAT_YCRCB444)
 		output_fmts[i++] = MEDIA_BUS_FMT_YUV8_1X24;
 
 	/* Default 8bit RGB fallback */
-- 
2.25.1

