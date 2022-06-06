Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id CE8B253E713
	for <lists+linux-kernel@lfdr.de>; Mon,  6 Jun 2022 19:07:36 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S240577AbiFFPZN (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Mon, 6 Jun 2022 11:25:13 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:40756 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S240533AbiFFPY7 (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Mon, 6 Jun 2022 11:24:59 -0400
Received: from mail-pj1-x102b.google.com (mail-pj1-x102b.google.com [IPv6:2607:f8b0:4864:20::102b])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 89EC52D4707
        for <linux-kernel@vger.kernel.org>; Mon,  6 Jun 2022 08:24:58 -0700 (PDT)
Received: by mail-pj1-x102b.google.com with SMTP id l7-20020a17090aaa8700b001dd1a5b9965so12831954pjq.2
        for <linux-kernel@vger.kernel.org>; Mon, 06 Jun 2022 08:24:58 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=YL/lrHRCDaMsktsmCvu5YRB9LM1inDC2pOHgWJCndXw=;
        b=D1Z5KQS2HSLEvMtB2j3LAhR5NcmnjnaRakAOctNY/fTtjy6NJh9M/naWqqKJFMw1aD
         ftJxyHyWX2BaMF+GgrZvKktG7a0W4ygHBP4JLSRdjeUYzuH55ulRLZwJWhNBOqXdleCC
         u4gEGUizOSUZZfXcgjF2AXmGtp2hBT5JWMOXA=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=YL/lrHRCDaMsktsmCvu5YRB9LM1inDC2pOHgWJCndXw=;
        b=5rRf4sru4BGrf+/Ezf6AmR1fHibiyH/wuJUzBTumpZtecdK2PuX+urr7E+7vSJkojd
         rYMffNOPX3Su1oCbdBxfekIqXefcaP/dud0dSOTZQj5CNcRv5HEo7SGWHHvOzW6cBdpg
         TnfztwSZiL7ITz8OYTCRKZK2XiWD0Lce6XAjVM5xqgFTuKm431it2nxAls+fWA4p6bVe
         nuEZEmYzWQggCvfrZ5KD8+10MfShYHvaFlmUVzqN8s6NUZFzhATaRuX6tuScBB2le5ep
         NCQQAV2OnhgKpwZO3JboEs7ViRxpO3XfBrX0aelD1o1AWl26xfATdnqtQ00IZHMf09Zq
         QZiQ==
X-Gm-Message-State: AOAM532Uo36MOwtsVWPNzj/R8poo+CUNrnaVl7eRwelD4OcDsCQ+/7gt
        9IIiSgRIVdelFfSyYzRHW33PVw==
X-Google-Smtp-Source: ABdhPJxjbZpEemJMQlqSYXCJpgXeUA7eJzzobDUSHMTnQ1O4rJ9DQ16x3dGz7G127Y3Adt9gtA60bQ==
X-Received: by 2002:a17:90a:930b:b0:1d5:684b:8e13 with SMTP id p11-20020a17090a930b00b001d5684b8e13mr27078340pjo.153.1654529098014;
        Mon, 06 Jun 2022 08:24:58 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:a0a:5e4:e24:c8c4])
        by smtp.gmail.com with ESMTPSA id h1-20020a655181000000b003fbaae74971sm10749306pgq.72.2022.06.06.08.24.54
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Mon, 06 Jun 2022 08:24:57 -0700 (PDT)
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
Subject: [PATCH v4 6/8] drm/panel: ili9881c: Implement .get_orientation callback
Date:   Mon,  6 Jun 2022 23:24:29 +0800
Message-Id: <20220606152431.1889185-7-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220606152431.1889185-1-hsinyi@chromium.org>
References: <20220606152431.1889185-1-hsinyi@chromium.org>
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
Reviewed-by: Douglas Anderson <dianders@chromium.org>
---
 drivers/gpu/drm/panel/panel-ilitek-ili9881c.c | 14 ++++++++++++++
 1 file changed, 14 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
index ba30d11547ad..c098a0ed6be7 100644
--- a/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
+++ b/drivers/gpu/drm/panel/panel-ilitek-ili9881c.c
@@ -853,17 +853,31 @@ static int ili9881c_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = mode->width_mm;
 	connector->display_info.height_mm = mode->height_mm;
 
+	/*
+	 * drm drivers are expected to call drm_panel_get_orientation() to get
+	 * panel's orientation then drm_connector_set_panel_orientation() to
+	 * set the property before drm_dev_register(). Otherwise there will be
+	 * a WARN_ON if orientation is set after drm is registered.
+	 */
 	drm_connector_set_panel_orientation(connector, ctx->orientation);
 
 	return 1;
 }
 
+static enum drm_panel_orientation ili9881c_get_orientation(struct drm_panel *panel)
+{
+       struct ili9881c *ctx = panel_to_ili9881c(panel);
+
+       return ctx->orientation;
+}
+
 static const struct drm_panel_funcs ili9881c_funcs = {
 	.prepare	= ili9881c_prepare,
 	.unprepare	= ili9881c_unprepare,
 	.enable		= ili9881c_enable,
 	.disable	= ili9881c_disable,
 	.get_modes	= ili9881c_get_modes,
+	.get_orientation = ili9881c_get_orientation,
 };
 
 static int ili9881c_dsi_probe(struct mipi_dsi_device *dsi)
-- 
2.36.1.255.ge46751e96f-goog

