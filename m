Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 812DE53E09A
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 06:59:27 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S229548AbiFFEui (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 00:50:38 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45834 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S229525AbiFFEu1 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 00:50:27 -0400
Received: from mail-pl1-x636.google.com (mail-pl1-x636.google.com [IPv6:2607:f8b0:4864:20::636])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 74A242F2969
        for <linux-kernel@vger.kernel.org>; Sun,  5 Jun 2022 21:47:38 -0700 (PDT)
Received: by mail-pl1-x636.google.com with SMTP id n8so11251467plh.1
        for <linux-kernel@vger.kernel.org>; Sun, 05 Jun 2022 21:47:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=j5js470YBzKdTaXPl+QQ3rHxeotAooP4m8EcPovVk7E=;
        b=jsy7p+Ffk83iH0WeQKhkJUtkuFwG2INATX6huMKL3o2tgG0gGW3qfw6O/Y1Oi1MDyg
         86riQ5YlrwYS7iGY1PePFPe+QKpOOSPUS/fFSgbsGS9/VB15qANkhc1m6SHZ/SEYuU7k
         2XcBTzVWeh3t3DXe0/FAfRY1xILCc0/LrypXU=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=j5js470YBzKdTaXPl+QQ3rHxeotAooP4m8EcPovVk7E=;
        b=NyhfNIKDY19YRNsAGzNCFQSW9HPD8xk32PIRibOWFoal4RgzgpaIoBpp6s3PKALcAb
         Q9tYxcMaUR3U6NC7zUdK5rU/fNV0C2huW/2Cdb/rsASodkImrdaID9Sfcix9BeMuJJ0D
         OgiFwj86f2kN6SBFrumFFgvDsThsZhvBhC0yeFFGQWtvB0s7kVZztIYp3Xw4m8QsZucq
         9UC2NH3NxFhAgIUpX6H6Hc1+uJVdg2xHV1hltAPTX0u0U4oksJnMJQad1l6ySWUBt6jO
         EF25Bs93QTnu0BiHhDLaoSCSvayRPdPArQyfYbmX4CfNQIGPf9LPzSu6JFq7mv7visus
         8LtA==
X-Gm-Message-State: AOAM533h6g8XQ0m5GpDnth/AUk7cmL7rCO+DCSeAQW/xFImnjdrj71M/
        bUdjpr62uiL85uQl/LNpSXYt7g==
X-Google-Smtp-Source: ABdhPJy42F5uKW7n3PhvsBm2Wpi4Be0H0h9tOi7rmAJO1h8CZRqP4ccOd2jEJ378wYUXbDk+hWrJJg==
X-Received: by 2002:a17:902:8648:b0:167:86f2:aec3 with SMTP id y8-20020a170902864800b0016786f2aec3mr986607plt.172.1654490857525;
        Sun, 05 Jun 2022 21:47:37 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:ced3:b110:401b:b32c])
        by smtp.gmail.com with ESMTPSA id t190-20020a6381c7000000b003db7de758besm9718609pgd.5.2022.06.05.21.47.34
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Sun, 05 Jun 2022 21:47:37 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Chun-Kuang Hu <chunkuang.hu@kernel.org>
Cc:     Hans de Goede <hdegoede@redhat.com>,
        Thierry Reding <thierry.reding@gmail.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        Matthias Brugger <matthias.bgg@gmail.com>,
        dri-devel@lists.freedesktop.org,
        linux-mediatek@lists.infradead.org,
        Rob Clark <robdclark@chromium.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v3 3/8] drm/panel: panel-edp: Implement .get_orientation callback
Date:   Mon,  6 Jun 2022 12:47:15 +0800
Message-Id: <20220606044720.945964-4-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220606044720.945964-1-hsinyi@chromium.org>
References: <20220606044720.945964-1-hsinyi@chromium.org>
MIME-Version: 1.0
Content-Transfer-Encoding: 8bit
X-Spam-Status: No, score=-3.3 required=5.0 tests=BAYES_00,DKIMWL_WL_HIGH,
        DKIM_SIGNED,DKIM_VALID,DKIM_VALID_AU,DKIM_VALID_EF,RCVD_IN_DNSWL_NONE,
        SPF_HELO_NONE,SPF_PASS,T_SCC_BODY_TEXT_LINE autolearn=ham
        autolearn_force=no version=3.4.6
X-Spam-Checker-Version: SpamAssassin 3.4.6 (2021-04-09) on
        lindbergh.monkeyblade.net
Precedence: bulk
List-ID: <linux-kernel.vger.kernel.org>
X-Mailing-List: linux-kernel@vger.kernel.org

To return the orientation property to drm/kms driver.

Signed-off-by: Hsin-Yi Wang <hsinyi@chromium.org>
Reviewed-by: Hans de Goede <hdegoede@redhat.com>
---
v2->v3: add comments for notice.
---
 drivers/gpu/drm/panel/panel-edp.c | 15 ++++++++++++++-
 1 file changed, 14 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-edp.c b/drivers/gpu/drm/panel/panel-edp.c
index 1732b4f56e38..5fa208005395 100644
--- a/drivers/gpu/drm/panel/panel-edp.c
+++ b/drivers/gpu/drm/panel/panel-edp.c
@@ -586,7 +586,12 @@ static int panel_edp_get_modes(struct drm_panel *panel,
 	else if (!num)
 		dev_warn(p->base.dev, "No display modes\n");
 
-	/* set up connector's "panel orientation" property */
+	/*
+	 * drm drivers are expected to call drm_panel_get_orientation() to get
+	 * panel's orientation then drm_connector_set_panel_orientation() to
+	 * set the property before drm_dev_register(). Otherwise there will be
+	 * a WARN_ON if orientation is set after drm is registered.
+	 */
 	drm_connector_set_panel_orientation(connector, p->orientation);
 
 	return num;
@@ -609,6 +614,13 @@ static int panel_edp_get_timings(struct drm_panel *panel,
 	return p->desc->num_timings;
 }
 
+static enum drm_panel_orientation panel_edp_get_orientation(struct drm_panel *panel)
+{
+	struct panel_edp *p = to_panel_edp(panel);
+
+       return p->orientation;
+}
+
 static int detected_panel_show(struct seq_file *s, void *data)
 {
 	struct drm_panel *panel = s->private;
@@ -637,6 +649,7 @@ static const struct drm_panel_funcs panel_edp_funcs = {
 	.prepare = panel_edp_prepare,
 	.enable = panel_edp_enable,
 	.get_modes = panel_edp_get_modes,
+	.get_orientation = panel_edp_get_orientation,
 	.get_timings = panel_edp_get_timings,
 	.debugfs_init = panel_edp_debugfs_init,
 };
-- 
2.36.1.255.ge46751e96f-goog

