Return-Path: <linux-kernel-owner@vger.kernel.org>
X-Original-To: lists+linux-kernel@lfdr.de
Delivered-To: lists+linux-kernel@lfdr.de
Received: from out1.vger.email (out1.vger.email [IPv6:2620:137:e000::1:20])
	by mail.lfdr.de (Postfix) with ESMTP id C325B542C96
	for <lists+linux-kernel@lfdr.de>; Wed,  8 Jun 2022 12:06:40 +0200 (CEST)
Received: (majordomo@vger.kernel.org) by vger.kernel.org via listexpand
        id S235952AbiFHKG1 (ORCPT <rfc822;lists+linux-kernel@lfdr.de>);
        Wed, 8 Jun 2022 06:06:27 -0400
Received: from lindbergh.monkeyblade.net ([23.128.96.19]:52282 "EHLO
        lindbergh.monkeyblade.net" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S236100AbiFHKFw (ORCPT
        <rfc822;linux-kernel@vger.kernel.org>);
        Wed, 8 Jun 2022 06:05:52 -0400
Received: from mail-pj1-x102c.google.com (mail-pj1-x102c.google.com [IPv6:2607:f8b0:4864:20::102c])
        by lindbergh.monkeyblade.net (Postfix) with ESMTPS id 76E90179947
        for <linux-kernel@vger.kernel.org>; Wed,  8 Jun 2022 02:48:38 -0700 (PDT)
Received: by mail-pj1-x102c.google.com with SMTP id l20-20020a17090a409400b001dd2a9d555bso17876509pjg.0
        for <linux-kernel@vger.kernel.org>; Wed, 08 Jun 2022 02:48:38 -0700 (PDT)
DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=chromium.org; s=google;
        h=from:to:cc:subject:date:message-id:in-reply-to:references
         :mime-version:content-transfer-encoding;
        bh=2Kwtqm69tvB7WRggJ5XHn949T/ZlxMDJh6EaE6ZnDiY=;
        b=YiFjyl4RYZQSh2zneOZKlgN1NfU3DRQWkkpcKfqjp4gdEGrKO0TU93MKmu/BaDusgr
         zeN07NEm+R/RJuhTParW40BbEBlEfW6j4KaVcmMe4NVLl7RXkACfADg2vkGqZxj8WJlW
         uaqt6JEDWLB/Ntzjx+fFCaPdezjTpOAfA3lkY=
X-Google-DKIM-Signature: v=1; a=rsa-sha256; c=relaxed/relaxed;
        d=1e100.net; s=20210112;
        h=x-gm-message-state:from:to:cc:subject:date:message-id:in-reply-to
         :references:mime-version:content-transfer-encoding;
        bh=2Kwtqm69tvB7WRggJ5XHn949T/ZlxMDJh6EaE6ZnDiY=;
        b=Gxlo0XlAddUHLpZ0WSdp+hgm29uPHO7toLd52ataCpxKvkB/dYR7RpigFq/JJPeZzD
         0fTmQgYVH4afhLLbmu28kb4crvOs/lDtIUJFSCqr4n492OI+Y/mhaL7I/UC1Cx4ria27
         2BjJ3aXeDGRL8J1I9GZksfwkmnj4eIsz+ixQN0gq35fEILcpfJQIrcAhjnetQi0dXNBz
         UQY0NoHFFf5xsd3+WqVUAsnnTyuu2EktYOJ9A/6PI+S3l9foAin5u3GOXgqHPTLDJDEq
         9isSsGcghNwm2OUYaMySSgapTOKGQnWPZtgTvQvOCDVITMkrPvj5QlKzP096SDjrbQtr
         4gOw==
X-Gm-Message-State: AOAM531A6jhJWqzaKDFyxpFC8LkDITnywa0L9U+z3FqrcqPM7a0kW99/
        1ePx+aC3OrgBlytWbvZ8SIBlEg==
X-Google-Smtp-Source: ABdhPJw8/VjrArS/YwkMwV0jBdv3BkZXAYmdj1+zyPegpaHvf6Ix+84rliKCIlsZqY98UOd6QgTghQ==
X-Received: by 2002:a17:90b:4d0a:b0:1e2:c0b4:8bb8 with SMTP id mw10-20020a17090b4d0a00b001e2c0b48bb8mr36934374pjb.94.1654681717995;
        Wed, 08 Jun 2022 02:48:37 -0700 (PDT)
Received: from hsinyi-z840.tpe.corp.google.com ([2401:fa00:1:10:c46b:e7b1:f6c8:5eb8])
        by smtp.gmail.com with ESMTPSA id t10-20020a17090a950a00b001e28e80a8d6sm13584038pjo.38.2022.06.08.02.48.35
        (version=TLS1_3 cipher=TLS_AES_256_GCM_SHA384 bits=256/256);
        Wed, 08 Jun 2022 02:48:37 -0700 (PDT)
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
Subject: [PATCH v6 5/8] drm/panel: panel-simple: Implement .get_orientation callback
Date:   Wed,  8 Jun 2022 17:48:13 +0800
Message-Id: <20220608094816.2898692-6-hsinyi@chromium.org>
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
Reviewed-by: Sam Ravnborg <sam@ravnborg.org>
---
 drivers/gpu/drm/panel/panel-simple.c | 14 +++++++++++++-
 1 file changed, 13 insertions(+), 1 deletion(-)

diff --git a/drivers/gpu/drm/panel/panel-simple.c b/drivers/gpu/drm/panel/panel-simple.c
index 4a2e580a2f7b..b4b919525189 100644
--- a/drivers/gpu/drm/panel/panel-simple.c
+++ b/drivers/gpu/drm/panel/panel-simple.c
@@ -411,7 +411,10 @@ static int panel_simple_get_modes(struct drm_panel *panel,
 	/* add hard-coded panel modes */
 	num += panel_simple_get_non_edid_modes(p, connector);
 
-	/* set up connector's "panel orientation" property */
+	/*
+	 * TODO: Remove once all drm drivers call
+	 * drm_connector_set_orientation_from_panel()
+	 */
 	drm_connector_set_panel_orientation(connector, p->orientation);
 
 	return num;
@@ -434,12 +437,21 @@ static int panel_simple_get_timings(struct drm_panel *panel,
 	return p->desc->num_timings;
 }
 
+static enum drm_panel_orientation panel_simple_get_orientation(struct drm_panel *panel)
+{
+       struct panel_simple *p = to_panel_simple(panel);
+
+       return p->orientation;
+}
+
+
 static const struct drm_panel_funcs panel_simple_funcs = {
 	.disable = panel_simple_disable,
 	.unprepare = panel_simple_unprepare,
 	.prepare = panel_simple_prepare,
 	.enable = panel_simple_enable,
 	.get_modes = panel_simple_get_modes,
+	.get_orientation = panel_simple_get_orientation,
 	.get_timings = panel_simple_get_timings,
 };
 
-- 
2.36.1.255.ge46751e96f-goog

