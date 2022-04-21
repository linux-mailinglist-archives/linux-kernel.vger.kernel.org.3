Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id BC15E50A69E
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:09:21 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390551AbiDURKc (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:10:32 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48682 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390545AbiDURKa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:10:30 -0400
Received: from mail-wm1-x333.google.com (mail-wm1-x333.google.com [IPv6:2a00:1450:4864:20::333])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 8BA284927B;
        Thu, 21 Apr 2022 10:07:40 -0700 (PDT)
Received: by mail-wm1-x333.google.com with SMTP id n126-20020a1c2784000000b0038e8af3e788so3848761wmn.1;
        Thu, 21 Apr 2022 10:07:40 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=+Fvcbf2Jm5l/vRCSGsuIt2faeX/qaz6+Vl1oafOAcKQ=;
        b=NMfSYNOPYP5wVJpdUDLQMLA9kSTWWoJS6DdQqc6sbuqGuz75ibsvUdGuuvwEplCgPM
         iFS7sQm+KrsRrQ38IV7thWl9D7GoM/s45vg7Zs8NMR9NQuZrj5peb1saZeX5NghZ2mJH
         /WU5rs+mq9WiOHP5cA8jNkFqzKfub6miD+dB9JoFLMW8yHVc/ISmwCJH6wJXAIvYYaTm
         Q+amkXrv5Xr7c4mq4s/2BELAdO73Dc5Wovph1WiFw7x/92IPLZfRmPh0U44iJLQr4YZZ
         JSJs+Urv3gKaQY6SgTcepc4t9aUZ430cSQwlRjfBW1dx6rHKeJ8DjUvRgZfbT6cGEx1F
         yWtA==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=+Fvcbf2Jm5l/vRCSGsuIt2faeX/qaz6+Vl1oafOAcKQ=;
        b=huhRgisThaft/uzM+QxeV7sV08wJs7Q5+ZvzQrfm66OwNnt1IJXLpprk5q4PQFZ07O
         m88jsTOv3DIa3ZvWfI4QmzgO0neP8pogNl0X+he9RTsFQaB9sXVeHJH+k10IE2NiKHG/
         HB1iqjj3ZJix8KUgzUOd3BtKyT3dxaIA1m7wQWOObmD5NQ58UO/ftcYIzBLYnoy1W+LS
         Nq19GEJZ8EBH4J8+h0nA2KyGGlKTBGIgojqeYvuTtQrAIWiUGfEVGLXifAlz6q+KoAMQ
         EqR2LOu8znrbni+VBmA59OyQcx32LhBI8L2UYOx3/LLQKRgxUv9CT+jC5Mry6WXImTss
         n4ZA==
X-Gm-Message-State: AOAM5314eQFJNtZp/Wf7M4WisZwPtQ24Sk9Pt6bTpqb0wIf/3TMAlvBX
        +HNIQHgRgguHTjPfUuDYjyw=
X-Google-Smtp-Source: ABdhPJwR0kknMZpvf1LjdEueL/t7nBEI/Q5b0+MyD3XtVoquZJFTZctKAaW4elf7wJkbs+MyuxguFQ==
X-Received: by 2002:a1c:35c1:0:b0:38e:c4f6:1931 with SMTP id c184-20020a1c35c1000000b0038ec4f61931mr280617wma.161.1650560859146;
        Thu, 21 Apr 2022 10:07:39 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm2963849wrf.10.2022.04.21.10.07.33
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:07:38 -0700 (PDT)
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
Subject: [PATCH 1/5] drm/exynos: hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
Date:   Thu, 21 Apr 2022 19:07:21 +0200
Message-Id: <20220421170725.903361-2-jose.exposito89@gmail.com>
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
instead and also remove hdmi_context.dvi_mode as it is no longer
necessary.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/exynos/exynos_hdmi.c | 15 +++++++++------
 1 file changed, 9 insertions(+), 6 deletions(-)

diff --git a/drivers/gpu/drm/exynos/exynos_hdmi.c b/drivers/gpu/drm/exynos/exynos_hdmi.c
index 7655142a4651..a6743ae87728 100644
--- a/drivers/gpu/drm/exynos/exynos_hdmi.c
+++ b/drivers/gpu/drm/exynos/exynos_hdmi.c
@@ -119,7 +119,6 @@ struct hdmi_context {
 	struct device			*dev;
 	struct drm_device		*drm_dev;
 	struct drm_connector		connector;
-	bool				dvi_mode;
 	struct delayed_work		hotplug_work;
 	struct cec_notifier		*notifier;
 	const struct hdmi_driver_data	*drv_data;
@@ -811,11 +810,12 @@ static int hdmi_audio_infoframe_apply(struct hdmi_context *hdata)
 static void hdmi_reg_infoframes(struct hdmi_context *hdata)
 {
 	struct drm_display_mode *m = &hdata->encoder.crtc->state->mode;
+	struct drm_display_info *display = &hdata->connector.display_info;
 	union hdmi_infoframe frm;
 	u8 buf[25];
 	int ret;
 
-	if (hdata->dvi_mode) {
+	if (!display->is_hdmi) {
 		hdmi_reg_writeb(hdata, HDMI_AVI_CON,
 				HDMI_AVI_CON_DO_NOT_TRANSMIT);
 		hdmi_reg_writeb(hdata, HDMI_VSI_CON,
@@ -893,9 +893,9 @@ static int hdmi_get_modes(struct drm_connector *connector)
 	if (!edid)
 		return -ENODEV;
 
-	hdata->dvi_mode = !drm_detect_hdmi_monitor(edid);
 	DRM_DEV_DEBUG_KMS(hdata->dev, "%s : width[%d] x height[%d]\n",
-			  (hdata->dvi_mode ? "dvi monitor" : "hdmi monitor"),
+			  (connector->display_info.is_hdmi ? "hdmi monitor" :
+							     "dvi monitor"),
 			  edid->width_cm, edid->height_cm);
 
 	drm_connector_update_edid_property(connector, edid);
@@ -1118,9 +1118,10 @@ static void hdmi_audio_config(struct hdmi_context *hdata)
 
 static void hdmi_audio_control(struct hdmi_context *hdata)
 {
+	struct drm_display_info *display = &hdata->connector.display_info;
 	bool enable = !hdata->audio.mute;
 
-	if (hdata->dvi_mode)
+	if (!display->is_hdmi)
 		return;
 
 	hdmi_reg_writeb(hdata, HDMI_AUI_CON, enable ?
@@ -1143,6 +1144,8 @@ static void hdmi_start(struct hdmi_context *hdata, bool start)
 
 static void hdmi_conf_init(struct hdmi_context *hdata)
 {
+	struct drm_display_info *display = &hdata->connector.display_info;
+
 	/* disable HPD interrupts from HDMI IP block, use GPIO instead */
 	hdmi_reg_writemask(hdata, HDMI_INTC_CON, 0, HDMI_INTC_EN_GLOBAL |
 		HDMI_INTC_EN_HPD_PLUG | HDMI_INTC_EN_HPD_UNPLUG);
@@ -1155,7 +1158,7 @@ static void hdmi_conf_init(struct hdmi_context *hdata)
 	/* disable bluescreen */
 	hdmi_reg_writemask(hdata, HDMI_CON_0, 0, HDMI_BLUE_SCR_EN);
 
-	if (hdata->dvi_mode) {
+	if (!display->is_hdmi) {
 		hdmi_reg_writemask(hdata, HDMI_MODE_SEL,
 				HDMI_MODE_DVI_EN, HDMI_MODE_MASK);
 		hdmi_reg_writeb(hdata, HDMI_CON_2,
-- 
2.25.1

