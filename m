Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4F6D950A6A3
	for <lists+linux-kernel@lfdr.de>; Thu, 21 Apr 2022 19:09:23 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S1390590AbiDURKy (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Thu, 21 Apr 2022 13:10:54 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:48784 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S1390571AbiDURKk (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Thu, 21 Apr 2022 13:10:40 -0400
Received: from mail-wr1-x42c.google.com (mail-wr1-x42c.google.com [IPv6:2a00:1450:4864:20::42c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 32B2349274;
        Thu, 21 Apr 2022 10:07:50 -0700 (PDT)
Received: by mail-wr1-x42c.google.com with SMTP id w4so7555337wrg.12;
        Thu, 21 Apr 2022 10:07:50 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=gmail.com; s=20210112;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=1DHr0UfeFKvgTc9CqETxWAhcnj8bwvB27mi7L/RJMLI=;
        b=P3YAtF35V53kyVqjeoLe6NLR6GC/doMtIALc3tdmXTpE4LrW2S2r1iOO54iREtCJxH
         dOTTK9hlGJ+9eEh532NzO318GRvv72+BePjdQztXTWKNZ5KBRVg3kEehRTC2u6l9OuDA
         WyN/gR2kdohSojmSfR71eW5heZTUm1swjm1FhpBiAt5P1j8iGudP1VksYTrWIyc/TPJZ
         zO6eIlGiJrE5j/OszmcVXjcgemR/u2dxwYFQlRq1UkFGUtPu5oKguyC0r+8QcnOAuC87
         BsRWuNatkxU/1mf9mOfrzEK7X+Wmg1Auq3cC4wSMaYC6wrC8x5aajWQ4/9ElGwsP/Rat
         1Puw==
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=1DHr0UfeFKvgTc9CqETxWAhcnj8bwvB27mi7L/RJMLI=;
        b=nMtPkxI0CR0F72UylNvaY6lxQcWz7yVn1Cg3NDCATlUvm9qNiolBjssuQbMj8ND00u
         QGmLt/QxjCVo/nai4wEOYPOgyMORRkpeQBKlD9bo4wnOHl5vaiGoG1m57GqE7JRkTmZw
         yQ+X3a7aUwWCpa01UM7HgKNJiZe4AdDbUqCd9ELGis3QUr41MDAAlXWl6v5VVlEXrzgY
         7tzzS1ZKj8oWGBvozvq5HwBBsKVMIdVf4JP1Rb8DsGcbGdysZCeqL0ku/bExMkjQ469e
         gCq+Q20G+cR6fUuCQtq9FSBTFQYR3c4qrVECHFcoYdKtuSmQ1+xBy9oJ/oscIu2BOkdW
         kHOQ==
X-Gm-Message-State: AOAM531BSz8BmoycTT+pWv83IlPwUISVfFYXeFJoiFtowkybWT0FsqOF
        l3DN3AO5yfFBvsXIQRcJTAQ=
X-Google-Smtp-Source: ABdhPJyF9I+tOdug2GInrB3O1KIZXBnyfjirt1kYYZ6Dne73ApfJWTQEjsu+D+I0t5Nf5JVuBfCwqA==
X-Received: by 2002:adf:e908:0:b0:207:a28e:b904 with SMTP id f8-20020adfe908000000b00207a28eb904mr562456wrm.542.1650560868785;
        Thu, 21 Apr 2022 10:07:48 -0700 (PDT)
Received: from localhost.localdomain ([94.73.37.128])
        by smtp.gmail.com with ESMTPSA id i11-20020a5d584b000000b0020a8d859e5fsm2963849wrf.10.2022.04.21.10.07.47
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Thu, 21 Apr 2022 10:07:48 -0700 (PDT)
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
Subject: [PATCH 5/5] drm/sun4i: hdmi: Replace drm_detect_hdmi_monitor() with is_hdmi
Date:   Thu, 21 Apr 2022 19:07:25 +0200
Message-Id: <20220421170725.903361-6-jose.exposito89@gmail.com>
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
instead and also remove sun4i_hdmi.hdmi_monitor as it is no longer
necessary.

Signed-off-by: José Expósito <jose.exposito89@gmail.com>
---
 drivers/gpu/drm/sun4i/sun4i_hdmi.h     | 1 -
 drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c | 6 +++---
 2 files changed, 3 insertions(+), 4 deletions(-)

diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi.h b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
index 00ca35f07ba5..65c801cd6f35 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi.h
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi.h
@@ -285,7 +285,6 @@ struct sun4i_hdmi {
 
 	struct sun4i_drv	*drv;
 
-	bool			hdmi_monitor;
 	struct cec_adapter	*cec_adap;
 
 	const struct sun4i_hdmi_variant	*variant;
diff --git a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
index 3799a745b7dd..d8b71710e8f6 100644
--- a/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
+++ b/drivers/gpu/drm/sun4i/sun4i_hdmi_enc.c
@@ -99,6 +99,7 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder)
 {
 	struct drm_display_mode *mode = &encoder->crtc->state->adjusted_mode;
 	struct sun4i_hdmi *hdmi = drm_encoder_to_sun4i_hdmi(encoder);
+	struct drm_display_info *display = &hdmi->connector.display_info;
 	u32 val = 0;
 
 	DRM_DEBUG_DRIVER("Enabling the HDMI Output\n");
@@ -111,7 +112,7 @@ static void sun4i_hdmi_enable(struct drm_encoder *encoder)
 	writel(val, hdmi->base + SUN4I_HDMI_PKT_CTRL_REG(0));
 
 	val = SUN4I_HDMI_VID_CTRL_ENABLE;
-	if (hdmi->hdmi_monitor)
+	if (display->is_hdmi)
 		val |= SUN4I_HDMI_VID_CTRL_HDMI_MODE;
 
 	writel(val, hdmi->base + SUN4I_HDMI_VID_CTRL_REG);
@@ -215,9 +216,8 @@ static int sun4i_hdmi_get_modes(struct drm_connector *connector)
 	if (!edid)
 		return 0;
 
-	hdmi->hdmi_monitor = drm_detect_hdmi_monitor(edid);
 	DRM_DEBUG_DRIVER("Monitor is %s monitor\n",
-			 hdmi->hdmi_monitor ? "an HDMI" : "a DVI");
+			 connector->display_info.is_hdmi ? "an HDMI" : "a DVI");
 
 	drm_connector_update_edid_property(connector, edid);
 	cec_s_phys_addr_from_edid(hdmi->cec_adap, edid);
-- 
2.25.1

