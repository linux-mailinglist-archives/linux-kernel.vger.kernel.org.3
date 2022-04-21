Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id E81D550A6A6
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390565AbiDURKj (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:10:39 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48706 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390545AbiDURKd (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:10:33 -0400
Received: from mail-wr1-x42a.google.com (mail-wr1-x42a.google.com [IPv6:2a00:1450:4864:20::42a])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 4481540905;
        Thu, 21 Apr 2022 10:07:43 -0700 (PDT)
Received: by mail-wr1-x42a.google.com with SMTP id u3so7609160wrg.3;
        Thu, 21 Apr 2022 10:07:43 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=eKm3qfCfRTvpAFA5EAH6ryNQ7rOqn4mcVqOVEQ3yBg4=;
        b=Ni5qBNH54L+lErFbripcTI35F+F8JtthLEbq0Z0UUJSc163DjScfnStCqt9bEBOvOK
         hctqtlIoahTUOylzbbJ4kWGEMRVfn6zntL6xxtDiWk2uQSpwhsYwuLELDawTzVgiexkD
         rGi8mJrxMu88sIQgnK5khi5vuZkh+co9PLdJmPTb1WLaKrmWDuy2Se2gR8Mh1Oc+j5YU
         2ym+G7p8V5ZgmMzGmPxeE1CDk6apDaEHSgrOf0duRZ+Q2MLICnFa+O9qvASKeWIuwbvR
         Hj7i3iyl0pnsPjjSMttEQyMlkMbmJA8JJmPHcQ2Ut12rtDOq9U/mhylL8DmhUnwPy5VL
         YWCg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=eKm3qfCfRTvpAFA5EAH6ryNQ7rOqn4mcVqOVEQ3yBg4=;
        b=pgEQd0tIPOixNsJ3/K9sYnyQjdFCZcaMhE+bLPG9pSGpP7PlgGxqNhfEH23AgLp6qs
         V9UCnt0a0kERVkZG0+W4wEC71zLzOl0rJA231BMy4kXo/fpjYZIooVa3plqswiS0M7W0
         W/SmPXOctQ4qmR+shrD3W136eeKHheStLczSCHJyC2Qm+9Om0k/mcVie9VOXFNlAgu11
         zuDf+vfsXxitnhTAeqi9eY9sWBizvV9ngw9lYbl2Mnc45YJaTkOYvDQHwFFXfccAQ/A6
         uVeDD/T4Vtr1z+8YhNYCgUU/N69zF2FYGzAt3qpKIFmIhDLPMY4BDuU3ggS7umRscTnK
         SZuw==
X-Gm-Message-State: AOAM533NQerp7MCArAl9OcPKyD4dCieK74o+57JkYOGa43OztcFEfTEi
        MhDzP1FzqElX29D9TEMGvng=
X-Google-Smtp-Source: ABdhPJxlCcy8zYc1BDrHUPlz44VMsFdU0skH0FV3nalzzrkpovFXfzLqOTI6phAIdGGYdymHKVzVjw==
X-Received: by 2002:a5d:5953:0:b0:206:b5c:dfe8 with SMTP id e19-20020a5d5953000000b002060b5cdfe8mr527391wri.35.1650560861569;
        Thu, 21 Apr 2022 10:07:41 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm2963849wrf.10.2022.04.21.10.07.39
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:07:41 -0700 (PDT)
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
Subject: [PATCH 2/5] drm/rockchip: inno_hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
Date:   Thu, 21 Apr 2022 19:07:22 +0200
Message-Id: <20220421170725.903361-3-jose.exposito89@gmail.com>
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
 drivers/gpu/drm/rockchip/inno_hdmi.c | 8 ++++----
 1 file changed, 4 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/rockchip/inno_hdmi.c b/drivers/gpu/drm/rockchip/inno_hdmi.c
index 046e8ec2a71c..aa8b704d44a2 100644
--- a/drivers/gpu/drm/rockchip/inno_hdmi.c
+++ b/drivers/gpu/drm/rockchip/inno_hdmi.c
@@ -30,7 +30,6 @@
 
 struct hdmi_data_info {
 	int vic;
-	bool sink_is_hdmi;
 	bool sink_has_audio;
 	unsigned int enc_in_format;
 	unsigned int enc_out_format;
@@ -433,6 +432,8 @@ static int inno_hdmi_config_video_timing(struct inno_hdmi *hdmi,
 static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 			   struct drm_display_mode *mode)
 {
+	struct drm_display_info *display = &hdmi->connector.display_info;
+
 	hdmi->hdmi_data.vic = drm_match_cea_mode(mode);
 
 	hdmi->hdmi_data.enc_in_format = HDMI_COLORSPACE_RGB;
@@ -452,13 +453,13 @@ static int inno_hdmi_setup(struct inno_hdmi *hdmi,
 
 	/* Set HDMI Mode */
 	hdmi_writeb(hdmi, HDMI_HDCP_CTRL,
-		    v_HDMI_DVI(hdmi->hdmi_data.sink_is_hdmi));
+		    v_HDMI_DVI(display->is_hdmi));
 
 	inno_hdmi_config_video_timing(hdmi, mode);
 
 	inno_hdmi_config_video_csc(hdmi);
 
-	if (hdmi->hdmi_data.sink_is_hdmi) {
+	if (display->is_hdmi) {
 		inno_hdmi_config_video_avi(hdmi, mode);
 		inno_hdmi_config_video_vsi(hdmi, mode);
 	}
@@ -553,7 +554,6 @@ static int inno_hdmi_connector_get_modes(struct drm_connector *connector)
 
 	edid = drm_get_edid(connector, hdmi->ddc);
 	if (edid) {
-		hdmi->hdmi_data.sink_is_hdmi = drm_detect_hdmi_monitor(edid);
 		hdmi->hdmi_data.sink_has_audio = drm_detect_monitor_audio(edid);
 		drm_connector_update_edid_property(connector, edid);
 		ret = drm_add_edid_modes(connector, edid);
-- 
2.25.1

