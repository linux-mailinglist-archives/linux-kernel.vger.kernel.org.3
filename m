Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id 4721B542C9B
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:07:11 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S236171AbiFHKGl (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:06:41 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:45270 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236146AbiFHKFx (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:05:53 -0400
Received: from mail-pf1-x429.google.com (mail-pf1-x429.google.com [IPv6:2607:f8b0:4864:20::429])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 60E7D19595F
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:48:45 -0700 (PDT)
Received: by mail-pf1-x429.google.com with SMTP id w21so17953000pfc.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:48:45 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=k48F1xGdZKHAitodolvWiz5jWt34V6z7uuaNSWQHz/4=;
        b=mjuft6W3VEPdNGWKnaMySpl6rJhexsAI7rf4/oPj/3tXgbm/bcKGzqwDhkVuWJKaoW
         6ZkK7zLQTboNF1KItp4Oxfn3PweihWVf1xrivLIyCgakTPyxHhEPSn37kHoOU5EpDFgD
         fYZKTD6N8AwubVrXTmhjJCn+kUhyJL/ibOvnM=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=k48F1xGdZKHAitodolvWiz5jWt34V6z7uuaNSWQHz/4=;
        b=e8kM33Trcg29fH4ez1bmPco3n0chzimlrhtj/mlxcPyFG9zQpDxzsld9pes8qMg8fM
         4FFJ1ubZ1IHIIaooSVYNBdgygjNT1439AVoQ0LrDPbucYLnmpV3HO6wLyCO6liUKio67
         LQJD9Mfl4yCyOtARkK+PtfDKVZi+p5RzgbkGMg+KkPqOSpOCXvTS1B1y2MNoNLkhGHY/
         +NBNnvF6HH+Jn9UiTsL+PkmndRhpPdyb5RZSTmga+Du4yqdLiHp53grVXuWt6RdgwH27
         hXFGJSDyHonpvqu/JsHnrMMszA8i9Hn0Vy9qVk+KnMNSQlloicivxbWHzahxkdB5iTnR
         6cXA==
X-Gm-Message-State: AOAM533P73A622tp+2TGsymKx5AlkfmVZTsiBvxN97lmxuchLYMI7oEA
        0pShotw22/Cis70vcZ27DFQe4SfrF2ugoQ==
X-Google-Smtp-Source: ABdhPJw0BdPzl0+1r4mTbW1xYGaRkwt3tvYvHMMvISgXDyTrIfNUNk9FoJ++5/FT423uIbh+qaXxnA==
X-Received: by 2002:a65:644b:0:b0:3fd:d5d5:8c7e with SMTP id s11-20020a65644b000000b003fdd5d58c7emr11242077pgv.590.1654681724058;
        Wed, 08 Jun 2022 02:48:44 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c46b:e7b1:f6c8:5eb8])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a950a00b001e28e80a8d6sm13584038pjo.38.2022.06.08.02.48.41
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:48:43 -0700 (PDT)
From:   Hsin-Yi Wang <hsinyi@chromium.org>
To:     Hans de Goede <hdegoede@redhat.com>,
        Sam Ravnborg <sam@ravnborg.org>,
        Stephen Boyd <swboyd@chromium.org>,
        Douglas Anderson <dianders@chromium.org>
Cc:     Thierry Reding <thierry.reding@gmail.com>,
        Maarten Lankhorst <maarten.lankhorst@linux.intel.com>,
        Maxime Ripard <mripard@kernel.org>,
        Thomas Zimmermann <tzimmermann@suse.de>,
        Philipp Zabel <p.zabel@pengutronix.de>,
        David Airlie <airlied@linux.ie>,
        Daniel Vetter <daniel@ffwll.ch>,
        dri-devel@lists.freedesktop.org,
        Rob Clark <robdclark@chromium.org>,
        Rob Herring <robh+dt@kernel.org>,
        linux-arm-kernel@lists.infradead.org, linux-kernel@vger.kernel.org
Subject: [PATCH v6 7/8] drm/panel: elida-kd35t133: Implement .get_orientation callback
Date:   Wed,  8 Jun 2022 17:48:15 +0800
Message-Id: <20220608094816.2898692-8-hsinyi@chromium.org>
X-Mailer: git-send-email 2.36.1.255.ge46751e96f-goog
In-Reply-To: <20220608094816.2898692-1-hsinyi@chromium.org>
References: <20220608094816.2898692-1-hsinyi@chromium.org>
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
 drivers/gpu/drm/panel/panel-elida-kd35t133.c | 12 ++++++++++++
 1 file changed, 12 insertions(+)

diff --git a/drivers/gpu/drm/panel/panel-elida-kd35t133.c b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
index 80227617a4d6..fa613d1d7a8f 100644
--- a/drivers/gpu/drm/panel/panel-elida-kd35t133.c
+++ b/drivers/gpu/drm/panel/panel-elida-kd35t133.c
@@ -217,15 +217,27 @@ static int kd35t133_get_modes(struct drm_panel *panel,
 	connector->display_info.width_mm = mode->width_mm;
 	connector->display_info.height_mm = mode->height_mm;
 	drm_mode_probed_add(connector, mode);
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, ctx->orientation);
 
 	return 1;
 }
 
+static enum drm_panel_orientation kd35t133_get_orientation(struct drm_panel *panel)
+{
+       struct kd35t133 *ctx = panel_to_kd35t133(panel);
+
+       return ctx->orientation;
+}
+
 static const struct drm_panel_funcs kd35t133_funcs = {
 	.unprepare	= kd35t133_unprepare,
 	.prepare	= kd35t133_prepare,
 	.get_modes	= kd35t133_get_modes,
+	.get_orientation = kd35t133_get_orientation,
 };
 
 static int kd35t133_probe(struct mipi_dsi_device *dsi)
-- 
2.36.1.255.ge46751e96f-goog

