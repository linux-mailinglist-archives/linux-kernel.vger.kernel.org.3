Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 5E49450A6A0
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:09:22 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390576AbiDURKm (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:10:42 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48740 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390554AbiDURKg (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:10:36 -0400
Received: from mail-wr1-x429.google.com (mail-wr1-x429.google.com [IPv6:2a00:1450:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 1AB1149274;
        Thu, 21 Apr 2022 10:07:46 -0700 (PDT)
Received: by mail-wr1-x429.google.com with SMTP id bv16so7559827wrb.9;
        Thu, 21 Apr 2022 10:07:46 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=dLb9n6Vqs4Ih6Tde/WV0zahdLSPBAQf9NPHM6Jy9hzo=;
        b=LAevyX/ERqtxF65hYRvst71jOVYt9rxNi2LfjZ3L4IvPvF3WP6C6foYJwdUqmgc9Uz
         3DIsXUyUOQFeHRz3NsIo4oChjNW1OCy6txnH8L4BbdXswQosN4TMfCACw1LMm3EUoGcW
         w/YN9U3gZRYMLrDoUzse9t2+NaarYg2H3R4Qb5AEHrQDoBbfX/Umx/8r2KqHv4WnSlDg
         xGZ0YsuUYnS5tu4PO/M9Ff3iq+eFrJ/BfqjRx59gzmbdDqIj8mpYMkD+euQeJa7DJuOO
         RGO2VuwabF3TTZDyScm1NSbxJEaTFG8bAbkFTFv3WpVPXJFWGINMOtgCQ5/U2SuQXeLp
         4d4Q==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=dLb9n6Vqs4Ih6Tde/WV0zahdLSPBAQf9NPHM6Jy9hzo=;
        b=imYi3OwSljssiYRN7Kbqrg8KEdf0uLHR0xbDYwPoFekN63J8Iuy+oMvOsLcd7iCf/7
         0w5mjpv7C1qZ8o+WFhxjXAstpVPaGc62oVwFE4U7hQZmMrrfHmuTgJDGsc/cRu03r+jE
         T7eJ8M53ADvz3mj4BL26pWEjcTpeB4g2vEQ9+dcD9+oxXhCC9dvjcmzXrbNRpYDNZkKD
         wXNzBaG+GDX/oEAFtPzAmeZ6L2ubwYBc5/m7/yZ0Yss7RgWtja+nJFlVhMIGU1Zxa6/Y
         BTRsu2KIQm6+H0Cxd0PR/4XOHBI9qIPBVRHH3sAZUnpO6dgWtae3Zrm7C+BBCQFWLN9X
         GFpQ==
X-Gm-Message-State: AOAM532K1jenXl2jRlqixieYM0OfjsFqvq6KlHCbNYIMp/vvSSLFjhQX
        xDX/LIRg0t7pcj10Rneoaqs=
X-Google-Smtp-Source: ABdhPJx/kFGrmr6cOw1E9qfYzW98wPDX3Gw0oBcObPlkQWqdzFcmeXcXxIP+Db0E7MqTjK84xMOdHQ==
X-Received: by 2002:a5d:6488:0:b0:203:b628:70d2 with SMTP id o8-20020a5d6488000000b00203b62870d2mr522020wri.83.1650560864504;
        Thu, 21 Apr 2022 10:07:44 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm2963849wrf.10.2022.04.21.10.07.43
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:07:44 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     inki.dae@samsung.com
Cc:     jy0922.shim@samsung.com, sw0312.kim@samsung.com,
        kyungmin.park@samsung.com, airlied@linux.ie, daniel@ffwll.ch,
        krzk@kernel.org, alim.akhtar@samsung.com, lgirdwood@gmail.com,
        broonie@kernel.org, dri-devel@lists.freedesktop.org,
        linux-arm-kernel@lists.infradead.org,
        linux-samsung-soc@vger.kernel.org, linux-kernel@vger.kernel.org,
        hjc@rock-chips.com, heiko@sntech.de,
        linux-rockchip@lists.infradead.org, alain.volmat@foss.st.com,
        p.zabel@pengutronix.de, mripard@kernel.org, wens@csie.org,
        jernej.skrabec@gmail.com, samuel@sholland.org,
        linux-sunxi@lists.linux.dev, laurent.pinchart@ideasonboard.com,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH 3/5] drm/rockchip: rk3066_hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
Date:   Thu, 21 Apr 2022 19:07:23 +0200
Message-Id: <20220421170725.903361-4-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220421170725.903361-1-jose.exposito89@gmail.com>
References: <20220421170725.903361-1-jose.exposito89@gmail.com>
MIME-Version: 1.0
Content-Type: text/plain; charset=UTF-8
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

Once EDID is parsed, the monitor HDMI support information is available
through drm_display_info.is_hdmi.

This driver calls drm_detect_hdmi_monitor() to receive the same
information and stores its own cached value, which is less efficient.

Avoid calling drm_detect_hdmi_monitor() and use drm_display_info.is_hdmi
instead and also remove hdmi_data_info.sink_is_hdmi as it is no longer
necessary.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/rockchip/rk3066_hdmi.c | 6 +++---
 1 file changed, 3 insertions(+), 3 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/rk3066_hdmi.c b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
index 1c546c3a8998..a09dbb7d446a 100644
--- a/drivers/gpu/drm/rockchip/rk3066_hdmi.c
+++ b/drivers/gpu/drm/rockchip/rk3066_hdmi.c
@@ -22,7 +22,6 @@
 
 struct hdmi_data_info {
 	int vic; /* The CEA Video ID (VIC) of the current drm display mode. */
-	bool sink_is_hdmi;
 	unsigned int enc_out_format;
 	unsigned int colorimetry;
 };
@@ -317,6 +316,8 @@ static void rk3066_hdmi_config_phy(struct rk3066_hdmi *hdmi)
 static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
 			     struct drm_display_mode *mode)
 {
+	struct drm_display_info *display = &hdmi->connector.display_info;
+
 	hdmi->hdmi_data.vic = drm_match_cea_mode(mode);
 	hdmi->hdmi_data.enc_out_format = HDMI_COLORSPACE_RGB;
 
@@ -349,7 +350,7 @@ static int rk3066_hdmi_setup(struct rk3066_hdmi *hdmi,
 
 	rk3066_hdmi_config_video_timing(hdmi, mode);
 
-	if (hdmi->hdmi_data.sink_is_hdmi) {
+	if (display->is_hdmi) {
 		hdmi_modb(hdmi, HDMI_HDCP_CTRL, HDMI_VIDEO_MODE_MASK,
 			  HDMI_VIDEO_MODE_HDMI);
 		rk3066_hdmi_config_avi(hdmi, mode);
@@ -472,7 +473,6 @@ static int rk3066_hdmi_connector_get_modes(struct drm_connector *connector)
 
 	edid = drm_get_edid(connector, hdmi->ddc);
 	if (edid) {
-		hdmi->hdmi_data.sink_is_hdmi = drm_detect_hdmi_monitor(edid);
 		drm_connector_update_edid_property(connector, edid);
 		ret = drm_add_edid_modes(connector, edid);
 		kfree(edid);
-- 
2.25.1

