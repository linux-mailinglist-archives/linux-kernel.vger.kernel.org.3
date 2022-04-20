Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 0930850874A
	for <lists+linux-kernel@lfdr.de>; Wed, 20 Apr 2022 13:46:06 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1378241AbiDTLsf (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 20 Apr 2022 07:48:35 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:54132 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1378229AbiDTLsa (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 20 Apr 2022 07:48:30 -0400
Received: from mail-wm1-x336.google.com (mail-wm1-x336.google.com [IPv6:2a00:1450:4864:20::336])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id E9C10419B8
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:45:44 -0700 (PDT)
Received: by mail-wm1-x336.google.com with SMTP id r4-20020a05600c35c400b0039295dc1fc3so1050767wmq.3
        for <linux-kernel@vger.kernel.org>; Wed, 20 Apr 2022 04:45:44 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=lFCKgPdJ/CCqTu3x/1Yy2jf+PG8b00IGqwXiUi0yBIA=;
        b=GXNF/fFbx9d6DuyiAMIllf2dfw0igvuN4n6cSYK5HEVSZ9Fu49GJl9W68c5f3BLVqI
         0IfqhTFSjoK+Rw3wvl6N/Ca+dotjOcYSkaRiIJZkU3fv9C9u6fm7JzHTv5P2h8Xhn1lB
         bNabk8Mnoy3OhlN7bZdPxhz5p3HGJ9GTVh0zoghFFu9z9pb/P02Diuow4ilWP4eZmFiB
         g3tsZWBBO5vBUEzPPq1yKSp85A8a4LMPFjNRDBLNziyjXhtqqDWqq1/u3Szjnk9Zeka4
         AL0mz460HRrdMlxPDSd+VeeSdfiBbynFLVCezYe1RVLccYnmmY3VCZIFsrxzvNuBUqq6
         BpOg==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=lFCKgPdJ/CCqTu3x/1Yy2jf+PG8b00IGqwXiUi0yBIA=;
        b=MkwjuklF9TVbuje03+0h1zX03M5sr4PE74EtPWCDNRNa9ZXSbaHq/Sk6aeL9t881a7
         eQNsawY7pgm7INNjkm6USj5gS2cq2B7nkR8aHOtLIS0I7FH+TKZJI/NTJvEZxjl5Vj/9
         lFUK9U8uy4z7WKLpc95wRKMMjAkMwuK6BRVOgh5aT1nfFzSJgTC0nzoBaZFse0hKoWpS
         qFLCe92d16LZz+gpFBgUkmVeVAsbWkFrZ8aGzugZ/xQq6gGlmGgAj8Hmx29zBBOMoLqa
         XpkhwfDvz3zWnml4HqSZ/In3spOB44f9jaIKtG7DxgbMU5V+YloK/wg6H7YQJIbZ50XJ
         jKjw==
X-Gm-Message-State: AOAM5335E3V7QQa7c2RR9LiYOEfnQ+QuDY/RN2gWQN+S3uuBd9biMJrq
        lgH27Rs5VJ8XcU1sTLzMpJA=
X-Google-Smtp-Source: ABdhPJxp2lXZMiX4io4AGVzFr7xka+KP2mq55THxYO6xGRXowX9g0V8G+19xuvrq8yDlfolUQx2n1A==
X-Received: by 2002:a1c:6a02:0:b0:38b:3661:47f1 with SMTP id f2-20020a1c6a02000000b0038b366147f1mr3211899wmc.5.1650455143489;
        Wed, 20 Apr 2022 04:45:43 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id i74-20020adf90d0000000b0020373ba7beesm17798204wri.0.2022.04.20.04.45.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 20 Apr 2022 04:45:43 -0700 (PDT)
From:   =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
To:     emma@anholt.net
Cc:     mripard@kernel.org, laurent.pinchart@ideasonboard.com,
        airlied@linux.ie, daniel@ffwll.ch, p.zabel@pengutronix.de,
        dri-devel@lists.freedesktop.org, linux-kernel@vger.kernel.org,
        =?UTF-8?q?Jos=C3=A9=20Exp=C3=B3sito?= <jose.exposito89@gmail.com>
Subject: [PATCH v3 2/2] drm/vc4: hdmi: Remove vc4_hdmi_encoder
Date:   Wed, 20 Apr 2022 13:45:00 +0200
Message-Id: <20220420114500.187664-3-jose.exposito89@gmail.com>
X-Mailer: git-send-email 2.25.1
In-Reply-To: <20220420114500.187664-1-jose.exposito89@gmail.com>
References: <20220420114500.187664-1-jose.exposito89@gmail.com>
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

The vc4_hdmi_encoder struct was used exclusively to cache the value
returned by drm_detect_hdmi_monitor() in order to avoid calling it
multiple times.

Now that drm_detect_hdmi_monitor() has been replaced with
drm_display_info.is_hdmi, there is no need to have an extra struct.

Remove vc4_hdmi_encoder.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/vc4/vc4_hdmi.c | 24 ++++++++++++------------
 drivers/gpu/drm/vc4/vc4_hdmi.h | 16 ++--------------
 2 files changed, 14 insertions(+), 26 deletions(-)

diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.c b/drivers/gpu/drm/vc4/vc4_hdmi.c
index 9c73a211ae80..f8d662fde5e0 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.c
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.c
@@ -220,7 +220,7 @@ vc4_hdmi_connector_detect(struct drm_connector *connector, bool force)
 			}
 		}
 
-		vc4_hdmi_enable_scrambling(&vc4_hdmi->encoder.base.base);
+		vc4_hdmi_enable_scrambling(&vc4_hdmi->encoder.base);
 		pm_runtime_put(&vc4_hdmi->pdev->dev);
 		mutex_unlock(&vc4_hdmi->mutex);
 		return connector_status_connected;
@@ -357,7 +357,7 @@ static int vc4_hdmi_connector_init(struct drm_device *dev,
 				   struct vc4_hdmi *vc4_hdmi)
 {
 	struct drm_connector *connector = &vc4_hdmi->connector;
-	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
+	struct drm_encoder *encoder = &vc4_hdmi->encoder.base;
 	int ret;
 
 	drm_connector_init_with_ddc(dev, connector,
@@ -1463,7 +1463,7 @@ static int vc4_hdmi_audio_startup(struct device *dev, void *data)
 
 static void vc4_hdmi_audio_reset(struct vc4_hdmi *vc4_hdmi)
 {
-	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
+	struct drm_encoder *encoder = &vc4_hdmi->encoder.base;
 	struct device *dev = &vc4_hdmi->pdev->dev;
 	unsigned long flags;
 	int ret;
@@ -1553,7 +1553,7 @@ static int vc4_hdmi_audio_prepare(struct device *dev, void *data,
 				  struct hdmi_codec_params *params)
 {
 	struct vc4_hdmi *vc4_hdmi = dev_get_drvdata(dev);
-	struct drm_encoder *encoder = &vc4_hdmi->encoder.base.base;
+	struct drm_encoder *encoder = &vc4_hdmi->encoder.base;
 	unsigned int sample_rate = params->sample_rate;
 	unsigned int channels = params->channels;
 	unsigned long flags;
@@ -2506,13 +2506,13 @@ static int vc4_hdmi_bind(struct device *dev, struct device *master, void *data)
 	INIT_DELAYED_WORK(&vc4_hdmi->scrambling_work, vc4_hdmi_scrambling_wq);
 
 	dev_set_drvdata(dev, vc4_hdmi);
-	encoder = &vc4_hdmi->encoder.base.base;
-	vc4_hdmi->encoder.base.type = variant->encoder_type;
-	vc4_hdmi->encoder.base.pre_crtc_configure = vc4_hdmi_encoder_pre_crtc_configure;
-	vc4_hdmi->encoder.base.pre_crtc_enable = vc4_hdmi_encoder_pre_crtc_enable;
-	vc4_hdmi->encoder.base.post_crtc_enable = vc4_hdmi_encoder_post_crtc_enable;
-	vc4_hdmi->encoder.base.post_crtc_disable = vc4_hdmi_encoder_post_crtc_disable;
-	vc4_hdmi->encoder.base.post_crtc_powerdown = vc4_hdmi_encoder_post_crtc_powerdown;
+	encoder = &vc4_hdmi->encoder.base;
+	vc4_hdmi->encoder.type = variant->encoder_type;
+	vc4_hdmi->encoder.pre_crtc_configure = vc4_hdmi_encoder_pre_crtc_configure;
+	vc4_hdmi->encoder.pre_crtc_enable = vc4_hdmi_encoder_pre_crtc_enable;
+	vc4_hdmi->encoder.post_crtc_enable = vc4_hdmi_encoder_post_crtc_enable;
+	vc4_hdmi->encoder.post_crtc_disable = vc4_hdmi_encoder_post_crtc_disable;
+	vc4_hdmi->encoder.post_crtc_powerdown = vc4_hdmi_encoder_post_crtc_powerdown;
 	vc4_hdmi->pdev = pdev;
 	vc4_hdmi->variant = variant;
 
@@ -2674,7 +2674,7 @@ static void vc4_hdmi_unbind(struct device *dev, struct device *master,
 	vc4_hdmi_cec_exit(vc4_hdmi);
 	vc4_hdmi_hotplug_exit(vc4_hdmi);
 	vc4_hdmi_connector_destroy(&vc4_hdmi->connector);
-	drm_encoder_cleanup(&vc4_hdmi->encoder.base.base);
+	drm_encoder_cleanup(&vc4_hdmi->encoder.base);
 
 	pm_runtime_disable(dev);
 
diff --git a/drivers/gpu/drm/vc4/vc4_hdmi.h b/drivers/gpu/drm/vc4/vc4_hdmi.h
index 44977002445f..71768915cc4b 100644
--- a/drivers/gpu/drm/vc4/vc4_hdmi.h
+++ b/drivers/gpu/drm/vc4/vc4_hdmi.h
@@ -8,17 +8,6 @@
 
 #include "vc4_drv.h"
 
-/* VC4 HDMI encoder KMS struct */
-struct vc4_hdmi_encoder {
-	struct vc4_encoder base;
-};
-
-static inline struct vc4_hdmi_encoder *
-to_vc4_hdmi_encoder(struct drm_encoder *encoder)
-{
-	return container_of(encoder, struct vc4_hdmi_encoder, base.base);
-}
-
 struct vc4_hdmi;
 struct vc4_hdmi_register;
 struct vc4_hdmi_connector_state;
@@ -127,7 +116,7 @@ struct vc4_hdmi {
 	struct platform_device *pdev;
 	const struct vc4_hdmi_variant *variant;
 
-	struct vc4_hdmi_encoder encoder;
+	struct vc4_encoder encoder;
 	struct drm_connector connector;
 
 	struct delayed_work scrambling_work;
@@ -230,8 +219,7 @@ connector_to_vc4_hdmi(struct drm_connector *connector)
 static inline struct vc4_hdmi *
 encoder_to_vc4_hdmi(struct drm_encoder *encoder)
 {
-	struct vc4_hdmi_encoder *_encoder = to_vc4_hdmi_encoder(encoder);
-
+	struct vc4_encoder *_encoder = to_vc4_encoder(encoder);
 	return container_of(_encoder, struct vc4_hdmi, encoder);
 }
 
-- 
2.25.1

