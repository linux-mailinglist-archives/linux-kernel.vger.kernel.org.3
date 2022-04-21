Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 00C3250A6A2
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390588AbiDURKv (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:10:51 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48752 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390563AbiDURKj (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:10:39 -0400
Received: from mail-wr1-x432.google.com (mail-wr1-x432.google.com [IPv6:2a00:1450:4864:20::432])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 7426549682;
        Thu, 21 Apr 2022 10:07:47 -0700 (PDT)
Received: by mail-wr1-x432.google.com with SMTP id x18so7624894wrc.0;
        Thu, 21 Apr 2022 10:07:47 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=qu4miKRfTQ5edYvqjwCdNnoZhdelBzzQxfVquTwJYcU=;
        b=lxA+j4hsGR37CsR5Pcl2akYbQ+9eiuuBp4pFH2LGebfC+LqkKZfG7H6fzk2IvrFcJt
         XsLiYjdR69D9iGA6qPpMFTk86JChOo/AomlJ2VbMPmsm4kOgP3oXEXft47RFsMJQ57AD
         Vxq5gk2rZ+BCIbH7Q7mRAYDHCjfpsiXoGDowdX916/ea67KHw9NM4wkxsAh0+bigZfiB
         BLicaU7MNZmEtp1JQOHY8LTMwHeUEozRWMOg98gmeDh7p47EJ++knKYdojZlFOTASofN
         bcv+MxJLsTyn75mUnleqvvO4gvsuyQ8jk5VbOFAUlkrj0CqoZJT6BH8WnvYBiYa9HRXU
         bo6A==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=qu4miKRfTQ5edYvqjwCdNnoZhdelBzzQxfVquTwJYcU=;
        b=FpTEbvjt+dehKm4/EFW51wqB2OFRd6DwYN2yYYcWeKSfX484e1V4UFzNAi9dWxFvdm
         4wdot279iVJfQLONLxZFfEyRi1d0SMaOeWVNer+6Zs+BFnYP/Xv3dpv3cES01t3clNSP
         tyAEX7Gm349moLrpDRnxF6a8C2V6e28FqH822jL0CswF1rVQcThOJZtol6witDsPHZR2
         0lhyof6kbhoo+vRxJcXNu+kC6SdH/J86PYd6UgpBbV/uH9lQQpTyYD3Su2ghQ/WM9HRn
         eixeqvJ54kSw8HFk/5Gxh27958V1wCtPVh+SimHIGgNQqt/ugoCaSBqWLnEEHDKFT6WN
         SSfw==
X-Gm-Message-State: AOAM531i3yfjZPmre3/GOytXuJ5jGgKe9wbxI2liCIidZjvaDepqHu3W
        EwrKcxmzJU8uxjxdd5+YA/w=
X-Google-Smtp-Source: ABdhPJztCBlTtH8qv1VRhJlR2SzX0FcTLm+9xXk+65FTP+M5MyZVogXt4diKZu3QDquG6Bgk4X0BGQ==
X-Received: by 2002:a5d:6d0f:0:b0:20a:897d:ad95 with SMTP id e15-20020a5d6d0f000000b0020a897dad95mr552084wrq.113.1650560866018;
        Thu, 21 Apr 2022 10:07:46 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm2963849wrf.10.2022.04.21.10.07.44
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:07:45 -0700 (PDT)
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
Subject: [PATCH 4/5] drm/sti/sti_hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
Date:   Thu, 21 Apr 2022 19:07:24 +0200
Message-Id: <20220421170725.903361-5-jose.exposito89@gmail.com>
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
instead and also remove sti_hdmi.hdmi_monitor as it is no longer
necessary.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/sti/sti_hdmi.c | 7 ++++---
 drivers/gpu/drm/sti/sti_hdmi.h | 2 --
 2 files changed, 4 insertions(+), 5 deletions(-)

diff --git a/drivers/gpu/drm/sti/sti_hdmi.c b/drivers/gpu/drm/sti/sti_hdmi.c
index f3ace11209dd..93841ba907a8 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.c
+++ b/drivers/gpu/drm/sti/sti_hdmi.c
@@ -266,6 +266,7 @@ static void hdmi_active_area(struct sti_hdmi *hdmi)
 static void hdmi_config(struct sti_hdmi *hdmi)
 {
 	u32 conf;
+	struct drm_display_info *display = &hdmi->drm_connector->display_info;
 
 	DRM_DEBUG_DRIVER("\n");
 
@@ -274,7 +275,7 @@ static void hdmi_config(struct sti_hdmi *hdmi)
 
 	/* Select encryption type and the framing mode */
 	conf |= HDMI_CFG_ESS_NOT_OESS;
-	if (hdmi->hdmi_monitor)
+	if (display->is_hdmi)
 		conf |= HDMI_CFG_HDMI_NOT_DVI;
 
 	/* Set Hsync polarity */
@@ -984,9 +985,9 @@ static int sti_hdmi_connector_get_modes(struct drm_connector *connector)
 	if (!edid)
 		goto fail;
 
-	hdmi->hdmi_monitor = drm_detect_hdmi_monitor(edid);
 	DRM_DEBUG_KMS("%s : %dx%d cm\n",
-		      (hdmi->hdmi_monitor ? "hdmi monitor" : "dvi monitor"),
+		      (connector->display_info.is_hdmi ? "hdmi monitor" :
+							 "dvi monitor"),
 		      edid->width_cm, edid->height_cm);
 	cec_notifier_set_phys_addr_from_edid(hdmi->notifier, edid);
 
diff --git a/drivers/gpu/drm/sti/sti_hdmi.h b/drivers/gpu/drm/sti/sti_hdmi.h
index 05b2f3d0d48d..6d4c3f57bc46 100644
--- a/drivers/gpu/drm/sti/sti_hdmi.h
+++ b/drivers/gpu/drm/sti/sti_hdmi.h
@@ -57,7 +57,6 @@ struct hdmi_audio_params {
  * @reset: reset control of the hdmi phy
  * @ddc_adapt: i2c ddc adapter
  * @colorspace: current colorspace selected
- * @hdmi_monitor: true if HDMI monitor detected else DVI monitor assumed
  * @audio_pdev: ASoC hdmi-codec platform device
  * @audio: hdmi audio parameters.
  * @drm_connector: hdmi connector
@@ -83,7 +82,6 @@ struct sti_hdmi {
 	struct reset_control *reset;
 	struct i2c_adapter *ddc_adapt;
 	enum hdmi_colorspace colorspace;
-	bool hdmi_monitor;
 	struct platform_device *audio_pdev;
 	struct hdmi_audio_params audio;
 	struct drm_connector *drm_connector;
-- 
2.25.1

